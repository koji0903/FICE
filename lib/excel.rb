$:.unshift(File.dirname(__FILE__) + "/../lib")
$:.unshift(File.dirname(__FILE__) + "/../bin")

require 'spreadsheet'

module CELL


  #
  # Sheet Setting
  #
  book = Spreadsheet::Workbook.new    
  sheet = book.create_worksheet( :name => "dummy" )

  def self.set_cell(sheet,color,border=nil)
    default_format = sheet.default_format
    cell = default_format.dup
    cell.pattern = 1
    cell.pattern_fg_color = color
    cell.border_color = :black
    cell.border = border unless border.nil?
    cell
  end

  GRAY = set_cell(sheet,:gray,:thin)
  GREEN = set_cell(sheet,:green,:thin)
  CYAN = set_cell(sheet,:cyan,:thin)
  YELLOW = set_cell(sheet,:yellow,:thin)
  WHITE = set_cell(sheet,:white,:thin)
  RED = set_cell(sheet,:red,:thin)
  PURE_WHITE = set_cell(sheet,:white)
  PURE_GRAY = set_cell(sheet,:gray)
  PURE_YELLOW = set_cell(sheet,:yellow)
  PURE_CYAN = set_cell(sheet,:cyan)
  
  #
  # Cell Setting
  #
  TITLE = {
    "A" => "No",
    "B" => "Comment",
    "C" => "MacroType\n(Startup)",
#    "D" => "MacroType\nReview\n(Startup)",
    "D" => "MacroType\nReason of Judgement\n(Startup)",
    "E" => "MacroType\n(Config)",
    "F" => "MacroType\nReason of Change\n(Config)",
    "G" => "Instance Name",
    "H" => "Emulation Specification",
    "I" => "Module Name",
    "J" => "Module Diff\n(vs DataBase)",
    "K" => "Module Diff\n(vs Startup)",
    "L" => "ICE-HDL",
    "M" => "ICE-HDL Diff\n(vs Startup)",
    "N" => "ICE-HDL\nDesign Principle",
    "O" => "ICE-HDL\nValidity(Config)",
    "P" => "Connect File\nin INST_CON",
    "Q" => "Connect File\nin ADD_INST_CON",
    "R" => "Connect File Diff",
    "S" => "Connect File\nDesign Principle\n(Startup)",
    "T" => "Connect Validity\n(Config)",
    "U" => nil,
    "V" => "Macro Control",
    "W" => "Device HDL",
    "X" => "ICE HDL",
    "Y" => "CONNECT",
    "Z" => "Design Principle(Config)",
  }

  def self.get_column(str)
    TITLE.each do |key,value|
      return COLUMN[key] if value == str
    end
  end

  def self.set_color(str)
    case str.gsub("\n","").gsub(" ","")
    when "MacroTypeReview(Startup)","MacroTypeReasonofJudgement(Startup)","EmulationSpecification","ICE-HDLDesignPrinciple","ConnectFileDesignPrinciple(Startup)"
      YELLOW
    when "MacroTypeReasonofChange(Config)","ICE-HDLValidity(Config)","ConnectValidity(Config)","MacroControl","DeviceHDL","ICEHDL","CONNECT","DesignPrinciple(Config)","ModuleDiff(vsStartup)","ICE-HDLDiff(vsStartup)","ConnectFileDiff"
      RED
    else
      CYAN
    end
  end


  COLUMN = {
    "A" => 0,
    "B" => 1,
    "C" => 2,
    "D" => 3,
    "E" => 4,
    "F" => 5,
    "G" => 6,
    "H" => 7,
    "I" => 8,
    "J" => 9,
    "K" => 10,
    "L" => 11,
    "M" => 12,
    "N" => 13,
    "O" => 14,
    "P" => 15,
    "Q" => 16,
    "R" => 17,
    "S" => 18,
    "T" => 19,
    "U" => 20,
    "V" => 21,
    "W" => 22,
    "X" => 23,
    "Y" => 24,
    "Z" => 25,
  }

  NUM2COLUMN = {
    0 => "A",
    1 => "B",
    2 => "C",
    3 => "D",
    4 => "E",
    5 => "F",
    6 => "G",
    7 => "H",
    8 => "I",
    9 => "J",
    10 => "K",
    11 => "L",
    12 => "M",
    13 => "N",
    14 => "O",
    15 => "P",
    16 => "Q",
    17 => "R",
    18 => "S",
    19 => "T",
    20 => "U",
    21 => "V",
    22 => "W",
    23 => "X",
    24 => "Y",
    25 => "Z",
  }

  #
  # Base Data Class
  # 
  class Data
    def initialize
    end
  end

  #
  # Create Data Class
  #
  def self.init_DataClass
    d = Data.new
    TITLE.each do |id,name|
      # Create Instance Variable
      d.instance_variable_set("@#{id}",nil)
      # Create Attribute (attr_accessor)
      d.class.__send__(:attr_accessor, "#{id}")
    end
    d
  end

  #
  # Crate Data
  #
  def self.make_Data(data)
    d = init_DataClass
    data.each do |key,value|
      d.instance_variable_set("@#{key}",value)
    end
    d
  end

  def self.set_width(sheet,col,str)
    sheet.column(col).width = str.size if !str.nil? && ( sheet.column(col).width <= str.size )
  end

  def self.make_diff(sheet,sheetfile,index,column,pre_files,current_files,str)
    diff_files = Array.new
    for i in 0...pre_files.size 
      pre_file = pre_files[i]
      current_file = current_files[i]

      # Modify File Path
      if pre_file != nil && File.readable?(pre_file) == false
        pre_file = pre_file.gsub("//","/").sub("/04_Config/local","/02_Startup/local_Candidate")
      end

      next if pre_file.nil? || current_file.nil?
      next if File.readable?(pre_file) == false || File.readable?(current_file) == false
      diff = nil
      unless pre_file.nil?
        diff = "result/diff/" + File.basename(pre_file) + ".diff"
      else
        diff = "result/diff/" + File.basename(current_file) + ".diff"
      end
      # unix diff
      diff_data = `diff -u #{pre_file} #{current_file}`
      if diff_data != ""
        # generate diff file
        printf("@I:generate Diff file(%s)\n",diff)
        f = open(diff,"w")
        diff_data = diff_data.kconv(Kconv::UTF8,Kconv.guess(diff_data))
        diff_data.split("\n").each do |line|
          f.printf "%s\n",line
        end
        f.close
        diff_files << diff
      end
    end
    file = nil
    if diff_files.size > 1
      # Merge Files
      file = "result/diff/" + File.basename(diff_files[0]).split(".")[0].sub("_common","").sub("_local","") + "_merge.diff"
      `cat #{diff_files.join(" ")} > #{file}`
    else
      file = diff_files[0]
    end
    unless file.nil?
      diff = File.basename(file)
      sheetfile[diff] = ["#{str}_#{index}","#{NUM2COLUMN[column]}#{index+1}"]
      sheet[index,column] = Spreadsheet::Link.new "", "Diff","#{sheetfile[diff][0]}!A1"
      sheet.row(index).set_format(column, YELLOW)
      return file
    else
      sheet[index,column] = "-"
      return nil
    end
  end

  #
  # Set Each Data
  # 
  def self.set_default_cell(sheet,index)
    for i in 0..(TITLE.size-1)
      if i == get_column(nil)
        sheet.row(index).set_format(i, PURE_WHITE)
      else
        sheet.row(index).set_format(i, WHITE)
      end
    end
  end


  def self.set_No(sheet,index)
    sheet[index,CELL::get_column(TITLE["A"])] = index - 1
    sheet.column(0).width = "100".size + 1
  end

  def self.set_Comment(sheet,index,comment)
    sheet[index,get_column(TITLE["B"])] = comment
    set_width(sheet,COLUMN["B"],comment)
  end

  def self.set_MacroType(sheet,index,mode,macro_type,inst,xls_data)
    if mode == "Startup"
      column = get_column("MacroType\n(Startup)")
      sheet[index,column] = macro_type
      set_width(sheet,column,macro_type)
    elsif mode == "Config"
      column = get_column("MacroType\n(Config)")
      startup_inst = xls_data[inst]
      unless startup_inst.nil?
        sheet[index,column-2] = startup_inst.instance_variable_get("@#{NUM2COLUMN[column-2]}")
        sheet[index,column] = macro_type
        set_width(sheet,column,macro_type)
        # "H" : Macro Type Reason for Change (Config)
        if startup_inst.instance_variable_get("@#{NUM2COLUMN[column-2]}") == macro_type
          sheet[index,column+1] = "-"
        else
          sheet[index,column+1] = "Why?"
          sheet.row(index).set_format(column, YELLOW)
          sheet.row(index).set_format(column+1, YELLOW)
        end
      else
        sheet[index,column-2] = "-"
        sheet[index,column] = macro_type
        sheet.row(index).set_format(column, YELLOW)
        sheet[index,column+1] = "Why?"
        sheet.row(index).set_format(column+1, YELLOW)
      end
    end
  end

=begin  
  def self.set_MacroTypeReview(sheet,index,mode,comment,inst,xls_data)
    if mode == "Startup"
      case comment.downcase
      when /auto/
        sheet[index,CELL::get_column(TITLE["D"])] = "-"
      when /candidate/
        sheet[index,CELL::get_column(TITLE["D"])] = "Consideration(CANDIDATE)"
        sheet.row(index).set_format(get_column(TITLE["D"]), YELLOW)
      when /not matched/
        sheet[index,CELL::get_column(TITLE["D"])] = "Consideration(Not Match)"
        sheet.row(index).set_format(get_column(TITLE["D"]), YELLOW)
      end
      set_width(sheet,COLUMN["D"],sheet[index,CELL::get_column(TITLE["D"])])
    elsif mode == "Config"
      startup_inst = xls_data[inst]
      unless startup_inst.nil?
        case comment.downcase
        when /candidate/
          sheet.row(index).set_format(get_column(TITLE["D"]), YELLOW)
        when /not matched/
          sheet.row(index).set_format(get_column(TITLE["D"]), YELLOW)
        end
        sheet[index,CELL::get_column(TITLE["D"])] = startup_inst.D
        set_width(sheet,COLUMN["D"],startup_inst.D)
      end
    end
  end
=end

  def self.set_MacroTypeReasonForJudge(sheet,index,mode,comment,inst,xls_data)
    column = get_column("MacroType\nReason of Judgement\n(Startup)")
    if mode == "Startup"
      case comment.downcase
      when /auto/
        sheet[index,column] = "-"
      when /candidate/, /not matched/
        sheet[index,column] = "Check!"
        sheet.row(index).set_format(column, YELLOW)
      end
      set_width(sheet,column,sheet[index,column])
    elsif mode == "Config"
      startup_inst = xls_data[inst]
      unless startup_inst.nil?
        case comment.downcase
        when /candidate/, /not matched/
#          sheet.row(index).set_format(column, YELLOW)
        end
        sheet[index,column] = startup_inst.instance_variable_get("@#{NUM2COLUMN[column]}")
        set_width(sheet,column,sheet[index,column])
        if startup_inst.instance_variable_get("@#{NUM2COLUMN[column]}") == "Check!"
#          sheet.row(index).set_format(column, YELLOW)
        end
      else
        sheet[index,column] = "-"
      end
    end
  end

  def self.set_InstanceName(sheet,index,inst) 
    column = get_column("Instance Name")
    sheet[index,column] = inst
    set_width(sheet,column,inst)
  end

  def self.set_EmulationSpecification(sheet,index,mode,inst,xls_data) 
    column = get_column("Emulation Specification")
    if mode == "Config"
      startup_inst = xls_data[inst]
      unless  startup_inst.nil?
        sheet[index,column] = startup_inst.instance_variable_get("@#{NUM2COLUMN[column]}")
        set_width(sheet,column,sheet[index,column])
      end
    end
  end

  def self.set_ModuleName(sheet,index,device_hdl,inst,inf,sheetfile)
    column = get_column("Module Name")
    if device_hdl.nil?
      if inf.MacroType != "Add"
        sheet[index,column] = inf.ModuleName
      elsif inf.ReplaceVerilogFile != nil
        file = inst + "_" + File.basename(inf.ReplaceVerilogFile)
#        sheetfile[file] = ["AddHDL_#{index}","J#{index+1}"]
        sheetfile[file] = ["HDL_#{index}","#{NUM2COLUMN[column]}#{index+1}"]
        sheet[index,column] = Spreadsheet::Link.new "", "#{inf.ModuleName}","#{sheetfile[file][0]}!A1"
      else
        sheet[index,column] = inf.ModuleName
      end
    else
      file = File.basename(device_hdl)
      sheetfile[file] = ["DeviceHDL_#{index}","#{NUM2COLUMN[column]}#{index+1}"]
      sheet[index,column] = Spreadsheet::Link.new "", "#{inf.ModuleName}","#{sheetfile[file][0]}!A1"
    end
    set_width(sheet,column,inf.ModuleName)
  end

  def self.set_ModuleDiff(sheet,index,diff,sheetfile)
    column = get_column("Module Diff\n(vs DataBase)")
    unless diff.nil?
      file = File.basename(diff)
      sheetfile[file] = ["ModuleDiff_DB_#{index}","#{NUM2COLUMN[column]}#{index+1}"]
      sheet[index,column] = Spreadsheet::Link.new "", "Diff","#{sheetfile[file][0]}!A1"
    else
      sheet[index,column] = "-"
    end
  end


  def self.set_ModuleDiffStartup(sheet,index,mode,sheetfile,current_data,pre_data)
    column = get_column("Module Diff\n(vs Startup)")
    sheet[index,column] = "-"
    return nil unless mode == "Config"
    return nil if current_data.nil? || pre_data.nil?
    return make_diff(sheet,sheetfile,index,column,[pre_data],[current_data],"ModuleDiff_Startup")
  end
  
  def self.set_ICEHDL_Diff(sheet,index,mode,sheetfile,current_data,pre_data)
    column = get_column("ICE-HDL Diff\n(vs Startup)")
    sheet[index,column] = "-"
    return nil unless mode == "Config"
    return nil if current_data.nil? || pre_data.nil?
    return make_diff(sheet,sheetfile,index,column,[pre_data.ReplaceVerilogFile],[current_data.ReplaceVerilogFile],"ICEHDL_Diff")
  end

  
  def self.set_VerilogHDL(sheet,index,mode,inf,sheetfile,inst,comment,xls_data)
    column = get_column("ICE-HDL")
    sheet[index,column] = "-"
    sheet[index,column+2] = "-"
    sheet[index,column+3] = "-"
    unless inf.ReplaceVerilogFile.nil?
      file = inst + "_" + File.basename(inf.ReplaceVerilogFile)
      sheetfile[file] = ["HDL_#{index}","#{NUM2COLUMN[column]}#{index+1}"]
      sheet[index,column] = Spreadsheet::Link.new "", "#{File.basename(inf.ReplaceVerilogFile)}","#{sheetfile[file][0]}!A1"
      if /auto/ !~ comment.downcase
        sheet.row(index).set_format(column, YELLOW)
        # Save Color as below
#        sheet.row(index).set_format(column+1, YELLOW)
        sheet.row(index).set_format(column+2, YELLOW)
#        sheet.row(index).set_format(column+3, YELLOW)
        if mode == "Startup"
          sheet[index,column+2] = "How?"
          sheet[index,column+3] = "Check!"
        end
        set_width(sheet,column,File.basename(inf.ReplaceVerilogFile))
      end
    end
    if mode == "Startup"
      unless inf.ReplaceVerilogFile.nil?
        if /TMP/ =~ inf.ReplaceVerilogFile
          sheet.row(index).set_format(column+2, YELLOW)
          sheet[index,column+2] = "How?"
          sheet[index,column+3] = "Check!"          
        end
      end
    end

    if mode == "Config"
      # copy
      startup_inst = xls_data[inst]
      unless startup_inst.nil?
        sheet[index,column+2] = startup_inst.instance_variable_get("@#{NUM2COLUMN[column+2]}") if startup_inst.instance_variable_get("@#{NUM2COLUMN[column+2]}") != ""
        set_width(sheet,column+2,sheet[index,column+2])
        sheet[index,column+3] = startup_inst.instance_variable_get("@#{NUM2COLUMN[column+3]}") if startup_inst.instance_variable_get("@#{NUM2COLUMN[column+3]}") != ""
        set_width(sheet,column+3,sheet[index,column+3])
      end
      # Color
      if /auto/ !~ comment.downcase
        case inf.MacroType.downcase
        when "replace","add"
          sheet.row(index).set_format(column+2, WHITE)
        end            
      end
      sheet.row(index).set_format(column+3, YELLOW) if sheet[index,column+3] != "-"
    end
  end

  def self.set_ConnectFile(sheet,index,mode,inf,sheetfile,inst,comment,xls_data)
    column = get_column("Connect File\nin INST_CON")
    local_flag = false
    color = WHITE
        
    # Initialize
    sheet[index,column] =  "-"
    sheet[index,column+1] =  "-"
    sheet[index,column+3] =  "-"
    sheet[index,column+4] =  "-"


    # For INST_CON
    unless inf.InstCon.nil?
      file = inst + "_" + File.basename(inf.InstCon)
      sheetfile[file] = ["INST_CON_#{index}","#{NUM2COLUMN[column]}#{index+1}"]
      sheet[index,column] =  Spreadsheet::Link.new "", "#{File.basename(inf.InstCon)}","#{sheetfile[file][0]}!A1"
      if /auto/ !~ comment.downcase && /_common/ !~ file.downcase
        local_flag = true
        sheet.row(index).set_format(column, YELLOW)
        color = YELLOW
      end
      case file.downcase
      when /_local/, /_tmp/
        local_flag = true
      end
      set_width(sheet,column,File.basename(inf.InstCon))
    end
    
    # For ADD_INST_CON
    unless inf.AddInstCon.nil?
      file = inst + "_" + File.basename(inf.AddInstCon)
      sheetfile[file] = ["ADD_INST_CON_#{index}","#{NUM2COLUMN[column+1]}#{index+1}"]
      sheet[index,column + 1] =  Spreadsheet::Link.new "", "#{File.basename(inf.AddInstCon)}","#{sheetfile[file][0]}!A1"
      if /auto/ !~ comment.downcase && /_common/ !~ file.downcase
        sheet.row(index).set_format(column + 1, YELLOW)
        color = YELLOW
        local_flag = true
      end
      case file.downcase
      when /_local/, /_tmp/
        local_flag = true
      end
      set_width(sheet,column+1,File.basename(inf.AddInstCon))
    end
    
    # Description
#    sheet.row(index).set_format(column+2, color)
    sheet.row(index).set_format(column+3, color)
#    sheet.row(index).set_format(column+4, color)
    
    if mode == "Startup"
      # Initialize
      if color == WHITE
        sheet[index,column+3] = "-"
        sheet[index,column+4] = "-"
      else
        sheet[index,column+3] = "How?"
        set_width(sheet,column+3,"How?")
        sheet[index,column+4] = "Check!"
#        set_width(sheet,column+3,"Check!")
      end
      unless inf.InstCon.nil?
        if /TMP/ =~ inf.InstCon
        sheet[index,column+3] = "How?"
        sheet.row(index).set_format(column + 3, YELLOW)
        sheet[index,column+4] = "Check!"
        end
      end
      unless inf.AddInstCon.nil?
        if /TMP/ =~ inf.AddInstCon
        sheet[index,column+3] = "How?"
        sheet.row(index).set_format(column + 3, YELLOW)
        sheet[index,column+4] = "Check!"
        end
      end
    elsif mode == "Config"
      # copy
      startup_inst = xls_data[inst]
      unless startup_inst.nil?
        if startup_inst.instance_variable_get("@#{NUM2COLUMN[column+3]}") == "-" && color == YELLOW
          sheet[index,column+3] = "How?"
          sheet.row(index).set_format(column+3, YELLOW)
        else
          sheet[index,column+3] = startup_inst.instance_variable_get("@#{NUM2COLUMN[column+3]}") if startup_inst.instance_variable_get("@#{NUM2COLUMN[column+3]}") != ""
        end
        
        if startup_inst.instance_variable_get("@#{NUM2COLUMN[column+4]}") == "-" && color == YELLOW
          sheet[index,column+4] = "Check!"
          sheet.row(index).set_format(column+4, YELLOW)
        else
          sheet[index,column+4] = startup_inst.instance_variable_get("@#{NUM2COLUMN[column+4]}") if startup_inst.instance_variable_get("@#{NUM2COLUMN[column+4]}") != ""
        end
        # Color
        if /auto/ !~ comment.downcase
          case inf.MacroType.downcase
          when "replace","keepchange","add"
            sheet.row(index).set_format(column+3, WHITE)
          end            
        end
        sheet.row(index).set_format(column+4, YELLOW) if sheet[index,column+4] != "-"
      else
        sheet.row(index).set_format(column+3, WHITE)
      end
      set_width(sheet,column+3,"Check!")
      set_width(sheet,column+4,"Check!")
    end
    
    local_flag
  end

  def self.set_ConnectFileDiff(sheet,index,mode,sheetfile,current_data,pre_data)
    column = get_column("Connect File Diff")
    sheet[index,column] = "-"
    return nil unless mode == "Config"
    return nil if current_data.nil? || pre_data.nil?
    return make_diff(sheet,sheetfile,index,column,[pre_data.InstCon,pre_data.AddInstCon],[current_data.InstCon,current_data.AddInstCon],"Connect_Diff")
  end

  
  def self.set_TotalColor(sheet,index,mode, comment,local_flag,diff_replace,diff_connect)
    # For Coloring of MacroType/Instance/ModuleName
    if /AUTO/ =~ comment && !local_flag
      for i in 1..(TITLE.size-1)
        if i == get_column(nil)
          sheet.row(index).set_format(i, PURE_WHITE)
        else
          sheet.row(index).set_format(i, GRAY)
        end

        case i
        when 11, 15
          unless diff_replace.nil? && diff_connect.nil?
#            sheet.row(index).set_format(i, YELLOW) if sheet[index,i] != nil && sheet[index,i].downcase != "-"
            sheet.row(index).set_format(i, YELLOW)
            sheet.row(index).set_format(i, GRAY) if  sheet[index,i].downcase == "-"
          end
        end
        sheet.row(index).set_format(i, YELLOW) if sheet[index,i] != nil && sheet[index,i].downcase == "diff"
      end
    elsif /AUTO/ =~ comment && local_flag
      for i in 1..(TITLE.size-1)
        if i == get_column(nil)
          sheet.row(index).set_format(i, PURE_WHITE)
        else 
          case sheet[index,i]
          when /_local/,/_TMP/ 
            sheet.row(index).set_format(i, YELLOW)
          end
        end
      end
    elsif /NOT Match/ =~ comment
      for i in 1..10
        case i
        when 4,5,7,9,10
          # comon skip          
        else
          sheet.row(index).set_format(i, YELLOW) if mode == "Startup"
        end
      end
#    elsif /candidate/ =~ comment.downcase
    else
      for i in 1..10
        case i
        when 8
          sheet.row(index).set_format(i, YELLOW) unless sheet[index,i] == "-"
        when 9
          sheet.row(index).set_format(i, YELLOW) if sheet[index,i].downcase == "diff"
        end
      end
    end
  end


end
