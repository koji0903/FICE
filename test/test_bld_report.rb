#!/usr/bin/ruby
require 'test/unit'
$:.unshift(File.dirname(__FILE__) + "/../bin")
$:.unshift(File.dirname(__FILE__) + "/../lib")
$:.unshift(File.dirname(__FILE__) + "/../conf")
require 'bld_report'
require 'common'

class Test_bld_report < Test::Unit::TestCase
  include ISEBld

  def setup
    @bld_file = Dir::pwd + "/_tp/ISE/EVA_TOP.bld"
  end
  
  def test_BldInf
    obj = BldReport.new(@bld_file)
    bld_inf = obj.parse(Common.file_read("#{@bld_file}"))
    # Check ISE Version
    assert_equal("Release 12.3 - edif2ngd M.70d (lin64)",bld_inf.ISEVersion)
    # Check CommandLint
    assert_equal("/home/tools13/eda_tools/Linux_RHEL5/xilinx/ise/12.3/ISE_DS/ISE/bin/lin64/unwrapped/ngdbuild -intstyle ise -dd _ngo -nt timestamp -p xc4vlx80-ff1148-11EVA_TOP.edf EVA_TOP.ngd -uc EVA_TOP_10MHz.ucf",bld_inf.CommandLine)
    # Check Warning Messages
    assert_equal(89,bld_inf.WarningMessages.size)
    # Check ErrorCounts
    assert_equal(0,bld_inf.ErrorCounts)
    # Check WarningCounts
    assert_equal(89,bld_inf.WarningCounts)
  end

end
