
# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) mod-eluna-lua-engine for AzerothCore
- Latest build status with azerothcore: [![Build Status](https://github.com/azerothcore/mod-eluna-lua-engine/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-eluna-lua-engine)

[english](README.md) | [中文说明](README_CN.md) | [Español](README_ES.md)

一个用于Azerothcore的[Eluna](https://github.com/ElunaLuaEngine/Eluna)模块. 

## 如何安装:

### 1) 下载源码

你可以使用git(推荐)或手动下载源代码的方法安装。

#### 使用git(推荐)下载 

1. 在你的`azerothcore-wotlk`源码文件夹中打开命令行(win的用户进入目录后shift+鼠标右键可以通过右键菜单打开)
2. 进入 **modules** 文件夹,命令行中输入: `cd modules`
3. 下载模块源码:
```
git clone https://github.com/azerothcore/mod-eluna-lua-engine.git
```
4. 下载模块源码后进入文件夹 **mod-eluna-lua-engine**,命令行中输入: `cd mod-eluna-lua-engine`
5. 下载Eluna源码,命令行中输入: `git submodule update --init`

可选: 模块中集成的Eluna是稳定版本,如果你要更新Eluna到最新版本,你可以进入目录**LuaEngine**(命令行输入:`cd LuaEngine`),进入后输入`git pull`获取即可更新最新版本.
请注意,最新版本可能和稳定版的源码不匹配.视情况可能需要自行修正.

#### 手动下载

1. 下载 [mod-eluna-lua-engine](https://github.com/azerothcore/mod-eluna-lua-engine/archive/master.zip)  
2. 解压到你的`azerothcore-wotlk`源码中的**modules**文件夹中,请确保路径看起来是这样的`azerothcore-wotlk/modules/mod-eluna-lua-engine`
3. 下载 [Eluna](https://github.com/ElunaLuaEngine/Eluna/archive/master.zip) 
4. 把文件解压到 `mod-eluna-lua-engine/LuaEngine`. `LuaEngine.h`这个文件的路径看起来应该是这样的`mod-eluna-lua-engine/LuaEngine/LuaEngine.h`.

### 2) 生成

你需要重新CMake并重新生成你的项目.


Eluna API : 
[http://elunaluaengine.github.io/](http://elunaluaengine.github.io/)
