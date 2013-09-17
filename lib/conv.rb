################################################
#
# Charactor code converter
#
# Author : Koji HIJIKURO
#
################################################

require "kconv"
require "nkf"

CODES = {
  NKF::JIS      => "JIS",
  NKF::EUC      => "EUC",
  NKF::SJIS     => "SJIS",
  NKF::BINARY   => "BINARY",
  NKF::UNKNOWN  => "Unknows",
  NKF::ASCII    => "ASCII",
  NKF::UTF8  	=> "UTF-8",
  NKF::UTF16    => "UTF-16",
}

# Charactor code converter
class Conv
  # Initialize
  #  arg : file - converting file name
  def initialize(file)
    @file = file
  end

  public
  # Main function
  def main
    f = open(@file,"r")
    contents = f.read
    f.close
#    if CODES[NKF.guess(contents)] != "JIS" 
      char_code = CODES[NKF.guess(contents)]
#      contents = contents.encode('Shift_JIS',char_code) if char_code != "EUC"
#      $NOTE_CNT += 1
#      printf("@N:CV010:%s file's charactor code is \"%s\". So convert to \"JIS\"\n",@file,char_code)
      return convert("sjis",contents)
#      return convert("utf",contents)
#    else
#      p contents
#    end
  end

  private
  def convert(enc,contents)
    case enc
    when "sjis"
#      contents = contents.encode("UTF-16BE", :invalid => :replace, :undef => :replace, :replace => '?')
      contents = contents.encode("Shift_JIS", :invalid => :replace, :undef => :replace, :replace => '?')
      contents = contents.kconv(Kconv::SJIS,Kconv.guess(contents))
#      contents = Kconv.tosjis(contents)
    when "euc"
      contents = Kconv.toeuc(contents)
    when "jis"
      contents = Kconv.tojis(contents)
    when "utf"
      contents = Kconv.toutf8(contents)
    else
      # Nothing
    end
    return contents
  end
end

if __FILE__ == $0
  $NOTE_CNT = 0
  conv = Conv.new(ARGV[0])
  contents = conv.main
  file_name = "conv_" + ARGV[0]
#  f = File.open(file_name,"w")
#  f.puts contents
#  f.close
end
