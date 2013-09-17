#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-
$:.unshift(File.dirname(__FILE__) + "/../lib")

# add test code more

require 'FICE_def'
require "system"
require "common"
require 'sqlite3'

$SUB_TOOL = "SQLite4_test"
Common.print_base

# Regist
class SQLite3Base
  def initialize(db_name,table_name,item)
    @db_name = db_name
    @table = table_name
    @item = item
    
    @db = SQLite3::Database.new("#{@db_name}")    
    create
  end

  def create
    sql = "create table #{@table} ( "
    @item.each_with_index do |each_item,index|
      if index == @item.size - 1
        sql = sql + " #{each_item[0]} #{each_item[1]} #{each_item[2]}"
      else
        sql = sql + " #{each_item[0]} #{each_item[1]} #{each_item[2]},"
      end
    end
    sql = sql + ");"

    printf "@I:create following table in #{@db_name}\n"
    printf "   - DB Name : #{@db_name}\n"
    printf "   - Schema  : #{sql}\n"
    begin      
      @db.execute(sql)
    rescue
      printf "@I:Table(#{@table}) is already exist.\n"
    end
  end

  def regist(data)
    begin
      sql = "insert into #{@table} values (?,?,?,?)"
      data.each do |each_data|
        @db.execute(sql,each_data)
      end
    rescue
    end
  end

  def view
    # View
    printf "-------------------------\n"
    printf "DB Name : #{@db_name}\n"
    printf "Table   : #{@table}\n"
    printf "-------------------------\n"
    @db.execute("select * from #{@table}") do |row|
      p row
    end
  end

  def main
    create

    @product_data.each do |data|
      regist(@table,data)
    end

    view(@db,@table)
  end
  
  def db_close
    @db.close
  end
end


class RL78
  def initialize
    @db_name = "RL78.db"

    # [Value, Type, Constraint]
    @item = [
            ["ProductVersion","TEXT",""],
            ["HDLFileName","TEXT","UNIQUE"],
            ["XMLFileName","TEXT",""],
            ["md5sum","INTEGER",""]
           ]

  end

  def make_G13
    table = "G13"
        
    test = SQLite3Base.new(@db_name,table,@item)
    product_data = [
                    ['1.0','hdl/top.v','xml/top.xml',1234],
                    ['1.0','hdl/aaa.v','xml/aaa.xml',5678]
                   ]
    test.regist(product_data)
    test.view
    test.db_close    
  end

  def make_G14
    table = "G14"
    
    test = SQLite3Base.new(@db_name,table,@item)
    product_data = [
                    ['1.1','hdl/top.v','xml/top.xml',0x1234],
                    ['1.1','hdl/bbb.v','xml/bbb.xml',0x4352]
                   ]
    test.regist(product_data)
    test.view
    test.db_close
  end
end


rl78 = RL78.new
rl78.make_G13
rl78.make_G14


class ModuleBase
  def initialize(db_name)
    @db_name = db_name
    
    @base_table = [
                   ["HDLFileName","TEXT","UNIQUE"],
                   ["XMLFileNmae","TEXT","UNIQUE"],
                   ["md5sum","INTEGER","UNIQUE"]
                  ]
    
    @signal_table = [
                     ["SignalName","TEXT","UNIQUE"],
                     ["Direction","TEXT",""],
                     ["MSB","INTEGER",""],
                     ["LSB","INTEGER",""]
                    ]
  end
end
