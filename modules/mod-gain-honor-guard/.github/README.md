# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

## Gain Honor Guard - Module

- Latest build status with azerothcore:

[![Build Status](https://github.com/azerothcore/mod-gain-honor-guard/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-gain-honor-guard)

Players on servers that are for Solo or are very low populated may have a difficult time gaining Honor, due to no battlegrounds or world PVP happening.

This module gives players the ablilty to farm Guards and/or Elites for Honor.

## Features

- Enable/Disable module
- Announcement of enabled module on login
- Enable Guard and Elite gain Honor on kill separately
- Change the amount of Honor gained for Elite/Guard killed.
- Enable/Disable the option to announce when Honor is gained (Elites and Guard configured separately).
- Adjusts Honor gained if in a group.
- Only awards Honor if Guard/Elite is not gray (too low level) to your character.
- Character must be alive and not in an Arena to gain Honor.

## How to use ingame

1. Enable module in conf file.
2. Go into conf and enable any other features you want.
3. Kill a Guard and/or Elite close to your level and gain Honor.

## Installation

```
1) Simply place the module under the `modules` directory of your AzerothCore source.
2) Re-run cmake and launch a clean build of AzerothCore.
```

## Edit module configuration (optional)

If you need to change the module configuration, go to your server configuration folder (where your worldserver or worldserver.exe is), copy GainHonorGuard.conf.dist to GainHonorGuard.conf and edit that new file.

## Troubleshooting

- If you do not get Honor from killing a Guard it may be because the database does not classify the creature killed to be a Guard.

The Guard classification is done in the Creature_Template -> flags_extra.  Value 32768 would need to be added to the flags_extra column.

Refer to the Wiki for information on the flags_extra column - [Creature_Template Wiki](https://www.azerothcore.org/wiki/creature_template#flags_extra)

### Data ###

------------------------------------------------------------------------------------------------------------------

- Type: Server/Player
- Script: GainHonorGuard
- Config: Yes
- SQL: No

### Credits ###

------------------------------------------------------------------------------------------------------------------
- [TrinityCore Patches](https://github.com/conan513/trinitycore-patches)
- AzerothCore: [repository](https://github.com/azerothcore) - [website](http://azerothcore.org/) - [discord chat community](https://discord.gg/PaqQRkd)
