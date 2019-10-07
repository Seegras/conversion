#!/bin/sh
#
# Author:  Peter Keel <seegras@discordia.ch>
# Date:    2011-20-27
# Version: 0.1
# License: Public Domain
# URL:     http://seegras.discordia.ch/Programs/
# Depends: apktool, android-SDK
#
# This script takes a android-project-directories as input (such as the
# ones you get when doing "apktool decode" on an apk-file), and produces
# a signed apk-file. 
# 
# The project-directory must be of the format <projectname>-<version>
# with no spaces, and the version only containing numbers and dots. 
# 
# It also produces two files, <projectname>.keystore and 
# <projectname>.storekey in the current directory. 
# 
# Unless <projectname>.keystore and <projectname>.storekey already exist
# it will randomly generate a store/key password, which it will then store
# in <projectname>.storekey. 
#
# The important bit here is, that androids permission-model depends on the
# signing-key. Thus, apps signed with the same key can access each others
# ressources. So this script tries to avoid that, while providing the same
# key for later versions of the same application (in order to make upgrades
# possible). 
# 

# Change this to suit your needs
DN="CN=Android RePermissioned,O=Discordia,C=CH";
APKTOOL="apktool";

if [ $# -lt 1 ]
then
    echo "usage: $0 <project-directory>";
    exit 1;
else 
    ARGS=$*
fi

echo "(Re-)Signing ${ARGS}";

for i in ${ARGS}; do
    FULLNAME=$i;
    SHORTNAME=${i%-[0-9.]*};
    ${APKTOOL} build ${FULLNAME} ${FULLNAME}-unaligned.apk
    if [ -e ${SHORTNAME}.keystore ];
    then 
	PASS=`cat ${SHORTNAME}.storekey`
    else 
	PASS=`pwgen -s 16 1`;
        echo "${PASS}" > ${SHORTNAME}.storekey;
	keytool -genkey -v -keystore ${SHORTNAME}.keystore -alias ${SHORTNAME} -storepass ${PASS} -keypass ${PASS} -dname "${DN}" -keyalg RSA -keysize 2048 -validity 10000
    fi
    jarsigner -verbose -keystore ${SHORTNAME}.keystore -keypass ${PASS} -storepass ${PASS} ${FULLNAME}-unaligned.apk ${SHORTNAME}
    zipalign -v 4 ${FULLNAME}-unaligned.apk ${FULLNAME}.apk
    rm ${FULLNAME}-unaligned.apk
done;
