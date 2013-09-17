#############################################################
#
# Synplify Pro RPT analize
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
#############################################################
require "common"
require "constraint"

#
# Data structure for Report File detail Information
#
class RPTErrorDetail
  # Error Message from RPT file
  attr_accessor :Message
  # Attibute Name considerd error message
  attr_accessor :AttributeName
  # Signal Name considerd error message
  attr_accessor :SignalName
  def initialize
    @Message = nil
    @AttributeName = nil
    @SignalName = nil
  end
end


#
# Synplify Report Class
#  - Read RPT file
#  - Analize Report file
#  - Compare report file and SCR Data
#
class SynplifyRPT < Message
  
  attr_accessor :RPT_ErrorList
  # 
  # initialize
  # 
  def initialize(file_name,attribute_all)
    @attribute_all = attribute_all
    @RPT_FILE = file_name
    @RPT_DATA = Array.new

    @RPT_ERR = Hash.new

    @RPT_ErrorList = Array.new  # [sdc sentence, error message]
  end
  
  #
  # read
  #
  def read
    @RPT_DATA = Common.file_read(@RPT_FILE)
  end

  #
  # analize
  #
  def analize
    attribute = nil
    error_msg = nil
    flag = false
    @RPT_DATA.each{|line|
      line = line.gsub("\t"," ")
      # get attribute
      if ((/^define_/ =~ line) != nil)
        attribute = line
#        attribute = line.gsub(" ","") # delete space for mattern-matching
        flag = true
        next
      end
      # get error message
      if ((/@E:/ =~ line) != nil)
        error_msg = line
        if attribute != nil
          detail = RPTErrorDetail.new
          detail.Message = error_msg
          detail.AttributeName = attribute.split[0]
          sig_name = error_msg.split[1].gsub("\"","")
          detail.SignalName = sig_name.slice(2..1000)
          @RPT_ERR["#{attribute}"] = detail
          flag = false
        else
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end if flag == true
      end
    }
    
  end
  
  #
  # compare
  #   NOTE : Compare Only "create_clock,syn_keep,xc_pulldown"
  #
  def compare_scr
    line = Array.new
    @attribute_all.each_value{|const|
      const[1].each{|line,data|
        data.SDC.each{|sdc|
          sdc_tmp = sdc.gsub("\*","").split[2].slice(2..1000)
          @RPT_ERR.each{|key,err|
            sig_tmp = err.SignalName.gsub("\*","")
            if err.AttributeName == sdc.split[0] && sig_tmp == sdc_tmp
              data.ConstCheckFlag = 0
              data.SynthesisReport = err.Message
              noapply = Array.new
              noapply << line
              noapply << data.SDC
              noapply << err.Message
              @RPT_ErrorList << noapply
            end
          }
        }if data.SDC != nil
      }
    }
  end

  #
  # compare under FPGAMode
  #   NOTE : Compare Only "define_clock,syn_keep,xc_pulldown"
  #
  def compare_sdc
    @attribute_all.each{|attribute_name,attribute_data|
      case attribute_name
      when "define_clock"
        attribute_data[0].each_value{|each|
          sdc_signal = "chiptop.chip." + each.Signal_mod.gsub("/",".")
          @RPT_ERR.each{|key,err|
            if err.AttributeName == attribute_name && err.SignalName == sdc_signal
              each.ConstCheckFlag = 0
              each.SynthesisReport = err.Message
            end
          }
        }
      when "xc_pulldown", "xc_pullup"
        attribute_data[0].each_value{|each|
          sdc_signal = "chiptop.chip." + each.Pin_mod.gsub("/",".")
          @RPT_ERR.each{|key,err|
            if err.AttributeName == "define_attribute" && err.SignalName == sdc_signal
              each.ConstCheckFlag = 0
              each.SynthesisReport = err.Message
            end
          }
        }
      when "syn_keep"
        attribute_data[0].each_value{|each|
          sdc_signal = "chiptop.chip." + each.Pin_mod.gsub("/",".")
          @RPT_ERR.each{|key,err|
            if err.AttributeName == "define_attribute" && err.SignalName == sdc_signal
              each.ConstCheckFlag = 0
              each.SynthesisReport = err.Message
            end
          }
        }
      end
    }
  end

  #
  # main
  #
  def main(mode)
    read
    analize
    if mode == "DeviceMode" 
      compare_scr
    elsif mode == "FPGAMode"
      compare_sdc
    end
      
  end

end

