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

class FMakeConf < Message

  #
  # initialize
  #
  def initialize(readfile="ConfigurationFile")
    @read_file = readfile
    @dir_name = ""
    @FileData = []
  end

  #
  # read
  #
  def read
    begin
      printf("@I:Read parts file : %s\n",@read_file)
      @dir_name =  Dir::pwd + "/" + File.dirname(@read_file)
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
      when "PROJECT" then
        if $VERBOSE == true;printf(" [PROJECT   ] %s\n",setting[1]);end
        $PROJECT = setting[1]
      when "FILE" then
        if $VERBOSE == true;printf(" [FILE      ] %s\n",setting[1]);end
        $FILE << setting[1] if setting[1] != nil
      when "SDC" then
        if $VERBOSE == true;printf(" [FILE      ] %s\n",setting[1]);end
        $SDC << setting[1] if setting[1] != nil
      when "TOP_MODULE" then
        if $VERBOSE == true;printf(" [TOP_MDULE ] %s\n",setting[1]);end
        $TOP_MODULE = setting[1]
      when "WORK_DIR" then
        if $VERBOSE == true;printf(" [WORK_DIR   ] %s\n",setting[1]);end
        $WORK_DIR = setting[1]
      when "TECHNOLOGY" then
        if $VERBOSE == true;printf(" [TECHNOLOGY] %s\n",setting[1]);end
        $TECHNOLOGY = setting[1]
      when "PART" then
        if $VERBOSE == true;printf(" [PART      ] %s\n",setting[1]);end
        $PART = setting[1]
      when "PACKAGE" then
        if $VERBOSE == true;printf(" [PACKAGE   ] %s\n",setting[1]);end
        $PACKAGE = setting[1]
      when "SPEED_GRADE" then
        if $VERBOSE == true;printf(" [SPEED_GRADE] %s\n",setting[1]);end
        $SPEED_GRADE = setting[1]
      when "FIX_GATED_CLOCK" then
        if $VERBOSE == true;printf(" [FIX_GATED_CLOCK] %s\n",setting[1]);end
        $FIX_GATED_CLOCK = setting[1]
      when "SYNTHESIS" then
        if $VERBOSE == true;printf(" [SYNTHESIS] %s\n",setting[1]);end
        $SYNTHESIS = setting[1]
      when "PLACE_AND_ROUTE" then
        if $VERBOSE == true;printf(" [PLACE_AND_ROUTE] %s\n",setting[1]);end
        $PLACE_AND_ROUTE = setting[1]
      else
      end
    end # @FileData.each
  end # analize
end
