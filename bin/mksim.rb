#!/usr/bin/ruby
############################################################
#
#  mksim ( genrate simulation environment  for ICE )
#
#   Author    : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#   Date      : 2009/12/08
#   Version   : 0.1
#
############################################################
#
# [Usage]
# Usage :ruby mksim.rb  
#  OPTION
#    -h/-help     : print help message
#    -v/-version  : print version
#    -verbose     : execute on verbose mode
#
# [Function]
#  
#
# [Output file]
#
# [Sub file]
#  ~/bin/common.rb  : for common function
#       /system.rb  : for system function
#       /report.rb  : for analizing report file
#       /pinlist.rb : for analizing pinlist file
#       /connect.rb : for analizing connect file
#
############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "message"
require "system"
require "common"
require "report"
require "pinlist"
require "connect"

$TOOL    = "mksim"
$VERSION = "0.1-beta"
$VERBOSE = false

$ERROR_CNT   = 0
$WARNING_CNT = 0
$NOTE_CNT    = 0

class MKSIM
  
  # 
  # initialize
  #
  def initialize

  end

  #
  # print ussage
  #
  def print_usage
    printf("\n")
    printf("Usage :ruby %s.rb \n",$TOOL)
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
      when '-report1' then
        @Report1File = ARGV[i+1]
        i += 1
      when '-report2' then
        @Report2File = ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        end
      end
    end 

    # Check Argument
    check_argument
    
    # Check File
    check_file


  end

  #
  # CheckArgument
  #
  def check_argument
  end
  
  #
  # CheckFile
  #
  def check_file
  end

  #
  # Error routine
  #
  def error
    print_usage
    Common.print_summary
    exit
  end

  #
  # 
  # main
  #
  def main
    get_argument                    # get argument & check parameter/file
    Common.print_summary
  end
end

mksim = MKSIM.new
mksim.main
