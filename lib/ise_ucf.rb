#############################################################
#
# ISE UCF
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
############################################################
require "common"

#
#* TIMESPEC_each
#  * TIMESPEC FORMAT : TIMESPEC "TS_NAME" = PERIOD "TNM_NAME" "PERIOD" "MEASURE" "LEVEL" "DUTY"
#
class TIMESPECInf
  attr_accessor :TS_NAME
  attr_accessor :TNM_NAME
  attr_accessor :PERIOD
  attr_accessor :MEASURE
  attr_accessor :LEVEL    # "HIGH" or "LOW"
  attr_accessor :DUTY
  attr_accessor :PRIORITY
  attr_accessor :FreqFlag
  attr_accessor :DutyFlag
  def initialize(udef=nil)
    @TS_NAME  = nil
    @TNM_NAME = nil
    @PERIOD   = nil
    @MEASURE  = nil
    @LEVEL    = nil
    @DUTY     = nil
    @PRIORITY = nil
    @FreqFlag = 0
    @DutyFlag = false    

    @FREQ_TS  = get_freq(Common.file_read(udef,"off"))[0] if udef != nil
    @FREQ_TS2  = get_freq(Common.file_read(udef,"off"))[1] if udef != nil
    @DUTY_CHANGE  = get_duty(Common.file_read(udef,"off")) if udef != nil
  end

  def make_data(line)
    tmp = line.split
    if tmp.size == 9
      @TS_NAME  = tmp[1]
      @TNM_NAME = tmp[4]
      @PERIOD   = tmp[5]
      @MEASURE  = tmp[6]
      @LEVEL    = tmp[7]
      @DUTY     = tmp[8]
    elsif tmp.size == 10
      @TS_NAME  = tmp[1]
      @TNM_NAME = tmp[4]
#      @PERIOD   = tmp[5]
      @MEASURE  = "ns"
      @LEVEL    = "HIGH"
      @DUTY     = tmp[9]
#      @PRIORITY = tmp[10]
    elsif tmp.size == 11
      @TS_NAME  = tmp[1]
      @TNM_NAME = tmp[4]
      @PERIOD   = tmp[5]
      @MEASURE  = tmp[6]
      @LEVEL    = tmp[7]
      @DUTY     = tmp[8]
      @PRIORITY = tmp[10]
    else
#      $ERROR_CNT += 1
#      printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
#      p line
#      exit
#      return 1
    end
    if @DUTY_CHANGE.index("#{@TS_NAME}") != nil
      @DutyFlag = true
    end if @DUTY_CHANGE != nil
    if @FREQ_TS.index("#{@TS_NAME}") != nil
      @FreqFlag = 1
    end if @FREQ_TS != nil
    if @FREQ_TS2.index("#{@TS_NAME}") != nil
      @FreqFlag = 2
    end if @FREQ_TS2 != nil
#    return 0
  end

  def error
    Common.print_summary
    exit 1
  end

  def get_freq(udef_data)
    freq = []
    freq2 = []
    udef_data.each{|line|
      group = line.split(":")[0]
      additional = line.split(":")[1]
      if group != nil
        clock = group.split[0]
      end
      if additional != nil
        add = additional.split(",")
      end
      add.each{|token|
        freq << "TS_" + clock if token == "FREQ"
        freq2 << "TS_" + clock if token == "FREQ*2"
      }if add != nil
    }    
    return freq,freq2
  end
  
  def get_duty(udef_data)
    duty = []
    udef_data.each{|line|
      group = line.split(":")[0]
      additional = line.split(":")[1]
      if group != nil
        clock = group.split[0]
      end
      if additional != nil
        add = additional.split(",")
      end
      add.each{|token|
        duty << "TS_" + clock if token == "DUTY"
      }if add != nil
    }    
    return duty
  end
  

end


#
#* ISEUcf
#
class ISEUcf
  # Output UCF file
  attr_accessor :OUCF
  # Clock Information for UCF
  attr_accessor :CLOCK
  attr_accessor :CLOCK_org
  # TIMESPEC Infromation for UCF
  attr_accessor :TIMESPEC
  # TIMEGRP Information for UCF
  attr_accessor :TIMEGRP
  # Name Changing list
  attr_accessor :NAME_CHANGING_LIST


  def initialize(udef=nil)
    @OUCF               = Array.new
    @CLOCK              = Array.new
    @CLOCK_org          = Array.new
    @TIMESPEC           = Array.new
    @TIMEGRP            = Hash.new
    @NAME_CHANGING_LIST = Array.new

    @UCF_DEF            = Hash.new

    # For Changing name
=begin
    @NAME_CHANGE = {
      "chiptop_chip_csc_cg_hioscctl_fmain_sel_fih" => "FIH", # FIH
      "chiptop_chip_csc_cg_mosccnt_fmx4" => "FMX4",          # FMX4
      "chiptop_chip_csc_cg_tbase_FCLK_ICE" => "FCLK",        # FCLK_ICE
      "chiptop_chip_ocd_main_uart_sclock_16m" => "OCDCLK",   # OCDCLK
      "chiptop_chip_pclbuz_fmain_scck" => "FMAIN_PCLBUZ",    # FMAIN
      "chiptop_chip_pclbuz_fsub_scck" => "FSUB_PCLBUZ",      # FSUB
      "chiptop_chip_csc_rg_resctl_main_fih_p" => "FIH_RG",   # FIH_RG
      "chiptop_chip_csc_rg_lvictl_counter_fil15kin" => "FIH_LVI", # FIH_LVI
      "CLK30MHZ_GB" => "CLK30MHZ_GB",                        # CLK30MHZ
      "CLK60MHZ" => "CLK60MHZ",                              # CLK60MHZ
      "ice_clockctl_dcm5_CLK60MHZLOCK" => "CLK60MHZLOCK",    # CLOCK60MHZLOCK
      "USBCLK" => "USBCLK",                                  # USBCLK
      "USBIFWR" => "USBIFWR",                                # USBIFWR
      "ice_ICEWR" => "ICEWR",                                # ICEWR
      "chiptop_h_rosc_CLK160M" => "CLK160M",                 # CLK160M
      "ice_timetagv2_CLK240M" => "CLK240M",                  # CLK240M
      "chiptop_h_rosc_R32MOUT_c" => "R32MCLK_c",                 # R32MCLK
      "chiptop_h_rosc_R32MOUT" => "R32MCLK",                 # R32MCLK
    }
=end
    list_file = File.dirname("#{__FILE__}") + "/../conf/NameChange.lst"
    @NAME_CHANGE = name_change(list_file,udef)
    
  end

  #
  # UCF Templete Description for ICE Macro
  #
  def ucf_templete
    @templete = ["############################################",
                 "# Special Timing Constraint",
                 "############################################",
#                 "# False Path setting for CLK60MHZ",
#                 "TIMESPEC \"TS_CLK60MHZ_to_USBIFWR\"  = FROM \"CLK60MHZ_grp\"  TO \"USBIFWR_grp\" TIG;",
#                 "TIMESPEC \"TS_CLK60MHZ_to_ICEWR\"    = FROM \"CLK60MHZ_grp\"  TO \"ICEWR_grp\" TIG;",
#                 "TIMESPEC \"TS_USBIFWR_to_CLK60MHZ\"  = FROM \"USBIFWR_grp\"   TO \"CLK60MHZ_grp\" TIG;",
#                 "TIMESPEC \"TS_ICEWR_to_CLK60MHZ\"    = FROM \"ICEWR_grp\" TO \"CLK60MHZ_grp\" TIG;", 
#                 "TIMESPEC \"TS_CLK60MHZ_to_fsub\"     = FROM \"CLK60MHZ_grp\" TO \"FSUB_grp\" TIG;",
#                 "TIMESPEC \"TS_CLK60MHZ_to_fmx4\"     = FROM \"CLK60MHZ_grp\" TO \"FMX4_grp\" TIG;",
#                 "TIMESPEC \"TS_CLK60MHZ_to_ocdclk\"   = FROM \"CLK60MHZ_grp\" TO \"OCDCLK_grp\" TIG;",
#                 "TIMESPEC \"TS_CLK60MHZ_to_fih\"      = FROM \"CLK60MHZ_grp\" TO \"FIH_grp\" TIG;",
#                 "TIMESPEC \"TS_CLK60MHZ_to_fmain\"    = FROM \"CLK60MHZ_grp\" TO \"FMAIN_grp\" TIG;",
#                 "TIMESPEC \"TS_CLK60MHZ_to_fclk\"     = FROM \"CLK60MHZ_grp\" TO \"FCLK_grp\" TIG;",
#                 "TIMESPEC \"TS_fsub_to_CLK60MHZ\"     = FROM \"FSUB_grp\" TO \"CLK60MHZ_grp\" TIG;",
#                 "TIMESPEC \"TS_fmx4_to_CLK60MHZ\"     = FROM \"FMX4_grp\" TO \"CLK60MHZ_grp\" TIG;",
#                 "TIMESPEC \"TS_ocdclk_to_CLK60MHZ\"   = FROM \"OCDCLK_grp\" TO \"CLK60MHZ_grp\" TIG;",
#                 "TIMESPEC \"TS_fih_to_CLK60MHZ\"      = FROM \"FIH_grp\" TO \"CLK60MHZ_grp\" TIG;",
#                 "TIMESPEC \"TS_fmain_to_CLK60MHZ\"    = FROM \"FMAIN_grp\" TO \"CLK60MHZ_grp\" TIG;",
#                 "TIMESPEC \"TS_fclk_to_CLK60MHZ\"     = FROM \"FCLK_grp\" TO \"CLK60MHZ_grp\" TIG;",
#                 "# RESB",
#                 "NET \"RESB\" TNM_NET = \"RESB\";",
#                 "NET \"RESB\" TIG;",
#                 "TIMESPEC \"TS_CLK60MHZ_to_RESB\"  = FROM \"CLK60MHZ_grp\"  TO \"RESB\" TIG;",
#                 "TIMESPEC \"TS_RESB_to_CLK60MHZ\"  = FROM \"RESB\"  TO \"CLK60MHZ_grp\" TIG;",
#                 "# Special Constraint",
#                 "INST \"ice/status/cpumclkst/clkm_p1\" TNM = \"fclk_data_path\";",
#                 "INST \"ice/timetagv2/sampbck\" TNM = \"fclk_data_path\";",
#                 "TIMESPEC \"TS_fclk_data_path\" = TO \"fclk_data_path\" TIG;",
                 #                 "",
#                 "############################################",
#                 "# Area Location Constraint",
#                 "############################################",
#                 "INST \"ice/emem/ram\" AREA_GROUP = \"pblock_ram\";",
#                 "AREA_GROUP \"pblock_ram\" RANGE=SLICE_X2Y174:SLICE_X47Y319;",
#                 "AREA_GROUP \"pblock_ram\" RANGE=DSP48_X0Y44:DSP48_X0Y79;",
#                 "AREA_GROUP \"pblock_ram\" RANGE=FIFO16_X0Y22:FIFO16_X1Y39;",
#                 "AREA_GROUP \"pblock_ram\" RANGE=RAMB16_X0Y22:RAMB16_X1Y39;",
#                 "INST \"ice/emem/rom\" AREA_GROUP = \"pblock_rom_1\";",
#                 "AREA_GROUP \"pblock_rom_1\" RANGE=SLICE_X76Y212:SLICE_X103Y281;",
#                 "AREA_GROUP \"pblock_rom_1\" RANGE=FIFO16_X2Y27:FIFO16_X4Y34;",
#                 "AREA_GROUP \"pblock_rom_1\" RANGE=RAMB16_X2Y27:RAMB16_X4Y34;",
#                 "INST \"chiptop/chip/cpu\" AREA_GROUP = \"pblock_cpu\";",
#                 "AREA_GROUP \"pblock_cpu\" RANGE=SLICE_X8Y180:SLICE_X101Y317;",
#                 "AREA_GROUP \"pblock_cpu\" RANGE=DSP48_X0Y46:DSP48_X0Y77;",
#                 "AREA_GROUP \"pblock_rom\" RANGE=SLICE_X84Y256:SLICE_X85Y257;",
#                 "# RTC_SELCLK",
#                 "NET \"chiptop/chip/rtc/main/tcnt/RTC_SELCK\" TNM_NET = \"RTC_SELCK\";",
#                 "TIMESPEC \"TS_ICEWR_to_RTC_SELCK\"     = FROM \"ICEWR_grp\" TO \"RTC_SELCK\" TIG;",
#                 "TIMESPEC \"TS_RTC_SELCK_to_ICEWR\"     = FROM \"RTC_SELCK\" TO \"ICEWR_grp\" TIG;",                 
=begin
                 "############################################",
                 "# DCMs",
                 "############################################",
                 "#",
                 "# DCM1: 60MHz  *28/15   = 112MHz",
                 "#",
                 "INST \"ice/clockctl/dcm1\"		CLKFX_MULTIPLY	= 28 ;",
                 "INST \"ice/clockctl/dcm1\"		CLKFX_DIVIDE	= 15 ;",
                 "#",
                 "# DCM2: 60MHz  *19/8   = 142.5MHz",
                 "#",
                 "INST \"ice/clockctl/dcm2\"		CLKFX_MULTIPLY	= 19 ;",
                 "INST \"ice/clockctl/dcm2\"		CLKFX_DIVIDE	=  8 ;",
                 "#",
                 "# DCM3: 60MHz  *27/11  = 147.273MHz",
                 "#",
                 "INST \"ice/clockctl/dcm3\"		CLKFX_MULTIPLY	= 27 ;",
                 "INST \"ice/clockctl/dcm3\"		CLKFX_DIVIDE	= 11 ;",
                 "#",
                 "# DCM4: 60MHz  *5/2    = 150MHz",
                 "#",
                 "INST \"ice/clockctl/dcm4\"		CLKFX_MULTIPLY	=  5 ;",
                 "INST \"ice/clockctl/dcm4\"		CLKFX_DIVIDE	=  2 ;",
                 "#",
                 "# DCM5: 30MHz  *2/1    = 60MHz",
                 "#",
                 "INST \"ice/clockctl/dcm5\"		CLKFX_MULTIPLY	=  2 ;",
                 "INST \"ice/clockctl/dcm5\"		CLKFX_DIVIDE	=  1 ;",
                 "",
=end
    ]
  end
  
  def ucf_templete_with_judge
    templete =
      [        
#       "NET \"chiptop/chip/csc/cg/tbase/FCLK_ICE\" TIG;",
#       "NET \"chiptop/chip/csc/cg/oscouts_nf_p\" TIG;",      
#       "# FCLK <=> FIHP1",
#       "TIMESPEC \"TS_FCLK_to_FIHP1\"  = FROM \"FCLK_grp\"  TO \"FIHP1_grp\" TIG;",
#       "TIMESPEC \"TS_FIHP1_to_FCLK\"  = FROM \"FIHP1_grp\"  TO \"FCLK_grp\" TIG;",
#       "# FCLK <=> FIHP2",
#       "TIMESPEC \"TS_FCLK_to_FIHP3\"  = FROM \"FCLK_grp\"  TO \"FIHP3_grp\" TIG;",
#       "TIMESPEC \"TS_FIHP3_to_FCLK\"  = FROM \"FIHP3_grp\"  TO \"FCLK_grp\" TIG;",
      ]
    return templete
  end
  
  # 
  # Parsing UCF file
  # [arg1] file pointer
  # 
  def parse(ucf_file,udef)
    n = 0
    while ucf_file[n] != nil
      line = ucf_file[n]
      flag = false
      internal_flag = false
      # Searching Definition Name
      @NAME_CHANGE.each{|key,value|
#        if /#{key}/ =~ line && (/PERIOD/ =~ line || /TNM/ =~ line)
        if /TNM_NET = \"#{key}\"/ =~ line || /PERIOD \"#{key}\"/ =~ line
          flag = true
          # name change
          changed_line = line.gsub("TNM_NET = \"#{key}\"","TNM_NET = \"#{value}\"")
          @NAME_CHANGING_LIST << ["#{line}","#{changed_line}"]
          if (/^TIMESPEC/ =~ line) == nil
            @CLOCK << changed_line
            if line != changed_line
              @CLOCK_org << line
            end
          else
            # TIMESPEC line
            changed_line = line.gsub("#{key}","#{value}")
            changed_line = changed_line.gsub("\"","").gsub(";","").strip  # line modify (delete "\,;" and space)
            timespec_each = TIMESPECInf.new(udef)
            timespec_each.make_data(changed_line)
            if timespec_each.TS_NAME != nil
              @TIMESPEC << timespec_each
            else
              flag = false
            end
          end
        end

        if /^TIMESPEC/ =~ line 
          value_grp = value + "_grp"
          changed_line = line.gsub("\"#{key}\"","\"#{value_grp}\"").\
          gsub("\"#{key}_rise\"","\"#{value_grp}_rise\"").\
          gsub("\"#{key}_fall\"","\"#{value_grp}_fall\"").\
          gsub("TIMESPEC \"TS_#{key}\"","TIMESPEC \"TS_#{value}\"")
          if line != changed_line
            @NAME_CHANGING_LIST << ["#{line}","#{changed_line}"]
            line = changed_line
          end
        end


        if /^TIMEGRP/ =~ line 
          value_grp = value + "_grp"
          changed_line = line.gsub("\"#{key}\"","\"#{value_grp}\"").\
          gsub("\"#{key}_rise\"","\"#{value_grp}_rise\"").\
          gsub("\"#{key}_fall\"","\"#{value_grp}_fall\"")
          if line != changed_line
            @NAME_CHANGING_LIST << ["#{line}","#{changed_line}"]
            line = changed_line
          end
        end
        
      }
      if flag == false # un-matchecd clock line
        # Searching PERIOD line and delete this constraint, because it may not need
        if /PERIOD/ =~ line
          # comment out
          line = "#" + line
        end
        if /System/ =~ line
          # comment out
          line = "#" + line
        end
        if /\-internal/ =~ line
          @OUCF << line
          n += 1
          while ( ( /^#/ =~ ucf_file[n] ) == nil || (/\-internal/ =~ ucf_file[n]) )
            if /^#/ =~ ucf_file[n] || ucf_file[n] == ""
              line = ucf_file[n]
            else
              line = "#" + ucf_file[n]
            end
            @OUCF << line
            n += 1
            internal_flag = true
          end
          internal_flag = true
        end
      end
      @NAME_CHANGE.each{|key,value|
#        line = line.gsub("#{key}","#{value}_grp")
        /^NET \"(.*)\" TNM_NET = \"(.*)\";/ =~ line
        if $1 != nil && $2 != nil
          if $2 == key
            line = line.gsub("#{key}","#{value}_grp")
          end
        else
          /^TIMEGRP \"(.*)\" TNM_NET = \"(.*)\";/ =~ line
        end
      }
      if internal_flag && ((/^#/ =~ ucf_file[n]) != nil )
        @OUCF << ucf_file[n]
      elsif !flag && !internal_flag
        @OUCF << line 
      end
      
      if /define_max_delay/ =~ line &&
         ( /timetagv2/ =~ line || /clockctl\.eoscsck_sync/ =~ line || /timj_0\.coretop\.sfrtop\.idlecntload_e/ =~ line || /timj_0\.coretop\.kerneltop\.cntctrl/ =~ line )
        @OUCF << line
        n += 1
        while (( /^TIMESPEC/ =~ ucf_file[n] ) != 0 )
          @OUCF << ucf_file[n]
          n += 1          
        end

        tmp = ucf_file[n]
        clk_flag = false
        @NAME_CHANGE.each{|key,value|
          value_grp = value + "_grp"
          changed_tmp = tmp.gsub("\"#{key}\"","\"#{value_grp}\"").\
          gsub("\"#{key}_rise\"","\"#{value_grp}_rise\"").\
          gsub("\"#{key}_fall\"","\"#{value_grp}_fall\"").\
          gsub("TIMESPEC \"TS_#{key}\"","TIMESPEC \"TS_#{value}\"")
          if tmp != changed_tmp
            @NAME_CHANGING_LIST << ["#{tmp}","#{changed_tmp}"]
            tmp = changed_tmp
            clk_flag = true
            if /ICEWR/=~ value
              clk_flag = false
            end
          end         
        }

        if clk_flag
          @OUCF << tmp
          clk_flag = false
        else
          @OUCF << "#" + tmp + " # Changed by mkucf"
          @OUCF << tmp.sub(";"," DATAPATHONLY;")
        end
#        @OUCF << "#" + ucf_file[n] + " # Changed by mkucf"
#        @OUCF << ucf_file[n].sub(";"," DATAPATHONLY;")
      end

      n += 1
    end
  end
  
  #
  # Make Adding constraint information
  # [arg1] UCF Define File Pointer
  #
  def make_AddConst(udef)

    # Get UCF Definition
    udef_a = Array.new
    udef.each{|line|
      # skip in ignored line
      next if line.strip.size == 0
      next if line.strip[0].chr == "#"
      line_s = Array.new
      line_s = line.split(":")
      next if line_s[0] == "C"
      line_s = line_s[0].split
      case line_s.size
      when 1 then
        parent_clock = line_s[0]
        @UCF_DEF["#{parent_clock}"] = nil
      else
        if line_s[1] != "EXCEPT"
          return 1
        end
        parent_clock = line_s[0]
        line_s.delete_at(1) # delete "EXCEPT"
        line_s.delete_at(0) # delete "ParentClock"
        child_clock = nil
        line_s.each{|str|
          child_clock = child_clock.to_s + " " + str.to_s
        }
        if @UCF_DEF.key?("#{parent_clock}") == true
          $WARNING_CNT += 1
          printf("@W:\"%s\" is defined multiple lines in UDEF\n",parent_clock)
        end
        @UCF_DEF["#{parent_clock}"] = "#{child_clock}"
      end
    }
    
    # make TIMEGRP
    @CLOCK.each{|tnm|
      except = Array.new
      child_clk = Array.new
      tnm = tnm.gsub("\"","").gsub(";","").strip 
      clk_name = tnm.split[4] # get Clock name
      # search Clock name in def file
      child_clk = @UCF_DEF["#{clk_name}"]
      child_clk.split.each{|cname|
        except << cname
      } if child_clk != nil

      @TIMEGRP["#{clk_name}"] = except.compact
#      @TIMEGRP << "TIMEGRP \"" + clk_name + "_grp\" = \"" + clk_name + "\" "+ except.to_s
    }

=begin
    # Error check
    @TIMESPEC.each{|timespec|
      if @TIMEGRP.key?("#{timespec.TNM_NAME}") == false
        p timespec.TNM_NAME
        $ERROR_CNT += 1
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
      end
    }
=end
    return 0
  end


  def name_change(file,udef)
    data = {}
    File.open("#{file}").each{|line|
      # next
      next if line.strip == "" || line.strip[0] == 35
      tmp = line.split
      tmp = tmp[0].split(",")
      data["#{tmp[0]}"] = tmp[1]
    }
    File.open("#{udef}").each{|line|
      line = line.strip
      next if line == "" || line[0] == ?#
      tmp = line.split(":")
      case tmp[0]
        when "C"
        tmp2 = tmp[1].split(",")
        tmp2[1] = Common.remove_after(tmp2[1],"#")
        data["#{tmp2[0]}"] = tmp2[1].strip
      end
    } if udef != nil
    data
  end
end
