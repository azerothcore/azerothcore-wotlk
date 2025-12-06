# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

## Beta testing warning

The current version of the master branch is currently in beta, under testing to ensure all the functionalities are working properly.
If you encur in problems please open an Issue and consider to use the last [stable version](https://github.com/azerothcore/mod-autobalance/releases/tag/stable) of this repository.

## AutoBalance

- Latest build status with azerothcore: [![Build Status](https://github.com/azerothcore/mod-autobalance/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-autobalance)

This module is intended to scale based on number of players, instance mobs and bosses' health, mana, and damage.

**NOTE:** This module requires at least [this commit](https://github.com/azerothcore/azerothcore-wotlk/commit/f127e583aae3cfa51a77d056c1892a7de07ffb52) of AzerothCore in order to work correctly. Older versions are not supported.

All settings are well-described in the configuration file.

**PLEASE** include the output from the `.ab mapstat` and `.ab creaturestat` commands (while targeting a problematic creature) when reporting issues. This will help us to quickly identify the problem and provide a solution.

## In-game Commands
| Command | Permission | Description |
| :------ | :--------- | :---------- |
| `.ab mapstat` | All Players | Displays AB-calcualted settings for the current map, including player count, difficulty, world modifiers, and others. |
| `.ab creaturestat` | All Players | Displays AB-calculated settings for the targeted dungeon creature including level scaling, difficulty, modifiers, and boss status. |
| `.ab setoffset` | Game Masters | Sets the server-wide player difficulty offset. Instances will be scaled as though they had this many more/less players than they really do. |
| `.ab getoffset` | All Players | Gets the current server-wide player difficulty offset. Instances will be scaled as though they had this many more/less players than they really do. |
| `.reload config` | Game Masters | Reloads all your configuration files, including `AutoBalance.conf`. This lets you update AutoBalance settings without restarting your worldserver. This module is designed to contiue to work as expected when this command is issued. |

## Logger Names
| Logger | Description |
| :----- | ----------- |
| `Logger.module.AutoBalance` | Main logger, verbose debug logs. Map detection, list management, creature adjustments, multiplier, modifiers. Catch-all. |
| `Logger.module.AutoBalance_CombatLocking` | Debug logs related to the combat locking/unlocking mechanism for maps. |
| `Logger.module.AutoBalance_DamageHealingCC` | Debug logs for the spell/melee/CC modifications that are made in real-time. |
| `Logger.module.AutoBalance_StatGeneration` | Detailed debug logs that show all the calculation steps in how different multipliers are derived. |

## References
- [Interactive Inflection Point Spreadsheet](https://docs.google.com/spreadsheets/d/100cmKIJIjCZ-ncWd0K9ykO8KUgwFTcwg4h2nfE_UeCc/copy)
- [InflectionPoint Curve Examples](https://i.imgur.com/x42UnUR.png)
- [Impact of CurveFloor and CurveCeiling on enemy multiplier](https://i.imgur.com/I8S4cwJ.png)
