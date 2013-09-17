########################################################################
#
# Operation for analizing PinList(ICE original format)
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#    Date     : 2009/12/08
#    Function : 
#
########################################################################
#
#  Class Name : PinList
#   usage : InstanceName PinList(PinList_FileName)
#
#  [Method]
#
#  [Data Structure]
#
########################################################################
require "message"
require "common"

#
# Data Structure for Pin
# that is created by report file
#
class PinInfo
  attr_accessor   :LineNo
  attr_accessor   :SignalName
  attr_accessor   :Direction
  attr_accessor   :InstPinName
  attr_accessor   :InstName
  attr_accessor   :PinName
  attr_accessor   :Judge
  def initialize
    @LineNo     = nil
    @SignalName = nil
    @Direction  = nil
    @InstPinName = nil
    @InstName   = nil
    @PinName    = nil
    @Judge      = "---"
  end
end

class PinList < Message

  attr_accessor :PinData
  attr_accessor :PinData_pin
  #
  # initialize
  #
  def initialize(readfile="")
    printf("\nPinList Operation\n")
    # init
    @read_file = readfile

    # for internal operation
    @PinListData = Array.new
    @PinData = Hash.new
    @PinData_pin = Hash.new
  end

  #
  # read
  #
  def read
    @PinListData = Common.file_read(@read_file)
#    @PinListData.each{|line|
#      p line
#    } if $VERBOSE
  end

  #
  # analize
  #
  def analize
    # Data modify
    tmp1 = Array.new # [line.data]
    tmp2 = Array.new # [tmp1]
    line_cnt = 1
    @PinListData.each{|line|
      line = line.gsub("\t"," ")   # convert from "\t" to space
      if /\w+/ =~ line             # pick-up effective line
        if /\/\// =~ line          # include comment
          /^([\w\s.,:]*)\/\// =~ line
          tmp1 = Array.new
          {tmp1 << line_cnt, tmp1 << $1.gsub("\s","")}if $1.size != 0 # remove space
          tmp2 << tmp1 if tmp1[1].to_s.size != 0
        else
          tmp1 = Array.new
          {tmp1 << line_cnt, tmp1 << line.gsub("\s","")} if line.size != 0 # remove space
          tmp2 << tmp1 if tmp1[1].to_s.size != 0
        end
      end      
      line_cnt += 1
    }
    
    # update array
    @PinListData = tmp2


    # check duplicate
    error_message = Array.new
    @PinListData.each{|a|
      tmp2.delete(a)
      tmp2.each{|b|
        if a[1] == b[1]
          $ERROR_CNT += 1
          error_message << "@E:Duplicate pins " + a[1].to_s + "(line:" + b[0].to_s + "," + a[0].to_s + ")"
        end
      }
      tmp2 << a
    }
    if error_message.size != 0
      error_message.each{|mes|
        p mes
      }
      Common.print_summary
    end

  end

  #
  # def make_pindata
  #
  def make_pindata
    @PinListData.each{|line|
      if /,/ =~ line[1] # Include direction setting
        /^(\w*):(\w*),(\w*).(\w*)/ =~ line[1]
        if ($1 == "" || $2 == "" || $3 == "" || $4 == "")
          $ERROR_CNT += 1
          printf("@E: Unrecognized line.([L:%d]%s)",line[0],line[1])
          Common.print_summary
          exit
        end
        pininfo = PinInfo.new
        pininfo.LineNo     = line[0]
        pininfo.SignalName = $1.to_s
        pininfo.Direction  = $2.to_s
        pininfo.InstName   = $3.to_s
        pininfo.PinName    = $4.to_s
        pininfo.Judge      = "New   "
        pininfo.InstPinName = pininfo.InstName + "." + pininfo.PinName
        @PinData["#{pininfo.InstPinName}"] = pininfo
        @PinData_pin["#{pininfo.PinName}"] = pininfo
      else # PinName only
        /^(\w*).(\w*)/ =~ line[1]
        if ($1 == "" || $2 == "")
          $ERROR_CNT += 1
          printf("@E: Unrecognized line.([L:%d]%s)\n",line[0],line[1])
          Common.print_summary
          exit
        end
        pininfo = PinInfo.new
        pininfo.LineNo     = line[0]
        pininfo.InstName   = $1.to_s
        pininfo.PinName    = $2.to_s
        pininfo.InstPinName = pininfo.InstName + "." + pininfo.PinName
#        printf("@I:InstName-%s,PinName-%s([L:%d]%s)\n",pininfo.InstName,pininfo.PinName,line[0],line[1])
        @PinData["#{pininfo.InstPinName}"] = pininfo
        @PinData_pin["#{pininfo.PinName}"] = pininfo
      end
    }
  end
  
  #
  # def main
  #
  def main
    read
    analize
    make_pindata
  end

end
