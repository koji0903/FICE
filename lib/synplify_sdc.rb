#############################################################
#
# Synplify SDC
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
#############################################################
#
# [FUNCTION]
#  Analize SDC Data and make Data Structure for Attribute.
#
# [USAGE]
#   1. Instancce
#   2. execute sdc_read(@IN_SDC) 
#        @IN_SDC : SDC File
#        access @SDC_DATA
#   3. execute analize
#        access @attribute_all
#
#
#############################################################
require "common"
require "constraint"
require "device_scr"

#
# Database for SDC Information
#  Member
#   - num      : the number of attribute
#   - num_rate : the rate of each num/all num
#   - rank     : ranking of all attribute
#   - applied_num : applied number of attribute
#   - applied_num_rate : rate of applied number
#
class SDC_DB_Info
  attr_accessor :num
  attr_accessor :num_rate
  attr_accessor :rank
  attr_accessor :applied_num
  attr_accessor :applied_num_rate
  def initialize
    @num = 0
    @num_rate = 0
    @rank = 0
    @applied_num = 0
    @applied_num_rate = 0
  end
end

#
# Dababase of SDC
#  Member
#   - each attribute, all attribute
#
class SDC_DB
  attr_reader :set
  attr_reader :define_clock
  attr_reader :xc_pulldown
  attr_reader :xc_pullup
  attr_reader :syn_keep
  attr_reader :syn_noclockbuf
  attr_reader :define_multicycle_path
  attr_reader :define_false_path
  attr_reader :define_global_attribute

  attr_accessor :attribute_all

  def initialize
    @set                      = Hash.new
    @define_clock             = Hash.new
    @xc_pulldown              = Hash.new
    @xc_pullup                = Hash.new
    @syn_keep                 = Hash.new
    @syn_noclockbuf           = Hash.new
    @define_multicycle_path   = Hash.new
    @define_false_path        = Hash.new
    @define_global_attribute  = Hash.new

    @attribute_all            = Hash.new

    # attribute_all [Number,SDC_DB_Info]
    @attribute_all = {
      "set"                     => [@set,SDC_DB_Info.new],
      "define_clock"            => [@define_clock,SDC_DB_Info.new],
      "xc_pulldown"             => [@xc_pulldown,SDC_DB_Info.new],
      "xc_pullup"               => [@xc_pullup,SDC_DB_Info.new],
      "syn_keep"                => [@syn_keep,SDC_DB_Info.new],
      "syn_noclockbuf"          => [@syn_noclockbuf,SDC_DB_Info.new],
      "define_multicycle_path"  => [@define_multicycle_path,SDC_DB_Info.new],
      "define_false_path"       => [@define_false_path,SDC_DB_Info.new],
      "define_global_attribute" => [@define_global_attribute,SDC_DB_Info.new],
    }
  end
end

#
# SDC Control Class
#   for Pattern-Mattching
#
class SDCCtrl
  SIGNAL    = "\\s*\\{\\s*(\\S+)\\s*\\}"
  FROM      = "\\s*-from#{SIGNAL}"
  TO        = "\\s*-to#{SIGNAL}"
  THROUGH   = "\\s*-through#{SIGNAL}"
  NUM       = "\\s*(\\d*)\\s*"
  MSIGNAL   = "\\s*\\{(.*)\\}"
  MFROM     = "\\s*-from#{MSIGNAL}"
  MTHROUGH  = "\\s*-through#{MSIGNAL}"
end

#
# SynplifySDC Class
#  - make attribute_all
#
class SynplifySDC

  attr_reader :attribute_all
  attr_reader :SDC_DATA

  def initialize
    @SDC_DATA = Array.new
    @SDC_DB   = SDC_DB.new
    @attribute_all = @SDC_DB.attribute_all
  end

  #
  # Make size of each attribute
  #
  private
  def make_size
    @attribute_all.each_value{|value|
      value[1].num = value[0].size
    }
  end

  #
  # Get Macro Name fro each parameter
  #  - pick up first instanse name
  #     ex ) aaa/bbb/ccc -> aaa (remove "/bbb/ccc")
  #
  private
  def get_MacroName(data)
        # for pickup macro name
    data.SignalMacro = data.Signal_mod.split("/")[0] if data.Signal_mod != nil
    data.PinMacro = data.Pin_mod.split("/")[0] if data.Pin_mod != nil
    data.SourceMacro = data.Source_mod.split("/")[0] if data.Source_mod != nil
    data.FromMacro = data.From_mod.split("/")[0] if data.From_mod != nil
    data.FallFromMacro = data.FallFrom_mod.split("/")[0] if data.FallFrom_mod != nil
    data.ToMacro = data.To_mod.split("/")[0] if data.To_mod != nil
    data.FallToMacro = data.FallTo_mod.split("/")[0] if data.FallTo_mod != nil
    data.Through1Macro = data.Through1_mod.split("/")[0] if data.Through1_mod != nil
    data.Through2Macro = data.Through2_mod.split("/")[0] if data.Through2_mod != nil
    data.Through3Macro = data.Through3_mod.split("/")[0] if data.Through3_mod != nil
    data.Through4Macro = data.Through4_mod.split("/")[0] if data.Through4_mod != nil
    data.FallThrough1Macro = data.FallThrough1_mod.split("/")[0] if data.FallThrough1_mod != nil
    data.FallThrough2Macro = data.FallThrough2_mod.split("/")[0] if data.FallThrough2_mod != nil
    data.FallThrough3Macro = data.FallThrough3_mod.split("/")[0] if data.FallThrough3_mod != nil
    data.FallThrough4Macro = data.FallThrough4_mod.split("/")[0] if data.FallThrough4_mod != nil
  end

  #
  # file read
  #  [arg1] sdc file name
  #  [make] @SDC_DATA : Array of file data
  #
  public
  def sdc_read(sdc_file)
    @SDC_DATA = Common.file_read(sdc_file)
  end

  #
  # def pre_operation
  #   - remove Tcl sentense
  #   - resolve SellVariable
  #
  public
  def pre_operation
    tmp = Array.new
    @SDC_DATA.each{|line|
      # delete comment
      line = Common.remove_after(line,"#")
      line = line.gsub(";","")
      line = line.strip
      next if line == nil
      next if line == "" || line == " " 
      next if line.size == 0
      if /^set/ =~ line
        /^set\s+(\S+)\s+(\S+)/ =~ line
        @SDC_DB.set["#{$1}"] = $2.gsub("\"","")
      else
        tmp << line
      end
    }
    @SDC_DATA = tmp

    tmp = Array.new
    @SDC_DATA.each{|line|
      # Resolve ShellVariable
      while ((/\$/ =~ line) != nil)
        line = resolve_ShellVariable(line)
      end

      tmp << line
    }
    @SDC_DATA = tmp

  end

  #
  # Resolve ShellVariable using "SET" variable
  #  [arg1]   sentence
  #  [return] sentence of resolving shell variable
  #
  def resolve_ShellVariable(id)
    if /\$/ =~ id # use ShellVariable
      /\$(\w+)/ =~ id # $1 = ShellVariable 
      shell = $1
      set = @SDC_DB.set
      if set["#{shell}"] == nil
        $WARNING_CNT += 1
        printf("@W: Shell Variable\(%s\) is not defined. So,\"%s\" attribute is skipped\n",shell, id) if $VERBOSE
        return nil
      else
        original = ("$" + "#{shell}").to_s
        original_s = ("\\$" + "#{shell}").to_s
        modified = @SDC_DB.set["#{shell}"].to_s
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
  # Analize SDC data
  #  - remove unexpected line (Tcl sentence)
  #  - operate separating each attribute
  #
  def analize
        
    printf("@I:analize sdc file\n")
    @SDC_DATA.each{|line|

      next if line == nil
      const_each = ConstEach.new
      line = line.strip
      if /^if/ =~ line || /^\} else/ =~ line || /^\}/ =~ line 
        #
        # !!Caution!! Now, not support!!
        #
      elsif /^#/ =~ line || line == ""
      elsif /define_scope_collection/ =~ line
        #
        # !!Caution!! Now, not support!!
        #
      elsif /define_clock/ =~ line
        /^define_clock\s*\{\s*(\S+)\s*\}\s*-name\s*\{\s*(\S+)\s*\}\s*-([a-zA-Z]*)\s*(\S+)\s*.*/ =~ line
        if $1 == nil || $2 == nil || $3 == nil 
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        else
          const_each.SDC = line
          const_each.SDCAttribute = "define_clock"
          const_each.Signal_mod = name_reverse($1)
          const_each.ClockName = $2
          const_each.Period = $4 if $3 == "period" 
          const_each.Freq = $4 if $3 == "freq"
          @SDC_DB.define_clock["#{line}"] = const_each
        end

      elsif /^define_attribute/ =~ line 
        /^define_attribute\s+\{\s*(\S*)\s*\}\s*\{([a-zA-Z_]*)\}\s+\{\s*(\d*)\s*\}\s*/ =~ line
        const_each.SDC = line
        p line
        if $1 == nil
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
        const_each.Pin_mod = name_reverse($1)
        const_each.SDCAttribute = $2        
        case const_each.SDCAttribute
        when "xc_pulldown" then
          @SDC_DB.xc_pulldown["#{line}"] = const_each
        when "xc_pullup" then
          @SDC_DB.xc_pullup["#{line}"] = const_each
        when "xc_pulldown" then
          @SDC_DB.xc_pulldown["#{line}"] = const_each
        when "syn_keep" then
          @SDC_DB.syn_keep["#{line}"] = const_each
        when "syn_noclockbuf" then
          @SDC_DB.syn_noclockbuf["#{line}"] = const_each
        else
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end

      elsif /^define_attribute/ =~ line 
        /^define_attribute\s+\{\s*(\S*)\s*\}\s*([a-zA-Z_]*)\s+\{\s*(\d*)\s*\}\s*/ =~ line
        const_each.SDC = line
        const_each.Pin_mod = name_reverse($1)
        const_each.SDCAttribute = $2        
        case const_each.SDCAttribute
        when "xc_pulldown" then
          @SDC_DB.xc_pulldown["#{line}"] = const_each
        when "xc_pullup" then
          @SDC_DB.xc_pullup["#{line}"] = const_each
        when "xc_pulldown" then
          @SDC_DB.xc_pulldown["#{line}"] = const_each
        when "syn_keep" then
          @SDC_DB.syn_keep["#{line}"] = const_each
        when "syn_noclockbuf" then
          @SDC_DB.syn_noclockbuf["#{line}"] = const_each
        else
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
      elsif /^define_multicycle_path/ =~ line 
        const_each.SDC  = line
        if(( /^define_multicycle_path\s*#{SDCCtrl::THROUGH}#{SDCCtrl::THROUGH}#{SDCCtrl::NUM}/=~ line ) != nil)
          const_each.Through1_mod = name_reverse($1)
          const_each.Through2_mod = name_reverse($2)
          const_each.Period   = $3
          @SDC_DB.define_multicycle_path["#{line}"] = const_each
        elsif(( /^define_multicycle_path\s*#{SDCCtrl::FROM}#{SDCCtrl::TO}#{SDCCtrl::NUM}/=~ line ) != nil)
          const_each.From_mod = name_reverse($1)
          const_each.To_mod = name_reverse($2)
          const_each.Period   = $3
          @SDC_DB.define_multicycle_path["#{line}"] = const_each
        else
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
      elsif /^define_false_path/ =~ line
        const_each.SDC  = line
        if(( /^define_false_path\s*#{SDCCtrl::FROM}#{SDCCtrl::THROUGH}#{SDCCtrl::TO}/=~ line ) != nil)
          const_each.From_mod = name_reverse($1)
          const_each.Through1_mod = name_reverse($2)
          const_each.To_mod = name_reverse($3)
          @SDC_DB.define_false_path["#{line}"] = const_each
        elsif(( /^define_false_path\s*#{SDCCtrl::MTHROUGH}#{SDCCtrl::MTHROUGH}/=~ line ) != nil)
          const_each.Through1_mod = name_reverse($1.split[0])
          const_each.Through1_mod = name_reverse($2.split[0])
          @SDC_DB.define_false_path["#{line}"] = const_each
        elsif(( /^define_false_path\s*#{SDCCtrl::FROM}#{SDCCtrl::TO}/=~ line ) != nil)
          const_each.From_mod = name_reverse($1)
          const_each.To_mod = name_reverse($2)
          @SDC_DB.define_false_path["#{line}"] = const_each
        elsif(( /^define_false_path\s*#{SDCCtrl::THROUGH}#{SDCCtrl::TO}/=~ line ) != nil)
          const_each.Through1_mod = name_reverse($1)
          const_each.To_mod = name_reverse($2)
          @SDC_DB.define_false_path["#{line}"] = const_each
        elsif(( /^define_false_path\s*#{SDCCtrl::THROUGH}/=~ line ) != nil)
          const_each.Through1_mod = name_reverse($1)
          @SDC_DB.define_false_path["#{line}"] = const_each
        elsif(( /^define_false_path\s*#{SDCCtrl::FROM}/=~ line ) != nil)
          const_each.From_mod = name_reverse($1)
          @SDC_DB.define_false_path["#{line}"] = const_each
        elsif(( /^define_false_path\s*#{SDCCtrl::TO}/=~ line ) != nil)
          const_each.To_mod = name_reverse($1)
          @SDC_DB.define_false_path["#{line}"] = const_each
        elsif(( /^define_false_path\s*#{SDCCtrl::MFROM}/=~ line ) != nil)
          const_each.From_mod = name_reverse($1.split[0])
          @SDC_DB.define_false_path["#{line}"] = const_each
        else
          p line
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
      elsif /^define_global_attribute/ =~ line
        const_each.SDC  = line
        if(( /^define_global_attribute\s+(\S+)\s+\{\d+\}/=~ line ) != nil)
          const_each.SDCAttribute = $1
          @SDC_DB.define_global_attribute["#{line}"] = const_each
        else
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit
        end
      else
        p line
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit
      end
      get_MacroName(const_each) # make Macro Name from signal
    }
    printf("@I:analize sdc file Done\n")

    # make each size
    make_size

  end

  #
  # Namve reverse
  #  - remove identifier of Synplify Pro
  #  - remove "chiptop.chip."
  #
  #  [param]  full path of signal name
  #  [return] only signal name
  #
  def name_reverse(str)
    str = str.gsub("p:","")
    str = str.gsub("i:","")
    str = str.gsub("v:","")
    str = str.gsub("r:","")
    str = str.gsub("n:","")
    str = str.gsub("t:","")
    str = str.gsub("chiptop.chip.","")
    str = str.gsub(".","\/")  
    return str
  end

end
