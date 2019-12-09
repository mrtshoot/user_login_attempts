#!/bin/bash
/tmp/u-access.txt
SUBJECT="User Access Reports on "date""
MESSAGE="/tmp/u-access.txt"
TO="hosi.ghorbani@gmail.com"
MYPATH=/var/log/secure*
yday=$(date --date='yesterday' | awk '{print $2,$3}')
tuser=$(grep "$yday" $MYPATH | grep "Accepted|Failed" | wc -l)
suser=$(grep "$yday" $MYPATH | grep "Accepted password|Accepted publickey|keyboard-interactive" | wc -l)
fuser=$(grep "$yday" $MYPATH | grep "Failed password" | wc -l)
scount=$(grep "$yday" $MYPATH | grep "Accepted" | awk '{print $9;}' | sort | uniq -c)
fcount=$(grep "$yday" $MYPATH | grep "Failed" | awk '{print $9;}' | sort | uniq -c)
echo "--------------------------------------------" >> $MESSAGE
echo "       User Access Report on: $yday" >> $MESSAGE
echo "--------------------------------------------" >> $MESSAGE
echo "Number of Users logged on System: $tuser" >> $MESSAGE
echo "Successful logins attempt: $suser" >> $MESSAGE
echo "Failed logins attempt: $fuser" >> $MESSAGE
echo "--------------------------------------------" >> $MESSAGE
echo -e "Success User Details:\n $scount" >> $MESSAGE
echo "--------------------------------------------" >> $MESSAGE
echo -e "Failed User Details:\n $fcount" >> $MESSAGE
echo "--------------------------------------------" >> $MESSAGE
mail -s "$SUBJECT" "$TO" < $MESSAGE
