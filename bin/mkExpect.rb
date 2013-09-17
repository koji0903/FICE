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
# - 2. Generate Template-ExpectFile
#
# [Usage]
# -%ruby mkExpect.rb -parts [PARTS file] [Option]
# If you want to get more information. plese use "-h" option.
#
# [EXAMPLE]
# -ruby mkExpect.rb -parts parts.para_hdl
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
$SUB_TOOL        = "mkExpect" # Tool Name
$VERBOSE         = false      # Verbose Mode
$ERROR_CNT       = 0          # Error Count for tool summary
$WARNING_CNT     = 0          # Warning Count for tool summary
$NOTE_CNT        = 0          # Note Count for tool summary
$MESSAGE         = false

$MODE            = "Each"  # Each/All(default "Each")

#
# Main Class
#
class GetInst
  EXPECT_DIR          = "GoldenExpect"
  TEMPLETE_EXPECT_DIR = "TemplateExpect"
  GOLDEN_EXPECT_DIR   = "/home/product/div-micom-ice/data/proj/78K0R/Common/CCGolden/trunk"

  # For Information
  class InstanceInfo
    attr_accessor :InstanceName
    attr_accessor :ModuleName
    attr_accessor :Type           # Soft or Hard ( reserved )
    attr_accessor :ExpectFile
    attr_accessor :ExpectType     # Copied / Already / None
    attr_accessor :Saved          # where saved ( Golden / Template )
    def initialize
      @InstanceName = nil
      @ModuleName = nil
      @Type = nil
      @ExpectFile = nil
      @ExpectType = nil
      @Saved = "Template"
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

    @current =  Dir.pwd
    @GoldenExpectDir = GOLDEN_EXPECT_DIR
    @ExpectDir = @current + "/" + EXPECT_DIR
    @TempExpectDir = @current + "/" + TEMPLETE_EXPECT_DIR

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
    printf("    \n")
  end

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  private
  def get_argument
    golden_flag = false
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
        @PARTS_FILE = ARGV[i+1]
        i += 1
      when '-golden' then
        golen_flag = true
        @GoldenExpectDir = ARGV[i+1]
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
    if golden_flag == true
      $NOTE_CNT += 1
      printf("@N:GolenExpect directory was changed to \"%s\"\n",@GoldenExpectDir)
    else
      printf("@I:GolenExpect directory : \"%s\"\n",@GoldenExpectDir)
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
  def generate_templete_expect
    # Expect File
    dir_name = @TempExpectDir
    Common.make_dir("#{dir_name}",1)

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
        comment = " Expect file for " + inst.InstanceName + "(" + inst.ModuleName + ")"  
        Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
        printf("   generate %s\n",file_name)
        f.printf("I:%s %s\n",inst.InstanceName,inst.ModuleName)
        f.printf("E\n")
        f.printf("\n")
        f.close
      }
    end
    
  end

  #
  # Update Expect File
  #  If there is expect file in GoldenExpect dir, save it in Expect dir.
  #  Otherwise, copy expect file which saved TmEpxpect to Expect dir.
  #
  def update_expect
    # Expect File
    dir_name = @ExpectDir
    Common.make_dir("#{dir_name}",1)
    printf("\n")
    printf("Search Expect Golden File...\n")
   
    # Copy from GoldenExpect
    printf("@I:Copy from Golden Expect dir \"%s\"\n",@GoldenExpectDir)
    writed_file = Array.new
    @InstInfo.sort_by{|inst|
      inst.ModuleName
    }.each{|inst|
      file_list = Array.new
      # Search File by ModuleName
      full_path = Dir.glob("#{@GoldenExpectDir}/#{inst.ModuleName}.expect").to_s
      if full_path.size != 0
        file_name = File.basename(full_path,".expect")
        file_name = @ExpectDir + "/" + inst.InstanceName + "(" + file_name + ").expect"
        # Dont apply overwrite
        if FileTest.exist?("#{file_name}") == true && writed_file.index("#{file_name}") == nil
          $WARNING_CNT += 1
          printf("@W:Already exist \"%s\"in %s dir. do not overwrite.\n",File.basename("#{file_name}"),File.basename("#{@ExpectDir}"))
          inst.ExpectType = "Already"
        else
          printf("Module:%-25s( inst name : %s ):Copy expect file from CCGolden to Expect\n",inst.ModuleName,inst.InstanceName)
          file_cp("#{full_path}","#{file_name}",inst)
          writed_file << file_name
          inst.ExpectType = "Copied"
        end
        inst.Saved = "Golden"
      else
        $WARNING_CNT += 1
        printf("@W:Not found about \"%s\" in %s dir.\n",inst.ModuleName,File.basename("#{@ExpectDir}"))
        inst.ExpectType = "None"
        inst.Saved = "Template"
      end
    }    
  end
  
  def file_cp(org_file,new_file,inst)
    output_file = Array.new
    f = open("#{new_file}","w")
    File.open("#{org_file}").each{|line|
      # Replace Instance Name
      tmp = line.split(":")
      case tmp[0]
      when "I"
        tmp = tmp[1].split
        org_inst_name =  tmp[0]
        line = line.sub("#{org_inst_name}","#{inst.InstanceName}")
      when "M"
        tmp = tmp[1].split # Get Target signal path
        tmp = tmp[0].split(".")
        org_inst_name = tmp[tmp.size-2]
        line = line.sub("#{org_inst_name}","#{inst.InstanceName}")
      end
      f.printf("%s",line)
    }
    f.close
  end

  def generate_report
    Common.make_dir("result")
    file_name = "result/mkExpect.report"
    report = open("#{file_name}","w")
    comment = "Report file" 
    Common.print_file_header(report,"#{comment}",$SUB_TOOL,$VERSION,"##")
    # Report
    # print summary
    report.printf("\n")
    report.printf("# para file\n") 
    report.printf("       %s\n",@PARTS_FILE)
    report.printf("\n")
    report.printf("# total number of instance\n")
    report.printf("       %d\n",@InstInfo.size)
    report.printf("\n")
    # sort & print
    report.printf("# Expect File List : Copied from %s\n",@GoldenExpectDir)
    inst_inf = Array.new
    @InstInfo.each{|inst|
      if inst.ExpectType == "Copied"
        inst_inf << inst
      end
    }
    if inst_inf.size == 0
      report.printf("  None\n")
    else
      make_table(report,inst_inf) 
    end
    report.printf("\n")

    report.printf("# Expect File List : Already exist in %s\n",@ExpectDir)
    inst_inf = Array.new
    @InstInfo.each{|inst|
      if inst.ExpectType == "Already"
        inst_inf << inst
      end
    }
    if inst_inf.size == 0
      report.printf("  None\n")
    else
      make_table(report,inst_inf) 
    end
    report.printf("\n")

    report.printf("# Expect File List : No-exist in %s\n",@GoldenExpectDir)
    inst_inf = Array.new
    @InstInfo.each{|inst|
      if inst.ExpectType == "None"
        inst_inf << inst
      end
    }
    if inst_inf.size == 0
      report.printf("  None\n")
    else
      make_table(report,inst_inf) 
    end
    report.printf("\n")


    report.close

  end

  #
  # make Table
  #
  def make_table(report,inst_inf)
    report.printf("+--+------------------+------------------------+------------------------------------------+\n")
    report.printf("|No|    Instance Name |            Module Name |                         Expect File Name |\n")
    report.printf("+--+------------------+------------------------+------------------------------------------+\n")
    i = 1
    inst_inf.sort_by{|a|
      a.ExpectType
      a.InstanceName
    }.each{|inst|
      report.printf("|%2d| %16s | %22s | %40s |\n",i, inst.InstanceName, inst.ModuleName,File.basename("#{inst.ExpectFile}"))
      i += 1
    }
    report.printf("+--+------------------+------------------------+------------------------------------------+\n")
  end
  

  #
  # generate Instance/ModuleName List
  #
  def generate_list
    file_name = "product.lst"
    lst = open("#{file_name}","w")
    comment = "Product list of Expect file for ProductCC" 
    Common.print_file_header(lst,"#{comment}",$SUB_TOOL,$VERSION,"##")
    @InstInfo.each{|inst|
      lst.printf("%s:%s\n",File.basename("#{inst.ExpectFile}"),inst.Saved)
    }
    lst.close
  end

  #
  # Main Function
  #  1. 
  #  2. 
  #
  public
  def main
    Common.print_base
    get_argument
    get_inst
    generate_templete_expect
    update_expect
    generate_report
    generate_list
    Common.print_summary
  end

end


if __FILE__ == $0
  inst = GetInst.new
  inst.main
end
