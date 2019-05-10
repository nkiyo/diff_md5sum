#!/bin/bash


# get current md5sum
OLDIFS=$IFS
IFS="\n"
current=$(cd ./post ; md5sum ./*.txt)
for line in $current; do
  # md5sum 区切り文字をcommaに。ファイル名を行頭に
  echo $line
done
IFS=$OLDIFS

# diff prev to current
OLDIFS=$IFS
IFS="\n"
prev=$(cd ./pre ; md5sum ./*.txt)
for line in $pre; do
  # md5sum 区切り文字をcommaに。ファイル名を行頭に
  echo $line
done
IFS=$OLDIFS

# create md5sum.txt for next interval

