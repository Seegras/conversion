#!/bin/sh
#
# Author:  Peter Keel <seegras@discordia.ch>
# Date:    20.10.2012
# Version: 0.1
# License: Public Domain
# URL:     http://seegras.discordia.ch/Programs/
#
for i in *.ass ; do 
    ffmpeg -i "$i" "$(basename $i .ass).srt" ; 
done
flip -ub *.srt 2> /dev/null
for i in *.srt; do sed -i "s#<font.*\">##g" $i; done 
for i in *.srt; do sed -i "s#</font>##g" $i; done 
for i in *.srt; do sed -i "s#<b>##g" $i; done 
for i in *.srt; do sed -i "s#</b>##g" $i; done 
