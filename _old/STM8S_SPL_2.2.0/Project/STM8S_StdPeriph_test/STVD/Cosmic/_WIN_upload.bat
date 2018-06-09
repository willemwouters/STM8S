REM just for output
echo off
cls

REM set make tool (if not in PATH, set complete path)
set MAKE=mingw32-make

REM set path to STM8 flasher tool (own or by STM)
set LOADER=C:\Users\ick2bue\Documents\STM8_serial_flasher\STM8_serial_flasher.exe

REM set COM port for flash loader
set PORT=7

REM name of target hexfile
set TARGET=Debug\stm8af52ax.s19

REM ask user to put STM8 to bootloader mode
echo.
echo.
echo reset STM8 and press return
echo.
PAUSE 

REM upload using STM8 bootloader (use own flash tool or STMFlashLoader by STM)
%LOADER% -p COM%PORT% -f %TARGET% -q

REM clean up
:END
PAUSE
echo on
