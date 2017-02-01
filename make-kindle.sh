#!/bin/bash

if [ "$#" -ge "1" ]; then
   PLAYLIST=$1
else
   PLAYLIST=playlist.txt
fi

PWD=$(pwd)
TEMP_DIR=$(mktemp -d)
HTML_NAME=$(basename $PLAYLIST .txt).html
MOBI_NAME=$(basename $PLAYLIST .txt).mobi

# convert tex syntax to html
while IFS='' read -r f; do
   # remove extension from file name
   ff=$(basename $f .tex)
   
   # name of song # author # verses # choruses # chords # solos # anything else remove
   sed -e 's#\\beginsong{\([^}]*\)}#<a name="'$ff'"><h3>\1</h3></a>\n#g' \
       -e 's#\\endsong##g' \
       -e 's#\[by={\([^}]*\)}\]#<h4>\1</h4>#g' \
       -e 's#\\beginverse#<pre>#g' \
       -e 's#\\endverse#</pre>#g' \
       -e 's#\\beginchorus#<pre><i>#g' \
       -e 's#\\endchorus#</i></pre>#g' \
       -e 's#\\bsolo#<pre><i>#g' \
       -e 's#\\esolo#</i></pre>#g' \
       -e 's$\\\[\([a-zA-Z0-9#+, ()/]*\)]$<sup>\1</sup>$g' \
       -e 's$\\[a-zA-Z0-9#+, ()/*]*$$g' \
       -e 's${.*}$$g' \
       -e 's#^%.*$##g' \
       $f >> $TEMP_DIR/$ff.html

   # add link to the song index at the end of each song
   echo '<a href="#'$ff'_obsah">Zpět na obsah</a>' >> $TEMP_DIR/$ff.html
done < $PLAYLIST;


# create html song index
grep --no-filename "<h3>" $TEMP_DIR/* > $TEMP_DIR/list.html
sed -i 's/name="\([a-zA-Z0-9_-]*\)"/name="\1_obsah" href="#\1"/g' $TEMP_DIR/list.html

# make whole html songbook

cat > $HTML_NAME <<EOL
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Martin Hejtmánek -- Zpěvník</title>
      <!--<link rel="stylesheet" href="" type="text/css"> -->
</head>
EOL

echo '<body>' >> $HTML_NAME

cat $TEMP_DIR/list.html >> $HTML_NAME
cat $TEMP_DIR/* >> $HTML_NAME

echo '</body>' >> $HTML_NAME
echo '</html>' >> $HTML_NAME

# make mobi file for kindle
# kindlegen $HTML_NAME -o $MOBI_NAME
pandoc $HTML_NAME -o $MOBI_NAME

# remove temp directory
rm -fr $TEMP_DIR

