########################################################################
#
# Operation for make_chip "parts" file
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#    Date     : Dec 10, 2009
#    Function : Refer to following HP
#       http://nqacs216.nms.necel.com/common_wiki/index.php?MakeChip#n39ed659
#    Version  : 0.1
#
#    History
#     - 0.1(Dec 10, 09): First release
# 
########################################################################
#
#  Class Name : Parts
#  
#  [Method]
#   read          : read "make_chip.report_ice" file
#   pre_operation : operation file modification
#   print         : print reportICE structure
#     - print/print_pullup/print_pulldown/print_opennet/print_connection
#
#  [Data Structure]
#    INSData  { key: instance name, value : module name, macro type }
#    HardList [Hard Macro Name]
#    SoftList [Soft Macro Name]
#
########################################################################
require "message"
require "fileutils"
require "common"

class MacroInfo
  attr_accessor :Type
  attr_accessor :File
  def initialize
    @Type = nil
    @File = nil
  end
end

class InsInfo
  attr_accessor :InstName
  attr_accessor :ModuleName
  attr_accessor :ModuleType
  attr_accessor :Macro
  attr_accessor :Ext
  def initialize
    @InstName   = nil
    @ModuleName = nil
    @ModuleType = nil
    @Macro      = Array.new
    @Ext   = Array.new
  end
end

class PartsAll
  attr_accessor :Product
  attr_accessor :Version
  attr_accessor :Macro
  def initialize
    @Product = nil
    @Version = nil
    @Macro = Array.new
  end
end

class Parts < Message

  attr_accessor :Parts
  attr_accessor :INSInfo
  #
  # initialize
  #
  def initialize(readfile="")
    @read_file = readfile
    @SRC_DIR = "./src"
    @PartsData = Array.new # save file data

    @Parts = Hash.new
    @INSInfo = Hash.new

  end

  #
  # file read
  #
  def read
    @PartsData = Common.file_read(@read_file)
  end

  #
  # pre_operation
  #
  def pre_operation
    printf("@I:Pre-operation\n")
    include_file_set = false
    ins_mode = false
    line_cnt = 0
    ins_info = InsInfo.new
    parts_info = PartsAll.new
    @PartsData.each{|line|
      line_cnt += 1
      # delete comment
      line = Common.remove_after(line,"//")
      next if line == nil
      if /^INCLUDE_FILE/ =~ line
        /^INCLUDE_FILE:\s+(\S*)\s+(\S*)$/ =~ line
        if $VERBOSE
          printf("INCLUDE_FILE :[L:%4d]%s\n",line_cnt,line)
          printf("             :   - %s\n", $1)
        end
        parts_info.Product = $1; parts_info.Version = $2 ; include_file_set = true
      elsif /^\/\// =~ line
        if $VERBOSE
          printf("Comment      : %s\n",line)
        end
      elsif /^\s*INS:/ =~ line
        /^INS:\s+(\S*)\s+(\S*)\s+(\S*)\s+(\S*)/ =~ line
        if $VERBOSE
          printf("INS          :[L:%4d]%s\n",line_cnt,line)
          printf("             :   - %s\n", $1)
          printf("             :   - %s\n", $2)
          printf("             :   - %s\n", $3)
          printf("             :   - %s\n", $4)
        end
        ins_mode = true
        ins_info = InsInfo.new
        ins_info.InstName = $1
        ins_info.ModuleName = $2
        ins_info.ModuleType = $4
      elsif /^\s*MACRO:/ =~ line
        /^\s+MACRO:\s+(\S*)\s+(\S*)\s*/ =~ line            
        if $VERBOSE == true
          printf("MACRO        :[L:%4d]%s\n",line_cnt,line)
          printf("             :   - %s\n", $1)
          printf("             :   - %s\n", $2)
        end
        if ins_mode == false
          macro_info = MacroInfo.new
          macro_info.Type = $1
          macro_info.File = $2
          ins_info.Ext << macro_info
          parts_info.Macro << macro_info
        else
          macro_info = MacroInfo.new
          macro_info.Type = $1
          macro_info.File = $2
          ins_info.Macro << macro_info
        end
      elsif /^END_INS:/ =~ line
        if $VERBOSE == true
          printf("END_INS      :[L:%4d]%s\n",line_cnt,line)
        end
        ins_mode = false
        @INSInfo["#{ins_info.InstName}"] = ins_info
      elsif /^/ =~ line
        if $VERBOSE == true
          printf("NON          :[L:%4d]%s\n",line_cnt,line)
        end
      else
        $WARNING_CNT += 1
        printf("@W-parts001: Unexpected line \"%s\" was described.\n", line)
      end      
    }
    
    @Parts = parts_info
    printf("@I:Pre-Operation Done\n")
  end
  
  #
  # collect files
  #   - expand the data path including MACRO files
  #   - collect files defined MACRO path to work direcotry
  #
  def collect_files(set)
    printf("@I:Collect Files\n")
    
    # Make Director
    Common.make_dir("#{@SRC_DIR}")
    printf("@I:Make direcory to save src- %s\n",@SRC_DIR)
    @set = set
    
    # Expand Path
    @MACROData.each do |tmp|
      tmp2 = tmp[1]
      tmp2.each do |tmp3|
        result = /^\$\{(\w*)\}.*/ =~ tmp3[1]
        if result == 0
          path = @set["#{$1}"]
          if path == nil
            $ERROR_CNT += 1
            printf("@E:Not found environment path\(\$\{%s\}\), pleae chek parameter file\n",$1)
            print_summary
            exit
          end
          macro = "${" + $1 + "}"
          tmp3[1] = tmp3[1].sub("#{macro}","#{path}")
        end
      end
    end
    
    # Copy files to work direcotry & make Readme.txt
    readme = @SRC_DIR + "/00Readme.txt"
    f = open(readme,"w")
    print_file_header(f,"Copied files from parts file")
    f.printf("#\n");
    f.printf("# Execute Information\n")
    f.printf("#\n")
    f.printf("# [PARAMETER]");f.printf("%s\n",$PARAMETER_FILE) 
    f.printf("# [REPORT   ]");f.printf("%s\n",$REPORT_FILE) 
    f.printf("# [PARTS    ]");f.printf("%s\n",$PARTS_FILE) 
    f.printf("# [CONNECT  ]");f.printf("%s\n",$CONNECT_FILE) 
    f.printf("#\n");
    @MACROData.each do |tmp|
      tmp2 = tmp[1]
      tmp2.each do |file|
        if File::exists?(file[1]) == true
          FileUtils.install(file[1],@SRC_DIR + "/"  + File.basename(file[1]), :mode => 0400 )
          f.printf("[MACRO Name]%s: %s\n", tmp[0], file[1])
        else
          $WARNING_CNT += 1
          printf("@W-parts001:%s is not exist\n",file[1])
          f.printf("[MACRO Name]%s: %s\n -!!CAUTION!!There is no original file.\n", tmp[0],file[1])
        end
      end
    end
    f.close
    if $VERBOSE == true
      printf("@I:Print copied file\n")
      system ("ls -al #{@SRC_DIR}")
    end
    
    printf("@I:Collect Files Done\n")
    
  end
  
  #
  # 
  # 
  def main
    printf("\nParts operation\n")
    read
    pre_operation
  end
  
end
