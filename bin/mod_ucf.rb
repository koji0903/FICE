#!/usr/bin/ruby
############################################################################
#
# Generate new UCF file for Fixed Place & Routed
#   Input File  : Original UCF File generated first Place & Route
#   Output File : Modified UCF for fixed Place & Route opration
#
#   Author      : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#   Date        : 2009/07/23
#   Version     : 0.7 Beta
#
#   History     :
#      0.1-beta : 09/07/11 - First making
#      0.2-beta : 09/07/12 - Support MAP Operation
#      0.3-beta : 09/07/13 - Support PAR Operation
#      0.4-beta : 09/07/14 - modify "ISE Command"
#      0.5-beta : 09/07/16 - Add Print Header in modified UCF file
#      0.6-beta : 09/07/17 - Add "-proj/-trim" option
#      0.7-beta : 09/07/23 - Add BLD file analize for translate error
#
############################################################################
#
# [OPERATION]
#   - UCF Trimming for Translate Warning which is constraint overridding
#
############################################################################

#
# GLOBAL Variable
#
$TOOL_NAME = "mod_ucf"
$VERSION   = "0.7-beta"


$PRJ_NAME  = "EVA_TOP"
$ORG_UCF = ""
$MOD_UCF = ""
$BACK_UCF = ""
$ERROR_SLICE = []
$TMP_UCF = ""
$RM_LIST = []
$remove_list_bld = Array.new

$ERROR_CNT = 0


# For Option
$TRIM = true
$TRANSLATE = true
$MAP = true
$PAR = true

#
# ISE Command ( Need "PATH" environment setting )
#
##$EDIF2NGD_CMD = "edif2ngd -quiet \"../#{$PRJ_NAME}.edf\" \"_ngo/#{$PRJ_NAME}.ngo\""
$TRANSLATE_CMD = "ngdbuild -ise \"./ISE_LOC.ise\" -intstyle ise -dd _ngo  -nt timestamp -i -p xc4vlx80-ff1148-10 \"../#{$PRJ_NAME}.edf\" #{$PRJ_NAME}.ngd"
$MAP_CMD = "map -ise \"./ISE_LOC.ise\" -intstyle ise -p xc4vlx80-ff1148-10 -timing -ol high -cm speed -pr b -k 4 -o #{$PRJ_NAME}_map.ncd EvaFPGA.ngd #{$PRJ_NAME}.pcf"
$PAR_CMD = "par -ise \"./ISE_LOC.ise\" -w -intstyle ise -ol high -t 1 #{$PRJ_NAME}_map.ncd #{$PRJ_NAME}.ncd #{$PRJ_NAME}.pcf"

#////////// ProtoType ////////////////////////////////////////////

def print_base
  puts ""
  puts $TOOL_NAME + " ver: " + $VERSION
  puts "Copyright (c) 2009 NEC MicroSystem. All rights reserved."
  puts ""
end

def usage
  puts "Usage: mod_ucf.rb \"UCF_FILE\" \[OPTION\]"
  puts " OPTION:"
  puts "    -h/-help          : print help message"
  puts "    -v/-version       : print version"
  puts "    -p/-proj PRJ_NAME : PRJECT NAME( default : EVA_TOP)"
  puts "    -no-trim          : Didable trim UCF description for Translate warning."
  puts "    -no-tran          : Disable first translate operation"
  puts "    -no-map           : Disable first map operation"
  puts ""
end
#
# Get Argument
#
def get_argument
  ucf_set = false
  size = ARGV.size
  size -= 1
  for i in 0..size
    case ARGV[i]
    when '-h','-help' then
      print_base
      usage
      exit
    when '-v','-version' then
      print_base
      printf("")
      exit
    when "-p","-proj" then
      $PRJ_NAME = ARGV[i+1]
      i += 1
    when "-no-trim" then
      $TRIM = false
    when "-no-tran" then
      $TRANSLATE = false
    when "-no-map" then
      $MAP = false
    else
      if /^-/ =~ ARGV[i]
        printf("[E] %s option is not supported.\n",ARGV[i])
        usage
        exit
      else
        $ORG_UCF = ARGV[i]
        $TMP_UCF = $ORG_UCF + ".tmp"
      end
    end
  end
end

# 
# Header Message
#
def print_header_message
  puts "Execute on following setting"
  printf("\[PROJECT_NAME\] : %s", $PRJ_NAME)
  printf("\[TRIMMING\]     : %s", $TRIM)
end

#
# Trim
#
def trim
  f = open($ORG_UCF,"r")
  ucf_inst = []
  ucf_other = []
  while line = f.gets
    if /^INST/ =~ line
      ucf_inst << line
    else
      ucf_other << line
    end
    #  $UCF_LINE << line
  end
  f.close
  ucf_inst.uniq!

  f = open($ORG_UCF,"w")
  ucf_inst.each do |i|
    f.write(i)
  end
  ucf_other.each do |i|
    f.write(i)
  end
  f.close
end

#
# read Bld
#
def read_bld
  f = open("#{$PRJ_NAME}.bld","r")
  mode = false, start = false
  i = 0
  data1 = Array.new
  data2 = Array.new

  # read bld file
  while line = f.gets
    if /Done./ =~ line
      mode = true
      next
    end
    if /Done.../ =~ line
      mode = false
      break
    end
    
    if mode == true
      if /ERROR/ =~ line
        line = line.sub("\n","")
        data1 << line
        start = true
      elsif /[a-zA-Z0-9]/ =~ line
        line = line.sub("\n","")
        data1 << line
      end
      if /^\n/ =~ line
        data2 << data1
        data1 = Array.new
      end
      if start == true
        if /ERROR/ =~ line
          data2 << data1
          data1 = Array.new
          start = false
          line = line.sub("\n","")
          data1 << line
        end
      end
    end
  end

  f.close

  # change to 1-line from multi-line
  new_data = Array.new
  word = ""
  data2.each do |a|
    size = a.size 
    if size >= 2
      for i in 0...size
        a[i] = a[i].sub("   ","")
        word = word + a[i].to_s
      end
      new_data << word
      word = ""
    end
  end
  # create remove signal list
  new_data.each do |word|
    if /^ERROR:NgdBuild/ =~ word
      /NET\"(.*)\"ROUTE/ =~ word
      if $1 == nil
        /NET\s\"(.*)\"ROUTE=/ =~ word
      end
      if $1 == nil
        /NET\"(.*)\"ROUTE=/ =~ word
      end
      if $1 == nil
        /NET\"(.*)\"\sROUTE=/ =~ word
      end
      if $1 == nil
        $ERROR_CNT += 1
        puts "------------------------------------------"
        puts "[E] BLD Alanys Error"
        puts "------------------------------------------"
        p word
        exit
      end
      $remove_list_bld << $1
    elsif /^ERROR:Constraint/ =~ word
      /INST\"(.*)\"\sLOC/ =~ word
      if $1 == nil
        /INST\"(.*)\"\sBEL/ =~ word    
      end
      if $1 == nil
        /INST\"(.*)\"LOC/ =~ word    
      end
      if $1 == nil
        /INST\"(.*)\"BEL/ =~ word    
      end
      if $1 == nil
        /NET\"(.*)\"ROUTE=/ =~ word    
      end
      if $1 == nil
        /NET\"(.*)\"\sROUTE=/ =~ word    
      end
      if $1 == nil
        puts "------------------------------------------"
        puts "[E] BLD  Alanys Error"
        puts "------------------------------------------"
        p word
        exit
      end
      $remove_list_bld << $1
    end
  end


  $remove_list_bld.each do |error_net|
    #      if/^NET \S*\]_\d\"$/ =~ line
    #      puts "@1"
    #      puts error_net
    error_net = error_net.gsub("\/","\\/")
    error_net = error_net.gsub("\[","\\[")
    error_net = error_net.gsub("\]","\\]")
  end

  if $VERBOSE == true
    puts ""
    puts "[I] remove signal list"
    puts ""
    puts $remove_list_bld
  end


end

#
# Remove the line including remove_list_bld
#
def modify_line_logic
  f = open($BACK_UCF,"r")
  new = open($ORG_UCF,"w")
  mode = false
  match = false
  cont = false
  i = 0, j = 0
  target_word = ""

  while line = f.gets

    if/_rt/ =~ line
      if /^#/ =~ line
      else
        line = "#" + line
      end
    end

    if cont == true
      if /^#/ =~ line
      else
        line = "#" + line
      end
      if /}\";$/ =~ line
        cont = false
      end
    end      
    
    $remove_list_bld.each do |net|
      error_net = net.gsub("\/","\\/")
      error_net = error_net.gsub("\[","\\[")
      net = error_net.gsub("\]","\\]")
      if /#{net}/ =~ line
        if /^#/ =~ line
        elsif /\AINST/ =~ line
          line = "#" + line
          if $VERBOSE == true
            printf("match [%4d]:%s", i, line)
            i += 1
          end
          break
        elsif /\ANET/ =~ line
          cont = true
          line = "#" + line
          if $VERBOSE == true
            printf("match [%04d]:%s", i, line)
            i += 1
          end
          break
        else
          printf("[E] %s", line)
          exit
        end
      end
    end
    if (j / 100) == 0
      printf(".")
    end
    j += 1
    new.write(line)
  end
  f.close
  printf("\n")
end


#
# Read MRP File ( MRP File is generated by MAP in ISE )
#
def read_mrp
  $MRP_FILE = $PRJ_NAME + "_map.mrp"
  f = open($MRP_FILE,"r")
  while line = f.gets
    if /ERROR/ =~ line
      /LOC=(.*)\)/ =~ line             # pick up Slice name
      $ERROR_SLICE << $1
    end
  end
  f.close
  $ERROR_SLICE.uniq!
end

#
# Read PAR File ( PAR File is generated by PAR in ISE )
#
def read_par
  cnt = []
  judge_conflict = 0
  judge_net = 0
  $PAR_FILE = $PRJ_NAME + ".par"
  f = open($PAR_FILE,"r")
  while line = f.gets
    if /Conflict/ =~ line
      judge_conflict = 1
    end
    if judge_conflict <= 2
      if /Net/ =~ line
        judge_conflict += 1
        judge_net = 1
      end
    end
    if ( judge_conflict == 3 ) && ( judge_net == 1)
      judge_conflict = 0
      judge_net = 0
      /Net:(\S*)\s*/ =~ line
      $RM_LIST << $1
    end
  end
  $RM_LIST.compact!
  f.close
end

#
# Modify the line for MRP Error( Slice Mapping Error )
#
def modify_line_slice(slice_name)
  puts "---" + slice_name
  f = open($TMP_UCF,"r")
  new = open($ORG_UCF,"w")
  while line = f.gets
    if/#{slice_name}/ =~ line
      line = "#" + line
      p line
    end
    new.write(line)
  end
  f.close
  new.close
end


def copy_file( org_file, tmp_file )
  source = open(org_file)
  dest = open(tmp_file, "w")
  contents = source.read
  dest.write(contents)
  dest.close
  source.close
end


#
# Modile the line for PAR Error ( Routing Confilect error)
#
def modify_line_net(net_name)
  match = 0
  net_name = net_name.sub("\(","\\(")
  net_name = net_name.sub("\)","\\)")
  net_name = net_name.sub("\[","\\[")
  net_name = net_name.sub("\]","\\]")
  f = open($TMP_UCF,"r")
  new = open($ORG_UCF,"w")
  while line = f.gets
    if ( /#{net_name}/ =~ line ) && ( /NET/ =~ line )
      match = 1
      puts ""
      puts "---" + net_name
    end
    if match == 1 
      if /^\n/ =~ line 
        match = 0
      else
        if /^#/ =~ line
        else
          line = "#" + line
        end
        p line
      end
    end
    new.write(line)
  end
  f.close
  new.close
end

# judge pid
def judge_pid(pid)
  /exited\(([0-9]*)\)/ =~ pid
  result = $1
  p result
  if result != "0"
    puts "[E] This program abnormally finished"
    puts "[E] Please contact koji.hijikuro@nms.necel.com"
    exit
  end
end


def add_header
  printf("@I:Add Header Information on UCF file.\n")
  copy_file($ORG_UCF,$TMP_UCF)
  f = open($TMP_UCF,"r")
  new = open($ORG_UCF,"w")
  new.printf("###################################################################\n")
  new.printf("#\n")
  new.printf("# UCF File for Fixed Implementation.\n")
  new.printf("# Generated by mod_ucf ver %s.\n",$VERSION)
  new.printf("#       %s\n",Time.now)
  new.printf("#\n")
  new.printf("# [Executed ISE Option]\n")
  new.printf("#  TRAN:%s\n",$TRANSLATE_CMD)
  new.printf("#  MAP :%s\n",$MAP_CMD)
  new.printf("#  PAR :%s\n",$PAR_CMD)
  new.printf("#\n")  
  new.printf("###################################################################\n")
  new.printf("#\n")  
  while line = f.gets
    new.write(line)
  end
  f.close
  new.close
end

#################################################################
#################################################################
#
# MAIN
#
#################################################################
#################################################################
get_argument
print_base

=begin
puts "[I]Get argument."
puts "   - Original file : " + $ORG_UCF

puts "[I]Make backup file for Original UCF"
$BACK_UCF = $ORG_UCF + ".org"
source = open($ORG_UCF)
dest = open($BACK_UCF, "w")
contents = source.read
dest.write(contents)
dest.close
source.close

if $TRIM == true
  puts "[I]Trimming UCF file for Translage warning."
  trim
end
$BACK_UCF = $ORG_UCF + ".back"
source = open($ORG_UCF)
dest = open($BACK_UCF, "w")
contents = source.read
dest.write(contents)
dest.close
source.close

if $TRANSLATE == true
  puts "[I]Pre-TRANSLATE" ; p $TRANSLATE_CMD; system ("#{$TRANSLATE_CMD} > /dev/null 2>&1"); result = $?; p result;
  puts "[I]Comment out the line including the error-net which generated by Translate"
  read_bld
  modify_line_logic
end

if $MAP == true
  puts "[I]First ISE Operation(Translate/MAP)."
  #puts "[I]EDIF2NGD"  ; system ("#{$EDIF2NGD_CMD} > /dev/null 2>&1"); result = $?; p result; 
  puts "[I]TRANSLATE" ; p $TRANSLATE_CMD; system ("#{$TRANSLATE_CMD} > /dev/null 2>&1"); result = $?; p result;
  puts "[I]MAP"       ; p $MAP_CMD; system ("#{$MAP_CMD} > /dev/null 2>&1")      ; p $?
  puts "[I]Read Map report"
  read_mrp
  puts "[M]Following SLICE are some problem in MAP Process, comment out the signale mapped following slice."
  puts $ERROR_SLICE
  puts "[I]Comment out the line including these SLICE"
  $ERROR_SLICE.each do |i|
    copy_file($ORG_UCF,$TMP_UCF)
    modify_line_slice(i)
  end
end


puts "[I]Second ISE Operation(Tranlsate/MAP/PAR)."
puts "[I]TRANSLATE" ; p $TRANSLATE_CMD; system ("#{$TRANSLATE_CMD} > /dev/null 2>&1"); result = $?; p result
puts "[I]MAP"       ; p $MAP_CMD; system ("#{$MAP_CMD} > /dev/null 2>&1")      ; result = $?; p result; 
puts "[I]PAR"       ; p $PAR_CMD; system ("#{$PAR_CMD} > /dev/null 2>&1")      ; p $?

=end

puts "[I]Read Par report"
$RM_LIST.clear
read_par
puts "[M]Following net are some problem in PAR Process, So comment out the net(s)."
puts $RM_LIST
$RM_LIST.each do |i|
  copy_file($ORG_UCF,$TMP_UCF)
  modify_line_net(i)
end

=begin
puts "[I]Third ISE Operation(Tranlsate/MAP/PAR)."
puts "[I]TRANSLATE"    ; p $TRANSLATE_CMD; system ("#{$TRANSLATE_CMD} > /dev/null 2>&1") ; result = $?; p result; 
puts "[I]MAP"          ; p $MAP_CMD; system ("#{$MAP_CMD} > /dev/null 2>&1")       ; result = $?; p result; 
puts "[I]PAR"          ; p $PAR_CMD; system ("#{$PAR_CMD} > /dev/null 2>&1")       ; p $?

/exited\(([0-9]*)\)/ =~ $?
if $1 != 0
  puts "[I]Read Par report"
  $RM_LIST.clear
  read_par
  puts "[M]Following net are some problem in PAR Process, comment out the net(s)."
  puts $RM_LIST
  $RM_LIST.each do |i|
    copy_file($ORG_UCF,$TMP_UCF)
    modify_line_net(i)
  end
  puts "[I]Fourth ISE Operation(Tranlsate/MAP/PAR)."
  puts "[I]TRANSLATE"  ; p $TRANSLATE_CMD; system ("#{$TRANSLATE_CMD} > /dev/null 2>&1") ; result = $?; p result
  puts "[I]MAP"        ; p $MAP_CMD; system ("#{$MAP_CMD} > /dev/null 2>&1")       ; result = $?; p result
  puts "[I]PAR"        ; p $PAR_CMD; system ("#{$PAR_CMD} > /dev/null 2>&1")       ; result = $?; p result
end  
=end

add_header
puts "[I]Done"

