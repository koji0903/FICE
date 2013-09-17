#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-
#############################################################
#
# Conf2Xls
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009-2012 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Convert from Conf to Xls
#
# [Usage]
# -%ruby Conf2Xls.rb --conf ${Conf File} --xls ${ExcelFile}
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
require "FMakeConf"
require 'rubygems'
require 'spreadsheet'
require 'pp'
require "conv"
require 'excel'

#
# Global Setting
#
$SUB_TOOL        = "Conf2Xls" # Tool Name
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
class Conf2Xls
  include CELL
  def initialize
    @Mode = "Startup"
    @InputXLS = nil
    @Conf = nil
    @XLS = nil
    @SheetFile = Hash.new
    @MainSheetName = nil
    @FileLink = true
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
      opt.on('-a','desription of -a'){|v|}
      opt.on('--conf [Conf File]','Conf File for FMake. ex) rl78.conf'){|v| @Conf = v }
      opt.on('--input-xls [XLS File]','XLS File generate in Startup-Mode. ex)l13_CF1.3_Startup.xls'){|v| @Mode = "Config"; @InputXLS = v }
      opt.on('--no-link','Disenable File Link'){|v| @FileLink = false }
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:Not support  "#{ARGV}" option or need argument using this option.
EOB
      return false
    end

    # Print Help if No Argument
    if ARGV.empty?
      puts opt.help
      puts
      exit
    end

    if @Conf.nil?
      $ERROR_CNT += 1
      printf "@E:You have to set Conf File(\"-conf\" option)\n"
      Common.print_summary
      exit 1
    end

    return true
  end

  #
  # Get Conf Information
  #  param : Conf File
  #
  def get_Conf(conf)
    return FMakeConf.new( :conffile      => conf ).analyze
  end

  #
  # Get Xls Information for Conf
  #
  def get_XLS(xls)
    # File Check
    unless File.readable?(xls)
      $ERROR_CNT += 1
      printf "@E:Could not read #{xls}. please file path for file name\n"
      Common.print_summary
      exit 1
    end
    # Analyze
    xls_data = Hash.new
    book = Spreadsheet.open(xls, 'rb')
    sheet = book.worksheet(0)
    body = false
    header = nil
    sheet.each_with_index do |line,i|
      if line[0] == "No"
        # Header
        header = line
        body = true
      elsif body
        # Body
        data = Hash.new
        line.each_with_index do |n,i|
          data[NUM2COLUMN[i]] = n.to_s
        end
        xls_data[data[NUM2COLUMN[CELL::get_column("Instance Name")]]] = CELL::make_Data(data)
      end
    end
    # Summary Portion
    sheet = book.worksheet(1)
    sheet.each do |line|
      xls_data[line[1]] = line[2]
    end
    xls_data
  end

  #
  # Generate XLS
  #
  def generate_XLS(conf_db,xls_data)
    already = Array.new

    book = Spreadsheet::Workbook.new    
    @MainSheetName = make_sheet_name(conf_db)
    sheet = book.create_worksheet( :name => @MainSheetName )
    summary = book.create_worksheet( :name => "Summary" )
    # summary
    add_files = make_summary(summary,conf_db,xls_data,@SheetFile)
    add_files.each do |file|
      if File.extname(file) == ".conf"
        add_sheet(book,sheet,nil,file,already,"conf","Summary")
      elsif File.extname(file) == ".list"
        add_sheet(book,sheet,nil,file,already,"list","Summary")
      else
        add_sheet(book,sheet,nil,file,already,nil,"Summary")
      end
    end
    # header
    index = 1
    index = make_header(sheet,index)
    
    # Get Each File Data
    pre_conf_db = nil
    if @Mode == "Config"
      pre_conf_db = get_Conf(xls_data["Startup Conf File"])
      Common.make_dir("result")
      Common.make_dir("result/diff")
    end
    
    
    index += 1
    conf_db.INST.each do |inst,inf|

      # set Default Color
      CELL::set_default_cell(sheet,index)
      # Get Infromation from Comment
      comment, device_hdl, diff = get_Comment(inf.PreviousComment)
      unless pre_conf_db.nil?
        pre_device_hdl = get_Comment(pre_conf_db.INST[inst].PreviousComment)[1] unless pre_conf_db.INST[inst].nil?
      end
      # Set Comment
      CELL::set_Comment(sheet,index,comment)

      # Set Each Data
      CELL::set_No(sheet,index)
      # Set MacroType
      CELL::set_MacroType(sheet,index,@Mode,inf.MacroType,inst,xls_data)
      # Set MacroType Review
#      CELL::set_MacroTypeReview(sheet,index,@Mode,comment,inst,xls_data)
      # Set MacroType Review
      CELL::set_MacroTypeReasonForJudge(sheet,index,@Mode,comment,inst,xls_data)
      # Set Instance Name
      CELL::set_InstanceName(sheet,index,inst)
      # Set Emulation Specification
      CELL::set_EmulationSpecification(sheet,index,@Mode,inst,xls_data)



      # Set ModuleName
      CELL::set_ModuleName(sheet,index,device_hdl,inst,inf,@SheetFile)

      # Set Module Diff
      CELL::set_ModuleDiff(sheet,index,diff,@SheetFile)
      # Set Module Diff Startup
      diff_startup = CELL::set_ModuleDiffStartup(sheet,index,@Mode,@SheetFile,device_hdl,pre_device_hdl)
      # Set Verilog-HDL
      CELL::set_VerilogHDL(sheet,index,@Mode,inf,@SheetFile,inst,comment,xls_data)
      diff_replace = CELL::set_ICEHDL_Diff(sheet,index,@Mode,@SheetFile,get_InstData(conf_db,inst),get_InstData(pre_conf_db,inst))

      # Set INST_CON
      local_flag = CELL::set_ConnectFile(sheet,index,@Mode,inf,@SheetFile,inst,comment,xls_data)
      # Set Connect Diff
      diff_connect = CELL::set_ConnectFileDiff(sheet,index,@Mode,@SheetFile,get_InstData(conf_db,inst),get_InstData(pre_conf_db,inst))

      # Set Total Color
      CELL::set_TotalColor(sheet,index,@Mode,comment,local_flag,diff_replace,diff_connect)

      # For OverWrite in Sheet
      if @FileLink
        unless device_hdl.nil?
          add_sheet(book,sheet,nil,device_hdl,already)
        end
        unless diff.nil?
          add_sheet(book,sheet,nil,diff,already,"diff")
        end
        unless diff_startup.nil?
          add_sheet(book,sheet,nil,diff_startup,already,"diff")
        end
        unless diff_replace.nil?
          add_sheet(book,sheet,nil,diff_replace,already,"diff")
        end
        unless diff_connect.nil?
          add_sheet(book,sheet,nil,diff_connect,already,"diff")
        end
      end
      index += 1

    end

    # Add Seet
    if @FileLink
      conf_db.INST.each do |inst,inf|
        add_sheet(book,sheet,inst,inf.ReplaceVerilogFile,already)
        add_sheet(book,sheet,inst,inf.InstCon,already,"connect")
        add_sheet(book,sheet,inst,inf.AddInstCon,already,"connect")
      end
    end
    printf "@I:Generating Excel File. Please wait.\n"
    t1 = Thread.new do
      book.write(@XLS)
    end

    t2 = Thread.new do
      while 1
        printf "."
        sleep 2
      end
    end

    t1.join
    Thread::kill(t2)
    
  end

  def get_InstData(pre_conf_db,inst)
    if pre_conf_db.nil?
      return nil
    else
      return pre_conf_db.INST[inst]
    end
  end

  #
  # Make Sheet Name
  # 
  def make_sheet_name(conf_db)
    if conf_db.IdVer.nil?
      sheet_name = conf_db.DeviceName + "_" + conf_db.DeviceVer
    else
      sheet_name = conf_db.DeviceName + "_" + conf_db.DeviceVer + "_" + conf_db.IdVer
    end
    sheet_name
  end

  #
  # Make Header
  #
  def make_header(sheet,index)

    # Set Title & Color
    index += 2
    CELL::TITLE.each do |key,value|
      col = CELL::COLUMN[key]
      sheet[index,col] = value
      if value.nil?
        sheet.row(index).set_format(CELL::TITLE.size+1, CELL::PURE_WHITE)
      else
        sheet.row(index).set_format(col, CELL::set_color(value))
      end
      # Set Size
#      CELL::set_width(sheet,col,value)
      sheet.row(index).height = 50
    end
    # End Column
    sheet.row(1).set_format(CELL::TITLE.size+1, CELL::PURE_WHITE)
    index
  end
  
  def make_summary(sheet,conf_db,xls_data,sheetfile)
    add_files = Array.new
    row = 2
    # Used File Information
    make_summary_each(sheet,row,"Category","Information",nil,nil,CYAN)
    row += 1
    make_summary_each(sheet,row,$TOOL + "(" + $SUB_TOOL +")","ver " + $VERSION)
    row += 1
    make_summary_each(sheet,row,"Execution Command","%"+ $SUB_TOOL + ".rb " + ARGV.join(" "))
    row += 1
    make_summary_each(sheet,row,"Execution Mode", @Mode)
    row += 2

    # Used File Information
    make_summary_each(sheet,row,"File Type","File Path","TimeStamp","MD5SUM",CYAN)
    if @Mode == "Startup"
      row += 1
      file = @Conf
      make_summary_each(sheet,row,"Startup Conf File",File.expand_path(file),File::stat(file).mtime,Common.md5sum(file),nil,sheetfile)
      add_files << file
      row += 1
      file = conf_db.VERILOG_LIST
      make_summary_each(sheet,row,"Startup List File",File.expand_path(file),File::stat(file).mtime,Common.md5sum(file),nil,sheetfile)
      add_files << file
    elsif @Mode == "Config"
      row += 1
      file = @InputXLS
      make_summary_each(sheet,row,"Input XLS File",File.expand_path(file),File::stat(file).mtime,Common.md5sum(file))
      row += 1
      file = xls_data["Startup Conf File"]
      make_summary_each(sheet,row,"Startup Conf File",File.expand_path(file),File::stat(file).mtime,Common.md5sum(file),nil,sheetfile)
      add_files << file
      row += 1
      file = xls_data["Startup List File"]
      make_summary_each(sheet,row,"Startup List File",File.expand_path(file),File::stat(file).mtime,Common.md5sum(file),nil,sheetfile)
      add_files << file
      row += 1
      file = @Conf
      make_summary_each(sheet,row,"Conifg Conf File",File.expand_path(file),File::stat(file).mtime,Common.md5sum(file),nil,sheetfile)
      add_files << file
      row += 1
      file = conf_db.VERILOG_LIST
      make_summary_each(sheet,row,"Config List File",File.expand_path(file),File::stat(file).mtime,Common.md5sum(file),nil,sheetfile)
      add_files << file
    end
    add_files
  end

  def make_summary_each(sheet,row,key,value,timestamp=nil,md5sum=nil,color=nil,sheetfile=nil)
    if color.nil?
      color1 = YELLOW
      color2 = WHITE
    else
      color1 = color
      color2 = color
    end
    col = 1
    # Key
    sheet[row,col] = key
    sheet.row(row).set_format(col, color1)
    sheet.column(col).width = key.size if sheet.column(col).width < key.size 
    # Value
    col += 1
    if sheetfile != nil
      file = File.basename(value)
      sheetfile[file] = ["Summary_#{row}","#{NUM2COLUMN[col]}#{row+1}"]  if sheetfile[file].nil?
      sheet[row,col] = Spreadsheet::Link.new "", "#{value}","#{sheetfile[file][0]}!A1"
    else
      sheet[row,col] = value
    end
    sheet.row(row).set_format(col, color2)
    sheet.column(col).width = value.size if sheet.column(col).width < value.size 
    # For File
    unless timestamp.nil?
      col += 1
      str = timestamp.to_s
      sheet[row,col] = str
      sheet.row(row).set_format(col, color2)
      sheet.column(col).width = str.size if sheet.column(col).width < str.size 
    end
    unless md5sum.nil?
      col += 1
      str = md5sum.to_s
      sheet[row,col] = str
      sheet.row(row).set_format(col, color2)
      sheet.column(col).width = str.size if sheet.column(col).width < str.size 
    end
  end

  def get_Comment(ary)
    comment, device_hdl, diff = "", nil, nil
    ary.each do |str|
      case str
      when /\[\s*(.*)\s*\]/
        comment = $1.strip
      when /#\s*DeviceHDL\s*:\s*(\S+)/
        device_hdl = $1          
      when /#\s*Diff\s*:\s*(\S+)/
        diff = $1
      end
    end
    return comment, device_hdl, diff
  end


  #
  # Add Sheet ( Add Each File Infomation in New Sheet)
  #  param : target_file
  #
  def add_sheet(book,sheet,inst,target_file,already,type="verilog",return_sheet=@MainSheetName)
    max_size = 0
    unless target_file.nil?
      if inst.nil?
        sheet_name = @SheetFile[File.basename(target_file)][0]
        ret = @SheetFile[File.basename(target_file)][1]
      else
        sheet_name = @SheetFile[inst + "_" + File.basename(target_file)][0]
        ret = @SheetFile[inst + "_" + File.basename(target_file)][1]
      end
      if File.readable?(target_file) 
        if already.nil? || already.index(sheet_name).nil?
          file = target_file
          contents = Conv.new(file).main.split("\n")
          # data write
          sheet = book.create_worksheet( :name => sheet_name )
          already <<  sheet_name unless already.nil?
          printf "@I:Writing #{target_file} in Sheet #{sheet_name}\n"
          max_size = 10
          contents.each do |line|
            max_size = line.size+1 if max_size < line.size
          end        
          sheet.column(0).width = max_size
          contents.each_with_index do |line,i|
            line =  line.encode("utf-8")
            #          printf "[%04d] %s",i,line
            # Comment
            case type
            when "verilog"
              sheet.row(i).set_format(0, CELL::PURE_GRAY) if line.strip[0..1] == "//" || line.strip[0..1] == "/*" 
            when "connect","list"
              sheet.row(i).set_format(0, CELL::PURE_GRAY) if line.strip[0] == "#"
            when "conf"
              if line.strip[0] == "#"
                sheet.row(i).set_format(0, CELL::PURE_CYAN)
              else
                sheet.row(i).set_format(0, CELL::PURE_YELLOW) if /INS:/ =~ line
                sheet.row(i).set_format(0, CELL::PURE_YELLOW) if /END_INS:/ =~ line
                sheet.row(i).set_format(0, CELL::PURE_YELLOW) if /MODULE_NAME/ =~ line
                sheet.row(i).set_format(0, CELL::PURE_YELLOW) if /VERILOG_FILE/ =~ line
                sheet.row(i).set_format(0, CELL::PURE_YELLOW) if /INST_CON/ =~ line
                sheet.row(i).set_format(0, CELL::PURE_YELLOW) if /ADD_INST_CON/ =~ line
              end
            end
            # Diff Portion
            if type == "diff"
              case line.strip[0]
              when "+"
                sheet.row(i).set_format(0, CELL::PURE_YELLOW) if line.strip[0] == "+" || line.strip[0] == "-"
              when "-"
                sheet.row(i).set_format(0, CELL::PURE_CYAN) if line.strip[0] == "+" || line.strip[0] == "-"
              end
            end
            line = line.gsub("\t","   ")
            sheet[i,0] = line
          end
          sheet[contents.size+2,0] = Spreadsheet::Link.new "", "[Back]","#{return_sheet}!#{ret}"
          sheet.column(0).width = max_size
        end
      else
        $WARNING_CNT += 1
        printf "@W:Could not read #{target_file}\n"
        target_file = target_file.sub("\/04_Config\/local","02_Startup\/local_Candidate")
        if File.readable?(target_file)
          printf "@I:Change Path automatically for Startup-Mode\n"
          add_sheet(book,sheet,inst,target_file,already)
        end
      end
    end
    already
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
    printf "@I:Run Information\n"
    printf "\tExecution Mode   : #{@Mode}\n"
    printf "\tFileLink         : #{@FileLink}\n"
    printf "\tConf File(input) : #{@Conf}\n"
    printf "\tXls File(input)  : #{@InputXLS}\n" unless @InputXLS.nil?
    printf "\n"

    printf "@I:Get Conf File Information\n"
    conf_db =  get_Conf(@Conf)

    @XLS = make_sheet_name(conf_db) + "_" + @Mode + ".xls"
    printf "@I:Run Information\n"
    printf "\tXls File(output) : #{@XLS}\n"


    xls_data = nil
    unless @InputXLS.nil?
      xls_data = get_XLS(@InputXLS)
    end
    printf "@I:Generate Excel File\n"
    generate_XLS(conf_db,xls_data)
    Common.print_summary
  end
  
end


if __FILE__ == $0
  conf2xls = Conf2Xls.new
  conf2xls.main
end
