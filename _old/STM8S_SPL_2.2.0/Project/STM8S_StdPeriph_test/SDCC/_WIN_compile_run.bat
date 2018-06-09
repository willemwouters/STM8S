REM just for output
echo off
cls

REM target device
set DEVICE=STM8AF52Ax

REM set make tool (if not in PATH, set complete path)
set MAKE=mingw32-make

REM set path to STM8 flasher tool (own or by STM)
set LOADER=C:\Users\ick2bue\Documents\STM8_serial_flasher\STM8_serial_flasher.exe
REM set LOADER=..\STM8_serial_flasher\STM8_serial_flasher.exe
REM set LOADER="C:\Program Files\STMicroelectronics\Software\Flash Loader Demonstrator\STMFlashLoader.exe"

REM set COM port for flash loader
set PORT=7

REM name of target hexfile
set TARGET=.\%DEVICE%\%DEVICE%.hex

REM compile and link
echo make application
if not exist %DEVICE% mkdir %DEVICE%
%MAKE% -f Makefile DEVICE=%DEVICE%
IF ERRORLEVEL 1 GOTO END
echo done with application
echo.

REM GOTO END

REM ask user to put STM8 to bootloader mode
echo.
echo.
echo reset STM8 and press return
echo.
PAUSE 

REM upload using STM8 bootloader (use own flash tool or STMFlashLoader by STM)
%LOADER% -p COM%PORT% -f %TARGET% -q
REM %LOADER% -c --pn %PORT% --br 115200 --co OFF --to 5000 -Dtr --Hi -Dtr --Lo -i STM8_128K -d --fn %TARGET% --v --o -r --a 0x8000 

REM clean up
:END
PAUSE
echo on
