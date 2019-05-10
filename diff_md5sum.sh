#!/bin/bash

# 特定ディレクトリに移動してコマンド実行？
# md5sum 区切り文字をcommaに。ファイル名を行頭に

# get current md5sum
current=$(cd ./post ; md5sum ./*.txt)
echo "## current =>" $current
echo

# diff prev to current
prev=$(cd ./pre ; md5sum ./*.txt)
echo "## prev =>" $prev

# create md5sum.txt for next interval

