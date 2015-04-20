#!/bin/bash
# 放弃使用，用Python重写，位置在 pyscript/helper/appicon.py
originImageName=$1
type=$2 # -icon or -image
if [ "$type" = "" ];then
    echo 'Usage: ./sips imageName -[i|l]'
    exit
fi

function resampleAppIcon()
{
    file=$1
    height=$2
    width=$2

    sips -z $height $width $file --out "Icon-$width-$file"
}

function resampleImage()
{
    file=$1
    width=$2
    height=$3

    sips -z $height $width $file --out "Image-$width-$height-$file"
}

if [ $type = "-i" ];then 
    # iPhone icons
    resampleAppIcon $originImageName (29*2)
    resampleAppIcon $originImageName 29*3

    resampleAppIcon $originImageName 40*2
    resampleAppIcon $originImageName 40*3

    resampleAppIcon $originImageName 60*2
    resampleAppIcon $originImageName 60*3

    # iPad icons
    resampleAppIcon $originImageName 29*1
    #resampleAppIcon $originImageName 29*2  omited, same as iPhone icon 29*2

    resampleAppIcon $originImageName 40*1
    #resampleAppIcon $originImageName 40*2  omited, same as iPhone icon 40*2

    resampleAppIcon $originImageName 76*1
    resampleAppIcon $originImageName 76*2

elif [ $type = '-l' ];then
    # Launch image
    resampleImage $originImageName 640 960   # 2x
    resampleImage $originImageName 640 1136  # Retina 4
    resampleImage $originImageName 750 1334  # Retina HD 4.7
    resampleImage $originImageName 1242 2208 # Retina HD 5.5 
fi
