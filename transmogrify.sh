#!/bin/bash

srcExt="MOV"
#srcExt="mp4"
destExt="mov"

#opts="-crf 10 -c:v prores -profile:v 3 -c:a pcm_s24le "
opts=" -c:v dnxhd -profile dnxhr_lb -c:a pcm_s16le"

rootDir="/home/james/Steam/WriteIntheCode_videos/s1"
sourceFolder="Camera"
destFolder="Transmogrified"
# check if Camera exists
if [ ! -d "$rootDir/$1/$sourceFolder" ] 
then
	echo "$sourceFolder directory doesn't exist, put camera video there."
	exit 9999
fi

# check if Transmogrified exists
if [ ! -d "$rootDir/$1/$destFolder" ] 
then
	echo "$destFolder does not exist, making directory in $rootDir/$1/"
    mkdir "$rootDir/$1/$destFolder"
fi


srcDir="$rootDir/$1/$sourceFolder"
#srcDir="/media/james/DE8E-0361/CameraUploads"
destDir="$rootDir/$1/$destFolder"
#destDir="/media/james/DE8E-0361/transmogrified/"


srcCnt=`ls $srcDir | wc -l`

#--------------------------------------------------# 

for filename in "$srcDir"/*.$srcExt; do
	destCnt=`ls $destDir | wc -l`
	echo "---------------------------------------------------------------------"
	echo "------ now transmogrifying $filename. ------------------------------"
	echo "\n"
	echo "\n"
        basePath=${filename%.*}
        baseName=${basePath##*/}

	ffmpeg -i "$filename" $opts "$destDir"/"$baseName"."$destExt"
	echo "----------------------- $destCnt / $srcCnt done!  ---------------------"	
	echo "---------------------------------------------------------------------"
	echo "\n"
	echo "\n"
done
#
# ffmpeg -i $filename   -c:v dnxhd -profile dnxhr_lb -c:a pcm_s16le media/james/DE8E-0361/transmogrified/ $filename.mov 
#
echo "Conversion from ${srcExt} to ${destExt} complete!"
