#!/usr/bin/ruby
#############################################################
#
# Conformal
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009,2010 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Analyzing Confromal Report
#
# [Usage]
# -%ruby ConformalSupporter.rb -noneq_custom [Noneq Report] -noneq_normal [Noneq Report] -dofile [Conformal Dofile] -unmapped [Unmapped Report]
# If you want to get more information. plese use "--help" option.
#
# * Noneq Report    : %diagnose -noneq
# * Unmapped Report : %report unmapped points
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
require "optparse"


#
# Global Setting
#
$SUB_TOOL        = "ConformalSupporter" # Tool Name
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
class ConformalSupporter
  
  def initialize
    # Non-equivalent report on Normal Mode
    @Noneq_Normal = nil
    # Non-equivalent report on Custom Mode
    @Noneq_Custom = nil
    # Dofile for Conformal(get ignored points)
    @Dofile = nil
    # Unmapped report from Conformal
    @UnmappedReport = nil
    # Conformal Directory from mkice2
    @ConformalDir = nil
    # Analyzed Data
    @noneqList_Normal = Hash.new
    @noneqList_Custom = Hash.new

    # Ignored Points from dofile (add ignored points)
    @IgnoredPoint = Array.new
    # Pin Constraint from dofile (add pin constraint)
    @PinConstraint = Array.new
    # Unmapped report
    @UnmappedPoint = Array.new
    # EachModule
    @EachModuleResult = Hash.new

    # Show #737
    @AnalysisType = {
      "KX4_IICASCLDLY" => "A",
      "KX4_IICASDADLY" => "A",
      "KX4_PORGA" => "A",
      "KX4_PORT0V1" => "B",
      "KX4_PORT12V1" 	=> "B",
      "KX4_PORT13V1" 	=> "B",
      "KX4_PORT14V1" => "B",
      "KX4_PORT1V1" => "C",
      "KX4_PORT2V1" => "B",
      "KX4_PORT3V1" => "B",
      "KX4_PORT4V1" => "B",
      "KX4_PORT5V1" => "B",
      "KX4_PORT6V1" => "B",
      "KX4_PORT7V1" => "B",
      "KX4_SDADLY" => "A",
      "QLK0RPCLBUZ1V1" => "A",
      "QAHIOS0BN32MV2" => "D",
      "QAHIOS1BN15KV1"  => "D",
      "QAHMOS0HNV1"  => "D",
      "QAHREGOHNMAINV2"  => "D",
      "QAHSOS1HNV1"  => "D",
      "QID04005"  => "D",
      "QLK0RCIBCM3SF1V1" => "E",
      "QLK0RCIBDM3SF1V1" => "G",
      "QLK0RCSC1V2" => "A",
      "QLK0RINTM4V1" => "G",
      "QLK0RINTM8V1" => "G",
      "QLK0RMAW0V1" => "E",
      "QLK0RMULDIV1V1" => "F",
      "QLK0RSCON1V1" => "E",
      "QNSC3NCP1V2" => "G", 
    }
    
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
      opt.on('-h','pint help message'){|v|}
      opt.on('-a','desription of -a'){|v|}
      opt.on('--noneq_custom report','analyzed Non-equivalent report'){|v| @Noneq_Custom = v}
      opt.on('--noneq_normal report','analyzed Non-equivalent report'){|v| @Noneq_Normal = v}
      opt.on('--dofile Dofile','Dofile executed Conformal'){|v| @Dofile = v}
      opt.on('--unmapped UnmappedReport','Unmapped Report from Conformal'){|v| @UnmappedReport = v}
      opt.on('--module Conformal Dir','Conformal Directory generated by mkice2'){|v| @ConformalDir = v}
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
  # Get Ignored-Points from Dofile
  #
  def get_Dofile(dofile)
    open(dofile).each do |line|
      # Ignored Point
      if /^add\s+ignored\s+inputs\s+(\S+)/ =~ line.strip
        @IgnoredPoint << $1
      end
      # Pin Constraint
      if /^add\s+pin\s+constraint\s+(\d+)\s+(\S+)/ =~ line.strip
        @PinConstraint << [$2,$1]
      end
    end
  end
  
  #
  # Get Unmapped Report
  # 
  def get_UnmappedReport(report)
    open(report).each do |line|
      # Filter on "(G)" and "PI"
      if /\(G\).*PI\s+(\S*)/ =~ line
        @UnmappedPoint << $1.sub("/","")
      end
    end
  end

  #
  # Analyzing Noneq Report
  #
  def analyze_noneq(noneq)
    noneqList = Hash.new
    printf "@I:analyzing #{noneq} ... "
    instance_ID = 0, instance = nil
    noneq_ID = 0
    start_ID = 0
    nocor_ID = 0
    open(noneq).each_with_index do |line,i|
      # Get Target-Instance Name (Update instance)
      instance_ID = i if /Diagnosis for/ =~ line
      if instance_ID + 1 == i
        noneq = NonEquivalent.new
        instance = line.strip.split[4].sub("/","")
        noneq.category = line.strip.split[3]
        noneqList["#{instance}"] = noneq
      end
      # Get Non-equivalent Points(End Point)
      noneq_ID = i if /Diagnosis points:/ =~ line
      if noneq_ID + 1 == i
        signal = line.strip.split[4].split("/").last
        noneqList["#{instance}"].noneq_points <<  signal
      end     
=begin
      # Get Start Point
      start_ID = i if /key point in this logic cone/ =~ line
      if start_ID + 4 == i
        target = line.strip.split[0]
        case target
        when "(G)"
          signal = line.strip.split[4]
          @noneqList["#{instance}"].noneq_points.startPoint_Golden = signal
        when "(R)"
          signal = line.strip.split[3]
          @noneqList["#{instance}"].noneq_points.startPoint_Revised = signal
        end
      end
=end
      # Get No-Correspoinding Points
      nocor_ID = i if /Diagnosis point has no corresponding point:/ =~ line
      if nocor_ID + 1 == i
        signal = line.strip.split[4].split("/").last
        noneqList["#{instance}"].nocor_points << signal
      end
    end
    printf "Done\n"
    return noneqList
  end

  #
  # Generate Report File
  #
  def generate_eachReport(noneqList,file_name)
    printf "@I:generate #{file_name}\n"
    f = open("#{file_name}","w")
    comment = "Equivalent Report"
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
    num = 1
    f.printf "|BGCOLOR(gray):COLOR(white):No|BGCOLOR(gray):COLOR(white):Category|BGCOLOR(gray):COLOR(white):Target(Instance/Port)|BGCOLOR(gray):COLOR(white):Signal|BGCOLOR(gray):COLOR(white):Type|\n"
    # Unmapped Report
    num = generate_UnmappedPoint(f,num,@UnmappedPoint)
    # No-quivalent Report
    noneqList.sort_by do |key|
      key
    end.each do |instance,data|
      flag = false
#      num = 1
      f.printf "|#{num}|#{data.category}|#{instance}|"
      case data.category
      when "PO"
        f.printf "---|Non-equivalent|\n"
        num += 1
      when "BBOX"  
        if data.noneq_points.size == 0 && data.nocor_points.size == 0
          $ERRORN_CNT += 1
          f.printf "internal error\n"
          Common.print_summary
          exit
        elsif data.noneq_points.size == 1 && data.nocor_points.size == 0
          f.printf "#{data.noneq_points}|Non-equivalent|\n"
          num += 1
        elsif data.noneq_points.size == 0 && data.nocor_points.size == 1
          f.printf "#{data.nocor_points}|No-corresponding|\n"
          num += 1
        else
          data.noneq_points.each_with_index do |signal,i|
            flag = true
            if i == 0
              f.printf "#{signal}|Non-equivalent|\n"
            else
              f.printf "|#{num}|~|~|#{signal}|Non-equivalent|\n"
            end
            num += 1
          end unless data.noneq_points.nil?
          data.nocor_points.each_with_index do |signal,i|
            if i == 0 && !flag
              f.printf "#{signal}|No-corresponding|\n"
            else
              f.printf "|#{num}|~|~|#{signal}|No-corresponding|\n"
            end
            num += 1
          end unless data.nocor_points.nil?
        end
      end
#      data.noneq_points.each do |signal|
#        f.printf "#{signal}"
#      end
    end
    f.printf "- The number of Total Evaluate Points : #{num-1}\n"
    f.close
  end


  #
  # Generate Report File
  #
  def generate_mergeReport(noneqList_normal,noneqList_custom,file_name)
    printf "@I:generate #{file_name}\n"
    f = open("#{file_name}","w")
    comment = "Equivalent Report"
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
    # Pin Const
    f.printf "* Pin Constraint\n"
    generate_PinConstraint(f,@PinConstraint)

    # Pin List
    total_num = 1
    iceMode_num = 0
    ignored_num = 0
    f.printf "* Diagnose List\n"
    f.printf "|BGCOLOR(gray):COLOR(white):No|BGCOLOR(gray):COLOR(white):Category|BGCOLOR(gray):COLOR(white):Target(Instance/Port)|BGCOLOR(gray):COLOR(white):Signal|BGCOLOR(gray):COLOR(white):Type|\n"
    # Unmapped Report
    total_num = generate_UnmappedPoint(f,total_num,@UnmappedPoint)
    # Un-equivalnet Report
    noneqList_normal.sort_by do |key|
      key
    end.each do |instance,data|
      flag = false
#      total_num = 1
      f.printf "|#{total_num}|#{data.category}|#{instance}|"
      case data.category
      when "PO"
        f.printf "---|Non-equivalent|\n"
        total_num += 1
      when "BBOX"  
        if data.noneq_points.size == 0 && data.nocor_points.size == 0
          $ERRORN_CNT += 1
          f.printf "internal error\n"
          Common.print_summary
          exit
        elsif data.noneq_points.size == 1 && data.nocor_points.size == 0
          data.noneq_points.each do |signal|
            if @IgnoredPoint.index("#{signal}")
              f.printf "#{signal}|BGCOLOR(orange):Ignored|\n"
              ignored_num += 1
            elsif judge_signal(instance,signal,noneqList_custom)
              f.printf "#{signal}|BGCOLOR(gray):ICE-Mode|\n"
              iceMode_num += 1
            else
              f.printf "#{signal}|Non-equivalent|\n"
            end
            total_num += 1
          end
        elsif data.noneq_points.size == 0 && data.nocor_points.size == 1
          data.nocor_points.each do |signal|
            if @IgnoredPoint.index("#{signal}")
              f.printf "#{signal}|BGCOLOR(orange):Ignored|\n"
              ignored_num += 1
            elsif judge_signal(instance,signal,noneqList_custom)
              f.printf "#{signal}|BGCOLOR(gray):ICE-Mode|\n"
              iceMode_num += 1
            else
              f.printf "#{signal}|No-corresponding|\n"
            end
            total_num += 1
          end
        else
          data.noneq_points.each_with_index do |signal,i|
            flag = true
            if i == 0
              if @IgnoredPoint.index("#{signal}")
                f.printf "#{signal}|BGCOLOR(orange):Ignored|\n"
                ignored_num += 1
              elsif judge_signal(instance,signal,noneqList_custom)
                f.printf "#{signal}|BGCOLOR(gray):ICE-Mode|\n"
                iceMode_num += 1
              else
                f.printf "#{signal}|Non-equivalent|\n"
              end
            else
              if @IgnoredPoint.index("#{signal}")
                f.printf "|#{total_num}|~|~|#{signal}|BGCOLOR(orange):Ignored|\n"
                ignored_num += 1
              elsif judge_signal(instance,signal,noneqList_custom)
                f.printf "|#{total_num}|~|~|#{signal}|BGCOLOR(gray):ICE-Mode|\n"
                iceMode_num += 1
              else
                f.printf "|#{total_num}|~|~|#{signal}|Non-equivalent|\n"
              end
            end
            total_num += 1
          end unless data.noneq_points.nil?
          data.nocor_points.each_with_index do |signal,i|
            if i == 0 && !flag
              if @IgnoredPoint.index("#{signal}")
                f.printf "#{signal}|BGCOLOR(orange):Ignored|\n"
                ignored_num += 1
              elsif judge_signal(instance,signal,noneqList_custom)
                f.printf "#{signal}|BGCOLOR(gray):ICE-Mode|\n"
                iceMode_num += 1
              else
                f.printf "#{signal}|No-corresponding|\n"
              end
            else
              if @IgnoredPoint.index("#{signal}")
                f.printf "|#{total_num}|~|~|#{signal}|BGCOLOR(orange):Ignored|\n"
                ignored_num += 1
              elsif judge_signal(instance,signal,noneqList_custom)
                f.printf "|#{total_num}|~|~|#{signal}|BGCOLOR(gray):ICE-Mode|\n"
                iceMode_num += 1
              else
                f.printf "|#{total_num}|~|~|#{signal}|No-corresponding|\n"
              end
            end
            total_num += 1
          end unless data.nocor_points.nil?
        end
      end
    end
    f.printf "- The number of Total Evaluate Points : #{total_num-1}\n"
    f.printf "- The number of Ignored Points        : #{ignored_num}\n"
    f.printf "- The number of ICE-Mode Points       : #{iceMode_num}\n"
    f.printf "- Rest: #{total_num - 1 - iceMode_num - ignored_num}\n"
    f.close
  end


  #
  # judgment existing in noneqLisst_custom
  #
  def judge_signal(instance,signal,noneqList_custom)
    flag = true
    noneqList_custom.each do |inst,data|
      if inst == instance
        flag = false unless data.noneq_points.index("#{signal}").nil?
        flag = false unless data.nocor_points.index("#{signal}").nil?
      end
    end
    return flag
  end

  #
  # generate Pin Constraint
  #
  def generate_PinConstraint(f,const)
    f.printf "|BGCOLOR(gray):COLOR(white):Signal|BGCOLOR(gray):COLOR(white):Constraint Value|\n"
    const.each do |each_const|
      f.printf "|#{each_const[0]}|#{each_const[1]}|\n"
    end
  end

  #
  # generate Unmapped Point
  # 
  def generate_UnmappedPoint(f,num,unmapped_points)
    unmapped_points.sort.each do |point|
      f.printf "|#{num}|PI|#{point}|---|Unmapped|\n"
      num += 1
    end
    return num
  end

  #
  # generate Conformal result Information for each Module
  #
  def generate_ModuleInfo(conformal_dir)
    total_num = 0
    hard_num = 0
    noneq_num = 0
    neq_num = 0

    # Get Hard Macro List
    open("#{conformal_dir}/HardMacroList.txt").each do |macro_name|
      @EachModuleResult["#{macro_name.strip}"] = "Hard Macro"
      total_num += 1
      hard_num += 1
    end
    # Get Conformal Result for each Module
    Dir::glob("#{conformal_dir}/*/diagnose_summary.txt").each do |summary|
      mod_name = summary.split("/")[2]
      type = "Non-equivalent"
      open("#{summary}").each do |line|
        if /There is no non-equivalent compare point for diagnosis./ =~ line
          type = "Equivalent"
        end
      end
      @EachModuleResult["#{mod_name}"] = type
      total_num += 1
      case type
      when "Equivalent"
        neq_num += 1
      when "Non-equivalent"
        noneq_num += 1
      end
    end
    
    # Generate Report
    file_name = "ModuleResult.txt"
    printf "@I:generate #{file_name}\n"
    f = open("#{file_name}","w")
    comment = "Conformal Report for each Module"
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
    # Pin Const
    f.printf "* Conformal Result each Module\n"
    f.printf "- The number of total modules is          #{total_num}\n"
    f.printf "- The number of Hard Macro module is      #{hard_num}\n"
    f.printf "- The number of Non-equivalent module is  #{noneq_num}\n"
    f.printf "- The number of Equivalent module is      #{neq_num}\n"
    f.printf "#br\n"
    f.printf "|BGCOLOR(gray):COLOR(white):No|BGCOLOR(gray):COLOR(white):Module Name|BGCOLOR(gray):COLOR(white):Category|BGCOLOR(gray):COLOR(white):Analysis|\n"
    num =1
    @EachModuleResult.sort_by do |key|
      key
    end.each do |module_name,category|
      case category
      when "Non-equivalent"
        noneq_type = @AnalysisType["#{module_name}"]
        case noneq_type
        when "A"
          f.printf "|#{num}|#{module_name}|COLOR(red):#{category}|[Module ifdef][[NoneqAnalysis-#{module_name}]]|\n"
        when "B"
          f.printf "|#{num}|#{module_name}|COLOR(red):#{category}|[Point Ignored][[NoneqAnalysis-#{module_name}]]|\n"
        when "C"
          f.printf "|#{num}|#{module_name}|BGCOLOR(Olive):#{category}|[Diff][[NoneqAnalysis-#{module_name}]]|\n"
        when "D"
          f.printf "|#{num}|#{module_name}|COLOR(red):#{category}|[Replace Macro][[NoneqAnalysis-#{module_name}]]|\n"
        when "E"
          f.printf "|#{num}|#{module_name}|COLOR(red):#{category}|[Security][[NoneqAnalysis-#{module_name}]]|\n"
        when "F"
          f.printf "|#{num}|#{module_name}|COLOR(red):#{category}|[FPGA Resource][[NoneqAnalysis-#{module_name}]]|\n"
        when "G"
          f.printf "|#{num}|#{module_name}|BGCOLOR(Olive):#{category}|[Logic ifdef][[NoneqAnalysis-#{module_name}]]|\n"
        else
          f.printf "|#{num}|#{module_name}|BGCOLOR(Olive):#{category}|[[NoneqAnalysis-#{module_name}]]|\n"
        end
      when "Hard Macro"
        f.printf "|#{num}|#{module_name}|COLOR(blue):#{category}|---|\n"
      else
        f.printf "|#{num}|#{module_name}|#{category}|---|\n"
      end
      num += 1
    end
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
    unless @Dofile.nil?
      get_Dofile(@Dofile)
    end
    unless @UnmappedReport.nil?
      get_UnmappedReport(@UnmappedReport)
    end
    unless @Noneq_Custom.nil?
      @noneqList_Custom = analyze_noneq(@Noneq_Custom) 
      generate_eachReport(@noneqList_Custom,"equivalent_custom.txt")
    end
    unless @Noneq_Normal.nil?
      @noneqList_Normal = analyze_noneq(@Noneq_Normal) 
      generate_eachReport(@noneqList_Normal,"equivalent_normal.txt")
    end
    unless @Noneq_Custom.nil? && @Noneq_Normal.nil?
      generate_mergeReport(@noneqList_Normal,@noneqList_Custom,"equivalent_merge.txt")
    end
    unless @ConformalDir.nil?
      generate_ModuleInfo(@ConformalDir)
    end
    Common.print_summary
  end
  
end

class NonEquivalent
  attr_accessor :category
  attr_accessor :noneq_points
  attr_accessor :nocor_points
  def initialize
    @category = nil
    @noneq_points = Array.new
    @nocor_points = Array.new
  end
end

=begin
class Points
  attr_accessor :endPoint
  attr_accessor :startPoint_Golden
  attr_accessor :startPoint_Revised
  def initialize
    @endPoint = nil
    @startPoint_Golden = nil
    @startPoint_Revised =nil
  end
end
=end

if __FILE__ == $0
  conformal = ConformalSupporter.new
  conformal.main
end
