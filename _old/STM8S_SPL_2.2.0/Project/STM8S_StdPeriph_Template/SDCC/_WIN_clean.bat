REM just for output
echo off
cls

REM target device
set DEVICE=STM8AF52Ax

REM set make tool (if not in PATH, set complete path)
set MAKE=mingw32-make

REM use makefile to delete sdcc output
REM %MAKE% -f Makefile DEVICE=%DEVICE% clean

REM also delete output folders
rd /S /Q  %DEVICE%

echo on
