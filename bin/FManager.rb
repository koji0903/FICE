#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-


$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"
require "optparse"
require "FMakeMessage"
require "FICE_DB"
require "FMakeVerilogList"
require "FMakeConf"
require "FMakeLogic"
require "FMakeFileControl"

#
# Global Setting
#
$TOOL            = "FICE"     # Envirment Name
$SUB_TOOL        = "FManager" # Tool Name
$VERBOSE         = false      # Verbose Mode
$ERROR_CNT       = 0          # Error Count for tool summary
$WARNING_CNT     = 0          # Warning Count for tool summary
$NOTE_CNT        = 0          # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
Version          = $VERSION # For OptParse


####################################################################################
#== FPGA-ICE Manager Tool
#    Management each Verilog-HDL Files and Macro components
#
#Authors::   Koji HIJIKURO<koji.hijikuro.rj@rms.renesas.com>
#Copyright:: Copyright (c) 2011 Renesas MicroSystems. All rights reserved.
#
#=== Notice
# Support Ruby-1.9.2 or higher
#
#=== Usage
#
# %FMake.rb [OPTION]
#  [OPTION]
#    --help                  : Print Help Message
#    --version               : Print Version Message
#    --verbose               : Execute under Verbose-Mode
#
#  If you want to get more information. plese use "--help" option.
#
#=== Example
#
#
#=== Output
#
####################################################################################
class FManager

  #
  # initialize method
  # 
  def initialize
    # For System
    @db_file = FICE_DB::FICE_DATA + "/db/rl78.db"
  end

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  public
  def get_argument
    opt = OptionParser.new
    begin
      # For System
      opt.on('--verbose',"execute under verbose mode"){|v| $VERBOSE = true}
      opt.parse(ARGV)
    rescue
      FMakeMessage.PrintError( :category => "OPT", :no => 2, :all_opt => ARGV.join(" "))
      return false
    end
    return true
  end

  #
  #
  #
  def operation
    macro_inf = get_DB_Data(@db_file,"Macro")
    inst_list = Array.new
    macro_inf.each do |each_macro|
      inst_list << each_macro[1]
    end
    p inst_list.uniq
  end

  #
  #
  #
  def get_DB_Data(db_file,table)
    db = SQLite3::Database.new("#{db_file}")      
    table = "Macro"
    sql = "select * from #{table}"
    return db.execute(sql)
  end

  #
  # Main Function
  #
  public
  def main
    #  1. Print Base Meesage in standard output 
    Common.print_base

    operation
    
    #  X. Print Summary and Finish Execute
    Common.print_summary
  end


end


if __FILE__ == $0
  fmanager = FManager.new
  fmanager.main
end
