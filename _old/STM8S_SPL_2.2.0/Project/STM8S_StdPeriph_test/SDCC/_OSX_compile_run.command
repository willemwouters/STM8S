#!/bin/bash 

# change to current working directory
cd `dirname $0`

# just for output
echo off
clear

# target device
DEVICE=STM8AF52Ax

# set make tool (if not in PATH, set complete path)
MAKE=make

# set STM8 flasher tool (if not in PATH, set complete path)
LOADER=~/Public/GitHub/STM8_serial_flasher/STM8_serial_flasher

# set COM port for flash loader
PORT=/dev/tty.usbserial-A4009I0O

# target hexfile
TARGET=./$DEVICE/$DEVICE.hex

# make project; check for output folder (=device name)
echo "make application"
test -d $DEVICE || mkdir $DEVICE
$MAKE -f Makefile DEVICE=$DEVICE
if [ $? -ne 0 ]; then
  echo " "
  read -p "press key to close window..."
  echo on
  exit
fi
echo "done with application"
echo " "

# ask user to put STM8 to bootloader mode
echo " "
echo " "
echo "reset STM8 and press return"
echo " "
read -p ""

# upload using STM8 bootloader (use flash tool from GitHub)
$LOADER -p $PORT -f $TARGET -q


echo " "
read -p "press key to close window..."
echo on
