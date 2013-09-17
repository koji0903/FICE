#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-
#############################################################
#
# Templete
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009-2012 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Descripton of this tool
#
# [Usage]
# -%ruby templete.rb
# If you want to get more information. plese use "--help" option.
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
require "FICE_def"
require "system"
require "common"
require "optparse"


#
# Global Setting
#
$SUB_TOOL        = "Templete" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
Version          = $VERSION # For OptParse


#
# Main Class
#
class Templete
  
  def initialize
  end

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  public
  def get_argument
    opt = OptionParser.new
    begin
      opt.on('--verbose',"verbose mode"){|v| $VERBOSE = true}
      opt.on('-h','pint help message'){|v|}
      opt.on('-a','desription of -a'){|v|}
      opt.on('-b VAL','description of -b'){|v|}
      opt.on('-c [VAL]','description of -c'){|v|}
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:Not support  "#{ARGV}" option or need argument using this option.
EOB
      return false
    end

    # Print Help if No Argument
    if ARGV.empty?
      puts opt.help
      puts
      exit
    end

    return true
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
    Common.print_summary
  end
  
end


if __FILE__ == $0
  templete = Templete.new
  templete.main
end
