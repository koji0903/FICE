##############################################
# FICE DB 
#  Common Database for FICE
##############################################
$GEM_HOME_PATH = "/home/product/div-micom-ice/data/proj/RL78/Common/local/gems/1.8"
ENV["GEM_HOME"] = $GEM_HOME_PATH

require 'sqlite3'
require 'FMakeMessage'

module FICE_DB

  #
  # SCAN/TESDB Data
  #
  SCAN_NAME= [
              "TESDBT",
              "TESDBT2",
              "TESTMOD",
              "TESSCAN1",
              "TESSCAN2",
              "TESSCAN3",
              "TESSCAN4",
              "SCANEN",
              "SCANMODE",
              "SCANCLK",
              "BBTESINST",
              "mod_scanmode",
              "mod_scanen",
              "mod_scanin",
              "mod_tesscan1",
              "mod_bbtesinst",

#              "OPTMDUMP",
#              "TESUSR",
#             "PTESINST",
#              "OPTBCT",
#              "OPTIDDQ",
#              "OPTDFL",
             ]

  #
  # RL78 Common
  #
  RL78_BASE = "/home/product/div-micom-ice/data/proj/RL78"
  RL78_COMMON = RL78_BASE + "/Common"
  RL78_PRODUCT = RL78_BASE + "/Products"

  

  #
  # FICE OUTPUT DATA PATH
  #
  FICE_DATA = RL78_COMMON + "/.fice"
  # HTML
  HTML_PATH = FICE_DATA + "/html"
  
  #
  # Adding TOOL
  #
  # V2XML 
  XML_CONV_VER = "1.8.5"
  V2XML     = RL78_COMMON + "/VerilogToXML/Release/#{XML_CONV_VER}/VerilogToXML"
  V2XML_VER = `#{V2XML} --version`.split[1]
  XML2V     = RL78_COMMON + "/XMLtoVerilog/Release/#{XML_CONV_VER}/XMLtoVerilog"
  XML2V_VER = `#{XML2V} --version`.split[1]
  # V2HTML
  V2HTML    = RL78_COMMON + "/v2html/v2html"
  V2HTML_OUTDIR = HTML_PATH + "/v2html"

  # Common PATH
  ICE_MACRO_BASE = RL78_COMMON + "/ICEMacroSuite/ICEMacro"
  ICE_MACRO_PATH = ICE_MACRO_BASE + "/tags"
  if $DEBUG
#    ICE_MACRO_CURRENT = ICE_MACRO_PATH + "/test"
    ICE_MACRO_CURRENT = ICE_MACRO_BASE + "/current"
  else
    ICE_MACRO_CURRENT = ICE_MACRO_BASE + "/current"
  end

  REPLACE_MACRO_BASE = "/design01/iecube_rl78/Common/ReplaceMacro"
  REPLACE_MACRO_PATH = REPLACE_MACRO_BASE + "/tags"
  if $DEBUG
#    REPLACE_MACRO_CURRENT = REPLACE_MACRO_PATH + "/test"
    REPLACE_MACRO_CURRENT = REPLACE_MACRO_BASE + "/latest"
  else
    REPLACE_MACRO_CURRENT = REPLACE_MACRO_BASE + "/latest"
  end

  PORT_BUFFER_BASE = "/design01/iecube_rl78/Common/PortBuffer"
  PORT_BUFFER_PATH = PORT_BUFFER_BASE + "/tags"
  if $DEBUG
#    PORT_BUFFER_CURRENT = PORT_BUFFER_PATH + "/test"
    PORT_BUFFER_CURRENT = PORT_BUFFER_BASE + "/latest"
  else
    PORT_BUFFER_CURRENT = PORT_BUFFER_BASE + "/latest"
  end

  SETTINGS_PATH = "/home/product/div-micom-ice/data/proj/RL78/Common/Settings"
  
  PRODUCT_PATH = Dir::pwd + "/local"
  PRODUCT_PATH_AUTO = "local_Candidate"
  DEVICE_DIFF = "MacroDiff"

  CLOCK_CONTROL = "/design01/iecube_rl78/Common/Constraints/Control/latest/ClockControl.cnt"
#  CLOCK_CONTROL = "/design01/iecube_rl78/Common/Constraints/Control/trunk/ClockControl.cnt"

  def FICE_DB::print_env
    print <<EOB

FICE(FMake) set Following Constant Variables. 

EOB

    constants(FICE_DB).each do |val|
      if const_get(val).class == String
        printf("%-25s : %s\n",val,const_get(val))
      end
    end
    printf("\n")
    exit
  end
  
  #
  # FPGA-ICE Common Environment Path
  #
  class CommonPath

    def initialize
    end

    public
    def get_ICEMacroVer
      if $DEBUG
        return "test"
      else
        return get_RealPath("#{ICE_MACRO_CURRENT}")
      end
    end
    
    public
    def get_ReplaceMacroVer
      if $DEBUG
        return "test"
      else
        return get_RealPath("#{REPLACE_MACRO_CURRENT}")
      end
    end

    public
    def get_PortBufferVer
      if $DEBUG
        return "test"
      else
        return get_RealPath("#{PORT_BUFFER_CURRENT}")
      end
    end

    private
    def get_RealPath(path)
      if File.exist?(path)
        if File.ftype(path) == "link"
          scope =  `ls -l #{path}`.split.last
          tmp = path.split("/")
          tmp[tmp.size-1] = scope
          get_RealPath(tmp.join("/"))
        else
          return path.split("/").last
        end
      else
        printf "@internal error: %s does not exist.\n",path
        exit 1
      end
    end
      
  end


  #
  # SignalInf Class
  #  Determine SignalInf Information
  #
  #  Selected by "Type"
  #  at input/output/inout
  #    direction ["MSB":"LSB"] SignalName;
  #  at wire
  #    wire ["MSB":"LSB"] WireName;
  #  at reg
  #    reg ["MSB":"LSB"] RegName;
  #  at mem
  #    reg ["MSB":"LSB"] MemName["WordTop":"WordButtom"];
  #
  class SignalInf
    # Module Name include Signal
    attr_accessor :ModuleName
    # Instance Name include Signal
    attr_accessor :InstName
    # SignalInf Name
    attr_accessor :Name
    # Connected Wire ( for search Connection )
    attr_accessor :ConnectedWireName
    # Type(input/output/inout/wire/reg/mem/constant/open/terminal/non-connect)
    attr_accessor :Type
    # MSB value
    attr_accessor :MSB
    # LSB value
    attr_accessor :LSB
    # Bus-Size
    attr_accessor :Size
    # BusPortion
    attr_accessor :BusPortion
    # BusPortion
    attr_accessor :PortBusPortion
    attr_accessor :PortSize

    # WordTop for mem
    attr_accessor :WordTop
    # WordButtom for mem
    attr_accessor :WordButtom
    # Connect Inf 
    attr_accessor :ConnectInf
    # New Flag ( new port/wire make by FMake)
    attr_accessor :NewFlag

    # Comment if necessary
    attr_accessor :Comment

    # SignalInf Information set
    def initialize( signal_inf = nil)
      @ModuleName = ""
      @InstName = ""
      @Name = ""
      @NewFlag = false

      if signal_inf != nil
        @ModuleName = signal_inf[:module_name]
        @InstName = signal_inf[:inst_name]
        @Name = signal_inf[:name]
        @ConnectedWireName = signal_inf[:connected_wire_name]
        @Type = signal_inf[:type]
        @MSB = signal_inf[:msb]
        @LSB = signal_inf[:lsb]
        @BusPortion = signal_inf[:portion]
        @PortBusPortion = signal_inf[:signal_portion]
        @PortSize = signal_inf[:signal_size]
        @WordTop = signal_inf[:word_top]
        @WordButtom = signal_inf[:word_buttom]
        @Comment = signal_inf[:comment]
        @NewFlag = signal_inf[:new_flag]
      end
      # Type member error

#      if @Type != "input" && @Type != "output" && @Type != "inout" && @Type !=  "wire" && @Type != "reg" && @Type != "mem" && @Type != "constant" && @Type != "open" && @Type != "terminal" && @Type != "non-connect" 
#        FMakeMessage.PrintInternalError( :category => "FICE_DB", :no => 10, :file_name => File.basename(__FILE__), :lineno => __LINE__, 
#                                         :param => @Type )       
#      end

      # BusPortion member error
#      if @MSB != nil && @BusPortion != nil
#        FMakeMessage.PrintInternalError( :category => "FICE_DB", :no => 11, :file_name => File.basename(__FILE__), :lineno => __LINE__ )       
#      end
      # Calucurate BusSize
      if @MSB != nil && @LSB != nil
        @Size = (@MSB.to_i - @LSB.to_i).abs + 1
      else
        @Size = 1
      end
    end
    
    
    #
    # Compare Instance Variavle Value for TestUnit assertion
    #
    public
    def ==(other)
      golden = nil
      revised = nil
      return false if other == nil
      instance_variables.each do |val|
        next if val == :@Comment # Except "Comment" Comparing
        golden = self.instance_variable_get(val)
        revised = other.instance_variable_get(val) if other != "Unknown"
#        return true if golden == nil || revised == nil
        unless golden == revised
          #         print "#{val} mismatch G:#{golden},R:#{revised}\n"
          return false
        end
      end
      return true
    end

    #
    # Compare Instance Variavle Value for TestUnit assertion
    #
    public
    def -(other)
      flag = true
      instance_variables.each do |val|
        next if val == :@Comment # Except "Comment" Comparing
        golden = self.instance_variable_get(val)
        revised = other.instance_variable_get(val)
        if golden != revised
          flag = false
        end
      end
      return flag
    end

  end

  #----------------------------------------------------------------------

  #
  # Conf Information Class
  #
  public
  class Conf
    # CONF FILE
    attr_accessor :CONF_FILE
    # PRODUCT
    attr_accessor :ProductBase
    # PRODUCT
    attr_accessor :DeviceName
    # PRODUCT
    attr_accessor :PRODUCT
    # PRODUCT_VER
    attr_accessor :DeviceVer
    attr_accessor :PRODUCT_VER
    # ICE_VER
    attr_accessor :IdVer
    attr_accessor :ICE_VER
    # Top Module Name
    attr_accessor :TopModule
    attr_accessor :TOP_MODULE
    # Verilog List File name
    attr_accessor :VERILOG_LIST
    # Verilog List OLD File name
    attr_accessor :VERILOG_LIST_OLD
    # Pin SDC File
    attr_accessor :PIN_SDC
    # Add Modify Instance
    attr_accessor :ADD_MODIFY_INST
    # Define File
    attr_accessor :VERILOG_DEFINE
    # SET Definition
    attr_accessor :SET
    # Instance Information
    attr_accessor :INST
    # Ins last line
    attr_accessor :LastLine

    def initialize( inf = nil )
      @CONF_FILE = inf[:conf_file]
      @ProductBase = nil
      @DeviceName = nil
      @DeviceVer = nil
      @IdVer = nil
      @TopModule = nil
      @PRODUCT = nil
      @PRODUCT_VER = nil
      @ICE_VER = nil
      @TOP_MODULE = nil
      @VERILOG_LIST = nil
      @VERILOG_LIST_OLD = nil
      @PIN_SDC = nil
      @ADD_MODIFY_INST = nil
      @VERILOG_DEFINE = nil
      @SET = Hash.new
      @INST = Hash.new # InstanceName => InstInf Class
    end
    def set_SET(value)
      @SET[value[0]] = value[1]
    end
    def save_INSInf( inf )
      inst_name = inf[:inst_name]
      if @INST[inst_name] == nil    
        inf[:conf_file] = @CONF_FILE if inf[:conf_file] == nil
        # save New
        inst_inf = InstInf.new(inf)
      else
        # Error ( already Defined same Instance )
        FMakeMessage::PrintError( :category => "CONF", :no => 111, :inst => inst_name, :file => self.CONF_FILE, :line_no => inf[:ins_line_no])
      end
      @INST[inst_name] = inst_inf
      return true
    end
    def add_INSInf( inf )
      result = nil
      inst_name = inf[:inst_name]
      if @INST[inst_name] != nil    
        # add inf
        inst_inf = @INST[inst_name]
        result = inst_inf.add( inf )
      end
      @INST[inst_name] = inst_inf
      return result
    end

    #
    # InstInf Class ( in Conf File )
    #  Determine Instance Information
    #
    class InstInf
      # CONF FILE
      attr_accessor :CONF_FILE
      # Module Name(Str)
      attr_accessor :ModuleName, :ModuleName_org
      # Instance Name(Str)
      attr_accessor :InstName, :InstName_org
      # MacroType(Str) - KeepKeep/KeepChange/Remove/Add/Replace
      attr_accessor :MacroType, :MacroType_org
      # Replace ModuleName ( Replace Macro only )
      attr_accessor :ReplaceModuleName, :ReplaceModuleName_org
      # Replace Verilog File
      attr_accessor :ReplaceVerilogFile, :ReplaceVerilogFile_org
      # MOD_CON File
      attr_accessor :ModCon, :ModCon_org
      # ADD_MOD_CON File
      attr_accessor :AddModCon, :AddModCon_org
      # INST_CON File
      attr_accessor :InstCon, :InstCon_org
      # ADD_INST_CON File
      attr_accessor :AddInstCon, :AddInstCon_org
      # Instance Information
      attr_accessor :InsLineNo
      attr_accessor :InsLineNo_End
      # Instance Information
      attr_accessor :Comment, :Comment_org, :PreviousComment
      
      def initialize(inf)
        @CONF_FILE = inf[:conf_file]
        @ModuleName = inf[:module_name]
        @ModuleName_org = inf[:module_name_org]
        @InstName = inf[:inst_name]
        @InstName_org = inf[:inst_name_org]
        @MacroType = inf[:macro_type]
        @MacroType_org = inf[:macro_type_org]
        @ReplaceModuleName = inf[:replace_module_name]
        @ReplaceModuleName_org = inf[:replace_module_name_org]
        @ReplaceVerilogFile = inf[:replace_verilog_file]
        @ReplaceVerilogFile_org = inf[:replace_verilog_file_org]
        @ModCon = inf[:mod_con]
        @ModCon_org = inf[:mod_con_org]
        @AddModCon = inf[:add_mod_con]
        @AddModCon_org = inf[:add_mod_con_org]
        @InstCon = inf[:inst_con]
        @InstCon_org = inf[:inst_con_org]
        @AddInstCon = inf[:add_inst_con]
        @AddInstCon_org = inf[:add_inst_con_org]
        @InsLineNo = inf[:ins_line_no]
        @InsLineNo_End = inf[:ins_line_no_end]
        @Comment = inf[:comment]
        @Comment_org = inf[:comment_org]
        @PreviousComment = inf[:previous_comment]
      end

      # Name Resolve from internal data to CONECT FILE format
      #   param : val - intrnal data name
      #   ret   : CONNECT File definition word
      def name_resolve(val)
        case val
        when :@ReplaceModuleName
          return "MODULE_NAME"
        when :@ReplaceVerilogFile
          return "VERILOG_FILE"
        when :@ModCon
          return "MOD_CON"
        when :@AddModCon
          return "ADD_MOD_CON"
        when :@InstCon
          return "INST_CON"
        when :@AddInstCon
          return "ADD_INST_CON"
        end
      end


      #
      # Add Instance Information defined in Conf File
      #  - param : inf ( defined each adding information )
      #  - ret   : true - save successfully, false - Error (already saved )
      def add(inf)
        # Repalace Module Name
        unless inf[:replace_module_name] == nil 
          if @ReplaceModuleName == nil
            @ReplaceModuleName = inf[:replace_module_name] 
          else
            return false
          end
        end
        unless inf[:replace_module_name_org] == nil 
          if @ReplaceModuleName_org == nil
            @ReplaceModuleName_org = inf[:replace_module_name_org] 
          else
            return false
          end
        end
        # Replace Verilog File
        unless inf[:replace_verilog_file] == nil
          if @ReplaceVerilogFile == nil
            @ReplaceVerilogFile = inf[:replace_verilog_file] 
          else
            return false
          end
        end
        unless inf[:replace_verilog_file_org] == nil
          if @ReplaceVerilogFile_org == nil
            @ReplaceVerilogFile_org = inf[:replace_verilog_file_org] 
          else
            return false
          end
        end
        # MOD_CON
        unless inf[:mod_con] == nil
          if @ModCon == nil
            @ModCon = inf[:mod_con] 
          else
            return false
          end
        end
        unless inf[:mod_con_org] == nil
          if @ModCon_org == nil
            @ModCon_org = inf[:mod_con_org] 
          else
            return false
          end
        end
        # ADD_MOD_CON
        unless inf[:add_mod_con] == nil
          if @AddModCon == nil
            @AddModCon = inf[:add_mod_con] 
          else
            return false
          end
        end
        unless inf[:add_mod_con_org] == nil
          if @AddModCon_org == nil
            @AddModCon_org = inf[:add_mod_con_org] 
          else
            return false
          end
        end
        # INST_CON
        unless inf[:inst_con] == nil
          if @InstCon == nil
            @InstCon = inf[:inst_con] 
          else
            return false
          end
        end
        unless inf[:inst_con_org] == nil
          if @InstCon_org == nil
            @InstCon_org = inf[:inst_con_org] 
          else
            return false
          end
        end
        # ADD_INST_CON
        unless inf[:add_inst_con] == nil
          if @AddInstCon == nil 
            @AddInstCon = inf[:add_inst_con] 
          else
            return false
          end
        end
        # ADD_INST_CON
        unless inf[:add_inst_con_org] == nil
          if @AddInstCon_org == nil 
            @AddInstCon_org = inf[:add_inst_con_org] 
          else
            return false
          end
        end
        
        return true
      end
      
      #
      # Definition Rule Check
      #
      def rule_check
        case self.MacroType
        when "KeepKeep","Remove"
          # Banned
          [:@ReplaceModuleName,:@ReplaceVerilogFile,:@ModCon,:@AddModCon,:@InstCon,:@AddInstCon].each do |val|
            FMakeMessage::PrintError( :category => "CONF", 
                                      :no => 131, 
                                      :type => self.MacroType, 
                                      :val => self.name_resolve(val),
                                      :file => self.CONF_FILE, 
                                      :line_no => self.InsLineNo ) unless self.instance_variable_get(val).nil?
          end
          # Need - Nothing
        when "KeepChange"
          # Banned
          [:@ReplaceModuleName,:@ReplaceVerilogFile].each do |val|
            FMakeMessage::PrintError( :category => "CONF", 
                                      :no => 131, 
                                      :type => self.MacroType, 
                                      :val => self.name_resolve(val),
                                      :file => self.CONF_FILE, 
                                      :line_no => self.InsLineNo ) unless self.instance_variable_get(val).nil?
          end
          # Need
          flag = false
          [:@ModCon,:@AddModCon,:@InstCon,:@AddInstCon].each do |val|
            flag = true unless self.instance_variable_get(val).nil?
          end
          FMakeMessage::PrintError( :category => "CONF", 
                                    :no => 132, 
                                    :type => self.MacroType,  
                                    :inst_name => self.InstName,
                                    :file => self.CONF_FILE, 
                                    :line_no => self.InsLineNo ) unless flag
        when "Replace"
          # Need
          [:@ReplaceModuleName,:@ReplaceVerilogFile].each do |val|
            if self.instance_variable_get(val).nil?
              FMakeMessage::PrintError( :category => "CONF", 
                                        :no => 133, 
                                        :type => self.MacroType,
                                        :inst_name => self.InstName,
                                        :file => self.CONF_FILE, 
                                        :line_no => self.InsLineNo )
              break
            end
          end
=begin
          # Need
          flag = false
          [:@ModCon,:@AddModCon,:@InstCon,:@AddInstCon].each do |val|
            flag = true unless self.instance_variable_get(val).nil?
          end
          FMakeMessage::PrintError( :category => "CONF", 
                                    :no => 132, 
                                    :type => self.MacroType, 
                                    :inst_name => self.InstName,
                                    :file => self.CONF_FILE, 
                                    :line_no => self.InsLineNo ) unless flag
=end
        when "Add"
          # Banned
          [:@ReplaceModuleName].each do |val|
            FMakeMessage::PrintError( :category => "CONF", 
                                      :no => 131, 
                                      :type => self.MacroType, 
                                      :val => self.name_resolve(val),
                                      :file => self.CONF_FILE, 
                                      :line_no => self.InsLineNo ) unless self.instance_variable_get(val).nil?
          end
          # Need
          [:@ReplaceVerilogFile].each do |val|
            if self.instance_variable_get(val).nil?
              FMakeMessage::PrintError( :category => "CONF", 
                                        :no => 134, 
                                        :type => self.MacroType,
                                        :inst_name => self.InstName,
                                        :file => self.CONF_FILE, 
                                        :line_no => self.InsLineNo )
              break
            end
          end
          # Need
=begin
          flag = false
          [:@ModCon,:@AddModCon,:@InstCon,:@AddInstCon].each do |val|
            flag = true unless self.instance_variable_get(val).nil?
          end
          FMakeMessage::PrintError( :category => "CONF", 
                                    :no => 132, 
                                    :type => self.MacroType, 
                                    :inst_name => self.InstName,
                                    :file => self.CONF_FILE, 
                                    :line_no => self.InsLineNo ) unless flag
=end
        else
          FMakeMessage::PrintError( :category => "CONF", :no => 130, :type => self.MacroType ,:file => self.CONF_FILE, :line_no => self.InsLineNo )
        end
        return true
      end
      
      # Get defiend CONNECT FILES
      #  return values priority
      #    1. MOD_CON
      #    2. ADD_MOD_CON
      #    3. INST_CON
      #    4. ADD_INST_CON
      #  ret : Connet File list (Array fo [FileType,file name]) ex: [["MOD_CON", "./tp/ADD_MODULE.mod_con"],["INST_CON", "./tp/ADD_MODULE.inst_con"]]
      def get_ConnectList
        connect_list = Array.new
        connect_list << ["MOD_CON",self.ModCon] unless self.ModCon == nil
        connect_list << ["ADD_MOD_CON",self.AddModCon] unless self.AddModCon == nil
        connect_list << ["INST_CON",self.InstCon] unless self.InstCon == nil
        connect_list << ["ADD_INST_CON",self.AddInstCon] unless self.AddInstCon == nil
        return connect_list
      end

      #
      # print
      #
      def print
        printf("@I:Logic Modify for \"inst:%s[module:%s]\" (Macro Type:%s)\n",self.InstName,self.ModuleName,self.MacroType)
        if self.ReplaceVerilogFile != nil || self.ModCon != nil || self.AddModCon != nil || self.InstCon != nil || self.AddInstCon
          printf("[Macro Information is following.]\n")
          printf("VerilogHDL     : %s\n",self.ReplaceModuleName) unless self.ReplaceModuleName == nil
          printf("VerilogHDL     : %s\n",self.ReplaceVerilogFile) unless self.ReplaceVerilogFile == nil
          printf("MOD_CON        : %s\n",self.ModCon) unless self.ModCon == nil
          printf("ADD_MOD_CON    : %s\n",self.AddModCon) unless self.AddModCon == nil
          printf("INST_CON       : %s\n",self.InstCon) unless self.InstCon == nil
          printf("ADD_INST_CON   : %s\n",self.AddInstCon) unless self.AddInstCon == nil
        else
          printf("Nothing Add Information.\n")
        end
      end
      
    end
  end
  
  #----------------------------------------------------------------------
  
  #
  # Connect Information Class
  #
  public
  class Connect
    # MOD_CON/ADD_MOD_CON/INST_CON/ADD_INST_CON
    attr_accessor :FILE_TYPE
    # CONNECT File Name
    attr_accessor :CONNECT_FILE
    # Basis Module Name
    attr_accessor :MODULE_NAME
    # Basis Instance Name
    attr_accessor :INST_NAME
    # Each Pin Information
    attr_accessor :PIN_INF
    def initialize(inf)
      @FILE_TYPE = inf[:file_type]
      @CONNECT_FILE = inf[:file]
      @MODULE_NAME = inf[:module_name]
      @INST_NAME = inf[:inst_name]
      @PIN_INF = Hash.new # PIN_NAME = {inf}
    end

    # save Pin Info
    def add_PinInfo(inf)
      pin_name = inf[:pin_name]
      #      if @PIN_INF[pin_name].nil?
      pin_inf = Pin.new(inf)
      tmp = @PIN_INF[pin_name]
      if tmp.nil?
        tmp = Array.new 
      else
        # Error (multiple-defined)
        if @PIN_INF[pin_name][0].LineNo != inf[:line_no]
          FMakeMessage::PrintError( :category => "CONNECT", :no => 201, :pin_name => pin_name, :file => @CONNECT_FILE, :line_no => inf[:line_no])        
        end
      end
      tmp << pin_inf
      @PIN_INF[pin_name] = tmp
      #      else
#      end
      # Error (not enough information)
      if inf[:type] == "CONNECT"
        if inf[:connect_target] == nil || inf[:connect_port] == nil
          FMakeMessage::PrintError( :category => "CONNECT", :no => 200, :file => @CONNECT_FILE, :line => inf[:line], :line_no => inf[:line_no])
        end
      end
    end
    
    #
    # Each Pin Inforamtion
    #
    private
    class Pin
      # Line Strings
      attr_accessor :Line
      # Line No
      attr_accessor :LineNo
      # CONNECT/PULLUP/PULLDOWN/OPEN/TERMINAL/DRIVE_CHANGE
      attr_accessor :Type
      # Terminal Name ( in case TERMINAL )
      attr_accessor :TerminalName
      # Conenct Instance ( in case CONNECT )
      attr_accessor :ConnectTarget
      # Conenct Port ( in case CONNECT )
      attr_accessor :ConnectPort
      # Drive Module ( in case DRIVE_CHANGE )
      attr_accessor :DriveModule
      # Conenct Port ( in case DRIVE_CHANGE )
      attr_accessor :DrivePort
      def initialize(inf)
        @Line = inf[:line]
        @LineNo = inf[:line_no]
        @Type = inf[:type]
        @TerminalName = inf[:terminal_name]
        @ConnectTarget = inf[:connect_target]
        @ConnectPort = inf[:connect_port]
        @DriveModule = inf[:drive_module]
        @DrivePort = inf[:drive_port]
      end
      def get_data
        return @Type,@TerminalName,@ConnectTarget,@ConnectPort,@DriveModule,@DrivePort
      end
    end
    
  end

  #----------------------------------------------------------------------

  #
  # Logic Class - save logic information to SQLite3-DB
  #
  public
  class Logic
    def initialize(inf)
      db_file = inf[:db_file]
      db_file = "rl78.db" if db_file.nil?

      product = inf[:product]
      dev_ver = inf[:dev_ver]
      ice_ver = inf[:ice_ver]
      @product = product
      @table = @product + "_Logic"
      @table = "Logic"

      @db_file = FICE_DATA + "/db/" + db_file

      @sql = <<SQL
create table #{@table}(
  PRODUCT     TEXT,
  DEVICE_VER  TEXT,
  ICE_VER     TEXT,
  BASE_NAME   TEXT,
  STATUS      TEXT,
  FILE_INF    BLOB,
  LOGIC_INF   BLOB,
  V2XML_VER   TEXT,
  XML2V_VER   TEXT,
  HDL_PATH    TEXT,
  HDL_DATA    BLOB,
  HDL_MD5SUM  TEXT,
  XML_PATH    TEXT,
  XML_DATA    BLOB,
  XML_MD5SUM  TEXT,
  LIST_MD5SUM  TEXT
);
SQL
      @db = SQLite3::Database.new("#{@db_file}")      
      # make db file ( first execution only )
      begin
        printf("@I:Create Table(%s) in SQLite DB.\n",@table)
        @db.execute(@sql)
      rescue SQLite3::SQLException => ex
        printf(" %s. nothing to do.\n",ex.message)
      rescue SQLite3::BusyException => ex
        printf(" %s. retry.\n",ex.message)
        sleep 10
        retry
      rescue ex
        printf(" %s. Unknown.\n",ex.message)
        p ex
        exit
      end
      begin
        FileUtils.chmod(0777,@db_file)
      rescue
      end
    end
    #
    # Regist HDL ( at reading Verilog List )
    # 
    def regist_hdl( regist )
      sql = "select * from #{@table}"
      flag = false
      begin
        @db.execute(sql).each do |inf|
          if ( inf[0] == regist[:product] && inf[1] == regist[:dev_ver] && inf[2] == regist[:ice_ver] && inf[3] == regist[:base_name] )
            if ((inf[7] != regist[:v2xml_ver]) || (inf[11].to_s != regist[:hdl_md5sum].to_s) )
              flag = true
            elsif inf[15].to_s != regist[:list_md5sum].to_s
              flag = true
            else
              # nothing
=begin
              flag = false
              printf("@I:Nothing to do for DB (table:%s in %s)\n",@table,@db_file)
              p inf[7] == regist[:v2xml_ver]
              p inf[11].to_s == regist[:hdl_md5sum].to_s
              p inf[15].to_s == regist[:list_md5sum].to_s
              p inf[0] 
              p regist[:product]
              p inf[7]
              p regist[:v2xml_ver] 
              p inf[11]
              p regist[:hdl_md5sum]
              p inf[15] 
              p regist[:list_md5sum] 
              exit
=end
#              return 
            end
          end
        end
      rescue SQLite3::BusyException => ex
        printf(" %s. retry.\n",ex.message)
        sleep 10
        retry
      rescue => ex
        print " [SQlite3]", ex.message, "\n" if $VERBOSE
        p ex
        p sql
        exit
#        update_hdl( regist )
      end
      if flag
        # Update
        printf("@I:Updated %s\n", regist[:hdl_path])
        sql = "update #{@table} set PRODUCT = :product, DEVICE_VER = :device_ver, ICE_VER = :ice_ver, BASE_NAME   = :base_name, STATUS      = :status, FILE_INF    = :file_inf, LOGIC_INF   = :logic_inf, V2XML_VER   = :v2xml_ver, XML2V_VER   = :xml2v_ver, HDL_PATH    = :hdl_path, HDL_DATA    = :hdl_data, HDL_MD5SUM  = :hdl_md5sum, XML_PATH    = :xml_path, XML_DATA    = :xml_data, XML_MD5SUM  = :xml_md5sum, LIST_MD5SUM = :list_md5sum
  where PRODUCT = :product and DEVICE_VER = :device_ver and ICE_VER = :ice_ver and BASE_NAME = :base_name"
      else
        # New
        printf("@I:Save new for %s\n", regist[:hdl_path])
        sql = "insert into #{@table} values (:product, :device_ver, :ice_ver, :base_name, :status, :file_inf, :logic_inf, :v2xml_ver, :xml2v_ver, :hdl_path, :hdl_data, :hdl_md5sum, :xml_path, :xml_data, :xml_md5sum, :list_md5sum)"
      end
      begin
        @db.execute(sql, 
                    :product    =>  "#{regist[:product]}",
                    :device_ver =>  "#{regist[:dev_ver]}",
                    :ice_ver =>  "#{regist[:ice_ver]}",
                    :base_name  =>  "#{regist[:base_name]}",
                    :status     =>  "#{regist[:status]}",
                    :file_inf   =>  regist[:file_inf],
                    :logic_inf  =>  regist[:logic_inf],
                    :v2xml_ver  =>  "#{regist[:v2xml_ver]}",
                    :xml2v_ver  =>  "#{regist[:xml2v_ver]}",
                    :hdl_path   =>  "#{regist[:hdl_path]}",
                    :hdl_data   =>  regist[:hdl_data],
                    :hdl_md5sum =>  "#{regist[:hdl_md5sum]}",
                    :xml_path   =>  "#{regist[:xml_path]}",
                    :xml_data   =>  regist[:xml_data],
                    :xml_md5sum =>  "#{regist[:xml_md5sum]}",
                    :list_md5sum =>  "#{regist[:list_md5sum]}"
                    )        
      rescue SQLite3::BusyException => ex
        printf(" %s. retry.\n",ex.message)
        sleep 10
        retry
      rescue => ex
        print " [SQlite3]", ex.message, "\n" if $VERBOSE
        p ex
        p sql
        exit
#        update_hdl( regist )
      end
    end


    #
    #
    #
    def delete_table
      printf("Delete table(%s)\n",@table)
      sql = "drop table #{@table}"
      begin
        @db.execute(sql)
      rescue SQLite3::BusyException => ex
        printf(" %s. retry.\n",ex.message)
        sleep 10
        retry
      rescue
#        printf(" retry delete table\n")
#        sleep 10
#        retry
      end
    end

    #
    # Update DB data
    #
    def update_hdl(regist)
      printf("@I:update hdl data about %s\n",regist[:hdl_path])
      # remove old data
      sql = "delete from #{@table} where HDL_MD5SUM='#{regist[:hdl_md5sum]}"
      @db.execute(sql)
      # regist new data
      regist_hdl(regist)
    end

    # ret : true - YES, and Same Md5SUM
    def check_md5sum(base_path,md5sum,product,dev_ver,ice_ver)
      sql = "select base_name,v2xml_ver,hdl_md5sum,xml_path,product,device_ver,ice_ver,list_md5sum from #{@table}"
      begin
        @db.execute(sql).each do |row|
          if ice_ver != nil
            return row[0], row[1], row[3], row[7] if row[0] == base_path && row[2] == md5sum && row[4] == product && row[5] == dev_ver && row[6] == ice_ver
          else
            return row[0], row[1], row[3], row[7] if row[0] == base_path && row[2] == md5sum && row[4] == product && row[5] == dev_ver
          end
        end
      rescue
#        printf(" retry select table\n")
#        sleep 10
#        retry
      end
      return nil
    end

    # ret : true - YES, and Same Md5SUM
    def check_file(name)
      sql = "select base_name,v2xml_ver,hdl_md5sum, xml_path from #{@table}"
      @db.execute(sql).each do |row|
        return row[1], row[2], row[3] if row[0] == name
      end
      return nil
    end

  end # Class Logic

  #
  # Macro Class - save macro information to SQLite3-DB
  #
  public
  class Macro
    def initialize(inf)
      db_file = inf[:db_file]
      db_file = "rl78.db" if db_file.nil?

      @table = "Macro"

      @db_file = FICE_DATA + "/db/" + db_file

      @sql = <<SQL
create table #{@table}(
  MODULE_NAME TEXT,
  INST_NAME   TEXT,
  PRODUCT_NAME TEXT,
  DEVICE_VER  TEXT,
  ICE_VER     TEXT,
  HDL_PATH    TEXT,
  HDL_MD5SUM  TEXT
);
SQL
      @db = SQLite3::Database.new("#{@db_file}")      
      # make db file ( first execution only )
      begin
        printf("@I:Create Table(%s) in SQLite DB.\n",@table)
        @db.execute(@sql)
      rescue SQLite3::SQLException => ex
        printf(" %s. nothing to do.\n",ex.message)
      rescue SQLite3::BusyException => ex
        printf(" %s. retry.\n",ex.message)
        sleep 10
        retry
      rescue ex
        printf(" %s. Unknown.\n",ex.message)
        p ex
        exit
      end
    end

    #
    # Regist ModuleName/InstanceName/ProductName/DeviceVer
    # 
    def regist( inf )
      module_name = inf[:module_name]
      inst_name = inf[:inst_name]
      product_name = inf[:product_name]
      device_ver = inf[:device_ver]
      ice_ver = inf[:ice_ver]
      ice_ver = "NONE" if ice_ver == nil
      sql = "select  MODULE_NAME, INST_NAME, PRODUCT_NAME, DEVICE_VER, ICE_VER from #{@table}"
      flag = true
      @db.execute(sql).each do |row|
        if row == [module_name,inst_name,product_name,device_ver,ice_ver]
          flag = false 
          break
        end
      end
      # Save
      sql = "insert into #{@table} values (:module_name, :inst_name , :product_name, :device_ver, :ice_ver, :hdl_path, :hdl_md5sum)"
      begin
        if flag
          @db.execute(sql, 
                      :module_name => module_name,
                      :inst_name => inst_name,
                      :product_name => product_name,
                      :device_ver => device_ver,
                      :ice_ver => ice_ver,
                      :hdl_path => nil,
                      :hdl_md5sum => nil
                      ) 
          printf("@I:Make new data in Macro(%s)\n",module_name)
        end
      rescue SQLite3::BusyException => ex
        printf(" %s. retry.\n",ex.message)
        sleep 10
        retry
      rescue => ex
        print " [SQlite3]", ex.message, "\n" if $VERBOSE
        p ex
#        update_hdl( regist )
      end
    end

    #
    # Update Module Date
    #   Add : File Name defined Module
    #         Md5sum of File
    #
    def update(inf)
      module_name = inf[:module_name]
      file_name = inf[:file_name]
      product_name = inf[:product_name]
      device_ver = inf[:device_ver]
      ice_ver = inf[:ice_ver]
      ice_ver = "NONE" if ice_ver == nil
      md5sum = Common.md5sum(file_name)
      sql = "update #{@table} set HDL_PATH = :file_name, HDL_MD5SUM = :md5sum where MODULE_NAME = :module_name and PRODUCT_NAME = :product_name and DEVICE_VER = :device_ver and ICE_VER = :ice_ver"
      begin
        @db.execute(sql, 
                    :module_name => module_name,
                    :product_name => product_name,
                    :device_ver => device_ver,
                    :ice_ver => ice_ver,
                    :file_name => file_name,
                    :md5sum => md5sum,
                    :module_name => module_name
                    )
      rescue SQLite3::BusyException => ex
        printf(" %s. retry.\n",ex.message)
        sleep 10
        retry
      rescue => ex
        print " [SQlite3]", ex.message, "\n" if $VERBOSE
        p ex
        #        update_hdl( regist )
      end
    end
  end

  #
  # ICECommon - save macro information(ICEMacro,ReplaceMacro/PortBuffer) to SQLite3-DB
  #
  public
  class ICECommon
    def initialize(inf)
      db_file = inf[:db_file]
      db_file = "rl78.db" if db_file.nil?

      @table = "ICECommon"

      @db_file = FICE_DATA + "/db/" + db_file

      @sql = <<SQL
create table #{@table}(
  VERILOG_FILE TEXT,
  VERILOG_DEFINE TEXT,
  HDL_MD5SUM  TEXT,
  DEFINE_MD5SUM TEXT,
  XML_DATA BLOB
);
SQL
      @db = SQLite3::Database.new("#{@db_file}")      
      # make db file ( first execution only )
      begin
        printf("@I:Create Table(%s) in SQLite DB.\n",@table)
        @db.execute(@sql)
      rescue SQLite3::SQLException => ex
        printf(" %s. nothing to do.\n",ex.message)
      rescue SQLite3::BusyException => ex
        printf(" %s. retry.\n",ex.message)
        sleep 10
        retry
      rescue ex
        printf(" %s. Unknown.\n",ex.message)
        p ex
        exit
      end
    end

    #
    # get  VERILOG_FILE,VERILOG_DEFINE,HDL_MD5SUM,XML_DATA
    #
    def get( inf )
      verilog_file = inf[:verilog_file]
      verilog_define = inf[:verilog_define]
      hdl_md5sum = inf[:hdl_md5sum]
      define_md5sum = inf[:define_md5sum]

      sql = "select * from #{@table}"
      @db.execute(sql).each do |row|
        return row[4] if row[0..3] == [verilog_file,verilog_define,hdl_md5sum,define_md5sum]
      end
      return nil
    end

    #
    #
    # 
    def regist(inf)
      # Save
      sql = "insert into #{@table} values (:verilog_file,:verilog_define,:hdl_md5sum,:define_md5sum,:xml_data)"
      begin
        @db.execute(sql, 
                    :verilog_file => inf[:verilog_file],
                    :verilog_define => inf[:verilog_define],
                    :hdl_md5sum => inf[:hdl_md5sum],
                    :define_md5sum => inf[:define_md5sum],
                    :xml_data => inf[:xml_data]
                    ) 
        printf("@I:Make new data in %s\n",@table)
      rescue SQLite3::BusyException => ex
        printf(" %s. retry.\n",ex.message)
        sleep 10
        retry
      rescue => ex
        print " [SQlite3]", ex.message, "\n" if $VERBOSE
        p ex
        #        update_hdl( regist )
      end
    end   
  end



  #
  # Connect Path
  #
  class ConnectPath
    attr_accessor :Path
    attr_accessor :Index
    attr_accessor :Num
    attr_accessor :SavedPath
    def initialize
      @Path = Array.new
      @num_prev = 0
      @Num = 0  # Array Number always increment
      @base = nil
      @indent_prev = 0
      @SavedPath = Array.new
    end

    def addNode(node,num)
      eachPath = Array.new

      # sequential connection
      tmp = Array.new
      if num == 0
        eachPath << node
      else
        tmp = @SavedPath[num-1]
        tmp = tmp +  [node]
        eachPath = tmp
      end
      @SavedPath[num] = eachPath

      # New Save
      @Path[@Num] = eachPath
      @num_prev = num
      @Num += 1
    end
    
    def getConnectInf(conf_db,depth=2)      
      result = Array.new
      @Path.each do |path|
        tmp = Array.new
        each_path = path.last
        if conf_db != nil && conf_db.ADD_MODIFY_INST != nil
          if conf_db.ADD_MODIFY_INST.index(each_path.InstName) != nil
            next
          end
        end
        tmp << each_path.ModuleName
        tmp << each_path.InstName
        tmp << each_path.Name
        result << tmp
=begin
        path.each_with_index do |each_path,i|
          tmp = Array.new
          if i == depth - 1
            tmp << each_path.ModuleName
            tmp << each_path.InstName
            tmp << each_path.Name
            result << tmp
          end
        end
=end
      end
      return result
    end
  end
  
  class PathTree
	ERRFMT = "%s isn't a tree member"
    
	def initialize(ary = nil)
      @children = Hash.new([])
      @parents = Hash.new([])
      self << ary if ary
	end
    
	def include?(item)
      @parents.has_key?(item) || @children.has_key?(item)
	end
    
	def <<(ary)
      parent = nil
      ary.each do |x|
        if parent
          @children[parent] += [x] unless @children[parent].include?(x)
          @parents[x] += [parent] unless @parents[x].include?(parent)
        end
        parent = x
      end
	end
    
	def sibling(item)
      if @parents.has_key?(item)
        @children[@parents[item][0]] - [item]
      elsif @children.has_key?(item)	# top
        []
      else
        raise ERRFMT % item
      end
	end
    
	def is_brother?(one, another)
      raise ERRFMT % another unless include?(another)
      sibling(one).include?(another)
	end
	alias is_sister? is_brother? 
    
	def depth(item)
      raise ERRFMT % another unless include?(item)
      depth = 0
      while @parents[item] != []
        item = @parents[item][0]
        depth += 1
      end
      depth
	end
    
	def is_descendant?(one, another)	# is one a descendant of another?
      return false if is_brother?(one, another)
      return false if depth(one) < depth(another)
      while @parents[one] != []
        return true if @parents[one][0] === another
        one = @parents[one][0]
      end
      false
	end
    
	def is_ancestor?(one, another)	# is one an ancestor of another ?
      is_descendant?(another, one)
	end
    
	def relationship(one, another)
      return "brother or sister" if is_brother?(one, another)
      return "ancestor" if is_ancestor?(one, another)
      return "descendant" if is_descendant?(one, another)
      return "unknown relation"
	end
    
	def roots
      @children.keys - @parents.keys
	end
    
	def children(item)
      if @children.has_key?(item)
        @children[item]
      elsif @parents.has_key?(item)
        []
      else
        raise ERRFMT % item
      end
	end

	def parents(item)
      if @parents.has_key?(item)
        @parents[item]
      elsif @children.has_key?(item)
        []
      else
        raise ERRFMT % item
      end
	end
    
	def to_s(limit = nil, fmt = "%s+- %s\n", indent = "  ")
      @fmt = fmt
      @indent = indent
      @limit = nil
      @limit = @indent * limit if limit
      result = ""
      roots.each do |x|
        result += _subtree(x, "")
      end
      result
	end
    
    private
	def _subtree(node, depth)
      result = @fmt % [depth, node]
      depth += @indent
      return result + @fmt % [depth, "..."] if @limit && @limit < depth
      @children[node].each do |x|
        if @children.has_key?(x)
          result += _subtree(x, depth)
        else
          result += @fmt % [depth, x]
        end
      end
      result
	end
  end
  
  #
  # Connect Log
  #  - managment for Circuit Information
  public
  class CircuitInf


    # Macro Infoformation
    #  - name : Module Name
    #  - 
    class MacroInf
      def initialize(module_name,type)
        @module_name = module_name
        @type = type
      end
    end

    #
    # Connect Information
    #
    class ConnectInf
      def initialize(base_module,connect_file_type,connect_file,target)
        @connect_file_type = connect_file_type
        @base_module = base_module
        @connect_file = connect_file
        @target = target
      end
    end


    def initialize
      @MacroData = Hash.new
      @ConnectData = Hash.new
    end

    # Add Macro Info
    def add_macro(inst_inf)
      # Print Message
      inst_inf.print
      printf("Macro Type     : %s\n",inst_inf.MacroType)
      # Save Data
      if @MacroData[inst_inf.InstName] != nil
        FMakeMessage::PrintInternalError( :category => "ALL", :no => 0, :file_name => __FILE__, :lineno => __LINE__)
      else
        @MacroData[inst_inf.InstName] = MacroInf.new(inst_inf.ModuleName,inst_inf.MacroType)
      end
    end
    
    # Add Connect Info ( From [Signalinf] to [SignalInf] )
    def add_connect(base,connect_file_type,base_module,connect_file,target)
      if @ConnectData[base] != nil # Defined Same Connection
        old_connect = @ConnectData[base]
        # CONNECT FILE Error
        # OK - old : MOD_CON, new : ADD_MOD_CON
        #      old : INNST_CON, new : ADD_INST_CON
        # NG - other
        unless (old_connect.connect_file_type == "MOD_CON" && connect_file_type == "ADD_MOD_CON ") ||
            (old_connect.connect_file_type == "INST_CON" && connect_file_type == "ADD_INST_CON ") 
          FMakeMessage::PrintInternalError( :category => "ALL", :no => 0, :file_name => __FILE__, :lineno => __LINE__)
        end
      end
      @ConnectData[base] = ConnectInf.new(base_module,connect_file_type,connect_file,target)
    end
    
    # Print Connction
    def print(file=nil)
      p @MacroData
      p @ConnectData
    end
  end


end
public
class ClockControlInf
  attr_accessor :Driver, :Pin, :Hierarchy, :Freq, :Template, :Wire, :SDC, :Comment
  def initialize(inf)
    @Driver = inf[:driver]
    @Pin = inf[:pin]
    @Hierarchy = inf[:hierarchy]
    @Freq = inf[:freq]
    @Template = inf[:template]
    @Wire = nil
    @SDC = nil
    @Comment = nil
  end
end
