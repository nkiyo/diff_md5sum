#!/bin/bash

# get current md5sum
#OLDIFS=$IFS
#IFS="\n"
current=$(cd ./post ; md5sum ./*.txt | sed -r 's/(.*) (.*)/\2,\1/g' | sort)
#echo current
#for line in $current; do
#  # md5sum 区切り文字をcommaに。ファイル名を行頭に
#  echo $line
#  :
#done
#IFS=$OLDIFS

# diff prev to current
#echo
#OLDIFS=$IFS
#IFS="\n"
prev=$(cd ./pre ; md5sum ./*.txt | sed -r 's/(.*) (.*)/\2,\1/g' | sort)
#for line in $prev; do
#  # md5sum 区切り文字をcommaに。ファイル名を行頭に
#  echo $line
#  :
#done
#IFS=$OLDIFS

# diff variable => https://stackoverflow.com/a/13437445
#diff <(echo "$prev") <(echo "$current")

# Show files that only exist in $prev
echo "Show lines that only exist in prev"
comm -23 <(echo "$prev" | sed -r 's/(.*),(.*)/\1/g') <(echo "$current" | sed -r 's/(.*),(.*)/\1/g')
echo

# Show files that only exist in $current
echo "Show lines that only exist in current"
comm -13 <(echo "$prev" | sed -r 's/(.*),(.*)/\1/g') <(echo "$current" | sed -r 's/(.*),(.*)/\1/g')
echo

# Show all diff files
echo "Show all diff files"
comm -3 <(echo "$prev") <(echo "$current") | sed -r 's/^\t//g' | sed -r 's/(.*),(.*)/\1/g' | sort | uniq
echo

# TODO Diff summary to file

# Create md5sum.csv for next boot
echo $current > md5sum.csv

