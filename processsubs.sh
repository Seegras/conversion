#!/bin/sh
#
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     2012-10-20
# Revision: 2019-10-08
# Version:  0.2
# License:  Public Domain
# URL:      https://seegras.discordia.ch/Programs/
# Requires: flip, ffmpeg, sed
# 

if ! command -v flip ffmpeg >/dev/null 2>&1; then
    echo >&2 "flip and ffmpeg are required"
    exit 1
fi

for FILE in ./*.ass ; do 
    ffmpeg -i "${FILE}" "$( basename "${FILE}" .ass ).srt" ; 
done
flip -ub ./*.srt 2> /dev/null
for FILE in ./*.srt; do sed -i "s#<font.*\">##g" "${FILE}"; done 
for FILE in ./*.srt; do sed -i "s#</font>##g" "${FILE}"; done 
for FILE in ./*.srt; do sed -i "s#<b>##g" "${FILE}"; done 
for FILE in ./*.srt; do sed -i "s#</b>##g" "${FILE}"; done 
