#!/usr/bin/ruby
#############################################################
#
#=PartsConv
#  
#Authors::   Koji HIJIKURO<koji.hijikuro.rj@rms.renesas.com>
#Copyright:: Copyright (c) 2009,2011 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
#==Function detail
#* make_chip Parts Converter
#
#==Usage
#%ruby PartsConv.rb --parts [parts.para] --main [main.para]
#
#
#############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "optparse"
require "fileutils"


#
# Global Setting
#
$SUB_TOOL        = "mkice" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
Version          = $VERSION # For OptParse


#
# Main Class
#
class PartsConv
  def initialize
    @PartsFile = nil
    @MainFile = nil

    @Env = Hash.new
    @FileList = Hash.new
  end

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  public
  def get_argument
    opt = OptionParser.new
    begin
      opt.on('--verbose',"verbose mode"){|v| $VERBOSE = true}
      opt.on('--parts parts file','parts file'){|v| @PartsFile = v}
      opt.on('--main main file','main file'){|v| @MainFile = v}
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:OP000:"#{$!}" 
#{opt.help}
EOB
      exit
      return false
    end
  end
  
  def parse_main
    open(@MainFile,"r").each{|line|
      next if line[0].to_i == 47 && line[1].to_i == 47
      line = line.gsub("\t"," ").gsub("\n","")
      if /SET:/ =~ line
        tmp = line.split
        @Env["#{tmp[1]}"] = tmp[2]
      end
    }
    new_env = Hash.new
    @Env.each{|key,value|
      value = spread_env(value)
      new_env["#{key}"] = value
    }
    @Env = new_env
  end

  def spread_env(str)
    while (/\$\{(\w*)\}/ =~ str ) != nil
      env = $1
      value = @Env["#{env}"]
      if value != nil
        str = str.gsub("\$\{#{env}\}","#{value}")
      else
        p str
        p "error"
        exit
      end
    end
    return str
  end

  def parse_para
    ins_flag = false
    module_name = nil
    file_list = Array.new
    open(@PartsFile,"r").each{|line|
      next if line[0].to_i == 47 && line[1].to_i == 47
      line = line.gsub("\t"," ").gsub("\n","")
      next if line == ""
      tmp = line.split
      case tmp[0]
      when "INS:"
        module_name = tmp[2]
        ins_flag = true
        file_list = Array.new
      when "END_INS:"
        @FileList["#{module_name}"] = file_list
        ins_flag = false
      else
        if ins_flag
          next if File.extname("#{tmp[2]}") == ".db"
          file_list << spread_env(tmp[2])
        end
      end
    }
  end

  def generate
    file_name = "filelist.txt"
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    @FileList.each{|key,value|
#      f.printf("%s:",key)
      printf("Copy\n")
      FileUtils.install("#{value[0]}","_src_tmp/#{key}.v")
#      value.each{|file_name|
#        f.printf("%s ",file_name)
#      }
      f.printf("\n")
    }
    f.close
  end

  def main
    get_argument
    parse_main
    parse_para
    generate
  end
end


#
# Execute
#
if __FILE__ == $0
  pconv = PartsConv.new
  pconv.main
end
