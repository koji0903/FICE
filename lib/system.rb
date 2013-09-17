############################################################
#
# SYSTEM
#
#  Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#  Date     : 2009/07/15
#
############################################################
#
# [Function]
#   - get_argument
#         param   : void
#         return  : void
#         func    : get parameter from prompt
#
############################################################

require "message"

class System < Message

  def exe_info
    printf("\n");
    printf("Execute Information\n")
    printf("./%s.rb\n",$TOOL);
    printf(" [OPTION   ]:")
    ARGV.each do |arg|
      printf("%s",arg)
    end
    printf("\n")
    printf(" [VERBOSE  ]:");if $VERBOSE == true;printf("on\n");else;printf("off\n");end; 
    printf(" [WORK DIR ]:");if $WORK_SET == true;printf("%s\n",$WORK_DIR);else;printf("%s(use defult setting)\n",$WORK_DIR);end; 
    printf(" [PARAMETER]:");if $PARAMETER_SET == true;printf("%s\n",$PARAMETER_FILE);else;printf("%s(use defult setting)\n",$PARAMETER_FILE);end; 
    printf(" [REPORT   ]:");if $REPORT_SET == true;printf("%s\n",$REPORT_FILE);else;printf("%s(use defult setting)\n",$REPORT_FILE);end; 
    printf(" [PARTS    ]:");if $PARTS_SET == true;printf("%s\n",$PARTS_FILE);else;printf("%s(use defult setting)\n",$PARTS_FILE);end; 
    printf(" [CONNECT  ]:");if $CONNECT_SET == true;printf("%s\n",$CONNECT_FILE);else;printf("%s(use defult setting)\n",$CONNECT_FILE);end; 
    printf("\n");
  end

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
      when '-all' then
        $CONF_ALL = true
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        else
          $CONF_FILE = ARGV[i]
        end
      end
    end 

    #check
    if $CONF_FILE == "" && $CONF_ALL == false
      $ERROR_CNT += 1
      printf("@E:sys00 - please set Configuration file\n")
      print_usage
      print_summary
      exit
    end
  end

  def make_workdir
    printf("Make working direcory\n")
    current_path = Dir.pwd
    work_path = current_path + "/" + $WORK_DIR
    if FileTest::directory?(work_path) == false
      Dir::mkdir(work_path,0700)
      printf("@I:Make working direcory (%s)\n",work_path)
    else
#      printf("@N:Assigment working direcory(%s) is already exist. \n",work_path)
#      $NOTE_CNT += 1
    end
    $WORK_DIR = work_path
  end
  
  def make_dir(dir_name)
    current_path = Dir.pwd
    work_path = current_path + "/" + dir_name
    if FileTest::directory?(work_path) == false
      Dir::mkdir(work_path,0700)
      printf("@I:Making working direcory (%s)\n",work_path)
    end
  end
end
