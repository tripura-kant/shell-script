#!/bin/sh
# Dump MySQL database every hour using cron
# Author: Vivek Gite
# See for more info: http://www.cyberciti.biz/tips/shell-scripting-creating-reportlog-file-names-with-date-in-filename.html
# ---------------------------------------------------------------------------------------------------------
 
## date format ##
NOW=$(date +"%F")
NOWT=$(date +"%T")
 
## Backup path ##
BAK="/nfs/backup/mysql/$NOW"
 
## Login info ##
MUSER="madmin"
MPASS="PASSWORD"
MHOST="127.0.0.1"
 
## Binary path ##
MYSQL="/usr/bin/mysql"
MYSQLDUMP="/usr/bin/mysqldump"
GZIP="/bin/gzip"
 
## Get database list ##
DBS="$($MYSQL -u $MUSER -h $MHOST -p$MPASS -Bse 'show databases')"
 
## Use shell loop to backup each db ##
for db in $DBS
do
 FILE="$BAK/mysql-$db-$NOWT.gz"
 echo "$MYSQLDUMP -u $MUSER -h $MHOST -p$MPASS $db | $GZIP -9 > $FILE"
done