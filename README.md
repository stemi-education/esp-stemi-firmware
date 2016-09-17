# NodeMCU firmware and .lua scripts for STEMI hexapod

[STEMI hexapod](https://www.stemi.education) uses ESP-12F, a popular version of [ESP8266](https://en.wikipedia.org/wiki/ESP8266) WiFi SoC for communicating with the world. A vibrant community around this chip introduced a [NodeMCU](https://github.com/nodemcu/nodemcu-firmware) firmware, that enables ESP8266 to be programmed by writing Lua scripts and uploading it to the chip.

We, developers at [STEMI](https://www.facebook.com/stemi.education), opted for this simple method to enable our robot to:
 - make a WiFi network named `STEMI-<7-digit serial number>`
   - you can connect to using password `12345678`
   - you can open a simple web interface at `192.168.4.1`
   - there you can find a way to connect a robot to your home router and obtain IP address via DHCP
 - connect it to your smartphone via STEMI iOS or Android app

This repo contains the binaries ready to be flashed to the ESP-12F chips in the `bin` directory.
In the `src` directory you can find Lua scripts and web page files. You can examine them to get a better insight into the STEMI hexapod, and also feel free to modify them to suit your needs.

## How to flash the firmware

To flash the firmware, use [esptool](https://github.com/themadinventor/esptool).

On Ubuntu, you can install *esptool* with:

    sudo apt install python-pip
    sudo pip install esptool

Then position yourself in `esp-stemi-firmware/bin` directory and execute `flash.sh`:
```bash
$ cd esp-stemi-firmware/bin
$ chmod +x flash.sh
$ ./flash.sh
```
If you get an error saying that you do not have a permission to access `/dev/ttyUSB0`, you need to add your user to the `dialout` group, or user `sudo`.

    sudo adduser <USER> dialout

Restart your chip and WiFi network with a name `STEMI-<7-digit serial number>` should appear. You can connect to it with the STEMI smartphone app, or with a computer using a password `12345678`. Default IP in Access Point mode is `192.168.4.1`.

## Upload custom scripts

Flashing ESP-12F with a binary file is a good way of uploading all the code from this repo, but what if you want to make changes? This can be done by modifying the Lua scripts or web files and uploading it to the chip.

To upload the files use [nodemcu-uploader](https://github.com/kmpm/nodemcu-uploader).

On Ubuntu 16.04, you can install *nodemcu-uploader* with:

    sudo apt install python-pip
    sudo pip install nodemcu-uploader

Navigate to `esp-stemi-firmware/src`, and execute `upload.sh`.

```bash
$ cd esp-stemi-firmware/src/
$ chmod +x upload.sh
$ ./upload.sh
```

## Building STEMI hexapod firmware on Ubuntu

What if uploading the custom scripts is not good enough? What if you want to take it to the next level and build the firmware yourself. Maybe you want to add some extra Lua modules, since our firmware is built with the minimum subset that we need (`node, net, wifi, cjson, file, uart`). Read on and find out how.

If you get stuck, it doesn't hurt to read [the official docs](https://nodemcu.readthedocs.io/en/master/en/build/) on building `nodemcu-firmware`.

First, install the neccesarry tools:

    $ sudo apt install make unrar autoconf automake libtool \
                       gcc g++ gperf flex bison python-pip \
                       texinfo gawk ncurses-dev libexpat-dev \
                       python sed git python-dev    
    $ sudo -H pip install pyserial esptool

### Clone esp-open-sdk

Clone esp-open-sdk in your $HOME directory:

      git clone --recursive https://github.com/pfalcon/esp-open-sdk

Make the esp-open-sdk:

      make STANDALONE=y |& tee make0.log

Add xtensa binaries to path:

      export PATH="$HOME/esp-open-sdk/xtensa-lx106-elf/bin/:$PATH"

Consider putting this line into your .bashrc directory

### Clone `nodemcu-firmware` for STEMI hexapod to your `$HOME` direcory:

    git clone https://github.com/stemi-education/nodemcu-firmware.git

Move all the Lua scripts and web files you wish to be on the filesystem of ESP to the `nodemcu-firmware/local/fs` directory.
Build the firmware:

    make all

If the build was successful `nodemcu-firmware/bin` directory should contain binary files for the ESP. To learn how to flash it to the ESP chip, examine the `bin/flash.sh` script of the `esp-stemi-firmware` repo, or read [the official docs](https://nodemcu.readthedocs.io/en/master/en/flash/) on the subject.
