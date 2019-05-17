#!/bin/bash

current=$(cd ./post ; md5sum ./*.txt | sed -r 's/(.*) (.*)/\2,\1/g' | sort)
prev=$(cd ./pre ; md5sum ./*.txt | sed -r 's/(.*) (.*)/\2,\1/g' | sort)

# Show files that only exist in $prev
deleted=$(comm -23 <(echo "$prev" | sed -r 's/(.*),(.*)/\1/g') <(echo "$current" | sed -r 's/(.*),(.*)/\1/g'))

# Show files that only exist in $current
created=$(comm -13 <(echo "$prev" | sed -r 's/(.*),(.*)/\1/g') <(echo "$current" | sed -r 's/(.*),(.*)/\1/g'))

# Show all diff files
diff_files=$(comm -3 <(echo "$prev") <(echo "$current") | sed -r 's/^\t//g' | sed -r 's/(.*),(.*)/\1/g' | sort | uniq)
modified=$(echo "$diff_files"$'\n'"$deleted"$'\n'"$created" | sort | uniq -u)

# Diff summary to file
for line in $modified; do
  echo $line",modified" >> changes.csv
done
for line in $created; do
  echo $line",created" >> changes.csv
done
for line in $deleted; do
  echo $line",deleted" >> changes.csv
done

# Create md5sum.csv for next boot
# TODO new line delimiter
echo $current > md5sum.csv

