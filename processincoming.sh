#!/bin/sh
#
# Author:  Peter Keel <seegras@discordia.ch>
# Date:    2025-11-28
# Version: 0.1
# License: Public Domain
# URL:     http://seegras.discordia.ch/Programs/
#

cd ~/transfer/incoming
bicapitalize.pl
mmv -g -r '*--*' '#1' 2> /dev/null
mmv -g '*/*/*.HI.srt' '#1/#2/#3.srt' 2> /dev/null
rm */*YTS*.txt 2> /dev/null
rm */*YTS*.jpg 2> /dev/null
rm */*YTS*.nfo 2> /dev/null
rm */*LAMA*.nfo 2> /dev/null
rm */*UIndex*.txt 2> /dev/null
mmv -g '*/*.2160p.*.mkv' '#1/#2.mkv' 2> /dev/null
mmv -g '*/*.1080p.*.mp4' '#1/#2.mp4' 2> /dev/null
mmv -g '*/*.1080p.*.srt' '#1/#2.srt' 2> /dev/null
mmv -g '*/*.*.[0-9][0-9][0-9][0-9].*' '#1/#2 #3-#4#5#6#7.#8' 2> /dev/null
mmv -g '*/*.[0-9][0-9][0-9][0-9].*' '#1/#2 #3-#4#5#6#7.#8' 2> /dev/null
mmv -g '*/*.*-[0-9][0-9][0-9][0-9].*' '#1/#2 #3-#4#5#6#7.#8' 2> /dev/null
mmv -g '*/*.*-[0-9][0-9][0-9][0-9].*' '#1/#2 #3-#4#5#6#7.#8' 2> /dev/null
mmv -g '*/*.*-[0-9][0-9][0-9][0-9].*' '#1/#2 #3-#4#5#6#7.#8' 2> /dev/null
mmv -g '*/*.*-[0-9][0-9][0-9][0-9].*' '#1/#2 #3-#4#5#6#7.#8' 2> /dev/null
for DIR in $(find -type d); do
    cd $DIR
    bicapitalize.pl
    for FILE in *.mp4; do
        if [ ! -f $(basename $FILE .mp4).mkv ]; then
            mkvmerge "$FILE" -o "$(basename $FILE .mp4).mkv" --language 0:eng "$(basename $FILE .mp4).srt"
            mkvpropedit --edit track:a1 --set language=en $(basename $FILE .mp4).mkv
            echo $FILE
            echo $(basename $FILE .mp4).srt
        fi
    done
    cd ~/transfer/incoming
done
