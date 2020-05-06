#!/bin/sh
#
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     2012-10-20
# Revision: 2019-10-08
# Version:  0.2
# License:  Public Domain
# URL:      https://seegras.discordia.ch/Programs/
#

if ! command -v bicapitalize.pl bookindex.pl >/dev/null 2>&1; then
    echo >&2 "bicapitalize.pl and bookindex.pl are required"
    exit 1
fi

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
 
mv -n ./*.cbr books/rar 2> /dev/null
mv -n ./*.cbz books/rar 2> /dev/null
 
cd books/rar || return
bicapitalize.pl

for CBZFILE in *.cbz; do 
if [ -e "${CBZFILE}" ]; then
    DIR=$( basename "${CBZFILE}" .cbz )
    DIR=$( echo "${DIR}"|tr "." "_" )
    DIR=$( echo "${DIR}"|sed 's/--/-/g' )
    DIR=$( echo "${DIR}"|sed 's/-$//' )
    mkdir "${DIR}"
    cd "${DIR}" || return
    unzip ../"${CBZFILE}"
    bicapitalize.pl
    mmv ' - *' '#1' > /dev/null 2>&1
    mmv '-*' '#1' > /dev/null 2>&1
    for FILE in *; do 
    if [ -d "${FILE}" ]; then
	DIRDIR="${FILE}"
	mv "${DIRDIR}"/* .
        bicapitalize.pl
	rmdir "${DIRDIR}"
    fi
    done
    if [ -e Thumbs.db ]; then
	rm Thumbs.db
    fi
    for JPGFILE in *.jpg; do 
	convert -density 300 -units PixelsPerInch "${JPGFILE}" "${JPGFILE}".jpg
	mv "${JPGFILE}".jpg "${JPGFILE}"
    done
    pdfjam --outfile ../"${DIR}".pdf -- *.jpg
    cd .. || return
fi
done 

for CBRFILE in *.cbr; do 
if [ -e "${CBRFILE}" ]; then
    DIR=$( basename "${CBRFILE}" .cbr )
    DIR=$( echo "${DIR}"|tr "." "_" )
    DIR=$( echo "${DIR}"|sed 's/--/-/g' )
    DIR=$( echo "${DIR}"|sed 's/-$//' )
    mkdir "${DIR}"
    cd "${DIR}" || return
    rar -o- x ../"${CBRFILE}" 
    bicapitalize.pl
    for FILE in *; do 
    if [ -d "${FILE}" ]; then
        DIRDIR="${FILE}"
        mv "${DIRDIR}"/* .
        bicapitalize.pl
        rmdir "${DIRDIR}"
    fi
    done
    if [ -e Thumbs.db ]; then
	rm Thumbs.db
    fi
    pdfjam --outfile ../"${DIR}".pdf -- *.jpg
    cd .. || return
fi
done 

mv ./*.pdf ../comics/
