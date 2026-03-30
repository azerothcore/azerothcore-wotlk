#!/bin/bash
function Base {
    echo "Extrayendo archivos base"
    rm -rf dbc maps Cameras
    ./map_extractor
    Menu
}

function VMaps {
    echo "Extrayendo VMaps"
    mkdir -p Buildings vmaps
    rm -rf Buildings/* vmaps/*
    ./vmap4_extractor
    ./vmap4_assembler Buildings vmaps
    rmdir -rf Buildings
    Menu
}

function MMaps {
    echo "Esto puede tardar unas horas en completarse. Por favor, tenga paciencia."
    mkdir -p mmaps
    rm -rf mmaps/*
    ./mmaps_generator
    Menu
}

function All {
    echo "Esto puede tardar varias horas en completarse. Por favor, tenga paciencia."
    rm -rf dbc maps Cameras
    mkdir -p Buildings vmaps mmaps
    rm -rf Buildings/* vmaps/* mmaps/*
    ./map_extractor
    ./vmap4_extractor
    ./vmap4_assembler Buildings vmaps
    rmdir -rf Buildings
    ./mmaps_generator
    Menu
}

function Menu {
echo ""
echo "..............................................."
echo "Extractor de dbc, maps, vmaps, mmaps de AzerothCore"
echo "..............................................."
echo "PRESIONE 1, 2, 3 O 4 para seleccionar su tarea, o 5 para SALIR."
echo "..............................................."
echo ""
echo "ADVERTENCIA: al extraer los vmaps del extractor"
echo "la salida del texto de abajo, es intencional y no un error:"
echo ".........................................."
echo "Extracting World\Wmo\Band\Final_Stage.wmo"
echo "No such file."
echo "Couldn't open RootWmo!!!"
echo "Done!"
echo ".........................................."
echo ""
echo "Presione 1, 2, 3 o 4 para iniciar la extracción o 5 para salir."
echo "1 - Extraer los archivos base (NECESARIOS) y las cámaras."
echo "2 - Extraer vmaps (necesita que los mapas se extraigan antes de ejecutar esto) (OPCIONAL, muy recomendable)"
echo "3 - Extraer mmaps (necesita que los vmaps se extraigan antes de ejecutar esto, puede llevar horas) (OPCIONAL, muy recomendable)"
echo "4 - Extraer todo (puede llevar varias horas)"
echo "5 - SALIR"
echo ""

read -rp "Escriba 1, 2, 3, 4 o 5 y pulse ENTER: " choice

case $choice in
    1) Base ;;
    2) VMaps ;;
    3) MMaps ;;
    4) All ;;
    5) exit 0;;
    *) echo "Opción inválida."; read -rp "Escriba 1, 2, 3, 4 o 5 y presione ENTER: " choice ;;
esac
}

if [ -d "./Data" ] && [ -f "map_extractor" ] && [ -f "vmap4_extractor" ] && [ -f "vmap4_assembler" ] && [ -f "mmaps_generator" ]; then
    echo "Los archivos y carpetas requeridos existen en el directorio actual."
    chmod +x map_extractor vmap4_extractor vmap4_assembler mmaps_generator
    Menu
else
    echo "Uno o más archivos o carpetas requeridos no se encuentran en el directorio actual."
    echo "Coloque map_extractor vmap4_extractor vmap4_assembler mmaps_generator"
    echo "en su directorio de WoW junto con WoW.exe"
fi
