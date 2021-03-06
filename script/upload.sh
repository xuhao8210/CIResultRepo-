#!/bin/bash

DATE=`date +20%y%m%d`
DATE1=`date +20%y-%m-%d`
TESTRAILPATH="$HOME/qm/scripts/test_reports"
COMMITID=""

if [ -d "$TESTRAILPATH" ] ; then
	if [ ! -d "$TESTRAILPATH/junit4TestRail" ]; then
	   	mkdir "$TESTRAILPATH/junit4TestRail"
    fi
else
	echo "Test Rail path is not exist"
fi	

if [ -d "$DATE" ]; then
   for PLFILE in `ls $DATE`
   do
     if [ "$PLFILE" = "version.log" ]; then
         COMMITID=`head -1 $DATE/version.log | awk -F: '{print $2}' | awk '{print $1}'`
     else
         cp "$DATE/$PLFILE" "$TESTRAILPATH/junit4TestRail"
	 fi	  

   done
fi

BDH="CIMaster-${DATE1}-${COMMITID}"
cd $TESTRAILPATH
ls junit4TestRail
chmod 755 report.py
echo "===================================================="
CMD="python3 report.py --runner sanitycheckbatch -j junit4TestRail -V "$BDH"    -p 5 -s 54 -m 9"
echo $CMD
$CMD
echo "===================================================="
ls -lrt junit4TestRail
