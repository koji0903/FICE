#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-
#############################################################
#
# FLocal
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009-2013 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Collect FPGA-ICE Design Information( Conf File, Expect File )
#
# [Usage]
# -%ruby FLocal.rb
# If you want to get more information. plese use "--help" option.
#
# [EXAMPLE]
# -example
#
# [Output]
# -filename
#
# [History]
# -history
#
#############################################################
$:.unshift(File.dirname(__FILE__) + "/../lib")
$:.unshift(File.dirname(__FILE__) + "/../bin")
require "FICE_def"
require "system"
require "common"
require "optparse"
require "spreadsheet"
require "FMakeConf"
require "FDiff"
require "pp"

#
# Global Setting
#
$SUB_TOOL        = "FLocal" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
Version          = $VERSION # For OptParse


#
# Main Class
#
class FLocal
  
  def initialize
    @ProductInf = File.dirname(__FILE__) + "/../conf/ExpectFiles.xls"
    @DeviceName = Array.new
    @TargetDevice = nil
    @TargetConf = nil
    @TargetExpectDir = nil

  end

  class ProductDataEach
    attr_accessor :ConfFile, :ExpectDir
    def initialize(conf,expect)
      @ConfFile = conf
      @ExpectDir = expect
    end
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
      opt.on('-h','pint help message'){|v|}
      opt.on('--target [Target Device]','Target Dive Name'){|v| @TargetDevice = v}
      opt.on('--conf [Conf File]','Target Dive Conf File'){|v| @TargetConf = v}
      opt.on('--expect_dir [Expect Dir]','Target Device Expect Name'){|v| @TargetExpectDir = v}
      opt.on('--compare [Compare File(XLS)]','Comare Files'){|v| @ProductInf = v}
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:Not support  "#{ARGV}" option or need argument using this option.
EOB
      return false
    end
    return true
  end

  #
  # Get ProductInf
  #
  def get_ProductInf(file)
    unless File.readable?(file)
      $ERROR_CNT += 1
      printf "@E:Could not access #{file}\n"
      exit 1
    end

    product_data = Hash.new

    printf "\n"
    printf "@I:Get Product Information form #{file}\n"
    printf "\n"
    book = Spreadsheet.open(file, 'rb')
    sheet = book.worksheet(0)
    device_name_index = nil
    conf_index = nil
    expect_index = nil
    sheet.each do |data|
      data.each_with_index do |str,i|
        unless str.nil?
          str = str.strip 
          device_name_index = i if str == "DeviceName"
          conf_index = i if str == "ConfFile"
          expect_index = i if str == "ExpectDir"
        end
      end
    end
    if device_name_index.nil? || conf_index.nil? || expect_index.nil?
      $ERROR_CNT += 1
      printf "@E:Not Support #{file} description. Please check it.\n"
      exit 1
    end

    sheet.each do |data|
      # Sekip to Title
      next if data[device_name_index] == "DeviceName" 
      next if data[0] == "#"
      if data[device_name_index].nil? && data[conf_index].nil? && data[expect_index].nil?
        # No need to analyze
        next
      end
      product_data_each = ProductDataEach.new(data[conf_index],data[expect_index])
      # Check Data
      unless File.readable?(data[conf_index]) || data[conf_index] == "NONE"
        $ERROR_CNT += 1
        printf "@E:Could not read #{data[conf_index]}\n"
        exit 1
      end
      if !FileTest::exist?(data[expect_index]) || File::ftype(data[expect_index]) != "directory"
        $ERROR_CNT += 1
        printf "@E:Could not access #{data[expect_index]} directory\n"
        exit 1
      end unless data[expect_index].nil?
      if product_data[data[device_name_index]].nil?
        product_data[data[device_name_index]] = product_data_each        
      else
        $ERROR_CNT += 1
        printf "@E:Found Same name Product about #{data[device_name_index]}\n"
        exit 1
      end
    end      

    # add option data
    product_data[@TargetDevice] = ProductDataEach.new(@TargetConf,@TargetExpectDir)    

    # Check Data
    if @TargetDevice.nil?
      $ERROR_CNT += 1
      printf "@E:You have to specify \"--target\" option.\n"
      Common.print_summary
      exit 1
    end
    if @TargetConf.nil?
      $ERROR_CNT += 1
      printf "@E:You have to specify \"--conf\" option.\n"
      Common.print_summary
      exit 1
    end
    if @TargetExpectDir.nil?
      $ERROR_CNT += 1
      printf "@E:You have to specify \"--expect_dir\" option.\n"
      Common.print_summary
      exit 1
    end
    unless File.readable?(@TargetConf) || @TargetConf == "NONE"
      $ERROR_CNT += 1
      printf "@E:Could not read #{@TargetConf}\n"
      exit 1
    end
    if !FileTest::exist?(@TargetExpectDir) || File::ftype(@TargetExpectDir) != "directory"
      $ERROR_CNT += 1
      printf "@E:Could not access #{@TargetExpectDir} directory\n"
      exit 1
    end 

    printf "[Product Information]\n"
    product_data.each do |key,value|
      printf "-------------------------------------------------------\n"
      printf " Device Name : #{key}\n"
      @DeviceName << key
      printf " Conf File   : #{value.ConfFile}\n"
      printf " Expect Dir  : #{value.ExpectDir}\n"
    end
    printf "-------------------------------------------------------\n"
    printf "\nDone.\n"

    # Check Target
    if product_data.keys.index(@TargetDevice).nil?
      $ERROR_CNT += 1
      printf "@E:Cannot get Target Device Information(Conf/Expect).\n"
      Common.print_summary
      exit
    end
    return product_data
  end


  #
  # Analyze Product Data
  #
  def analyze_ProductData(product_data)
    design_inf = Hash.new
    printf "@I:Analyze Product Data ...\n"
    common_expect = nil
    common_files = Array.new
    product_data.each do |key,value|
      printf "-#{key}\n"
      # For Conf File
      conf_db = FMakeConf.new( 
                              :conffile      => value.ConfFile,
                              ).analyze unless value.ConfFile == "NONE"
      # For Expect File
      expect = Hash.new
      files = Array.new
      Dir::glob("#{value.ExpectDir}/*.expect").each do |file|        
        files << file
      end
      common_files = files if key == "Common"
      (files + common_files).each do |file|
        printf("%s\n",file)
        FDiff.new.analyze(conf_db,file,expect)
      end
      design_inf[key] = [conf_db,expect]
    end
    printf "Done\n"
    return design_inf
  end

  #
  # Data Arrangement
  #  ret : all_inst_inf   { InstanceName => { DeviceName => [ModuleName,MacroType] } }
  #        all_module_inf { ModuleName => { DeviceName => [InstName,MacroType] } }
  #
  def data_arrangement(design_inf)
    all_inst_inf = Hash.new
    all_module_inf = Hash.new
    all_expect_inf = Hash.new

    design_inf.each do |key,value|
      # value[0] : Conf File Information
      # value[1] : Expect File Information
      value[0].INST.each do |inst_name,inst_inf|

        # Make All Instance Information
        if all_inst_inf[inst_inf.InstName].nil?
          product_inst_inf = Hash.new
        else
          product_inst_inf = all_inst_inf[inst_inf.InstName]
        end
        product_inst_inf[key] = [inst_inf.ModuleName,inst_inf.MacroType]
        all_inst_inf[inst_inf.InstName] = product_inst_inf

        # Make All Module Information
        if all_module_inf[inst_inf.ModuleName].nil?
          product_module_inf = Hash.new
        else
          product_module_inf = all_module_inf[inst_inf.ModuleName]
        end
        unless product_module_inf[key].nil?
          tmp = product_module_inf[key]
          tmp << [inst_inf.InstName,inst_inf.MacroType]
          product_module_inf[key] = tmp          
        else
          product_module_inf[key] = [[inst_inf.InstName,inst_inf.MacroType]]
        end
        all_module_inf[inst_inf.ModuleName] = product_module_inf

      end unless value[0].nil?

      value[1].each do |inst_name,expect_inf|
        expect_inf.each do |port,connect_inf|
          connect_inf.Connect.each do |each_connect|
            case connect_inf.Direction
            when "I"
              direction = "<-"
            when "O"
              direction = "->"
            when "IO"
              direction = "<->"
            end
            con_str = connect_inf.Path + " " + direction + " " + each_connect.Path

            # Make All Expect Information
            if all_expect_inf[con_str].nil?
              product_expect_inf = Hash.new
            else
              product_expect_inf = all_expect_inf[con_str]
            end
            product_expect_inf[key] = each_connect
            all_expect_inf[con_str] = product_expect_inf
          end
        end
      end
    end

    return all_inst_inf,all_module_inf,all_expect_inf
  end

  #
  # Generate Excel
  #
  def generate_Excel(all_inst_inf,all_module_inf,all_expect_inf)

    book = Spreadsheet::Workbook.new

    # Expect Base
    sheet_name = "Expect Base"
    sheet = book.create_worksheet( :name => sheet_name )

    cell_gray = Common.set_cell(sheet,:gray,:thin)
    cell_red = Common.set_cell(sheet,:red,:thin)
    cell_green = Common.set_cell(sheet,:green,:thin)
    cell_cyan = Common.set_cell(sheet,:cyan,:thin)
    cell_magenta = Common.set_cell(sheet,:magenta,:thin)
    cell_yellow = Common.set_cell(sheet,:yellow,:thin)
    cell_white = Common.set_cell(sheet,:white,:thin)
    cell_pure_white = Common.set_cell(sheet,:white)   

    index = 1
    sheet[index,1] = "Expect Name"
    sheet.row(index).set_format(1,cell_cyan)

    # Remove Common Inf
    @DeviceName = @DeviceName - ["Common"]


    @DeviceName.each_with_index do |inst_name,i|
      i = i + 2
      sheet[index,i] = inst_name
      sheet.row(index).set_format(i,cell_cyan)
    end

    common_expect = Array.new
    all_expect_inf.each do |key,value|
      unless value["Common"].nil?
        common_expect << key
      end
    end

    target_expect = Array.new
    all_expect_inf.each do |key,value|
      unless value[@TargetDevice].nil?
        # get Source Information
        target_expect << key.split[0]
      end
    end

    all_expect_inf.sort_by do |key|
      key
    end.each do |key,value|
      common_flag = false
      
      src_inst_name, dist_inst_name = get_inst(key)

      if !all_inst_inf[src_inst_name].nil? && all_inst_inf[src_inst_name][@TargetDevice].nil?
        next
      end
      
      # Ignore Common Expect
      next unless common_expect.index(key).nil?
      # Ignore Untarget Only Source
      next if target_expect.index(key.split[0]).nil?
      
      # output expect inf
      # Except PorductLocal Instance
=begin
      case key
      when /iePortControl/
        next
      end
=end
      index = index + 1
      sheet[index,1] = key 
      sheet.row(index).set_format(1,cell_white)

      # Set Cell Size
      if sheet.column(1).width < key.size
        sheet.column(1).width = key.size
      end
      ng_flag = false
      @DeviceName.each_with_index do |dev,dev_index|
        dev_index = dev_index + 2
        unless all_inst_inf[src_inst_name].nil?
          # Instance does not exist in this Device
          if all_inst_inf[src_inst_name][dev].nil?
            sheet[index,dev_index] = "-"
            ng_flag = true
            sheet.row(index).set_format(dev_index,cell_white)
          elsif !dist_inst_name.nil? && !all_inst_inf[dist_inst_name].nil? && all_inst_inf[dist_inst_name][dev].nil?
            sheet[index,dev_index] = "-"
            ng_flag = true
            sheet.row(index).set_format(dev_index,cell_white)
          else 
            if value[dev].nil?
              if dev == @TargetDevice
                sheet[index,dev_index] = "x"
                ng_flag = true
                sheet.row(index).set_format(dev_index,cell_magenta)
              else
                sheet[index,dev_index] = "-"
                ng_flag = true
                sheet.row(index).set_format(dev_index,cell_white)
              end
            else
              sheet[index,dev_index] = "o"
              sheet.row(index).set_format(dev_index,cell_white)
              if dev == @TargetDevice
                for num in 1..(1+@DeviceName.size)
                  sheet.row(index).set_format(num,cell_yellow) if sheet.row(index)[num] != "x"
                end
              end
            end
          end
        end
      end

      # Color Gray if all cell "o"
      unless ng_flag
        for num in 1..(1+@DeviceName.size)
          sheet.row(index).set_format(num,cell_gray)
        end
      end
=begin
      for num in 1..(1+@DeviceName.size)
        case src_inst_name
        when /FixedPin/,/ierl78puctl7v1/,/iePortControl/
          sheet.row(index).set_format(num,cell_gray)
        else
          unless ng_flag
            sheet.row(index).set_format(num,cell_yellow)
          end
        end
        case dist_inst_name
        when /FixedPin/,/ierl78puctl7v1/,/iePortControl/,/PTTL/
          sheet.row(index).set_format(num,cell_gray)
        end        
      end  
=end
    end

    printf "@I:Generating Excel File. Please wait.\n"
    Common.make_dir("result")
    xls = "result/LocalConnection_" + @TargetDevice + ".xls"
    book.write(xls)

  end

  def get_inst(key)
    # Get Source Instance Name
    src_inst_tmp = key.split[0]
    src_inst_tmp2 = src_inst_tmp.split(".")
    src_inst_tmp2.pop
    src_inst_name = src_inst_tmp2.join(".")
    
    dist_inst_tmp = key.split[2]
    dist_inst_tmp2 = dist_inst_tmp.split(".")
    if dist_inst_tmp2.size != 1
      dist_inst_tmp2.pop
      dist_inst_name = dist_inst_tmp2.join(".")
    else
      dist_inst_name = dist_inst_tmp2[0]
    end
    return src_inst_name,dist_inst_name
  end

  #
  # Main Function
  #  1. 
  #  2. 
  #
  public
  def main
    Common.print_base
    get_argument

    # Get Product Information File
    product_data = get_ProductInf(@ProductInf)
    # Analyze ProductData
    design_inf = analyze_ProductData(product_data)
    # Data Arrangement Design Inf
    all_inst_inf,all_module_inf,all_expect_inf = data_arrangement(design_inf)
    # Generate Excel
    common_expect = generate_Excel(all_inst_inf,all_module_inf,all_expect_inf)

    Common.print_summary
  end
  
end


if __FILE__ == $0
  flocal = FLocal.new
  flocal.main
end
