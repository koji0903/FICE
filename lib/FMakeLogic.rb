#######################################################################
#
# FMake Logic Control Class
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
########################################################################
#
#  Class Name : FMakeLogic
#  
#  [Input]
#    - XML File
#    - Conf DB, Connect DB
# 
########################################################################
require "FMakeMessage"
require 'FICE_DB'
require 'common'
require 'XMLParse'
require 'FMakeConnect'
require 'FMakeFileControl'
require 'PinChecker'

#
# FMake Logic
#
class FMakeLogic

  attr_accessor :TOP_MODULE
  def initialize(inf)
    # XML File
    @XML_FILE = inf[:xml]
    # CONF file Database ( analyzed FMakeConf )
    @CONF_DB = inf[:conf]
    # XML Data
    @root = XMLParse.read(@XML_FILE)
    # Top Module name ( defined target instance )
    @TOP_MODULE = inf[:top_module]
    $TOP_MODULE = @TOP_MODULE

    @VERILOG_DEFINE = inf[:verilog_define]

    # Log file for connect
    @CONNECT_LOG = inf[:connect_log]
    @CONNECT_LOG = FICE_DB::FICE_DATA + "/connect.log" if @CONNECT_LOG == nil
    @connect_log = File.open(@CONNECT_LOG,"w")
    Common.print_file_header(@connect_log,"Connect Log","FMake","FICE")
    @circuit_inf = FICE_DB::CircuitInf.new

    
    # output dir for Remove
    @outdir = inf[:outdir]
    @outdir = "." if @outdir.nil?

    @HierData = Array.new
    @RemovedMacro = Array.new

    @BlackBoxFileList = Array.new

      # for Caching Data
    @INST_LIST = Hash.new
    @WIRE_LIST = Hash.new
    @PORT_LIST = Hash.new
    @ALL_CONNECT = Hash.new
    @CONNECT_LIST = Hash.new
    @TERMINAL_LIST = Hash.new
    
  end
  
  #
  # Main operation for XML Modify
  # - Separate to Macro Type(KeepKeep/KeepChange/Add/Replace/Remove)
  #   First Time(MODE:MODULE) - Only Change for Module
  #   Second Time(MODE:CONNECT) - Only Change for Connect  
  #   
  #   ret : Modifief doc
  #
  def main(exe_mode=nil)
    # 1st Step (MODE : MODULE)
    printf("@I:XML Modify for changing about Module only.\n") if $VERBOSE
    mode = "MODULE"

    # Get Using ModuleName
    module_list = XMLParse::get_ModuleList(@root)
    inst_list = Array.new
    module_list.each do |mod_name|
      inst_list += XMLParse::get_InstanceList(@root,mod_name)
    end
    module_list = Array.new
    inst_list.each do |inf|
      module_list << inf[0]
    end

    # Check illegal Module Name
    @CONF_DB.INST.each_value do |inst_inf|
      case inst_inf.MacroType.downcase
      when "keepchange","replace","remove","keepkeep"
        if module_list.index(inst_inf.ModuleName).nil?
          FMakeMessage.PrintError( :category => "CONF", :no => 139, :mod_name => inst_inf.ModuleName, :conf_file => inst_inf.CONF_FILE, :line_no => inst_inf.InsLineNo)
        end
        
        if inst_inf.InstName != resolve_Hier_from_Instance(inst_inf.InstName.split("."))[0][1]
          FMakeMessage.PrintError( :category => "CONF", :no => 140, :inst_name => inst_inf.InstName, :conf_file => inst_inf.CONF_FILE, :line_no => inst_inf.InsLineNo)
        end 

      end
    end
    
    @CONF_DB.INST.each_value do |inst_inf|
      # Save & Check & Print
#      @circuit_inf.add_macro(inst_inf) 
      # When "BlackBox" Mode, Force Change
      if exe_mode == "BlackBox"
        inst_inf.MacroType = "Remove"
      end
      case inst_inf.MacroType
      when "KeepKeep"
        # do nothing
      when "KeepChange"
        modify_KeepChange(inst_inf,mode)
      when "Add","add","ADD"
        modify_Add(inst_inf,mode)
      when "Replace","replace","REPLACE"
        modify_Replace(inst_inf,mode)
      when "Remove","remove","REPLACE"
        # No-execute( Remove operation will execute last )
#        modify_Remove(inst_inf,mode,exe_mode)
      end
    end

    # DataBase Update
    XMLParse::get_ModuleList(@root).each do |current_module|
      XMLParse::update_ConnectData(@root,current_module)
    end

    # 2nd Step (MODE : CONNECT-HIGH)
    printf("@I:XML Modify for changing about Connection only( Priority : High ).\n") if $VERBOSE
    mode = "CONNECT-HIGH"
    @CONF_DB.INST.each_value do |inst_inf|
      printf("\n================================\n@I:XML Modify for %s\n================================\n",inst_inf.InstName)
      case inst_inf.MacroType
      when "KeepKeep"
        # do nothing
      when "KeepChange"
        modify_KeepChange(inst_inf,mode)
      when "Add","add","ADD"
        modify_Add(inst_inf,mode)
      when "Replace","replace","REPLACE"
        modify_Replace(inst_inf,mode)
      when "Remove","remove","REPLACE"
        # do nothing
      end
    end

    # Check FPGA Terminal
    if @CONF_DB.PIN_SDC != nil
      printf("@I:Execute checking between Pin Location in SDC File(%s) and FPGA Terminal.\n",@CONF_DB.PIN_SDC)
      terminalList = XMLParse::get_TerminalList(@root,@TOP_MODULE)
      pin_checker = PinChecker.new
      sdc_inf = pin_checker.get_SDCInf(@CONF_DB.PIN_SDC)[1]
      sdcList = Array.new
      sdc_inf.each do |each_inf|
        sdcList <<  each_inf.FPGASignal
      end
      terminalList.sort
      sdcList.sort
      printf("@E:Unmatch between SDC Pin-Location and FPGA Terminal in HDL\n")
      printf("\n[Common Signal]\n\n")
      if ((terminalList - sdcList).size != 0 ) || ((sdcList - terminalList).size != 0 )  
        $WARNING_CNT += 1
        printf("\n[Only Pin-Location in SDC File]\n\n")
        p (sdcList - terminalList)        
        printf("\n[Only FPGA Teriminal in HDL]\n\n")
        p (terminalList - sdcList)        
      else
        printf("@I:Succesfull Pin Check.\n")
      end
    end
    
    # 3rd Step (MODE : CONNECT-NORMAL)
    printf("@I:XML Modify for changing about Connection only( Priority : Normal ).\n") if $VERBOSE
    mode = "CONNECT-NORMAL"
    @CONF_DB.INST.each_value do |inst_inf|
      new_signal_db = nil
      printf("\n================================\n@I:XML Modify for %s\n================================\n",inst_inf.InstName)
      case inst_inf.MacroType
      when "KeepKeep"
        # do nothing
      when "KeepChange"
        modify_KeepChange(inst_inf,mode)
      when "Add","add","ADD"
        new_signal_db = modify_Add(inst_inf,mode)
      when "Replace","replace","REPLACE"
        new_signal_db = modify_Replace(inst_inf,mode)
      when "Remove","remove","REPLACE"
        # do nothing
      end

      # Make SCAN/TEST PULLDOWN
      printf "@I:Make SCAN/TEST PULLDOWN operation.\n"
      modify_SCAN(inst_inf,mode,new_signal_db)
      printf "Done.\n\n"
    end

    if exe_mode == "BlackBox"
      filename = "BlackBox.list"
      printf("@I:gnerate BlackBox List File(%s)\n",filename)
      f = open(filename,"w")
      @BlackBoxFileList.each do |file|
        f.printf("%s\n",file)
      end
      f.close
    end

    # Delete Remove macro & HardMacro
    @CONF_DB.INST.each_value do |inst_inf|
      case inst_inf.MacroType
      when "Remove","remove","REPLACE"
        modify_Remove(inst_inf,mode,exe_mode)
      end
    end
    XMLParse::delete_HardMacro(@root)

    # Change TopModuleName from ${ORG} to ${ORG}_EVA    
    XMLParse::change_ModuleName(@root,@TOP_MODULE,@TOP_MODULE + "_EVA")

    return @root
  end

  #
  # XML Modify for "Add"
  #   param : inst_inf - Instance Information of target module
  #         : mode     - MODULE/CONNECT
  #   ret   : true - sccess
  #
  def modify_Add(inst_inf,mode)

    # collect Target Macro detail
    module_name = inst_inf.ModuleName
    verilog = inst_inf.ReplaceVerilogFile
    inst_name = inst_inf.InstName

    # Get Signal Information of New Macro
    signal_db, new_signal_db = get_SignalDB_from_Verilog(inst_inf,module_name,verilog)

    # Add FileControl
    FMakeFileControl::Verilog.add(verilog)

    # For Multi-Hier
    upper_module,inst_name = resolve_MultiHier(inst_inf)

    case mode
    when "MODULE"
      # add Instance inf
      printf "add Instance(%s) ...", inst_inf.InstName
      XMLParse::add_Instance(@root,upper_module,[module_name,inst_name],@CONF_DB)
      # add Port
      signal_db.each_key do |name|
        XMLParse::add_InstancePort(@root,upper_module,inst_name,{"#{name}" => nil},@CONF_DB)
      end
      printf "OK\n"
    when "CONNECT-HIGH"
      # Connect Change
      apply_ConnectChange(inst_inf,signal_db,nil,"High")
    when "CONNECT-NORMAL"
      # Connect Change
      apply_ConnectChange(inst_inf,signal_db,nil,"Normal")
    end

    return new_signal_db
  end

  #
  # XML Modify for "Replace"
  #   param : inst_inf - Instance Information of target module
  #         : mode     - MODULE/CONNECT
  #   ret   : true - sccess
  #
  def modify_Replace(inst_inf,mode)

    # ----------------
    # - Original Macro 
    #     for Connect Information that does not change connection
    # ----------------
    org_module_name = inst_inf.ModuleName
    org_inst_name = inst_inf.InstName
    
    # ----------------
    # - Replace Macro
    # ----------------
    
    # collect Target Macro detail
    replace_module_name = inst_inf.ReplaceModuleName
    verilog = inst_inf.ReplaceVerilogFile

    # Add DB
    FMakeFileControl::Verilog.add(verilog)
    
    # For Multi-Hier
    connect_TargetInstance = resolve_Hier_from_Instance(org_inst_name.split("."))
    if connect_TargetInstance == []
      $ERROR_CNT += 1
      printf("@E:Cannot resolve Hierarchy for %s\n",org_inst_name)
      printf("    please check Conf File")
      printf("    or Rerun FMake after removed %s.\n",$TOP_XML_FILE)
      Common.print_summary
      exit
    end
    module_path = connect_TargetInstance[0][0].split(".")
    inst_path = connect_TargetInstance[0][1].split(".")
    module_path.pop # org_inst module
    upper_module = module_path.pop # Upper Module
    upper_module = @TOP_MODULE if upper_module == nil
    org_inst_name = inst_path.pop

    # Get Signal Information of New Macro
    replace_SignalInf, new_signal_db = get_SignalDB_from_Verilog(inst_inf,replace_module_name,verilog,@root)

    case mode
    when "MODULE"
      # Change Module
      if XMLParse::change_InstanceModule(@root,upper_module,org_inst_name,replace_module_name) == false
        FMakeMessage.PrintError( :category => "CONF", :no => 136, :inst_name => org_inst_name, :verilog_file => verilog, :conf_file => inst_inf.CONF_FILE, :line_no => inst_inf.InsLineNo)
      end
    when "CONNECT-HIGH","CONNECT-NORMAL"
#      str = upper_module + "." + org_inst_name
#      @CONNECT_LIST[str] = XMLParse::get_ConnectList(@root,upper_module,org_inst_name) if @CONNECT_LIST[str].nil?
#      original_ConnectInf = @CONNECT_LIST[str]
      original_ConnectInf = XMLParse::get_ConnectList(@root,upper_module,org_inst_name)

      # make replace_ConnectInf (Merge Orignilan Connection & Connect Inf to replace_SignalInf)
      replace_ConnectInf = Hash.new
      replace_SignalInf.each do |port_name,signal_inf|
        connect_inf = original_ConnectInf[port_name]
        replace_ConnectInf[port_name] = connect_inf
      end

      # Delete Connection ( removed pin at Replace Macro )
      printf "[Apply(delete) Instance Port] Replace Macro does not have following port.\n"
      (original_ConnectInf.keys - replace_SignalInf.keys).each do |pin|
        printf("@I:Delete connection(%s.%s)\n",org_inst_name,pin)
        if XMLParse::delete_InstancePort(@root,upper_module,org_inst_name,pin) == false
          printf("@Not Found %s in %s\n", pin,org_inst_name)
          exit
        end
      end
      printf("Done\n")
      
      # Add Connection ( add pin at Replace Macro )
      printf "[Add Instance Port] Replace Macro have following new port.\n"
      (replace_SignalInf.keys - original_ConnectInf.keys).each do |pin|
        XMLParse::add_InstancePort(@root,upper_module,org_inst_name,{"#{pin}" => nil},@CONF_DB)
      end
      printf("Done\n")
      
      # Change Connection
      printf "[Change Connection]\n"
#      apply_ConnectChange(inst_inf,replace_ConnectInf,replace_SignalInf)
      case mode
      when "CONNECT-HIGH"
        apply_ConnectChange(inst_inf,replace_SignalInf,replace_ConnectInf,"High")
      when "CONNECT-NORMAL"
        apply_ConnectChange(inst_inf,replace_SignalInf,replace_ConnectInf,"Normal")
      end
      printf("Done\n")
    end


    # Remove Original Module
    inst_all = Array.new
    @CONF_DB.INST.values.each do |inf|
      if inf.ModuleName == inst_inf.ModuleName
        inst_all << inf.InstName
      end
    end

    if inst_all - [inst_inf.InstName] == [] && /cell_pf/ !~ inst_inf.ModuleName
      XMLParse::delete_Module(@root,inst_inf.ModuleName) 
    end
    return  new_signal_db
  end

  #
  # XML Modify for "KeepChange"
  #   param : inst_inf - Instance Information of target module
  #         : mode     - MODULE/CONNECT
  #   ret   : true - sccess
  #
  def modify_KeepChange(inst_inf,mode)

    case mode
    when "MODULE"
      # Do nothing
    when "CONNECT-HIGH"
      signal = XMLParse::get_PortList(@root,inst_inf.ModuleName)
      signal_db = Hash.new
      signal.each do |key,value|
        signal_db[key] = [value]
      end
      # Connect Change
      apply_ConnectChange(inst_inf,signal_db,nil,"High")
    when "CONNECT-NORMAL"
      signal = XMLParse::get_PortList(@root,inst_inf.ModuleName)
      signal_db = Hash.new
      signal.each do |key,value|
        signal_db[key] = [value]
      end
      # Connect Change
      apply_ConnectChange(inst_inf,signal_db,nil,"Normal")
    end

    return true
  end

  #
  # XML Modify for "SCAN/TEST"
  #   param : inst_inf - Instance Information of target module
  #         : mode     - MODULE/CONNECT
  #   ret   : true - sccess
  #
  def modify_SCAN(inst_inf,mode,new_signal_db)
    signal = XMLParse::get_PortList(@root,inst_inf.ModuleName)
    if signal.size == 0 && new_signal_db != nil
      signal = new_signal_db
    end
    signal_db = Hash.new
    signal.each do |key,value|
      if FICE_DB::SCAN_NAME.index(key) != nil
        signal_db[key] = value
      end
    end

    # For Multi-Hier
    upper_module,inst_name = resolve_MultiHier(inst_inf)
    
    signal_db.each do |name,value|
      if value.Type == "input"
        printf("@I:SCAN/TEST: Force change to PullDown at %s.%s\n",inst_name,name)
        # Change PULLDOWN
        signal = FICE_DB::SignalInf.new( 
                                        :name => "1'b0",
                                        :type => "constant" 
                                        )
        XMLParse::change_Connection(@root,upper_module,inst_name,{"#{name}" => [signal]},nil)
        printf("Done\n")    
      elsif value.Type == "output"
        # Do nothing( Keep Oringinal Wire )
=begin
        # Change OPEN
        signal = FICE_DB::SignalInf.new( 
                                        :name => nil,
                                        :type => "open" 
                                        )
        XMLParse::change_Connection(@root,upper_module,inst_name,{"#{name}" => [signal]},nil)
        printf("Done\n")    
=end
      end
    end
    

    
=begin
    # Port Direction Check ( only input/inout is allowd in pulldown )
    if sig.Type == "input" || sig.Type == "inout"
      con = con_db.PIN_INF[sig.Name][i]
      const = make_ConstantValue(sig,0)
      printf("\tadd Connection(PULLDOWN:%s)\n",const)
      signal = FICE_DB::SignalInf.new( 
                                      :name => const, 
                                      :type => "constant", 
                                      :msb => sig.MSB, 
                                      :lsb => sig.LSB, 
                                      :portion => sig.BusPortion, 
                                      :word_top => sig.WordTop, 
                                      :word_buttom => sig.WordButtom)
      # connect port to PULLDOWN in instantiation1
      XMLParse::change_Connection(@root,upper_module,inst_name,{"#{sig.Name}" => [signal]},con_db)
      @circuit_inf.add_connect(inst_inf.InstName+"."+sig.Name,connect_file_type,inst_inf.ModuleName,con,signal)
      printf("Done\n")    
    else
      # Error of port-direction
      printf "\n"
      FMakeMessage.PrintError( :category => "CONNECT", :no => 211, :pin_name => sig.Name, :direction => sig.Type, :verilog => inst_inf.ReplaceVerilogFile)
    end
=end
  end


  #
  # XML Modify for "Remove"
  #   param : inst_inf - Instance Information of target module
  #         : mode     - MODULE/CONNECT
  #         : exe_mode - Remove/BlackBox
  #   ret   : true - sccess
  #
  def modify_Remove(inst_inf,mode,exe_mode)
    # if Already Remove, Skip This function
    return if @RemovedMacro.index("#{inst_inf.ModuleName}") != nil

    # Make output directory
    # Make Verilog-HDL for RemoveMacro
    if exe_mode == "BlackBox"
      outdir = @outdir + "/BlackBox"
      filename = outdir + "/" + inst_inf.ModuleName + ".v"
      @BlackBoxFileList << filename
    else
      if @outdir == "."
        outdir = Dir.pwd + "/RemoveMacro_TMP"
      else
        outdir = @outdir + "/RemoveMacro_TMP"
      end
      filename = outdir + "/" + inst_inf.ModuleName + "_TMP.v"
    end
    printf("@I:make output directory(%s)\n",outdir)
    Dir::mkdir(outdir) unless FileTest::directory?(outdir)

    # Add FileControl
    FMakeFileControl::Verilog.add(filename)
    
    # Overwrite Warning
    FMakeMessage.PrintWarning( :category => "FMakeLogic", :no => 100, :file_name => File.basename(__FILE__), :filename => filename) if FileTest::exist?(filename)
    
    printf("@I:Generaete \"%s\" at temporary Reove Macro.\n",filename)
    f = open(filename,"w")
    comment = "Remove Macro (" + inst_inf.ModuleName + ")"
    Common.print_file_header(f,comment,"FMake",$VERSION,"//")

f.print <<EOB
//-----------------------------------------------------------------------------
// Title         : Remove Macro for #{inst_inf.ModuleName}
// Project       : FPGA-ICE for #{@product_name}
//-----------------------------------------------------------------------------
// File          : #{File.basename(filename)}
// Author        : Automacically generated by FMake ( ver #{$VERSION} )
// Created       : #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}
// Last modified : #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}
//-----------------------------------------------------------------------------
// Description :
// <description>
//-----------------------------------------------------------------------------
// Copyright (c) #{Time.now.strftime("%Y")} by Renesas Electronics This model is the confidential and
// proprietary property of <company> and the possession or use of this
// file requires a written license from Renesas Electronics.
//------------------------------------------------------------------------------
// Modification history :
// #{Time.now.strftime("%Y-%m-%d %H:%M:%S")} : created
//-----------------------------------------------------------------------------

/*
 * This File is temporary circuit for Remove Macro.
 * You HAVE TO edit this file to match product specification before FPGA synthesis.
 * 
 * Default circuit
 *  All input signals  - Non-Connect in this module
 *  All output signals - Output PULLDOWN signal
 *  All inout signals  - Output Hi-Z signal
 */

EOB

    # get Port Information
    signalList = XMLParse::get_PortList(@root,inst_inf.ModuleName)
    
    # print Module
    f.printf("module\t%s(\n",inst_inf.ModuleName)

    # Print Terminal List
    list = Array.new
    signalList.each_key do |name|
      list << "\t\t" + name
    end
    f.printf("%s\n",list.join(",\n"))

    # print Close-Module
    f.printf("\t\t);\n\n")

    # print Port List
    signalList.each do |name,inf|
      if inf.Size == 1
        f.printf("\t%s\t%s;\n",inf.Type,name)
      else
        f.printf("\t%s\t[%d:%d]\t%s;\n",inf.Type,inf.MSB,inf.LSB,name)
      end
    end

    # print Output-Clamp
    f.printf("\n\t// PULLDOWN for output/inout port\n")
    signalList.each do |name,inf|
      next if inf.Type == "input"
      if inf.Size == 1
        if inf.Type == "output"
          f.printf("\tassign %s = 1'b0;\n",name)
        else
          f.printf("\tassign %s = 1'bz;\n",name)
        end
      else
        if inf.Type == "output"
          f.printf("\tassign %s = %d'b0;\n",name,inf.Size)
        else
          f.printf("\tassign %s = %d'bz;\n",name,inf.Size)
        end
      end
    end

    # print Close-Module
    f.printf("\nendmodule\n\n")

    f.close

    XMLParse::delete_Module(@root,inst_inf.ModuleName)
    @RemovedMacro << inst_inf.ModuleName

  end

  #
  # get_SignalDB_from_Verilog
  #   param : inst_inf
  #           module_name
  #           verilog
  #   ret   : SignalDB
  #
  private
  def get_SignalDB_from_Verilog(inst_inf,module_name,verilog,org_root=nil)

    # Get Add Macro Information
    printf "@I:Getting %s Information.\n", module_name
    printf "@I:Execute V2XML for %s\n",verilog

    # file Check
    unless  FileTest::readable?(verilog)
      $DEBUG = false
      FMakeMessage::PrintError( :category => "FILE", :no => 21, :param => verilog)
    end
    
    # get Port List of Target Module
    tmp_file = "temp"
=begin
    ice_common = FICE_DB::ICECommon.new( :db_file => "rl78.db" )
    xml_data = ice_common.get( :verilog_file => verilog, :verilog_define => @VERILOG_DEFINE, :hdl_md5sum => Common.md5sum(verilog), :define_md5sum => Common.md5sum(@VERILOG_DEFINE))
    if xml_data == nil
      # Generate List File (define/User Source)
      tmp_list = FMakeFileControl::List.generate(@VERILOG_DEFINE,verilog)
      result = `#{FICE_DB::V2XML} #{tmp_list} > #{tmp_file}` # Execute V2XML
      f = open(tmp_file,"r")
      xml_contents = f.read
      f.close
      ice_common.regist( :verilog_file => verilog, :verilog_define => @VERILOG_DEFINE, :hdl_md5sum => Common.md5sum(verilog), :define_md5sum => Common.md5sum(@VERILOG_DEFINE), :xml_data => xml_contents)    
      File.delete(tmp_list)
    else
      printf("@Skip execute V2XML using XML Data from DB\n")
      f = open(tmp_file,"w")
      f.write(xml_data)
      f.close
    end
=end
    # Generate List File (define/User Source)
    tmp_list = FMakeFileControl::List.generate(@VERILOG_DEFINE,verilog)
    result = `#{FICE_DB::V2XML} #{tmp_list} > #{tmp_file}` # Execute V2XML
    File.delete(tmp_list)
    
    root = XMLParse.read("#{tmp_file}") # Read XML
    # Get ALL Module in target File & Delete SubModule in root doc
    XMLParse::get_ModuleList(root).each do |sub_mod|
      next if sub_mod == module_name
      XMLParse::delete_Module(org_root,sub_mod)
    end if org_root != nil

    XMLParse::add_doc(verilog,root)
    FileUtils.rm(tmp_file) # delte tmp file
    signal_db = XMLParse::get_PortList(root,module_name)
    # Nothing Target Module    
    FMakeMessage.PrintError( :category => "CONF", :no => 135, :module_name => module_name, :verilog_file => verilog, :conf_file => inst_inf.CONF_FILE, :line_no => inst_inf.InsLineNo) if signal_db == {}
    
    new_db = Hash.new
    signal_db.each do |key,value|
      new_db[key] = [value]
    end

    return new_db,signal_db
  end


  #
  # Apply Connect Change for each connect
  #  param : inst_inf     - Instance Inforamtion
  #          signal_db    - Signal Infomation of Target Module
  #
  def apply_ConnectChange(inst_inf,signal_db,add_signal_db=nil,priority)
    # get taget macro info
    module_name = nil, inst_name = nil
    case inst_inf.MacroType
    when "Add","ADD","add","KeepChange","KEEPCHANGE"
      module_name = inst_inf.ModuleName
      inst_name = inst_inf.InstName
    when "Replace","REPLACE","replace"
      module_name = inst_inf.ReplaceModuleName
      inst_name = inst_inf.InstName
    end
    
    # Get Connect List ( ex: [["MOD_CON", "./tp/ADD_MODULE.mod_con"],["INST_CON", "./tp/ADD_MODULE.inst_con"]] )
    connect_list = inst_inf.get_ConnectList

    connect_list.each do |connect|
      connect_file_type = connect[0]     # MOD_CON/ADD_MOD_CON/INST_CON/ADD_INST_CON
      connect_file = connect[1]  # File name 
      
      # Get Conenct Inforamtion ( read & analyze conf )
      printf("@I:read Connect File(%s)\n",connect_file)
      connect = FMakeConnect.new(
                                 :file_type => connect_file_type,
                                 :con_file => connect_file,
                                 :module_name => module_name,
                                 :inst_name => inst_name
                                 )
      con_db = connect.analyze

      printf "[Apply(change/add) Connection]\n"
      # XML Add/Modify each Port
      signal_db.each do |name,sig_all|
        if sig_all == nil
          if con_db.PIN_INF == {} # There is no change connection
            # Error : not enough to signal connect infomation
            FMakeMessage.PrintError( :category => "CONNECT", :no => 224, :inst_name => inst_name, :pin_name => name,  :conf_file => con_db.CONNECT_FILE) 
          else
            # New Port
            sig_all = add_signal_db[name]
            printf("@I:make new connect for %s\n",name)
            connect_change(sig_all,con_db,inst_name,connect_file_type,inst_inf,priority)
          end
        else
          # There is no change connection
          if con_db.PIN_INF == {} 
#            sig_all.each do |sig|
#              connect = connect + " " + sig.Name
#            end
            printf("@I:Make connection(%s.%s) Indication:No-Change\n",inst_name,name)
          else
            printf("------------------------------------------------------\n")
            printf("@I:change connect for %s.%s\n",inst_name,name)
            printf("------------------------------------------------------\n")
            connect_change(sig_all,con_db,inst_name,connect_file_type,inst_inf,priority)
          end
        end
      end
    end
      
  end

  #
  # Connect Channge
  #  param : sig_all - Target Signal Information
  #          con_db  - Connect information from MOD_CON/INST_CON
  #          inst_name - Instance Name
  #          connect_file_type - MOD_CON/ADD_MOD_CON/INST_CON/ADD_INST_CON
  #          inst_inf - Instance Information
  #          priority - terminal/pullup/pulldown : High, other - Normal
  #  ret   : none(XML data update)
  #
  def connect_change(sig_all,con_db,inst_name,connect_file_type,inst_inf,priority)
    sig_all.each do |sig|
      # Get Connect indication
      con_a = con_db.PIN_INF[sig.Name]
      tmp_sig = FICE_DB::SignalInf.new(
                                       :module_name => sig.ModuleName,
                                       :inst_name => sig.InstName,
                                       :name => sig.Name,
                                       :connected_wire_name => sig.ConnectedWireName,
                                       :type => sig.Type,
                                       :msb => sig.MSB,
                                       :lsb => sig.LSB,
                                       :portion => sig.BusPortion,
                                       :signal_portion => sig.PortBusPortion,
                                       :signal_size => sig.PortSize,
                                       :word_top => sig.WordTop,
                                       :word_buttom => sig.WordButtom,
                                       :comment => sig.Comment,
                                       :new_flag => sig.NewFlag
                                       )
      if con_a != nil

        # Force Change Terminal Attribute in case of multiple define in Conenct
        new_con_a = Array.new
        con_a.each do |con|
          unless con.ConnectPort.nil?
            case con.ConnectPort.downcase
            when %r(:terminal)
              con.Type = "TERMINAL"
              ter_name = con.ConnectPort.split(":")[0]
              ter_name = "Port_" + inst_name.gsub(".","_") + "_" + sig.Name if ter_name == ""
              con.TerminalName = ter_name
              if ter_name != sig.Name
                $ERROR_CNT += 1
                printf "@E:Not Support describe different Terminal Name in Multiple-Connect-Change.(#{con_db.CONNECT_FILE}(Line:#{con.LineNo}))\n"
                printf "\tModule Port Name     : #{sig.Name}\n"
                printf "\tTerminal Name in Con : #{ter_name}\n"
                Common.print_summary
                exit
              end
            end
          end
          new_con_a << con
        end
        con_a = new_con_a
        con_a.each_with_index do |con,i|
          sig_clone = sig.clone
          if tmp_sig.Name != sig_clone.Name
            sig_clone = tmp_sig
          end
          printf("@I:Make connection(%s.%s:%s) Indication:%s ( connect index : %s )\n",inst_name,sig_clone.Name,sig_clone.Type,con.Type,i)
          case con.Type
          when "CONNECT"
            if priority == "High"
              printf("Skip\n")
              next
            end
            connect_TargetInstance = get_ConnectTargetInstance(connect_file_type,con.ConnectTarget)
            if connect_TargetInstance != []
              make_connect(inst_inf,sig_clone,con_db,connect_TargetInstance,connect_file_type,i)
            else
              FMakeMessage.PrintError( :category => "CONNECT", :no => 220, :target => con.ConnectTarget, :con_file => con_db.CONNECT_FILE, :line_no => con.LineNo) 
            end
          when "PULLUP"
            if priority == "Normal"
              printf("Skip\n")
              next
            end
            make_pullup(inst_inf,sig_clone,con_db,connect_file_type,i)
          when "PULLDOWN"
            if priority == "Normal"
              printf("Skip\n")
              next
            end
            make_pulldown(inst_inf,sig_clone,con_db,connect_file_type,i)
          when "OPEN"
            if priority == "High"
              printf("Skip\n")
              next
            end
            make_open(inst_inf,sig_clone,con_db,connect_file_type,i)
          when "TERMINAL"
            if priority == "Normal"
              printf("Skip\n")
              next
            end
            make_terminal(inst_inf,sig_clone,con_db,connect_file_type,i)
          when "DRIVE_CHANGE"
            if priority == "High"
              printf("Skip\n")
              next
            end
            # Change target module connection
            connect_TargetInstance = get_ConnectTargetInstance(connect_file_type,con.ConnectTarget)
            new_BaseInstance = get_ConnectTargetInstance(connect_file_type,con.DriveModule)
            if connect_TargetInstance != [] && new_BaseInstance != []
              # Make New Connect ( New Drive Instace -> Original target instance )
              printf("\n@I:Make Drive Change\n")
              make_DriveChange_connect(inst_inf,sig_clone,con_db,new_BaseInstance,connect_file_type,i)
              # Make Connect ( Original Instance -> New Drive Instance ) 
              printf("\n@I:Make Connect\n\n")
              make_connect(inst_inf,sig_clone,con_db,connect_TargetInstance,connect_file_type,i)
            else
              FMakeMessage.PrintError( :category => "CONNECT", :no => 220, :target => con.ConnectTarget, :con_file => con_db.CONNECT_FILE, :line_no => con.LineNo) 
            end
          else
            # internal error
            FMakeMessage.PrintInternalError( :category => "FMakeLogic", :no => 20, :file_name => File.basename(__FILE__), :lineno => __LINE__, :param => con.Type)       
          end
        end
      else
        case inst_inf.MacroType
        when "Add","add","Add"
          FMakeMessage.PrintNote( :category => "CONNECT", :no => 210, :pin_name => sig.Name, :module_name => inst_inf.ModuleName)
          if con_a != nil
            #FMakeMessage.PrintError( :category => "CONNECT", :no => 210, :pin_name => sig.Name, :module_name => inst_inf.ModuleName, :connect_file => con_db.CONNECT_FILE, :line_no => con.LineNo)
          else
            #FMakeMessage.PrintError( :category => "CONNECT", :no => 210, :pin_name => sig.Name, :module_name => inst_inf.ModuleName, :connect_file => con_db.CONNECT_FILE, :line_no => 0)
          end
        end
      end
    end
  end

  #
  # XML Modify for CONNECT 
  #   param : inst_inf - Instance Infromation
  #           sig      - Target Module Signal Information
  #           con_db   - Conenct File Information
  #   ret   : true - success
  #
  private
  def make_connect(inst_inf,base_sig,con_db,connect_TargetInstance,connect_file_type,i)
    con = con_db.PIN_INF[base_sig.Name][i]
    # For All Connect Instance because the connections are not only one.
    connect_TargetInstance.each do |connect_target_instance|
      # resolve multi-hier
      tmp = connect_target_instance[0].split(".")
      target_instance = tmp.pop
      upper_module = tmp.pop
      upper_module = target_instance if upper_module == nil
      # get Port Information at Tareget Macro
      target_signal_db = XMLParse::get_PortList(@root,target_instance)
      target_sig =  target_signal_db["#{con.ConnectPort}"]
      # get Port Information at Tareget Macro
      target_wire_db = XMLParse::get_WireList(@root,target_instance)
      target_wire =  target_wire_db["#{con.ConnectPort}"]
      # Error Check
      connect_check(con_db,base_sig,base_sig,target_sig,target_wire,i)

      # Support no-port connection.
      if target_sig == nil && target_wire != nil
        direction = nil
        case base_sig.Type
        when "input"
          direction = "output"
        when "output"
          direction = "input"
        when "inout"
          direction = "inout"
        end

        # make port data
        signal = FICE_DB::SignalInf.new( 
                                        :name => target_wire.Name, 
                                        :type => direction, 
                                        :msb => target_wire.MSB, 
                                        :lsb => target_wire.LSB, 
                                        :portion => target_wire.BusPortion, 
                                        :word_top => target_wire.WordTop, 
                                        :word_buttom => target_wire.WordButtom,
                                        :new_flag => true
                                        )
        # Add Port
        printf("XML Modify. Add Port to %s module ( port name : %s ,direction : %s)\n",target_instance,signal.Name,direction) if $VERBOSE
        XMLParse::add_Port(@root,target_instance,signal)
        # Add Terminal
        printf("XML Modify. Add Terminal to %s module ( terminal name : %s )\n",target_instance,signal.Name)  if $VERBOSE
        XMLParse::add_Terminal(@root,target_instance,signal,con_db)

        # Add Wire upper Module for Make New Wire judgmenet
        if XMLParse::get_WireList(@root,upper_module)[target_wire.Name] != nil
#          printf "@Internal, Not support in this case."
#          exit
        else
          printf("XML Modify. Add Wire to %s module ( wire name : %s )\n",upper_module,signal.Name) if $VERBOSE
          XMLParse::add_Wire(@root,upper_module,signal)
        end 
       
        target_sig = signal
      elsif target_sig == nil
        target_sig = FICE_DB::SignalInf.new( 
                                            :name => con.ConnectPort, 
                                            )

      end
      # Make All Connection Data
      base_instance = inst_inf.InstName
      base_port = base_sig.Name
      target_module = resolve_Hier_from_Instance(connect_target_instance[1].split("."))
      target_instance = connect_target_instance[1]
      target_port = target_sig.Name  if target_sig != nil
      base_module_path = @TOP_MODULE + "." + resolve_Hier_from_Instance(inst_inf.InstName.split("."))[0][0]
      
      target_module.each do |each_target_module|
        target_module = each_target_module[0] # get module_name
        # XML Modify & Print Message
        printf("@I:Make new connect from %s.%s (%s) to %s.%s (Module Name:%s)\n",base_instance,base_port,base_module_path,target_instance,target_port,target_module)
        connect_modify_to_xml(con_db,con,base_sig,base_module_path,base_instance,base_port,target_module,target_instance,target_port)
        printf("Done\n")
      end            

#      target_sig.InstName = target_instance
#      @circuit_inf.add_connect(inst_inf.InstName+"."+base_sig.Name,connect_file_type,inst_inf.ModuleName,con,target_sig)
      
    end
    return true
  end


  #
  # XML Modify for DRIVE_CHANE CONNECT 
  #   param : inst_inf - Instance Infromation
  #           sig      - Target Module Signal Information
  #           con_db   - Conenct File Information
  #   ret   : true - success
  #
  private
  def make_DriveChange_connect(inst_inf,org_sig,con_db,connect_BaseInstance,connect_file_type,i)
 
    # 1. Get Original Taget Connect Instance/Port
    printf("\n@I:Search Connection about %s.%s\n",inst_inf.InstName,org_sig.Name)

    if inst_inf.InstName.split(".").size == 1
      top_module = @TOP_MODULE
      connect_list = XMLParse::search_Connection(true,@root,top_module,inst_inf.InstName,[org_sig.Name,nil],false)
    else
      module_path = resolve_Hier_from_Instance(inst_inf.InstName.split("."))[0][0]
      tmp = module_path.split(".")
      tmp.pop
      top_module = @TOP_MODULE + "." + tmp.join(".")
      connect_list = XMLParse::search_Connection(true,@root,top_module,inst_inf.InstName,[org_sig.Name,nil],true,nil,nil,0,@CONF_DB.INST.keys)
    end

    con = con_db.PIN_INF[org_sig.Name][i]
    connect_TargetInstance = connect_list.getConnectInf(@CONF_DB)

#    p connect_TargetInstance
#    exit
    # For All Connect Instance because the connections are not only one.
    connect_TargetInstance.each do |connect_target_instance|
      tmp_module = connect_target_instance[2]
      # get Port Information at Target Macro
      target_signal_db = XMLParse::get_PortList(@root,connect_target_instance[0])
      target_sig =  target_signal_db[tmp_module]
      
      # get Port Information at Target Macro
      target_wire_db = XMLParse::get_WireList(@root,connect_target_instance[0])
      target_wire =  target_wire_db[tmp_module]
      connect_BaseInstance.each do |each_connect_BaseInstance|
        new_drive_module  = each_connect_BaseInstance[0] # get module name
        depth = new_drive_module.split(".")
        
        # For Multi-Hier
        if depth.size == 1 # Signle Hier
          base_sig = XMLParse::get_PortList(@root,new_drive_module)[con.DrivePort]
        else # Multi Hier
          base_sig = XMLParse::get_PortList(@root,depth.pop)[con.DrivePort]
        end
  
      # Error Check
=begin
        p org_sig
        p target_sig
        p base_sig
        connect_check(con_db,org_sig,base_sig,target_sig,target_wire,i)
        connect_check(con_db,base_sig,base_sig,target_sig,target_wire,i)
=end

        # Support no-port connection.
        if target_sig == nil && target_wire != nil
          direction = nil
          case base_sig.Type
          when "input"
            direction = "output"
          when "output"
            direction = "input"
          when "inout"
            direction = "inout"
          end
          
          # make port data
          signal = FICE_DB::SignalInf.new( 
                                          :name => target_wire.Name, 
                                          :type => direction, 
                                          :msb => target_wire.MSB, 
                                          :lsb => target_wire.LSB, 
                                          :portion => target_wire.BusPortion, 
                                          :word_top => target_wire.WordTop, 
                                          :word_buttom => target_wire.WordButtom,
                                          :new_flag => true
                                          )
          # Add Port
          printf("XML Modify. Add Port to %s module ( port name : %s ,direction : %s)\n",tmp_module,signal.Name,direction) if $VERBOSE
          XMLParse::add_Port(@root,tmp_module,signal)
          # Add Terminal
          printf("XML Modify. Add Terminal to %s module ( terminal name : %s )\n",tmp_module,signal.Name) if $VERBOSE
          XMLParse::add_Terminal(@root,tmp_module,signal,con_db)

          # Add Wire upper Module for Make New Wire judgmenet
          if XMLParse::get_WireList(@root,upper_module)[target_wire.Name] != nil
            printf "@Internal, Not support in this case."
            exit
          else
            printf("XML Modify. Add Wire to %s module ( wire name : %s )\n",upper_module,signal.Name) if $VERBOSE
            XMLParse::add_Wire(@root,upper_module,signal)
          end 
          
          target_sig = signal
        elsif target_sig == nil
          target_sig = FICE_DB::SignalInf.new( 
                                              :name => tmp_module, 
                                              )
          
        end

        if connect_BaseInstance.size > 1
          # Error( Not Only One Driver )
        end
        
        # Make All Connection Data
        base_instance = each_connect_BaseInstance[1]
        base_port = base_sig.Name
        target_instance = connect_target_instance[1]
        target_port = target_sig.Name
        full_module_path = @TOP_MODULE + "." + each_connect_BaseInstance[0]

        target_module = resolve_Hier_from_Instance(connect_target_instance[1].split("."))
        target_module.each do |each_target_module|
          target_module = each_target_module[0]
          # XML Modify & Print Message
          printf("@I:Make new connect from %s.%s to %s.%s (Module Name:%s)\n",base_instance,base_port,target_instance,target_port,target_module)
          connect_modify_to_xml(con_db,con,base_sig,full_module_path,base_instance,base_port,target_module,target_instance,target_port)
        end        

        target_sig.InstName = target_instance
#        @circuit_inf.add_connect(inst_inf.InstName+"."+base_sig.Name,connect_file_type,inst_inf.ModuleName,con,target_sig)
      end
      
    end
    return true
  end
  
  #
  # Connect Modify for XML
  #
  def connect_modify_to_xml(con_db,con,base_sig,base_module,base_instance,base_port,target_module,target_instance,target_port,port_already=false)
    printf("connect_modify_to_xml Base:%s , Target:%s\n",base_module,target_module) if $VERBOSE
=begin
    p "base_sig:#{base_sig.Name}"
    p "base_module:#{base_module}"
    p "base_instance:#{base_instance}"
    p "base_port:#{base_port}"
    p "target_module:#{target_module}"
    p "target_instance:#{target_instance}"
    p "target_port:#{target_port}"
=end
    # resolve Hierarchy ( Module/Instance, Base/Target)
    base_current_module, base_upper_module, base_higher_module_name, base_upper_module_size = analyze_BaseTarget_path(base_module,"module") if base_module != nil
    base_current_instance, base_upper_instance, base_higher_instance_name, base_upper_instance_size = analyze_BaseTarget_path(base_instance,"instance") if base_instance != nil
    target_current_module, target_upper_module, target_higher_module_name, target_upper_module_size = analyze_BaseTarget_path(target_module,"module") if target_module != nil
    target_current_instance, target_upper_instance, target_higher_instance_name, target_upper_instance_size = analyze_BaseTarget_path(target_instance,"instance") if target_instance != nil

    force_upper = false
    if base_upper_instance != nil &&  target_upper_instance != nil
      base_path =  base_upper_instance.split(".") 
      target_path = target_upper_instance.split(".") 
      if ( target_path - base_path == target_path ) && ( base_path !=  [] )
        force_upper = true
      end
    end
    
    if base_upper_instance == nil # Connct from Terminal To Port ( module port and wire are already added in XML )
      
      if base_module == target_higher_module_name # Connect to Instance
        printf("@I:Modify XML from Terminal( module : %s, port : %s) to Instance-Port ( instance : %s ).\n",base_module,base_port,target_current_instance )
        
        # make wire data
        signal = FICE_DB::SignalInf.new( 
                                        :name => base_port, 
                                        :type => "wire", 
                                        )
        # Change Connection to base_instance
        printf("XML Modify. Change Connection for %s.%s\n",target_current_instance,target_port) if $VERBOSE
        XMLParse::change_Connection(@root,base_module,target_current_instance,{"#{target_port}" => [signal]},con_db)

      else # Next Lower Instance

        printf("@I:Modify XML from Terminal( module : %s, port : %s) to Instance-Port ( instance : %s ).\n",base_module,base_port,target_instance )
        # Next Lower module
#        FMakeMessage::PrintInternalError( :category => "ALL", :no => 0, :file_name => __FILE__, :lineno => __LINE__)
        
      end

    elsif target_upper_instance == nil # Connect Port to Terminal

      # Maybe same as Connect Upper Hierarchy. So no-need to implement
      printf("@I:Modify XML from Instance-Port to Terminal\n") if $VERBOSE
      FMakeMessage::PrintInternalError( :category => "ALL", :no => 0, :file_name => __FILE__, :lineno => __LINE__)

    elsif base_upper_instance == target_upper_instance # Same Hierarchy. Connect from Instance to Instance
      hier = "Same"
      printf("@I:Modify XML for Same Hierarchy.\n")  if $VERBOSE

      # get wire name connecting Target Port
      case base_sig.Type
      when "output"
        # If Base Port have connection originally, Use Original Wire. But dont have it, make new
        if XMLParse::get_ConnectList(@root,"#{base_higher_module_name}","#{base_current_instance}") != nil
          net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,base_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,target_port,con,false,port_already)
        else
          net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,base_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,target_port,con,true,port_already)
        end
      else
        # When input port, Base Instanc name was used in net name
#        net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,base_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,con)
        if XMLParse::get_ConnectList(@root,"#{target_higher_module_name}","#{target_current_instance}")[target_port] == nil
          net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,target_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,target_port,con,false,port_already)
        else
          net_name =  XMLParse::get_ConnectList(@root,"#{target_higher_module_name}","#{target_current_instance}")[target_port][0].Name
          if net_name != nil
            net = FICE_DB::SignalInf.new( :name => net_name , :type => "wire", :msb => base_sig.MSB, :lsb => base_sig.LSB )
            printf("XML Modify. Add Wire to %s module ( wire name : %s )\n",target_higher_module_name,net.Name) if $VERBOSE
            XMLParse::add_Wire(@root,target_higher_module_name,net)            
          else
            net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,target_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,target_port,con,false,port_already)
          end
        end
      end

      
      @connect_log.printf("[%s],%s,%s,%s,%s,%s\n",base_sig.Type,base_instance,base_port,net.Name,target_instance,target_port) if base_sig != nil
      
      case base_sig.Type
      when "input"
        printf("@I:Connect [Base]%s.%s <- [Net]%s <- [Target]%s.%s\n",base_instance,base_port,net.Name,target_instance,target_port)
      when "output"
        printf("@I:Connect [Base]%s.%s -> [Net]%s -> [Target]%s.%s\n",base_instance,base_port,net.Name,target_instance,target_port)
      when "inout"
      printf("@I:Connect [Base]%s.%s <-> [Net]%s <-> [Target]%s.%s\n",base_instance,base_port,net.Name,target_instance,target_port)
      else
        # internal error
        FMakeMessage.PrintInternalError( :category => "FMakeLogic", :no => 21, :file_name => File.basename(__FILE__), :lineno => __LINE__, :param => sig.Type)       
      end
      # make wire data
      signal = FICE_DB::SignalInf.new( 
                                      :name => net.Name, 
                                      :type => "wire", 
                                      :msb => net.MSB, 
                                      :lsb => net.LSB, 
# No Use BusPortion in Base                                     :portion => net.BusPortion, 
                                      :word_top => net.WordTop, 
                                      :word_buttom => net.WordButtom,
                                      :new_flag => true
                                      )

      # Change Connection to base_instance
      printf("XML Modify. Change Connection for %s.%s\n",base_instance,base_port) if $VERBOSE
      XMLParse::change_Connection(@root,base_higher_module_name,base_current_instance,{"#{base_port}" => [signal]},con_db)
      # Change Connection  to target_instance
      # make wire data
      signal = FICE_DB::SignalInf.new( 
                                      :name => net.Name, 
                                      :type => "wire", 
                                      :msb => net.MSB, 
                                      :lsb => net.LSB, 
                                      :portion => net.BusPortion, 
                                      :word_top => net.WordTop, 
                                      :word_buttom => net.WordButtom,
                                      :new_flag => true
                                      )
      printf("XML Modify. Change Connection for %s.%s\n",target_instance,target_port) if $VERBOSE
      XMLParse::change_Connection(@root,target_higher_module_name,target_current_instance,{"#{target_port}" => [signal]},con_db)
      
    elsif (( base_upper_instance_size >= target_upper_instance_size ) || force_upper == true )
      # Different Hierarchy. Connect to Terminal and continue next connection.
      hier = "Upper"
      printf("@I:Modify XML for Different Hierarchy. ( Connect to Upper Hierarchy )\n")  if $VERBOSE
      # get wire name connecting Target Port. Always make new wire
      case base_sig.Type
      when "output"
        if con.Type == "DRIVE_CHANGE"
          net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,base_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,target_port,con,true)
        else
          net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,base_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,target_port,con)
        end
      else
        net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,base_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,target_port,con,true)
      end
      org_net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,base_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,target_port,con)

      @connect_log.printf("[%s],%s,%s,%s,%s,%s\n",base_sig.Type,base_instance,base_port,net.Name,target_instance,target_port) if base_sig != nil

      case base_sig.Type
      when "input"
        printf("@I:Connect [Base]%s.%s <- [Net]%s <- [transfer point]%s.%s\n",base_instance,base_port,net.Name,base_upper_instance,net.Name)
      when "output"
        printf("@I:Connect [Base]%s.%s -> [Net]%s -> [transfer point]%s.%s\n",base_instance,base_port,net.Name,base_upper_instance,net.Name)
      when "inout"
        printf("@I:Connect [Base]%s.%s <-> [Net]%s <-> [transfer point]%s.%s\n",base_instance,base_port,net.Name,base_upper_instance,net.Name)
      else
        # internal error
        FMakeMessage.PrintInternalError( :category => "FMakeLogic", :no => 21, :file_name => File.basename(__FILE__), :lineno => __LINE__, :param => sig.Type)       
      end
      printf("XML Modify. Change Connection for %s.%s\n",base_instance,base_port) if $VERBOSE
      # make wire data
      if net.Comment == "OverWrite"
        signal = FICE_DB::SignalInf.new( 
                                        :name => net.Name, 
                                        :type => "wire", 
                                        :msb => net.MSB, 
                                        :lsb => net.LSB, 
#                                        :portion => net.BusPortion, 
                                        :word_top => net.WordTop, 
                                        :word_buttom => net.WordButtom,
                                        :new_flag => true
                                        )   
      else
        signal = FICE_DB::SignalInf.new( 
                                        :name => net.Name, 
                                        :type => "wire", 
                                        :msb => net.MSB, 
                                        :lsb => net.LSB, 
                                        :portion => net.BusPortion, 
                                        :word_top => net.WordTop, 
                                        :word_buttom => net.WordButtom,
                                        :new_flag => true
                                        )   
      end
      # Change Connection to base_instance
      XMLParse::change_Connection(@root,base_higher_module_name,base_current_instance,{"#{base_port}" => [signal]},con_db)
      # make wire data
      signal = FICE_DB::SignalInf.new( 
                                      :name => net.Name, 
                                      :type => base_sig.Type, 
                                      :msb => net.MSB, 
                                      :lsb => net.LSB, 
                                      :portion => net.BusPortion, 
                                      :word_top => net.WordTop, 
                                      :word_buttom => net.WordButtom,
                                      :new_flag => true
                                      )
      XMLParse::change_ConnectionToPort(@root,base_higher_module_name,base_current_instance,signal,con_db)

      # Care Other Connection
      if  base_sig.Type == "output"
        printf("[A]Search Connection Inst:%s.%s in Module:%s\n",base_instance,base_port,$TOP_MODULE + "." + base_upper_module)
        connect_list = nil
        connect_list = XMLParse::search_Connection(true,@root,$TOP_MODULE + "." + base_upper_module,base_instance,[base_port,nil],true,nil,nil,0,@CONF_DB.INST.keys)
        #        list = XMLParse::search_Connection(true,@root,top_module,inst_name,[sig,value],true,nil,nil,0,@CONF_DB.INST.keys)        
        #      connect_list = XMLParse::search_Connection(true,@root,target_upper_module,target_current_instance,[target_port,nil],false)      
        if connect_list != nil && connect_list.Path.size != 1
          # In case, Wire name was Changed
          if net.Name != org_net.Name
            # Changed Net name
            printf("@I: Connected Wire Changed from \"%s\" to \"%s\" by FMake, So other connection net also change.\n",org_net.Name,net.Name)
            connect_list.Path.each do |path|
              case path.size
              when 1
                # MySelf. Do nothing
              when 2
                other_connect_inst = path[1].InstName.split(".").last
                #              other_connect_inst = path[1].InstName.
                other_connect_port = path[1].Name
                printf("XML Modify. Change Connection for %s.%s ( module name : %s , wire name : %s )\n",other_connect_inst,other_connect_port,base_higher_module_name,net.Name) if $VERBOSE
                XMLParse::change_Connection(@root,base_higher_module_name,other_connect_inst,{"#{other_connect_port}" => [signal]},con_db)
              else
#              when 3
                inst_size =  path.last.InstName.split(".").size
                if inst_size <= path.size
                  other_connect_inst = path.last.InstName
                  other_connect_port = path.last.Name
                  tmp = resolve_Hier_from_Instance(other_connect_inst.split("."))[0][0].split(".")
                  current_module =  tmp.pop
                  
                  connect_change = false
                  if base_instance != nil &&  other_connect_inst != nil
                    base_path =  base_instance.split(".") 
                    target_path = other_connect_inst.split(".") 
                    if (( base_path & target_path ) != [] && base_path.size > target_path.size ) || target_path.size == 1
                      connect_change = true
                    end
                  end
                  
                  if tmp == []
                    module_name = $TOP_MODULE
                  else
                    module_name = $TOP_MODULE + "." + tmp.join(".")
                  end
                  if path.last.PortBusPortion != nil && path.last.Type == "input" && @CONF_DB.INST.keys.index(path.last.InstName) != nil
                    printf("@internal error: Not Support yet.\n")
                    pp path
                    pp path.last.PortBusPortion
                    pp path.last.Type
                    pp @CONF_DB.INST.keys.index(path.last.InstName)
                    exit
                  elsif path.last.Type == "input" && connect_change
                    name = "FMakeWire_" + target_instance.gsub(".","_") + "_" + base_port
                    new_signal = FICE_DB::SignalInf.new( 
                                                        :name => name, 
                                                        :type => "wire", 
                                                        :msb => net.MSB, 
                                                        :lsb => net.LSB, 
                                                        :portion => net.BusPortion, 
                                                        :word_top => net.WordTop, 
                                                        :word_buttom => net.WordButtom,
                                                        :new_flag => true
                                                        )      
                    printf("@XML Modify. Change Connection for %s.%s ( module name : %s , wire name : %s )\n",other_connect_inst,other_connect_port,module_name,name) if $VERBOSE
                    XMLParse::change_Connection(@root,module_name.split(".").last,other_connect_inst.split(".").last,{"#{other_connect_port}" => [new_signal]},con_db)
                  end
                end
                #              exit
              end
            end
          end
        end
      end
     
      # Next Connection
#      printf("Next Connection - 1\n")
      connect_modify_to_xml(con_db,con,signal,base_upper_module,base_upper_instance,signal.Name,target_module,target_instance,target_port)
   
    else # base_upper_instance_size < target_upper_instance_size
      hier = "Lower"
      printf("@I:Modify XML for Different Hierarchy. ( Connect to Lower Hierarchy )\n")  if $VERBOSE

      # update each data in this case

      # get wire name connecting Target Port. Always make new wire

      # Search Original Connect ( If target has other connection )
      case base_sig.Type
      when "output"
        net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,base_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,target_port,con,true,false)
      else
#        net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,base_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,con)
        net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,target_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,target_port,con,false,false)
      end

      org_net = get_WireInf(@root,hier,base_higher_module_name,base_current_module,base_current_instance,base_sig,target_higher_module_name,target_current_module,target_current_instance,target_port,con)

      @connect_log.printf("[%s],%s,%s,%s,%s,%s\n",base_sig.Type,base_instance,base_port,net.Name,target_instance,target_port) if base_sig != nil


      lower_direction = nil
      case base_sig.Type
      when "input"
        printf("@I:Connect [Base]%s.%s <- [Net]%s <- [transfer point]%s.%s\n",base_instance,base_port,net.Name,target_upper_instance,net.Name)
        lower_direction = "output"
      when "output"
        printf("@I:Connect [Base]%s.%s -> [Net]%s -> [transfer point]%s.%s\n",base_instance,base_port,net.Name,target_upper_instance,net.Name)
        lower_direction = "input"
      when "inout"
        printf("@I:Connect [Base]%s.%s <-> [Net]%s <-> [transfer point]%s.%s\n",base_instance,base_port,net.Name,target_upper_instance,net.Name)
        lower_direction = "inout"
      else
        # internal error
        FMakeMessage.PrintInternalError( :category => "FMakeLogic", :no => 21, :file_name => File.basename(__FILE__), :lineno => __LINE__, :param => sig.Type)       
      end


      signal = FICE_DB::SignalInf.new( 
                                      :name => net.Name, 
                                      :type => "wire", 
                                      :msb => net.MSB, 
                                      :lsb => net.LSB, 
                                      :portion => net.BusPortion, 
                                      :word_top => net.WordTop, 
                                      :word_buttom => net.WordButtom,
                                      :new_flag => true
                                      )      
#      transfer_instance = target_upper_instance.split(".")[0]
      transfer_instance = target_upper_instance

      # Add Wire
#      printf("XML Modify. Add Wire to %s module ( wire name : %s )\n",base_higher_module_name,net.Name)
#      XMLParse::add_Wire(@root,base_higher_module_name,net)
      # Change Connection to base_instance
      printf("XML Modify. Change Connection for %s.%s ( module name : %s , wire name : %s )\n",base_instance,base_port,base_higher_module_name,net.Name) if $VERBOSE
      XMLParse::change_Connection(@root,base_higher_module_name,base_current_instance,{"#{base_port}" => [signal]},con_db)
      # Change Connection  to transfer point
      
#      printf("XML Modify. Change Connection for %s.%s ( module name : %s , wire name : %s )\n",target_upper_instance,net.Name,target_higher_module_name,net.Name)      
#      XMLParse::change_Connection(@root,base_higher_module_name,target_upper_instance,{"#{net.Name}" => [signal]},con_db)
      printf("XML Modify. Change Connection for %s.%s ( module name : %s , wire name : %s )\n",transfer_instance,net.Name,target_higher_module_name,net.Name) if $VERBOSE
      XMLParse::change_Connection(@root,base_higher_module_name,transfer_instance,{"#{net.Name}" => [signal]},con_db)

      # Care Other Connection
      if  base_sig.Type == "input"
        printf("[B]Search Connection Inst:%s.%s in Module:%s\n",target_instance,target_port,$TOP_MODULE + "." + target_upper_module)
        connect_list = nil
        connect_list = XMLParse::search_Connection(true,@root,$TOP_MODULE + "." + target_upper_module,target_instance,[target_port,nil],true,nil,nil,0,@CONF_DB.INST.keys)      
        #        list = XMLParse::search_Connection(true,@root,top_module,inst_name,[sig,value],true,nil,nil,0,@CONF_DB.INST.keys)        
        #      connect_list = XMLParse::search_Connection(true,@root,target_upper_module,target_current_instance,[target_port,nil],false)      
        if connect_list != nil && connect_list.Path.size != 1
          # In case, Wire name was Changed
          if net.Name != org_net.Name
            # Changed Net name
            printf("@I: Connected Wire Changed from \"%s\" to \"%s\" by FMake, So other connection net also change.\n",org_net.Name,net.Name)
            connect_list.Path.each do |path|
              case path.size
              when 1
                # MySelf. Do nothing
              when 2
                other_connect_inst = path[1].InstName.split(".").last
                #              other_connect_inst = path[1].InstName.
                other_connect_port = path[1].Name
                printf("XML Modify. Change Connection for %s.%s ( module name : %s , wire name : %s )\n",other_connect_inst,other_connect_port,target_higher_module_name,net.Name) if $VERBOSE
                XMLParse::change_Connection(@root,target_higher_module_name,other_connect_inst,{"#{other_connect_port}" => [signal]},con_db)                
              else
                inst_size =  path.last.InstName.split(".").size
                if inst_size <= path.size
                  other_connect_inst = path.last.InstName
                  other_connect_port = path.last.Name
                  tmp = resolve_Hier_from_Instance(other_connect_inst.split("."))[0][0].split(".")
                  current_module =  tmp.pop
                  #                higher_module = tmp.pop
                  
                  connect_change = false
                  if base_instance != nil &&  other_connect_inst != nil
                    base_path =  base_instance.split(".") 
                    target_path = other_connect_inst.split(".") 
                    if (( base_path & target_path ) != [] && base_path.size > target_path.size ) || target_path.size == 1 || base_path.size == 1
                      connect_change = true
                    end
                  end
                  
                  if tmp == []
                    module_name = $TOP_MODULE
                  else
                    module_name = $TOP_MODULE + "." + tmp.join(".")
                  end
                  if path.last.PortBusPortion != nil && path.last.Type == "input" && @CONF_DB.INST.keys.index(path.last.InstName) != nil
                    printf("@internal error: Not Support yet.\n")
                    pp path
                    pp path.last.PortBusPortion
                    pp path.last.Type
                    pp @CONF_DB.INST.keys.index(path.last.InstName)
                    exit
                  elsif path.last.Type == "input" && connect_change
                    if  base_path.size == 1 && target_path.size != 1
                      tmp = target_instance.split(".")
                      tmp.delete_at(0)
                      new_wire_Name = tmp.join("_")
                      name = "FMakeWire_" + new_wire_Name + "_" + base_port
                    else
                      name = "FMakeWire_" + target_instance.gsub(".","_") + "_" + base_port
                    end
                    new_signal = FICE_DB::SignalInf.new( 
                                                        :name => name, 
                                                        :type => "wire", 
                                                        :msb => net.MSB, 
                                                        :lsb => net.LSB, 
                                                        :portion => net.BusPortion, 
                                                        :word_top => net.WordTop, 
                                                        :word_buttom => net.WordButtom,
                                                        :new_flag => true
                                                        )      
                    #                signal.Name = name
                    #                  printf("XML Modify. Change Connection for %s.%s ( module name : %s , wire name : %s )\n",other_connect_inst,other_connect_port,module_name,name)      
                    #                  XMLParse::change_Connection(@root,module_name,other_connect_inst,{"#{other_connect_port}" => [new_signal]},con_db)
                    printf("@XML Modify. Change Connection for %s.%s ( module name : %s , wire name : %s )\n",other_connect_inst,other_connect_port,module_name,name) if $VERBOSE
                    XMLParse::change_Connection(@root,module_name.split(".").last,other_connect_inst.split(".").last,{"#{other_connect_port}" => [new_signal]},con_db)
                  else
                    printf "Do nothing. (#{path.last.Type}, #{connect_change})\n" if $VERBOSE
                  end
                end
                printf "Done\n"
                #              exit
              end
            end
          end
        end
      end

      # make port data
      signal = FICE_DB::SignalInf.new( 
                                      :name => net.Name, 
                                      :type => lower_direction, 
                                      :msb => net.MSB, 
                                      :lsb => net.LSB, 
                                      :portion => net.BusPortion, 
                                      :word_top => net.WordTop, 
                                      :word_buttom => net.WordButtom,
                                      :new_flag => true
                                      )
      # Add Wire
      printf("XML Modify. Add Wire to %s module ( wire name : %s )\n",target_higher_module_name,signal.Name) if $VERBOSE
      XMLParse::add_Wire(@root,target_higher_module_name,signal)
      # Add Port
      printf("XML Modify. Add Port to %s module ( port name : %s ,direction : %s)\n",target_higher_module_name,signal.Name,lower_direction) if $VERBOSE     
      XMLParse::add_Port(@root,target_higher_module_name,signal)
      # Add Terminal
      printf("XML Modify. Add Terminal to %s module ( terminal name : %s )\n",target_higher_module_name,signal.Name) if $VERBOSE  
      ret = XMLParse::add_Terminal(@root,target_higher_module_name,signal,con_db)
      port_already = true if ret == 7
      # modify target_module
#      printf("Next Connection - 2\n")
      connect_modify_to_xml(con_db,con,signal,target_higher_module_name,nil,signal.Name,target_module,target_instance,target_port,port_already)
#      connect_modify_to_xml(con_db,con,signal,target_upper_module,nil,signal.Name,target_module,target_instance,target_port,port_already)

      # Make Next
      target_module = base_module
      target_instance = base_instance
      base_port = signal.Name
      base_current_module, base_upper_module, base_higher_module_name, base_upper_module_size = analyze_BaseTarget_path(target_upper_module,"module") if target_upper_module != nil
      base_current_instance, base_upper_instance, base_higher_instance_name, base_upper_instance_size = analyze_BaseTarget_path(target_upper_instance,"instance") if target_upper_instance != nil

      if base_upper_module != ""
        base_upper_module = base_upper_module + "." + base_current_module
      else
        base_upper_module = base_current_module
      end
      if base_upper_instance != ""
        base_upper_instance = base_upper_instance + "." + base_current_instance
      else
        base_upper_instance = base_current_instance
      end

      # Next Connection
#      printf("Next Connection - 3\n")
      connect_modify_to_xml(con_db,con,signal,base_upper_module,base_upper_instance,signal.Name,target_module,target_instance,base_sig.Name,port_already)
      port_already = false
    end

  end

  #
  # Analyze Base/Target path
  #
  private
  def analyze_BaseTarget_path(base,mode)
    tmp = base.split(".")
    current = tmp.pop
    upper = nil
    upper_size = 0
    if tmp != nil
      upper = tmp.join(".")
      upper_size = tmp.size
    end
    higher = tmp.pop 
    if higher == nil && mode == "module"
      higher = @TOP_MODULE
    end
    return current, upper, higher, upper_size
  end

  #
  # get Wire Information
  #  param : doc - XML data
  #          top_mdule - Top Module name
  #          target_module
  #          target_instance
  #          con - Connect Infomation
  #          force - true : force Make new wire
  #  return : Wire(FICE_DB::SignalInf)
  #
  private
  def get_WireInf(doc,hier,upper_module,base_current_module,base_instance,base_port,target_higher_module_name,target_current_module,target_instance,target_port,con,force=false,port_already=false)
    net_name = nil

    str = target_higher_module_name + "." + target_instance
    @CONNECT_LIST[str] = XMLParse::get_ConnectList(doc,"#{target_higher_module_name}","#{target_instance}") if @CONNECT_LIST[str].nil?
    target_port_list = @CONNECT_LIST[str]
#    target_port_list = XMLParse::get_ConnectList(doc,"#{target_higher_module_name}","#{target_instance}")

#    str = upper_module + "." + base_instance
#    @CONNECT_LIST[str] = XMLParse::get_ConnectList(doc,"#{upper_module}","#{base_instance}") if @CONNECT_LIST[str].nil?
#    base_port_list = @CONNECT_LIST[str]
    base_port_list = XMLParse::get_ConnectList(doc,"#{upper_module}","#{base_instance}")

    @PORT_LIST[target_higher_module_name] = XMLParse::get_PortList(doc,"#{target_higher_module_name}") if @PORT_LIST[target_higher_module_name].nil?
    port_list = @PORT_LIST[target_higher_module_name]
#    port_list = XMLParse::get_PortList(doc,"#{target_higher_module_name}")

# !NG!   
#    @WIRE_LIST[target_higher_module_name] = XMLParse::get_WireList(doc,"#{target_higher_module_name}") if @WIRE_LIST[target_higher_module_name].nil?
#    wire_list = @WIRE_LIST[target_higher_module_name] 
    wire_list = XMLParse::get_WireList(doc,"#{target_higher_module_name}")

=begin
    if $VERBOSE
      printf(" - hier : %s\n",hier)
      printf(" - upper_module : %s\n",upper_module)
      printf(" - base_current_module : %s\n", base_current_module)
      printf(" - base_instance : %s\n",base_instance)
      printf(" - base_port.Name : %s\n",base_port.Name)
      printf(" - target_higher_module_name : %s\n",target_higher_module_name)
      printf(" - target_current_module : %s\n", target_current_module)
      printf(" - target_instance : %s\n",target_instance)
      printf(" - con\n")
      p con
      printf(" - target_port_list(target_higher_module_name:%s,target_instance:%s)\n",target_higher_module_name,target_instance)
      p target_port_list
      printf(" - base_port_list(upper_module:%s,base_instance:%s)\n",upper_module,base_instance)
      p base_port_list
      printf(" - port_list(target_higher_module_name:%s)\n",target_higher_module_name)
      p port_list
      printf(" - wire_list(target_higher_module_name:%s)\n",target_higher_module_name)
      p wire_list
    end
=end
   
    if target_port_list["#{con.ConnectPort}"] != nil && target_port_list["#{con.ConnectPort}"].size > 1 
      # error  (Ver2.0 Limitation, see redmine ticket #1413)
#      if con != nil
#        FMakeMessage.PrintError( :category => "CONNECT", :no => 300, :target_port => con.ConnectPort, :target_module => con.ConnectTarget, 
#                                 :con_file => con_db.CONNECT_FILE, :line_no => con.LineNo)
#      else
        FMakeMessage.PrintError( :category => "CONNECT", :no => 300, :target_port => con.ConnectPort, :target_module => con.ConnectTarget, 
                                 :con_file => nil, :line_no => con.LineNo)
#      end
    end
    if target_port_list["#{con.ConnectPort}"] != nil 
      # get only one wire
      port = target_port_list["#{con.ConnectPort}"][0]
    elsif base_port_list["#{con.ConnectPort}"] != nil 
      port = base_port_list["#{con.ConnectPort}"][0]
    end
    
    if port_list["#{con.ConnectPort}"] != nil
      port.MSB = port_list["#{con.ConnectPort}"].MSB if port != nil
      port.LSB = port_list["#{con.ConnectPort}"].LSB if port != nil
      port = port_list["#{con.ConnectPort}"] if port == nil
    elsif wire_list["#{con.ConnectPort}"] != nil
      port.MSB = wire_list["#{con.ConnectPort}"].MSB if port != nil
      port.LSB = wire_list["#{con.ConnectPort}"].LSB if port != nil
      port = wire_list["#{con.ConnectPort}"] if port == nil
#    else
    elsif hier != "Same"
      port = base_port
    end

    if ( port != nil && ( port.Type == "wire" || port.Type == "output" ) && force == false ) && 
        ( con.ConnectTarget.split(".").size == 1 || target_instance == con.ConnectTarget.split(".").last || con.DriveModule != nil ) && port.NewFlag != true 
#    if ( port != nil && ( port.Type == "wire" || port.Type == "output" ) && force == false ) 
      # Use existing wire (saved Wire Information)
#      net = XMLParse::get_WireList(doc,target_higher_module_name)[port.Name]
      net = XMLParse::get_WireList(doc,upper_module)[port.Name]
      connect_net = nil
      conenct_net_inf = nil
      if  base_port_list[port.Name] != nil
        connect_net_inf =  base_port_list[port.Name][0]
        connect_net = base_port_list[port.Name][0].Name
      end
      
      if net == nil || ( net != nil && net.Name != connect_net )
        msb_tmp = nil
        lsb_tmp = nil
        if net != nil
          msb_tmp = net.MSB 
          lsb_tmp = net.LSB
        end
        net = port 
        # Update net Information        
        if connect_net != nil && hier == "Upper"
          net.Name = connect_net
          net.BusPortion = connect_net_inf.BusPortion
          net.PortBusPortion = connect_net_inf.BusPortion
        end
        if msb_tmp != nil
          net.MSB = msb_tmp
          net.LSB = lsb_tmp
        end

        if port.Type == "wire" && hier == "Same"
          net.Name = "FMakeWire_" + base_instance + "_" + base_port.Name.sub("FMakeWire_","") 
        end
        if hier == "Same" && base_port_list[base_port.Name] != nil && base_port_list[base_port.Name][0] != nil && base_port_list[base_port.Name][0].Name != nil
          net.Name =  base_port_list[base_port.Name][0].Name
        end
        if hier == "Upper" && base_port_list[base_port.Name] != nil && base_port_list[base_port.Name][0] != nil && net.MSB == nil
          net_name_tmp =  base_port_list[base_port.Name][0].Name
          if XMLParse::get_PortList(doc,"#{upper_module}")[net_name_tmp] != nil
            net.Name =  base_port_list[base_port.Name][0].Name
#          else
#            p "internal error\n"
#            p upper_module
#            exit
#            target_port_list = XMLParse::get_ConnectList(doc,"#{target_higher_module_name}","#{target_instance}")
          end
        end
        if net.MSB == nil
          printf("\t[A]Get Connected Wire - Name : \"%s\" ( This wire does not defined \"wire\" in %s module )\n",net.Name,upper_module) if $VERBOSE
        else
          printf("\t[A]Get Connected Wire - Name : \"%s[%d:%d]\" ( This wire does not defined \"wire\" in %s module )\n",net.Name,net.MSB,net.LSB,upper_module) if $VERBOSE
        end
        if hier == "Same"
          printf("XML Modify. Add Wire to %s module ( wire name : %s )\n",upper_module,net.Name)  if $VERBOSE
          XMLParse::add_Wire(@root,upper_module,net)
        end
      else
        if port.Type == "wire" && hier == "Same"
          net.Name = "FMakeWire_" + base_instance + "_" + base_port.Name.sub("FMakeWire_","") 
        end 
        if hier == "Same" && base_port_list[base_port.Name] != nil && base_port_list[base_port.Name][0] != nil && base_port_list[base_port.Name][0].Name != nil
          net.Name =  base_port_list[base_port.Name][0].Name
        end
        if net.MSB == nil
          printf("\t[B]Get Connected Wire - Name : \"%s\"\n",net.Name)  if $VERBOSE
        else
          printf("\t[B]Get Connected Wire - Name : \"%s[%d:%d]\"\n",net.Name,net.MSB,net.LSB) if $VERBOSE
        end
      end
    elsif port != nil && hier == "Lower" && port.Type == "input" && force == false && target_port_list[con.ConnectPort] != nil
      target_net =  target_port_list[con.ConnectPort][0]
      if target_net.Name != nil && target_net.BusPortion == nil
        # Use Original Wire
        net = FICE_DB::SignalInf.new( :name => target_net.Name, :type => "wire", :msb => port.MSB, :lsb => port.LSB )
        if net.MSB == nil
          printf("\t[C]Get Connected Wire - Name : \"%s\"\n",net.Name) if $VERBOSE
        else
          printf("\t[C]Get Connected Wire - Name : \"%s[%d:%d]\"\n",net.Name,net.MSB,net.LSB) if $VERBOSE
        end
      else
        # Make New Wire
        name = "FMakeWire_" + base_instance + "_" + base_port.Name.sub("FMakeWire_","")
        printf("@I:Make new wire \"%s\"\n",name)
        if port != nil
          if  port.Type != "open"  && port.Type != "constant"
            net = FICE_DB::SignalInf.new( :name => name , :type => "wire", :msb => port.MSB, :lsb => port.LSB )
          else
            net = FICE_DB::SignalInf.new( :name => name , :type => "wire", :msb => base_port.MSB, :lsb => base_port.LSB )
          end
        else
          base_inf = XMLParse::get_PortList(doc,"#{base_current_module}")[base_port.Name]
          if base_inf != nil
            net = FICE_DB::SignalInf.new( :name => name , :type => "wire", :msb => base_inf.MSB, :lsb => base_inf.LSB )
          else
            net = FICE_DB::SignalInf.new( :name => name , :type => "wire", :msb => nil, :lsb => nil)
          end
        end
      end
    elsif base_port != nil && port_already == true  && base_port.Name != nil && force == false
      # Use Original Wire
      target_net = base_port  
      net = FICE_DB::SignalInf.new( :name => target_net.Name, :type => "wire", :msb => target_net.MSB, :lsb => target_net.LSB )
      if net.MSB == nil
        printf("\t[D]Get Connected Wire - Name : \"%s\"\n",net.Name) if $VERBOSE
      else
        printf("\t[D]Get Connected Wire - Name : \"%s[%d:%d]\"\n",net.Name,net.MSB,net.LSB) if $VERBOSE
      end      
      if hier == "Same"
        printf("XML Modify. Add Wire to %s module ( wire name : %s )\n",upper_module,net.Name) if $VERBOSE
        XMLParse::add_Wire(@root,upper_module,net)
      end
    elsif (hier == "Upper" || hier == "Same" ) && ( base_port_list[base_port.Name] != nil && base_port_list[base_port.Name][0].Name != nil ) && target_port_list[con.ConnectPort] == nil
      #    elsif (hier == "Upper" || hier == "Same" ) && base_port_list[base_port.Name] != nil
#      p target_port_list[con.ConnectPort]
#      exit
#    elsif ( hier == "Upper" ) && base_port_list[base_port.Name] != nil
      # Use Original Wire
      target_net = base_port  
#      net = FICE_DB::SignalInf.new( :name => target_net.Name, :type => "wire", :msb => target_net.MSB, :lsb => target_net.LSB )
      net = FICE_DB::SignalInf.new( :name => base_port_list[base_port.Name][0].Name, :type => "wire", :msb => target_net.MSB, :lsb => target_net.LSB )
      if net.MSB == nil
        printf("\t[E]Get Connected Wire - Name : \"%s\"\n",net.Name) if $VERBOSE
      else
        printf("\t[E]Get Connected Wire - Name : \"%s[%d:%d]\"\n",net.Name,net.MSB,net.LSB) if $VERBOSE
      end      
      if hier == "Same"
        printf("XML Modify. Add Wire to %s module ( wire name : %s )\n",upper_module,net.Name) if $VERBOSE
        XMLParse::add_Wire(@root,upper_module,net)
      end
#    elsif ( hier == "Upper" ) && target_port_list[base_port.Name] != nil && ( base_port_list[base_port.Name] != nil && base_port_list[base_port.Name][0].Name != nil )
    elsif  (hier == "Upper" || hier == "Same" ) &&
        ( base_port_list[base_port.Name] != nil && base_port_list[base_port.Name][0].Name != nil && base_port_list[base_port.Name][0].Type != "constant" ) && 
        base_port.Type == "output" && force == false && con.Type != "DRIVE_CHANGE"
#    elsif  (hier == "Upper" ) && ( base_port_list[base_port.Name] != nil && base_port_list[base_port.Name][0].Name != nil ) && base_port.Type == "output" && force == false
#    elsif ( hier == "Upper" ) && ( base_port_list[base_port.Name] != nil && base_port_list[base_port.Name][0].Name != nil ) 
#    elsif ( hier == "Upper" ) && target_port_list[base_port.Name] != nil
#      p "-------------------"
#      printf(" - target_port_list(target_higher_module_name:%s,target_instance:%s)\n",target_higher_module_name,target_instance)
#      p target_port_list
#      p base_port
#      p "base_port_list"
#      p base_port_list
#      p base_instance
#      exit
#    elsif (hier == "Upper" || hier == "Same" ) && base_port_list[base_port.Name] != nil
#      p target_port_list[con.ConnectPort]
#      exit
#    elsif ( hier == "Upper" ) && base_port_list[base_port.Name] != nil
      # Use Original Wire
      target_net = base_port  
      if base_port_list[base_port.Name][0].Name == nil
        net = FICE_DB::SignalInf.new( :name => target_net.Name, :type => "wire", :msb => target_net.MSB, :lsb => target_net.LSB, :portion => base_port.BusPortion, :comment => "OverWrite" )
      else
        net = FICE_DB::SignalInf.new( :name => base_port_list[base_port.Name][0].Name, :type => "wire", :msb => target_net.MSB, :lsb => target_net.LSB, :portion => base_port.BusPortion, :comment => "OverWrite"  )
      end
      if net.BusPortion != nil
        printf("\t[F]Get Connected Wire - Name : \"%s[%d]\"\n",net.Name,net.BusPortion)  if $VERBOSE
      elsif net.MSB == nil
        printf("\t[F]Get Connected Wire - Name : \"%s\"\n",net.Name) if $VERBOSE
      else
        printf("\t[F]Get Connected Wire - Name : \"%s[%d:%d]\"\n",net.Name,net.MSB,net.LSB) if $VERBOSE
      end      
      if hier == "Same"
        printf("XML Modify. Add Wire to %s module ( wire name : %s )\n",upper_module,net.Name) if $VERBOSE
        XMLParse::add_Wire(@root,upper_module,net)
      end
    else
      # Make new wire
      if base_port.Type == "input" && hier == "Same"
        name = "FMakeWire_" + base_instance + "_" + target_port.sub("FMakeWire_","")
      else
        if base_instance != nil
          name = "FMakeWire_" + base_instance + "_" + base_port.Name.sub("FMakeWire_","")
        else
          name = "FMakeWire_" + base_port.Name.sub("FMakeWire_","")
        end
      end
      printf("@I:Make new wire \"%s\" in %s\n",name, upper_module)
      if port != nil
        if  port.Type != "open" && port.Type != "constant"
          net = FICE_DB::SignalInf.new( :name => name , :type => "wire", :msb => port.MSB, :lsb => port.LSB, :portion => base_port.BusPortion  )
        else
          net = FICE_DB::SignalInf.new( :name => name , :type => "wire", :msb => base_port.MSB, :lsb => base_port.LSB, :portion => base_port.BusPortion )
        end
      else
#        @PORT_LIST[base_current_module] = XMLParse::get_PortList(doc,"#{base_current_module}") if @PORT_LIST[base_current_module].nil?
#        base_inf = @PORT_LIST[base_current_module][base_port.Name]
        base_inf = XMLParse::get_PortList(doc,"#{base_current_module}")[base_port.Name]
        if base_inf != nil
          net = FICE_DB::SignalInf.new( :name => name , :type => "wire", :msb => base_inf.MSB, :lsb => base_inf.LSB, :portion => base_port.BusPortion )
        else
          net = FICE_DB::SignalInf.new( :name => name , :type => "wire", :msb => nil, :lsb => nil, :portion => base_port.BusPortion )
        end
      end
      # Add Wire
      if hier != "Lower"      
        printf("XML Modify. Add Wire to %s module ( wire name : %s )\n",upper_module,net.Name) if $VERBOSE
        XMLParse::add_Wire(@root,upper_module,net)
        if net.MSB == nil
          printf("\tThere is no orignal connected-wire, So make new wire - Name : \"%s\"\n",net.Name) if $VERBOSE
        elsif net.BusPortion != nil
          printf("\tThere is no orignal connected-wire, So make new wire - Name : \"%s[%d]\"\n",net.Name,net.BusPortion)  if $VERBOSE
        else
          printf("\tThere is no orignal connected-wire, So make new wire - Name : \"%s[%d:%d]\"\n",net.Name,net.MSB,net.LSB) if $VERBOSE
        end
        new_flag = true
      end
    end
    return net
  end

  #
  # XML Modify for PULLUP 
  #   param : inst_inf - Instance Infromation
  #           sig      - Target Module Signal Information
  #           con_db   - Conenct File Information
  #   ret   : true - success
  #
  private
  def make_pullup(inst_inf,sig,con_db,connect_file_type,i)
    # resolve Multi Hier
    upper_module,inst_name = resolve_MultiHier(inst_inf)

    # Port Direction Check ( only input/inout is allowd in pullup )
    if sig.Type == "input"
      con = con_db.PIN_INF[sig.Name][i]
      const = make_ConstantValue(sig,1)
      printf("\tadd Connection(PULLUP:%s)\n",const)
      signal = FICE_DB::SignalInf.new( 
                                      :name => const, 
                                      :type => "constant", 
                                      :msb => sig.MSB, 
                                      :lsb => sig.LSB, 
                                      :portion => sig.BusPortion, 
                                      :word_top => sig.WordTop, 
                                      :word_buttom => sig.WordButtom)
      # connect port to PULLUP in instantiation
      if XMLParse::change_Connection(@root,upper_module,inst_name,{"#{sig.Name}" => [signal]},con_db) == false
      end
#      @circuit_inf.add_connect(inst_inf.InstName+"."+sig.Name,connect_file_type,inst_inf.ModuleName,con,signal)
      printf("Done\n")
    else
      # Error of port-direction
      printf "\n"
      FMakeMessage.PrintError( :category => "CONNECT", :no => 211, :pin_name => sig.Name, :direction => sig.Type, :verilog => inst_inf.ReplaceVerilogFile)
    end
    return true
  end

  #
  # Resolve MultiHier
  #
  def resolve_MultiHier(inst_inf)
    # For Multi-Hier
    inst_path = inst_inf.InstName.split(".")
    inst_name = inst_path.pop
    inst_path = inst_path.join(".")
    upper_module = nil
    if inst_path == ""
      upper_module = @TOP_MODULE      
    else
      upper_module = resolve_Hier_from_Instance(inst_path.split("."))[0][0].split(".").pop
    end
    return upper_module, inst_name
  end

  #
  # XML Modify for PULLDOWN
  #   param : inst_inf - Instance Infromation
  #           sig      - Target Module Signal Information
  #           con_db   - Conenct File Information
  #   ret   : true - success
  #
  private
  def make_pulldown(inst_inf,sig,con_db,connect_file_type,i)
    # For Multi-Hier
    upper_module,inst_name = resolve_MultiHier(inst_inf)

    # Port Direction Check ( only input/inout is allowd in pulldown )
    if sig.Type == "input"
      con = con_db.PIN_INF[sig.Name][i]
      const = make_ConstantValue(sig,0)
      printf("\tadd Connection(PULLDOWN:%s)\n",const)
      signal = FICE_DB::SignalInf.new( 
                                      :name => const, 
                                      :type => "constant", 
                                      :msb => sig.MSB, 
                                      :lsb => sig.LSB, 
                                      :portion => sig.BusPortion, 
                                      :word_top => sig.WordTop, 
                                      :word_buttom => sig.WordButtom)
      # connect port to PULLDOWN in instantiation1
      XMLParse::change_Connection(@root,upper_module,inst_name,{"#{sig.Name}" => [signal]},con_db)
#      @circuit_inf.add_connect(inst_inf.InstName+"."+sig.Name,connect_file_type,inst_inf.ModuleName,con,signal)
      printf("Done\n")    
    else
      # Error of port-direction
      printf "\n"
      FMakeMessage.PrintError( :category => "CONNECT", :no => 211, :pin_name => sig.Name, :direction => sig.Type, :verilog => inst_inf.ReplaceVerilogFile)
    end
    return true
  end
  
  #
  # XML Modify for OPEN
  #   param : inst_inf - Instance Infromation
  #           sig      - Target Module Signal Information
  #           con_db   - Conenct File Information
  #   ret   : true - success
  #
  private
  def make_open(inst_inf,sig,con_db,connect_file_type,i)
    # For Multi-Hier
    upper_module,inst_name = resolve_MultiHier(inst_inf)

    # Port Direction Check ( only output is allowd in open )
    if sig.Type == "output" || sig.Type == "inout"
      con = con_db.PIN_INF[sig.Name][i]
      printf("\tdelete Connection(OPEN)\n")
      signal = FICE_DB::SignalInf.new( 
                                      :name => nil, 
                                      :type => "open" 
                                      )
      # connect port to PULLDOWN in instantiation1
      XMLParse::change_Connection(@root,upper_module,inst_name,{"#{sig.Name}" => [signal]},con_db)
#      @circuit_inf.add_connect(inst_inf.InstName+"."+sig.Name,connect_file_type,inst_inf.ModuleName,con,signal)
      printf("Done\n")    
    else
      # Error of port-direction
      printf "\n"
      FMakeMessage.PrintError( :category => "CONNECT", :no => 212, :pin_name => sig.Name, :direction => sig.Type, :verilog => inst_inf.ReplaceVerilogFile)
    end
    return true
  end

  #
  # XML Modify for TERMINAL
  #   param : inst_inf - Instance Infromation
  #           sig      - Target Module Signal Information
  #           con_db   - Conenct File Information
  #   ret   : true - success
  #
  private
  def make_terminal(inst_inf,sig,con_db,connect_file_type,i,first=true) 
    current_instance, upper_instance, higher_instance, inst_size = analyze_BaseTarget_path(inst_inf.InstName,"instance")
    module_path_array = resolve_Hier_from_Instance(inst_inf.InstName.split("."))
    base_instance = inst_inf.InstName
    module_path_array.each do |mod|
      module_path = mod[0]
      current_module, upper_module, higher_module, inst_size = analyze_BaseTarget_path(module_path,"module")

      if inst_inf.MacroType == "Add" ||  inst_inf.MacroType == "KeepChange" 
        new_module_name = inst_inf.ModuleName.split(".").last
        next if ( current_module != new_module_name ) # Different Module
      elsif inst_inf.MacroType == "Replace"
        if inst_inf.ReplaceModuleName != nil
          new_module_name = inst_inf.ReplaceModuleName 
        else
          new_module_name = inst_inf.ModuleName.split(".").last
        end
        next if ( current_module != new_module_name ) # Different Module
      else
        next if ( current_module != inst_inf.ModuleName ) && ( current_module != inst_inf.ReplaceModuleName ) # Different Module
      end

      original_Port = sig.Name
      original_ConnectInf = XMLParse::get_ConnectListwithPort(@root,higher_module,current_instance,sig.Name)
      org_net = original_ConnectInf[0]
      if org_net != nil
        org_net_name = org_net.Name
      end
      base_port = original_Port

      # No-Need Port Direction Check ( all direction type is allowd in terminal )
      con = con_db.PIN_INF[sig.Name][i]      
      signal = FICE_DB::SignalInf.new( 
                                      :name => con.TerminalName, 
                                      :type => sig.Type, 
                                      :msb => sig.MSB, 
                                      :lsb => sig.LSB, 
                                      :portion => sig.BusPortion, 
                                      :word_top => sig.WordTop, 
                                      :word_buttom => sig.WordButtom,
                                      :new_flag => true
                                      )

      # Care Other Connection
      if  sig.Type == "output" && first == true
        base_upper_module = upper_module
        base_higher_module_name = higher_module
        base_instance = inst_inf.InstName
        target_instance = base_instance
        printf("[C]Search Connection Inst:%s in Module:%s(%s)\n",base_instance,$TOP_MODULE + "." + base_upper_module,base_port)
        connect_list = nil
        connect_list = XMLParse::search_Connection(true,@root,$TOP_MODULE + "." + base_upper_module,base_instance,[base_port,nil],true,nil,nil,0,@CONF_DB.INST.keys)
        if connect_list.Path != [] && connect_list.Path.size != 1
          # In case, Wire name was Changed
          if con.TerminalName != org_net_name
            net = org_net
            net.Name = con.TerminalName
            # Changed Net name
            printf("@I: Connected Wire Changed from \"%s\" to \"%s\" by FMake, So other connection net also change.\n",org_net_name,net.Name)
            connect_list.Path.each do |path|
              case path.size
              when 1
                # MySelf. Do nothing
              when 2
                other_connect_inst = path[1].InstName.split(".").last
                #              other_connect_inst = path[1].InstName.
                other_connect_port = path[1].Name
                printf("XML Modify. Change Connection for %s.%s ( module name : %s , wire name : %s )\n",other_connect_inst,other_connect_port,base_higher_module_name,net.Name)  if $VERBOSE
                XMLParse::change_Connection(@root,base_higher_module_name,other_connect_inst,{"#{other_connect_port}" => [signal]},con_db)
#              when 3,4,5,6,7,8,9,10,11,12,13
              else
                inst_size =  path.last.InstName.split(".").size
                if inst_size <= path.size
                  other_connect_inst = path.last.InstName
                  other_connect_port = path.last.Name
                  tmp = resolve_Hier_from_Instance(other_connect_inst.split("."))[0][0].split(".")
                  current_module =  tmp.pop
                  connect_change = false
                  if base_instance != nil &&  other_connect_inst != nil
                    base_path =  base_instance.split(".") 
                    target_path = other_connect_inst.split(".") 
                    if (( base_path & target_path ) != [] && base_path.size > target_path.size ) || target_path.size == 1
                      connect_change = true
                    end
                  end
                  
                  if tmp == []
                    module_name = $TOP_MODULE
                  else
                    module_name = $TOP_MODULE + "." + tmp.join(".")
                  end
                  if path.last.PortBusPortion != nil && path.last.Type == "input" && @CONF_DB.INST.keys.index(path.last.InstName) != nil
                    printf("@internal error: Not Support yet.\n")
                    pp path
                    pp path.last.PortBusPortion
                    pp path.last.Type
                    pp @CONF_DB.INST.keys.index(path.last.InstName)
                    exit
                  elsif path.last.Type == "input" && connect_change == true
                    name = con.TerminalName
                    new_signal = signal
                    #                signal.Name = name
                    printf("@XML Modify. Change Connection for %s.%s ( module name : %s , wire name : %s )\n",other_connect_inst,other_connect_port,module_name,name)  if $VERBOSE
                    XMLParse::change_Connection(@root,module_name.split(".").last,other_connect_inst.split(".").last,{"#{other_connect_port}" => [new_signal]},con_db)
                  end
                end
                #              exit
              end
            end
          end
        end
      end

      # 1. add Wire
      printf("add Wire( Module Name: %s, Wire name: %s )\n",higher_module,signal.Name)
      XMLParse::add_Wire(@root,higher_module,signal,con_db) if XMLParse::get_WireList(@root,higher_module)[signal.Name] == nil
      # 2. add Terminal
      printf("add Terminal( Module Name: %s, Port name: %s )\n",higher_module,signal.Name)
      XMLParse::add_Terminal(@root,higher_module,signal,con_db)
      # 3. add Port
      printf("add Port( Module Name: %s, Port name: %s )\n",higher_module,signal.Name)
      XMLParse::add_Port(@root,higher_module,signal,con_db)
      # 4. connect port to wire in instantiation
      printf("add InstancePort( Module Name: %s, Instance Name: %s, Connect name: %s ( to %s port ) )\n",higher_module,current_instance,signal.Name,sig.Name)
      XMLParse::change_Connection(@root,higher_module,current_instance,{"#{sig.Name}" => [signal]},con_db)
      printf("Done\n")
      


      if inst_size != 0 
        # make new inst_inf
        new_inst_inf = FICE_DB::Conf::InstInf.new(:conf_file => inst_inf.CONF_FILE,
                                                  :module_name => upper_module,
                                                  :inst_name => upper_instance,
                                                  :macro_type => inst_inf.MacroType,
                                                  )
        sig.Name = signal.Name
        # Add Pin Information in Connect-DB
        if con_db.PIN_INF[sig.Name].nil?
          con_db.add_PinInfo(:pin_name => sig.Name, :line => con.Line, :line_no => con.LineNo,:type => con.Type, :terminal_name => sig.Name)
        end

        # Next Upper Moudule
        printf("@I:Next Upper Module\n")
        make_terminal(new_inst_inf,sig,con_db,connect_file_type,i,false)
      else
        # Save Data
#        @circuit_inf.add_connect(inst_inf.InstName+"."+sig.Name,connect_file_type,inst_inf.ModuleName,con,signal)
      end

    end
    return true
  end

  #
  # Get Connect TargetInstance
  #   ret : List of [module_name,instance_name]
  #
  private
  def get_ConnectTargetInstance(connect_file_type,connect_target)
    # MOD_CON/ADD_MOD_CON   : use Resovle Instance name from Module name 
    # INST_CON/ADD_INST_CON : get ModuleName at Instance

    # defined change path is Single Hier or Multi Hier
    connect_TargetInstance = Array.new
    connect_path = connect_target.split(".")
    instance_list = nil

    # Signle Hier
    if connect_path.size == 1
      # Get only from TOP_MODULE
      @INST_LIST[@TOP_MODULE] = XMLParse::get_InstanceList(@root,@TOP_MODULE) if @INST_LIST[@TOP_MODULE].nil?
      instance_list = @INST_LIST[@TOP_MODULE]
#      instance_list = XMLParse::get_InstanceList(@root,@TOP_MODULE)

      if connect_file_type == "MOD_CON" || connect_file_type == "ADD_MOD_CON"
        instance_list.each do |list|
          if list[0] == connect_target   # compare to Module name
            connect_TargetInstance << list
          end
        end
      else # INST_CON / ADD_INST_CON
        instance_list.each do |list|
          if list[1] == connect_target   # compare to Instance Name
            connect_TargetInstance << list
          end
        end
      end
      
    else # Multi Hier
      if connect_file_type == "MOD_CON" || connect_file_type == "ADD_MOD_CON"
        connect_TargetInstance = resolve_Hier_from_Module(connect_path)
      else # INST_CON / ADD_INST_CON
        connect_TargetInstance = resolve_Hier_from_Instance(connect_path)
      end
    end
    return connect_TargetInstance
  end

  #
  # Resolve Multi Hier from Instance
  #
  private
  def resolve_Hier_from_Module(connect_path)
    connect_TargetInstance = Array.new
    top_module = @TOP_MODULE
    connect_path.each do |each_module|
      @INST_LIST[top_module] = XMLParse::get_InstanceList(@root,top_module) if @INST_LIST[top_module].nil?
      instance_list = @INST_LIST[top_module]
#      instance_list = XMLParse::get_InstanceList(@root,top_module)
      instance_list.each do |list|
        target_instance = Array.new
        if list[0] == each_module   # compare to Instance Name
          if connect_TargetInstance == []
            connect_TargetInstance << list
          else
            connect_TargetInstance.each do |upper|
              upper0 = upper[0] + "." + list[0]
              upper1 = upper[1] + "." + list[1]
              target_instance << [upper0,upper1]
            end
            connect_TargetInstance = connect_TargetInstance +  target_instance if target_instance != []
          end
          top_module = list[0]
        end # if list[1] == each_inst
      end # instance_list.each do |list|
    end
    # Delete ignored data
    new_connect_TargetInstance = Array.new
    connect_TargetInstance.each do |list|
       new_connect_TargetInstance << list unless list[0].split(".").size != connect_path.size
    end
    return new_connect_TargetInstance
  end

  #
  # Resolve Multi Hier from Instance
  #
  private
  def resolve_Hier_from_Instance(connect_path)
    connect_TargetInstance = Array.new
    top_module = @TOP_MODULE
    connect_path.each do |each_inst|
# !NG!
#      @INST_LIST[top_module] = XMLParse::get_InstanceList(@root,top_module) if @INST_LIST[top_module].nil?
#      instance_list = @INST_LIST[top_module]
      instance_list = XMLParse::get_InstanceList(@root,top_module)
      instance_list.each do |list|
        if list[1] == each_inst   # compare to Module Name
          if connect_TargetInstance == []
            connect_TargetInstance << list
          else
            connect_TargetInstance.each do |upper|
              upper[0] = upper[0] + "." + list[0]
              upper[1] = upper[1] + "." + list[1]
            end
          end
          top_module = list[0]
        end
      end
    end
    return connect_TargetInstance
  end

  #
  # make ConstantValue
  #   param : sig - Signal Information
  #           value - Constant value
  #   ret   : Constant Value string in Verilog
  #
  private
  def make_ConstantValue(sig,value)
    if sig.MSB == nil && sig.LSB == nil
      return "1'b" + value.to_s
    else
      bit_width = (sig.MSB.to_i - sig.LSB.to_i).abs + 1
      str = bit_width.to_s + "'b"
      bit_width.times do 
        str = str + value.to_s
      end
      return str
    end
  end

  #
  # get ModulePath (convert from Instance-Path to Module-Path)
  #   param : isnt_path - Hier Path defined inst name
  #   ret : Hier Path at Module name
  #
  def get_ModulePath(connect_path)
    module_path = Array.new
    connect_path.each do |inst|
#      @INST_LIST[@TOP_MODULE] = XMLParse::get_InstanceList(@root,@TOP_MODULE) if @INST_LIST[@TOP_MODULE].nil?
#      instance_list = @INST_LIST[top_module]
      instance_list = XMLParse::get_InstanceList(@root,@TOP_MODULE)
      instance_list.each do |each_inst|
        if each_inst[1] == inst
          module_path << each_inst[0]
          break
        end
      end     
    end
    return module_path
  end

  #
  # Connect Check
  #   check bewteen base_sig and target_sig
  #  param : base_sig   - Base Signal Info
  #          target_sig - Target Conenct Signal Info
  private
  def connect_check(con_db,org_sig,base_sig,target_sig,target_wire,i)
    if org_sig != nil
      con = con_db.PIN_INF[org_sig.Name][i]
    else
      con = con_db.PIN_INF[base_sig.Name][i]
    end

    # There is no Target Port
    if target_sig == nil && target_wire == nil
      FMakeMessage.PrintError( :category => "CONNECT", :no => 218, :port_name => base_sig.Name, :con_file => con_db.CONNECT_FILE) if con == nil
      FMakeMessage.PrintError( :category => "CONNECT", :no => 221, :target_port => con.ConnectPort, :target_module => con.ConnectTarget, 
                               :con_file => con_db.CONNECT_FILE, :line_no => con.LineNo)
    elsif target_sig != nil
      # Mismatch Port Direction (input-input , output-output)
      if base_sig.Type == "input" && target_sig.Type == "input"
        FMakeMessage.PrintError( :category => "CONNECT", :no => 218, :port_name => base_sig.Name, :con_file => con_db.CONNECT_FILE) if con == nil
        FMakeMessage.PrintError( :category => "CONNECT", :no => 222, 
                                 :base_port => base_sig.Name, :base_module => con_db.MODULE_NAME, :base_direction => base_sig.Type, 
                                 :target_port => target_sig.Name, :target_module => con.ConnectTarget, :target_direction => target_sig.Type, 
                                 :con_file => con_db.CONNECT_FILE, :line_no => con.LineNo)
      end
      if base_sig.Type == "output" && target_sig.Type == "output"
        FMakeMessage.PrintError( :category => "CONNECT", :no => 218, :port_name => base_sig.Name, :con_file => con_db.CONNECT_FILE) if con == nil
        FMakeMessage.PrintError( :category => "CONNECT", :no => 222, 
                                 :base_port => base_sig.Name, :base_module => con_db.MODULE_NAME, :base_direction => base_sig.Type, 
                                 :target_port => target_sig.Name, :target_module => con.ConnectTarget, :target_direction => target_sig.Type, 
                                 :con_file => con_db.CONNECT_FILE, :line_no => con.LineNo)
      end
      # Mismatch Data Size
      if base_sig.Size != target_sig.Size
        FMakeMessage.PrintError( :category => "CONNECT", :no => 223, 
                                 :base_port => base_sig.Name, :base_module => con_db.MODULE_NAME, :base_size => base_sig.Size, 
                                 :target_port => target_sig.Name, :target_module => con.ConnectTarget, :target_size => target_sig.Size, 
                                 :con_file => con_db.CONNECT_FILE, :line_no => con.LineNo)
      end
    end
  end

  def get_path(connect_list)
    revised = Array.new
    connect_list.Path.each do |each_path|
      next if each_path.size == 1
      tmp2 = Array.new
      each_path.each do |path|
        tmp = Array.new
        tmp << path.InstName
        tmp << path.Name
        tmp2 << tmp
      end
      revised << tmp2
    end
    return  revised
  end

  #
  # Print Connect Information
  #
  public
  def print(file=nil)
    @circuit_inf.print
  end


  #
  # analyze
  #
  public
  def analyze_ConnectPath(generate_flag=true)
#    $VERBOSE = true
    connect_list = Hash.new
    # For Each Instance
    module_list = XMLParse::get_ModuleList(@root)

    # check TOP_MODULE
    if module_list.index(@TOP_MODULE).nil?
      FMakeMessage.PrintError( :category => "CONF", :no => 141, :top_module => @TOP_MODULE, :conf_file => @CONF_DB.CONF_FILE)
    end

    module_list.each do |current_module|
      XMLParse::update_ConnectData(@root,current_module)
    end

    @CONF_DB.INST.keys.each do |inst_name|
      printf("\n*[Inst]%s\n",inst_name) if $VERBOSE
      next if resolve_Hier_from_Instance(inst_name.split(".")) == nil
      next if resolve_Hier_from_Instance(inst_name.split("."))[0] == nil
      if inst_name !=  resolve_Hier_from_Instance(inst_name.split("."))[0][1]
        @CONF_DB.INST.delete("#{inst_name}")
        next
      end
      module_path = resolve_Hier_from_Instance(inst_name.split("."))[0][0]
      current_module = get_CurrentModule(module_path)
      top_module = nil
      if inst_name.split(".").size == 1
        top_module = @TOP_MODULE
      else
        tmp = module_path.split(".")
        tmp.pop
        top_module = @TOP_MODULE + "." + tmp.join(".")
      end
      connect_sig_list = Hash.new

      XMLParse::get_PortList(@root,current_module).each do |sig,value|
#        if $VERBOSE
          printf("==============================================\n")
          printf("[Search Point]%s.%s (direction:%s)\n",inst_name,sig,value.Type)
          printf("   - MODULE : %s\n",top_module)
          printf("   - INST PATH   : %s\n",inst_name)
#        end
        
        list = XMLParse::search_Connection(true,@root,top_module,inst_name,[sig,value],true,nil,nil,0,@CONF_DB.INST.keys)        

        if value.BusPortion != nil
          sig_name = inst_name + "." + sig + "[" + value.BusPortion.to_s + "]"
        elsif value.MSB != nil
          sig_name = inst_name + "." + sig + "[" + value.MSB.to_s + ":" + value.LSB.to_s + "]"
        else
          sig_name = inst_name + "." + sig
        end

        connect_list[[sig_name,value.Type]] = get_path(list,@CONF_DB.INST.keys)
        connect_sig_list[[sig,value.Type]] = get_path(list,@CONF_DB.INST.keys)
      end
      printf("\n")
=begin
      # make each report
      if generate_flag
        Common.make_dir("result")
        file = "result/" + inst_name + ".connect"
        f = open(file,"w")
        connect_sig_list = make_NeedPath(connect_sig_list)
        connect_sig_list.each do |sig,path|
          f.printf("-------------------------------------------------------\n")
          f.printf("%s [%s]\n",sig[0],sig[1])
          path.each do |each_path|
            f.printf("  %s\n",each_path)
          end
        end
        f.close
      end
=end
    end

    if generate_flag
      # Generate Connection report
      file_name =  @outdir + "/connection.report"
      f = open(file_name,"w")

      unless $TEST_MODE
        comment = "Analyze Report" 
        Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
      end

      f.print "\n# M:InstanceName,ModuleName\n\n"
      @CONF_DB.INST.each do |inst_name,inf|
        f.print "M:#{inf.InstName},#{inf.ModuleName}\n"
      end

      f.print "\n\n"
      f.print "# Connect Information\n\n"
      connect_list = make_NeedPath(connect_list)
      connect_list.each do |name,path|
        if path.size == 0
          case name[1]
          when "input"
            f.printf("%s <- No-Connect # [Check!] or Across the circuit ( not support to analyze now )\n",name[0])
          when "output"
            f.printf("%s -> OPEN\n",name[0])
          when "inout"            
            f.printf("%s <-> No-Connect\n",name[0])
          end
        else
          path.each do |each_path|
            wire_only_flag = false
            next if each_path.size == 0
            if @CONF_DB.INST.keys.index(each_path.last[0]) == nil && /#{@TOP_MODULE}/ !~  each_path.last[0] && /'b/ !~  each_path.last[1]  && /'h/ !~  each_path.last[1] 
              # Only Wire Connection
              if path.size != 1
                next
              else
                wire_only_flag = true
              end
            end
=begin
            if ( each_path.last[7] == nil && /#{@TOP_MODULE}/ !~  each_path.last[0]  && /'b/ !~  each_path.last[1]  && /'h/ !~  each_path.last[1] )
              # Only Wire Connection
              if path.size != 1
                next
              else
                wire_only_flag = true
              end
            end
=end

            # Terminal
            if each_path[0][3] == nil
              # Signle-Bit
              source = each_path[0][0] + "." + each_path[0][1]
            elsif each_path[0][5] != nil
              # Bus-Portion
              source = each_path[0][0] + "." + each_path[0][1] + "[" + each_path[0][5].to_s + "]"
            else
              # Bus-Bit
              source = each_path[0][0] + "." + each_path[0][1] + "[" + each_path[0][3].to_s + ":" +  each_path[0][4].to_s + "]"
            end

            if each_path.last[0] == nil
              distination = each_path.last[1]
            elsif  each_path.last[1] != nil
              distination = each_path.last[0] + "." + each_path.last[1]
            else
              distination = "OPEN"
            end

            if wire_only_flag
              case name[1]
              when "input"
                distination = "No-Connect # [Check!] or Across the circuit ( not support to analyze now )"
              when "output"
                distination = "OPEN # Or Distination Instance was not defined in Conf File"
              when "inout"            
                distination = "No-Connect"
              end

              # for PULLDOWN/PULLUP
              if /pulldown/ =~ each_path.last[0] ||  /pull_down/ =~ each_path.last[0]
                distination = "1'b0 # Connect PullDown Cell"
              end
              if /pullup/ =~ each_path.last[0] ||  /pull_up/ =~ each_path.last[0]
                distination = "1'b1 # Connect PullUp Cell"
              end
              
            else              
              if each_path.last[5] != nil 
                distination = distination + "[" + each_path.last[5].to_s + "]" if each_path.last[7] != nil && each_path.last[7] != 1
              elsif each_path.last[3] != nil
                distination = distination + "[" + each_path.last[3].to_s + ":" + each_path.last[4].to_s +  "]"
              end
              if each_path.last[0] == @TOP_MODULE
                distination = distination.sub(@TOP_MODULE + ".","")
                distination = distination + " [TOP Terminal]"
              end
            end

            case name[1]
            when "input"
              direction = "<-"
            when "output"
              direction = "->"
            when "inout"
              direction = "<->"
            end
            f.printf("%s %s %s\n",source,direction,distination)
          end
        end
      end
      f.close
    end
    
    return connect_list
  end

  private
  def get_CurrentModule(module_path)
    tmp = module_path.split(".")
    current_module = tmp.pop
    return current_module
  end

  private
  def make_NeedPath(connect_list)
    new_connect_list = Hash.new
    connect_list.each do |name,path|
      new_path = Array.new
      path.each_with_index do |each_path,i|        
        if path[i+1] != nil
          if (path[i+1] | each_path) != path[i+1]
            new_path << each_path
          end
        else
          new_path << each_path
        end
      end
      new_connect_list[name] = new_path
    end
    return  new_connect_list
  end

  #
  # Get Path from search_Connection Data
  #
  def get_path(connect_list,target_inst=nil)
    path = Array.new
    connect_list.Path.each do |each_path|

      if each_path.size == 1
=begin
        tmp2 = Array.new
        each_path.each do |path|
          tmp = Array.new
          tmp << path.InstName
          tmp << path.Name
          tmp << path.ConnectedWireName
          tmp << path.MSB
          tmp << path.LSB
          tmp << path.BusPortion
          tmp << path.PortBusPortion
          tmp << path.PortSize
          tmp2 << tmp
        end
        path << tmp2
=end
      else
        tmp2 = Array.new
        each_path.each do |path|
          tmp = Array.new
          tmp << path.InstName
          tmp << path.Name
          tmp << path.ConnectedWireName
          tmp << path.MSB
          tmp << path.LSB
          tmp << path.BusPortion
          tmp << path.PortBusPortion
          tmp << path.PortSize
          tmp2 << tmp
        end
        path << tmp2
      end
    end
    return  path
  end

  #
  # Analyze Logic Structure
  # 
  public
  def analyze_Hier(top=$TOP_MODULE)
    file_name =  @outdir + "/hier.txt"
    f = open(file_name,"w")
    
    @root = XMLParse.read("#{@XML_FILE}")
    # Top-Module
    f.printf("%s\n",top)
    get_InstanceList(f,@root,top)

    f.close
    return true
  end
  
  #
  # Get Instance List
  #
  private
  def get_InstanceList(f,doc,module_name,space=1)
    module_list =  XMLParse::get_InstanceList(doc,module_name)
    # Sub-Module
    module_list.each do |sub_module|
      next if /pull/ =~ sub_module[1]
      space.times do
        f.printf(" ")
      end
      f.printf("+%s(%s)\n",sub_module[1],sub_module[0])
      get_InstanceList(f,doc,sub_module[0],space+1)

    end
  end

end

