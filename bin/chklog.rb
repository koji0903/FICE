#!/usr/bin/ruby
#############################################################
#
# chklog
#  - check make_chip Log file
#  - generate pin.para for chip hierarchy
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@necel.com>
#  Date       : 2009/12/08
#  Version    : 0.2-beta
#
############################################################
#
# [OPERATION]
#  This tool support checking make_chip modification. 
#
# [USAGE]
#  %checklog.rb -log_ice <ICE Log File> -log_device <Device Log File>  
#
# [EXAMPLE]
#  %checklog.rb -log_ice make_chip.log_ice -log_device make_chip.log_device
#
# [OUTPUT]
#   pin_chip.para_ice : for make_chip for chip hier
#   chkfile.txt       : Personal use
#
#
###################################################################
require "system"
require "common"
require "xst"

$TOOL       = "chklog"
$VERSION    = "0.2-beta"

$LOG_ICE     = nil
$LOG_DEVICE  = nil

$ERROR_CNT   = 0
$NOTE_CNT = 0
$WARNING_CNT = 0

class CheckLog

  def initialize
    # For ICE
    @LogICE = Array.new
    @InListICE = Array.new     # For Input signal regarded floating
    @OutListICE = Array.new    # For Output/Inout signal regarded floating

    # For Device
    @LogDevice = Array.new
    @InListDevice = Array.new     # For Input signal regarded floating
    @OutListDevice = Array.new    # For Output/Inout signal regarded floating
  end

  #
  # print base
  #
  def print_base
    printf("%s ver:%s\n",$TOOL,$VERSION)
    printf("Copyright (c) 2009 NEC MicroSystem. All rights reserved.\n\n")
  end
  
  #
  # print ussage
  #
  def print_usage
    printf("\n")
    printf("Usage :  %s.rb [OPTION] -log_ice <make_chip LogFile> -log_device <make_chip LogFile>\n",$TOOL)
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
        print_base
        print_usage
        exit
      when '-v','-version' then
        print_base
        printf("")
        exit
      when '-verbose' then
        $VERBOSE = true
      when '-log_ice' then
        $LOG_ICE = ARGV[i+1]
        i += 1
      when '-log_device' then
        $LOG_DEVICE = ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        end
      end
    end 

    # Argument Check
    if $LOG_ICE == nil
      $ERROR_CNT += 1
      printf("@E:\"ICE LogFile\" is not specified.\n")
      print_usage
      print_summary
    end

#    if $LOG_DEVICE == nil
#      $ERROR_CNT += 1
#      printf("@E:\"Device LogFile\" is not specified.\n")
#      print_usage
#      print_summary
#    end
  end

  def read
    @LogICE = Common.file_read("#{$LOG_ICE}")    # For Log File
    if $LOG_DEVICE != nil
      @LogDevice = Common.file_read("#{$LOG_DEVICE}")   # For Open File
    end
  end

  #
  # filter
  #  - pick up Error/Warning line and filter existing unexpect message
  #    If there is message with expecting, make data including detail info
  #
  def filter(log_data)
    i = 1
    out_list = Array.new
    in_list  = Array.new
    log_data.each{|line|
      float_info = Array.new # [ins,pin,net]
      if /Warning/ =~ line
        tmp = line.split
        if tmp[1] != "1031:"
          $ERROR_CNT += 1
          printf("@E:Found unexpected warning message\(\[Line:%d\]%s\).please check this message\n",i,line)
        else
          /.*\[(\w*)\].*\[(\w*)\].*\[(\w*)\]/ =~ line
          ins = $1;pin = $2;net = $3
          float_info << ins; float_info << pin; float_info << net;
          out_list << float_info
          printf("\nline:%s/n",line) if $VERBOSE
          printf("ins:%s\n",ins) if $VERBOSE
          printf("pin:%s\n",pin) if $VERBOSE
          printf("net:%s\n",net) if $VERBOSE
        end
      end
      if /Error/ =~ line
        tmp = line.split
        if tmp[1] != "1008:"
          $ERROR_CNT += 1
          printf("@E:Found unexpected error message\(\[Line:%d\]%s\).please check this message\n",i,line)
        else
          /.*\[(\w*)\].*\[(\w*)\].*\[(\w*)\]/ =~ line
          ins = $1;pin = $2;net = $3
          float_info << ins; float_info << pin; float_info << net;
          in_list << float_info
          printf("\nline:%s/n",line) if $VERBOSE
          printf("ins:%s\n",ins) if $VERBOSE
          printf("pin:%s\n",pin) if $VERBOSE
          printf("net:%s\n",net) if $VERBOSE
        end
      end
      i += 1
    }
    return in_list, out_list
    exit
  end

  #
  # Gen Pin file
  #   [File Format]
  #     PIN: [PinName] TYPE [Direction(IN/OUT/IO)]
  #     END_PIN:
  #
  def gen_pinfile
    type = nil
    file_name = "pin_chip.para_ice"
    chkfile   = "chkfile.txt"
    printf("@I:generate %s\(Pin File for \"chip\" hierarchy\)\n",file_name)
    f = File::open("#{file_name}","w")
    cf = File::open("#{chkfile}","w")
    Common.print_file_header(f,"Pin file for chip hierarchy",$TOOL,$VERSION,"//")
    f.printf("\nINCLUDE_FILE: MF2 1.00\n\n")
    @OutListICE.each{|info|
      type = "OUT"
      f.printf("\/\/ Instance:%s, Pin:%s, Net:%s\n",info[0],info[1],info[2])
      cf.printf("Instance:%s, Pin:%s, Net:%s (out)\n",info[0],info[1],info[2])
      f.printf("PIN: %s TYPE %s\n", info[2], type)
      f.printf("END_PIN:\n")
      f.printf("\n")
    }
    @InListICE.each{|info|
      type = "IN"
      f.printf("\/\/ Instance:%s, Pin:%s, Net:%s\n",info[0],info[1],info[2])
      cf.printf("Instance:%s, Pin:%s, Net:%s (in)\n",info[0],info[1],info[2])
      f.printf("PIN: %s TYPE %s\n", info[2], type)
      f.printf("END_PIN:\n")
      f.printf("\n")
    }
    f.printf("\nEND_INCLUDE_FILE:\n\n")
    f.close
    cf.close
  end

  def check
    if $ERROR_CNT ==  0
      printf("@I:There is no unexpect signal\n")
    else
      printf("@I: InList  %d\n",@InListICE.size)
      printf("@I: OutList %d\n",@OutListICE.size)
    end
  end

  ##########################################################
  def exe
    get_argument
    Common.print_base
    read
    printf("@I:Filterling %s file\n",$LOG_ICE)
    @InListICE,@OutListICE = filter(@LogICE)
    if $LOG_DEVICE != nil
      printf("@I:Filterling %s file\n",$LOG_DEVICE)
      @InListDevice,@OutListDevice = filter(@LogDevice)
    end
    @InListICE = @InListICE - @InListDevice            # remove original floating signal
    @OutListICE = @OutListICE - @OutListDevice         # remove original undriven signal
#    gen_pinfile
    check
    Common.print_summary
    exit
  end
  ##########################################################
end

cl = CheckLog.new
cl.exe
