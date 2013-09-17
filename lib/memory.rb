#!/usr/bin/ruby
##################################################################
#
#  Memory
#
#  Function : Memory
#
#  Author   : Koji HIJIKURO
#
###################################################################

# DataBase
class MemoryDB
  attr_accessor :MemoryName
  attr_accessor :PortSize
  attr_accessor :Port1
  attr_accessor :Port2
  attr_accessor :BitWriteFlag
  attr_accessor :ByteWriteFlag
  attr_accessor :UnusedInput
  def initialize
    @MemoryName = nil
    @PortSize = 0
    @Port1 = Port.new
    @Port2 = Port.new
    @BitWriteFlag = false
    @ByteWriteFlag = false
    @UnusedInput = Array.new
  end
  
  class Port
    attr_accessor  :Clock
    attr_accessor  :InputData
    attr_accessor  :OutputData
    attr_accessor  :Address
    attr_accessor  :BitWriteEnable
    attr_accessor  :ByteWriteEnable
    attr_accessor  :WriteEnable
    attr_accessor  :ChipEnable
    attr_accessor  :Type
    def initialize
      @Clock = nil
      @InputData = nil
      @OutputData = nil
      @Address = nil
      @BitWriteEnable = nil
      @ByteWriteEnable = nil
      @WriteEnable = nil
      @ChipEnable = nil
      @Type = nil
    end
  end
end
