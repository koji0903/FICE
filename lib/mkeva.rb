#!/usr/bin/ruby
##################################################################
#
#  mkeva ( Make Chip for ICE )
#
#  Author   : Koji HIJIKURO<koji.hijikuro@nms.necel.com>
#  Date     : 2009/07/13
#  Version  : 0.1-Beta
#
#  History
#    0.1 bata
#
###################################################################
#
# [OPERATION]
#   - Analize Report file
#   - Analize Parts file
#
###################################################################
require "system"
require "message"

# For make_chip
require "mkice_conf"
require "parameter"
require "connect"
require "report"
require "parts"
require "connect"

# GRABAL VARIABLE
$TOOL        = "mkeva"
$VERSION     = "0.1-Beta"

# SYSTEM
$CONF_FILE   = ""
$VERBOSE     = false
$NOTE_CNT    = 0
$WARNING_CNT = 0
$ERROR_CNT   = 0

$WORK_DIR    = "work"
$WORK_SET    = false

# READ FILES
$PARAMETER_FILE = ""
$PARAMETER_SET  = false
$REPORT_FILE    = ""
$REPORT_SET     = false
$PARTS_FILE     = ""
$PARTS_SET      = false
$CONNECT_FILE   = ""
$CONNECT_SET    = false


###################################################################
###################################################################
# MAIN
###################################################################
###################################################################

# Init operation
system  = System.new
message = Message.new
system.get_argument
message.print_base

# Operation for Configuration file
conf    = MKICEConf.new($CONF_FILE)
conf.analize         # analize configuratio file
system.exe_info      # print execution message
#$WORK_DIR = system.make_workdir


# Operation for Each Parameter Files
parameter = Parameter.new($PARAMETER_FILE)
report    = Report.new($REPORT_FILE)
parts     = Parts.new($PARTS_FILE)
connect   = Connect.new($CONNECT_FILE)

# for Parameter file 
parameter.make_data
# for Report file
report.make_data
# for Parts file
parts.make_data(parameter.set)
# for Connect file
connect.make_data




###################################################################
# Report Summary
###################################################################
message.print_summary
