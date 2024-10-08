### [![Eluna](src/LuaEngine/docs/Eluna.png)](https://github.com/ElunaLuaEngine/Eluna)

## About

Eluna Lua Engine &copy; is a lua engine embedded to World of Warcraft emulators. Eluna supports MaNGOS, CMaNGOS, TrinityCore and AzerothCore.
We are currently working hard to make Eluna better from inside and outside.  

If you are having trouble with installation or scripts, please feel free to open an issue.
For documentation and reference see [Eluna API (AC version)](https://www.azerothcore.org/pages/eluna/index.html) and [Lua reference manual](http://www.lua.org/manual/5.2/).


## Community

You can join the official Eluna Discord server, where you'll be able to find resources, releases and support provided by the community:
<a href="https://discord.gg/bjkCVWqqfX">
    <img src="https://img.shields.io/badge/discord-join-7289DA.svg?logo=discord&longCache=true&style=flat" />
</a>

The official Azerothcore Discord server offers a channel dedicated to lua development as well:
<a href="https://discord.gg/gkt4y2x">
    <img src="https://img.shields.io/badge/discord-join-7289DA.svg?logo=discord&longCache=true&style=flat" />
</a>

# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) mod-eluna for AzerothCore
- Latest build status with azerothcore: [![Build Status](https://github.com/azerothcore/mod-eluna/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-eluna)

[english](README.md) | [中文说明](README_CN.md) | [Español](README_ES.md)

An [Eluna](https://github.com/ElunaLuaEngine/Eluna) module for AzerothCore.


## How to install:

### 1) Download the sources

You can get the sources using git.

#### download with git

1. open a terminal inside your `azerothcore-wotlk` folder
2. go inside the **modules** folder: `cd modules`
3. download the module sources using:
```
git clone https://github.com/azerothcore/mod-eluna.git mod-eluna
```

### 2) Build

You need to run the cmake again and rebuild the project.

Eluna API for AC: 
[https://www.azerothcore.org/pages/eluna/index.html](https://www.azerothcore.org/pages/eluna/index.html)


## Documentation

* [Getting started](https://github.com/ElunaLuaEngine/Eluna/blob/master/docs/USAGE.md)
* [Eluna features](https://github.com/ElunaLuaEngine/Eluna/blob/master/docs/IMPL_DETAILS.md)
* [Function documentation (AC version)](https://www.azerothcore.org/pages/eluna/index.html)
* [Hook documentation](https://github.com/ElunaLuaEngine/Eluna/blob/master/Hooks.h)
* [Lua reference manual](http://www.lua.org/manual/5.2/)
* [Forum - support, releases, guides](https://www.getmangos.eu/forums/forum/119-eluna-central/)
* [Example scripts](https://github.com/ElunaLuaEngine/Scripts)
* [Contributing](https://github.com/ElunaLuaEngine/Eluna/blob/master/docs/CONTRIBUTING.md)


## Links

* [MaNGOS](http://getmangos.eu/)
* [cMaNGOS](http://cmangos.net/)
* [TrinityCore](http://www.trinitycore.org/)
* [AzerothCore](http://www.azerothcore.org/)
* [Lua.org](http://www.lua.org/)
* [License](https://github.com/ElunaLuaEngine/Eluna/blob/master/docs/LICENSE.md)


## Additions from Eluna/master

### Player
- Added `RegisterPlayerEvent` `43` (`PLAYER_EVENT_ON_PET_ADDED_TO_WORLD`) fires for pets and summoned creatures: https://github.com/azerothcore/mod-eluna/pull/3
- Added `RegisterPlayerEvent` `44` (`PLAYER_EVENT_ON_LEARN_SPELL`): https://github.com/azerothcore/mod-eluna/pull/46
- Added `RegisterPlayerEvent` `45` (`PLAYER_ON_ACHIEVEMENT_COMPLETE`): https://github.com/azerothcore/mod-eluna/pull/47
- Added `RegisterPlayerEvent` `46` (`PLAYER_EVENT_ON_FFAPVP_CHANGE`): https://github.com/azerothcore/mod-eluna/pull/63
- Added `RegisterPlayerEvent` `47` (`PLAYER_EVENT_ON_UPDATE_AREA`): https://github.com/azerothcore/mod-eluna/pull/65
- Added `RegisterPlayerEvent` `48` (`PLAYER_EVENT_ON_CAN_INIT_TRADE`): https://github.com/azerothcore/mod-eluna/pull/83
- Added `RegisterPlayerEvent` `49` (`PLAYER_EVENT_ON_CAN_SEND_MAIL`): https://github.com/azerothcore/mod-eluna/pull/85
- Added `RegisterPlayerEvent` `50` (`PLAYER_EVENT_ON_CAN_JOIN_LFG`): https://github.com/azerothcore/mod-eluna/pull/86
- Added `RegisterPlayerEvent` `51` (`PLAYER_EVENT_ON_QUEST_REWARD_ITEM`): https://github.com/azerothcore/mod-eluna/pull/88
- Added `RegisterPlayerEvent` `52` (`PLAYER_EVENT_ON_CREATE_ITEM`): https://github.com/azerothcore/mod-eluna/pull/88
- Added `RegisterPlayerEvent` `53` (`PLAYER_EVENT_ON_STORE_NEW_ITEM`): https://github.com/azerothcore/mod-eluna/pull/88
- Added `RegisterPlayerEvent` `54` (`PLAYER_EVENT_ON_COMPLETE_QUEST`): https://github.com/azerothcore/mod-eluna/pull/90
- Added `RegisterPlayerEvent` `55` (`PLAYER_EVENT_ON_CAN_GROUP_INVITE`): https://github.com/azerothcore/mod-eluna/pull/100
- Added `RegisterPlayerEvent` `56` (`PLAYER_EVENT_ON_GROUP_ROLL_REWARD_ITEM`): https://github.com/azerothcore/mod-eluna/pull/119
- Added `RegisterPlayerEvent` `57` (`PLAYER_EVENT_ON_BG_DESERTION`): https://github.com/azerothcore/mod-eluna/pull/146
- Added `Player:GetMailCount()`: https://github.com/azerothcore/mod-eluna/pull/76
- Added `Player:GetXP()`: https://github.com/azerothcore/mod-eluna/pull/77
- Added `Player:GetAchievementCriteriaProgress()`: https://github.com/azerothcore/mod-eluna/pull/78
- Added vendor entry as argument to `Player:SendListInventory(object, vendorentry)`: https://github.com/azerothcore/mod-eluna/pull/48
- Added `Player:GetPlayerSettingValue()` and `Player:UpdatePlayerSetting()`: https://github.com/azerothcore/mod-eluna/pull/125
- Added `Player:GetTrader()`: https://github.com/azerothcore/mod-eluna/pull/126
- Added `Player:CanCompleteRepeatableQuest(questId)`: https://github.com/azerothcore/mod-eluna/pull/141
- Added `Player:CanRewardQuest(questId)`: https://github.com/azerothcore/mod-eluna/pull/141
- Added `Player:SetGlyph(glyphId, slotIndex)`: https://github.com/azerothcore/mod-eluna/pull/152

### Group
- Added `Group:GetGroupType()`: https://github.com/azerothcore/mod-eluna/pull/82
- Added `Group:SetMemberFlag()`: https://github.com/azerothcore/mod-eluna/pull/102

### Unit
- Added `Unit:ModifyThreatPct()`: https://github.com/azerothcore/mod-eluna/pull/25
- Added `Unit:GetAttackers()`: https://github.com/azerothcore/mod-eluna/pull/116
- Added `Unit:GetThreatList()`: https://github.com/azerothcore/mod-eluna/pull/117
- Added `Unit:GetUnitFlags()`: https://github.com/azerothcore/mod-eluna/pull/137
- Added `Unit:GetUnitFlagsTwo()`: https://github.com/azerothcore/mod-eluna/pull/137
- Added `Unit:SetUnitFlags(flags)`: https://github.com/azerothcore/mod-eluna/pull/137
- Added `Unit:SetUnitFlagsTwo(flags)`: https://github.com/azerothcore/mod-eluna/pull/137
- Added `Unit:SetSpeedRate(unitMoveType, speed)`: https://github.com/azerothcore/mod-eluna/pull/155
- Added `Unit:SetSpeedRate()`: https://github.com/azerothcore/mod-eluna/pull/155

### GameObject
- Added `GameObject:AddLoot()` to add loot at runtime to an **empty** container: https://github.com/azerothcore/mod-eluna/pull/52

### Object
- Added `Object:IsPlayer()`: https://github.com/azerothcore/mod-eluna/pull/42

### Item
- Added `Item:GetItemTemplate()`: https://github.com/azerothcore/mod-eluna/pull/84

### Misc
- Added `HttpRequest()`: https://github.com/azerothcore/mod-eluna/pull/2
- Added `GetItemTemplate(itemEntry)`: https://github.com/azerothcore/mod-eluna/pull/84
- Added `ChatHandler` methods: https://github.com/azerothcore/mod-eluna/pull/23
- Added `ItemTemplate` methods: https://github.com/azerothcore/mod-eluna/pull/84
- Added `Roll` methods: https://github.com/azerothcore/mod-eluna/pull/119
- Added logging with `ELUNA_LOG_INFO` for `RunCommand()`: https://github.com/azerothcore/mod-eluna/pull/75
- Added `GetOwnerHalaa` and `SetOwnerHalaa`: https://github.com/azerothcore/mod-eluna/pull/79
- Added `WorldDBQueryAsync`, `CharDBQueryAsync` and `AuthDBQueryAsync`: https://github.com/azerothcore/mod-eluna/pull/113
