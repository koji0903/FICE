#!/usr/bin/ruby

$UCF
$UCF_LINE = []

def get_argument
  ARGV.each do |i|
    case i
    when  '-h' then
      puts "[W]Please input Original UCF File name."
      exit
    else
      $UCF = i
    end
  end
end


get_argument
f = open($UCF,"r")
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

f = open($UCF,"w")
f.printf("###################################################################\n")
f.printf("#\n")
f.printf("# UCF File for Fixed Implementation\n")
f.printf("#\n")
f.printf("# Generated by mod_ucf ver %s\n",$VERSION)
f.printf("#       %s\n",Time.now)
f.printf("#\n")
f.printf("###################################################################\n")
ucf_inst.each do |i|
  f.write(i)
end
ucf_other.each do |i|
  f.write(i)
end
f.close
