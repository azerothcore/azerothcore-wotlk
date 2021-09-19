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
start /b /w mapextractor.exe
cls
GOTO MENU

:VMAPS
start /b /w vmap4extractor.exe
if not exist vmaps md vmaps
start /b /w vmap4assembler.exe Buildings vmaps
rmdir Buildings /s /q
cls
GOTO MENU

:MMAPS
ECHO Esto puede tardar unas horas en completarse. Por favor, tenga paciencia.
ECHO Pulse una tecla para continuar.
PAUSE
if not exist mmaps md mmaps
start /b /w mmaps_generator.exe
cls
GOTO MENU

:ALL
ECHO Esto puede tardar unas horas en completarse. Por favor, tenga paciencia.
ECHO Pulse una tecla para continuar.
PAUSE
if not exist vmaps md vmaps
if not exist mmaps md mmaps
start /b /w mapextractor.exe
start /b /w vmap4extractor.exe
start /b /w vmap4assembler.exe Buildings vmaps
rmdir Buildings /s /q
start /b /w mmaps_generator.exe
cls
GOTO MENU
