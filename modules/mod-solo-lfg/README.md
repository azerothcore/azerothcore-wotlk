# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

# Solo Dungeon Finder

- Latest build status with azerothcore:

[![Build Status](https://github.com/azerothcore/mod-solo-lfg/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-solo-lfg)

## Description

Allows for players to use dungeon finder solo or in groups less than and up to 5 players. Use on azerothcore 3.3.5a. Good companion module for mod-solocraft and mod-autobalance.

## Standard Installation
```
1. Go inside your /modules/ folder
2. git clone https://github.com/azerothcore/mod-solo-lfg.git
3. Re-run cmake and launch a clean build of AzerothCore. 
   a. If using AzerothCore Bash Dashboard setup: Do a ./acore.sh compiler configure followed by ./acore.sh compiler build.
   b. If using standard installation, refer to https://www.azerothcore.org/wiki/installation
```

## Docker Installation
```
1. Go inside your /modules/ folder
2. git clone https://github.com/azerothcore/mod-solo-lfg.git
3. Re-run cmake and launch a clean build of AzerothCore.
    a. Go to your root folder and  ./bin/acore-docker-build
    b. Then do a docker-compose up
```

## Edit module configuration (optional)

If you need to change the module configuration, go to your server configuration folder (where your `worldserver` or `worldserver.exe` is)
copy the file SoloLfg.conf.dist to SoloLfg.conf and edit it (keep both files).

## Standard Uninstallation
```
1. Remove the /modules/mod-solo-lfg folder
2. Re-run cmake and launch a clean build of AzerothCore.
```

## Docker Uninstallation
```
1. Remove the /modules/mod-solo-lfg folder
2. Re-run cmake and launch a clean build of AzerothCore.
    a. Go to your root folder and  ./bin/acore-docker-build
    b. Then do a docker-compose up
```

## Credits
*  [Traesh: Original Script](https://github.com/Traesh)
*  [Micrah/Milestorme: Module Creator](https://github.com/milestorme).
*  [Conan513](https://github.com/conan513).
*  [Artanisx](https://github.com/Artanisx) - Update for Docker installations. Updated LFG-Solo.patch to work with the latest AzerothCore version (17/09/2021). Updated standard installation instructions.
