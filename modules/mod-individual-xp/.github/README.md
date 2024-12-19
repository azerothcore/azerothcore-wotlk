# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

## Individual XP Module

- Latest build status with azerothcore:

[![Build Status](https://github.com/azerothcore/mod-individual-xp/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-individual-xp)

This module allows each player to `view`, `enable`, `disable`, and `modify` their experience multiplier without having to modify the values of other players. This functionality can be accessed at any time through the use of commands. It is the player who decides how to play (`slow` or `fast`), rather than the server forcing them to decide for them.

# How to install

1. Clone this module into the modules directory of the main source
2. Re-run cmake
3. Compile.

# Config

There are two variables to configure in the Config:

- `IndividualXp.Enabled`
    - Enable or Disable the IndividualXP Module.
- `IndividualXp.Announce`
    - Announce the IndividualXP Module at logon.
- `IndividualXp.AnnounceRatesOnLogin`
    - The player is shown the rates he has and the maximum value when he enters the chat.
- `IndividualXp.MaxXPRate`
    - This is the max amount a player can set their xp to.
- `IndividualXp.DefaultXPRate`
    - This is the default rate players start with.

The Max XP Rate variable dictates how high a player can set their XP rate. While the Default XP Rate variable dictates what XP rate players start with and the rate will be set to if the user does `.xp default`. As a recommendation, it would be a good idea to set the default and maximum experience rates to match. In this way, all players would initially have the maximum experience on the server, and then, through the `.xp set` command, they could modify it.

# Player Commands

| Command     | Description                                       |
|-------------|---------------------------------------------------|
| .XP         | Main Module Command                               |
| .XP View    | Displays the current XP rate                      |
| .XP Set #   | Changes the XP rate to the value specified        |
| .XP Default | Returns the XP rate to the default value          |
| .XP Disable | Disables all XP gain until user does '.XP Enable' |
| .XP Enable  | Enables all XP gain if it was disabled            |

# Video Showcase

[![Youtube Link](https://i.imgur.com/Jhrdgv6.png)](https://www.youtube.com/watch?v=T6UEX47mPeE)

> [!IMPORTANT]
> If you no longer use the module, remember to delete any tables or values added within them.

### Database World

```sql
DELETE FROM `command` WHERE `name` IN ('xp', 'xp set', 'xp view', 'xp default', 'xp enable', 'xp disable');

SET @ENTRY:=35411;
DELETE FROM `acore_string` WHERE `entry` BETWEEN @ENTRY+0 AND @ENTRY+9;
```

### Database Characters

```sql
DROP TABLE `individualxp`;
```
