######################################################################
#
# Operation for conf file
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#    Date     : 2009/07/30
#    Function : Refer to following HP
#       http://nqacs216.nms.necel.com/common_wiki/index.php?MakeChip#n39ed659
#
########################################################################
#
#  Class Name : Conf
#  
#  [Method]
#
#  [Data Structure]
#
########################################################################
require "message"

class MKICEConf < Message

  #
  # initialize
  #
  def initialize(readfile="ConfigurationFile")
    @read_file = readfile
    @FileData = []
  end

  #
  # read
  #
  def read
    begin
      printf("@I:Read parts file : %s\n",@read_file)
      f = open("#{@read_file}","r")
      while line = f.gets
        line = line.sub("\n","")
        @FileData << line
      end
    rescue => ex
      puts ex.message
      exit
    end  
  end

  #
  # analize
  #
  def analize
    read
    setting = ""
    @FileData.each do |line|
      line = line.gsub(" ","")  # delete space
      setting = line.split("=") # separator "="
      case setting[0]
      when "WORK_DIR" then
        if $VERBOSE == true;printf(" [WORK_DIR] %s\n",setting[1]);end
        $WORK_SET = true
        $WORK_DIR = setting[1]
      when "PARAMETER" then
        if $VERBOSE == true;printf(" [PARAMETER] %s\n",setting[1]);end
        $PARAMETER_SET = true
        $PARAMETER_FILE = setting[1]
      when "REPORT" then
        if $VERBOSE == true;printf(" [REPORT  ] %s\n",setting[1]);end
        $REPORT_SET = true
        $REPORT_FILE = setting[1]
      when "PARTS" then
        if $VERBOSE == true;printf(" [PARTS   ] %s\n",setting[1]);end
        $PARTS_SET = true
        $PARTS_FILE = setting[1]
      when "CONNECT" then
        if $VERBOSE == true;printf(" [CONNECT ] %s\n",setting[1]);end
        $CONNECT_SET = true
        $CONNECT_FILE = setting[1]
      else
      end
    end # @FileData.each
  end # analize
end
