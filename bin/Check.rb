#!/home/product/div-micom-ice/data/proj/78K0R/Common/local/ruby/bin/ruby
$:.unshift(File.dirname(__FILE__) + "/../bin")
$:.unshift(File.dirname(__FILE__) + "/../lib")
$:.unshift(File.dirname(__FILE__) + "/../conf")
require 'XMLParse'
require 'FICE_DB'

#
# Get Path from search_Connection Data
#
def get_path(connect_list)
  path = Array.new
  connect_list.Path.each do |each_path|
    next if each_path.size == 1
    tmp2 = Array.new
    each_path.each do |path|
      tmp = Array.new
      tmp << path.InstName
      tmp << path.Name
      tmp << path.ConnectedWireName
      tmp << path.MSB
      tmp << path.LSB
      tmp << path.BusPortion
      tmp2 << tmp
    end
    path << tmp2
  end
  return  path
end

connect_sig_list = Hash.new

@root = XMLParse.read("/home/m0001/rl0003/product/div-micom-ice/data/proj/RL78/Common/.fice/xml/l13_ICE_df0.2_rev002.xml")
port_list = XMLParse.get_TerminalList(@root,"QAHIOS0BN32MV2_ICE")
port_list.each do |port| 
  connect_list =  XMLParse::search_Connection(true,@root,"R5F10WMGA.crl78fcspf00_l13","cspf.h_rosc",[port,nil],true) # Input signal
  connect_sig_list[[port,"NONE"]] = get_path(connect_list)
end


file = "a.connect"
f = open(file,"w")
connect_sig_list = make_NeedPath(connect_sig_list)
connect_sig_list.each do |sig,path|
  f.printf("-------------------------------------------------------\n")
  f.printf("%s [%s]\n",sig[0],sig[1])
  path.each do |each_path|
    f.printf("  %s\n",each_path)
  end
end
f.close
