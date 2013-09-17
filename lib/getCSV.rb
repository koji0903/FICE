#!/usr/bin/ruby -Ks
# -*- coding: utf-8 -*-
#############################################################
#
# getCSV
#  
# Authors::   Koji HIJIKURO<koji.hijikuro.rj@rms.renesas.com>
# Copyright:: Copyright (c) 2009,2010 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - get CSV data
#
#
#############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "system"
require "common"
require "csv"

require "kconv"
require 'nkf'


CODES = {
  NKF::JIS      => "JIS",
  NKF::EUC      => "EUC",
  NKF::SJIS     => "SJIS",
  NKF::BINARY   => "BINARY",
  NKF::UNKNOWN  => "UNKNOWN(ASCII)",
  NKF::UTF8     => "UTF8",
}

class CSVHeaderInf
  attr_reader :ProductName
  attr_reader :Version
 # CSV Column
  A = 0
  E = 4
  F = 5
  G = 6

  def initialize
    @ProductName = nil
    @Version = nil
  end
  def make(row)
    # Get data
    if row[A] == "ProductName="
      @ProductName = row[E]
    end
#    if row[F] == "Para Ver.="
    @Version = row[G]
#    end

    # Error Check
    if @ProductName == nil
      $ERROR_CNT += 1
      printf("\n@E: Cannot get ProductName information.\n")
      Common.print_summary
      exit 1
    end
    if @Version == nil
      $ERROR_CNT += 1
      printf("\n@E: Cannot get Version information.\n")
      Common.print_summary
      exit 1
    end

    return self
  end
end

class CSVPinInf
  # Row number in Excel
  attr_reader :Row
  # Identifier
  attr_reader :Id
  # Connector No in Excel
  attr_accessor :ConnectorNo      
  # PinNo in Excel
  attr_accessor :PinNo        
  # Bank
  attr_reader :Bank
  # FPGASignal in Excel
  attr_accessor :FPGASignal       
  # define_attribute { XXX } xc_loc { ZZZ }
  attr_accessor :PinLocAttribute  
  # define_attribute { XXX } xc_pulldown/pullup { 1 }
  attr_reader :PinPullAttribute 
  # UCF Buffer Type  : NET "XXX" IOSTANDARD = LVCMOS33;
  attr_reader :UCFBufferType    
  # SDC Buffer Speed : define_attribute {XXX} xc_fast {1}
  attr_reader :SDCBufferSpeed
  # UCF Driver Strength
  attr_reader :UCFDriverStrength
  # output fixH_XXX = 1'b1
  attr_reader :FixedVerilog     
  # "XXX" TYPE "YYY"
  attr_reader :PinsInf          
  # "XXX" "XXX":terminal
  attr_reader :ConInf        
  # PULLDOWN: xxx YYY / NET: xxx XXX YYYY
  attr_reader :PullControl      

  # CSV Column
  A = 0
  B = 1
  C = 2
  D = 3
  E = 4
  F = 5
  G = 6
  H = 7
  I = 8
  J = 9
  K = 10
  L = 11
  M = 12
  N = 13
  O = 14
  P = 15
  Q = 16
  R = 17
  S = 18
  T = 19
  U = 20
  V = 21
  W = 22

  def initialize
    # For Output file
    @Row = 0
    @Id = 0
    @ConnectorNo = "-"
    @PinNo = "-"
    @Bank = nil
    @FPGASignal = nil
    @PinLocAttribute = nil
    @PinPullAttribute = nil
    @UCFBufferType = nil
    @SDCBufferSpeed = nil
    @UCFDriverStrength = nil
    @FixedVerilog = nil
    @PinsInf = nil
    @ConInf = nil
    @PullControl = nil
  end

  #
  #=== make method
  #
  #make Pin-Information from each row
  #
  # [num]
  #   line number
  # [row]
  #   each row in CVS file
  #
  # [return]
  #   CSVPinInf oneself
  #
  def make(num,row,file_type)
    # Judgmenet Japanese
    new_row = Array.new
    row.each do |r|
      if r.nil?
        new_row << r
      else
        if r =~ /([0-9a-zA-Z\-_ :#=';\/\.\(\)\"\[\]\{\}]*)/
          new_row << $1
        else
          new_row << r
        end
      end
    end
    row = new_row

    @Row = num
    case file_type
    when "CN"
      @ConnectorNo = row[A]
      @PinNo = row[C]
      @Bank = row[B]
      @FPGASignal = row[N]
      @PinLocAttribute = row[O]
      @PinPullAttribute = row[P]
      @UCFBufferType = row[Q]
      @FixedVerilog = row[R]
      @PinsInf = row[S]
    when "PULL"
      @PullControl = row[H]
      if @PullControl.nil?
        @PullControl = row[G]
      end
      if @PullControl.nil?
        $ERROR_CNT += 1
        printf("\n@E: Cannot get Pullup Control information.\n")
        Common.print_summary
        exit 1
      end
    when "CT"
      @Id = row[A]
      @Bank = row[C]
      @FPGASignal = row[O]
      @PinLocAttribute = row[P]
      @PinPullAttribute = row[Q]
      @UCFBufferType = row[R]
      @FixedVerilog = row[S]
      @ConInf = row[T]
      @SDCBufferSpeed = row[U]
      @UCFDriverStrength = row[V]
=begin
      @PinsInf = row[T]
      @ConInf = row[U]
      @SDCBufferSpeed = row[V]
      @UCFDriverStrength = row[W]
=end
    else
    end
    return self
  end

end

#
# Main Class
#
class GetCSV
  attr_reader :HeaderInf
  attr_reader :PinInf
  def initialize
    # Header Information
    @HeaderInf = nil
    # Pin Information
    @PinInf = Array.new      
    # Pull Information
    @PullInf = Array.new
    # CT Information
    @CTInf = Array.new
  end

  #
  # reader_CN
  # * get CSV data and save array
  #
  # [file_name]
  #   CSV File name for analyzing
  # [type]
  #   Connector info
  #
  def reader_CN(file_name)
    type = "CN"
    num = 1
    printf("@I:read %s ... ",file_name)
    CSV.open("#{file_name}","r").each{|row|
      # Skip Header
      if row[0] == "ProductName="
        obj = CSVHeaderInf.new
        @HeaderInf = obj.make(row)
      elsif /CN\d-/ =~ row[0] || /\d/ =~ row[0]
#      if row[0] != "CN"
          obj = CSVPinInf.new
          # Get Pin Information
          if obj.make(num,row,type) != nil
            @PinInf << obj.make(num,row,type) 
          end
#        end
      end
      num += 1
    }
    printf("Success\n")
    return @HeaderInf,@PinInf
  end

  #
  # reader_PULL
  # * get CSV data and save array
  #
  # [file_name]
  #   CSV File name for analyzing
  # [type]
  #   Pulldown/Pullup info
  #
  def reader_PULL(file_name)
    type = "PULL"
    num = 1
    already = Array.new
    printf("@I:read %s ... ",file_name)
    CSV.open("#{file_name}","r").each{|row|
      # Skip Header
#      if row.size == 8 && row[7] != nil && row[3] != nil && row[5] != nil        
      if ( /DIN\d+/ =~ row[7] || /^#/ =~ row[7] ) || ( /DIN\d+/ =~ row[6] || /^#/ =~ row[6] )
        next if row[0] == "LS"
        obj = CSVPinInf.new
        @PullInf << obj.make(num,row,type) 
        connect_path = obj.make(num,row,type).PullControl.split[1]
        if connect_path != "PULLDOWN" && connect_path != nil
          if already.index(connect_path) == nil
            already << connect_path
          else
            $WARNING_CNT += 1
            printf("\n@W:Found Multiple connection to PUCTL(%s),please check MkPin Excel File.\n",connect_path)
          end
        end
       end
      num += 1
    }
    printf("Success\n")
    return @PullInf
  end

  #
  # reader_CT
  # * get CSV data and save array
  #
  # [file_name]
  #   CSV File name for analyzing
  # [type]
  #   CT Info
  #
  def reader_CT(file_name)
    type = "CT"
    num = 1
    printf("@I:read %s ... ",file_name)
    CSV.open("#{file_name}","r").each{|row|
      # Skip Header
      if row[1] != nil && /IO_/ =~ row[1]
        obj = CSVPinInf.new
        # Get Pin Information
        if obj.make(num,row,type) != nil
          @CTInf << obj.make(num,row,type) 
        end
      end
      num += 1
    }
    printf("Success\n")
    return @CTInf
  end

end
