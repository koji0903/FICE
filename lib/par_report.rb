########################################################################
#
# Operation for anlizing par report
#
#    Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#
########################################################################
#
#  Class Name : ParReport
#  
#  [Input]
#    - par_file: ISE Par File
#
#  [Output]
#    - ClockInf : Clock result information
#
########################################################################
module ISEPar
  class ParReport
    attr_accessor :CLOCK_INF
    
    def initialize(par_file,udef_file)
      @par_file = par_file
      @ts_list = make_ts_list(udef_file)
      @CLOCK_INF = Hash.new
    end
    
    def make_ts_list(udef_file)
      ts_list = Array.new
      Common.file_read(udef_file).each{|line|
        clock_name = line.split[0]
        if clock_name != nil
          next if clock_name[0] == 35 # comment line
          ts_list << "TS_" + clock_name 
        end
      }
      return ts_list.compact
    end
    
    private
    def get_TS_result(data,ts_list)
      i = 0
      ts_correct = Array.new
      while i < data.size do
        line = data[i].strip
        if /^(TS_\w*) \= .*/ =~ line
          if ts_list.index("#{$1}") != nil
            ts_each = Array.new
            while /------/ !~ data[i]
              ts_each << data[i] # First Line
              i += 1
            end
            ts_correct << ts_each
          end
        end
        i += 1
      end
      ts_correct
    end
    
    def get_TS_result_each(ts_each)
      ts_data = TSResult.new

      if ( /^(TS_\w*).*\|SETUP\|(\d*\.\d*ns)\|(\d*\.\d*ns)\|(\d*)\|(\d*)/ =~ ts_each[0].gsub(" ","") ) != nil
        # Get SETUP Info
        printf("%s\n",ts_each) if $VERBOSE
        ts_data.TSName = $1
        ts_data.SetupWorstCaseSlack = $2.to_f
        ts_data.SetupBestCaseAchievable = $3.to_f
        ts_data.SetupTimingErrors = $4.to_f
        ts_data.SetupTimingScore = $5.to_f

        # Get HOLD Info
        /^.*\|HOLD\|(\d*\.\d*ns)\|(\d*\.\d*ns)\|(\d*)\|(\d*)/ =~ ts_each[1].gsub(" ","") 
        ts_data.HoldWorstCaseSlack = $1.to_f
        ts_data.HoldBestCaseAchievable = $2.to_f
        ts_data.HoldTimingErrors = $3.to_f
        ts_data.HoldTimingScore = $4.to_f
        
        if $2 == nil
          if (/^.*\|HOLD\|(\d*\.\d*ns)\|\|(\d*)\|(\d*)/ =~ ts_each[1].gsub(" ","")) != nil
            ts_data.HoldWorstCaseSlack = $1.to_f
            ts_data.HoldBestCaseAchievable = nil
            ts_data.HoldTimingErrors = $2.to_f
            ts_data.HoldTimingScore = $3.to_f
          else
            Common.error(__FILE__,__LINE__)
          end
        end

      elsif ( /^(TS_\w*).*\|MINLOWPULSE\|(\d*\.\d*ns)\|(\d*\.\d*ns)\|(\d*)\|(\d*)/ =~ ts_each[0].gsub(" ","") ) != nil
        # Get MINLOWPULSE
        printf("%s\n",ts_each) if $VERBOSE
        ts_data.TSName = $1
        ts_data.MinlowpulseWorstCase = $2.to_f
        ts_data.MinlowpulseBestCaseAchievable = $3.to_f
        ts_data.MinlowpulseTimingErrors = $4.to_f
        ts_data.MinlowpulseTimingScore = $5.to_f
      elsif ( /^(TS_\w*).*\|N\/A\|N\/A\|N\/A\|N\/A\|N\/A/ =~ ts_each[0].gsub(" ","") ) != nil
        # N/A info
        ts_data.TSName = $1
        ts_data.SetupWorstCaseSlack = "N/A"
        ts_data.SetupBestCaseAchievable = "N/A"
        ts_data.SetupTimingErrors = "N/A"
        ts_data.SetupTimingScore = "N/A"
        ts_data.HoldWorstCaseSlack = "N/A"
        ts_data.HoldBestCaseAchievable = "N/A"
        ts_data.HoldTimingErrors = "N/A"
        ts_data.HoldTimingScore = "N/A"
      else
        printf("%s\n",ts_each[0].gsub(" ",""))
        Common.error(__FILE__,__LINE__)
      end
      
      ts_data = ts_judge(ts_data)
      return ts_data
    end
    
    def ts_judge(ts_data)
      ts_data.Result = "NG" if ts_data.SetupTimingErrors.to_i != 0
      ts_data.Result = "NG" if ts_data.HoldTimingErrors.to_i != 0
      return ts_data
    end
    
    #
    # correct_clock_inf
    #  [param]
    #    data    : Par report data
    #    ts_list : TS Name list from UDEF file
    #
    #  [return]
    #    @CLOCK_INF : Clock report information
    #                    {TS_NAME,ts_data}
    # 
    public
    def correct_clock_inf(par_data,ts_list)
      ts_result = Array.new
      clock_inf = Hash.new
      ts_result = get_TS_result(par_data,ts_list)
      ts_result.each{|ts_each|
        ts_data = get_TS_result_each(ts_each)
        clock_inf["#{ts_data.TSName}"] = ts_data
      }
      clock_inf
    end
    
    def main
      # Get Clock Inf
      @CLOCK_INF = correct_clock_inf(Common.file_read(@par_file),@ts_list)
      return @CLOCK_INF
    end
    
  end
  
  class TSResult
  attr_accessor :TSName
    attr_accessor :SetupWorstCaseSlack
    attr_accessor :SetupBestCaseAchievable
    attr_accessor :SetupTimingErrors
    attr_accessor :SetupTimingScore
    attr_accessor :HoldWorstCaseSlack
    attr_accessor :HoldBestCaseAchievable
    attr_accessor :HoldTimingErrors
    attr_accessor :HoldTimingScore
    attr_accessor :MinlowpulseWorstCase
    attr_accessor :MinlowpulseBestCaseAchievable
    attr_accessor :MinlowpulseTimingErrors
    attr_accessor :MinlowpulseTimingScore
    attr_accessor :Result
    def initialize
      @TSName = nil
      @SetupWorstCaseSlack = nil
      @SetupBestCaseAchievable = nil
      @SetupTimingErrors = nil
      @SetupTimingScore = nil
      @HoldWorstCaseSlack = nil
      @HoldBestCaseAchievable = nil
      @HoldTimigErrors = nil
      @HoldTimingScore = nil
      @MinlowpulseWorstCaseSlack = nil
      @MinlowpulseBestCaseAchievable = nil
      @MinlowpulseTimingErrors = nil
      @MinlowpulseTimingScore = nil
      @Result = "OK"              # result("OK"/"NG")
    end
  end
end
