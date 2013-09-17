############################################################
#
# Device SCR
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
############################################################
#
# [OPERATION]
# - Analize all scr file saved in SCR Directory, and make
#   data structure for accessing other class
# - Other Class Access following data structure
#    - unrecognized_line      : Un-recognized line in SCR file
#    - unrecognized_attribute : Un-recognized attribute in SCR file
#
############################################################
require "common"
require "constraint"
require "scr_parse"

#
# SCR_DB - Database for SCR file
#
class SCR_DB
  attr_reader :set
  attr_reader :report_timing             
  attr_reader :remove_annotated_delay   
  attr_reader :reset_path               
  attr_reader :remove_disable_timing    
  attr_reader :create_clock             
  attr_reader :update_timing            
  attr_reader :report_clock_timing      
  attr_reader :create_generated_clock   
  attr_reader :parse_proc_arguments     
  attr_reader :define_proc_attributes   
  attr_reader :adsar_check_timing       
  attr_reader :adlscut_check_min        
  attr_reader :create_bounds            
  attr_reader :create_placement_keepout 
  attr_reader :remove_attribute         
  attr_reader :set_min_library          
  attr_reader :set_wire_load_mode       
  attr_reader :set_dont_use             
  attr_reader :set_disable_timing       
  attr_reader :set_false_path           
  attr_reader :set_max_delay            
  attr_reader :set_max_time_borrow
  attr_reader :set_min_delay            
  attr_reader :set_input_delay          
  attr_reader :set_annotated_delay      
  attr_reader :set_case_analysis        
  attr_reader :set_dont_touch           
  attr_reader :set_dont_touch_network   
  attr_reader :set_clock_latency        
  attr_reader :set_propagated_clock     
  attr_reader :set_clock_gating_check   
  attr_reader :set_multicycle_path      

  attr_reader :attribute_all

  def initialize(set_max_delay)
    # each attribute
    @set                      = Hash.new
    @report_timing            = Hash.new 
    @remove_annotated_delay   = Hash.new
    @reset_path               = Hash.new
    @remove_disable_timing    = Hash.new
    @create_clock             = Hash.new
    @update_timing            = Hash.new
    @report_clock_timing      = Hash.new
    @create_generated_clock   = Hash.new
    @parse_proc_arguments     = Hash.new
    @define_proc_attributes   = Hash.new
    @adsar_check_timing       = Hash.new
    @adlscut_check_min        = Hash.new
    @create_bounds            = Hash.new
    @create_placement_keepout = Hash.new
    @remove_attribute         = Hash.new
    @set_min_library          = Hash.new
    @set_wire_load_mode       = Hash.new
    @set_dont_use             = Hash.new
    @set_disable_timing       = Hash.new
    @set_false_path           = Hash.new
    @set_max_delay            = Hash.new
    @set_max_time_borrow      = Hash.new
    @set_min_delay            = Hash.new
    @set_input_delay          = Hash.new
    @set_annotated_delay      = Hash.new
    @set_case_analysis        = Hash.new
    @set_dont_touch           = Hash.new
    @set_dont_touch_network   = Hash.new
    @set_clock_latency        = Hash.new
    @set_propagated_clock     = Hash.new
    @set_clock_gating_check   = Hash.new
    @set_multicycle_path      = Hash.new
    @set_clock_gating_check   = Hash.new

    @SetMaxDelay = set_max_delay

    @attribute_all = Hash.new
    # attribute_all = {[Identifire,Data,SDCAttributeName,Function Message,Limiteted Message]}
    @attribute_all = {
      "set"                      => ["NONEED",
                                     @set,
                                     "",
                                     ConstSummary.new,
                                     0,
                                     "Not reflect in SDC file",
      ],                   
      "report_timing"            => ["NONEED",
                                     @report_timing,
                                     "",
                                     ConstSummary.new,
                                     "Output timing report on Circuit",
                                     "Not reflect in SDC file",
      ],            
      "remove_annotated_delay"   => ["NEED",
                                     @remove_annotated_delay,
                                     "",
                                     ConstSummary.new,
                                     "Remove delay annotated between Pins",
                                     "ver0.3.xx : not support",
      ],   
      "reset_path"               => ["NEED",
                                     @reset_path,
                                     "",
                                     ConstSummary.new,
                                     "Reset to single-cycle-timing specified path",
                                     "ver0.3.xx : not support",
      ],               
      "remove_disable_timing"    => ["UNKONWN",
                                     @remove_disable_timing,
                                     "",
                                     ConstSummary.new,
                                     "",
                                     "ver0.3.xx : not support",
      ],    
      "set_disable_timing"       => ["NONEED",
                                     @set_disable_timing,
                                     "define_false_path",
                                     ConstSummary.new,
                                     "Disable timing on Pin, Cell or Port",
                                     "Support. Now, on analizing report file"
      ],
      "create_clock"             => ["NEED",
                                     @create_clock,
                                     "define_clock",
                                     ConstSummary.new,
                                     "Create clock object on current circuit",
                                     "Support. Now, on analizing report file"
      ],             
      "update_timing"            => ["NONEED",
                                     @update_timing,
                                     "",
                                     ConstSummary.new,
                                     "Update report timing",
                                     "ver0.3.xx : not support",
      ],
      "report_clock_timing"      => ["NONEED",
                                     @report_clock_timing,
                                     "",
                                     ConstSummary.new,
                                     "Output clock timing report",
                                     "Not reflect in SDC file",
      ],
      "create_generated_clock"   => ["NEED",
                                     @create_generated_clock,
                                     "",
                                     ConstSummary.new,
                                     "Create new clock from current clock object",
                                     "ver0.3.xx : not support",
      ],
      "parse_proc_arguments"     => ["NONEED",
                                     @parse_proc_arguments,
                                     "",
                                     ConstSummary.new,
                                     "Parse argument to send Tcl procedure",
                                     "Not reflect in SDC file",
      ],
      "define_proc_attributes"   => ["NONEED",
                                     @define_proc_attributes,
                                     "",
                                     ConstSummary.new,
                                     "Define attribute on Tcl procedure",
                                     "Not reflect in SDC file",
      ],
      "adsar_check_timing"       => ["NONEED",
                                     @adsar_check_timing,
                                     "",
                                     ConstSummary.new,
                                     "Not reflect in SDC file",
      ],
      "adlscut_check_min"        => ["NONEED",
                                     @adlscut_check_min,
                                     "",
                                     ConstSummary.new,
                                     "",
                                     "Not reflect in SDC file",
      ],
      "create_bounds"            => ["NONEED",
                                     @create_bounds,
                                     "",
                                     ConstSummary.new,
                                     "",
                                     "Not reflect in SDC file",
      ],
      "create_placement_keepout" => ["NONEED",
                                     @create_placement_keepout,
                                     "",
                                     ConstSummary.new,
                                     "Execute general placement on circuit",
                                     "Not reflect in SDC file",
      ],
      "remove_attribute"         => ["NEED",
                                     @remove_attribute,
                                     "",
                                     ConstSummary.new,
                                     "Remove attribute from design object or library object",
                                     "ver0.3.xx : not support",
      ],
      "set_min_library"          => ["NONEED",
                                     @set_min_library,
                                     "",
                                     ConstSummary.new,
                                     "Set library to use analizing minimum delay",
                                     "Not reflect in SDC file",
      ],
      "set_wire_load_mode"       => ["NONEED",
                                     @set_wire_load_mode,
                                     "",
                                     ConstSummary.new,
                                     "Set the model of wire-load to calucurate wire-capacity",
                                     "Not reflect in SDC file",
      ],
      "set_dont_use"             => ["NONEED",
                                     @set_dont_use,
                                     "",
                                     ConstSummary.new,
                                     "Remove library cell from target library on optimization",
                                     "Not reflect in SDC file",
      ],
      "set_false_path"           => ["NEED",
                                     @set_false_path,
                                     "define_false_path",
                                     ConstSummary.new,
                                     "Remove timing constraint on apecified path",
                                     "[Limitation] Not support include \"Setup\" attribute and multiple through path"
      ],           
      "set_max_delay"            => ["NEED",
                                     @set_max_delay,
                                     "define_path_delay",
                                     ConstSummary.new,
                                     "Set maximum delay on described path",
                                     "Supported all constraints",
      ],
      "set_max_time_borrow"            => ["NEED",
                                           @set_max_time_borrow,
                                           "",
                                           ConstSummary.new,
                                           "Set max time borrow",
                                           "Tool Limitation",
                                          ],
      "set_min_delay"            => ["NEED",
                                     @set_min_delay,
                                     "",
                                     ConstSummary.new,
                                     "Set minimum delay on described path",
                                     "ver0.3.xx : Not support",
      ],            
      "set_input_delay"          => ["NEED",
                                     @set_input_delay,
                                     "",
                                     ConstSummary.new,
                                     "Set input-delay to Pin or input-port basing on Clock signal",
                                     "ver0.3.xx : Not support",
      ],          
      "set_annotated_delay"      => ["NEED",
                                     @set_annotated_delay,
                                     "",
                                     ConstSummary.new,
                                     "Set path-delay annotated between pins",
                                     "ver0.3.xx : Not suppor",
      ],      
      "set_case_analysis"        => ["NEED",
                                     @set_case_analysis,
                                     "xc_pulldown,xc_pullup",
                                     ConstSummary.new,
                                     "Set logical value(1/0) on Port or Pin",
                                     "Support all constraints",
      ],        
      "set_dont_touch"           => ["NEED",
                                     @set_dont_touch,
                                     "syn_keep",
                                     ConstSummary.new,
                                     "Set no-change and no-replace on net,cell,reference,circuit of library cell)",
                                     "Support all constraints",
      ],
      "set_dont_touch_network"   => ["NEED",
                                     @set_dont_touch_network,
                                     "syn_keep",
                                     ConstSummary.new,
                                     "Set no-change and no-replace on fanout cell or net described object",
                                     "Support all constraints",
      ],
      "set_clock_latency"        => ["NEED",
                                     @set_clock_latency,
                                     "",
                                     ConstSummary.new,
                                     "Set clock latency",
                                     "ver0.3.xx : not support",
      ],
      "set_propagated_clock"     => ["NEED",
                                     @set_propagated_clock,
                                     "",
                                     ConstSummary.new,
                                     "Set propagated clock latency",
                                     "ver0.3.xx : not support",
      ],
      "set_clock_gateing_check"  => ["NONEED",
                                     @set_clock_gating_check,
                                     "",
                                     ConstSummary.new,
                                     "Check setup and hold timing on clock gate cell",
                                     "Not reflect in SDC file",
      ],
      "set_multicycle_path"      => ["NEED",
                                     @set_multicycle_path,
                                     "define_multicycle_path",
                                     ConstSummary.new,
                                     "Set multi-cycle-path on described path",
                                     "[Limitation] include \"setup/hold\" optione",
      ]      
    }

    # Change "set_max_delay"
    set_max_delay = @attribute_all["set_max_delay"]
    set_max_delay[0] = "NONEED" if @SetMaxDelay == "OFF"
  end

end


class DeviceSCR
  # Un-Recognized Line from analizing SCR
  attr_reader :unrecognized_line
  # Un-Recognized Attribute for report
  attr_reader :unrecognized_attribute
  # Un-Analized Attribute List for report
  attr_reader :UnAnalizedAttributeList
  # Un-Converted Attribute list for report
  attr_reader :UnConvertedAttributeList
  # No-Need Attribute List
  attr_reader :NoNeedAttributeList
  # Remve Macro list
  attr_reader :RM_MACRO


  # SCR File List saved in described directory
  attr_reader :FILE_LIST
  # Data Structure ALL SCR Attribute
  attr_reader :attribute_all

  #
  # Initialize
  #  [arg1] Directory Name save scr file
  #
  def initialize(dir_name,rmlist,set_max_delay)
    @scr_dir = dir_name
    @RMLIST = rmlist
    # Has Defalt value about "PHASE/MODE"
    @ShellVariable = {"PHASE" => "PHYSOPT", 
      "phase" => "PHYSOPT", 
      "MODE" => "NORMAL", 
      "mode" => "normal",
      "voltage" => "2.1v" 
    }
    @RM_MACRO = Hash.new
    @UnConvertedAttributeList = Array.new
    @FILE_LIST = Hash.new
    @unrecognized_line = Array.new
    @attribute = Hash.new

    @unrecognized_attribute = Array.new
    @UnAnalizedAttributeList = Array.new
    @NoNeedAttributeList = Array.new

    @db = SCR_DB.new(set_max_delay)
    @attribute_all = @db.attribute_all

    @ICECustom = {
      "cpu\\/alu\\/ES_reg\\*\\/H01" => "cpu/alu/ES_sv_reg*/H01 cpu/alu/ES_usr_reg*/H01",
      "cpu\\/alu\\/SP_reg\\*\\/H01" => "cpu/alu/SP_sv_reg*/H01 cpu/alu/SP_usr_reg*/H01",
      "cpu\\/alu\\/CS_reg\\*\\/H01" => "cpu/alu/CS_sv_reg*/H01 cpu/alu/CS_usr_reg*/H01",
    }


  end
    
  #
  # Read all SCR File save in directory
  #   - save @FILE_LIST["{FILE_NAME}"] = DATA
  #   - save line informatnion to @attribute  
  #
  private
  def scr_read
    Dir::glob("#{@scr_dir}/*").each{|name|
      @FILE_LIST["#{name}"] = Common.file_read("#{name}")
    }
    if @FILE_LIST == { }
      # Error : There is no scr files.      
      $ERROR_CNT += 1
      printf("@E:There is no scr file in \"%s\" directory. please check directory path or save scr file(s) in \"%s\".\n",@scr_dir,@scr_dir)
      Common.print_summary
      exit
    end
  end

  #
  # Analize all scr file
  #  - remove unrecognized line( Tcl sentense )
  #  - save 
  #
  private
  def analize
    ###### FILTERING ATTRIBUTE #####
    @FILE_LIST.each{|file,data|
      printf("@I:Analize %s\n",file)
      flag = false
      line_num = 1
      line_num_tmp = 0
      line_pre = nil

#      data.each{|line|
      i = 0
      if_flag = false
      if_enable = false
      ignored_flag = false
      nest_cnt = 0
      while data[i] != nil do
        line = data[i]
        if if_flag == true
          line = line_pre.to_s + " " + line.to_s
          if_flag = false
        end
        line.strip!
        if /^\s*#/ =~ line # comment line
        elsif line == "" # brank
        elsif /\\$/ =~ line # continue line
          line.chop! # delete "\" 
          line_pre = line_pre.to_s + line.to_s
          line_num_tmp = line_num if flag == false
          flag = true
        elsif /^\s*\{/ =~ line # continued line
        elsif /^\s*\}/ =~ line # continued line
          if if_enable
            nest_cnt -= 1
            if_enable = false if nest_cnt == 0
          end
          ignored_flag = false
        elsif /^\s*if/ =~ line
          if_enable = true
          laxer = Lexer.new("#{line}"); tokens = laxer.tokens
          param_start = tokens.index("{"); param_end = tokens.index("}")
          if param_end == nil # continued line
            line_pre = line.to_s
            line_num_tmp = line_num if flag == false
            if_flag = true
          else
            condition_tokens = []; sentense_tokens = []
            condition_tokens = tokens[(param_start+1)..(param_end-1)]
            sentense_tokens  = tokens[(param_end+1)..(tokens.size-1)]
            # get sub_condition
            if condition_tokens != nil
              ignored_flag = analize_condition(ignored_flag,condition_tokens)
            else
              printf("@E:Cannnot analize \"%s\"\n",line)
              Common.internal_error(__FILE__,__LINE__)
            end
            param_start = sentense_tokens.index("{"); param_end = sentense_tokens.index("}")
            if param_start != nil && param_end == nil
              nest_cnt += 1
            end
          end
        elsif ( /^\s*echo/ =~ line ) \
          || ( /^\s*foreach/ =~ line ) \
          || ( /^\s*proc/ =~ line ) \
          || ( /^\s*quit/ =~ line ) \
          || ( /^\s*\}/ =~ line ) \
          || ( /^\s*\(/ =~ line ) 
          @unrecognized_line << line
          # shell grammer
        else
          if ignored_flag == false
            flag = save_attribute(file,flag,line,line_pre,line_num,line_num_tmp)
            line_pre = ""
          end
        end  
        line_num += 1
        i += 1
      end
    }
  end
  
  def analize_condition(ignored_flag,condition_tokens)
#    return condition_tokens == nil
    if condition_tokens.size == 5 # 1-Condition
      ignored_flag = judge_mode_phase_condition(ignored_flag,condition_tokens)
    elsif condition_tokens.size == 7 # 1-Condition
      ignored_flag = judge_mode_phase_condition(ignored_flag,condition_tokens[1..5])
    else                          # over
      if condition_tokens[0] == "(" && condition_tokens[1] == "(" && condition_tokens[(condition_tokens.size-2)] == ")" && condition_tokens[(condition_tokens.size-1)] == ")" 
        condition_tokens = condition_tokens[1..(condition_tokens.size-2)]
      end
      ignored_flag = judge_mode_phase_condition(ignored_flag,condition_tokens[1..5])
      comparator = condition_tokens[7]
      if condition_tokens != nil
        if condition_tokens.size == 11
          if condition_tokens[5] == "&"
            ignored_flag = judge_mode_phase_condition(ignored_flag,condition_tokens[0..4])
            ignored_flag = judge_mode_phase_condition(ignored_flag,condition_tokens[6..10])
          else
            Common.internal_error(__FILE__,__LINE__)
          end
        else
          ignored_flag = analize_condition(ignored_flag,condition_tokens[8..(condition_tokens.size-1)])
        end
      else
        Common.internal_error(__FILE__,__LINE__)
      end
    end
    ignored_flag
  end

  def judge_mode_phase_condition(ignored_flag,condition_tokens)
    condition_variable = condition_tokens[0]
    comparator         = condition_tokens[1]
    judge_variable     = condition_tokens[3]

    case condition_variable
    when "$MODE"
      if comparator == "=="
        ignored_flag = true if judge_variable != "NORMAL" && judge_variable != "NORMAL2" && judge_variable != "NORMAL3"
      elsif comparator == "!="
        ignored_flag = true if judge_variable == "NORMAL" || judge_variable == "NORMAL2" || judge_variable == "NORMAL3"
      else
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit
      end
    when "$PHASE"
      if comparator == "=="
        ignored_flag = true if judge_variable != "PHYSOPT"
      elsif comparator == "!="
        ignored_flag = true if judge_variable == "PHYSOPT"
      else
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit
      end        
    when "$voltage"
      if comparator == "=="
        ignored_flag = true if judge_variable != "2.1v"
      elsif comparator == "!="
        ignored_flag = true if judge_variable == "2.1v"
      else
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit
      end        
      #    else
      #      ignored_flag = true
    end
    ignored_flag
  end
  
  def save_attribute(file,flag,line,line_pre,line_num,line_num_tmp)
    each = ConstEach.new
    each.FileName = file
    if flag == true # combine previous line
      line = line_pre.to_s + " " + line.to_s
      line_pre = nil
      each.LineNo = line_num_tmp
      flag = false
    else
      each.LineNo = line_num
    end
    line.strip! # remove head and tail space
    if line != "" && line != nil && line.size != 0
      if ( @attribute["#{line}"] != nil )
        $WARNING_CNT += 1
        printf("@W:%s is multiple defined. It was overwritten\n",line) 
      end
      # save Hash table
      @attribute["#{line}"] = each
    end
    flag
  end

  #
  # Get each attribute from @attribute
  #  - remove comment
  #  - pattern-maching for scr attribute name
  #
  private
  def get_each_attribute
    @attribute.each{|line,info|
      line = Common.remove_after(line,";")# remove comment include enable line
      line = Common.remove_after(line,"#")# remove comment include enable line
      line = line.gsub("\t"," ")

      if /^set\s+/ =~ line
        @db.set["#{line}"] = info
      elsif /^report_timing\s*/ =~ line
        @db.report_timing["#{line}"] = info
      elsif /^remove_annotated_delay\s+/ =~ line
        @db.remove_annotated_delay["#{line}"] = info
      elsif /^reset_path\s+/ =~ line
        @db.reset_path["#{line}"] = info
      elsif /^remove_disable_timing\s+/ =~ line
        @db.remove_disable_timing["#{line}"] = info
      elsif /^create_clock\s+/ =~ line
        @db.create_clock["#{line}"] = info
      elsif /^update_timing\s+/ =~ line
        @db.update_timing["#{line}"] = info
      elsif /^report_clock_timing\s+/ =~ line
        @db.report_clock_timing["#{line}"] = info
      elsif /^create_generated_clock\s+/ =~ line
        @db.create_generated_clock["#{line}"] = info
      elsif /^parse_proc_arguments\s+/ =~ line
        @db.parse_proc_arguments["#{line}"] = info
      elsif /^define_proc_attributes\s+/ =~ line
        @db.define_proc_attributes["#{line}"] = info
      elsif /^adsar_check_\$timing\s+/ =~ line
        @db.adsar_check_timing["#{line}"] = info
      elsif /^adlscut_check_min\s+/ =~ line
        @db.adlscut_check_min["#{line}"] = info
      elsif /^create_bounds\s+/ =~ line
        @db.create_bounds["#{line}"] = info
      elsif /^create_placement_keepout\s+/ =~ line
        @db.create_placement_keepout["#{line}"] = info
      elsif /^remove_attribute\s+/ =~ line
        @db.remove_attribute["#{line}"] = info
      elsif /^set_min_library\s+/ =~ line
        @db.set_min_library["#{line}"] = info
      elsif /^set_wire_load_mode\s+/ =~ line
        @db.set_wire_load_mode["#{line}"] = info
      elsif /^set_dont_use\s+/ =~ line
        @db.set_dont_use["#{line}"] = info
      elsif /^set_disable_timing\s+/ =~ line
        @db.set_disable_timing["#{line}"] = info
      elsif /^set_false_path\s+/ =~ line
        @db.set_false_path["#{line}"] = info
      elsif /^set_max_delay\s+/ =~ line
        @db.set_max_delay["#{line}"] = info
      elsif /^set_max_time_borrow\s+/ =~ line
        @db.set_max_time_borrow["#{line}"] = info
      elsif /^set_min_delay\s+/ =~ line
        @db.set_min_delay["#{line}"] = info
      elsif /^set_input_delay\s+/ =~ line
        @db.set_input_delay["#{line}"] = info
      elsif /^set_annotated_delay\s+/ =~ line
        @db.set_annotated_delay["#{line}"] = info
      elsif /^set_case_analysis\s+/ =~ line
        @db.set_case_analysis["#{line}"] = info
      elsif /^set_dont_touch\s+/ =~ line
        @db.set_dont_touch["#{line}"] = info
      elsif /^set_dont_touch_network\s+/ =~ line
        @db.set_dont_touch_network["#{line}"] = info
      elsif /^set_clock_latency\s+/ =~ line
        @db.set_clock_latency["#{line}"] = info
      elsif /^set_propagated_clock\s+/ =~ line
        @db.set_propagated_clock["#{line}"] = info
      elsif /^set_clock_gating_check\s+/ =~ line
        @db.set_clock_gating_check["#{line}"] = info
      elsif /^set_multicycle_path\s+/ =~ line
        @db.set_multicycle_path["#{line}"] = info
      else
        @unrecognized_attribute << [line,info]
      end  
    }

  end

  #
  # Analize each atribute using Attribute Data structure
  #  - opearatin each SCR attribute.
  #  - make @UnAnalizdAttributeList
  #
  private
  def analize_each_attribute
    printf("@I:Analize each attribute\n")
    # set_false_path
    if @db.set_false_path.size != 0
      cls_set_false_path = SetFalsePath.new(@db.set_false_path)
      cls_set_false_path.analize
      @UnAnalizedAttributeList = cls_set_false_path.UnAnalizedAttributeList
      attribute = "set_false_path"
      if cls_set_false_path.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # set_max_delay
    if @db.set_max_delay.size != 0
      cls_set_max_delay = SetMaxDelay.new(@db.set_max_delay)
      cls_set_max_delay.analize
      @UnAnalizedAttributeList += cls_set_max_delay.UnAnalizedAttributeList
      attribute = "set_max_delay"
      if cls_set_max_delay.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # set_dont_touch
    if @db.set_dont_touch.size != 0
      cls_set_dont_touch = SetDontTouch.new(@db.set_dont_touch)
      cls_set_dont_touch.analize
      @UnAnalizedAttributeList += cls_set_dont_touch.UnAnalizedAttributeList
      attribute = "set_dont_touch"
      if cls_set_dont_touch.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # set_disable_timing
    if @db.set_disable_timing.size != 0
      cls_set_disable_timing = SetDisableTiming.new(@db.set_disable_timing)
      cls_set_disable_timing.analize
      @UnAnalizedAttributeList += cls_set_disable_timing.UnAnalizedAttributeList
      attribute = "set_disable_timing"
      if cls_set_disable_timing.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # set_case_analysis
    if @db.set_case_analysis != 0
      cls_set_case_analysis = SetCaseAnalysis.new(@db.set_case_analysis)
      cls_set_case_analysis.analize
      @UnAnalizedAttributeList += cls_set_case_analysis.UnAnalizedAttributeList
      attribute = "set_case_analysis"
      if cls_set_case_analysis.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # remove_attribute
    if @db.remove_attribute.size != 0
      cls_remove_attribute = RemoveAttribute.new(@db.remove_attribute)
      cls_remove_attribute.analize
      @UnAnalizedAttributeList += cls_remove_attribute.UnAnalizedAttributeList
      attribute = "remove_attribute"
      if cls_remove_attribute.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # create_clock
    if @db.create_clock.size != 0
      cls_create_clock = CreateClock.new(@db.create_clock)
      cls_create_clock.analize
      @UnAnalizedAttributeList += cls_create_clock.UnAnalizedAttributeList
      attribute = "create_clock"
      if cls_create_clock.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # reset_path
    if @db.reset_path != 0
      cls_reset_path = ResetPath.new(@db.reset_path)
      cls_reset_path.analize
      @UnAnalizedAttributeList += cls_reset_path.UnAnalizedAttributeList
      attribute = "reset_path"
      if cls_reset_path.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # set_min_delay
    if @db.set_min_delay.size != 0
      cls_set_min_delay = SetMinDelay.new(@db.set_min_delay)
      cls_set_min_delay.analize
      @UnAnalizedAttributeList += cls_set_min_delay.UnAnalizedAttributeList
      attribute = "set_min_delay"
      if cls_set_min_delay.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # set_annotated_delay
    if @db.set_annotated_delay.size != 0
      cls_set_annotated_delay = SetAnnotatedDelay.new(@db.set_annotated_delay)
      cls_set_annotated_delay.analize
      @UnAnalizedAttributeList += cls_set_annotated_delay.UnAnalizedAttributeList 
      attribute = "set_annotated_delay"
      if cls_set_annotated_delay.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # set_multicycle_path
    if @db.set_multicycle_path != 0
      cls_set_multicycle_path = SetMulticyclePath.new(@db.set_multicycle_path)
      cls_set_multicycle_path.analize
      @UnAnalizedAttributeList += cls_set_multicycle_path.UnAnalizedAttributeList 
      attribute = "set_multicycle_path"
      if cls_set_multicycle_path.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # create_generated_clock
    if @db.create_generated_clock != 0
      cls_create_generated_clock = CreateGeneratedClock.new(@db.create_generated_clock)
      cls_create_generated_clock.analize
      @UnAnalizedAttributeList += cls_create_generated_clock.UnAnalizedAttributeList 
      attribute = "create_generated_clock"
      if cls_create_generated_clock.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end
    
    # set_input_delay
    if @db.set_input_delay.size != 0
      cls_set_input_delay = SetInputDelay.new(@db.set_input_delay)
      cls_set_input_delay.analize
      @UnAnalizedAttributeList += cls_set_input_delay.UnAnalizedAttributeList 
      attribute = "set_input_delay"
      if cls_set_input_delay.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # remove_disable_timing
    if @db.remove_disable_timing.size != 0
      cls_remove_disable_timing = RemoveDisableTiming.new(@db.remove_disable_timing)
      cls_remove_disable_timing.analize
      @UnAnalizedAttributeList += cls_remove_disable_timing.UnAnalizedAttributeList 
      attribute = "remove_disable_timing"
      if cls_remove_disable_timing.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # set_dont_touch_network
    if @db.set_dont_touch_network.size != 0
      cls_set_dont_touch_network = SetDontTouchNetwork.new(@db.set_dont_touch_network)
      cls_set_dont_touch_network.analize
      @UnAnalizedAttributeList += cls_set_dont_touch_network.UnAnalizedAttributeList 
      attribute = "set_dont_touch_network"
      if cls_set_dont_touch_network.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # remove_annotated_delay
    if @db.remove_annotated_delay != 0
      cls_remove_annotated_delay = RemoveAnnotatedDelay.new(@db.remove_annotated_delay)
      cls_remove_annotated_delay.analize
      @UnAnalizedAttributeList += cls_remove_annotated_delay.UnAnalizedAttributeList 
      attribute = "remove_annotated_delay"
      if cls_remove_annotated_delay.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # set_propagated_clock
    if @db.set_propagated_clock.size != 0
      cls_set_propagated_clock = SetPropagatedClock.new(@db.set_propagated_clock)
      cls_set_propagated_clock.analize
      @UnAnalizedAttributeList += cls_set_propagated_clock.UnAnalizedAttributeList 
      attribute = "set_propagated_clock"
      if cls_set_propagated_clock.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end

    # set_clock_latency
    if @db.set_clock_latency.size != 0
      cls_set_clock_latency = SetClockLatency.new(@db.set_clock_latency)
      cls_set_clock_latency.analize
      @UnAnalizedAttributeList += cls_set_clock_latency.UnAnalizedAttributeList 
      attribute = "set_clock_latency"
      if cls_set_clock_latency.UnAnalizedAttributeList.size == 0
        printf("\t%-30s ... Done\n",attribute)
      else
        printf("\t%-30s ... Done with UnAnalized attribute\n",attribute)
      end
    end
  end
  
  #
  # make_ShellVariable
  #
  private
  def make_ShellVariable
    set = @attribute_all["set"]
    set[1].each_key{|line|
      line = line.gsub("\t","")
      if((/^set\s+(\S*)\s+\[(.*)\]/ =~ line) != nil)
        @ShellVariable["#{$1}"] = $2
      elsif((/^set\s+\S*\s+\$\{.*\}/ =~ line) != nil)
        tmp = line.split
        @ShellVariable["#{tmp[1]}"] = tmp[2]
      elsif((/^set\s+\S*\s+\w*/ =~ line) != nil)
        tmp = line.split
        @ShellVariable["#{tmp[1]}"] = tmp[2]        
      else
        $ERROR_CNT += 1
        printf("@E:Unresolve shell-variable.\"%s\"\n",line)
      end
    }

    shell_org = @ShellVariable
    shell = Hash.new
    shell_org.each{|key,data|
      while ((/\$/ =~ data) != nil)
        # Resolve ShellVariable
        data = resolve_ShellVariable(data)
      end
      shell_org["#{key}"] = data
   }
    @ShellVariable = shell_org
  end

  #
  # resolve_ShellVariable
  # [arg1]   sentense
  # [return] settense resolved shell variable
  #
  private
  def resolve_ShellVariable(id)
    if /\$/ =~ id # use ShellVariable
      /\$(\w+)/ =~ id # $1 = ShellVariable 
      shell = $1
      if shell == nil
        /\$\{(\w+)\}/ =~ id # $1 = ShellVariable 
        shell = $1
      end

      if shell == "CLOCK"
        return "CLOCK"
      elsif @ShellVariable["#{shell}"] == nil
        $WARNING_CNT += 1
        printf("@W: Shell Variable\(%s\) is not defined. So,\"%s\" attribute is skipped\n",shell, id) 
        return nil
      else
        original = ("$" + "#{shell}").to_s
        original_s = ("\\$" + "#{shell}").to_s
        modified = @ShellVariable["#{shell}"].to_s
        id = id.gsub("#{original}","#{modified}")
        original = ("${" + "#{shell}" + "}").to_s
        original_s = ("\\$" + "#{shell}").to_s
        modified = @ShellVariable["#{shell}"].to_s
        id = id.gsub("#{original}","#{modified}")
        if ((/#{original_s}/ =~ id ) != nil)
          printf("@W: Shell Variable\(%s\) found same line. So,\"%s\" attribute is skipped\n",shell, id) if $VERBOSE
          return nil
        end
      end
    else
    end
    return id
  end
  

  #
  # spread_ShellVariable
  #
  private
  def spread_ShellVariable


    @attribute_all.each{|key,value|
      if value[0] != "NONEED"
        value[1].each{|key,value|
          tmp = key
          while ((/\$/ =~ tmp) != nil)
            tmp = resolve_ShellVariable(tmp)
          end
          value.ModLine = tmp
          if value.ModLine == nil
            value.RemoveFlag = true 
            $NOTE_CNT += 1
            value.ModLine = key
            printf("@N:\"%s\" is removed because Environment Variable cannot resolved\n",key)
          end

          @ICECustom.each{|before,after|
            if (/#{before}/ =~ value.ModLine) != nil
              before = before.gsub("\\","")
              value.ModLine = value.ModLine.sub("#{before}","#{after}")
            end
          }
          value.ModLine = value.ModLine.gsub("{","").gsub("}","")
        }
      end
    }
  end

  #
  # Make data structure for output SDC
  #
  private
  def make_sdc_sentence
    printf("@I:make each constraint infomation in SDC file\n")
    @attribute_all.each{|attribute_name,const|
      if const[0] != "NONEED"
        case attribute_name
        when "create_clock" then
          next if const[1].size == 0
          cls = CreateClock.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "remove_attribute" then
          next if const[1].size == 0
          cls = RemoveAttribute.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "remove_annotated_delay" then
          next if const[1].size == 0
          cls = RemoveAnnotatedDelay.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_dont_touch" then
          next if const[1].size == 0
          cls = SetDontTouch.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_case_analysis" then
          next if const[1].size == 0
          cls = SetCaseAnalysis.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_min_delay" then
          next if const[1].size == 0
          cls = SetMinDelay.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "reset_path" then
          next if const[1].size == 0
          cls = ResetPath.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_max_delay" then
          next if const[1].size == 0
          cls = SetMaxDelay.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_clock_latency" then
          next if const[1].size == 0
          cls = SetClockLatency.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "create_generated_clock" then
          next if const[1].size == 0
          cls = CreateGeneratedClock.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "remove_disable_timing" then
          next if const[1].size == 0
          cls = RemoveDisableTiming.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_propagated_clock" then
          next if const[1].size == 0
          cls = SetPropagatedClock.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_dont_touch_network" then
          next if const[1].size == 0
          cls = SetDontTouchNetwork.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_multicycle_path" then
          next if const[1].size == 0
          cls = SetMulticyclePath.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_false_path" then
          next if const[1].size == 0
          cls = SetFalsePath.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_disable_timing" then
          next if const[1].size == 0
          cls = SetDisableTiming.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_input_delay" then
          next if const[1].size == 0
          cls = SetInputDelay.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_annotated_delay" then
          next if const[1].size == 0
          cls = SetAnnotatedDelay.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        when "set_max_time_borrow" then
          next if const[1].size == 0
          cls = SetMaxTimeBorrow.new(const[1])
          cls.convert(const[2])
          @UnConvertedAttributeList += cls.UnConvertedAttributeList 
          attribute = "#{attribute_name}"
          if cls.UnConvertedAttributeList.size == 0
            printf("\t%-30s ... Done\n",attribute)
          else
            printf("\t%-30s ... Done with UnConverted attribute\n",attribute)
          end
        else
          $ERROR_CNT += 1
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
      else
        next if const[1].size == 0
        const[1].each{|line,data|
          if data.ModLine == nil
            @NoNeedAttributeList << [line,data]
          end
        }
      end
    }
  end

  #
  # Remove Constraint
  # - using RMLIST from argument list
  # - remove attribute if using macro describes on RMLIST
  #
  private
  def remove_const
    line_cnt = 0
    data = Common.file_read(@RMLIST)
    data.each{|line|
      line_cnt += 1
      # delete comment
      line = Common.remove_after(line,"//")
      next if line == nil || line == ""
      tmp = line.split[0]
      @RM_MACRO["#{tmp}"] = "Removed Macro"
    }
    const_ctrl = ConstCtrl.new
    const_ctrl.judge_remove_macro(@attribute_all,@RM_MACRO)
  end

  #
  # make lst file
  #  - list file is for each attribute
  #
  private
  def make_lst_file
    @attribute_all.each{|key,value|
      generate_lst(key,value[1]) if value[1].size != 0
    }
  end

  #
  # generate each lst file
  #
  private
  def generate_lst(filename,data)
    file_name = "tmp/" + filename + ".lst"
    f = open("#{file_name}","w")
    data.each_key{|line|
      f.printf("%s\n",line)
    }
    f.close
  end

  #
  # Main operation deviceSCR
  #  1.scr_read               :Read SCR File save in user described directory
  #  2.analize                :Analize each SCR( pick up un-recognized line )
  #  3.get_each_attribute     :Get each attribute( if found unexpected attribute, save in @unrecognized_attribute)
  #  4.make_ShellVaribable    :Make Shell Variable from "set" sentence
  #  5.sprread_ShellVariable  :Spread Shell Variable using 4's step result
  #  6.analize_each_attribute :Analize each attribute and pick up un-analized line
  #  7.remove_const           :Remove constraint using RMLIST information
  #  8.make_sdc_sentence      :Make SDC Data whith converting constraint format
  #  9.make_lst_file          :make lst file for debug
  #
  public
  def main
    scr_read
    analize
    get_each_attribute
    make_ShellVariable
    spread_ShellVariable
    analize_each_attribute
    remove_const if @RMLIST != nil
    make_sdc_sentence
    make_lst_file
  end
  


end
