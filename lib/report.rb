########################################################################
#
# Operation for make_chip "report" file
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#    Date     : 2009/12/04
#    Function : Refer to following HP
#       http://nqacs216.nms.necel.com/common_wiki/index.php?MakeChip#n39ed659
#
########################################################################
#
#  Class Name : Report
#  
#  [Method]
#   read          : read make_chip report file
#   pre_operation : operation file modification
#   print         : print reportICE structure
#     - print/print_pullup/print_pulldown/print_opennet/print_connection
#
#  [Data Structure]
#    ReportICE_Data
#      [No, SignalName, Connection List, (pulldown/pullup)]
#
########################################################################
require "message"

#
# Data Structure for Circuit Information
# that is created by report file
#
#        @InstanseName,[
#                        @ModuleName,
#                        @Signal[SingalName,Connection]
#                      ]

class ReportPinInfo
  attr_accessor :No
  attr_accessor :NetName
  attr_accessor :Type
  attr_accessor :ConnectInfo
  attr_accessor :Attribute
  attr_accessor :PIN
  def initialize
    @No = 0
    @NetName = nil
    @Type = nil
    @ConnectInfo = Array.new
    @Attribute = nil
    @PIN = nil
  end
end

class ReportConnectInfo
  attr_accessor :InstName
  attr_accessor :NetName
  attr_accessor :Direction
  attr_accessor :InstPinName
  attr_accessor :PinName
  attr_accessor :PIN
  attr_accessor :ReportFlag
  def initialize
    @InstName = nil
    @SignalName = nil
    @Direction = nil
    @InstPinName = nil
    @PinName = nil
    @PIN = nil
    @ReportFlag = false
  end
end

class RelationInf
  attr_accessor :NetName
  attr_accessor :Direction
  attr_accessor :IN
  attr_accessor :OUT
  attr_accessor :INOUT
  def initialize
    @NetName = nil
    @Direction = nil
    @IN      = Array.new
    @OUT     = Array.new
    @INOUT   = Array.new
  end
end

class Report

  # Grobal Variable
  attr_accessor :Report_Data
  
  attr_accessor :List
  attr_accessor :OpenNetList
  attr_accessor :NoFaninList
  attr_accessor :IOShortList
  attr_accessor :ConnectList
  attr_accessor :NoConnectList
  attr_accessor :NetNameList
  attr_accessor :InstSigList

  attr_accessor :ConnectRelation
  attr_accessor :InstList
  #
  # initialize
  #
  def initialize(readfile="",flag=nil)
    @Flag = flag
    @read_file = readfile
    @Report_Data = Array.new
    @PinNo = 0
    @PinName = 1
    @ConnectionList = 2
    @Attribute = 3

    @chip_info = Array.new 
    
    @List = Hash.new
    @OpenNetList = Hash.new
    @NoFaninList = Hash.new
    @IOShortList = Hash.new
    @ConnectList = Hash.new
    @NetNameList = Hash.new
    @InstSigList = Hash.new

    @InstList    = Array.new

    @PullUp = Array.new
    @PullDown = Array.new
    @OpenNet = Array.new
    @NoFanin = Array.new
    @Other = Array.new

    @ConnectRelation = Hash.new
  end

  #
  # file read
  #
  def read
    begin
      printf("@I:Read report file : %s\n",@read_file) 
      f = open("#{@read_file}","r")
      while line = f.gets
        @Report_Data << line
      end
    rescue => ex
      puts ex.message
      exit
    end  
  end

  #
  # Pre-Operation
  #   1.only use the line which the first charctor is "|".(remove "+" line)
  #   2.remove "|" charactor in enable line
  #   3.merge multi-line description
  #
  def pre_operation
    reportICE_tmp = Array.new
    printf("@I:Pre-Operation\n")
    # line operation
    line_s = Array.new
    @Report_Data.each do |line|
      if /^\|/ =~ line # for "1" 
        line = line.sub("\n","") # erase "\n"
        line_s = line.split(/\|/) # sub "|" charactor
        line_s.delete_at(0)
        reportICE_tmp << line_s
      end
    end

    # word operation for each line
    #  - modify structrure for multi line description
    size =  reportICE_tmp.size-1 
    while( size >= 0 )
      reportICE_tmp[size][@PinNo] = reportICE_tmp[size][@PinNo].gsub(" ","") # delete space char for 1-st column
      reportICE_tmp[size][@PinName] = reportICE_tmp[size][@PinName].gsub(" ","") # delete space char for 2-nd column
      reportICE_tmp[size][@ConnectionList] = reportICE_tmp[size][@ConnectionList].gsub(" ","") # delete space char for 3-rd column
      reportICE_tmp[size][@Attribute] = ""                                  # for attribute
      if ( reportICE_tmp[size][@PinNo] == "" )
        reportICE_tmp[size-1][@ConnectionList] = reportICE_tmp[size-1][@ConnectionList] + reportICE_tmp[size][@ConnectionList] # combile multi lines
        reportICE_tmp.delete_at(size) 
      end
      size -= 1
    end

    #
    # modify each data
    #
    if $VERBOSE == true; printf("@I:Print Attribute\n"); end;
    reportICE_tmp.each do |word|
      pininfo = ReportPinInfo.new
      word[@ConnectionList] = word[@ConnectionList].sub("\[out\/ioshort\]","") # delete unsuported comment
      #
      # PULLDOWN
      #
      if /\[pulldown\]/ =~ word[@ConnectionList]
#        if $VERBOSE == true; puts word[@PinNo] + ":" + word[@PinName] + " is Pull Down signal"; end;
        word[@Attribute] = "pulldown"
        word[@ConnectionList] = word[@ConnectionList].sub("\[pulldown\]","")

        # make data
        pininfo.No,pininfo.NetName,pininfo.Attribute,pininfo.PIN = make_pininfo(word)
        
        # connection list
        pininfo.ConnectInfo, @PullDown, pininfo.Type = make_connection_data(word[@ConnectionList],pininfo)
        @List["#{pininfo.No}"] = pininfo
        
        @ConnectList["#{pininfo.No}"] = pininfo
        @NetNameList["#{pininfo.NetName}"] = pininfo

        #
        # PULLUP
        #
      elsif /\[pullup\]/ =~ word[@ConnectionList]
#        if $VERBOSE == true; puts word[@PinNo] + ":" + word[@PinName] + " is Pull Up signal"; end;
        word[@Attribute] = "pullup"
        word[@ConnectionList] = word[@ConnectionList].sub("\[pullup\]","")
        
        # make data
        pininfo.No,pininfo.NetName,pininfo.Attribute,pininfo.PIN = make_pininfo(word)

        # connection list
        pininfo.ConnectInfo, @PullUp, pininfo.Type = make_connection_data(word[@ConnectionList],pininfo)
        @List["#{pininfo.No}"] = pininfo

        @ConnectList["#{pininfo.No}"] = pininfo
        @NetNameList["#{pininfo.NetName}"] = pininfo

      elsif /\[opennet\]/ =~ word[@ConnectionList]
#        if $VERBOSE == true; puts word[@PinNo] + ":" + word[@PinName] + " is Open Net signal"; end;
        word[@Attribute] = "opennet"
        word[@ConnectionList] = word[@ConnectionList].sub("\[opennet\]","")
        # make data
        pininfo.No,pininfo.NetName,pininfo.Attribute,pininfo.PIN = make_pininfo(word)

        # connection list
        pininfo.ConnectInfo, @OpenNet, pininfo.Type = make_connection_data(word[@ConnectionList],pininfo)
        @OpenNetList["#{pininfo.NetName}"] = pininfo
        @List["#{pininfo.No}"] = pininfo

        @ConnectList["#{pininfo.No}"] = pininfo
        @NetNameList["#{pininfo.NetName}"] = pininfo
        

      elsif /\[nofanin\]/ =~ word[@ConnectionList]
#        if $VERBOSE == true; puts word[@PinNo] + ":" + word[@PinName] + " is No Fanin signal"; end;
        word[@Attribute] = "nofanin"
        word[@ConnectionList] = word[@ConnectionList].sub("\[nofanin\]","")
        # make data
        pininfo.No,pininfo.NetName,pininfo.Attribute,pininfo.PIN = make_pininfo(word)

        # connection list
        pininfo.ConnectInfo, @NoFanin, pininfo.Type = make_connection_data(word[@ConnectionList],pininfo)
        @NoFaninList["#{pininfo.NetName}"] = pininfo
        @List["#{pininfo.No}"] = pininfo

        @ConnectList["#{pininfo.No}"] = pininfo
        @NetNameList["#{pininfo.NetName}"] = pininfo
      elsif /\[out\/ioshort\]/ =~ word[@ConnectionList]
        word[@Attribute] = "ioshort"
        word[@ConnectionList] = word[@ConnectionList].sub("\[out\/ioshort\]","")
        # make data
        pininfo.No,pininfo.NetName,pininfo.Attribute,pininfo.PIN = make_pininfo(word)

        # connection list
        pininfo.ConnectInfo, @NoFanin, pininfo.Type = make_connection_data(word[@ConnectionList],pininfo)
        @IOShortList["#{pininfo.NetName}"] = pininfo
        @List["#{pininfo.No}"] = pininfo

        @ConnectList["#{pininfo.No}"] = pininfo
        @NetNameList["#{pininfo.NetName}"] = pininfo
      else
        # make data
        pininfo.No,pininfo.NetName,pininfo.Attribute,pininfo.PIN = make_pininfo(word)

        # connection list
        pininfo.ConnectInfo, @Other, pininfo.Type = make_connection_data(word[@ConnectionList],pininfo)

        @ConnectList["#{pininfo.No}"] = pininfo
        @List["#{pininfo.No}"] = pininfo
        @NetNameList["#{pininfo.NetName}"] = pininfo
     
      end
    end
    # Update Original-Data Structure
    @Report_Data = reportICE_tmp
   
    printf("@I:Pre-Operation Done\n")
  end # pre_operation
  
  # make pininfo
  def make_pininfo(word)
    /^.*,(\w*_PIN):/ =~ word[@ConnectionList]
    pin = $1
    return word[@PinNo], word[@PinName], word[@Attribute], pin
  end
  
  def make_connect_data_each(str)
#    /(\w*).(\w*):(\S*)$/ =~ str
    # Judgement for Bit-signal or Bus-signal
    if /.*\[.*\].*/ =~ str
      /(\w*).(\w*\[\d*\])\s*:\s*(\S*)$/ =~ str
    else
      /(\w*).(\w*)\s*:\s*(\S*)$/ =~ str
    end
#    /(\w*).(\w*)\s*:\s*(\S*)$/ =~ str
    inst = $1.to_s
    sig = $2.to_s
    dir = $3.to_s
    instpin = inst + "." + sig
    # OUT_PIN/IN_PIN
    if sig == ""
      /(\w*):(\S*)$/ =~ str
      inst = $1.to_s
      sig = ""
      dir = $2.to_s
      instpin = inst
    end
    # Error Check
    if inst == nil || sig == nil || dir == nil || instpin ==  nil
      printf("Inernal error[File:%s(line:%d)]\n",__FILE__,__LINE__)
      printf("  found unrecognized line about \"%s\".please check make_chip report file\n",str)
    end
    return inst, sig, dir, instpin
  end
  
  def make_connection_data(word,pininfo)
    each_data = Array.new
    connect_info = Array.new
    in_out_pin_flag = false
    spl = word.split(",")
    spl.each{|str|
      connect = ReportConnectInfo.new
      connect.InstName,connect.NetName,connect.Direction,connect.InstPinName = make_connect_data_each(str)
      connect.NetName = pininfo.NetName
      connect.PIN = pininfo.PIN
      @InstSigList["#{connect.InstPinName}"] = connect
      in_out_pin_flag = true if connect.InstPinName == "IN_PIN" || connect.InstPinName == "OUT_PIN"
      connect_info << connect
      each_data << connect.InstName + "." + connect.NetName
      @InstList << connect.InstName
      @InstList.uniq!
    }
    # through type "one signal / OUT_PIN or IN_PIN"
    type = nil
    if spl.size == 2 && in_out_pin_flag == true
      type = "Through"
    end
    return connect_info, each_data ,type
  end
  
  def make_data
    printf("\nAnalize Report File\n")
    read
    pre_operation
  end
  
  
  #
  # Make ChipInfo
  #   - Remake focusing Module Section
  def make_ChipInfo
    inst_list = Array.new
    sig_list = Array.new
    @Report_Data.each{|line|
      tmp = line[2].split(",")
      tmp.each{|info|
        sig_info = Array.new
        inst_name = info.split(":")[0].split(".")[0]
        if @Flag == "all"
          inst_list << inst_name
        else
          if (( inst_name != "IN_PIN")&&( inst_name != "IO_PIN")&&( inst_name != "OUT_PIN"))
            inst_list << inst_name
          end
        end
        
        signal_name = info.split(":")[0].split(".")[1]
        direction = info.split(":")[1]
        connection = line[1]
        sig_info << inst_name
        sig_info << signal_name
        sig_info << direction
        sig_info << connection
        sig_list << sig_info
      }
    }
    inst_list.uniq!
    inst_list.each{|inst|
      tmp = Array.new
      sig_list.each{|line|
        if inst == line[0]
          line.delete_at(0)
          tmp << line
        end
      }
      each_inst = Array.new
      each_inst << inst
      each_inst << tmp
      @chip_info << each_inst
    }
  end

  #
  # Print Method
  #

  #
  # make relation
  #
  def make_relation
    @List.each_value{|each_inf|
      each_inf.ConnectInfo.each{|inf|
        tmp = RelationInf.new
        tmp.NetName = each_inf.NetName
        in_data = Array.new
        out_data = Array.new
        inout_data = Array.new
        each_inf.ConnectInfo.each{|inf2|
          next if inf2.InstPinName == inf.InstPinName # skip 
          if inf2.Direction == "IN"
            if inf2.InstPinName != ""
              in_data << inf2.InstPinName
            else
              in_data << inf2.InstName
            end
          elsif inf2.Direction == "OUT"
            if inf2.InstPinName != ""
              out_data << inf2.InstPinName
            else
              out_data << inf2.InstName
            end
          elsif inf2.Direction == "I/O"
            if inf2.InstPinName != ""
              inout_data << inf2.InstPinName
            else
              inout_data << inf2.InstName
            end
=begin
          elsif inf2.Direction == "I/O[out/ioshort]"
            if inf2.InstPinName != ""
              inout_data << inf2.InstPinName
            else
              inout_data << inf2.InstName
            end
          elsif inf2.Direction == "OUT[out/ioshort]"
            if inf2.InstPinName != ""
              inout_data << inf2.InstPinName
            else
              inout_data << inf2.InstName
            end
=end
          else
            $ERROR_CNT += 1
            printf("@E:Not Found signal direction about net:%s. not support this format in this version.\n",inf2.NetName)
            printf("Please check input file for make_chip\n")
            p inf2

            Common.print_summary
            exit
          end
        }
        tmp.Direction = inf.Direction
        tmp.IN = in_data
        tmp.OUT = out_data
        tmp.INOUT = inout_data
        @ConnectRelation["#{inf.InstPinName}"] = tmp  
      }
    }
  end

  def relation
    make_data
    make_relation
  end

  def print
    puts "@I:Print Data Structure"
    @Report_Data.each do |tmp|; p tmp; end
  end

  def print_pulldown
    puts "@I:Print Pull-Down signal"
    @Report_Data.each do |tmp|
      if tmp[@Attribute] == "pulldown"; puts tmp[@PinName]; end
    end    
  end

  def print_pullup
    puts "@I:Print Pull-Up signal"
    @Report_Data.each do |tmp|
      if tmp[@Attribute] == "pullup"; puts tmp[@PinName]; end
    end    
  end

  def print_opennet
    puts ":I:Print Open-Net signal"
    @Report_Data.each do |tmp|
      if tmp[@Attribute] == "opennet"; puts tmp[@PinName]; end
    end    
  end

  def print_nofanin
    puts ":I:Print No-Fanin signal"
    @Report_Data.each do |tmp|
      if tmp[@Attribute] == "nofanin"; puts tmp[@PinName]; end
    end    
  end

  def get_opennet
    list = Array.new
    @Report_Data.each do |tmp|
      if tmp[@Attribute] == "opennet"
        pininfo = ReportPinInfo.new
        pininfo.PinName = tmp[@PinName]
        /^(\w*).(\w*):\w*/ =~ tmp[@ConnectionList]
        pininfo.ModuleName = $1
        pininfo.SignalName = $2
        list << pininfo
      end
    end    
    return list
  end

  def get_nofanin
    list = Array.new
    @Report_Data.each do |tmp|
      if tmp[@Attribute] == "nofanin"
        pininfo = ReportPinInfo.new
        pininfo.PinName = tmp[@PinName]
        /^(\w*).(\w*):\w*/ =~ tmp[@ConnectionList]
        pininfo.ModuleName = $1
        pininfo.SignalName = $2
        list << pininfo
      end
    end    
    return list
  end

  def print_connection
    puts "@I:Print connection info for each signal"
    @Report_Data.each do |tmp|
      puts "-----------------------" 
      signal = tmp[@ConnectionList].split(",")
      printf("%3s:%s\n",tmp[@PinNo],tmp[@PinName])
      signal.each{|word|
        if /:IN/ =~ word
          word = word.sub(":IN","")
          printf("  -IN   : %s\n",word)
        end
        if /:OUT/ =~ word
          word = word.sub(":OUT","")
          printf("  -OUT  : %s\n",word)
        end
      }
      signal.clear
    end    
  end

  #
  # generate pin files
  #
  def gen_open_net
    file_name = "pins_open.para_ice"
    f = File::open("#{file_name}","w")
    
    print_file_header(f,"Pins parameter file for Open net",$TOOL,$VERSION,"//")
    @Report_Data.each do |tmp|
      if tmp[@Attribute] == "opennet";
        f.printf("\n")
        f.printf("\/\/ %s\n",tmp[@ConnectionList])
        f.printf("PIN: %s TYPE OUT\n",tmp[@PinName])
        f.printf("END_PIN:\n")
      end
    end        
    f.close    
  end

  def gen_pins
    file_name = "pins.para_ice"
    f = File::open("#{file_name}","w")
    
    print_file_header(f,"Pins parameter file for Open net",$TOOL,$VERSION,"//")
    @chip_info.sort{|a,b|
      a[0] <=> b[0]
    }.each do |inst|
      f.printf("\n")
      f.printf("\/\/\n")
      f.printf("\/\/ For %s\n",inst[0])
      f.printf("\/\/\n")
      inst[1].each{|a|
        f.printf("\/\/")
        a.each{|b|
          f.printf(" %s",b)
        }
        f.printf("\n")
        f.printf("PIN: %s TYPE %s\n",a[0],a[1])
        f.printf("END_PIN:\n")
        f.printf("\n")
      }
    end        
    f.close    
  end
  
end

module GetReportInf
  def get_inst_inf(inst_name,connect)
    tmp = Hash.new
    # connect = @ConnectRelation
    connect.each{|inst_pin_name,connect_inf|
      if inst_pin_name.split(".")[0] == inst_name
        tmp["#{inst_pin_name}"] = connect_inf
      end
    }
    return tmp
  end
  module_function :get_inst_inf
end


