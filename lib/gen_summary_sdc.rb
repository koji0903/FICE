#############################################################
#
# Generate Summary report
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#  Date       : Jan 13, 2010
#
#############################################################

class GenSummarySDC

  def initialize(dir,attribute_all)
    @dir = dir
    @attribute_all = attribute_all

    # for summary
    @total_num = 0
  end
  
  def summary
    file_name = @dir + "constraint.summary" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "Constraint Summary from SDC file" 
    Common.print_file_header(f,"#{comment}",$TOOL,$VERSION,"##")

    # global summary
    global_summary(f)

    # each attribute
    each_attribute(f)
    
    # detail each attribute
    detail_attribute(f)

    f.close
  end

  def global_summary(f)
    f.printf("## Global\n")
    @attribute_all.each_value{|each_attribute|
      @total_num += each_attribute[1].num
    }
    f.printf("The total number of constraint on SDC: %5d\n",@total_num)
    f.printf("\n")
  end

  def each_attribute(f)
    i = 1
    f.printf("## Each Attribute\n")
    f.printf("+--+---------------------------+-------------------+-------------------+\n")
    f.printf("|No| Attribute Name            |   const number(%%) | applied number(%%) |\n")
    f.printf("+--+---------------------------+-------------------+-------------------+\n")
    @attribute_all.sort_by{|key,value|
      -value[1].num
    }.each{|key,value|
      next if key == "set"
      value[1].rank = i # make Rank

      # get applied number
      value[0].each_value{|each_const|
        if each_const.ConstCheckFlag == 1
          value[1].applied_num += 1
        end
      }
      

      # make const number
      value[1].num_rate = (value[1].num*100).to_f/@total_num.to_f
      if value[1].num_rate == 100;    all = "%4d/%4d(%2.2f%%) "
      elsif value[1].num_rate >= 10;  all = "%4d/%4d( %2.2f%%) "
      else                     all = "%4d/%4d(  %2.2f%%) ";end

      # make applied number
      if value[1].num != 0
        value[1].applied_num_rate = (value[1].applied_num*100).to_f/value[1].num.to_f
      else
        value[1].applied_num_rate = 0.00
      end
      if value[1].applied_num_rate == 100;    applied = "%4d/%4d(%2.2f%%) "
      elsif value[1].applied_num_rate >= 10;  applied = "%4d/%4d( %2.2f%%) "
      else                     applied = "%4d/%4d(  %2.2f%%) ";end

      f.printf("|%2d| %-25s |#{all}|#{applied}|\n" \
               ,value[1].rank \
               ,key \
               ,value[1].num \
               ,@total_num \
               ,value[1].num_rate \
               ,value[1].applied_num \
               ,value[1].num \
               ,value[1].applied_num_rate \
               )
      i += 1
    }
    f.printf("+--+---------------------------+-------------------+-------------------+\n")

    # make total number
    const_total_num  = 0
    const_total_applied_num = 0
    @attribute_all.each_value{|value|
      const_total_num += value[1].num
      const_total_applied_num += value[1].applied_num
    }
    const_total_rate = (const_total_num*100).to_f/@total_num.to_f
    if const_total_rate == 100;    const_all = "%4d/%4d(%2.2f%%) "
    elsif const_total_rate >= 10;  const_all = "%4d/%4d( %2.2f%%) "
    else                           const_all = "%4d/%4d(  %2.2f%%) ";end
    const_total_applied_rate = (const_total_applied_num*100).to_f/const_total_num.to_f
    if const_total_applied_rate == 100;    const_applied_rate = "%4d/%4d(%2.2f%%) "
    elsif const_total_applied_rate >= 10;  const_applied_rate = "%4d/%4d( %2.2f%%) "
    else                                  const_applied_rate = "%4d/%4d(  %2.2f%%) ";end
    f.printf("| -| Total                     |#{const_all}|#{const_applied_rate}|\n" \
               ,const_total_num \
               ,@total_num \
               ,const_total_rate \
               ,const_total_applied_num \
               ,const_total_num \
               ,const_total_applied_rate \
             )
    f.printf("+--+---------------------------+-------------------+-------------------+\n")
    f.printf("\n")
  end

  def detail_attribute(f)
    f.printf("\n## Detail of each attribute\n\n")
    @attribute_all.sort_by{|key,value|
      value[1].rank
    }.each{|attribute_name,attribute_data|
      next if attribute_name == "set"
      f.printf("# No %d: %s\n",attribute_data[1].rank,attribute_name)
      f.printf("   Number of Constraint               :      %4d\n", attribute_data[1].num)
      f.printf("   Number(Rate) of Applied Constraint : %4d/%4d( %2.2f%%)\n", attribute_data[1].applied_num,attribute_data[1].num,attribute_data[1].applied_num_rate)
      f.printf("\n")

      # detail
      f.printf("   %s(total number:%d)\n","Detail include Macro Infomation",attribute_data[1].num)
      attribute_data[0].each{|key,value|
        if value.ConstCheckFlag == 1
          judge = "OK"
        else
          judge = "NG"
        end
        f.printf("    %s : %s\n",judge,key)
      }

      f.printf("\n\n")
    }
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


end
