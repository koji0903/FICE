#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-

#
# Convert form TopMaker if file to make_chip pins file
#

$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"
require "optparse"


#
# Global Setting
#
$SUB_TOOL        = "if2pin" # Tool Name
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
class IF2PIN
  
  def initialize
    @IF_FILE = nil
    @OUTPUT = nil
    @PRODUCT = nil

    @Signal = Hash.new
  end

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  public
  def get_argument
    opt = OptionParser.new
    begin
#      opt.on('--verbose',"verbose mode"){|v| $VERBOSE = true}
      opt.on('--i [TopMaker if-file]','TopMaker if file'){|v| @IF_FILE = v}
      opt.on('--o [output Pins file]','Pins file for make_chip'){|v| @OUTPUT = v}
      opt.on('--product [Product name]','Product name'){|v| @PRODUCT = v}
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:Not support  "#{ARGV}" option or need argument using this option.
EOB
      return false
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
    if @IF_FILE == nil || @OUTPUT == nil ||@PRODUCT == nil
      printf "ERROR(Invalid Option or non-enough argument)\n"
      exit
    end
    open(@IF_FILE).each do |line|
      line = line.strip
      next if line[0] == ?#
      next if line.split[0] == "PORT" && line.split[1] == "I/O" && line.split[2] == "TYPE"
      case line.split[1]
      when "I"
        @Signal["#{line.split[0]}"] = "IN"
      when "O"
        @Signal["#{line.split[0]}"] = "OUT"
      when "B"
        @Signal["#{line.split[0]}"] = "IO"
      end
    end

    f = open("#{@OUTPUT}","w")
    f = open("#{@OUTPUT}","w")
    comment = "Pins file for make_chip execution"
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"//")
    f.printf("INCLUDE_FILE: %s 1.00\n",@PRODUCT)
    f.printf("\n")
    @Signal.each do |name,direction|
      f.printf("PIN:\t%s\tTYPE\t%s\n",name,direction)
      f.printf("END_PIN:\n\n")
    end
    f.printf("END_INCLUDE_FILE:\n")
    f.close

    Common.print_summary
  end
  
end


if __FILE__ == $0
  if2pin = IF2PIN.new
  if2pin.main
end
