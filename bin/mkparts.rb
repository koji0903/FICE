#!/usr/bin/ruby
##################################################################
#
#  mkparts
#
#  Function : make parts-parameter file for make_chip at pre_chip
#
#  Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#  Date     : Dec 14, 2009
#  Version  : 0.0.2
#
###################################################################
#
# [USAGE]
# %ruby mkparts.rb -I <Original Parts file> -O <New Parts file>
#
# [FUNCTION]
#   make parts-parameter file for make_chip at pre_chip, which is
#   refferd original parts file, the DB of "DeviceMacro" 
#   infomation and ${FMAKE}/lib/parts.conf
#
#   It refferd usable macro name from original parts file,
#   and collect macro name. In next step, mkparts compare the 
#   information of macro name and its of parts.conf, which have
#   the operation judgement( replace, keep, need ) of each macro.
# 
#   If some macro need replacement, mkparts get the information
#   from inf file save in Device Macro Database. 
#
#   At last, generate new parts-parameter file for make_chip.
#   You can use it for operating pre_chip.
#   
# [INPUT FILE(s)]
#   - original parts-parameter file from Device
#
# [OUTPUT FILE(s)]
#   - new parts-parameter file
#
# [Internal use file]
#   - FICE/conf/parts.conf
#   - DeviceMacro/macro.inf
#
###################################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "system"
require "common"
require "parts"
require "parts_conf"
require "macro_inf"

$TOOL    = "mkparts"
$VERSION = "0.1"
$VERBOSE = false

$ERROR_CNT   = 0
$WARNING_CNT = 0
$NOTE_CNT    = 0

$FICE_WORK = "/home/2007H1/cf6fs90_disk0503/product/ice/work/koji-h/work/MyProj"
$DB_DeviceMacro = "/DeviceMacro/trunk"

class MKPARTS

  #
  # initialize
  #
  def initialize
    
    # for parts.conf
    @mkparts_path = __FILE__ 
    @CONF_FILE = File::dirname("#{@mkparts_path}") + "/../conf/parts.conf"
    @CONF_DATA = Array.new

    # for macro.inf
    @INF_FILE = nil
    @INF_DATA = Array.new
    @INFData  = Hash.new

    # for PARTS file
    @ORG_PARTS_FILE = nil # from argument
    @NEW_PARTS_FILE = nil # from argument
    @VERILOG_ADD_NET = Array.new # for "VERILOG_ADD_NET" info

    # Internal operation
    @NEW_PARTS_DATA = Array.new

    # from Original Parts Data
    @ORG_PARTS = Hash.new
    @ORG_INSInfo = Hash.new

    # for conf
    @CONFInfo = Hash.new

  end

  #
  # print ussage
  #
  def print_usage
    printf("\n")
    printf("Usage :ruby %s.rb -I <Original Parts file> -O <New Parts file>\n",$TOOL)
    printf(" OPTION\n")
    printf("    -h/-help     : print help message\n")
    printf("    -v/-version  : print version\n")
    printf("    -verbose     : execute on verbose mode\n")
    printf("    \n")
  end

  # 
  #  Get Argument
  #
  def get_argument
    size = ARGV.size
    size -= 1
    for i in 0..size
      case ARGV[i]
      when '-h','-help' then
        Common.print_base
        print_usage
        exit
      when '-v','-version' then
        Common.print_base
        printf("")
        exit
      when '-verbose' then
        $VERBOSE = true
      when '-I', '-i' then
        @ORG_PARTS_FILE = ARGV[i+1]
        i += 1
      when '-O', '-o' then
        @NEW_PARTS_FILE = ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        end
      end
    end 

    check_argument
  end

  #
  # check arugment
  #
  def check_argument
    printf("@I:check_argument\n")
    $ERROR_CNT += Common.chk_argument("-I/-i",@ORG_PARTS_FILE)
    if $ERROR_CNT 
      printf("[Option Info]\n")
      Common.print_argument("-I/-i",@ORG_PARTS_FILE)
      Common.print_argument("-O/-o",@NEW_PARTS_FILE)
    else
      error
    end
  end

  #
  # analize_parts
  #
  def analize_parts
    printf("@I:analize parts file\n")
    parts = Parts.new(@ORG_PARTS_FILE)
    parts.main
    @ORG_PARTS,@ORG_INSInfo  = parts.Parts, parts.INSInfo

    # verbose
    if $VERBOSE
      printf("\@ORG_PARTS\n")
      p @ORG_PARTS
      printf("\@ORG_INSInfo\n")
      p @ORG_INSInfo
    end
  end

  #
  # alalize_conf
  #
  def analize_conf
    printf("@I:analize parts configuration file\n")
    parts_conf = PartsConf.new(@CONF_FILE)
    parts_conf.main
    @CONFInfo = parts_conf.CONFInfo
    p @CONFInfo if $VERBOSE
  end

  #
  # analize_inf
  #
  def analize_inf
    printf("@I:analize inf file\n")
    inf_path = $FICE_WORK + $DB_DeviceMacro
    @INF_FILE = inf_path + "/macro.inf"
    macro_inf = MacroInf.new("#{@INF_FILE}")
    macro_inf.main
    @INFData = macro_inf.INFData
    p @INFData if $VERBOSE
  end

  def gen_parts
    file_name = @NEW_PARTS_FILE
    printf("@generate %s file\n",file_name)
    f = open("#{file_name}","w")
    comment = "New parts file for ICE make_chip\n\/\/   refferd %s" + @ORG_PARTS_FILE
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"//")

    # print "INCLUDE" Header info
    f.printf("\nINCLUDE_FILE: %s %s\n\n",@ORG_PARTS.Product,@ORG_PARTS.Version)
    # print "MACRO" info
    @ORG_INSInfo.each{|ins_name,ins_info|
      if @CONFInfo.key?("#{ins_info.ModuleName}")
        conf_info = @CONFInfo.fetch("#{ins_info.ModuleName}")

        case conf_info.Identifier
        when "D" then # Delete Macro
          printf("%s  - delete\n",ins_name) if $VERBOSE
          f.printf("// %s (deleted)\n\n",ins_name)
        when "K" then # Keep Macro
          printf("%s  - unchange\n",ins_name) if $VERBOSE
          f.printf("// %s (unchanged)\n",ins_name)
          f.printf("INS: %s %s TYPE %s\n",ins_name,conf_info.ModuleName,ins_info.ModuleType)
          ins_info.Macro.each{|each_macro|
            f.printf("\sMACRO: %s %s\n",each_macro.Type,each_macro.File)
          }
          f.printf("END_INS:\n\n")

        when "C" then # Change Macro
          printf("%s  - change\n",ins_name) if $VERBOSE
          # pre-operation for changed name macro
          module_name = nil
          if conf_info.ChangeName == nil
            module_name = conf_info.ModuleName
          else
            module_name = conf_info.ChangeName
          end
          # data from inf file
          if @INFData.key?(module_name)
            inf_data = @INFData.fetch("#{module_name}")
            f.printf("// %s (changed)\n",ins_name)
            f.printf("INS: %s %s TYPE %s\n",ins_name,module_name,ins_info.ModuleType)
            inf_data.each{|each_macro|
              # data separete include "VERILOG_ADD_NET" in parts info.
              if each_macro.Parts == "VERILOG_ADD_NET"
                @VERILOG_ADD_NET << each_macro
              else
                f.printf("\sMACRO: %s %s\n",each_macro.Parts,each_macro.FileName)
              end
            }
            f.printf("END_INS:\n\n")
          else
            printf("@Internal error. (file:%s,line:%s)",__FILE__,__LINE__)
          end
        else
          printf("@Internal error. (file:%s,line:%s)",__FILE__,__LINE__)
        end
      else
        printf("@I:Not found %s in parts.conf file.so, not resolve macro type.\n")
        printf("   please update parts.conf file\n")
        error
      end
    }

    # write "VERILOG_ADD_NET"
    f.printf("//\n")
    f.printf("// \"VERILOG_ADD_NET\" MACRO\n")
    f.printf("//\n")
    files = Array.new
    @VERILOG_ADD_NET.each{|each_macro|
      files << each_macro.FileName
    }
    files.uniq!
    files.each{|file|
      f.printf("MACRO: VERILOG_ADD_NET %s\n",file)
    }
    @ORG_PARTS.Macro.each{|each_macro|
      f.printf("MACRO: %s %s\n",each_macro.Type,each_macro.File)
    }
    
    f.printf("\nEND_INCLUDE_FILE:\n")

    f.close


  end
  #
  # operation
  #
  def operation
    unsupported_macro = Array.new
    # execute all macro using originl parts file
    @ORG_INSInfo.each_value{|macro_info|
      # search macro info conf file
      if @CONFInfo.key?(macro_info.ModuleName)
        @NEW_PARTS_DATA <<  @CONFInfo.fetch(macro_info.ModuleName)
      else
        unsupported_macro << macro_info.ModuleName
      end  
    }
    # Exist unsupported macro
    if unsupported_macro.size != 0
      printf("@I: There are unsupported macro. plese update parts.conf file and DeviceMacro Database\n")
      printf("The list of Unsupported Macro\n")
      unsupported_macro.each{|name|
        printf("   - %s\n",name)
      }
      exit 1
    end
  end

  #
  # 
  # main
  #
  def main
    printf("@I:execute mkparts\n")
    get_argument                    # get argument & check parameter/file
    analize_parts
    analize_conf
    analize_inf
    operation
    gen_parts
    Common.print_summary
  end

  #
  # Error operation
  #
  def error
    print_usage
    Common.print_summary
    exit 1
  end

end


mkparts = MKPARTS.new
mkparts.main
