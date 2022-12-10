@ECHO OFF
CLS

:MENU
ECHO.
ECHO ...............................................
ECHO AzerothCore dbc, maps, vmaps, mmaps extractor
ECHO ...............................................
ECHO PRESIONE 1, 2, 3 O 4 para seleccionar su tarea, o 5 para SALIR.
ECHO ...............................................
ECHO.
ECHO ADVERTENCIA: al extraer los vmaps del extractor
ECHO la salida del texto de abajo, es intencional y no un error:
ECHO ..........................................
ECHO Extracting World\Wmo\Band\Final_Stage.wmo
ECHO No such file.
ECHO Couldn't open RootWmo!!!
ECHO Done!
ECHO ..........................................
ECHO.
ECHO Pulse 1, 2, 3 o 4 para iniciar la extraccion o 5 para salir.
ECHO 1 - Extraer los archivos base (NECESARIOS) y las cámaras.
ECHO 2 - Extraer vmaps (necesita que los mapas se extraigan antes de ejecutar esto) (OPCIONAL, muy recomendable)
ECHO 3 - Extraer mmaps (necesita que los vmaps se extraigan antes de ejecutar esto, puede llevar horas) (OPCIONAL, muy recomendable)
ECHO 4 - Extraer todo (puede llevar varias horas)
ECHO 5 - SALIR
ECHO.
SET /P M=Escriba 1, 2, 3, 4 o 5 y pulse ENTER: 
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
ECHO Esto puede tardar unas horas en completarse. Por favor, tenga paciencia.
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
ECHO Esto puede tardar unas horas en completarse. Por favor, tenga paciencia.
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
