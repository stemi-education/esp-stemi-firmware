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

esptool.py --port $PORT --baud $BAUDRATE write_flash -fm dio -fs 32m \
				         	     0x00000 0x00000.bin  \
						     0x10000 0x10000.bin \
						     0x70000 0x70000-32mb.bin \
						     0x3fc000 esp_init_data_default.bin
