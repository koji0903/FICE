#!/usr/bin/ruby
#############################################################
#
# Get SRC
#= get src file from file list
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009,2010 NEC MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Descripton of this tool
#
# [Usage]
# -%ruby get_src.rb -f [FileList] -out_dir [Output Directory]
# If you want to get more information. plese use "-h" option.
#
# [EXAMPLE]
# -%ruby get_src.by -f verilog.f -out_dir src
#
# [Output]
# -filename
#
# [History]
# -new
#
#############################################################
require "fileutils"
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"

#
# Global Setting
#
$TOOL            = "get_src" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$MESSAGE         = false



#
# Main Class
#
class GetSRC
  
  def initialize
    # File list from -f option
    @FILE_LIST = nil
    # Output Directory name form -out_dir option
    @OUT_DIR = nil

  end

  #
  # Print Base Information( Tool name, Version, Copyright )
  #
  private
  def print_base
    printf("%s ver:%s\n",$TOOL,$VERSION)
    printf("Copyright (c) 2009,2010 NEC MicroSystem. All rights reserved.\n\n")
  end

  #
  # Print Tool Usage
  #
  private
  def print_usage
    printf("\n")
    printf("Usage :  %s.rb -f [FileList] -out_dir [OutputDirectory]\n",$TOOL)
    printf(" OPTION\n")
    printf("\t-h/-help         : print help message\n")
    printf("\t-v/-version      : print version\n")
    printf("\t-verbose         : execute on verbose mode\n")
    printf("\t-f               : File list\n")
    printf("\t-out_dir         : Output Directory\n")
    printf("    \n")
  end

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  private
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
      when '-f' then
        @FILE_LIST = ARGV[i+1]
        i += 1
      when '-out_dir' then
        @OUT_DIR = ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        end
      end
    end 

    if @FILE_LIST == nil
      $ERROR_CNT += 1
      printf("@E:\"FILE LIST\" is not specified.\n")
      print_usage
      Common.error
    end
    
    if @OUT_DIR == nil
      $ERROR_CNT += 1
      printf("@E:\"OUT DIR\" is not specified.\n")
      print_usage
      Common.error
    end
    
    if Common.chk_file("-f",@FILE_LIST) == true
      $ERROR_CNT += 1
      printf("@E:\"\" file doesnt find.\n",@FILE_LIST)
      print_usage
      error
    end
  end
  
  #
  # analize file list
  #
  private
  def analize
    data = Common.file_read(@FILE_LIST)
    data.each{|line|
      line = line.strip
      next if /^\/\// =~ line
      next if /^\#/ =~ line
      next if line.size == 0
      # File Copy
      file_name = File.basename("#{line}")
      out = @OUT_DIR + "/" + file_name
      FileUtils.cp("#{line}","#{out}")
    }
  end

  #
  # Main Function
  #  1. 
  #  2. 
  #
  public
  def main
    get_argument
    Common.make_dir(@OUT_DIR)
    analize
    Common.print_summary
  end
  
end


if __FILE__ == $0
  get_src = GetSRC.new
  get_src.main
end
