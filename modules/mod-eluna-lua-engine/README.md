# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) mod-eluna-lua-engine for AzerothCore
- Latest build status with azerothcore: [![Build Status](https://github.com/azerothcore/mod-eluna-lua-engine/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-eluna-lua-engine)

[english](README.md) | [中文说明](README_CN.md) | [Español](README_ES.md)

An [Eluna](https://github.com/ElunaLuaEngine/Eluna) module for AzerothCore.

## How to install:

### 1) Download the sources

You can get the sources either using git (recommended) or downloading them manually.

#### download with git (recommended)

1. open a terminal inside your `azerothcore-wotlk` folder
2. go inside the **modules** folder: `cd modules`
3. download the module sources using:
```
git clone https://github.com/azerothcore/mod-eluna-lua-engine.git
```
4. go inside the **mod-eluna-lua-engine** folder: `cd mod-eluna-lua-engine`
5. download the Eluna sources using `git submodule update --init`

Optional: if you need to update Eluna to the latest version, you can `cd LuaEngine` and run `git pull` from there.

#### download manually 

1. download [mod-eluna-lua-engine](https://github.com/azerothcore/mod-eluna-lua-engine/archive/master.zip)  
2. extract it move the folder **mod-eluna-lua-engine** inside the **modules** folder of your azerothcore-wotlk sources
3. download [Eluna](https://github.com/ElunaLuaEngine/Eluna/archive/master.zip) 
4. extract it and move all the files inside the `Eluna-master` folder into the `mod-eluna-lua-engine/LuaEngine` folder. `LuaEngine.h` needs to be directly under `mod-eluna-lua-engine/LuaEngine` without any extra sub-folders.

### 2) Build

You need to run the cmake again and and rebuild the project.

Eluna API : 
[http://elunaluaengine.github.io/](http://elunaluaengine.github.io/)
