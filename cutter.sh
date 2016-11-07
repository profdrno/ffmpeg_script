#!/bin/bash

END="00:00:33.00"
START=9

for f in *.mp4 ; do
	TIME=$(ffmpeg -i "$f" 2>&1 | grep "Duration" | cut -d ' ' -f 4 | sed s/,//)

	N_END=$(date -u -d "$END" +"%s.%N")
	N_TIME=$(date -u -d "$TIME" +"%s.%N")

	DURATION=$(date -u -d "0 $N_TIME sec - $N_END sec" +"%H:%M:%S")

	ffmpeg -ss $START -i "$f" -c copy -map 0 -t $DURATION "${f%.mp4}".mkv

	mv "$f" Old/
	mv *.mkv New/

	sleep 1
done

echo "DONE"



