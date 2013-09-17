########################################################################
#
# Operation for make_chip "connect" file
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#    Date     : 2009/12/08
#    Function : Refer to following HP
#       http://nqacs216.nms.necel.com/common_wiki/index.php?MakeChip#n39ed659
#
#    History  :
#
########################################################################
#
#  Class Name : Connect
#  
#  [Method]
#   read          : read "connect" file
#   pre_operation : operation file modification
#   print         : print connect structure
#
#  [Data Structure]
#
########################################################################
require "message"

class ConnectInfo
  attr_accessor :Ext
  attr_accessor :Id
  attr_accessor :InstName
  attr_accessor :PinName
  attr_accessor :SignalName

  def initialize 
    @Ext = nil
    @Id = nil
    @InstName = nil
    @PinName = nil
    @SignalName = nil 
 end
end

class Connect  < Message
  
  attr_accessor :FileData
  attr_accessor :ConnectInfo
  #
  # initialize
  #
  def initialize(readfile="")
    @read_file = readfile
    @FileData = Array.new
    @include_file = ""
    @include_file_set = false
    @module_list = Array.new
   
    @each_line = Array.new
    @tmp = Array.new

    @ConnectList = Hash.new

    @InsData    = Array.new   # Data Structure of Description
    @SigList = Hash.new    # Signal List on each module(key:module name, value:signal info)

  end

  #
  # file read
  #
  def read
    begin
      printf("@I:Read connect file : %s\n",@read_file)
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
  #
  #
  def mod_direction(str,line_no,line)
    if /IN/ =~ str
      return "IN"
    elsif /OUT/ =~ str
      return "OUT"
    elsif /PAD/ =~ str
      return "PAD"
    elsif str == ""
      return "NONE"
    else
      $WARNING_CNT += 1
      printf("@W-connect002:Cannot recognize comment.([%d]%s)\n", line_no, line)
      return "NONE"
    end
  end

  #
  # make @InsData
  #
  def make_InsData
    # change data number
    ins_name = @each_line[1]
    @each_line.delete_at(1)
    # making @InsData
    @tmp << ins_name; @tmp << @each_line
    @InsData << @tmp
    @each_line = Array.new; @tmp = Array.new
    make = false          
  end

  #
  # make @SigList
  #
  def make_SigList
    tmp = Array.new
    # collect module name
    @InsData.each do |data|
      @module_list << data[0]
    end
    # delete same name
    @module_list.uniq!   

    @InsData.sort
    @module_list.each do |module_name|
      size = @InsData.size
      tmp = Array.new
      for i in 0..(size-1)
        if module_name == @InsData[i][0]
          tmp << @InsData[i][1]
        end
      end
      @SigList["#{module_name}"] = tmp
    end

  end
  

  #
  # pre_operation
  #
  def pre_operation
    line_cnt    = 0
    make        = false
    printf("@I:Pre-Operation\n")
    @FileData.each do |line|
#      line = line.gsub("\t"," ") # change from Tab to Space
      connect_info = ConnectInfo.new
#      line = Common.remove_after(line,"\\\/\\\q/")
      line_cnt +=1
      if /^\s*\/\// =~ line # comment line
        if $VERBOSE == true
          printf("COMMENT   :[L:%4d]%s\n",line_cnt,line)
        end
        connect_info.Ext = line
        @ConnectList["#{line_cnt}"] = connect_info
      elsif /^I\s*INCLUDE_FILE:\s(.*)$/ =~ line # special line
        if $VERBOSE == true
          printf("INCLUDE   :[L:%4d]%s\n",line_cnt,line)
          printf("          :       - %s\n", $1)
        end
        @include_file = $1
        connect_info.Ext = line
        @ConnectList["#{line_cnt}"] = connect_info
      elsif /^\s*NET:\s/ =~ line
        if $VERBOSE == true
          make = true
          sep = line.split()
          printf("NET       :[L:%4d]%s\n",line_cnt,line)
          for i in 0..(sep.size-1)
            printf("          :       - %s\n", sep[i])
          end
        end
        /^(\w*):\s*(\w*)\s*(\w*)\s*(\w*)\s*(\w*)/ =~ line
        @each_line[0] = $1
        @each_line[1] = $2
        @each_line[2] = $3
        @each_line[3] = $4
        @each_line[4] = mod_direction($5,line_cnt,line); 
        make_InsData
        connect_info.Id = @each_line[0]
        connect_info.InstName = @each_line[1]
        connect_info.PinName = @each_line[2]
        connect_info.SignalName = @each_line[3]
        @ConnectList["#{line_cnt}"] = connect_info
      elsif /^\s*BUSNET:\s/ =~ line
        if $VERBOSE == true
          sep = line.split()
          printf("BUSNET     :[L:%4d]%s\n",line_cnt,line)
          for i in 0..(sep.size-1)
            printf("          :       - %s\n", sep[i])
          end
        end
        /^(\w*):\s*(\w*)\s*(\w*)\s*(\w*)\s*(\w*)/ =~ line
        @each_line[0] = $1
        @each_line[1] = $2
        @each_line[2] = $3
        @each_line[3] = $4
        @each_line[4] = mod_direction($5,line_cnt,line); 
        make_InsData
        connect_info.Id = @each_line[0]
        connect_info.InstName = @each_line[1]
        connect_info.PinName = @each_line[2]
        connect_info.SignalName = @each_line[3]
        @ConnectList["#{line_cnt}"] = connect_info
      elsif /^PULLDOWN:\s/ =~ line
        if $VERBOSE == true
          sep = line.split()
          printf("PULLDOWN  :[L:%4d]%s\n",line_cnt,line)
          for i in 0..(sep.size-1)
            printf("          :       - %s\n", sep[i])
          end
        end
        /^(\S*):\s*(\S*)\s*(\S*)\s*(S*)\s*/ =~ line
        @each_line[0] = $1
        @each_line[1] = $2
        @each_line[2] = $3
        @each_line[3] = "NONE"
        @each_line[4] = mod_direction($4,line_cnt,line); 
        make_InsData
        connect_info.Id = @each_line[0]
        connect_info.InstName = @each_line[1]
        connect_info.PinName = @each_line[2]
        connect_info.SignalName = @each_line[3]
        @ConnectList["#{line_cnt}"] = connect_info
      elsif /^PULLUP:\s/ =~ line
        if $VERBOSE == true
          sep = line.split()
          printf("PULLUP    :[L:%4d]%s\n",line_cnt,line)
          for i in 0..(sep.size-1)
            printf("          :       - %s\n", sep[i])
          end
        end
        /^(\w*):\s*(\w*)\s*(\w*)\s*(\w*)\s*(\w*)/ =~ line
        @each_line[0] = $1
        @each_line[1] = $2
        @each_line[2] = $3
        @each_line[3] = $4
        @each_line[4] = mod_direction($5,line_cnt,line); 
        make_InsData
        connect_info.Id = @each_line[0]
        connect_info.InstName = @each_line[1]
        connect_info.PinName = @each_line[2]
        connect_info.SignalName = @each_line[3]
        @ConnectList["#{line_cnt}"] = connect_info
      elsif /^/ =~ line
        if $VERBOSE == true
          printf("BRANK     :[L:%4d]\n",line_cnt)
        end
        @ConnectList["#{line_cnt}"] = connect_info
      else
        $WARNING_CNT += 1
        printf("@W-connect001: Unexpected line \"%s\" was described.\n", line)
        exit
      end
      
    end

    # make new data structure
    make_SigList
    printf("@I:Pre-Operation Done\n")

  end # def pre_operation

  #
  # make_data
  #
  def make_data
    printf("\nConnect operation\n")
    read
    pre_operation
  end

  #
  # print
  #
  def print_InsData
    @InsData.each do |data|
      p data
    end
  end

  def print_ModuleList
    puts "@I:Print module list"
    puts @module_list
  end

  def print_SigList
    @module_list.each do |module_name|
      puts "-------------------------------------------"
      puts module_name
      puts "-------------------------------------------"
      p @SigList["#{module_name}"]
    end
  end
end
