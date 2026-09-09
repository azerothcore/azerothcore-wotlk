@echo off
if not "x%WDKDIR%" == "x" goto SELECT_BINARY
echo The WDKDIR environment variable is not set
echo Set this variable to your WDK directory (without ending backslash)
echo Example: set WDKDIR C:\WinDDK\6001
pause
goto:eof

:SELECT_BINARY
set PROJECT_DIR=%~dp0
set SAVE_PATH=%PATH%
set BINARY_NAME=StormLibWDK

:PREPARE_SOURCES
echo Preparing sources ...
copy .\src\wdk\sources-cpp.cpp . >nul
copy .\src\wdk\sources-wdk-*   . >nul
echo.

:BUILD_BINARY_64
echo Building %BINARY_NAME%.lib (64-bit) ...
set DDKBUILDENV=
call %WDKDIR%\bin\setenv.bat %WDKDIR%\ fre x64 wnet
cd /d %PROJECT_DIR%
build.exe -czgw
del buildfre_wnet_amd64.log
echo.

:BUILD_BINARY_32
echo Building %BINARY_NAME%.lib (32-bit) ...
set DDKBUILDENV=
call %WDKDIR%\bin\setenv.bat %WDKDIR%\ fre w2k
cd /d %PROJECT_DIR%
build.exe -czgw
del buildfre_w2k_x86.log
echo.

:COPY_OUTPUT
if not exist ..\aaa goto CLEANUP
if not exist ..\aaa\inc   md ..\aaa\inc
if not exist ..\aaa\lib32 md ..\aaa\lib32
if not exist ..\aaa\lib64 md ..\aaa\lib64
copy /Y .\src\StormLib.h  ..\aaa\inc >nul
copy /Y .\src\StormPort.h ..\aaa\inc >nul
copy /Y .\objfre_wnet_amd64\amd64\%BINARY_NAME%.lib ..\aaa\lib64\%BINARY_NAME%.lib >nul
copy /Y .\objfre_w2k_x86\i386\%BINARY_NAME%.lib     ..\aaa\lib32\%BINARY_NAME%.lib >nul

:CLEANUP
if exist sources-cpp.cpp del sources-cpp.cpp
if exist sources-wdk-* del sources-wdk-*
if exist build.bat del build.bat
set PATH=%SAVE_PATH%
