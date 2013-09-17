#!/usr/bin/ruby
#############################################################
#
# FList
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009-2012 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Generate List file for FMake
#
# [Usage]
# -%ruby FList.rb --dev_list_dir [A:B] --old_path [Path] --new_path [Path] --o [Output File Name] 
# If you want to get more information. plese use "--help" option.
#
# [EXAMPLE]
# -example
#
# [Output]
# -filename
#
# [History]
# -history
#
#############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"
require "optparse"
require "FICE_DB"
require "kconv"
require "nkf"
require "pp"

CODES = {
  NKF::JIS      => "JIS",
  NKF::EUC      => "EUC",
  NKF::SJIS     => "SJIS",
  NKF::BINARY   => "BINARY",
  NKF::UNKNOWN  => "Unknows",
  NKF::ASCII    => "ASCII",
  NKF::UTF8  	=> "UTF-8",
  NKF::UTF16    => "UTF-16",
}


#
# Global Setting
#
$SUB_TOOL        = "FList" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
Version          = $VERSION # For OptParse
$TEST_MODE = false


#
# Main Class
#
class FList
  
  def initialize
    @DevListDir = nil
    @OldPath = nil
    @NewPath = nil
    @OutFile = nil
    @def_files = Array.new
    @def_files_next = Array.new
    @IgnoreDefine = false

    @V2XML_define_opt = "--dry-run"

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
      opt.on('--ignore-define',"Ignore Check define(FPGA_ICE)"){|v| @IgnoreDefine = true}
      opt.on('--dev_list_dir [Dir]','Device List file directory'){|v| @DevListDir = v.split(",")}
      opt.on('--old_path [Path]','Old File Path'){|v| @OldPath = v}
      opt.on('--new_path [Path]','New File Path'){|v| @NewPath = v}
      opt.on('--o [Output]','output file name'){|v| @OutFile = v}
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:Not support  "#{ARGV}" option or need argument using this option.
EOB
      return false
    end

    # Error Check
    if @DevListDir.nil? || @OldPath.nil? || @NewPath.nil? || @OutFile.nil?
      $ERROR_CNT += 1
      print "[Option]\n"
      print ARGV
      print "\n"
      print "@E: You must describe \"--dev_list_dir/--old_path/--new_path/--o\" options.\n"
      Common.print_summary
      exit 1
    end
    return true
  end
  
  #
  # Collect Device List Files
  #   param : Dir Name(Array)
  #   ret   : Files(Array)
  #
  def collect_files(dir_list)
    files = Array.new
    dir_list.each do |dir_name|
      files += Dir::glob("#{dir_name}/*")
    end
    files
  end

  #
  # Make List
  #
  def make_list(files,data=Array.new)
#    data = Array.new
    files.each do |file|
      print "@I:read #{file}\n"
      ext =  File.extname("#{file}")
      if ext == ".def"
        print "-recognized : Def File( print THIS file name in List File )\n"
        @def_files << file
      elsif ext == ".txt"
        print "-recognized : Text File( Skip this file )\n"
      else
        print "-recognized : List File\n"
#        data += open(file).readlines
        file = file.strip
        if File.readable?(file)
          open(file).readlines.each do |line|
            line = line.strip
            if File.extname(line) == ".list"
#              print "-recognized : List File Nest\n"
              if File.readable?(line)
                data = make_list([line],data)
              else
                data = make_list(modify_list([line]),data)
              end
            else
              data << line
            end
          end
        else
          $ERROR_CNT += 1
          print "@E:Cannot read \"#{file}\". \n"
          Common.print_summary
          exit 1
        end
      end
    end
    data
  end

  #
  # Modify List
  #
  def modify_list(list)
    hard_files = Array.new

    list_new = Array.new
    list.each do |file_name|
      if /\.def\n*$/ =~ file_name
        # Search *.def File
        @def_files << file_name        
      elsif /_def/ =~ file_name
        @def_files_next << file_name
      elsif /-y/ =~ file_name || /-NWCELL/ =~ file_name    
        print "@I:Delete Line:\" #{file_name.chomp}\"\n"
      elsif /-v/ =~ file_name
        hard_files << file_name.sub("-v","").strip + "\n"
      else
        # Other
        list_new << file_name if file_name != "" && file_name.strip.size != 0
      end
    end
    list = @def_files + @def_files_next + list_new + hard_files

    # Change Path
    list_new = Array.new
    list.each do |file_name|
      if /\.def\n*$/ =~ file_name
        if FileTest.readable?(file_name)
          list_new << file_name
        else
          list_new << file_name.sub("#{@OldPath}","#{@NewPath}")
        end
      else
        list_new << file_name.sub("#{@OldPath}","#{@NewPath}")
      end
    end
    list_new
  end
  #
  # Main Function
  #  1. 
  #  2. 
  #
  public
  def main
    Common.print_base
    get_argument

    print <<EOF
[Input Information]
Device List File Directory : #{@DevListDir}
File Old Path              : #{@OldPath}
File New Path              : #{@NewPath}
Output File Name           : #{@OutFile}

Start Operation ...

EOF

    # Collect Device List Files
    files = collect_files(@DevListDir)
    # Make List
    list = make_list(files)

    # Modify List
    mod_list = modify_list(list)

    # FPGA_ICE Flas
    fpga_ice = false


    # Check CPU Files
    v3_cnt = 0
    v4_cnt = 0
    mod_list.each do |line|
      file_name = File.basename(line.strip)
      if file_name == "QLK0RCPU0V4.v"
        v4_cnt += 1
      elsif /qlk0rcpueva0v4/ =~ file_name
        v4_cnt += 1
      elsif file_name == "QLK0RCPU0V3.v"
        v3_cnt += 1
      elsif /qlk0rcpueva0v3/ =~ file_name
        v3_cnt += 1
      end
    end


    # Check CPU
    new_mod = Array.new
    mod_list.each do |line|
      file_name = File.basename(line.strip)
      if file_name == "QLK0RCPU0V4.v"
        unless v4_cnt == 2
          $WARNING_CNT += 1
         printf "@W: Not Found HDL File for CPUEVA\n"
          printf "    FList add qlk0rcpueva0v4_111201.hdl in output list file automatically.\n"
          new_mod << "/home/product/div-micom-ice/data/proj/RL78/Common/EvaCoreMacro/qlk0rcpueva0v4_111201.hdl" 
        end
      elsif file_name == "QLK0RCPU0V3.v"
        unless v3_cnt == 2
          $WARNING_CNT += 1
         printf "@W: Not Found HDL File for CPUEVA\n"
          printf "    FList add qlk0rcpueva0v3_101216.hdl in output list file automatically.\n"
          new_mod << "/home/product/div-micom-ice/data/proj/RL78/Common/EvaCoreMacro/qlk0rcpueva0v3_101216.hdl" 
        end
      else
        new_mod << line
      end
    end
    mod_list = new_mod


    # Check "`define FPGA_ICE"
    mod_list.each do |line|
      line = line.chomp
      if FileTest.readable?(line)
        open(line).each do |str|
          # Def file
#          str = CODES[NKF.guess(str)]
          str = str.kconv(Kconv::SJIS,Kconv.guess(str))
          new_str = Common.remove_after(str,"\/\/")
          if /`define\s+FPGA_ICE$/ =~ new_str.strip
            fpga_ice = true
          end
        end if fpga_ice == false
      end
    end

    unless fpga_ice
      if @IgnoreDefine
        $WARNING_CNT += 1
        printf("@W:Not found \"`define FPGA_ICE\" in any files. Continue operation because \"--ignore-define\" option was set.\n")
      else
        $ERROR_CNT += 1
        printf("@E:Not found \"`define FPGA_ICE\" in any files. please add def-file in List.\n")
        printf("   If you do not need  \"`define FPGA_ICE\", Execute with \"--ignore-define\" option.\n")
        Common.print_summary
        exit 1
      end
    end

    # Generate
    f = open(@OutFile,"w")
    mod_list.each do |line|
      line = line.strip.chomp
      if FileTest.readable?(line)
        open(line).each do |str| 
          # Def file
          if File.extname("#{line}") == ".def" 
            str = CODES[NKF.guess(str)]
            new_str = Common.remove_after(str,"\/\/")
            if /`define\s+FPGA_ICE$/ =~ new_str.strip
              printf "@I: defined \"FPGA_ICE\" in #{line.strip} file.\n"
              printf "  Sentence : #{new_str}\n"
              fpga_ice = true 
            end
          end
        end if fpga_ice == false
        # db file
        if File.extname("#{line}") == ".db"
          $NOTE_CNT += 1
          printf "@N: Skip db file ( does not describe in List file ) - File:#{line}\n"
          next
        end
        f.printf("%s\n",line)
      else
        if File.extname(line) != ".list"
          # ignore comment & simulation option line
          if line.strip[0] != "#" && line[0] != "+" && line[0..1] != "//"
            $WARNING_CNT += 1
            print "@W:Cannot read \"#{line}\". skip this file .\n"
#            p line
#            exit
          else
            $NOTE_CNT += 1
            print "@N:Found igrored line \"#{line}\".\n"
          end
        else
          if line.strip[0] != "#"
            $ERROR_CNT += 1
            print "@E:Cannot read \"#{line}\". \n"
            Common.print_summary
          end
        end
      end
    end
    f.close
    print "\n\n@I:generate #{@OutFile}\n"


    Common.print_summary
  end
  
end


if __FILE__ == $0
  flist = FList.new
  flist.main
end
