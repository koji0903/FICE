#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
require 'test/unit'
$:.unshift(File.dirname(__FILE__) + "/../../bin")
$:.unshift(File.dirname(__FILE__) + "/../../lib")
$:.unshift(File.dirname(__FILE__) + "/../../conf")
require 'FMakeConnect'


class Test_FMakeConnect < Test::Unit::TestCase

  def setup
  end


  def test_analyze
    
    file_type = "MOD_CON"
    module_name = "TestModule"
    inst_name = "TestInst"
    test_connect_file = "./tp/test.mod_con"
    
    
    connect = FMakeConnect.new(
                               :file_type => file_type,
                               :con_file => test_connect_file,
                               :module_name => module_name,
                               :inst_name => inst_name
                               )
    con_db = connect.analyze
    assert_equal(file_type,con_db.FILE_TYPE)
    assert_equal(test_connect_file,con_db.CONNECT_FILE)
    assert_equal(module_name,con_db.MODULE_NAME)
    assert_equal(inst_name,con_db.INST_NAME)

    golden = [
              ["Port_OtherConnect", "CONNECT", nil, "MA", "PA", nil, nil],
              ["Port_OtherConnect2", "CONNECT", nil, "SOCKET.MA", "PA", nil, nil],
              ["Port_Pulldown", "PULLDOWN", nil, nil, nil, nil, nil],
              ["Port_PulllUP", "PULLUP", nil, nil, nil, nil, nil],
              ["Port_Open", "OPEN", nil, nil, nil, nil, nil],
              ["Port_DriveChange", "DRIVE_CHANGE", nil, "MB", "PortChange", "ME", "MBPortChange"],
              ["Port_DriveChange2", "DRIVE_CHANGE", nil, "SOCKET.MB", "PortChange", "SOCKET.ME", "MBPortChange"],
              ["Port_TerminalWithName", "TERMINAL", "TerA", nil, nil, nil, nil],
              ["Port_TerminalWithoutName", "TERMINAL", "Port_TestInst_Port_TerminalWithoutName", nil, nil, nil, nil]
              ]
    
    revised = Array.new
    con_db.PIN_INF.each do |key,value|
      revised << value.get_data.unshift(key)
    end
    assert_equal(golden,revised)
  end

end
