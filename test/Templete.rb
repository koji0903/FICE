#!/usr/bin/ruby
require 'test/unit'
$:.unshift(File.dirname(__FILE__) + "/../bin")
$:.unshift(File.dirname(__FILE__) + "/../lib")
$:.unshift(File.dirname(__FILE__) + "/../conf")
require 'templete'


class Test_Templete < Test::Unit::TestCase
  #
  # Option Test
  #  
  def test_get_argument
    obj = Templete.new
    # Unsupprted Option
    ARGV.clear
    ARGV << "-x"
    assert_equal(false,obj.get_argument)
    # "-h"
    ARGV.clear
    ARGV << "-h"
    assert_equal([true,true],obj.get_argument)
    # "-a"
    ARGV.clear
    ARGV << "-a"
    assert_equal(true,obj.get_argument)  
  end
end
