require "common"
#
#===Message Module for FMake(Error,Warning,Note)
# All Message Code(expect Information message) execute this module
module FMakeMessage

  # Print Error Message
  #  param  : category - error category, no - error no
  #  return : None( exit program immidiately )
  def PrintError( message )
    $ERROR_CNT += 1
    case message[:category]
    when "OPT"
      case message[:no]
      when 1      # Invalid Execution Mode
        printf("@E: %s%03d : Invalid Exection Mode. You have to specify only \"--startup\" or \"--check\" or \"--config\" option. (opt: %s)\n", 
               message[:category],
               message[:no],
               message[:param],
               )
      when 2      # Invalid Option 
        printf("@E: %s%03d : Invalid option \"%s\"\n", 
               message[:category],
               message[:no],
               message[:all_opt],
               )
      when 3
        printf("@E: %s%03d : \"%s\" does not exist or unreadable.(opt: %s)\n", 
               message[:category],
               message[:no],
               message[:file],
               message[:opt],
               )
      when 4
        printf("@E: %s%03d : Not Found %s. Under %s Mode, you have to describe %s(opt: %s)\n", 
               message[:category],
               message[:no],
               message[:param],
               message[:mode],
               message[:param],
               message[:all_opt],
               )
      when 5
        printf("@E: %s%03d : Not Found %s. Under %s Mode, you have to describe %s. Use \"--%s\" option. (opt: %s)\n", 
               message[:category],
               message[:no],
               message[:param],
               message[:mode],
               message[:param],
               message[:need_opt],
               message[:all_opt],
               )
      when 6
        printf("@E: %s%03d : Not Found %s. you have to describe %s(opt: %s)\n", 
               message[:category],
               message[:no],
               message[:param],
               message[:param],
               message[:all_opt],
               )
      when 7
        printf("@E: %s%03d : Not Found %s. you have to describe %s. Use \"--%s\" option. (opt: %s)\n", 
               message[:category],
               message[:no],
               message[:param],
               message[:param],
               message[:need_opt],
               message[:all_opt],
               )
      end
    when "FILE"
      case message[:no]
      when 20
        printf("@E: %s%03d : Does not exist \"%s\" (%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:param],
               message[:read_file],
               message[:line_no]
               )
      when 21
        printf("@E: %s%03d : Does not exist \"%s\"\n", 
               message[:category],
               message[:no],
               message[:param]
               )
      when 22
        printf("@E: %s%03d : Not Found Top Module(\"%s\") in any Verilog-HDL Files at List file. Please Check Top Module Name or List File.\n", 
               message[:category],
               message[:no],
               message[:module]
               )
      end
    when "XMLParse"
      case message[:no]
      when 50
        printf("@E: %s%03d : Cannot parse \"%s\" file in XMLParse. It may cause Verilog-HDL Syntax Error or V2XML Exection Error.\n", 
               message[:category],
               message[:no],
               message[:param],
               )
      when 60
        printf("@E: %s%03d : \"%s\" treminal is already exist in \"%s\" module. please check Curcuit or ConnectFile(%s[L:%d]).\n", 
               message[:category],
               message[:no],
               message[:pin_name],
               message[:module_name],
               message[:connect_file],
               message[:line_no]
               )
      when 61
        printf("@E: %s%03d : \"%s\" port is already exist in \"%s\" module. please check Curcuit or ConnectFile(%s[L:%d]).\n", 
               message[:category],
               message[:no],
               message[:pin_name],
               message[:module_name],
               message[:connect_file],
               message[:line_no]
               )
      when 62
        printf("@E: %s%03d : \"%s\" instance is already exist in \"%s\" module. please check Curcuit or ConfFile(%s) about %s.\n", 
               message[:category],
               message[:no],
               message[:inst_name],
               message[:module_name],
               message[:conf_file],
               message[:inst_name],
               )
      when 63
        printf("@E: %s%03d : \"%s\" port-connection is already exist in \"%s\" module. please check Curcuit or ConnectFile(%s[L:%d]).\n", 
               message[:category],
               message[:no],
               message[:pin_name],
               message[:module_name],
               message[:connect_file],
               message[:line_no]
               )
      when 64
        printf("@E: %s%03d : \"%s\" wire is already exist in \"%s\" module. please check Curcuit.\n", 
               message[:category],
               message[:no],
               message[:pin_name],
               message[:module_name]
               )
      when 65
        printf("@E: %s%03d : \"%s\" port does not found in  \"%s\" module. please check Curcuit.\n", 
               message[:category],
               message[:no],
               message[:pin_name],
               message[:module_name]
               )
      when 66
        printf("@E: %s%03d : Not found \"%s\" module in any files. please check Curcuit.\n", 
               message[:category],
               message[:no],
               message[:module_name]
               )
      when 67
        printf("@E: %s%03d : Found multiple Modules(%s). Please check list file.\n",
               message[:category],
               message[:no],
               message[:mod]
               )
      end
    when "CONF"
      $DEBUG = false
      case message[:no]
      when 100,101        
        printf("\n@E: %s%03d : Syntax Error \"%s\" (%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:line],
               message[:file],
               message[:line_no]
               )
      when 110
        printf("@E: %s%03d : Found unset variable \"%s\" (%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:line],
               message[:file],
               message[:line_no]
               )
      when 111
        $DEBUG = false
        printf("\n")
        printf("@E: %s%03d : Multiple defined same instance name \"%s\" (%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:inst],
               message[:file],
               message[:line_no]
               )
      when 112
        printf("@E: %s%03d : Not Found conf file \"%s\" in this path.\n", 
               message[:category],
               message[:no],
               message[:conf_file],
               )
      when 120
        printf("@E: %s%03d : Found same definition name \"%s\" in same instance group. (%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:reserved],
               message[:file],
               message[:line_no]
               )        
      when 130
        printf("@E: %s%03d : Found unsupported macro type \"%s\"(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:type],
               message[:file],
               message[:line_no]
               )        
      when 131
        printf("@E: %s%03d : In \"%s\" MacroType, do not describe definition word \"%s\".(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:type],
               message[:val],
               message[:file],
               message[:line_no]
               )        
      when 132
        printf("\n")
        printf("@E: %s%03d : In \"%s\" MacroType(%s), Require at least one CON File(MOD_CON/INST_CON).(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:type],
               message[:inst_name],
               message[:file],
               message[:line_no]
               )        
      when 133
        printf("\n")
        printf("@E: %s%03d : In \"%s\" MacroType(%s), Require both MODULE_NAME and VRILOG_FILE.(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:type],
               message[:inst_name],
               message[:file],
               message[:line_no]
               )       
      when 134
        printf("@E: %s%03d : In \"%s\" MacroType(%s), Require VRILOG_FILE.(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:type],
               message[:inst_name],
               message[:file],
               message[:line_no]
               )       
      when 135
        printf("@E: %s%03d : Not Found \"%s\" module in \"%s\" file at Replace Macro. Please check module name and/or Verilog-HDL file.(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:module_name],
               message[:verilog_file],
               message[:conf_file],
               message[:line_no]
               )       
      when 136
        printf("@E: %s%03d : Not Found \"%s\" instance in \"%s\" file at Replace Macro. Please check instance name and/or Verilog-HDL file.(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:inst_name],
               message[:verilog_file],
               message[:conf_file],
               message[:line_no]
               )       
      when 137
        printf("@E: %s%03d : Not Found VerilogList File. Please Check Conf file.\n", 
               message[:category],
               message[:no]
               )       
      when 138
        printf("@E: %s%03d : Not Found VerilogList file \"%s\" in this path.\n", 
               message[:category],
               message[:no],
               message[:file],
               )
      when 139
        printf("@E: %s%03d : Not Found \"%s\" module in Circuit. Please Check Conf File(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:mod_name],
               message[:conf_file],
               message[:line_no]
               )       
      when 140
        printf("@E: %s%03d : Not Found \"%s\" instance in Circuit. Please Check Conf File(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:inst_name],
               message[:conf_file],
               message[:line_no]
               )       
      when 141
        printf("@E: %s%03d : Not Found \"%s\" module in Circuit. Please Check \"TOP_MODULE\" in Conf File(%s) or List File\n", 
               message[:category],
               message[:no],
               message[:top_module],
               message[:conf_file]
               )       
      end
    when "CONNECT"
      case message[:no]
      when 200
        printf("@E: %s%03d : Syntax Error \"%s\" (%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:line],
               message[:file],
               message[:line_no]
               )
      when 201
        printf("@E: %s%03d : Found multiple-defined about \"%s\" (%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:pin_name],
               message[:file],
               message[:line_no]
               )
      when 210
        printf("@E: %s%03d : Not Found connect information about  \"%s\" (%s). For add macro(%s), need connect information for all signals.\n", 
               message[:category],
               message[:no],
               message[:pin_name],
               message[:module_name],
               message[:module_name]
               )
      when 211
        printf("@E: %s%03d : PULLUP/PULLDOWN indication is allowed only INPUT signal. But, the direction of \"%s\" signal is \"%s\", please change connection or check circuit(%s)\n", 
               message[:category],
               message[:no],
               message[:pin_name],
               message[:direction],
               message[:verilog]
               )
      when 212
        printf("@E: %s%03d : OPEN indication is allowed only OUTPUT/INOUT signal. But, the direction of \"%s\" signal is \"%s\", please change connection or check circuit(%s)\n", 
               message[:category],
               message[:no],
               message[:pin_name],
               message[:direction],
               message[:verilog]
               )
      when 213
        printf("@E: %s%03d : Found not support attribute \"%s\" (%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:attr],
               message[:file],
               message[:line_no]
               )
      when 218
        printf("\n")
        printf("@E: %s%03d : Cannot analyze connection about \"%s\" signal that maybe Drive Change signal. please check circuit or Connect File(%s)\n", 
               message[:category],
               message[:no],
               message[:port_name],
               message[:con_file]
               )
      when 220
        printf("\n")
        printf("@E: %s%03d : Not found target macro \"%s\" at Connect File. please check circuit or Connect File(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:target],
               message[:con_file],
               message[:line_no]
               )
        # Dont Stop in this case
        return
      when 221
        printf("@E: %s%03d : Not found target port/internal-wire \"%s\" in \"%s\" module. please check circuit or Connect File(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:target_port],
               message[:target_module],
               message[:con_file],
               message[:line_no]
               )
        # Dont Stop in this case
        return
      when 222
        printf("@E: %s%03d : Port Direction mismatch.  Base Port \"%s\" in \"%s\" is %s, and Connect Port \"%s\" in \"%s\" is %s.(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:base_port],
               message[:base_module],
               message[:base_direction],
               message[:target_port],
               message[:target_module],
               message[:target_direction],
               message[:con_file],
               message[:line_no]
               )
        # Dont Stop in this case
        return
      when 223
        printf("@E: %s%03d : Mismatch Port Size.  The bus-size of Base Port \"%s\" at \"%s\" module is %d bit , but the bus-size of Base Port \"%s\" at \"%s\" module is %d bit(%s[L:%d])\n", 
               message[:category],
               message[:no],
               message[:base_port],
               message[:base_module],
               message[:base_size],
               message[:target_port],
               message[:target_module],
               message[:target_size],
               message[:con_file],
               message[:line_no]
               )
        # Dont Stop in this case
        return
      when 224
        printf("@E: %s%03d : Not found connect information to %s.%s in Connect File(%s). You have to assign to connect information about this port.\n", 
               message[:category],
               message[:no],
               message[:inst_name],
               message[:pin_name],
               message[:conf_file]
               )
      when 300
        printf("@E: %s%03d : Now, not support multi signal connection in instance-port at Port:%s, Module:%s defined Connect File(%s[L:%d])\nThis function will be supported at FICE future version.\n", 
               message[:category],
               message[:no],
               message[:target_port],
               message[:target_module],
               message[:con_file],
               message[:line_no]
               )
        printf("Please Check about \".AAA({A1,B1,C2})\" description in verilog. This circuit is not supported yet.\n")
      end
    when "VerilogList"
      $DEBUG = false
      case message[:no]
      when 500
        printf("\n@E: %s%03d : VerilogToXML has finished with error(s). Please see XML File(%s)\n", 
               message[:category],
               message[:no],
               message[:xml]
               )
        
      end
    end
    unless $DEBUG
      Common.print_summary
      exit 1
    end
  end

  # For Warning Message
  def PrintWarning( message )
    $WARNING_CNT += 1
    case message[:category]
    when "XMLParse"
      #
      # XMLParse.rb
      #
      case message[:no]
      when 1
        # Not found module
        printf("@W: %s%03d : Not found any module\n", 
               message[:category],
               message[:no],
               message[:file_name],
               message[:lineno]
               )
      when 2
        # Not found terminal
        printf("@W: %s%03d : Not found any terminal in %s module\n", 
               message[:category],
               message[:no],
               message[:module_name],
               message[:file_name],
               message[:lineno]
               )
      when 3
        # Not found target module
        printf("@W: %s%03d : Not found %s in %s module, so cannnot add %s\n", 
               message[:category],
               message[:no],
               message[:add_port],
               message[:module_name],
               message[:add_port],
               )
      when 4
        # Not found target module or delete port
        printf("@W: %s%03d : Cannot execute %s delete operation, because not found \"%s\" in \"%s\" module.\n", 
               message[:category],
               message[:no],
               message[:target],
               message[:add_port],
               message[:module_name],
               )
      when 5
        # Not found target port
        printf("@W: %s%03d : Not found connect information %s.%s in %s module.please check it.\n", 
               message[:category],
               message[:no],
               message[:inst],
               message[:port],
               message[:module],
               )
      when 6
        # Not Support Prameterize Bit-Width
        printf("@W: %s%03d : Not support Parameterized Bit-Width in wire definition. So, FMake assign 1-BitWidth about %s signal\n", 
               message[:category],
               message[:no],
               message[:port],
               )
      when 66
        printf("\n@W: %s%03d : Not found \"%s\" module in any files. please check Curcuit.\n", 
               message[:category],
               message[:no],
               message[:module_name]
               )
      end
    when "FMakeLogic"
      case message[:no]
      when 100
        printf("@W: %s%03d : \"%s\" already exists. Overwrite file.\n", 
               message[:category],
               message[:no],
               message[:filename]
               )
      end
    when "CONNECT"
      case message[:no]
      when 210
        printf("@W: %s%03d : Not Found connect information about  \"%s\" (%s). For add macro(%s).\n", 
               message[:category],
               message[:no],
               message[:pin_name],
               message[:module_name],
               message[:module_name]
               )
      end
    when "OPT"
      case message[:no]
      when 300
        printf("@W: %s%03d : Not Found \"%s\" instance in this circuit. Please remove this instance in ADD_MODIFY_INST option or edit.\n",
               message[:category],
               message[:no],
               message[:modify_inst]
               )
      end
    when "Conf"
      case message[:no]
      when 400
        printf("@W: %s%03d : Not Found Veriog-HDL about \"%s\" in any files at List File. Cannot generate Remove Macro HDL, So use MacroControl File.\n",
               message[:category],
               message[:no],
               message[:mod]
               )
      end
    end
  end

  # For Note Message
  def PrintNote( message )
    $NOTE_CNT += 1
    case message[:category]
    when "XMLParse"
      case message[:no]
      when 1
        printf("@N: %s%03d : %s already exist in this path. Overwrite in this file.\n", 
               message[:category],
               message[:no],
               message[:param],

               )
      when 6
        # Not Support Prameterize Bit-Width
        printf("@N: %s%03d : Not support Parameterized Bit-Width in wire definition. So, FMake assign 1-BitWidth about %s signal\n", 
               message[:category],
               message[:no],
               message[:port],
               )
      when 66
        printf("\n@N: %s%03d : Not found \"%s\" module in any files. Cannot get Port Information about this module. please check Curcuit.\n", 
               message[:category],
               message[:no],
               message[:module_name]
               )
      end
    when "CONNECT"
      case message[:no]
      when 210
        printf("@N: %s%03d : Not Found connect information about  \"%s\" (%s). For add macro(%s).\n", 
               message[:category],
               message[:no],
               message[:pin_name],
               message[:module_name],
               message[:module_name]
               )
      end
    end
  end
  
  def PrintInternalError( message )
    $INTERNAL_ERROR_CNT += 1
    case message[:category]
    when "ALL"
      case message[:no]
      when 0
        printf("InternalError: %s%03d : Not implemented this function. [%s:%d]\n", 
               message[:category],
               message[:no],
               message[:file_name],
               message[:lineno]
               )
      end
    when "FICE_DB"
      #
      # FICE_DB.rb
      #
      case message[:no]
      when 10
        printf("InternalError: %s%03d : \"Type\" member expect input/output/inout/wire/reg/mem, but decribe \"%s\".[%s:%d]\n", 
               message[:category],
               message[:no],
               message[:param],
               message[:file_name],
               message[:lineno]
               )
      when 11
        printf("InternalError: %s%03d : \"BusPortion\" and \"MSB/LSB\" dont describe in sambe data.[%s:%d]\n", 
               message[:category],
               message[:no],
               message[:file_name],
               message[:lineno]
               )
      end
    when "XMLParse"
      #
      # XMLParse.rb
      #
      case message[:no]
      when 0
        # Cannnot analyze XML
        printf("InternalError: %s%03d : Cannot analyze XML Data at [%s:%d]\n", 
               message[:category],
               message[:no],
               message[:file_name],
               message[:lineno]
               )
      when 1
        # Unexpected XML Syntax
        printf("InternalError: %s%03d : Found Unsupported XML Data at [%s:%d]\n", 
               message[:category],
               message[:no],
               message[:file_name],
               message[:lineno]
               )
      when 2
        # File doesnt Read
        printf("InternalError: %s%03d : Cannot read \"%s\" file at [%s:%d]\n", 
               message[:category],
               message[:no],
               message[:param],
               message[:file_name],
               message[:lineno]
               )
      when 3
        # Not found module
        printf("InternalError: %s%03d : Not found any module at [%s:%d]\n", 
               message[:category],
               message[:no],
               message[:file_name],
               message[:lineno]
               )
      when 4
        # Constant analyze error
        printf("InternalError: %s%03d : Not found any module at [%s:%d]\n", 
               message[:category],
               message[:no],
               message[:file_name],
               message[:lineno]
               )
      when 100
        # BusPortion Error
        printf("InternalError: %s%03d : %s [%s:%d]\n", 
               message[:category],
               message[:no],
               message[:comment],
               message[:file_name],
               message[:lineno]
               )
      end
    when "FMakeLogic"
      #
      # FMakeLogic.rb
      #
      case message[:no]
      when 20
        printf("InternalError: %s%03d : Found unexpected macro-Type \"%s\".[%s:%d]\n", 
               message[:category],
               message[:no],
               message[:param],
               message[:file_name],
               message[:lineno]
               )
      when 21
        printf("InternalError: %s%03d : Found unexpected Pin-Type \"%s\".[%s:%d]\n", 
               message[:category],
               message[:no],
               message[:param],
               message[:file_name],
               message[:lineno]
               )
      end
    end
    Common.print_summary
    exit
  end

  # Open Message function
  module_function :PrintError
  module_function :PrintWarning
  module_function :PrintNote
  module_function :PrintInternalError
end
