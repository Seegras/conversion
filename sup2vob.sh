#!/bin/bash
#
# wrapper around bdsup2sub++ to convert subtitle files in batch
# and set the correct language
# 
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     
# Version:  0.2
# License:  Public Domain
# 

# Old version
# if ! command -v bdsup2sub++ >/dev/null 2>&1; then
#     echo >&2 "bdsup2sub++ is required"
#     exit 1
# fi

JARFILE="$HOME/lib/BDSup2Sub512.jar"
FLAGS="-Dsun.java2d.uiScale=2 -Dglass.gtk.uiScale=2.0"
if [[ ! -e "${JARFILE}" ]]; then
     echo >&2 "${JARFILE} is required"
     exit 1
 fi

for FILE in *.sup; do 
LANG3=$( echo "${FILE}" | cut -d "." -f 1 | rev | cut -c -3 | rev )
   case "${LANG3}" in
         bul)
             LANG2="bg"
             ;;
         chi)
             LANG2="zh"
             ;;
         cze)
             LANG2="cs"
             ;;
         dan)
             LANG2="da"
             ;;
         dut)
             LANG2="nl"
             ;;
         eng)
             LANG2="en"
             ;;
         fin)
             LANG2="fi"
             ;;
         fre)
             LANG2="fr"
             ;;
         ger)
             LANG2="de"
             ;;
         gre)
             LANG2="el"
             ;;
         heb)
             LANG2="he"
             ;;
         hin)
             LANG2="hi"
             ;;
         hun)
             LANG2="hu"
             ;;
         ita)
             LANG2="it"
             ;;
         ice)
             LANG2="is"
             ;;
         ind)
             LANG2="id"
             ;;
         jpn)
             LANG2="ja"
             ;;
         kor)
             LANG2="ko"
             ;;
         may)
             LANG2="ms"
             ;;
         nor)
             LANG2="no"
             ;;
         pol)
             LANG2="pl"
             ;;
         por)
             LANG2="pt"
             ;;
         spa)
             LANG2="es"
             ;;
         swe)
             LANG2="sv"
             ;;
         tha)
             LANG2="th"
             ;;
         tur)
             LANG2="tr"
             ;;
     esac
# Old version
# bdsup2sub++ --language $LANG2 -o $(basename $i .sup).idx $i; 
# 
java "${FLAGS}" -jar "${JARFILE}" --language "${LANG2}" -o "$( basename "${FILE}" .sup ).idx" "${FILE}";
done
