#!/bin/sh
#
# Author:  Peter Keel <seegras@discordia.ch>
# Date:    16.03.2014
# Version: 0.1
# License: Public Domain
# URL:     http://seegras.discordia.ch/Programs/
#

# ensure directories exist
if [ ! -d books ]; then
    mkdir books
fi
if [ ! -d books/new ]; then
    mkdir books/new
fi
if [ ! -d books/pdf ]; then
    mkdir books/pdf
fi

mv -n *.pdf books/new 2> /dev/null

# Unpack, delete known files and add new ones to index.
cd books/new
if type "bicapitalize.pl" > /dev/null; then
    bicapitalize.pl
fi
mmv -- '-*' '#1' 2> /dev/null
if type "bookindex.pl" > /dev/null; then
    bookindex.pl -d
    bookindex.pl -a
fi

mv -n *.pdf ../pdf/ 2> /dev/null
