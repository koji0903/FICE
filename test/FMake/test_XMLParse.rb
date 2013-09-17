#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
require 'test/unit'
$:.unshift(File.dirname(__FILE__) + "/../../bin")
$:.unshift(File.dirname(__FILE__) + "/../../lib")
$:.unshift(File.dirname(__FILE__) + "/../../conf")
require 'XMLParse'
require 'FICE_DB'

class Test_XMLParse < Test::Unit::TestCase
  
  def setup
    @root = XMLParse.read("./tp/test001.xml")
    @error = nil
  end

  #
  # Test for get_ModuleList function
  #
  def test_get_ModuleList
    printf "\n@T:#{__method__}\n"
    @root = XMLParse.read("./tp/test001.xml")
    golden = ["D78F1070_EVA",
              "QLK0RCPUEVA0V3",
              "QLK0RCPUEVA0V3_ADR",
              "QLK0RCPUEVA0V3_ALU",
              "QLK0RCPUEVA0V3_EXE",
              "QLK0RCPUEVA0V3_EXE2",
              "QLK0RCPUEVA0V3_CLK",
              "QLK0RCPUEVA0V3_DEC"]
    # Normalrror
    assert_equal(golden,XMLParse::get_ModuleList(@root))
  end

  #
  # Test for get_ModuleList function
  #
  def test_delete_Module
    printf "\n@T:#{__method__}\n"
    @root = XMLParse.read("./tp/test001.xml")
    golden = ["D78F1070_EVA",
              "QLK0RCPUEVA0V3",
              "QLK0RCPUEVA0V3_ADR",
              "QLK0RCPUEVA0V3_ALU",
              "QLK0RCPUEVA0V3_EXE2",
              "QLK0RCPUEVA0V3_CLK",
              "QLK0RCPUEVA0V3_DEC"]
    XMLParse::delete_Module(@root,"QLK0RCPUEVA0V3_EXE")
    assert_equal(golden,XMLParse::get_ModuleList(@root))

  end

  #
  def test_delete_HardMacro
    printf "\n@T:#{__method__}\n"
    #   @root = XMLParse.read("./tp/gate.xml")
    @root = XMLParse.read("./tp/l13.xml")
    golden1 = XMLParse::get_ModuleList(@root)
    XMLParse::delete_HardMacro(@root)
    revised1 = XMLParse::get_ModuleList(@root)
    golden =[ 
             "umf30qaaawcmpb0",
             "QNSA3N128K0V2",
             "QICTR0LHLH01",
             "QAHLCD0O000A",
             "QAHLCD0BHKAH3SA",
             "QICBL0LHLH01",
             "QICBR0LHLH01",
             "QAHLCD0BGKAESA",
             "QAHLCD0O000AP",
             "QAHLCD0BHKAISA",
             "QAHLCD0BHKAJSA",
             "QAHLCD0B3F0K",
             "QICTL0LHLH01",
             "QAHLCD0BGKAESAP",
             "QAHAB2010HNV1",
             "QAHAB2011HNV1",
             "QAHAB2012HNV1",
             "QAHAB2013HNV1",
             "QAHAB2014HNV1",
             "QAHAB2015HNV1",
             "QB20GKASAG",
             "QB003F0G",
             "QO200KALZ",
             "QB20HKASAFG",
             "QAHAB2008HNJV1",
             "QIFLVPP1P5",
             "QAHAB2000HNV1",
             "QAHAB2001HNV1",
             "QAHAB2002HNV1",
             "QAHAB2003HNV1",
             "QAHAB2004HNV1",
             "QAHAB2005HNV1",
             "QAHAB2006HNV1",
             "QAHAB2007HNV1",
             "QB20HKASAG",
             "QAHAB2008HNV1",
             "QAHAB2009HNV1",
             "QO200KAL",
             "QB20HKASAFGX99",
             "OWSRAM130W2048B18C4B9",
             "QAHIOS0BN32MV2",
             "QNSB3N004K0V2",
             "umf30QAHLCD0",
             "umf30QAHMIX0MAIN",
             "QAHAB2000HNYV1",
             "QAHAB2001HNYV1",
             "QAHAD20SWL1V1",
             "QAHADA20HN0V1",
             "QAHAD20SWL1LCDV1",
             "QAHAD20SWR1V1",
             "QAHAD20SWR1LCDV1",
             "QICTR5H5AP"
             ]
    revised = golden1-revised1
    assert_equal(golden,revised)
=begin
    @root = XMLParse.read("./tp/f14.xml")
    golden1 = XMLParse::get_ModuleList(@root)
    XMLParse::delete_HardMacro(@root)
    revised1 = XMLParse::get_ModuleList(@root)
    revised = golden1-revised1
    golden = ["QAHPLMF3MPLLV1", "RELMULTPLLMODULEV0"]
    assert_equal(golden,revised)
=end
  end

  #
  # Test for get_TerminalList function
  #
  def test_get_TerminalList
    printf "\n@T:#{__method__}\n"

    @root = XMLParse.read("./tp/test_simple.xml")
    golden = ["CLK","RST","SEL","DIN","DIN2","DOUT","SELOUT","IO_PORT1","IO_PORT2"]
    assert_equal(golden,XMLParse::get_TerminalList(@root,"test"))

  end


  #
  # Test for add_Terminal function
  #
  def test_add_Terminal
    printf "\n@T:#{__method__}\n"
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")
    golden = []
    signal001 = FICE_DB::SignalInf.new( :name => "ADD_INPUT_PORT001", :type => "input" )
    signal002 = FICE_DB::SignalInf.new( :name => "ADD_OUTPUT_PORT002", :type => "output" )
    @root = XMLParse::add_Terminal(@root,"test",signal001)
    @root = XMLParse::add_Terminal(@root,"test",signal002)
    assert_equal([signal001.Name,signal002.Name],XMLParse::get_TerminalList(@root,"test") - XMLParse::get_TerminalList(@root_org,"test"))
  end

  #
  # Test for delete_Terminal function
  #
  def test_delete_Terminal
    printf "\n@T:#{__method__}\n"
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")
    golden = ["CLK","RST"]
    golden.each do |name|
      @root = XMLParse::delete_Terminal(@root,"test",name)
    end
    assert_equal(golden,XMLParse::get_TerminalList(@root_org,"test") - XMLParse::get_TerminalList(@root,"test"))
  end


  #
  # Test for get_PortList function
  #
  def test_get_PortList
    printf "\n@T:#{__method__}\n"
    
    @root = XMLParse.read("./tp/test_simple.xml")
    # test for test module
    golden = { 
      "CLK" => FICE_DB::SignalInf.new( :name => "CLK" , :type => "input"),
      "CLK2" => FICE_DB::SignalInf.new( :name => "CLK2" , :type => "input"),
      "RST" => FICE_DB::SignalInf.new( :name => "RST" , :type => "input"),
      "SEL" => FICE_DB::SignalInf.new( :name => "SEL" , :type => "input"),
      "DIN" => FICE_DB::SignalInf.new( :name => "DIN" , :type => "input", :msb => 3, :lsb => 0),
      "DIN2" => FICE_DB::SignalInf.new( :name => "DIN2" , :type => "input", :msb => 3, :lsb => 0),
      "DOUT" => FICE_DB::SignalInf.new( :name => "DOUT" , :type => "output", :msb => 3, :lsb => 0),
      "SELOUT" => FICE_DB::SignalInf.new( :name => "SELOUT" , :type => "output"),
      "IO_PORT1" => FICE_DB::SignalInf.new( :name => "IO_PORT1" , :type => "inout"),
      "IO_PORT2" => FICE_DB::SignalInf.new( :name => "IO_PORT2" , :type => "inout", :msb => 8, :lsb => 0),
    }
    
    revised = XMLParse::get_PortList(@root,"test")
    assert_equal(golden,revised)
    
    # test for Buffer module
    golden = {
      "a" => FICE_DB::SignalInf.new( :name => "a" , :type => "input", :msb => 3, :lsb => 0),
      "b" => FICE_DB::SignalInf.new( :name => "b" , :type => "output"),
    }   
    revised = XMLParse::get_PortList(@root,"Buffer")
    assert_equal(golden,revised)
    
  end
  
  #
  # Test for get_PortDirectionn
  #
  def test_get_PortDirection
    printf "\n@T:#{__method__}\n"
    
    @root = XMLParse.read("./tp/test_simple.xml")
    golden = {
      "CLK" => "input",
      "CLK2" => "input",
      "RST" => "input",
      "SEL" => "input",
      "DIN" => "input",
      "DIN2" => "input",
      "DOUT" => "output",
      "SELOUT" => "output",
      "IO_PORT1" => "inout",
      "IO_PORT2" => "inout"      
    }
    revised = Hash.new
    golden.each_key do |name|
      direction = XMLParse::get_PortDirection(@root,"test",name)
      revised["#{name}"] = direction
    end
    assert_equal(golden,revised)
  end
  
  #
  # Test for add_Port function
  #
  def test_add_Port
    printf "\n@T:#{__method__}\n"
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")
    golden = []
    signal001 = FICE_DB::SignalInf.new( :name => "ADD_INPUT_PORT001", :type => "input")
    signal002 = FICE_DB::SignalInf.new( :name => "ADD_INPUT_PORT002", :type => "input", :msb => 3, :lsb => 0)
    signal003 = FICE_DB::SignalInf.new( :name => "ADD_OUTPUT_PORT003", :type => "output" )
    signal004 = FICE_DB::SignalInf.new( :name => "ADD_OUTPUT_PORT004", :type => "output", :msb => 7, :lsb => 2)
    @root = XMLParse::add_Port(@root,"test",signal001)
    @root = XMLParse::add_Port(@root,"test",signal002)
    @root = XMLParse::add_Port(@root,"test",signal003)
    @root = XMLParse::add_Port(@root,"test",signal004)
    
    diff = port_diff(@root,@root_org,"test")
    assert_equal([signal004,signal003,signal002,signal001],diff)
  end
  
  #
  # Test for add_Port function
  #
  def test_delete_Port
    printf "\n@T:#{__method__}\n"
    @root_org = XMLParse.read("./tp/test_simple.xml")
#    p XMLParse::get_PortList(@root_org,"test").keys

    @root = XMLParse.read("./tp/test_simple.xml")
    golden = ["CLK2","RST","DIN2","IO_PORT1"]
    golden.each do |signal|
      @root = XMLParse::delete_Port(@root,"test",signal)
    end
#    p XMLParse::get_PortList(@root_org,"test").keys
#    XMLParse::save(@root_org,"mod.xml")
#    `XMLtoVerilog mod.xml > tp/mod.v`
#    exit
    
    diff = port_diff(@root_org,@root,"test")
    revised = Array.new
    diff.each do |signal|
      revised << signal.Name
    end
    assert_equal(golden,revised)
  end

  def port_diff(xml_mod,xml_org,module_name)
    list1 = XMLParse::get_PortList(xml_mod,"#{module_name}")
    list2 = XMLParse::get_PortList(xml_org,"#{module_name}")
    diff = Array.new
    list1.each_value do |port_inf|
      match_flag = false
      list2.each_value do |port_inf2|
        if port_inf -  port_inf2
          match_flag = true
        end
      end
      diff << port_inf if match_flag == false
    end
    return diff
  end
  
  def wire_diff(xml_mod,xml_org,module_name)
    list1 = XMLParse::get_WireList(xml_mod,"#{module_name}")
    list2 = XMLParse::get_WireList(xml_org,"#{module_name}")
    diff = Array.new
    list1.each_value do |port_inf|
      match_flag = false
      list2.each_value do |port_inf2|
        if port_inf -  port_inf2
          match_flag = true
        end
      end
      diff << port_inf if match_flag == false
    end
    return diff
  end

  def connect_diff(xml_mod,xml_org,module_name,inst_name)
    list1 = XMLParse::get_ConnectList(xml_mod,"#{module_name}","#{inst_name}")
    list2 = XMLParse::get_ConnectList(xml_org,"#{module_name}","#{inst_name}")
    diff = Hash.new
    list1.each do |port_inf,value1|
      match_flag = false
      list2.each do |port_inf2,value2|
        if port_inf ==  port_inf2 
          for i in 0..(value1.size-1)
            if value1[i] - value2[i]
              match_flag = true
            else
              match_flag = false
              break
            end
          end
        end
      end
      diff[port_inf] = value1 if match_flag == false
    end
    return diff
  end

  #
  # Test for get_InstanceList function
  #
  def test_get_InstanceList
    printf "\n@T:#{__method__}\n"
    # Normal
    golden = [["TBCLL", "pulldown0"],["TBCLL", "pulldown1"],["TBCLL", "pulldown2"],["TBCLL", "pulldown3"],["TBCLL", "pulldown4"],["TBCLL", "pulldown5"],["TBCLL", "pulldown6"],["TBCLL", "pulldown7"],["TBCLL", "pulldown8"],["TBCLL", "pulldown9"],["TBCLL", "pulldown10"],["TBCLL", "pulldown11"],["TBCLL", "pulldown12"],["TBCLL", "pulldown20"],["TBCLL", "pulldown13"],["TBCLL", "pulldown21"],["TBCLL", "pulldown14"],["TBCLL", "pulldown22"],["TBCLL", "pulldown30"],["TBCLL", "pulldown15"],["TBCLL", "pulldown23"],["TBCLL", "pulldown31"],["TBCLL", "pulldown16"],["TBCLL", "pulldown24"],["TBCLL", "pulldown32"],["TBCLL", "pulldown40"],["TBCLL", "pulldown17"],["TBCLL", "pulldown25"],["TBCLL", "pulldown33"],["TBCLL", "pulldown41"],["TBCLL", "pulldown18"],["TBCLL", "pulldown26"],["TBCLL", "pulldown34"],["TBCLL", "pulldown42"],["TBCLL", "pulldown50"],["TBCLL", "pulldown19"],["TBCLL", "pulldown27"],["TBCLL", "pulldown35"],["TBCLL", "pulldown43"],["TBCLL", "pulldown51"],["TBCLL", "pulldown28"],["TBCLL", "pulldown36"],["TBCLL", "pulldown44"],["TBCLL", "pulldown52"],["TBCLL", "pulldown60"],["TBCLL", "pulldown29"],["TBCLL", "pulldown37"],["TBCLL", "pulldown45"],["TBCLL", "pulldown53"],["TBCLL", "pulldown61"],["TBCLL", "pulldown38"],["TBCLL", "pulldown46"],["TBCLL", "pulldown54"],["TBCLL", "pulldown62"],["TBCLL", "pulldown70"],["TBCLL", "pulldown39"],["TBCLL", "pulldown47"],["TBCLL", "pulldown55"],["TBCLL", "pulldown63"],["TBCLL", "pulldown71"],["TBCLL", "pulldown48"],["TBCLL", "pulldown56"],["TBCLL", "pulldown64"],["TBCLL", "pulldown72"],["TBCLL", "pulldown80"],["TBCLL", "pulldown49"],["TBCLL", "pulldown57"],["TBCLL", "pulldown65"],["TBCLL", "pulldown73"],["TBCLL", "pulldown81"],["TBCLL", "pulldown58"],["TBCLL", "pulldown66"],["TBCLL", "pulldown74"],["TBCLL", "pulldown82"],["TBCLL", "pulldown90"],["TBCLL", "pulldown59"],["TBCLL", "pulldown67"],["TBCLL", "pulldown75"],["TBCLL", "pulldown83"],["TBCLL", "pulldown91"],["TBCLL", "pulldown68"],["TBCLL", "pulldown76"],["TBCLL", "pulldown84"],["TBCLL", "pulldown92"],["TBCLL", "pulldown69"],["TBCLL", "pulldown77"],["TBCLL", "pulldown85"],["TBCLL", "pulldown93"],["TBCLL", "pulldown78"],["TBCLL", "pulldown86"],["TBCLL", "pulldown94"],["TBCLL", "pulldown79"],["TBCLL", "pulldown87"],["TBCLL", "pulldown95"],["TBCLL", "pulldown88"],["TBCLL", "pulldown96"],["TBCLL", "pulldown89"],["TBCLL", "pulldown97"],["TBCLL", "pulldown98"],["TBCLL", "pulldown99"],["TBCLL", "pulldown100"],["TBCLL", "pulldown101"],["TBCLL", "pulldown102"],["TBCLL", "pulldown110"],["TBCLL", "pulldown103"],["TBCLL", "pulldown111"],["TBCLL", "pulldown104"],["TBCLL", "pulldown112"],["TBCLL", "pulldown120"],["TBCLL", "pulldown105"],["TBCLL", "pulldown113"],["TBCLL", "pulldown106"],["TBCLL", "pulldown114"],["TBCLL", "pulldown107"],["TBCLL", "pulldown115"],["TBCLL", "pulldown108"],["TBCLL", "pulldown116"],["TBCLL", "pulldown109"],["TBCLL", "pulldown117"],["TBCLL", "pulldown118"],["TBCLL", "pulldown119"],["TBCLH", "pullup0"],["TBCLH", "pullup1"],["TBCLH", "pullup2"],["TBCLH", "pullup3"],["TBCLH", "pullup4"],["TBCLH", "pullup5"],["TBCLH", "pullup6"],["TBCLH", "pullup7"],["TBCLH", "pullup8"],["TBCLH", "pullup9"],["TBCLH", "pullup10"],["TBCLH", "pullup11"],["TBCLH", "pullup12"],["TBCLH", "pullup20"],["TBCLH", "pullup13"],["TBCLH", "pullup21"],["TBCLH", "pullup14"],["TBCLH", "pullup22"],["TBCLH", "pullup30"],["TBCLH", "pullup15"],["TBCLH", "pullup23"],["TBCLH", "pullup31"],["TBCLH", "pullup16"],["TBCLH", "pullup24"],["TBCLH", "pullup32"],["TBCLH", "pullup40"],["TBCLH", "pullup17"],["TBCLH", "pullup25"],["TBCLH", "pullup33"],["TBCLH", "pullup41"],["TBCLH", "pullup18"],["TBCLH", "pullup26"],["TBCLH", "pullup34"],["TBCLH", "pullup42"],["TBCLH", "pullup50"],["TBCLH", "pullup19"],["TBCLH", "pullup27"],["TBCLH", "pullup35"],["TBCLH", "pullup43"],["TBCLH", "pullup51"],["TBCLH", "pullup28"],["TBCLH", "pullup36"],["TBCLH", "pullup44"],["TBCLH", "pullup52"],["TBCLH", "pullup60"],["TBCLH", "pullup29"],["TBCLH", "pullup37"],["TBCLH", "pullup45"],["TBCLH", "pullup53"],["TBCLH", "pullup61"],["TBCLH", "pullup38"],["TBCLH", "pullup46"],["TBCLH", "pullup54"],["TBCLH", "pullup62"],["TBCLH", "pullup70"],["TBCLH", "pullup39"],["TBCLH", "pullup47"],["TBCLH", "pullup55"],["TBCLH", "pullup63"],["TBCLH", "pullup71"],["TBCLH", "pullup48"],["TBCLH", "pullup56"],["TBCLH", "pullup64"],["TBCLH", "pullup72"],["TBCLH", "pullup49"],["TBCLH", "pullup57"],["TBCLH", "pullup65"],["TBCLH", "pullup73"],["TBCLH", "pullup58"],["TBCLH", "pullup66"],["TBCLH", "pullup74"],["TBCLH", "pullup59"],["TBCLH", "pullup67"],["TBCLH", "pullup75"],["TBCLH", "pullup68"],["TBCLH", "pullup76"],["TBCLH", "pullup69"],["TBCLH", "pullup77"],["TBCLH", "pullup78"],["TBCLH", "pullup79"],["QLK0RCPUEVA0V3", "cpu"],["QLK0RINT48V2", "int48"],["QLK0RDMAC0V1", "dmac"],["QLK0RMULDIV1V1", "muldiv"],["QLK0ROCD1V1", "ocd"],["QLK0RIAW0V1", "iaw"],["QLK0RCSC1V2", "csc"],["QLK0RPCLBUZ1V1", "pclbuz"],["QLK0RCIBCM3SF1V1", "cibc"],["QLK0RCIBDM3SF1V1", "cibd"],["QLK0RFCBM3SF1V1", "fcb"],["QLK0RWWDT1V2", "wwdt"],["QLK0RRTC0V3", "rtc"],["QLK0RCRC0V1", "crc"],["QLK0RMAW0V1", "maw0"],["QLK0RMODECTL2V1", "modectl"],["QLK0RSCON1V1", "scon"],["KX4_FLASHCLK_DLY", "flashclk_dly"],["QNSC3NCP1V2", "flash_cp"],["QNSC3NREG1V2", "flash_reg"],["QNSC3NCPDC0V1", "flash_capa0"],["QNSC3NCPDC0V1", "flash_capa1"],["QNSC3NCPDC0V1", "flash_capa2"],["QNSC3NCPDC0V1", "flash_capa3"],["QNSC3NCPDC0V1", "flash_capa4"],["QNSC3NCPDC0V1", "flash_capa5"],["QNSC3NCPDC0V1", "flash_capa6"],["QNSC3NCPDC0V1", "flash_capa7"],["QNSC3NCPDC0V1", "flash_capa8"],["QNSC3NCPDC0V1", "flash_capa9"],["QNSC3NCPDC0V1", "flash_capa10"],["QNSC3NCPDC0V1", "flash_capa11"],["QNSC3NCPDC0V1", "flash_capa12"],["QNSC3NCPDC0V1", "flash_capa13"],["QNSC3NCPDC0V1", "flash_capa14"],["KX4_BUSBRIDGE", "bbr"],["KX4_PORGA", "porga"],["KX4_INTOR", "intor"],["KX4_CKDIST", "ckdist"],["KX4_MONSIG", "monsig"],["QLK0RINTM4V1", "intm4"],["QLK0RINTM8V1", "intm8"],["KX4_IICASCLDLY", "sdadly0"],["KX4_IICASDADLY", "sdadly1"],["KX4_SDADLY", "sdadly2"],["KX4_SDADLY", "sdadly3"],["KX4_SDADLY", "sdadly011"],["KX4_SDADLY", "sdadly013"],["KX4_SDADLY", "sdadly110"],["KX4_SDADLY", "sdadly111"],["QLK0RIICAV2", "iica"],["QLK0RSAU04R2V1", "sau0"],["QLK0RSAU02R2V1", "sau1"],["QLK0RTAU08R2V1", "tau0"],["KX4_PORT0V1", "port0"],["KX4_PORT1V1", "port1"],["KX4_PORT2V1", "port2"],["KX4_PORT3V1", "port3"],["KX4_PORT4V1", "port4"],["KX4_PORT5V1", "port5"],["KX4_PORT6V1", "port6"],["KX4_PORT7V1", "port7"],["KX4_PORT12V1", "port12"],["KX4_PORT13V1", "port13"],["KX4_PORT14V1", "port14"],["KX4_PIORV2", "pior"],["QLK0RADAA32V1", "adctl"],["KX4_CAPCKGATE", "capckgate"],["KX4_CAPMUX4", "capmux"],["KX4_CAPLIO", "capl"],["KX4_CAPRIO", "capr"],["QICAP035H5H", "capadl"],["QICAP025H5H", "capadr"],["TBFILTER1X2", "dmydly50n"],["QAHNFI4BN300NV1", "dmydly300n"],["QAHRES0CV1", "vppts1_res"]]
    assert_equal(golden,XMLParse::get_InstanceList(@root,"D78F1070_EVA"))
  end

  #
  # Test for change_InstanceModule
  #
  def test_change_InstanceModule
    printf "\n@T:#{__method__}\n"
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")
    golden = [
              ["Buffer_Change", "buf0"], 
              ["Buffer", "buf1"],
              ["Buffer", "buf2"],
              ["Buffer", "buf3"],
              ["SubMod","sub0"],
              ["DriveChangeA", "drive_change_a"],
              ["DriveChangeB", "drive_change_b"],
              ["DriveChangeC", "drive_change_c"]
             ]
    # Inst:buf0 (Buffer => Buffer_Change)
    XMLParse::change_InstanceModule(@root,"test","buf0","Buffer_Change")
    assert_equal(golden,XMLParse::get_InstanceList(@root,"test"))
    # Both Instance
    golden = [
              ["Buffer_Change", "buf0_change"], 
              ["Buffer", "buf1"],
              ["Buffer", "buf2"],
              ["Buffer", "buf3"],
              ["SubMod","sub0"],
              ["DriveChangeA", "drive_change_a"],
              ["DriveChangeB", "drive_change_b"],
              ["DriveChangeC", "drive_change_c"]
             ]
    XMLParse::change_InstanceModule(@root,"test","buf0","Buffer_Change","buf0_change")
    assert_equal(golden,XMLParse::get_InstanceList(@root,"test"))
  end
  

  #
  # Test for get_InstConnectList function
  #
  def test_get_ConnectList
    printf "\n@T:#{__method__}\n"


    # bus-connection
    @root = XMLParse.read("./tp/test_simple.xml")
    
    signal001 = FICE_DB::SignalInf.new( :name => "SEL", :type => "wire" )
    signal002 = FICE_DB::SignalInf.new( :name => "DIN2", :type => "wire" , :portion => 0)
    signal003 = FICE_DB::SignalInf.new( :name => "DIN2", :type => "wire" , :msb => 2, :lsb => 1)
    b_con = FICE_DB::SignalInf.new( :name => "SEL_w", :type => "wire" )
    golden = { 
      "a" => [signal001, signal002, signal003], 
      "b" => [b_con]
    }
    assert_equal(golden,XMLParse::get_ConnectList(@root,"test","buf0"))

    

    signal001 = FICE_DB::SignalInf.new( :name => "SEL", :type => "wire" )
    signal002 = FICE_DB::SignalInf.new( :name => "DIN2", :type => "wire" , :msb => 1, :lsb => 0)
    signal003 = FICE_DB::SignalInf.new( :name => "DIN2", :type => "wire" , :portion => 2)
    b_con = FICE_DB::SignalInf.new( :name => "SEL_w", :type => "wire" )
    golden = { 
      "a" => [signal001, signal002, signal003],
      "b" => [b_con]
    }
    assert_equal(golden,XMLParse::get_ConnectList(@root,"test","buf1"))


    signal001 = FICE_DB::SignalInf.new( :name => "DIN2", :type => "wire" , :msb => 1, :lsb => 0)
    b_con = FICE_DB::SignalInf.new( :name => "SEL_w", :type => "wire" )
    golden = { 
      "a" => [signal001],
      "b" => [b_con]
    }
    assert_equal(golden,XMLParse::get_ConnectList(@root,"test","buf2"))
    
    signal001 = FICE_DB::SignalInf.new( :name => "DIN3", :type => "wire" , :portion => 2)
    b_con = FICE_DB::SignalInf.new( :name => "SEL_w", :type => "wire" )
    golden = { 
      "a" => [signal001],
      "b" => [b_con]
    }
    assert_equal(golden,XMLParse::get_ConnectList(@root,"test","buf3"))


    signal001 = FICE_DB::SignalInf.new( :name => "1'b1", :type => "constant")
    signal002 = FICE_DB::SignalInf.new( :name => "wire002", :type => "wire")
    signal003 = FICE_DB::SignalInf.new( :name => "wire001", :type => "wire")
    signal004 = FICE_DB::SignalInf.new( :name => "SEL_w", :type => "wire" )
    golden = { 
      "a" => [signal001],
      "b" => [signal002],
      "c" => [signal003],
      "d" => [signal004]
    }
    assert_equal(golden,XMLParse::get_ConnectList(@root,"test","sub0"))
  end

=begin
  #
  # Test for search_Connection
  #
  def test_search_Connection
    printf "\n@T:#{__method__}\n"
    @root = XMLParse.read("/home/product/div-micom-ice/data/proj/RL78/Common/.fice/xml/rl78.xml")
    
    tree = FICE_DB::PathTree.new

    #------------------------------
#    golden = [
#             ]
#    connect_list = XMLParse::search_Connection(@root,"D78F1070.QLK0RDMAC0V1.QLK0RDMAC0V1_MAIN","dmac.main.trigsel0","dmack",true) # Input signal
#    revised = get_path(connect_list)
#    assert_equal(golden,revised)
#    exit

    #------------------------------
    golden = [
              [["dmac.main.sfr", "mdw9"], ["dmac.main", "mdw9"]],
              [["dmac.main.sfr", "mdw9"], ["dmac.main", "mdw9"], ["dmac", "MDW9"]],
              [["dmac.main.sfr", "mdw9"], ["dmac.main", "mdw9"], ["dmac", "MDW9"], ["cpu", "MDW9"]],
              [["dmac.main.sfr", "mdw9"], ["dmac.main", "mdw9"], ["dmac", "MDW9"], ["cpu", "MDW9"], ["cpu.U561", "N01"]],
             ]
    connect_list = XMLParse::search_Connection(@root,"D78F1070.QLK0RDMAC0V1.QLK0RDMAC0V1_MAIN","dmac.main.sfr","mdw9",true) # Input signal
    revised = get_path(connect_list)
    assert_equal(golden,revised)

    #------------------------------
    golden = [
              [["cpu", "MDW9"], ["int48", "MDW9"]],
              [["cpu", "MDW9"], ["dmac", "MDW9"]],
              [["cpu", "MDW9"], ["muldiv", "MDW9"]],
              [["cpu", "MDW9"], ["ocd", "MDW9"]],
              [["cpu", "MDW9"], ["csc", "PWDATA9"]],
              [["cpu", "MDW9"], ["pclbuz", "PWDATA9"]],
              [["cpu", "MDW9"], ["cibc", "PWDATA9"]],
              [["cpu", "MDW9"], ["fcb", "PWDATA9"]],
              [["cpu", "MDW9"], ["wwdt", "PWDATA9"]],
              [["cpu", "MDW9"], ["rtc", "PWDATA9"]],
              [["cpu", "MDW9"], ["crc", "PWDATA9"]],
              [["cpu", "MDW9"], ["maw0", "PWDATA9"]],
              [["cpu", "MDW9"], ["modectl", "PWDATA9"]],
              [["cpu", "MDW9"], ["ramif", "MDW9"]],
              [["cpu", "MDW9"], ["bbr", "MDW9"]],
              [["cpu", "MDW9"], ["intm4", "MDW9"]],
              [["cpu", "MDW9"], ["intm8", "MDW9"]],
              [["cpu", "MDW9"], ["iica", "PWDATA9"]],
              [["cpu", "MDW9"], ["sau0", "PWDATA25"]],
              [["cpu", "MDW9"], ["sau0", "PWDATA9"]],
              [["cpu", "MDW9"], ["sau1", "PWDATA25"]],
              [["cpu", "MDW9"], ["sau1", "PWDATA9"]],
              [["cpu", "MDW9"], ["tau0", "PWDATA25"]],
              [["cpu", "MDW9"], ["tau0", "PWDATA9"]],
              [["cpu", "MDW9"], ["port1", "PWDATA9"]],
              [["cpu", "MDW9"], ["port3", "PWDATA9"]],
              [["cpu", "MDW9"], ["port5", "PWDATA9"]],
              [["cpu", "MDW9"], ["port7", "PWDATA9"]],
              [["cpu", "MDW9"], ["adctl", "PWDATA9"]]
             ]
    connect_list = XMLParse::search_Connection(@root,"D78F1070","cpu","MDW9",false) # Input signal
    revised = get_path(connect_list)
    assert_equal(golden,revised)

    #------------------------------
    golden = [
              [["dmac", "MDW9"], ["cpu", "MDW9"]]
             ]
    connect_list = XMLParse::search_Connection(@root,"D78F1070","dmac","MDW9",false) # Input signal
    revised = get_path(connect_list)
    assert_equal(golden,revised)

    #------------------------------
    golden = [
              [["cpu", "MDW9"], ["int48", "MDW9"]],
              [["cpu", "MDW9"], ["int48", "MDW9"], ["int48.main", "MDW9"]],
              [["cpu", "MDW9"], ["int48", "MDW9"], ["int48.main", "MDW9"], ["int48.main.sfrreg", "MDW9"]],
              [["cpu", "MDW9"], ["int48", "MDW9"], ["int48.main", "MDW9"], ["int48.main.sfrreg", "MDW9"], ["int48.main.sfrreg.IFREG9", "mdw"]],
              [["cpu", "MDW9"], ["int48", "MDW9"], ["int48.main", "MDW9"], ["int48.main.sfrreg", "MDW9"], ["int48.main.sfrreg.IFREG25", "mdw"]],
              [["cpu", "MDW9"], ["int48", "MDW9"], ["int48.main", "MDW9"], ["int48.main.sfrreg", "MDW9"], ["int48.main.sfrreg.IFREG41", "mdw"]],
              [["cpu", "MDW9"], ["dmac", "MDW9"]],
              [["cpu", "MDW9"], ["dmac", "MDW9"], ["dmac.main", "mdw9"]],
              [["cpu", "MDW9"], ["dmac", "MDW9"], ["dmac.main", "mdw9"], ["dmac.main.sfr", "mdw9"]],
              [["cpu", "MDW9"], ["muldiv", "MDW9"]],
              [["cpu", "MDW9"], ["ocd", "MDW9"]],
              [["cpu", "MDW9"], ["ocd", "MDW9"], ["ocd.bi", "mdw"]],
              [["cpu", "MDW9"], ["csc", "PWDATA9"]],
              [["cpu", "MDW9"], ["csc", "PWDATA9"], ["csc.cg", "PWDATA9"]],
              [["cpu", "MDW9"], ["csc", "PWDATA9"], ["csc.cg", "PWDATA9"], ["csc.cg.regi", "din"]],
              [["cpu", "MDW9"], ["pclbuz", "PWDATA9"]],
              [["cpu", "MDW9"], ["pclbuz", "PWDATA9"], ["pclbuz.main", "din"]],
              [["cpu", "MDW9"], ["cibc", "PWDATA9"]],
              [["cpu", "MDW9"], ["fcb", "PWDATA9"]],
              [["cpu", "MDW9"], ["fcb", "PWDATA9"], ["fcb.mode", "dhin1"]],
              [["cpu", "MDW9"], ["fcb", "PWDATA9"], ["fcb.mscb", "dhin1"]],
              [["cpu", "MDW9"], ["fcb", "PWDATA9"], ["fcb.regrw", "dhin1"]],
              [["cpu", "MDW9"], ["fcb", "PWDATA9"], ["fcb.wcbctl", "dhin1"]],
              [["cpu", "MDW9"], ["wwdt", "PWDATA9"]],
              [["cpu", "MDW9"], ["wwdt", "PWDATA9"], ["wwdt.bi", "wdata"]],
              [["cpu", "MDW9"], ["rtc", "PWDATA9"]],
              [["cpu", "MDW9"], ["rtc", "PWDATA9"], ["rtc.apbbi", "wdata"]],
              [["cpu", "MDW9"], ["crc", "PWDATA9"]],
              [["cpu", "MDW9"], ["maw0", "PWDATA9"]],
              [["cpu", "MDW9"], ["modectl", "PWDATA9"]],
              [["cpu", "MDW9"], ["modectl", "PWDATA9"], ["modectl.modectl_apbbi", "wdata"]],
              [["cpu", "MDW9"], ["ramif", "MDW9"]],
              [["cpu", "MDW9"], ["ramif", "MDW9"], ["ramif.ramif", "mdw"]],
              [["cpu", "MDW9"], ["ramif", "MDW9"], ["ramif.prty_write", "MDW_in"]],
              [["cpu", "MDW9"], ["bbr", "MDW9"]],
              [["cpu", "MDW9"], ["bbr", "MDW9"], ["bbr.apbctl", "mdw"]],
              [["cpu", "MDW9"], ["intm4", "MDW9"]],
              [["cpu", "MDW9"], ["intm4", "MDW9"], ["intm4.main", "dinh"]],
              [["cpu", "MDW9"], ["intm8", "MDW9"]],
              [["cpu", "MDW9"], ["intm8", "MDW9"], ["intm8.main", "din"]],
              [["cpu", "MDW9"], ["iica", "PWDATA9"]],
              [["cpu", "MDW9"], ["iica", "PWDATA9"], ["iica.apbbi", "wdata"]],
              [["cpu", "MDW9"], ["sau0", "PWDATA25"]],
              [["cpu", "MDW9"], ["sau0", "PWDATA9"]],
              [["cpu", "MDW9"], ["sau1", "PWDATA25"]],
              [["cpu", "MDW9"], ["sau1", "PWDATA9"]],
              [["cpu", "MDW9"], ["tau0", "PWDATA25"]],
              [["cpu", "MDW9"], ["tau0", "PWDATA9"]],
              [["cpu", "MDW9"], ["port1", "PWDATA9"]],
              [["cpu", "MDW9"], ["port1", "PWDATA9"], ["port1.portbit1", "PWDATA"]],
              [["cpu", "MDW9"], ["port3", "PWDATA9"]],
              [["cpu", "MDW9"], ["port3", "PWDATA9"], ["port3.portbit1", "PWDATA"]],
              [["cpu", "MDW9"], ["port5", "PWDATA9"]],
              [["cpu", "MDW9"], ["port5", "PWDATA9"], ["port5.portbit1", "PWDATA"]],
              [["cpu", "MDW9"], ["port7", "PWDATA9"]],
              [["cpu", "MDW9"], ["port7", "PWDATA9"], ["port7.portbit1", "PWDATA"]],
              [["cpu", "MDW9"], ["port7", "PWDATA9"], ["port7.kr08", "PWDATA1"]],
              [["cpu", "MDW9"], ["port7", "PWDATA9"], ["port7.kr08", "PWDATA1"], ["port7.kr08.QPK0RKR08V1_BI", "PWDATA"]],
              [["cpu", "MDW9"], ["adctl", "PWDATA9"]],
              [["cpu", "MDW9"], ["adctl", "PWDATA9"], ["adctl.apbif", "PWDATA9"]],
              [["cpu", "MDW9"], ["adctl", "PWDATA9"], ["adctl.apbif", "PWDATA9"], ["adctl.apbif.regtop", "PWDATA9"]],
              [["cpu", "MDW9"], ["adctl", "PWDATA9"], ["adctl.apbif", "PWDATA9"], ["adctl.apbif.regtop", "PWDATA9"], ["adctl.apbif.regtop.regwr", "PWDATA9"]]
             ]
    connect_list = XMLParse::search_Connection(@root,"D78F1070","cpu","MDW9",true) # Input signal
    revised = get_path(connect_list)
    assert_equal(golden,revised)

    #------------------------------
    golden = [
              [[nil, "RESINB"], ["resetb", "SPAD"]]
             ]
    connect_list = XMLParse::search_Connection(@root,"D78F1070",nil,"RESINB",true) # Input Terminal
    revised = get_path(connect_list)
    assert_equal(golden,revised)

    #------------------------------
    golden = [
              [[nil, "P120"], ["port12_iobuf", "P120"]],
              [[nil, "P120"], ["port12_iobuf", "P120"], ["port12_iobuf.iobuf0", "SPAD"]]
             ]
    connect_list = XMLParse::search_Connection(@root,"D78F1070",nil,"P120",true)   # Inout Terminal
    revised = get_path(connect_list)
    assert_equal(golden,revised)


    #------------------------------
    golden = [
              [["dec", "ID_stage1"], ["adr", "ID_stage1_dec"]]
             ]
    connect_list = XMLParse::search_Connection(@root,"QLK0RCPUEVA0V3","dec","ID_stage1",false)   # Inout Terminal
    revised = get_path(connect_list)
    assert_equal(golden,revised)
  end
=end

  #
  # Test for add_Instance
  #
  def test_add_Instance
    printf "\n@T:#{__method__}\n"
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root1 = XMLParse.read("./tp/test_simple.xml")
    @root2 = XMLParse.read("./tp/test_simple.xml")

    golden = XMLParse::get_InstanceList(@root_org,"test")
    add_inst = [["ADD_MODULE","add_module"]]
    golden = golden + add_inst
    root_modify = XMLParse::add_Instance(@root1,"test",add_inst[0])
    assert_equal(golden,XMLParse::get_InstanceList(root_modify,"test"))

    XMLParse::add_Instance(@root2,"test",add_inst[0])
    
    add_port001 = FICE_DB::SignalInf.new( :name => "ADD_PORT001_CON", :type => "wire" )
    add_port002 = FICE_DB::SignalInf.new( :name => "ADD_PORT002_CON", :msb => 3, :lsb => 0, :type => "wire" )
    add_port003 = FICE_DB::SignalInf.new( :name => "ADD_PORT003_CON", :portion => 2,  :type => "wire" )

    signal004 = FICE_DB::SignalInf.new( :name => "ADD_PORT004_CON", :type => "wire" )
    signal005 = FICE_DB::SignalInf.new( :name => "ADD_PORT005_CON", :type => "wire" , :portion => 10)
    signal006 = FICE_DB::SignalInf.new( :name => "ADD_PORT006_CON", :type => "wire" , :msb => 2, :lsb => 1)

    golden = { 
      "ADD_PORT001" => [add_port001],
      "ADD_PORT002" => [add_port002],
      "ADD_PORT003" => [add_port003],
      "ADD_PORT004-006" =>  [signal004, signal005, signal006]
    }

    XMLParse::add_InstancePort(@root2,"test","add_module",{"ADD_PORT001" => [add_port001]})
    XMLParse::add_InstancePort(@root2,"test","add_module",{"ADD_PORT002" => [add_port002]})
    XMLParse::add_InstancePort(@root2,"test","add_module",{"ADD_PORT003" => [add_port003]})
    XMLParse::add_InstancePort(@root2,"test","add_module",{"ADD_PORT004-006" =>  [signal004, signal005, signal006]})
    diff = connect_diff(@root2,@root1,"test","add_module")
    assert_equal(golden,diff)
  end

  #
  # Test for add_Instance
  #
  def test_delete_InstancePort
    printf "\n@T:#{__method__}\n"
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")

    golden = { 
      "b"=> [FICE_DB::SignalInf.new( :name => "SEL_w", :type => "wire", :msb => nil, :lsb => nil)]
    }
    XMLParse::delete_InstancePort(@root,"test","buf0","b")
    diff = connect_diff(@root_org,@root,"test","buf0")
    assert_equal(golden,diff)
  end
  
  #
  # Test for add_InstancePort
  #
  def test_add_InstancePort
    printf "\n@T:#{__method__}\n"
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")

    add_port001 = [FICE_DB::SignalInf.new( :name => "ADD_PORT001_CON", :type => "wire" )]
    add_port002 = [FICE_DB::SignalInf.new( :name => "ADD_PORT002_CON", :msb => 3, :lsb => 0, :type => "wire" )]
    add_port003 = [FICE_DB::SignalInf.new( :name => "ADD_PORT003_CON", :portion => 2,  :type => "wire" )]

    signal004 = FICE_DB::SignalInf.new( :name => "ADD_PORT004_CON", :type => "wire" )
    signal005 = FICE_DB::SignalInf.new( :name => "ADD_PORT005_CON", :type => "wire" , :portion => 10)
    signal006 = FICE_DB::SignalInf.new( :name => "ADD_PORT006_CON", :type => "wire" , :msb => 2, :lsb => 1)
    add_port004 = [signal004, signal005, signal006]

    add_port005 = [FICE_DB::SignalInf.new( :name => "1'b1", :type => "constant" )]
    add_port006 = [FICE_DB::SignalInf.new( :name => "1'b0", :type => "constant" )]
    add_port007 = [FICE_DB::SignalInf.new( :name => nil, :type => "open" )]

    golden = { 
              "ADD_PORT001" => add_port001,
              "ADD_PORT002" => add_port002,
              "ADD_PORT003" => add_port003,
              "ADD_PORT004-006" => add_port004,
              "ADD_PORT005" => add_port005,
              "ADD_PORT006" => add_port006,
              "ADD_PORT007" => add_port007
    }
    
    XMLParse::add_InstancePort(@root,"test","buf0",{"ADD_PORT001" => add_port001})
    XMLParse::add_InstancePort(@root,"test","buf0",{"ADD_PORT002" => add_port002})
    XMLParse::add_InstancePort(@root,"test","buf0",{"ADD_PORT003" => add_port003})
    XMLParse::add_InstancePort(@root,"test","buf0",{"ADD_PORT004-006" => add_port004})
    XMLParse::add_InstancePort(@root,"test","buf0",{"ADD_PORT005" => add_port005})
    XMLParse::add_InstancePort(@root,"test","buf0",{"ADD_PORT006" => add_port006})
    XMLParse::add_InstancePort(@root,"test","buf0",{"ADD_PORT007" => add_port007})
    diff = connect_diff(@root,@root_org,"test","buf0")
    assert_equal(golden,diff)
  end

  
  #
  # Test for get_WireList function
  #
  def test_get_WireList
    printf "\n@T:#{__method__}\n"
    @root = XMLParse.read("./tp/test_simple.xml")
    golden = { 
      "wire001" => FICE_DB::SignalInf.new( :name => "wire001" , :type => "wire"),
      "wire002" => FICE_DB::SignalInf.new( :name => "wire002" , :type => "wire", :msb => 3, :lsb => 0),
      "wire003" => FICE_DB::SignalInf.new( :name => "wire003" , :type => "wire", :msb => 3, :lsb => 0),
      "SEL_w" => FICE_DB::SignalInf.new( :name => "SEL_w" , :type => "wire"),
      "CLK_w" => FICE_DB::SignalInf.new( :name => "CLK_w" , :type => "wire"),
      "drive_change_original" => FICE_DB::SignalInf.new( :name => "drive_change_original" , :type => "wire"),
    }
    assert_equal(golden,XMLParse::get_WireList(@root,"test"))
  end

  #
  # Test for add_Wire function
  #
  def test_add_Wire
    printf "\n@T:#{__method__}\n"
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")
    signal001 = FICE_DB::SignalInf.new( :name => "ADD_WIRE001" , :type => "wire")
    signal002 = FICE_DB::SignalInf.new( :name => "ADD_WIRE002" , :type => "wire", :msb => 3, :lsb => 0)
    @root = XMLParse::add_Wire(@root,"test",signal002)
    @root = XMLParse::add_Wire(@root,"test",signal001)

    diff = wire_diff(@root,@root_org,"test")
    assert_equal([signal001,signal002],diff)
  end

  #
  # Test for delete_Wire function
  #
  def test_delete_Wire
    printf "\n@T:#{__method__}\n"
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")
    golden = ["wire001","wire003","SEL_w"]
    golden.each do  |wire|
      XMLParse::delete_Wire(@root,"test",wire)
    end
    revised = Array.new
    wire_diff(@root_org,@root,"test").each do |wire|
      revised << wire.Name
    end    
    assert_equal(golden,revised)
  end

  #
  # Test for change Module
  #
  def test_change_ModuleName
    printf "\n@T:#{__method__}\n"
    @root = XMLParse.read("./tp/test_simple.xml")
    org =  XMLParse::get_ModuleList(@root)
    @root_mod = XMLParse::change_ModuleName(@root,"test","EVA_TOP")
    mod = XMLParse::get_ModuleList(@root_mod)
    assert_equal(mod - org,["EVA_TOP"])
    assert_equal(org - mod,["test"])
  end

  #
  # Test for get_RegList function
  #
  def test_get_RegList
    printf "\n@T:#{__method__}\n"
    @root = XMLParse.read("./tp/test_simple.xml")
    golden = {
      "reg001" => FICE_DB::SignalInf.new( :name => "reg001" , :type => "reg"),
      "reg002" => FICE_DB::SignalInf.new( :name => "reg002" , :type => "reg"),
      "reg003" => FICE_DB::SignalInf.new( :name => "reg003" , :type => "reg", :msb => 100, :lsb => 0),
      "reg004" => FICE_DB::SignalInf.new( :name => "reg004" , :type => "reg", :msb => 100, :lsb => 0),
      "DOUT_reg" => FICE_DB::SignalInf.new( :name => "DOUT_reg" , :type => "reg", :msb => 3, :lsb => 0),
      "mem001" => FICE_DB::SignalInf.new( :name => "mem001" , :type => "mem", :msb => 7, :lsb => 0, :word_top => 15, :word_buttom => 0),
  }
    assert_equal(golden,XMLParse::get_RegList(@root,"test"))
  end

  #
  # Test for search_Connection
  #
  def test_get_Parameter
    printf "\n@T:#{__method__}\n"
    @root = XMLParse.read("./tp/1572.xml")
    
    top_module = "QNSA3N032K1V2"
#    p XMLParse::get_Parameter(@root,top_module)
  end


  #
  # Test for search_Connection ( Parameterized Wire )
  #
  def test_1572
    printf "\n@T:#{__method__}\n"
    @root = XMLParse.read("./tp/1572.xml")
    
    top_module = "QNSA3N032K1V2"
    golden = FICE_DB::SignalInf.new( :name => "DW", :type => "wire")
    wire_list = XMLParse::get_WireList(@root,top_module)
    assert_equal(golden,wire_list["DW"])
  end
  #
  # Test for search_Connection ( Bus Connection )
  #


  def test_ticket1573
    $TOP_MODULE = "TOP"
    $VERBOSE = true
    printf "\n@T:#{__method__}\n"
    @root = XMLParse.read("./tp/1573.xml")

#    connect_list = XMLParse::search_Connection(@root,"TOP","sub_b3","adr",true) # Input signal
#    p connect_list
#    revised = get_path(connect_list)
#    p revised
#    assert_equal(golden,revised)

    golden = [
              [["sub_a", "a3"], ["sub_b3", "data"]], 
              [["sub_a", "a3"], ["sub_b3", "data"], ["sub_b3.sub_b_sub", "A0"]]
             ]
    connect_list = XMLParse::search_Connection(true,@root,"TOP","sub_a",["a3",nil],true) # Input signal

    revised =  get_path(connect_list)
    assert_equal(golden,revised)

    golden = [
              [["sub_a", "a0"], ["sub_b3", "data"]], 
              [["sub_a", "a0"], ["sub_b3", "data"], ["sub_b3.sub_b_sub", "A3"]]
             ]
    connect_list = XMLParse::search_Connection(true,@root,"TOP","sub_a",["a0",nil],true) # Input signal
    revised =  get_path(connect_list)
    assert_equal(golden,revised)

    golden = [
              [["sub_b3", "data"], ["sub_a", "a3"]], 
              [["sub_b3", "data"], ["sub_a", "a2"]], 
              [["sub_b3", "data"], ["sub_a", "a1"]], 
              [["sub_b3", "data"], ["sub_a", "a0"]]
             ]

    connect_list = XMLParse::search_Connection(true,@root,"TOP","sub_b3",["data",nil],true) # Input signal
    revised =  get_path(connect_list)
    assert_equal(golden,revised)

#    connect_list = XMLParse::search_Connection(@root,"TOP","sub_a","a1",true) # Input signal
#    connect_list = XMLParse::search_Connection(@root,"TOP","sub_a","a2",true) # Input signal
    #   connect_list = XMLParse::search_Connection(@root,"TOP","sub_a","a0",true) # Input signal
    #
  end

  #
  # Test for search_Connection ( Bus Connection )
  #
  def test_ticket1579

    $TOP_MODULE = "TOP_1579"
    $VERBOSE = true
    printf "\n@T:#{__method__}\n"
    @root = XMLParse.read("./tp/1579.xml")
    
#    connect_list = XMLParse::search_Connection(@root,"TOP","sub_b3","adr",true) # Input signal
#    p connect_list
#    revised = get_path(connect_list)
#    p revised
#    assert_equal(golden,revised)

    golden = [
              [["Asub_a", "a3"], ["Asub_b3", "data"]], 
              [["Asub_a", "a3"], ["Asub_b3", "data"], ["Asub_b3.Asub_b3", "A0"]]
             ]
    connect_list = XMLParse::search_Connection(true,@root,"TOP_1579","Asub_a",["a3",nil],true) # Input signal
    revised =  get_path(connect_list)
    assert_equal(golden,revised)

    golden = [
              [["Asub_a", "a0"], ["Asub_b3", "data"]], 
              [["Asub_a", "a0"], ["Asub_b3", "data"], ["Asub_b3.Asub_b3", "A3"]]
             ]
    connect_list = XMLParse::search_Connection(true,@root,"TOP_1579","Asub_a",["a0",nil],true) # Input signal
    revised =  get_path(connect_list)
    assert_equal(golden,revised)


    golden = [
              [["Asub_b3.Asub_b3", "A0"], ["Asub_b3", "data"]],
              [["Asub_b3.Asub_b3", "A0"], ["Asub_b3", "data"], ["Asub_a", "a3"]]
             ]
    
    connect_list = XMLParse::search_Connection(true,@root,"TOP_1579.ASubB","Asub_b3.Asub_b3",["A0",nil],true) # Input signal
    revised =  get_path(connect_list)
    assert_equal(golden,revised)

    golden = [
              [["Asub_b3.Asub_b3", "A1"], ["Asub_b3", "data"]],
              [["Asub_b3.Asub_b3", "A1"], ["Asub_b3", "data"]],
              [["Asub_b3.Asub_b3", "A1"], ["Asub_b3", "data"]],
              [["Asub_b3.Asub_b3", "A1"], ["Asub_b3", "data"], ["Asub_a", "a1"]]      
             ]
    
    connect_list = XMLParse::search_Connection(true,@root,"TOP_1579.ASubB","Asub_b3.Asub_b3",["A1",nil],true) # Input signal
    revised =  get_path(connect_list)
    assert_equal(golden,revised)

    golden = [
              [["Asub_b3.Asub_b3", "A3"], ["Asub_b3", "data"]],
              [["Asub_b3.Asub_b3", "A3"], ["Asub_b3", "data"]],
              [["Asub_b3.Asub_b3", "A3"], ["Asub_b3", "data"]],
              [["Asub_b3.Asub_b3", "A3"], ["Asub_b3", "data"]],
              [["Asub_b3.Asub_b3", "A3"], ["Asub_b3", "data"], ["Asub_a", "a0"]]
             ]
    
    connect_list = XMLParse::search_Connection(true,@root,"TOP_1579.ASubB","Asub_b3.Asub_b3",["A3",nil],true) # Input signal
    revised =  get_path(connect_list)
    assert_equal(golden,revised)


#    connect_list = XMLParse::search_Connection(@root,"TOP","sub_a","a1",true) # Input signal
#    connect_list = XMLParse::search_Connection(@root,"TOP","sub_a","a2",true) # Input signal
    #   connect_list = XMLParse::search_Connection(@root,"TOP","sub_a","a0",true) # Input signal
    #
  end

  #
  # Test for search_Connection ( Bus Connection )
  #
=begin
  def test_ticket1581

#    $TOP_MODULE = "TOP_1580"
    $VERBOSE = true
    printf "\n@T:#{__method__}\n"
 #   @root = XMLParse.read("./tp/1580.xml")

    @root = XMLParse.read("/home/product/div-micom-ice/data/proj/RL78/Common/.fice/xml/G1C_device_DF1.0_rev001_org.xml")

    module_path = "R5F10JGC.crl78fcspf00_g1c"
    inst_path  = "cspf.dmydly300n"
    port_name  = "NFIN"
    
    connect_list = XMLParse::search_Connection(true,@root,module_path,inst_path,[port_name,nil],true) # Input signal
    p get_path(connect_list)
#    connect_list = XMLParse::search_Connection(@root,"TOP_1580.CHIP.cpu","chip.cpu.sub_cpu","pc",true) # Input signal
#    revised = get_path(connect_list)
#    revised.each do |each_path|
#      p each_path
#    end
  end
=end
  def get_path(connect_list)
    revised = Array.new
    connect_list.Path.each do |each_path|
      next if each_path.size == 1
      tmp2 = Array.new
      each_path.each do |path|
        tmp = Array.new
        tmp << path.InstName
        tmp << path.Name
        tmp2 << tmp
      end
      revised << tmp2
    end
    return  revised
  end


end
