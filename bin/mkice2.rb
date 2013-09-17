#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-
#############################################################
#
#=mkice : generate files related FPGA-ICE
#  
#Authors::   Koji HIJIKURO<koji.hijikuro.rj@rms.renesas.com>
#Copyright:: Copyright (c) 2009,2010 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
#==Function detail
#* Analyze Verilog-HDL 
#
#==Usage
#
#===Setup Mode ( In this mode,gnerate instance list and conf file)
#%ruby mkice.rb --startup TopModule-HDL
#
#===Config Mode ( In this mode, generate modified verilog )
#%ruby mkice.rb --config mkice.conf
#  If you want to get more information. plese use "--help" option.
#
#===Analyze Mode ( In this mode, analyze all verilog under described directory)
#%ruby mkice.rb --analyze HDL_Dir
#
#  If you want to get more information. plese use "--help" option.
#
#===Connect Mode ( In this mode, analyze connect infomation between each module, generate connect files )
#%ruby mkice.rb --connect TopModule-HDL
#
#===EXAMPLE
#%ruby mkice.rb chip.v
#
#===Output Files
#
#===History
#* Please see the RedMine Project Web Page<http://nqjpc147:1030/redmine>
#
#############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "fileutils"

require "FICE_def"
require "system"
require "common"
require "optparse"
require "XMLParse"
require "conv"



#
# Global Setting
#
$SUB_TOOL        = "mkice" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
Version          = $VERSION # For OptParse


$CircuitInf = Circuit::Circuit.new

$MODE            = nil     # Execution mode

#
# Main Class
#
class MkICE
  
  def initialize
    @Help = nil
    # VerilogToXML Version
    @VerilogToXML_Version = nil
    # Verilog Dir Name from option
    @HDLDir = nil
    # Conf File from option
    @ConfFile = nil
    # HDL File from option
    @HDLFile = nil
    # Module & HDL File List file from option
    @HDLListFile = nil
    # Option Flag
    @StartupFlag = false
    @AnalyzeFlag = false
    @ConfigFlag = false
    @ConnectFlag = false

    # Verilog
    @HDLFiles = Array.new # Output Verilog file name
    # XML
    @XMLFiles = Array.new
    # direcotry name which saved all verilog files
    @HDL_ALL = "_hdl"
  end

  #
  # Print Base Information( Tool name, Version, Copyright )
  #
  private
  def print_base
    print <<EOB
#{$TOOL}(#{$SUB_TOOL}) ver:#{Version}
Copyright (c) 2011 Renesas Micro Systems. All rights reserved.
EOB
  end
  

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  public
  def get_argument
    opt = OptionParser.new
    begin
      opt.on('--verbose',"verbose mode"){|v| $VERBOSE = true}
      opt.on('--analyze Diredtory','Directory saved hdl files'){|v| @HDLDir = v; @AnalyzeFlag = true}
      opt.on('--startup VerilogList:ModuleName','[Startup mode]Verilog List File : Top module name'){|v| @HDLFile = v; @StartupFlag = true }
      opt.on('--check ConfigFile','[Check mode]Configuration file'){|v| @HDLFile = v; @StartupFlag = true }
      opt.on('--config ConfigFile','[Config  mode]Configuration file'){|v| @ConfFile = v; @ConfigFlag = true }
      opt.on('--connect Verilog-HDL','Verilog-HDL'){|v| @HDLFile = v; @ConnectFlag = true }
      opt.on('--list File List','Verilog-HDL FileList'){|v| @HDLListFile = v }
      opt.on('--conformal SettingFile','Setting file for Conformal'){|v| $CircuitInf.Conformal = v }
#      opt.on('-v','--version','Print version message'){print_version}
#      opt.on('--pull PullDown/PullUp inf','pulldown/pullup information at CVS'){|v| @PullFile = v}
#      opt.on('--ct CT inf','CT Port Setting information at CVS'){|v| @CTFile = v}
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:OP000:"#{$!}" 
#{opt.help}
EOB
      exit
      return false
    end
    @Help = opt.help
    # Mode Setting
    if @StartupFlag && !@ConfigFlag && !@AnalyzeFlag && !@ConnectFlag
      $MODE = "StartupMode"
      @HDLDir = "."
    elsif !@StartupFlag && !@ConfigFlag && @AnalyzeFlag && !@ConnectFlag
      $MODE = "AnalyzeMode"
    elsif !@StartupFlag && @ConfigFlag && !@AnalyzeFlag && !@ConnectFlag
      $MODE = "ConfigMode"
    elsif !@StartupFlag && !@ConfigFlag && !@AnalyzeFlag && @ConnectFlag
      $MODE = "ConnectMode"
      @HDLDir = "."
    else
      $ERROR_CNT += 1
      printf("@E:OP001:The options you specified are not permitted. please check usage\n")   
      printf("%s\n",@Help)
      exit      
    end

    return true
  end

  #
  # convert verilog to xml using VerilogToXML
  # 
  def v2xml(hdl_files)
    current = Dir::pwd
    v2xml = File.dirname(__FILE__) + "/VerilogToXML"

    # print VerilotToXML version
    system("#{v2xml} -v")
    
    # Generate XML
    printf("@I:Generate XML File using VerilogToXML ... \n")    
#    Common.make_dir_with_delete("_xml",num=0)
    Common.make_dir("_xml")
    begin
      hdl_files.each{|file|
        # make xml file name
        base_name = File.basename(file)
        ext_name = File.extname(base_name)
        xml = base_name.sub("#{ext_name}","") + ".xml"

        # Char conv
        conv = Conv.new(file)
        contents = conv.main
        if contents != nil
          # make new file_name
          base_name = File.basename(file)
          ext_name = File.extname(base_name)
          dist_name = base_name.sub("#{ext_name}","")
          new_name = @HDLDir + "/" + dist_name + "_enc" + ext_name
          printf("@I:Generate new hdl file(%s) that changed char-code.\n", new_name)
          f = File.open(new_name,"w")
          f.puts contents
          f.close
          file = new_name
        end

        xml_file = "_xml/" + xml
        result = system("#{v2xml} #{file} > #{xml_file}")
        @XMLFiles << xml_file
        if contents != nil
          # delted file which changed char-code
          File.delete("#{file}")
        end
        if result == false
          printf("@E:VerilogToXML abnormally finished.(%s)\n",file)
          exit
        end
        
        # file delete
      }
    rescue => ex
      print ex.message, "\n"
    end
    printf("Done.\n")
  end

  #
  # Parsing XML
  #
  def xml_parse(circuit_inf,search_module_list=nil)
    i = 1
    @XMLFiles.each{|xml_file|
      printf("@I:Parsing %s and making Circuit DB ... (%d/%d)\n",xml_file,i,@XMLFiles.size)    
      xml = XMLParse.new("#{xml_file}",circuit_inf,search_module_list)
      xml.main
      printf("Done.\n")
      i += 1
    }
    @XMLFiles.clear
  end
  
  #
  # Get Sub-Module
  #
  def get_sub_module_inf
    # serach files defined one module and copy tmp directory
    dir_name = "_hdl_all"
    get_sub_module_files(dir_name)
    # Collect HDL Files (Sub-Module)
    @HDLFiles = Common.collect_verilog_files("#{dir_name}")
    if @HDLFiles != nil
      printf(" Found %d verilog files\n",@HDLFiles.size) 
      @HDLFiles.each{|file|
        printf("  - %s\n",file)
      }
    end
    # generate xml
    v2xml(@HDLFiles)
    # parse xml , parsing only define ModuleList
    xml_parse($CircuitInf)
#    Common.del_dir("#{dir_name}")
  end
  
  #
  # Get Sub-Module Files
  #
  def get_sub_module_files(dir)
    Common.make_dir_with_delete("#{dir}")
    printf("@I:Searching related files on from \"%s\"\n",@HDLListFile)
    $CircuitInf.ModuleHDL.each{|module_name,list|
      list.each{|file_name|
        begin
          FileUtils.install("#{file_name}","#{dir}")
        rescue
          $ERROR_CNT += 1
          print <<EOB
@E:OP000:"#{$!}" 

EOB
          Common.print_summary
          exit
        end
      }
    }
  end

  #
  # Get HDLList File
  #
  def get_HDLListFile(file)
    open(file,"r").each{|line|
      tmp = line.split(":")
      module_name = tmp[0]
      file_list = tmp[1].split
      $CircuitInf.make_ModuleHDL(module_name,file_list)
    }
  end
  
  #
  # Main Function
  #  1. Print Base Message
  #  2. Get Exected Argument
  #  3. Operation(read CSV data)
  #  4. Generate each files
  #  5. Print Summary Message
  #
  public
  def main
    Common.print_base
    get_argument

    printf("@I:Execute \"%s\" mode\n",$MODE)
    
    case $MODE
    when "AnalyzeMode"
      # Collect HDL Files
      printf("@I:Collect Verilog Files in \"%s\" directory. \n",@HDLDir)
      @HDLFiles = Common.collect_verilog_files(@HDLDir)
      printf(" Found %d verilog files\n",@HDLFiles.size)
      @HDLFiles.each{|file|
        printf("  - %s\n",file)
      } if @HDLFiles != nil
      # generate xml
      v2xml(@HDLFiles)
      # parse xml
      xml_parse($CircuitInf)

    when "StartupMode"
      @HDLFiles << @HDLFile # 1 file save
      # generate xml
      v2xml(@HDLFiles)
      # parse xml
      xml_parse($CircuitInf)

      # get HDLList
      if @HDLListFile != nil
        printf("@I:Analyze Module Name and HDL File\n")
        get_HDLListFile(@HDLListFile)
      end

    when "ConnectMode"
      @HDLFiles << @HDLFile # 1 file save
      # generate xml
      v2xml(@HDLFiles)
      # parse xml
      xml_parse($CircuitInf)
      $CircuitInf.make_TopModule
      # get HDLList
      if @HDLListFile != nil
        printf("@I:Analyze Module Name and HDL File\n")
        get_HDLListFile(@HDLListFile)
        # Get Sub-Module Information
        get_sub_module_inf
      end
    end

    # result
    $CircuitInf.make_FileList(@HDLFiles)
    $CircuitInf.make_connect_inf
    $CircuitInf.generate

    Common.print_summary
  end
  
end


#
# Execute
#
if __FILE__ == $0
  mkice = MkICE.new
  mkice.main
end
