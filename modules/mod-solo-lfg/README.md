# Solo Dungeon Finder

## Description

Allows for players to use dungeon finder solo or in groups less than and up to 5 players. Use on azerothcore 3.3.5a. Good companion module for mod-solocraft and mod-autobalance.

## Standard Installation
```
1. Apply lfg-solo.patch to your core.
2. Simply place the module under the `modules` directory of your AzerothCore source.
3.  Apply lfg-solo.patch to your core.
    a. In order to do this, please go to the root /azerothcore-wotlk of your installation.
    b. Then do git apply modules/mod-solo-lfg/lfg-solo.patch 
4. Re-run cmake and launch a clean build of AzerothCore.
```

## Docker Installation
```
1. Go inside your /modules/ folder
2. git clone https://github.com/milestorme/mod-solo-lfg.git
3. Apply lfg-solo.patch to your core.
    a. In order to do this, please go to the root /azerothcore-wotlk of your installation.
    b. Then do git apply modules/mod-solo-lfg/lfg-solo.patch 
    (make sure the path is indeed pointing to your lfg-solo.patch file)
4. Go to src/Lfg_solo.cpp and replace line 23 & 40 with ```   void OnLogin(Player* __attribute__ ((unused))player)``` save file.
5. Re-run cmake and launch a clean build of AzerothCore.
    a. Go to your root folder and  ./bin/acore-docker-build
    b. Then do a docker-compose up
```

## Edit module configuration (optional)

If you need to change the module configuration, go to your server configuration folder (where your `worldserver` or `worldserver.exe` is)
copy the file SoloLfg.conf.dist to SoloLfg.conf and edit it (keep both files).

## Standard Uninstallation
```
1. Remove the lfg-solo.patch from y our core.
    a. In order to do this, please go to the root /azerothcore-wotlk of your installation.
    b. Then do git apply -R modules/mod-solo-lfg/lfg-solo.patch 
2. Re-run cmake and launch a clean build of AzerothCore.
```

## Docker Uninstallation
```
1. Remove the /modules/mod-solo-lfg folder
2. Remove the lfg-solo.patch from y our core.
    a. In order to do this, please go to the root /azerothcore-wotlk of your installation.
    b. Then do git apply -R modules/mod-solo-lfg/lfg-solo.patch 
3. Re-run cmake and launch a clean build of AzerothCore.
    a. Go to your root folder and  ./bin/acore-docker-build
    b. Then do a docker-compose up
```


## Credits
*  [Traesh: Original Script](https://github.com/Traesh)
*  [Micrah/Milestorme: Module Creator](https://github.com/milestorme).
*  [Conan513](https://github.com/conan513).
*  [Artanisx](https://github.com/Artanisx) - Update for Docker installations.
