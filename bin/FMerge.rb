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
require "fileutils"
require "conv"
require "pp"
require "kconv"
require "nkf"


#
# Global Setting
#
$TOOL            = "FICE"  # Envirment Name
$SUB_TOOL        = "FMerge" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
$TEST_MODE       = false

#############################################################
#
# FMerge
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009-2012 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Merge for FMake Configuration File(*.conf)
#
# [Usage]
# -%ruby templete.rb
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
class FMerge
  attr_accessor :Report
  def initialize
    @PreStartupConf = nil
    @PreConfigConf = nil
    @CurrentStartupConf = nil
    @MergedConf = nil

    @PreDevVer = nil
    @CurrentDevVer = nil

    @outdir = "result"
    Common.make_dir(@outdir)

    @Report = @outdir + "/" + "FMerge.report"
    @f_report = nil

    @CurrentConfInf = nil

    @UpdatedModules = Hash.new
    @NewInst = Hash.new
    @DeleteInst = Hash.new
    @UpdateInst = Hash.new

    @IdVer = nil
    @LocalPath = nil
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
      opt.on('--previous-startup-conf [Conf]','Previous Conf File'){|v| @PreStartupConf = v }
      opt.on('--previous-config-conf [Conf]','Previous Conf File'){|v| @PreConfigConf = v }
      opt.on('--current-startup-conf [Conf]','Current Conf File'){|v| @CurrentStartupConf = v }
      opt.on('--merged-conf [Conf]','Output Merged Conf File'){|v| @MergedConf = v }
      opt.on('--idver [IDVersion]','Id Version(ICE_VER in conf)'){|v| @IdVer = v }
      opt.on('--ice-ver [IDVersion]','Id Version(ICE_VER in conf)'){|v| @IdVer = v }
      opt.on('--local-path [Local Path]','Local Path(PRODUCT_PATH in conf)'){|v| @LocalPath = v }
      opt.on('--product-path [Product Path]','Product Path(PRODUCT_PATH in conf)'){|v| @LocalPath = v }
      opt.on('--report [ReportFile]','Output Report File ( default : FMerge.report )'){|v| @Report = v }
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:Not support  "#{ARGV}" option or need argument using this option.
EOB
      Common.print_summary
      exit 1
    end

    # Check Input Inf ( must setting )
    check_described_readable("Previous Startup Conf File","previous-startup-conf",@PreStartupConf)
    check_described_readable("Current Startup Conf File","current-startup-conf",@CurrentStartupConf)
    check_described_readable("Previous Config Conf File","previous-config-conf",@PreConfigConf)
    check_described_readable("Merged Conf File","merged-conf",@MergedConf,false)

    # Check Option
    if @IdVer.nil?
      $WARNING_CNT += 1
      printf "@W:\"--idver\" option was not set. You HAVE to check \"ICE_VER\" in Conf File yourself.\n"
    end
#    if @LocalPath.nil?
#      $WARNING_CNT += 1
#      printf "@W:\"--local-path\" option was not set. You HAVE to check \"PRODUCT_PATH\" in Conf File yourself.\n"
#    end

    return true
  end

  # Check Describe ( If not described, Error and Exit )
  def check_described_readable(str,opt,param,readable_check=true)
    if opt == nil
      FMakeMessage::PrintError( :category => "OPT", :no => 6, :param => str, :all_opt => ARGV.join(" ")) if param.nil?
    else
      FMakeMessage::PrintError( :category => "OPT", :no => 7, :param => str, :need_opt => opt, :all_opt => ARGV.join(" ")) if param.nil?
    end
    FMakeMessage::PrintError( :category => "OPT", :no => 3, :file => param, :opt => ARGV.join(" "), :mode => @MODE) unless FileTest::readable?(param) if readable_check
  end
  
  #
  # Get Conf File Information
  #  para : Configuration File Name
  #  ret  : Analyzed Conf Data ( Class - FICE_DB:Conf )
  #
  def get_Conf(conf)
    conf_db = FMakeConf.new( 
                            :conffile      => conf,
                            ).analyze
    conf_db
  end
  
  #
  # Compare between Confs
  #  para : pre Conf, current Conf  ( Class - FICE_DB:Conf )
  #
  def compare_startup_conf(f_report,pre_file,current_file)
    printf "@I: Compare between #{pre_file} and #{current_file}\n"
    pre_data, current_data = ["Previous",get_Conf(pre_file)], ["Current",get_Conf(current_file)]
    @CurrentConfInf = current_data[1]
    f_report.print <<EOF

-------------------------------------------------------------------------------------------------------------------

1. Compare Previous / Current Startup Conf File

1-1. INPUT Information

 Previous Startup Conf : #{File.expand_path(pre_file)} (#{File::stat("#{pre_file}").mtime})
 Current Startup Conf  : #{File.expand_path(current_file)} (#{File::stat("#{current_file}").mtime})

1-2. Basic Conf File Information

EOF
    [pre_data,current_data].each do |data|
      category = data[0]
      inf = data[1]

      f_report.print <<EOF
 [#{category} Startup Conf]
   Product Name  : #{inf.PRODUCT}
   Product Ver   : #{inf.PRODUCT_VER}
   ICE Ver       : #{inf.ICE_VER}
   Top Module    : #{inf.TOP_MODULE}
   List File     : #{File.expand_path(inf.VERILOG_LIST)}
EOF

      f_report.printf("   Set Variables : ")
      inf.SET.each_with_index do |set_data,num|
        if num == 0
          f_report.printf("%s => %s\n",set_data[0],set_data[1])          
        else
          f_report.printf("                   %s => %s\n",set_data[0],set_data[1])
        end
      end
      f_report.printf("\n")      
    end
    
    pre_list,current_list = make_list(pre_data[1]), make_list(current_data[1])    
    
    f_report.print <<EOF
1-3. Comparison Result - Device HDL File Check

 [New File(s)] - #{(current_list.keys - pre_list.keys).size} files
EOF
    
    (current_list.keys - pre_list.keys).each do |file|
      f_report.printf("  %s\n",current_list[file][0])
    end
    
    num = 0
    (current_list.keys & pre_list.keys).each do |file|
      num += 1 if current_list[file][1] != pre_list[file][1] 
    end
    
    f_report.print <<EOF

 [Update File(s)] - #{num} files
EOF
    
    # common file
    outdir = "./result/diff"
    Common.make_dir(outdir)
    (current_list.keys & pre_list.keys).each do |file|
      # compare md5sum
      next if current_list[file][1] == pre_list[file][1] 
      # get module name
      module_list = Array.new
      contents = Conv.new(current_list[file][0]).main
      contents.split("\n").each do |line|
        if /^\s*module\s+(\w*)\s*\(/ =~ line
          module_list << $1.strip
        elsif /^\s*module\s+(\w*)\s*$/ =~ line
          module_list << $1.strip
        end
      end
      diff = outdir + "/" + file + ".diff"
      # unix diff
      diff_data = `diff -u #{pre_list[file][0]} #{current_list[file][0]}`
      # generate diff file
      printf("@I:generate Diff file(%s)\n",diff)
      f = open(diff,"w")
      diff_data = diff_data.kconv(Kconv::UTF8,Kconv.guess(diff_data))
      diff_data.split("\n").each do |line|
        f.printf "%s\n",line
      end
      f.close
      # Print message
      f_report.printf("  %s\n",current_list[file][0])
      f_report.printf("   - Diff File : %s\n",diff)
      f_report.printf("   - Module    : ")
      module_list.each_with_index do |mod,i|
        if i == 0
          f_report.printf("%s\n",mod)
        else
          f_report.printf("                 %s\n",mod)
        end
        @UpdatedModules[mod] = diff
      end
      f_report.printf("\n")
    end
    printf "Done\n"
  end
    
  #
  # Compare between Confs
  #  para : pre Startup Conf, pre Config Conf  ( Class - FICE_DB:Conf )
  #
  def compare_conf(f_report,current_startup_file,pre_config_file)
    printf "@I: Compare between #{current_startup_file} and #{pre_config_file}\n"

    current_startup_data, pre_config_data = ["Current Startup",get_Conf(current_startup_file)], ["Pre Config",get_Conf(pre_config_file)]

    f_report.print <<EOF

-------------------------------------------------------------------------------------------------------------------

2. Compare Current Startup / Previous Config

2-1. INPUT Information

 Current Startup Conf  : #{File.expand_path(current_startup_file)} (#{File::stat("#{current_startup_file}").mtime})
 Previous Config Conf  : #{File.expand_path(pre_config_file)} (#{File::stat("#{pre_config_file}").mtime})

2-2. Basic Conf File Information

EOF
    @PreDevVer = pre_config_data[1].PRODUCT_VER
    @CurrentDevVer = current_startup_data[1].PRODUCT_VER
    [current_startup_data,pre_config_data].each do |data|
      category = data[0]
      inf = data[1]
      f_report.print <<EOF
 [Previous #{category} Conf]
   Product Name  : #{inf.PRODUCT}
   Product Ver   : #{inf.PRODUCT_VER}
   ICE Ver       : #{inf.ICE_VER}
   Top Module    : #{inf.TOP_MODULE}
   List File     : #{File.expand_path(inf.VERILOG_LIST)}
EOF
      f_report.printf("   Set Variables : ")
      inf.SET.each_with_index do |set_data,num|
        if num == 0
          f_report.printf("%s => %s\n",set_data[0],set_data[1])          
        else
          f_report.printf("                   %s => %s\n",set_data[0],set_data[1])
        end
      end
      f_report.printf("\n")      
    end
    
    f_report.print <<EOF
2-3. Comparison Result - Instance Check

EOF

    startup_inst = current_startup_data[1].INST
    config_inst = pre_config_data[1].INST
    
    # Case 1 : New Instance
    f_report.print " [New Instance (except ADD macro)] - add in #{@MergedConf} file\n"
    (startup_inst.keys - config_inst.keys).each do |inst|
      inf = startup_inst[inst]
      unless inf.MacroType.downcase == "add"
        f_report.printf "   %s\n",inst 
        @NewInst[inst] = inf
      end
    end
    f_report.print "\n"

    # Case 2 : Delete Instance 
    f_report.print " [Delete Instance (except ADD macro)] - comemnt out at #{@MergedConf} file\n"
    (config_inst.keys - startup_inst.keys).each do |inst|
      inf = config_inst[inst]
      unless inf.MacroType.downcase == "add"
        f_report.printf "   %s\n",inst 
        @DeleteInst[inst] = inf
      end
    end
    f_report.print "\n"
    
    # Case 3 : Same Instance ( Next Step : Check Module name and each settting file(*.v/*.con) )
    f_report.print " [Same Instance but Updated Module(except ADD macro)] - add comemnt in #{@MergedConf}\n"
    (config_inst.keys & startup_inst.keys).each do |inst|
      inf = config_inst[inst]
      next if inf.MacroType.downcase == "add"
      # Same Module , But Update HDL
      if @UpdatedModules[inf.ModuleName] != nil
        f_report.printf "   %s[%s] - HDL Update ( see %s )\n",inst,inf.ModuleName,@UpdatedModules[inf.ModuleName]
        @UpdateInst[inst] = inf
      end
      # Different Module
      if startup_inst[inst].ModuleName != config_inst[inst].ModuleName
        f_report.printf "   %s[%s] - Change Module ( %s -> %s )\n",inst,inf.ModuleName,config_inst[inst].ModuleName,startup_inst[inst].ModuleName
        @DeleteInst[inst] = config_inst[inst]
        @NewInst[inst] = startup_inst[inst]
      end
    end

    # Get HDL File path (current_startup_file)
    device_hdl = Hash.new
    device_diff = Hash.new
    inst_comment = Hash.new
    open(current_startup_file).each do |line|
      if /#\s*\[.*\].*\(\s*Inst\s+:\s*(\S+)\s*\)/ =~ line
        inst_name = $1.strip
        inst_comment[inst_name] = line
      end
      if /#\s*DeviceHDL\s*:\s+(\S+)/ =~ line
        file_path = $1.strip
        device_hdl[File.basename(file_path)] = file_path
      end
      if /#\s*Diff\s*:\s+(\S+)/ =~ line
        file_path = $1.strip
        device_diff[File.basename(file_path)] = file_path
      end
    end
    return device_hdl,device_diff,inst_comment
  end


  #
  # Compare between Confs
  #  para : pre Startup Conf, pre Config Conf  ( Class - FICE_DB:Conf )
  #
=begin
  def compare_config_conf(startup_file,config_file)
    printf "@I: Compare between #{startup_file} and #{config_file}\n"

    startup_data, config_data = ["Startup",get_Conf(startup_file)], ["Config",get_Conf(config_file)]

    @f_report.print <<EOF

-------------------------------------------------------------------------------------------------------------------

2. Compare Previous Startup/Config Conf File

1-1. INPUT Information

 Previous Startup Conf : #{File.expand_path(startup_file)} (#{File::stat("#{startup_file}").mtime})
 Previous Config Conf  : #{File.expand_path(config_file)} (#{File::stat("#{config_file}").mtime})

1-2. Basic Conf File Information

EOF
    [startup_data,config_data].each do |data|
      category = data[0]
      inf = data[1]
      @f_report.print <<EOF
 [Previous #{category} Conf]
   Product Name  : #{inf.PRODUCT}
   Product Ver   : #{inf.PRODUCT_VER}
   ICE Ver       : #{inf.ICE_VER}
   Top Module    : #{inf.TOP_MODULE}
   List File     : #{File.expand_path(inf.VERILOG_LIST)}
EOF
      @f_report.printf("   Set Variables : ")
      inf.SET.each_with_index do |set_data,num|
        if num == 0
          @f_report.printf("%s => %s\n",set_data[0],set_data[1])          
        else
          @f_report.printf("                   %s => %s\n",set_data[0],set_data[1])
        end
      end
      @f_report.printf("\n")      
    end
    
    @f_report.print <<EOF
1-3. Comparison Result - Instance Check

EOF
    
    startup_inst = startup_data[1].INST
    config_inst = config_data[1].INST
    
    @f_report.printf(" [Add Instance]\n")
    (config_inst.keys - startup_inst.keys).each do |inst|
      @f_report.printf("   %s\n",inst)
      @ChangeInst[inst] = config_inst[inst]
    end
    @f_report.printf("\n") 

    @f_report.printf(" [Delete Instance]\n")
    (startup_inst.keys - config_inst.keys).each do |inst|
      @f_report.printf("   %s\n",inst)      
      @DeleteInst[inst] = config_inst[inst]
    end
    @f_report.printf("\n") 


    @f_report.printf(" [Change(Type/Verilog/Con) Instance]\n")
    config_inst.each do |key,inst_inf|
      unless startup_inst[key].nil?
        if ( inst_inf.MacroType_org != startup_inst[key].MacroType_org || 
             inst_inf.ReplaceModuleName_org != startup_inst[key].ReplaceModuleName_org ||
             inst_inf.ReplaceVerilogFile_org != startup_inst[key].ReplaceVerilogFile_org ||
             inst_inf.ModCon_org  != startup_inst[key].ModCon_org ||
             inst_inf.AddModCon_org != startup_inst[key].AddModCon_org ||
             inst_inf.InstCon_org != startup_inst[key].InstCon_org ||
             inst_inf.AddInstCon_org != startup_inst[key].AddInstCon_org ||
             inst_inf.Comment_org != startup_inst[key].Comment_org )            
          @f_report.printf("   %s\n",inst_inf.InstName)
          if inst_inf.MacroType_org != startup_inst[key].MacroType_org
            @f_report.printf("     - MacroType : %s -> %s\n",startup_inst[key].MacroType_org,inst_inf.MacroType_org)            
          end
          if inst_inf.ReplaceModuleName_org != startup_inst[key].ReplaceModuleName_org
            @f_report.printf("     - ReplaceModuleName : %s -> %s\n",startup_inst[key].ReplaceModuleName_org,inst_inf.ReplaceModuleName_org) 
          end
          if inst_inf.ReplaceVerilogFile_org != startup_inst[key].ReplaceVerilogFile_org
            @f_report.printf("     - ReplaceVerilogFile : %s -> %s\n",startup_inst[key].ReplaceVerilogFile_org,inst_inf.ReplaceVerilogFile_org) 
          end
          if inst_inf.ModCon_org != startup_inst[key].ModCon_org
            @f_report.printf("     - ModCon : %s -> %s\n",startup_inst[key].ModCon_org,inst_inf.ModCon_org) 
          end
          if inst_inf.AddModCon_org != startup_inst[key].AddModCon_org
            @f_report.printf("     - AddModCon : %s -> %s\n",startup_inst[key].AddModCon_org,inst_inf.AddModCon_org) 
          end
          if inst_inf.InstCon_org != startup_inst[key].InstCon_org
            @f_report.printf("     - InstCon : %s -> %s\n",startup_inst[key].InstCon_org,inst_inf.InstCon_org) 
          end
          if inst_inf.AddInstCon_org != startup_inst[key].AddInstCon_org
            @f_report.printf("     - AddInstCon : %s -> %s\n",startup_inst[key].AddInstCon_org,inst_inf.AddInstCon_org) 
          end
          if inst_inf.Comment_org != startup_inst[key].Comment_org
            @f_report.printf("     - Comment : %s -> %s\n",startup_inst[key].Comment_org,inst_inf.Comment_org) 
          end
          @f_report.printf("\n")
          @ChangeInst[inst_inf.InstName] = inst_inf
        end
      end
    end
    printf "Done\n"
  end
=end

  def make_list(data)
    list = Hash.new
    open(data.VERILOG_LIST).each do |line|
      next if line.size == 0
      next if /^\/\// =~ line
      next if /^#/ =~ line
      line = line.strip
      unless File.readable?(line)
        $ERROR_CNT += 1
        printf "@E:Cannot read \"#{line}\". please check #{data.VERILOG_LIST}\n"
        Common.print_summary
        exit 1
      end
      list[File.basename(line)] = [line,Common.md5sum(line)]
    end
    list
  end

  #
  # generate Merged Conf
  #
  def generate_merged_conf(file,pre_config_file,device_hdl,device_diff,inst_comment)
    f = open(pre_config_file,"r")
    data = f.read.split("\n")
    f.close

    pre_config = get_Conf(pre_config_file)

    # Change Set Inf
    new_data = Array.new
    data.each do |line|
      case line
      when /\s*ICE_VER:.+/
        unless @IdVer.nil?
          new_data << "ICE_VER: #{@IdVer}\n"
        else
          new_data << line
        end
      when /\s*IdVer\s*:.+/
        unless @IdVer.nil?
          new_data << "IdVer: #{@IdVer}\n"
        else
          new_data << line
        end
      when /\s*SET\s+PRODUCT_PATH/
        unless @LocalPath.nil?
          new_data << "SET PRODUCT_PATH=#{@LocalPath}\n"
        else
          new_data << line
        end
      when /\s*PRODUCT_VER\s*:.+/
        new_data << "PRODUCT_VER: #{@CurrentConfInf.PRODUCT_VER}\n"
      when /\s*DeviceVer\s*:.+/
        new_data << "DeviceVer: #{@CurrentConfInf.DeviceVer}\n"
      when /\s*VERILOG_LIST\s*:.+/
        new_data << "VERILOG_LIST: #{@CurrentConfInf.VERILOG_LIST}\n"
      when /\s*VERILOG_DEFINE\s*:.+/
        new_data << "VERILOG_DEFINE: #{@CurrentConfInf.VERILOG_DEFINE}\n"
      when /\s*SET\s+ICE_MACRO_VER/
        if @CurrentConfInf.SET["ICE_MACRO_VER"].nil?
          new_data << line
        else
          new_data << "SET ICE_MACRO_VER=#{@CurrentConfInf.SET["ICE_MACRO_VER"]}"
        end
      when /\s*SET\s+REPLACE_MACRO_VER/
        if @CurrentConfInf.SET["REPLACE_MACRO_VER"].nil?
          new_data << line
        else
          new_data << "SET REPLACE_MACRO_VER=#{@CurrentConfInf.SET["REPLACE_MACRO_VER"]}"
        end
      when /\s*SET\s+PORT_BUFFER_VER/
        if @CurrentConfInf.SET["PORT_BUFFER_VER"].nil?
          new_data << line
        else
          new_data << "SET PORT_BUFFER_VER=#{@CurrentConfInf.SET["PORT_BUFFER_VER"]}"
        end
      when /\s*SET\s+MC/
        str = "MC"
        if @CurrentConfInf.SET["#{str}"].nil?
          new_data << line
        else
          new_data << "SET #{str}=#{@CurrentConfInf.SET["#{str}"]}"
        end
      when /\s*SET\s+FB/
        str = "FB"
        if @CurrentConfInf.SET["#{str}"].nil?
          new_data << line
        else
          new_data << "SET #{str}=#{@CurrentConfInf.SET["#{str}"]}"
        end
      when /\s*SET\s+IM/
        str = "IM"
        if @CurrentConfInf.SET["#{str}"].nil?
          new_data << line
        else
          new_data << "SET #{str}=#{@CurrentConfInf.SET["#{str}"]}"
        end
      when /\s*SET\s+RE/
        str = "RE"
        if @CurrentConfInf.SET["#{str}"].nil?
          new_data << line
        else
          new_data << "SET #{str}=#{@CurrentConfInf.SET["#{str}"]}"
        end
      when /\s*SET\s+PB/
        str = "PB"
        if @CurrentConfInf.SET["#{str}"].nil?
          new_data << line
        else
          new_data << "SET #{str}=#{@CurrentConfInf.SET["#{str}"]}"
        end
      when /\s*SET\s+RM/
        str = "RM"
        if @CurrentConfInf.SET["#{str}"].nil?
          new_data << line
        else
          new_data << "SET #{str}=#{@CurrentConfInf.SET["#{str}"]}"
        end
      when /\s*SET\s+IT/
        str = "IT"
        if @CurrentConfInf.SET["#{str}"].nil?
          new_data << line
        else
          new_data << "SET #{str}=#{@CurrentConfInf.SET["#{str}"]}"
        end
      when /\s*SET\s+FW/
        str = "FW"
        if @CurrentConfInf.SET["#{str}"].nil?
          new_data << line
        else
          new_data << "SET #{str}=#{@CurrentConfInf.SET["#{str}"]}"
        end
      when /\s*SET\s+FH/
        str = "FH"
        if @CurrentConfInf.SET["#{str}"].nil?
          new_data << line
        else
          new_data << "SET #{str}=#{@CurrentConfInf.SET["#{str}"]}"
        end
      when /\s*SET\s+FC/
        str = "FC"
        if @CurrentConfInf.SET["#{str}"].nil?
          new_data << line
        else
          new_data << "SET #{str}=#{@CurrentConfInf.SET["#{str}"]}"
        end
      when /\s*#\s*DeviceHDL\s*:/
        file_path = nil
        if /#\s*DeviceHDL\s*:\s+(\S+)/ =~ line
          file_path = $1.strip
        end
        unless file_path.nil?
          new_path = device_hdl[File.basename(file_path)]
          unless new_path.nil?
            new_data << "# DeviceHDL : #{new_path}"
          else
            new_data << line
          end
        else
          new_data << line
        end
      when /\s*#\s*Diff\s*:/
        file_path = nil
        if /#\s*Diff\s*:\s+(\S+)/ =~ line
          file_path = $1.strip
        end
        unless file_path.nil?
          new_path = device_diff[File.basename(file_path)]
          unless new_path.nil?
            new_data << "# Diff      : #{new_path}"
          else
            new_data << line
          end
        else
          new_data << line
        end
      when /#\s*\[.*\].*\(\s*Inst\s+:.*\)/ =~ line
        inst_name = nil
        if /#\s*\[.*\].*\(\s*Inst\s+:\s*(\S+)\s*\)/ =~ line
          inst_name = $1
        end
        if inst_name.nil?
            new_data << line
        else
            new_data << inst_comment[inst_name]
        end
=begin
      when /\s*SET\s+PP/
        str = "PP"
        if @CurrentConfInf.SET["#{str}"].nil?
          new_data << line
        else
          new_data << "SET #{str}=#{@CurrentConfInf.SET["#{str}"]}"
        end
=end
      else
        new_data << line
      end
    end
    data = new_data
    new_data = Array.new
    add_inf = Array.new
    new_data = data

    # New Instance
    @NewInst.sort do |a,b|
      -(a[0] <=> b[0])
    end.each do |inst_name,inf|
      printf "@I:\"#{inst_name}\" is Added at Device\n"
      cmp_inst_name = inst_name.split(".")
      cmp_inst_name.pop
      cmp_inst_name = cmp_inst_name.join(".")
      if pre_config.INST[cmp_inst_name].nil?
        no = pre_config.LastLine + 1
      else
        no =  pre_config.INST[cmp_inst_name].InsLineNo_End + 1
      end
      add = get_AddInstInf(inf)
      add_inf << [no,add]
    end
        
    @UpdateInst.each do |inst_name,inf|
      no =  pre_config.INST[inst_name].InsLineNo - 1
      printf "@I:\"#{inst_name}\" is Updated at Device ( LineNo in Conf : #{pre_config.INST[inst_name].InsLineNo} )\n"
      add = Array.new
      add << "# [FMerge] Updated Device HDL(#{inst_name}) : #{@PreDevVer} -> #{@CurrentDevVer}"
      add_inf << [no,add]
    end

    # Add Code
    add_inf.sort_by do |key|
      -key[0]
    end.each do |add|
      new_data[add[0],0] = add[1]
    end

    data = Array.new
    data = new_data
    
    # for Delete Instance
    new_data = Array.new
    delete_flag = false
    data.each do |line|
      @DeleteInst.each do |inst_name,inf|
        if /INS:.*#{inst_name}\s+#{inf.ModuleName}\s/ =~ line.gsub("\t","\s")
          line = "# [#{$SUB_TOOL}] Delete : #{@PreDevVer} -> #{@CurrentDevVer} # " + line 
          if /END_INS:/ =~ line
            delete_flag = false
          else
            delete_flag = true
          end
          next
        end
      end
      # Delete
      if delete_flag
        line = "# [#{$SUB_TOOL}] Delete : #{@PreDevVer} -> #{@CurrentDevVer} # " + line 
        if /END_INS:/ =~ line
          delete_flag = false
        end
      end
      new_data << line
    end


    printf("@I:generate Merged Conf File(%s)\n",file)    
    f = open(file,"w")
    comment = "Merged Conf File" 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")

    new_data.each do |line|
      f.printf "#{line}\n"
    end

    f.close
    conf_diff =  File.basename(file,".conf") + ".diff"
    `diff -u #{@PreConfigConf} #{file} > #{conf_diff}`
=begin
    diff_data = `diff -u #{@PreConfigConf} #{file}`.split("\n")
    print "\n---[DIFF REPORT START (%diff -u #{@PreConfigConf} #{file})]---------------------\n\n"
    diff_data.each do |line|
      printf "%s\n",line
    end
    print "\n---[DIFF END]----------------------------------------------------------\n\n"
=end
  end

  def get_AddInstInf(inf)
    add = Array.new
    case inf.MacroType.downcase
    when "keepkeep","remove"
      add << "# [#{$SUB_TOOL}] Merged : #{@PreDevVer} -> #{@CurrentDevVer}"
      add << "INS:\t#{inf.InstName}\t#{inf.ModuleName}\tTYPE\t#{inf.MacroType} END_INS:"
      add << ""
    else
      add << "# [#{$SUB_TOOL}] Merged : #{@PreDevVer} -> #{@CurrentDevVer}"
      add << "INS:\t#{inf.InstName}\t#{inf.ModuleName}\tTYPE\t#{inf.MacroType}"
      add << "\tMODULE_NAME: #{inf.ReplaceModuleName_org}" unless  inf.ReplaceModuleName_org.nil?
      add << "\tVERILOG_FILE: #{inf.ReplaceVerilogFile_org}" unless  inf.ReplaceVerilogFile_org.nil?
      add << "\t: #{inf.Comment_org}" unless  inf.Comment_org.nil?
      add << "\tMOD_CON: #{inf.ModCon_org}" unless  inf.ModCon_org.nil?
      add << "\tADD_MOD_CON: #{inf.AddModCon_org}" unless  inf.AddModCon_org.nil?
      add << "\tINST_CON: #{inf.InstCon_org}" unless  inf.InstCon_org.nil?
      add << "\tADD_INST_CON: #{inf.AddInstCon_org}" unless  inf.AddInstCon_org.nil?
      add << "END_INS:"
      add << ""
    end
    return add
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

    printf("@I:generate report file(%s)\n",@Report)    
    @f_report = open(@Report,"w")
    comment = "FMerge Report" 
    Common.print_file_header(@f_report,"#{comment}",$SUB_TOOL,$VERSION,"##")

    # Compare "Previous / Current" Startup Conf File
    compare_startup_conf(@f_report,@PreStartupConf,@CurrentStartupConf)

    # Compare Current Config Startup / Previous Config Conf File
    device_hdl,device_diff,inst_comment = compare_conf(@f_report,@CurrentStartupConf,@PreConfigConf)


#    compare_config_conf(@PreStartupConf,@PreConfigConf)
    
    # Generate Merged Conf
    generate_merged_conf(@MergedConf,@PreConfigConf,device_hdl,device_diff,inst_comment)


    @f_report.close

    Common.print_summary
  end
  
end


if __FILE__ == $0
  fmerge = FMerge.new
  fmerge.main
end
