#!/usr/bin/ruby
#############################################################
#
# FICE Global Setting File
#
#  Author : Koji HIJIKURO <koji.hijikuro@nms.necel.com>
#
#############################################################
#
#-Operation
#* Define Grobal Variable for all FICE-IDE tools
#  * Version (Major/Minor/Revision)
#
#############################################################
$GEM_HOME_PATH = "/home/product/div-micom-ice/data/proj/RL78/Common/local/gems/1.8"
ENV["GEM_HOME"] = $GEM_HOME_PATH

# MAJOR VERSION
$MAJOR_VERSION   = 3
# MINOR VERSION
$MINOR_VERSION   = 6
# Revision
$REVISION = 0

if /trunk/ =~ File.expand_path($0)
  $REVISION_FULL = $REVISION.to_s + "-trunk"
elsif /branches/ =~ $0
  $REVISION_FULL = $REVISION.to_s + "-branch"
else
  $REVISION_FULL = $REVISION.to_s
end

=begin
if /trunk/ =~ $:[0]
  $SVNRevision     = "$Rev$"
  $REVISION        = $SVNRevision.split[1] + "-trunk"
elsif /branches/ =~ $:[0]
  $SVNRevision     = "$Rev$"
  $REVISION        = $SVNRevision.split[1] + "-branches"
else
  $SVNRevision     = "$Rev$"
  $REVISION        = $SVNRevision.split[1]
end
=end



# TOOL NAME
$TOOL            = "FICE"
# VERSION
$VERSION         = "#{$MAJOR_VERSION}.#{$MINOR_VERSION}.#{$REVISION_FULL}"

# For summary
$ERROR_CNT       = 0
$NOTE_CNT        = 0
$WARNING_CNT     = 0
$INTERNAL_ERROR_CNT = 0

# For ModuleName related in FPGA-ICE
#$TOP_MODULE      = nil
