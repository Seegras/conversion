#!/bin/sh
#
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     2012-10-20
# Revision: 2019-10-08
# Version:  0.2
# License:  Public Domain
# URL:      http://seegras.discordia.ch/Programs/
# Requires: flip, ffmpeg, sed
# 

if ! command -v flip ffmpeg >/dev/null 2>&1; then
    echo >&2 "flip and ffmpeg are required"
    exit 1
fi

for i in *.ass ; do 
    ffmpeg -i "$i" "$(basename $i .ass).srt" ; 
done
flip -ub *.srt 2> /dev/null
for i in *.srt; do sed -i "s#<font.*\">##g" $i; done 
for i in *.srt; do sed -i "s#</font>##g" $i; done 
for i in *.srt; do sed -i "s#<b>##g" $i; done 
for i in *.srt; do sed -i "s#</b>##g" $i; done 
