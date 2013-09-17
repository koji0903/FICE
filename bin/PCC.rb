#!/usr/bin/ruby
#############################################################
#
# GetInst
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009,2010 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - 1. Get all-instance name from parts file
# - 2. Generate Templete-ExpectFile
#
# [Usage]
# -%ruby PCC.rb -golden [GoldenExpect] [Option]
# If you want to get more information. plese use "-h" option.
#
# [EXAMPLE]
# -example
#
# [Output]
# -filename
#
# [History]
# -history
#
#############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "fileutils"

require "FICE_def"
require "system"
require "common"

#
# Global Setting
#
$SUB_TOOL        = "PCC" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$MESSAGE         = false

$MODE            = "Each"  # Each/All(default "Each")

#
# Main Class
#
class GetInst
  GOLDEN_EXPECT_PATH = "/home/product/div-micom-ice/data/proj/78K0R/Common/CCGolden"

  # For Information
  class InstanceInfo
    attr_accessor :InstanceName
    attr_accessor :ModuleName
    attr_accessor :Type
    attr_accessor :ExpectFile
    def initialize
      @InstanceName = nil
      @ModuleName = nil
      @Type = nil
      @ExpectFile = nil
    end
    def add(each_info)
      @InstanceName = each_info[1]
      @ModuleName = each_info[2]
      @Type = each_info[4]
    end
  end

  def initialize
    @PARTS_FILE=nil
    @lineno=0
    @sentense=nil
    @InstInfo = Array.new

    @GoldenExpectDir = GOLDEN_EXPECT_PATH
    @TmpExpectDir = nil

    @DEV_OPT = nil
    @ICE_OPT = Array.new
    @report = nil
  end


  #
  # Print Tool Usage
  #
  private
  def print_usage
    printf("\n")
    printf("Usage : ruby %s.rb [Option]\n",$SUB_TOOL)
    printf(" OPTION\n")
    printf("\t-h/-help         : print help message\n")
    printf("\t-v/-version      : print version\n")
    printf("\t-verbose         : execute on verbose mode\n")
    printf("\t-goden           : GoldenExpect dir name\n")   
    printf("\t-parts           : make_chip parts file\n")
    printf("\t-ice             : make_chip report files for ICE\n")
    printf("\t-device          : make_chip report files for Device\n")
    printf("\t-mode            : mode for ConnectChecker(All[default]/Each)\n")
    printf("    \n")
  end

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  private
  def get_argument
    ice_flag = false
    size = ARGV.size
    i = 0
    while i < size
      case ARGV[i]
      when '-h','-help' then
        print_usage
        exit
      when '-v','-version' then
        printf("")
        exit
      when '-verbose' then
        $VERBOSE = true
      when '-parts' then
        ice_flag = false
        @PARTS_FILE = ARGV[i+1]
        i += 1
      when '-mode' then
        $MODE = ARGV[i+1]
        i += 1
      when '-golden' then
        @GoldenExpectDir = ARGV[i+1]
        i += 1
      when '-device' then
        ice_flag = false
        @DEV_OPT = ARGV[i+1]
        i += 1
      when '-ice' then
        ice_flag = true
        @ICE_OPT << ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        else
          @ICE_OPT << ARGV[i] if ice_flag
        end
      end
      i += 1
    end 
    
    if @PARTS_FILE == nil
      $ERROR_CNT += 1
      printf("@E:\"PARTS FILE\" was not specified.\n")
      print_usage
      Common.error
    end
    if @ICE_OPT == nil
      $ERROR_CNT += 1
      printf("@E:\"-ice\" option was not specified.\n")
      print_usage
      Common.error
    end
    if @DEV_OPT == nil
      $ERROR_CNT += 1
      printf("@E:\"-device\" option was not specified.\n")
      print_usage
      Common.error
    end
    if @GoldenExpectDir == nil
      $ERROR_CNT += 1
      printf("@W:\"-golden option\" was not spedified.\n")
      print_usage
      Common.error
    end
    
    Common.chk_file("-parts",@PARTS_FILE)
  end
  
  #
  # Get Inst Name
  #
  private
  def get_inst
    File.open("#{@PARTS_FILE}").each{|line|
      line.strip!
      # Search "INS" line
      @sentense = line
      @lineno += 1
      if /^INS:/ =~ line
        # INS Format: "INS: [Instance name] [Module name] TYPE [Type]"
        each_info = line.split
        # Error Check
        error_check(each_info)
        
        # Get detail
        inst_each = InstanceInfo.new
        inst_each.add(each_info)
        @InstInfo << inst_each
      end
    }

  end

  #
  # error check
  #
  def error_check(info)
    if info[0] != "INS:" || info[3] != "TYPE" || !(info[4] == "SOFT" || info[4] == "HARD")
      $ERROR_CNT +=1
      printf("@E:%s:%d:Unexpeded format",@sentense,@lineno)
      exit
    end
  end

  #
  # generate
  #
  private
  def generate_expect
    # Expect File
    @TmpExpectDir = "TmpExpect" 
    dir_name = @TmpExpectDir
    Common.make_dir("#{dir_name}")

    case $MODE
    when "All"
      file_name = dir_name.to_s + "/product.expect" 
      f = open("#{file_name}","w")
      comment = "Expect file for ConnectChecker" 
      Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")
      printf("@I:generate %s\n",file_name)
      @InstInfo.each{|inst|
        f.printf("I:%s\n",inst.InstanceName)
        f.printf("E\n")
        f.printf("\n")
      }
      f.close
    when "Each"
      @InstInfo.each{|inst|
        file_name = dir_name.to_s + "/" + inst.InstanceName + "(" + inst.ModuleName + ").expect" 
        inst.ExpectFile = file_name
        f = open("#{file_name}","w")
        comment = "Execute file for ConnectChecker" 
        Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")
        printf("   generate %s\n",file_name)
        f.printf("I:%s %s\n",inst.InstanceName,inst.ModuleName)
        f.printf("E\n")
        f.printf("\n")
        f.close
      }
    end


    # Report
    # print summary
    @report.printf("\n")
    @report.printf("[para file] %s\n",@PARTS_FILE)
    @report.printf("[total number of instance] %d\n",@InstInfo.size)
    @report.printf("\n")
    # sort & print
    @report.printf("[InstanceList]\n")
    @report.printf("+--+---------------------+-------------------------+\n")
    @report.printf("|No|        Instance Name|              Module Name|\n")
    @report.printf("+--+---------------------+-------------------------+\n")
    i = 1
    @InstInfo.sort_by{|a|
      a.InstanceName
    }.each{|inst|
      @report.printf("|%2d| %19s | %23s |\n",i, inst.InstanceName, inst.ModuleName)
      i += 1
    }
    @report.printf("+--+---------------------+-------------------------+\n")
  end

  # 
  # Generate Shell script for runnning ConnectChecker
  #
  def generate_shell
    # shell
    file_name = "run_All.sh"
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    f.printf("#\!\/bin\/sh\n")
    comment = "Run Script for ConnectChecker" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")
    f.printf("FICE=%s\n",File.dirname(__FILE__))
    f.printf("CONNECT_CHECKER=\$\{FICE\}\/ConnectChecker.rb\n")
    f.printf("\n")
    f.printf("for EXPECT_FILE in \\\n")
    case $MODE
    when "All"
      f.printf("           %s\/product.expect \\\n",dir_name)
    when "Each"
      @InstInfo.sort_by{|a|
        a.InstanceName
      }.each{|inst|
        f.printf("           %s \\\n",inst.ExpectFile.gsub("\(","\\\(").gsub("\)","\\\)"))
      }
    end
    f.printf("\n")
    f.printf("do\n")
    ice_opt = ""
    @ICE_OPT.each{|str|
      ice_opt = ice_opt + " " + str
    }
    f.printf("\truby -w \$\{CONNECT_CHECKER\} -expect \$\{EXPECT_FILE\} -device %s -ice %s\n",@DEV_OPT,ice_opt)
    f.printf("\done\n")
    f.close
    FileUtils.chmod(0744,"#{file_name}")
  end

  #
  # Update Expect File
  #  If there is expect file in GoldenExpect dir, save it in Expect dir.
  #  Otherwise, copy expect file which saved TmpExpect to Expect dir.
  #
  def update_expect
    # Expect File
    @ExpectDir = "Expect"
    dir_name = @ExpectDir
    Common.make_dir_with_delete("#{dir_name}")
    @report.printf("\n")
    @report.printf("Search Expect Golden File...\n")
    
    # Copy from GoldenExpect
    printf("@I:Copy from Golden Expect dir \"%s\"\n",@GoldenExpectDir)
    @InstInfo.sort_by{|inst|
      inst.ModuleName
    }.each{|inst|
      file_list = Array.new
      # Search File by ModuleName
      file_list = Dir.glob("#{@GoldenExpectDir}/*\(#{inst.ModuleName}\).expect")
      if file_list.size != 0
        @report.printf("  Module:%-25s( Inst:%-15s):Copy expect file from CCGolden to Expect\n",inst.ModuleName,inst.InstanceName)
      else
        @report.printf("  Module:%-25s( Inst:%-15s):Not found expect file in CCGolden\n",inst.ModuleName,inst.InstanceName)
      end
    }
=begin
    Dir.glob("#{@GoldenExpectDir}/*.expect").each{|file|
      FileUtils.cp("#{file}","#{@ExpectDir}")
      @report.printf("  Copied from %s to %s\n",file,@ExpectDir)
    }
    @report.printf("Done\n\n")

    # Copy from TmpExpect
    printf("@I:Copy from Tmp Expect dir \"%s\"\n",@TmpExpectDir)
    Dir.glob("#{@TmpExpectDir}/*.expect").each{|file|
      if File.file?(@ExpectDir+"/"+File.basename("#{file}"))
        @report.printf("  %-40s: Already Exist in %s dir\n",File.basename("#{file}"),@ExpectDir)
      else
        FileUtils.cp("#{file}","#{@ExpectDir}")
        @report.printf("  %-40s: Copy to %s dir\n",File.basename("#{file}"),@ExpectDir)
      end
    }
    @report.printf("Done\n\n")
    
    file_name = "product.expect"
    product = open("#{file_name}","w")
    
    # make one Expect File ( cat )
    Dir.glob("#{@ExpectDir}/*.expect").each{|file|
      File.open("#{file}").each{|line|
        product.printf("%s",line)
      }
    }

    product.close
=end
    
  end
  
  #
  # Main Function
  #  1. 
  #  2. 
  #
  public
  def main
    file_name = "PCC.report"
    @report = open("#{file_name}","w")
    comment = "Report file" 
    Common.print_file_header(@report,"#{comment}",$SUB_TOOL,$VERSION,"##")

    Common.print_base
    get_argument
    get_inst
    generate_expect
    generate_shell
    update_expect
    Common.print_summary

    @report.close
  end

end


if __FILE__ == $0
  inst = GetInst.new
  inst.main
end
