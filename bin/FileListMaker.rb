#!/home/product/div-micom-ice/data/proj/RL78/Common/local/ruby/bin/ruby
$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'optparse'
require 'common'

$TOOL = "FICE"
$SUB_TOOL = "FileListMaker"
Version          = $VERSION # For OptParse

##################################################################################
#
# Generate File List
#  for Prj File, make_chip library file
#
##################################################################################
class Prj2FMake
  def initialize
    @PRJ = nil
    @Library = nil
    @ProductName = nil
    @DevVer = nil
    @Mode = nil
    @TopModule = nil
    @ProductList = nil
    @ListData = Array.new
    @ShellFiles = Array.new
  end

  # 
  # Get argument from prompt, Select Mode and Check argument Error.
  # Execute error operation, if user sets unexpected option.
  #
  public
  def get_argument
    opt = OptionParser.new
    begin
      # For System
      opt.on('--prj [ProductName]',"Prj file for Synplify"){|v| @PRJ = v}
      opt.on('--library [make_chip Library]',"Library File generaeted by make_chip"){|v| @Library = v}
      opt.on('--product [ProductName]','ProductName at Product. ex) G13'){|v| @ProductName = v}
      opt.on('--dev_ver [Device Ver]','Device Version. ex) DF1.0,CF1.0'){|v| @DevVer = v}
      opt.on('--ice_ver [ICE Ver]','ICE Version. ex) 3001_0001'){|v| @ICEVer = v}
      opt.on('--top_module [Top Module]','TOP Module Name'){|v| @TopModule = v}
      opt.on('--list [Product List File]','Product List'){|v| @ProductList = v}
      opt.parse(ARGV)
    rescue
      return false
    end
    if @ProductList.nil?
      # Each Mode
      if @PRJ.nil? && @Library.nil?
        printf("@E:Not described Project File or Library File\n")
        exit
      end
      
      if @ProductName.nil?
        printf("@E:Not described Product Name\n")
        exit
      end
      
      if @DevVer.nil?
        printf("@E:Not described Device Version\n")
        exit
      end
    end
    return true
  end


  #
  # Generate Run-Script in Each Product Directory
  #  - run_Startup.sh
  #  - run_Analyze.sh
  #
  def generate_RunScript
    file_list = Array.new


    # Get Verilog File list fro Project File
    add_opt = nil
    case @Mode
    when "ICE"
      printf "@I:Open orj file .. #{@PRJ}\n"
      open("#{@PRJ}").each do |line|
        if /^add_file\s+-verilog\s+\"(.*)\"/ =~ line
          file_list << $1
        end
      end
      @TopModule = "EVA_TOP"
      add_opt = "--disenable_auto_reflect"
      add_modify_inst = "chiptop,chiptop.chip,chiptop.chip.socket,port_iobuf"
      if @ICEVer == nil
        printf("@E:Not Found ICE Version\n")
        exit
      end
    when "Device"
      printf "@I:Open orj file .. #{@Library}\n"
      open("#{@Library}").each do |line|
        if /`include\s+\"(.*)\"/ =~ line
          file_list << $1
        end
      end
      @ICEVer = nil
      add_modify_inst = "socket,port*_iobuf"
    end

    # make directory
    dir_name = @ProductName + "_" + @DevVer
    Common.make_dir(dir_name)
    dir_name = dir_name + "/" + @Mode
    Common.make_dir(dir_name)

    # Generate List File
    file = dir_name + "/" + @ProductName + "_" + @DevVer + ".list"
    printf "@I:generate VerilogList File .. #{file}\n" 
    f = open("#{file}","w")
    file_list.each do |verilog|
      f.printf "#{verilog}\n"
    end
    f.close

    # Genrate Startup Run-Script
    file = dir_name + "/run_Startup.sh"
    printf "@I:generate #{file}\n"
    f = open("#{file}","w")
    
    f.print <<EOB
#!/bin/sh
#############################################################
#
# FICE 2.0 Trial Environment using #{@ProductName}
#
#############################################################

## BASE SETTING #################

FICE=/home/m0001/rl0003/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk
FMAKE=${FICE}/bin/FMake.rb

RUBY=/home/product/div-micom-ice/data/proj/RL78/Common/local/ruby/bin/ruby

#################################

VERILOG_LIST=./#{@ProductName}_#{@DevVer}.list
TOP_MODULE=#{@TopModule}
PRODUCT=#{@ProductName}
DEV_VER=#{@DevVer}
ICE_VER=#{@ICEVer}
ADD_MODIDY_INST=#{add_modify_inst}

${RUBY} ${FMAKE} --startup ${VERILOG_LIST} --top_module ${TOP_MODULE} --product ${PRODUCT} --dev_ver ${DEV_VER} --ice_ver ${ICE_VER} --add_modify_inst ${ADD_MODIDY_INST} #{add_opt} --verbose

EOB
    f.close
    File.chmod(0744,"#{file}")

    # Genrate Startup Run-Script
    file = dir_name + "/run_Analyze.sh"
    printf "@I:generate #{file}\n"
    f = open("#{file}","w")
    f.print <<EOB
#!/bin/sh
#############################################################
#
# FICE 2.0 Trial Environment using G1C
#  - Analyze Mode
#
#############################################################

## BASE SETTING #################

FICE=/home/m0001/rl0003/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk
FMAKE=${FICE}/bin/FMake.rb

RUBY=/home/product/div-micom-ice/data/proj/RL78/Common/local/ruby/bin/ruby

#################################

CONF=./#{@ProductName}.conf

${RUBY} ${FMAKE} --analyze ${CONF} --verbose

EOB
    f.close
    File.chmod(0744,"#{file}")


    # Genrate Run-Script
    file = dir_name + "/run.sh"
    @ShellFiles << [dir_name,File.basename(file)]
    printf "@I:generate #{file}\n"
    f = open("#{file}","w")
    f.print <<EOB
#!/bin/sh
#############################################################
#
# FICE 2.0 Trial Environment using G1C
#  - Startup/Analyze Mode
#
#############################################################

./run_Startup.sh > startup.log
./run_Analyze.sh > analyze.log

EOB
    f.close
    File.chmod(0744,"#{file}")


    printf "\nFinished Successfully\n"

  end

  #
  # Analyze Product List File
  #
  def analyze_ProductList
    # File Read
    printf "@I:Read #{@ProductList}\n"
    open("#{@ProductList}","r").each do |line|
      analyze_each_line(line)
    end

    # Generate Each Run-Shell
    printf "@I:Generate Each Run-Shell\n"
    @ListData.each do |product|
      product.print

      @PRJ = product.ProjectFile
      @Library = product.LibraryFile
      @ProductName = product.ProductName
      @DevVer = product.DevVer
 
      # For Device
      @TopModule = product.DEVICE_TOP
      @Mode = "Device" 
      generate_RunScript

      # For ICE
      @ICEVer = product.ICEVer
      @TopModule = product.ICE_TOP
      @Mode = "ICE" 
      generate_RunScript      
    end
    
  end

  def analyze_each_line(line)
    tokens = BasicParser.new("#{line}").tokens
    return if /^#/ =~ tokens[0] || tokens[0] == nil
    data = line.split(",")
#    printf "Line:#{line}"
    product = ProductInf.new
    product.ProductName = data[0]
    product.DevVer = data[1]
    product.ICEVer = data[2]
    product.LibraryFile = data[3].split(":")[0]
    product.DEVICE_TOP = data[3].split(":")[1]
    product.ProjectFile = data[4].split(":")[0]
    product.ICE_TOP = data[4].split(":")[1]

    if !File.readable?(product.LibraryFile)
      printf("@E: Cannot read %s\n",product.LibraryFile)
      exit
    end
    if !File.readable?(product.ProjectFile)
      printf("@E: Cannot read %s\n",product.ProjectFile)
      exit
    end
    @ListData << product
  end

  def generate_AllRun
    # AllRun
    file = "FMake_AllRun.sh"
    f = open("#{file}","w")   
      f.print <<EOB
##################################################
#
# All-Run Script For FMake
#   execute FMake(Startup/Analyze) in each Product
#
##################################################

EOB

    @ListData.each do |product|
      product.fprint(f)
    end if @ListData != nil


    @ShellFiles.each do |path|
      f.print <<EOB
#------------------------------------------------
pushd #{path[0]}
bs #{path[1]} > run.log &
popd

EOB
    end
    f.close
    File.chmod(0744,"#{file}")
  end

  #
  # Main Function
  #
  def main
    
    Common.print_base
    get_argument

    # read Product Inf List
    if @ProductList != nil
      analyze_ProductList
    else
      @Mode = "ICE" unless @PRJ.nil?
      @Mode = "Device" unless @Library.nil?
      generate_RunScript
    end
    generate_AllRun

    Common.print_summary
  end
  
  private
  class ProductInf
    attr_accessor :ProductName
    attr_accessor :DevVer
    attr_accessor :ICEVer
    attr_accessor :LibraryFile
    attr_accessor :DEVICE_TOP
    attr_accessor :ProjectFile
    attr_accessor :ICE_TOP
    def initialize
      @ProductName = nil
      @DevVer = nil
      @ICEVer = nil
      @LibraryFile = nil
      @DEVICE_TOP = nil
      @ProjectFile = nil
      @ICE_TOP = nil
    end

    def print
      printf "# - Product Name   : #{@ProductName}\n"
      printf "# - Device Version : #{@DevVer}\n"
      printf "# - ICE Version    : #{@ICEVer}\n"
      printf "# - Library File   : #{@LibraryFile}\n"
      printf "# - DEVICE TOP     : #{@DEVICE_TOP}\n"
      printf "# - Project File   : #{@ProjectFile}\n"
      printf "# - ICE TOP        : #{@ICE_TOP}\n"
    end

    def fprint(f)
      f.printf "# - Product Name   : #{@ProductName}\n"
      f.printf "# - Device Version : #{@DevVer}\n"
      f.printf "# - ICE Version    : #{@ICEVer}\n"
      f.printf "# - Library File   : #{@LibraryFile}\n"
      f.printf "# - DEVICE TOP     : #{@DEVICE_TOP}\n"
      f.printf "# - Project File   : #{@ProjectFile}\n"
      f.printf "# - ICE TOP        : #{@ICE_TOP}\n"
    end
  end

end

if __FILE__ == $0
  prj2fmake = Prj2FMake.new
  prj2fmake.main
end


