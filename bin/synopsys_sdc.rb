#!/usr/bin/ruby
############################################################
#
# Analize Synopsys SDC File
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@necel.com>
#  File       : synopsys_sdc.rb
#  Date       :
#  Version    :
#
############################################################
#
# [Function]
#
#
############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "message"

$SDC_DIR = "scr"

class SyopsysSDC < Message

  def initialize
    @BASE_DIR = Dir::pwd + "/" + $SDC_DIR 
    @SDC_DIR = @BASE_DIR + "/*.*"
    @file_name = ""
    @SDCData = Hash.new
  end
  
  #
  # File read
  #
  def read
    printf("@I:Read all Syopsys SDC files in %s directory.\n",@BASE_DIR)
    Dir::glob("#{@SDC_DIR}").each{|file|
      @FileData = Array.new
      f = open("#{file}","r")
      while line = f.gets
        line = line.sub("\n","")
        @FileData << line
      end
      @file_name = File::basename("#{file}")
      @SDCData["#{@file_name}"] = @FileData
    }
  end

  #
  # Analize
  #
  def analize
    @SDCData.each_pair{|key, value|
      printf("\n*******[%s]*************************************************\n\n",key)
      value.each{|line|
        words = line.split(" ")
        if /#/ =~ words[0]; next; end # skip comment line 
        if line.size == 0; next; end  # skip no entry
        if /echo/ =~ words[0]; next; end # skip echo line 
        # search set line
        if /^set/ =~ words[0]
         printf("%s\n",line)
        end
      }
    }
  end
end

sdc = SyopsysSDC.new
sdc.read
sdc.analize
