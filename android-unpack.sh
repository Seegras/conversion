#!/bin/sh
#
# Author:  Peter Keel <seegras@discordia.ch>
# Date:    2011-02-27
# Version: 0.1
# License: Public Domain
# URL:     https://seegras.discordia.ch/Programs/
#
# Change this to suit your needs
APKTOOL="apktool";

if [ $# -lt 1 ]
then
    ARGS='*.apk'
else 
    ARGS=$*
fi
echo "Unpacking ${ARGS}"
for FILE in ${ARGS}; do 
${APKTOOL} decode "${FILE}" "$( basename "${FILE}" .apk )";
done

