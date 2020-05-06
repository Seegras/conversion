#!/bin/bash
#
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     2010-02-28
# Revision: 2019-10-08
# Version:  0.2
# License:  Public Domain
# URL:      https://seegras.discordia.ch/Programs/
#
if ! command -v bicapitalize.pl bookindex.pl epub-meta epub-rename.pl >/dev/null 2>&1; then
    echo >&2 "bicapitalize.pl, bookindex.pl epub-meta and epub-rename.pl are required"
    exit 1
fi

# ensure directories exist
if [ ! -d books ]; then
    mkdir books
fi
if [ ! -d books/rar ]; then
    mkdir books/rar
fi
if [ ! -d books/new ]; then
    mkdir books/new
fi
if [ ! -d books/epub ]; then
    mkdir books/epub
fi

mv -n ./*epub*.rar books/rar 2> /dev/null
mv -n ./*mobi*.rar books/rar 2> /dev/null
mv -n ./*.epub books/rar 2> /dev/null
mv -n ./*.mobi books/rar 2> /dev/null
mv -n ./*.lit books/rar 2> /dev/null

# Unpack, delete known files and add new ones to index.
cd books/rar || return
bicapitalize.pl
for RARFILE in *.rar; do 
if [ -e "${RARFILE}" ]; then
    rar -o- x "${RARFILE}"; 
    rm "${RARFILE}"
fi
done 

bicapitalize.pl

bookindex.pl -d
bookindex.pl -a

# Find broken files. 
for EPUBFILE in *.epub; do 
if [[ -e "${EPUBFILE}" ]]; then
epub-meta "${EPUBFILE}"
RETVAL=$?
    if [ $RETVAL != 0 ]; then
	if [ ! -d ../broken ]; then
	    mkdir ../broken
	fi
	mv "${EPUBFILE}" ../broken/
    fi
fi
done

# Convert foreign formats
for MOBIFILE in *.mobi; do 
if [[ -e "${MOBIFILE}" ]]; then
FILEPUB="$( basename "${MOBIFILE}" .mobi ).epub"
    if [[ ! -f "${FILEPUB}" ]]; then 
	ebook-convert "${MOBIFILE}" "${FILEPUB}"
	if [ ! -d ../del ]; then
	    mkdir ../del
	fi
	mv "${MOBIFILE}" ../del/
    fi
fi
done

for LITFILE in *.lit; do 
if [ -e "${LITFILE}" ]; then
FILEPUB="$( basename "${LITFILE}" .lit ).epub"
    if [[ ! -f "${FILEPUB}" ]]; then 
	ebook-convert "${LITFILE}" "${FILEPUB}" --no-default-epub-cover
	if [ ! -d ../del ]; then
	    mkdir ../del
	fi
	mv "${LITFILE}" ../del/
    fi
fi
done

mv -n ./*.epub ../epub/ 2> /dev/null

# Process broken files

if [[ -d ../broken ]]; then
cd ../broken/ || return
for FILE in *.epub; do 
if [[ -e "${FILE}" ]]; then
    ebook-convert "${FILE}" "$( basename "${FILE}" .epub)-2.epub" --no-default-epub-cover;
    mv "$( basename "${FILE}" .epub )-2.epub" ../epub
    if [ ! -d ../del ]; then
        mkdir ../del
    fi
    mv "${FILE}" ../del/
fi
done
fi

# rename and add to index
cd ../epub || return
rmdir ../rar 2> /dev/null
if [[ -d ../broken ]]; then
rmdir ../broken
fi

epub-rename.pl -r
bookindex.pl -a -- 

cd .. || return
rmdir new  2> /dev/null
