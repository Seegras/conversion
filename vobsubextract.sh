#!/bin/sh
#
# extracts subtitles from movie (mkv, mp4, ogm) files
# 
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     ?
# Revision: 2019-10-08
# Version:  0.1
# License:  Public Domain
# URL:      http://seegras.discordia.ch/Programs/
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
        sed_exp="s/Track\sID\s([0-9]{1,3}):.*/\1:'$filename_no_ext'-\1/"
        mkvmerge -i "${filename}" | grep subtitles | sed -r "${sed_exp}" | xargs mkvextract tracks "${filename}"
        mkvmerge -J v.mkv | jq -r '
  .tracks |
  map((.id | tostring) + " " + .properties.language + " " + .codec) |
  join("\n")
'
    ;; 
    *.mp4 )
        filename_no_ext=$(basename "$filename" .mp4)
        ffmpeg -i "$filename" -map 0:s:0 "$filename_no_ext.srt"
        flip -ub "$filename_no_ext.srt"
        sed -i 's/<[^>]\+>/ /g' "$filename_no_ext.srt"
    ;;
    *.ogm )
        filename_no_ext=$(basename "$filename" .ogm)
        ffmpeg -i "$filename" -map 0:s:0 "$filename_no_ext.srt"
        flip -ub "$filename_no_ext.srt"
        sed -i 's/<[^>]\+>/ /g' "$filename_no_ext.srt"
    ;;
esac

