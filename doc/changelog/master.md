## 6.0.0-dev.3 | Commit: [44b7a0666c78dc99ab0bbc94045abb6685b3ad86
](https://github.com/azerothcore/azerothcore-wotlk/commit/44b7a0666c78dc99ab0bbc94045abb6685b3ad86


### Added

- New hook for OnQuestComputeXP(). The intended use is to change the XP values for certain quests programmatically. The hook is triggered after XP calculation and before rewarding XP or gold to the player.

### How to upgrade

- No special changes needed. The new hook is available for use and should not interfere with any existing hooks or logic.

## 6.0.0-dev.2 | Commit: [680e60c68b1864596bf23d427e9f4742c6437b86
](https://github.com/azerothcore/azerothcore-wotlk/commit/680e60c68b1864596bf23d427e9f4742c6437b86


### Changed
Removed Rate.XP.BattlegroundKill, added one rate config for each bg.

### How to upgrade

Delete Rate.XP.BattlegroundKill, and then set all the battlegroundkill rate for each bg.
Rate.XP.BattlegroundKillAV   = 1
Rate.XP.BattlegroundKillWSG  = 1
Rate.XP.BattlegroundKillAB   = 1
Rate.XP.BattlegroundKillEOTS = 1
Rate.XP.BattlegroundKillSOTA = 1
Rate.XP.BattlegroundKillIC   = 1


## 6.0.0-dev.1 | Commit: [de13bf426e162ee10cbd5470cec74122d1d4afa0
](https://github.com/azerothcore/azerothcore-wotlk/commit/de13bf426e162ee10cbd5470cec74122d1d4afa0


## How to upgrade
- `PrepareStatment`

```diff
- setNull(...)
+ SetData(...)
```
```diff
- setBool(...)
+ SetData(...)
```
```diff
- setUInt8(...)
+ SetData(...)
```
```diff
- setInt8(...)
+ SetData(...)
```
```diff
- setUInt16(...)
+ SetData(...)
```
```diff
- setInt16(...)
+ SetData(...)
```
```diff
- setUInt32(...)
+ SetData(...)
```
```diff
- setUInt64(...)
+ SetData(...)
```
```diff
- setInt64(...)
+ SetData(...)
```
```diff
- setFloat(...)
+ SetData(...)
```
```diff
- setDouble(...)
+ SetData(...)
```
```diff
- setString(...)
+ SetData(...)
```
```diff
- setStringView(...)
+ SetData(...)
```
```diff
- setBinary(...)
+ SetData(...)
```

- `Fields`

```diff
- GetBool()
+ Get<bool>()
```
```diff
- GetUInt8()
+ Get<uint8>()
```
```diff
- GetInt8()
+ Get<int8>()
```
```diff
- GetUInt16()
+ Get<uint16>()
```
```diff
- GetInt16()
+ Get<int16>()
```
```diff
- GetUInt32()
+ Get<uint32>()
```
```diff
- GetInt32()
+ Get<int32>()
```
```diff
- GetUInt64()
+ Get<uint64>()
```
```diff
- GetInt64()
+ Get<int64>()
```
```diff
- GetFloat()
+ Get<float>()
```
```diff
- GetDouble()
+ Get<double>()
```
```diff
- GetString()
+ Get<std::string>()
```
```diff
- GetStringView()
+ Get<std::string_view>()
```
```diff
- GetBinary()
+ Get<Binary>()
```

## 5.0.0-dev.1 | Commit: [8b7df23f064f8c1c41aea222342b53f109c4e3b9
](https://github.com/azerothcore/azerothcore-wotlk/commit/8b7df23f064f8c1c41aea222342b53f109c4e3b9


### How to upgrade

```diff
- time(nullptr)
+ GameTime::GetGameTime().count()
```
```diff
- sWorld->GetGameTime()
+ GameTime::GetGameTime().count()
```
```diff
- World::GetGameTimeMS()
+ GameTime::GetGameTimeMS().count()
```

## 5.0.0-dev.0 | Commit: [2fd8b00d7bac1f9c9b565916453cf490fb069df0
](https://github.com/azerothcore/azerothcore-wotlk/commit/2fd8b00d7bac1f9c9b565916453cf490fb069df0


We suggest that you always use the latest version of our master branch.
https://github.com/azerothcore/azerothcore-wotlk/tree/master

### How to upgrade

For server administrators: instructions about how to upgrade existing servers are available [here](http://www.azerothcore.org/wiki/Upgrade-from-pre-2.0.0-to-latest-master).

## Release notes

This PR removes the modelId column from creature table to allow us to move to a dual entry spawn system.

If this causes an issue for in game or custom spawns the following line of SAI can update the modelId.

(#entryorguid,0,0,0,11,0,100,0,0,0,0,0,0,3,0,#modelId,0,0,0,0,1,0,0,0,0,0,0,0,0,"Creature Name - On Spawn - Change Model to #modelId"),

Special thanks to @Shin @Kitzunu @M'Dic for assistance.

## 4.0.0-dev.13 | Commit: [bc82f36f1ff46bb21d32e1cfdaec8271dde08af1
](https://github.com/azerothcore/azerothcore-wotlk/commit/bc82f36f1ff46bb21d32e1cfdaec8271dde08af1


### Added

```cpp
// Unit.cpp
    virtual void Talk(std::string_view text, ChatMsg msgType, Language language, float textRange, WorldObject const* target);
    virtual void Say(std::string_view text, Language language, WorldObject const* target = nullptr);
    virtual void Yell(std::string_view text, Language language, WorldObject const* target = nullptr);
    virtual void TextEmote(std::string_view text, WorldObject const* target = nullptr, bool isBossEmote = false);
    virtual void Whisper(std::string_view text, Language language, Player* target, bool isBossWhisper = false);
    virtual void Talk(uint32 textId, ChatMsg msgType, float textRange, WorldObject const* target);
    virtual void Say(uint32 textId, WorldObject const* target = nullptr);
    virtual void Yell(uint32 textId, WorldObject const* target = nullptr);
    virtual void TextEmote(uint32 textId, WorldObject const* target = nullptr, bool isBossEmote = false);
    virtual void Whisper(uint32 textId, Player* target, bool isBossWhisper = false);
```

### Removed

```cpp
// Object.cpp
    void MonsterSay(const char* text, uint32 language, WorldObject const* target);
    void MonsterYell(const char* text, uint32 language, WorldObject const* target);
    void MonsterTextEmote(const char* text, WorldObject const* target, bool IsBossEmote = false);
    void MonsterWhisper(const char* text, Player const* target, bool IsBossWhisper = false);
    void MonsterSay(int32 textId, uint32 language, WorldObject const* target);
    void MonsterYell(int32 textId, uint32 language, WorldObject const* target);
    void MonsterTextEmote(int32 textId, WorldObject const* target, bool IsBossEmote = false);
    void MonsterWhisper(int32 textId, Player const* target, bool IsBossWhisper = false);

    void SendPlaySound(uint32 Sound, bool OnlySelf);
```

### How to upgrade

```diff
- creature->MonsterSay(text, LANG_XXX, nullptr);
+ creature->Say(text, LANG_XXX);

- creature->MonsterTextEmote(text, 0);
+ creature->TextEmote(text);

- creature->MonsterWhisper(text, receiver);
+ creature->Whisper(text, LANG_XXX, receiver);

- creature->MonsterYell(text, LANG_XXX, NULL);
+ creature->Yell(text, LANG_XXX);

- creature->MonsterWhisper(text, target, isBossWhisper);
+ creature->Whisper(text, LANG_XXX, target, isBossWhisper);

- SendPlaySound(uint32 Sound, bool OnlySelf);
 PlayDirectSound(uint32 sound_id, Player* target = nullptr);
```

## 4.0.0-dev.12 | Commit: [bcec4191e43de8a7b57a4219d6baaa7c5e3dfaf1
](https://github.com/azerothcore/azerothcore-wotlk/commit/bcec4191e43de8a7b57a4219d6baaa7c5e3dfaf1



### Added

- Added `OnPlayerPVPFlagChange` hook, it will be executed after the pvp flag from a player gets changed.



## 4.0.0-dev.11 | Commit: [d18545263fda54e19c875d22adfb28ae4072ec01
](https://github.com/azerothcore/azerothcore-wotlk/commit/d18545263fda54e19c875d22adfb28ae4072ec01


### Added

- Added `OnBeforeFinalizePlayerWorldSession ` that can be used to modify the cache version that is sent to the client via modules.
## 4.0.0-dev.10 | Commit: [0897705a6814fc19007e5f88fbcb98b3689880c9
](https://github.com/azerothcore/azerothcore-wotlk/commit/0897705a6814fc19007e5f88fbcb98b3689880c9


### How to upgrade

Upgrade your Boost version to 1.74 or higher.

## 4.0.0-dev.9 | Commit: [edfc2a8db48a17bf3e9ace0b36edc819aa0e5e23
](https://github.com/azerothcore/azerothcore-wotlk/commit/edfc2a8db48a17bf3e9ace0b36edc819aa0e5e23


Changelog for commit "[feature(Core/Spells): Allow to learn all spells for characters on creation](https://github.com/azerothcore/azerothcore-wotlk/commit/06ee4ea7c46a5c0494dd7502a7646e84f83dab89)"

### Added

- All abilities for classes up to TBC into playercreateinfo_spell_custom
- Config option PlayerStart.AllSpells - If enabled, players will start with all their class spells (not talents). You must populate playercreateinfo_spell_custom table with the spells you want, or this will not work! The table has data for all classes / races up to TBC expansion.

### Removed

- Config option PlayerStart.CustomSpells

### How to upgrade

- Update the worldserver.conf file with the new PlayerStart.AllSpells if you want to change it to "ON". Otherwise it will go with the default option "OFF" from the worldserver.conf.dist file.

## 4.0.0-dev.8 | Commit: [edfc2a8db48a17bf3e9ace0b36edc819aa0e5e23
](https://github.com/azerothcore/azerothcore-wotlk/commit/edfc2a8db48a17bf3e9ace0b36edc819aa0e5e23


Changelog for commit "[fix(Core/Player): Use SkillLineAbility.dbc to determine player initial spells - skill assignment done in a new table `playercreateinfo_skills`](https://github.com/azerothcore/azerothcore-wotlk/commit/1be561e03b56dc396270335886e59eddad9fa0c6)"

### Added

- playercreateinfo_skills - New Database table for skill assignment.

### Removed

- playercreateinfo_spells

### Changed

- Use SkillLineAbility.dbc to determine player initial spells.
- Renamed SkillLineAbilityEntry fields

### How to upgrade

```diff
-    uint32    id;                                           // 0        m_ID
-    uint32    skillId;                                      // 1        m_skillLine
-    uint32    spellId;                                      // 2        m_spell
-    uint32    racemask;                                     // 3        m_raceMask
-    uint32    classmask;                                    // 4        m_classMask
-    //uint32    racemaskNot;                                // 5        m_excludeRace
-    //uint32    classmaskNot;                               // 6        m_excludeClass
-    uint32    req_skill_value;                              // 7        m_minSkillLineRank
-    uint32    forward_spellid;                              // 8        m_supercededBySpell
-    uint32    learnOnGetSkill;                              // 9        m_acquireMethod
-    uint32    max_value;                                    // 10       m_trivialSkillLineRankHigh
-    uint32    min_value;                                    // 11       m_trivialSkillLineRankLow
-    //uint32    characterPoints[2];                         // 12-13    m_characterPoints[2]
+    uint32 ID;                                              // 0
+    uint32 SkillLine;                                       // 1
+    uint32 Spell;                                           // 2
+    uint32 RaceMask;                                        // 3
+    uint32 ClassMask;                                       // 4
+    //uint32 ExcludeRace;                                   // 5
+    //uint32 ExcludeClass;                                  // 6
+    uint32 MinSkillLineRank;                                // 7
+    uint32 SupercededBySpell;                               // 8
+    uint32 AcquireMethod;                                   // 9
+    uint32 TrivialSkillLineRankHigh;                        // 10
+    uint32 TrivialSkillLineRankLow;                         // 11
+    //uint32 CharacterPoints[2];                            // 12-13
```

- for example skillLine->forward_spellid will become skillLine->SupercededBySpell

## 4.0.0-dev.7 | Commit: [59a3912a3b3bd4dd2d8e2b1c2cdd225b9c4d6244
](https://github.com/azerothcore/azerothcore-wotlk/commit/59a3912a3b3bd4dd2d8e2b1c2cdd225b9c4d6244


### Removed
- Old gossips api [#5414](https://github.com/azerothcore/azerothcore-wotlk/pull/5414)

### How to upgrade
- `player->ADD_GOSSIP_ITEM(whatever)` -> `AddGossipItemFor(player, whatever)`
- `player->ADD_GOSSIP_ITEM_DB(whatever)` -> `AddGossipItemFor(player, whatever)`
- `player->ADD_GOSSIP_ITEM_EXTENDED(whatever)` -> `AddGossipItemFor(player, whatever)`
- `player->CLOSE_GOSSIP_MENU()` -> `CloseGossipMenuFor(player)`
- `player->SEND_GOSSIP_MENU(textid, creature->GetGUID())` -> `SendGossipMenuFor(player, textid, creature->GetGUID())`

You also need  `#include "ScriptedGossip.h"` in your cpp files

## 4.0.0-dev.6 | Commit: [59a3912a3b3bd4dd2d8e2b1c2cdd225b9c4d6244
](https://github.com/azerothcore/azerothcore-wotlk/commit/59a3912a3b3bd4dd2d8e2b1c2cdd225b9c4d6244


### Changed
- New options for loading scripts `static dynamic minimal-static minimal-dynamic` [#5346](https://github.com/azerothcore/azerothcore-wotlk/pull/5346)
```
static - Build statically. Default option. for all scripts (As it was before)
dynamic - Build dynamically. After start support Dynamic Linking Library (DLL) can make separated library for each script. Now don't support
minimal-static - builds commands and spells statically
minimal-dynamic - builds commands and spells dynamically. Now don't support
```
- Also the default value which is provided by the `SCRIPTS` variable is overwriteable through the `SCRIPTS_COMMANDS, SCRIPTS_SPELLS...` variable.
- Each subdirectory contains it's own translation unit now which is responsible for loading it's directory
- If module using deprecated script loader api, you get error message.
```cmake
> Module (mod-ah-bot) using deprecated loader api
```

### How to upgrade
- For most modules, the `CMakeLists.txt' file is no longer needed
- Need change script loader file.
```
1. Rename extension in file to `.cpp`
2. Rename general loading function to `Add(module name with replace all whitespace to '_')Scripts()`.
3. Delete macros `AC_ADD_SCRIPT_LOADER` from `CMakeLists.txt`
```
- Example loader script for modules:
```cpp
/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

// From SC
void AddSC_ServerAutoShutdown();

// Add all scripts
void Addmod_server_auto_shutdownScripts()
{
    AddSC_ServerAutoShutdown();
}
```
- List modules support new script loader api:
https://github.com/azerothcore/mod-server-auto-shutdown

## 4.0.0-dev.5 | Commit: [59a3912a3b3bd4dd2d8e2b1c2cdd225b9c4d6244
](https://github.com/azerothcore/azerothcore-wotlk/commit/59a3912a3b3bd4dd2d8e2b1c2cdd225b9c4d6244


### Added
- New cmake option `WITH_STRICT_DATABASE_TYPE_CHECKS` [#5611](https://github.com/azerothcore/azerothcore-wotlk/pull/5611)

### Changed
- Prevent mixing databases with query holders [#5611](https://github.com/azerothcore/azerothcore-wotlk/pull/5611)
- Prevent using prepared statements on wrong database [#5611](https://github.com/azerothcore/azerothcore-wotlk/pull/5611)
- Prevent committing transactions started on a different database [#5611](https://github.com/azerothcore/azerothcore-wotlk/pull/5611)
- Convert async queries to new query callbacks [#5611](https://github.com/azerothcore/azerothcore-wotlk/pull/5611)

### How to upgrade
- `PreparedStatement`
```diff
- PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_LOGONPROOF);
+ LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_LOGONPROOF);
```
- `SQLTransaction`
```diff
- SQLTransaction trans = CharacterDatabase.BeginTransaction();
+ CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
```
## 4.0.0-dev.4 | Commit: [fbad1f3d6c27a5d3eea22483913c67a827ab01be
](https://github.com/azerothcore/azerothcore-wotlk/commit/fbad1f3d6c27a5d3eea22483913c67a827ab01be


### Added
- new hook `OnBeforeSendJoinMessageArenaQueue` and `OnBeforeSendExitMessageArenaQueue`

### Changed
- Rename `CanExitJoinMessageArenaQueue` to `OnBeforeSendExitMessageArenaQueue`
- Rename `CanSendJoinMessageArenaQueue` to `OnBeforeSendJoinMessageArenaQueue`

### How to upgrade
- Just rename all hooks from `CanExitJoinMessageArenaQueue` and `CanSendMessageArenaQueue`, to `OnBeforeSendExitMessageArenaQueue`
- Just rename all hooks from `CanSendJoinMessageArenaQueue` and `OnBeforeSendJoinMessageArenaQueue`

## 4.0.0-dev.3 | Commit: [c35dde6fae732269357b78fb796fba21956b83fc
](https://github.com/azerothcore/azerothcore-wotlk/commit/c35dde6fae732269357b78fb796fba21956b83fc


Changelog for commit "[refactor(Collision): Update some methods to UpperCamelCase](https://github.com/azerothcore/azerothcore-wotlk/commit/b84f9b8a4b334632cb37dcebbb2dd4e087f65610)"

### Changes

```diff
- getPosition
- getBounds
- getBounds2
- getInstanceMapTree
- getModelInstances
- getPosInfo
- getMeshData
- getGroupModels
- getIntersectionTime
- getObjectHitPos
- getAreaInfo
+ GetPosition
+ GetBounds
+ GetBounds2
+ GetInstanceMapTree
+ GetModelInstances
+ GetPosInfo
+ GetMeshData
+ GetGroupModels
+ GetIntersectionTime
+ GetObjectHitPos
+ GetAreaInfo
```

### How to upgrade

If you are using any of those methods, simply rename it by changing the first letter of the method from lowercase to uppercase.

Example: `getAreaInfo` -> `GetAreaInfo`

## 4.0.0-dev.2 | Commit: [3f70d0b80ff483f142ffbebf8960aeb503913a35](https://github.com/azerothcore/azerothcore-wotlk/commit/3f70d0b80ff483f142ffbebf8960aeb503913a35)


### Added
- Created new changelog system.

### How to upgrade

To create a new changelog please follow the instructions on our [wiki page](https://www.azerothcore.org/wiki/how-to-use-changelog)


