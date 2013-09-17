#!/usr/bin/ruby
#############################################################
#
# gHier
#= gHier: Analize Hierarchy Information and generate report
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009,2010 NEC MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# -gHier is the FPGA-ICE development tool of the part of FICE-IDE.
# -gHier read hierarchy file which is hierarchy information file 
#  generated by Debussy, analized circuit categoly, generate summary report.
#
# [Usage]
# -%ruby gHier.by -hier [Hierarchy File]
# If you want to get more information. plese use "-h" option.
#
# [Output]
# -hier_inf.txt
#
# [History]
# - 0.4.xxx New Release
#
#############################################################
require "FICE_def"
require "system"
require "common"

#
# Global Setting
#
$TOOL            = "gHier" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$MESSAGE         = false



#
# Main Class
#
class GHier

  # 
  # for the information of the each line 
  #
  class EachLine
    attr_accessor :Message
    attr_accessor :InstName
    attr_accessor :ModuleName
    def initialize
      @Message = nil
      @InstName = nil
      @ModuleName = nil
    end
  end
    
  #
  # for the database saving the informatin for the report.
  #
  class DB
    attr_accessor :Num
    attr_accessor :EachLine
    attr_accessor :ModuleList
    attr_accessor :UniqModuleNum
    def initialize
      @Num = 0
      @EachLine = Array.new
      @ModuleList = Array.new
      @UniqModuleNum = 0
    end
  end
  
  def initialize
    @HIER  = nil
    @HIER_DATA = Array.new

    @ALL_DATA = {
      "A"         => ["Architecture",DB.new],
      "M"         => ["Module",DB.new],
      "F"         => ["Function",DB.new],
      "FU"        => ["Unused Function",DB.new],
      "C"         => ["Procedure",DB.new],
      "CU"        => ["Unused Procedure",DB.new],
      "T"         => ["Task",DB.new],
      "TU"        => ["Unused Task",DB.new],
      "FI"        => ["Function inherit from parent",DB.new],
      "FIU"       => ["Unused Function inherit from parent",DB.new],
      "TI"        => ["Task inherit from parent",DB.new],
      "TIU"       => ["Unused Task inherit from parent",DB.new],
      "ATI"       => ["Automatic Task inherit from parent",DB.new],
      "ATIU"      => ["Automatic Unused Task inherit from parent",DB.new],
      "AT"        => ["Automatic Task",DB.new],
      "ATU"       => ["Unused Automatic Task",DB.new],
      "N"         => ["Name block",DB.new],
      "P"         => ["Package",DB.new],
      "G"         => ["Library/Primitive",DB.new],
      "B"         => ["Undefined",DB.new],
      "U"         => ["User-defined/Macro",DB.new],
      "I"         => ["Instance array",DB.new],
      "D"         => ["Pureview memory module",DB.new],
      "SUBPROG_SET"     => ["Sub-program set",DB.new],
      "BLOCK_SET"       => ["Name-block Set",DB.new],
      "PB"              => ["Program Block",DB.new],
      "CLASS"           => ["Class",DB.new],
      "PSL_ASSERT"      => ["PSL assert",DB.new],
      "PSL_COVER"       => ["PSL cover",DB.new],
      "PSL_ASSUME"      => ["PSL assume",DB.new],
      "SVA_BIND"        => ["SVA bind",DB.new],
      "SVA_ASSERT_SET"  => ["SVA assertion set",DB.new],
      "SVA_ASSERT_PRO"  => ["SVA assert property",DB.new],
      "SVA_PROP"        => ["SVA property",DB.new],
      "SVA_SEQ"         => ["SVA sequence",DB.new],
      "SVA_COVER"       => ["SVA cover property",DB.new],
      "SVA_ASSUME"      => ["SVA assume property",DB.new],
    }
  end


  #
  # Print Tool Usage
  #
  private
  def print_usage
    printf("\n")
    printf("Usage :  %s.rb -hier hier.file\n",$TOOL)
    printf(" OPTION\n")
    printf("    \n")
  end

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  private
  def get_argument
    size = ARGV.size
    size -= 1
    for i in 0..size
      case ARGV[i]
      when '-h','-help' then
        Common.print_base
        print_usage
        exit
      when '-v','-version' then
        Common.print_base
        printf("")
        exit
      when '-verbose' then
        $VERBOSE = true
      when '-hier' then
        @HIER = ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        end
      end
    end 

    if @HIER == nil
      $ERROR_CNT += 1
      printf("@E:\"SDC NAME\" is not specified.\n")
      print_usage
      error
    end
    
    if Common.chk_file("-hier",@HIER) == true
      $ERROR_CNT += 1
      printf("@E:\"\" file doesnt find.\n",@HIER)
      print_usage
      error
    end
  end
  

  #
  # Analize each line and operate each identifier.
  #
  private
  def analize
    @HIER_DATA.each{|line|
      line = line.strip
      id = line.split(":")[0] 
      next if id == nil
      case id 
      when "A" then
        printf("%s\n",line)
      when "M" then
        @ALL_DATA["#{id}"][1].EachLine << get_InstName_ModuleName(line)
      when "F" then
        printf("%s\n",line)
      when "FU" then
        printf("%s\n",line)
      when "C" then
        printf("%s\n",line)
      when "CU" then
        printf("%s\n",line)
      when "T" then
        # now skip
      when "TU" then
        printf("%s\n",line)
      when "FI" then
        printf("%s\n",line)
      when "FIU" then
        printf("%s\n",line)
      when "TI" then
        printf("%s\n",line)
      when "TIU" then
        printf("%s\n",line)
      when "ATI" then
        printf("%s\n",line)
      when "ATIU" then
        printf("%s\n",line)
      when "AT" then
        printf("%s\n",line)
      when "ATU" then
        printf("%s\n",line)
      when "N" then
        # now skip
      when "P" then
        printf("%s\n",line)
      when "G" then
        @ALL_DATA["#{id}"][1].EachLine << get_InstName_ModuleName(line)
      when "B" then
        @ALL_DATA["#{id}"][1].EachLine << get_InstName_ModuleName(line)
      when "U" then
        # now skip
      when "I" then
        printf("%s\n",line)
      when "D" then
        printf("%s\n",line)
      when "SUBPROG_SET" then
        printf("%s\n",line)
      when "BLOCK_SET" then
        printf("%s\n",line)
      when "PB" then
        printf("%s\n",line)
      when "CLASS" then
        printf("%s\n",line)
      when "PSL_ASSERT" then
        printf("%s\n",line)
      when "PSL_COVER" then
        printf("%s\n",line)
      when "PSL_ASSUME" then
        printf("%s\n",line)
      when "SVA_BIND" then
        printf("%s\n",line)
      when "SVA_ASSERT_SET" then
        printf("%s\n",line)
      when "SVA_ASSERT_PRO" then
        printf("%s\n",line)
      when "SVA_PROP" then
        printf("%s\n",line)
      when "SVA_SEQ" then
        printf("%s\n",line)
      when "SVA_COVER" then
        printf("%s\n",line)
      when "SVA_ASSUME" then
        printf("%s\n",line)
      else
      end
    }
  end
  
  #
  # Sub function. Get "Instance Name and ModuleName" from each line
  #
  private
  def get_InstName_ModuleName(line)
    each = EachLine.new
    each.InstName = line.split[1]
    each.ModuleName = line.split[2].sub("(","").sub(")","") if line.split[2] != nil
    return each
  end
  
  #
  # Sub function. Calucurate the number of each identifier
  #
  private
  def cal_each_attribute
    @ALL_DATA.each{|key,value|
      # calucurate number
      value[1].Num = value[1].EachLine.size
      # save all ModuleName
      value[1].EachLine.each{|line|
        value[1].ModuleList << line.ModuleName
      }
      value[1].UniqModuleNum = value[1].ModuleList.uniq.size
    }
  end

  #
  # Generate report file
  #
  private
  def generate_report
    file_name = "hier.txt" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Hierarchy report from Debussy hier file" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")   
    f.printf("\n")
    f.printf("### Global Summary ###\n\n\n")
    @ALL_DATA.sort_by{|key,value|
      -value[1].Num
    }.each{|key,value|
      if value[1].Num != 0
        f.printf("\n")
        f.printf("%s:\n",value[0])
        f.printf(" total number : %5d\n",value[1].Num)
        f.printf(" uniq  number : %5d\n",value[1].UniqModuleNum)
      end
    }

    f.printf("\n\n\n")
    f.printf("### ModuleName Summary ###\n\n")
    @ALL_DATA.sort_by{|key,value|
      -value[1].Num
    }.each{|key,value|
      if value[1].Num != 0
        f.printf("# %s\n",value[0])
        f.printf(" uniq  number : %5d\n",value[1].UniqModuleNum)
        f.printf(" module list :\n")
        value[1].ModuleList.uniq.each{|each_module|
          f.printf("    %s\n",each_module)
        }
      f.printf("\n\n")
      end
    }
    f.printf("\n")
    f.close
  end

  #
  # Main Function
  #  1. Get argument from execute option.
  #  2. Read hierarchy file
  #  3. Analize hier file
  #  4. Calucuarte the number of each identifier
  #  5. Generate report file
  #
  public
  def main
    get_argument
    @HIER_DATA = Common.file_read(@HIER)
    analize
    cal_each_attribute
    generate_report
    Common.print_summary
  end
  
end


if __FILE__ == $0
  aries = GHier.new
  aries.main
end