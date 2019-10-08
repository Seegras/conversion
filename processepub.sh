#!/bin/she
#
# Author:  Peter Keel <seegras@discordia.ch>
# Date:    28.02.2010
# Version: 0.1
# License: Public Domain
# URL:     http://seegras.discordia.ch/Programs/
#

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

mv -n *epub*.rar books/rar 2> /dev/null
mv -n *mobi*.rar books/rar 2> /dev/null
mv -n *.epub books/rar 2> /dev/null
mv -n *.mobi books/rar 2> /dev/null
mv -n *.lit books/rar 2> /dev/null

# Unpack, delete known files and add new ones to index.
cd books/rar
bicapitalize.pl
for i in *.rar; do 
if [ -e $i ]; then
    rar -o- x $i; 
fi
done 
rm *.rar 2> /dev/null

bicapitalize.pl

if type "bookindex.pl" > /dev/null; then
    bookindex.pl -d
    bookindex.pl -a
fi

# Find broken files. 
for i in *.epub; do 
if [ -e $i ]; then
epub-meta $i
RETVAL=$?
    if [ $RETVAL != 0 ]; then
	if [ ! -d ../broken ]; then
	    mkdir ../broken
	fi
	mv $i ../broken/
    fi
fi
done

# Convert foreign formats
for i in *.mobi; do 
if [ -e $i ]; then
FILEPUB=`basename $i .mobi`.epub
    if [ ! -f ${FILEPUB} ]; then 
	ebook-convert $i ${FILEPUB}
	if [ ! -d ../del ]; then
	    mkdir ../del
	fi
	mv $i ../del/
    fi
fi
done

for i in *.lit; do 
if [ -e $i ]; then
FILEPUB=`basename $i .lit`.epub
    if [ ! -f ${FILEPUB} ]; then 
	ebook-convert $i ${FILEPUB} --no-default-epub-cover
	if [ ! -d ../del ]; then
	    mkdir ../del
	fi
	mv $i ../del/
    fi
fi
done

mv -n *.epub ../epub/ 2> /dev/null

# Process broken files

if [ -d ../broken ]; then
cd ../broken/
for i in *.epub; do 
if [ -e $i ]; then
    ebook-convert $i `basename $i .epub`-2.epub --no-default-epub-cover; 
    mv `basename $i .epub`-2.epub ../epub
    if [ ! -d ../del ]; then
        mkdir ../del
    fi
    mv $i ../del/
fi
done
fi

# rename and add to index
cd ../epub
rmdir ../rar 2> /dev/null
if [ -d ../broken ]; then
rmdir ../broken
fi
epub-rename.pl -r
if type "bookindex.pl" > /dev/null; then
    bookindex.pl -a -- 
fi
