#############################################################
#
# Synplify Pro SRR report analize
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#  Date       : Jan 14, 2010
#
############################################################
require "common"
require "constraint"

class SynplifySrr < Message
  
  attr_accessor :NoApplyList
  # 
  # initialize
  # 
  def initialize(file_name,attribute)
    @SRR_FILE = file_name
    @SRR_DATA = Array.new

    @attribute_all = attribute

    @syn_keep = Hash.new
    @define_path_delay = Hash.new
    @define_multicycle_path = Hash.new
    @define_false_path = Hash.new
    
    @NoApplyList = Array.new
  end
  
  #
  # read
  #
  def read
    @SRR_DATA = Common.file_read(@SRR_FILE)
  end

  #
  # analize
  #
  def analize
    printf("@I:Analizing SRR file and Checking application situation.\n")
    @SRR_DATA.each{|line|
      next if /chiptop.chip.flash_cp/ =~ line

      line = line.gsub("\t"," ")

      # syn_keep/xc_pulldown/xc_pullup error
      if ((/^@W: BN105/ =~ line) != nil)
        line = line.gsub("\"","") # remove "
        tmp = line.split
        @syn_keep["#{tmp[7]}"] = line
        if tmp[7] == nil
          $ERROR_CNT += 1
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
      end
      # constraint unmatched
      if ((/^@W: MT299/ =~ line) != nil)
        tmp = line.gsub("(","").gsub(")","").split
        if  tmp.size == 26 # from-thouh-to
          const = ConstEach.new
          const.From = tmp[5] if tmp[4] == "from"
          const.Through1 = tmp[7] if tmp[6] == "through"
          const.To = tmp[9] if tmp[8] == "to"
          const.Period = tmp[12]
          @define_path_delay["#{line}"] = const
        elsif tmp.size == 24 || tmp.size == 30 || tmp.size == 31# from-to/through-to/from-through
          const = ConstEach.new
          const.From = tmp[5] if tmp[4] == "from"
          const.Through1 = tmp[5] if tmp[4] == "through"
          const.To = tmp[7] if tmp[6] == "to"
          const.Through1 = tmp[7] if tmp[6] == "through"
          const.Period = tmp[10]
          @define_path_delay["#{line}"] = const
        elsif tmp.size == 22 # from/to
          const = ConstEach.new
          const.From = tmp[5] if tmp[4] == "from"
          const.To = tmp[5] if tmp[4] == "to"
          const.Period = tmp[8]
          @define_path_delay["#{line}"] = const
        else
          p line
          p tmp.size
          $ERROR_CNT += 1
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
      end

      #
      # MT303
      # 
      if ((/^@W: MT303/ =~ line) != nil)
        tmp = line.gsub("(","").gsub(")","").split
        if  tmp.size == 28 # from/throuh/to
          const = ConstEach.new
          const.From = tmp[5] if tmp[4] == "from"
          const.To = tmp[5] if tmp[4] == "to"
          const.Through1 = tmp[5] if tmp[4] == "through"
          const.Period = tmp[8]
          @define_multicycle_path["#{line}"] = const
        elsif  tmp.size == 26 # from-throuh-to
          const = ConstEach.new
          const.To = tmp[5] if tmp[4] == "to"
          const.From = tmp[5] if tmp[4] == "from"
          const.Through1 = tmp[7] if tmp[6] == "through"
          const.To = tmp[9] if tmp[8] == "to"
          const.Period = tmp[12]
          @define_multicycle_path["#{line}"] = const
        elsif tmp.size == 24 # from-to/through-to/from-through
          const = ConstEach.new
          const.From = tmp[5] if tmp[4] == "from"
          const.Through1 = tmp[5] if tmp[4] == "through"
          const.To = tmp[7] if tmp[6] == "to"
          const.Through1 = tmp[7] if tmp[6] == "through"
          const.Period = tmp[10]
          @define_multicycle_path["#{line}"] = const
        elsif tmp.size == 22 # from/to/through1
          const = ConstEach.new
          const.From = tmp[5] if tmp[4] == "from"
          const.To = tmp[5] if tmp[4] == "to"
          const.Through1 = tmp[5] if tmp[4] == "through"
          const.Period = tmp[8]
          @define_multicycle_path["#{line}"] = const
        else
          p line
          p tmp.size
          $ERROR_CNT += 1
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
      end
      
      #
      # MT305
      #
      if ((/^@W: MT305/ =~ line) != nil)
        tmp = line.gsub("(","").gsub(")","").split
        if tmp.size == 23 # from-to
          const = ConstEach.new
          const.To = tmp[5] if tmp[4] == "to"
          const.From = tmp[5] if tmp[4] == "from"
          const.Through1 = tmp[5] if tmp[4] == "through"
          const.To = tmp[7] if tmp[6] == "to"
          const.From = tmp[7] if tmp[6] == "from"
          if const.Through1 == nil
            const.Through1 =  tmp[7] if tmp[6] == "through"
          else
            const.Through2 = tmp[7] if tmp[6] == "through"
          end
          @define_false_path["#{line}"] = const
=begin
          if (const.From != nil && const.Through1 != nil) || (const.To != nil) && (const.Through1 != nil) || (const.From != nil) && (const.To != nil)
          else
            p line
            $ERROR_CNT += 1
            printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
            exit
          end
=end
        elsif tmp.size == 21 || tmp.size == 28
          const = ConstEach.new
          const.To = tmp[5] if tmp[4] == "to"
          const.From = tmp[5] if tmp[4] == "from"
          const.Through1 = tmp[5] if tmp[4] == "through"
          @define_false_path["#{line}"] = const
          if const.From == nil && const.To == nil && const.Through1 == nil
            printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
            exit
          end
        elsif tmp.size == 29 || tmp.size == 30
          const = ConstEach.new
          const.To = tmp[5] if tmp[4] == "to"
          const.From = tmp[5] if tmp[4] == "from"
          const.Through1 = tmp[5] if tmp[4] == "through"
          const.To = tmp[7] if tmp[6] == "to"
          const.From = tmp[7] if tmp[6] == "from"
          if const.Through1 == nil
            const.Through1 =  tmp[7] if tmp[6] == "through"
          else
            const.Through2 = tmp[7] if tmp[6] == "through"
          end
          @define_false_path["#{line}"] = const
          if (const.From != nil && const.Through1 != nil) || (const.To != nil) && (const.Through1 != nil) || (const.From != nil) && (const.To != nil)
          else
            p line
            $ERROR_CNT += 1
            printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
            exit
          end
        else
          p line
          p tmp.size
          $ERROR_CNT += 1
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
      end

      #
      # MT302
      #
      if ((/^@W: MT302/ =~ line) != nil)
        tmp = line.gsub("(","").gsub(")","").split
        case tmp.size
        when 31 then
          const = ConstEach.new
          # 1st
          const.To = tmp[6] if tmp[5] == "to"
          const.From = tmp[6] if tmp[5] == "from"
          const.Through1 = tmp[6] if tmp[5] == "through"
          # 2nd
          const.To = tmp[8] if tmp[7] == "to"
          const.From = tmp[8] if tmp[7] == "from"
          if const.Through1 == nil
            const.Through1 =  tmp[8] if tmp[7] == "through"
          else
            const.Through2 = tmp[8] if tmp[7] == "through"
          end
          # 3rd
          const.To = tmp[10] if tmp[9] == "to"
          const.From = tmp[10] if tmp[9] == "from"
          if const.Through1 == nil
            const.Through1 =  tmp[10] if tmp[9] == "through"
          elsif const.Through2 == nil
            const.Through2 = tmp[10] if tmp[9] == "through"
          else
            const.Through3 = tmp[10] if tmp[9] == "through"
          end
          # 4th
          const.To = tmp[12] if tmp[11] == "to"
          const.From = tmp[12] if tmp[11] == "from"
          if const.Through1 == nil
            const.Through1 =  tmp[12] if tmp[11] == "through"
          elsif const.Through2 == nil
            const.Through2 = tmp[12] if tmp[11] == "through"
          elsif const.Through3 == nil
            const.Through3 = tmp[12] if tmp[11] == "through"
          else
            const.Through4 = tmp[12] if tmp[11] == "through"
          end          
          # 5th
          const.To = tmp[14] if tmp[13] == "to"
          const.From = tmp[14] if tmp[13] == "from"
          @define_multicycle_path["#{line}"] = const
=begin
          if (const.From != nil && const.Through1 != nil && const.Through2 != nil && const.Through3 != nil && const.To != nil)
          else
            p line
            $ERROR_CNT += 1
            printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
            exit
          end
=end
        when 29 then
          const = ConstEach.new
          # 1st
          const.To = tmp[6] if tmp[5] == "to"
          const.From = tmp[6] if tmp[5] == "from"
          const.Through1 = tmp[6] if tmp[5] == "through"
          # 2nd
          const.To = tmp[8] if tmp[7] == "to"
          const.From = tmp[8] if tmp[7] == "from"
          if const.Through1 == nil
            const.Through1 =  tmp[8] if tmp[7] == "through"
          else
            const.Through2 = tmp[8] if tmp[7] == "through"
          end
          # 3rd
          const.To = tmp[10] if tmp[9] == "to"
          const.From = tmp[10] if tmp[9] == "from"
          if const.Through1 == nil
            const.Through1 =  tmp[10] if tmp[9] == "through"
          elsif const.Through2 == nil
            const.Through2 = tmp[10] if tmp[9] == "through"
          else
            const.Through3 = tmp[10] if tmp[9] == "through"
          end
          # 4th
          const.To = tmp[12] if tmp[11] == "to"
          const.From = tmp[12] if tmp[11] == "from"
          if const.Through1 == nil
            const.Through1 =  tmp[12] if tmp[11] == "through"
          elsif const.Through2 == nil
            const.Through2 = tmp[12] if tmp[11] == "through"
          elsif const.Through3 == nil
            const.Through4 = tmp[12] if tmp[11] == "through"
          else
            const.Through4 = tmp[12] if tmp[11] == "through"
          end 
          @define_multicycle_path["#{line}"] = const
          if (const.Through1 != nil && const.Through2 != nil && const.Through3 != nil && const.Through4 != nil)
          else
            $ERROR_CNT += 1
            printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          end
        when 27 then
          const = ConstEach.new
          const.To = tmp[6] if tmp[5] == "to"
          const.From = tmp[6] if tmp[5] == "from"
          const.Through1 = tmp[6] if tmp[5] == "through"

          const.To = tmp[8] if tmp[7] == "to"
          const.From = tmp[8] if tmp[7] == "from"
          if const.Through1 == nil
            const.THrough1 =  tmp[8] if tmp[7] == "through"
          else
            const.Through2 = tmp[8] if tmp[7] == "through"
          end

          const.To = tmp[10] if tmp[9] == "to"
          const.From = tmp[10] if tmp[9] == "from"
          if const.Through1 == nil
            const.Through1 =  tmp[10] if tmp[9] == "through"
          elsif const.Through2 == nil
            const.Through2 = tmp[10] if tmp[9] == "through"
          else
            const.Through3 = tmp[10] if tmp[9] == "through"
          end
          @define_multicycle_path["#{line}"] = const
          if (const.Through1 != nil && const.Through2 != nil && const.To != nil) || \
             (const.Through1 != nil && const.Through2 != nil && const.Through3 != nil)
          else
#            p line
            $ERROR_CNT += 1
            printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
#            exit
          end
        when 25 then
          const = ConstEach.new
          const.To = tmp[6] if tmp[5] == "to"
          const.From = tmp[6] if tmp[5] == "from"
          const.Through1 = tmp[6] if tmp[5] == "through"
          const.To = tmp[8] if tmp[7] == "to"
          const.From = tmp[8] if tmp[7] == "from"
          if const.Through1 == nil
            const.THrough1 =  tmp[8] if tmp[7] == "through"
          else
            const.Through2 = tmp[8] if tmp[7] == "through"
          end
          @define_multicycle_path["#{line}"] = const
          if (const.Through1 != nil && const.Through2 != nil)
          else
#            p line
            $ERROR_CNT += 1
            printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
#            exit
          end
        else
          p line
          p tmp.size
          $ERROR_CNT += 1
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
      end      

    } 
    printf(" ... Done\n")
  end

  #
  # compare
  #
  def compare_scr
    printf("@I:Comparing SRR File info and SDC File info\n")
    line = Array.new
    # for syn_keep
    syn_keep = Hash.new
    @attribute_all.each_value{|const|
      const[1].each{|line,data|
        if data.SDCAttribute != nil
          # for Signal
          tmp = Array.new
          tmp = data.Signal_mod.split if data.Signal_mod != nil # corresponding mult signal
          tmp.each{|sig|
            if sig == "all_clocks" || sig == "all_inputs" || sig == "all_outputs" || sig == "all_registers"
            else
              sig = "chiptop.chip." + sig.gsub("/",".") + ".*" # signal convert
            end
            if ( @syn_keep.key?("#{sig}") == true )
              data.ConstCheckFlag = 0
              data.SynthesisReport = @syn_keep.fetch("#{sig}")
              noapply = Array.new
              noapply << line
              noapply << data.SDC
              noapply << @syn_keep.fetch("#{sig}") 
              @NoApplyList << noapply
              @syn_keep.delete("#{sig}")
            end
          } if tmp != nil

          # forPin
          tmp = Array.new
          tmp = data.Pin_mod.split if data.Pin_mod != nil # corresponding mult signal
          tmp.each{|sig|
            if sig == "all_clocks" || sig == "all_inputs" || sig == "all_outputs" || sig == "all_registers"
            else
              if data.SDCAttribute == "syn_keep"
                sig = "chiptop.chip." + sig.gsub("/",".") + ".*" # signal convert
              else
                sig = "chiptop.chip." + sig.gsub("/",".") # signal convert
              end
            end
            if ( @syn_keep.key?("#{sig}") == true )
              data.ConstCheckFlag = 0
              data.SynthesisReport = @syn_keep.fetch("#{sig}") 
              noapply = Array.new
              noapply << line
              noapply << data.SDC
              noapply <<  @syn_keep.fetch("#{sig}") 
              @NoApplyList << noapply
              @syn_keep.delete("#{sig}")
            end
          } if tmp != nil
        end
      }
    }
    @NoApplyList.uniq!

    #
    # for define_path_delay
    #
    @attribute_all.each_value{|const|
      const[1].each{|line,data|
        if data.SDCAttribute == "define_path_delay" && data.RemoveFlag == false
          line = line.strip
          component_matching(line,data,@define_path_delay)
        end
      }
    }


    #
    # for define_multicycle_path
    #
    @attribute_all.each_value{|const|
      const[1].each{|line,data|
        if data.SDCAttribute == "define_multicycle_path" && data.RemoveFlag == false
          line = line.strip
          component_matching(line,data,@define_multicycle_path)
        end
      }
    }
    
    #
    # define_false_path
    #
    @attribute_all.each_value{|const|
      const[1].each{|line,data|
        if data.SDCAttribute == "define_false_path" && data.RemoveFlag == false
          line = line.strip
          component_matching(line,data,@define_false_path)
        end
      }
    }

    # cannot search all error
=begin
    if @syn_keep.size != 0
      p @syn_keep
      $ERROR_CNT += 1
      printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
      printf("  - syn_keep : srr report and SDC file donot match completely\n")
      exit
    end
=end
=begin
    if @define_path_delay.size != 0
#      p @define_path_delay
      $ERROR_CNT += 1
      printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
      printf("  - define_path_delay : srr report and SDC file donot match completely\n")
#      exit
    end
=end
    @define_path_delay.each_value{|value|
      if value.ComponentMatchingFlag == 0
#        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
#        printf("  - define_path_delay : srr report and SDC file donot match completely\n")
      end
    }
    @define_false_path.each_value{|value|
      if value.ComponentMatchingFlag == 0
        # illegal attribute
        next if value.From == "i:chiptop.chip.cpu.alu.IE" && value.To == "i:chiptop.chip.csc.cg.tbase.stby.stpst_neg"
        next if value.From == "i:chiptop.chip.cpu.alu.ISP[1:0]" && value.To == "i:chiptop.chip.csc.cg.tbase.stby.stpst_neg"
        next if value.From == "i:chiptop.chip.cpu.alu.AC" && value.To == "i:chiptop.chip.csc.cg.tbase.stby.stpst_neg"
        $ERROR_CNT += 1
        printf("@E:define_false_path : srr report and SDC file donot match completely\n")
        printf("   it may be illegal srr/rpt file was specified.please check it\n")
        Common.internal_error(__FILE__,__LINE__)
      end
    }
    @define_multicycle_path.each_value{|value|
      if value.ComponentMatchingFlag == 0
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        printf("  - define_multicycle_path : srr report and SDC file donot match completely\n")
      end
    }
=begin
    if @define_false_path.size != 0
      $ERROR_CNT += 1
#      p @define_false_path
      printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
      printf("  - define_false_path : srr report and SDC file donot match completely\n")
#     exit
    end
    if @define_multicycle_path.size != 0
#      p @define_multicycle_path
      $ERROR_CNT += 1
      printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
      printf("  - define_multicycle_path : srr report and SDC file donot match completely\n")
#      exit
    end
=end
    printf(" ... Done\n")
  end

  #
  #
  #
  def comp_search(tmp, pre )
    ret = Array.new
    if tmp != nil
      tmp.each{|mod|
        if mod == "all_clocks" || mod == "all_inputs" || mod == "all_outputs" || mod == "all_registers"
          ret << mod
        else
          ret << (pre + mod.gsub("/",".")).strip if mod != nil
        end
      }
    end
    return ret
  end

  def get_flag(str,srr)
    if str.size != 0
      str.each{|each|
        return 1 if str == nil && srr == nil
        return 1 if del_header(each) == del_header(srr)
      }
    else 
      return 1
    end
    return 0
  end

  def del_header(str)
    str = str.sub("i:","") if str != nil
    str = str.sub("n:","") if str != nil
    str = str.sub("p:","") if str != nil
    str = str.sub("t:","") if str != nil
    str = str.sub("r:","") if str != nil
    str = str.sub("c:","") if str != nil
    str = str.sub("chiptop.chip.","") if str != nil
    return str
  end

  def component_matching(line,data,attribute)
    flag = 0
    from = Array.new
    to = Array.new
    through1 = Array.new
    through2 = Array.new
    through3 = Array.new
    signal = Array.new
    pin = Array.new

    tmp = Array.new
    tmp = data.From_mod.split if data.From_mod != nil
    from = comp_search(tmp,"i:chiptop.chip.")
   
    tmp = Array.new
    tmp = data.To_mod.split if data.To_mod != nil
    to = comp_search(tmp,"i:chiptop.chip.")
    
    tmp = Array.new
    tmp = data.Through1_mod.split if data.Through1_mod != nil
    through1 = comp_search(tmp,"n:chiptop.chip.")
    
    tmp = Array.new
    tmp = data.Through2_mod.split if data.Through2_mod != nil
    through2 = comp_search(tmp,"n:chiptop.chip.")

    tmp = Array.new
    tmp = data.Through3_mod.split if data.Through3_mod != nil
    through3 = comp_search(tmp,"n:chiptop.chip.")
    
    tmp = Array.new
    tmp = data.Signal_mod.split if data.Signal_mod != nil
    signal = comp_search(tmp,"i:chiptop.chip.")

    tmp = Array.new
    tmp = data.Pin_mod.split if data.Pin_mod != nil
    pin = comp_search(tmp,"t:chiptop.chip.")

    attribute.each{|err_line,srr|
      flag = 0
      flag += get_flag(from,srr.From)
      flag += get_flag(to,srr.To)
      flag += get_flag(through1,srr.Through1)
      flag += get_flag(through2,srr.Through2)
      flag += get_flag(through3,srr.Through3)
      flag += get_flag(signal,srr.Signal)
      flag += get_flag(pin,srr.Pin)
           
      if flag == 7
        data.ConstCheckFlag = 0 # NG
        data.SynthesisReport = err_line
        noapply = Array.new
        noapply << line
        noapply << data.SDC
        noapply << err_line
        @NoApplyList << noapply
#        attribute.delete("#{err_line}")
        srr.ComponentMatchingFlag = 1
      end
    }
  end
    

  #
  # compare with sdc
  #
  def compare_sdc
    @attribute_all.each{|attribute_name,attribute_data|
      case attribute_name
      when "xc_pullup", "xc_pulldown" 
        # it cannnot compare because cannot get infomation from SRR file
      when "define_clock"
        # it cannnot compare because cannot get infomation from SRR file
      when "define_false_path"
        attribute_data[0].each{|key,value|
          component_matching(attribute_name,value,@define_false_path)
        }
      when "define_multicycle_path"
        attribute_data[0].each{|key,value|
          component_matching(attribute_name,value,@define_multicycle_path)
        }
      when "syn_keep"
        attribute_data[0].each{|key,value|
          sdc_pin = "chiptop.chip." + value.Pin_mod.gsub("/",".")
          if ( @syn_keep.key?("#{sdc_pin}") == true )
            value.ConstCheckFlag = 0 # NG
          end
        }
      when "set"
        # Nothing
      when "define_global_attribute"
        # Nothing
      when "syn_noclockbuf"
        attribute_data[0].each{|key,value|
          sdc_pin = "chiptop.chip." + value.Pin_mod.gsub("/",".")
          if ( @syn_keep.key?("#{sdc_pin}") == true )
            value.ConstCheckFlag = 0 # NG
          end
        }
      else
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit
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


