#!/usr/bin/ruby

#############################################################
#
# FMake ( FPGA Maker )
#  - Synthesis      by Synplify Pro
#  - Place & Route  by Xilinx ISE
#
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@necel.com>
#  Date       : 2009/09/02
#  Version    : 0.1-beta
#
############################################################
#
# [Usage]
#   %FMake.rb [OPTION] ConfFile/<-all>
#   
#     OPTION
#        -h/-help     : print help message
#        -v/-version  : print version infomation
#        -all         : execute all files which is saved "conf" dir
#
############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "find"


$VERBOSE = nil
$ERROR_CNT = 0
$WARNING_CNT = 0
$NOTE_CNT = 0

class PickUpModule
  
  #
  # initialize
  #
  def initialize
    @src_path = nil
    @file_list = Array.new
    @src_data = Array.new

    @module_list = Array.new
  end

  #
  # print base
  #
  def print_base
    printf("%s ver:%s\n",$TOOL,$VERSION)
    printf("Copyright (c) 2009 NEC MicroSystem. All rights reserved.\n\n")
  end
  
  #
  # print ussage
  #
  def print_usage
    printf("\n")
    printf("Usage :  %s.rb [OPTION] -prj <Project Name> -scr_dir <SCR Dirctory>\n",$TOOL)
    printf(" OPTION\n")
    printf("    -h/-help     : print help message\n")
    printf("    -v/-version  : print version\n")
    printf("    -verbose     : execute on verbose mode\n")
    printf("    \n")
  end

  def print_summary
    printf("\n")
    printf("Execution summary\n")
    printf("   Note     : %3d\n", $NOTE_CNT)
    printf("   Warning  : %3d\n", $WARNING_CNT)
    printf("   Error    : %3d\n", $ERROR_CNT)
    printf("\n")
    if $ERROR_CNT == 0
      printf("%s finished in successfully.\n",$TOOL)
    else
      printf("%s finished with Errors. please check error message.\n",$TOOL)
    end
  end

  # 
  #  Get Argument
  #
  def get_argument
    size = ARGV.size
    size -= 1
    for i in 0..size
      case ARGV[i]
      when '-h','-help' then
        print_base
        print_usage
        exit
      when '-v','-version' then
        print_base
        printf("")
        exit
      when '-verbose' then
        $VERBOSE = true
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        else
          @src_path = ARGV[i]
        end
      end
    end 

    if @src_path == nil
      $ERROR_CNT += 1
      printf("@E:\"SRC DIRECTORY\" is not specified.\n")
      print_usage
      print_summary
      exit
    end
  end

  #
  # file_read
  #
  def file_read(file_name)
    printf("@I:read %s\n",file_name)
    file_data = Array.new
    begin
      f = open("#{file_name}","r")
      while line = f.gets
        line = line.sub("\n","") # Delete "\n" code
        file_data << line
      end
    rescue => ex
      puts ex.message
      exit
    end
#    p file_data
    return file_data
  end # def read


  #
  # read file
  #
  def read
    @file_list = search_file("#{@src_path}","*")
    @file_list.each{|fname|
      tmp1 = Array.new # [data]
      tmp1 = file_read("#{fname}")
      tmp2 = Array.new # [file,[data]]
      tmp2 << fname
      tmp2 << tmp1
      @src_data << tmp2
    }
  end

  #
  # search file
  #
  def search_file(dir=".",extension=nil)

    file_list = Array.new
    ext = "." + extension

    Find.find(dir){|path|
      if FileTest.directory?(path)
      else
        file_list << path
      end
=begin
      if extension == nil
        file_list << path
      else
        if File.extname("#{path}") == ext
          file_list << path
        end
      end
=end
    }
    return file_list
  end

  def analize
    @src_data.each{|line|
      line[1].each{|ll|
        if /module/ =~ ll
          next
        elsif /assign/ =~ ll
          next
        elsif /:/ =~ ll
          next
        elsif /\t\(/ =~ ll
          next
        elsif /if/ =~ ll
          next
        elsif /\w*\s+\w*\(/ =~ ll
          @module_list << ll
        end
      }
    }
  end

  def write
    f = open("k0r-fx4.mlist","w")
    @module_list.each{|m|
      f.printf("%s\n",m)
    }
    f.close
  end

  def main
    get_argument
    read
    analize
    write
  end

end

pm = PickUpModule.new
pm.main
