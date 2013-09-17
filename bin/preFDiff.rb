#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-

$:.unshift(File.dirname(__FILE__) + "/../lib")
require "FICE_def"
require "system"
require "common"
require "optparse"
require "FMakeConf"
require "FMakeMessage"
#
# Global Setting
#
$TOOL            = "FICE"  # Envirment Name
$SUB_TOOL        = "preFDiff" # Tool Name
$VERBOSE         = false   # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
Version          = $VERSION # For OptParse
$TEST_MODE = false


############################################################# 
#  
# Authors::   Koji HIJIKURO<koji.hijikuro@nms.necel.com>
# Copyright:: Copyright (c) 2012 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
# [Function]
# - pre-processing for FDiff
#     Change Module name to Instance Name in Expect file description
#
# [Usage]
# -%ruby preFDiff.rb --conf [Conf File] --expect_in_dir [Input Expect Files Dir] --expect_out_dir [Output Expect Files Dir]
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


#
# Main Class
#
class PreFDiff

  #
  # Expect Infomation Class
  #
  class ExpectInf
    attr_accessor :FileName
    attr_accessor :InData
    attr_accessor :OutData
    attr_accessor :ModuleName
    attr_accessor :InstName
    attr_accessor :Status
    def initialize(inf)
      @FileName = nil
      @ModuleName = nil
      @InstName = nil
      @Status = nil
      @InData = nil
      @OutData = Array.new
      
      @FileName = inf[:file_name]
      @InData = inf[:data]
      @ModuleName = inf[:module_name]
      @InstName = inf[:inst_name]
    end
    def set_status(status)
      @Status = status
    end
    def save(line)
      @OutData << line
    end
  end
  

  def initialize
    # From Option
    @ConfFile = nil
    @ExpectInDir = nil
    @ExpectOutDir = nil
    @Reverse = false
    @InExt = nil
    @OutExt = nil

    @TopModule = nil
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
      opt.on('--conf ConfFile','FMake Conf File'){|v| @ConfFile = v}
      opt.on('--expect_in_dir ExpectDir','Expect Directory for Input'){|v| @ExpectInDir = v}
      opt.on('--expect_out_dir ExpectDir','Expect Directory for Out'){|v| @ExpectOutDir = v}
      opt.on('--reverse','Convert reverse(Instannce -> Module)'){|v| @Reverse = true}
      opt.parse(ARGV)
    rescue
      $ERROR_CNT += 1
      print <<EOB
@E:Not support  "#{ARGV}" option or need argument using this option.
EOB
      return false
    end

    #-----------------------------
    # Argument Check
    #-----------------------------

    # Check Conf-File
    if @ConfFile.nil?
      $ERROR_CNT += 1
      printf "@E:You have to specify Conf File(use --conf option)\n"
      Common.print_summary
      exit
    elsif !FileTest::readable?(@ConfFile)
      FMakeMessage::PrintError( :category => "OPT", :no => 3, :file => @ConfFile, :opt => ARGV.join(" ")) 
    end

    # Check Input Expect Directory
    if @ExpectInDir.nil?
      $ERROR_CNT += 1
      printf "@E:You have to specify Expect In Directory (use --expect_in_dir option)\n"
      Common.print_summary
      exit
    elsif !FileTest.directory?(@ExpectInDir)
      $ERROR_CNT += 1
      printf "@E: \"%s\" is not directory.\n", @ExpectInDir
      Common.print_summary
      exit
    end

    # Check Output Expect Directory
    if @ExpectOutDir.nil?
      $ERROR_CNT += 1
      printf "@E:You have to specify Expect Out Directory (use --expect_out_dir option)\n"
      Common.print_summary
      exit
    else
      if FileTest.directory?(@ExpectOutDir)
        $WARNING_CNT += 1
        printf "@W:%s directory is already exist. preFDiff overwrite files saved in dir.\n", @ExpectOutDir
      end
      Common.make_dir(@ExpectOutDir)
    end

    return true
  end

  #
  # Analyze Conf
  #   param : Conf File Name
  #   ret   : ModuleName-InstanceName relation Data [Hash]
  #
  def analyze_Conf(conf_file)
    mod_inst = Hash.new # { InstanceName => ModuleName }
    inst_mod = Hash.new # { ModuleName => InstName }
    # Get Conf Information
    conf_db = FMakeConf.new( 
                            :conffile      => conf_file,
                            ).analyze
    @TopModule = conf_db.TOP_MODULE
    # for mod_inst
    conf_db.INST.each do |inst_name,value|
      if mod_inst[value.ModuleName].nil?
        # First match
        mod_inst[value.ModuleName] = [inst_name]
      else
        # Second
        tmp = mod_inst[value.ModuleName]
        tmp << inst_name
        mod_inst[value.ModuleName] = tmp
      end
    end

    # for inst_mod
    conf_db.INST.each do |inst_name,value|
      inst_mod[inst_name] = value.ModuleName
    end

    return mod_inst, inst_mod
  end

  #
  # Get Expect
  #   param : Expect Input Directory Name
  #   ret   : Expect File Information
  #
  def get_Expect(dir_name)
    inf = Hash.new
    # .expect File => warning
    Dir::glob("#{dir_name}/*.#{@OutExt}").each do |file|
      $WARNING_CNT += 1
      printf "@W:\"%s\" file is not analyzed by preFDiff. Supported extension is \".%s\".\n", file, @InExt
    end
    # .expect File => Get Infomation
    Dir::glob("#{dir_name}/*.#{@InExt}").each do |file|
      base_name = File.basename(file,".#{@InExt}")
      printf "@I: Get Expect file ( Name : %s )\n", base_name
      data = Array.new
      open(file).each do |line|
        data << line.chomp.strip
      end
      inf[base_name] = ExpectInf.new( 
                                     :file_name => file, 
                                     :data => data 
                                     )
    end
    inf
  end
  
  #
  # Convert from Module to Inst 
  #   param : Module-Inst Inf
  #           ExpectBase Inf ( {ModuleName => FileData } )
  #   ret   : Converted ExpectBase
  #
  def convert_Mod2Inst(mod_inst,expect)
    expect.each do |base_name,inf|
      if $VERBOSE
        printf "--------------------------------------\n"
        printf " %s\n",inf.FileName
        printf "--------------------------------------\n"
      end

      inf.ModuleName = base_name
      inf.InstName = mod_inst[base_name]

      if inf.InstName.size == 1
        inf.InData.each_with_index do |line,line_no|
          new_line = nil
          status = nil
          if /^#/ =~ line
            # Skip for Comment Line
            status = "COMMENT"
          elsif line.size == 0
            # Skip for Brank Line
            status = "BRANK  "
          else
            status = "ENABLE "
            inst_name = inf.InstName[0]
            ary = line.split
            if ary[0].split(".").size != 1
              $ERROR_CNT += 1
              printf "@E:Cannot Convert \"%s\" (%s[L:%d])\n",line,inf.FileName,line_no
              printf "   It is maybe Expect File. (Not Expect_base File).\n"
              Common.print_summary
              exit
            else
              ary[0] = inst_name + "." + ary[0]
              target_module = get_BaseName(ary[2])
              target_inst = mod_inst[target_module]
              if target_inst != nil
                target_inst.each do |target_inst_each|
                  if ary[1] == "<-" && target_inst.size != 1
                    $WARNING_CNT += 1
                    printf "@W:Cannot convert about \"%s\". Becuase of multiple instances.\n",line
                  else
                    ary[2] = ary[2].sub(target_module,target_inst_each)
                    new_line = ary.join("\t")
                    printf "From:%s\n", line if $VERBOSE
                    printf "To  :%s\n", line if $VERBOSE
                    # Save
                    inf.save(new_line)
                  end
                end
              else
                ary = resolve_Dist(ary)
                new_line = ary.join("\t")
                inf.save(new_line)              
              end
            end
          end
          # Print Message
          if $VERBOSE
            printf "[%s] %s\n",status,new_line
          end
        end
      else
        # Can not convert
        $WARNING_CNT += 1
        printf "@W:%s module is used over two instances in this product. Cannot convert.\n",inf.ModuleName
        inf.Status = "NotGenerate"
      end
    end
    expect
  end

  #
  # Convert from Inst to Module 
  #   param : Inst-Module Inf
  #           Expect Inf ( {InstName => FileData } )
  #   ret   : Converted ExpectBase
  #
  def convert_Inst2Mod(inst_mod,expect)
    expect.each do |base_name,inf|
      if $VERBOSE
        printf "--------------------------------------\n"
        printf " %s\n",inf.FileName
        printf "--------------------------------------\n"
      end


      inf.InstName = base_name
      inf.ModuleName = inst_mod[base_name]
      inf.InData.each_with_index do |line,line_no|
        status = nil
        if /^#/ =~ line
          # Skip for Comment Line
          status = "COMMENT"
        elsif line.size == 0
          # Skip for Brank Line
          status = "BRANK  "
        else
          status = "ENABLE "
          printf "From:%s\n", line if $VERBOSE
          # operation
          ary = line.split
          if ary[0].split(".").size == 1
            $ERROR_CNT += 1
            printf "@E:Cannot Convert \"%s\" (%s[L:%d])\n",line,inf.FileName,line_no
            printf "   It is maybe Expect Base File. (Not Expect File).\n"
            Common.print_summary
              exit
          else
            ary[0] = get_OnlySignal(ary[0])
            target_inst = get_BaseName(ary[2])
            target_module = inst_mod[target_inst]
            
            #          ary = pin2term(ary)
            
            # Convert
            if target_module != nil
              ary[2] = ary[2].sub(target_inst,target_module)
            end
            line = ary.join("\t")
            printf "To  :%s\n", line if $VERBOSE
            
            # Save
            inf.save(line)
          end
        end
        # Print Message
        if $VERBOSE
          printf "[%s] %s\n",status,line
        end
      end
    end
    expect
  end

  # ex ) "a.b.c" -> ret "c"
  def get_OnlySignal(str)
    return str.split(".").last
  end
  # ex ) "a.b.c" -> ret "a.b"
  def get_BaseName(str)
    tmp = str.split(".")
    tmp.delete_at(tmp.size-1)
    return tmp.join(".")
  end
  # ex ) R5F10PMFJ.CLK30 -> IN_PIN
  def pin2term(ary)
    if /^#{@TopModule}./ =~ ary[2]
      case ary[1]
      when "->"
        ary[2] = "OUT_PIN" 
      when "<-"
        ary[2] = "IN_PIN"
      when "<->"
        ary[2] = "IO_PIN"
      end
    end
    return ary
  end
  def resolve_Dist(ary)
    case ary[2]
    when %r(\d+\'[hb]\d+),"OPEN"
      return ary      
    when "IN_PIN","OUT_PIN","IO_PIN"
      ary[2] = @TopModule + "_EVA." + get_OnlySignal(ary[0])      
    end
    return ary
  end

  #
  # Geneate New Expect File
  #
  def generate(expect)
    # Generate
    Common.make_dir_with_delete(@ExpectOutDir)

    # Duplicate Module Check
    if @Reverse
      already_module = Array.new
      expect.each do |key,value|
        unless already_module.index(value.ModuleName).nil?
          $WARNING_CNT += 1
          printf "@W:%s module is used over two instances in this product. Not support in this case, dont generate expect_base.\n",value.ModuleName
          value.Status = "NotGenerate"
        end
        already_module << value.ModuleName
      end
    end


    expect.each do |key,value|
      next if value.Status == "NotGenerate"
      if @Reverse
        file = [value.ModuleName]
        comment = "Expect Base File ( In case of using FDiff, you have to need Convert to expect )" 
      else
        file = value.InstName
        comment = "Expect File for FDiff" 
      end
      if file == []
        printf "internal error\n"
        exit
      end

      file.each do |each_file|
        file_name = @ExpectOutDir + "/" + each_file + "." + @OutExt
        
        printf("@I:generate Expect file(%s)\n",file_name)    
        f = open(file_name,"w")
        Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")
        f.printf "\n"
        value.OutData.uniq.each do |line|
          f.printf "%s\n",line
        end
        f.printf "\n"
        f.close
      end
    end
  end

  #
  # Main Function
  #  1. Get Argument
  #  2. Analyze Conf ( get Module/Instance Information )
  #  3. Get Expect   ( get Expect Information )
  #  4. Convert Expect Using No2/No3 Inf.
  #  5. Generate New Expect Files
  #
  public
  def main
    Common.print_base
    
    #  1. Get Argument
    get_argument

    if @Reverse
      @InExt = "expect"
      @OutExt = "expect_base"
    else
      @InExt = "expect_base"
      @OutExt = "expect"
    end

    #  2. Analyze Conf ( get Module/Instance Information )
    mod_inst,inst_mod = analyze_Conf(@ConfFile)
    #  3. Get Expect   ( get Expect Information )
    expect_in = get_Expect(@ExpectInDir)
    #  4. Convert Expect Using No2/No3 Inf.
    if @Reverse
      expect_out = convert_Inst2Mod(inst_mod,expect_in)
    else
      expect_out = convert_Mod2Inst(mod_inst,expect_in)
    end
    #  5. Generate New Expect Files
    generate(expect_out)


    Common.print_summary
  end
  
end


if __FILE__ == $0
  preFDiff = PreFDiff.new
  preFDiff.main
end
