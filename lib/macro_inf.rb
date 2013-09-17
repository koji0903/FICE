##################################################################
#
#  macro inf
#
#  Function : analize macro.inf and return MacroInfo
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
#   - macro.info file save in Macro Database
#
# [OUTPUT FILE(s)]
#   - CONFInfo through accessor
#
###################################################################
require "common"

class MACRO
  attr_accessor :ModuleName
  attr_accessor :FileName
  attr_accessor :Parts
  def initialize 
    @ModuleName = nil
    @FileName = nil
    @Parts = nil
  end
end

class MacroInf

  attr_accessor :INFData

  def initialize(filename="")
    @INF_FILE = filename
    @INF_DATA = Array.new

    @INFData = Hash.new
  end

  def pre_operation
    @INF_DATA = Common.file_read(@INF_FILE)
    line_cnt = 0
    @INF_DATA.each{|line|
      inf_each = Array.new
      line_cnt += 1
      line = Common.remove_after(line,"//") # delete line
      line = line.gsub("\t",""); line = line.gsub("\s","")
      next if line == ""
      tmp = line.split(",")
      macro = MACRO.new
      macro.ModuleName = tmp[0]
      macro.FileName = tmp[1]
      tmp = tmp[2].split(":")

      case tmp[0]
      when "PARTS" then
        macro.Parts = tmp[1]
      when "SYN" then
      when "PAR" then
      else
        printf("@Internal error. (file:%s,line:%s)",__FILE__,__LINE__)
        exit 1
      end
      
      if @INFData.key?(macro.ModuleName)
        inf_each = Array.new
        inf_each = @INFData.fetch(macro.ModuleName)
        inf_each << macro
        @INFData["#{macro.ModuleName}"] = inf_each
      else
        inf_each << macro
        @INFData["#{macro.ModuleName}"] = inf_each
      end
    }
  end
  
  ######### MAIN #############
  def main
    printf("\nINF operation\n")
    pre_operation
  end

end
