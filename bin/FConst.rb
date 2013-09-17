#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-
#############################################################
#
# FConst
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009-2012 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Generate SDC File for FPGA-ICE Synthesi
#
# [Usage]
# -%ruby FConst.rb 
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
$:.unshift(File.dirname(__FILE__) + "/../bin")
require "FICE_def"
require "system"
require "common"
require "optparse"
require "FICE_DB"
require "FMakeConf"
require "FMakeFileControl"
require "FMakeVerilogList"
require "XMLParse"
require "fileutils"
require "pp"

#
# Global Setting
#
$SUB_TOOL        = "FConst" # Tool Name
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
class FConst
  
  def initialize
    @Outdir = "./"

    @ClockControlFile = FICE_DB::CLOCK_CONTROL
    @ClockControlTime = nil
    @ClockControlVer = nil
    @Conf = nil

    @SystemClockFreq = 32.000

    # Conf File
    # Verilog List File at Startup
    @VerilogListFile = nil
    # TopModule Name
    @TopModuleName = nil
    @ProductBase = "/design01/iecube_rl78/Products"
    # Product Name
    @ProductName = nil
    @DeviceName = nil
    # Device Version
    @DevVer = nil
    # ICE Version
    @ICEVer = nil
    # Add Modify Instance name( Array )
    @AddModifyInst = Array.new
    # Verilog Define
    @VerilogDefine = Array.new

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
      opt.on('--clock-control [ClockControlFile]','Clock Control File (Defalt:/design01/iecube_rl78/Common/Constraints/Control/latest/ClockControl.cnt)'){|v| @ClockControlFile = v }
      opt.on('--system-clock-freq [Freqency(MHz)]','System Clock Freqency (Defult:32)'){|v| @SystemClockFreq = v }
      opt.on('--conf [ConfFile]','Clock Control File'){|v| @Conf = v }
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:Not support  "#{ARGV}" option or need argument using this option.
EOB
      return false
    end

    if @Conf.nil?
      $ERROR_CNT += 1
      printf "@E: You have to describe conf File(option:--conf)\n"
      Common.print_summary
      exit 1
    end
    
    return true
  end

  #
  # Get Clock Clontrol Information
  #
  def get_ClockControl(ccf)
    clock_inf = Array.new

    printf "@I:Get Clock Control Information\n"
    # Readable Check
    unless File::readable?(ccf)
      $ERROR_CNT += 1
      printf "@E:Could not read #{ccf}. please check it.\n"
      Common.print_summary
      exit 1
    else
      @ClockControlTime = File.stat(ccf).mtime
      if /Common\/Constraints/ =~ ccf
        # Read Common file
        @ClockControlVer = Common.get_RealPath(File.dirname(ccf)).split("/").last
        printf "[Inf]\n"
        printf " - Name : #{ccf} (#{@ClockControlTime})\n"
        printf " - Ver  : #{@ClockControlVer}\n"
        printf "\n"
      end
    end

    # Get File Information
    inf = Array.new
    open(ccf).each do |line|
      # Get Each Information
      tmp = line.strip.split(" :")
      tmp2 = Array.new
      tmp.each do |d|
        tmp2 << d.strip
      end
      inf << tmp2
    end
    driver = nil
    pin = nil
    hierarchy = nil
    freq = nil
    template = nil
    no = 1
    inf.each do |data|
      case data[0].downcase
      when "driver"
        driver = data[1]
      when "pin"
        pin = data[1]
      when "hierarchy"
        hierarchy = data[1]
      when "freq"
        freq = data[1]
      when "template"
        template = data[1]
      end  if data.size != 0

      if /#/ =~ data[0] || data.size == 0
        if driver && ( pin.nil? || hierarchy.nil? || template.nil? )
          printf "@ERROR ( Could not analyze Clock Control File. )\n"
          exit 1
        elsif driver != nil
#          if $VERBOSE
          printf "@I:Save Clock Information ( No : #{no} )\n"
          printf " - Driver    : #{driver}\n"
          printf " - Pin       : #{pin}\n"
          printf " - Hierarchy : #{hierarchy}\n"
          printf " - Freq      : #{freq}\n"
          printf " - Template  : #{template}\n"
          printf "\n"
          no += 1
#          end
          clock_control_inf = ClockControlInf.new(
                                                  :driver => driver,
                                                  :pin => pin,
                                                  :hierarchy => hierarchy,
                                                  :freq => freq,
                                                  :template => template
                                                  )        
          clock_inf << clock_control_inf
        end
        driver = nil
        pin = nil
        hierarchy = nil
        freq = nil
        template = nil        
      end
    end
    return clock_inf
  end

  #
  # Get Conf
  #  - get Conf File infomation
  #
  def get_Conf(conf)
    # Read Conf File
    conf_db = FMakeConf.new( 
                            :conffile      => conf,
                            ).analyze
    set_each_data(conf_db)

    xml = FMakeFileControl::make_FileName(nil,@ProductName,@DevVer,@ICEVer,".xml")
    # Generate XML
    xml_file  = generate_xml_html(@TopModuleName,xml)
    
    # Make output dir
    if FileTest::directory?(@Outdir) == false
      Dir::mkdir(@Outdir,0777)
    end

    return conf_db, xml_file
  end

  #
  # analyze_path
  #
  def analyze_Path(clock_inf,conf_db,xml)
    printf "@I:read XML File(#{xml}) ... "
    root = XMLParse.read(xml)
    printf "Done\n"
    XMLParse.get_ModuleList(root)
    top_module =  conf_db.TOP_MODULE

    # Search Path
    printf "@I:Search Clock Net ... \n"
    clock_inf.each_with_index do |inf,i|
      printf "[Pattern #{i}]\n"
      printf " - Driver : #{inf.Driver}\n"
      printf " - Pin : #{inf.Pin}\n"
      path_all = resolve_Hier_from_Instance(root,top_module,inf.Driver.split("."))
      if path_all.size == 0
        printf "Not exist in your circuit.\n"
      else
        path_all.each do |path|
          if path[1] != inf.Driver
            printf "Not Found Instance #{inf.Driver}\n"
            inf.Comment = "Not Found Instance"
          else
            printf "Found Instance Path(#{inf.Driver})\n"
            module_path = path[0].split(".")
            current_module = module_path.pop # non-use
            upper_module = module_path.pop
            upper_module = top_module if upper_module.nil?
            inst_name = inf.Driver.split(".").last
            printf "Search Connected-Wire in the Circuit (Module:#{upper_module}, Inst:#{inst_name}, Pin:#{inf.Pin})\n"
            connect_inf = XMLParse::get_ConnectList(root,upper_module,inst_name)
            if connect_inf.size == 0
                $NOTE_CNT += 1
                printf "@N:Could not found #{inst_name} instance.\n"
            else
              if connect_inf[inf.Pin].nil?
                $WARNING_CNT += 1
                printf "@W:Could not found #{inf.Pin} in #{inst_name}.\n"
              else
                if connect_inf[inf.Pin].size != 1
                  $INTERNAL_ERROR_CNT += 1
                  printf "@internal error ( Not Support multiple-wire)\n"
                  exit 1
                else             
                  tmp_path =  inf.Driver.split(".")
                  tmp_path.pop
                  wire_ins = tmp_path.join(".")
                  if wire_ins == ""
                    inf.Wire = connect_inf[inf.Pin][0].Name
                  else
                    inf.Wire = wire_ins + "." + connect_inf[inf.Pin][0].Name
                  end
                  inf.Comment = "Found"
                  printf "Found Connected Wire Name : #{inf.Wire}\n"
                end
              end
            end
          end
        end
      end
      printf "\n"
    end
    printf "Done\n"
    return clock_inf
  end

  #
  # Resolve Multi Hier from Instance
  #   param : root (XMLParse)
  #           top_module
  #           connect_path Array (ex: a.b.c -> [a,b,c] )
  #   return : Module Path
  #
  private
  def resolve_Hier_from_Instance(root,top_module,connect_path)
    connect_TargetInstance = Array.new
    connect_path.each do |each_inst|
      instance_list = XMLParse::get_InstanceList(root,top_module)
      if $VERBOSE
        printf "Search Instance in #{top_module}\n"
        pp instance_list
        pp each_inst
      end
      instance_list.each do |list|
        if list[1] == each_inst   # compare to Module Name
          if connect_TargetInstance == []
            connect_TargetInstance << list
          else
            connect_TargetInstance.each do |upper|
              upper[0] = upper[0] + "." + list[0]
              upper[1] = upper[1] + "." + list[1]
            end
          end
          top_module = list[0]
        end
      end
    end
    return connect_TargetInstance
  end

  #
  # Set Each data to Global Variables
  #
  private
  def set_each_data(conf_db)
    # Get Each Data
    @TopModuleName = conf_db.TOP_MODULE
    @VerilogListFile =  conf_db.VERILOG_LIST
    @ProductName = conf_db.PRODUCT
    @DevVer = conf_db.PRODUCT_VER
    @ICEVer = conf_db.ICE_VER 
    if conf_db.VERILOG_DEFINE != nil
      @VerilogDefine << File.expand_path(conf_db.VERILOG_DEFINE)
      # File Check
      unless FileTest.readable?( conf_db.VERILOG_DEFINE)
        # ERROR and EXIT
        FMakeMessage::PrintError( :category => "FILE", :no => 21, :param => @VerilogDefine )
      end
    end
  end

  #
  # Gnerate XML and HTML
  #
  private
  def generate_xml_html(top_module,xml_base,html_base=nil)
    # Generate XML
    verilog_list = FMakeVerilogList.new( :filelist => @VerilogListFile,
                                         :xml_base => xml_base,
                                         :product => @ProductName,
                                         :dev_ver => @DevVer,
                                         :ice_ver => @ICEVer,
                                         :outdir  => @Outdir
                                         )
    xml_file = generate_xml(verilog_list,xml_base)
    @ModuleList = verilog_list.ModuleList
    @VerilogDefine << File.expand_path(verilog_list.v2xml_define)
    return xml_file 
  end

  #
  # Generate XML using FMakeVerilogList
  #
  private
  def generate_xml(verilog_list,xml)
    return  verilog_list.analyze_VerilogList
  end

  #
  # Generate SDC
  #
  def generate_SDC(clock_inf,conf_db)
    file = conf_db.PRODUCT + ".sdc"
    printf "@I:Generate SDC File ( #{file} )\n"
    f = open(file,"w")
    comment = "Constraint for FPGA-ICE" 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
    f.printf <<EOB

# ------------------------------------------------------------------------
#
# [Product]
#   Device Name : #{conf_db.PRODUCT}
#   System Clock Frequency(MHz) : #{@SystemClockFreq.to_s}
#
# [ClockControl]
#   File Name   : #{@ClockControlFile} (#{@ClockControlTime})
#   Ver         : #{@ClockControlVer}
#
# ------------------------------------------------------------------------

#
# Clock Constraint for #{conf_db.PRODUCT}
#
EOB
    clock_inf.each do |inf|
      /name\s+\{(\S*)\}\s+/ =~ inf.Template
      name = $1
      f.printf <<EOB

#
# [Clock - #{name}]
#   Driver    : #{inf.Driver}
#   Pin       : #{inf.Pin}
#   Hierarchy : #{inf.Hierarchy}
#   Freq      : #{inf.Freq}
#   Template  : #{inf.Template}
#
EOB
      if inf.Comment == "Found"
        if inf.Freq == "SyncSystemClock"
          sdc = inf.Template.sub("\$Wire",inf.Wire).sub("\$Freq",@SystemClockFreq.to_s)
        else
          sdc = inf.Template.sub("\$Wire",inf.Wire).sub("\$Freq",inf.Freq)
        end
        f.printf "#{sdc}\n"
      else
        f.printf "# *** Not Found Clock Information in this circuit *** \n"
      end
    end
    f.printf "\n\n"
    f.close
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
    # Get ClockControlFile
    clock_inf = get_ClockControl(@ClockControlFile)
    # Get Conf
    conf_db,xml = get_Conf(@Conf)
    # Analyze Clock Information
    clock_inf = analyze_Path(clock_inf,conf_db,xml)
    # Genratet SDC
    generate_SDC(clock_inf,conf_db)
    Common.print_summary
  end
  
end


if __FILE__ == $0
  fconst = FConst.new
  fconst.main
end
