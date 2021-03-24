cd $1
raw2dng -j $3.$4
cp $3.jpg $2
cd $2
echo $3.jpg
convert $3.jpg -resize 400 $3.jpg
