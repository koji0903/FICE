#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
require 'test/unit'
$:.unshift(File.dirname(__FILE__) + "/../../bin")
$:.unshift(File.dirname(__FILE__) + "/../../lib")
$:.unshift(File.dirname(__FILE__) + "/../../conf")
require 'FMakeConf'
require 'XMLParse'


class Test_FMakeConf < Test::Unit::TestCase

  def setup
  end

  def test_generate
#    @root = XMLParse.read("/home/m0001/rl0003/product/div-micom-ice/data/proj/RL78/Common/.fice/xml/rl78.xml")
#    p XMLParse::get_InstanceList(@root,"D78F1070")
    inst_list = [["TBCLL", "pulldown0"], ["TBCLL", "pulldown1"], ["TBCLL", "pulldown2"], ["TBCLL", "pulldown3"], ["TBCLL", "pulldown4"], ["TBCLL", "pulldown5"], ["TBCLL", "pulldown6"], ["TBCLL", "pulldown7"], ["TBCLL", "pulldown8"], ["TBCLL", "pulldown9"], ["TBCLL", "pulldown10"], ["TBCLL", "pulldown11"], ["TBCLL", "pulldown12"], ["TBCLL", "pulldown20"], ["TBCLL", "pulldown13"], ["TBCLL", "pulldown21"], ["TBCLL", "pulldown14"], ["TBCLL", "pulldown22"], ["TBCLL", "pulldown30"], ["TBCLL", "pulldown15"], ["TBCLL", "pulldown23"], ["TBCLL", "pulldown31"], ["TBCLL", "pulldown16"], ["TBCLL", "pulldown24"], ["TBCLL", "pulldown32"], ["TBCLL", "pulldown40"], ["TBCLL", "pulldown17"], ["TBCLL", "pulldown25"], ["TBCLL", "pulldown33"], ["TBCLL", "pulldown41"], ["TBCLL", "pulldown18"], ["TBCLL", "pulldown26"], ["TBCLL", "pulldown34"], ["TBCLL", "pulldown42"], ["TBCLL", "pulldown50"], ["TBCLL", "pulldown19"], ["TBCLL", "pulldown27"], ["TBCLL", "pulldown35"], ["TBCLL", "pulldown43"], ["TBCLL", "pulldown51"], ["TBCLL", "pulldown28"], ["TBCLL", "pulldown36"], ["TBCLL", "pulldown44"], ["TBCLL", "pulldown52"], ["TBCLL", "pulldown60"], ["TBCLL", "pulldown29"], ["TBCLL", "pulldown37"], ["TBCLL", "pulldown45"], ["TBCLL", "pulldown53"], ["TBCLL", "pulldown61"], ["TBCLL", "pulldown38"], ["TBCLL", "pulldown46"], ["TBCLL", "pulldown54"], ["TBCLL", "pulldown62"], ["TBCLL", "pulldown70"], ["TBCLL", "pulldown39"], ["TBCLL", "pulldown47"], ["TBCLL", "pulldown55"], ["TBCLL", "pulldown63"], ["TBCLL", "pulldown71"], ["TBCLL", "pulldown48"], ["TBCLL", "pulldown56"], ["TBCLL", "pulldown64"], ["TBCLL", "pulldown72"], ["TBCLL", "pulldown80"], ["TBCLL", "pulldown49"], ["TBCLL", "pulldown57"], ["TBCLL", "pulldown65"], ["TBCLL", "pulldown73"], ["TBCLL", "pulldown81"], ["TBCLL", "pulldown58"], ["TBCLL", "pulldown66"], ["TBCLL", "pulldown74"], ["TBCLL", "pulldown82"], ["TBCLL", "pulldown90"], ["TBCLL", "pulldown59"], ["TBCLL", "pulldown67"], ["TBCLL", "pulldown75"], ["TBCLL", "pulldown83"], ["TBCLL", "pulldown91"], ["TBCLL", "pulldown68"], ["TBCLL", "pulldown76"], ["TBCLL", "pulldown84"], ["TBCLL", "pulldown92"], ["TBCLL", "pulldown69"], ["TBCLL", "pulldown77"], ["TBCLL", "pulldown85"], ["TBCLL", "pulldown93"], ["TBCLL", "pulldown78"], ["TBCLL", "pulldown86"], ["TBCLL", "pulldown94"], ["TBCLL", "pulldown79"], ["TBCLL", "pulldown87"], ["TBCLL", "pulldown95"], ["TBCLL", "pulldown88"], ["TBCLL", "pulldown96"], ["TBCLL", "pulldown89"], ["TBCLL", "pulldown97"], ["TBCLL", "pulldown98"], ["TBCLL", "pulldown99"], ["TBCLL", "pulldown100"], ["TBCLL", "pulldown101"], ["TBCLL", "pulldown102"], ["TBCLL", "pulldown110"], ["TBCLL", "pulldown103"], ["TBCLL", "pulldown111"], ["TBCLL", "pulldown104"], ["TBCLL", "pulldown112"], ["TBCLL", "pulldown120"], ["TBCLL", "pulldown200"], ["TBCLL", "pulldown105"], ["TBCLL", "pulldown113"], ["TBCLL", "pulldown121"], ["TBCLL", "pulldown201"], ["TBCLL", "pulldown106"], ["TBCLL", "pulldown114"], ["TBCLL", "pulldown122"], ["TBCLL", "pulldown130"], ["TBCLL", "pulldown202"], ["TBCLL", "pulldown210"], ["TBCLL", "pulldown107"], ["TBCLL", "pulldown115"], ["TBCLL", "pulldown123"], ["TBCLL", "pulldown131"], ["TBCLL", "pulldown203"], ["TBCLL", "pulldown211"], ["TBCLL", "pulldown108"], ["TBCLL", "pulldown116"], ["TBCLL", "pulldown124"], ["TBCLL", "pulldown132"], ["TBCLL", "pulldown140"], ["TBCLL", "pulldown204"], ["TBCLL", "pulldown212"], ["TBCLL", "pulldown109"], ["TBCLL", "pulldown117"], ["TBCLL", "pulldown125"], ["TBCLL", "pulldown133"], ["TBCLL", "pulldown141"], ["TBCLL", "pulldown205"], ["TBCLL", "pulldown213"], ["TBCLL", "pulldown118"], ["TBCLL", "pulldown126"], ["TBCLL", "pulldown134"], ["TBCLL", "pulldown142"], ["TBCLL", "pulldown150"], ["TBCLL", "pulldown206"], ["TBCLL", "pulldown214"], ["TBCLL", "pulldown119"], ["TBCLL", "pulldown127"], ["TBCLL", "pulldown135"], ["TBCLL", "pulldown143"], ["TBCLL", "pulldown151"], ["TBCLL", "pulldown207"], ["TBCLL", "pulldown215"], ["TBCLL", "pulldown128"], ["TBCLL", "pulldown136"], ["TBCLL", "pulldown144"], ["TBCLL", "pulldown152"], ["TBCLL", "pulldown160"], ["TBCLL", "pulldown208"], ["TBCLL", "pulldown216"], ["TBCLL", "pulldown129"], ["TBCLL", "pulldown137"], ["TBCLL", "pulldown145"], ["TBCLL", "pulldown153"], ["TBCLL", "pulldown161"], ["TBCLL", "pulldown209"], ["TBCLL", "pulldown217"], ["TBCLL", "pulldown138"], ["TBCLL", "pulldown146"], ["TBCLL", "pulldown154"], ["TBCLL", "pulldown162"], ["TBCLL", "pulldown170"], ["TBCLL", "pulldown139"], ["TBCLL", "pulldown147"], ["TBCLL", "pulldown155"], ["TBCLL", "pulldown163"], ["TBCLL", "pulldown171"], ["TBCLL", "pulldown148"], ["TBCLL", "pulldown156"], ["TBCLL", "pulldown164"], ["TBCLL", "pulldown172"], ["TBCLL", "pulldown180"], ["TBCLL", "pulldown149"], ["TBCLL", "pulldown157"], ["TBCLL", "pulldown165"], ["TBCLL", "pulldown173"], ["TBCLL", "pulldown181"], ["TBCLL", "pulldown158"], ["TBCLL", "pulldown166"], ["TBCLL", "pulldown174"], ["TBCLL", "pulldown182"], ["TBCLL", "pulldown190"], ["TBCLL", "pulldown159"], ["TBCLL", "pulldown167"], ["TBCLL", "pulldown175"], ["TBCLL", "pulldown183"], ["TBCLL", "pulldown191"], ["TBCLL", "pulldown168"], ["TBCLL", "pulldown176"], ["TBCLL", "pulldown184"], ["TBCLL", "pulldown192"], ["TBCLL", "pulldown169"], ["TBCLL", "pulldown177"], ["TBCLL", "pulldown185"], ["TBCLL", "pulldown193"], ["TBCLL", "pulldown178"], ["TBCLL", "pulldown186"], ["TBCLL", "pulldown194"], ["TBCLL", "pulldown179"], ["TBCLL", "pulldown187"], ["TBCLL", "pulldown195"], ["TBCLL", "pulldown188"], ["TBCLL", "pulldown196"], ["TBCLL", "pulldown189"], ["TBCLL", "pulldown197"], ["TBCLL", "pulldown198"], ["TBCLL", "pulldown199"], ["TBCLH", "pullup0"], ["TBCLH", "pullup1"], ["TBCLH", "pullup2"], ["TBCLH", "pullup3"], ["TBCLH", "pullup4"], ["TBCLH", "pullup5"], ["TBCLH", "pullup6"], ["TBCLH", "pullup7"], ["TBCLH", "pullup8"], ["TBCLH", "pullup9"], ["TBCLH", "pullup10"], ["TBCLH", "pullup11"], ["TBCLH", "pullup12"], ["TBCLH", "pullup20"], ["TBCLH", "pullup13"], ["TBCLH", "pullup21"], ["TBCLH", "pullup14"], ["TBCLH", "pullup22"], ["TBCLH", "pullup30"], ["TBCLH", "pullup15"], ["TBCLH", "pullup23"], ["TBCLH", "pullup31"], ["TBCLH", "pullup16"], ["TBCLH", "pullup24"], ["TBCLH", "pullup32"], ["TBCLH", "pullup40"], ["TBCLH", "pullup17"], ["TBCLH", "pullup25"], ["TBCLH", "pullup33"], ["TBCLH", "pullup41"], ["TBCLH", "pullup18"], ["TBCLH", "pullup26"], ["TBCLH", "pullup34"], ["TBCLH", "pullup42"], ["TBCLH", "pullup50"], ["TBCLH", "pullup19"], ["TBCLH", "pullup27"], ["TBCLH", "pullup35"], ["TBCLH", "pullup43"], ["TBCLH", "pullup51"], ["TBCLH", "pullup28"], ["TBCLH", "pullup36"], ["TBCLH", "pullup44"], ["TBCLH", "pullup52"], ["TBCLH", "pullup60"], ["TBCLH", "pullup29"], ["TBCLH", "pullup37"], ["TBCLH", "pullup45"], ["TBCLH", "pullup53"], ["TBCLH", "pullup61"], ["TBCLH", "pullup38"], ["TBCLH", "pullup46"], ["TBCLH", "pullup54"], ["TBCLH", "pullup62"], ["TBCLH", "pullup70"], ["TBCLH", "pullup39"], ["TBCLH", "pullup47"], ["TBCLH", "pullup55"], ["TBCLH", "pullup63"], ["TBCLH", "pullup71"], ["TBCLH", "pullup48"], ["TBCLH", "pullup56"], ["TBCLH", "pullup64"], ["TBCLH", "pullup72"], ["TBCLH", "pullup80"], ["TBCLH", "pullup49"], ["TBCLH", "pullup57"], ["TBCLH", "pullup65"], ["TBCLH", "pullup73"], ["TBCLH", "pullup81"], ["TBCLH", "pullup58"], ["TBCLH", "pullup66"], ["TBCLH", "pullup74"], ["TBCLH", "pullup82"], ["TBCLH", "pullup59"], ["TBCLH", "pullup67"], ["TBCLH", "pullup75"], ["TBCLH", "pullup83"], ["TBCLH", "pullup68"], ["TBCLH", "pullup76"], ["TBCLH", "pullup84"], ["TBCLH", "pullup69"], ["TBCLH", "pullup77"], ["TBCLH", "pullup85"], ["TBCLH", "pullup78"], ["TBCLH", "pullup79"], ["QLK0RCPU0V3", "cpu"], ["QLK0RINT48V2", "int48"], ["QLK0RDMAC0V1", "dmac"], ["QLK0RMULDIV1V1", "muldiv"], ["QLK0ROCD1V1", "ocd"], ["QLK0RIAW0V1", "iaw"], ["QLK0RCSC1V2", "csc"], ["QLK0RPCLBUZ1V1", "pclbuz"], ["QLK0RCIBCM3SF1V1", "cibc"], ["QLK0RCIBDM3SF1V1", "cibd"], ["QLK0RFCBM3SF1V1", "fcb"], ["QLK0RWWDT1V2", "wwdt"], ["QLK0RRTC0V3", "rtc"], ["QLK0RCRC0V1", "crc"], ["QLK0RMAW0V1", "maw0"], ["QLK0RMODECTL2V1", "modectl"], ["QLK0RSCON1V1", "scon"], ["KX4_NF", "nf"], ["QAHREGOHNMAINV2", "regm"], ["QAHREGOHNDRVV2", "regd"], ["QAHIOS0BN32MV2", "h_rosc"], ["QAHIOS1BN15KV1", "l_rosc"], ["QAHMOS0HNV1", "oscmain"], ["QAHSOS1HNV1", "oscsub"], ["QID04005", "resetb"], ["KX4_FLASHCLK_DLY", "flashclk_dly"], ["KX4_RAMCLK_DLY", "ramclk_dly"], ["QLK0RRAMIF04KV1", "ramif"], ["QNSA3N064K0V2", "flash_code"], ["QNSB3N004K0V2", "flash_data"], ["QNSC3NCP1V2", "flash_cp"], ["QNSC3NREG1V2", "flash_reg"], ["QNSC3NCPDC0V1", "flash_capa0"], ["QNSC3NCPDC0V1", "flash_capa1"], ["QNSC3NCPDC0V1", "flash_capa2"], ["QNSC3NCPDC0V1", "flash_capa3"], ["QNSC3NCPDC0V1", "flash_capa4"], ["QNSC3NCPDC0V1", "flash_capa5"], ["QNSC3NCPDC0V1", "flash_capa6"], ["QNSC3NCPDC0V1", "flash_capa7"], ["QNSC3NCPDC0V1", "flash_capa8"], ["QNSC3NCPDC0V1", "flash_capa9"], ["QNSC3NCPDC0V1", "flash_capa10"], ["QNSC3NCPDC0V1", "flash_capa11"], ["QNSC3NCPDC0V1", "flash_capa12"], ["QNSC3NCPDC0V1", "flash_capa13"], ["QNSC3NCPDC0V1", "flash_capa14"], ["OWSRAM130W2048B18C4B9", "ram0"], ["KX4_BUSBRIDGE", "bbr"], ["KX4_PORGA", "porga"], ["KX4_INTOR", "intor"], ["KX4_CKDIST", "ckdist"], ["KX4_MONSIG", "monsig"], ["QLK0RINTM4V1", "intm4"], ["QLK0RINTM8V1", "intm8"], ["KX4_IICASCLDLY", "sdadly0"], ["KX4_IICASDADLY", "sdadly1"], ["KX4_SDADLY", "sdadly2"], ["KX4_SDADLY", "sdadly3"], ["KX4_SDADLY", "sdadly011"], ["KX4_SDADLY", "sdadly013"], ["KX4_SDADLY", "sdadly110"], ["KX4_SDADLY", "sdadly111"], ["QLK0RIICAV2", "iica"], ["QLK0RSAU04R2V1", "sau0"], ["QLK0RSAU02R2V1", "sau1"], ["QLK0RTAU08R2V1", "tau0"], ["KX4_PORT0V1", "port0"], ["KX4_PORT0_IOBUF", "port0_iobuf"], ["KX4_PORT1V1", "port1"], ["KX4_PORT1_IOBUF", "port1_iobuf"], ["KX4_PORT2V1", "port2"], ["KX4_PORT2_IOBUF", "port2_iobuf"], ["KX4_PORT3V1", "port3"], ["KX4_PORT3_IOBUF", "port3_iobuf"], ["KX4_PORT4V1", "port4"], ["KX4_PORT4_IOBUF", "port4_iobuf"], ["KX4_PORT5V1", "port5"], ["KX4_PORT5_IOBUF", "port5_iobuf"], ["KX4_PORT6V1", "port6"], ["KX4_PORT6_IOBUF", "port6_iobuf"], ["KX4_PORT7V1", "port7"], ["KX4_PORT7_IOBUF", "port7_iobuf"], ["KX4_PORT12V1", "port12"], ["KX4_PORT12_IOBUF", "port12_iobuf"], ["KX4_PORT13V1", "port13"], ["KX4_PORT13_IOBUF", "port13_iobuf"], ["KX4_PORT14V1", "port14"], ["KX4_PORT14_IOBUF", "port14_iobuf"], ["KX4_PIORV2", "pior"], ["QLK0RADAA32V1", "adctl"], ["QAHADA20HN0V1", "adhard"], ["QAHAD20SW16V1", "adsw16"], ["QAHAD20SWL1V1", "adswcap1"], ["QAHAD20SW17V1", "adsw17"], ["QAHAD20SW18V1", "adsw18"], ["QAHAD20SW19V1", "adsw19"], ["QICTRBG5A", "adcorner"], ["QIVG0005", "power"], ["DMYA", "dmya"], ["DMYA", "dmyb"], ["DMYA", "dmyc"], ["DMYA", "dmyd"], ["KX4_CAPCKGATE", "capckgate"], ["KX4_CAPMUX4", "capmux"], ["KX4_CAPLIO", "capl"], ["KX4_CAPRIO", "capr"], ["QICAP035H5H", "capadl"], ["QICAP025H5H", "capadr"], ["TBFILTER1X2", "dmydly50n"], ["QAHNFI4BN300NV1", "dmydly300n"], ["QAHRES0CV1", "vppts1_res"]]

    FMakeConf.new( 
                  :filename      => "test.conf",
                  :outdir        => "/home/product/div-micom-ice/data/proj/RL78/Common/.fice/",
                  :product_name  => "G13",
                  :product_ver   => "CF1.0",
                  :top_module    => "D78F1070",
                  :verilog_list  => "./tp/rl78.list",
                  :verilog_list_old => "./tp/rl78_old.list",
                  ).generate(inst_list)
    revised = Array.new
    golden = Array.new
    open("/home/product/div-micom-ice/data/proj/RL78/Common/.fice/test.conf").each do |line|
      next if line.size <= 1
      next if /#/ =~ line 
      next if /VER=/ =~ line
      revised << line
    end
    open("./tp/FMakeConf_golden.conf").each do |line|
      next if line.size <= 1
      next if /#/ =~ line 
      next if /VER=/ =~ line
      golden << line
    end
    
    for i in 0..(golden.size-1)
      assert_equal(golden[i],revised[i])
    end

#    assert_equal(golden,revised)
  end

  def test_analyze
=begin
    # File Error
    conf = FMakeConf.new( 
                         :conffile      => "tp/dummy.conf",
                         )
    conf.analyze
=end
    # Analyze Test
#    $VERBOSE = true
    conf = FMakeConf.new( 
                         :conffile      => "./tp/test.conf",
                         )

    conf_db = conf.analyze
    assert_equal("G13",conf_db.PRODUCT)
    assert_equal("CF1.0",conf_db.PRODUCT_VER)
    assert_equal("D78F1070",conf_db.TOP_MODULE)
    assert_equal("./tp/rl78.list",conf_db.VERILOG_LIST)
    assert_equal("./tp/rl78_old.list",conf_db.VERILOG_LIST_OLD)

    set_golden = {
      "ICE_MACRO_VER"=> "SS3rd_V1_1_2",
      "ICE_MACRO_PATH"=> "/home/product/div-micom-ice/data/proj/RL78/Common/ICEMacroSuite/ICEMacro/tags/SS3rd_V1_1_2",
      "REPLACE_MACRO_VER"=> "1.1.6",
      "REPLACE_MACRO_PATH"=> "/home/product/div-micom-ice/data/proj/RL78/Common/ReplaceMacro/tags/1.1.6"
    }

    assert_equal(set_golden,conf_db.SET)

    conf_db.INST.each do |each_inst|
#      p each_inst
    end

    assert_equal(417,conf_db.INST.size)


  end

end
