#/bin/bash

BAUDRATE=115200
PORT=/dev/ttyUSB0

if [ $1 ]
then
  PORT=$1
fi

if [ $2 ]
then
  BAUDRATE=$2
fi

nodemcu-uploader -p $PORT -B $BAUDRATE upload \
    favicon.png index.html init.lua main.lua \
    weblogo.png wifimenu.html min.min.css
