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
# -%ruby ProductCC.rb -device [device report] -ice [ice report]
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
$:.unshift(File.dirname(__FILE__) + "/")
require "fileutils"

require "FICE_def"
require "system"
require "common"
require "ConnectChecker"

#
# Global Setting
#
$SUB_TOOL        = "ProductCC" # Tool Name
#$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$MESSAGE         = false

$MODE            = "Each"  # Each/All(default "Each")

#
# Main Class
#
class ProductCC

  def initialize
    @DEV_OPT = Array.new
    @ICE_OPT = Array.new
    @report = nil

    @GoldenExpectDir = "GoldenExpect"
    @TemplateExpectDir = "TemplateExpect"

    @FileList = Array.new
    @ProductExpect = Array.new

    @ExpectFile = nil
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
    printf("\t-ice             : make_chip report files for ICE\n")
    printf("\t-device          : make_chip report files for Device\n")
    printf("    \n")
  end


  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  public
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
      when '-device' then
        ice_flag = false
        @DEV_OPT = ARGV[i+1].split(",")
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
    
  end
  
  def generate_expect
    # From GoldenExpect
    Dir.glob("#{@GoldenExpectDir}/*.expect").each{|file|
      @FileList << File.basename("#{file}")
      File.open("#{file}").each{|line|
        @ProductExpect << line
      }
    }
    if Dir.glob("#{@GoldenExpectDir}/*.expect").size == 0
      $WARNING_CNT += 1
      printf("@W:Not found Expect file in %s. Is this correct?\n",@GoldenExpectDir)
    end    
    # From TempleteExpect
    Dir.glob("#{@TemplateExpectDir}/*.expect").each{|file|
      if @FileList.index("#{File.basename("#{file}")}") == nil
        @FileList << File.basename("#{file}")
        File.open("#{file}").each{|line|
          @ProductExpect << line
        }
      end
    }
    if Dir.glob("#{@TemplateExpectDir}/*.expect").size == 0
      $WARNING_CNT += 1
      printf("@W:Not found Expect file in %s. Is this correct?\n",@TemplateExpectDir)
    end    

    # Generate "product.expect"
    @ExpectFile = "product.expect" 
    f = open("#{@ExpectFile}","w")
    comment = "Expect file for ConnectChecker" 
    @ProductExpect.each{|line|
      f.printf("%s",line)
    }
    return @ProductExpect
  end
  
  #
  # Run ConnectChecker
  #
  def run_CC
    cc = ConnectChecker.new(@ExpectFile,@DEV_OPT,@ICE_OPT,@ProductExpect)
    cc.run
  end

  #
  # Main Function
  #  1. 
  #  2. 
  #
  public
  def main
    Common.print_base
    # Ruby Version Judgment
    if RUBY_VERSION >= "1.9"
      printf("@E:%s only support Ruby ver : 1.8.X ( Now, executed %s )\n",$SUB_TOOL,RUBY_VERSION)
      printf("   please check your ruby execute setting.")
      $ERROR_CNT += 1
      Common.print_summary
      exit
    end

    get_argument
    generate_expect
    run_CC
    Common.print_summary
  end

end


if __FILE__ == $0
  pcc = ProductCC.new
  pcc.main
end
