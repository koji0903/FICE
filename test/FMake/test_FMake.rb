#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby-1.9.2-p180/bin/ruby
require 'test/unit'
$:.unshift(File.dirname(__FILE__) + "/../../bin")
$:.unshift(File.dirname(__FILE__) + "/../../lib")
$:.unshift(File.dirname(__FILE__) + "/../../conf")
require 'FMake'


class Test_FMake < Test::Unit::TestCase

  def setup
    @obj = FMake.new
  end

  #
  # Option Test
  #  
  def test_get_argument
=begin
    # Unsupprted Option
    ARGV.clear
    ARGV << "-x"
    assert_equal(false,@obj.get_argument)


    # "-h"
    ARGV.clear
    ARGV << "--help"
    assert_equal(true,obj.get_argument)
    # "-a"
    ARGV.clear
    ARGV << "-a"
    assert_equal(true,obj.get_argument)  
=end
  end

  #
  # Startup test
  #
  def test_Startup
    ARGV.clear
    # VerilogListFile
    ARGV << "--startup"
    ARGV << "./tp/test.list"
    # Top Module
    ARGV << "--top_module"
    ARGV << "test"
    # Product
    ARGV << "--product"
    ARGV << "test"
    # Device Ver
    ARGV << "--dev_ver"
    ARGV << "CF1.0"
    # add_modify_inst
    ARGV << "--add_modify_inst"
    ARGV << "sub0"
    ARGV << "--add_modify_inst"
    ARGV << "sub1"
#    ARGV << "--add_modify_inst"
#    ARGV << "sub0.drive_change_a1"
    ARGV << "--outdir"
    ARGV << "/home/product/div-micom-ice/data/proj/RL78/Common/.fice"
    @obj.main

    golden_file = "./tp/test.conf_golden"
    golden_tmp = Common.file_read(golden_file)

    start_line_no = 0
    golden_tmp.each_with_index do |line,i|
      if /# Circuit Information/ =~ line
        start_line_no = i
      end
    end
    golden = golden_tmp[start_line_no..(golden_tmp.size-1)]

    revised_file = "/home/product/div-micom-ice/data/proj/RL78/Common/.fice/test.conf"
    revised_tmp = Common.file_read(revised_file)

    start_line_no = 0
    revised_tmp.each_with_index do |line,i|
      if /# Circuit Information/ =~ line
        start_line_no = i
      end
    end
    revised = revised_tmp[start_line_no..(revised_tmp.size-1)]

    assert_equal(golden,revised)
  end

  #
  # Test for Check Mode
  #
  def test_Check
    ARGV.clear
    ARGV << "--check"
    ARGV << "./tp/test_Check.conf"
    ARGV << "--outdir"
    ARGV << "/home/product/div-micom-ice/data/proj/RL78/Common/.fice/test"
    @obj.main
  end

  #
  # Test for Config Mode
  #
  def test_Config
    ARGV.clear
    ARGV << "--config"
    ARGV << "./tp/test_Config.conf"
    ARGV << "--outdir"
    ARGV << "/home/product/div-micom-ice/data/proj/RL78/Common/.fice/test"
    ARGV << "--verbose"
    @obj.main

    golden_file = "./tp/test.v_golden"
    golden = Common.file_read(golden_file)

    revised_file = "/home/product/div-micom-ice/data/proj/RL78/Common/.fice/test/test_CF1.0_rev001_modify.v"
    revised = Common.file_read(revised_file)

    assert_equal(golden,revised)
  end

  #
  # Test for Config Mode
  #
  def test_Analyze
    ARGV.clear
    ARGV << "--analyze"
    ARGV << "./tp/test_Config.conf"
    ARGV << "--outdir"
    ARGV << "/home/product/div-micom-ice/data/proj/RL78/Common/.fice/test"
    @obj.main
  end

end
