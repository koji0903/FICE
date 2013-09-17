#!/usr/bin/ruby
#############################################################
#
# rDiff (make_chip report Diff)
#  
# Authors::   Koji HIJIKURO<koji.hijikuro.rj@rms.renesas.com>
# Copyright:: Copyright (c) 2009,2010 Renesas Micro Systems Co.,Ltd. All rights reserved.
#
#############################################################
#
# [Function]
# - find difference between two report files
#
# [Usage]
# -%ruby rDiff.rb from-file to-file
# If you want to get more information. plese use "-h" option.
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
$:.unshift(File.dirname(__FILE__) + "/../lib") # add lib path
require "FICE_def"
require "system"
require "common"
require "report"
require "optparse"

#
# Global Setting
#
$COMMAND         = ""
$SUB_TOOL        = "rDiff" # Tool Name
$VERBOSE         = false   # Verbose Mode

$INTERNAL_ERROR_CNT  = 0   # Internal Error Count for Tool Bug
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary

$MESSAGE         = false


#
# Main Class
#
class RDiff
  def initialize()
    # first parameter (expect Device make_chip report)
    @FROM_REPORT = nil
    # second parameter (expect ICE make_chip report)
    @TO_REPORT = nil

    # Connect Relation
    @FROM_CONNECT_RELATION = nil
    @TO_CONNECT_RELATION = nil
    
  end
 
  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  public
  def get_argument
    argv = nil
    opt = OptionParser.new
    begin
      opt.on('--verbose',"verbose mode"){|v| $VERBOSE = true}
      opt.on('-h','pint help message'){|v|}
      argv = opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:Not support  "#{ARGV}" option or need argument using this option.
EOB
      return false
    end
    # save parameter
    @FROM_REPORT = argv[0]
    @TO_REPORT = argv[1]
    return true
  end

  #
  # get Connect Information from each report files
  #
  def get_report
    @FROM_CONNECT_RELATION = report("#{@FROM_REPORT}")
    @TO_CONNECT_RELATION = report("#{@TO_REPORT}")
  end

  #
  # execute report library, and get details
  #   param : each files
  #   ret   : connect relation
  #
  def report(file)
    rep = Report.new(file,"all")
    rep.relation
    return rep.ConnectRelation
  end

  def filter(inf)
    delete_list = ["IN_PIN","IO_PIN","OUT_PIN"]
    inf.each do |key,value|
      if /pullup\d+\./ =~ key
        delete_list << key
      end
      if /pulldown\d+\./ =~ key
        delete_list << key
      end
    end
    delete_list.each do |del|
      inf.delete("#{del}")
    end
    return inf
  end

  def gen_all_report(f,file,inf)
    f.printf "# #{file}\n"
    inf.sort_by do |key|
      key
    end.each do |key,value|
      f.printf "#{key}\n"
      f.printf "  Netname       :#{value.NetName}\n"
      f.printf "  Direction     :#{value.Direction}\n"
      f.printf "  IN-Connect    :#{value.IN}\n" 
      f.printf "  OUT-Connect   :#{value.OUT}\n"
      f.printf "  INUOT-Connect :#{value.INOUT}\n"
    end
  end

  def analyze(f,from_inf,to_inf)
    from_inf.sort_by do |key|
      key
    end.each do |key,value|
      if to_inf["#{key}"] == nil
        report_FromOnly(f,key,value)
        print_diff_FromOnly(f,value)
      else
        to_value = to_inf["#{key}"]
        if differ(value,to_value)
          f.printf "differ:#{key}\n"
          print_diff(f,value,to_value)
        end
      end
    end

    to_inf.sort_by do |key|
      key
    end.each do |key,value|
      if from_inf["#{key}"] == nil
        report_ToOnly(f,key,value)
        print_diff_ToOnly(f,value)
      end
    end
  end

  def differ(from_value,to_value)
    diff = false
    if from_value.NetName != to_value.NetName
      diff = true
    end
    if from_value.Direction != to_value.Direction
      diff = true
    end
    if from_value.IN != to_value.IN
      diff = true
    end
    if from_value.OUT != to_value.OUT
      diff = true
    end
    if from_value.INOUT != to_value.INOUT
      diff = true
    end
    
    # ticket #925
    if from_value.Direction == "IN" && to_value.Direction == "IN"
      from_value.OUT.delete("OUT_PIN")
      to_value.OUT.delete("OUT_PIN")
      if from_value.OUT == to_value.OUT
        diff = false
      end
    end

    return diff
  end

  def print_diff(f,golden,revised)
    f.printf "  [golden]  NetName:#{golden.NetName}, Direction:#{golden.Direction}, IN:#{golden.IN}, OUT:#{golden.OUT}, INOUT:#{golden.INOUT}\n"
    f.printf "  [revised] NetName:#{revised.NetName}, Direction:#{revised.Direction}, IN:#{revised.IN}, OUT:#{revised.OUT}, INOUT:#{revised.INOUT}\n"
    f.printf "\n"
  end

  def print_diff_FromOnly(f,golden)
    f.printf "  [golden]  NetName:#{golden.NetName}, Direction:#{golden.Direction}, IN:#{golden.IN}, OUT:#{golden.OUT}, INOUT:#{golden.INOUT}\n"
    f.printf "  [revised] NONE\n"
    f.printf "\n"
  end

  def print_diff_ToOnly(f,revised)
    f.printf "  [golden]  NONE\n"
    f.printf "  [revised] NetName:#{revised.NetName}, Direction:#{revised.Direction}, IN:#{revised.IN}, OUT:#{revised.OUT}, INOUT:#{revised.INOUT}\n"
    f.printf "\n"
  end

  def report_FromOnly(f,key,value)
    f.printf "-#{key}\n"
  end

  def report_ToOnly(f,key,value)
    f.printf "+#{key}\n"
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
    printf "@I:make_chip paramter\n"
    printf "   - FROM : #{@FROM_REPORT}\n"
    printf "   - TO   : #{@TO_REPORT}\n"
    get_report
    # Filterling
    @FROM_CONNECT_RELATION = filter @FROM_CONNECT_RELATION
    @TO_CONNECT_RELATION = filter @TO_CONNECT_RELATION

    # Generate details
    printf "@I:generate report information\n"
    file_name = "details.txt" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    gen_all_report(f,
                   @FROM_REPORT,
                   @FROM_CONNECT_RELATION)
    gen_all_report(f,
                   @TO_REPORT,
                   @TO_CONNECT_RELATION)
    f.close

    file_name = "report.diff" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    analyze(f,@FROM_CONNECT_RELATION,@TO_CONNECT_RELATION)
    f.close


    Common.print_summary
  end

end


if __FILE__ == $0
  rdiff = RDiff.new
  rdiff.main
end
