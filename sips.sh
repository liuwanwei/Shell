#!/bin/bash
originImageName=$1
type=$2 # -icon or -image
if [ "$type" = "" ];then
    echo 'Usage: ./sips imageName -[icon|image]'
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

if [ $type = "-icon" ];then 
    # App icon
    #resampleAppIcon $originImageName 60
    #resampleAppIcon $originImageName 120
    #resampleAppIcon $originImageName 180

    resampleAppIcon $originImageName 58
    resampleAppIcon $originImageName 80
    resampleAppIcon $originImageName 120
else
    # Launch image
    resampleImage $originImageName 640 960   # 2x
    resampleImage $originImageName 640 1136  # Retina 4
    resampleImage $originImageName 750 1334  # Retina HD 4.7
    resampleImage $originImageName 1242 2208 # Retina HD 5.5 
fi
