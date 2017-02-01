#!/bin/bash

# choose the latex program to compile sources
# because of mixing languages (russian, czech, german...), xelatex is the easiest option 
TEX=xelatex

if [ "$#" -ge "1" ]; then
   PLAYLIST=$1
else
   PLAYLIST=playlists/playlist.txt
fi

OUT_FILENAME=$(basename $PLAYLIST .txt)

echo 'generating list.tex...'
sed -e 's/.*/\\input{&}/' $PLAYLIST > list.tex

echo 'cleaning directory...'
echo '--> rm -fr .saxbool'
rm -fr .saxbool
echo '--> rm -fr .promobool'
rm -fr .promobool

# ========================== #
# ==== standard version ==== #
# ========================== #
echo 'compiling latex source...'
echo '--> '$TEX' zpevnik'
$TEX zpevnik 
#songidx songindex.sxd songindex.sbx
#songidx authorindex.sxd authorindex.sbx
#$TEX zpevnik 

echo 'moving zpevnik.pdf...'
echo '--> mv zpevnik.pdf '$OUT_FILENAME'.pdf'
mv zpevnik.pdf build/$OUT_FILENAME.pdf

## ========================== #
## ====== sax version ======= #
## ========================== #
#echo 'compiling sax version...'
#echo '--> '$TEX' zpevnik'
#touch .saxbool
#$TEX zpevnik 
#rm -fr .saxbool
#
#echo 'moving zpevnik.pdf...'
#echo '--> mv zpevnik.pdf '$OUT_FILENAME'-sax.pdf'
#mv zpevnik.pdf build/$OUT_FILENAME-sax.pdf
#
## ========================== #
## ====== promo version ===== #
## ========================== #
#echo 'compiling promo version...'
#echo '--> '$TEX' zpevnik'
#touch .promobool
#$TEX zpevnik 
#rm -fr .promobool
#
#echo 'moving zpevnik.pdf...'
#echo '--> mv zpevnik.pdf '$OUT_FILENAME'-promo.pdf'
#mv zpevnik.pdf build/$OUT_FILENAME'-promo.pdf'


# cleaning...
rm -fr .promobool
rm -fr .saxbool
rm -fr list.tex
mv *.log build/
mv *.aux build/

