########################################################################
#
# Operation for anlizing bld report
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
########################################################################
#
#  Class Name : BldReport
#  
#  [Input]
#    - bol_file: ISE Par File
#
#  [Output]
#    - WarnInf : Clock result information
#
########################################################################
module ISEBld
  #
  # Information Database for Bld
  #
  class BldInf
    # ISE Version
    attr_accessor :ISEVersion
    # Execute command
    attr_accessor :CommandLine
    # Array of Warning Message
    attr_accessor :WarningMessages
    # Ignored Line Number
    attr_accessor :IgnoredLineNum
    # Number of Error
    attr_accessor :ErrorCounts
    # Number of Warning
    attr_accessor :WarningCounts
    def initalize
      @ISEVersion = nil
      @CommandLine = nil
      @WarningMessages = nil
      @IgnoredLineNum = nil
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
      @WarningMessages = tmp
      @WarningMessages.uniq

      if /ConstraintSystem:119/ =~ str
        /\((\d*)\)/ =~ str
        if $1 != nil
          if @IgnoredLineNum == nil
            num = Array.new
          else
            num = @IgnoredLineNum
          end
          num << $1
          @IgnoredLineNum = num.uniq
        end
         
      end

    end
  end

  #
  #
  #
  class BldReport
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
      bld_inf = BldInf.new

      # Parsing
      for n in 0..(data.size-1)
        line = data[n]
        line = line.strip

        #-- Get ISE Version --#
        bld_inf.ISEVersion = line if /#{ISE_VERSION}/ =~ line
        

        #-- Get Command Line --#
        if /#{COMMAND_LINE}/ =~ line
          str = ""; n += 1
          while data[n] != ""
            # Judgement for needing space
            if /^\// =~ data[n] && str != ""
              str += " " + data[n].strip
            else
              str += data[n].strip
            end
            n += 1
          end
          bld_inf.CommandLine = str
        end

        #-- Get Warning Message(s) --#
        if /#{WARNING_MESSAGE}/ =~ line
          str = ""
          while data[n] != ""
            line = data[n].strip
            if (/^\"/ =~ line || /^\[/ =~ line || /^\'/ =~ line ) && str != ""
              str += " " + line
            else
              str += line
            end
            n += 1
          end
          bld_inf.get_warn("#{str}")
        end
        
        #-- Get Error Counts --#
        bld_inf.ErrorCounts = line.split(":")[1].strip.to_i if /#{ERROR_COUNTS}/ =~ line

        #-- Get Warning Counts --#
        bld_inf.WarningCounts = line.split(":")[1].strip.to_i if /#{WARNING_COUNTS}/ =~ line
      end

      return bld_inf
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
