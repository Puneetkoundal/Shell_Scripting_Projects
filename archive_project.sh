#!/bin/bash
#$Revision:001$
#Date of Creation: Mon Dec 02 2024 10:50 AM IST$

#Variables
BASE=/home/puneet/scripting_projects
DAYS=10
DEPTH=1
RUN=0

#check if the directory is present or not
if [ ! -d $BASE ]
then
    echo "directory does not exist: $BASE"
    exit 1
fi

#create 'archive' forlder if not present
if [ ! -d $BASE/archive ]
then
    mkdir $BASE/archive
fi

#find the list of file larger then 20MB
for i in 'find $BASE -maxdepth $DEPTH -type f -size +20M'
do
  if [ $RUN -eq 0 ]
  then
      echo "[$(date "+%Y-%m-%d %H:%M:%S")] archiving $i ==> $BASE/archive"
      gzip $i || exit 1
      mv $i.gz $BASE/archive || exit 1
  fi
done 
