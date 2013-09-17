#!/usr/bin/ruby
#############################################################
#
# chksyn
#  - check Synplify Synthesis Warning messages
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#  Date       : 2009/10/23
#  Version    : 0.2-beta
#
#############################################################
#
# [OPERATION]
#  This tool check Synplify Synthesis warning messages.
#  "Check" means separating messages now.
#
# [USAGE]
#  %chksyn.rb <Synplify Report File(*.srr)>
#
# [EXAMPLE]
#  %checklog.rb chip.srr
#
# [OUTPUT]
#
# [History]
#   0.1-beta : Rev26(2009/10/22) - Beta revision first release
#   0.2-beta : Rev27(2009/10/22) - Support Windows/Linux
#
############################################################
require "system"
require "common"

$TOOL       = "chksyn"
$VERSION    = "0.1-beta"

$VERBOSE    = false

$SRR_FILE   = nil

$ERROR_CNT   = 0
$WARNING_CNT = 0
$NOTE_CNT    = 0

$OS          = nil

class ChkSyn
  
  #
  # initialize
  #
  def initialize
    @SRR = Array.new   # Array of SRR File

    @srr_warn = Array.new # For Warning
    @srr_note = Array.new # For Note
    @srr_info = Array.new # For Information
    
    @FILE_LIST    = Array.new
    @MESSAGE_LIST = Array.new

    # For Clock
    @UserGlobalBuf = nil
    @InsertingClockBuffer = Array.new
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
    printf("Usage :  %s.rb [OPTION] <SRR File>\n",$TOOL)
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
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        else
          $SRR_FILE = ARGV[i]
        end
      end
    end 

    # Argument Check
    if $SRR_FILE == nil
      $ERROR_CNT += 1
      printf("@E:\"SRR File\" is not specified.\n")
      print_usage
      Common.print_summary
      exit
    end
  end

  #
  # read file
  #
  def read
    @SRR = Common.file_read("#{$SRR_FILE}")
  end

  #
  # analize srr file
  #
  def analize
    i = 0
    clkbuf_num = 0
    # separating each message
    @SRR.each{ |line|
      tmp = Array.new  # [(W/N/I),file,number,messge]
      
      # Judgment OS(Windows/Linux)
      if /^\#OS/ =~line
        tmp = line.split
        $OS = tmp[1]
      # Message  
      elsif /^\@W:/ =~ line
        tmp << "W"
        a,b,c = pickup_each_element(line)
        tmp << a # file
        tmp << b # number
        tmp << c # message
        @srr_warn << tmp
      elsif /^\@N:/ =~ line
        tmp << "N"
        a,b,c = pickup_each_element(line)
        tmp << a # file
        tmp << b # number
        tmp << c # message
        @srr_note << tmp
        if /FX430/ =~ line
          tmp = line.split
          @UserGlobalBuf = tmp[3]
        end
      elsif /^Clock Buffers:/ =~ line
        clkbuf_num = i+1
      end
      i += 1
    }

    # get Inserting Clock Buffer
    tmp = Array.new
    tmp = @SRR[clkbuf_num].split("@")
    tmp = tmp[0].split(",")
    tmp.pop
    tmp.each{|line|
      @InsertingClockBuffer <<  line.split[5]
    }

    printf("@I:Waning Message Count - %5d\n", @srr_warn.size) if $VERBOSE
    printf("@I:Note Message Count   - %5d\n", @srr_note.size) if $VERBOSE

    
  end

  def pickup_each_element(sentense)
    tmp = Array.new
    identifier = nil
    number = nil
    file_name = nil

    # pickup file_name, number
    tmp = sentense.split
    identifier = tmp[0]
    number = tmp[1]
    /\"(.*)\"/ =~ tmp[2]
    if $OS == "Windows"
      /.*\\(.*)$/ =~ $1    # For Windows
    elsif $OS == "Linux"
      /.*\/(.*)$/ =~ $1   # For Linux
    else
      $ERROR_CNT += 1
      printf("@E: This SRR file generated on \"%s\" is not supported.\n",$OS)
      print_summary
    end
    file_name = $1

    # under files
    if file_name != nil
      tmp = sentense.split("|")
      message = tmp[1]
    # other
    else
      tmp = sentense.split("|")
      tmp.delete_at(0)
      message = tmp.to_s
    end

    @FILE_LIST << file_name


    return file_name, number, message
=begin
    printf("---------------------------------\n")
    printf("identifier  : %s\n",identifier)
    printf("number      : %s\n",number)
    printf("file_name   : %s\n",file_name)
=end


  end

  #
  # print
  #
  def print_warning_note(file)

    warn_list = Array.new
    note_list = Array.new
    
    file.printf("\n")
    file.printf("############## WARNING MESSAGE ##############\n")
    file.printf("\n")

    @FILE_LIST.compact!
    @FILE_LIST.uniq!
    @FILE_LIST.sort!
    @FILE_LIST.each{|f|
      tmp1 = Array.new
      tmp_srr_warn = Array.new
      file.printf("[FILE]%s\n",f)
      @srr_warn.each{|sw|
        tmp2 = Array.new
        if(f == sw[1])
          tmp2 << sw[2]
          tmp2 << sw[3]
          warn_list << sw
        end
        tmp1 << tmp2
      }
      tmp1.compact!
      tmp1.uniq!
      tmp1.sort!
      tmp1.each{|t|
        if t.size != 0
          file.printf("  - %s : %s\n",t[0],t[1])
        end
      }
      file.printf("\n")
    }

    file.printf("[OTHER WARNING]\n")        
    (@srr_warn - warn_list).each{|sw|
      file.printf("  - %s : %s\n",sw[2],sw[3])        
    }

    file.printf("\n")
    file.printf("############## NOTE MESSAGE ##############\n")
    file.printf("\n")

    @FILE_LIST.compact!
    @FILE_LIST.uniq!
    @FILE_LIST.sort!
    @FILE_LIST.each{|f|
      tmp1 = Array.new
      file.printf("[FILE]%s\n",f)
      @srr_note.each{|sw|
        tmp2 = Array.new
        if(f == sw[1])
          tmp2 << sw[2]
          tmp2 << sw[3]
          note_list << sw
        end
        tmp1 << tmp2
      }
      tmp1.compact!
      tmp1.uniq!
      tmp1.sort!
      tmp1.each{|t|
        if t.size != 0
          file.printf("  - %s : %s\n",t[0],t[1])
        end
      }
      file.printf("\n")
    }

    file.printf("[OTHER NOTE]\n")        
    (@srr_note - note_list).each{|sw|
      file.printf("  - %s : %s\n",sw[2],sw[3])        
    }


  end
  
  def print_clk_info(file)

    file.printf("\n")
    file.printf("############## CLOCK INFORMATION ##############\n")
    file.printf("\n")

    file.printf("[Number of Global Buffer instantiated by user]\n")
    file.printf(" - %d\n",@UserGlobalBuf)

    file.printf("[Inserted Clock Buffer]\n")
    @InsertingClockBuffer.each{|clk_name|
      file.printf(" - %s\n",clk_name)
    }
    file.printf("\n")
  end
  
  #
  # analize clock
  #
  def analize_clock
    # pickup ClockBuffers
    
  end

  
  #
  # write report file
  #
  def write
    # for warn
    file_name = "syn_report.txt"
    printf("@I:generate %s file\n",file_name)
    f = File::open("#{file_name}","w")
    Common.print_file_header(f,"#{file_name} using #{$SRR_FILE}")
    print_clk_info(f)
    print_warning_note(f)
    f.close
  end


  #
  # main execution
  #
  def exe
    get_argument
    print_base
    read
    analize
    write
    Common.print_summary
  end
end

chksyn = ChkSyn.new
chksyn.exe
