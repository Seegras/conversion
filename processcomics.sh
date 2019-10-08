#!/bin/sh
#
# Author:  Peter Keel <seegras@discordia.ch>
# Date:    20.10.2012
# Version: 0.1
# License: Public Domain
# URL:     http://seegras.discordia.ch/Programs/
#

# ensure directories exist
if [ ! -d books ]; then
    mkdir books
fi
if [ ! -d books/comics ]; then
    mkdir books/comics
fi
if [ ! -d books/rar ]; then
    mkdir books/rar
fi
 
mv -n *.cbr books/rar 2> /dev/null
mv -n *.cbz books/rar 2> /dev/null
 
cd books/rar
bicapitalize.pl

for i in *.cbz; do 
if [ -e $i ]; then
    DIR=`basename $i .cbz`
    DIR=`echo ${DIR}|tr "." "_"`
    DIR=`echo ${DIR}|sed 's/--/-/g'`
    DIR=`echo ${DIR}|sed 's/-$//'`
    mkdir ${DIR}
    cd ${DIR}
    unzip ../$i
    bicapitalize.pl
    mmv ' - *' '#1'
    mmv '-*' '#1'
    for i in *; do 
    if [ -d $i ]; then
	DIRDIR=$i
	mv ${DIRDIR}/* .
        bicapitalize.pl
	rmdir ${DIRDIR}
    fi
    done
    if [ -e Thumbs.db ]; then
	rm Thumbs.db
    fi
    for i in *.jpg; do 
	convert -density 300 -units PixelsPerInch $i $i.jpg
	mv $i.jpg $i
    done
    pdfjam --outfile ../${DIR}.pdf  *.jpg
    cd ..
fi
done 

for i in *.cbr; do 
if [ -e $i ]; then
    DIR=`basename $i .cbr`
    DIR=`echo ${DIR}|tr "." "_"`
    DIR=`echo ${DIR}|sed 's/--/-/g'`
    DIR=`echo ${DIR}|sed 's/-$//'`
    mkdir ${DIR}
    cd ${DIR}
    rar -o- x ../$i 
    bicapitalize.pl
    for i in *; do 
    if [ -d $i ]; then
	DIRDIR=$i
	mv ${DIRDIR}/* .
        bicapitalize.pl
	rmdir ${DIRDIR}
    fi
    done
    if [ -e Thumbs.db ]; then
	rm Thumbs.db
    fi
    pdfjam --outfile ../${DIR}.pdf  *.jpg
    cd ..
fi
done 

mv *.pdf ../comics/
