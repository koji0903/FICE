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
$SUB_TOOL        = "PartsMod" # Tool Name
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
class PARTS_MOD
  
  def initialize
    @IF_FILE = nil
    @OUTPUT = nil
    @PRODUCT = nil

    @DATA = Array.new

    @ModuleList = Hash.new
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
      opt.on('--i Original Parts','Original Parts file name'){|v| @IF_FILE = v}
      opt.on('--o Modified Parts','Modified Parts file name'){|v| @OUTPUT = v}
      opt.on('--product TopMaker if','Product Name'){|v| @PRODUCT = v}
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
    dirname = nil
    # Get Dir Name
    open(@IF_FILE).each do |line|
      if /MACRO/ =~ line
        file_name =  line.strip.split[2]
        dirname = File.dirname("#{file_name}")
        break
      end
    end

    Dir::glob("#{dirname}/*").each do |file|
      open("#{file}").each do |line|
        if /^module\s*(\w+|_)\s*/ =~ line.strip
          @ModuleList["#{$1}"] = file
        end
      end
    end if dirname != nil

    open(@IF_FILE).each do |line|
      # Special
      line = line.gsub("QLK0RCPU0V4","QLK0RCPUEVA0V4")

      if /^INCLUDE_FILE:/ =~ line
        line = "INCLUDE_FILE: " + @PRODUCT + " 1.00\n"
      end
      if /MACRO/ =~ line
        file_name =  line.strip.split[2]
        basename = File.basename("#{file_name}",".*")
        if @ModuleList["#{basename}"] == nil
          $WARNING_CNT += 1
          printf("@W:Not found HDL about %s module in %s\n",basename,dirname)
        else
          converted = @ModuleList["#{basename}"]
          @DATA << "\t//" + line.strip + " //-- Modified by " + $SUB_TOOL + " --//\n"
          line = line.gsub("#{file_name}","#{converted}")
        end
      end
      @DATA << line
    end
    
    f = open("#{@OUTPUT}","w")
    f = open("#{@OUTPUT}","w")
    comment = "Modified parts.para"
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"//")
    @DATA.each do |line|
      f.printf("%s",line)
    end
    f.close

    Common.print_summary
  end
  
end


if __FILE__ == $0
  parts = PARTS_MOD.new
  parts.main
end
