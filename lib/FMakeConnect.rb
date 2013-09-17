########################################################################
#
# FMake - for Connect file(MOD_CON/ADD_MOD_CON/INST_CON/ADD_INST_CON)
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
########################################################################
#
#  Class Name : FMakeConnect
#  
#  [Input]
#    - Connect File
#  [Output]
#    - 
# 
########################################################################
require "FICE_def"
require "FMakeMessage"
require 'FICE_DB'
require 'common'

#
# FMake Connect
#
class FMakeConnect

  #
  # Initialize
  #  Param : file_name - Output Conf filename
  #          outdir    - Output Directory (default : current dir)
  #
  def initialize( setup )
    @file_type = setup[:file_type]
    @connect_file = setup[:con_file]
    @module_name = setup[:module_name]
    @inst_name = setup[:inst_name]
  end

  #
  # Analyze Connect File
  #
  public
  def analyze
    file = @connect_file
    # File Check
    unless FileTest.readable?(file)
      # ERROR and EXIT
      $DEBUG = false
      FMakeMessage::PrintError( :category => "FILE", :no => 21, :param => file )
    end

    # Analyze
    tokens = []
    syntax_tokens = []
    line_no = 1
    
    # Saved DB
    connect_db = FICE_DB::Connect.new(
                                      :file_type => @file_type,
                                      :file => file,
                                      :module_name => @module_name,
                                      :inst_name => @inst_name
                                      )

    # Analyze Each line ( saving FICE_DB::Conf )
    open(file).each do |line|
      analyze_each_line(connect_db,file,line,line_no)      
      line_no += 1
    end
    
    return connect_db
  end


  #
  # Analyze Each Line ( Operation separated each reseved word )
  #
  private
  def analyze_each_line(conf_db,file,line,line_no)
    line = line.strip
    lexer = Parser.new("#{line}")
    tokens = lexer.tokens
    printf "L%03d - BRANK or COMMENT\n",line_no  if $VERBOSE && tokens == []
    pin_name = tokens[0]
    case tokens.size
    when 0
      # Nothing to do
    when 2
      case tokens[1]
      when "PULLUP","pullup","Pullup"
        # PULLUP
        type = "PULLUP"
        conf_db.add_PinInfo(:pin_name => pin_name,:line => line.strip, :line_no => line_no,:type => type)
      when "PULLDOWN","pulldown","Pulldown"
        # PULLDOWN
        type = "PULLDOWN"
        conf_db.add_PinInfo(:pin_name => pin_name,:line => line, :line_no => line_no,:type => type)
      when "OPEN","open","Open"
        # OPEN
        type = "OPEN"
        conf_db.add_PinInfo(:pin_name => pin_name,:line => line, :line_no => line_no,:type => type)
      when %r(:terminal),%r(:TERMINAL),%r(:Terminal)
        # Terminal
        type = "TERMINAL"
        ter = tokens[1].split(":") 
        ter_name = ter[0]
        inst_name = @inst_name.gsub(".","_")
        ter_name = "Port_" + inst_name + "_" + pin_name if ter_name == ""
        conf_db.add_PinInfo(:pin_name => pin_name,:line => line, :line_no => line_no,:type => type, :terminal_name => ter_name)
      when %r(:.*),%r(:.*),%r(:.*)
        ter = tokens[1].split(":") 
        attr = ter[1]        
        FMakeMessage::PrintError( :category => "CONNECT", :no => 213, :attr => attr, :file => file, :line => line.strip, :line_no => line_no)
      else
        # Other Connect
        type = "CONNECT"
        con = tokens[1].split(".")
        connect_port = con.pop
        connect_target = con.join(".")
        conf_db.add_PinInfo(:pin_name => pin_name,:line => line, :line_no => line_no,:type => type, :connect_target => connect_target, :connect_port => connect_port)
      end
    when 3
      # Drive Change ( Only )
      type = "DRIVE_CHANGE"
      con = tokens[1]
      drive_a = tokens[2].split(":")
      if drive_a[1] != "drive"
        FMakeMessage::PrintError( :category => "CONNECT", :no => 200, :file => file, :line => line.strip, :line_no => line_no)
      end
      drive = drive_a[0]
      con = con.split(".")
      drive = drive.split(".")
      connect_port = con.pop
      connect_target = con.join(".")
      drive_port = drive.pop
      drive_module = drive.join(".")
      conf_db.add_PinInfo(:pin_name => pin_name,:line => line, :line_no => line_no,:type => type, :connect_target => connect_target, :connect_port => connect_port, :drive_module => drive_module, :drive_port => drive_port)
    else
      if tokens.index(",").nil?
        # Syntax Error
        FMakeMessage::PrintError( :category => "CONNECT", :no => 200, :file => file, :line => line.strip, :line_no => line_no)
      else
        # Multi Signal
        tokens.each_with_index do |token,i|
          next if i == 0 # PinName
          next if token == "," # Delimiter
          # Other Connect
          type = "CONNECT"
          con = token.split(".")
          connect_port = con.pop
          connect_target = con.join(".")
          conf_db.add_PinInfo(:pin_name => pin_name,:line => line, :line_no => line_no,:type => type, :connect_target => connect_target, :connect_port => connect_port)
        end
      end
    end
  end
  
  #
  # Basic Connect Paser
  #
  private
  class Parser
    def initialize(src)
      @src = src
    end
    def lex
      case @src
      when /^[\r\n\t ]*([:${}\/0-9.a-zA-Z_-]+)(.*$)/      # number
#      when /^[\r\n\t ]*(#+)(.*$)/      # comment
      when /^[\r\n\t ]*(\w+)(.*$)/         # alphabet
      when /^[\r\n\t ]*([\[\]\"\(\),\;\:])(.*$)/  # delimiter({,},[,])
      when /^[\r\n\t ]*(\=+|\|\||\!\=|\&\&|\||\&)(.*$)/         # delimiter({,},[,])
      when /^[\r\n\t ]+(.*)(.*$)/          # ==
        return nil
      end
      @src = $2
      $1
    end
    
    def tokens
      ts = Array.new
      while (token = lex) != nil
        ts.push(token)
      end
      ts
    end
  end

end


