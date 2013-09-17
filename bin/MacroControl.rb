#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-
#############################################################
#
# MacroControl
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2009-2012 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - Control MacroControl.conf
#
# [Usage]
# -%ruby MacroControl.rb
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
require "FICE_def"
require "system"
require "common"
require "optparse"
require "pp"
require "spreadsheet"
require 'digest/md5'

#
# Global Setting
#
$SUB_TOOL        = "MacroControl" # Tool Name
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
class MacroControl
  attr_accessor :SET, :DIR, :MACRO
  
  def initialize
    @Git = "/home/product/div-micom-ice/data/proj/RL78/Common/local/git/bin/git"
    if $DEBUG
      @MacroControlFile = "/design01/iecube_rl78/Common/FMakeFiles/Control/trunk/MacroControl.xls"
    else
      @MacroControlFile = "/design01/iecube_rl78/Common/FMakeFiles/Control/latest/MacroControl.xls"
    end

    @SET = Hash.new
    # MySelf
    if $DEBUG
      @DIR = { "${MC}" => ["MACRO_CONTROL","/design01/iecube_rl78/Common/FMakeFiles/Control/trunk"]}
    else
      @DIR = { "${MC}" => ["MACRO_CONTROL","/design01/iecube_rl78/Common/FMakeFiles/Control/latest"]}
    end
    # FPGA_BASE
    @DIR["${FB}"] = ["FPGA_BASE","/design01/iecube_rl78/Products/BASE/latest"]
    @MACRO = MacroInf.new
    @MACRO_for_Check = MacroInf.new

    @Element = Array.new
    @ElementMaxSize = 0
    @macro_inf_base = MacroInfBase.new
  end

  class MacroInf
    attr_accessor :List
    def initialize
      @List = Array.new
    end
    def add(inf)
      @List << inf
    end

    #
    # Check Macro
    #  Function : Check File readable 
    #  param    : macro
    #
    def check(element)
      # Get MD5SUM Index
      md5sum_index = Array.new
      element.each_with_index do |elem,i|
        if /MD5SUM/ =~ elem
          md5sum_index << i
        end
      end

      # Check File readable
      printf "@I:Checking readable and md5sum for all Files ... \n"
      @List.each do |inf|
        # Readable
        inf.instance_variables.each do |val|
          str = inf.instance_variable_get(val)
          if /\// =~ str.to_s && /\$/ !~ str.to_s
            unless File.readable?(str)
              $ERROR_CNT += 1
              printf "@E:Could not read \"#{str}\" (Line:#{inf.Line})\n"
            else
              printf " - #{str} : OK\n"
            end
          end
        end
        # MD5SUM
        md5sum_index.each do |num|
          file = inf.instance_variable_get("@#{ element[num-1]}")
          md5sum = inf.instance_variable_get("@#{ element[num]}")
          next if file.nil? || file.downcase == "none"
          next if md5sum.downcase == "none"
          next unless File.readable?(file)
          if /\// =~ file.to_s && /\$/ !~ file.to_s
              if Common.md5sum(file).to_s != md5sum.to_s
                $ERROR_CNT += 1               
                printf "@E:Unmatch MD5SUM about #{file} ( #{Digest::MD5.hexdigest(File.open(file,"rb").read)}  <=> #{md5sum}) . Please Check Inf (Line:#{inf.Line})\n"
              end
          end
        end
      end
      printf "Done.\n\n"

      printf "@I:Registerd Macro Information\n"
      total_num = 0
      @List.each do |inf|
        key = inf.Category
        @List.instance_variable_set("@#{key}_num",0)
        @List.class.__send__(:attr_accessor, "#{key}_num")
        total_num += 1
      end

      # Set Size
      @List.each do |inf|
        key = inf.Category
        num = @List.instance_variable_get("@#{key}_num")
        @List.instance_variable_set("@#{key}_num", num + 1)
      end

      # print
      category = Hash.new
      @List.each do |inf|
        key = inf.Category
        next unless category[key].nil?
        category[key] = @List.instance_variable_get("@#{key}_num")
      end
      category.each do |key,value|
#        printf " - #{key} : #{value}/#{total_num}\n"
        printf "  - %s : %3d/%3d\n",key,value,total_num
      end
      printf "Done.\n\n"

      if __FILE__ == $0
        Common.print_summary
      end

    end


  end
  # Base
  class MacroInfBase
    def initialize
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
      opt.on('-a','desription of -a'){|v|}
      opt.on('-b VAL','description of -b'){|v|}
      opt.on('-c [VAL]','description of -c'){|v|}
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
  
  def get_MacroControlInf(file)

    printf "\n"
    printf "@I:Get Macro Control Inf from #{file}\n"
    printf "\n"
    book = Spreadsheet.open(file, 'rb')
    sheet = book.worksheet(0)

#    open(file).each_with_index do |line_org,i|
    sheet.each_with_index do |n,i|
      i += 1 # For Line Number
      j = 0
      col = Array.new
      while (!n[j].nil?)
        col << n[j]
        j += 1
      end
#      line = line_org.strip
#      col = line.gsub("\"","").split(",")
      case col[0]
      when "",nil
        # Brank Line
        category = "BRANK"
      when /^Category/
        # Comment Line
        category = "Element"
        analyze_Element(col,i)
      when /^#/
        # Comment Line
        category = "COMMENT"
      when /SET/
        # SET
        category = "SET"
        analyze_SET(col,i)
      when /DIR/
        # Directory
        category = "DIR"
        analyze_DIR(col,i)        
      else
        category = "MACRO"
        analyze_MacroLine(col,i)
      end
      # Print Line Information
      if $VERBOSE
        printf "[%04d:%10s] %s\n", i,category,col.join(",")
      end
    end

    printf "@I:Setting Information\n"
    printf " [SET]\n"
    @SET.each do |key,value|
      printf "  - #{key} : #{value}\n"
    end
    printf "\n"
    @DIR = get_CommonVer
    printf " [DIR]\n"
    @DIR.each do |key,value|
      printf "  - #{key} : #{value}\n"
    end
    printf "\n"
    @MACRO_for_Check.check(@Element)
  end

  #
  # Analyze Element
  #   - analyze element in XLS and make Class Variable with attr_accessor
  #
  def analyze_Element(col,i)
    @ElementMaxSize = col.size
    col[@ElementMaxSize] = "Line"
    col.each_with_index do |str,num|
      # for Index
      @Element << str
      # for Macro Inf Class
      @macro_inf_base.instance_variable_set("@#{str}",nil)
      @macro_inf_base.class.__send__(:attr_accessor, "#{str}")
    end
  end

  #
  # Analyze SET Line
  #
  def analyze_SET(col,i)
    key = col[1]
    value = col[2]
    # Syntax Check
    if key.nil? || value.nil?
      $ERROR_CNT += 1
      printf "@E:Syntax Error( Line : %d )\n",i
    end
    if @SET[key].nil?      
      @SET[key] = value
    else
      $WARNING_CNT += 1
      printf "@W: Found multiple set about \"$s\". Overwrite \"%s\"",key,value
    end
  end

  #
  # Analyze DIR
  #
  def analyze_DIR(col,i)
    name = col[1]
    dir = resolve_SET(col[2])
    @DIR[col[2]] = [name,dir]
  end

  #
  # Analylze KeepKeep
  #
  def analyze_MacroLine(col,i)
    inf = Marshal.load(Marshal.dump(@macro_inf_base))
    inf_for_check = Marshal.load(Marshal.dump(@macro_inf_base))
    col[@ElementMaxSize] = i
    col.each_with_index do |str,num|
      inf.instance_variable_set("@#{@Element[num]}",str)
      inf_for_check.instance_variable_set("@#{@Element[num]}",resolve_SET(str))
    end
    @MACRO.add(inf)
    @MACRO_for_Check.add(inf_for_check)
  end

  #
  # Check Directory
  #  Function : Check Exist and real Version
  #  param    : dir_list
  #
  def get_CommonVer(dir_list=@DIR)
    printf "@I:Get Version of Common Control Files.\n"
    dir_list.each_value do |inf|
      name = inf[0]
      path = inf[1]
      real_path = get_RealPath(path)
      inf << real_path
      ver = real_path.split("/").last
      printf "\n"
      printf " %-20s : %s (%s)\n",name,ver,real_path
      current_dir = Dir::pwd
      Dir.chdir(real_path)
      begin
        if FileTest::directory?("./.git")          
          result = `#{@Git} log  --graph --date-order -C -M --pretty=format:"<%h> %ad [%an] %s" -n 1 --date=short `
          printf " [Git Inf] #{result}\n"
#          result = `#{@Git} log  --graph --date-order -C -M --pretty=format:"<%h> %ad [%an] %Cgreen%d%Creset %s" -n 1 --date=short `
        end
      rescue
      end
      Dir.chdir(current_dir)
    end
    return dir_list
  end


  #
  # Resolve Set Variable
  #  Param : str - original string
  #          set - {"Name"=>"Resvole String"}
  #  Ret   : str - resolved string
  #
  public
  def resolve_SET(str,set=@SET)
    return str unless str.class == String
    while ( /^\$\{(\w*)\}/ =~ str ) != nil
      set_str = $1
      expand_str = set[set_str]
      unless expand_str.nil?
        str = str.sub(/\$\{#{set_str}\}/,expand_str)
      else
        return str
      end
    end 
    str
  end

  #
  # Get Real Path
  #  Funk : Resolve Synbolic Link
  #
  def get_RealPath(path)
    if File.exist?(path)      
      if File.ftype(path) == "link" && /\./ !~ path.split("/").last
        scope =  `ls -l #{path}`.split.last
        tmp = path.split("/")
        tmp[tmp.size-1] = scope
        get_RealPath(tmp.join("/"))
      else
        path = path.gsub("\/.\/","\/")
        return path
      end
    else
      printf "@E: %s does not exist or cannot access.\n",path
      return path
    end
  end

  #
  # Main Function
  #  1. 
  #  2. 
  #
  public
  def main
    Common.print_base
#    get_argument
#    Common.print_summary
    get_MacroControlInf(@MacroControlFile)
  end

  def get
    get_MacroControlInf(@MacroControlFile)
    return true
  end
  
  def search(file,inst_name,mod_name,md5sum,diff_dir)
    type = nil
    diff = nil
    match_inst = false
    match_module = false
    match_md5sum = false
    match_inf = nil
    db_module = nil
    db_md5sum = nil
    @MACRO.List.each do |inf|
      next if inf.Category == "AF"
      if /^#{inf.DeviceInstanceName}$/ =~ inst_name
        match_inst = true
        db_module = inf.DeviceModuleName
        db_md5sum = inf.DeviceHDL_MD5SUM
        type = inf.Category
        if /^#{inf.DeviceModuleName}$/ =~ mod_name || inf.DeviceModuleName == "ANY"
          match_module = true
          if inf.DeviceHDL_MD5SUM == md5sum || inf.DeviceModuleName == "ANY" ||  virtual_check(file,md5sum,inf,mod_name,diff_dir)[0]
            match_md5sum = true
            match_inf = inf
          else
            if match_inf.nil?
              match_inf = inf
            elsif !match_md5sum ||  virtual_check(file,md5sum,match_inf,mod_name,diff_dir)[0]
              match_inf = inf
            end
          end
        else
          if match_inf.nil?
            match_inf = inf
          elsif !match_module
            match_inf = inf
          end
        end
      else
        case inf.Category
        when "PB","RM"
          if inf.DeviceModuleName == mod_name
            match_inst = true
            db_module = inf.DeviceModuleName
            db_md5sum = inf.DeviceHDL_MD5SUM
            type = inf.Category 
            match_module = true
            if inf.DeviceHDL_MD5SUM == md5sum
              match_md5sum = true
            end
            match_inf = inf
            #          break
          end
        end
      end
    end
    
    unless match_inf.nil?
      db_module = match_inf.DeviceModuleName
      db_md5sum = match_inf.DeviceHDL_MD5SUM
    end

    printf "  - type : #{type}\n"
    printf "  - module match? : #{match_module} ( Target : #{mod_name}, DB : #{db_module})\n"
    if File.basename(file) != "virtual.v"
      printf "  - md5sum match? : #{match_md5sum} ( Target : #{md5sum}, DB : #{db_md5sum})\n"
    else
      printf "  - md5sum match? : #{match_md5sum} ( Special Diff for virtual.v )\n"
    end
    
    # Generate Diff File
    if File.basename(file) != "virtual.v"
      if ( ( match_inst == true && match_md5sum == false && match_inf != nil  && ( Common.md5sum("#{resolve_SET(match_inf.DeviceHDL)}") != Common.md5sum("#{file}") )) || ( match_inst == true && match_inf != nil && match_inf.DeviceModuleName == "ANY" && ( Common.md5sum("#{resolve_SET(match_inf.DeviceHDL)}") != Common.md5sum("#{file}") )))
        diff = diff_dir + "/" + mod_name + ".diff"
        if FileTest.readable?(resolve_SET(match_inf.DeviceHDL)) && FileTest.readable?(file)
          `diff -ub #{resolve_SET(match_inf.DeviceHDL)} #{file} > #{diff}`
        end   
      end    
    else
      unless virtual_check(file,md5sum,match_inf,mod_name,diff_dir)[0]
        diff = virtual_check(file,md5sum,match_inf,mod_name,diff_dir)[1]
      end
    end

    if match_inf.nil?
        regexp = false
    else 
      if match_inf.DeviceModuleName == "ANY"
        regexp = true
      elsif match_inf.DeviceModuleName != mod_name && /^#{match_inf.DeviceModuleName}$/ =~ mod_name
        regexp = true
      else
        regexp = false
      end
    end


    return type,match_module,match_md5sum,match_inf,diff,regexp
  end
  
  def search_AF(file,inst_name,mod_name,md5sum,diff_dir)
    type = nil
    diff = nil
    match_inst = false
    match_module = false
    match_md5sum = false
    match_inf = nil
    db_module = nil
    db_md5sum = nil
    @MACRO.List.each do |inf|
      next if inf.Category != "AF"
      if /^#{inf.DeviceInstanceName}$/ =~ inst_name
        match_inst = true
        db_module = inf.DeviceModuleName
        db_md5sum = inf.DeviceHDL_MD5SUM
        type = inf.Category        
        if /^#{inf.DeviceModuleName}$/ =~ mod_name || inf.DeviceModuleName == "ANY"
          match_module = true
          if inf.DeviceHDL_MD5SUM == md5sum || inf.DeviceModuleName == "ANY" || virtual_check(file,md5sum,inf,mod_name,diff_dir)[0]
            match_md5sum = true
            match_inf = inf
          else
            if match_inf.nil?
              match_inf = inf
            elsif !match_md5sum ||  virtual_check(file,md5sum,match_inf,mod_name,diff_dir)[0]
              match_inf = inf
            end
          end
        else
          if match_inf.nil?
            match_inf = inf
          elsif !match_module
            match_inf = inf
          end
        end
      end
    end
    if type == "AF"
      printf "  - type : #{type}\n"
      printf "  - module match? : #{match_module} ( Target : #{mod_name}, DB : #{db_module})\n"
      if File.basename(file) != "virtual.v"
        printf "  - md5sum match? : #{match_md5sum} ( Target : #{md5sum}, DB : #{db_md5sum})\n"
      else
        printf "  - md5sum match? : #{match_md5sum} ( Special Diff for virtual.v )\n"
      end
      
      # Generate Diff File
      if File.basename(file) != "virtual.v"
        if match_inst == true && match_md5sum == false && match_inf != nil
          diff = diff_dir + "/" + mod_name + ".diff"
          if FileTest.readable?(resolve_SET(match_inf.DeviceHDL)) && FileTest.readable?(file)
            `diff -ub #{resolve_SET(match_inf.DeviceHDL)} #{file} > #{diff}`
          end
        end
      else
        unless virtual_check(file,md5sum,match_inf,mod_name,diff_dir)[0]
          diff = virtual_check(file,md5sum,match_inf,mod_name,diff_dir)[1]
        end
      end
    end

    if match_inf.nil?
        regexp = false
    else 
      if match_inf.DeviceModuleName == "ANY"
        regexp = true
      elsif match_inf.DeviceModuleName != mod_name && /^#{match_inf.DeviceModuleName}$/ =~ mod_name
        regexp = true
      else
        regexp = false
      end
    end

    return type,match_module,match_md5sum,match_inf,diff,regexp
  end
  
  def virtual_check(file,md5sum,inf,mod_name,diff_dir)
    return false,nil if inf.nil?
    if File.basename(file) == "virtual.v"
      diff = module_diff(file,resolve_SET(inf.DeviceHDL),mod_name,diff_dir)
      if diff.nil?
        return true,nil
      else
        return false,diff
      end
    else
      return false,nil
    end
  end
  
  
  def module_diff(file_a,file_b,module_name,diff_dir)
    file_a_data = pickup_module(file_a,module_name)
    file_b_data = pickup_module(file_b,module_name)
    
    new_file_a = "virtual_Devince.v"
    new_file_b = "virtual_DB.v"
    
    # Generate file_a
    f = open(new_file_a,"w")
    file_a_data.each do |line|
      f.printf "#{line}\n"
    end
    f.close
    # Generate file_b
    f = open(new_file_b,"w")
    file_b_data.each do |line|
      f.printf "#{line}\n"
    end
    f.close
    # diff
    if file_a_data != file_b_data
      diff = diff_dir + "/virtual_#{module_name}.diff"
      `diff -ub #{new_file_b} #{new_file_a} > #{diff}`  
    else
      diff = nil
    end
    FileUtils.rm(new_file_a)
    FileUtils.rm(new_file_b)
    return diff
  end
  
  
  def pickup_module(file,target_module_name)
    contents = Conv.new(file).main.split("\n")
    module_flag = false
    module_line = Array.new
    contents.each do |line|    
      if /^\s*module\s+(\w*)\s*\(/ =~ line
        module_name = $1.strip
      elsif /^\s*module\s+(\w*)\s*$/ =~ line
        module_name = $1.strip
      end
      if target_module_name == module_name
        module_flag = true
        module_line << line
      elsif module_flag
        module_line << line
      end
      if /^\s*endmodule$/ =~ line
        module_flag = false
      elsif /^\s*endmodule\s+/ =~ line
        module_flag = false
      elsif /^\s*endmodule\/$/ =~ line
        module_flag = false
      end
    end
    return module_line
  end
  
end

  



if __FILE__ == $0
  macro_control = MacroControl.new
  macro_control.main
end
