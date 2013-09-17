#!/usr/bin/ruby
require 'test/unit'
$:.unshift(File.dirname(__FILE__) + "/../bin")
$:.unshift(File.dirname(__FILE__) + "/../lib")
$:.unshift(File.dirname(__FILE__) + "/../conf")
require 'ProductCC'

class Test_ProductCC < Test::Unit::TestCase
  def test_argument1
    a = ProductCC.new
    a.generate_expect
  end
end
