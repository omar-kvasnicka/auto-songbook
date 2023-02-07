#!/bin/bash

cleanup() {
   rm -fr .promobool
   rm -fr .saxbool
}

# choose the latex program to compile sources
# because of mixing languages (russian, czech, german...), xelatex is the easiest option 
TEX=xelatex
OUT_DIR=out

if [ "$#" -ge "1" ]; then
   PLAYLIST=$1
else
   PLAYLIST=playlists/playlist.txt
fi

sed -e 's/.*/\\input{&}/' $PLAYLIST > list.tex

OUT_FILENAME=$(basename $PLAYLIST .txt)

mkdir -p $OUT_DIR

cleanup
$TEX -output-directory=$OUT_DIR zpevnik
mv $OUT_DIR/zpevnik.pdf $OUT_DIR/$OUT_FILENAME.pdf

cleanup
touch .saxbool
$TEX -output-directory=$OUT_DIR zpevnik
mv $OUT_DIR/zpevnik.pdf $OUT_DIR/$OUT_FILENAME-sax.pdf

# cleanup
# touch .promobool
# $TEX zpevnik -output-directory=$OUT_DIR
# mv $OUT_DIR/zpevnik.pdf $OUT_DIR/$OUT_FILENAME-promo.pdf
