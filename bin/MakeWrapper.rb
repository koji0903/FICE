#!/usr/bin/ruby
#############################################################
#
# MakeWrapper
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009,2010 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Descripton of this tool
#
# [Usage]
# -%ruby MakeWrapper --verilog [TargetFile] --module [TopModuleName] --bus [ChangeBusSignal]
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
require "XMLParse"

#
# Global Setting
#
$SUB_TOOL        = "MakeWrapper" # Tool Name
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
class MakeWrapper
  
  def initialize
    @org = nil
    @TopModule = nil
    @BusSignal = Array.new
    @ChangeInf = Hash.new
  end

  class BusSignal
    attr_accessor :MSB
    attr_accessor :LSB
    def initialize(msb,lsb)
      @MSB = msb
      @LSB = lsb
    end
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
      opt.on('--verilog [Verilog-HDL]','Verilog-HDL'){|v| @org = v}
      opt.on('--module  [TopModuleName]','Top Module name'){|v| @TopModule = v}
      opt.on('--bus     [ChangeBus]','Signal name that change form bit to Bus'){|v| @BusSignal = v.split(",")}
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

    # Get Original PortData
    if @TopModule != nil
      top_module = @TopModule
    else
      top_module = "ICE_TOP"
    end
    
    `VerilogToXML #{@org} > tmp.xml`
    root = XMLParse::read("tmp.xml")
    File.delete("tmp.xml")
    port_list = XMLParse::get_PortList(root,top_module)

    port_list.each do |name,inf|
      /^([a-zA-Z_]*)(\d*)/ =~ name
      name = $1
      bit = $2.to_i
      if name != nil && bit != nil
        if @BusSignal.index("#{name}") !=  nil
          if  @ChangeInf[name] == nil
            @ChangeInf[name] = BusSignal.new(bit,bit)
          else
            current_data = @ChangeInf[name]
            if bit > current_data.MSB
              current_data.MSB = bit
            end
            if bit < current_data.LSB
              current_data.LSB = bit
            end
          end
        end
      end
    end
      
    # Make Wrapper
    wrapper = File.basename(@org,".v") + "_wrapper.v"
    printf("@I:generate %s\n",wrapper)
    f = open(wrapper,"w")
    Common.print_file_header(f,"Verilog Wrapper File","MakeWrapper",$VERSION,"//")
    f.print <<EOB
module\t#{top_module}_wrapper (
EOB
    
    # Print Terminal
    already = Hash.new
    port_list.keys.sort_by do |name|
      name
    end.each_with_index do |name,i|
      /^([a-zA-Z_]*)(\d*)/ =~ name
      new_name = $1
      bit = $2.to_i
      if @ChangeInf[new_name] == nil
        if i == 0
          f.print "\t #{name}\n"
        else
          f.print "\t,#{name}\n"
        end
      else
        if already[new_name] == nil
          if i == 0
            f.print "\t #{new_name}\t// Change Bit2Bus\n"
          else
            f.print "\t,#{new_name}\t// Change Bit2Bus\n"
          end          
          already[new_name] = "Already"
        end
      end
    end
    f.print"\t);\n\n"

    # Print Port
    already = Hash.new
    port_list.sort_by do |name|
      name
    end.each do |name,inf|
      /^([a-zA-Z_]*)(\d*)/ =~ name
      new_name = $1
      bit = $2.to_i
      if @ChangeInf[new_name] == nil
        if inf.MSB == nil && inf.LSB == nil
        f.print "\t#{inf.Type}\t#{name};\n"
        else
          f.print "\t#{inf.Type}\t[#{inf.MSB}:#{inf.LSB}]\t#{name};\n"
        end
      else
        if already[new_name] == nil
          current_data = @ChangeInf[new_name]
          f.print "\t#{inf.Type}\t[#{current_data.MSB}:#{current_data.LSB}]\t#{new_name};\n"
          already[new_name] = "Already"
        end
      end
    end
    
    # Make Instance
    f.print "\n\n"
    f.print "\t#{top_module} #{top_module.downcase}(\n"
    port_list.sort_by do |name|
      name
    end.each_with_index do |name,i|
      /^([a-zA-Z_]*)(\d*)/ =~ name[0]
      new_name = $1
      bit = $2.to_i
      if @ChangeInf[new_name] == nil
        if i == 0
          f.print "\t\t .#{name[0]}(#{name[0]})\n"
        else
          f.print "\t\t,.#{name[0]}(#{name[0]})\n"
        end
      else
        current_data = @ChangeInf[new_name]
        if i == 0
          f.print "\t\t .#{name[0]}(#{new_name}[#{bit}])\n"
        else
          f.print "\t\t,.#{name[0]}(#{new_name}[#{bit}])\n"
        end
      end
    end    
    f.print "\t);\n"

    f.print <<EOB


endmodule
EOB
    f.close


    Common.print_summary
  end
  
end


if __FILE__ == $0
  wrapper = MakeWrapper.new
  wrapper.main
end
