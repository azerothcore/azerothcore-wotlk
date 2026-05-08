# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore module
## CrossFaction Battleground
- Latest build status with azerothcore: [![Build Status](https://github.com/azerothcore/mod-cfbg/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-cfbg)

### Module currently requires:
* Need AC commit [`d40e8946`](https://github.com/azerothcore/azerothcore-wotlk/commit/d40e8946180129b39172c2a1b4d690aa71723917) or newer.

## About module
This module based patch https://gist.github.com/irancore/10913800. 
But, all mechanics of change of fraction and so on is remade. Faction change occurs only for BG and nowhere else.

#### Features:
- Change you faction in bg for balance faction.

#### Config option (CFBG.conf.dist)
```ini
###################################################################################################
#   CrossFaction BattleGround
#   
#   CFBG.Enable
#       Description: Enable mixed alliance and horde in one battleground 
#       Default: 1
#
#   CFBG.Include.Avg.Ilvl.Enable
#       Description: Enable check average item level for bg
#       Default: 1
#

CFBG.Enable = 1
CFBG.Include.Avg.Ilvl.Enable = 1
CFBG.Players.Count.In.Group = 3
```

### How to install
1. Simply place the module under the `modules` folder of your AzerothCore source folder.
2. Re-run cmake and launch a clean build of AzerothCore
3. Make sure your `Battleground.InvitationType` is set to `0` in `worldserver.conf`
4. Done :)

### Edit module configuration (optional)
If you need to change the module configuration, go to your server configuration folder (where your worldserver or `worldserver.exe` is), copy `CFBG.conf.dist` to `CFBG.conf` and edit that new file.

### Usage
- Enable system `CFBG.Enable = 1`
- Enter BG

## Credits
- [Winfidonarleyan](https://github.com/Winfidonarleyan) (Author of the module)
- [Viste](https://github.com/Viste) (Port Irancore's code to AC)
- [Irancore](https://github.com/Irancore) (Author original code for TrinityCore)
- [AzerothCore repository](https://github.com/azerothcore/azerothcore-wotlk)
- [Discord AzerothCore](https://discord.gg/PaqQRkd)
