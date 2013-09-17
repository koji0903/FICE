#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
# -*- coding: utf-8 -*-
#############################################################
#
#=mkUDEF : generate UDEF file for mkucf
#  
#Authors::   Koji HIJIKURO<koji.hijikuro.rj@rms.renesas.com>
#Copyright:: Copyright (c) 2011 Renesas MicroSystem. All rights reserved.
#
#############################################################
#
#==Function detail
#* Read SDC and clock_topology generated Xilinx TimingAanalyzer(timingan),
#  analyze clock tree struncture, and generate UDEF file using mkucf.
#
#==Usage
#  %ruby -w mkUFEF.rb --sdc [SDCFile] -twr [Clock Topology TWR File]
#
#  * If you want to get more information. plese use "--help" option.
#
#
#===EXAMPLE
# %ruby -w mkUDEF.rb --sdc k0r.sdc --twr clock_topology.twr
#
#===Output Files
# * UDEF file
# * report file
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


#
# Global Setting
#
$SUB_TOOL        = "mkUDEF" # Tool Name
$VERBOSE         = false # Verbose Mode
$ERROR_CNT       = 0       # Error Count for tool summary
$WARNING_CNT     = 0       # Warning Count for tool summary
$NOTE_CNT        = 0       # Note Count for tool summary
$INTERNAL_ERROR_CNT = 0
$MESSAGE         = false
Version          = $VERSION # For OptParse



$ConvertedClockName = Array.new

#
# Main Class
#
class MkUDEF
  
  def initialize
    # Synplify Constraint file name from option
    @SDC_File = nil
    # Clock Topology file name from option
    @TWR_File = nil
    # Frequencty List
    @FREQ_List = nil
    # Duty List
    @DUTY_List = nil

    # Finally ClockTree
    @ClockTree = Array.new  # { [[child_clock1, child_clock2],[child_clock1, child_clock3] }

    @Ptree = Array.new

    # Except Clock List
    @Except = ["FCLK1"]

    # Special Rool
    @SpecialExcept = {
      "OSCOUTS" => ["CLK60MHZ"],
      "FMAIN_PCLBUZ" => ["FCLK"],
      "ICEWR" => ["FCLK"],
      "SDAI1DLY" => ["CLK60MHZ"],
      "CLK60MHZ" => ["EVAMCLK","CANCLK0"],
      "CAN0VPSTB" => ["FCLK"],
      "CAN1VPSTB" => ["FCLK"],
      "MTRCVPSTB" => ["FCLK"],
      "SGVPSTB" => ["FCLK"],
      "X2DIN" => ["FCLK"],
      "RESB" => ["FCLK"],
    }
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
      opt.on('--sdc SDC','SDC Constraint file for Synopsys Synplify-Pro'){|v| @SDC_File = v}
      opt.on('--twr TWR','Clock Topology file generated Xilinx TimingAnalyzer'){|v| @TWR_File = v}
      opt.on('--freq Change frequency Clock','Clock Name you want to change frequency yourself'){|v| @FREQ_List = v}
      opt.on('--duty Change duty Clock','Clock Name you want to change clock-duty yourself'){|v| @DUTY_List = v}
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
    return true
  end

  private
  #
  # read files
  #
  def read_files(sdc_file,twr_file)
    return Common.file_read(sdc_file), Common.file_read(twr_file)
  end

  #
  # analyze SDC file
  #  - get Clock Name and Clock Path
  #  ex ) define_clock { n:chiptop.chip.csc.cg.tbase.fclk } -name { FCLK } -period 29.0 -clockgroup FCLK -route 0.000
  #         Clock Name : FCLK ( -name {XXX} )
  #         CLock Path : chiptop/chip/csc/cg/tbase/fclk ( {n:XXX} and convert "." => "/" )
  # 
  def analyze_SDC(sdc)
    clock_inf = Hash.new
    sdc.each{|line|
      # Skip at Comment-Line
      next if line.strip[0] == ?# 
      # for "define_clock" attribute line
      if line.split[0] == "define_clock"
        /^define_clock\s+\{\s*(\S*)\s*\}\s*-name\s+\{\s*(\S*)\s*\}/ =~ line
        if $1.nil? || $2.nil?
          /^define_clock\s+\{\s*(\S*)\s*\}\s*-name\s+\s*(\S*)\s*/ =~ line
          if $1.nil? || $2.nil?
            printf("@W:cannot recoginize line \"%s\"\n",line)
            next
          end
        end
        clock_full_path, clock_last_path = change_path($1)
        clock_name = $2
        if $VERBOSE
          printf("Line: %s\n", line)
          printf("  Clock Full-Path : %s\n",clock_full_path)
          printf("  Clock Last-Path : %s\n",clock_last_path)
          printf("  Clock Name : %s\n",clock_name)
          printf("\n")
        end
        # Error Check
        if clock_full_path.nil? || clock_name.nil?
          $ERROR_CNT += 1
          printf("@E: Cannot get ClockName or ClockPath about %s\n",line)
          Common.error
        end
        
        # Save
        clock_inf["#{clock_name}"] = [clock_full_path,clock_last_path,nil,false] # [2] : Special Converted Name, [3] : Use after(judgment use or unuse in clock_topology)
      end

    }
    return clock_inf
  end

  #
  # change path
  #  * delete "n:"
  #  * convert from "." to "/"
  #
  def change_path(str)
    full_path = str.sub("n:","").gsub(".","/") 
    return full_path, full_path.split("/").last
  end
  


  #
  # analyze TWR file
  #  - get Clock Tree
  #  - get information from "Clock Network Topology:" to EOF
  # 
  def analyze_TWR(twr,clock_inf)
    tree = Hash.new
    sub_node = Hash.new
    hier_array = Array.new
    enable_flag = false
    sub_clock = Array.new
    for i in 0..twr.size-1
      line = twr[i]
      if /Clock Network Topology:/ =~ line
        # Skip Dienable line
        enable_flag = true
        i = i + 2
        next
      elsif enable_flag && line.size != 0
        # Enable Line
        # Judgement hierarchy 
        hier_num = judgement_hier(line).to_i
        # Skip line
        next if hier_num < 0 || line == ""
        node = line.split[0]
        # Make tree
        if hier_num == 0
          # new tree
          clock_tree = ClockTree.new(node,hier_num,clock_inf)
#          printf("[VERBOSE]Make most parent tree : %s\n",node) if $VERBOSE
        else
          sub_clock << node
#          printf("  - child (node:%s, hier_num:%d)\n",node,hier_num) if $VERBOSE
          clock_tree = ClockTree.new(node,hier_num,clock_inf)
          clock_tree.add_parents(hier_array[hier_num-1])
          parent = tree["#{hier_array[hier_num-1]}"]
          parent.add_children(node,clock_tree)
        end 
        tree["#{node}"] = clock_tree
        hier_array[hier_num] = node
      end # if
    end # for
    sub_clock.each{|sub| tree.delete("#{sub}")}
    @Except.each{|sub| tree.delete("#{sub}")}
#    tree.each{|key,value|
#      p "------"
#      p key
#      p value
#    } if $VERBOSE
    return tree
  end

  class ClockTree

    attr_accessor :Node
    attr_accessor :HierNum
    attr_accessor :Parents
    attr_accessor :Children
    attr_accessor :ClockName
    attr_accessor :ChildList
    attr_accessor :Type      # matching type "complete"/"part"/"name"
    def initialize(node,hier_num,clock_inf)

      @Node = node
      @HierNum = hier_num
      @Parents = nil
      @Children = Hash.new
      @ClockName = nil
      @MatchLevel = nil
      resolve_Node(clock_inf)
    end
    def add_parents(parent)
      @Parents = parent
    end
    def add_children(node,child)
      @Children["#{node}"] = child
    end
  #
  # Search Clock Node
  #  - Set Searched rsult in clock_path[3] about between Clock Node and Clock-Inf(SDC) maching infomation
  #
  def resolve_Node(clock_inf)

    # Name ConvertList
    convertList = {
      "fclk" => "FCLK_ICE",
      "fsub_scck" => "fsub_scck_i",
      "USBCLK" => "USBCLK_c",
      "LOSCOUT" => "R15KOUT",
      "canclk0" => "CANCLK0",
      "canclk1" => "CANCLK1",
      "fih_p3" => "FIHP3",
      "fpllpp" => "FPLLCLM",
      "fmainclm" => "FMAINCLM",
      "oscouts_nf_p" => "oscouts_nf_p_i",
      "FCLKRT" => "cscss.FCLKRT",
      "dcclk" => "dcclk_c",
      "FPGA_IN_CLK30MHZ" => "FPGA_IN_CLK30MHZ_c",
      "FPGA_IN_CLK60MHZ" => "FPGA_IN_CLK60MHZ_c",
    }

    clock_inf.each{|clock_name,clock_path|
      # Froce Changed clock-path Name
      clock_path[2] =  convertList["#{clock_path[1]}"] unless convertList["#{clock_path[1]}"].nil?
      # Match Full-Path 
      if @Node == clock_path[0]
        @ClockName = clock_name
        @Type = "complete"
        clock_path[3] = true
        next
      end
      # Match Parts-Path
      if @Node.split("/").last == clock_path[1]
        @ClockName = clock_name
        @Type = "part"
        clock_path[3] = true
        next
      end
      # Match Parts-Path
      if @Node.split("/").last == clock_path[2]
        @ClockName = clock_name
        @Type = "special"
        clock_path[3] = true
        next
      end
    } unless clock_inf.nil?
    $ConvertedClockName << [@ClockName,@Node] unless @ClockName.nil? if $VERBOSE
  end



  end
  #
  # Judgement Hierarchy
  #  return : Hierarachy number
  #
  def judgement_hier(line)
    if line.size == 0
      return -1
    else
      return line.index(/\S/)/2 - 1
    end
  end

  #
  # Resolve Clock Tree
  #
  def resolve_ClockTree(clock_inf,clock_tree)
    printf("@I:Resovle Clock Tree at using in SDC file\n")
    clock_inf.each{|clock_name,clock_path|
      # Match Full-Path 
      unless clock_tree["#{clock_path[0]}"].nil?
        clock_tree["#{clock_path[0]}"].ClockName = clock_name
        clock_tree["#{clock_path[0]}"].Type = "complete"
        printf("Completely Match : %s (%s)\n",clock_name,clock_path[0])
        next
      end
      # Match Parts-Path
      flag = false
      clock_tree.each_value{|each_clock|
        if each_clock.Node.split("/").last == clock_path[1]
          printf("Part Match       : %s (%s)\n",clock_name,each_clock.Node)
          each_clock.ClockName = clock_name
          each_clock.Type = "part"
          flag = true
        end
      }
      next if flag

      # Match Name
      clock_tree.each_value{|each_clock|
        special_clock_name = each_clock.Node.split("/").last
        if /#{clock_name}/ =~ special_clock_name
          printf("Name Match1      : %s (%s)\n",clock_name,each_clock.Node)
          each_clock.ClockName = clock_name
          each_clock.Type = "name"
          flag = true
        end
      }
      next if flag

      clock_tree.each_value{|each_clock|
        special_clock_name = each_clock.Node.split("/").last
        if /#{clock_path[1]}/ =~ special_clock_name
          printf("Name Match2      : %s (%s)\n",clock_name,each_clock.Node)
          each_clock.ClockName = clock_name
          each_clock.Type = "name"
          flag = true
        end
      }
      next if flag

      printf("Not-Found        : %s\n",clock_name)      
    }
    return clock_tree
  end

  #
  # generate ClockTree
  #
  def analyze_ClockTree(clock_tree,tree=nil,num=nil)
    clock_tree.each{|clock_path,tree_inf|
      @Ptree = @Ptree[0..tree_inf.HierNum-1]
      tree = Array.new
      if tree_inf.HierNum == 0
        @Ptree.clear
      end
      if tree_inf.ClockName != nil
        tree << tree_inf.ClockName
        @Ptree[tree_inf.HierNum] = tree_inf.ClockName
      end
      @Ptree = @Ptree[0..tree_inf.HierNum]
      if tree_inf.Children.size != 0
        analyze_ClockTree(tree_inf.Children,tree,tree_inf.HierNum) 
      else
        @ClockTree << @Ptree.compact
      end      
    }
  end
  
  def get_child(child,p_HierNum)
    child.each{|each_child|
      if each_child.ClockName != nil
        printf("\n") if each_child.HierNum < p_HierNum
        printf("%s%s(%s)\n","+"*(each_child.HierNum+1),each_child.ClockName,each_child.Node) 
      end
      if each_child.Children.size != 0
        get_child(each_child.Children,each_child.HierNum)
      end
    }
  end
  
  #
  # Merge ClockTree
  #  - delete ClockTree when another ClockTree inlude this ClockTree
  #
  def merge_ClockTree(clock_tree)
    clock_tree.sort_by{|tree|
      tree.size
    }.each{|tree1|
      if tree1.size == 0
        clock_tree.delete(tree1)
        next
      end
      clock_tree.each{|tree2|
        next if tree1 == tree2
        if tree1 == (tree2 & tree1)
          clock_tree.delete(tree1)
          break
        end
      }
    }

    #
    # make clock-relation 
    #
    clock_relation = Hash.new # {"clock_name" => [Except List] }
    # pre-operation (make clock relation)
    clock_tree.each{|tree|
      for i in 0..(tree.size-1)
        each_clock = tree[i]
        if clock_relation["#{each_clock}"].nil?
          if tree[i+1].nil?
            clock_relation["#{each_clock}"] = nil
          else
            except_list = Array.new
            except_list << tree[i+1]
            except_list = except_list.uniq
            clock_relation["#{each_clock}"] = except_list
          end
        else
          except_list = clock_relation["#{each_clock}"]
          unless tree[i+1].nil?
            except_list << tree[i+1]
            clock_relation["#{each_clock}"] = except_list.uniq
          end
        end
      end
    }

    #
    # Add Spectial Excetp
    #
    clock_relation.each{|clock_name,except_list|
      special_list = @SpecialExcept["#{clock_name}"]
      delete_list = Array.new
      if !special_list.nil?
        # delete undefined clock
        special_list.each{|special_clock|
          flag = false
          clock_tree.each{|tree|
            unless tree.index("#{special_clock}").nil?
              flag = true
            end
          }
          delete_list << special_clock unless flag
        }
        delete_list.each{|del_clock|
          special_list.delete("#{del_clock}")
        }
        # merge except list
        if except_list.nil?
          except_list = special_list
        else
          except_list = except_list | special_list 
        end
      end
      clock_relation["#{clock_name}"] = except_list
    }

    return clock_tree, clock_relation
  end

  #
  # generate UDEF
  #
  def generate_UDEF(clock_inf,clock_relation)

    freq = Array.new
    duty = Array.new
    # Frequency List
    freq = @FREQ_List.strip.split(":") unless @FREQ_List.nil?
    # Duty List
    duty = @DUTY_List.strip.split(":") unless @DUTY_List.nil?

    # generate
    file_name = "sample.udef" 
    printf("@I:generate %s\n",file_name)
    f = open("#{file_name}","w")
    comment = "UDEF File for mkucf" 
    Common.print_file_header(f,"#{comment}",$SUB_TOOL,$VERSION,"##")

    # NameChange List
    f.printf("#\n")
    f.printf("# Name Change\n")
    f.printf("#\n")
    clock_inf.each{|clock_name,clock_path|
      f.printf("C:%s,%s\n",clock_path[0].gsub("/","_"),clock_name)
      if clock_path[2] != nil
        f.printf("C:%s,%s\n",clock_path[0].gsub("#{clock_path[0].split("/").last}","#{clock_path[2]}").gsub("/","_"),clock_name)
      end
    }
    f.printf("\n")

    # Clock Grouping
    f.printf("#\n")
    f.printf("# Clock Grouping\n")
    f.printf("#\n")
    clock_relation.sort_by{|clock_name,except_list|
      clock_name
    }.each{|clock_name,except_list|
      f.printf("%-15s",clock_name)
      if except_list.nil?
        f.printf(" EXCEPT :")
        if freq.index("#{clock_name}") && duty.index("#{clock_name}")
          f.printf("FREQ,DUTY")
        elsif freq.index("#{clock_name}")
          f.printf("FREQ")
        elsif duty.index("#{clock_name}")
          f.printf("DUTY")
        end
        f.printf("\n")
      else
        f.printf(" EXCEPT ")
        except_list.each{|except|
          f.printf("%s ",except)
        }
        f.printf(":")
        if freq.index("#{clock_name}") && duty.index("#{clock_name}")
          f.printf("FREQ,DUTY")
        elsif freq.index("#{clock_name}")
          f.printf("FREQ")
        elsif duty.index("#{clock_name}")
          f.printf("DUTY")
        end
        f.printf("\n")
      end
    }

    f.close
  end

  #
  # Main Function
  #  1. Print Base Message
  #  2. Read SDC & TWR File
  #  3. Analyze SDC ( make clock_inf )
  #  4. Analyze TWR ( makd clock_tree )
  #  5. Check matching SDC and ClockTopology Information
  #  6. Anylyze Clock Tree & Merge Information
  #  7. Generate UDEF File
  #
  public
  def main
    # 1. Print Mabe Message
    Common.print_base

    # Ruby Version Judgment
    if RUBY_VERSION != "1.8.5"
      printf("@E:mksdc only support Ruby ver : 1.8.5 ( Now, executed %s )\n",RUBY_VERSION)
      printf("   please check your ruby execute setting.")
      $ERROR_CNT += 1
      Common.print_summary
      exit
    end

    get_argument

    # 2. Read SDC & TWR
    sdc,twr = read_files(@SDC_File,@TWR_File)

    # 3. Analyze SDC
    clock_inf = analyze_SDC(sdc)

    # 4. Analyze TWR
    clock_tree = analyze_TWR(twr,clock_inf)
    if $VERBOSE
      $ConvertedClockName = $ConvertedClockName.uniq.compact
      $ConvertedClockName.each{|list|
        printf("[VERBOSE] Converted Clock Name form \"%s\" to \"%s\"\n",list[1],list[0])
      }
    end

    # 5. Check matching SDC and ClockTopology Information
    clock_inf.each{|clock_name,path_inf|
      if path_inf[3] == false # Unmatched SDC & TWE
        $WARNING_CNT += 1
        printf("@W:Not Found clock_name \"%s\" in %s. Check it, please.\n",clock_name,@TWR_File)
        printf("   - clock_path in SDC : %s\n",path_inf[0])
      end
    }

    # 6. Anylyze Clock Tree
    printf("@I:analyze ClockTree\n")
    analyze_ClockTree(clock_tree)
    num = @ClockTree.size
    if $VERBOSE
      printf("[VERBOSE] Before marged Clock-Tree\n")
      @ClockTree.each{|tree|
        p tree if tree.size != 0
      }
    end
    @ClockTree, clock_relation = merge_ClockTree(@ClockTree.compact.uniq)
    printf("@I:Analyzed Clock Tree Information\n")
=begin
    if $VERBOSE
      printf("[VERBOSE] After marged Clock-Tree\n")
      @ClockTree.each{|tree|
        p tree
      }
      printf("\n")
    end
=end
    j = 1
    @ClockTree.compact.uniq.each{|tree|
      printf(" [%02d]: ",j)
      for i in 0..tree.size-2
        printf("%s -> ",tree[i])
      end
      printf("%s\n",tree.last)
      j += 1
    }

    # 7. Generaete UDEF file
    generate_UDEF(clock_inf,clock_relation)

    Common.print_summary
  end
  
end


#
# Execute
#
if __FILE__ == $0
  mkudef = MkUDEF.new
  mkudef.main
end
