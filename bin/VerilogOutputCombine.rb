#!/usr/bin/ruby
#############################################################
#
# VerilogOutputCombine
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009,2010 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Combine to One signal from All Output Signal.
# - Specialy Edit for Test-Implementation for FPGA in short
#   supply FPGA I/O.
#
# [Usage]
# -%ruby templete.rb
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
require "FICE_def"
require "system"
require "common"

#
# Global Setting
#
$SUB_TOOL        = "VerilogOutputCombine" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$MESSAGE         = false



#
# Main Class
#
class VerilogOutputCombine
  
  def initialize
    @OUT_VERILOG = Array.new
    @OUTPUT_LIST = Hash.new
  end

  class SignalInfo
    attr_accessor :Name
    attr_accessor :MSB
    attr_accessor :LSB
    def initialize(name,msb,lsb)
      @Name = name
      @MSB = msb
      @LSB = lsb
    end
  end
  #
  # Print Base Information( Tool name, Version, Copyright )
  #
  private
  def print_base
    printf("%s(%s) ver:%s\n",$TOOL,$SUB_TOOL,$VERSION)
    printf("Copyright (c) 2009,2010 NEC MicroSystem. All rights reserved.\n\n")
  end

  #
  # Print Tool Usage
  #
  private
  def print_usage
    printf("\n")
    printf("Usage :  %s.rb -veriog *.v\n",$SUB_TOOL)
    printf(" OPTION\n")
    printf("\t-h/-help         : print help message\n")
    printf("\t-v/-version      : print version\n")
    printf("\t-verbose         : execute on verbose mode\n")
    printf("\t-verilog         : target modifieng verilog file\n")
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
      when '-verilog' then
        @VERILOG = ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        end
      end
    end 

    if @VERILOG == nil
      $ERROR_CNT += 1
      printf("@E:\"Verilog file \" is not specified.\n")
      print_usage
      Common.error
    end
    
    Common.chk_file("-verilog",@VERILOG)

  end
  
  #
  # Parse Verilog
  #
  def parse
    out_line = ""
    # Get "Output Signal List"
    #     "Out Verilog" that modified comment out on "output" line
    File.open("#{@VERILOG}").each{|line|
      out_line = line
      line = line.strip
      if /^output/ =~ line
        printf("%s\n",line) if $VERBOSE
        out_line = "//[COMMENT OUT]//" + out_line # comment out for "output" line
        line = Common.remove_after(line,"\/\/")
        case line.split.size
        when 2
          name = line.split[1].sub(";","")
          signal = SignalInfo.new(name,0,0)
          @OUTPUT_LIST["#{name}"] = signal
        when 3
          name = line.split[2].sub(";","")
          /^\[(\d*):(\d*)\]/ =~ line.split[1]
          msb = $1
          lsb = $2
          signal = SignalInfo.new(name,msb,lsb)         
          @OUTPUT_LIST["#{name}"] = signal
        else
          p "Error"
          p line
          exit
        end
      end
      @OUT_VERILOG << out_line
    }
    #
    #
    #
    first_time = false
    mode = false
    last_flag = false
    out_line = ""
    tmp_OUT_VERILOG = Array.new
    @OUT_VERILOG.each{|line|
      out_line = line
#      printf("[%s]%s\n",mode,line)
      line = line.strip
      if /^\/\// =~ line
        tmp_OUT_VERILOG << out_line
      else
        if /^\(/ =~ line && first_time == false
          first_time = true
          mode = true  
        end
        if /\)\;/ =~ line && mode
          last_flag = true
          tmp_OUT_VERILOG << "\t,AllOutput  //[VerilogOutputCombile]\n"
          mode = false
        end
        
        if mode == true
          if line.size == 0
            tmp_OUT_VERILOG << out_line
          elsif /^\(/ =~ line
          else
            token = line.split[0].sub(",","")
            if @OUTPUT_LIST.key?("#{token}") == true
              out_line = "//[COMMENT OUT]//" + out_line
            end
          end
        end
        tmp_OUT_VERILOG << out_line        

        if last_flag == true
          tmp_OUT_VERILOG << "\toutput AllOutput;\n"
          @OUTPUT_LIST.each_value{|signal|
            if signal.MSB == 0 && signal.LSB == 0
              tmp_OUT_VERILOG << "\twire\t" + signal.Name + ";\n"
            else
              tmp_OUT_VERILOG << "\twire\t[" + signal.MSB + ":" + signal.LSB + "]\t"+ signal.Name + ";\n"
            end
          }
          tmp_OUT_VERILOG << "\tassign AllOutput =\n"
          @OUTPUT_LIST.each_value{|signal|
            tmp_OUT_VERILOG << "\t\t^" + signal.Name + " |\n"
          }
          tmp_OUT_VERILOG << "\t\t1'b1;\n"
          last_flag = false
        end
      end
    }
    @OUT_VERILOG = tmp_OUT_VERILOG


  end

  def generate
    file_name = File.basename("#{@VERILOG}",".v") + "_w.v"
    f = open("#{file_name}","w")
    @OUT_VERILOG.each{|line|
      f.printf("%s",line)
    }
    f.close
  end

  #
  # Main Function
  #  1. 
  #  2. 
  #
  public
  def main
    get_argument
    parse
    generate
    Common.print_summary
  end
  
end


if __FILE__ == $0
  voc = VerilogOutputCombine.new
  voc.main
end
