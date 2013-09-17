#!/bin/csh -f
####################################################
#
# Update Latest
#
####################################################

echo "Update Latest"

set VerFile = ./lib/FICE_def.rb

#Get Version
set MajorVersion = `ruby -n -e 'print $1 if /^\$MAJOR_VERSION\s+=\s+(.+)/ =~ $_' ${VerFile}`
set MinorVersion = `ruby -n -e 'print $1 if /^\$MINOR_VERSION\s+=\s+(.+)/ =~ $_' ${VerFile}`
set Revision = `ruby -n -e 'print $1.gsub("\"","") if /^\$REVISION\s+=\s+(.+)/ =~ $_' ${VerFile};`

set Latest = ${MajorVersion}"."${MinorVersion}"-latest"
set Version = ${MajorVersion}"."${MinorVersion}"."${Revision}


echo ""
echo "Get Version information from ${VerFile}"
echo "   - Major Version : ${MajorVersion}"
echo "   - Minor Version : ${MinorVersion}"
echo "   - Revision      : ${Revision}"
echo ""

echo "Start to Create FICE ver${Version} ..."
echo ""

# Check Branch
echo "Check Branch ..."
set Branch = `git branch --no-color |& sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/"`
echo " - Branch Name : $Branch"

if ( ${Branch} != "master" ) then
	echo "@E:Branch is not master. Making release Data is alllowd at master."
	exit 1
endif
echo "OK"
echo ""

# Check Directory
echo "Check Directory ... "
if ( -d ../tags/${Version} ) then
	echo "@E: ver ${Version} already exist. Please describe other version"
	exit 1
endif
echo "OK"
echo ""

# Check Status
set GitStatus = `git status -s`
if ( "${GitStatus}" == "" ) then
	echo "@I:Status Check .. OK"
else
	echo "@E:Status Check .. NG"
	echo "    Please check update and commit before updating current version."	
	echo ""
	echo "[GitStatus]"
	echo "${GitStatus}"
	echo "Do you continue? [Y/N Enter]" 
	set ANSWER = $<
	switch ( $ANSWER )
	case "Y":
	case "y":
		echo $ANSWER
		set Update = true
			breaksw
	default:
		echo "Stop execution." 
		exit 1		
	endsw
endif

echo ""
echo "Please Check making Ver : ${Version}"
echo ""

# Confirm
echo "Is this correct? [Y/N Enter]" 
set ANSWER = $<
switch ( $ANSWER )
case "Y":
case "y":
	echo $ANSWER
	set Update = true
	breaksw
   default:
	echo "Stop execution." 
	exit 1
endsw


# Make Tag
echo "Making tag to Git repository ..."
set message = "release v${Version}"
git tag -a ${Version} -m "${message}" >& /dev/null
if ( $? == "128" ) then
	echo "@E: ${Version} tag is already exit."
	echo ""
	exit 1
endif

echo "OK"
echo ""


pushd ../

# Make release File
echo "@I:Making Clone tags/${Version} ..."
git clone --depth 1 file:///home/product/div-micom-ice/data/proj/RL78/Common/FICE/trunk tags/${Version}
echo "OK"
echo ""

# Make Link
echo "Make Link (  ${Latest} -> tags/${Version} )"
if ( -e ${Latest} ) unlink ${Latest}
ln -s tags/${Version} ${Latest}
echo "Make Link (  latest -> ${Latest} )"
if ( -e latest ) unlink latest
ln -s ${Latest} latest
echo "OK"
echo ""

popd

# Finish
echo ""
echo "UpdateLatst ... Done"
echo " - Created New Version : ${Version}"
echo ""



