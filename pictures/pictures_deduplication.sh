#!/bin/bash

BASEDIR=$1
MD5SUM_FILE="md5sum_pictures.txt"

function gen_md5sum() {
   # Generate the md5sum of the all of the files
   cat /dev/null > $MD5SUM_FILE
   find ${BASEDIR} -type f -exec md5sum {} \; >> $MD5SUM_FILE 
}

function deduplication() {
   
}

# While there are no more duplicates
#  Generate the list of md5sums which are duplicate
#  For each duplciate entry move the file to a quarantine directory

function deduplicate_entries() {

   COUNT=1
   until [ $COUNT -lt 0 ]; do
      echo $COUNT
      FUTURE_COUNT=`expr $COUNT + 1`
      awk '{print $1}' ${COUNT}_${MD5SUM_FILE} | uniq -c > ${FUTURE_COUNT}_${MD5SUM_FILE}
      if [[ -s ${FUTURE_COUNT}_${MD5SUM_FILE} ]]; then
          echo "${FUTURE_COUNT}_${MD5SUM_FILE} is not empty. Processing...."
          deduplicate ${FUTURE_COUNT}_${MD5SUM_FILE}
          COUNT=${FUTURE_COUNT}
      else
          echo "Could not find any more duplicate file!"
          COUNT=-1
      fi
   done
}





