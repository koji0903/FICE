#!/usr/bin/ruby
#############################################################
#
# gMem
#  
# Authors::   Koji HIJIKURO<koji.hijikuro.rj@rms.renesas.com>
# Copyright:: Copyright (c) 2009,2010 Renesas Micro System. All rights reserved.
#
#############################################################
#
# [Function]
# - Generate memory using CoreGenerator equivalent Device memory on function.
#
# [Usage]
# -%ruby gMem.rb [MemoryMacroName] [OPTION]
# If you want to get more information. plese use "-h" option.
#
# [EXAMPLE]
# -%ruby gMem.rb OWSRAM107W128B39C3
#
# [Output]
# -coregen/MemData
#
# [History]
# -history
#
#############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"
require "memory"
require "coregen"
require "coregen_test"
#
# Global Setting
#
$TOOL            = "FICE"
$SUB_TOOL        = "gMem" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$MESSAGE         = false



#
# Main Class
#
class GMem
  
  def initialize
    # Memory name to generate from Option
    @MEM_NAME = nil

    # TestMode Flag
    @TEST = false

    #
    @WORK = "mem"

    # MDEF
    @MDEF = Array.new

    # Memory DataBase refferd "conf/memory.mdef"
    @MemDB = Hash.new

    @matched_memory = nil
    @depth = 0
    @data_width = 0
    @addr_width = 0
    @BitWriteFlag = false
    @ByteWriteFlag = false
    @InvalidBitWrite = false
    @InvalidByteWrite = false
  end

  #
  # Print Base Information( Tool name, Version, Copyright )
  #
  private
  def print_base
    printf("%s(%s) ver:%s\n",$TOOL,$SUB_TOOL,$VERSION)
    printf("Copyright (c) 2009,2010 Renesas Micro System. All rights reserved.\n\n")
  end

  #
  # Print Tool Usage
  #
  private
  def print_usage
    printf("\n")
    printf("Usage :  %s.rb -hier hier.file\n",$SUB_TOOL)
    printf(" OPTION\n")
    printf("\t-h/-help           : print help message\n")
    printf("\t-v/-version        : print version\n")
    printf("\t-verbose           : execute on verbose mode\n")
    printf("\t-bit               : specify memory bit widht\n")
    printf("\t-word              : specify memory word size\n")
    printf("\t-invalid-bitwrite  : force change invalid bitwrite function\n")
    printf("\t-invalid-bytewrite : force change invalid bytewrite function\n")
    printf("    \n")
  end

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  private
  def get_argument
    size = ARGV.size
    size -= 1
    i = 0
    while i <= size
      case ARGV[i]
      when '-h','-help' then
        print_base
        print_usage
        exit
      when '-v','-version' then
        print_base
        printf("")
        exit
      when '-verbose' then
        $VERBOSE = true
      when '-bit' then
        @data_width = ARGV[i+1].to_i
        i += 1
      when '-word' then
        @depth = ARGV[i+1].to_i
        i += 1
      when '-test' then
        @TEST = true
      when '-invalid-bitwrite' then
        @InvalidBitWrite = true
      when '-invalid-bytewrite' then
        @InvalidByteWrite = true
      else
        if /^-/ =~ ARGV[i]
          printf("[E] %s option is not supported.\n",ARGV[i])
          print_usage
          exit
        else
          @MEM_NAME = ARGV[i]
        end
      end
      i += 1
    end 

    # Error Check
    if ( @data_width != 0 && @depth == 0 ) || ( @data_width == 0 && @depth != 0 )
      $ERROR_CNT += 1
      printf("@E:Both \"-bit\" and \"-word\" is defined same time\n")
      print_summary
      exit
    end
  end
  
  #
  # Read mdef(memory definition file from conf directory)
  #
  private
  def read_mdef
    mdef = File.dirname(__FILE__) + "/../conf/memory.mdef"
    @MDEF = Common.file_read(mdef)
    mem = MemoryDB.new
    @MDEF.each{|line|
      next if line == "" || line[0] == 35 # Skip escape and comment line
      info = line.split(":") 
      case info[0]
      when "M"
        mem = MemoryDB.new
        mem.MemoryName = info[1]
      when "EM"
        @MemDB["#{mem.MemoryName}"] = mem
      when "UnusedInput"
        mem.UnusedInput = info[1].split(",")
      when "UnusedOutput"
        mem.UnusedOutput = info[1].split(",")
      when "1" # Port 1
        mem.PortSize = 1 if mem.PortSize != 2
        case info[1]
        when "Clock" then mem.Port1.Clock = info[2]
        when "InputData" then mem.Port1.InputData = info[2]
        when "OutputData" then mem.Port1.OutputData = info[2]
        when "Address" then mem.Port1.Address = info[2]
        when "BitWriteEnable" then mem.Port1.BitWriteEnable = info[2]
        when "ByteWriteEnable" then mem.Port1.ByteWriteEnable = info[2]
        when "WriteEnable" then mem.Port1.WriteEnable = info[2]
        when "ChipEnable" then mem.Port1.ChipEnable = info[2]
        when "Type" then mem.Port1.Type = info[2]
        else
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__);exit
        end
      when "2" # Port 2
        mem.PortSize = 2
        case info[1]
        when "Clock" then mem.Port2.Clock = info[2]
        when "InputData" then mem.Port2.InputData = info[2]
        when "OutputData" then mem.Port2.OutputData = info[2]
        when "Address" then mem.Port2.Address = info[2]
        when "BitWriteEnable" then mem.Port2.BitWriteEnable = info[2]
        when "ByteWriteEnable" then mem.Port2.ByteWriteEnable = info[2]
        when "WriteEnable" then mem.Port2.WriteEnable = info[2]
        when "ChipEnable" then mem.Port2.ChipEnable = info[2]
        when "Type" then mem.Port2.Type = info[2]
        else
          printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
        end
      else
        printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__);exit
      end
    }
  end

  #
  # Determine Memory
  #
  private
  def determine_memory
    # Change memory name for matching DB
    modified_name = @MEM_NAME.sub(/W\d+/,"W\[word\]").sub(/B\d+/,"B[bit]")
    printf("@I:Searching %s in Memory DataBase ... ",@MEM_NAME)
    if @MemDB["#{modified_name}"] != nil
      printf("Done\n")
      @matched_memory = @MemDB["#{modified_name}"]
    else
      printf("\n")
      $ERROR_CNT += 1
      printf("@E:Not found in Memory DataBase\n")
      Common.print_summary
      exit
    end
  end
  
  #
  # Generate Verilog
  #
  private
  def generate_verilog
    
    data_width = 0
    addr_width = 0
    file_name = @WORK + "/" + @MEM_NAME + ".v" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = @MEM_NAME + " Verilog file" 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"\/\/")

    # get depth/width
    /[A-Z+]\d+W(\d+)B(\d+)C/ =~ @MEM_NAME
    if $1.to_i != 0
      depth = $1.to_i
      @depth = depth 
    else
      depth = @depth
    end
    while depth != 1 # calcurate depth number
      depth = depth/2
      addr_width += 1
      addr_width += depth % 2 if depth != 1
    end
    @addr_width = addr_width


    if $2.to_i != 0
      data_width = $2.to_i
      @data_width = data_width 
    end
    


    /[A-Z+]\d+W(\d+)B(\d+)C\d+B(\d+)/ =~ @MEM_NAME
    if $3 == "1" 
      @BitWriteFlag = true
      write_width = 1
    else $3 == "8" || $3 == "9"
      @ByteWriteFlag = true
      write_width = $3.to_i
    end

    # print information
    printf("@I:Generating Memory Information.\n")
    printf("   - Memory Name    : %s\n",@MEM_NAME)
    printf("   - Address Width  : %d\n",@addr_width)
    printf("   - Data Width     : %d\n",@data_width)
    printf("   - Memory Type    : %s\n",@matched_memory.Port1.Type)
    printf("   - BitWriteEnable : %s\n",@matched_memory.Port1.BitWriteEnable)
    printf("   - WriteMode : %s\n",@matched_memory.Port1.Type)
    Common.make_dir("#{@WORK}/coregen")
    run_coregen(@matched_memory,write_width)

    # Print Header
    f.printf("module %s(\n",@MEM_NAME)

    #
    # Print module 
    #
    if @matched_memory.PortSize != 0
      module_generate_each_port(f,@matched_memory.Port1,@data_width,@addr_width,write_width)
    end
    if @matched_memory.PortSize == 2
      f.printf("\t,\n")
      module_generate_each_port(f,@matched_memory.Port2,@data_width,@addr_width,write_width)
    end
    # UnusedInput
    @matched_memory.UnusedInput.each{|sig|
      f.printf("\t,%s\n",sig)
    } if @matched_memory.UnusedInput != nil
    f.printf("\t);\n")

    #
    # Print signal
    #
    f.printf("\n")
    if @matched_memory.PortSize != 0
      signal_generate_each_port(f,@matched_memory.Port1,@data_width,@addr_width,write_width)
    end
    if @matched_memory.PortSize == 2
      signal_generate_each_port(f,@matched_memory.Port2,@data_width,@addr_width,write_width)
    end
    # UnusedInput
    @matched_memory.UnusedInput.each{|sig|
      f.printf("\tinput\t%s;\t// Unused Pin\n",sig)
    } if @matched_memory.UnusedInput != nil

    #
    # Print Wire
    #
    f.printf("\n")
    if @matched_memory.PortSize != 0
      wire_generate_each_port(f,@matched_memory.Port1,@data_width,@addr_width,write_width)
    end
    if @matched_memory.PortSize == 2
      wire_generate_each_port(f,@matched_memory.Port2,@data_width,@addr_width,write_width)
    end
    
    #
    # Print Instance of CoreGenerator Memory
    #
    inst_name = @MEM_NAME + "_cg"
    f.printf("\n")
    f.printf("\t// Instance of CoreGenerator Memory\n")

    #
    # Judgement WriteMode
    # 
    mode = "Normal" # Normal/BitWrite/ByteWrite
    if ( @BitWriteFlag == true && @matched_memory.Port1.Type == "BitWrite" )
      mode = "BitWrite"
    elsif ( @ByteWriteFlag == true && @matched_memory.Port1.Type == "ByteWrite" )
      mode = "ByteWrite"
    end
    if @InvalidBitWrite == true || @InvalidByteWrite == true
      mode = "Normal"
    end

    # print verilog
    case mode
    when "Normal"
      f.printf("\t%s %s(\n",inst_name,inst_name)
      if @matched_memory.PortSize != 0
        f.printf("\t\t.clka(%s),\n",@matched_memory.Port1.Clock);
        if @matched_memory.Port1.ChipEnable != nil
          f.printf("\t\t.ena(~%s),\n",@matched_memory.Port1.ChipEnable);
        else
          f.printf("\t\t.ena(1'b1),\n");
        end
        if @InvalidBitWrite == true 
          if @matched_memory.Port1.BitWriteEnable == nil
            f.printf("\t\t.wea(~%s0),\n",@matched_memory.Port1.WriteEnable);
          else
            f.printf("\t\t.wea(~%s && ~%s0),\n",@matched_memory.Port1.WriteEnable,@matched_memory.Port1.BitWriteEnable);
          end
        else
          f.printf("\t\t.wea(~%s),\n",@matched_memory.Port1.WriteEnable);
        end
        f.printf("\t\t.addra(%s),\n",@matched_memory.Port1.Address);
        f.printf("\t\t.dina(%s),\n",@matched_memory.Port1.InputData);
        f.printf("\t\t.douta(%s)\n",@matched_memory.Port1.OutputData);
      end
      if @matched_memory.PortSize == 2
        f.printf("\t\t,\n")
        f.printf("\t\t.clkb(%s),\n",@matched_memory.Port2.Clock);
        if @matched_memory.Port2.ChipEnable != nil
          f.printf("\t\t.enb(~%s),\n",@matched_memory.Port2.ChipEnable);
        else
          f.printf("\t\t.enb(1'b1),\n",@matched_memory.Port2.ChipEnable);
        end
        if @InvalidBitWrite == true
          if @matched_memory.Port2.BitWriteEnable == nil
            f.printf("\t\t.web(~%s0),\n",@matched_memory.Port2.WriteEnable);
          else
            f.printf("\t\t.web(~%s && ~%s0),\n",@matched_memory.Port2.WriteEnable,@matched_memory.Port2.BitWriteEnable);
          end
        else
          f.printf("\t\t.web(~%s),\n",@matched_memory.Port2.WriteEnable);
        end
        f.printf("\t\t.addrb(%s),\n",@matched_memory.Port2.Address);
        f.printf("\t\t.dinb(%s),\n",@matched_memory.Port2.InputData);
        f.printf("\t\t.doutb(%s)\n",@matched_memory.Port2.OutputData);
      end
      f.printf("\t);\n")
    when "BitWrite"
      tmp = @data_width
      while tmp != 0
        f.printf("\t%s %s_%d(\n",inst_name,inst_name,tmp-1)
        if @matched_memory.PortSize != 0
          f.printf("\t\t.clka(%s),\n",@matched_memory.Port1.Clock);
          f.printf("\t\t.ena(~%s),\n",@matched_memory.Port1.ChipEnable);
          if @matched_memory.Port1.BitWriteEnable == nil 
            f.printf("\t\t.wea(~%s%d),\n",@matched_memory.Port1.WriteEnable,tmp-1);
          else
            f.printf("\t\t.wea(~%s%d & %s),\n",@matched_memory.Port1.BitWriteEnable,tmp-1,@matched_memory.Port1.WriteEnable);
          end
          f.printf("\t\t.addra(%s),\n",@matched_memory.Port1.Address);
          f.printf("\t\t.dina(%s%d),\n",@matched_memory.Port1.InputData,tmp-1);
          f.printf("\t\t.douta(%s%d)\n",@matched_memory.Port1.OutputData,tmp-1);
        end
        if @matched_memory.PortSize == 2
          f.printf("\t\t,\n")
          f.printf("\t\t.clkb(%s),\n",@matched_memory.Port2.Clock);
          f.printf("\t\t.enb(~%s),\n",@matched_memory.Port2.ChipEnable);
          if @matched_memory.Port2.BitWriteEnable == nil 
            f.printf("\t\t.wea(~%s%d),\n",@matched_memory.Port2.WriteEnable,tmp-1);
          else
            f.printf("\t\t.wea(~%s%d & %s),\n",@matched_memory.Port2.BitWriteEnable,tmp-1,@matched_memory.Port1.WriteEnable);
          end
          f.printf("\t\t.addrb(%s),\n",@matched_memory.Port2.Address);
          f.printf("\t\t.dinb(%s%d),\n",@matched_memory.Port2.InputData,tmp-1);
          f.printf("\t\t.doutb(%s%d)\n",@matched_memory.Port2.OutputData,tmp-1);
        end
        f.printf("\t);\n")
        tmp -= write_width
      end
    when "ByteWrite"
      tmp = @data_width
      f.printf("\t%s %s(\n",inst_name,inst_name)
      if @matched_memory.PortSize != 0
        f.printf("\t\t.clka(%s),\n",@matched_memory.Port1.Clock);
        f.printf("\t\t.ena(~%s),\n",@matched_memory.Port1.ChipEnable);
        if @matched_memory.Port1.ByteWriteEnable == nil
          f.printf("\t\t.wea(~%s),\n",@matched_memory.Port1.WriteEnable);
        else
          f.printf("\t\t.wea(~%s),\n",@matched_memory.Port1.ByteWriteEnable);
        end
        f.printf("\t\t.addra(%s),\n",@matched_memory.Port1.Address);
        f.printf("\t\t.dina(%s),\n",@matched_memory.Port1.InputData);
        f.printf("\t\t.douta(%s)\n",@matched_memory.Port1.OutputData);
      end
      if @matched_memory.PortSize == 2
        f.printf("\t\t,\n")
        f.printf("\t\t.clkb(%s),\n",@matched_memory.Port2.Clock);
        f.printf("\t\t.enb(~%s),\n",@matched_memory.Port2.ChipEnable);
        if @matched_memory.Port2.ByteWriteEnable == nil
          f.printf("\t\t.web(~%s),\n",@matched_memory.Port2.WriteEnable);
        else
          f.printf("\t\t.web(~%s),\n",@matched_memory.Port2.ByteWriteEnable);
        end
        f.printf("\t\t.addrb(%s),\n",@matched_memory.Port2.Address);
        f.printf("\t\t.dinb(%s),\n",@matched_memory.Port2.InputData);
        f.printf("\t\t.doutb(%s)\n",@matched_memory.Port2.OutputData);
      end
      f.printf("\t);\n")
    else
      printf("internal error")
      exit
    end
    f.printf("endmodule\n")


    # 
    # Print Verilog generated by CoreGenerator
    #
    # Run Core Generator
    f.printf("\n")
    coregen_verilog = Array.new
    file = @WORK + "/coregen/" + @MEM_NAME + "_cg.v"
    coregen_verilog = Common.file_read("#{file}")
    if coregen_verilog == nil
      $ERROR_CNT += 1
      printf("@Internal error. (file:%s,line:%s)\n",__FILE__,__LINE__)
      Common.print_summary
      exit
    end
    coregen_verilog.each{|line|
      # Add "syn_isclock/syn_gatedclk_clock_en" attribute
      if /input clka;/ =~ line
        line = "input clka\n/\*synthesis syn_isclock=1\*/\n/\*synthesis syn_gatedclk_clock_en=\"ena\"\*/;"
      end
      if /input clkb;/ =~ line
        line = "input clkb\n/\*synthesis syn_isclock=1\*/\n/\*synthesis syn_gatedclk_clock_en=\"enb\"\*/;"
      end

      f.printf("%s\n",line)
    }
  end
  
  def module_generate_each_port(f,port_info,data_width,addr_width,write_width)
    # Clock
    f.printf("\t %s\n",port_info.Clock) if port_info.Clock != nil
    # InputData
    tmp = data_width
    while tmp != 0
      f.printf("\t,%s%d\n",port_info.InputData,tmp-1)
      tmp -= 1
    end if port_info.InputData != nil
    # OutputData
    tmp = data_width
    while tmp != 0
      f.printf("\t,%s%d\n",port_info.OutputData,tmp-1)
      tmp -= 1
    end if port_info.OutputData != nil
    # Address
    tmp = addr_width
    while tmp != 0
      f.printf("\t,%s%d\n",port_info.Address,tmp-1)
      tmp -= 1
    end if port_info.Address != nil
    # BitWriteEnable
    if port_info.BitWriteEnable != nil
      tmp = data_width
      while tmp != 0
        f.printf("\t,%s%d\n",port_info.BitWriteEnable,tmp-1)
        tmp -= 1
      end
    end
    # WriteEnable
    if @BitWriteFlag == true && port_info.Type == "BitWrite" && port_info.BitWriteEnable == nil
      tmp = data_width
      while tmp != 0
        f.printf("\t,%s%d\n",port_info.WriteEnable,tmp-1)
        tmp -= 1
      end
    elsif @ByteWriteFlag == true && port_info.Type == "ByteWrite" && port_info.BitWriteEnable == nil && port_info.ByteWriteEnable == nil
      tmp = data_width/write_width
      while tmp != 0
        f.printf("\t,%s%d\n",port_info.WriteEnable,tmp-1) if port_info.WriteEnable != nil
        tmp -= 1
      end
    elsif @ByteWriteFlag == true && port_info.Type == "ByteWrite" && port_info.BitWriteEnable == nil && port_info.ByteWriteEnable != nil
      f.printf("\t,%s\n",port_info.WriteEnable) if port_info.WriteEnable != nil
      tmp = data_width/write_width
      while tmp != 0
        f.printf("\t,%s%d\n",port_info.ByteWriteEnable,tmp-1) if port_info.WriteEnable != nil
        tmp -= 1
      end
    else
      f.printf("\t,%s\n",port_info.WriteEnable) if port_info.WriteEnable != nil
    end
    # ChipEnable
    f.printf("\t,%s\n",port_info.ChipEnable) if port_info.ChipEnable != nil
  end

  def signal_generate_each_port(f,port_info,data_width,addr_width,write_width)
    # Clock
    f.printf("\tinput\t%s;\n",port_info.Clock) if port_info.Clock != nil
    # InputData
    tmp = data_width
    while tmp != 0
      f.printf("\tinput\t%s%d;\n",port_info.InputData,tmp-1)
      tmp -= 1
    end if port_info.InputData != nil
    # OutputData
    tmp = data_width
    while tmp != 0
      f.printf("\toutput\t%s%d;\n",port_info.OutputData,tmp-1)
      tmp -= 1
    end if port_info.OutputData != nil
    # Address
    tmp = addr_width
    while tmp != 0
      f.printf("\tinput\t%s%d;\n",port_info.Address,tmp-1)
      tmp -= 1
    end if port_info.Address != nil
    # BitWriteEnable
    if port_info.BitWriteEnable != nil
      tmp = data_width
      while tmp != 0
        f.printf("\tinput\t%s%d;\n",port_info.BitWriteEnable,tmp-1)
        tmp -= 1
      end
    end
    # WriteEnable
    if @BitWriteFlag == true && port_info.Type == "BitWrite" && port_info.BitWriteEnable == nil 
      tmp = data_width
      while tmp != 0
        f.printf("\tinput\t%s%d;\n",port_info.WriteEnable,tmp-1) if port_info.WriteEnable != nil
        tmp -= 1
      end
    elsif @ByteWriteFlag == true && port_info.Type == "ByteWrite" && port_info.BitWriteEnable == nil && port_info.ByteWriteEnable == nil 
      tmp = data_width/write_width
      while tmp != 0
        f.printf("\tinput\t%s%d;\n",port_info.WriteEnable,tmp-1) if port_info.WriteEnable != nil
        tmp -= 1
      end 
    elsif @ByteWriteFlag == true && port_info.Type == "ByteWrite" && port_info.BitWriteEnable == nil && port_info.ByteWriteEnable != nil 
      tmp = data_width/write_width
      f.printf("\tinput\t%s;\n",port_info.WriteEnable) if port_info.WriteEnable != nil
      while tmp != 0
        f.printf("\tinput\t%s%d;\n",port_info.ByteWriteEnable,tmp-1) if port_info.ByteWriteEnable != nil
        tmp -= 1
      end 
    else
      f.printf("\tinput\t%s;\n",port_info.WriteEnable) if port_info.WriteEnable != nil
    end
    # ChipEnable
    f.printf("\tinput\t%s;\n",port_info.ChipEnable) if port_info.ChipEnable != nil
  end

  def wire_generate_each_port(f,port_info,data_width,addr_width,write_width)
    # InputData
    if ( @BitWriteFlag == false && port_info.Type != "BitWrite" ) || @InvalidBitWrite == true
      f.printf("\t\/\/ Logic of Input Data\n")
      f.printf("\twire\t[%d:0]\t%s;\n",data_width-1,port_info.InputData) if port_info.InputData != nil
      f.printf("\tassign\t%s = {",port_info.InputData)
      tmp = data_width
      while tmp != 1
        f.printf("%s%d,",port_info.InputData,tmp-1)
        tmp -= 1
      end
      f.printf("%s%d",port_info.InputData,0)
      f.printf("};\n")
    end
    # OutputData
    if ( @BitWriteFlag == false &&  port_info.Type != "BitWrite" ) || @InvalidBitWrite == true
      f.printf("\t\/\/ Logic of Output Data\n")
      tmp = data_width
      f.printf("\twire\t[%d:0]\t%s;\n",data_width-1,port_info.OutputData)
      while tmp != 0
        f.printf("\tassign\t%s%d = %s[%d];\n",port_info.OutputData,tmp-1,port_info.OutputData,tmp-1)
        tmp -= 1
      end
    end
    # Address
    f.printf("\t\/\/ Logic of Address\n")
    f.printf("\twire\t[%d:0]\t%s;\n",addr_width-1,port_info.Address) if port_info.Address != nil
    f.printf("\tassign\t%s = {",port_info.Address)
    tmp = addr_width
    while tmp != 1
      f.printf("%s%d,",port_info.Address,tmp-1)
      tmp -= 1
    end
    f.printf("%s%d",port_info.Address,0)
    f.printf("};\n")
    # WriteEnable
    if @ByteWriteFlag == true && port_info.Type == "ByteWrite" && port_info.BitWriteEnable == nil 
      f.printf("\t\/\/ Logic of WriteEnable\n")
      if port_info.ByteWriteEnable == nil
        byte_write_enable = port_info.WriteEnable
      else
        f.printf("\twire\t%s;\n",port_info.WriteEnable) if port_info.WriteEnable != nil
        byte_write_enable = port_info.ByteWriteEnable
      end
      f.printf("\twire\t[%d:0]\t%s;\n",data_width/write_width-1,byte_write_enable) 
      f.printf("\tassign\t%s = {",byte_write_enable)
      tmp = data_width/write_width
      while tmp != 1
        if port_info.ByteWriteEnable == nil
          f.printf("%s%d,",byte_write_enable,tmp-1)
        else
          f.printf("%s%d|%s,",byte_write_enable,tmp-1,port_info.WriteEnable)
        end
        tmp -= 1
      end
      if port_info.ByteWriteEnable == nil
        f.printf("%s%d",byte_write_enable,0)
      else
        f.printf("%s%d|%s",byte_write_enable,0,port_info.WriteEnable)
      end
      f.printf("};\n")
    end
  end

  #
  # Run Core Generator
  #
  def run_coregen(matched_memory,write_width)
    if @InvalidBitWrite == true || @InvalidByteWrite == true
      cg = CoreGen.new(@WORK,@MEM_NAME,@matched_memory.PortSize,@data_width,@depth,@matched_memory.Port1.Type,write_width)
    elsif @BitWriteFlag == false && @matched_memory.Port1.Type != "BitWrite" && @matched_memory.Port1.BitWriteEnable == nil
      cg = CoreGen.new(@WORK,@MEM_NAME,@matched_memory.PortSize,@data_width,@depth,@matched_memory.Port1.Type,write_width)
    elsif @ByteWriteFlag == true && @matched_memory.Port1.Type == "ByteWrite" 
      # ByteWrite
      cg = CoreGen.new(@WORK,@MEM_NAME,@matched_memory.PortSize,@data_width,@depth,@matched_memory.Port1.Type,write_width)
    else
      # BitWrite
      cg = CoreGen.new(@WORK,@MEM_NAME,@matched_memory.PortSize,write_width,@depth,@matched_memory.Port1.Type,write_width)
    end
    cg.main
  end

  #
  # Main Function
  #  1. 
  #  2. 
  #
  public
  def main
    # Print Base Message
    print_base
    # Get Argument
    get_argument
    # Read memory Definition File
    read_mdef
    # Generate WorkDirecotry
    Common.make_dir("#{@WORK}")
    # Detrmint Memory target memory and Memory DB
    determine_memory
    # Generate Verilog 
    generate_verilog

    # Test mode (for synthesizing generated memory)
    if @TEST
      printf("@I:Test Mode ON\n")
      test = CoregenTest.new(@MEM_NAME)
      test.main
    end

    Common.print_summary

  end
  
end


if __FILE__ == $0
  gMem = GMem.new
  gMem.main
end
