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
$SUB_TOOL        = "ConnectMod" # Tool Name
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
class CONNECT_MOD
  
  def initialize
    @INPUT = nil
    @OUTPUT = nil
    @PRODUCT = nil

    @Instance = nil
    @DATA = Array.new
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
      opt.on('--i Original Connect','Original Connect file name'){|v| @INPUT = v}
      opt.on('--o Modified Connect','Modified Connect file name'){|v| @OUTPUT = v}
      opt.on('--o Modified Connect','Modified Connect file name'){|v| @OUTPUT = v}
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
    if @INPUT == nil || @OUTPUT == nil 
      printf "ERROR(Invalid Option or non-enough argument)\n"
      exit
    end
    open(@INPUT).each do |line|
      line = line.strip
      flag = false # for judgment line analyze
      # get INCLUDE_FILE
      if /^TOP/ =~ line && line.split.size == 2
        if @PRODUCT.nil?
          @DATA << "INCLUDE_FILE: " + line.split[1] + " 1.00\n"
        else
          @DATA << "INCLUDE_FILE: " + @PRODUCT + " 1.00\n"
        end
        flag = true
      end
      # get Instance Name (Update)
      if "INSTANCE"  == line.split[0] && line.split.size == 2
        @Instance = line.split[1]        
        flag = true
      end
      # get Connect Information
      if "CONNECT" == line.split[0]
        if /pullup/ =~ @Instance || /pulldown/ =~ @Instance
          @DATA << "\n//" + line + "\n"
          @DATA << "// Skip convert\n"
          next
        end
        @DATA << "\n//" + line + "\n"
        if /\/\*Open.*\*\// =~ line
          # Case8 : CONNECT ICOMP /*Open0*/ O
          port = line.split[1]
          wire = port + "_open"
          @DATA << "NET: " + @Instance + " " + port + " " + wire + "\t// [Special Change - Open]\n"
        elsif /\/\*.*\*\// =~ line
          # Case9 : CONNECT PIO77 /*PIO77*/ O
          port = line.split[1]
          direction = line.split[3]
          case direction
          when "I"
            direction = "IN"
          when "O"
            direction = "OUT"
          when "B"
            direction = "IO"
          end
          @DATA << "PIN:\t" + port + "\tTYPE\t" + direction + "\n"
          @DATA << "END_PIN:\t// [Special Change - Terminal]\n"
        elsif /^\d+/ =~ line.split[2]
          # Case10 : CONNECT	clk_bbclkr	0	I
          case line.split[2]
          when "0"
            @DATA << "PULLDOWN: " + @Instance + " " + line.split[1] + "\t// [Special Change - Constant Value]\n"
          when "1"
            @DATA << "PULLUP: " + @Instance + " " + line.split[1] + "\t// [Special Change - Constant Value]\n"            
          when /1'b0/
            @DATA << "PULLDOWN: " + @Instance + " " + line.split[1] + "\t// [Special Change - Constant Value]\n"
          when /1'b1/
            @DATA << "PULLUP: " + @Instance + " " + line.split[1] + "\t// [Special Change - Constant Value]\n"
          else
            $ERROR_CNT += 1
            printf("@E: Found Unexpected Line(%s)",line)
            Common.print_summary
          end
        elsif /\{.*\}/ =~ line
          # Case3 : CONNECT bbrsub_peri_pwdata[31:0] {bbrsub_peri_pwdata[15:0],bbrsub_peri_pwdata[15:0]}
          #         => NET: inst bbrsub_peri_pwdata[31] bbrsub_peri_pwdata[15]
          #         => NET: inst bbrsub_peri_pwdata[30] bbrsub_peri_pwdata[14]
          #         => ...
          #         => NET: inst bbrsub_peri_pwdata[16] bbrsub_peri_pwdata[0]
          #         => NET: inst bbrsub_peri_pwdata[15] bbrsub_peri_pwdata[15]
          #         => ...
          #         => NET: inst bbrsub_peri_pwdata[0] bbrsub_peri_pwdata[0]

          # Case4 : CONNECT inst bbr_dfsize[1:0] {bbr_dfsize1,bbr_dfsize0}
          #         => NET: inst bbr_dfsize[1] bbr_dfsize1
          #         => NET: inst bbr_dfsize[0] bbr_dfsize0

          port = line.split[1]
          wire = line.split[2].gsub("{","").gsub("}","").split(",")
          if bus_flag(port)
            port_list = Array.new
            wire_list = Array.new

            port_list = make_SignalList(port)
            wire.each do |each_wire|
              if bus_flag(each_wire)
                wire_list += make_SignalList(each_wire)
              else
                wire_list << each_wire
              end
            end
            
            i = 0
            while i < port_list.length
              if /pull_up/ =~ wire_list[i]
                @DATA << "PULLUP: " + @Instance + " " + port_list[i] + "\t// [Special Change - PULLUP]\n"
              elsif /pull_down/ =~ wire_list[i]
                @DATA << "PULLDOWN: " + @Instance + " " + port_list[i] + "\t// [Special Change - PULLDOWN]\n"
              else
                @DATA << "NET: " + @Instance + " " + port_list[i] + " " + wire_list[i] + "\t// [Special Change]\n"             
              end
              i += 1
            end
          else
            $ERROR_CNT += 1
            printf("@E: Found Unexpected Line(%s)",line)
            Common.print_summary
          end
        elsif /pull_up/ =~ line.split[2]
          # Case1 : PULLUP
          @DATA << "PULLUP: " + @Instance + " " + line.split[1] + "\n"
        elsif /pull_down/ =~ line.split[2]
          # Case2 : PULLDWON
          @DATA << "PULLDOWN: " + @Instance + " " + line.split[1] + "\n"          
        elsif /\[\d+:\d+\]/ =~ line.split[1] && /\[\d+:\d+\]/ =~ line.split[1]
          # Case5 : CONNECT sau02_prdata[15:0] sau_1_prdata[15:0]
          #         => NET: inst sau02_prdata[15] sau_1_prdata[15]
          #         => NET: inst sau02_prdata[14] sau_1_prdata[14]
          #         => ...
          #         => NET: inst sau02_prdata[0] sau_1_prdata[0]
          port = line.split[1]
          wire = line.split[2]
          port_list = Array.new
          wire_list = Array.new

          port_list = make_SignalList(port)
          wire_list = make_SignalList(wire)

          i = 0
          while i < port_list.length
            @DATA << "NET: " + @Instance + " " + port_list[i] + " " + wire_list[i] + "\t// [Special Change]\n"              
            i += 1
          end


        elsif line.split.size == 3 ||
            ( line.split.size == 4 && ( line.split[3] == "I" || line.split[3] == "O" || line.split[3] == "B" ) )

          # Case6 : CONNECT ADSAR9 hadm_adc_adsar[9]
          #         => NET: inst ADSAR9 hadm_adc_adsar[9]

          # Case7 : CONNECT AAA BBB
          #         => NET: inst AAA BBB
          @DATA << "NET: " + @Instance + " " + line.split[1] + " " + line.split[2] + "\n"
        else
          $WARNING_CNT += 1
          printf("@W:Not-Converted line\"[%s]\"\n",line)
        end
        flag = true
      end

      if flag == false  && line.size != 0
        unless /MODULE/ =~ line || /^#/ =~ line
          $WARNING_CNT += 1
          p "@W:Unanalyze Line:" + line
        end
      end
    end
    @DATA << "\n\nEND_INCLUDE_FILE:\n\n"

    # Generate OutputFile
    f = open("#{@OUTPUT}","w")
    comment = "Converted from " + @INPUT + " to " + @OUTPUT
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"//")
    f.printf("\n\n")
    @DATA.each do |line|
      f.printf("%s",line) if error_check(line) == 0
    end
    f.close

    Common.print_summary
  end
  
  def error_check(line)
    return 0 if /^\/\// =~ line
    if /pull_/ =~ line
      $INTERNAL_ERROR_CNT += 1
      printf("@internal_error. found unexpected converting.(%s)\n",line)
      Common.print_summary
      exit
    end
    return 0
  end

  #
  # Bus Flag
  #  - parm : signal name
  #  - ret  : true - Bus, false - Single
  def bus_flag(name)
    if /\w+\[\d+:\d+\]/ =~ name # AAA[msb:lsb]  => Type = "Bus" , signal_name = AAA, MSB = msb, LSB = lsb
      return true
    else
      return false
    end
  end

  #
  # Get SignalName except Bit
  #  - parm : signal name
  #  - ret  : MSB
  def get_SignalName(name)
    if /(\w+)\[\d+:\d+\]/ =~ name # AAA[msb:lsb]  => Type = "Bus" , signal_name = AAA, MSB = msb, LSB = lsb
      return $1
    else
      return nil
    end
  end

  #
  # Get MSB
  #  - parm : signal name
  #  - ret  : MSB
  def get_MSB(name)
    if /\w+\[(\d+):\d+\]/ =~ name # AAA[msb:lsb]  => Type = "Bus" , signal_name = AAA, MSB = msb, LSB = lsb
      return $1.to_i
    else
      return nil
    end
  end

  #
  # Get LSB
  #  - parm : signal name
  #  - ret  : LSB
  def get_LSB(name)
    if /\w+\[\d+:(\d+)\]/ =~ name # AAA[msb:lsb]  => Type = "Bus" , signal_name = AAA, MSB = msb, LSB = lsb
      return $1.to_i
    else
      return nil
    end
  end


  def make_SignalList(signal)
    list = Array.new
    msb = get_MSB(signal)
    lsb = get_LSB(signal)
    name = get_SignalName(signal)
    while msb > lsb - 1
      list << name + "[" + msb.to_s + "]"
      msb -= 1
    end
    return list
  end

  #
  # Analyze Signal
  #  - param : (signal name)
  #  - ret   : Type(Bus/Signal), SiganlName, MSB, LSB
  def analyze_Signal(name)
    type = nil
    signal_name = nil
    size = 0
    msb = 0
    if /(\w+)\[(\d+):(\d+)\]/ =~ name # AAA[msb:lsb]  => Type = "Bus" , signal_name = AAA, MSB = msb, LSB = lsb
      type = "Bus"
      signal_name = $1
      msb = $2
      lsb = $3
    elsif /(\w+)\[(\d+)\]/ =~ name # AAA[Num]      => Type = "Single",  signal_name = AAA, MSB = 0, LSB = 0
      type = "Single"
      signal_name = $1
    elsif /(\w+)/ =~ name # AAA           => Type = "Single", signal_name = AAA, MSB = 0, LSB = 0
    end
    
    
  end
end


if __FILE__ == $0
  connect = CONNECT_MOD.new
  connect.main
end
