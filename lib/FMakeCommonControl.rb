########################################################################
#
# FMakeSetting - Operation for Setting File
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
########################################################################
#
#  Module Name : FMakeSetting
#  
#  [Input]
#    - 
#  [Output]
#    - FMake Conf file refledted Logic Analyze
# 
########################################################################

module FMakeCommonControl
  # For ReplaceMacro
  attr_accessor :MacroControlFile
  class Macro
    def initialize
      @MacroControlFile = nil
      @macro_inf = Array.new
    end
    def get
#      file = FICE_DB::FICE_DATA + "/conf/MacroControl.conf" 
      @MacroControlFile = FICE_DB::SETTINGS_PATH + "/MacroControl.conf" 
      printf("@I:read Macro Configuration File(%s)\n",@MacroControlFile)
      open(@MacroControlFile).each do |line|
        next if line == "" || line[0] == "#" || line == "\n"
        line = line.split[0]
        p line if $VERBOSE
        inf = line.strip.split(",")
        category = inf[0]
        case category
        when "RE","PB"
          replace_file_name = inf[1] + "_ICE.v"
          replace_con_name = inf[1] + "_ICE.con"
          replace_module_name = inf[1] + "_ICE"
          device_module_name = inf[1]
          device_inst_name = nil
          device_file_path = inf[2]
          device_file_md5sum = inf[3]
        when "IM","EM","PM"
          replace_file_name = inf[2]
          replace_con_name = inf[3]
          replace_module_name = inf[1]
          device_module_name = "NONE"
          device_inst_name = nil
          device_file_path = "NONE"
          device_file_md5sum = "NONE"
        when "RM"
          replace_file_name = "NONE"
          replace_con_name = "NONE"
          replace_module_name = "NONE"
          device_module_name = inf[1]
          device_inst_name = inf[2]
          device_file_path = "NONE"
          device_file_md5sum = "NONE"
        when "KK"
          replace_file_name = "NONE"
          replace_con_name = "NONE"
          replace_module_name = "NONE"
          device_module_name = inf[1]
          device_inst_name = nil
          device_file_path = "NONE"
          device_file_md5sum = "NONE"
        when "KC"
          replace_file_name = "NONE"
          replace_con_name = inf[1] + ".con"
          replace_module_name = "NONE"
          device_module_name = inf[1]
          device_inst_name = nil
          device_file_path = "NONE"
          device_file_md5sum = "NONE"
        else
        end
        macro = MacroInf.new(
                             :category => category,
                             :replace_file_name => replace_file_name,
                             :replace_con_name => replace_con_name,
                             :replace_module_name => replace_module_name,
                             :device_module_name => device_module_name,
                             :device_inst_name => device_inst_name,
                             :device_file_path => device_file_path,
                             :device_file_md5sum => device_file_md5sum
                             )
        @macro_inf << macro
      end
      print_inf if $VERBOSE
    end
    def print_inf
      printf("  +--+---------------------------+---------------------------+---------------------------+----------------------------------+\n")
      printf("  |  | Replace File Name         | Replace Module Name       | Device Module Name        | MD5SUM of Supported Macro        |\n")
      printf("  +--+---------------------------+---------------------------+---------------------------+----------------------------------+\n")
      @macro_inf.each do |each_macro|
        printf("  |%s| %-25s | %-25s | %-25s | %-32s |\n",
               each_macro.CATEGORY,
               each_macro.REPLACE_FILE_NAME,
               each_macro.REPLACE_MODULE_NAME,
               each_macro.DEVICE_MODULE_NAME,
               each_macro.DEVICE_FILE_MD5SUM
               )
      end
      printf("  +--+---------------------------+---------------------------+---------------------------+----------------------------------+\n")
=begin
      printf("  +------------------------------------------------------+---------------------------+---------------------------+\n")
      printf("  | Replace File Name        (  Connect File     )       | Replace Module Name       | Org Module Name           |\n")
      printf("  +------------------------------------------------------+---------------------------+---------------------------+\n")
      @macro_inf.each do |each_macro|
        printf("  | %-25s(%-25s) | %-25s | %-25s |\n",
               each_macro.REPLACE_FILE_NAME,
               each_macro.REPLACE_CON_NAME,
               each_macro.REPLACE_MODULE_NAME,
               each_macro.DEVICE_MODULE_NAME
               )
#               each_macro.DEVICE_FILE_MD5SUM
      end
      printf("  +------------------------------------------------------+---------------------------+---------------------------+\n")
=end
    end
    def search(device_module_name,device_inst_name,device_file_md5sum)
      same_module = Array.new
      same_inst   = Array.new
      @macro_inf.each do |each_macro|
        same_module << each_macro if device_module_name == each_macro.DEVICE_MODULE_NAME
      end
      @macro_inf.each do |each_macro|
        same_inst << each_macro if device_inst_name.split(".").last == each_macro.DEVICE_INST_NAME
      end
      if same_module == []
        if same_inst != []
          same_inst.each do |each_macro|
            if each_macro.CATEGORY == "RM"
              return "RM_Candidate",nil
            end
          end
          return same_module
        else
          return same_module
        end
      else
        same_module.each do |each_macro|
          if each_macro.CATEGORY == "RM" || each_macro.CATEGORY == "KK"
            return each_macro.CATEGORY,nil 
          elsif  each_macro.CATEGORY == "KC"
            return each_macro.CATEGORY,each_macro.REPLACE_CON_NAME
          else
            if device_file_md5sum == each_macro.DEVICE_FILE_MD5SUM || each_macro.DEVICE_FILE_MD5SUM == "ANY"
              return each_macro.CATEGORY,each_macro.REPLACE_MODULE_NAME, each_macro.REPLACE_FILE_NAME, each_macro.REPLACE_CON_NAME 
            end
          end
        end
        # Unmatch
        return "Unmatch MD5SUM",nil,nil
      end
    end
    def get_ICEMacro
      @macro_inf.each do |each_macro|
        if each_macro.CATEGORY == "IM"
          return each_macro
        end
      end
      return nil
    end
    def get_EmulationMacro
      macro = Array.new
      @macro_inf.each do |each_macro|
        if each_macro.CATEGORY == "EM"
          macro << each_macro
        end
      end
      return macro
    end
    def get_ProductMacro
      macro = Array.new
      @macro_inf.each do |each_macro|
        if each_macro.CATEGORY == "PM"
          macro << each_macro
        end
      end
      return macro
    end
    class MacroInf
      attr_accessor :CATEGORY
      attr_accessor :REPLACE_FILE_NAME
      attr_accessor :REPLACE_CON_NAME
      attr_accessor :REPLACE_MODULE_NAME
      attr_accessor :DEVICE_MODULE_NAME
      attr_accessor :DEVICE_INST_NAME
      attr_accessor :DEVICE_FILE_PATH
      attr_accessor :DEVICE_FILE_MD5SUM
      def initialize(inf)
        @CATEGORY = inf[:category]
        @REPLACE_FILE_NAME = inf[:replace_file_name]
        @REPLACE_CON_NAME = inf[:replace_con_name]
        @REPLACE_MODULE_NAME = inf[:replace_module_name]
        @DEVICE_MODULE_NAME = inf[:device_module_name]
        @DEVICE_INST_NAME = inf[:device_inst_name]        
        @DEVICE_FILE_PATH = inf[:device_file_name]
        @DEVICE_FILE_MD5SUM = inf[:device_file_md5sum]
      end
    end
  end
end
