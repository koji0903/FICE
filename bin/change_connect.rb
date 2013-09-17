##################################################################
#
#  change connect
#
#  Function : analize connect file and modify it
#
#  Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#  Date     : Dec 15, 2009
#
###################################################################
#
# [USAGE]
#   Modify connect file using connect.inf infromation
#   
# [INPUT FILE(s)]
#   - <Inf file>     : changing information
#   - <Connect file> : Target connect file
#
# [OUTPUT FILE(s)]
#   - <Modified connect file> : Modifid connect file
#
###################################################################
require "common"

$TOOL    = "change_connect"
$VERSION = "0.1-beta"
$VERBOSE = false

$ERROR_CNT   = 0
$WARNING_CNT = 0
$NOTE_CNT    = 0


class ChangeConnect

  def initialize(filename="")
    @INFFile = nil
    @ConnectFile = nil

    @INFData = Array.new
    @ConnectData = Array.new

    @INF = Hash.new
    @NewConnect = Array.new
  end

  #
  # print ussage
  #
  def print_usage
    printf("\n")
    printf("Usage :ruby %s.rb -inf <Inf file> -connect <Connect file>\n",$TOOL)
    printf(" OPTION\n")
    printf("    -h/-help     : print help message\n")
    printf("    -v/-version  : print version\n")
    printf("    -verbose     : execute on verbose mode\n")
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
        Common.print_base
        print_usage
        exit
      when '-v','-version' then
        Common.print_base
        printf("")
        exit
      when '-verbose' then
        $VERBOSE = true
      when '-inf' then
        @INFFile = ARGV[i+1]
        i += 1
      when '-connect' then
        @ConnectFile = ARGV[i+1]
        i += 1
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        end
      end
    end 

    # Check Argument
    check_argument
    
    # Check File
    check_file

  end

  #
  # CheckArgument
  #
  def check_argument
    $ERROR_CNT += Common.chk_argument("-inf",@INFFile)
    $ERROR_CNT += Common.chk_argument("-connect",@ConnectFile)
    error if $ERROR_CNT != 0
  end
  
  #
  # CheckFile
  #
  def check_file
    $ERROR_CNT += Common.chk_file("Inf",@INFFile)
    $ERROR_CNT += Common.chk_file("Connect",@ConnectFile)
    error if $ERROR_CNT != 0
  end
  
  #
  # read
  #
  def read
    @INFData = Common.file_read("#{@INFFile}")
    @ConnectData = Common.file_read("#{@ConnectFile}")
  end
  
  #
  # analize inf
  #
  def analize_inf
    @INFData.each{|line|
      line = Common.remove_after(line,"//") # delete line
      line = line.gsub("\t",""); line = line.gsub("\s","")
      next if line == ""
      tmp = line.split(",")
      @INF["#{line}"] = tmp
    }
  end

  #
  # operation
  #
  def operation
    @ConnectData.each{|line|
      new_line = ""
      if /^\s*NET:/ =~ line
        /^\s*NET:\s*(\S*)\s*(\S*)\s*(\S*)/ =~ line
        str = $1 + "," + $2 + "," + $3
        if @INF.key?(str) == true
          new_line = "//" + line + "  // modified by " + $TOOL
        else
          new_line = line
        end
      else
        new_line = line
      end
      @NewConnect << new_line
    }
  end

  #
  # gen_connect
  #
  def gen_connect
    file_name = @ConnectFile
    printf("@I:generate %s\n",@ConnectFile)
    f = open("#{file_name}","w")
    @NewConnect.each{|line|
      f.printf("%s\n",line)
    }
    f.close
  end


  #
  #
  # Error operation
  #
  def error
    print_usage
    Common.print_summary
    exit 1
  end

  
  #
  # main
  #
  def main
    get_argument
    read
    analize_inf
    operation
    gen_connect
    Common.print_summary
  end

end

cc = ChangeConnect.new
cc.main
