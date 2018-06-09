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

# use Makefiles to delete outputs
#$MAKE -f Makefile DEVICE=$DEVICE clean 

# also delete output folders
rm -fr $DEVICE

echo on
