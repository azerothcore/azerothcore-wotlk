@ECHO OFF
CLS

:MENU
ECHO.
ECHO ...............................................
ECHO AzerothCore dbc, maps, vmaps, mmaps extractor
ECHO ...............................................
ECHO PRESS 1, 2, 3 OR 4 to select your task, or 5 to EXIT.
ECHO ...............................................
ECHO.
ECHO WARNING! when extracting the vmaps extractor will
ECHO output the text below, it's intended and not an error:
ECHO ..........................................
ECHO Extracting World\Wmo\Band\Final_Stage.wmo
ECHO No such file.
ECHO Couldn't open RootWmo!!!
ECHO Done!
ECHO ..........................................
ECHO.
ECHO Press 1, 2, 3 or 4 to start extracting or 5 to exit.
ECHO 1 - Extract base files (NEEDED) and cameras.
ECHO 2 - Extract vmaps (needs maps to be extracted before you run this) (OPTIONAL, highly recommended)
ECHO 3 - Extract mmaps (needs vmaps to be extracted before you run this, may take hours) (OPTIONAL, highly recommended)
ECHO 4 - Extract all (may take hours)
ECHO 5 - EXIT
ECHO.
SET /P M=Type 1, 2, 3, 4 or 5 then press ENTER:
IF %M%==1 GOTO MAPS
IF %M%==2 GOTO VMAPS
IF %M%==3 GOTO MMAPS
IF %M%==4 GOTO ALL
IF %M%==5 GOTO :EOF

:MAPS
start /b /w map_extractor.exe
GOTO MENU

:VMAPS
start /b /w vmap4_extractor.exe
if exist vmaps\ (
    echo folder found.
) else (
    echo creating folder "vmaps".
    mkdir "vmaps"
)
start /b /w vmap4_assembler.exe Buildings vmaps
rmdir Buildings /s /q
GOTO MENU

:MMAPS
ECHO This may take a few hours to complete. Please be patient.
PAUSE
if exist mmaps\ (
    echo folder found.
) else (
    echo creating folder "mmaps".
    mkdir "mmaps"
)
start /b /w mmaps_generator.exe
GOTO MENU

:ALL
ECHO This may take a few hours to complete. Please be patient.
PAUSE
if exist vmaps\ (
    echo folder found.
) else (
    echo creating folder "vmaps".
    mkdir "vmaps"
)
if exist mmaps\ (
    echo folder found.
) else (
    echo creating folder "mmaps".
    mkdir "mmaps"
)
start /b /w map_extractor.exe
start /b /w vmap4_extractor.exe
start /b /w vmap4_assembler.exe Buildings vmaps
rmdir Buildings /s /q
start /b /w mmaps_generator.exe
GOTO MENU
