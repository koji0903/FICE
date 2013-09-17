#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
require 'test/unit'
$:.unshift(File.dirname(__FILE__) + "/../../bin")
$:.unshift(File.dirname(__FILE__) + "/../../lib")
$:.unshift(File.dirname(__FILE__) + "/../../conf")
require 'FMake'
require 'FMakeLogic'
require 'FICE_DB'
require 'FMakeConf'

class Test_FMakeLogic < Test::Unit::TestCase
  def setup
    $TEST_MODE = true
    $VERBOSE = true
  end

  def test_main_for_AddMacro
    printf "\n@T:#{__method__}\n"
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")

    #--------------------
    # Conf File Setting
    #-------------------
    top_module = "test"
    # Conf File
    conf = FMakeConf.new( :conffile =>  "./tp/test_FMakeLogic_Add.conf" )
    conf_db = conf.analyze
    # Verilog File
    
    logic = FMakeLogic.new( :top_module => top_module ,:xml => "./tp/test_simple.xml", :conf => conf_db )
    @root = logic.main

#    XMLParse::save(@root,"mod.xml")
#    `XMLtoVerilog mod.xml > mod.v`
    
    XMLParse::change_ModuleName(@root,"test_EVA","test")
    add_inst = nil
    golden = XMLParse::get_InstanceList(@root_org,top_module)
    conf_db.INST.each do |key,value|
      if value.MacroType == "Add"
        golden = golden + [[value.ModuleName,key]]
        add_inst = key
      end
    end

    revised = XMLParse::get_InstanceList(@root,top_module)
    # Test for Instantiation 
    assert_equal(golden,revised)

    # Test for Base Connection 
    golden = { 
      "In_A1" => [FICE_DB::SignalInf.new( :name => "Port_add_macro_In_A1", :type => "wire", :msb => nil, :lsb => nil)],
      "In_A3" => [FICE_DB::SignalInf.new( :name => "1'b0", :type => "constant")],
      "In_A4" => [FICE_DB::SignalInf.new( :name => "11'b11111111111", :type => "constant")],
      "Out_B1" => [FICE_DB::SignalInf.new( :name => "Port_add_macro_Out_B1", :type => "wire", :msb => nil, :lsb => nil)],
      "Inout_C1" => [FICE_DB::SignalInf.new( :name => "Port_add_macro_Inout_C1", :type => "wire", :msb => nil, :lsb => nil)],
      "Inout_C2" => [FICE_DB::SignalInf.new( :name => "Port_add_macro_Inout_C2", :type => "wire", :msb => 3, :lsb => 0)],
      "In_A2" => [FICE_DB::SignalInf.new( :name => "wire001", :type => "wire", :msb => nil, :lsb => nil)],
      "Out_B4" => [FICE_DB::SignalInf.new( :name => nil, :type => "open")],
      "Out_B2" => [FICE_DB::SignalInf.new( :name => "FMakeWire_add_macro_Out_B2", :type => "wire", :msb => 3, :lsb => 0)],
      "Out_B3" => [FICE_DB::SignalInf.new( :name => "FMakeWire_add_macro_Out_B3", :type => "wire")],
    }
    generate_verilog(__method__)
    diff = connect_diff(@root,@root_org,"test",add_inst)
    assert_equal(golden,diff)

    # Test for Target Connection
    target_inst = "sub0"
    
    golden = { 
      "b" => [FICE_DB::SignalInf.new( :name => "FMakeWire_add_macro_Out_B2", :type => "wire", :msb => 3, :lsb => 0)],
      "aaa" => [FICE_DB::SignalInf.new( :name => "FMakeWire_add_macro_Out_B3", :type => "wire")],
    }
    
    diff = connect_diff(@root,@root_org,"test",target_inst)
    assert_equal(golden,diff)

    generate_verilog(__method__)
  end


  def test_main_for_ReplaceMacro
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")
   

    #--------------------
    # Conf File Setting
    #-------------------
    top_module = "test"
    # Conf File
    conf = FMakeConf.new( :conffile      => "./tp/test_FMakeLogic_Replace.conf")

    conf_db = conf.analyze
    # Verilog File
    
    logic = FMakeLogic.new( :top_module => top_module ,:xml => "./tp/test_simple.xml", :conf => conf_db )
    @root = logic.main

    XMLParse::change_ModuleName(@root,"test_EVA","test")
    #-------------------
    # Instance Test
    #-------------------
    replace_module_name = nil
    conf_db.INST.each do |inst_list|
      case inst_list[1].MacroType
      when "Replace"
        replace_module_name = inst_list[1].ReplaceModuleName
      end
    end
  
    golden = XMLParse::get_InstanceList(@root_org,top_module)
    golden.each do |inst_list|
      if inst_list[0] == "SubMod"
        inst_list[0] = replace_module_name
      end
    end
    revised = XMLParse::get_InstanceList(@root,top_module)

    assert_equal(golden,revised)

    #-------------------------
    # Connect Information Test
    #-------------------------
    # Replace > Original
    golden = { 
      "add_in_port" => [FICE_DB::SignalInf.new( :name => "SEL_w", :type => "wire", :msb => nil, :lsb => nil)],
      "a" => [FICE_DB::SignalInf.new( :name => "SEL_w", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root,@root_org,"test","sub0")
    assert_equal(golden,diff)
    # Original > Replace
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "1'b1", :type => "constant", :msb => nil, :lsb => nil)],
      "b" => [FICE_DB::SignalInf.new( :name => "wire002", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root_org,@root,"test","sub0")
    assert_equal(golden,diff)

    generate_verilog(__method__)

  end


  def test_main_for_KeepChange
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")
   

    #--------------------
    # Conf File Setting
    #-------------------
    top_module = "test"
    # Conf File
    conf = FMakeConf.new( :conffile      => "./tp/test_FMakeLogic_KeepChange.conf")
    conf_db = conf.analyze

    # Verilog File
    
    logic = FMakeLogic.new( :top_module => top_module ,:xml => "./tp/test_simple.xml", :conf => conf_db )
    @root = logic.main

#    XMLParse::save(@root,"mod.xml")
#    `XMLtoVerilog mod.xml > mod.v`
    XMLParse::change_ModuleName(@root,"test_EVA","test")
    generate_verilog(__method__)

    #--------------------
    # For drive_change_a(DriveChangeA)
    #   OLD : a -> drive_change_b.a
    #   NEW : a -> drive_change_c.a
    #--------------------
    # OLD Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "drive_change_original", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root_org,@root,"test","drive_change_a")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "FMakeWire_drive_change_a_a", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root,@root_org,"test","drive_change_a")
    assert_equal(golden,diff)

    #--------------------
    # For drive_change_c(DriveChangeC)
    #   OLD : a -> drive_change_b.a, b -> OPEN
    #   NEW : a -> drive_change_c.a, b -> drive_change_b.a
    #--------------------
    # Old Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "1'b1", :type => "constant", :msb => nil, :lsb => nil)],
      "b" => [FICE_DB::SignalInf.new( :name => nil, :type => "open", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root_org,@root,"test","drive_change_c")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "FMakeWire_drive_change_a_a", :type => "wire", :msb => nil, :lsb => nil)],
      "b" => [FICE_DB::SignalInf.new( :name => "FMakeWire_drive_change_c_b", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root,@root_org,"test","drive_change_c")
    assert_equal(golden,diff)

    #--------------------
    # For drive_change_b(DriveChangeb)
    #   OLD : a <- drive_change_a.a
    #   NEW : a <- drive_change_b.a
    #--------------------
    # Old Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "drive_change_original", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root_org,@root,"test","drive_change_b")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "FMakeWire_drive_change_c_b", :type => "wire", :msb => nil, :lsb => nil)],
      
    }
    diff = connect_diff(@root,@root_org,"test","drive_change_b")
    assert_equal(golden,diff)

  end
  

  def test_main_for_MultiHier
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")
    

    #--------------------
    # Conf File Setting
    #-------------------
    top_module = "test"
    # Conf File
    conf = FMakeConf.new( :conffile      => "./tp/test_FMakeLogic_MultiHier.conf")

    conf_db = conf.analyze
    # Verilog File
    
    logic = FMakeLogic.new( :top_module => top_module ,:xml => "./tp/test_simple.xml", :conf => conf_db )
    @root = logic.main


#    XMLParse::save(@root,"mod.xml")
#    `XMLtoVerilog mod.xml > mod.v`

    #--------------------
    # For drive_change_a(DriveChangeA)
    #   OLD : a -> drive_change_b.a
    #   NEW : a -> drive_change_c.a
    #--------------------
    # OLD Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "drive_change_original", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root_org,@root,"SubMod","drive_change_a1")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "FMakeWire_drive_change_a1_a", :type => "wire", :msb => nil, :lsb => nil)],
#      "a" => [FICE_DB::SignalInf.new( :name => "a", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root,@root_org,"SubMod","drive_change_a1")
    assert_equal(golden,diff)

    #--------------------
    # For drive_change_c(DriveChangeC)
    #   OLD : a -> 1'b1, b -> OPEN
    #   NEW : a -> drive_change_a1.a, b -> drive_change_b.a
    #--------------------
    # Old Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "1'b1", :type => "constant", :msb => nil, :lsb => nil)],
      "b" => [FICE_DB::SignalInf.new( :name => nil, :type => "open", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root_org,@root,"SubMod","drive_change_c1")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "FMakeWire_drive_change_a1_a", :type => "wire", :msb => nil, :lsb => nil)],
#      "a" => [FICE_DB::SignalInf.new( :name => "a", :type => "wire", :msb => nil, :lsb => nil)],
      "b" => [FICE_DB::SignalInf.new( :name => "FMakeWire_drive_change_c1_b", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root,@root_org,"SubMod","drive_change_c1")
    assert_equal(golden,diff)

    #--------------------
    # For drive_change_b(DriveChangeb)
    #   OLD : a <- drive_change_a.a
    #   NEW : a <- drive_change_b.a
    #--------------------
    # Old Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "drive_change_original", :type => "wire", :msb => nil, :lsb => nil)],      
    }
    diff = connect_diff(@root_org,@root,"SubMod","drive_change_b1")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "FMakeWire_drive_change_c1_b", :type => "wire", :msb => nil, :lsb => nil)],      
    }
    diff = connect_diff(@root,@root_org,"SubMod","drive_change_b1")
    assert_equal(golden,diff)

    #--------------------
    # For sub0.add_macro(ADD_MODULE)
    #--------------------
    golden = { 
      "In_A1" => [FICE_DB::SignalInf.new( :name => "1'b0", :type => "constant")],
      "In_A2" => [FICE_DB::SignalInf.new( :name => "1'b0", :type => "constant")],
      "In_A3" => [FICE_DB::SignalInf.new( :name => "1'b0", :type => "constant")],
      "In_A4" => [FICE_DB::SignalInf.new( :name => "11'b11111111111", :type => "constant")],
      "Out_B1" => [FICE_DB::SignalInf.new( :type => "open")],
      "Out_B2" => [FICE_DB::SignalInf.new( :type => "open")],
      "Out_B3" => [FICE_DB::SignalInf.new( :type => "open")],
      "Out_B4" => [FICE_DB::SignalInf.new( :type => "open")],
      "Inout_C1" => [FICE_DB::SignalInf.new( :type => "open")],
      "Inout_C2" => [FICE_DB::SignalInf.new( :type => "open")]
    }
    diff = connect_diff(@root,@root_org,"SubMod","add_macro")
    golden
    assert_equal(golden,diff)

    generate_verilog(__method__)
 end
  

  def test_main_for_CrossHier
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")
    

    #--------------------
    # Conf File Setting
    #-------------------
    top_module = "test"
    # Conf File
    conf = FMakeConf.new( :conffile      => "./tp/test_FMakeLogic_CrossHier.conf")

    conf_db = conf.analyze
    # Verilog File
    
    logic = FMakeLogic.new( :top_module => top_module ,:xml => "./tp/test_simple.xml", :conf => conf_db )
    @root = logic.main
    XMLParse::change_ModuleName(@root,"test_EVA","test")

#    XMLParse::save(@root,"mod.xml")
#    `XMLtoVerilog mod.xml > mod.v`
    generate_verilog(__method__)

    #--------------------
    # For drive_change_a(DriveChangeA)
    #   OLD : a -> drive_change_b.a
    #   NEW : a -> sub0.FMakeWire_dirve_change_a_a ( connect lower hierarchy )
    #--------------------
    # OLD Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "drive_change_original", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root_org,@root,"test","drive_change_a")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "FMakeWire_drive_change_a_a", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root,@root_org,"test","drive_change_a")
    assert_equal(golden,diff)


    #--------------------
    # For sub0(SubMod)
    #   NEW(Add) :  FMakeWire_drive_change_a_a <-   drive_change_a.FMakeWire_dirve_change_a_a ( connect lower hierarchy )
    #--------------------

    # Teminal Check
    golden = ["FMakeWire_drive_change_c1_b", "FMakeWire_drive_change_a_a"]
    revised =  XMLParse::get_TerminalList(@root,"SubMod") - XMLParse::get_TerminalList(@root_org,"SubMod")
    assert_equal(golden,revised)

    # Port Check
    golden = ["FMakeWire_drive_change_a_a", "FMakeWire_drive_change_c1_b"]
    revised =  XMLParse::get_PortList(@root,"SubMod").keys - XMLParse::get_PortList(@root_org,"SubMod").keys
    assert_equal(golden,revised)

    # Wire Check
    golden = ["FMakeWire_drive_change_a_a", "FMakeWire_drive_change_c1_b"]
    revised =  XMLParse::get_WireList(@root,"SubMod").keys - XMLParse::get_WireList(@root_org,"SubMod").keys
    assert_equal(golden,revised)

    # OLD Connection
    golden = { 
      # Nothing
    }
    diff = connect_diff(@root_org,@root,"test","sub0")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      "FMakeWire_drive_change_c1_b" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub0_drive_change_c1_b", :type => "wire", :msb => nil, :lsb => nil)],      
      "FMakeWire_drive_change_a_a" => [FICE_DB::SignalInf.new( :name => "FMakeWire_drive_change_a_a", :type => "wire", :msb => nil, :lsb => nil)],      
    }
    diff = connect_diff(@root,@root_org,"test","sub0")
    assert_equal(golden,diff)



    #--------------------
    # For drive_change_c(DriveChangeC)
    #   OLD : a -> drive_change_b.a, b -> OPEN
    #   NEW : a -> drive_change_c.a, b -> drive_change_b.a
    #--------------------
    # Old Connection
    golden = { 
      # Nothing
    }
    diff = connect_diff(@root_org,@root,"test","drive_change_c")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      # Nothing
    }
    diff = connect_diff(@root,@root_org,"test","drive_change_c")
    assert_equal(golden,diff)


    #--------------------
    # For drive_change_b(DriveChangeb)
    #   OLD : a <- drive_change_a.a
    #   NEW : a <- drive_change_b.a
    #--------------------
    # Old Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "drive_change_original", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root_org,@root,"test","drive_change_b")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub0_drive_change_c1_b", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root,@root_org,"test","drive_change_b")
    assert_equal(golden,diff)

    #--------------------
    # For sub0.drive_change_c1(DriveChangeC)
    #   OLD : a <- 1'b1, b -> OPEN
    #   NEW : a <- Term(FMakeWire_drive_change_a_a)
    #--------------------
    # Old Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "1'b1", :type => "constant", :msb => nil, :lsb => nil)],      
      "b" => [FICE_DB::SignalInf.new( :name => nil, :type => "open", :msb => nil, :lsb => nil)],      
    }
    diff = connect_diff(@root_org,@root,"SubMod","drive_change_c1")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "FMakeWire_drive_change_a_a", :type => "wire", :msb => nil, :lsb => nil)],      
      "b" => [FICE_DB::SignalInf.new( :name => "FMakeWire_drive_change_c1_b", :type => "wire", :msb => nil, :lsb => nil)],      
    }
    diff = connect_diff(@root,@root_org,"SubMod","drive_change_c1")
    assert_equal(golden,diff)

    #--------------------
    # For sub0.drive_change_c2(DriveChangeC)
    #   Nothing difference
    #--------------------
    # Old Connection
    golden = { 
      # nothing
    }
    diff = connect_diff(@root_org,@root,"SubMod","drive_change_c2")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      # nothing
    }
    diff = connect_diff(@root,@root_org,"SubMod","drive_change_c2")
    assert_equal(golden,diff)


  end


  def test_main_for_CrossHierTerminal
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")
    

    #--------------------
    # Conf File Setting
    #-------------------
    top_module = "test"
    # Conf File
    conf = FMakeConf.new( :conffile      => "./tp/test_FMakeLogic_CrossHier_Term.conf")

    conf_db = conf.analyze
    # Verilog File
    
    logic = FMakeLogic.new( :top_module => top_module ,:xml => "./tp/test_simple.xml", :conf => conf_db )
    @root = logic.main
    XMLParse::change_ModuleName(@root,"test_EVA","test")

    # Test for Top Terminal
    golden = ["Port_sub0_drive_change_c1_a","Port_sub0_drive_change_c1_b"]
    signal = {
      "Port_sub0_drive_change_c1_a" => FICE_DB::SignalInf.new( :name => "Port_sub0_drive_change_c1_a" , :type => "input"),
      "Port_sub0_drive_change_c1_b" => FICE_DB::SignalInf.new( :name => "Port_sub0_drive_change_c1_b" , :type => "output"),
    }
    mod_list = [
                "test",
                "SubMod",
               ]
    mod_list.each do |module_name|
      revised = XMLParse::get_TerminalList(@root,module_name) - XMLParse::get_TerminalList(@root_org,module_name)
      assert_equal(golden,revised)
      revised.each do |term|
        assert_equal(signal[term],XMLParse::get_PortList(@root,module_name)[term])
      end
    end

    # Tesr for Port
    golden = ["Port_sub0_drive_change_c1_b", "Port_sub0_drive_change_c1_a"]
    revised =  XMLParse::get_PortList(@root,"test").keys - XMLParse::get_PortList(@root_org,"test").keys
    assert_equal(golden,revised)

    # Wire Check
    golden = ["Port_sub0_drive_change_c1_b", "Port_sub0_drive_change_c1_a"]
    revised =  XMLParse::get_WireList(@root,"test").keys - XMLParse::get_WireList(@root_org,"test").keys
    assert_equal(golden,revised)

    # Test for Connection

    #--------------------
    # For sub0.drive_change_c1(DriveChangeC)
    #   OLD : a <- 1'b1
    #   NEW : a <- Term(Port_sub0_drive_change_c1_a)
    #--------------------
    # Old Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "1'b1", :type => "constant", :msb => nil, :lsb => nil)],      
      "b" => [FICE_DB::SignalInf.new( :name => nil, :type => "open", :msb => nil, :lsb => nil)],      
    }
    diff = connect_diff(@root_org,@root,"SubMod","drive_change_c1")
    assert_equal(golden,diff)
    # New Connection
    golden = { 
      "a" => [FICE_DB::SignalInf.new( :name => "Port_sub0_drive_change_c1_a", :type => "wire", :msb => nil, :lsb => nil)],      
      "b" => [FICE_DB::SignalInf.new( :name => "Port_sub0_drive_change_c1_b", :type => "wire", :msb => nil, :lsb => nil)],      
    }
    diff = connect_diff(@root,@root_org,"SubMod","drive_change_c1")
    assert_equal(golden,diff)

    #--------------------
    # For sub0(SubMod)
    #   NEW : Term(Port_sub0_drive_change_c1_a)
    #--------------------
    # Old Connection
    golden = { 
    }
    diff = connect_diff(@root_org,@root,"test","sub0")
    assert_equal(golden,diff)

    # New Connection
    golden = { 
      "Port_sub0_drive_change_c1_a" => [FICE_DB::SignalInf.new( :name => "Port_sub0_drive_change_c1_a", :type => "wire", :msb => nil, :lsb => nil)],      
      "Port_sub0_drive_change_c1_b" => [FICE_DB::SignalInf.new( :name => "Port_sub0_drive_change_c1_b", :type => "wire", :msb => nil, :lsb => nil)],      
    }
    diff = connect_diff(@root,@root_org,"test","sub0")
    assert_equal(golden,diff)
 
    # Tesr for Port
    golden = ["Port_sub0_drive_change_c1_b", "Port_sub0_drive_change_c1_a"]
    revised =  XMLParse::get_PortList(@root,"SubMod").keys - XMLParse::get_PortList(@root_org,"SubMod").keys
    assert_equal(golden,revised)

    # Wire Check
    golden = ["Port_sub0_drive_change_c1_b", "Port_sub0_drive_change_c1_a"]
    revised =  XMLParse::get_WireList(@root,"SubMod").keys - XMLParse::get_WireList(@root_org,"SubMod").keys
    assert_equal(golden,revised)

    generate_verilog(__method__)
 end


  def test_main_for_Remove
    @root_org = XMLParse.read("./tp/test_simple.xml")
    @root = XMLParse.read("./tp/test_simple.xml")
    

    #--------------------
    # Conf File Setting
    #-------------------
    top_module = "test"
    # Conf File
    conf = FMakeConf.new( :conffile      => "./tp/test_FMakeLogic_Remove.conf")

    conf_db = conf.analyze
    # Verilog File
    
    outdir = "/home/product/div-micom-ice/data/proj/RL78/Common/.fice"
    logic = FMakeLogic.new( :top_module => top_module ,
                            :xml => "./tp/test_simple.xml", 
                            :conf => conf_db,
                            :outdir => outdir
                            )
    @root = logic.main
    XMLParse::change_ModuleName(@root,"test_EVA","test")
 
    golden_file = "./tp/SubMod_TMP.v_golden"
    golden = Common.file_read(golden_file)
    19.times do golden.shift end # delete comment

    revised_file = outdir + "/RemoveMacro_TMP/SubMod_TMP.v"
    revised = Common.file_read(revised_file)
    36.times do revised.shift end # delete comment
    
#    p revised
    assert_equal(golden,revised)
   
    
    golden = ["SubMod"]
    revised =  XMLParse::get_ModuleList(@root_org) - XMLParse::get_ModuleList(@root)
   
    assert_equal(golden,revised)

    generate_verilog(__method__)
  end

  def test_ModulePortConnection
    @root_org = XMLParse.read("./tp/test002.xml")
    @root = XMLParse.read("./tp/test002.xml")

    #--------------------
    # Conf File Setting
    #-------------------
    top_module = "test"
    # Conf File
    conf = FMakeConf.new( :conffile      => "./tp/test002.conf")

    conf_db = conf.analyze

    top_module = "TOP"
    outdir = "/home/product/div-micom-ice/data/proj/RL78/Common/.fice"
    logic = FMakeLogic.new( :top_module => top_module ,
                            :xml => "./tp/test002.xml", 
                            :conf => conf_db,
                            :outdir => outdir
                            )

    golden = {
      "pulldown0.Out"=>[
                        [["pulldown0", "Out", "pull_down000"], ["sub0", "In", "pull_down000"]]
                       ], 
      "pulldown1.Out"=>[
                        [["pulldown1", "Out", "pull_down001"], ["sub1", "In", "pull_down001"]]
                       ],
      "sub0.In"=>[
                  [["sub0", "In", "pull_down000"], ["pulldown0", "Out", "pull_down000"]]
                 ],
      "sub1.In"=>[
                  [["sub1", "In", "pull_down001"], ["pulldown1", "Out", "pull_down001"]]
                 ]
    }


#    revised = logic.analyze_ConnectPath
#    assert_equal(golden,revised)
=begin
    connect_list.each do |base,connect|
      p base
      connect.each do |each_connect|
        p each_connect
      end
    end
=end

  end

  def test_1695
    no = "1695"
    `VerilogToXML tp/#{no}.v > tp/#{no}.xml`
    @root_org = XMLParse.read("./tp/#{no}.xml")
    @root = XMLParse.read("./tp/#{no}.xml")


    #--------------------
    # Conf File Setting
    #-------------------
    top_module = "test"
    # Conf File
    conf = FMakeConf.new( :conffile      => "./tp/#{no}.conf")

    conf_db = conf.analyze

    top_module = "TOP"
#    outdir = "/home/product/div-micom-ice/data/proj/RL78/Common/.fice"
    outdir = "."
    logic = FMakeLogic.new( :top_module => top_module ,
                            :xml => "./tp/#{no}.xml", 
                            :conf => conf_db,
                            :outdir => outdir
                            )


    @root = logic.main
    XMLParse::save(@root,"mod.xml")
    `XMLtoVerilog mod.xml > tp/#{no}_FMake.v`
    FileUtils.rm("mod.xml")

#    logic.analyze_ConnectPath
    #--------------------
    # For out_mod(OutModule)
    #--------------------
    XMLParse::change_ModuleName(@root,"TOP_EVA","TOP")
    # Old Connection
    golden = { 
      "OutSignal" => [FICE_DB::SignalInf.new( :name => nil, :type => "open", :msb => nil, :lsb => nil)]
    }
    diff = connect_diff(@root_org,@root,"TOP","out_mod")
    assert_equal(golden,diff)

    # New Connection
    golden = { 
      "OutSignal" => [FICE_DB::SignalInf.new( :name => "FMakeWire_out_mod_OutSignal", :type => "wire", :msb => 2, :lsb => 0)],
    }
    diff = connect_diff(@root,@root_org,"TOP","out_mod")
    assert_equal(golden,diff)

    #--------------------
    # For sub0001(Sub001)
    #--------------------
    # Old Connection
    golden = { 
    }
    diff = connect_diff(@root_org,@root,"TOP","sub001")
    assert_equal(golden,diff)

    # New Connection
    golden = { 
      "OutSignal2" => [FICE_DB::SignalInf.new( :name => "OutSignal2", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_sub002_sub003_sub004_c" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub001_sub002_sub003_sub004_c", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_sub002_sub003_xxx" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub001_sub002_sub003_xxx", :type => "wire", :msb => 2, :lsb => 0)],
      "FMakeWire_sub002_sub003_UUU" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub001_sub002_sub003_UUU", :type => "wire", :msb => 2, :lsb => 0)],
      "FMakeWire_sub002_sub003_sub004_out_mod2_DIN5" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub001_sub002_sub003_sub004_out_mod2_DIN5", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_sub002_sub003_KKK" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub001_sub002_sub003_KKK", :type => "wire", :msb => 2, :lsb => 0)],
      "FMakeWire_sub002_sub003_sub004_add_1695_DOUT4" => [FICE_DB::SignalInf.new( :name => "FMakeWire_add_1695_sub002_sub003_sub004_add_1695_DOUT4", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_sub002_sub003_sub004_in_mod3_InSignal0" => [FICE_DB::SignalInf.new( :name => "FMakeWire_add_1695_sub002_sub003_sub004_add_1695_DOUT4", :type => "wire", :msb => nil, :lsb => nil)]
    }
#      "FMakeWire_sub002_sub003_sub004_out_mod2_DIN5" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub001_sub002_sub003_sub004_out_mod2_DIN5", :type => "wire", :msb => nil, :lsb => nil)],

    diff = connect_diff(@root,@root_org,"TOP","sub001")
#    diff.keys.each do |key|
#      p "------"
#      p key
#      p golden[key]
#      p diff[key]
#    end
#    exit
#    assert_equal(golden,diff)
 
    #--------------------
    # For sub0002(Sub002)
    #--------------------
    # Old Connection
    golden = { 
    }
    diff = connect_diff(@root_org,@root,"Sub001","sub002")
    assert_equal(golden,diff)

    # New Connection
    golden = { 
      "FMakeWire_sub003_sub004_c" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub002_sub003_sub004_c", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_sub003_xxx" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub002_sub003_xxx", :type => "wire", :msb => 2, :lsb => 0)],
      "FMakeWire_sub003_UUU" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub002_sub003_UUU", :type => "wire", :msb => 2, :lsb => 0)],
      "FMakeWire_sub003_sub004_out_mod2_DIN5" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub002_sub003_sub004_out_mod2_DIN5", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_sub003_KKK" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub002_sub003_KKK", :type => "wire", :msb => 2, :lsb => 0)],
      "FMakeWire_sub003_sub004_add_1695_DOUT4" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub002_sub003_sub004_add_1695_DOUT4", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_sub003_sub004_in_mod3_InSignal0" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub002_sub003_sub004_in_mod3_InSignal0", :type => "wire", :msb => nil, :lsb => nil)]
    }
    diff = connect_diff(@root,@root_org,"Sub001","sub002")
#    diff.keys.each do |key|
#      p "------"
#      p key
#      p golden[key]
#      p diff[key]
#    end
#    exit
#    assert_equal(golden,diff)

    #--------------------
    # For sub0003(Sub003)
    #--------------------
    # Old Connection
    golden = { 
    }
    diff = connect_diff(@root_org,@root,"Sub002","sub003")
    assert_equal(golden,diff)

    # New Connection
    golden = { 
      "FMakeWire_sub004_c" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub003_sub004_c", :type => "wire", :msb => nil, :lsb => nil)],
      "xxx" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub003_xxx", :type => "wire", :msb => 2, :lsb => 0)],
      "UUU" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub003_UUU", :type => "wire", :msb => 2, :lsb => 0)],
      "FMakeWire_sub004_out_mod2_DIN5" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub003_sub004_out_mod2_DIN5", :type => "wire", :msb => nil, :lsb => nil)],
      "KKK" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub003_KKK", :type => "wire", :msb => 2, :lsb => 0)],
      "FMakeWire_sub004_add_1695_DOUT4" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub003_sub004_add_1695_DOUT4", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_sub004_in_mod3_InSignal0" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub003_sub004_in_mod3_InSignal0", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root,@root_org,"Sub002","sub003")
#    assert_equal(golden,diff)

    #--------------------
    # For sub0004(Sub004)
    #--------------------
    # Old Connection
    golden = { 
    }
    diff = connect_diff(@root_org,@root,"Sub003","sub004")
#    assert_equal(golden,diff)

    # New Connection
    golden = { 
      "c" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub004_c", :type => "wire", :msb => nil, :lsb => nil)],
      "UUU" => [FICE_DB::SignalInf.new( :name => "UUU", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_out_mod2_DIN5" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub004_out_mod2_DIN5", :type => "wire", :msb => nil, :lsb => nil)],
      "KKK" => [FICE_DB::SignalInf.new( :name => "KKK", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_add_1695_DOUT4" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub004_add_1695_DOUT4", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_in_mod3_InSignal0" => [FICE_DB::SignalInf.new( :name => "FMakeWire_sub004_in_mod3_InSignal0", :type => "wire", :msb => nil, :lsb => nil)],
    }
    diff = connect_diff(@root,@root_org,"Sub003","sub004")
#    assert_equal(golden,diff)


    # Check for connection.report
    logic.analyze_ConnectPath    
    golden = File.read("connection.report")
    revised = File.read("tp/connection.report_1695")
    assert_equal(golden,revised)
    FileUtils.rm("connection.report")
#    system(`rm -rf result`)
  end

  def test_1767
#    sleep(20)
    no = "1767"
    `VerilogToXML tp/#{no}.v > tp/#{no}.xml`
    @root_org = XMLParse.read("./tp/#{no}.xml")
    @root = XMLParse.read("./tp/#{no}.xml")

    #--------------------
    # Conf File Setting
    #-------------------
    # Conf File
    conf = FMakeConf.new( :conffile      => "./tp/#{no}.conf")

    conf_db = conf.analyze
    $TOP_MODULE = "TOP"
    top_module = "TOP"
#    outdir = "/home/product/div-micom-ice/data/proj/RL78/Common/.fice"
    outdir = "."
    logic = FMakeLogic.new( :top_module => top_module ,
                            :xml => "./tp/#{no}.xml", 
                            :conf => conf_db,
                            :outdir => outdir
                            )


    @root = logic.main
    XMLParse::save(@root,"mod.xml")
    `XMLtoVerilog mod.xml > tp/#{no}_FMake.v`
    FileUtils.rm("mod.xml")
    $TOP_MODULE = "TOP_EVA"
=begin
    #--------------------
    # For ice_top(ICE_TOP)
    #--------------------
    # Old Connection
    golden = { 
      "clk_out" => [FICE_DB::SignalInf.new( :name => nil, :type => "open", :msb => nil, :lsb => nil)],
      "connect_bus_1718_0" => [FICE_DB::SignalInf.new( :name => "connect_bus_1718", :type => "wire", :msb => nil, :lsb => nil, :portion => 0)],
      "connect_bus_1718_1" => [FICE_DB::SignalInf.new( :name => "connect_bus_1718", :type => "wire", :msb => nil, :lsb => nil, :portion => 1)]
    }
    diff = connect_diff(@root_org,@root,"TOP","ice_top")
    assert_equal(golden,diff)

    # New Connection
    golden = { 
      "connect_bus_1718_0" => [FICE_DB::SignalInf.new( :name => "FMakeWire_cspf_wrapper_cspf_mc200_BUS0", :type => "wire", :msb => nil, :lsb => nil)],
      "connect_bus_1718_1" => [FICE_DB::SignalInf.new( :name => "FMakeWire_cspf_wrapper_cspf_mc200_BUS1", :type => "wire", :msb => nil, :lsb => nil)],
      "clk_out" => [FICE_DB::SignalInf.new( :name => "FMakeWire_ice_top_clk_out", :type => "wire", :msb => nil, :lsb => nil)]
    }
    diff = connect_diff(@root,@root_org,"TOP","ice_top")
    assert_equal(golden,diff)

    #--------------------
    # For cspf(CSPF)
    #--------------------
    # Old Connection
    golden = { 
    }
    diff = connect_diff(@root_org,@root,"TOP","cspf")
    assert_equal(golden,diff)

    # New Connection
    golden = { 
      "rst" => [FICE_DB::SignalInf.new( :name => "rst", :type => "wire", :msb => nil, :lsb => nil)],
      "cspf_Q3" => [FICE_DB::SignalInf.new( :name => "cspf_Q3", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_mc200_BUS1" => [FICE_DB::SignalInf.new( :name => "FMakeWire_cspf_mc200_BUS1", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_mc200_BUS0" => [FICE_DB::SignalInf.new( :name => "FMakeWire_cspf_mc200_BUS0", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_mc200_add_ff2_clk" => [FICE_DB::SignalInf.new( :name => "FMakeWire_cspf_mc200_add_ff2_clk", :type => "wire", :msb => nil, :lsb => nil)]
    }
    diff = connect_diff(@root,@root_org,"CSPF_wrapper","cspf")
    assert_equal(golden,diff)

    #--------------------
    # For cspf.mc200(MD200)
    #--------------------
    # Old Connection
    golden = { 
      "CON_BUS1" => [FICE_DB::SignalInf.new( :name => "connect_bus_1718", :type => "wire", :msb => nil, :lsb => nil, :portion => 1)],
      "CON_BUS0" => [FICE_DB::SignalInf.new( :name => "connect_bus_1718", :type => "wire", :msb => nil, :lsb => nil, :portion => 0)]
    }
    diff = connect_diff(@root_org,@root,"CSPF","mc200")
    assert_equal(golden,diff)

    # New Connection
    golden = { 
      "rst" => [FICE_DB::SignalInf.new( :name => "rst", :type => "wire", :msb => nil, :lsb => nil)],
      "cspf_Q3" => [FICE_DB::SignalInf.new( :name => "cspf_Q3", :type => "wire", :msb => nil, :lsb => nil)],
      "CON_BUS1" => [FICE_DB::SignalInf.new( :name => "FMakeWire_mc200_BUS1", :type => "wire", :msb => nil, :lsb => nil)],
      "CON_BUS0" => [FICE_DB::SignalInf.new( :name => "FMakeWire_mc200_BUS0", :type => "wire", :msb => nil, :lsb => nil)],
      "FMakeWire_add_ff2_clk" => [FICE_DB::SignalInf.new( :name => "FMakeWire_mc200_add_ff2_clk", :type => "wire", :msb => nil, :lsb => nil)]
    }
    diff = connect_diff(@root,@root_org,"CSPF","mc200")
    assert_equal(golden,diff)

    #--------------------
    # For add_ff(add_ff)
    #--------------------
    # Old Connection
    golden = { 
    }
    diff = connect_diff(@root_org,@root,"MC200","add_ff2")
    assert_equal(golden,diff)

    # New Connection
    golden = { 
      "OUT_OPEN" => [FICE_DB::SignalInf.new( :name => nil, :type => "open", :msb => nil, :lsb => nil)],
      "NoConnectInPin" => [FICE_DB::SignalInf.new( :name => nil, :type => "open", :msb => nil, :lsb => nil)],
      "rst" => [FICE_DB::SignalInf.new( :name => "rst", :type => "wire", :msb => nil, :lsb => nil)],
      "D" => [FICE_DB::SignalInf.new( :name => "D", :type => "wire", :msb => nil, :lsb => nil)],
      "Q3" => [FICE_DB::SignalInf.new( :name => "cspf_Q3", :type => "wire", :msb => nil, :lsb => nil)],
      "FixedPin_Single" => [FICE_DB::SignalInf.new( :name => "1'b0", :type => "constant", :msb => nil, :lsb => nil)],
      "FixedPin_Bus" => [FICE_DB::SignalInf.new( :name => "3'b111", :type => "constant", :msb => nil, :lsb => nil)],
      "clk" => [FICE_DB::SignalInf.new( :name => "FMakeWire_add_ff2_clk", :type => "wire", :msb => nil, :lsb => nil)]
    }
    diff = connect_diff(@root,@root_org,"MC200","add_ff2")
    assert_equal(golden,diff)
=end
    # Check for connection.report
    logic.TOP_MODULE = "TOP_EVA"
    logic.analyze_ConnectPath    
    golden = File.read("connection.report")
    revised = File.read("tp/connection.report_1767")
    assert_equal(golden,revised)
    FileUtils.rm("connection.report")
#    system(`rm -rf result`)
  end



  def test_RESB
#    sleep(20)
    no = "RESB"
    `VerilogToXML tp/#{no}.v > tp/#{no}.xml`
    @root_org = XMLParse.read("./tp/#{no}.xml")
    @root = XMLParse.read("./tp/#{no}.xml")

    #--------------------
    # Conf File Setting
    #-------------------
    # Conf File
    conf = FMakeConf.new( :conffile      => "./tp/#{no}.conf")

    conf_db = conf.analyze
    $TOP_MODULE = "TOP"
    top_module = "TOP"
#    outdir = "/home/product/div-micom-ice/data/proj/RL78/Common/.fice"
    outdir = "."
    logic = FMakeLogic.new( :top_module => top_module ,
                            :xml => "./tp/#{no}.xml", 
                            :conf => conf_db,
                            :outdir => outdir
                            )


    @root = logic.main
    XMLParse::save(@root,"mod.xml")
    `XMLtoVerilog mod.xml > tp/#{no}_FMake.v`
    FileUtils.rm("mod.xml")
    $TOP_MODULE = "TOP_EVA"
    # Check for connection.report
    logic.TOP_MODULE = "TOP_EVA"
    logic.analyze_ConnectPath    
    golden = File.read("connection.report")
    revised = File.read("tp/connection.report_RESB")
    assert_equal(golden,revised)
    FileUtils.rm("connection.report")
    FileUtils.rm("tp/#{no}.xml")
  end


  def test_BUS
    no = "BUS"
    `VerilogToXML tp/#{no}.v > tp/#{no}.xml`
    @root_org = XMLParse.read("./tp/#{no}.xml")
    @root = XMLParse.read("./tp/#{no}.xml")

    #--------------------
    # Conf File Setting
    #-------------------
    # Conf File
    conf = FMakeConf.new( :conffile      => "./tp/#{no}.conf")

    conf_db = conf.analyze
    $TOP_MODULE = "TOP"
    top_module = "TOP"
#    outdir = "/home/product/div-micom-ice/data/proj/RL78/Common/.fice"
    outdir = "."
    logic = FMakeLogic.new( :top_module => top_module ,
                            :xml => "./tp/#{no}.xml", 
                            :conf => conf_db,
                            :outdir => outdir
                            )


    @root = logic.main
    XMLParse::save(@root,"mod.xml")
    `XMLtoVerilog mod.xml > tp/#{no}_FMake.v`
    FileUtils.rm("mod.xml")
    $TOP_MODULE = "TOP_EVA"
    # Check for connection.report
    logic.TOP_MODULE = "TOP_EVA"
    logic.analyze_ConnectPath    
    golden = File.read("connection.report")
    revised = File.read("tp/connection.report_#{no}")
    assert_equal(golden,revised)
    FileUtils.rm("connection.report")
    FileUtils.rm("tp/#{no}.xml")
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

  def generate_verilog(method)
    xml = method.to_s + ".xml"
    verilog = "./tp/" + method.to_s + ".v"
    printf("@I:generate Verilog-HDL(%s)\n",verilog)
    XMLParse::save(@root,xml)
    result = `#{FICE_DB::XML2V} #{xml} > #{verilog}`
    File.delete(xml)
  end

end

