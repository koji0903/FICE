############################################################
#
# Constraint
#  
#  Author     : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
#############################################################
#
# [FUNCTION]
# Make Data structure for Device Constraint. This Data Structure
# has all information of each constraint. And it also has Flag
# signal for summary report.
#
#############################################################

#
# ClockInfomation
#
class ClockInf
  attr_accessor :Period
  def initialize
    @Period = 0
  end
end

class ConstEach
  # Modified Line
  attr_accessor :ModLine
  # Attribute
  attr_accessor :Attribute
  # FileName of constraint
  attr_accessor :FileName
  # Line No of constraint
  attr_accessor :LineNo
  # Peiod(String) for clock attribute
  attr_accessor :Period
  # Freqency(String) for clock attribute
  attr_accessor :Freq
  # Signal Name
  attr_accessor :Signal
  # Modified signal name
  attr_accessor :Signal_mod
  # Macro Name of signal
  attr_accessor :SignalMacro
  # Pin Name
  attr_accessor :Pin
  # Modified Pin Name
  attr_accessor :Pin_mod
  # Macro Name of Pin
  attr_accessor :PinMacro
  # Source Name
  attr_accessor :Source
  # Modified Source Name
  attr_accessor :Source_mod
  # Macro Name of Source
  attr_accessor :SourceMacro
  # From-Signal Name
  attr_accessor :From
  # Modified From-Signal Name
  attr_accessor :From_mod
  # Macro name of From-Signal
  attr_accessor :FromMacro
  # FallFrom-Signal Name
  attr_accessor :FallFrom
  # Modified FallFrom-Signal Name
  attr_accessor :FallFrom_mod
  # Macro name of FallFrom-Signal
  attr_accessor :FallFromMacro
  # To-Signal name
  attr_accessor :To
  # Modified To-Signal Name
  attr_accessor :To_mod
  attr_accessor :ToMacro
  attr_accessor :FallTo
  attr_accessor :FallTo_mod
  attr_accessor :FallToMacro
  attr_accessor :Through1
  attr_accessor :Through1_mod
  attr_accessor :Through1Macro
  attr_accessor :FallThrough1
  attr_accessor :FallThrough1_mod
  attr_accessor :FallThrough1Macro
  attr_accessor :RiseThrough1
  attr_accessor :RiseThrough1_mod
  attr_accessor :RiseThrough1Macro
  attr_accessor :Through2
  attr_accessor :Through2_mod
  attr_accessor :Through2Macro
  attr_accessor :FallThrough2
  attr_accessor :FallThrough2_mod
  attr_accessor :FallThrough2Macro
  attr_accessor :Through3
  attr_accessor :Through3_mod
  attr_accessor :Through3Macro
  attr_accessor :FallThrough3
  attr_accessor :FallThrough3_mod
  attr_accessor :FallThrough3Macro
  attr_accessor :Through4
  attr_accessor :Through4_mod
  attr_accessor :Through4Macro
  attr_accessor :FallThrough4
  attr_accessor :FallThrough4_mod
  attr_accessor :FallThrough4Macro
  attr_accessor :SetupFlag
  attr_accessor :HoldFlag
  attr_accessor :EndFlag
  attr_accessor :Type
  attr_accessor :NoUseFlag
  attr_accessor :ClockName
  attr_accessor :SDC
  attr_accessor :SDCAttribute
  # Analize Flag for summary
  attr_accessor :AnalizeFlag
  attr_accessor :ConvertFlag
  attr_accessor :NameChangeFlag
  attr_accessor :ConstCheckFlag

  attr_accessor :LimitFlag
  attr_accessor :RemoveFlag

  attr_accessor :ComponentMatchingFlag
  attr_accessor :SynthesisReport

  def initialize
    @ModLine      = nil
    @Attribute    = nil
    @FileName     = nil
    @LineNo       = nil
    @Period       = nil
    @Freq         = nil
    @AnalizeFlag  = false
    @ConvertFlag  = false
    @NameChangeFlag = false
    @Signal       = nil
    @Signal_mod   = nil
    @SignalMacro  = nil
    @Pin          = nil
    @Pin_mod      = nil
    @PinMacro     = nil
    @Source       = nil
    @Source_mod   = nil
    @SourceMacro  = nil
    @From         = nil
    @From_mod     = nil
    @FromMacro    = nil
    @FallFrom     = nil
    @FallFrom_mod = nil
    @FallFromMacro = nil
    @To           = nil
    @To_mod       = nil
    @ToMacro      = nil
    @FallTo       = nil
    @FallTo_mod   = nil
    @FallToMacro  = nil
    @Through1     = nil
    @Through1_mod = nil
    @Through1Macro = nil
    @FallThrough1 = nil
    @FallThrough1_mod = nil
    @FallThrough1Macro = nil
    @RiseThrough1 = nil
    @RiseThrough1_mod = nil
    @RiseThrough1Macro = nil
    @Through2     = nil
    @Through2_mod = nil
    @Through2Macro = nil
    @Through3     = nil
    @Through3_mod = nil
    @Through3Macro = nil
    @Through4     = nil
    @Through4_mod = nil
    @Through4Macro = nil
    @SetupFlag    = false
    @HoldFlag     = false
    @EndFlag      = false
    @Type         = nil
    @NoUseFlag    = false
    @ClockName    = nil
    @SDC          = nil    # must save Array data
    @SDCAttribute = nil
    @LimitFlag    = false
    @RemoveFlag   = false
    @ConstCheckFlag = 1      # 0   : Signal does not exist, using Synplify Rpt/SRR Information
                             # 1   : OK
                             # nil : non-check 

    @ComponentMatchingFlag = 0
    @SynthesisReport = nil
  end
end

class ConstSummary
  attr_accessor :No
  attr_accessor :ConstNumber
  attr_accessor :RemoveNumber
  attr_accessor :ConstRate
  attr_accessor :AnalizeNumber
  attr_accessor :AnalizeRate
  attr_accessor :LimitNumber
  attr_accessor :ConvertNumber
  attr_accessor :ConvertRate
  attr_accessor :ConstChkNumber
  attr_accessor :ConstChkRate
  def initialize
    @No = nil
    @ConstNumber = 0
    @RemoveNumber = 0
    @ConstRate = 0.00
    @AnalizeNumber = 0
    @AnalizeRate = 0.00
    @LimitNumber = 0
    @ConvertNumber = 0
    @ConvertRate = 0.00
    @ConstChkNumber = 0
    @ConstChkRate = 0.00
  end
end

class ConstCtrl
  # for Pattern-mattching
  ALL_CLOCKS          = "\\s+\\[all_clocks\\]"
  ALL_INPUTS          = "\\s+\\[all_inputs\\]"
  GET_CLOCKS          = "\\s+\\[get_clock.*\\s+(.+)\\]"
  FROM_CLOCKS          = "\\s+-from#{ALL_CLOCKS}"
  FROM_GET_CLOCKS     = "\\s+-from#{GET_CLOCKS}"
  TO_GET_CLOCKS     = "\\s+-to#{GET_CLOCKS}"
  FROM_INPUTS          = "\\s+-from#{ALL_INPUTS}"
  TO_CLOCKS          = "\\s+-to#{ALL_CLOCKS}"
  TO_INPUTS          = "\\s+-to#{ALL_INPUTS}"
  PERIOD              = "\\s+(\\S+)"
  SIGNAL              = "\\s+\\[\\s*(.+)\\s*\\]"
  SIGNAL_C            = "\\s+\"\\s*(\\S+)\\s*\""
  SIGNAL_D            = "\\s+(\\S+)"
  LIST                = "\\s+\\[\\s*list\\s+(.+)\\s*\\]"
  GETPIN              = "\\s+\\[\\s*get_pins\\s+(\\S+)\\s*\\]"
  GETPIN_LIST         = "\\s+\\[\\s*get_pins\\s+\\[\\s*list\\s+(.+)\\s*\\]\\s*\\]"
  GETCELL             = "\\s+\\[\\s*get_cells\\s+(.+)\\s*\\]"
  GETNET              = "\\s+\\[\\s*get_nets\\s+(.+)\\s*\\]"
  FROM_SIGNAL         = "\\s+-from#{SIGNAL}"
  FROM_LIST           = "\\s+-from#{LIST}"
  FROM_GET_CELL       = "\\s+-from#{GETCELL}"
  FROM_GETPIN          = "\\s+-from#{GETPIN}"
  FALL_FROM_SIGNAL    = "\\s+-fall_from#{SIGNAL}"
  FALL_FROM_SIGNAL_D  = "\\s+-fall_from#{SIGNAL_D}"
  FALL_FROM_LIST      = "\\s+-fall_from#{LIST}"
  TO_SIGNAL           = "\\s+-to#{SIGNAL}"
  TO_LIST             = "\\s+-to#{LIST}"
  TO_GET_CELL         = "\\s+-to#{GETCELL}"
  TO_GETPIN          = "\\s+-to#{GETPIN}"
  FALL_TO_SIGNAL      = "\\s+-fall_to#{SIGNAL}"
  FALL_TO_SIGNAL_D    = "\\s+-fall_to#{SIGNAL_D}"
  FALL_TO_LIST        = "\\s+-fall_to#{LIST}"
  THROUGH_SIGNAL      = "\\s+-thr\\w*#{SIGNAL}"
  THROUGH_LIST        = "\\s+-thr\\w*#{LIST}"
  THROUGH_PINLIST     = "\\s+-thr\\w*#{GETPIN_LIST}"
  THROUGH_GETPIN     = "\\s+-thr\\w*#{GETPIN}"
  FALL_THROUGH_SIGNAL = "\\s+-fall_thr\\w*#{SIGNAL}"
  FALL_THROUGH_LIST   = "\\s+-fall_thr\\w*#{LIST}"
  FALL_THROUGH_GETPIN     = "\\s+-fall_thr\\w*#{GETPIN}"
  RISE_THROUGH_SIGNAL = "\\s+-rise_thr\\w*#{SIGNAL}"
  RISE_THROUGH_SIGNAL_D = "\\s+-rise_thr\\w*#{SIGNAL_D}"
  RISE_THROUGH_LIST   = "\\s+-rise_thr\\w*#{LIST}"
  RISE_THROUGH_GETPIN     = "\\s+-rise_thr\\w*#{GETPIN}"
  SETUP               = "\\s+-setup"
  HOLD                = "\\s+-hold"
  START                = "\\s+-start"
  EEND                 = "\\s+-end"
  DONT_USE            = "\\s+dont_use"
  MACRO               = "\\s+(\\$\\S+)"
  TO_MACRO            = "\\s+-to\\s+(\\$\\S+)"
  FROM_MACRO          = "\\s+-from\\s+(\\$\\S+)"
  TO_SIGNAL_D         = "\\s+-to\\s+(\\S+)"
  TO_LIST_SIGNAL_D    = "\\s+-to\\s+list\\s+(.*)"
  FROM_SIGNAL_D       = "\\s+-from\\s+(\\S+)"
  FROM_LIST_SIGNAL_D  = "\\s+-from\\s+list\\s+(.*)"
  THROUGH_LIST_SIGNAL_D  = "\\s+-thr\\w*\\s+list\\s+(.*)"
  THROUGH_SIGNAL_D    = "\\s+-thr\\w*\\s+(\\S+)"
  FALL_THROUGH_SIGNAL_D    = "\\s+-fall_thr\\w*\\s+(\\S+)"
#  RISE_THROUGH_SIGNAL_D    = "\\s+-rise_thr\\w*\\s+(\\S+)"
  RISE_FROM_SIGNAL_D    = "\\s+-rise_from\\w*\\s+(\\S+)"


  # For Hierachy
  def hier_cell(str)
    str = str.gsub("socket/","").gsub("socket.","") if $TARGET == "socket"
    if @clock_name.index("#{str}") != nil
      return "c:" + str
    elsif str != "all_clocks" && str != "all_inputs" && str != "all_outputs" && str != "all_registers"
      return "i:#{$HIER}" + str.gsub("\/",".") 
    else
      return str
    end
   end

  def hier_view(str)
    str = str.gsub("socket/","").gsub("socket.","") if $TARGET == "socket"
    if str != "all_clocks" && str != "all_inputs" && str != "all_outputs" && str != "all_registers"
      return "v:work.#{$HIER}" + str.gsub("\/",".") 
    else
      return str
    end
  end

  def hier_reg(str)
    str = str.gsub("socket/","").gsub("socket.","") if $TARGET == "socket"
    if str != "all_clocks" && str != "all_inputs" && str != "all_outputs" && str != "all_registers"
      return "r:#{$HIER}" + str.gsub("\/",".") 
    else
      return str
    end
  end

  def hier_net(str)
    str = str.gsub("socket/","").gsub("socket.","") if $TARGET == "socket"
    if str != "all_clocks" && str != "all_inputs" && str != "all_outputs" && str != "all_registers"
      return "n:#{$HIER}" + str.gsub("\/",".") 
    else
      return str
    end
  end

  def hier_pin(str)
    str = str.gsub("socket/","").gsub("socket.","") if $TARGET == "socket"
    if str != "all_clocks" && str != "all_inputs" && str != "all_outputs" && str != "all_registers"
      return "t:#{$HIER}" + str.gsub("\/",".") 
    else
      return str
    end
  end

  def hier_clock(str)
    str = str.gsub("socket/","").gsub("socket.","") if $TARGET == "socket"
    if str != "all_clocks" && str != "all_inputs" && str != "all_outputs" && str != "all_registers"
      return "c:" + str 
    else
      return str
    end
  end

  # SDC templet
  def sdc_templete
    if $TARGET == "plug" || $TARGET == "socket" 
      @templete = ["#",
                   "# CLOCK Attribute",
                   "#",
                   "# ice system",
                   "define_clock { n:CLK30MHZ_GB } -name { CLK30MHZ_GB } -freq 30.000 -clockgroup clk30mhzgb -route 0.000",
                   "# ice system(dcm)",
                   "define_clock { n:CLK60MHZ } -name { CLK60MHZ } -freq 60.000 -clockgroup clk60mhz -route 0.000",
                   "# usb",
                   "define_clock { n:USBCLK } -name { USBCLK } -freq 20.000 -clockgroup usb -route 0.000",
                   "# host interface",
                   "define_clock { n:ice.ICEWR } -name { ICEWR } -freq 2.000 -clockgroup icewr -route 0.000",
                   "# pseudo-emulation",
                   "define_clock { n:USBIFWR } -name { USBIFWR } -freq 2.000 -clockgroup usbifwr -route 0.000",
                   #                 "define_clock { n:ice.timetagv2.CLK240M } -name { CLK240M } -freq 240 -clockgroup clk240m -route 0",
                   "define_clock { n:chiptop.clk240base.CLK240M } -name { CLK240M } -freq 240.000 -clockgroup clk240m -route 0",
                   "define_clock { n:chiptop.clk240base.CLK120M } -name { CLK120M } -freq 120.000 -clockgroup clk120m -route 0",
                   "define_clock { n:chiptop.h_rosc.CLK160M } -name { CLK160M } -freq 160 -clockgroup clk160m -route 0",
                   "# for internal clock",
                   #                 "define_clock   { n:ice.clockctl.clk112 } -name {clk112}  -freq 2 -clockgroup clk112 -route 0;",
                   #                 "define_clock   { n:ice.clockctl.clk142 } -name {clk142}  -freq 2 -clockgroup clk142 -route 0;",
                   #                 "define_clock   { n:ice.clockctl.clk147 } -name {clk147}  -freq 2 -clockgroup clk147 -route 0;",
                   #                 "define_clock   { n:ice.clockctl.clk150 } -name {clk150}  -freq 2 -clockgroup clk150 -route 0;",
                   #                 "define_clock   { n:ice.clockctl.main_clk } -name {main_clk}  -freq 2 -clockgroup main_clk -route 0;",
                   #                 "define_clock   { n:ice.clockctl.mclktmp2 } -name {mclktmp2}  -freq 2 -clockgroup mclktmp2 -route 0;",
                   #                 "define_clock   { n:ice.clockctl.sclktmp } -name {sclktmp}  -freq 2 -clockgroup sclktmp -route 0;",
                   "define_clock   { n:RESB } -name { RESB }  -freq 2 -clockgroup RESB -route 0;",
                   "",
                   "#",
                   "# LOGIC Attribute",
                   "#",
                   #                 "define_false_path  -from { p:USB* };",
                   "define_false_path -to { i:ice.host_interface.usb2usbif.hi_read_data* }",
                   "define_false_path -to { i:ice.host_interface.usbif2ice.iceifa* }",
                   "define_false_path -to { i:ice.host_interface.usbif2ice.iceifaclk_d2 }", 
                   "define_false_path -from { i:ice.host_interface.VDDLEV* }",
                   "define_false_path -to { i:ice.host_interface.snatch.en_snatch }",
                   #                 "define_false_path -through { n:ice.host_interface.snatch.ICEDO* n:ice.host_interface.snatch.ICEDO* } -through { n:ice.host_interface.snatch.MDR* }",                 
                   "define_false_path -through { n:ice.host_interface.snatch.ICEDO[31:0] } -through { n:ice.host_interface.snatch.MDR[15:0] }",
                   #                 "define_multicycle_path  -through {n:ice.break.PCWAITF}  -through {n:ice.break.SVMODI} 10",
                   "define_false_path -to { i:ice.break.STBRELESV }",
                   "define_false_path -through { n:ice.ICERESB }",
                   "define_false_path -to { i:ice.emem.rom.clksel.low1_p }",
                   "define_false_path -to { i:ice.emem.rom.clksel.clksel_resetb_p }",
                   "define_false_path -to { i:ice.emem.rom.clksel.clksel_p }",
                   "define_attribute { USBCLK } { syn_noclockbuf } { 1 }",
                   "define_attribute { n:ice.ICEWR } { syn_noclockbuf } { 1 }",
                   "define_attribute { n:RESB } { syn_noclockbuf } { 1 }",
                   "define_attribute { i:ice.trace.trdata.pcwaitf_l } { syn_noclockbuf } { 1 }",
                   "# flash_cp",
                   "define_false_path -from { i:#{$HIER}flash_cp.*.*.* }",
                   "define_false_path -from { i:#{$HIER}flash_cp.*.*.*.* }",
                   "define_false_path -to { i:#{$HIER}flash_cp.*.*.* }",
                   "define_false_path -to { i:#{$HIER}flash_cp.*.*.*.* }",
                   "# timetag",
                   "define_max_delay -from { i:ice.timetagv2.tag[31:0] } -to { i:ice.trace.trdata.fch_data_l2[31:0] } { 3 }",
                   "define_max_delay -from { i:ice.timetagv2.TAGOVF } -to { i:ice.trace.trdata.tagovf_l1 } { 3 }",
                   #                 "define_false_path -to { i:ice.timetagv1.tagsvmod };",
                   "",
                   "#",
                   "# GROBAL",
                   "#",
                   "define_global_attribute  { syn_forward_io_constraints } { 0 }",
                   "define_global_attribute  { xc_use_timespec_for_io } { 0 }",
                   "define_global_attribute  { syn_useioff } { 1 }",
                   "define_global_attribute  { xc_fast_auto } { 1 }",
                   "",
                   "#",
                   "# Special Constraint about dummy-path at Device Logic",
                   "#",
                   #                 "define_max_delay -from { i:#{$HIER}csc.cg.hioscctl.fihsync.rsts } -to { i:#{$HIER}csc.cg.regi.hiostop_neg } { 10 }",
                   #                 "define_false_path -from { i:#{$HIER}cpu.alu.IE i:#{$HIER}cpu.alu.Z i:#{$HIER}cpu.alu.RBS[1:0] i:#{$HIER}cpu.alu.AC i:#{$HIER}cpu.alu.ISP[1:0] i:#{$HIER}cpu.alu.CY } -to { i:#{$HIER}csc.cg.tbase.stby.stpst_neg }",
                   "",
                   "#",
                   "# Special Constraint about dummy-path at Device Logid add on Oct 15,2010",
                   "#",
                   "# <<<Hold issue>>>",
                   "define_false_path -to { i:ice.status.cpumclkst.clkm_p1 }",
                   "define_false_path -to { i:ice.timetagv2.sampbck }",
                   "",
                   "# <<<tune the hi-level latch's effective timing>>>",
                   "define_max_delay -from { c:FCLK } -through { n:#{$HIER}CK0IIC0 } -to { i:#{$HIER}iica.micg_gate_0.U1.DLSFQ2_inst.LDCPE_inst } { 31.25 }",
                   "define_max_delay -from { c:FCLK } -through { n:#{$HIER}porga.main.regctl.pclkrw_latch.G001 } -to { i:#{$HIER}porga.main.regctl.pclkrw_latch.DLSFQ2_inst.LDCPE_inst } { 31.25 }",
                   "",
                   "#define_path_delay  -through {n:#{$HIER}modectl.modectl_usertop.modectl_incdec.crc0_gate.G001}  -to {{i:#{$HIER}modectl.modectl_usertop.modectl_incdec.crc0_gate.DLSFQ2_inst.LDCPE_inst}}  -max 29",
                   "# Cut pseudo path (crc0_gate.G001 propagate to latch's din-pin and clock-pin.)",
                   "#define_false_path -through {n:#{$HIER}modectl.modectl_usertop.modectl_incdec.crc0_gate.G001} -through {n:#{$HIER}csc.cg.tbase.fclk_cts.clkout} -to {i:#{$HIER}modectl.modectl_usertop.modectl_incdec.crc0_gate.DLSFQ2_inst.LDCPE_inst}",
                   "#define_false_path -from {i:#{$HIER}modectl.modectl_usertop.modectl_incdec.usrcrcctl.crcctl[6]} -through {n:#{$HIER}csc.cg.tbase.fclk_cts.clkout} -to {i:#{$HIER}modectl.modectl_usertop.modectl_incdec.crc0_gate.DLSFQ2_inst.LDCPE_inst}",
                   "",
                   "define_max_delay -from { c:FCLK } -through { n:#{$HIER}cibc.nvmchk.baseck_latch.G001 } -to { i:#{$HIER}cibc.nvmchk.baseck_latch.DLSFQ2_inst.LDCPE_inst } { 31.25 }",
                   "define_max_delay -from { c:FCLK } -through { n:#{$HIER}cibc.fmop.frqdec.we_frqsel } -to { i:#{$HIER}cibc.fmop.frqdec.frqselck_latch.DLSFQ2_inst.LDCPE_inst } { 31.25 }",
                   "define_max_delay -from { c:FCLK } -through { n:#{$HIER}cibc.fmop.b_trmlv2_iref_en } -to { i:#{$HIER}cibc.fmop.main.trmlv.irefck_latch.DLSFQ2_inst.LDCPE_inst } { 31.25 }",
                   "define_max_delay -from { c:FCLK } -through { n:#{$HIER}cibc.fmop.b_trmlv2_vreadC_en } -to { i:#{$HIER}cibc.fmop.main.trmlv.vreadCck_latch.DLSFQ2_inst.LDCPE_inst } { 31.25 }",
                   "define_max_delay -from { c:FCLK } -through { n:#{$HIER}cibc.fmop.main.baseck_latch.G001 } -to { i:#{$HIER}cibc.fmop.main.baseck_latch.DLSFQ2_inst.LDCPE_inst } { 31.25 }",
                   "define_max_delay -from { c:FCLK } -through { n:#{$HIER}OPBOEN } -to { i:#{$HIER}csc.rg.lvictl.main.lvimd_gate.DLSFQ2_inst.LDCPE_inst } { 31.25 }",
                   "",
                   "# <<<32MHz issue>>>",
                   "#define_false_path -from {i:#{$HIER}cpu.alu.Z i:#{$HIER}cpu.alu.CY i:#{$HIER}cpu.alu.RBS[1] i:#{$HIER}cpu.alu.RBS[0]} -to {i:#{$HIER}csc.cg.tbase.stby.stpst_neg}",
                   "",
                   "define_false_path -from { i:#{$HIER}cpu.alu.* } -to { i:#{$HIER}csc.cg.tbase.stby.stpst_neg }",
                   "define_false_path -through { n:#{$HIER}cpu.adr.slmirr } -to { i:#{$HIER}csc.cg.tbase.stby.stpst_neg }",
                   "define_false_path -from { i:#{$HIER}cpu.adr.pa_data_maw i:#{$HIER}cpu.adr.pa_data_buf i:#{$HIER}cpu.adr.pa_data_mlt1 i:#{$HIER}cpu.adr.pa_data_cyc1 } -to { i:#{$HIER}csc.cg.tbase.stby.stpst_neg }",
                   "define_false_path -through { n:#{$HIER}cpu.alu.SP_usr[*] n:#{$HIER}cpu.alu.SP_sv[*] } -to { i:#{$HIER}csc.cg.tbase.stby.stpst_neg }",
                   "define_false_path -through { n:#{$HIER}cpu.adr.maw[*] } -to { i:#{$HIER}csc.cg.tbase.stby.stpst_neg }",
                   "",
                   "# <<<ICE WakeUp issue>>>",
                   "#define_path_delay  -through {n:#{$HIER}cibc.fmop.main.trmlv.bgrt_clk.bgrt_en}  -to {{i:#{$HIER}cibc.fmop.main.trmlv.bgrt_latch.bgrt_0.ft3_latch1.DLSFQ2_inst.LDCPE_inst}}  -max 10",
                   "#define_path_delay  -through {n:#{$HIER}cibc.fmop.main.trmlv.bgrtc_clk.bgrt_en}  -to {{i:#{$HIER}cibc.fmop.main.trmlv.bgrtc_latch.bgrtc_0.ft3_latch1.DLSFQ2_inst.LDCPE_inst}}  -max 10",
                   "",
                   "define_attribute { n:#{$HIER}cibc.fmop.main.trmlv.bgrt_clk.* } syn_noclockbuf { 1 };",
                   "define_attribute { n:#{$HIER}cibc.fmop.main.trmlv.bgrtc_clk.* } syn_noclockbuf { 1 };",
                   "",
                   "# <<<invalidate cibc circuit of decision by majority. (ICE Only)>>>",
                   "define_false_path -to { i:#{$HIER}cibc.fmop.main.trmlv.bgrt_latch.bgrt_*.ft3_latch*.DLSFQ2_inst.LDCPE_inst }",
                   "define_false_path -to { i:#{$HIER}cibc.fmop.main.trmlv.bgrtc_latch.bgrtc_*.ft3_latch*.DLSFQ2_inst.LDCPE_inst }",
                   "define_false_path -from { i:#{$HIER}cibc.fmop.main.trmlv.bgrt_latch.bgrt_*.ft3_latch*.DLSFQ2_inst.LDCPE_inst }",
                   "define_false_path -from { i:#{$HIER}cibc.fmop.main.trmlv.bgrtc_latch.bgrtc_*.ft3_latch*.DLSFQ2_inst.LDCPE_inst }",
                   "",
                   "# add from 2010.12.06",
                   "define_false_path -from { i:#{$HIER}csc.cg.hioscctl.fmain_sel.cksel_fih_p2.ckmsk2 }",
                   "define_false_path -from { i:#{$HIER}csc.cg.hioscctl.fmain_sel.cksel_fmx.ckmsk2 }",
                   "define_false_path -from { i:#{$HIER}csc.cg.hioscctl.fmain_sel.cksel_fmain_p.ckmsk2 }",
                   "define_false_path -from { i:#{$HIER}csc.cg.hioscctl.fmain_sel.cksel_fmain_p.ckmsk1_p }",
                   "define_false_path -from { i:ice.emem.rom.icewr_start_latch }",
                   "define_false_path -from { i:ice.emem.rom.ice_write_latch }",
                   "# add from 2010.12.17 Redmine Ticket:#277",
                   "define_false_path -from { i:chiptop.chip.socket.cpu.adr.ID_stage* } -through { n:chiptop.chip.socket.cpu.adr.svmodf } -through { n:ice.break.SVI } -to { i:chiptop.chip.socket.csc.cg.tbase.stby.stpst_neg }",
                   "# add from 2010.12.24 Redmine Ticket #287 for Main/Sub OSC generating clock problem",
                   "define_compile_point { v:work.clockctl_cksel } -type { locked }",
                   "# for CSC1V2",
                   "define_compile_point { v:work.QLK0RCSC1V2_CG_CKSEL1 } -type { locked }",
                   "define_compile_point { v:work.QLK0RCSC1V2_CG_CKSEL2 } -type { locked }",
                   "define_compile_point { v:work.QLK0RCSC1V2_CG_MUX } -type { locked }",
                   "# for CSC1V3",
                   "define_compile_point { v:work.QLK0RCSC1V3_CG_CKSEL1 } -type { locked }",
                   "define_compile_point { v:work.QLK0RCSC1V3_CG_CKSEL2 } -type { locked }",
                   "define_compile_point { v:work.QLK0RCSC1V3_CG_MUX } -type { locked }",
                   "# for DataFlash erase",
                   "define_compile_point { v:work.CLKSEL } -type { locked }",
                   "",
                   "# for ICE Macro ver after SS3rd_1_1_2 [begin]",
                   "",
                   "define_max_delay -from { c:ICEWR } -to { i:ice.clockctl.eoscsck_sync* } { 13.95 } # 143.36MHz x 2clock",
                   "define_clock { n:ice.clockctl.main_clk  } -name { CLOCKCTL_COUNTER_MAIN } -freq 150    -clockgroup clockctl_counter_main -route 0 # 60MHz or 112MHz or 142.5MHz or 147.273MHz or 150MHz",
                   "define_clock { n:ice.clockctl.subsource } -name { CLOCKCTL_COUNTER_SUB  } -freq 143.36 -clockgroup clockctl_counter_sub  -route 0 # 112MHz or 120MHz or 143.36MHz",
                   "",
                   "## for main_clk pseudo path (can be standardized) #",
                   "### clock changing",
                   "define_false_path -from { i:ice.clockctl.mclk1mux.clk1mk }",
                   "define_false_path -from { i:ice.clockctl.mclk2mux.clk1mk }",
                   "define_false_path -from { i:ice.clockctl.evamclksel.clk1mk }",
                   "",
                   "### clock gen",
                   "define_false_path -from { i:ice.clockctl.main_out_neg }",
                   "define_false_path -from { i:ice.clockctl.main_out_pos }",
                   "",
                   "## for subsource pseudo path (can be standardized) #",
                   "### clock changing",
                   "define_false_path -from { i:ice.clockctl.sclkmux.clk1mk }",
                   "define_false_path -from { i:ice.clockctl.evasclksel.clk1mk }",
                   "",
                   "### clock gen",
                   "define_false_path -from { i:ice.clockctl.sub_out_neg }",
                   "define_false_path -from { i:ice.clockctl.sub_out_pos }",
                   "",
                   "define_false_path -from { i:ice.clockctl.subsource_sel.clk1mk }",
                   "define_false_path -from { i:ice.clockctl.subsource_pre_sel.clk2mk }",
                   "",
                   "###",
                   "### RTCCLK",
                   "###",
                   "## If don't define clock RTCCLK, subsource's period constraint will propagate to RTC circuits.",
                   "## Previously, RTCCLK domain maybe had not been constrained.",
                   "define_clock { n:chiptop.RTCCLK } -name { RTCCLK } -freq 10.00 -clockgroup RTCCLK -route 0",
                   "",
                   "# for ICE Macro ver after SS3rd_1_1_2 [end]",
                   "",
                   #                 "# add from 2011.01.25 Redmine Ticket #405 for FCLK <=> RESB Path",
                   #                 "define_false_path -from { c:FCLK } -to { i:#{$HIER}int48.main.sfrreg.IFREGDBG.ed_reg }", 
                   "",
                  ]
    elsif  $TARGET == "manatiipf" ||   $TARGET == "fmake" 
      @templete = ["#",
                   "# CLOCK Attribute",
                   "#",
                   "# ice system",
                   "define_clock { n:FMakeWire_ice_CLK30MHZ_GB } -name { CLK30MHZ_GB } -freq 30.000 -clockgroup clk30mhzgb -route 0.000",
                   "# ice system(dcm)",
                   "define_clock { n:FMakeWire_ice_CLK60MHZ } -name { CLK60MHZ } -freq 60.000 -clockgroup clk60mhz -route 0.000",
                   "# usb",
                   "define_clock { n:USBCLK } -name { USBCLK } -freq 20.000 -clockgroup usb -route 0.000",
                   "# host interface",
                   "define_clock { n:ice.ice_top.ICEWR } -name { ICEWR } -freq 2.000 -clockgroup icewr -route 0.000",
                   "# pseudo-emulation",
                   "define_clock { n:FMakeWire_ice_USBIFWR } -name { USBIFWR } -freq 2.000 -clockgroup usbifwr -route 0.000",
                   #                 "define_clock { n:ice.ice_top.timetagv2.CLK240M } -name { CLK240M } -freq 240 -clockgroup clk240m -route 0",
                   "define_clock { n:FMakeWire_ierl78clk240basev1_CLK240M } -name { CLK240M } -freq 240.000 -clockgroup clk240m -route 0",
                   "define_clock { n:FMakeWire_ierl78clk240basev1_CLK120M } -name { CLK120M } -freq 120.000 -clockgroup clk120m -route 0",
                   "define_clock { n:cspf.h_rosc.CLK160M } -name { CLK160M } -freq 160 -clockgroup clk160m -route 0",
                   "# for internal clock",
                   #                 "define_clock   { n:ice.ice_top.clockctl.clk112 } -name {clk112}  -freq 2 -clockgroup clk112 -route 0;",
                   #                 "define_clock   { n:ice.ice_top.clockctl.clk142 } -name {clk142}  -freq 2 -clockgroup clk142 -route 0;",
                   #                 "define_clock   { n:ice.ice_top.clockctl.clk147 } -name {clk147}  -freq 2 -clockgroup clk147 -route 0;",
                   #                 "define_clock   { n:ice.ice_top.clockctl.clk150 } -name {clk150}  -freq 2 -clockgroup clk150 -route 0;",
                   #                 "define_clock   { n:ice.ice_top.clockctl.main_clk } -name {main_clk}  -freq 2 -clockgroup main_clk -route 0;",
                   #                 "define_clock   { n:ice.ice_top.clockctl.mclktmp2 } -name {mclktmp2}  -freq 2 -clockgroup mclktmp2 -route 0;",
                   #                 "define_clock   { n:ice.ice_top.clockctl.sclktmp } -name {sclktmp}  -freq 2 -clockgroup sclktmp -route 0;",
                   "define_clock   { n:rst_res_n } -name { RESB }  -freq 2 -clockgroup RESB -route 0;",
                   "",
                   "#",
                   "# LOGIC Attribute",
                   "#",
                   #                 "define_false_path  -from { p:USB* };",
                   "define_false_path -to { i:ice.ice_top.host_interface.usb2usbif.hi_read_data* }",
                   "define_false_path -to { i:ice.ice_top.host_interface.usbif2ice.iceifa* }",
                   "define_false_path -to { i:ice.ice_top.host_interface.usbif2ice.iceifaclk_d2 }", 
                   "define_false_path -from { i:ice.ice_top.host_interface.VDDLEV* }",
                   "define_false_path -to { i:ice.ice_top.host_interface.snatch.en_snatch }",
                   #                 "define_false_path -through { n:ice.ice_top.host_interface.snatch.ICEDO* n:ice.ice_top.host_interface.snatch.ICEDO* } -through { n:ice.ice_top.host_interface.snatch.MDR* }",                 
                   "define_false_path -through { n:ice.ice_top.host_interface.snatch.ICEDO[31:0] } -through { n:ice.ice_top.host_interface.snatch.MDR[15:0] }",
                   #                 "define_multicycle_path  -through {n:ice.ice_top.break.PCWAITF}  -through {n:ice.ice_top.break.SVMODI} 10",
                   "define_false_path -to { i:ice.ice_top.break.STBRELESV }",
                   "define_false_path -through { n:ice.ice_top.ICERESB }",
                   "define_false_path -to { i:ice.ice_top.emem.rom.clksel.low1_p }",
                   "define_false_path -to { i:ice.ice_top.emem.rom.clksel.clksel_resetb_p }",
                   "define_false_path -to { i:ice.ice_top.emem.rom.clksel.clksel_p }",
                   "define_attribute { n:USBCLK } { syn_noclockbuf } { 1 }",
                   "define_attribute { n:ice.ice_top.ICEWR } { syn_noclockbuf } { 1 }",
                   "define_attribute { n:rst_res_n } { syn_noclockbuf } { 1 }",
                   "define_attribute { i:ice.ice_top.trace.trdata.pcwaitf_l } { syn_noclockbuf } { 1 }",
                   "# flash_cp",
                   "define_false_path -from { i:#{$HIER}cspf.flash_cp.*.*.* }",
                   "define_false_path -from { i:#{$HIER}cspf.flash_cp.*.*.*.* }",
                   "define_false_path -to { i:#{$HIER}cspf.flash_cp.*.*.* }",
                   "define_false_path -to { i:#{$HIER}cspf.flash_cp.*.*.*.* }",
                   "# timetag",
                   "define_max_delay -from { i:ice.ice_top.timetagv2.tag[31:0] } -to { i:ice.ice_top.trace.trdata.fch_data_l2[31:0] } { 3 }",
                   "define_max_delay -from { i:ice.ice_top.timetagv2.TAGOVF } -to { i:ice.ice_top.trace.trdata.tagovf_l1 } { 3 }",
                   #                 "define_false_path -to { i:ice.timetagv1.tagsvmod };",
                   "",
                   "#",
                   "# GROBAL",
                   "#",
                   "define_global_attribute  { syn_forward_io_constraints } { 0 }",
                   "define_global_attribute  { xc_use_timespec_for_io } { 0 }",
                   "define_global_attribute  { syn_useioff } { 1 }",
                   "define_global_attribute  { xc_fast_auto } { 1 }",
                   "",
                   "#",
                   "# Special Constraint about dummy-path at Device Logic",
                   "#",
                   #                 "define_max_delay -from { i:#{$HIER}csc.cg.hioscctl.fihsync.rsts } -to { i:#{$HIER}csc.cg.regi.hiostop_neg } { 10 }",
                   #                 "define_false_path -from { i:#{$HIER}cpu.alu.IE i:#{$HIER}cpu.alu.Z i:#{$HIER}cpu.alu.RBS[1:0] i:#{$HIER}cpu.alu.AC i:#{$HIER}cpu.alu.ISP[1:0] i:#{$HIER}cpu.alu.CY } -to { i:#{$HIER}csc.cg.tbase.stby.stpst_neg }",
                   "",
                   "#",
                   "# Special Constraint about dummy-path at Device Logid add on Oct 15,2010",
                   "#",
                   "# <<<Hold issue>>>",
                   "define_false_path -to { i:ice.ice_top.status.cpumclkst.clkm_p1 }",
                   "define_false_path -to { i:ice.ice_top.timetagv2.sampbck }",
                   "",
                   "# <<<tune the hi-level latch's effective timing>>>",
                   "define_max_delay -from { c:FCLK } -through { n:CK0IIC0 } -to { i:pericore.mp200.iic*.micg_gate_0.U1.* } { 31.25 }",
                   "define_max_delay -from { c:FCLK } -through { n:pericore.mp200.porga.main.regctl.pclkrw_latch.G001 } -to { i:pericore.mp200.porga.main.regctl.pclkrw_latch.* } { 31.25 }",
                   "",
                   "#define_path_delay  -through {n:cspf.mc200.mod.modectl_usertop.modectl_incdec.crc0_gate.G001}  -to {{i:cspf.mc200.mod.modectl_usertop.modectl_incdec.crc0_gate.*}}  -max 29",
                   "# Cut pseudo path (crc0_gate.G001 propagate to latch's din-pin and clock-pin.)",
                   "#define_false_path -through {n:cspf.mc200.mod.modectl_usertop.modectl_incdec.crc0_gate.G001} -through {n:cspf.mc200.csc.cg.tbase.fclk_cts.clkout} -to {i:cspf.mc200.mod.modectl_usertop.modectl_incdec.crc0_gate.*}",
                   "#define_false_path -from {i:cspf.mc200.mod.modectl_usertop.modectl_incdec.usrcrcctl.crcctl[6]} -through {n:cspf.mc200.csc.cg.tbase.fclk_cts.clkout} -to {i:cspf.mc200.mod.modectl_usertop.modectl_incdec.crc0_gate.*}",
                   "",
                   "define_max_delay -from { c:FCLK } -through { n:cspf.mc200.cibc.nvmchk.baseck_latch.G001 } -to { i:cspf.mc200.cibc.nvmchk.baseck_latch.* } { 31.25 }",
                   "define_max_delay -from { c:FCLK } -through { n:cspf.mc200.cibc.fmop.frqdec.we_frqsel } -to { i:cspf.mc200.cibc.fmop.frqdec.frqselck_latch.* } { 31.25 }",
                   "define_max_delay -from { c:FCLK } -through { n:cspf.mc200.cibc.fmop.b_trmlv2_iref_en } -to { i:cspf.mc200.cibc.fmop.main.trmlv.irefck_latch.* } { 31.25 }",
                   "define_max_delay -from { c:FCLK } -through { n:cspf.mc200.cibc.fmop.b_trmlv2_vreadC_en } -to { i:cspf.mc200.cibc.fmop.main.trmlv.vreadCck_latch.* } { 31.25 }",
                   "define_max_delay -from { c:FCLK } -through { n:cspf.mc200.cibc.fmop.main.baseck_latch.G001 } -to { i:cspf.mc200.cibc.fmop.main.baseck_latch.* } { 31.25 }",
                   "define_max_delay -from { c:FCLK } -through { n:OPBOEN } -to { i:cspf.mc200.csc.rg.lvictl.main.lvimd_gate.* } { 31.25 }",
                   "",
                   "# <<<32MHz issue>>>",
                   "#define_false_path -from {i:#{$HIER}cpu.alu.Z i:#{$HIER}cpu.alu.CY i:#{$HIER}cpu.alu.RBS[1] i:#{$HIER}cpu.alu.RBS[0]} -to {i:#{$HIER}csc.cg.tbase.stby.stpst_neg}",
                   "",
                   "define_false_path -from { i:cspf.mc200.cpu.alu.* } -to { i:cspf.mc200.csc.cg.tbase.stby.stpst_neg }",
                   "define_false_path -through { n:cspf.mc200.cpu.adr.slmirr } -to { i:cspf.mc200.csc.cg.tbase.stby.stpst_neg }",
                   "define_false_path -from { i:cspf.mc200.cpu.adr.pa_data_maw i:cspf.mc200.cpu.adr.pa_data_buf i:cspf.mc200.cpu.adr.pa_data_mlt1 i:cspf.mc200.cpu.adr.pa_data_cyc1 } -to { i:cspf.mc200.csc.cg.tbase.stby.stpst_neg }",
                   "define_false_path -through { n:cspf.mc200.cpu.alu.SP_usr[*] n:cspf.mc200.cpu.alu.SP_sv[*] } -to { i:cspf.mc200.csc.cg.tbase.stby.stpst_neg }",
                   "define_false_path -through { n:cspf.mc200.cpu.adr.maw[*] } -to { i:cspf.mc200.csc.cg.tbase.stby.stpst_neg }",
                   "",
                   "# <<<ICE WakeUp issue>>>",
                   "#define_path_delay  -through {n:cspf.mc200.cibc.fmop.main.trmlv.bgrt_clk.bgrt_en}  -to {{i:cspf.mc200.cibc.fmop.main.trmlv.bgrt_latch.bgrt_0.ft3_latch1.*}}  -max 10",
                   "#define_path_delay  -through {n:cspf.mc200.cibc.fmop.main.trmlv.bgrtc_clk.bgrt_en}  -to {{i:cspf.mc200.cibc.fmop.main.trmlv.bgrtc_latch.bgrtc_0.ft3_latch1.*}}  -max 10",
                   "",
                   "define_attribute { n:cspf.mc200.cibc.fmop.main.trmlv.bgrt_clk.* } syn_noclockbuf { 1 };",
                   "define_attribute { n:cspf.mc200.cibc.fmop.main.trmlv.bgrtc_clk.* } syn_noclockbuf { 1 };",
                   "",
                   "# <<<invalidate cibc circuit of decision by majority. (ICE Only)>>>",
                   "define_false_path -to { i:cspf.mc200.cibc.fmop.main.trmlv.bgrt_latch.bgrt_*.ft3_latch*.* }",
                   "define_false_path -to { i:cspf.mc200.cibc.fmop.main.trmlv.bgrtc_latch.bgrtc_*.ft3_latch*.* }",
                   "define_false_path -from { i:cspf.mc200.cibc.fmop.main.trmlv.bgrt_latch.bgrt_*.ft3_latch*.* }",
                   "define_false_path -from { i:cspf.mc200.cibc.fmop.main.trmlv.bgrtc_latch.bgrtc_*.ft3_latch*.* }",
                   "",
                   "# add from 2010.12.06",
                   "define_false_path -from { i:cspf.mc200.csc.cg.hioscctl.fmain_sel.cksel_fih_p2.ckmsk2 }",
                   "define_false_path -from { i:cspf.mc200.csc.cg.hioscctl.fmain_sel.cksel_fmx.ckmsk2 }",
                   "define_false_path -from { i:cspf.mc200.csc.cg.hioscctl.fmain_sel.cksel_fmain_p.ckmsk2 }",
                   "define_false_path -from { i:cspf.mc200.csc.cg.hioscctl.fmain_sel.cksel_fmain_p.ckmsk1_p }",
                   "define_false_path -from { i:ice.ice_top.emem.rom.icewr_start_latch }",
                   "define_false_path -from { i:ice.ice_top.emem.rom.ice_write_latch }",
                   "# add from 2010.12.17 Redmine Ticket:#277",
                   "define_false_path -from { i:cspf.mc200.cpu.adr.ID_stage* } -through { n:cspf.mc200.cpu.adr.svmodf } -through { n:ice.ice_top.break.SVI } -to { i:cspf.mc200.csc.cg.tbase.stby.stpst_neg }",
                   "# add from 2010.12.24 Redmine Ticket #287 for Main/Sub OSC generating clock problem",
                   "define_compile_point { v:work.clockctl_cksel } -type { locked }",
                   "# for CSC1V2",
                   "define_compile_point { v:work.QLK0RCSC1V2_CG_CKSEL1 } -type { locked }",
                   "define_compile_point { v:work.QLK0RCSC1V2_CG_CKSEL2 } -type { locked }",
                   "define_compile_point { v:work.QLK0RCSC1V2_CG_MUX } -type { locked }",
                   "# for CSC1V3",
                   "define_compile_point { v:work.QLK0RCSC1V3_CG_CKSEL1 } -type { locked }",
                   "define_compile_point { v:work.QLK0RCSC1V3_CG_CKSEL2 } -type { locked }",
                   "define_compile_point { v:work.QLK0RCSC1V3_CG_MUX } -type { locked }",                   
                   "# for LVI interrupt and reset mode",
                   "define_compile_point { v:work.QLK0RCSC1V2_CG_MUX } -type { locked }",
                   "define_compile_point { v:work.QLK0RCSC1V3_CG_MUX } -type { locked }",
                   "# for DataFlash erase",
                   "define_compile_point { v:work.CLKSEL } -type { locked }",
                   "# for PGCSC",
                   "define_compile_point { v:work.QLK0RPGCSC1V3_CG_CKSEL1 } -type { locked }",
                   "define_compile_point { v:work.QAHPLMF3MPLLV1_CKSEL } -type { locked }",
                   "",
                   "# for ICE Macro ver after SS3rd_1_1_2 [begin]",
                   "",
                   "define_max_delay -from { c:ICEWR } -to { i:ice.ice_top.clockctl.eoscsck_sync* } { 13.95 } # 143.36MHz x 2clock",
                   "define_clock { n:ice.ice_top.clockctl.main_clk  } -name { CLOCKCTL_COUNTER_MAIN } -freq 150    -clockgroup clockctl_counter_main -route 0 # 60MHz or 112MHz or 142.5MHz or 147.273MHz or 150MHz",
                   "define_clock { n:ice.ice_top.clockctl.subsource } -name { CLOCKCTL_COUNTER_SUB  } -freq 143.36 -clockgroup clockctl_counter_sub  -route 0 # 112MHz or 120MHz or 143.36MHz",
                   "",
                   "## for main_clk pseudo path (can be standardized) #",
                   "### clock changing",
                   "define_false_path -from { i:ice.ice_top.clockctl.mclk1mux.clk1mk }",
                   "define_false_path -from { i:ice.ice_top.clockctl.mclk2mux.clk1mk }",
                   "define_false_path -from { i:ice.ice_top.clockctl.evamclksel.clk1mk }",
                   "",
                   "### clock gen",
                   "define_false_path -from { i:ice.ice_top.clockctl.main_out_neg }",
                   "define_false_path -from { i:ice.ice_top.clockctl.main_out_pos }",
                   "",
                   "## for subsource pseudo path (can be standardized) #",
                   "### clock changing",
                   "define_false_path -from { i:ice.ice_top.clockctl.sclkmux.clk1mk }",
                   "define_false_path -from { i:ice.ice_top.clockctl.evasclksel.clk1mk }",
                   "",
                   "### clock gen",
                   "define_false_path -from { i:ice.ice_top.clockctl.sub_out_neg }",
                   "define_false_path -from { i:ice.ice_top.clockctl.sub_out_pos }",
                   "",
                   "define_false_path -from { i:ice.ice_top.clockctl.subsource_sel.clk1mk }",
                   "define_false_path -from { i:ice.ice_top.clockctl.subsource_pre_sel.clk2mk }",
                   "",
                   "###",
                   "### RTCCLK",
                   "###",
                   "## If don't define clock RTCCLK, subsource's period constraint will propagate to RTC circuits.",
                   "## Previously, RTCCLK domain maybe had not been constrained.",
                   "define_clock { n:chiptop.RTCCLK } -name { RTCCLK } -freq 10.00 -clockgroup RTCCLK -route 0",
                   "",
                   "# for ICE Macro ver after SS3rd_1_1_2 [end]",
                   "",
                   #                 "# add from 2011.01.25 Redmine Ticket #405 for FCLK <=> RESB Path",
                   #                 "define_false_path -from { c:FCLK } -to { i:#{$HIER}int48.main.sfrreg.IFREGDBG.ed_reg }", 
                   "",
                  ]
    end
    
  end
  # For name-changing
  attr_reader :UnConvertClock
  def initialize
    @Rule_pre = {
      # First
      "optexcck_mux\/root\/N01" => "fclkds",
      "optexcck_mux\/clk_gate2" => "fclkds",
      "npbbb\/U36\/N01" => "npbbb\/SGVPSTB",
      "npbbb\/U38\/N01" => "npbbb\/MTRCVPSTB",
      "npbbb\/U37\/N01" => "npbbb\/CAN1VPSTB",
      "npbbb\/can0wait_ctl\/U3\/N01" => "npbbb\/CAN0VPSTB",
      "lcdctl\/FLCDCLGEN\/U100\/N01" => "lcdctl\/FLCDCL",
      "pllctl\/fpll_cts3\/root\/N01" => "pllctl\/fpllpp",
      "clkctl\/pllctl\/fmain_clm_cts\/root\/N01" => "clkctl\/pllctl\/fmainclm",
      "cspf\/h_rosc\/FIHFL" => "cspf.clk_fihfl",
      "cspf\/oscsub\/RTCCLK" => "cspf.clk_fsx_rtc",
      "cspf.pgcsc.kerneltop.wdtlococtl.wdt_l_rosc.LOSCOUT" => "cspf.pgcsc.kerneltop.wdtlococtl.clk_wdt_loscout",
      "cspf\/pgcsc\/kerneltop\/wdtlococtl\/wdt_l_rosc\/LOSCOUT" => "cspf.pgcsc.kerneltop.wdtlococtl.clk_wdt_loscout",
      "cspf.pgcsc.kerneltop.pllctl.pll.FO" => "cspf.pgcsc.kerneltop.pllctl.fpll64mclm",
      "cspf\/pgcsc\/kerneltop\/pllctl\/pll\/FO" => "cspf.pgcsc.kerneltop.pllctl.fpll64mclm",
      "cspf.mc200.csc.cg.tbase.fclk_cts.vc_muxclk2_cell.y" => "cspf.mc200.csc.cg.tbase.fclk",
      "cspf\/mc200\/csc\/cg\/tbase\/fclk_cts\/vc_muxclk2_cell\/y" => "cspf.mc200.csc.cg.tbase.fclk",
      "cspf.mc200.csc.cg.mosccnt.fmx4_cts.vc_muxclk2_cell.y" => "cspf.mc200.csc.cg.mosccnt.fmx4",
      "cspf\/mc200\/csc\/cg\/mosccnt\/fmx4_cts\/vc_muxclk2_cell\/y" => "cspf.mc200.csc.cg.mosccnt.fmx4",
      "cspf/mc200/csc/cg/oscctl/root_oscouts/dly300n/NFOUT" => "cspf.mc200.csc.cg.oscctl.oscouts_nf_p",
      "cspf.mc200.csc.cg.hioscctl.fmain_sel.fih_p3_cts.vc_muxclk2_cell.y" => "cspf.mc200.csc.cg.hioscctl.fmain_sel.fih_p3",
      "cspf\/mc200\/csc\/cg\/hioscctl\/fmain_sel\/fih_p3_cts\/vc_muxclk2_cell\/y" => "cspf.mc200.csc.cg.hioscctl.fmain_sel.fih_p3",
      "cspf\/h_rosc\/FIHOCD" => "cspf.clk_fihocd",
      "cspf.h_rosc.R32MOUT" => "cspf.clk_fhoco",
      "cspf\/h_rosc\/R32MOUT" => "cspf.clk_fhoco",      
      "cspf.mc200.csc.cg.hioscctl.fihsync.fih4_cts.vc_muxclk2_cell.y" => "cspf.mc200.csc.cg.hioscctl.fihsync.fih4",
      "cspf\/mc200\/csc\/cg\/hioscctl\/fihsync\/fih4_cts\/vc_muxclk2_cell\/y" => "cspf.mc200.csc.cg.hioscctl.fihsync.fih4",
      "pericore\/mp200\/pcbz\/pcbz\/fsub_cts\/clk_gate\/Y" => "pericore.mp200.pcbz.pcbz.fsub_scck",
      "cspf\/oscmain\/OSCOUTM" => "cspf.clk_fm",
      "cspf\/l_rosc\/LOSCOUT" => "cspf.clk_fil",
      "cspf.mc200.csc.rg.lvictl.counter.fil15kin_mux.vc_muxclk2_cell.y" => "cspf.mc200.csc.rg.lvictl.counter.fil15kin",
      "cspf\/mc200\/csc\/rg\/lvictl\/counter\/fil15kin_mux\/vc_muxclk2_cell\/y" => "cspf.mc200.csc.rg.lvictl.counter.fil15kin",
      "cspf\/mc200\/ocd\/main\/uart\/uart_bcounter\/root\/vc_bufclk_cell\/vc_bufclk_cell\/Y" => "cspf.mc200.ocd.main.uart.uart_bcounter.clk16m_s",
      "pericore\/mp200\/pcbz\/pcbz\/fmain_cts\/clk_gate\/Y" => "pericore.mp200.pcbz.pcbz.fmain_scck"
    }

    @Rule  = {
      # High - priority
      # Custom
      "_reg\\/H\\d+$" => "",
      "\\/C\\d*\\/\\d+$" => "",
      "_reg_\\d*_\\/H\\d+$" => "",
#      "_reg\\[" => "\[",
      "\\.H\\d+$" => "",
      "_reg\\/N\\d+$" => "",
      "_reg$" => "",
      "\.C\\d+$" => "",
      "\.H\\d+$" => "",
      "\/C\\d+$" => "",
      "\/H\\d+$" => "",
     "_reg\.\/H\\d+$" => "[\*]",
     "_reg_\\*_" => "[\*]",
      "\/U\\d+\/H\\d+$" => "",
      "\/N\\d+$" => "",
      "\/C\\d+$" => "",
      "\/U\\d+$" => "",
      "\/U\\d+\/N\\d+$" => "",
      "\/B\\d+$" => "",
      "\/BL\\d+$" => "",
      "_U\\d+\/H\\d+$" => "",
      
      # for ad
      "ad\/soft_top\/" => "ad\/",
      
      # Kx4 Custom
      "cksel_fdsc\/clk_gate" => "fih_p",
      "main_trmlv" => "main.trmlv",
      "fsub_cts" => "fsub_scck",
      "fmain_cts" => "fmain_scck",
      "uart_bcounter" => "sclock_16m",
      "fih32m" => "fih_p",
      "fil15kin_mux\/clk_gate2" => "fil15kin",
      "fil15kin_mux\/root" => "fil15kin",
      "oscctl\/root_oscouts\/out" => "oscouts_nf_p",
      "modectl\/TESENI" => "TESENI",
      "port13\/PRDATA" => "PRDP13",
      "port2\/PRDATA" => "PRDP02",
      "port12\/PRDATA" => "PRDP12",
      "port\\*\/TDIN" => "TDIN",
      "porga\/SEL" => "SEL",
#      "stby\/stpst" => "stpst",
      "port7\/INTKR" => "INTKR",
      "modectl\/OPTOPLRD" => "OPTOPLRD",
      "main_trmlv_bgrt_latch_bgrt" => "main_trmlv\/bgrt_latch\/bgrt",
      "main_trmlv_bgrtc_latch_bgrtc" => "main_trmlv\/bgrtc_latch\/bgrtc",
      "main_trmlv_bgrt" => "main_trmlv\/bgrt",
      "main_trmlv_bgrtc" => "main_trmlv\/bgrtc",
      "_cku_cts\/clk_gate1" => "",
      "ft3_latch\\*" => "ft3_latch\*\/DLSFQ2_inst\/LDCPE_inst",
      " BBFCLK " => " FCLK ",
      "clkctl\/fil" => "clkctl\/FIL",


      # for clock
      "_cts\/root" => "", 
      "\\/root$" => "",
     "_cts\/root\/N\\d*$" => "",
      "\/root\/C\\d+\/N\\d+$" => "",
      "\/\\*\/N\\d+$" => "",

    }
    
    @Convert = ["__\(\\d+\)__",
                "_reg_\(\\d+\)_",
    ]

    # Udef_file
    udef_file = File.dirname(__FILE__) + "/../conf/kx4.udef"
    udef = Common.file_read("#{udef_file}","off")
    @clock_name = Array.new
    udef.each{|each_clock|
      next if each_clock.strip.size == 0
      next if each_clock.strip[0].chr == "#"
      @clock_name << each_clock.split[0]
    }

    # Change List
    list_file = File.dirname("#{__FILE__}") + "/../conf/SDCChange.lst"
    @UnConvertClock = Array.new
    File.open("#{list_file}").each{|line|
      # next
      next if line.strip == "" || line.strip[0] == 35
      tmp = line.strip.split(",")
      id = tmp[0]
      case id
      when "D"
        @UnConvertClock << tmp[1].split[0]
      end
    }

  end

  #
  # change
  #  - change signal path name using name
  #
  def change(str)
    tmp = str
    
    @Convert.each{|org|
      /#{org}/ =~ tmp
      tmp =  $` + "[" + $1 + "]" + $' if $1 != nil
    }
    
    @Rule_pre.each{|before,after|
      tmp = tmp.sub(/#{before}/,"#{after}")
    }

    @Rule.each{|before,after|
      next if "FIH4" == tmp
      next if /RDCLKC1/ =~ tmp
      if /peri_penable_reg_reg\/N01/ =~ tmp
        tmp = tmp.sub(/peri_penable_reg_reg\/N01/,"peri_penable_reg")
        break
      end
      if /timd_0_dsprdata_reg_reg_\*\/H01/ =~ tmp
        tmp = tmp.sub(/timd_0_dsprdata_reg_reg_\*\/H01/,"timd_0_dsprdata_reg\[\*\]")
        break
      end
      if /H_bank\*_reg_\*\/H\d+/ =~ tmp
        tmp = tmp.sub(/H_bank\*_reg_\*\/H\d+/,"H_bank\*_reg\[\*\]")
        break
      end
      tmp = tmp.sub(/#{before}/,"#{after}")
    }
    return tmp
  end

  #
  # modify_signal
  #  - resolve signal path name using change-rule & error check
  #
  def modify_signal_each(each,line)
    # error_check
    if (
        ((/\[\s*list/ =~ each) != nil)
        ) 
      printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
      printf("  - \"%s\" signal may be un-analized completely.\n",each)
      exit
    end
    if ((/\[\s*get_pins/ =~ each) != nil)
      each =  each.gsub(/\[\s*get_pins/,"").gsub("]","") # Change String
    end
    if ((/\[\s*get_clocks/ =~ each) != nil)
      each =  each.gsub(/\[\s*get_clocks/,"").gsub("]","") # Change String
    end
    if each != nil
      tmp = each.split
      tmp2 = Array.new
      if tmp.size >= 2
        tmp.each{|signal|
          tmp2 << change(signal) + " "
        }
      else
        tmp2 << change(tmp.join)
      end
      return tmp2.join
    end
  end
  
  def modify_signal(data,line=nil)
    # for macor modify
    data.Signal_mod = modify_signal_each(data.Signal,line) if data.Signal != nil
    data.Pin_mod = modify_signal_each(data.Pin,line) if data.Pin != nil
    data.Source_mod = modify_signal_each(data.Source,line) if data.Source != nil
    data.From_mod = modify_signal_each(data.From,line) if data.From != nil
    data.FallFrom_mod = modify_signal_each(data.FallFrom,line) if data.FallFrom != nil
    data.To_mod = modify_signal_each(data.To,line) if data.To != nil
    data.FallTo_mod = modify_signal_each(data.FallTo,line) if data.FallTo != nil
    data.Through1_mod = modify_signal_each(data.Through1,line) if data.Through1 != nil
    data.Through2_mod = modify_signal_each(data.Through2,line) if data.Through2 != nil
    data.Through3_mod = modify_signal_each(data.Through3,line) if data.Through3 != nil
    data.Through4_mod = modify_signal_each(data.Through4,line) if data.Through4 != nil
    data.FallThrough1_mod = modify_signal_each(data.FallThrough1,line) if data.FallThrough1 != nil
    data.RiseThrough1_mod = modify_signal_each(data.RiseThrough1,line) if data.RiseThrough1 != nil
    data.FallThrough2_mod = modify_signal_each(data.FallThrough2,line) if data.FallThrough2 != nil
    data.FallThrough3_mod = modify_signal_each(data.FallThrough3,line) if data.FallThrough3 != nil
    data.FallThrough4_mod = modify_signal_each(data.FallThrough4,line) if data.FallThrough4 != nil

    # for pickup macro name
    data.SignalMacro = data.Signal_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.Signal != nil
    data.PinMacro = data.Pin_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.Pin != nil
    data.SourceMacro = data.Source_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.Source != nil
    data.FromMacro = data.From_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.From != nil
    data.FallFromMacro = data.FallFrom_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.FallFrom != nil
    data.ToMacro = data.To_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.To != nil
    data.FallToMacro = data.FallTo_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.FallTo != nil
    data.Through1Macro = data.Through1_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.Through1 != nil
    data.Through2Macro = data.Through2_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.Through2 != nil
    data.Through3Macro = data.Through3_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.Through3 != nil
    data.Through4Macro = data.Through4_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.Through4 != nil
    data.FallThrough1Macro = data.FallThrough1_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.FallThrough1 != nil
    data.RiseThrough1Macro = data.RiseThrough1_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.RiseThrough1 != nil
    data.FallThrough2Macro = data.FallThrough2_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.FallThrough2 != nil
    data.FallThrough3Macro = data.FallThrough3_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.FallThrough3 != nil
    data.FallThrough4Macro = data.FallThrough4_mod.gsub("socket/","").gsub("pericore/mp200/","").gsub("pericore/portiotop/","").split("/")[0] if data.FallThrough4 != nil

    data.NameChangeFlag = true if compare(data) == true
  end
  
  #
  # compare
  #  - compare original signal and modified signal
  #
  def compare(data)
    code = false
    code = true if data.Signal_mod != data.Signal
    code = true if data.Pin_mod != data.Pin
    code = true if data.Source_mod != data.Source
    code = true if data.From_mod != data.From
    code = true if data.FallFrom_mod != data.FallFrom
    code = true if data.To_mod != data.To
    code = true if data.FallTo_mod != data.FallTo
    code = true if data.Through1_mod != data.Through1
    code = true if data.FallThrough1_mod != data.FallThrough1
    code = true if data.RiseThrough1_mod != data.RiseThrough1
    code = true if data.Through2_mod != data.Through2
    code = true if data.FallThrough2_mod != data.FallThrough2
    code = true if data.Through3_mod != data.Through3
    code = true if data.Through4_mod != data.Through4
    code = true if data.FallThrough3_mod != data.FallThrough3
    code = true if data.FallThrough4_mod != data.FallThrough4
    return code
  end

  
  #
  # jucge_remove_macro
  #   RemoveFlag = true when the attribute data has the signal with removed macro
  #
  def judge_remove_macro(const_data,rm_list)
    printf("@I:Constraint remove operation\n")
    const_data.each_value{|data|
      data[1].each{|const|
        # macro name
        # remove
        const[1].RemoveFlag = true if rm_list.key?(const[1].SignalMacro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].PinMacro) 
        const[1].RemoveFlag = true if rm_list.key?(const[1].SourceMacro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FromMacro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FallFromMacro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].ToMacro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FallToMacro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].Through1Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].Through2Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].Through3Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].Through4Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FallThrough1Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].RiseThrough1Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FallThrough2Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FallThrough3Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FallThrough4Macro)
        
        # remove "*"
        const[1].SignalMacro = const[1].SignalMacro.gsub("\*","") if const[1].SignalMacro != nil
        const[1].PinMacro = const[1].PinMacro.gsub("\*","") if const[1].PinMacro != nil
        const[1].SourceMacro = const[1].SourceMacro.gsub("\*","") if const[1].SourceMacro != nil
        const[1].FromMacro = const[1].FromMacro.gsub("\*","") if const[1].FromMacro != nil
        const[1].FallFromMacro = const[1].FallFromMacro.gsub("\*","") if const[1].FallFromMacro != nil
        const[1].ToMacro = const[1].ToMacro.gsub("\*","") if const[1].ToMacro != nil
        const[1].FallToMacro = const[1].FallToMacro.gsub("\*","") if const[1].FallToMacro != nil
        const[1].Through1Macro = const[1].Through1Macro.gsub("\*","") if const[1].Through1Macro != nil
        const[1].Through2Macro = const[1].Through2Macro.gsub("\*","") if const[1].Through2Macro != nil
        const[1].Through3Macro = const[1].Through3Macro.gsub("\*","") if const[1].Through3Macro != nil
        const[1].Through4Macro = const[1].Through4Macro.gsub("\*","") if const[1].Through4Macro != nil
        const[1].FallThrough1Macro = const[1].FallThrough1Macro.gsub("\*","") if const[1].FallThrough1Macro != nil
        const[1].RiseThrough1Macro = const[1].RiseThrough1Macro.gsub("\*","") if const[1].RiseThrough1Macro != nil
        const[1].FallThrough2Macro = const[1].FallThrough2Macro.gsub("\*","") if const[1].FallThrough2Macro != nil
        const[1].FallThrough3Macro = const[1].FallThrough3Macro.gsub("\*","") if const[1].FallThrough3Macro != nil
        const[1].FallThrough4Macro = const[1].FallThrough4Macro.gsub("\*","") if const[1].FallThrough4Macro != nil

        # remove
        const[1].RemoveFlag = true if rm_list.key?(const[1].SignalMacro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].PinMacro) 
        const[1].RemoveFlag = true if rm_list.key?(const[1].SourceMacro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FromMacro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FallFromMacro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].ToMacro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FallToMacro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].Through1Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].Through2Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].Through3Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].Through4Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FallThrough1Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].RiseThrough1Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FallThrough2Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FallThrough3Macro)
        const[1].RemoveFlag = true if rm_list.key?(const[1].FallThrough4Macro)
      }if data[1] != nil
    }

    # Special Condition
    #  - Remove attribute under all following codition
    #     1. define_false_path
    #     2. only corresponding cpu module
=begin
    const_data.each{|attribute,data|
      if attribute != nil
        data[1].each{|const|
          if cpu_search(const[1]) == true
            const[1].RemoveFlag = true
          end
        }
      end
    }
=end
  end

  def cpu_search(data)
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
    macro_list << data.RiseThrough1Macro if data.RiseThrough1Macro != nil
    macro_list << data.FallThrough2Macro if data.FallThrough2Macro != nil
    macro_list << data.FallThrough3Macro if data.FallThrough3Macro != nil
    macro_list << data.FallThrough4Macro if data.FallThrough4Macro != nil
    macro_list = macro_list.uniq
    macro_list.each{|const|
      return false if const != "cpu"
    }
    return true
  end
end

#############################################################
# set_false_path
#############################################################
class SetFalsePath
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def pattern_error(line)
    printf("@Internal error. (file:%s,line:%s)\n",__FILE__,line)
    exit
  end

  def analize
    pat = ConstCtrl.new
    attribute   = "\\s*set_false_path"
    @DeviceConst.each{|line,data|
     if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      data.Attribute = "set_false_path"
      if( ( /^#{attribute}#{ConstCtrl::FROM_CLOCKS}#{ConstCtrl::TO_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = "all_clocks" # special case
        data.To   = "all_clocks" # special case
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.Through4 = $4.strip
        data.Type = "Through1Through2Through3Through4"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.To = $4.strip
        data.Type = "Through1Through2Through3To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.Type = "Through1Through2Through3"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.To = $3.strip
        data.Type = "Through1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Type = "Through1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.To = $4.strip
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Through2   = $3.strip 
        data.To = $4.strip
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::THROUGH_SIGNAL}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Through2   = $3.strip 
        data.To = $4.strip
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Through2   = $3.strip 
        data.Through3   = $4.strip
        data.To = $5.strip
        data.Type = "FromThrough1Through2Through3To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Through2   = $3.strip 
        data.To = $4.strip
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.To = $3.strip
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.To = $3.strip
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.To = $3.strip
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::THROUGH_LIST_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Through2   = $3.strip 
        data.To = $4.strip
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Through2   = $3.strip 
        data.To = $4.strip
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_CLOCKS}#{ConstCtrl::TO_INPUTS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = "all_clocks" # special case
        data.To   = "all_inputs" # special case
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_INPUTS}#{ConstCtrl::TO_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = "all_inputs" # special case
        data.To   = "all_inputs" # special case
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.Through3 = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2Through3Setup"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Through2   = $3.strip
        data.Type = "FromThrough1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To   = $2.strip 
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::RISE_THROUGH_GETPIN}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.SetupFlag = true
        data.Type = "RiseThrough1Through2Through3Setup"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::RISE_FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.SetupFlag = true
        data.Type = "RiseFromThrough1Through2Setup"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2Setup"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FALL_THROUGH_GETPIN}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.SetupFlag = true
        data.Type = "FallThrough1Through2Through3Setup"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From     = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.Through3 = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2Through3Setup"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From     = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.To = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2ToSetup"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.Through4 = $4.strip
        data.Type = "Through1Through2Through3Through4"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.Through4 = $4.strip
        data.Type = "Through1Through2Through3Through4"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.Through4 = $4.strip
        data.SetupFlag = true
        data.Type = "Through1Through2Through3Through4"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.Type = "Through1Through2Through3"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.To = $3.strip
        data.Type = "Through1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.SetupFlag = true
        data.Type = "Through1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Type = "Through1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CELL}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CELL}#{ConstCtrl::TO_GET_CELL}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::TO_GET_CELL}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_LIST}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_MACRO}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FALL_THROUGH_LIST}#{ConstCtrl::FALL_TO_LIST}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.FallThrough1 = $1.strip
        data.FallTo = $2.strip
        data.SetupFlag = true
        data.Type = "FallThrough1FallTo"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FALL_THROUGH_GETPIN}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.FallThrough1 = $1.strip
        data.Through2 = $2.strip
        data.SetupFlag = true
        data.Type = "SetupFallThrough1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_MACRO}#{ConstCtrl::TO_LIST}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FALL_THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.FallThrough1 = $1.strip
        data.To = $2.strip
        data.Type = "FallThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_MACRO}#{ConstCtrl::TO_MACRO}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.HoldFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From     = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.Through3 = $4.strip
        data.To       = $5.strip
        data.Type = "FromThrough1Through2Through3To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From     = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.To       = $5.strip
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From     = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.Through3 = $4.strip
        data.To       = $5.strip
        data.Type = "FromThrough1Through2Through3To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.SetupFlag = true
        data.Type = "From"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.To = $2.strip
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.SetupFlag = true
        data.Type = "Through1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Type = "Through1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.To = $1.strip
        data.Type = "To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}\s+-to\s+list\s+(.*)$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}\s+-from\s+list(.*)-to\s+\[\s*list\s+(\S+)\]#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}\s+-from\s+list(.*)-to\s+list\s+(\S+)$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}\s+-to\s+list\s+(.+)$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_SIGNAL}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Type = "From"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.To   = $2.strip
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::TO_LIST_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To   = $2.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_LIST_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.To   = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_LIST_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.To   = $3.strip
        data.SetupFlag = true
        data.Type = "Through1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.To = $3.strip
        data.Type = "Through1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.HoldFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.SetupFlag = true
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}\s+-to\s+list\s+(.*)$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.To = $1.strip
        data.Type = "To"
      elsif( ( /^#{attribute}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.To = $1.strip
        data.Type = "To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.To = $2.strip
        data.HoldFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.SetupFlag = true
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_INPUTS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = "all_inputs" # special case
        data.SetupFlag = true
        data.Type = "FromSetup"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.SetupFlag = true
        data.Type = "Through1Through2Through3Setup"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Type = "Through1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.SetupFlag = true
        data.Type = "Through1Through2Setup"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.To = $1.strip
        data.SetupFlag = true
        data.Type = "ToSetup"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.SetupFlag = true
        data.Type = "Through1Setup"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.To = $2.strip
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FALL_THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.SetupFlag = true
        data.Type = "FallThrough1Through2Through3Setup"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::RISE_THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.SetupFlag = true
        data.Type = "RiseThrough1Through2Through3Setup"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.Type = "FromThrough1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.Type = "FromThrough1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.Type = "FromThrough1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::RISE_THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.RiseThrough1 = $2.strip
        data.Through2 = $3.strip
        data.SetupFlag = true
        data.Type = "FromRiseThrough1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.To = $4.strip
        data.Type = "Through1Through2Through3To"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Through3 = $3.strip
        data.To = $4.strip
        data.Type = "Through1Through2Through3To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FALL_FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.FallFrom = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.SetupFlag = true
        data.Type = "FallFromThrough1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::HOLD}#{ConstCtrl::RISE_THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.RiseThrough1 = $1.strip
        data.To = $2.strip
        data.HoldFlag = true
        data.Type = "RiseThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::RISE_THROUGH_SIGNAL_D}#{ConstCtrl::TO_LIST_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.RiseThrough1 = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "RiseThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_SIGNAL_D}\s+-through\s+(.*)#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CELL}#{ConstCtrl::TO_LIST_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_GET_CELL}#{ConstCtrl::TO_LIST_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.HoldFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Type = "From"
      elsif( ( /^#{attribute}#{ConstCtrl::HOLD}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.To = $1.strip
        data.HoldFlag = true
        data.Type = "To"
      elsif( ( /^#{attribute}#{ConstCtrl::TO_LIST}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.To = $1.strip
        data.SetupFlag = true
        data.Type = "To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::RISE_THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.SetupFlag = true
        data.Type = "RiseThrough1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Through2   = $3.strip 
        data.To   = $4.strip 
        data.HoldFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.Through2   = $3.strip 
        data.To   = $4.strip 
        data.SetupFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1   = $2.strip 
        data.To   = $3.strip 
        data.SetupFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.To = $1.strip
        data.SetupFlag = true
        data.Type = "To"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.SetupFlag = true
        data.Type = "From"
      elsif( ( /^#{attribute}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.HoldFlag = true
        data.Type = "Through1"
      else
        p data.ModLine
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      
      pat.modify_signal(data,line)
    }
  end


  #
  # convert
  #
  def convert(sdc_attribute)
    pat = ConstCtrl.new
    @DeviceConst.each{|line,data|
      sdc = Array.new
      # ver0.4 Limitation
=begin
      if data.SetupFlag == true
        data.ConvertFlag = false
        data.LimitFlag = true
        sdc << line
        data.SDC = sdc
        $NOTE_CNT += 1
        printf("@N:\"%s\" line cannnot convert because is has setup attribute.\n",line) if $VERBOSE
        @UnConvertedAttributeList << line  if !data.RemoveFlag
      else
=end
      case data.Type
      when "Through1Through2Through3Through4" then
        data.ConvertFlag = true
        through1_mod = data.Through1_mod.split
        through2_mod = data.Through2_mod.split
        through3_mod = data.Through3_mod.split
        through4_mod = data.Through4_mod.split
        sdc = "define_false_path "
        sdc = sdc + "-through { "
        through1_mod.each{|through1|
          sdc = sdc + pat.hier_net(through1) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through2_mod.each{|through2|
          sdc = sdc + pat.hier_net(through2) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through3_mod.each{|through3|
          sdc = sdc + pat.hier_net(through3) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through4_mod.each{|through4|
          sdc = sdc + pat.hier_net(through4) + " "
        }
        sdc = sdc + "}"       
=begin
        through1_mod.each{|through1|
          through2_mod.each{|through2|
            through3_mod.each{|through3|
              through4_mod.each{|through4|
                sdc << "define_multicycle_path -through { " + pat.hier_net(through1) \
                + " } -through { " + pat.hier_net(through2) \
                + " } -through { " + pat.hier_net(through3) \
                + " } -through { " + pat.hier_net(through4) \
                + " } { 3 }"
              }
            }
          }
        }
=end
#        data.SDC = sdc.to_a
          data.SDC = Array(sdc)
        data.SDCAttribute = "define_multicycle_path"
        $NOTE_CNT += 1
        printf("@N:\"%s\" line convert define_multicycle_path because is has multiple through point and Synplify Pro doesnt support multi-through on false_path\n",line) if $VERBOSE
        
      when "FromThrough1Through2Through3To" then
        data.ConvertFlag = true
        from_mod       = data.From_mod.split
        through1_mod = data.Through1_mod.split
        through2_mod = data.Through2_mod.split
        through3_mod = data.Through3_mod.split
        to_mod = data.To_mod.split
        sdc = "define_false_path "
        sdc = sdc + "-from { "
        from_mod.each{|from|
          if $CLOCK_INF["#{from}"] == nil
            sdc = sdc + pat.hier_cell(from) + " "
          else
            sdc = sdc + pat.hier_clock(from) + " "
          end
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through1_mod.each{|through1|
          sdc = sdc + pat.hier_net(through1) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through2_mod.each{|through2|
          sdc = sdc + pat.hier_net(through2) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through3_mod.each{|through3|
          sdc = sdc + pat.hier_net(through3) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-to { "
        to_mod.each{|to|
          if $CLOCK_INF["#{to}"] == nil
            sdc = sdc + pat.hier_cell(to) + " "
          else
            sdc = sdc + pat.hier_clock(to) + " "
          end
        }
        sdc = sdc + "}"       
=begin
        from_mod.each{|from|
          through1_mod.each{|through1|
            through2_mod.each{|through2|
              through3_mod.each{|through3|
                to_mod.each{|to|
                  sdc << "define_multicycle_path -from { " + pat.hier_cell(from) \
                  + " } -through { " + pat.hier_net(through1) \
                  + " } -through { " + pat.hier_net(through2) \
                  + " } -through { " + pat.hier_net(through3) \
                  + " } -to { " + pat.hier_cell(to) \
                  + " } { 3 }"
                }
              }
            }
          }
        }
=end
#        data.SDC = sdc.to_a
          data.SDC = Array(sdc)
        data.SDCAttribute = "define_multicycle_path"
        $NOTE_CNT += 1
        printf("@N:\"%s\" line convert define_multicycle_path because is has multiple through point and Synplify Pro doesnt support multi-through on false_path\n",line) if $VERBOSE
        
      when "Through1Through2Through3", "Through1Through2Through3Setup" then
        data.ConvertFlag = true
        through1_mod = data.Through1_mod.split
        through2_mod = data.Through2_mod.split
        through3_mod = data.Through3_mod.split
        sdc = "define_false_path "
        sdc = sdc + "-through { "
        through1_mod.each{|through1|
          sdc = sdc + pat.hier_net(through1) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through2_mod.each{|through2|
          sdc = sdc + pat.hier_net(through2) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through3_mod.each{|through3|
          sdc = sdc + pat.hier_net(through3) + " "
        }
        sdc = sdc + "}"       
=begin
        through1_mod.each{|through1|
          through2_mod.each{|through2|
            through3_mod.each{|through3|
              sdc << "define_multicycle_path"\
              + " -through { " + pat.hier_net(through1) \
              + " } -through { " + pat.hier_net(through2) \
              + " } -through { " + pat.hier_net(through3) \
              + " } { 3 }"
            }
          }
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_multicycle_path"
        $NOTE_CNT += 1
        printf("@N:\"%s\" line convert define_multicycle_path because is has multiple through point and Synplify Pro doesnt support multi-through on false_path\n",line) if $VERBOSE
        
      when "Through1Through2Through3" then
        data.ConvertFlag = true
        through1_mod = data.Through1_mod.split
        through2_mod = data.Through2_mod.split
        through3_mod = data.Through3_mod.split
        sdc = "define_false_path "
        sdc = sdc + "-through { "
        through1_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through2_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through3_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "}"       
=begin
        through1_mod.each{|through1|
          through2_mod.each{|through2|
            through3_mod.each{|through3|
              sdc << "define_multicycle_path -through {" + pat.hier_net(through1) + "} -through {" + pat.hier_net(through2) + "} -through {" + pat.hier_net(through3) + "} { 3 }"
            }
          }
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_multicycle_path"
        $NOTE_CNT += 1
        printf("@N:\"%s\" line convert define_multicycle_path because is has multiple through point and Synplify Pro doesnt support multi-through on false_path\n",line) if $VERBOSE
      when "Through1Through2To" then
        data.ConvertFlag = true
        through1_mod = data.Through1_mod.split
        through2_mod = data.Through2_mod.split
        to_mod = data.To_mod.split
        sdc = "define_false_path "
        sdc = sdc + "-through { "
        through1_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through2_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-to { "
        to_mod.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "}"       
=begin
        through1_mod.each{|through1|
          through2_mod.each{|through2|
            to_mod.each{|to|
              sdc << "define_multicycle_path -through { " + pat.hier_net(through1) + " } -through { " + pat.hier_net(through2) + " } -to { " + pat.hier_cell(to) + " } { 3 }"
            }
          }
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_multicycle_path"
        $NOTE_CNT += 1
        printf("@N:\"%s\" line convert define_multicycle_path because is has multiple through point and Synplify Pro doesnt support multi-through on false_path\n",line) if $VERBOSE
      when "Through1Through2Through3To" then
        data.ConvertFlag = true
        through1_mod = data.Through1_mod.split
        through2_mod = data.Through2_mod.split
        through3_mod = data.Through3_mod.split
        to_mod = data.To_mod.split
        sdc = "define_false_path "
        sdc = sdc + "-through { "
        through1_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through2_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through3_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-to { "
        to_mod.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "}"       
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_multicycle_path"
        $NOTE_CNT += 1
        printf("@N:\"%s\" line convert define_multicycle_path because is has multiple through point and Synplify Pro doesnt support multi-through on false_path\n",line) if $VERBOSE
      when "Through1Through2", "Through1Through2Setup" then
        data.ConvertFlag = true
        through1_mod = data.Through1_mod.split
        through2_mod = data.Through2_mod.split
        sdc = "define_false_path "
        sdc = sdc + "-through { "
        through1_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through2_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "}"       
=begin
        through1_mod.each{|through1|
          through2_mod.each{|through2|
            sdc << "define_multicycle_path -through { " + pat.hier_net(through1) + " } -through { " + pat.hier_net(through2) + " } { 3 }"
          }
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_multicycle_path"
        $NOTE_CNT += 1
        printf("@N:\"%s\" line convert define_multicycle_path because is has multiple through point and Synplify Pro doesnt support multi-through on false_path\n",line) if $VERBOSE
      when "FromThrough1To" then
        data.ConvertFlag = true
        from_mod       = data.From_mod.split
        through1_mod = data.Through1_mod.split
        to_mod = data.To_mod.split
        sdc = sdc_attribute
        sdc = sdc + " -from { "
        from_mod.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through1_mod.each{|through1|
          sdc = sdc + pat.hier_net(through1) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-to { "
        to_mod.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "}"       
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_false_path"        
      when "FromThrough1"  then
        data.ConvertFlag = true
        from_mod = data.From_mod.split
        through1_mod = data.Through1_mod.split
        sdc = sdc_attribute
        sdc = sdc + " -from { "
        from_mod.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through1_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "}"       
=begin
        from_tmp.each{|from|
          through1_tmp.each{|through|
            sdc << sdc_attribute + " -from { " + pat.hier_cell(from) + " } -through { " + pat.hier_net(through) + " }"
          }
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_false_path"
      when "FromThrough1Through2Through3", "FromThrough1Through2Through3Setup" then
        data.ConvertFlag = true
        from_mod = data.From_mod.split
        through1_mod = data.Through1_mod.split
        through2_mod = data.Through2_mod.split
        through3_mod = data.Through3_mod.split
        sdc = sdc_attribute
        sdc = sdc + " -from { "
        from_mod.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through1_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "       
        sdc = sdc + "-through { "
        through2_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "       
        sdc = sdc + "-through { "
        through3_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "}"       
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_false_path"
      when "FromThrough1Through2To", "FromThrough1Through2ToSetup" then
        data.ConvertFlag = true
        from_mod = data.From_mod.split
        through1_mod = data.Through1_mod.split
        through2_mod = data.Through2_mod.split
        to_mod = data.To_mod.split
        sdc = sdc_attribute
        sdc = sdc + " -from { "
        from_mod.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through1_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "       
        sdc = sdc + "-through { "
        through2_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "       
        sdc = sdc + "-to { "
        to_mod.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "}"       
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_false_path"
      when "FromThrough1Through2","FromThrough1Through2Setup"  then
        data.ConvertFlag = true
        from_mod = data.From_mod.split
        through1_mod = data.Through1_mod.split
        through2_mod = data.Through2_mod.split
        sdc = sdc_attribute
        sdc = sdc + " -from { "
        from_mod.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through1_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "       
        sdc = sdc + "-through { "
        through2_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "}"       
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_false_path"
      when "FromTo"  then
        data.ConvertFlag = true
        from_tmp = data.From_mod.split
        to_tmp = data.To_mod.split
        sdc = sdc_attribute
        sdc = sdc + " -from { "
        from_tmp.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "} "
        sdc = sdc + "-to { "
        to_tmp.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "}"       
=begin
        from_tmp.each{|from|
          to_tmp.each{|to|
            sdc << sdc_attribute + " -from { " + pat.hier_cell(from) + " } -to { " + pat.hier_cell(to) + " }"
          }
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_false_path"
      when "Through1To"  then
        data.ConvertFlag = true
        through_tmp = data.Through1_mod.split
        to_tmp = data.To_mod.split
        sdc = sdc_attribute
        sdc = sdc + " -through { "
        through_tmp.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-to { "
        to_tmp.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "}"       
=begin
        through_tmp.each{|through|
          to_tmp.each{|to|
            sdc << sdc_attribute + " -through { " + pat.hier_net(through) + " } -to { " + pat.hier_cell(to) + " }"
          }
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_false_path"
      when "From", "FromSetup" then
        data.ConvertFlag = true
        from_tmp = data.From_mod.split
        sdc = sdc_attribute
        sdc = sdc + " -from { "
        from_tmp.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "}"       
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_false_path"
      when "To","ToSetup" then
        data.ConvertFlag = true
        to_tmp = data.To_mod.split
        sdc = sdc_attribute
        sdc = sdc + " -to { "
        to_tmp.each{|node|
          if $CLOCK_INF["#{node}"] == nil
            sdc = sdc + pat.hier_cell(node) + " "
          else
            sdc = sdc + pat.hier_clock(node) + " "
          end
        }
        sdc = sdc + "}"       
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_false_path"
      when "Through1", "Through1Setup" then
        data.ConvertFlag = true
        through1_mod = data.Through1_mod.split
        sdc = sdc_attribute
        sdc = sdc + " -through { "
        through1_mod.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "}"       
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_false_path"
      when "FallThrough1Through2Through3Setup", 
        "RiseThrough1Through2Through3Setup",
        "RiseFromThrough1Through2Setup",
        "FallFromThrough1Through2",
        "RiseThrough1To",
        "FromRiseThrough1Through2",
        "RiseThrough1Through2",
        "FallThrough1To"
        @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
        data.LimitFlag = true
      else
        next if data.ModLine == nil
        @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
#        p data
        p data.Type
        p line
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit
        data.ConvertFlag = false
      end
#    end

      # Removed for "SCANCLK"
      if /SCANCLK/ =~ data.To_mod ||
          /SCANCLK/ =~ data.From_mod ||
          /SCANCLK/ =~ data.Through1_mod ||
          /SCANCLK/ =~ data.Through2_mod ||
          /SCANCLK/ =~ data.Through3_mod 
        data.RemoveFlag = true
      end
    }
  end
end

#############################################################
# set_max_delay
#############################################################
class SetMaxDelay
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*set_max_delay"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
#      line = line.gsub("\*","asterisk")
      data.Attribute = "set_max_delay"
      if( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.Type = "FromThroughTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.Type = "FromThroughTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.Type = "FromThroughTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.Type = "ThroughTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.Type = "ThroughTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::FROM_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.Through1 = $2.strip
        data.From = $3.strip
        data.Type = "ThroughFrom"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::TO_LIST}#{ConstCtrl::FROM_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.From = $4.strip
        data.Type = "FromThroughTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::FROM_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.Through1 = $2.strip
        data.From = $3.strip
        data.Type = "ThroughFrom"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.Type = "ThroughTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::FROM_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.Through1 = $2.strip
        data.From = $3.strip
        data.Type = "ThroughFrom"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.Type = "ThroughTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Type = "FromThrough"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Type = "FromThrough"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.To = $2.strip
        data.Type = "To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.Type = "From"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.To = $2.strip
        data.Type = "To"
      else
        p line
        $INTERNAL_ERROR_CNT += 1
        printf("@Internal error. (file:%s,line:%s)",__FILE__,__LINE__)
        Common.print_summary
        exit 1
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end

      pat.modify_signal(data,line)
    }

  end

  def convert(sdc_attribute)
    pat = ConstCtrl.new
    @DeviceConst.each{|line,data|
      sdc = Array.new
      line = data.ModLine.strip
      case data.Type
      when "FromTo" then
        data.ConvertFlag = true
        from_tmp = data.From_mod.split
        to_tmp = data.To_mod.split
        sdc = "define_max_delay"
        sdc = sdc + " -from { "
        from_tmp.each{|node|
          sdc = sdc + pat.hier_cell(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-to { "
        to_tmp.each{|node|
          sdc = sdc + pat.hier_cell(node) + " "
        }
        sdc = sdc + "} { " + data.Period.to_s + " }" 
=begin
        from_tmp.each{|from|
          to_tmp.each{|to|
            sdc <<  "define_max_delay -from { " + pat.hier_cell(from) +" } -to { " + pat.hier_cell(to) + " } { " + data.Period.to_s + " }" 
          }
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_path_delay"
      when "ThroughTo" then
        data.ConvertFlag = true
        through1_tmp = data.Through1_mod.split
        to_tmp = data.To_mod.split
        sdc = "define_max_delay"
        sdc = sdc + " -through { "
        through1_tmp.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-to { "
        to_tmp.each{|node|
          sdc = sdc + pat.hier_cell(node) + " "
        }
        sdc = sdc + "} { " + data.Period.to_s + " }"        
=begin
        through1_tmp.each{|through|
          to_tmp.each{|to|
            sdc <<  "define_max_delay -through { " + pat.hier_net(through) +" } -to { " + pat.hier_cell(to) + " } { " + data.Period.to_s + " }"
          }
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_path_delay"
      when "ThroughFrom" then
        data.ConvertFlag = true
        through1_tmp = data.Through1_mod.split
        from_tmp = data.From_mod.split
        sdc = "define_max_delay"
        sdc = sdc + " -through { "
        through1_tmp.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-from { "
        from_tmp.each{|node|
          sdc = sdc + pat.hier_cell(node) + " "
        }
        sdc = sdc + "} { " + data.Period.to_s + " }"        
=begin
        through1_tmp.each{|through|
          from_tmp.each{|from|
            sdc <<  "define_max_delay -through { " + pat.hier_net(through) +" } -from { " + pat.hier_cell(from) + " } { " + data.Period.to_s + " }"
          }
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_path_delay"
      when "To" then
        data.ConvertFlag = true
        to_tmp = data.To_mod.split
        sdc = "define_max_delay"
        sdc = sdc + " -to { "
        to_tmp.each{|node|
          sdc = sdc + pat.hier_cell(node) + " "
        }
        sdc = sdc + "} { " + data.Period.to_s + " }"        
=begin
        to_tmp.each{|to|
          sdc <<  "define_max_delay -to { " + pat.hier_cell(to) + " } { " + data.Period.to_s + " }"
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_path_delay"
      when "FromThrough" then
        data.ConvertFlag = true
        from_tmp = data.From_mod.split
        through1_tmp = data.Through1_mod.split
        sdc = "define_max_delay"
        sdc = sdc + " -from { "
        from_tmp.each{|node|
          sdc = sdc + pat.hier_cell(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through1_tmp.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} { " + data.Period.to_s + " }"        
=begin
        from_tmp.each{|from|
          through1_tmp.each{|through1|
            sdc << "define_max_delay -from { " + pat.hier_cell(from) +" } -through { " + pat.hier_net(through1) + " } { " + data.Period.to_s + " }"
          }
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_path_delay"
      when "FromThroughTo" then
        data.ConvertFlag = true
        from_tmp = data.From_mod.split
        through1_tmp = data.Through1_mod.split
        to_tmp = data.To_mod.split
        sdc = "define_max_delay"
        sdc = sdc + " -from { "
        from_tmp.each{|node|
          sdc = sdc + pat.hier_cell(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-through { "
        through1_tmp.each{|node|
          sdc = sdc + pat.hier_net(node) + " "
        }
        sdc = sdc + "} "
        sdc = sdc + "-to { "
        to_tmp.each{|node|
          sdc = sdc + pat.hier_cell(node) + " "
        }
        sdc = sdc + "} { " + data.Period.to_s + " }"        
=begin
        from_tmp.each{|from|
          through1_tmp.each{|through1|
            to_tmp.each{|to|
              sdc << "define_max_delay -from { " + pat.hier_cell(from) +" } -through { " + pat.hier_net(through1) + " } -to { " + pat.hier_cell(to) + " } { " + data.Period.to_s + " }"
            }
          }
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_path_delay"
      when "From" then
        data.ConvertFlag = true
        from_tmp = data.From_mod.split
        sdc = "define_max_delay"
        sdc = sdc + " -from { "
        from_tmp.each{|node|
          sdc = sdc + pat.hier_cell(node) + " "
        }
        sdc = sdc + "} { " + data.Period.to_s + " }"        
=begin
        from_tmp.each{|from|
          sdc << "define_max_delay -from { " + pat.hier_cell(from) + " } { " + data.Period.to_s + " }"
        }
=end
#        data.SDC = sdc.to_a
        data.SDC = Array(sdc)
        data.SDCAttribute = "define_path_delay"
      else
        p line
        p data.Type
        $INTERNAL_ERROR_CNT += 1
        printf("@Internal error. (file:%s,line:%s)",__FILE__,__LINE__)
        Common.print_summary
        exit 1
        next if data.ModLine == nil
        @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
        data.ConvertFlag = false
      end

    }
  end
end

#############################################################
# set_min_delay
#############################################################
class SetMinDelay
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*set_min_delay"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      data.Attribute = "set_min_delay"
      if( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.Type = "ThroughTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.To = $2.strip
        data.Type = "To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period= $1.strip
        data.From = $2.strip
        data.Type = "From"
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end

      pat.modify_signal(data,line)

    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    @DeviceConst.each{|line,data|
      data.ConvertFlag = false
      @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
    }
  end

end


#############################################################
# set_dont_touch
#############################################################
class SetDontTouch
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(const)
    # from GenSDC
    @DeviceConst = const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*set_dont_touch"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      line_org = line
      line = line.sub("-hierarchical","")
      data.Attribute = "set_dont_touch"
      if( ( /^#{attribute}#{ConstCtrl::LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      elsif( ( /^#{attribute}#{ConstCtrl::GETCELL}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      elsif( ( /^#{attribute}#{ConstCtrl::GETNET}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      elsif( ( /^#{attribute}#{ConstCtrl::SIGNAL}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      elsif( ( /^#{attribute}#{ConstCtrl::SIGNAL_C}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      elsif( ( /^#{attribute}#{ConstCtrl::LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      elsif( ( /^#{attribute}#{ConstCtrl::SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      else
        @UnAnalizedAttributeList << [line_org,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)

    }
  end

  # 
  # convert
  #
  def convert(sdc_attribute)
    ctl = ConstCtrl.new
    @DeviceConst.each{|line,data|
      sdc = Array.new
      tmp = data.Signal_mod.split # corresponding mult signal
      tmp.each{|sig|
        sig = ctl.hier_cell(sig) + ".*"  if sig != "all_clocks" && sig != "all_inputs" && sig != "all_outputs" && sig != "all_registers"
        sdc << "define_attribute { " + sig + " } " + sdc_attribute + " { 1 }"
        if /all_connected/ =~ sig
          data.LimitFlag = true
        end
#        sig = ctl.hier_view(sig)  if sig != "all_clocks" && sig != "all_inputs" && sig != "all_outputs" && sig != "all_registers"
#        sdc << "define_attribute {" + sig + "} syn_hier {hard}"
      }

      if sdc != nil
        data.ConvertFlag = true 
        data.SDC = sdc
        data.SDCAttribute = "syn_keep"
      else
        data.ConvertFlag = false
        @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
      end
    }
  end

end


#############################################################
# set_disable_timing
#############################################################
class SetDisableTiming
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*set_disable_timing"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      data.Attribute = "set_disable_timing"
      if( ( /^#{attribute}#{ConstCtrl::GETPIN_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Pin = $1.strip
      elsif( ( /^#{attribute}#{ConstCtrl::GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Pin = $1.strip
      elsif( ( /^#{attribute}#{ConstCtrl::LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Pin = $1.strip
      elsif( ( /^#{attribute}#{ConstCtrl::SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end

      pat.modify_signal(data,line)
    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    ctl = ConstCtrl.new
    @DeviceConst.each{|line,data|
      sdc = Array.new
      tmp = data.Signal_mod.split if data.Signal_mod != nil # corresponding mult signal
      tmp.each{|sig|
        #        sig = hier_cell(sig) + ".*"
        #        sdc << "define_attribute {" + sig + "} {" + sdc_attribute + "} {1}"
        sig = ctl.hier_net(sig) if sig != "all_clocks" && sig != "all_inputs" && sig != "all_outputs" && sig != "all_registers"
        sdc << "define_false_path -through { " + sig + " }"
      } if tmp != nil
      # for SRR & SDC Compare
      data.Through1_mod = data.Signal_mod
      data.Signal_mod = nil

      tmp = Array.new
      tmp = data.Pin_mod.split if data.Pin_mod != nil # corresponding mult signal
      tmp.each{|sig|
        sig = ctl.hier_pin(sig) if sig != "all_clocks" && sig != "all_inputs" && sig != "all_outputs" && sig != "all_registers"
        sdc << "define_false_path -through { " + sig + " }"
        #        sig = ctl.hier_view(sig)  if sig != "all_clocks" && sig != "all_inputs" && sig != "all_outputs" && sig != "all_registers"
        #        sdc << "define_attribute {" + sig + "} syn_hier {hard}"
      } if tmp != nil
      # for SRR & SDC Compare
      data.Through1_mod = data.Pin_mod
      data.Pin_mod = nil
      
      if sdc != nil
        data.ConvertFlag = true 
        data.SDC = sdc
        data.SDCAttribute = "define_false_path"
      else
        data.ConvertFlag = false
        @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
      end
    }
  end
end


#############################################################
# set_case_analysis
#############################################################
class SetCaseAnalysis
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*set_case_analysis"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      data.Attribute = "set_case_analysis"
      if( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip.to_i
        data.Pin = $2.strip
      else
        printf("@E:%s\n", line)
        exit
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)
    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    pat = ConstCtrl.new
    @DeviceConst.each{|line,data|
      sdc = Array.new
#      sig = "p:#{$HIER}" + data.Pin_mod.gsub("/",".")
      sig = pat.hier_pin(data.Pin_mod.gsub("/","."))
      if data.Period == 1
        data.ConvertFlag = true
        sdc << "define_attribute { " + sig + " } " + sdc_attribute.split(",")[1] + " { 1 }"
        data.SDC = sdc
        data.SDCAttribute = "xc_pullup"
      elsif data.Period == 0
        data.ConvertFlag = true
        sdc << "define_attribute { " + sig + " } " + sdc_attribute.split(",")[0] + " { 1 }"
        data.SDC = sdc
        data.SDCAttribute = "xc_pulldown"
      else
        $ERROR_CNT += 1
        printf("@Internal error. (file:%s,line:%s)",__FILE__,__LINE__)
        Common.print_summary
        exit 1
      end
      if data.SDC == nil
        @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
      end
    }
  end

end


#############################################################
# remove_attribute
#############################################################
class RemoveAttribute
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*remove_attribute"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      data.Attribute = "remove_attribute"
      if( ( /^#{attribute}#{ConstCtrl::SIGNAL_D}#{ConstCtrl::DONT_USE}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
        data.NoUseFlag = true
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)
    }
  end

  #
  # convert( not support on ver 0.3.xx )
  #
  def convert(sdc_attribute)
    @DeviceConst.each{|line,data|
      data.ConvertFlag = false
      @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
    }
  end

end


#############################################################
# create_clock
#############################################################
class CreateClock
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
 end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*create_clock"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      data.Attribute = "create_clock"
      if( ( /^#{attribute}\s+-name#{ConstCtrl::SIGNAL_D}#{ConstCtrl::GETPIN}\s+-period#{ConstCtrl::PERIOD}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.ClockName = $1.strip
        data.Signal = $2.strip
        data.Period = $3.strip
        clk = ClockInf.new
        clk.Period = data.Period
        $CLOCK_INF["#{data.ClockName}"] = clk
      elsif( ( /^#{attribute}\s+-name#{ConstCtrl::SIGNAL_D}#{ConstCtrl::GETPIN}\s+-period#{ConstCtrl::MACRO}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.ClockName = $1.strip
        data.Signal = $2.strip
        data.Period = $3.strip
        clk = ClockInf.new
        clk.Period = data.Period
        $CLOCK_INF["#{data.ClockName}"] = clk
      elsif( ( /^#{attribute}\s+-name#{ConstCtrl::SIGNAL_D}\s+-period#{ConstCtrl::PERIOD}#{ConstCtrl::GETPIN}/ =~line ) != nil )
#      elsif( ( /^#{attribute}\s+-name#{ConstCtrl::SIGNAL_D}\s+-period#{ConstCtrl::PERIOD}\s+#{ConstCtrl::GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.ClockName = $1.strip
        data.Period = $2.strip
        data.Signal = $3.strip
        clk = ClockInf.new 
        clk.Period = data.Period
        $CLOCK_INF["#{data.ClockName}"] = clk
      elsif( ( /^#{attribute}#{ConstCtrl::GETPIN}\s+-name#{ConstCtrl::SIGNAL_D}\s+-period#{ConstCtrl::PERIOD}\s+-waveform/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
        data.ClockName = $2.strip
        data.Period = $3.strip
        clk = ClockInf.new
        clk.Period = data.Period
        $CLOCK_INF["#{data.ClockName}"] = clk
      else
        p line
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end

      pat.modify_signal(data,line)
    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    pat = ConstCtrl.new
    @DeviceConst.each{|line,data|
      sdc = Array.new
      tmp = data.Signal_mod.split # corresponding mult signal
      i = 0
      tmp.each{|sig|
        sig = sig.gsub("socket/","") if $TARGET == "socket"
        if /h_rosc/ =~ sig || /l_rosc/ =~ sig || /regm/ =~ sig || /oscmain/ =~ sig || /oscsub/ =~ sig || /resetb/ =~ sig     
          sig = "n:chiptop." + sig.gsub("/",".").gsub("\*","") 
        else
          sig = "n:#{$HIER}" + sig.gsub("/",".").gsub("\*","")
        end
        # Force Change for BBFCLKDS
        if data.ClockName == "BBFCLKDS"
          sdc << sdc_attribute + " { " + sig + " } -name { " + data.ClockName + " } -period " + data.Period.to_s + " -clockgroup FCLK -route 0.000"
        else
          sdc << sdc_attribute + " { " + sig + " } -name { " + data.ClockName + " } -period " + data.Period.to_s + " -clockgroup " + data.ClockName + " -route 0.000"
        end
        i += 1
        # Limited about "Delete Clock"
        if pat.UnConvertClock.index("#{data.ClockName}")
          data.RemoveFlag = true
        end
      }
      if sdc != nil
        data.ConvertFlag = true 
        data.SDC = sdc
        data.SDCAttribute = "define_clock"
      else
        data.ConvertFlag = false
        @UnConvertedAttributeList << [line,data] if !data.RemoveFlag
      end
    }
  end

end


#############################################################
# ResetPath
#############################################################
class ResetPath
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute   = "\\s*reset_path"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
#        @UnAnalizedAttributeList << line
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip if data.ModLine.strip != "CLOCK"
      data.Attribute = "reset_path"
      if( ( /^#{attribute}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.SetupFlag = true
        data.Type = "Through1Through2Setup"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Through2 = $2.strip
        data.Type = "Through1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_LIST}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.Type = "FromToSetup"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_MACRO}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "FromToSetup"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_MACRO}#{ConstCtrl::TO_MACRO}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.To = $1.strip
        data.Type = "To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.SetupFlag = true
        data.Type = "FromSetup"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Through1 = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "Through1ToSetup"
      elsif( ( /^#{attribute}#{ConstCtrl::FALL_THROUGH_LIST}#{ConstCtrl::FALL_TO_LIST}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.FallThrough1 = $1.strip
        data.FallTo = $2.strip
        data.SetupFlag = true
        data.Type = "FallThrough1FallToSetup"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_SIGNAL}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.Type = "From"
      elsif( ( /^#{attribute}#{ConstCtrl::FALL_THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.FallThrough1 = $1.strip
        data.To = $2.strip
        data.Type = "FallThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_MACRO}#{ConstCtrl::TO_LIST}#{ConstCtrl::SETUP}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "FromToSetup"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_MACRO}#{ConstCtrl::TO_MACRO}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.From = $1.strip
        data.To = $2.strip
        data.Type = "FromTo"
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)
    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    @DeviceConst.each{|line,data|
      sdc = Array.new
      data.ConvertFlag = false
      if data.RemoveFlag
        sdc << line
        data.SDC = sdc
      else
        data.ConvertFlag = false
        sdc << line
        data.SDC = sdc
#        @UnConvertedAttributeList << [line,data] 
      end
    }
  end

end


#############################################################
# set_annotated_delay
#############################################################
class SetAnnotatedDelay
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*set_annotated_delay"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip 
      data.Attribute = "set_annotated_delay"
      if( ( /^#{attribute}\s+-net\s+-rise#{ConstCtrl::MACRO}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.To = $2.strip
      elsif( ( /^#{attribute}\s+-net\s+-fall#{ConstCtrl::MACRO}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.To = $2.strip
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)
    }
  end

  #
  # convert( not support because not support analizing)
  #
  def convert(sdc_attribute)
    @DeviceConst.each{|line,data|
      data.ConvertFlag = false
      @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
    }
  end

end

#############################################################
# set_max_time_borrow
#############################################################
class SetMaxTimeBorrow
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*set_max_time_borrow"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip 
      data.Attribute = "set_max_time_borrow"
      if( ( /^#{attribute}\s+-net\s+-rise#{ConstCtrl::MACRO}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.To = $2.strip
      elsif( ( /^#{attribute}\s+-net\s+-fall#{ConstCtrl::MACRO}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.To = $2.strip
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)
    }
  end

  #
  # convert( not support because not support analizing)
  #
  def convert(sdc_attribute)
    @DeviceConst.each{|line,data|
      data.ConvertFlag = false
      @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
    }
  end

end



#############################################################
# set_multicycle_path
#############################################################
class SetMulticyclePath
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*set_multicycle_path"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      data.Attribute = "set_multicycle_path"
      if( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.Through3 = $4.strip
        data.SetupFlag = true
        data.Type = "Through1Through2Through3"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil && data.Through3 == nil 
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.To = $4.strip
        data.SetupFlag = true
        data.Type = "Through1Through2To"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil && data.Through3 == nil 
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.SetupFlag = true
        data.Type = "Through1Through2"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil && data.Through3 == nil 
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "Through1To"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil && data.Through3 == nil 
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.To = $5.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "Through1To"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil && data.Through3 == nil 
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.To = $5.strip
        data.HoldFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.To = $5.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.To = $5.strip
        data.HoldFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.Through3 = $5.strip
        data.HoldFlag = true
        data.Type = "FromThrough1Through2Through3"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil && data.Through3 == nil 
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.Through3 = $4.strip
        data.HoldFlag = true
        data.Type = "Through1Through2Through3"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil && data.Through3 == nil 
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1To"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil && data.Through3 == nil 
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.Through3 = $4.strip
        data.HoldFlag = true
        data.Type = "Through1Through2Through3"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil && data.Through3 == nil 
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.Through3 = $4.strip
        data.SetupFlag = true
        data.Type = "Through1Through2Through3"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil && data.Through3 == nil 
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::THROUGH_GETPIN}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.Through3 = $4.strip
        data.SetupFlag = true
        data.Type = "Through1Through2Through3"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil && data.Through3 == nil 
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.Through3 = $5.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2Through3"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil  && data.Through3 == nil
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.HoldFlag = true
        data.Type = "FromThrough1Through2"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.Type = "FromThrough1Through2"
        pattern_error(__LINE__) if data.Period == nil && data.From == nil && data.Through1 == nil && data.Through2 == nil
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.HoldFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.HoldFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::EEND}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.HoldFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::START}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.Through3 = $5.strip
        data.To = $6.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2Through3To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::EEND}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.To = $5.strip
        data.HoldFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.To = $4.strip
        data.SetupFlag = true
        data.Type = "Through1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.To = $4.strip
        data.HoldFlag = true
        data.Type = "Through1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::EEND}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.To = $4.strip
        data.HoldFlag = true
        data.Type = "Through1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::EEND}#{ConstCtrl::FROM_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.EndFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::EEND}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.HoldFlag = true
        data.EndFlag = true
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::EEND}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.EndFlag = true
        data.Type = "Throug1To"
      elsif( ( /^#{attribute}#{ConstCtrl::HOLD}#{ConstCtrl::PERIOD}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::EEND}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.HoldFlag = true
        data.EndFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.HoldFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::HOLD}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_GETPIN}#{ConstCtrl::THROUGH_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.HoldFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.SetupFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::HOLD}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.HoldFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.To = $4.strip
        data.HoldFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.SetupFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.HoldFlag = true
        data.Type = "FromThrough1"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::FROM_MACRO}#{ConstCtrl::TO_MACRO}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.To = $3.strip
        data.Type = "FromTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FALL_FROM_SIGNAL_D}#{ConstCtrl::FALL_TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.FallFrom = $2.strip
        data.FallTo = $3.strip
        data.SetupFlag = true
        data.Type = "FallFromFallTo"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.To = $2.strip
        data.HoldFlag = true
        data.Type = "To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.HoldFlag = true
        data.Type = "From"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.SetupFlag = true
        data.Type = "From"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.HoldFlag = true
        data.Type = "From"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::EEND}#{ConstCtrl::THROUGH_PINLIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.EndFlag = true
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::EEND}#{ConstCtrl::THROUGH_PINLIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.HoldFlag = true
        data.EndFlag = true
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.HoldFlag = true
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::SETUP}#{ConstCtrl::TO_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.To = $2.strip
        data.SetupFlag = true
        data.Type = "To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.To = $5.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.To = $5.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.To = $5.strip
        data.HoldFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.To = $5.strip
        data.HoldFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::START}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.To = $5.strip
        data.SetupFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_SIGNAL_D}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.Through3 = $5.strip
        data.To = $6.strip
        data.HoldFlag = true
        data.Type = "FromThrough1Through2Through3To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.SetupFlag = true
        data.Type = "Through1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_LIST}#{ConstCtrl::THROUGH_LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.HoldFlag = true
        data.Type = "Through1Through2"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_LIST_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_LIST_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.To = $4.strip
        data.SetupFlag = true
        data.Type = "Through1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_LIST_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.Through2 = $3.strip
        data.To = $4.strip
        data.HoldFlag = true
        data.Type = "Through1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_LIST_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.Type = "Through1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::RISE_THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.SetupFlag = true
        data.Type = "RiseThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::RISE_THROUGH_SIGNAL_D}#{ConstCtrl::TO_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.To = $3.strip
        data.HoldFlag = true
        data.Type = "RiseThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1   = $3.strip 
        data.Through2   = $4.strip 
        data.To   = $5.strip 
        data.HoldFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1   = $3.strip 
        data.Through2   = $4.strip 
        data.To   = $5.strip 
        data.SetupFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1   = $3.strip 
        data.To   = $4.strip 
        data.HoldFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1   = $3.strip 
        data.To   = $4.strip 
        data.SetupFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_LIST_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1   = $3.strip 
        data.To   = $4.strip 
        data.HoldFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_LIST_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1   = $3.strip 
        data.To   = $4.strip 
        data.SetupFlag = true
        data.Type = "FromThrough1To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_LIST_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1 = $3.strip
        data.Through2 = $4.strip
        data.To   = $5.strip 
        data.HoldFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::FROM_GET_CLOCKS}#{ConstCtrl::THROUGH_SIGNAL_D}#{ConstCtrl::THROUGH_LIST_SIGNAL_D}#{ConstCtrl::TO_GET_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.From = $2.strip
        data.Through1   = $3.strip 
        data.Through2   = $4.strip 
        data.To   = $5.strip 
        data.SetupFlag = true
        data.Type = "FromThrough1Through2To"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SETUP}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.SetupFlag = true
        data.Type = "Through1"
      elsif( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::HOLD}#{ConstCtrl::THROUGH_SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Through1 = $2.strip
        data.HoldFlag = true
        data.Type = "Through1"
      else
        p data.ModLine
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        exit
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end 
      pat.modify_signal(data,line)
    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    pat = ConstCtrl.new
    @DeviceConst.each{|line,data|
      sdc = Array.new
      if data.HoldFlag == true
        data.ConvertFlag = false
        data.LimitFlag = true
        sdc << line
        data.SDC = sdc
        $NOTE_CNT += 1
        printf("@N:\"%s\" line cannnot convert because is has setup/hold attribute.\n",line) if $VERBOSE
        @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
      else
        case data.Type
        when "RiseThrough1To", "RiseThrough1Through2Setup" then
          data.ConvertFlag = false
          data.LimitFlag = true
          sdc << line
          data.SDC = sdc
          $NOTE_CNT += 1
          printf("@N:\"%s\" line cannnot convert because is has rise_through attribute.\n",line) if $VERBOSE
          @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
        when "Through1Through2Through3" then
          data.ConvertFlag = true
          through1_tmp = data.Through1_mod.split
          through2_tmp = data.Through2_mod.split
          through3_tmp = data.Through3_mod.split
          sdc = sdc_attribute + " "
          sdc = sdc + "-through { "
          through1_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through2_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through3_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} { " + data.Period.to_s + " }"
#          data.SDC = sdc.to_a
        data.SDC = Array(sdc)
          data.SDCAttribute = "define_multicycle_path" 
        when "FromThrough1Through2To" then
          data.ConvertFlag = true
          from_tmp     = data.From_mod.split
          through1_tmp = data.Through1_mod.split
          through2_tmp = data.Through2_mod.split
          to_tmp       = data.To_mod.split
          sdc = sdc_attribute + " "
          sdc = sdc + "-from { "
          from_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through1_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through2_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-to { "
          to_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} { " + data.Period.to_s + " }"
#          data.SDC = sdc.to_a
          data.SDC = Array(sdc)
          data.SDCAttribute = "define_multicycle_path"
       when "FromThrough1Through2" then
          data.ConvertFlag = true
          from_tmp = data.From_mod.split
          through1_tmp = data.Through1_mod.split
          through2_tmp = data.Through2_mod.split
          sdc = sdc_attribute + " "
          sdc = sdc + "-from { "
          from_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through1_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through2_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} { " + data.Period.to_s + " }"
#          data.SDC = sdc.to_a
          data.SDC = Array(sdc)
          data.SDCAttribute = "define_multicycle_path"
       when "Through1Through2" then
          data.ConvertFlag = true
          through1_tmp = data.Through1_mod.split
          through2_tmp = data.Through2_mod.split
          sdc = sdc_attribute + " "
          sdc = sdc + "-through { "
          through1_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through2_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} { " + data.Period.to_s + " }"
#          data.SDC = sdc.to_a
          data.SDC = Array(sdc)
          data.SDCAttribute = "define_multicycle_path"
       when "Through1Through2To" then
          data.ConvertFlag = true
          through1_tmp = data.Through1_mod.split
          through2_tmp = data.Through2_mod.split
          to_tmp = data.To_mod.split
          sdc = sdc_attribute + " "
          sdc = sdc + "-through { "
          through1_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through2_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-to { "
          to_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} { " + data.Period.to_s + " }"
#          data.SDC = sdc.to_a
          data.SDC = Array(sdc)
          data.SDCAttribute = "define_multicycle_path"
        when "FromThrough1To" then
          data.ConvertFlag = true
          from_tmp = data.From_mod.split
          through1_tmp = data.Through1_mod.split
          to_tmp = data.To_mod.split
          sdc = sdc_attribute + " "
          sdc = sdc + "-from { "
          from_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through1_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-to { "
          to_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} { " + data.Period.to_s + " }"
#          data.SDC = sdc.to_a
          data.SDC = Array(sdc)
          data.SDCAttribute = "define_multicycle_path"
        when "FromThrough1Through2Through3To" then
          data.ConvertFlag = true
          from_tmp = data.From_mod.split
          through1_tmp = data.Through1_mod.split
          through2_tmp = data.Through2_mod.split
          through3_tmp = data.Through3_mod.split
          to_tmp = data.To_mod.split
          sdc = sdc_attribute + " "
          sdc = sdc + "-from { "
          from_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through1_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through2_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through3_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-to { "
          to_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} { " + data.Period.to_s + " }"
#          data.SDC = sdc.to_a
          data.SDC = Array(sdc)
          data.SDCAttribute = "define_multicycle_path"
        when "FromThrough1" then
          data.ConvertFlag = true
          from_tmp = data.From_mod.split
          through1_tmp = data.Through1_mod.split
          sdc = sdc_attribute + " "
          sdc = sdc + "-from { "
          from_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} "
          sdc = sdc + "-through { "
          through1_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} { " + data.Period.to_s + " }"
#          data.SDC = sdc.to_a
          data.SDC = Array(sdc)
          data.SDCAttribute = "define_multicycle_path"
        when "Through1To" then
          data.ConvertFlag = true
          through1_tmp = data.Through1_mod.split
          to_tmp = data.To_mod.split
          sdc = sdc_attribute + " "
          sdc = sdc + "-through { "
          through1_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} "
          sdc = sdc + "-to { "
          to_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} { " + data.Period.to_s + " }"
          data.SDC = Array(sdc)
          data.SDCAttribute = "define_multicycle_path"
        when "FromTo" then
          data.ConvertFlag = true
          from_tmp = data.From_mod.split
          to_tmp = data.To_mod.split
          sdc = sdc_attribute + " "
          sdc = sdc + "-from { "
          from_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} "
          sdc = sdc + "-to { "
          to_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} { " + data.Period.to_s + " }"
=begin
          from_tmp.each{|from|
            to_tmp.each{|to|
              sdc << sdc_attribute + " -from { " + pat.hier_cell(from) + " } -to { " + pat.hier_cell(to) + " } { " + data.Period.to_s + " }"
            }
          }
=end
#          data.SDC = sdc.to_a
          data.SDC = Array(sdc)
          data.SDCAttribute = "define_multicycle_path"
        when "To" then
          data.ConvertFlag = true
          to_tmp = data.To_mod.split
          sdc = sdc_attribute + " "
          sdc = sdc + "-to { "
          to_tmp.each{|node|
            if $CLOCK_INF["#{node}"] == nil
              sdc = sdc + pat.hier_cell(node) + " "
            else
              sdc = sdc + pat.hier_clock(node) + " "
            end
          }
          sdc = sdc + "} { " + data.Period.to_s + " }"
=begin
          to_tmp.each{|to|
            sdc << sdc_attribute + " -to { " + pat.hier_cell(to) + " } { " + data.Period.to_s + " }"
          }
=end
#          data.SDC = sdc.to_a
          data.SDC = Array(sdc)
          data.SDCAttribute = "define_multicycle_path"
        when "Through1" then
          data.ConvertFlag = true
          through1_tmp = data.Through1_mod.split
          sdc = sdc_attribute + " "
          sdc = sdc + "-through { "
          through1_tmp.each{|node|
            sdc = sdc + pat.hier_net(node) + " "
          }
          sdc = sdc + "} { " + data.Period.to_s + " }"
=begin
          through1_tmp.each{|thr|
            sdc << sdc_attribute + " -through { " + pat.hier_net(thr) + " } { " + data.Period.to_s + " }"
          }
=end
#          data.SDC = sdc.to_a
          data.SDC = Array(sdc)
          data.SDCAttribute = "define_multicycle_path"
        when "FallFromFallTo" then
          data.ConvertFlag = true
          from_tmp = data.FallFrom_mod.split
          to_tmp = data.FallTo_mod.split
          sdc = "define_clock_delay" + " "
          sdc = sdc + "-fall { "
          period = 0
          from_tmp.each{|node|
            sdc = sdc + "c:" + node + " "
            if $CLOCK_INF["#{node}"] != nil
              period = $CLOCK_INF["#{node}"].Period
            else
              $ERROR_CNT += 1
              printf("@E:Not Found \"%s\" in all scr files.\n",node)
              Common.print_summary
              exit
            end
          }
          sdc = sdc + " } -fall { "
          to_tmp.each{|node|
            sdc = sdc + "c:" + node + " "
          }
          sdc = sdc + "} { " + period + " }"
=begin
          through1_tmp.each{|thr|
            sdc << sdc_attribute + " -through { " + pat.hier_net(thr) + " } { " + data.Period.to_s + " }"
          }
=end
#          data.SDC = sdc.to_a
          data.SDC = Array(sdc)
          data.SDCAttribute = "define_clock_delay"
        else
          next if data.ModLine == nil
          $ERROR_CNT += 1
          p data.ModLine
          p data
          p data.Type
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
          exit 
        end
      end
    }
  end

end


#############################################################
# create_generated_clock
#############################################################
class CreateGeneratedClock
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*create_generated_clock"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      data.Attribute = "create_generated_clock"
      if( ( /^#{attribute}\s+-name#{ConstCtrl::SIGNAL_D}\s+-source#{ConstCtrl::SIGNAL_D}\s+-divide_by#{ConstCtrl::PERIOD}#{ConstCtrl::SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.ClockName = $1.strip
        data.Source = $2.strip
        data.Period = $3.strip
        data.Signal = $4.strip
      elsif( ( /^#{attribute}\s+-name#{ConstCtrl::SIGNAL_D}\s+-source#{ConstCtrl::GETPIN}\s+-divide_by#{ConstCtrl::PERIOD}#{ConstCtrl::GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.ClockName = $1.strip
        data.Source = $2.strip
        data.Period = $3.strip
        data.Signal = $4.strip
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)
    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    @DeviceConst.each{|line,data|
      data.ConvertFlag = false
      @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
    }
  end

end

#############################################################
# set_input_delay
#############################################################
class SetInputDelay
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*set_input_delay"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip 
      data.Attribute = "set_input_delay"
      if( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SIGNAL_D}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Signal = $2.strip
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)
    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    @DeviceConst.each{|line,data|
      data.ConvertFlag = false
      @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
    }
  end

end


#############################################################
# remove_disable_timing
#############################################################
class RemoveDisableTiming
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*remove_disable_timing"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      data.Attribute = "remove_disable_timing"
      if( ( /^#{attribute}#{ConstCtrl::GETPIN}/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)
    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    @DeviceConst.each{|line,data|
      data.ConvertFlag = false
      @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
    }
  end

end


#############################################################
# set_dont_touch_network
#############################################################
class SetDontTouchNetwork
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*set_dont_touch_network"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip 
      data.Attribute = "set_dont_touch_network"
      if( ( /^#{attribute}#{ConstCtrl::GETPIN}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      elsif( ( /^#{attribute}#{ConstCtrl::ALL_CLOCKS}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = "all_clocks"
      elsif( ( /^#{attribute}#{ConstCtrl::SIGNAL}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)
    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    ctl = ConstCtrl.new
    @DeviceConst.each{|line,data|
      sdc = Array.new
      tmp = data.Signal_mod.split # corresponding mult signal
      tmp.each{|sig|
        sig = ctl.hier_cell(sig) + ".*"  if sig != "all_clocks" && sig != "all_inputs" && sig != "all_outputs" && sig != "all_registers"
        sdc << "define_attribute { " + sig + " } " + sdc_attribute + " { 1 }"
#        sig = ctl.hier_view(sig) if sig != "all_clocks" && sig != "all_inputs" && sig != "all_outputs" && sig != "all_registers"
#        sdc << "define_attribute {" + sig + "} syn_hier {hard}"
      }

      if sdc != nil
        data.ConvertFlag = true 
        data.SDC = sdc
        data.SDCAttribute = "syn_keep"
      else
        data.ConvertFlag = false
        @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
      end
    }
  end


end


#############################################################
# remove_annotated_delay
#############################################################
class RemoveAnnotatedDelay
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*remove_annotated_delay"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      data.Attribute = "remove_annotated_delay"
      if( ( /^#{attribute}#{ConstCtrl::LIST}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)
    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    @DeviceConst.each{|line,data|
      data.ConvertFlag = false
      @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
    }
  end

end


#############################################################
# set_propagated_clock
#############################################################
class SetPropagatedClock
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*set_propagated_clock"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      data.Attribute = "set_propagated_clock"
      if( ( /^#{attribute}#{ConstCtrl::SIGNAL}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Signal = $1.strip
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)
    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    @DeviceConst.each{|line,data|
      data.ConvertFlag = false
      @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
    }
  end

end


#############################################################
# set_clock_latency
#############################################################
class SetClockLatency
  attr_accessor :UnAnalizedAttributeList
  attr_accessor :UnConvertedAttributeList
  def initialize(device_const)
    # from GenSDC
    @DeviceConst = device_const
    # To GenSDC
    @UnAnalizedAttributeList = Array.new
    @UnConvertedAttributeList = Array.new
  end
  
  def analize
    pat = ConstCtrl.new
    attribute = "\\s*set_clock_latency"
    @DeviceConst.each{|line,data|
      if data.ModLine == nil
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
        next
      end
      line = data.ModLine.strip
      data.Attribute = "set_clock_latency"
      if( ( /^#{attribute}#{ConstCtrl::PERIOD}#{ConstCtrl::SIGNAL}$/ =~line ) != nil )
        data.AnalizeFlag = true
        data.Period = $1.strip
        data.Signal = $2.strip
      else
        @UnAnalizedAttributeList << [line,data]
        data.AnalizeFlag = false
      end
      pat.modify_signal(data,line)
      
    }
  end

  #
  # convert
  #
  def convert(sdc_attribute)
    @DeviceConst.each{|line,data|
      data.ConvertFlag = false
      @UnConvertedAttributeList << [line,data]  if !data.RemoveFlag
    }
  end

end


