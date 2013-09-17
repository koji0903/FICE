##################################################################
#
#  parts conf
#
#  Function : analize parts.conf and return conf info
#
#  Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#  Date     : Dec 11, 2009
#
###################################################################
#
# [USAGE]
#   No use only this script. It is for subfunction to analize 
#   parts.conf file
#   
# [INPUT FILE(s)]
#   - parts.conf file from instance
#
# [OUTPUT FILE(s)]
#   - CONFInfo through accesor
#
###################################################################
require "common"

class CONF_INFO
  attr_accessor :Identifier
  attr_accessor :ModuleName
  attr_accessor :ChangeName # if using macro need change, please set it
  def initialize 
    @Identifier = nil
    @ModuleName = nil
    @ChangeName = nil
  end
end

class PartsConf

  attr_accessor :CONFInfo

  def initialize(filename="")
    @CONF_FILE = filename
    @CONF_DATA = Array.new

    @CONFInfo = Hash.new
  end

  def pre_operation
    @CONF_DATA = Common.file_read(@CONF_FILE)
    line_cnt = 0
    @CONF_DATA.each{|line|
      line_cnt += 1
      line = Common.remove_after(line,"//") # delete line
      line = line.gsub("\t",""); line = line.gsub("\s","")
      next if line == ""
      tmp = line.split(",")
      if $1 == "" or $2 == ""
        printf("@E:[Line:%4d]\"%s\" is unrecognized\n",line_cnt,line)
        exit 1
      end
      conf_info = CONF_INFO.new
      conf_info.Identifier = tmp[0]
      conf_info.ModuleName = tmp[1]
      conf_info.ChangeName = tmp[2]
      @CONFInfo["#{conf_info.ModuleName}"] = conf_info
    }
  end
  
  ######### MAIN #############
  def main
    printf("\nPartsConf operation\n")
    pre_operation
  end

end
