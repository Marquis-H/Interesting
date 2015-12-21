#!/bin/sh

#delay 10 minute
delay=-v-30M
#image location
location=$HOME/Pictures/himawari8

date=$(date -u $delay "+%Y/%m/%d")
file_name=$(date -u $delay "+%H")$(echo "($(date -u $delay "+%M"))/10 * 10" | bc)"00_0_0.png"
url=http://himawari8-dl.nict.go.jp/himawari8/img/D531106/1d/550/$date/$file_name
mkdir -p $location
#del old data
rm -rf $location/*
cd $location
#Override download
curl $url > $file_name
img_path=$location/$file_name
osascript <<EOF
tell application "Finder" to set desktop picture to POSIX file "$img_path"
EOF