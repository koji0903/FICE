#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-

$:.unshift(File.dirname(__FILE__) + "/../lib")
$:.unshift(File.dirname(__FILE__) + "/../bin")
require "FICE_def"
require "system"
require "common"
require "optparse"
require "FMakeMessage"
require "FICE_DB"
require "FMakeVerilogList"
require "FMakeConf"
require "FMakeLogic"
require "FMakeFileControl"
require "fileutils"
require "pp"

#
# Global Setting
#
$TOOL            = "FICE"  # Envirment Name
$SUB_TOOL        = "FMake" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
Version          = $VERSION if Version.nil? # For OptParse

$TOP_MODULE = nil
$AUTO_REFLECT = true # AUTO REFLECT

$TOP_XML_FILE = nil
$TEST_MODE = false

####################################################################################
#== FPGA-ICE Development Support Tool 
#    Generate Verilog-HDL modified for FPGA-ICE
#
#Authors::   Koji HIJIKURO<koji.hijikuro.rj@rms.renesas.com>
#Copyright:: Copyright (c) 2011 Renesas MicroSystems. All rights reserved.
#
#=== Notice
# Support Ruby-1.9.3 only
#
#=== Usage
#
# %FMake.rb [OPTION]
#  [OPTION]
#    --help                  : Print Help Message
#    --version               : Print Version Message
#    --verbose               : Execute under Verbose-Mode
#
#    --print_env             : Print FMake Environment
#
#    --startup [VerilogList] : Execute Startup-Mode
###    --bb [Conf file]        : Execute BlackBox ( Analyze Circuit Information for Developer )
#    --top_module  [Modulename]  : Describe Analyzing Module, use under Startup-Mode
#    --product [ProdctName]  : Describe Product Name, use under Startup-Mode
#    --check  [Conf file]    : Execute Check-Mode ( Each Macro Version Check )
#    --config [Conf file]    : Execute Config-Mode ( Configuration Circuit for FPGA-ICE )
#    --analyze [Conf file]   : Execute Analyze-Mode ( Analyze Circuit Information for Developer )
#
#  If you want to get more information. plese use "--help" option.
#
#=== Example
# [Startup Mode] %FMake.rb --startup Product.list --module RL78TOP --product RL78-GXX --dev_ver DF1.0 (--ice_ver v001) (--add_modify_inst InstanceName)
# [Check Mode]   %FMake.rb --check RL78-GXX.conf
# [Config Modde] %FMake.rb --config RL78-GXX.conf
#
#
#=== Output
# Conf-file(*.conf) - Startup/Check
# Verilog-HDL(*.v) - Config
# Report File(fmake.report)
#
####################################################################################
class FMake

  #
  # initialize method
  # 
  def initialize
    # For System
    @PrintEnv = false
    @Conformal = false

    # Verilog List File at Startup
    @VerilogListFile = nil
    # TopModule Name
    @TopModuleName = nil
    @ProductBase = "/design01/iecube_rl78/Products"
    # Product Name
    @ProductName = nil
    @DeviceName = nil
    # Device Version
    @DevVer = nil
    # ICE Version
    @ICEVer = nil
    # Add Modify Instance name( Array )
    @AddModifyInst = Array.new
    # Verilog Define
    @VerilogDefine = Array.new

    # Configuratio File
    @ConfFile = nil

    # Output Directory
#    @Outdir = "."
    @Outdir = Dir::pwd

    # Excution Mode (Startup/Check/Config)
    @Startup = false
    @BlackBox = false
    @Check = false
    @Config = false
    @Analyze = false
    @MODE = nil
    @ModuleList = nil

    @TOP_MODULE = nil
    
    @HardMacroList = Array.new
  end

  #
  # Initial Setting
  #
  public
  def init_setting
    # Set Gem HOME
    ENV["GEM_HOME"] = $GEM_HOME_PATH
  end


  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  public
  def get_argument
    opt = OptionParser.new
    begin
      # For System
      opt.on('--verbose',"execute under verbose mode"){|v| $VERBOSE = true}
      opt.on('--test',"execute under test mode"){|v| $TEST_MODE = true}
      opt.on('--print_env',"Print FMake Environment Variables"){|v| @PrintEnv = true}
      opt.on('--outdir [Dir name]','output directory name'){|v| 
        @Outdir = Common.resolve_FullPath(v)
      }

      # For Startup-Mode
      opt.on('--startup [VerilogListFile]','VerilogListFile defined all Verilog-HDL at Product. ex) RL78-G13_DF1.0.list'){|v| @Startup = true;@VerilogListFile = v}
      opt.on('--top_module  [Top-ModuleName]','TopModuleName at Product. ex) D78XXXX'){|v| @TopModuleName = v}
      opt.on('--product_base [ProductBase]','ProductBase at Product. ex) G13'){|v| @ProductBase = v }
      opt.on('--product [ProductName]','ProductName at Product. ex) G13'){|v| 
        @ProductName = v
        @DeviceName = v
      }
      opt.on('--device [DeviceName]','DeviceName at Product. ex) G13'){|v| 
        @ProductName = v
        @DeviceName = v
      }
      opt.on('--dev_ver [Device Ver]','Device Version. ex) DF1.0,CF1.0'){|v| @DevVer = v}
      opt.on('--ice_ver [ICE Ver(Opt)]','ICE Version. ex) rev001'){|v| @ICEVer = v}
      opt.on('--add_modify_inst [Instance Name(Opt)]','Upper-Instance Name you want to modify Circuit additionally. ex) socket'){ |v| 
        @AddModifyInst += v.gsub("+","*").split(",")
      }
      opt.on('--pin  [Pin-SDC]','SDC File for Pin Location Constraint'){|v| @SDCFile = v}
      opt.on('--disenable_auto_reflect','disenable auto feflect function'){|v| $AUTO_REFLECT = false}
      opt.on('--conformal','generate Conformal Files( valid Startup-Mode only )'){|v| @Conformal = true}

#      # For Analyze-Mode
#      opt.on('--bb [FMake-Conf File]','Configuration file for FMake. ex) RL78-G13_DF1.0.conf'){|v| @BlackBox = true; @ConfFile = v}

      # For Check-Mode
      opt.on('--check [FMake-Conf File]','Configuration file for FMake. ex) RL78-G13_DF1.0.conf'){|v| @Check = true; @ConfFile = v}

      # For Config-Mode
      opt.on('--config [FMake-Conf File]','Configuration file for FMake. ex) RL78-G13_DF1.0.conf'){|v| @Config = true; @ConfFile = v}

      # For Analyze-Mode
      opt.on('--analyze [FMake-Conf File]','Configuration file for FMake. ex) RL78-G13_DF1.0.conf'){|v| @Analyze = true; @ConfFile = v}

      opt.parse(ARGV)
    rescue
      FMakeMessage.PrintError( :category => "OPT", :no => 2, :all_opt => ARGV.join(" "))
      return false
    end
    print_env if @PrintEnv

    if ARGV == []
      ARGV << "--help"
      opt.parse(ARGV)
    end

    # Judenment Execute Mode (Startup/Check/Config)
    judgment_mode

    return true
  end
  

  #
  # Jugement Execution Mode
  #
  private
  def judgment_mode
    if @Startup == true && @Check == false && @Config == false && @Analyze == false && @BlackBox == false
      @MODE = "Startup"
    elsif @Startup == false && @Check == true && @Config == false && @Analyze == false && @BlackBox == false
      @MODE = "Check"
    elsif @Startup == false && @Check == false && @Config == true && @Analyze == false && @BlackBox == false
      @MODE = "Config"
    elsif @Startup == false && @Check == false && @Config == false && @Analyze == true && @BlackBox == false
      @MODE = "Analyze"
    elsif @Startup == false && @Check == false && @Config == false && @Analyze == false && @BlackBox == true
      @MODE = "BlackBox"
    else
      # Error
      FMakeMessage::PrintError( :category => "OPT", :no => 1, :param => ARGV.join(" "))
    end
    # Error Check for Other Argument
    error_check
  end

  #
  # Argument Error Check
  #
  private
  def error_check
    # Mode
    case @MODE
    when "Startup"
      # VerilogListFile Check( readable? )
      check_readable("VerilogListFile",@VerilogListFile)
      # Other need option [--module/--product/--dev_ver/(--ice_ver)/(--add_modify_inst)]
      check_described("TopModuleName","top_module",@TopModuleName)
      check_described("ProductName","product",@ProductName)      
      check_described("DeviceVersion","dev_ver",@DevVer)      
    when "Check", "Config", "Analyze", "BlackBox"
      # Conf File Check( readable? )
      check_readable("ConfFile",@ConfFile)
    end
  end

  # Check Describe ( If not described, Error and Exit )
  def check_described(str,opt,param)
    if opt == nil
      FMakeMessage::PrintError( :category => "OPT", :no => 4, :param => str, :all_opt => ARGV.join(" "), :mode => @MODE) if param.nil?
    else
      FMakeMessage::PrintError( :category => "OPT", :no => 5, :param => str, :need_opt => opt, :all_opt => ARGV.join(" "), :mode => @MODE) if param.nil?
    end
  end

  # Check File Readable ( If not readable, Error and Exit )
  def check_readable(str,param)
    check_described(str,nil,param)
    FMakeMessage::PrintError( :category => "OPT", :no => 3, :file => param, :opt => ARGV.join(" "), :mode => @MODE) unless FileTest::readable?(param)
  end

  #
  # Operation
  #
  private
  def operation
    printf("@I:%s execute \"%s\" mode.\n",$SUB_TOOL,@MODE)
    case @MODE
    when "Startup"
      startup_mode
    when "Check"
      check_mode
    when "Config","BlackBox"
      config_mode
    when "Analyze"
      analyze_mode
    end
    return true
  end

  #
  # Print FMake Env
  #  - Print FMake Environment Variable, Program Exit after execute.
  def print_env
    FICE_DB::print_env
    exit
  end


  #
  # Operation for Starup Mode
  #   Func : Read VerilogListFile
  #          Analyze Circuit
  #          Generate Conf File
  #
  def startup_mode
    # Get InstanceList
    if @ICEVer == nil
      xml_file = @ProductName + "_" + @DevVer + ".xml"
      html_file = @ProductName + "_" + @DevVer + ".html"
      verilog_file = @ProductName + "_" + @DevVer + ".v"
    else
      xml_file = @ProductName + "_" + @DevVer + "_" + @ICEVer + ".xml"
      html_file = @ProductName + "_" + @DevVer + "_" + @ICEVer + ".html"
      verilog_file = @ProductName + "_" + @DevVer + "_" + @ICEVer + ".v"
    end
    list = get_InstanceList(@AddModifyInst,
                            :xml_file => xml_file,
                            :html_file => html_file,
                            :top_module => @TopModuleName
                            )
    
    # Generate Conf File
    if FileTest::directory?(@Outdir) == false
      Dir::mkdir(@Outdir)
    end
    conf_file = @ProductName + ".conf"
    fmake_conf = FMakeConf.new( 
                               :filename      => conf_file,
                               :outdir        => @Outdir,
                               :product_base  => @ProductBase,
                               :product_name  => @ProductName,
                               :product_ver   => @DevVer,
                               :ice_ver       => @ICEVer,
                               :top_module    => @TopModuleName,
                               :verilog_list  => Common.resolve_FullPath(@VerilogListFile),
                               :verilog_list_old => nil,
                               :add_modify_inst => @AddModifyInst,
                               :verilog_define => @VerilogDefine,
                               :hard_macro => @HardMacroList
                                )
    enable_mod = fmake_conf.generate(list,@ModuleList)
    fmake_conf.AUTO_REMOVE_MACRO
    if @Conformal
      # Generate Conformal Files
      outdir = @Outdir + "/conformal"
      Common.make_dir(outdir,1)
      #    list = FMakeFileControl::make_FileName(outdir,@ProductName,@DevVer,@ICEVer,".list")
      #    conf_file = FMakeFileControl::make_FileName(outdir,@ProductName + "_ICE",@DevVer,@ICEVer,".conf")
      #    sh = outdir + "/00run_conformal.sh"
      printf("@I:generate Conformal files in %s directory\n",outdir)    
      FMakeFileControl::Conformal.generate_GoldenList(outdir,@VerilogListFile,fmake_conf.AUTO_REMOVE_MACRO+fmake_conf.AUTO_REPLACE_MACRO)
      FMakeFileControl::Conformal.generate_RevisedList(outdir,verilog_file,fmake_conf.AUTO_REMOVE_MACRO+fmake_conf.AUTO_REPLACE_MACRO)
      FMakeFileControl::Conformal.generate_DoFile(outdir)
      FMakeFileControl::Conformal.generate_Sh(outdir,enable_mod,fmake_conf.AUTO_REMOVE_MACRO+fmake_conf.AUTO_REPLACE_MACRO)
    end

    return true
  end

  #
  # Operation for Check Mode
  #
  def check_mode
    # Read Conf File
    conf_db = FMakeConf.new( 
                            :conffile      => @ConfFile,
                            ).analyze

    # Get InstanceList
    @ICEVer = conf_db.ICE_VER
    @ProductBase =  conf_db.ProductBase
    @ProductName =  conf_db.PRODUCT    
    @DevVer = conf_db.PRODUCT_VER
    @AddModifyInst = conf_db.ADD_MODIFY_INST
    @TopModuleName = conf_db.TOP_MODULE
    @VerilogListFile = conf_db.VERILOG_LIST
    if @ICEVer == nil
      xml_file = @ProductName + "_" + @DevVer + ".xml"
      html_file = @ProductName + "_" + @DevVer + ".html"
    else
      xml_file = @ProductName + "_" + @DevVer + "_" + @ICEVer + ".xml"
      html_file = @ProductName + "_" + @DevVer + "_" + @ICEVer + ".html"
    end
    list = get_InstanceList(@AddModifyInst,
                            :xml_file => xml_file,
                            :html_file => html_file,
                            :top_module => @TopModuleName
                            )
    p list
    exit

    # Check List File
    FMakeVerilogListCheck.new(
                              :new => conf_db.VERILOG_LIST,
                              :old => conf_db.VERILOG_LIST_OLD
                              ).check
=begin
    xml_tmp = ".tmp.xml"
    html_tmp = ".tmp.xml"
    @VerilogListFile = conf_db.VERILOG_LIST
    list  = get_InstanceList(@AddModifyInst,
                             :xml_file => xml_tmp,
                             :html_file => html_tmp,
                             :top_module => conf_db.TOP_MODULE
                             )
=end
    printf("@I:Not Implemente this function.\n")
    return true
  end

  #
  # Operation for Config Mode
  #
  def config_mode
    # Read Conf File
    conf_db = FMakeConf.new( 
                            :conffile      => @ConfFile,
                            ).analyze
    set_each_data(conf_db)

    # Make output dir
    if FileTest::directory?(@Outdir) == false
      Dir::mkdir(@Outdir,0777)
    end

    html = FMakeFileControl::make_FileName(@Outdir,@ProductName,@DevVer,@ICEVer,"_hier.html")
#    xml = FMakeFileControl::make_FileName(nil,@ProductName,@DevVer,@ICEVer,"_org.xml")
    xml = FMakeFileControl::make_FileName(nil,@ProductName,@DevVer,@ICEVer,".xml")

    # Generate XML
    xml_file = generate_xml_html(@TopModuleName,xml,html)
    set_each_data(conf_db)

    # Modify XML defined by conf_db
    @VerilogDefine = @VerilogDefine.uniq
    logic = FMakeLogic.new( :top_module => @TopModuleName,
                            :xml => xml_file, 
                            :conf => conf_db,
                            :outdir => @Outdir,
                            :verilog_define => @VerilogDefine
                            ).main(@MODE)


    xml = FMakeFileControl::make_FileName(@Outdir,@ProductName,@DevVer,@ICEVer,"_ICE.xml")
    verilog = FMakeFileControl::make_FileName(@Outdir,@ProductName,@DevVer,@ICEVer,"_ICE.v")

    # Generate Verilog
    t1 = Thread.new do
      printf("To complete this process takes a long time. please wait.\n")
      FMakeFileControl::Verilog.generate_from_xml(xml,verilog,logic)
    end

    # print "." message while executing V2XML
    t2 = Thread.new do
      while 1 > 0
        printf "."
        sleep 3
      end
    end

    # wait for finishing V2XML
    t1.join
    Thread::kill(t2)

    # Generate Prj
    @TopModuleName = @TopModuleName + "_EVA" # Change Top ModuleName
    printf("\n")
    prj = FMakeFileControl::make_FileName(@Outdir,@ProductName,@DevVer,@ICEVer,".prj")
    FMakeFileControl::SynplifyPrj.generate(prj,@TopModuleName,conf_db,@VerilogDefine)

    # Generate Files for Analyze
    outdir = @Outdir + "/analyze_ICE"
    Common.make_dir(outdir,1)
    list = FMakeFileControl::make_FileName(outdir,@ProductName,@DevVer,@ICEVer,".list")
    conf_file = FMakeFileControl::make_FileName(outdir,@ProductName + "_ICE",@DevVer,@ICEVer,".conf")
    sh = outdir + "/00run_Analyze_ICE.sh"
    FMakeFileControl::Analyze.generate_Conf(conf_file,list,conf_db)
    FMakeFileControl::Analyze.generate_Sh(sh,conf_file)
    # Copy define File
    @VerilogDefine.each do |define|
      FileUtils.cp(define,outdir)
      def_file = outdir + "/" + File.basename(define) 
      FMakeFileControl::Analyze.generate_List(list,def_file,conf_db)
    end
    begin
      File.chmod(0777,sh)
    rescue
    end
    
    return true
  end
  
  #
  # Operation for Config Mode
  #
  def analyze_mode
    # Read Conf File
    conf_db = FMakeConf.new( 
                            :conffile      => @ConfFile,
                            ).analyze
    set_each_data(conf_db)

   #                            :xml_file => @ProductName + "_" + @DevVer + ".xml",
    xml = FMakeFileControl::make_FileName(nil,@ProductName,@DevVer,@ICEVer,".xml")
    # Generate XML
    xml_file  = generate_xml_html(@TopModuleName,xml)
    
    # Make output dir
    if FileTest::directory?(@Outdir) == false
      Dir::mkdir(@Outdir,0777)
    end
    # Analyze Connection
    t1 = Thread.new do
      printf("@I:analyze All Connections. It takes long time. Please wait.\n")
      $TOP_MODULE = @TopModuleName
      FMakeLogic.new( :top_module => @TopModuleName,
                      :xml => xml_file, 
                      :outdir => @Outdir,
                      :conf => conf_db,
                      :verilog_define => @VerilogDefine
                      ).analyze_ConnectPath
    end
    # Analyze Hier
    t2 = Thread.new do
      printf("@I:analyze Hierarchy. It takes long time. Please wait.\n")
      $TOP_MODULE = @TopModuleName
      FMakeLogic.new( :top_module => @TopModuleName,
                      :xml => xml_file, 
                      :outdir => @Outdir,
                      :conf => conf_db,
                      :verilog_define => @VerilogDefine
                      ).analyze_Hier
    end


    # print "." message while executing FMakeLogic.analyze
    t3 = Thread.new do
      while 1 > 0
        printf "."
        sleep 3
      end
    end

    t1.join
    t2.join
    Thread::kill(t3)

    return true
  end
  
  #
  # get Instance List from VerilogList
  #  ret : Instance List
  def get_InstanceList(add_modify_inst,inf)
    xml_base = inf[:xml_file]
    top_module = inf[:top_module]

    # Generate XML and HTML
#    xml_file  = generate_xml_html(top_module,xml_base,html_base)
    xml_file  = generate_xml_html(top_module,xml_base)
    # Get Instance List
    root = XMLParse.read(xml_file)
    @HardMacroList = XMLParse::delete_HardMacro(root)
    list = get_InstanceList_each(root,top_module)
    if list == []
      # Not found Top Module
      FMakeMessage::PrintError( :category => "FILE", :no => 22, :module => top_module)
    end    
    @TOP_MODULE = top_module
    add_modify_inst.uniq.each do |target_inst|
      list_tmp = Array.new
      r_target_inst = target_inst.gsub("*",".*")
      list.each do |each_inst|
        if each_inst[1] != target_inst && /^#{r_target_inst}$/ !~ each_inst[1]
          list_tmp << each_inst 
        else
          each_inst << "CommentOut"
          list_tmp << each_inst
          printf("@I:delete \"%s\" at Instance Inf in Conf File.\n",each_inst[1])
        end
      end
      list = list_tmp # update
      next_flag = false
      list.each do |each_inst|
        new_inst_name = each_inst[1].sub(/\d+/,"*")
        next_flag = true if each_inst[1] == target_inst
        next_flag = true if new_inst_name == target_inst
      end
      if next_flag
        printf("@I:add Modify Instance(%s)\n",target_inst)
        list += get_InstanceList_each(root,top_module,target_inst)
      else
        $WARNING_CNT += 1
        FMakeMessage.PrintWarning( :category => "OPT", :no => 300, :modify_inst => target_inst)
      end
    end if @AddModifyInst != nil
    return list
  end

  #
  # Get Instance List each target module
  #
  private
  def get_InstanceList_each(root,module_name,inst_path=nil,expand=false)
    printf("ModuleName : %s\n",module_name)
    printf("InstPath   : %s\n",inst_path)    
    add_list = Array.new
    if inst_path == nil
      # Get Instance List Under Top Module
      inst_list = XMLParse::get_InstanceList(root,module_name)
    else
      # Get Instance List Under inst_path( defined "--add_modify_inst" option )
      inst_path_a = inst_path.split(".")
      match_flag = true
      inst_path_a.each do |each_inst|
        inst_list = XMLParse::get_InstanceList(root,module_name)
        match_flag = false
        add_flag = false
        # for Regexp
        r_each_inst = each_inst.gsub("*",".*")
        inst_list.each do |inst|
          if each_inst == inst[1]
            module_name = inst[0]
            inst_list = XMLParse::get_InstanceList(root,module_name)
            match_flag = true
          elsif /^#{r_each_inst}$/ =~ inst[1]
            r_each_inst_tmp = r_each_inst.gsub(".*","\\*")
            inst_path_tmp = inst_path.sub(/#{r_each_inst_tmp}/,inst[1])
            printf("@I:add Modify Instance(%s)\n",inst_path)
=begin
            if resolve_Hier_from_Instance(root,inst_path.split("."))[0][1] != inst_path
              p "::::::::::::::::::::::::::::::::::::::::::::::::::"
              p resolve_Hier_from_Instance(root,inst_path.split("."))[0][1]
              p inst_path
              #        exit
              return []
            end
=end
            add_list += get_InstanceList_each(root,module_name,inst_path_tmp,true)
            add_flag = true
          end
        end
        unless match_flag
          inst_list = []
#          printf("@W:Cannot find Instance List in %s\n",module_name)
        end
        if add_flag
          return add_list
        end
      end 
    end
    inst_list.each do |each_inst|
      if inst_path != nil
        each_inst[1] = inst_path + "." + each_inst[1]
      end
    end unless inst_list == []
    return inst_list
  end

  #
  # Resolve Multi Hier from Instance
  #
  private
  def resolve_Hier_from_Instance(root,connect_path)
    connect_TargetInstance = Array.new
    top_module = @TOP_MODULE
    connect_path.each do |each_inst|
      instance_list = XMLParse::get_InstanceList(root,top_module)
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
  # Gnerate XML and HTML
  #
  private
  def generate_xml_html(top_module,xml_base,html_base=nil)
    # Generate XML
    verilog_list = FMakeVerilogList.new( :filelist => @VerilogListFile,
                                         :xml_base => xml_base,
                                         :product => @ProductName,
                                         :dev_ver => @DevVer,
                                         :ice_ver => @ICEVer,
                                         :outdir  => @Outdir
                                         )
    xml_file = generate_xml(verilog_list,xml_base)
    @ModuleList = verilog_list.ModuleList
#    @VerilogDefine = verilog_list.v2xml_define_base
    @VerilogDefine << File.expand_path(verilog_list.v2xml_define)
    # Generate HTML
#    FMakeFileControl::HTML::generate(top_module,verilog_list,html_base) if html_base != nil  
    return xml_file 
  end
  
  #
  # Generate XML using FMakeVerilogList
  #
  private
  def generate_xml(verilog_list,xml)
    # Analyze VerilogList
    return  verilog_list.analyze_VerilogList
  end

  #
  # Set Each data to Global Variables
  #
  def set_each_data(conf_db)
    # Get Each Data
    @TopModuleName = conf_db.TOP_MODULE
    @VerilogListFile =  conf_db.VERILOG_LIST
    @ProductName = conf_db.PRODUCT
    @DevVer = conf_db.PRODUCT_VER
    @ICEVer = conf_db.ICE_VER 
    if conf_db.VERILOG_DEFINE != nil
      @VerilogDefine << File.expand_path(conf_db.VERILOG_DEFINE)
      # File Check
      unless FileTest.readable?( conf_db.VERILOG_DEFINE)
        # ERROR and EXIT
        FMakeMessage::PrintError( :category => "FILE", :no => 21, :param => @VerilogDefine )
      end
    end
  end
  

  #
  # Main Function
  #
  public
  def main
    #  1. Print Base Meesage in standard output 
    Common.print_base
    #  2. Initial Setting
    init_setting
    #  3. Get Argument & Error Check for Argument
    get_argument
    #  4. Operation ( separate each mode )
    operation
    
    #  X. Print Summary and Finish Execute
    Common.print_summary
    if $ERROR_CNT == 0 && $INTERNAL_ERROR_CNT == 0
      exit 0
    else
      exit 1
    end
  end

end


if __FILE__ == $0
  fmake = FMake.new
  fmake.main
end
