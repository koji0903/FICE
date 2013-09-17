require "common"
require "verilog_parse"
require 'XMLParse'

class Verilog

  class ModuleInf
    attr_accessor :ModuleName
    attr_accessor :Port
    attr_accessor :Terminal
    def initialize
      @ModuleName = nil
      @Port = PortList.new
      @Terminal = TerminalList.new
    end
  end

  class PortList
    attr_accessor :PortList
    def initialize
      @PortList = Array.new
    end
  end

  class TerminalList
    attr_accessor :Output
    attr_accessor :Input
    def initialize
      @Output = Array.new
      @Inout = Array.new
    end
  end

  def initialize
  end

  def analyze(file_name)
    @VerilogData = Common.file_read(file_name)
    # Collect all token
    tokens = []
    @VerilogData.each{|line|
      lexer = VerilogParse.new("#{line}")
      tokens += lexer.tokens
    }

    module_inf = ModuleInf.new
    # Get ModuleName
    module_inf.ModuleName = get_ModuleName(tokens)
    # Get Port List
    module_inf.Port = get_Port(tokens)

    return module_inf
  end

  def analyze_xml(xml,module_name)
    @root = XMLParse.read("#{xml}")
    port_list = XMLParse::get_PortList(@root,module_name)
    if port_list == { }
      printf("@E:Cannnot Found %s module\n",module_name)
      exit
    end
    module_inf = ModuleInf.new
    # Get ModuleName
    module_inf.ModuleName = module_name
    # Get Port List
    module_inf.Port = port_list.keys
    
    return module_inf
  end

  #
  # Get ModuleName
  # 
  def get_ModuleName(tokens)
    module_num = tokens.index("module")
    return tokens[module_num+1]
  end
  
  def get_Port(tokens)
    port_list = Array.new
    tokens[(tokens.index("(")+1)..(tokens.index(")")-1)].each{|data|
      port_list << data if data != ","
    }
    return port_list
  end
end
