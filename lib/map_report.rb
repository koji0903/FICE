########################################################################
#
# Operation for anlizing map report
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
########################################################################
#
#  Class Name : MapReport
#  
#  [Input]
#    - bol_file: ISE Map File
#
#  [Output]
#    - WarnInf : Clock result information
#
########################################################################
module ISEMap
  #
  # Information Database for Bld
  #
  class MapInf
    # ISE Version
    attr_accessor :ISEVersion
    # Execute command
    attr_accessor :CommandLine
    # Array of Warning Message
    attr_accessor :WarningMessages
    # Array of Ignored TSName
    attr_accessor :IgnoredTSName
    # Number of Error
    attr_accessor :ErrorCounts
    # Number of Warning
    attr_accessor :WarningCounts
    def initalize
      @ISEVersion = nil
      @CommandLine = nil
      @WarningMessages = nil
      @IgnoredTSName = nil
      @ErrorCounts = 0
      @WarningCoutns = 0
    end
    def get_warn(str)
      # Message
      if @WarningMessages == nil
        tmp = Array.new
      else
        tmp = @WarningMessages.uniq
      end
      tmp << str
      @WarningMessages = tmp.uniq

      # IgnoredTSName
      if @IgnoredTSName == nil
        ignored = Array.new
      else
        ignored = @IgnoredTSName.uniq
      end
      # get warning number
      warn_num = str.split[0].split(":")[2]
      case warn_num
      when "49"
        /\"(TS_\S*)\"/ =~ str
        ignored << $1
      when "3223"
        /(TS_\S*)/ =~ str
        ignored << $1
      end
      @IgnoredTSName = ignored.uniq.compact
    end
  end

  #
  #
  #
  class MapReport
    # Identifier for ISE Version
    ISE_VERSION = "Release"
    # Identifier for command line
    COMMAND_LINE = "Command Line"
    # Identifier for Warning Message
    WARNING_MESSAGE = "WARNING:"
    # Identifier for error counts
    ERROR_COUNTS = "Number of errors"
    # Identifier for warning counts
    WARNING_COUNTS = "Number of warnings"

    def initialize(bld_file)
      @bld_file = bld_file
    end

    #
    # Bld Parsing
    #
    def parse(data)
      # Saved BLD Each Infromation
      map_inf = MapInf.new
      # Parsing
      for n in 0..(data.size-1)
        line = data[n]
        line = line.strip

        #-- Get ISE Version --#
        map_inf.ISEVersion = line if /#{ISE_VERSION}/ =~ line
        
        #-- Get Command Line --#
        if /#{COMMAND_LINE}/ =~ line
          str = ""
          while /Target/ !~ data[n]
            str += data[n].gsub("Command Line   : ","")
            n += 1
          end
          map_inf.CommandLine = str
        end

        #-- Get Warning Message(s) --#
        if /#{WARNING_MESSAGE}/ =~ line
          line = data[n].sub("WARNING:","")
          str = ""
          while data[n] != "" && /WARNING/ !~ line
            line = data[n].strip
            str += " " + line
            n += 1
            line = data[n]
          end
          map_inf.get_warn("#{str.strip}")
        end
        
        #-- Get Error Counts --#
        map_inf.ErrorCounts = line.split(":")[1].strip.to_i if /#{ERROR_COUNTS}/ =~ line

        #-- Get Warning Counts --#
        map_inf.WarningCounts = line.split(":")[1].strip.to_i if /#{WARNING_COUNTS}/ =~ line
      end
      return map_inf
    end

    #
    # Main Function
    #
    def main
      # Bld File Data
      @bld_data = Common.file_read("#{@bld_file}")
      return parse(@bld_data)
    end
  end
end
