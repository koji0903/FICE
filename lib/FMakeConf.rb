########################################################################
#
# FMake - generate Conf file
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
########################################################################
#
#  Class Name : FMakeConf
#  
#  [Input]
#    - 
#  [Output]
#    - FMake Conf file refledted Logic Analyze
# 
########################################################################
require 'FMakeCommonControl'
require 'XMLParse'
require 'MacroControl'
require 'conv'

#
# FMake Logic
#
class FMakeConf
  attr_accessor :AUTO_REMOVE_MACRO
  attr_accessor :AUTO_REPLACE_MACRO  
  
  class MacroList
    attr_accessor :Macro ,:Total_num
    def initialize
      @Macro = Hash.new
      @Total_num = 0
    end
    def add(category,inst,mod,local_connect)
      if @Macro[category].nil?
        @Macro[category] = [[inst,mod,local_connect]]
      else
        tmp = @Macro[category]
        tmp << [inst,mod,local_connect]
      end
      @Total_num += 1
    end
  end


  #
  # Initialize
  #  Param : file_name - Output Conf filename
  #          outdir    - Output Directory (default : current dir)
  #
  def initialize( setup )

    # for generate
    @outdir = "."

    @filename = setup[:filename]
    @outdir   = setup[:outdir] if setup[:outdir] != nil

    @product_base = setup[:product_base]
    @product_path = setup[:product_path]
    @product_name = setup[:product_name]
    @product_ver  = setup[:product_ver]
    @ice_ver  = setup[:ice_ver]
    @top_module   = setup[:top_module]
    @verilog_list = setup[:verilog_list]
    @verilog_list_old = setup[:verilog_list_old]
    @add_modify_inst = setup[:add_modify_inst]
    @verilog_define = setup[:verilog_define]
    @pin_sdc = setup[:pin_sdc]
    if @add_modify_inst != nil
      @add_modify_inst = @add_modify_inst.join(",")
    end
    @hardmacro = setup[:hard_macro]
    
    # for analyze
    if setup[:conffile] != nil
     @conffile = setup[:conffile]
      if FileTest.exist?(@conffile) == false
        FMakeMessage::PrintError( :category => "CONF", :no => 112, :conf_file => @conffile )
     end
    end

    common_path = FICE_DB::CommonPath.new
    @ice_macro_ver = common_path.get_ICEMacroVer
    @replace_macro_ver = common_path.get_ReplaceMacroVer
    @port_buffer_ver = common_path.get_PortBufferVer

    @time = Time.new

    @inst_scope = nil  # not nil : Instance name  between INS: and END_INS;
    @inst_scope_org = nil

    # For Macro Db
    @macro_db = FICE_DB::Macro.new( :db_file => "rl78_#{@product_name}.db" )

    @conf_db = nil

    @AUTO_REMOVE_MACRO = Array.new
    @AUTO_REPLACE_MACRO = Array.new

    @previous_comment = Array.new

    @List = MacroList.new

    # Link to Redmine
    @RedmineConnectURL = "http://nmpc3739.rms.renesas.com/redmine/projects/common/repository/connect/revisions/"
  end

  #
  # Generate Conf File
  #
  def generate(inst_list,module_list=nil)
    macro_list = Array.new # For MacroList.txt
    
    if $AUTO_REFLECT
      macro_control = MacroControl.new
      macro_control.get
    end
    
    # Make FileList
    file_list = Hash.new
    inst_list.each do |each_inst|
      mod_name = each_inst[0] 
      inst_name = each_inst[1]
      # Save FileList
      if module_list != nil
        if module_list[mod_name] != nil
          file_list[mod_name] = module_list[mod_name] 
        else
          file_list[mod_name] = "NONE"
        end
      end
    end

    file = @outdir + "/" + @filename
    printf("@I:Generate Conf File(%s).\n",file)
    f = open("#{file}","w")
    
    # file header message
    $SUB_TOOL = "FMake"
    Common.print_file_header(f, "Configuration file for FMake",$SUB_TOOL,$VERSION,"##")
    # Command line
    f.printf("# < Executed Command Line >\n")
    f.printf("# %s\n\n\n",ARGV.join(" "))
    # added message
    f.print <<EOB
#
# !!NOTICE!!\n#  Please modify following information to suit your product environment.
#

# Product Base
ProductBase: #{@product_base}
# Device Name
DeviceName: #{@product_name}
# Device Version
DeviceVer: #{@product_ver}
# Id Version
IdVer: #{@ice_ver}

# Circuit Information
TopModule: #{@top_module}

# Verilog List File
VERILOG_LIST: #{@verilog_list}
# Verilog List Old File ( only need check-mode )
VERILOG_LIST_OLD: #{@verilog_list_old}

# Pin SDC
PIN_SDC: #{@pin_sdc}

# Add Modify Instance List
ADD_MODIFY_INST: #{@add_modify_inst}

# Verilog Define ( affect on Add/Replace Macro )
VERILOG_DEFINE: #{@verilog_define[0]}

# Environment Setting (Initial Setting)


EOB

    macro_control.DIR.each do |key,value|
      /(\w+)/ =~ key
      key = $1
      f.printf "# #{value[0]}\n"
      f.printf "SET #{key}=#{value[2]}\n"
    end
    
    f.printf "\n"
    f.printf "# Local Setting File Path\n"
    f.printf "SET PP=${ProductBase}/${DeviceName}/ice/fmake/${DeviceVer}/${IdVer}/04_Config/local\n"
    f.printf "\n"

    f.print <<EOB

#
# <<< INF Inf Description Format >>>
# - KeepKeep : N0-Need add Information
#
# - KeepChange
# INS: <Instance Name> <Module Name> KeepChange
#   INST_CON: <INST_CON File Path>
# END_INS:
#
# - Replace
# INS: <Instance Name> <Module Name> Replace
#   MODULE_NAME: <Replace Module Name>
#   VERILOG_FILE: <Replace Verilog-DHL Path>
#   INST_CON: <INST_CON File Path>
# END_INS:
#
# - Add
# INS: <Instance Name> <Module Name> Add
#   VERILOG_FILE: <Add Verilog-DHL Path>
#   INST_CON: <INST_CON File Path>
# END_INS:
#
# - Remove
# INS: <Instance Name> <Module Name> Remove
# END_INS:
#

# --------------------------------------------
# Circuit Information
# --------------------------------------------

EOB

    # For Diff/Local Candidate Directory
    Common.make_dir("#{@outdir}",1)
    Common.make_dir("#{@outdir}/#{FICE_DB::DEVICE_DIFF}",1)
    Common.make_dir("#{@outdir}/#{FICE_DB::PRODUCT_PATH_AUTO}",1)
    local_Candidate_dir = @outdir + "/" + FICE_DB::PRODUCT_PATH_AUTO


    #
    # For Add Macro ( Automatic )
    #
    macro_control.MACRO.List.each do |mod|
      local_connect = "NONE"
      case mod.Category
      when "AD"
        f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
        f.printf "# [ AUTO Add ] ( Inst : #{mod.ICEInstance1} )\n"
        f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
        new_mod = mod.ICEModule1.gsub("XXX","#{@product_name}")
        f.printf "INS:\t#{mod.ICEInstance1}\t#{new_mod}\tTYPE\tAdd\n"
        @List.add("AUTO_Add",mod.ICEInstance1,new_mod,mod.LocalConnect1)
        if /XXX/ =~ mod.ICEHDL1
          print_local(f,"VERILOG_FILE",macro_control.resolve_SET(mod.ICEHDL1),local_Candidate_dir)
        else
          f.printf "  VERILOG_FILE: #{mod.ICEHDL1}\n"
        end

        if mod.CommonConnect1 != "NONE" && mod.LocalConnect1 != "NONE"
          f.printf "  INST_CON: #{mod.CommonConnect1}\n"
          print_local(f,"ADD_INST_CON",macro_control.resolve_SET(mod.LocalConnect1),local_Candidate_dir)
        elsif mod.CommonConnect1 != "NONE" && mod.LocalConnect1 == "NONE"
          f.printf "  INST_CON: #{mod.CommonConnect1}\n"
        elsif mod.CommonConnect1 == "NONE" && mod.LocalConnect1 != "NONE"
          print_local(f,"INST_CON",macro_control.resolve_SET(mod.LocalConnect1),local_Candidate_dir)
        end
        f.printf "END_INS:\n\n"
      end
    end
    
    # For Add For
    inst_list.each do |each_inst|
      mod_name = each_inst[0] 
      inst_name = each_inst[1]

      md5sum = Common.md5sum("#{file_list[mod_name]}")
      # Compare for MacroControl
      type,match_module,match_md5sum,match_inf,diff_file,regexp = macro_control.search_AF(file_list[mod_name],inst_name,mod_name,md5sum,@outdir + "/" + FICE_DB::DEVICE_DIFF )
      case type
      when "AF"
        f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
        if match_module && match_md5sum && !regexp
          str = "# [ AUTO Add for #{mod_name} ] Matched Add for #{mod_name}  ( Inst : #{match_inf.ICEInstance1} )"
        elsif match_module && match_md5sum && regexp
          str = "# [ AUTO Add for #{mod_name} (Regexp) ] Matched Add for #{mod_name} ( Inst : #{match_inf.ICEInstance1} )"
        elsif match_module
          str = "# [ Add for #{mod_name} CANDIDATE ] Not matched md5sum ( Matched Instance Name and Module Name ) ( Inst : #{match_inf.ICEInstance1} )"
        else
          str = "# [ Add for #{mod_name} CANDIDATE ] Matched neither md5sum nor Module Name( Matched Instance Name Only )  ( Inst : #{match_inf.ICEInstance1} )"
        end
        
        f.printf "#{str}\n"
        f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
        f.printf "INS:\t#{match_inf.ICEInstance1}\t#{match_inf.ICEModule1}\tTYPE\tAdd\n"
        f.printf "  VERILOG_FILE: #{match_inf.ICEHDL1}\n"
        print_connect(f,macro_control,match_inf,local_Candidate_dir)  
        f.printf "END_INS:\n\n"
        @List.add("AUTO_Add",match_inf.ICEInstance1,match_inf.ICEModule1,match_inf.LocalConnect1)
      end      
    end
    

    f.print <<EOB

# ---------- Device Instance Infomation ---------- #

EOB
    

    enable_mod = Array.new


    # For Device Macro
    inst_list.sort_by do |a|
      a[1]
    end.each do |each_inst|

      mod_name = each_inst[0] 
      inst_name = each_inst[1]
      comment = each_inst[2]

      # Save DB
      db_inst = inst_name.gsub("chiptop.","").gsub("chip.","")
      @macro_db.regist( :module_name => mod_name,
                        :inst_name => db_inst,
                        :product_name => @product_name,
                        :device_ver => @product_ver,
                        :ice_ver => @ice_ver
                        ) if ( mod_name != "TBCLH" && mod_name != "TBCLL" ) && (( /pull/ =~ db_inst) == nil )
      
      # Skip for pulldown/pullup module
      next if /pull/ =~ db_inst

      # Skip for

      if comment == "CommentOut"
        f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
        f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
        f.print <<EOB
#INS:\t#{inst_name}\t#{mod_name}\tTYPE\tKeepKeep\tEND_INS:\t# Comment Out ( add_modify_inst )

EOB
        @List.add("CommentOut",inst_name,mod_name,"NONE")
   else
        device_hdl = file_list[mod_name]
        printf "@I:Compare Macro Control - #{mod_name}(#{device_hdl})\n"

        md5sum = Common.md5sum("#{device_hdl}")
        # Compare for MacroControl
        type,match_module,match_md5sum,match_inf,diff_file,regexp = macro_control.search(device_hdl,inst_name,mod_name,md5sum,@outdir + "/" + FICE_DB::DEVICE_DIFF )
        case type
        when "KK"
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          if match_module && match_md5sum && !regexp
            str = "# [ AUTO KeepKeep ] Matched KeepKeep Macro ( Inst : #{inst_name} )"
            @List.add("AUTO_KeepKeep",inst_name,mod_name,match_inf.LocalConnect1)
          elsif match_module && match_md5sum && regexp
            str = "# [ AUTO KeepKeep (Regexp) ] Matched KeepKeep Macro ( Inst : #{inst_name} )"
            @List.add("AUTO_KeepKeep",inst_name,mod_name,match_inf.LocalConnect1)
          elsif match_module
            str = "# [ KeepKeep CANDIDATE ] Not matched md5sum ( Matched Instance Name and Module Name ) ( Inst : #{inst_name} )"
            @List.add("KeepKeep_CANDIDATE",inst_name,mod_name,match_inf.LocalConnect1)
          else
            str = "# [ KeepKeep CANDIDATE ] Matched neither md5sum nor Module Name( Matched Instance Name Only ) ( Inst : #{inst_name} )"
            @List.add("KeepKeep_CANDIDATE",inst_name,mod_name,match_inf.LocalConnect1)
          end
          f.printf "#{str}\n"
          f.printf "# DeviceHDL : #{device_hdl}\n"
          f.printf "# Diff      : #{diff_file}\n" unless diff_file.nil?
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          f.printf "INS:\t#{inst_name}\t#{mod_name}\tTYPE\tKeepKeep\tEND_INS:\n"
        when "KC"
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          if match_module && match_md5sum && !regexp
            str = "# [ AUTO KeepChange ] Matched KeepChange Macro ( Inst : #{inst_name} )"
            @List.add("AUTO_KeepChange",inst_name,mod_name,match_inf.LocalConnect1)
          elsif match_module && match_md5sum && regexp
            str = "# [ AUTO KeepChange (Regexp) ] Matched KeepChange Macro ( Inst : #{inst_name} )"
            @List.add("AUTO_KeepChange",inst_name,mod_name,match_inf.LocalConnect1)
          elsif match_module
            str = "# [ KeepChange CANDIDATE ] Not matched md5sum ( Matched Instance Name and Module Name ) ( Inst : #{inst_name} )"
            @List.add("KeepChange_CANDIDATE",inst_name,mod_name,match_inf.LocalConnect1)
          else
            str = "# [ KeepChange CANDIDATE ] Matched neither md5sum nor Module Name( Matched Instance Name Only ) ( Inst : #{inst_name} )"
            @List.add("KeepChange_CANDIDATE",inst_name,mod_name,match_inf.LocalConnect1)
          end
          f.printf "#{str}\n"
          f.printf "# DeviceHDL : #{device_hdl}\n"
          f.printf "# Diff      : #{diff_file}\n" unless diff_file.nil?
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          f.printf "INS:\t#{inst_name}\t#{mod_name}\tTYPE\tKeepChange\n"
          print_connect(f,macro_control,match_inf,local_Candidate_dir)
          f.printf "END_INS:\n"
        when "RE"
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          if match_module && match_md5sum && !regexp
            str = "# [ AUTO Replace ] Matched Replace Macro ( Inst : #{inst_name} )"
            @List.add("AUTO_Replace",inst_name,mod_name,match_inf.LocalConnect1)
          elsif match_module && match_md5sum && regexp
            str = "# [ AUTO Replace (Regexp) ] Matched Replace Macro ( Inst : #{inst_name} )"
            @List.add("AUTO_Replace",inst_name,mod_name,match_inf.LocalConnect1)
          elsif match_module
            str = "# [ Replace CANDIDATE ] Not matched md5sum ( Matched Instance Name and Module Name ) ( Inst : #{inst_name} )"
            @List.add("Replace_CANDIDATE",inst_name,mod_name,match_inf.LocalConnect1)
          else
            str = "# [ Replace CANDIDATE ] Matched neither md5sum nor Module Name( Matched Instance Name Only ) ( Inst : #{inst_name} )"
            @List.add("Replace_CANDIDATE",inst_name,mod_name,match_inf.LocalConnect1)
          end
          f.printf "#{str}\n"
          f.printf "# DeviceHDL : #{device_hdl}\n"
          f.printf "# Diff      : #{diff_file}\n" unless diff_file.nil?
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          f.printf "INS:\t#{inst_name}\t#{mod_name}\tTYPE\tReplace\n"
          f.printf "  MODULE_NAME: #{match_inf.ICEModule1}\n"
          f.printf "  VERILOG_FILE : #{match_inf.ICEHDL1}\n"
          print_connect(f,macro_control,match_inf,local_Candidate_dir)
          f.printf "END_INS:\n"
        when "AF"
          # Do Nothing ( Operated Other timing )
        when "SA"
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          if match_module && match_md5sum && !regexp
            str = "# [ AUTO SelectAdd ] Matched SelectAdd Macro ( Inst : #{inst_name} )"
            @List.add("AUTO_SelectAdd",inst_name,mod_name,match_inf.LocalConnect1)
          elsif match_module && match_md5sum && regexp
            str = "# [ AUTO SelectAdd (Regexp) ] Matched SelectAdd Macro ( Inst : #{inst_name} )"
            @List.add("AUTO_SelectAdd",inst_name,mod_name,match_inf.LocalConnect1)
          elsif match_module
            str = "# [ SelectAdd CANDIDATE ] Not matched md5sum ( Matched Instance Name and Module Name ) ( Inst : #{inst_name} )"
            @List.add("SelectAdd_CANDIDATE",inst_name,mod_name,match_inf.LocalConnect1)
          else
            str = "# [ SelectAdd CANDIDATE ] Matched neither md5sum nor Module Name( Matched Instance Name Only ) ( Inst : #{inst_name} )"
            @List.add("SelectAdd_CANDIDATE",inst_name,mod_name,match_inf.LocalConnect1)
          end
          f.printf "#{str}\n"
          f.printf "# DeviceHDL : #{device_hdl}\n"
          f.printf "# Diff      : #{diff_file}\n" unless diff_file.nil?
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          f.printf "INS:\t#{inst_name}\t#{mod_name}\tTYPE\tKeepKeep\tEND_INS:\n"
          f.printf "\n"
          f.printf "INS:\t#{match_inf.ICEInstance1}\t#{match_inf.ICEModule1}\tTYPE\tAdd\n"
          f.printf "  VERILOG_FILE : #{match_inf.ICEHDL1}\n"
          print_connect(f,macro_control,match_inf,local_Candidate_dir)
          f.printf "END_INS:\n"

        when "RM"
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          rm_module = nil
          rm_file = nil
          if match_module && match_md5sum && !regexp
            str = "# [ AUTO Remove ] Matched Remove Macro ( Inst : #{inst_name} )"
            @List.add("AUTO_Remove",inst_name,mod_name,match_inf.LocalConnect1)
            rm_module = match_inf.ICEModule1
            rm_file = match_inf.ICEHDL1
          elsif match_module && match_md5sum && regexp
            new_file = check_io(macro_control,mod_name,device_hdl,match_inf.ICEModule1,match_inf.ICEHDL1,local_Candidate_dir,regexp)
            if new_file == match_inf.ICEHDL1
              str = "# [ AUTO Remove (Regexp) ] Matched Remove Macro ( Inst : #{inst_name} )"
              @List.add("AUTO_Remove",inst_name,mod_name,match_inf.LocalConnect1)
              rm_module = match_inf.ICEModule1
              rm_file = match_inf.ICEHDL1
            else
              str = "# [ Remove CANDIDATE ] Not Matched IO Port Information( Matched Instance Name Only ) ( Inst : #{inst_name} )"
              @List.add("Remove_CANDIDATE",inst_name,mod_name,match_inf.LocalConnect1)
              rm_module = mod_name
              rm_file = new_file
            end
          elsif match_module
            str = "# [ Remove CANDIDATE ] Not matched md5sum ( Matched Instance Name and Module Name ) ( Inst : #{inst_name} )"
            @List.add("Remove_CANDIDATE",inst_name,mod_name,match_inf.LocalConnect1)
            new_file = check_io(macro_control,mod_name,device_hdl,match_inf.ICEModule1,match_inf.ICEHDL1,local_Candidate_dir)
            rm_module = mod_name + "_ICE"
            rm_file = new_file
          else
            str = "# [ Remove CANDIDATE ] Matched neither md5sum nor Module Name( Matched Instance Name Only ) ( Inst : #{inst_name} )"
            @List.add("Remove_CANDIDATE",inst_name,mod_name,match_inf.LocalConnect1)
            new_file = check_io(macro_control,mod_name,device_hdl,match_inf.ICEModule1,match_inf.ICEHDL1,local_Candidate_dir)
            rm_module = mod_name + "_ICE"
            rm_file = new_file
          end
          f.printf "#{str}\n"
          f.printf "# DeviceHDL : #{device_hdl}\n"
          f.printf "# Diff      : #{diff_file}\n" unless diff_file.nil?
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          f.printf "INS:\t#{inst_name}\t#{mod_name}\tTYPE\tReplace\n"
          f.printf "  MODULE_NAME: #{rm_module}\n"
          f.printf "  VERILOG_FILE: #{rm_file}\n"
#          print_connect(f,macro_control,match_inf,local_Candidate_dir)
          f.printf "END_INS:\n"
        when "PB"
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          # Check TTL Terminal
          con = nil
          port_file = macro_control.resolve_SET(match_inf.ICEHDL1)
          printf "@I:Check TTL terminal (#{port_file})\n"
          xml_file = "#{mod_name}.xml"
          if FileTest::readable?(port_file)
            result = `#{FICE_DB::V2XML} #{port_file} > #{xml_file}`
            if FileTest::readable?(xml_file)
              root = XMLParse.read("#{xml_file}")
              term = XMLParse::get_PortList(root,match_inf.ICEModule1).keys
              if term.index("PTTL") != nil
                /port(\d+)_iobuf\.iobuf(\d+)$/ =~ inst_name
                if $1 != nil && $2 != nil
                  port_base = $1
                  port_buf = $2
                  port_num = port_base + port_buf
                  con = "p" + port_num + ".con"
                  printf("@I:%s module have PTTL Port. So make Connect File for PTTL.\n",match_inf.ICEModule1)
                  con_file = open("#{@outdir}/#{FICE_DB::PRODUCT_PATH_AUTO}/#{con}","w")
                  con_file.printf <<EOB
#####################################################
#
# Generated by FMake
# - Connect PTTL Terminal
#
#  +-----#{"-"*port_base.size}------------#{"-"*port_buf.size}------+
#  | port#{port_base}_iobuf.iobuf#{port_buf}.PTTL |<-----o PTTL#{port_num} (TTL Buffer on ICE)
#  +-----#{"-"*port_base.size}------------#{"-"*port_buf.size}------+
#
#####################################################
PTTL\tPTTL#{port_num}:terminal

EOB
#                  con_file.printf("PTTL\tPTTL%s:terminal\n",port_num)
                  con_file.close
                end
              end
              FileUtils.rm("#{xml_file}") 
            end
          end
          
          if match_md5sum
            str = "# [ AUTO PortIOBuffer ] Matched Port IO Buffer Module ( Inst : #{inst_name} )"
            @List.add("AUTO_PortIOBuffer",inst_name,mod_name,match_inf.LocalConnect1)
          else
            str = "# [ PortIOBuffer CANDIDATE ] Not matched md5sum ( Matched Port IO Buffer Module ) ( Inst : #{inst_name} )"
            @List.add("PortIOBuffer_CANDIDATE",inst_name,mod_name,match_inf.LocalConnect1)
          end
          f.printf "#{str}\n"
          f.printf "# DeviceHDL : #{device_hdl}\n"
          f.printf "# Diff      : #{diff_file}\n" unless diff_file.nil?
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          f.printf "INS:\t#{inst_name}\t#{mod_name}\tTYPE\tReplace\n"
          f.printf "  MODULE_NAME: #{match_inf.ICEModule1}\n"
          f.printf "  VERILOG_FILE: #{match_inf.ICEHDL1}\n"
          f.printf "  INST_CON: ${PP}/#{con}\n" unless con.nil?
          f.printf "END_INS:\n"
        else
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          str = "# [ NOT Matched MacroControl ] ( Inst : #{inst_name} )"
          @List.add("NOT_Matched_MacroControl",inst_name,mod_name,"NONE")
          f.printf "#{str}\n"
          f.printf "# DeviceHDL : #{device_hdl}\n"
          f.printf "# Diff      : #{diff_file}\n" unless diff_file.nil?
          f.printf "#-----------------------------------------------------------------------------------------------------------------------------------\n"
          f.printf "INS:\t#{inst_name}\t#{mod_name}\tTYPE\tKeepKeep\tEND_INS:\n"
        end
        f.printf "\n"
      end
 
    end
    
    f.print <<EOB

################################
# END OF CONF FILE
################################

EOB
    
    f.close
    
    
    printf "@I:HardMacro Pick Up\n"
    @hardmacro.each do |mod_name|
      printf " - #{mod_name} : #{module_list[mod_name]}\n"
      @AUTO_REMOVE_MACRO << [mod_name,module_list[mod_name]]
    end

    #--------------------------------------------------------
    # Generate HDLList
    #--------------------------------------------------------
    file = @outdir + "/" + "HDLList.txt"    
    printf("@I:Generate File(%s).\n",file)
    f = open("#{file}","w")
    f.print <<EOB

################################
# MODULE NAME : VERILOG HDL Path
################################

EOB

    file_list.sort_by do |key|
      key
    end.each do |mod_name,file_name|
      f.printf("%-25s : %s,%s\n",mod_name,file_name,Common.md5sum(file_name).to_s)
      @macro_db.update(
                       :module_name => mod_name,
                       :file_name => file_name,
                       :product_name => @product_name,
                       :device_ver => @product_ver,
                       :ice_ver => @ice_ver
                       )
    end
    f.printf("\n")
    f.close
    
    
    #--------------------------------------------------------
    # Generate MacroList
    #--------------------------------------------------------
    file = @outdir + "/" + "MacroList.txt"
    printf("@I:Generate File(%s).\n",file)
    f = open("#{file}","w")

    f.printf <<EOF

h2. Judgment Criteria 

* "-" : No need to check
** Case 1 : AUTO category & No Local Connect
** Case 2 : CommentOut
* Other : Need to check

h2. Each Macro Information

EOF
    
    # Set Instance Variable
    @List.Macro.each_key do |key|
      @List.instance_variable_set("@#{key}_num",0)
      @List.class.__send__(:attr_accessor, "#{key}_num")
    end
    
    # Set Size
    @List.Macro.each do |key,value|
      @List.instance_variable_set("@#{key}_num", value.size)
    end

    @List.Macro.sort_by do |key|
      key
    end.each do |key,value|
      key_num = @List.instance_variable_get("@#{key}_num")
      f.printf "h3. #{key} (#{key_num}/#{@List.Total_num})\n"
      f.printf "\n"
      f.printf "|No|Instance Name|Module Name|Local Connect|Judgement|\n"
      value.sort_by do |inf|
        inf[0]
      end.each_with_index do |inf,i|
        connect_url = nil
        if inf[2].nil?
          inf[2] = "NONE" 
        elsif /Local/ =~ inf[2]
          base = inf[2].split("/")[0]
          # Execept ${PP} Path. ${PP} Path is ProductPath files
          if /\{FC\}/ =~ base
            local_connect_ver = macro_control.DIR["#{base}"][2].split("/").last
            connect_url = @RedmineConnectURL + local_connect_ver + "/entry/Local"
          end
        end

        check = ""
        case key
        when /AUTO/
          if inf[2] == "NONE"
            check = "---"
          end
        when /CommentOut/
            check = "---"
        end
        if connect_url.nil?
          f.printf "|#{i+1}|#{inf[0]}|#{inf[1]}|#{inf[2]}|#{check}|\n"
        else
          file_name = File.basename(inf[2])
          f.printf "|#{i+1}|#{inf[0]}|#{inf[1]}|\"#{inf[2]}\":#{connect_url}/#{file_name}|#{check}|\n"
        end
      end
      f.printf "\n\n"
    end
    f.close

    return enable_mod.uniq

  end

  def print_connect(f,macro_control,match_inf,local_Candidate_dir)
    if match_inf.CommonConnect1 != "NONE" && match_inf.LocalConnect1 != "NONE" 
      f.printf "  INST_CON: #{match_inf.CommonConnect1}\n" 
      print_local(f,"ADD_INST_CON",macro_control.resolve_SET(match_inf.LocalConnect1),local_Candidate_dir)
    elsif match_inf.CommonConnect1 == "NONE" && match_inf.LocalConnect1 != "NONE"
      print_local(f,"INST_CON",macro_control.resolve_SET(match_inf.LocalConnect1),local_Candidate_dir)
    elsif match_inf.CommonConnect1 != "NONE" && match_inf.LocalConnect1 == "NONE"
      f.printf "  INST_CON: #{match_inf.CommonConnect1}\n"
    end
  end

  #
  # Print local
  #  - Copy local connect/hdl file to local dir
  #  - move file name
  # 
  def print_local(f,conf_str,local_file,local_Candidate_dir)
    local_file_org = local_file
    local_file = File.basename(local_file)
    if /XXX/ =~ local_file
      local_file = File.basename(local_file)
      local_file = local_file.gsub("XXX","#{@product_name}")
    end
#    if /iead/ !~ local_file && /FixedPin/ !~ local_file
    if /FixedPin/ !~ local_file && /PUCTL/ !~ local_file
      local_file = local_file.gsub("\.","_TMP\.")
    end

    if File.readable?(local_file_org)
      if File.extname(local_file_org) != ".v"
        FileUtils.cp(local_file_org,local_Candidate_dir + "/" + local_file)        
      else
        data = Array.new
        contents = Conv.new(local_file_org).main
        contents.split("\n").each do |line|
          if /_XXX/ =~ line
            line = line.gsub("XXX",@product_name)
          end
          data << line
        end
        out_file = local_Candidate_dir + "/" + local_file
        new_file = open("#{out_file}","w")
        data.each do |line|
          new_file.printf("#{line}\n")
        end
        new_file.close
    end

    end
    local_file = local_file.gsub(@product_name,"${DeviceName}")
    f.printf "  #{conf_str}: ${PP}/#{local_file}\n"
  end

  #
  # Check io
  # 
  def check_io(macro_control,device_mod,device_hdl,db_mod,db_hdl,local_dir,regexp=false)
    device_term_inf = nil
    db_term_inf = nil

    # Device Infomation
    device_term_inf = get_PortInf(device_mod,device_hdl) unless device_hdl == "NONE"
    # DB Information
    db_term_inf = get_PortInf(db_mod,macro_control.resolve_SET(db_hdl)) unless macro_control.resolve_SET(db_hdl) == "NONE"

    if device_hdl == "NONE" 
      filename = db_hdl
      FMakeMessage.PrintWarning( :category => "Conf", :no => 400, :mod => device_mod)
    elsif regexp && ( device_term_inf.keys == db_term_inf.keys )
      printf "  - Matched IO Information between #{device_mod} and #{db_mod}\n"
      filename = db_hdl
    elsif ( device_term_inf.keys != db_term_inf.keys ) || ( device_mod != db_mod )     
      # Not match IO Pin or ModuleName
      filename = local_dir + "/" + device_mod + "_ICE_TMP.v"
      generate_RemoveHDL(filename,device_mod+"_ICE",device_term_inf)
      filename = "${PP}/" + File.basename(filename)
    else
      filename = db_hdl
    end
    return filename
  end
  
  def get_PortInf(mod,file)
    printf "@I:get Port Information about #{file}\n"
    term = nil
    xml_file = "tmp"
    result = `#{FICE_DB::V2XML} #{file} > #{xml_file}`
    if FileTest::readable?(xml_file)
      root = XMLParse.read("#{xml_file}")
      term = XMLParse::get_PortList(root,mod)
    end
    FileUtils.rm("#{xml_file}") 
    return term
  end

  def generate_RemoveHDL(filename,mod,signalList)
    
    # Overwrite Warning
    FMakeMessage.PrintWarning( :category => "FMakeLogic", :no => 100, :file_name => File.basename(__FILE__), :filename => filename) if FileTest::exist?(filename)
    
    printf("@I:Generaete \"%s\" at temporary Reove Macro.\n",filename)
    f = open(filename,"w")

f.print <<EOB
//-----------------------------------------------------------------------------
// Title         : Remove Macro for #{mod}
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
    
    # print Module
    f.printf("module\t%s(\n",mod)

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
  end

  #
  # Analyze Conf
  #
  public
  def analyze
    file = @conffile
    # File Check
    unless FileTest.readable?(file)
      # ERROR and EXIT
      FMakeMessage::PrintError( :category => "FILE", :no => 21, :param => file, :read_file => @filelist )
    end
    # Analyze
    tokens = []
    syntax_tokens = []
    line_no = 1
    
    # Saved DB
    printf("@I:Read and Analyze Conf File(%s) ... ",file)
    conf_db = FICE_DB::Conf.new( :conf_file => file )

    # Analyze Each line ( saving FICE_DB::Conf )
    printf("\n") if $VERBOSE
    open(file).each do |line|
      analyze_each_line(conf_db,file,line,line_no)      
      line_no += 1
    end

    # Definition Rule Check each Instance group
    inst_rule_check(conf_db)
    printf("Success\n")
    @conf_db = conf_db
    return conf_db

  end # analyze
  
  #
  # Analyze Each Line ( Operation separated each reseved word )
  #
  private
  def analyze_each_line(conf_db,file,line,line_no)
    lexer = Parser.new("#{line}")
    tokens = lexer.tokens
    if tokens == []
      printf "L%03d - BRANK\n",line_no if $VERBOSE  
      @previous_comment = []
    end
    while tokens != []
      token = tokens.shift
      result = true
      case token
      when %r(#) 
        # COMMENT
        printf "L%03d - COMMENT     - %s\n",line_no,line.strip  if $VERBOSE
        unless line.strip.size == 0
          @previous_comment << line
        end
      when "ProductBase"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.ProductBase = get_param_global(conf_db,tokens,file,line,line_no)
        conf_db.set_SET( ["ProductBase", conf_db.ProductBase] )
      when "PRODUCT"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.PRODUCT = get_param_global(conf_db,tokens,file,line,line_no)
        conf_db.DeviceName = conf_db.PRODUCT
        conf_db.set_SET( ["DeviceName", conf_db.PRODUCT] )
      when "DeviceName"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.PRODUCT = get_param_global(conf_db,tokens,file,line,line_no)         
        conf_db.DeviceName = conf_db.PRODUCT
        conf_db.set_SET( ["DeviceName", conf_db.PRODUCT] )
      when "PRODUCT_VER"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.PRODUCT_VER = get_param_global(conf_db,tokens,file,line,line_no) 
        conf_db.DeviceVer = conf_db.PRODUCT_VER
        conf_db.set_SET( ["DeviceVer", conf_db.PRODUCT_VER] )
      when "DeviceVer"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.PRODUCT_VER = get_param_global(conf_db,tokens,file,line,line_no) 
        conf_db.DeviceVer = conf_db.PRODUCT_VER
        conf_db.set_SET( ["DeviceVer", conf_db.PRODUCT_VER] )
      when "ICE_VER"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.ICE_VER = get_param_global(conf_db,tokens,file,line,line_no) 
        conf_db.IdVer = conf_db.ICE_VER
        conf_db.set_SET( ["IdVer", conf_db.ICE_VER] )
      when "IdVer"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.ICE_VER = get_param_global(conf_db,tokens,file,line,line_no) 
        conf_db.IdVer = conf_db.ICE_VER
        conf_db.set_SET( ["IdVer", conf_db.ICE_VER] )
      when "TOP_MODULE"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.TOP_MODULE = get_param_global(conf_db,tokens,file,line,line_no) 
        conf_db.set_SET( ["TopModule", conf_db.TOP_MODULE] )
      when "TopModule"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.TOP_MODULE = get_param_global(conf_db,tokens,file,line,line_no) 
        conf_db.set_SET( ["TopModule", conf_db.TOP_MODULE] )
      when "VERILOG_LIST"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.VERILOG_LIST = get_param_global(conf_db,tokens,file,line,line_no) 
      when "VERILOG_LIST_OLD"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.VERILOG_LIST_OLD = get_param_global(conf_db,tokens,file,line,line_no) 
      when "PIN_SDC"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.PIN_SDC = get_param_global(conf_db,tokens,file,line,line_no) 
      when "ADD_MODIFY_INST"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        add_modify_inst = get_param_global(conf_db,tokens,file,line,line_no)
        conf_db.ADD_MODIFY_INST = add_modify_inst.split(",") unless add_modify_inst.nil? 
      when "VERILOG_DEFINE"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.VERILOG_DEFINE = get_param_global(conf_db,tokens,file,line,line_no) 
      when "SET"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        conf_db.set_SET( get_param_set(conf_db,tokens,file,line,line_no) )
      when "INS"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        # Check Syntax        
        FMakeMessage::PrintError( :category => "CONF", :no => 100, :file => file, :line => line.strip, :line_no => line_no) if @inst_scope != nil
        inf = get_param_ins(conf_db,tokens,file,line,line_no)
        result = conf_db.save_INSInf( :inst_name => inf[0], :module_name => inf[1], :macro_type => inf[2], :ins_line_no => line_no, :ins_line_no_end => line_no,
                                      :inst_name_org => tokens[1], :module_name_org => tokens[2], :macro_type_org => tokens[3], :previous_comment => @previous_comment)
        conf_db.LastLine = line_no
      when "END_INS"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        if conf_db.INST[@inst_scope] != nil
          conf_db.INST[@inst_scope].InsLineNo_End = line_no
        end
        # Check Syntax        
        FMakeMessage::PrintError( :category => "CONF", :no => 101, :file => file, :line => line.strip, :line_no => line_no) if @inst_scope == nil
        @inst_scope = nil
        conf_db.LastLine = line_no
        @previous_comment = []
      when "MODULE_NAME"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        replace_module_name_org = tokens[1]
        replace_module_name =  get_param_global(conf_db,tokens,file,line,line_no) 
        result = conf_db.add_INSInf( :inst_name => @inst_scope, :replace_module_name => replace_module_name, :inst_name_org => @inst_scope_org, :replace_module_name_org => replace_module_name_org)
      when "VERILOG_FILE"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        replace_verilog_file_org =  tokens[1]
        replace_verilog_file =  get_param_global(conf_db,tokens,file,line,line_no) 
        result = conf_db.add_INSInf( :inst_name => @inst_scope, :replace_verilog_file => replace_verilog_file, :inst_name_org => @inst_scope_org, :replace_verilog_file_org => replace_verilog_file_org )
      when "MOD_CON"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        mod_con_org = tokens[1]
        mod_con =  get_param_global(conf_db,tokens,file,line,line_no) 
        result = conf_db.add_INSInf( :inst_name => @inst_scope, :mod_con => mod_con, :inst_name_org => @inst_scope_org, :mod_con_org => mod_con_org )
      when "ADD_MOD_CON"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        add_mod_con_org = tokens[1]
        add_mod_con =  get_param_global(conf_db,tokens,file,line,line_no) 
        result = conf_db.add_INSInf( :inst_name => @inst_scope, :add_mod_con => add_mod_con, :inst_name_org => @inst_scope_org, :add_mod_con_org => add_mod_con_org )
      when "INST_CON"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        inst_con_org = tokens[1]
        inst_con =  get_param_global(conf_db,tokens,file,line,line_no) 
        result = conf_db.add_INSInf( :inst_name => @inst_scope, :inst_con => inst_con, :inst_name_org => @inst_scope_org, :inst_con_org => inst_con_org )
      when "ADD_INST_CON"
        printf "L%03d - ENABLE LINE - %s\n",line_no,line.strip  if $VERBOSE
        add_inst_con_org = tokens[1]
        add_inst_con =  get_param_global(conf_db,tokens,file,line,line_no) 
        result = conf_db.add_INSInf( :inst_name => @inst_scope, :add_inst_con => add_inst_con, :inst_name_org => @inst_scope_org, :add_inst_con_org => add_inst_con_org )
      else
        # Un-Supported Line
        FMakeMessage::PrintError( :category => "CONF", :no => 100, :file => file, :line => line.strip, :line_no => line_no)
      end
      # Error of Multiple-Define 
      FMakeMessage::PrintError( :category => "CONF", :reserved => token, :no => 120, :file => file, :line_no => line_no) unless result
      break # goto next line
    end
  end

  #
  # Instance Definition Rule Check
  #   Check separate MacroType
  #
  private
  def inst_rule_check(data)
    data.INST.each_value do |inst|
      inst.rule_check unless inst.nil?
    end
  end


  #
  # get Parameter
  #   return : if success return param else return nil
  #
  private
  def get_param_global(conf_db,tokens,file,line,line_no)
    param = nil
    if tokens.shift == ":"
      param =  tokens.shift
      tmp = tokens
      next_token = tokens.shift
      if next_token == nil || /#/ =~ next_token
        # Expand set variable
        param = expand_set_variable(conf_db,param,file,line,line_no)
        return param
      elsif next_token == ","
        tmp =  tmp - [","] 
        tmp << param
        return tmp.join(',')
      end
    end
    # Syntax Error
    FMakeMessage::PrintError( :category => "CONF", :no => 100, :file => file, :line => line.strip, :line_no => line_no)
  end

  #
  # get Parameter for Set
  #
  private
  def get_param_set(conf_db,tokens,file,line,line_no)
    param = nil
    key =  tokens.shift
    if tokens.shift == "="
      value = expand_set_variable(conf_db,tokens.shift,file,line,line_no)
      next_token = tokens.shift
      if next_token == nil || /#/ =~ next_token
        return key,value
      end
    end
    # Syntax Error
    FMakeMessage::PrintError( :category => "CONF", :no => 100, :file => file, :line => line.strip, :line_no => line_no)
  end

  #
  # get Parameter for INS
  #   return : if success return param else return nil
  #
  private
  def get_param_ins(conf_db,tokens,file,line,line_no)
    inst_name = nil,mod_name = nil,type = nil,inst_name_org =nil
    if tokens.shift == ":"
      inst_name_org = tokens[0]
      inst_name = expand_set_variable(conf_db,tokens.shift,file,line,line_no)
      mod_name =  expand_set_variable(conf_db,tokens.shift,file,line,line_no)
      if tokens.shift == "TYPE"
        type = tokens.shift
        next_token = tokens.shift
        if next_token == nil || /#/ =~ next_token
          @inst_scope = inst_name
          @inst_scope_org = inst_name_org
          return inst_name,mod_name,type
        elsif next_token == "END_INS"
          @inst_scope = nil
          @inst_scope_org = nil
          if tokens.shift == ":"
            next_token = tokens.shift
            if next_token == nil || /#/ =~ next_token
              return inst_name,mod_name,type
            end
          end
        end
      end
    end
    # Syntax Error
    FMakeMessage::PrintError( :category => "CONF", :no => 100, :file => file, :line => line.strip, :line_no => line_no)
  end

  #
  # Expand Set Variable
  #  param  : line, FICE_DB::Conf
  #  return : line that expanded set variable ( ex: set BBB=bbb , aaa/${BBB} => aaa/bbb )
  #
  private
  def expand_set_variable(conf_db,tokens,file,line,line_no)
    while ( /^.*\$\{(.*)\}/ =~ tokens ) != nil
      set_var = $1
      expand_var = conf_db.SET[set_var]
      if expand_var != nil
        tokens = tokens.sub(/\$\{#{set_var}\}/,expand_var)
      else
        $DEBUG = false
        if set_var == "IdVer" 
          tokens = tokens.sub(/\$\{#{set_var}\}/,"")
        else
          FMakeMessage::PrintError( :category => "CONF", :no => 110, :file => file, :line => line.strip, :line_no => line_no)        
        end
      end
    end
    return tokens
  end

  #
  # Basic Conf Paser
  #
  private
  class Parser
    def initialize(src)
      @src = src
    end
    def lex
      case @src
      when /^[\r\n\t ]*([${}\/0-9.a-zA-Z_-]+)(.*$)/      # number
      when /^[\r\n\t ]*(#+)(.*$)/      # comment
      when /^[\r\n\t ]*(\w+)(.*$)/         # alphabet
      when /^[\r\n\t ]*([\[\]\"\(\)\,\;\:])(.*$)/  # delimiter({,},[,])
      when /^[\r\n\t ]*(\=+|\|\||\!\=|\&\&|\||\&)(.*$)/         # delimiter({,},[,])
      when /^[\r\n\t ]+(.*)(.*$)/          # ==
        return nil
      end
      @src = $2
      $1
    end
    
    def tokens
      ts = Array.new
      while (token = lex) != nil
        ts.push(token)
      end
      ts
    end
  end


  def check
    p @conf_db
    exit
  end

end


