#!/bin/sh
FILE=$*
ffmpeg -i ${FILE} -map 0:s:0 -c:s dvdsub -f matroska "$( basename "${FILE}" .mkv ).mks"
mkvextract "$( basename "${FILE}" .mkv ).mks" tracks 0: "$( basename "${FILE}" .mkv ).sub"
