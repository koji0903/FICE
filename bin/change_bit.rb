#!/usr/local/bin/ruby


class ChangeBit
  def main
    @Data = Array.new
    hdl = ARGV[0]
    open("#{hdl}").each do |line|
      if /(\w+)\s+\[(\d+):(\d+)\]/ =~ line
        msb = $2.to_i
        lsb = $3.to_i
        if msb < lsb          
          line = line.sub(/#{lsb}/,"#{msb}")
          line = line.sub(/#{msb}/,"#{lsb}")
        end
      end
      @Data << line
    end

    file = hdl + "_mod"
    f = open("#{file}","w")
    @Data.each do |line|
      f.printf "#{line}"
    end
    f.close
  end
end

if __FILE__ == $0
  tool = ChangeBit.new
  tool.main
end
