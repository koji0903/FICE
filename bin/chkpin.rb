#!/usr/bin/ruby
#############################################################
#
# chkpin
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#  Date       : 2009/10/23
#  Version    : 0.1-beta
#
#############################################################
#
# [OPERATION]
#
# [USAGE]
#  %chkpin.rb -sdc <Pin SDC File> -csv <Pin CSV File> -txt <Test File>
#
# [EXAMPLE]
#
# [OUTPUT]
#
# [History]
#
############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "system"
require "common"

$TOOL       = "chkpin"
$VERSION    = "0.1-beta"

$VERBOSE    = false

$ERROR_CNT   = 0
$WARNING_CNT = 0
$NOTE_CNT    = 0


class ChkPin

  def initialize
    # Input File
    @SDC_FILE_NAME = nil 
    @CSV_FILE_NAME = nil
    @TXT_FILE_NAME = nil
    @NCF_FILE_NAME = nil

    # array data of file
    @SDCData = Array.new
    @CSVData = Array.new
    @TXTData = Array.new
    @NCFData = Array.new

    # Signal List
    @SDCPinInList = Array.new
    @SDCPinOutList = Array.new
    @SDCPinInOutList = Array.new
    @CSVPinInList = Array.new
    @CSVPinOutList = Array.new
    @CSVPinInOutList = Array.new
    @TXTPinInList = Array.new
    @TXTPinOutList = Array.new
    @TXTPinInOutList = Array.new
    @NCFPinList = Array.new

    # Difference
    @Differ = Array.new

    @PinAssign = Hash.new
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
    printf("Usage :  %s.rb [OPTION] -sdc <SDC File> -csv <CSV File>\n",$TOOL)
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
      when '-sdc' then
        @SDC_FILE_NAME = ARGV[i+1]
        i += 1
      when '-csv' then
        @CSV_FILE_NAME = ARGV[i+1]
        i += 1
      when '-txt' then
        @TXT_FILE_NAME = ARGV[i+1]
        i += 1
      when '-ncf' then
        @NCF_FILE_NAME = ARGV[i+1]
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
    if @SDC_FILE_NAME == nil
      $ERROR_CNT += 1
      printf("@E:\"SDC File\" is not specified.\n")
      print_usage
      Common.print_summary
      exit
    end
    if @CSV_FILE_NAME == nil
      $ERROR_CNT += 1
      printf("@E:\"CSV File\" is not specified.\n")
      print_usage
      Common.print_summary
      exit
    end
  end
  
  #
  # read file
  #
  def read
    @SDCData = Common.file_read("#{@SDC_FILE_NAME}") if @SDC_FILE_NAME != nil
    @CSVData = Common.file_read("#{@CSV_FILE_NAME}") if @CSV_FILE_NAME != nil
    @TXTData = Common.file_read("#{@TXT_FILE_NAME}") if @TXT_FILE_NAME != nil
    @NCFData = Common.file_read("#{@NCF_FILE_NAME}") if @NCF_FILE_NAME != nil
  end
  
  #
  # Analize SDC File
  #
  def analize_sdc
    @SDCData.each{|line|
      # For Input 
      if /define_input_delay/ =~ line
        /^.*\{(.*)\}/ =~ line # Pickup pin name
        next if $1 == nil     # "default"
        @SDCPinInList << $1
      end
      # For Out 
      if /define_output_delay/ =~ line
        /^.*\{(.*)\}/ =~ line # Pickup pin name
        next if $1 == nil     # "default"
        @SDCPinOutList << $1
      end
      # For InOut 
      if /define_io_standard/ =~ line
        /^.*\{(.*)\}/ =~ line # Pickup pin name
        next if $1 == nil     # "default"
        @SDCPinInOutList << $1
      end
    }
  end

  #
  # Analize CSV File
  #
  def analize_csv
    dirction = nil
    signal_name = nil
    locked = nil
    @CSVData.each{|line|
      # Skip nul line and coment line
      if /^#/ =~ line
      else
        tmp = Array.new
        tmp = line.split(",")
        direction = tmp[4]
        signal_name = tmp[1]
        locked = tmp[12]


        if direction == "INPUT"
          @CSVPinInList << signal_name
        elsif direction == "OUTPUT"
          @CSVPinOutList << signal_name
        elsif direction == "BIDIR"
          @CSVPinInOutList << signal_name
        end
      end
    }
  end

  # 
  # analize TXT File
  def analize_txt
    dirction = nil
    signal_name = nil
    locked = nil

    @TXTData.each{|line|
      # Pre-operation
      if /\|Pin Number/ =~ line
        next
      end

      # main operation
      if /\|.*\|.*\|/ =~ line
        tmp = Array.new
        tmp = line.split("|")

        pin_assign = tmp[1].scan(/\w+/)
        direction = tmp[5].scan(/\w+/)
        signal_name = tmp[2].scan(/\w+/)
        locked = tmp[13].scan(/\w+/)
        pull = tmp[10].scan(/\w+/)

        if direction.to_s == "INPUT"
          @TXTPinInList << signal_name.to_s
        elsif direction.to_s == "OUTPUT"
          @TXTPinOutList << signal_name.to_s
        elsif direction.to_s == "BIDIR"
          @TXTPinInOutList << signal_name.to_s
        end

        
        printf("%s:%s\n",signal_name,pull) if pull.to_s == "UP"
        # Make Golden PinAssign
        @PinAssign["#{signal_name}"] = pin_assign
      end
    }
  end

  #
  # analize ncf
  #
  def analize_ncf
    @NCFData.each{|line|
      if /^NET/ =~ line
        /.+\"(.+)\".+\"(.+)\"/ =~ line
        @NCFPinList << $1.to_s
      end
    }
  end

  def report

    printf("\n")
    printf("#### Pin Report ####\n")
    printf("[SDC File: %s]\n",@SDC_FILE_NAME)
    printf("  The number of total signals : %4d\n",@SDCPinInList.size+@SDCPinOutList.size+@SDCPinInOutList.size)
    printf("    - Input signal            : %4d\n",@SDCPinInList.size)
    printf("    - Output signal           : %4d\n",@SDCPinOutList.size)
    printf("    - InOut signal            : %4d\n",@SDCPinInOutList.size)
    printf("\n")
    printf("[CSV File: %s]\n",@CSV_FILE_NAME)
    printf("  The number of total signals : %4d\n",@CSVPinInList.size+@CSVPinOutList.size+@CSVPinInOutList.size)
    printf("    - Input signal            : %4d\n",@CSVPinInList.size)
    printf("    - Output signal           : %4d\n",@CSVPinOutList.size)
    printf("    - InOut signal            : %4d\n",@CSVPinInOutList.size)
    printf("\n")
    printf("[TXT File: %s]\n",@TXT_FILE_NAME)
    printf("  The number of total signals : %4d\n",@TXTPinInList.size+@TXTPinOutList.size+@TXTPinInOutList.size)
    printf("    - Input signal            : %4d\n",@TXTPinInList.size)
    printf("    - Output signal           : %4d\n",@TXTPinOutList.size)
    printf("    - InOut signal            : %4d\n",@TXTPinInOutList.size)
    printf("\n")
    printf("[NCF File: %s]\n",@NCF_FILE_NAME)
    printf("  The number of total signals : %4d\n",@NCFPinList.size)
    printf("\n")

    # Differ Input Signal
    printf("## Differ CSV\n")
    @Differ = @TXTPinInList - @CSVPinInList
    @Differ.sort!
    printf("[Input : %s - %s]\n",@TXT_FILE_NAME,@CSV_FILE_NAME)
    @Differ.each{|sig|
      printf(" - %s\n",sig)
    }
    printf("\n")


    # Differ NCF
    printf("## Differ NCF\n")
    tmp = Array.new
    tmp = @TXTPinInList + @TXTPinOutList + @TXTPinInOutList
    @Differ = tmp - @NCFPinList
    @Differ.sort!
    printf("[Input : %s - %s]\n",@TXT_FILE_NAME,@NCF_FILE_NAME)
    printf(" - Input signal is same\n") if @Differ.size == 0
    ((@Differ & @TXTPinInList).sort!).each{|sig|
#      printf(" - %s\n",sig)
      printf("define_attribute {%s} xc_loc {%s};\n",sig,@PinAssign.fetch("#{sig}"))
    }
    printf("\n")
    printf("[Output : %s - %s]\n",@TXT_FILE_NAME,@NCF_FILE_NAME)
    printf(" - Output signal is same\n") if @Differ.size == 0
    ((@Differ & @TXTPinOutList).sort!).each{|sig|
#      printf(" - %s\n",sig)
      printf("define_attribute {%s} xc_loc {%s};\n",sig,@PinAssign.fetch("#{sig}"))
    }
    printf("\n")
    printf("[InOut : %s - %s]\n",@TXT_FILE_NAME,@NCF_FILE_NAME)
    printf(" - InOut signal is same\n") if @Differ.size == 0
    ((@Differ & @TXTPinInOutList).sort!).each{|sig|
#      printf(" - %s\n",sig)
      printf("define_attribute {%s} xc_loc {%s};\n",sig,@PinAssign.fetch("#{sig}"))
    }
    printf("\n")



  end
  def exe
    get_argument
    read
    analize_sdc
    analize_csv
    analize_txt
    analize_ncf
    report
    Common.print_summary
  end

  
end

cp = ChkPin.new
cp.exe

