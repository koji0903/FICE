#!/usr/bin/ruby
############################################################
#
#  mkice ( make_chip for ICE )
#
#   Author    : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#   Date      : 2009/12/08
#   Version   : 0.1
#
############################################################
#
# [Usage]
# Usage :ruby mkice.rb -report1 <ReportFile from Device> {-report2 <ReportFile from Pre-makechip>} {-connect <ConnectFile from Device>} -product <ProductName> -top <TopName> 
#  OPTION
#    -h/-help     : print help message
#    -v/-version  : print version
#    -verbose     : execute on verbose mode
#
#  NOTE
#    In case of chip hier : "-report1/-report2/-connect/-product/-top" must be specifed
#    In case of chip_top/eva_top hier : "-report1/-product/-top" must be specifed
# [Function]
#  
#
# [Output file]
#   - connect_mod_${TopModule}.para   : modified param file
#   - ConnectChList.txt               : connect list report
#   - pins_hrmacro_${TopModule}.para  : param file for removed hard macro
#   - connect_ice_${TopModule}.para   : param file for ICE-connect
#   - NameList.txt                    : Name list report
#   - connect_reverse_chip.para       : param file for reverse signal
#   - connect_nouse_chip.para         : param file for no-use signal
#   - other.v                         : verilog module for no-use signal
#
# [Sub file]
#  ~/bin/common.rb  : for common function
#       /system.rb  : for system function
#       /report.rb  : for analizing report file
#       /pinlist.rb : for analizing pinlist file
#       /connect.rb : for analizing connect file
#
############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "message"
require "system"
require "common"
require "report"
require "pinlist"
require "connect"

$TOOL    = "mkice"
$VERSION = "0.1-beta"
$VERBOSE = false
$CHECK   = true       # syntax check mode 
$MODE    = ""         # target hierarchy ("CHIP" or "OTHER")
                      # "OTHER" means chip_top or eva_top

$ERROR_CNT   = 0
$WARNING_CNT = 0
$NOTE_CNT    = 0

class MKICE
  
  # 
  # initialize
  #
  def initialize
    # for argument
    @Report = nil
    @Report1File = nil # Report file from Device "-report1"
    @Report2File    = nil # Report file from Pre-make "-report2"
    @PinList      = nil # PinList file for target device "-pinlist"
    @ConnectFile  = nil # Connect file at make_chip "-connect"
    @ProductName  = nil # Product name for parameter file "-product"
    @TopModule    = nil # Top module name "-top"

    # for internal operation
    @Report = Array.new
    @Report_NoFanin = Hash.new  # List of NoFanin Signal in Device report
    @Report_OpenNet = Hash.new  # List of Open Signal in Device report
    @Report_PinList = Hash.new
    @Report_InstSigList = Hash.new

    @Report1 = Array.new
    @Report1_NoFanin = Hash.new  # List of NoFanin Signal in Device report
    @Report1_OpenNet = Hash.new  # List of Open Signal in Device report
    @Report1_PinList = Hash.new
    @Report1_InstSigList = Hash.new

    @Report2 = Array.new
    @Report2_NoFanin = Hash.new     # List of NoFanin Signal in ICE report
    @Report2_OpenNet = Hash.new     # List of Open Signal in ICE report
    @Report2_PinList = Hash.new
    @Report2_InstSigList = Hash.new

    @PinList_Data = Hash.new
    @PinList_Data_pin = Hash.new
    @Connect_Data = Array.new

    @OnlyICENoConnect = Hash.new

    @ICEPin_OpenNet = Array.new # Using Only ICE signal list
    @ICEPin_NoFanin = Array.new # Using Only ICE signal list


    # for NameList
    @NameList = Array.new
    @ChangeList = Hash.new
    @ChangeListSig = Hash.new
    
    @PinsICE = Array.new
    # for Connect
    @ConnectData = Array.new
    @ConnectMod = Array.new
    @ConnectICE = Array.new
    @ConnectChList = Array.new

  end

  #
  # print ussage
  #
  def print_usage
    printf("\n")
    printf("Usage :ruby %s.rb -report1 <ReportFile from Device> -report2 <ReportFile from Pre-makechip> -connect <ConnectFile from Device> -product <ProductName> -top <TopName>\n",$TOOL)
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
        Common.print_base
        print_usage
        exit
      when '-v','-version' then
        Common.print_base
        printf("")
        exit
      when '-verbose' then
        $VERBOSE = true
      when '-report1' then
        @Report1File = ARGV[i+1]
        i += 1
      when '-report2' then
        @Report2File = ARGV[i+1]
        i += 1
      when '-pinlist' then
        @PinList = ARGV[i+1]
        i += 1
      when '-connect' then
        @ConnectFile = ARGV[i+1]
        i += 1
      when '-product' then
        @ProductName = ARGV[i+1]
        i += 1
      when '-top' then
        @TopModule = ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        end
      end
    end 

    # Check Argument
    check_argument
    
    # Check File
    check_file

    # pre-operation for output
    @ConnectFileMod = "connect_mod_" + @TopModule + ".para"

  end

  #
  # CheckArgument
  #
  def check_argument
    # MODE SELECT
    if @Report1File && @Report2File && @PinList && @ConnectFile && @ProductName && @TopModule
      $MODE = "CHIP"
    elsif @Report1File && !@Report2File && @PinList && !@ConnectFile && @ProductName && @TopModule
      $MODE = "OTHER"
    else
      $ERROR_CNT += 1
      printf("@E: The option you specifed was not enough\n")
      error
    end

    case $MODE
    when "CHIP" then
      $ERROR_CNT += Common.chk_argument("-report1",@Report1File)
      $ERROR_CNT += Common.chk_argument("-report2",@Report2File)
      $ERROR_CNT += Common.chk_argument("-pinlist",@PinList)
      $ERROR_CNT += Common.chk_argument("-connect",@ConnectFile)
      $ERROR_CNT += Common.chk_argument("-product",@ProductName)
      $ERROR_CNT += Common.chk_argument("-top",@TopModule)
    when "OTHER" then
      $ERROR_CNT += Common.chk_argument("-report1",@Report1File)
      $ERROR_CNT += Common.chk_argument("-pinlist",@PinList)
      $ERROR_CNT += Common.chk_argument("-product",@ProductName)
      $ERROR_CNT += Common.chk_argument("-top",@TopModule)
    else
      printf("@Internal error. (file:%s,line:%s)",__FILE__,__LINE__)
      error
    end

    if $ERROR_CNT != 0
      error
    end
  end
  
  #
  # CheckFile
  #
  def check_file
    case $MODE
    when "CHIP" then
      $ERROR_CNT += Common.chk_file("Report1",@Report1File)
      $ERROR_CNT += Common.chk_file("Report2",@Report2File)
      $ERROR_CNT += Common.chk_file("PinList",@PinList)
      $ERROR_CNT += Common.chk_file("Connect",@ConnectFile)
    when "OTHER" then
      $ERROR_CNT += Common.chk_file("Report1",@Report1File)
      $ERROR_CNT += Common.chk_file("PinList",@PinList)
    else
      printf("@Internal error. (file:%s,line:%s)",__FILE__,__LINE__)
      error
    end
    if $ERROR_CNT != 0
      error
    end
  end

  #
  # operation for OTHER
  #
  def operation_OTHER
    # Analize Report file
    @Report1_OpenNet, @Report1_NoFainin, @Report1, @Report1_PinList, @Report1_InstSigList \
    = analize_report(@Report1File)   # analize report (get open-net/no-fanin signals)
    @Report_InstSigList = @Report1_InstSigList

    # analize PinList file
    analize_pinlist(@PinList)  

    # make NameList
    printf("@I:make NameList\n")
    make_NameList_OTHER

    # Make ConnectICE
    printf("@I:make ConnectICE\n")
    make_ConnectICE

    # make PinsICE
    printf("@I:make PinsICE\n")
    make_PinsICE_OTHER

    # generate NameList
    gen_NameList
    # generate ConnectICE File
    gen_ConnectICE
    # generate PinsICE
    gen_PinsICE

  end

  #
  # operation for CHIP
  #
  def operation_CHIP
    
    # Analize Report file
    @Report2_OpenNet, @Report2_NoFanin, @Report2, @Report2_PinList, @Report2_InstSigList \
    = analize_report(@Report2File)   # analize report (get open-net/no-fanin signals)
    @Report1_OpenNet, @Report1_NoFainin, @Report1, @Report1_PinList, @Report1_InstSigList \
    = analize_report(@Report1File)   # analize report (get open-net/no-fanin signals)
    @Report_InstSigList = @Report2_InstSigList

    # analize PinList file
    analize_pinlist(@PinList)  

    # make only ICEPin
    make_OnlyICEPin

    
    #
    # make each data( NameList, ConnectICE, ConnectMod )
    #   - NameList  : for NameList.txt ( original/new/change signal report )
    #   - ConectICE : for connect_ice_${TopModule}.para ( using only ICE connection list )
    #
    # Make NameList
    printf("@I:make NameList\n")
    make_NameList_CHIP

    # Make ConnectICE
    printf("@I:make ConnectICE\n")
    make_ConnectICE

    # Make ConnectMod
    printf("@I:make ConnectMod\n")
    make_ConnectMod

    # make PinsICE
    make_PinsICE_CHIP

    #
    # generate each data( NameList, ConnectICE, ConnectMod )
    #   - NameList  : for NameList.txt ( original/new/change signal report )
    #   - ConectICE : for connect_ice_${TopModule}.para ( using only ICE connection list )
    #

    # generate ConnectMod File
    gen_ConnectMod
    # generate ConnectChList File
    gen_ConnectChList
    # generate PinsFile
    gen_PinsFile
    # generate ConnectICE File
    gen_ConnectICE
    # generate NameList
    gen_NameList
    # generate ConnectReverse
    gen_ConnectReverse
    # generate ConnectNoUse
    gen_ConnectNoUse
    # generate other
    gen_other_verilog
    # genraete PinsICE
    gen_PinsICE

  end
  
  #
  # Analize Report
  #
  def analize_report(report_file)
    report = Report.new(report_file)  
    report.make_data # make data from ReportFile

    printf("%s summary\n",report_file)
    printf(" The number of OpenNet signal is %d\n",report.OpenNetList.size)
    printf(" The number of NoFanin signal is %d\n",report.NoFaninList.size)
    return report.OpenNetList, report.NoFaninList, report.List, report.PinList, report.InstSigList
  end

  #
  # Analize PinList
  #
  def analize_pinlist(file)
    pinlist = PinList.new(file)
    pinlist.main
    @PinList_Data = pinlist.PinData
    @PinList_Data_pin = pinlist.PinData_pin

    # Check PinListFile
    if $CHECK == true && $MODE == "CHIP"
      error_list = Array.new
      siglist = Hash.new
      printf("@I:check PinList file information to Report file ... ")
      siglist = @Report_InstSigList
      @PinList_Data.each_value{|list|
        if( siglist.key?("#{list.InstPinName}") == false )
          $ERROR_CNT += 1
          error_list << list
        end
      }
      if error_list.size != 0
        printf("\n")
        error_list.each{|line|
          printf("@E: Signal : %s.%s(line:%d) in %s is not found in %s file\n",line.InstName,line.PinName,line.LineNo,File.basename("#{@PinList}"),File.basename("#{@Report}"))
        }
        error
      else
        printf("no error\n")
      end
    end
 
  end

  #
  # Make OnlyICEPin
  #
  def make_OnlyICEPin
    @ICEPin_OpenNet = make_ICEPin(@Report2_OpenNet,@Report1_OpenNet)
    @ICEPin_NoFanin = make_ICEPin(@Report2_NoFanin,@Report1_NoFanin)
    # make Report Hash data
    (@ICEPin_OpenNet+@ICEPin_NoFanin).each{|info|
      str = info.split(",")
      @OnlyICENoConnect["#{str[0]}"] = str[1]
    }
  end
  
  #
  # MakeNameList for CHIP
  #
  def make_NameList_CHIP
    change_signal = Hash.new
    @Report_InstSigList.each_key{|key|
      if ( @PinList_Data.key?("#{key}") == true )
        list = @Report_InstSigList.fetch("#{key}")
        pininfo = @PinList_Data.fetch("#{key}")
        if ( pininfo.Judge != "New   " )
          if (( list.PinName != pininfo.PinName ) && ( ( /^pull_/ =~ list.PinName) == nil ))
            change_signal["#{pininfo.PinName}"] = list.PinName
            str = "Change," + pininfo.PinName + "," + list.PinName + "," + pininfo.InstName
            @NameList << str
            @ChangeList["#{list.PinName}"] = str
            @ChangeListSig["#{pininfo.PinName}"] = str
          else
            str = "      ," + pininfo.PinName + "," + pininfo.PinName + "," + pininfo.InstName
            @NameList << str
          end
        else
          @NameList << pininfo.Judge + "," + pininfo.PinName + "," + pininfo.SignalName + "," + pininfo.InstName
        end
      end
    }
  end

  #
  # Make NameList for OTHER
  #
  def make_NameList_OTHER
    change_signal = Hash.new
    @PinList_Data.each_value{|pininfo|
      if pininfo.Judge == "New   "
        str = pininfo.Judge + "," + pininfo.PinName + "," + pininfo.SignalName + "," + pininfo.InstName
        @NameList << str
      end
    }
    @Report_InstSigList.each_key{|key|
      if ( @PinList_Data.key?("#{key}") == true )
        list = @Report_InstSigList.fetch("#{key}")
        pininfo = @PinList_Data.fetch("#{key}")
        if ( pininfo.Judge != "New   " )
          if (( list.PinName != pininfo.PinName ) && ( ( /^pull_/ =~ list.PinName) == nil ))
            change_signal["#{pininfo.PinName}"] = list.PinName
            str = "Change," + pininfo.PinName + "," + list.PinName + "," + pininfo.InstName
            @NameList << str
            @ChangeList["#{list.PinName}"] = str
            @ChangeListSig["#{pininfo.PinName}"] = str
          else
            str = "      ," + pininfo.PinName + "," + pininfo.PinName + "," + pininfo.InstName
            @NameList << str
          end
        end
      end
    }
  end

  #
  # Make NameList for OTHER
  #
  def make_PinsICE_OTHER
    @PinList_Data.each_value{|pininfo|
      if ( pininfo.Judge == "New   " )
        @PinsICE << pininfo.InstName + "," + pininfo.SignalName + "," + pininfo.Direction 
      end
    }
    @Report_InstSigList.each_key{|key|
      if ( @PinList_Data.key?("#{key}") == true )
        list = @Report_InstSigList.fetch("#{key}")
        pininfo = @PinList_Data.fetch("#{key}")
        if( pininfo.Judge != "New   ")
          if(@OnlyICENoConnect.key?("#{list.PinName}") == false )
            if ( list.InstPinName == pininfo.InstPinName) 
              @PinsICE << pininfo.InstName + "," + list.SignalName + "," + list.Direction 
            end
          end
        end
      end
    }
  end

  #
  # Make ConnectICE
  #
  def make_ConnectICE
    @PinList_Data.each_value{|value|
      if( value.Judge == "New   ")
        if ( value.SignalName != value.PinName )
          @ConnectICE << value.InstName + "," + value.PinName + "," + value.SignalName 
        end
      end
    }
  end

  #
  # Make PinsICE
  #
  def make_PinsICE_CHIP
    @PinList_Data.each_value{|pininfo|
      if ( pininfo.Judge == "New   " )
        if ( @Report_InstSigList.key?("#{pininfo.InstPinName}") == true )
          @PinsICE << pininfo.InstName + "," + pininfo.SignalName + "," + pininfo.Direction 
        end
      end
    }
    @Report_InstSigList.each_key{|key|
      if ( @PinList_Data.key?("#{key}") == true )
        list = @Report_InstSigList.fetch("#{key}")
        pininfo = @PinList_Data.fetch("#{key}")
        if( pininfo.Judge != "New   ")
          if(@OnlyICENoConnect.key?("#{list.PinName}") == false )
            if ( list.InstPinName == pininfo.InstPinName) 
              if (( /^pull_/ =~ list.PinName) != nil )
                @PinsICE << pininfo.InstName + "," + pininfo.PinName + "," + list.Direction 
              else
                @PinsICE << pininfo.InstName + "," + list.PinName + "," + list.Direction 
              end
            end
          end
        end
      end
    }
  end

  #
  # Make ConnectMod
  #
  def make_ConnectMod
    connect_mod_list = Hash.new
    @PinList_Data.each_value{|value|
      if( value.Judge == "New   ")
        connect_mod_list["#{value.InstPinName}"] = value
      end
    }
    @Report2.each_value{|pininfo|
      if ( (( /pull_down/ =~ pininfo.PinName.to_s ) != nil ) || ((/pull_up/ =~ pininfo.PinName.to_s) != nil ) )
        pininfo.ConnectInfo.each{|siginfo| 
          if ( @PinList_Data_pin.key?(siginfo.SignalName) == true )
            pinlist = @PinList_Data_pin.fetch(siginfo.SignalName)
            if ( pinlist.Judge !=  "New   ")
              if ( ( @Report2_PinList.key?(siginfo.SignalName) == false ) && ( @ChangeListSig.key?(siginfo.SignalName) == false ))
                str = siginfo.InstName.to_s + "." + siginfo.SignalName.to_s
                connect_mod_list["#{str}"] = siginfo
                break
              end
            end
          end
        }
      end
    } # @Report2.each_value{|pininfo|   
    # modify ConnectFile
    printf("@I:modify Connect file\n")

    # get Connect File
    connect = Connect.new(@ConnectFile)
    connect.read
    @ConnectData= connect.FileData
    mod_ConnectFile(connect_mod_list)
  end

  #
  # mod ConnectFile
  #
  def mod_ConnectFile(target)    
    line_mod = ""
    tmp = Array.new
    if ( @ConnectFile != nil )
      @ConnectData.each{|line|
        line_mod = line
        /^\s*\S+\:\s*(\S+)\s*(\S+)\s*/ =~ line
        inst_pin_name = $1.to_s + "." + $2.to_s
        if (target.key?(inst_pin_name) == true )
          list = target.fetch(inst_pin_name)
          if ( /\/\/forDevice/ =~ line)
          elsif ( list.InstPinName == inst_pin_name )
            line_mod = "\/\/forDevice(opin) " + line
            @ConnectChList << line_mod
          end
          tmp << line_mod
        else
          tmp << line
        end
        @ConnectData = tmp # update
      }
       @ConnectMod = @ConnectData
    end
  end

  #
  # make ICE Pin Infromation for para file.
  # 
  def make_ICEPin(ice,device)
    common_key = Array.new
    onlyICE = Hash.new
    ice_pin = Array.new
    # correct common_key Report2 & Report1
    ice.each_key{|key_ice|
      device.each_key{|key_device|
        if key_ice == key_device
          common_key << key_ice
        end
      }
    }
    # make Only ICE report NoFanin/Open List
    onlyICE = ice
    common_key.each{|key|
      onlyICE.delete("#{key}")
    }


    # compare only ICE info an PinLinst info
    onlyICE.each{|ice_key,ice_value|
      str = ""
      ice_value.ConnectInfo.each{|connect|
        inst_pin_name = connect.InstName + "." + connect.SignalName
        if ( @PinList_Data.key?("#{inst_pin_name.to_s}")  == true )
          str = ice_key + "," + @PinList_Data["#{inst_pin_name.to_s}"].InstName.to_s
          break
        else
          str = ice_value.PinName + ",Device Only or RFU"
        end
      }
      ice_pin << str
    }
    return ice_pin
  end

  

  #
  # Generate connect_mod file
  #
  def gen_ConnectMod
    file_name = "connect_mod_" + @TopModule + ".para" 
    printf("@I:generate %s file\n",file_name)
    f = open("#{file_name}","w")
    comment = "Connect mod file, which is refferd \n//   " + @ConnectFile
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"//")
    @ConnectMod.each{|line|
      f.printf("%s\n",line)
    }
    f.close
  end
  
  #
  # Generate ConnectChList
  #
  def gen_ConnectChList
    file_name = "ConnectChList.txt" 
    printf("@I:generate %s file\n",file_name)
    f = open("#{file_name}","w")
    comment = "Connect Change List"
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"//")
    @ConnectChList.each{|line|
      f.printf("%s\n",line)
    }
    f.close
  end
  
  #
  # Generate PinsFile include Hard Macro
  #
  def gen_PinsFile
    file_name = "pins_hrmacro_" + @TopModule + ".para" 
    printf("@I:generate %s file\n",file_name)
    f = open("#{file_name}","w")
    Common.print_file_header(f,"Pins for Hard Macro",$TOOL,$VERSION,"//")
    f.printf("INCLUDE_FILE: %s 1.00\n\n",@ProductName)
    f.printf("//////////////////////////////////////////\n")
    f.printf("// From Hard Macro or Replaced Macro    //\n")
    f.printf("//////////////////////////////////////////\n")
    @ICEPin_NoFanin.sort!
    @ICEPin_NoFanin.each{|info|
      str = info.split(",")
      f.printf("PIN: %s TYPE IN\t\/\/ %s\nEND_PIN:\n\n",str[0],str[1])
    }

    f.printf("//////////////////////////////////////////\n")
    f.printf("// To Hard Macro or Replaced Macro      //\n")
    f.printf("//////////////////////////////////////////\n")
    @ICEPin_OpenNet.sort!
    @ICEPin_OpenNet.each{|info|
      str = info.split(",")
      f.printf("PIN: %s TYPE OUT\t\/\/ %s\nEND_PIN:\n\n",str[0],str[1])
    }
    f.printf("\nEND_INCLUDE_FILE:\n")
    f.close
  end

  #
  # Generate PinsFile include Hard Macro
  #
  def gen_PinsICE
    file_name = "pins_ice_" + @TopModule + ".para" 
    printf("@I:generate %s file\n",file_name)
    f = open("#{file_name}","w")
    Common.print_file_header(f,"Pins for ICE",$TOOL,$VERSION,"//")
    f.printf("INCLUDE_FILE: %s 1.00\n\n",@ProductName)
    @PinsICE.each{|info|
      str = info.split(",")
      f.printf("PIN: %s TYPE %s\t\/\/ %s\nEND_PIN:\n\n",str[1],str[2],str[0])
    }
    f.printf("\nEND_INCLUDE_FILE:\n")
    f.close
  end

  #
  # gen_ConnectICE
  #
  def gen_ConnectICE
    file_name = "connect_ice_" + @TopModule + ".para"
    printf("@I:generate %s file\n",file_name)
    f = open("#{file_name}","w")
    Common.print_file_header(f,"Conect File for ICE",$TOOL,$VERSION,"//")
    f.printf("INCLUDE_FILE: %s 1.00\n\n",@ProductName)
    @ConnectICE.each{|line|
      split = line.split(",")
      f.printf("NET:\t%-15s%-15s%-15s\n",split[0],split[1],split[2])
    }
    f.printf("\nEND_INCLUDE_FILE:\n\n")
    f.close    
  end

  #
  # gen_NameList
  #
  def gen_NameList
    name_list = Array.new
    file_name = "NameList.txt"
    printf("@I:generate %s file\n",file_name)
    f = open("#{file_name}","w")
    Common.print_file_header(f,"NameList for ICE",$TOOL,$VERSION,"//")
    f.printf("+---------+----------------+----------------+----------------+\n")
    f.printf("| Judge   | Pin            | Signal         | Inst           |\n")
    # sort for InstName
    @NameList.each{|line|
      split = line.split(",")
      name_list <<  split[3].to_s + "," + split[2] + "," + split[1] + "," + split[0]
    }
    name_list.uniq!
    name_list.sort!
    name_list.each{|line|
      split = line.split(",")
      f.printf("+---------+----------------+----------------+----------------+\n")
      f.printf("| %-8s| %-15s| %-15s| %-15s|\n",split[3],split[2],split[1],split[0])
    }
    f.printf("+---------+----------------+----------------+----------------+\n")
    f.close    
  end
  
  #
  # Generate Connecet Reverse
  #
  def gen_ConnectReverse
    file_name = "connect_reverse_" + @TopModule + ".para" 
    printf("@I:generate %s file\n",file_name)
    f = open("#{file_name}","w")
    comment = "Connect Reverse file \n//  reffered  " + @ConnectFile
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"//")
    f.printf("INCLUDE_FILE: %s 1.00\n\n",@ProductName);
    list = Array.new
    @ChangeList.each_value{|value|
      spl = value.split(",")
      list << spl[2].to_s + "," + spl[1].to_s
    }
    list.sort!
    list.each{|line|
      spl = line.split(",")
      f.printf("NET:                chip            %-16s%-17s\n",spl[0],spl[1])
    }
    f.printf("END_INCLUDE_FILE:\n");
    f.close
  end

  #
  # generate ConnectNoUse
  #
  def gen_ConnectNoUse
    file_name = "connect_nouse_" + @TopModule + ".para" 
    printf("@I:generate %s file\n",file_name)
    f = open("#{file_name}","w")
    comment = "Connect NoUse file \n//  reffered  " + @ConnectFile
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"//")
    f.printf("INCLUDE_FILE: %s 1.00\n\n",@ProductName)
    @ICEPin_NoFanin.sort!
    @ICEPin_NoFanin.each{|line|
      stl = line.split(",")
      if stl[1] == "Device Only or RFU"
        f.printf("PULLDOWN:       chip            %-15s\n",stl[0])
      end
    }
    f.printf("\n")
    f.printf("END_INCLUDE_FILE:\n")
    f.close
  end

  # 
  # generate other verilog
  #
  def gen_other_verilog
    file_name = "other.v" 
    printf("@I:generate %s file\n",file_name)
    f = open("#{file_name}","w")
    comment = "Circuit for no-use signal for ICE"
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"//")
    f.printf("module other \(\n")
    @ICEPin_OpenNet.sort!
    # define in/out signal
    line_cnt = 0
    @ICEPin_OpenNet.each{|line|
      stl = line.split(",")
      if stl[1] == "Device Only or RFU"
        if line_cnt == 0
          f.printf("\t %s\n",stl[0])
        else
          f.printf("\t,%s\n",stl[0])
        end
        line_cnt += 1
      end
    }
    f.printf("\t\);\n")
    @ICEPin_OpenNet.each{|line|
      stl = line.split(",")
      if stl[1] == "Device Only or RFU"
        f.printf("\tinput\t%-10s ;\n",stl[0])
      end
    }
    
    # define in/out port
    f.printf("endmodule\n")
  end

  #
  # Error operation
  #
  def error
    print_usage
    Common.print_summary
    exit 1
  end

  #
  # 
  # main
  #
  def main
    get_argument                    # get argument & check parameter/file
    case $MODE
    when "CHIP" then
      @Report = @Report2File
      operation_CHIP
    when "OTHER" then
      @Report = @Report1File
      operation_OTHER
    else
      printf("@Internal error. (file:%s,line:%s)",__FILE__,__LINE__)
      error
    end
    Common.print_summary
  end
end

mkice = MKICE.new
mkice.main
