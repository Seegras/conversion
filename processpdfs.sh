#!/bin/sh
#
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     2014-03-16
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
if [ ! -d books/new ]; then
    mkdir books/new
fi
if [ ! -d books/pdf ]; then
    mkdir books/pdf
fi

mv -n ./*.pdf books/new 2> /dev/null

# Unpack, delete known files and add new ones to index.
cd books/new || return
bicapitalize.pl
mmv -- '-*' '#1'> /dev/null 2>&1
bookindex.pl -d
bookindex.pl -a

mv -n ./*.pdf ../pdf/ 2> /dev/null
cd .. || return
rmdir new  2> /dev/null
