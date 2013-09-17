#!/bin/ruby

# Get Job ID
list = `sjobs`
pid = Array.new
list.split("\n").each do |line|
  data = line.split
  if data.size == 10 && data[0] != "JOBID"
    pid <<  data[0]
  end
end

# Generate Kill.sh
file = "CurrentAllJobKill.sh"
f = open("#{file}","w")
f.printf("#!/bin/sh\n")
pid.each do |no|
  f.printf("bkill %s\n",no)
end
f.close
File.chmod(0744,"#{file}")

