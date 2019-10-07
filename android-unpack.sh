#!/bin/sh
#
# Author:  Peter Keel <seegras@discordia.ch>
# Date:    2011-02-27
# Version: 0.1
# License: Public Domain
# URL:     http://seegras.discordia.ch/Programs/
#
# Change this to suit your needs
APKTOOL="apktool";

if [ $# -lt 1 ]
then
    ARGS='*.apk'
else 
    ARGS=$*
fi
echo Unpacking ${ARGS}
for i in ${ARGS}; do 
${APKTOOL} decode $i `basename $i .apk`;
done

