# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

## mod-solocraft

- Latest build status with azerothcore:

[![Build Status](https://github.com/azerothcore/mod-solocraft/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-solocraft)

## Description

- Adjusts player stats for raids based on the # of players in the group
- Configurable debuff for groups trying to overload the difficulty modifier for an instance
- Adjustable stats modifier in config
- Config: Difficulty settings for each instance and type
- Now includes a Spellpower buff: Adjustable modifier in config
- Saves your modifier settings in database.
- Max level thresholds can be set to not buff players whose level is too far over the dungeon level

## How to use ingame

1. Enable in conf
2. Go into conf and set any features you want to enable or modify
3. Enter Dungeon or Raid

## Requirements

- AzerothCore v1.0.1+

## Installation

```
1) Simply place the module under the `modules` directory of your AzerothCore source. 
2) Import the SQL to the right Database (character)
3) Re-run cmake and launch a clean build of AzerothCore.
```

## Edit module configuration (optional)

If you need to change the module configuration, go to your server configuration folder (where your worldserver or worldserver.exe is), copy Solocraft.conf.dist to Solocraft.conf and edit that new file.

### Data ###

------------------------------------------------------------------------------------------------------------------

- Type: Server/Player
- Script: Solocraft
- Config: Yes
- SQL: Yes

### Credits ###

------------------------------------------------------------------------------------------------------------------
- [DavidMacalaster](https://github.com/DavidMacalaster/Solocraft)
- [Blizzard Entertainment](http://blizzard.com)
- [TrinityCore](https://github.com/TrinityCore/TrinityCore/blob/3.3.5/THANKS)
- [SunwellCore](http://www.azerothcore.org/pages/sunwell.pl/)
- [EMUDevs](https://youtube.com/user/EmuDevs)
- [AC-Web](http://ac-web.org/)
- [ModCraft.io](http://modcraft.io/)
- [OwnedCore](http://ownedcore.com/)
- [OregonCore](https://wiki.oregon-core.net/)
- [Wowhead.com](http://wowhead.com)
- [AoWoW](https://wotlk.evowow.com/)
- AzerothCore: [repository](https://github.com/azerothcore) - [website](http://azerothcore.org/) - [discord chat community](https://discord.gg/PaqQRkd)
