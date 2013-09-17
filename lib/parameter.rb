########################################################################
#
# Operation for make_chip "Parameter" file
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#    Date     : 2009/07/27
#    Function : Refer to following HP
#       http://nqacs216.nms.necel.com/common_wiki/index.php?MakeChip#n39ed659
#    Version  : 1.0
#
#    History  :
#      1.0 - first make
#
########################################################################
#
#  Class Name : Parameter
#  
#  [Method]
#   read          : read "Parameter" file
#   pre_operation : operation file modification
#   print         : print connect structure
#
#  [Data Structure]
#
########################################################################
require "message"

class Product
  attr_accessor :name
  attr_accessor :version
end

class Name
  attr_accessor :str
end

class NamePath
  attr_accessor :name
  attr_accessor :path
end



class Parameter  < Message
  attr_accessor :set
  #
  # initialize
  #
  def initialize(readfile="#{$PARAMETER_FILE}")
    @read_file = readfile
    @FileData  = Array.new

    # Data Structure
    @product = Product.new  
    @designer = Name.new
    @set_val = NamePath.new  
    @set = {}
    @date = Name.new
    @process = Name.new
    @uln = NamePath.new
    @frontend_val = NamePath.new
    @frontend = {}
    @libinfo = Name.new
    @include_val = Name.new
    @include = []
    
  end

  #
  # file read
  #
  def read
    begin
      printf("@I:Read Parameter file : %s\n",@read_file)
      f = open("#{@read_file}","r")
      while line = f.gets
        line = line.sub("\n","")
        @FileData << line
      end
    rescue => ex
      puts ex.message
      exit
    end  
  end
  

  #
  # pre_operation
  #
  def pre_operation
    line_no = 0
    i = 0
    sep = ""
    set_cnt = 0
    
    printf("@I:Pre-Operation\n")

    @FileData.each do |line|
      line_no += 1

      if /^PRODUCT/ =~ line
        sep = line.split()
        if $VERBOSE == true
          printf("PRODUCT  :[L:%3d]%s\n",line_no,line)
          printf("                   - name    : %s\n",sep[1])
          printf("                   - version : %s\n",sep[2])
        end
        @product::name = sep[1]
        @product::version = sep[2]

      elsif /^DESIGNER/ =~ line
        sep = line.split()
        sep[1] = sep[1].gsub("\"","")
        if $VERBOSE == true
          printf("DESIGNER :[L:%3d]%s\n",line_no,line)
          printf("                   - name    : %s\n",sep[1])          
        end
        @designer.str = sep[1]

      elsif /^DATE/ =~ line
        sep = line.split()
        if $VERBOSE == true
          printf("DATE     :[L:%3d]%s\n",line_no,line)
          printf("                   - date    : %s\n",sep[1])          
        end
        @date.str = sep[1]

      elsif /^PROCESS/ =~ line
        sep = line.split()
        if $VERBOSE == true
          printf("PROCESS  :[L:%3d]%s\n",line_no,line)
          printf("                   - proces  : %s\n",sep[1])          
        end
        @process.str = sep[1]

      elsif /^SET/ =~ line
        sep = line.split()
        if $VERBOSE == true
          printf("SET      :[L:%3d]%s\n",line_no,line)
          printf("                   - name    : %s\n",sep[1])          
          printf("                   - path    : %s\n",sep[2])          
        end
        @set_val = NamePath.new
        @set_val::name = sep[1]
        @set_val::path = sep[2]
        if /\$/=~ @set_val::path
          /\$\{(\w*)\}.*/ =~ @set_val::path
          path = set["#{$1}"]
          tmp = "${" + $1 + "}" 
        end
        @set_val::path = @set_val::path.sub("#{tmp}","#{path}")
        @set[@set_val::name] = @set_val::path

      elsif /^USABLE_LABEL_NAME/ =~ line
        sep = line.split()
        if $VERBOSE == true
          printf("USABLE_LABEL_NAME:[L:%3d]%s\n",line_no,line)
          printf("                   - name    : %s\n",sep[1])          
        end
        @uln::name = sep[1]

      elsif /^FRONTEND/ =~ line
        sep = line.split()
        if $VERBOSE == true
          printf("FRONTEND :[L:%3d]%s\n",line_no,line)
          printf("                   - name    : %s\n",sep[1])          
          printf("                   - path    : %s\n",sep[2])          
        end
        @frontend_val = NamePath.new
        @frontend_val::name = sep[1]
        @frontend_val::path = sep[2]
        @frontend[@frontend_val::name] = @frontend_val::path

      elsif /^LIB_INFO/ =~ line
        sep = line.split()
        if $VERBOSE == true
          printf("LIB_INFO :[L:%3d]%s\n",line_no,line)
          printf("                   - name    : %s\n",sep[1])          
        end
        @libinfo::str = sep[1]

      elsif /^INCLUDE/ =~ line
        sep = line.split()
        if $VERBOSE == true
          printf("INCLUDE  :[L:%3d]%s\n",line_no,line)
          printf("                   - name    : %s\n",sep[1])          
          printf("                   - version : %s\n",sep[2])          
        end
        @include_val = Name.new
        @include_val::str = sep[1]
        if /\$/=~ @include_val::str
          /\$\{(\w*)\}.*/ =~ @include_val::str
          path = @set["#{$1}"]
          tmp = "${" + $1 + "}" 
        end
        @include_val::str = @include_val::str.sub("#{tmp}","#{path}")
        @include << @include_val::str

      elsif /^END_PRODUCT/ =~ line
        if $VERBOSE == true
          printf("END_PRODUCT:[L:%3d]%s\n",line_no,line)
        end

      elsif /^\/\// =~ line
        if $VERBOSE == true
          printf("COMMENT  :[L:%3d]%s\n",line_no,line)
        end

      elsif /^/ =~ line
        if $VERBOSE == true
          printf("BRANK    :[L:%3d]%s\n",line_no,line)
        end
      end  

    end # @FileData.each

    printf("@I:Pre-Operation Done\n")

  end # def pre_operation

  #
  # make_data
  #
  def make_data
    printf("\nParameter operation\n")
    read
    pre_operation
  end

  #
  # print
  #
  def print
    printf("\n")
    printf("Parameter setting\n")
    printf("[PRODUCT]\n")
    printf("  Name:%s, Version:%s\n",@product::name,@product::version)
    printf("[DESIGNER]\n")
    printf("  %s\n",@designer::str)
    printf("[DATE]\n")
    printf("  %s\n",@date::str)
    printf("[PROCESS]\n")
    printf("  %s\n",@process::str)
    printf("[SET]\n")
    @set.each do |val|
      printf("  %s : %s\n",val[0],val[1]) 
    end
    printf("[USABLE_LABEL_NAME]\n")
    printf("  %s\n",@uln::name)
    printf("[FRONTEND]\n")
    @frontend.each do |val|
      printf("  %s : %s\n",val[0],val[1]) 
    end
    printf("[LIB INFO]\n")
    printf("  %s\n",@libinfo::str)
    printf("[INCLUDE]\n")
    @include.each do |val|
      printf("  %s\n",val) 
    end
    printf("\n")
    printf("\n")
  end
end

