#!/usr/bin/ruby
#############################################################
#
# VHDLParse
#= 
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009,2010 NEC MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Parsing Input/Output signal in target module written by VHDL 
#
# [Usage]
# -%ruby VHDLParse.rb -f [VHDLFile] -module [ModuleName]
#  If you want to get more information. plese use "-h" option.
#
# [EXAMPLE]
# -%ruby VHDLParse.rb -f CHIP.vhd -module CHIP
#
# [Output]
# -CHIP.v (BlackBox)
#
# [History]
# -history
#
#############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"

#
# Global Setting
#
$SUB_TOOL        = "VHDLParse" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$MESSAGE         = false


#
# Main Class
#
class VHDLParse
  
  def initialize
    # VHDL File Name from Option
    @VHDLFileName = nil
    # Module Name from Option
    @ModuleName = nil

    # Data
    @VHDLData = Array.new

    # For Output
    @ModuleSignalInfo = Array.new
  end

  # Signal DataClass
  class Signal
    attr_accessor :Line
    attr_accessor :Name
    attr_accessor :Direction
    attr_accessor :BitWidth
    attr_accessor :MSB
    attr_accessor :LSB
    def initialize
      @Line = nil
      @Name = nil
      @Direction = nil
      @BitWidth = 0
      @MSB = 0
      @LSB = 0
    end
  end

  #
  # Print Base Information( Tool name, Version, Copyright )
  #
  private
  def print_base
    printf("FICE(%s) ver:%s\n",$SUB_TOOL,$VERSION)
    printf("Copyright (c) 2009,2010 NEC MicroSystem. All rights reserved.\n\n")
  end

  #
  # Print Tool Usage
  #
  private
  def print_usage
    printf("\n")
    printf("Usage :  %s.rb -hier hier.file\n",$SUB_TOOL)
    printf(" OPTION\n")
    printf("\t-h/-help         : print help message\n")
    printf("\t-v/-version      : print version\n")
    printf("\t-verbose         : execute on verbose mode\n")
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
        @VHDLFileName = ARGV[i+1]
        i += 1
      when '-module' then
        @ModuleName = ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        end
      end
    end 
    
    if Common.chk_file("-f",@VHDLFileName) == true
      $ERROR_CNT += 1
      printf("@E:\"\" file doesnt find.\n",@VHDLFileName)
      print_usage
      error
    end
  end
  
  #
  # Operation
  #
  private
  def operation
    # Read File
    @VHDLData = Common.file_read(@VHDLFileName)
    # Parsing
    parse_flag = false
    @VHDLData.each{|line|
      if /#{@ModuleName} /i =~ line
        parse_flag = true if /entity/i =~ line
        parse_flag = false if /end/i =~ line
      end
      if /#{@ModuleName}\s*;/i =~ line
        parse_flag = false if /end/i =~ line
      end
      
      # Get Signal Information
      line = line.strip
      if parse_flag
        /^(\w+)\s*:\s*(\w+)\s+(.+)/i =~ line
        next if $1 == nil
        next if $2 != "in" && $2 != "out" && $2 != "IN" && $2 != "OUT"
        sig = Signal.new
        sig.Line = line
        sig.Name = $1
        sig.Direction = $2
        logic_vector =  $3
        if (/std_ulogic_vector/i =~ logic_vector ) != nil
          /std_ulogic_vector\s*\(\s*(\w+)\s*downto\s*(\w+)\s*\)/i =~ logic_vector
          sig.MSB = $1.to_i
          sig.LSB = $2.to_i
          sig.BitWidth = sig.MSB - sig.LSB
        elsif (/std_logic_vector/ =~ logic_vector ) != nil
          /std_logic_vector\s*\(\s*(\w+)\s*downto\s*(\w+)\s*\)/i =~ logic_vector
          sig.MSB = $1.to_i
          sig.LSB = $2.to_i
          sig.BitWidth = sig.MSB - sig.LSB
        elsif (/std_ulogic/i =~ logic_vector) != nil
          sig.BitWidth = 0
        elsif (/std_logic/i =~ logic_vector) != nil
          sig.BitWidth = 0
        end
        @ModuleSignalInfo << sig
      end
    }
  end

  #
  # generate verilog file
  #
  private
  def generate
    file_name = @ModuleName + "_BB.v" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "#{@ModuleName} : Verilog Wrapper Module" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"//")
    f.printf("module %s(\n",@ModuleName)
    i = 0

    
    # print definition of signal
    while i <= @ModuleSignalInfo.size - 2
      f.printf("\t%s,\n",@ModuleSignalInfo[i].Name)
      i += 1
    end
    f.printf("\t%s\n",@ModuleSignalInfo[i].Name)
    f.printf("\t)/*synthesis syn_black_box*/;\n",@ModuleName)
    f.printf("\n")

    # print Input/Output of signal
    @ModuleSignalInfo.each{|info|
      # direction
      if info.Direction == "in" || info.Direction == "IN"
        direction = "input"
      elsif info.Direction == "out" || info.Direction == "OUT"
        direction = "output"
      end

      # print with bitwidth
      if info.BitWidth == 0
        f.printf("\t%s\t%s;\n",direction,info.Name)
      else
        f.printf("\t%s\t[%d:%d]\t%s;\n",direction,info.MSB,info.LSB,info.Name)
      end
    }

    f.printf("endmodule")
  end
  
  #
  # Main Function
  #  1. 
  #  2. 
  #
  public
  def main
    get_argument
    operation
    generate
    Common.print_summary
  end
  
end


if __FILE__ == $0
  vhdl_parse = VHDLParse.new
  vhdl_parse.main
end



