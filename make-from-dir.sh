#!/bin/bash

if [ "$#" -ge "1" ]; then
   DIR=$1
else
   DIR=pisnicky
fi

OUT_PLAYLIST_NAME=playlists/$(basename $DIR .tex).txt

# if in $DIR is stored just name of the file
if [ -f "$DIR" ]; then
   ls -1 $DIR > $OUT_PLAYLIST_NAME
else
   ls -1 $DIR/*.tex > $OUT_PLAYLIST_NAME
fi

./make-from-list.sh $OUT_PLAYLIST_NAME

