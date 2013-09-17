#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby-1.9.2-p180/bin/ruby
require 'test/unit'
$:.unshift(File.dirname(__FILE__) + "/../../bin")
$:.unshift(File.dirname(__FILE__) + "/../../lib")
$:.unshift(File.dirname(__FILE__) + "/../../conf")
require 'FMakeVerilogList'
require 'FICE_DB'

class Test_FMakeVerilogList < Test::Unit::TestCase

  def setup
    @file = "../../test/FMake/tp/rl78.list"
    @module_name = "D78F1070"
    
    @obj = FMakeVerilogList.new( :filelist => @file, 
                                 :xml_base => "rl78.xml",
                                 :db_file => "rl78.db",
                                 :product => "RL78",
                                 :dev_ver => "CF1.0",
                                 :ice_ver => "rev001"
                                 )
  end

=begin
  def test_hdl    
    assert_equal(true,@obj.analyze_VerilogList)
  end
=end

  def test_generaete_HierHtml
    assert_equal("/home/product/div-micom-ice/data/proj/RL78/Common/.fice/xml/rl78.xml",@obj.analyze_VerilogList)
    # test for Html file size
    f = open("tp/hier_golden.html","r")
    golden = f.read
    @obj.generate_HierHtml(@module_name)
    html = FICE_DB::HTML_PATH + "/hier.html"
    f = open("#{html}","r")
    revised = f.read
    assert_equal(golden,revised)
  end

end
