#!/usr/bin/ruby
##################################################################
#
#  gen_hier
#
#  Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
#  Structure
#   gen_hier.rb
#    +xst.rb
#    +system.rb
#    +common.rb
#
#  History
#   1.0-beta(09/09/02) - New Release
#
#
###################################################################
#
# [OPERATION]
#   Analize hdl files that saved $SRC_DIR and generate hierarchy 
#   file for hier.You can customize $SRC_DIR which is the direcory
#   saved hdl files you want compile and $XST_WORK which is the 
#   direcory saved XST output files, $TOP_MODULE which is the top
#   module descirebie hierarchy file
#
#   Notice: This tool use XST synthesis for analizing circuit structure,
#   So, It may need a great deal of time sometimes. Once synthesis 
#   operation executed and saved xst log file, it skipped next operation.
#
# [USAGE]
#  %gen_hier.rb -top_module $TOP_MODULE {-src_dir $SRC_DIR} {-xst_dir $XST_WORK}
#
# [EXAMPLE]
#  %~/ruby/gen_hier.rb -top_module EVA_TOP -src_dir ./src -xst_dir ./xst_work
#
# [OUTPUT]
#  Hierarchy File ($TOP_MODULE.hier)
#
###################################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"
require "xst"

$TOOL       = "gen_hier"

$SRC_DIR    = "./src"
$XST_WORK   = "./xst_work"
$TOP_MODULE = ""
$VERBOSE    = false

$NOTE_CNT    = 0
$WARNING_CNT = 0
$ERROR_CNT   = 0

#
# Data Class for each module
#
class ModuleInfo
  attr_accessor  :FileType
  attr_accessor  :FileName
  attr_accessor  :ModuleName
  attr_accessor  :InSig        # non-support
  attr_accessor  :OutSig       # non-support
  attr_accessor  :Inst
  attr_accessor  :FileData

  def initialize
    @FileType     = nil
    @FileName     = nil
    @ModuleName   = nil
    @InSig        = Array.new
    @OutSig       = Array.new
    @Inst         = Inst.new
    @FileData     = Array.new
  end
end

class GenHier < System

  #
  # initialize
  #
  def initialize
    @ModuleList = Array.new
    @xst_result = Array.new
    @hier_cnt  = 0
    @ModFile = Hash.new
  end

  #
  # print base
  #
  def print_base
    printf("%s ver:%s\n",$TOOL,$VERSION)
    printf("Copyright (c) 2009 NEC MicroSystem. All rights reserved.\n\n")
  end
  
  #
  # print ussage
  #
  def print_usage
    printf("\n")
    printf("Usage :  %s.rb [OPTION]\n",$TOOL)
    printf(" OPTION\n")
    printf("    -h/-help     : print help message\n")
    printf("    -v/-version  : print version\n")
    printf("    -verbose     : execute on verbose mode\n")
    printf("    -top_module [MODULE] : assign Top Module\n")
    printf("    -src_dir [SRC Dir]   : assign dir that saved src files\n")
    printf("    -xst_dir [XST Dir]   : assign directory that save XST outputs\n")
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
        print_base
        print_usage
        exit
      when '-v','-version' then
        print_base
        printf("")
        exit
      when '-verbose' then
        $VERBOSE = true
      when '-top_module' then
        $TOP_MODULE = ARGV[i+1]
        i += 1
      when '-src_dir' then
        $SRC_DIR = ARGV[i+1]
        i += 1
      when '-xst_dir' then
        $XST_WORK = ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        else
          $CONF_FILE = ARGV[i]
        end
      end
    end 

  end

  #
  # method
  #
  def file_pickup
    printf("@I:Loading all HDL Files saved in %s\n",$SRC_DIR)
    # for *.v
    Dir::glob("#{$SRC_DIR}/*.*"){|file|
      m = ModuleInfo.new
      m.FileType, m.FileName = "Verilog", file
      @ModuleList << m # Update
    }
    # for *.hdl
    Dir::glob("#{$SRC_DIR}/*.*"){|file|
      m = ModuleInfo.new
      m.FileType, m.FileName = "HDL", file
      @ModuleList << m # Update 
    }
  end

  #
  # Analize Circuit using Xilinx XST
  #
  def analize_circuit(file_name,module_name)
    tmp = Array.new
    tmp = file_name.to_a
    xst = XST.new("#{tmp}","#{module_name}","#{$XST_WORK}",@ModFile)
    xst.exe
    xst.get_report
    @xst_result << xst.ModuleInfo
    @xst_result.uniq!
    xst.print if $VERBOSE 
  end

  #
  # read
  #
  def analize
    printf("@I:Analize Circuit\n")
    @add_ModuleList = Array.new
    @ModuleList.each{|m|
      # Get FileData
      m.FileData = Common.file_read("#{m.FileName}")
      # Get ModuleName
      module_set = false
      m.FileData.each{|line|
        if /^module/ =~ line
          if module_set == true # Found Multi Module in same file
            old_mlist = ModuleInfo.new
            old_mlist.FileType = m.FileType
            old_mlist.FileName = m.FileName
            old_mlist.FileData = m.FileData
            old_mlist.ModuleName = m.ModuleName
            @add_ModuleList << old_mlist
          end
          line = line.sub("\t"," ")
          tmp = line.split(" ")
          # Select "ModuleName(" string pattern
          if /\(/ =~ tmp[1] 
            num = tmp[1].index("\(")
            m.ModuleName = tmp[1].unpack("a#{num}").to_s # separate after "(" string
          else
            m.ModuleName = tmp[1].to_s
          end
          module_set = true
        end
      }
    }
    @ModuleList += @add_ModuleList # add module list for mulit module in a file

    # make HashTable(ModuleName->FileName)
    @ModuleList.each{|mod|
      @ModFile["#{mod.ModuleName}"] = mod.FileName
    }

    # Get InstanceName
    i = 1
    @ModuleList.each{|mod|
      file_name = Array.new
      file_name << mod.FileName
      printf("\n") if $VERBOSE
      printf("@I:Synthesis %s module (File:%s)[%d/%d]\n",mod.ModuleName,mod.FileName,i,@ModuleList.size) 
      analize_circuit("#{file_name}","#{mod.ModuleName}")
      i += 1
    }
    print("\n")
  end

  #
  # print_ModuleList
  #
  def print_ModuleList(new)
    scope_pre = ""
    scope = new
    inst_size = 0
    cnt = 0
    @ModuleList.each{|mod|
      if(mod.ModuleName == scope)
        if ( mod.ModuleName == $TOP_MODULE)
          @hier_cnt += 1
          @hier_cnt.times{printf("+")}
          printf("%s(%s)[%s]\n",mod.ModuleName,mod.ModuleName,mod.FileName)
        end
        @xst_result.each{|rep|
          if rep.module_name == mod.ModuleName
            if rep.inst.size == 0
            else
              inst_size = rep.inst.size
              cnt = 0
              rep.inst.each{|inst_info|
                cnt += 1
                @hier_cnt += 1
                @hier_cnt.times{printf("+")}
                printf("%s(%s)[%s]\n",inst_info.InstName,inst_info.ModuleName,inst_info.FileName)
                scope_pre = scope
                scope = inst_info.ModuleName
                print_ModuleList(scope)
              }
            end
          end
        }
      end
    }
    @hier_cnt -= 1
  end


  def write(f,new)
    scope_pre = ""
    scope = new
    inst_size = 0
    cnt = 0
    @ModuleList.each{|mod|
      if(mod.ModuleName == scope)
        if ( mod.ModuleName == $TOP_MODULE)
          @hier_cnt += 1
          @hier_cnt.times{f.printf("+")}
          f.printf("%s(%s)[%s]\n",mod.ModuleName,mod.ModuleName,mod.FileName)
        end
        @xst_result.each{|rep|
          if rep.module_name == mod.ModuleName
            if rep.inst.size == 0
            else
              inst_size = rep.inst.size
              cnt = 0
              rep.inst.each{|inst_info|
                cnt += 1
                @hier_cnt += 1
                @hier_cnt.times{f.printf(" ")}
                f.printf(" +-")
                f.printf("%s(%s)[%s]\n",inst_info.InstName,inst_info.ModuleName,inst_info.FileName)
                scope_pre = scope
                scope = inst_info.ModuleName
                write(f,scope)
              }
            end
          end
        }
      end
    }
    @hier_cnt -= 1
  end


  def write_hier
    if $TOP_MODULE == ""
      $WARNING_CNT += 1
      printf("@W:Don't genereta *.hier file. because $TOP_MODULE was't descirbed\n")
      printf("   If you want to generate hier file. Please use \"-top_module\" option.\n")
    else
      file_name = $TOP_MODULE + ".hier"
      printf("@I:Generate %s file\n",file_name)
      f = File::open("#{file_name}","w")
      
      print_file_header(f,"#{$TOP_MODULE} Hierarchy File",$TOOL,$VERSION)
      write(f,$TOP_MODULE)
      
      f.close
    end
  end

  def exe
    get_argument
    Common.print_base
    # check argument
    if $TOP_MODULE == ""
      $WARNING_CNT += 1
      printf("@W:Don't describe $TOP_MODULE. So execute only synthesis.\n")
    end
    file_pickup
    analize; print("\n")
    #gh.print_ModuleList($TOP_MODULE)
    $hier_cnt = 0
    write_hier
    Common.print_summary
  end

end

gh = GenHier.new
gh.exe
