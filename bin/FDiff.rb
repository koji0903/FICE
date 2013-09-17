#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-
$GEM_HOME_PATH = "/home/product/div-micom-ice/data/proj/RL78/Common/local/gems/1.8"
ENV["GEM_HOME"] = $GEM_HOME_PATH

$:.unshift(File.dirname(__FILE__) + "/../lib")
$:.unshift(File.dirname(__FILE__) + "/../bin")
require "FICE_def"
require "system"
require "common"
require "optparse"
require "FMakeConf"
require "pp"
#
# Global Setting
#
$TOOL            = "FICE"  # Envirment Name
$SUB_TOOL        = "FDiff" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
$TEST_MODE = false
Version          = $VERSION # For OptParse


#############################################################
#
# FDiff
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
# -%ruby FDiff.rb --conf ${Conf File} --golden ${Golden Connect} --revised ${Revised Connect} --expect_dir ${ExpectFile} --report ${Report}
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


#
# Main Class
#
class FDiff

  #
  # Data Structure for Summary Report
  #
  class Summary
    attr_accessor :ModuleName
    attr_accessor :Type
    attr_accessor :Total
    attr_accessor :OK
    attr_accessor :Same
    attr_accessor :Expect
    attr_accessor :CommonExpect
    attr_accessor :AutoExpect
    attr_accessor :LocalExpect
    attr_accessor :UnusedExpect
    attr_accessor :CommonUnusedExpect
    attr_accessor :AutoUnusedExpect
    attr_accessor :LocalUnusedExpect
    attr_accessor :NG
    def initialize
      @ModuleName = nil
      @Type = "Unknown"
      @Total = 0
      @OK = 0
      @NG = 0
      @Same = 0
      @Expect = 0
      @CommonExpect = 0
      @AutoExpect = 0
      @LocalExpect = 0
      @UnusedExpect = 0
      @CommonUnusedExpect = 0
      @AutoUnusedExpect = 0
      @LocalUnusedExpect = 0
    end
    def add_OK
      @Total += 1
      @OK += 1
    end
    def add_NG
      @Total += 1
      @NG += 1
    end
    def add_Same
      @Same += 1      
    end
    def add_Expect
      @Expect += 1      
    end
    def add_CommonExpect
      @CommonExpect += 1      
    end
    def add_AutoExpect
      @AutoExpect += 1      
    end
    def add_LocalExpect
      @LocalExpect += 1      
    end
    def add_UnusedExpect
      @NG += 1
      @Total += 1
      @UnusedExpect += 1
    end
    def add_CommonUnusedExpect
      @CommonUnusedExpect += 1
    end
    def add_AutoUnusedExpect
      @AutoUnusedExpect += 1
    end
    def add_LocalUnusedExpect
      @LocalUnusedExpect += 1
    end
  end

  #
  # Data Structure for Conenct List
  #
  class ConnectList
    attr_accessor :Base
    attr_accessor :Inst
    attr_accessor :Direction
    attr_accessor :Connect
    def initialize(inst,base,direction)
      @Base = base
      @Direction = direction
      @Inst = inst
      @Connect = Array.new
    end
    def add(str)
      @Connect << str
    end
  end

  #
  # Macro Information for Quality
  #
  class MacroInf
    attr_accessor :InstName, :ModuleName
    attr_accessor :MacroType
    attr_accessor :ChangeConnectionFlag
    def initialize(inf)
      if inf.nil?
        @InstName = nil
        @ModuleName = nil
        @MacroType = nil
        @ChangeConnectionFlag = false
      else
        @InstName = inf[:inst_name]
        @ModuleName = inf[:mod_name]
        @ChangeConnectionFlag = false
      end
    end
    def set_inf(inf)
      set_type(inf.Type)
      set_connect_flag(inf.Total,inf.Same)
    end
    private    
    def set_type(type)
      @MacroType = type
    end
    def set_connect_flag(total,same)
      @ChangeConnectionFlag = true if total != same
    end
  end
  
  #
  # Special Inf
  #
  class SpecialInf
    attr_accessor :DLY, :NF, :CTS, :OTHER
    def initialize
      @DLY, @NF, @CTS, @OTHER = false,false,false,false
    end
  end

  #-------------------------------------------------------------
  def initialize
    @Product = nil
    @ConfFile = nil
    @GoldenReport = nil
    @GoldenPrefix = nil
    @RevisedReport = nil
    @RevisedPrefix = nil
    @ExpectDir = nil
    @CommonExpectDir = nil
    @AutoExpectDir = nil
    @Report = Array.new
    @ReportFile = "connection_Diff.report"
    @Summary = Hash.new
    @summary = nil
    @ErrorList = Hash.new
    @InstInf = Hash.new # {Instance Name => ModuleName}
    @all_rep = nil
    # SummaryTmp
    @SummaryTmp = "tmp.txt"
    # Log
    Common.make_dir("result")
    @ConnectCSV =  "result/Connect.csv"
    @summary_csv = nil
    @macro_inf = Hash.new

    @GoldenReport_Ver = nil
    @GoldenReport_Ver_Major = nil
    @GoldenReport_Ver_Minor = nil
    @GoldenReport_Ver_Revision = nil
    @RevisedReport_Ver = nil
    @RevisedReport_Ver_Major = nil
    @RevisedReport_Ver_Minor = nil
    @RevisedReport_Ver_Revision = nil

    @DuplicateExpect = Array.new
    @IgnoredExpect = Array.new
  end


  # param : path
  # ret   : inst,port
  def get_InstPort(path)
    tmp = path.split(".")
    port_t = tmp.pop
    if /(\w+)\[(\d+)\:(\d+)\]/ =~ port_t
      port = $1
#      msb = $2
#      lsb = $3
    elsif /(\w+)\[(\d+)\]/ =~ port_t
      port = $1
#      @BusPortion = $2
    else
      port = port_t
    end
    inst = tmp.join(".")
    return inst, port
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
      opt.on('--conf       [FMake Conf File]','Configuration File for FMake'){|v| @ConfFile = v }
      opt.on('--golden     [Golden Connect-Report]','Connect Report File for Golden'){|v| 
        @GoldenReport = v.split(":")[0]
        @GoldenPrefix = v.split(":")[1]
      }
      opt.on('--revised    [Revised Connect-Report]','Connect Report File for Revised'){|v| 
        @RevisedReport = v.split(":")[0]
        @RevisedPrefix = v.split(":")[1]
      }
      opt.on('--expect_dir [Execpt Directory for Connect-Diff]','Expect Directory'){|v| @ExpectDir = v }
      opt.on('--common_expect_dir [Execpt Directory for Connect-Diff]','Expect Directory'){|v| @CommonExpectDir = v }
      opt.on('--auto_expect_dir [Execpt Directory for Connect-Diff]','Expect Directory'){|v| @AutoExpectDir = v }
      opt.on('--report     [Diff Report File]','Diff Report'){|v| @ReportFile = v }
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:Not support  "#{ARGV}" option or need argument using this option.
EOB
      Common.print_summary
      exit 1
      return false
    end

    if @ConfFile.nil?
      $ERROR_CNT += 1
      printf("@E:You have to specify Conf File. \"--conf\" option.\n")
      Common.print_summary
      exit
    end

    unless File.directory?(@ExpectDir)
      $WARNING_CNT += 1 
      printf("@W:Does not exist #{@ExpectDir}. Please check directory path.\n")
    end unless @ExpectDir.nil?

    unless File.directory?(@CommonExpectDir)
      $WARNING_CNT += 1 
      printf("@W:Does not exist #{@CommonExpectDir}. Please check directory path.\n")
    end unless @CommonExpectDir.nil?

    unless File.directory?(@AutoExpectDir)
      $WARNING_CNT += 1 
      printf("@W:Does not exist #{@AutoExpectDir}. Please check directory path.\n")
    end unless @AutoExpectDir.nil?

    # Get FMake version from Report
    open(@GoldenReport).each do |line|
      if /FICE\(FMake\) ver (.*)/ =~ line
        @GoldenReport_Ver = $1        
        ver = @GoldenReport_Ver.split("-")[0]
        @GoldenReport_Ver_Major = ver.split(".")[0].to_i
        @GoldenReport_Ver_Minor = ver.split(".")[1].to_i
        @GoldenReport_Ver_Revision = ver.split(".")[2].to_i
        break
      end
    end
    open(@RevisedReport).each do |line|
      if /FICE\(FMake\) ver (.*)/ =~ line
        @RevisedReport_Ver = $1
        ver = @RevisedReport_Ver.split("-")[0]
        @RevisedReport_Ver_Major = ver.split(".")[0].to_i
        @RevisedReport_Ver_Minor = ver.split(".")[1].to_i
        @RevisedReport_Ver_Revision = ver.split(".")[2].to_i
        break
      end
    end

    if @GoldenReport_Ver == nil && @RevisedReport_Ver != nil
      $ERROR_CNT += 1
      printf("@E:%s file is generated by OLD FMake ( maybe 2.2.x or lower ). So, FDiff can not compare exactly. \n",@GoldenReport)
      printf("Please re-execute FMake Analyze Device.\n")
      Common.print_summary
      exit 1
    end
    # Uncompative 2.5.x / 2.4.x
    if @GoldenReport_Ver_Major >= 2 && @RevisedReport_Ver_Major <= 2
      if @GoldenReport_Ver_Minor >= 5 && @RevisedReport_Ver_Minor < 5
        $ERROR_CNT += 1
        printf("@E:Un-compatible the FMake Report version of %s(ver%s) and %s(%s) . So, FDiff can not compare exactly. \n",@GoldenReport,@GoldenReport_Ver,@RevisedReport,@RevisedReport_Ver)
        printf("Please re-execute FMake Analyze Device ( Use Latest Versin ).\n")
        Common.print_summary
        exit 1
      end
    end
    if @RevisedReport_Ver_Major >= 2 && @GoldenReport_Ver_Major <= 2
      if @RevisedReport_Ver_Minor >= 5 && @GoldenReport_Ver_Minor < 5
        $ERROR_CNT += 1
        printf("@E:Un-compatible the FMake Analyze Report version of %s(ver %s) and %s(ver %s) . So, FDiff can not compare exactly. \n",@GoldenReport,@GoldenReport_Ver,@RevisedReport,@RevisedReport_Ver)
        printf("Please re-execute FMake Analyze Device ( Use Latest Versin ).\n")
        Common.print_summary
        exit 1
      end
    end

    return true
  end
  
  #
  # Analyze report
  #  - param : report file
  #  - ret   : analyzed report data(Original Data format)
  #
  def analyze(conf_db,file,path,prefix=nil,expect_type=nil)
    # File Check
    FMakeMessage::PrintError( :category => "OPT", :no => 3, :file => file, :opt => ARGV.join(" ")) unless FileTest::readable?(file)
    # analyze each line
    open(file).each_with_index do |line,i|
      line = line.strip
      id = line.split(":")[0]
      if line == "" || line == "\n" || line[0] == "#"
        # Noting 
      elsif id == "M"
        # Define Module
        inf = line.split(":")[1].split(",")
        if prefix.nil?
          @InstInf[inf[0]] = inf[1]
        else
          @InstInf[prefix+"."+inf[0]] = inf[1]
        end
      elsif id == "I" || id == "E\n" || id == "E"
        # Define Insance
        # -- Now Skip -- #
      else
        # Define Connection
        if $DEBUG
          print "=================================\n"
          print line
        end
        # For Upper Comatible ( Delete Top Module )
        line = line.gsub("#{conf_db.TOP_MODULE}.","") unless conf_db.nil?
        line = line.gsub("#{conf_db.TOP_MODULE}_EVA.","") unless conf_db.nil?
        line = line.gsub(/\S+_EVA\./,"")
        line = line.gsub("TOP_EVA.","")

        case line
        when /^(\S+)\s+->\s+(\S+)/
          if prefix.nil?
            source = $1
            destination = $2
          else
            source = prefix + "." + $1
            destination =  prefix + "." + $2
          end
          direction = "O"
          if $DEBUG
            print " Soutce      : " + source + "\n"
            print " Destination : " + destination + "\n"
          end
        when /^(\S+)\s+<-\s+(\S+)/
          if prefix.nil?
            source = $1
            destination = $2
          else
            source = prefix + "." + $1
            destination =  prefix + "." + $2
          end
          direction = "I"
          if $DEBUG
            print " Source      : " + source + "\n"
            print " Destination : " + destination + "\n"
          end
        when /^(\S+)\s+<->\s+(\S+)/
          if prefix.nil?
            source = $1
            destination = $2
          else
            source = prefix + "." + $1
            destination =  prefix + "." + $2
          end
          direction = "IO"
          if $DEBUG
            print " Source      : " + source + "\n"
            print " Destination : " + destination + "\n"
          end
        else
          printf("@E: Syntax error in Expect File(%s). please check following sentense.\n",file)
          printf("%s\n",line)
          print "internal error\n"
          exit
        end
        save_path(path,source,direction,destination,file,i+1,expect_type,line)
      end
    end
    return path
  end

  

  class InstPort
    attr_accessor :Path
    attr_accessor :Inst
    attr_accessor :Port
    attr_accessor :MSB
    attr_accessor :LSB
    attr_accessor :BusPortion
    attr_accessor :Direction
    attr_accessor :Connect
    attr_accessor :File
    attr_accessor :Line
    attr_accessor :ExpectType
    attr_accessor :UsedFlag
    attr_accessor :LineStr
    def initialize(path,direction=nil,file=nil,line=nil,expect_type=nil,line_str=nil)
      tmp = path.split(".")
      @Path = path
      port = tmp.pop
      if /(\w+)\[(\d+)\:(\d+)\]/ =~ port
        @Port = $1
        @MSB = $2
        @LSB = $3
      elsif /(\w+)\[(\d+)\]/ =~ port
        @Port = $1
        @BusPortion = $2
      else
        @Port = port
      end
#      @Port = tmp.pop
      @Inst = tmp.pop
      @Direction = direction
      @Connect = Array.new
      @File = File.basename(file) unless file.nil?
      @Line = line
      @ExpectType = expect_type
      @UsedFlag = false
      @LineStr = line_str
    end
    # Add Connect Information
    def add_connect(connect)
      @Connect << connect
      return self
    end
    def get_Path
      return @Path,@ExpectType
    end
    def path_compare(other)
      if self.Path == other.Path
        return @File,Line
      end
      nil
    end
  end

  #
  # Modify Path
  #
  def modify_path(str)
    if /pulldown/ =~ str.downcase
      return "1'b0"
    end
    if /pullup/ =~ str.downcase
      return "1'b1"
    end
    if /open/ =~ str.downcase
      return "OPEN"
    end
    if /_EVA/ =~ str
      tmp = str.split(".")
      tmp[0] = "TOP_EVA"
      return tmp.join(".")
    end
    str
  end
  
  #
  # Modify Expect
  #
  def modify_expect(ary)
    new_ary = Array.new
    ary.each do |str|
      case str[0]
      when "PULLDOWN","pulldown"
        new_ary << ["1'b0",str[1]]
      when "PULLUP","pullup"
        new_ary << ["1'b1",str[1]]
      else
        new_ary << str
      end
    end
    new_ary
  end
  

  #
  # Calucrate & Save path
  #
  private
  def save_path(path,source,direction,destination,file,line,expect_type,line_str)

    # Modify Path ( ex : Pulldown -> 1'b0 )
    source = modify_path(source)
    destination = modify_path(destination)
    
    # Get Instance Name [0] and Port Name [1] from Path
    source_Inst = get_InstPort(source)[0]
    source_Port = get_InstPort(source)[1]
    
    # Make InstPort Object
    src = InstPort.new(source,direction,nil,expect_type,line_str) # Source Inf with Direction
    dist = InstPort.new(destination,nil,file,line,expect_type,line_str)  # Destination

    if path[source_Inst] == nil
      path[source_Inst] = { source_Port => src.add_connect(dist) }
    else
      exist_path = path[source_Inst]
      if exist_path[source_Port] == nil          
        exist_path[source_Port] = src.add_connect(dist)
        path[source_Inst] = exist_path
      else
        exist_path[source_Port].add_connect(dist)
      end
    end
  end

  def compare(golden,revised,expect,conf_db)
    golden_InstanceList = golden.keys
    revised_InstanceList = revised.keys

    revised_OnlyInstance = revised_InstanceList - golden_InstanceList
#    golden_OnlyInstance = golden_InstanceList - revised_InstanceList
    common_Instance = golden_InstanceList & revised_InstanceList
    
    # Comparing Path ( Common  )

    @summary_tmp.print <<EOB

#
# Comparing Path between Instances(Common Instance)
#

EOB
    top_module = "TOP_EVA"
#    top_module = conf_db.TOP_MODULE if conf_db != nil
    @Product = conf_db.TOP_MODULE if conf_db != nil

    common_Instance.each do |inst_name|
      @summary= Summary.new
      @Summary[inst_name] = @summary
      inst_inf = conf_db.INST[inst_name] if conf_db != nil
      error_connect = Hash.new
      @ErrorList[inst_name] = error_connect  if inst_inf != nil
      if inst_inf != nil
        @summary.ModuleName = inst_inf.ModuleName
        @summary.Type = inst_inf.MacroType
        @summary_tmp.print "---------------------------------------------------------------------------------------------\n"
        @summary_tmp.print "[Common]#{inst_name}  [ ModuleName : #{inst_inf.ModuleName}, MacroType : #{inst_inf.MacroType} ]\n"
        # Skip Diff Search Opearation for Remove macro
=begin
        if inst_inf.MacroType == "Remove"
          @summary_tmp.print "---------------------------------------------------------------------------------------------\n"
          @summary_tmp.printf " Skip for searching connection.\n\n"
          next
        end
=end
      else
        @summary_tmp.print "---------------------------------------------------------------------------------------------\n"
        @summary_tmp.print "[Common]#{inst_name}  [ Module Name : Unknown, MacroType : Unknown ]\n"
      end

      common_Signal = golden[inst_name].keys & revised[inst_name].keys
      golden_OnlySignal = golden[inst_name].keys - revised[inst_name].keys
      revised_OnlySignal = revised[inst_name].keys - golden[inst_name].keys


      expect_num = 0
      if expect[inst_name] != nil
        expect_num = expect[inst_name].keys.size
      end

      @summary_tmp.print "\t[Pin]        Common : #{common_Signal.size}, Golden Only : #{golden_OnlySignal.size}, Revised Only : #{revised_OnlySignal.size}\n"
      @summary_tmp.print "---------------------------------------------------------------------------------------------\n\n"
      # Comparing Common Signal
      common_Signal.each do |sig|        
        ext_sig = getExt(sig,golden[inst_name][sig].MSB,golden[inst_name][sig].LSB,golden[inst_name][sig].BusPortion)
        error_connect_list = ConnectList.new(inst_name,sig,golden[inst_name][sig].Direction)
        error_connect[ext_sig] = error_connect_list
        direction = golden[inst_name][sig].Direction
        if expect[inst_name] != nil && expect[inst_name][sig] != nil
          compare_Signal(error_connect_list,top_module,inst_name,sig,direction,
                         golden[inst_name][sig],
                         revised[inst_name][sig],
                         expect[inst_name][sig]
                         )
        else
          compare_Signal(error_connect_list,top_module,inst_name,sig,direction,
                         golden[inst_name][sig],
                         revised[inst_name][sig],
                         nil
                         )
        end
      end

      # Comparing Golden Only Siganl
      golden_OnlySignal.each do |sig|
#        @summary_tmp.printf("[%s]Golden Only : %s.%-30s ... ", golden[inst_name][sig].Direction,inst_name,sig)
        ext_sig = getExt(sig,golden[inst_name][sig].MSB,golden[inst_name][sig].LSB,golden[inst_name][sig].BusPortion)
        error_connect_list = ConnectList.new(inst_name,sig,golden[inst_name][sig].Direction)
        error_connect[ext_sig] = error_connect_list
        direction = golden[inst_name][sig].Direction
        if expect[inst_name] != nil && expect[inst_name][sig] != nil
          compare_Signal(error_connect_list,top_module,inst_name,sig,direction,
                         golden[inst_name][sig],
                         nil,
                         expect[inst_name][sig]
                         )
        else
          compare_Signal(error_connect_list,top_module,inst_name,sig,direction,
                         golden[inst_name][sig],
                         nil,
                         nil
                         )
        end
      end

      # Comaring Revised Only Signal
      revised_OnlySignal.each do |sig|
#        @summary_tmp.printf("[%s]Revised Only : %s.%-30s ... ", revised[inst_name][sig].Direction,inst_name,sig)
        ext_sig = getExt(sig,revised[inst_name][sig].MSB,revised[inst_name][sig].LSB,revised[inst_name][sig].BusPortion)
        error_connect_list = ConnectList.new(inst_name,sig,revised[inst_name][sig].Direction)
        error_connect[ext_sig] = error_connect_list
        direction = revised[inst_name][sig].Direction
        if expect[inst_name] != nil && expect[inst_name][sig] != nil
          compare_Signal(error_connect_list,top_module,inst_name,sig,direction,
                         nil,
                         revised[inst_name][sig],
                         expect[inst_name][sig]
                         )
        else
          compare_Signal(error_connect_list,top_module,inst_name,sig,direction,
                         nil,
                         revised[inst_name][sig],
                         nil
                         )
        end
      end

      @summary_tmp.print "\n"

    end
    
    # Comparing Path ( Revised Only  )

    @summary_tmp.print <<EOB

#
# Comparing Path between Instances( Revised Only Instance)
#

EOB

    revised_OnlyInstance.each do |inst_name|
      revised_OnlySignal = revised[inst_name].keys
      expect_num = 0
      if expect[inst_name] != nil
        expect_num = expect[inst_name].keys.size
      end

      @summary = Summary.new
      @Summary[inst_name] = @summary
      inst_inf = conf_db.INST[inst_name] if conf_db != nil
      @summary.ModuleName = inst_inf.ModuleName unless inst_inf.nil?
      if inst_inf != nil
        @summary.Type = inst_inf.MacroType      
      else
        @summary.Type = "Add"
      end
      inst_inf = conf_db.INST[inst_name]
      error_connect = Hash.new
      @ErrorList[inst_name] = error_connect if inst_inf != nil
      @summary_tmp.print "---------------------------------------------------------------------------------------------\n"
      @summary_tmp.print "[Revised Only]#{inst_name} \n"
      @summary_tmp.print "\t[Pin] Revised Only : #{revised_OnlySignal.size}\n"
      @summary_tmp.print "---------------------------------------------------------------------------------------------\n\n"
      revised_OnlySignal = revised[inst_name].keys
      revised_OnlySignal.each do |sig|
        @summary_tmp.printf("[%s(R)]%s.%s \n", revised[inst_name][sig].Direction,inst_name,sig)
        ext_sig = getExt(sig,revised[inst_name][sig].MSB,revised[inst_name][sig].LSB,revised[inst_name][sig].BusPortion)
        error_connect_list = ConnectList.new(inst_name,sig,revised[inst_name][sig].Direction)
        error_connect[ext_sig] = error_connect_list
        if expect[inst_name] != nil && expect[inst_name][sig] != nil
          print_connect(top_module,error_connect_list,inst_name+"."+ext_sig,direction2arrow(revised[inst_name][sig].Direction),revised[inst_name][sig].Connect,expect[inst_name][sig].Connect)
        else
          print_connect(top_module,error_connect_list,inst_name+"."+ext_sig,direction2arrow(revised[inst_name][sig].Direction),revised[inst_name][sig].Connect,nil)
        end
      end
    end

  end

  def compare_Signal(error_connect_list,top,inst_name,sig,direction,g,r,e)
    golden = g.Connect unless g.nil?
    revised = r.Connect unless r.nil?
    expect = e.Connect unless e.nil?

    base_signal = inst_name + "." + sig

    golden_path = Array.new
    revised_path = Array.new
    expect_path = Array.new
    golden.each do |each|
      golden_path << each.get_Path[0]
    end if golden != nil
    revised.each do |each|
      revised_path << each.get_Path[0]
    end if revised != nil
    expect.each do |each|
      expect_path << each.get_Path
    end if expect != nil

    msb = 0
    lsb = 0
    bus_portion = 0
    if g != nil
      msb = g.MSB
      lsb = g.LSB
      bus_portion = g.BusPortion
    elsif r != nil
      msb = r.MSB
      lsb = r.LSB
      bus_portion = r.BusPortion
    end
    base_signal = getExt(base_signal,msb,lsb,bus_portion)

    
    if golden_path == revised_path # Same Connection
      if expect_path == []
        if @all_rep
          sig = getExt(sig,msb,lsb,bus_portion)
          @summary_tmp.printf "[%s(G/R)]%s.%s ... Same. Not Found Expect Connection  - Judement : OK\n", direction,inst_name,sig
          golden_path.each do |each_path|
            @summary_tmp.printf "\t(G)/(R) : %s %s %s\n",base_signal,direction2arrow(direction),each_path
          end
          @summary_tmp.printf "\n"
        end
        @summary.add_OK
        @summary.add_Same
      else
        sig = getExt(sig,msb,lsb,bus_portion)
        @summary_tmp.printf "[%s(G/R)]%s.%s ... Same. Found Expect Connection\n", direction,inst_name,sig
#        @summary_tmp.printf "[%s(G/R)]%s.%s ... Same. Found Expect Connection      - Judement : NG\n", direction,inst_name,sig
        @summary.add_NG
        golden_path.each do |each_path|
          @summary_tmp.printf "\t(G)/(R) : %s %s %s\n",base_signal,direction2arrow(direction),each_path
        end
        expect.each do |each_sig|
          each_sig.UsedFlag = true
          case each_sig.ExpectType
          when "common"
            @summary_tmp.printf "\tUnmatch (CE)    : %s %s %s [ %s (L:%d) ]\n",base_signal,direction2arrow(direction),each_sig.Path,each_sig.File,each_sig.Line
            @summary.add_CommonUnusedExpect
          when "auto"
            @summary_tmp.printf "\tUnmatch (AE)    : %s %s %s [ %s (L:%d) ]\n",base_signal,direction2arrow(direction),each_sig.Path,each_sig.File,each_sig.Line
            @summary.add_AutoUnusedExpect
          when "local"
            @summary_tmp.printf "\tUnmatch (LE)    : %s %s %s [ %s (L:%d) ]\n",base_signal,direction2arrow(direction),each_sig.Path,each_sig.File,each_sig.Line
            @summary.add_LocalUnusedExpect
          else
          end
          @summary.add_UnusedExpect
        end unless expect.nil?
        @summary_tmp.printf "\tJudgment - NG \n\n"
        @summary_tmp.printf "\n"
      end
    else # Different Connection
      sig = getExt(sig,msb,lsb,bus_portion)
      if g == nil
        @summary_tmp.printf "[%s(R)]%s.%s \n", direction,inst_name,sig
      elsif r == nil
        @summary_tmp.printf "[%s(G)]%s.%s \n", direction,inst_name,sig
      else
        @summary_tmp.printf "[%s(G/R)]%s.%s \n", direction,inst_name,sig
      end
      sig_list = nil
      golden_only = golden_path - revised_path
      revised_only = revised_path - golden_path

      # Print G/R Signal
      same_flag = false
      same_flag, sig_list,expect_type = print_signal_diff(@summary,top,base_signal,direction,golden_only,revised_only,modify_expect(expect_path),expect)

      # Print Judgement Message
      case same_flag
      when 1
#        @summary_tmp.printf "                                                                                - Judgment : OK\n\n"
        @summary_tmp.printf "\tJudgment - OK \n\n"
        @summary.add_OK
        @summary.add_Expect
        case expect_type
        when "common"
          @summary.add_CommonExpect
        when "auto"
          @summary.add_AutoExpect
        when "local"
          @summary.add_LocalExpect
        end
      when 2
#        @summary_tmp.printf "                                                                                - Judgment : NG\n\n"
        @summary_tmp.printf "\tJudgment - NG \n\n"

#        @summary.add_NG
        sig_list.each do |each_sig|
          error_connect_list.add(each_sig)
        end
      when 3
#        @summary_tmp.printf "                                                                                - Judgment : NG\n\n"
        @summary_tmp.printf "\tJudgment - NG \n\n"

        @summary.add_NG
        sig_list.each do |each_sig|
          error_connect_list.add(each_sig)
        end
      end
    end
  end
  
  def print_signal_diff(summary,top,base,direction,golden_only,revised_only,expect_sig,expect)
    match_expect = Array.new
    if golden_only.size != 0
      golden_only.each do |sig|
        type = "Golden"
        @summary_tmp.printf "\t(G)     : %s %s %s\n",base,direction2arrow(direction),sig
        @summary_csv.printf "%s Only,%s,%s,%s,NONE,NONE,\n",type,direction,base,sig
      end 
    else
#        @summary_tmp.printf "\t(G)     : NONE ( expect Common-Connection )\n"
    end
    if revised_only.size != 0
      type = "Revised"
      revised_only.each do |sig|
        @summary_tmp.printf "\t(R)     : %s %s %s",base,direction2arrow(direction),sig        
        ep = Array.new
        expect.each do |each_sig|
          each_sig.Path = pin2term(each_sig.Path,top,sig.split(".").last)
          if sig == each_sig.Path
            ep << each_sig
            each_sig.UsedFlag = true
            case each_sig.ExpectType
            when "common"
              @summary_tmp.printf " [ (CE) %s (L:%d) ]",each_sig.File,each_sig.Line
            when "auto"
              @summary_tmp.printf " [ (AE) %s (L:%d) ]",each_sig.File,each_sig.Line
            when "local"
              @summary_tmp.printf " [ (LE) %s (L:%d) ]",each_sig.File,each_sig.Line
            else
            end
            match_expect << sig
          end
        end unless expect.nil?
        if ep.size > 1
          @DuplicateExpect << ["#{base} #{direction2arrow(direction)} #{sig}",ep]
        end
        
        @summary_tmp.printf("\n")
        @summary_csv.printf "%s Only,%s,%s,NONE,%s,NONE,\n",type,direction,base,sig
      end
    else
      case direction
      when "I"
        @summary_tmp.printf "\t(R)     : NONE"
      else
        @summary_tmp.printf "\t(R)     : NONE ( except Common-Connection )"
      end
      ep = Array.new
      expect.each do |each_sig|
        ep << each_sig
        case each_sig.Path.downcase
          when "open", "no-connect", "non-connect"
          each_sig.UsedFlag = true
          case each_sig.ExpectType
          when "common"
            @summary_tmp.printf " [ (CE) %s (L:%d) ]",each_sig.File,each_sig.Line
          when "auto"
            @summary_tmp.printf " [ (AE) %s (L:%d) ]",each_sig.File,each_sig.Line
          when "local"
            @summary_tmp.printf " [ (LE) %s (L:%d) ]",each_sig.File,each_sig.Line
          else
          end
          match_expect << each_sig.Path
        end
      end unless expect.nil?
      if ep.size > 1
        @DuplicateExpect << ["#{each_sig.Line}",ep]
      end

      @summary_tmp.printf("\n")
#      @summary_csv.printf "%s Only,%s,%s,NONE,%s,NONE,\n",type,direction,base,each_sig.Path
    end

    # Refer Expect File
    if golden_only != [] || revised_only != []
      expect.each do |each|
        if match_expect.index(each.Path).nil?
          each.UsedFlag = true
          case each.ExpectType
          when "common"
            @summary_tmp.printf "\t(CE)    : %s %s %s [ %s (L:%d) ]\n",base,direction2arrow(direction),each.Path,each.File,each.Line 
          when "auto"
            @summary_tmp.printf "\t(AE)    : %s %s %s [ %s (L:%d) ]\n",base,direction2arrow(direction),each.Path,each.File,each.Line 
          when "local"
            @summary_tmp.printf "\t(LE)    : %s %s %s [ %s (L:%d) ]\n",base,direction2arrow(direction),each.Path,each.File,each.Line 
          else
          end
        end
      end unless expect.nil?
      expect_type = "local"
      expect.each do |e|
        case e.ExpectType
        when "common","auto"
          expect_type = e.ExpectType
          break
        end
      end unless expect.nil?
      same_flag, sig_list = search_expect(@summary,top,base,direction,golden_only,revised_only,expect_sig,expect,match_expect)
    end
    return same_flag, sig_list,expect_type
  end
  
  def search_expect(summary,top,base_signal,direction,golden,revised,expect_sig,expect,match_expect)
    expect_type = "local"
    tmp = Array.new
    expect_sig.each do |d|
      tmp << d[0]
      case d[1]
      when "common"
        expect_type = d[1]
      when "auto"
        expect_type = d[1]
      else
      end
    end
    expect_sig = tmp


    same_flag = 0
    unused_expect_flag = false
    sig_list = Array.new
    if revised != []
      # [Case1] New Connection
      #   Golden  : Non-Connection
      #   Revised : Conenctioin
      #     [Judgment] OK - Revised Connection exist in Expect
      #                NG - Revised Connection does not in Expect

      # [Case2] Change Connection
      #   Golden  : Connection
      #   Revised : Conenctioin
      #     [Judgment] OK - Revised Connection exist in Expect
      #                NG - Revised Connection does not in Expect
      
      if expect_sig == []
        @summary_tmp.printf "\t(E)     : NONE\n"
        same_flag = 3
        sig_list += revised
#        summary.add_NG
        revised.each do |revised_each|
          sig_list << revised_each
        end
      else
        diff_flag = false
        # Search All Signal( Output Signal may have many connection )
        tmp = Array.new
        revised.each do |revised_each|
          revised_each_c = change_term(top,direction,revised_each)
          if expect_sig.index(revised_each_c) == nil &&  expect_sig.index(revised_each) == nil
            diff_flag = true
            sig_list << revised_each
          end
        end
        # Judgement
        # Print Other Expect Connection
        # Change Term Name from Pin
        tmp = Array.new
        expect_sig.uniq.each do |sig|
          tmp << pin2term(sig,top,base_signal.split(".").last)
        end
        expect_sig = tmp
        if expect_sig - revised != []
          @summary_tmp.printf "\t@E:Exist unmatch Expect Connection ( Expect - Revised ). Please Check above inf.\n"
          (expect_sig.uniq - revised.uniq - match_expect).each do |sig|
            case expect_type
            when "common"
              @summary_tmp.printf "\tUnmatch (CE)    : %s \n",sig
              @summary.add_CommonUnusedExpect
            when "auto"
              @summary_tmp.printf "\tUnmatch (AE)    : %s \n",sig
              @summary.add_AutoUnusedExpect
            when "local"
              @summary_tmp.printf "\tUnmatch (LE)    : %s \n",sig
              @summary.add_LocalUnusedExpect
            else
            end
            @summary.add_UnusedExpect
            unused_expect_flag = true
          end
        end
        if diff_flag == false && ( expect_sig - revised == [] )
#          @summary_tmp.printf "\tMatch\n"
          same_flag = 1
        elsif unused_expect_flag 
          same_flag = 2
        else
 #         @summary_tmp.printf "\tUnmatch\n"
          same_flag = 3
        end
      end
    else    
      
      # [Case3] Change Connection
      #   Golden  : Connection
      #   Revised : Non-Connection(OPEN/Clamp)
      #     [Judgment] OK - Revised Connection exist in Expect
      #                NG - Revised Connection does not in Expect
      if expect_sig == []
        @summary_tmp.printf "\t(E)     : NONE\n"
        summary.add_NG 
        same_flag = 3
        sig_list << "OPEN"
     else
        diff_flag = false
        # Search All Signal( Output Signal may have many connection )
        tmp = Array.new
        golden.each do |golden_each|
          golden_each = change_term(top,direction,golden_each)
          tmp << golden_each
          if ( expect_sig.index(golden_each) == nil && expect_sig.index("OPEN") == nil ) && expect_sig.index("No-Connect") == nil 
            # Unmatch Judement
            diff_flag = true
            sig_list << golden_each
          end
        end
        golden = tmp
        tmp = Array.new
        expect_sig.each do |expect_each|
          if expect_each != "OPEN"
            tmp << expect_each
          end
        end
        expect_sig = tmp
        noconnect_flag = false
        # Print Other Expect Connection
        if expect_sig - golden != []
          if expect_sig == ["No-Connect"] && revised == []
            noconnect_flag = true
          else
            @summary_tmp.printf " @W: Exist unumatch Expect Connection ( Expect - Golden )\n"
            (expect_sig - golden - match_expect).each do |sig|
              unused_expect_flag = true
=begin
              sig.UsedFlag = true
              case sig.ExpectType
              when "common"
                @summary_tmp.printf "\tUnmatch (CE)     : %s %s %s [ %s (L:%d)]\n",base_signal,arrow,sig.Path,sig.File,sig.Line
                @summary.add_CommonUnusedExpect
              when "auto"
                @summary_tmp.printf "\tUnmatch (AE)     : %s %s %s [ %s (L:%d)]\n",base_signal,arrow,sig.Path,sig.File,sig.Line
                @summary.add_AutoUnusedExpect
              when "local"
                @summary_tmp.printf "\tUnmatch (LE)     : %s %s %s [ %s (L:%d)]\n",base_signal,arrow,sig.Path,sig.File,sig.Line
                @summary.add_LocalUnusedExpect
              else
              end
=end
              @summary.add_UnusedExpect
              @summary_tmp.printf "    - %s\n",sig
              sig_list << sig
            end
          end
        end
        # Judgement
        if ( diff_flag == false && ( expect_sig - golden == [] ) ) || noconnect_flag
#          @summary_tmp.printf "\tMatch\n"
          same_flag = 1
        elsif unused_expect_flag
          same_flag = 2
        else
#          @summary_tmp.printf "\tUnmatch\n"
          same_flag = 3
        end
      end
    end
    return same_flag, sig_list
  end
  
  def print_connect(top,error_connect_list,base_signal,arrow,connect,expect)
    match_expect = Array.new
    expect_path = Array.new
    expect.each do |each|
      expect_path << each.get_Path[0]
    end if expect != nil
    ng_flag = false
    connect.each do |each|
      connect_path = each.get_Path[0]
      if expect_path != nil
        if expect_path.index(connect_path) != nil
          @summary_tmp.printf "\t(R)     : #{base_signal} #{arrow} #{connect_path} "
          expect_type = "local"
          ep = Array.new
          expect.each do |each_sig|
            each_sig.Path = pin2term(each_sig.Path,top,connect_path.split(".").last)            
            if connect_path == each_sig.Path
              ep << each_sig
              each_sig.UsedFlag = true
              case each_sig.ExpectType
              when "common"
                @summary_tmp.printf " [ (CE) %s (L:%d) ]",each_sig.File,each_sig.Line
                expect_type = each_sig.ExpectType
              when "auto"
                @summary_tmp.printf " [ (AE) %s (L:%d) ]",each_sig.File,each_sig.Line
                expect_type = each_sig.ExpectType
              when "local"
                @summary_tmp.printf " [ (LE) %s (L:%d) ]",each_sig.File,each_sig.Line
              else
              end
              match_expect << connect_path
            end
          end unless expect.nil?
          if ep.size > 1
            @DuplicateExpect << ["#{base_signal} #{arrow} #{connect_path}",ep]
          end
          
          @summary_tmp.printf("\n")
          @summary.add_OK
          @summary.add_Expect
          case expect_type
          when "common"
            @summary.add_CommonExpect
          when "auto"
            @summary.add_AutoExpect
          when "local"
            @summary.add_LocalExpect
          end
        else
          @summary_tmp.printf "\t(R)     : #{base_signal} #{arrow} #{connect_path}\n"
          @summary.add_NG
          ng_flag = true
          error_connect_list.add(connect_path)
        end
      else
        @summary_tmp.printf "\t(R)     : #{base_signal} #{arrow} #{connect_path}\n"
        @summary.add_NG
        ng_flag = true
        error_connect_list.add(connect_path)
      end
    end
    unless expect.nil?
      expect.each do |sig|
        if match_expect.index(sig.Path).nil?
          sig.UsedFlag = true
          case sig.ExpectType
          when "common"
            @summary_tmp.printf "\tUnmatch (CE)     : %s %s %s [ %s (L:%d)]\n",base_signal,arrow,sig.Path,sig.File,sig.Line
            @summary.add_CommonUnusedExpect
          when "auto"
            @summary_tmp.printf "\tUnmatch (AE)     : %s %s %s [ %s (L:%d)]\n",base_signal,arrow,sig.Path,sig.File,sig.Line
            @summary.add_AutoUnusedExpect
          when "local"
            @summary_tmp.printf "\tUnmatch (LE)     : %s %s %s [ %s (L:%d)]\n",base_signal,arrow,sig.Path,sig.File,sig.Line
            @summary.add_LocalUnusedExpect
          else
          end
          @summary.add_UnusedExpect
          ng_flag = true
        end
      end 
    else
        @summary_tmp.printf "\t(E)     : NONE\n"
    end
    if ng_flag
#      @summary_tmp.printf "                                                                                                     - Judgment : NG\n"
      @summary_tmp.printf "\tJudgment - NG \n"
    else
#      @summary_tmp.printf "                                                                                                     - Judgment : OK\n"
      @summary_tmp.printf "\tJudgment - OK \n"
    end
    @summary_tmp.printf "\n"
  end

  def change_term(top,direction,sig)
    if /#{top}/ =~ sig
      case direction
      when "O"
        sig = "OUT_PIN"
      when "I"
        sig =  "IN_PIN"
      when "IO"
        sig =  "IO_PIN"
      end
    end
    sig
  end

  def pin2term(str,top,pin)
    case str
    when "OUT_PIN", "IN_PIN", "IO_PIN"
      return top + "_EVA." + pin
    when "PULLDOWN"
      return "1'b0"
    when "PULLUP"
      return "1'b1"
    else
      return str
    end
  end
  
  def getExt(sig,msb,lsb,bus_portion)
    if msb != nil && lsb != nil
      return "#{sig}[#{msb}:#{lsb}]"
    elsif bus_portion != nil
      return "#{sig}[#{bus_portion}]"
    else
      return "#{sig}"
    end
  end

  #
  # Generate Diff Report
  #
  def generate_DiffReport(ng_flag)
    result = "result"
    # make output dire
    Common.make_dir(result)
    if ng_flag
      report = result + "/" + @ReportFile
    else
      report = result + "/" + @ReportFile.sub(".report","_NG.report")
    end
    printf("@I:generate report file(%s)\n",report)    
    f = open(report,"w")
    comment = "Comparing Connection Report" 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")

    ng_total = 0
    ok_total = 0
    same_total = 0
    expect_total = 0
    common_expect_total = 0
    auto_expect_total = 0
    local_expect_total = 0    
    unused_expect_total = 0
    common_unused_expect_total = 0
    auto_unused_expect_total = 0
    local_unused_expect_total = 0
    @Summary.each do |key,value|
      ng_total += value.NG
      ok_total += value.OK
      same_total += value.Same
      expect_total += value.Expect
      common_expect_total += value.CommonExpect
      auto_expect_total += value.AutoExpect
      local_expect_total += value.LocalExpect
      unused_expect_total += value.UnusedExpect
      common_unused_expect_total += value.CommonUnusedExpect
      auto_unused_expect_total += value.AutoUnusedExpect
      local_unused_expect_total += value.LocalUnusedExpect
    end


    f.print <<EOF

#
# Comparing Information
#

PRODUCT : #{@Product}
CONF    : #{File.expand_path(@ConfFile)} (#{File::stat("#{@ConfFile}").mtime})

GOLDEN  : #{File.expand_path(@GoldenReport)} (#{File::stat("#{@GoldenReport}").mtime})
          - generated FMake Ver : #{@GoldenReport_Ver}
REVISED : #{File.expand_path(@RevisedReport)} (#{File::stat("#{@RevisedReport}").mtime})
          - generated FMake Ver : #{@RevisedReport_Ver}
EOF
    unless @ExpectDir.nil?
      f.print <<EOF

LOCAL  EXPECT  : #{File.expand_path(@ExpectDir)}/*.expect
EOF
    end
    unless @CommonExpectDir.nil?
      f.print <<EOF
COMMON EXPECT  : #{File.expand_path(@CommonExpectDir)}/*.expect
EOF
    end
    unless @AutoExpectDir.nil?
      f.print <<EOF
AUTO   EXPECT  : #{File.expand_path(@AutoExpectDir)}/*.expect

EOF
    end
      
    f.print <<EOF

#
# Connection Summary (OK/NG)
#

The number of OK connection : #{ok_total} [ Same : #{same_total}, Expect : #{expect_total} ( Common: #{common_expect_total}, Auto: #{auto_expect_total}, Local: #{local_expect_total} ) ]
The number of NG connection : #{ng_total} [ Different : #{ng_total-unused_expect_total}, Unmatch Expect : #{unused_expect_total}  ( Common: #{common_unused_expect_total}, Auto: #{auto_unused_expect_total}, Local: #{local_unused_expect_total} ) ]

EOF

    inst_size = 10
    mod_size = 10
    @Summary.each do |key,value|
      if key.size > inst_size
        inst_size = key.size 
      end
      if value.ModuleName.size > mod_size
        mod_size = value.ModuleName.size 
      end
    end

    inst_bar = ""
    inst_str = " Instance Name "
    (inst_size+2).times { |i|
      inst_bar = inst_bar + "-"
      inst_str = inst_str + " " if i > 14
    }

    mod_bar = ""
    mod_str = " Module Name "
    (mod_size+2).times { |i|
      mod_bar = mod_bar + "-"
      mod_str = mod_str + " " if i > 12
    }
    
    f.printf <<EOB
+#{inst_bar}+#{mod_bar}+------------+------+------+---------------------------------+------+
|#{inst_str}|#{mod_str}| ResultType |  All | Same |  Exp ( Common,   Auto,  Local ) |   NG |
+#{inst_bar}+#{mod_bar}+------------+------+------+---------------------------------+------+
EOB
    ng_list = Array.new
    @Summary.sort_by do |key,value|
      key
    end.each do |key,value|
      # Change Type
      case value.Type
      when "KeepKeep"
        value.Type = "KeepOther" if value.Expect != 0 || value.NG != 0        
      end
      if value.NG == 0
        comment = ""
      else
        comment = " <= Check"
        ng_list << [key,value.ModuleName]
      end

      f.printf("| %-#{inst_size}s | %-#{mod_size}s | %-11s| %4d | %4d | %4d ( C:%4d, A:%4d, L:%4d ) | %4d |%s\n",
               key,
               value.ModuleName,
               value.Type,
               value.Total,
               value.Same,
               value.Expect,
               value.CommonExpect,
               value.AutoExpect,
               value.LocalExpect,
               value.NG,
               comment
               )
    end

      
      f.printf <<EOB
+#{inst_bar}+#{mod_bar}+------------+------+------+---------------------------------+------+

EOB

    if ng_flag
      f.printf <<EOB

#--------------------------------------------------------------------------------------------------------------------------
# Difference Connection Macro ( Do NOT edit!! Use FMerge )
#--------------------------------------------------------------------------------------------------------------------------
EOB
    ng_list.each do |inf|
      f.printf "Differ:#{inf[0]},#{inf[1]}\n"
    end

      f.printf <<EOB

#--------------------------------------------------------------------------------------------------------------------------
# Difference Connect & Expect Judgement Detail
#--------------------------------------------------------------------------------------------------------------------------

# <<Judgement Type>>
#   - Case 1 : Same Pin & Connection - Golden == Revised                                -> Unreport
#   - Case 2 : Same Pin & Connection - Golden != Revised ( NOT defined in Expect File ) -> NG  ( See "Report Format A" )
#   - Case 3 : Same Pin & Connection - Golden != Revised ( defined in Expcect File      -> OK  ( See "Report Format B" )
#   - Case 4 : Golden Only Pin ( NOT defined in Expect File )                           -> NG  ( See "Report Format C" )
#   - Case 5 : Golden Only Pin ( defined in Expect File )                               -> OK  ( See "Report Format D" )
#   - Case 6 : Revised Only Pin ( NOT defined in Expect File )                          -> NG  ( See "Report Format E" )
#   - Case 7 : Revised Only Pin ( defined in Expect File )                              -> OK  ( See "Report Format F" )
#   - Case 8 : Found Unmatch Expect Connection                                          -> NG  ( See "Report Format G" )


# <<Report Format ( Port Information )>>
# [Direction(Type)]InstancePath.PortName 
#     |        |       |          +- Module Port Name
#     |        |       +- Instance Name ( Full Path )
#     |        +- (G/R) : Both Golden and Revised have same Port
#     |           (G)   : Golden has a port, But Revised does not have a port. 
#     |           (R)   : Golden does not have a port, But Revised has a port.
#     + I  : Input Port
#     + O  : Output Port
#     + IO : Inout Port
#
# <<Report Format ( Connect Information )>>
# Report Format A
#	(G)     : "Source" "Direction" "Destination"
#	(R)     : "Source" "Direction" "Destination"
#	Judgment - NG
#
# Report Format B
#	(G)     : "Source" "Direction" "Destination"
#	(R)     : "Source" "Direction" "Destination" [ (E) "ExpectFile Name" (L:"LineNo") ]
#	Judgment - OK
#
# Report Format C
#	(G)     : "Source" "Direction" "Destination"
#	Judgment - NG
#
# Report Format D
#	(G)     : "Source" "Direction" "Destination"
#	(R)     : NONE [ (E) "ExpectFile Name" (L:"LineNo") ]
#	Judgment - OK
#     * In Expect File : Please define OPEN/Non-Connect Conenction
#
# Report Format E
#	(R)     : "Source" "Direction" "Destination"
#	Judgment - NG
#
# Report Format F
#	(R)     : "Source" "Direction" "Destination" [ (E) "ExpectFile Name" (L:"LineNo") ]
#	Judgment - OK
#
# Report Format G
#	(E)     : "Source" "Direction" "Destination" [ "ExpectFile Name" (L:"LineNo") ]
#   E:Exist unused Expect Connection
#	Judgment - NG
#
# <<Special Definition>>
#  TOP_MODULE.PIN    : FPGA Terminal ( unconerned direction )
#  IN_PIN            : FPGA Input Terminal
#  OUT_PIN           : FPGA Output Terminal
#  IO_PIN            : FPGA Inout Terminal
#  1'b0/PULLDOWN     : Connect GND
#  1'b1/PULLUUP      : Connect VDD
#  OPEN              : for Inpu/Inout port
#  No-Connect        : for Output port
#

EOB
    else
      
      f.printf <<EOB

#--------------------------------------------------------------------------------------------------------------------------
# Difference Connect & Expect Judgement Detail ( NG Only )
#--------------------------------------------------------------------------------------------------------------------------

EOB
    end

    
    # add detail
    f.print "\n"
    if ng_flag
      open("#{@SummaryTmp}").each do |line|
        #      if /Same. Not Found Expect Connection  - Judement : OK/ !~ line
        f.print line
        #      end
      end
    else
      tmp = Array.new
      delete_inf = Array.new
      index = 0
      space_index = 0
      open("#{@SummaryTmp}").each do |line|
        if line.strip == ""
          space_index = index
        end
        if /Judgment - NG/ =~ line
          ng_index = index
          delete_inf << [space_index,ng_index]
        end
        index += 1
        tmp << line
      end
      tmp2 = Array.new
      delete_inf.each do |inf|
        tmp2 += tmp[inf[0]..inf[1]]
      end
      tmp2.each do |line|
        f.printf line
      end
    end

f.printf <<EOB

##### [ REPORT END  ] #####

EOB

    f.close
    return if ng_flag == false

    ok_inst = Array.new
    @ErrorList.each do |inst_name,port|
      ok_flag = true
      port.each do |port_name,inf|
        if inf.Connect.size != 0
          ok_flag = false
        end
      end
      ok_inst << inst_name if ok_flag
    end
    ok_inst.uniq.each do |mod|
      @ErrorList.delete(mod)
    end
    
    @ErrorList.each do |inst_name,port|
      result = "expect_Candidate"
      Common.make_dir(result)
      report = result + "/" + inst_name + ".expect"
      printf("@I:generate expect Candidate file(%s)\n",report)    
      f = open(report,"w")
      comment = "Expect Candidate" 
      Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
      port.each do |port_name,inf|
        direction = direction2arrow(inf.Direction)
        if inf.Connect.size != 0
          inf.Connect.uniq.each do |sig|
            f.printf("%s.%s\t%s\t%s\n",inf.Inst,port_name,direction,sig)
          end
        end
      end 
      f.close
    end
    
    printf("@I:generate Connect CSV file(%s)\n",@ConnectCSV)    

    report = "result/AllConnectReport.log"
    all_rep = open(report,"w")
    printf("@I:generate All Connect Report file(%s)\n",report)    
    open("#{@SummaryTmp}").each do |line|
      all_rep.print line
    end
    all_rep.close

    print "\n\nConnection summary\n"
    printf <<EOF
The number of OK connection : #{ok_total} [ Same : #{same_total}, Expect : #{expect_total} ( Common: #{common_expect_total}, Auto: #{auto_expect_total}, Local: #{local_expect_total} ) ]
The number of NG connection : #{ng_total} [ Different : #{ng_total-unused_expect_total}, Unmatch Expect : #{unused_expect_total}  ( Common: #{common_unused_expect_total}, Auto: #{auto_unused_expect_total}, Local: #{local_unused_expect_total} ) ]
EOF
#    print "   The number of OK connection : #{ok_total} ( Same : #{same_total}, Expect : #{expect_total} )\n"
#    print "   The number of NG connection : #{ng_total} ( Different : #{ng_total-unused_expect_total}, Unmatch Expect : #{unused_expect_total} )\n"
    print "\n"
    
  end

  #
  # Generate Specification Report
  #
  def generate_SpecReport(conf_db,summary)

    # Make Data
    conf_db.INST.values.each do |inf|
      @macro_inf[inf.InstName] = MacroInf.new( 
                                              :inst_name => inf.InstName,
                                              :mod_name => inf.ModuleName
                                              )
    end
    summary.each do |key,value|
      macro = @macro_inf[key]
      if macro.nil?
        print "Internal error."
        exit
      end
      # Set Macro Information
      macro.set_inf(value)
    end

    # Read Spec Conf
    spec_conf = "/home/product/div-micom-ice/data/proj/RL78/Common/Settings/EmulationSpecification.conf"
    spec = Hash.new
    open(spec_conf).each do |line|
      data = line.strip.split(":")
      data[1].split(",").each do |mod|
        if spec[mod].nil?
          special = SpecialInf.new
        else
          special = spec[mod]
        end

        case data[0]
        when "DLY"
          special.DLY = true
        when "NF"
          special.NF = true
        when "CTS"
          special.CTS = true
        when "OTEHR"
          special.OTHER = true
        end
        spec[mod] = special
      end unless data[1].nil?
    end unless spec_conf.nil?

    # Report File
    result = "result"
    # make output dire
    Common.make_dir(result)
    report = result + "/ForSpecification.report"
    printf("@I:generate report file(%s)\n",report)
    f = open(report,"w")
    comment = "For Specification Report. Please Use with Redmine-Wiki" 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
    f.print "|/2.No|/2.MacroName|/2.ModuleName|/2.Remove|/2.Keep|\\4.Shared Logic|/2.Replace|\\4.Evaluation|
|DLY|N/F|CTS|Other|FDiff|System|ICE|Board|\n"
    i = 1
    @macro_inf.each do |key,value|
      remove = ""
      keep = ""
      replace = ""
      dly = ""
      nf = ""
      cts = ""
      other = ""
      fdiff = ""
      system = ""
      ice = ""
      board = ""

      case value.MacroType
      when "Add"
        next
      when "Remove"
        remove = "o"
      when "KeepKeep"
        keep = "o"
      when "KeepChange"
        keep = "o(*1)"
        fdiff = "o"
      when "Replace"
        replace = "o"
        fdiff = "o"
      end

      spec.each do |macro,special_inf|
        if /#{macro}/ =~ value.ModuleName
          dly = "o" if special_inf.DLY
          nf = "o" if special_inf.NF
          cts = "o" if special_inf.CTS
          other = "o" if special_inf.OTHER
        end
      end

      f.printf "|#{i}|#{key}|#{value.ModuleName}|#{remove}|#{keep}|#{dly}|#{nf}|#{cts}|#{other}|#{replace}|#{fdiff}|#{system}|#{ice}|#{board}|\n"
      if i % 20 == 0
        f.print "\n"
        f.print "|/2.No|/2.MacroName|/2.ModuleName|/2.Remove|/2.Keep|\\4.Shared Logic|/2.Replace|\\4.Evaluation|
|DLY|N/F|CTS|Other|FDiff|System|ICE|Board|\n"
      end
      i += 1

    end
    f.close
    File::chmod(0666,report)

    report = result + "/DuplicateIgnored_Expect.txt"
      printf("@I:generate report file(%s)\n",report)    
      f = open(report,"w")
      comment = "Duplicate/Ignored Expect Inforamtion Report" 
      Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
      f.printf <<EOF
#
# [ Duplicate Expect ]
#
# Following Expect Information are duplicate in multiple files.
# Please check it and delete unnecessary Line
#

EOF

    unless @DuplicateExpect == []
      @DuplicateExpect.each do |inf|
        f.printf "%-50s %s counts - ", inf[0],inf[1].size        
        inf[1].each do |expect|
          case expect.ExpectType
          when "local"
            str = "LE"
          when "auto"
            str = "AE"
          when "common"
            str = "CE"
          end
          f.printf "[(%s)%s (L:%d)] ",str,expect.File,expect.Line
        end
        f.printf "\n"
      end
    else
      f.printf " - Nothing\n\n"
    end

      f.printf <<EOF


#
# [ Ignored Expect ]
#
# Following Expect Information are ignored in your circuit.
# Please check it and delete unnecessary Line
#

EOF

    unless @IgnoredExpect == []
      @IgnoredExpect.each do |inf|
        case inf.ExpectType
        when "local"
          str = "LE"
        when "auto"
          str = "AE"
          when "common"
          str = "CE"
        end
        f.printf "%s    [ (%s)%s (L:%d) ]\n",inf.LineStr,str,inf.File,inf.Line
      end
    else
      f.printf " - Nothing\n\n"
    end
    f.printf "\n\n"
    f.close

  end

  def direction2arrow(direction)
    case direction
    when "I"
      return "<-"
    when "O"
      return "->"
    when "IO"
      return "<->"
    end
  end

  #
  # Main Function
  #  1. Print Base Inf
  #  2. Get Argument
  #  3. Analyze Report File( Both Golden and Revised )
  #
  public
  def main
    Common.print_base
    get_argument
    golden = Hash.new
    revised = Hash.new
    expect = Hash.new

    # Get Conf File Information
    conf_db = nil
    if @ConfFile != nil
      conf_db = FMakeConf.new( 
                              :conffile      => @ConfFile,
                              ).analyze
    end

    # For Golden
    printf("@I:Analyze ReportFile(%s)\n",@GoldenReport)
    analyze(conf_db,@GoldenReport,golden,@GoldenPrefix)

    # For Revised
    printf("@I:Analyze ReportFile(%s)\n",@RevisedReport)
    analyze(conf_db,@RevisedReport,revised,@RevisedPrefix)

    # For Local Expect
    if @ExpectDir != nil
      printf("@I:Search Expect File in \"%s\" )\n",@ExpectDir)
      Dir::glob("#{@ExpectDir}/*.expect").each do |file|
        printf("%s\n",file)
        analyze(conf_db,file,expect,nil,"local")
      end
    else
      printf("@I:No-Described Expect File\n")
    end

    # For Common Expect
    if @CommonExpectDir != nil
      printf("@I:Search Common Expect File in \"%s\" )\n",@CommonExpectDir)
      Dir::glob("#{@CommonExpectDir}/*.expect").each do |file|
        printf("%s\n",file)
        analyze(conf_db,file,expect,nil,"common")
      end
    else
      printf("@I:No-Described Expect File\n")
    end
    # For Auto Expect
    if @AutoExpectDir != nil
      printf("@I:Search Common Expect File in \"%s\" )\n",@AutoExpectDir)
      Dir::glob("#{@AutoExpectDir}/*.expect").each do |file|
        printf("%s\n",file)
        analyze(conf_db,file,expect,nil,"auto")
      end
    else
      printf("@I:No-Described Expect File\n")
    end

    @summary_csv = open(@ConnectCSV,"w")
    @summary_tmp = open(@SummaryTmp,"w")

    # Compare
    compare(golden,revised,expect,conf_db)

    # Check Ignored Expect    
    expect.each do |key,value|
      value.each do |sig,inf|
        @IgnoredExpect << inf.Connect.select do |con|
          con.UsedFlag == false && con.ExpectType == "local"
        end
      end
    end
    @IgnoredExpect.delete_if{|i| i.size == 0}.flatten!
    @summary_tmp.close

    # Generate Diff report
    generate_DiffReport(false)
    generate_DiffReport(true)
    # Generate Specification report
    generate_SpecReport(conf_db,@Summary)


    @summary_csv.close
    
    FileUtils.rm("#{@SummaryTmp}")
    Common.print_summary

  end
  
end


if __FILE__ == $0
  fdiff = FDiff.new
  fdiff.main
end
