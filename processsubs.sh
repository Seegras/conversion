#!/bin/sh
#
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     2012-10-20
# Revision: 2019-10-08
# Version:  0.2
# License:  Public Domain
# URL:      https://seegras.discordia.ch/Programs/
# Requires: flip, ffmpeg, sed
# 

if ! command -v flip ffmpeg >/dev/null 2>&1; then
    echo >&2 "flip and ffmpeg are required"
    exit 1
fi

for FILE in ./*.ass ; do 
    if [ -f ${FILE} ]; then
        ffmpeg -i "${FILE}" "$( basename "${FILE}" .ass ).srt" ; 
    fi
done
for FILE in ./*.vtt ; do 
    if [ -f ${FILE} ]; then
        ffmpeg -i "${FILE}" "$( basename "${FILE}" .vtt ).srt" ; 
    fi
done
flip -ub ./*.srt 2> /dev/null
for FILE in ./*.srt; do sed -i "s#<font.*\">##g" "${FILE}"; done 
for FILE in ./*.srt; do sed -i "s#</font>##g" "${FILE}"; done 
for FILE in ./*.srt; do sed -i "s#<b>##g" "${FILE}"; done 
for FILE in ./*.srt; do sed -i "s#</b>##g" "${FILE}"; done 
mmv '?_*.srt' '0#1_#2.srt' > /dev/null 2>&1
mmv '*_Arabic.srt' '#1-ara.srt'  > /dev/null 2>&1
mmv '*_Chinese.srt' '#1-chi.srt'  > /dev/null 2>&1
mmv '*_Croatian.srt' '#1-hrv.srt'  > /dev/null 2>&1
mmv '*_Czech.srt' '#1-cze.srt'  > /dev/null 2>&1
mmv '*_Bokmal.srt' '#1-nob.srt'  > /dev/null 2>&1
mmv '*_Bulgarian.srt' '#1-bul.srt'  > /dev/null 2>&1
mmv '*_Danish.srt' '#1-dan.srt'  > /dev/null 2>&1
mmv '*_Dutch.srt' '#1-dut.srt'  > /dev/null 2>&1
mmv '*_English.srt' '#1-eng.srt'  > /dev/null 2>&1
mmv '*_Estonian.srt' '#1-est.srt'  > /dev/null 2>&1
mmv '*_Finnish.srt' '#1-fin.srt'  > /dev/null 2>&1
mmv '*_French.srt' '#1-fre.srt'  > /dev/null 2>&1
mmv '*_German.srt' '#1-ger.srt'  > /dev/null 2>&1
mmv '*_Greek.srt' '#1-gre.srt'  > /dev/null 2>&1
mmv '*_Hebrew.srt' '#1-heb.srt'  > /dev/null 2>&1
mmv '*_Hungarian.srt' '#1-hun.srt'  > /dev/null 2>&1
mmv '*_Italian.srt' '#1-ita.srt'  > /dev/null 2>&1
mmv '*_Indonesian.srt' '#1-ind.srt'  > /dev/null 2>&1
mmv '*_Latvian.srt' '#1-lav.srt'  > /dev/null 2>&1
mmv '*_Lithuanian.srt' '#1-lit.srt'  > /dev/null 2>&1
mmv '*_Japanese.srt' '#1-jpn.srt'  > /dev/null 2>&1
mmv '*_Korean.srt' '#1-kor.srt'  > /dev/null 2>&1
mmv '*_Polish.srt' '#1-pol.srt'  > /dev/null 2>&1
mmv '*_Portuguese.srt' '#1-por.srt'  > /dev/null 2>&1
mmv '*_Romanian.srt' '#1-rum.srt'  > /dev/null 2>&1
mmv '*_Russian.srt' '#1-rus.srt'  > /dev/null 2>&1
mmv '*_Serbian.srt' '#1-srp.srt'  > /dev/null 2>&1
mmv '*_Slovenian.srt' '#1-slv.srt'  > /dev/null 2>&1
mmv '*_Spanish.srt' '#1-spa.srt'  > /dev/null 2>&1
mmv '*_Swedish.srt' '#1-swe.srt'  > /dev/null 2>&1
mmv '*_Thai.srt' '#1-tha.srt'  > /dev/null 2>&1
mmv '*_Turkish.srt' '#1-tur.srt'  > /dev/null 2>&1
mmv '*_Vietnamese.srt' '#1-vie.srt'  > /dev/null 2>&1
