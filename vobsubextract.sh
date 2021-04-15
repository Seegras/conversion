#!/bin/bash
# 
# vobsubextract.sh -- extracts actually all kinds of subtitles from movie
# files. Notably SUP, VOBSUB/IDX and SRT. If possible fixes them to .srt;
# otherwise leaves idx/sub files lying around for further processing. 
# 
# Author:  Peter Keel <seegras@discordia.ch>
# Date:    
# Version: 0.2
# License: Public Domain
# URL:     https://seegras.discordia.ch/Programs/
#

if ! command -v mkvmerge mkvextract >/dev/null 2>&1; then
    echo >&2 "Tools mkvmerge & mkvextract are required. Install package mkvtoolnix."
    exit 1
fi

filename=$1

if [ ! -f "$filename" ]; then
    echo "File not found."
    exit 1
fi

case "$filename" in 
    *.mkv )
filename_no_ext=$(basename "$filename" .mkv)
awk_exp='{ gsub("S_TEXT/UTF8","srt",$3); gsub("S_TEXT/ASS","ass",$3); gsub("S_HDMV/PGS","sup",$3); s = "0"$1; print $1":" fnoext "-"substr(s, 1 + length(s) - 2)"-"$2"."$3 }'
mkvmerge -J "${filename}" | jq -r '.tracks | map((.id | tostring) + " " + .properties.language + " " + .properties.codec_id) |  join("\n")' | grep -E "S_HDMV/PGS|S_TEXT/UTF8|S_TEXT/ASS|S_VOBSUB" | awk -v fnoext="$filename_no_ext" -F ' ' "${awk_exp}" | xargs mkvextract tracks "${filename}"
    ;; 
    *.mp4 )
filename_no_ext=$(basename "$filename" .mp4)
# ffmpeg -i "$filename" -map 0:s:0 "$filename_no_ext.srt"
ffmpeg -i "$filename" 2>&1 | sed -n "s/.*Stream \#\(.\+\)\:\([0-9]\+\)(\(.\+\))\: Subtitle\: \([a-zA-Z0-9]\+\).*$/-map \1:\2 $filename_no_ext-\2-\3.srt/p" | xargs ffmpeg -i $filename
for subfile in $filename_no_ext*.srt; do 
    flip -ub $subfile
    sed -i 's/<[^>]\+>/ /g' "$subfile"
done
    ;;
    *.ogm )
filename_no_ext=$(basename "$filename" .ogm)
ffmpeg -i "$filename" -map 0:s:0 "$filename_no_ext.srt"
flip -ub "$filename_no_ext.srt"
#sed -n -i '/^$/!{s/<[^>]*>//g;p;}' "$filename_no_ext.srt"
sed -i 's/<[^>]\+>/ /g' "$filename_no_ext.srt"
    ;;
esac

