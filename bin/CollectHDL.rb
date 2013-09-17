#!/usr/bin/ruby
#############################################################
#
# CollectHDL
#  - Collect HDL files from library information
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@necel.com>
#
############################################################
#
# [OPERATION]
#
# [USAGE]
#  %libanalize.rb -lib <LibFile> -outdir <OutputDirectory> -list <ListFile>
#
# [EXAMPLE]
#
# [OUTPUT]
#  - _src/{HDL Files}
#
###################################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"
require "fileutils"
require "synthesis"

$SUB_TOOL       = "CollectHDL"
Version    = $VERSION

$LIB_FILE   = nil
$TOP_FILE   = nil
$PROJECT    = nil
$TOP_MODULE = nil   # = $PROJECT

$SRC        = "_src"
$LIST       = "HDL.lst"

# For synthesis
$WORK_DIR   = "work"
$FILE       = Array.new

$ERROR_CNT   = 0
$WARNING_CNT = 0

class CollectHDL
  #
  # initialize
  #
  def initialize
    @FileData = Array.new
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
    printf("Usage :  %s.rb  -lib <LibFile> -outdir\n",$TOOL)
    printf(" OPTION\n")
    printf("    -h/-help      : print help message\n")
    printf("    -v/-version   : print version\n")
    printf("    -lib [Lib]    : make_chip library file\n")
    printf("    -outdir [dir] : HDL output directory(default:./src)\n")
    printf("    -list [List]  : List file(default:%s)\n",$LIST)
    printf("    -verbose      : execute on verbose mode\n")
    printf("    \n")
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
      when '-lib' then
        $LIB_FILE = ARGV[i+1]
        i += 1
      when '-outdir' then
        $SRC = ARGV[i+1]
        i += 1
      when '-list' then
        $LIST = ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        end
      end 
    end      

    # Argument Check
    if $LIB_FILE == nil
      $ERROR_CNT += 1
      printf("@E:Option setting is not enough\n")
      print_usage
      Common.print_summary
      exit
    end

  end

  def read
    @FileData = Common.file_read("#{$LIB_FILE}")
  end
  
  def analize
    f = File.open("#{$LIST}","w")
    # Copy LIB_FILE
    @FileData.each{|line|
      if /^`include/ =~ line
        /\"(.*)\"/ =~ line
        target = $1

        # If the file name is "*.include*"
        if /.*\.include.*$/ =~ target
          printf("@I:Found include file, so this file is progresed\n")
          include_file = Array.new
          include_file = Common.file_read("#{target}")
          include_file.each{|line2|
            if /include/ =~ line2
              /\"(.*)\"/ =~ line2
              target2 = $1
              # Copy file
              if File::exists?(target2) == true
                printf("Copied %s\n",target2)
                f.printf("%s\n",target2)
                FileUtils::install(target2,$SRC + "/" + File.basename(target2), :mode=> 0700)
                $FILE << "../" + $SRC + "/" + File.basename(target2)
              end
            end
          }
          printf("@I:sub include file operation end\n")
        else
          # Copy file
          if File::exists?(target) == true
            printf("Copied %s\n",target)
            f.printf("%s\n",target)
            FileUtils::install(target,$SRC + "/" + File.basename(target), :mode=> 0700)
            $FILE << "../" + $SRC + "/" + File.basename(target)
          else
            printf "@E:Canno copy file #{target}"
            $ERROR_CNT += 1
            Common.print_summary
          end
        end
      end
      $FILE.uniq! 
    }
    f.close
  end

  #
  # main
  #
  def main
    get_argument
    Common.print_base
    Common.make_dir("#{$SRC}")
    Common.make_dir("#{$WORK_DIR}")
    read
    analize
    Common.print_summary
  end
end

collect = CollectHDL.new
collect.main
