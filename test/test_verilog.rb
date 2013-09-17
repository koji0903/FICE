#!/usr/bin/ruby
require 'test/unit'
$:.unshift(File.dirname(__FILE__) + "/../bin")
$:.unshift(File.dirname(__FILE__) + "/../lib")
$:.unshift(File.dirname(__FILE__) + "/../conf")
require 'verilog'


class Test_verilog < Test::Unit::TestCase
  #
  # Option Test
  #  
  def test_analyze
    hdl_file = "_tp/eva_top.v"
    obj = Verilog.new
    obj.analyze(hdl_file)
#    assert_equal("IX4",obj.reader_CN(csv_file)[0].ProductName)
  end
end

