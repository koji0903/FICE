#############################################################
#
# Generate Summary report
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#  Date       : Jan 13, 2010
#
#############################################################

class GenSummarySCR
  def initialize(dir,data,unrecognized,unanalized,unconverted)
    @dir = dir
    @attribute_all = data
    @unrecognized_attribute = unrecognized
    @UnAnalizedAttributeList = unanalized
    @UnConvertedAttributeList = unconverted

    @total_num   = 0  # all constraint
    @need_num    = 0  # needed constraint number
    @noneed_num  = 0  # no-need constrint
    @limit_num   = 0  # tool limited constraint number
    @rmconst_num = 0  # the numver of removed constraint

    @CategoryList   = Hash.new
    @ConstraintPath = Hash.new
  end

  #
  # make_AllScrFile
  #
  def make_AllScrFile(scr_data)
    merge_data = Array.new
    # All File Search
    scr_data.each{|file_name,data|
      line_str = nil
      
      merge_data << "#--------------------------------------------------"
      merge_data << "# [SCR FILE]: " + file_name
      merge_data << "#--------------------------------------------------"
      
      # 
      # Make @ShellVariable
      #
      data.each{|line|
        line = line.gsub("\t"," ") # change from "tab" to "space"
        line.strip!
        # continue next line using "\"
        if /\\$/ =~ line
          line.chop! # delete "\" 
          line_str = line_str.to_s + line.to_s
        else
          line_str = line_str.to_s + line.to_s
          
          # update data sturucture
          merge_data << line_str
          line_str = nil
        end
        
      }     
    }
    
    
    ###### FILE WRITE ######
    f = open("report/all.scr","w")
    merge_data.each{|line|
      f.printf("%s\n",line)
    }
    f.close
  end
  

  #
  # summary
  #
  def summary
    file_name = @dir + "constraint.summary" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Constraint Summary from Device Constraint" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")

    # grobal summary
    global_summary(f)

    # Each Attribute
    each_attribute(f)

    # Detail of Each Macro
    detail_each_macro(f)

    # Add Message
    add_message(f)

    f.printf("\n")
    f.close

  end

  #
  # Grobal summary
  #
  def global_summary(f)
    f.printf("## Grobal\n")
    @attribute_all.each_value{|each_attribute|
      @total_num += each_attribute[1].size
      case each_attribute[0] 
      when "NONEED" then
        @noneed_num += each_attribute[1].size
      else
        @need_num += each_attribute[1].size
      end
            
      each_attribute[1].each{|const|
        @rmconst_num += 1 if const[1].RemoveFlag
      }
    }


#    @need_num = @need_num - @rmconst_num 
    unrecognized_attribute = 0
    unrecognized_attribute = @unrecognized_attribute.size if @unrecognized_attribute != nil
    f.printf("The total number of constraint : %5d\n",@total_num)
    f.printf(" the number of constraint must be applied to FPGA implement       : %5d\n",@need_num)
    f.printf(" the number of constraint no directory related to FPGA implement  : %5d\n",@noneed_num)
    f.printf(" the number of attribute include removed macro or no-resolve path : %5d\n",@rmconst_num)
    f.printf(" the number of unrecognized constraints                           : %5d\n",unrecognized_attribute)
    f.printf("\n")
  end

  #
  # each attribute
  #

  def create_line(f)
    f.printf("+--+--------------------------+----------------------------+-------------------+---------------------------+-------------------+\n")
  end

  def each_attribute(f)
    f.printf("## Each Attribute\n")
    attribute_for_sort = Hash.new
    @attribute_all.each{|key,value|
      const_num = 0
      remove_num = 0
      analize_num = 0
      limit_num = 0
      convert_num = 0
      constcheck_num = 0
      if value[0] != "NONEED"
        tmp = Array.new
        value[1].each{|line|
          const_num += 1      if line[1].RemoveFlag == false
          remove_num += 1     if line[1].RemoveFlag == true
          analize_num += 1    if line[1].RemoveFlag == false && line[1].AnalizeFlag == true
          limit_num += 1      if line[1].RemoveFlag == false && line[1].AnalizeFlag == true && line[1].LimitFlag == true
          convert_num += 1    if line[1].RemoveFlag == false && line[1].AnalizeFlag == true && line[1].LimitFlag == false && line[1].ConvertFlag == true
          constcheck_num += 1 if line[1].RemoveFlag == false && line[1].AnalizeFlag == true && line[1].LimitFlag == false && line[1].ConvertFlag == true && line[1].ConstCheckFlag == 1
        }
        tmp << const_num      # [0]total number of each constraint
        tmp << remove_num     # [1]number of removed constraint
        tmp << analize_num    # [2]number of analized
        tmp << limit_num      # [3]number of limitation constraint
        tmp << convert_num    # [4]number of converted
        tmp << constcheck_num # [5]number of constcheck
        tmp << value

        attribute_for_sort["#{key}"] = tmp

        # make ConstSummary 
        value[3].ConstNumber  = const_num
        value[3].RemoveNumber = remove_num
        if @need_num != 0
          value[3].ConstRate    = (const_num.to_f*100)/@need_num.to_f
        else
          value[3].ConstRate    = 0
        end
        value[3].AnalizeNumber  = analize_num
        if value[3].ConstNumber != 0
          value[3].AnalizeRate    = (value[3].AnalizeNumber.to_f*100)/value[3].ConstNumber.to_f
        else
          value[3].AnalizeRate = 0
        end
        value[3].LimitNumber    = limit_num
        value[3].ConvertNumber  = convert_num
        if value[3].ConstNumber != 0
          value[3].ConvertRate    = (value[3].ConvertNumber.to_f*100)/value[3].ConstNumber.to_f
        else
          value[3].ConvertRate = 0
        end
        value[3].ConstChkNumber = constcheck_num
        if value[3].ConstNumber-value[3].LimitNumber != 0
          value[3].ConstChkRate   = (value[3].ConstChkNumber.to_f*100)/value[3].ConstNumber.to_f
        else
          value[3].ConstChkRate = 0
        end

      end
    }
    num = 1
    create_line(f)
    f.printf("|No| Attribute Name           |         number(%%) - remove |        analize(%%) |        convert(%%) - limit |      const chk(%%) |\n")
    create_line(f)
    fvalue_all = 0; fvalue_ana = 0; fvalue_con = 0; fvalue_const_check = 0

    attribute_for_sort.sort_by{|key,value| - (value[0]+value[1])}.each{|key,value|
      fvalue_all = 0; fvalue_ana = 0; fvalue_con = 0; fvalue_const_check = 0

      fvalue_all = (value[0]*100).to_f/@need_num.to_f
#      value[0] = value[0] - value[1] # sub the number of removed
#      value[2] = value[2] - value[3] # sub the number of limitation
      fvalue_ana = (value[2]*100).to_f/value[0].to_f if value[0] != 0
      fvalue_con = (value[4]*100).to_f/value[2].to_f if value[2] != 0
      fvalue_const_check = (value[5]*100).to_f/value[4].to_f if value[4] != 0
      if fvalue_all == 100;    all = "%4d/%4d(%2.2f%%) "
      elsif fvalue_all >= 10;  all = "%4d/%4d( %2.2f%%) "
      else                     all = "%4d/%4d(  %2.2f%%) ";end
      if fvalue_ana == 100;    ana = "%4d/%4d(%2.2f%%) "
      elsif fvalue_ana >= 10;  ana = "%4d/%4d( %2.2f%%) "
      else;                    ana = "%4d/%4d(  %2.2f%%) ";end
      if fvalue_con == 100;    con = "%4d/%4d(%2.2f%%) "
      elsif fvalue_con >= 10;  con = "%4d/%4d( %2.2f%%) "
      else                     con = "%4d/%4d(  %2.2f%%) ";end
      if fvalue_const_check == 100;    const_check = "%4d/%4d(%2.2f%%) "
      elsif fvalue_const_check >= 10;  const_check = "%4d/%4d( %2.2f%%) "
      else                             const_check = "%4d/%4d(  %2.2f%%) ";end

      if fvalue_all != 0 || value[1] != 0
        f.printf("|%2d| %-25s|#{all}-  %5d |#{ana}|#{con}- %5d |#{const_check}|\n"\
                 ,num,key,value[0],@need_num,fvalue_all,value[1],value[2],value[0],fvalue_ana,value[4],value[2],fvalue_con,value[3],value[5],value[4],fvalue_const_check)
      else
        f.printf("|%2d| %-25s|#{all}-      - |        -(     -%%) |        -(     -%%) -     - |        -(     -%%) |\n"\
                 ,num,key,value[0],@need_num,fvalue_all)
      end
      @attribute_all["#{key}"][3].No = num
      num += 1
    }
    create_line(f)
    # print total
    value0_all = 0
    value1_all = 0
    value2_all = 0
    value3_all = 0
    value4_all = 0
    value5_all = 0
    attribute_for_sort.sort_by{|key,value| - value[0]}.each{|key,value|
      value0_all += value[0]
      value1_all += value[1]
      value2_all += value[2]
      value3_all += value[3]
      value4_all += value[4]
      value5_all += value[5]
    }
    fvalue_all = (value0_all*100).to_f/@need_num.to_f
    fvalue_ana = (value2_all*100).to_f/value0_all.to_f if value0_all != 0
    fvalue_con = (value4_all*100).to_f/value2_all.to_f if value2_all != 0
    fvalue_const_check = (value5_all*100).to_f/value4_all.to_f if value4_all != 0
    if fvalue_all == 100;    all = "%4d/%4d(%2.2f%%) "
    elsif fvalue_all >= 10;  all = "%4d/%4d( %2.2f%%) "
    else                     all = "%4d/%4d(  %2.2f%%) ";end
    if fvalue_ana == 100;    ana = "%4d/%4d(%2.2f%%) "
    elsif fvalue_ana >= 10;  ana = "%4d/%4d( %2.2f%%) "
    else;                    ana = "%4d/%4d(  %2.2f%%) ";end
    if fvalue_con == 100;    con = "%4d/%4d(%2.2f%%) "
    elsif fvalue_con >= 10;  con = "%4d/%4d( %2.2f%%) "
    else                     con = "%4d/%4d(  %2.2f%%) ";end
    if fvalue_const_check == 100;    const_check = "%4d/%4d(%2.2f%%) "
    elsif fvalue_const_check >= 10;  const_check = "%4d/%4d( %2.2f%%) "
    else                             const_check = "%4d/%4d(  %2.2f%%) ";end
    f.printf("|%2d| %-25s|#{all}-  %5d |#{ana}|#{con}- %5d |#{const_check}|\n"\
             ,num,"ALL",value0_all,@need_num,fvalue_all,value1_all,value2_all,value0_all,fvalue_ana,value4_all,value2_all,fvalue_con,value3_all,value5_all,value4_all,fvalue_const_check)
    create_line(f)
    f.printf("\n")
    f.printf("# Exclusion constraints\n")
    @attribute_all.each{|key,value|
      if value[0] == "NONEED"
        f.printf("  - %s\n", key)
      end
    }

    f.printf("\n")
=begin
    f.printf("# Information of tool operation\n")
    @attribute_all.each{|key,value|
      f.printf("%s\n",key)
      f.printf("  - %s\n\n",value[4])
    }
=end

  end
  
  #
  # Detail of each constraint
  #
  def detail_each_macro(f)
    f.printf("\n## Detail of each attribute\n")


#    @attribute_all.each{|key,value|
    @attribute_all.sort_by{|key,value| 
      value[3].No.to_i
    }.each{|key,value|
      next if value[3].No == nil
      if value[0] != "NONNEED" && ( value[3].ConstNumber + value[3].RemoveNumber ) != 0 
        f.printf("\n")
        f.printf("# No %d: %s\n\n",value[3].No,key)
        f.printf("   Number of Constraint     :    %4d\n", value[3].ConstNumber)
        f.printf("   Number of Removed Const  :    %4d\n", value[3].RemoveNumber)
        f.printf("   Number(Rate) of Analize  : %3d/%3d( %2.2f%%)\n", value[3].AnalizeNumber,value[3].ConstNumber,value[3].AnalizeRate)
        f.printf("   Number(Rate) of Convert  : %3d/%3d( %2.2f%%)\n", value[3].ConvertNumber,value[3].ConstNumber,value[3].ConvertRate)
        f.printf("   Number of Limit Const    :    %4d\n", value[3].LimitNumber)        
        f.printf("   Number(Rate) of ConstChk : %3d/%3d( %2.2f%%)\n", value[3].ConstChkNumber,value[3].ConstNumber-value[3].LimitNumber,value[3].ConstChkRate)
        f.printf("\n")
        get_removed_macro_detail(f,value[1],value[3])
        get_limit_const_detail(f,value[1],value[3])
        get_each_macro_detail(f,value[1],value[3])
      end
    }
  end

  def get_removed_macro_detail(f,data,total_num)
    macro_info = Hash.new # {file_name,[data]}
    data.each{|const|
      inf_data = Array.new
      file_name = get_macro_info(const[1]) if const[1].RemoveFlag == true
      next if file_name == nil
      inf_data << const[1]
      if macro_info.key?("#{file_name}") == true
        tmp = inf_data + macro_info.fetch("#{file_name}") 
      else
        tmp = inf_data
      end
      macro_info["#{file_name}"] = tmp
    }
    print_detail_info(f,macro_info,"Removed Constraint Detail",0,total_num.RemoveNumber)
  end

  def get_limit_const_detail(f,data,total_num)
    macro_info = Hash.new # {file_name,[data]}
    data.each{|const|
      inf_data = Array.new
      file_name = get_macro_info(const[1]) if const[1].RemoveFlag == false && const[1].AnalizeFlag == true && const[1].LimitFlag == true
      next if file_name == nil
      inf_data << const[1]
      if macro_info.key?("#{file_name}") == true
        tmp = inf_data + macro_info.fetch("#{file_name}") 
      else
        tmp = inf_data
      end
      macro_info["#{file_name}"] = tmp
    }
    print_detail_info(f,macro_info,"Limited Constraint Detail",0,total_num.LimitNumber)
  end

  def get_each_macro_detail(f,data,total_num)
    # make data structure for report
    macro_info = Hash.new # {file_name,[data]}
    data.each{|const|
      inf_data = Array.new
      file_name = get_macro_info(const[1]) if const[1].RemoveFlag == false && const[1].LimitFlag == false
      next if file_name == nil
      inf_data << const[1]
      if macro_info.key?("#{file_name}") == true
        tmp = inf_data + macro_info.fetch("#{file_name}") 
      else
        tmp = inf_data
      end
      macro_info["#{file_name}"] = tmp
    }
    print_detail_info(f,macro_info,"ConstCheck Detail",1,total_num.ConstNumber)
    
  end

  def print_detail_info(f,macro_info,message,flag,total_num)
    macro_info_for_sort = Hash.new
    macro_info.each{|key,value|
      applied_cnt = 0
      value.each{|const|
        applied_cnt += 1 if const.RemoveFlag == false && const.AnalizeFlag == true && const.ConvertFlag == true && const.ConstCheckFlag == 1
      }
      tmp = Array.new
      tmp << value.size
      tmp << applied_cnt
      tmp << value
      macro_info_for_sort["#{key}"] = tmp
    }

    f.printf("   %s(total number:%d)\n",message,total_num)
    if flag == 1
      f.printf("   +-------------------------------------+------------------+\n")
      f.printf("   | Macro Info                          | ConstCheck Rate  |\n")
      f.printf("   +-------------------------------------+------------------+\n")
    elsif flag == 0
      f.printf("   +-------------------------------------+-----+\n")
      f.printf("   | Macro Info                          | Num |\n")
      f.printf("   +-------------------------------------+-----+\n")
    end


    if flag == 1 # with rate
      if macro_info_for_sort.size == 0
        f.printf("   | NONE                                | %3d/%3d (  %2.2f%%)|\n",0,0,0.00)
      else
        macro_info_for_sort.sort_by{|key,value| - value[0]}.each{|key,value|
          fvalue = (value[1].to_f*100)/value[0].to_f
          if fvalue == 100
            f.printf("   | %-35s | %3d/%3d (%2.2f%%)|\n",key,value[1],value[0],fvalue)
          elsif fvalue >= 10
            f.printf("   | %-35s | %3d/%3d ( %2.2f%%)|\n",key,value[1],value[0],fvalue)
          else
            f.printf("   | %-35s | %3d/%3d (  %2.2f%%)|\n",key,value[1],value[0],fvalue)
          end
        }
      end
    elsif flag == 0 # only number
      if macro_info_for_sort.size == 0
        f.printf("   | NONE                                |   0 |\n")
      else
        macro_info_for_sort.sort_by{|key,value| - value[0]}.each{|key,value|
          fvalue = (value[1].to_f*100)/value[0].to_f
          f.printf("   | %-35s | %3d |\n",key,value[0])
        }
      end
    end
  
    if flag == 1
      f.printf("   +-------------------------------------+------------------+\n")
    elsif flag == 0
      f.printf("   +-------------------------------------+-----+\n")
    end

    f.printf("\n")
    
    # for report/const_each_macro
  end

  def get_macro_info(data)
    macro_list = Array.new
    macro_list << data.SignalMacro if data.SignalMacro != nil
    macro_list << data.PinMacro if data.PinMacro != nil
    macro_list << data.SourceMacro if data.SourceMacro != nil
    macro_list << data.FromMacro if data.FromMacro != nil
    macro_list << data.FallFromMacro if data.FallFromMacro != nil
    macro_list << data.ToMacro if data.ToMacro != nil
    macro_list << data.FallToMacro if data.FallToMacro != nil
    macro_list << data.Through1Macro if data.Through1Macro != nil
    macro_list << data.Through2Macro if data.Through2Macro != nil
    macro_list << data.Through3Macro if data.Through3Macro != nil
    macro_list << data.Through4Macro if data.Through4Macro != nil
    macro_list << data.FallThrough1Macro if data.FallThrough1Macro != nil
    macro_list << data.FallThrough2Macro if data.FallThrough2Macro != nil
    macro_list << data.FallThrough3Macro if data.FallThrough3Macro != nil
    macro_list << data.FallThrough4Macro if data.FallThrough4Macro != nil
    macro_list = macro_list.uniq.sort!

    report_file_name = ""
    macro_list.each{|each_macro|
      report_file_name += " <-> " + each_macro
    }
    report_file_name = report_file_name.sub(" <-> ","") # delete first "<->" charactor
    return nil if /pull_/ =~ report_file_name
    return report_file_name
  end

  #
  # Add Message
  #
  def add_message(f)
    f.printf("\n## Un-Recognized Constraint ##\n")
    if  @unrecognized_attribute.size != 0
      @unrecognized_attribute.each{|line|
        f.printf("%s\n",line[0])
      }
    else
      f.printf("\nNONE\n")
    end
#    f.printf("## Un-Recognize Line ##\n")
#    @unrecognized_line.each{|line|
#      f.printf("%s\n",line)
#    }
    f.printf("\n## Un-Analized Constraint Line ##\n")
    if @UnAnalizedAttributeList.size != 0
      @UnAnalizedAttributeList.each{|line|
        f.printf("%s\n",line[0])
      }
    else
      f.printf("\nNONE\n")
    end

    f.printf("\n## Un-Converted Constraint Line ##\n")
    if @UnConvertedAttributeList.size != 0
      @UnConvertedAttributeList.each{|line|
        f.printf("%s\n",line[0])
      }
    else
      f.printf("\nNONE\n")
    end
  end
    
  #
  # applied_report
  #
  def applied_report

    # get Category information
    applied_info = Common.file_read("#{File.dirname(__FILE__)}/../conf/const.set")
    applied_info.each{|line|
      line_data = line.split(":")
      case line_data[0]
      when "C" then
        @CategoryList["#{line_data[1]}"] = line_data[2]
      when "P" then
        @ConstraintPath["#{line_data[1]}"] = line_data[2]
      else
      end
    }
    
    # generate
    file_name = @dir + "AppliedReport.csv" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Constraint Detail from Device" 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
    f.printf("\n")

    n = 1
    f.printf("No,Judge,Device Constraint,Converted FPGA Constraint,Category under tool operation,Reason(if not applied),Synthesys Report(if not applied)\n")
    @attribute_all.each_value{|all_const|
      if all_const[0] != "NONEED"
        all_const[1].each{|sentence,c|
          category = "Applied"
          reason = nil
          # Const Check Flag
          if c.ConstCheckFlag == 1
            judge_flag = "OK"
            reason = "---"
          else
            judge_flag = "NG"
          end
          if !c.AnalizeFlag
            judge_flag = "--"
            category = "UnAnalized"
            reason = "[UnAnalized]"
          end
          if !c.ConvertFlag
            judge_flag = "---"
            c.SDC = "---"
            category = "UnConverted"
            reason = "[UnConverted]"
          end
          if c.RemoveFlag
            judge_flag = "---"
            judge_flag = "OK(with Removed)" # Update
            category = "Removed"
            reason = "[REMOVED]Removed Constraint. The macro path is include removed macro for ICE."
          end
          if c.LimitFlag
            judge_flag = "---"
            judge_flag = "OK(with Limited)" # Update
            category = "Limited"
            reason = "[LIMITED]Limited Constraint. The description is now limited on this tool."
          end
          
          if judge_flag == "NG"
            # Category 
            @ConstraintPath.each{|key,value|
              if /#{key}/ =~ sentence
                category_num = value.to_i
                reason = @CategoryList["#{category_num}"].to_s
                if reason != nil
                  judge_flag = "OK(with Analized)"
                end
                category = "NOT Applied"
              end
            }
          end
          
          # Print
          #            c.SDC.each{|each_sdc|
          if c.SDC.size == 1
            f.printf("%d,%s,%s,%s,%s,%s,%s\n",n,judge_flag,sentence,c.SDC,category,reason,c.SynthesisReport)
          else
            f.printf("%d,%s,%s,\"%s\n",n,judge_flag,sentence,c.SDC[0])
            num = c.SDC.size - 1
            for i in 1...(c.SDC.size-2)
              f.printf("%s\n",c.SDC[i])
            end
#            f.printf("%s\",%s,%s\n",c.SDC[c.SDC.size-1],category,reason,c.SynthesisReport)
            f.printf("%s\",%s,%s\n",c.SDC[c.SDC.size-1],category,reason)
          end
          n += 1
          #            }
        }
      end
    }
    
    n = 1
    f.printf("\n")
    f.printf("List of No-Need or Unsupported Constraint")
    f.printf("No,,Device Constraint\n")
    @attribute_all.each_value{|all_const|
      if all_const[0] == "NONEED"
        all_const[1].each{|sentence,c|
          f.printf("%d,,%s\n",n,sentence)
          n += 1
        }
      end
    }
    f.close
  end

  #
  # const_detail
  #
  def const_detail
    file_name = @dir + "constraint_detail.txt" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Constraint Detail from Device" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")
    f.printf("#attribute,period,ClockName,signal,pin,source,from,fall-from,to,fall-to,through1,fall-through1,through2,fall-through2,setup-flag,type,Nouse-flag,AnalizeFlag,ConvertFlag,FileName,LineNo,sentence\n")
    @attribute_all.each_value{|all_const|
      if all_const[0] != "NONEED"
        all_const[1].each{|sentence,c|
          f.printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%d,%s,\n"\
                   ,c.Attribute\
                   ,c.Period\
                   ,c.ClockName\
                   ,c.Signal\
                   ,c.Pin\
                   ,c.Source\
                   ,c.From\
                   ,c.FallFrom\
                   ,c.To\
                   ,c.FallTo\
                   ,c.Through1\
                   ,c.FallThrough1\
                   ,c.Through2\
                   ,c.FallThrough2\
                   ,c.SetupFlag\
                   ,c.Type\
                   ,c.NoUseFlag\
                   ,c.AnalizeFlag\
                   ,c.ConvertFlag\
                   ,c.FileName\
                   ,c.LineNo\
                   ,sentence\
                   )
        }
      end
    }
    f.close

  end

  #
  # generate name_change file
  # 
  def name_change
    file_name = @dir + "name_change.txt"
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Naming change list" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")    
    i = 0
    @attribute_all.each{|attribute_name,const|
      if const[0] != "NONEED"
        const[1].each{|line,data|
          if data.NameChangeFlag == true
            i += 1
          end
        }
      end
    }
    f.printf("# Summary\n")
    f.printf("   The total number of changing constraint : %d\n",i)
    f.printf("\n\n")
    f.printf("# Each changed list\n")
    @attribute_all.each{|attribute_name,const|
      if const[0] != "NONEED"
        const[1].each{|line,data|
          if data.NameChangeFlag == true
            f.printf("---------------------------------------------------\n")
            f.printf("[File] %s ",data.FileName)   
            f.printf("[LineNo] %4d\n",data.LineNo)   
            f.printf("[Sentense] %s\n",line)   
            f.printf("[Changed]\n")   
            f.printf("  %s => %s\n",data.To,data.To_mod) if data.To_mod != nil  
            f.printf("  %s => %s\n",data.FallTo,data.FallTo_mod) if data.FallTo_mod != nil  
            f.printf("  %s => %s\n",data.From,data.From_mod) if data.From_mod != nil  
            f.printf("  %s => %s\n",data.FallFrom,data.FallFrom_mod) if data.FallFrom_mod != nil  
            f.printf("  %s => %s\n",data.Through1,data.Through1_mod) if data.Through1_mod != nil  
            f.printf("  %s => %s\n",data.FallThrough1,data.FallThrough1_mod) if data.FallThrough1_mod != nil  
            f.printf("  %s => %s\n",data.Through2,data.Through2_mod) if data.Through2_mod != nil  
            f.printf("  %s => %s\n",data.FallThrough2,data.FallThrough2_mod) if data.FallThrough2_mod != nil  
            f.printf("  %s => %s\n",data.Signal,data.Signal_mod) if data.Signal_mod != nil  
            f.printf("  %s => %s\n",data.Pin,data.Pin_mod) if data.Pin_mod != nil  
            f.printf("  %s => %s\n",data.Source,data.Source_mod) if data.Source_mod != nil  
            i += 1
          end
        }
      end
    }
    f.close
  end

  #
  # generate remomve_constraint list file
  # 
  def remove_const
    file_name = @dir + "remove_const_list.txt"
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Removed constraint list" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")    
    i = 0
    @attribute_all.each{|attribute_name,data|
      data[1].each{|const|
        f.printf("%s\n",const[0]) if const[1].RemoveFlag
      }
    }
    f.close
  end

  #
  # Synplify Rpt error report
  #
  def rpt_error(error_list)
    file_name = @dir + "rpt_error_list.txt"
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Error attribute list refferd from Synplify Rpt file" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")    
    print_synplify_rpt(f,error_list)
    f.close
  end

  #
  # Synplify Srr error report
  #
  def srr_error(error_list)
    file_name = @dir + "srr_error_list.csv"
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Error attribute list refferd from Synplify Srr file" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")    
    print_synplify_srr(f,error_list)
    f.close
  end

  def print_synplify_srr(f,error_list)
    f.printf("\n")
    f.printf("# Summary\n")
    f.printf("   The total number of error attribute : %d\n",error_list.size)
    f.printf("\n")
    f.printf("# Each error list\n")
=begin # for CSV
    error_list.each{|data|
      p data
      f.printf("%s,",data[0])
      data[1].each{|each|
        f.printf("%s,",each)
      }
      f.printf("%s,",data[2].gsub("\@W",""))
      f.printf("\n")
    } if error_list != nil
=end
    error_list.each{|data|
      f.printf("-----------------------------------------------\n")
      f.printf("[Device Attribute]%s\n",data[0])
      data[1].each{|each|
        f.printf("[FPGA   Attribute]%s\n",each)
      }
      f.printf("  -%s\n",data[2])
      f.printf("\n")
    }
  end

  def print_synplify_rpt(f,error_list)
    f.printf("\n")
    f.printf("# Summary\n")
    f.printf("   The total number of error attribute : %d\n",error_list.size)
    f.printf("\n")
    f.printf("# Each error list\n")
    error_list.each{|data|
      f.printf("-----------------------------------------------\n")
      f.printf("[Device Attribute]%s\n",data[0])
      data[1].each{|each|
        f.printf("[FPGA   Attribute]%s\n",each)
      }
      f.printf("  -%s\n",data[2])
      f.printf("\n")
    }
  end



end
