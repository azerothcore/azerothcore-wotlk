/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _OBJECTMGR_H
#define _OBJECTMGR_H

#include "Bag.h"
#include "ConditionMgr.h"
#include "Corpse.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "DynamicObject.h"
#include "GameObject.h"
#include "GossipDef.h"
#include "ItemTemplate.h"
#include "Log.h"
#include "Mail.h"
#include "Map.h"
#include "NPCHandler.h"
#include "Object.h"
#include "ObjectAccessor.h"
#include "ObjectDefines.h"
#include "QuestDef.h"
#include "TemporarySummon.h"
#include "VehicleDefines.h"
#include <functional>
#include <limits>
#include <map>
#include <string>

class Item;
struct DungeonProgressionRequirements;
struct PlayerClassInfo;
struct PlayerClassLevelInfo;
struct PlayerInfo;
struct PlayerLevelInfo;

// GCC have alternative #pragma pack(N) syntax and old gcc version not support pack(push, N), also any gcc version not support it at some platform
#if defined(__GNUC__)
#pragma pack(1)
#else
#pragma pack(push, 1)
#endif

struct PageText
{
    std::string Text;
    uint16 NextPage;
};

/// Key for storing temp summon data in TempSummonDataContainer
struct TempSummonGroupKey
{
    TempSummonGroupKey(uint32 summonerEntry, SummonerType summonerType, uint8 group)
        : _summonerEntry(summonerEntry), _summonerType(summonerType), _summonGroup(group)
    {
    }

    bool operator<(TempSummonGroupKey const& rhs) const
    {
        return std::tie(_summonerEntry, _summonerType, _summonGroup) <
               std::tie(rhs._summonerEntry, rhs._summonerType, rhs._summonGroup);
    }

private:
    uint32 _summonerEntry;      ///< Summoner's entry
    SummonerType _summonerType; ///< Summoner's type, see SummonerType for available types
    uint8 _summonGroup;         ///< Summon's group id
};

// GCC have alternative #pragma pack() syntax and old gcc version not support pack(pop), also any gcc version not support it at some platform
#if defined(__GNUC__)
#pragma pack()
#else
#pragma pack(pop)
#endif

// DB scripting commands
enum ScriptCommands
{
    SCRIPT_COMMAND_TALK                  = 0,                // source/target = Creature, target = any, datalong = talk type (0=say, 1=whisper, 2=yell, 3=emote text, 4=boss emote text), datalong2 & 1 = player talk (instead of creature), dataint = string_id
    SCRIPT_COMMAND_EMOTE                 = 1,                // source/target = Creature, datalong = emote id, datalong2 = 0: set emote state; > 0: play emote state
    SCRIPT_COMMAND_FIELD_SET             = 2,                // source/target = Creature, datalong = field id, datalog2 = value
    SCRIPT_COMMAND_MOVE_TO               = 3,                // source/target = Creature, datalong2 = time to reach, x/y/z = destination
    SCRIPT_COMMAND_FLAG_SET              = 4,                // source/target = Creature, datalong = field id, datalog2 = bitmask
    SCRIPT_COMMAND_FLAG_REMOVE           = 5,                // source/target = Creature, datalong = field id, datalog2 = bitmask
    SCRIPT_COMMAND_TELEPORT_TO           = 6,                // source/target = Creature/Player (see datalong2), datalong = map_id, datalong2 = 0: Player; 1: Creature, x/y/z = destination, o = orientation
    SCRIPT_COMMAND_QUEST_EXPLORED        = 7,                // target/source = Player, target/source = GO/Creature, datalong = quest id, datalong2 = distance or 0
    SCRIPT_COMMAND_KILL_CREDIT           = 8,                // target/source = Player, datalong = creature entry, datalong2 = 0: personal credit, 1: group credit
    SCRIPT_COMMAND_RESPAWN_GAMEOBJECT    = 9,                // source = WorldObject (summoner), datalong = GO guid, datalong2 = despawn delay
    SCRIPT_COMMAND_TEMP_SUMMON_CREATURE  = 10,               // source = WorldObject (summoner), datalong = creature entry, datalong2 = despawn delay, x/y/z = summon position, o = orientation
    SCRIPT_COMMAND_OPEN_DOOR             = 11,               // source = Unit, datalong = GO guid, datalong2 = reset delay (min 15)
    SCRIPT_COMMAND_CLOSE_DOOR            = 12,               // source = Unit, datalong = GO guid, datalong2 = reset delay (min 15)
    SCRIPT_COMMAND_ACTIVATE_OBJECT       = 13,               // source = Unit, target = GO
    SCRIPT_COMMAND_REMOVE_AURA           = 14,               // source (datalong2 != 0) or target (datalong2 == 0) = Unit, datalong = spell id
    SCRIPT_COMMAND_CAST_SPELL            = 15,               // source and/or target = Unit, datalong2 = cast direction (0: s->t 1: s->s 2: t->t 3: t->s 4: s->creature with dataint entry), dataint & 1 = triggered flag
    SCRIPT_COMMAND_PLAY_SOUND            = 16,               // source = WorldObject, target = none/Player, datalong = sound id, datalong2 (bitmask: 0/1=anyone/player, 0/2=without/with distance dependency, so 1|2 = 3 is target with distance dependency)
    SCRIPT_COMMAND_CREATE_ITEM           = 17,               // target/source = Player, datalong = item entry, datalong2 = amount
    SCRIPT_COMMAND_DESPAWN_SELF          = 18,               // target/source = Creature, datalong = despawn delay

    SCRIPT_COMMAND_LOAD_PATH             = 20,               // source = Unit, datalong = path id, datalong2 = is repeatable
    SCRIPT_COMMAND_CALLSCRIPT_TO_UNIT    = 21,               // source = WorldObject (if present used as a search center), datalong = script id, datalong2 = unit lowguid, dataint = script table to use (see ScriptsType)
    SCRIPT_COMMAND_KILL                  = 22,               // source/target = Creature, dataint = remove corpse attribute

    // AzerothCore only
    SCRIPT_COMMAND_ORIENTATION           = 30,               // source = Unit, target (datalong > 0) = Unit, datalong = > 0 turn source to face target, o = orientation
    SCRIPT_COMMAND_EQUIP                 = 31,               // soucre = Creature, datalong = equipment id
    SCRIPT_COMMAND_MODEL                 = 32,               // source = Creature, datalong = model id
    SCRIPT_COMMAND_CLOSE_GOSSIP          = 33,               // source = Player
    SCRIPT_COMMAND_PLAYMOVIE             = 34,               // source = Player, datalong = movie id
    SCRIPT_COMMAND_MOVEMENT              = 35                // soucre = Creature, datalong = MovementType, datalong2 = MovementDistance (wander_distance f.ex.), dataint = pathid
};

// Benchmarked: Faster than std::unordered_map (insert/find)
typedef std::map<uint32, PageText> PageTextContainer;

// Benchmarked: Faster than std::map (insert/find)
typedef std::unordered_map<uint16, InstanceTemplate> InstanceTemplateContainer;

struct GameTele
{
    float  position_x;
    float  position_y;
    float  position_z;
    float  orientation;
    uint32 mapId;
    std::string name;
    std::wstring wnameLow;
};

typedef std::unordered_map<uint32, GameTele > GameTeleContainer;

enum ScriptsType
{
    SCRIPTS_FIRST = 1,

    SCRIPTS_SPELL = SCRIPTS_FIRST,
    SCRIPTS_EVENT,
    SCRIPTS_WAYPOINT,

    SCRIPTS_LAST
};

enum eScriptFlags
{
    // Talk Flags
    SF_TALK_USE_PLAYER          = 0x1,

    // Emote flags
    SF_EMOTE_USE_STATE          = 0x1,

    // TeleportTo flags
    SF_TELEPORT_USE_CREATURE    = 0x1,

    // KillCredit flags
    SF_KILLCREDIT_REWARD_GROUP  = 0x1,

    // RemoveAura flags
    SF_REMOVEAURA_REVERSE       = 0x1,

    // CastSpell flags
    SF_CASTSPELL_SOURCE_TO_TARGET = 0,
    SF_CASTSPELL_SOURCE_TO_SOURCE = 1,
    SF_CASTSPELL_TARGET_TO_TARGET = 2,
    SF_CASTSPELL_TARGET_TO_SOURCE = 3,
    SF_CASTSPELL_SEARCH_CREATURE  = 4,
    SF_CASTSPELL_TRIGGERED      = 0x1,

    // Playsound flags
    SF_PLAYSOUND_TARGET_PLAYER  = 0x1,
    SF_PLAYSOUND_DISTANCE_SOUND = 0x2,

    // Orientation flags
    SF_ORIENTATION_FACE_TARGET  = 0x1,
};

struct ScriptInfo
{
    ScriptsType type;
    uint32 id;
    uint32 delay;
    ScriptCommands command;

    union
    {
        struct
        {
            uint32 nData[3];
            float  fData[4];
        } Raw;

        struct                      // SCRIPT_COMMAND_TALK (0)
        {
            uint32 ChatType;        // datalong
            uint32 Flags;           // datalong2
            int32  TextID;          // dataint
        } Talk;

        struct                      // SCRIPT_COMMAND_EMOTE (1)
        {
            uint32 EmoteID;         // datalong
            uint32 Flags;           // datalong2
        } Emote;

        struct                      // SCRIPT_COMMAND_FIELD_SET (2)
        {
            uint32 FieldID;         // datalong
            uint32 FieldValue;      // datalong2
        } FieldSet;

        struct                      // SCRIPT_COMMAND_MOVE_TO (3)
        {
            uint32 Unused1;         // datalong
            uint32 TravelTime;      // datalong2
            int32  Unused2;         // dataint

            float DestX;
            float DestY;
            float DestZ;
        } MoveTo;

        struct                      // SCRIPT_COMMAND_FLAG_SET (4)
        // SCRIPT_COMMAND_FLAG_REMOVE (5)
        {
            uint32 FieldID;         // datalong
            uint32 FieldValue;      // datalong2
        } FlagToggle;

        struct                      // SCRIPT_COMMAND_TELEPORT_TO (6)
        {
            uint32 MapID;           // datalong
            uint32 Flags;           // datalong2
            int32  Unused1;         // dataint

            float DestX;
            float DestY;
            float DestZ;
            float Orientation;
        } TeleportTo;

        struct                      // SCRIPT_COMMAND_QUEST_EXPLORED (7)
        {
            uint32 QuestID;         // datalong
            uint32 Distance;        // datalong2
        } QuestExplored;

        struct                      // SCRIPT_COMMAND_KILL_CREDIT (8)
        {
            uint32 CreatureEntry;   // datalong
            uint32 Flags;           // datalong2
        } KillCredit;

        struct                      // SCRIPT_COMMAND_RESPAWN_GAMEOBJECT (9)
        {
            uint32 GOGuid;          // datalong
            uint32 DespawnDelay;    // datalong2
        } RespawnGameobject;

        struct                      // SCRIPT_COMMAND_TEMP_SUMMON_CREATURE (10)
        {
            uint32 CreatureEntry;   // datalong
            uint32 DespawnDelay;    // datalong2
            uint32 CheckIfExists;   // dataint

            float PosX;
            float PosY;
            float PosZ;
            float Orientation;
        } TempSummonCreature;

        struct                      // SCRIPT_COMMAND_CLOSE_DOOR (12)
        // SCRIPT_COMMAND_OPEN_DOOR (11)
        {
            uint32 GOGuid;          // datalong
            uint32 ResetDelay;      // datalong2
        } ToggleDoor;

        // SCRIPT_COMMAND_ACTIVATE_OBJECT (13)

        struct                      // SCRIPT_COMMAND_REMOVE_AURA (14)
        {
            uint32 SpellID;         // datalong
            uint32 Flags;           // datalong2
        } RemoveAura;

        struct                      // SCRIPT_COMMAND_CAST_SPELL (15)
        {
            uint32 SpellID;         // datalong
            uint32 Flags;           // datalong2
            int32  CreatureEntry;   // dataint

            float SearchRadius;
        } CastSpell;

        struct                      // SCRIPT_COMMAND_PLAY_SOUND (16)
        {
            uint32 SoundID;         // datalong
            uint32 Flags;           // datalong2
        } Playsound;

        struct                      // SCRIPT_COMMAND_CREATE_ITEM (17)
        {
            uint32 ItemEntry;       // datalong
            uint32 Amount;          // datalong2
        } CreateItem;

        struct                      // SCRIPT_COMMAND_DESPAWN_SELF (18)
        {
            uint32 DespawnDelay;    // datalong
        } DespawnSelf;

        struct                      // SCRIPT_COMMAND_LOAD_PATH (20)
        {
            uint32 PathID;          // datalong
            uint32 IsRepeatable;    // datalong2
        } LoadPath;

        struct                      // SCRIPT_COMMAND_CALLSCRIPT_TO_UNIT (21)
        {
            uint32 CreatureEntry;   // datalong
            uint32 ScriptID;        // datalong2
            uint32 ScriptType;      // dataint
        } CallScript;

        struct                      // SCRIPT_COMMAND_KILL (22)
        {
            uint32 Unused1;         // datalong
            uint32 Unused2;         // datalong2
            int32  RemoveCorpse;    // dataint
        } Kill;

        struct                      // SCRIPT_COMMAND_ORIENTATION (30)
        {
            uint32 Flags;           // datalong
            uint32 Unused1;         // datalong2
            int32  Unused2;         // dataint

            float Unused3;
            float Unused4;
            float Unused5;
            float Orientation;
        } Orientation;

        struct                      // SCRIPT_COMMAND_EQUIP (31)
        {
            uint32 EquipmentID;     // datalong
        } Equip;

        struct                      // SCRIPT_COMMAND_MODEL (32)
        {
            uint32 ModelID;         // datalong
        } Model;

        // SCRIPT_COMMAND_CLOSE_GOSSIP (33)

        struct                      // SCRIPT_COMMAND_PLAYMOVIE (34)
        {
            uint32 MovieID;         // datalong
        } PlayMovie;

        struct                       // SCRIPT_COMMAND_MOVEMENT (35)
        {
            uint32 MovementType;     // datalong
            uint32 MovementDistance; // datalong2
            int32  Path;             // dataint
        } Movement;
    };

    [[nodiscard]] std::string GetDebugInfo() const;
};

typedef std::multimap<uint32, ScriptInfo> ScriptMap;
typedef std::map<uint32, ScriptMap > ScriptMapMap;
typedef std::multimap<uint32, uint32> SpellScriptsContainer;
typedef std::pair<SpellScriptsContainer::iterator, SpellScriptsContainer::iterator> SpellScriptsBounds;
extern ScriptMapMap sSpellScripts;
extern ScriptMapMap sEventScripts;
extern ScriptMapMap sWaypointScripts;

std::string GetScriptsTableNameByType(ScriptsType type);
ScriptMapMap* GetScriptsMapByType(ScriptsType type);
std::string GetScriptCommandName(ScriptCommands command);

struct SpellClickInfo
{
    uint32 spellId;
    uint8 castFlags;
    SpellClickUserTypes userType;

    // helpers
    bool IsFitToRequirements(Unit const* clicker, Unit const* clickee) const;
};

typedef std::multimap<uint32, SpellClickInfo> SpellClickInfoContainer;
typedef std::pair<SpellClickInfoContainer::const_iterator, SpellClickInfoContainer::const_iterator> SpellClickInfoMapBounds;

struct AreaTriggerTeleport
{
    uint32 target_mapId;
    float  target_X;
    float  target_Y;
    float  target_Z;
    float  target_Orientation;
};

struct AreaTrigger
{
    uint32 entry;
    uint32 map;
    float x;
    float y;
    float z;
    float radius;
    float length;
    float width;
    float height;
    float orientation;
};

struct BroadcastText
{
    BroadcastText()
    {
        MaleText.resize(DEFAULT_LOCALE + 1);
        FemaleText.resize(DEFAULT_LOCALE + 1);
    }

    uint32 Id{0};
    uint32 LanguageID{0};
    std::vector<std::string> MaleText;
    std::vector<std::string> FemaleText;
    uint32 EmoteId1{0};
    uint32 EmoteId2{0};
    uint32 EmoteId3{0};
    uint32 EmoteDelay1{0};
    uint32 EmoteDelay2{0};
    uint32 EmoteDelay3{0};
    uint32 SoundEntriesId{0};
    uint32 EmotesID{0};
    uint32 Flags{0};
    // uint32 VerifiedBuild;

    [[nodiscard]] std::string const& GetText(LocaleConstant locale = DEFAULT_LOCALE, uint8 gender = GENDER_MALE, bool forceGender = false) const
    {
        if (gender == GENDER_FEMALE && (forceGender || !FemaleText[DEFAULT_LOCALE].empty()))
        {
            if (FemaleText.size() > size_t(locale) && !FemaleText[locale].empty())
                return FemaleText[locale];
            return FemaleText[DEFAULT_LOCALE];
        }
        // else if (gender == GENDER_MALE)
        {
            if (MaleText.size() > size_t(locale) && !MaleText[locale].empty())
                return MaleText[locale];
            return MaleText[DEFAULT_LOCALE];
        }
    }
};

typedef std::unordered_map<uint32, BroadcastText> BroadcastTextContainer;

typedef std::set<ObjectGuid::LowType> CellGuidSet;

struct CellObjectGuids
{
    CellGuidSet creatures;
    CellGuidSet gameobjects;
};

typedef std::unordered_map<uint32/*cell_id*/, CellObjectGuids> CellObjectGuidsMap;
typedef std::unordered_map<uint32/*(mapid, spawnMode) pair*/, CellObjectGuidsMap> MapObjectGuids;

// Acore string ranges
#define MIN_ACORE_STRING_ID           1                    // 'acore_string'
#define MAX_ACORE_STRING_ID           2000000000
#define MIN_CREATURE_AI_TEXT_STRING_ID (-1)                 // 'creature_ai_texts'
#define MAX_CREATURE_AI_TEXT_STRING_ID (-1000000)

// Acore Trainer Reference start range
#define ACORE_TRAINER_START_REF      200000

struct AcoreString
{
    std::vector<std::string> Content;
};

typedef std::map<ObjectGuid, ObjectGuid> LinkedRespawnContainer;
typedef std::unordered_map<ObjectGuid::LowType, CreatureData> CreatureDataContainer;
typedef std::unordered_map<ObjectGuid::LowType, GameObjectData> GameObjectDataContainer;
typedef std::map<TempSummonGroupKey, std::vector<TempSummonData> > TempSummonDataContainer;
typedef std::unordered_map<uint32, CreatureLocale> CreatureLocaleContainer;
typedef std::unordered_map<uint32, GameObjectLocale> GameObjectLocaleContainer;
typedef std::unordered_map<uint32, ItemLocale> ItemLocaleContainer;
typedef std::unordered_map<uint32, ItemSetNameLocale> ItemSetNameLocaleContainer;
typedef std::unordered_map<uint32, QuestLocale> QuestLocaleContainer;
typedef std::unordered_map<uint32, QuestOfferRewardLocale> QuestOfferRewardLocaleContainer;
typedef std::unordered_map<uint32, QuestRequestItemsLocale> QuestRequestItemsLocaleContainer;
typedef std::unordered_map<uint32, NpcTextLocale> NpcTextLocaleContainer;
typedef std::unordered_map<uint32, PageTextLocale> PageTextLocaleContainer;
typedef std::unordered_map<int32, AcoreString> AcoreStringContainer;
typedef std::unordered_map<uint32, GossipMenuItemsLocale> GossipMenuItemsLocaleContainer;
typedef std::unordered_map<uint32, PointOfInterestLocale> PointOfInterestLocaleContainer;

typedef std::multimap<uint32, uint32> QuestRelations;
typedef std::pair<QuestRelations::const_iterator, QuestRelations::const_iterator> QuestRelationBounds;

struct PetLevelInfo
{
    PetLevelInfo()
    {
        stats.fill(0);
    }

    std::array<uint32, MAX_STATS> stats = { };
    uint32 health{0};
    uint32 mana{0};
    uint32 armor{0};
    uint32 min_dmg{0};
    uint32 max_dmg{0};
};

struct MailLevelReward
{
    MailLevelReward()  = default;
    MailLevelReward(uint32 _raceMask, uint32 _mailTemplateId, uint32 _senderEntry) : raceMask(_raceMask), mailTemplateId(_mailTemplateId), senderEntry(_senderEntry) {}

    uint32 raceMask{0};
    uint32 mailTemplateId{0};
    uint32 senderEntry{0};
};

typedef std::list<MailLevelReward> MailLevelRewardList;
typedef std::unordered_map<uint8, MailLevelRewardList> MailLevelRewardContainer;

// We assume the rate is in general the same for all three types below, but chose to keep three for scalability and customization
struct RepRewardRate
{
    float questRate;            // We allow rate = 0.0 in database. For this case, it means that
    float questDailyRate;
    float questWeeklyRate;
    float questMonthlyRate;
    float questRepeatableRate;
    float creatureRate;         // no reputation are given at all for this faction/rate type.
    float spellRate;
};

struct ReputationOnKillEntry
{
    uint32 RepFaction1;
    uint32 RepFaction2;
    uint32 ReputationMaxCap1;
    float RepValue1;
    uint32 ReputationMaxCap2;
    float RepValue2;
    bool IsTeamAward1;
    bool IsTeamAward2;
    bool TeamDependent;
};

struct RepSpilloverTemplate
{
    uint32 faction[MAX_SPILLOVER_FACTIONS];
    float faction_rate[MAX_SPILLOVER_FACTIONS];
    uint32 faction_rank[MAX_SPILLOVER_FACTIONS];
};

struct PointOfInterest
{
    uint32 ID;
    float PositionX;
    float PositionY;
    uint32 Icon;
    uint32 Flags;
    uint32 Importance;
    std::string Name;
};

struct QuestGreeting
{
    uint16 EmoteType;
    uint32 EmoteDelay;
    std::string Text;

    QuestGreeting() : EmoteType(0), EmoteDelay(0) { }
    QuestGreeting(uint16 emoteType, uint32 emoteDelay, std::string text)
        : EmoteType(emoteType), EmoteDelay(emoteDelay), Text(std::move(text)) { }
};

struct QuestGreetingLocale
{
    std::vector<std::string> Greeting;
};

typedef std::unordered_map<uint32, QuestGreetingLocale> QuestGreetingLocaleContainer;

struct GossipMenuItems
{
    uint32          MenuID;
    uint32          OptionID;
    uint8           OptionIcon;
    std::string     OptionText;
    uint32          OptionBroadcastTextID;
    uint32          OptionType;
    uint32          OptionNpcFlag;
    uint32          ActionMenuID;
    uint32          ActionPoiID;
    bool            BoxCoded;
    uint32          BoxMoney;
    std::string     BoxText;
    ConditionList   Conditions;
    uint32          BoxBroadcastTextID;
};

struct GossipMenus
{
    uint32          MenuID;
    uint32          TextID;
    ConditionList   Conditions;
};

typedef std::multimap<uint32, GossipMenus> GossipMenusContainer;
typedef std::pair<GossipMenusContainer::const_iterator, GossipMenusContainer::const_iterator> GossipMenusMapBounds;
typedef std::pair<GossipMenusContainer::iterator, GossipMenusContainer::iterator> GossipMenusMapBoundsNonConst;
typedef std::multimap<uint32, GossipMenuItems> GossipMenuItemsContainer;
typedef std::pair<GossipMenuItemsContainer::const_iterator, GossipMenuItemsContainer::const_iterator> GossipMenuItemsMapBounds;
typedef std::pair<GossipMenuItemsContainer::iterator, GossipMenuItemsContainer::iterator> GossipMenuItemsMapBoundsNonConst;

struct QuestPOIPoint
{
    int32 x{0};
    int32 y{0};

    QuestPOIPoint()  = default;
    QuestPOIPoint(int32 _x, int32 _y) : x(_x), y(_y) {}
};

struct QuestPOI
{
    uint32 Id{0};
    int32 ObjectiveIndex{0};
    uint32 MapId{0};
    uint32 AreaId{0};
    uint32 FloorId{0};
    uint32 Unk3{0};
    uint32 Unk4{0};
    std::vector<QuestPOIPoint> points;

    QuestPOI()  = default;
    QuestPOI(uint32 id, int32 objIndex, uint32 mapId, uint32 areaId, uint32 floorId, uint32 unk3, uint32 unk4) : Id(id), ObjectiveIndex(objIndex), MapId(mapId), AreaId(areaId), FloorId(floorId), Unk3(unk3), Unk4(unk4) {}
};

typedef std::vector<QuestPOI> QuestPOIVector;
typedef std::unordered_map<uint32, QuestPOIVector> QuestPOIContainer;

typedef std::array<std::unordered_map<uint32, QuestGreeting>, 2> QuestGreetingContainer;

typedef std::unordered_map<uint32, VendorItemData> CacheVendorItemContainer;
typedef std::unordered_map<uint32, TrainerSpellData> CacheTrainerSpellContainer;
typedef std::unordered_map<uint32, ServerMail> ServerMailContainer;

typedef std::vector<uint32> CreatureCustomIDsContainer;

enum SkillRangeType
{
    SKILL_RANGE_LANGUAGE,                                   // 300..300
    SKILL_RANGE_LEVEL,                                      // 1..max skill for level
    SKILL_RANGE_MONO,                                       // 1..1, grey monolite bar
    SKILL_RANGE_RANK,                                       // 1..skill for known rank
    SKILL_RANGE_NONE,                                       // 0..0 always
};

SkillRangeType GetSkillRangeType(SkillRaceClassInfoEntry const* rcEntry);

#define MAX_PLAYER_NAME          12                         // max allowed by client name length
#define MAX_INTERNAL_PLAYER_NAME 15                         // max server internal player name length (> MAX_PLAYER_NAME for support declined names)
#define MAX_PET_NAME             12                         // max allowed by client name length
#define MAX_CHARTER_NAME         24                         // max allowed by client name length
#define MAX_CHANNEL_NAME         50                         // pussywizard

bool ReservedNames(std::wstring& name);
bool ProfanityNames(std::wstring& name);
bool normalizePlayerName(std::string& name);

struct LanguageDesc
{
    Language lang_id;
    uint32   spell_id;
    uint32   skill_id;
};

extern LanguageDesc lang_description[LANGUAGES_COUNT];
LanguageDesc const* GetLanguageDescByID(uint32 lang);

struct DungeonEncounter
{
    DungeonEncounter(DungeonEncounterEntry const* _dbcEntry, EncounterCreditType _creditType, uint32 _creditEntry, uint32 _lastEncounterDungeon)
        : dbcEntry(_dbcEntry), creditType(_creditType), creditEntry(_creditEntry), lastEncounterDungeon(_lastEncounterDungeon) { }

    DungeonEncounterEntry const* dbcEntry;
    EncounterCreditType creditType;
    uint32 creditEntry;
    uint32 lastEncounterDungeon;
};

typedef std::list<DungeonEncounter const*> DungeonEncounterList;
typedef std::unordered_map<uint32, DungeonEncounterList> DungeonEncounterContainer;

static constexpr uint32 MAX_QUEST_MONEY_REWARDS = 10;
typedef std::array<uint32, MAX_QUEST_MONEY_REWARDS> QuestMoneyRewardArray;
typedef std::unordered_map<uint32, QuestMoneyRewardArray> QuestMoneyRewardStore;

class PlayerDumpReader;

class ObjectMgr
{
    friend class PlayerDumpReader;

private:
    ObjectMgr();
    ~ObjectMgr();

public:
    static ObjectMgr* instance();

    typedef std::unordered_map<uint32, Item*> ItemMap;

    typedef std::unordered_map<uint32, Quest*> QuestMap;

    typedef std::unordered_map<uint32, AreaTrigger> AreaTriggerContainer;

    typedef std::unordered_map<uint32, AreaTriggerTeleport> AreaTriggerTeleportContainer;

    typedef std::unordered_map<uint32, uint32> AreaTriggerScriptContainer;

    typedef std::unordered_map<uint32, std::unordered_map<uint8, DungeonProgressionRequirements*>> DungeonProgressionRequirementsContainer;

    typedef std::unordered_map<uint32, RepRewardRate > RepRewardRateContainer;
    typedef std::unordered_map<uint32, ReputationOnKillEntry> RepOnKillContainer;
    typedef std::unordered_map<uint32, RepSpilloverTemplate> RepSpilloverTemplateContainer;

    typedef std::unordered_map<uint32, PointOfInterest> PointOfInterestContainer;

    typedef std::vector<std::string> ScriptNameContainer;

    typedef std::map<uint32, uint32> CharacterConversionMap;

    GameObjectTemplate const* GetGameObjectTemplate(uint32 entry);
    bool IsGameObjectStaticTransport(uint32 entry);
    [[nodiscard]] GameObjectTemplateContainer const* GetGameObjectTemplates() const { return &_gameObjectTemplateStore; }
    int LoadReferenceVendor(int32 vendor, int32 item_id, std::set<uint32>* skip_vendors);

    void LoadGameObjectTemplate();
    void LoadGameObjectTemplateAddons();
    void AddGameobjectInfo(GameObjectTemplate* goinfo);

    CreatureTemplate const* GetCreatureTemplate(uint32 entry);
    [[nodiscard]] CreatureTemplateContainer const* GetCreatureTemplates() const { return &_creatureTemplateStore; }
    CreatureModelInfo const* GetCreatureModelInfo(uint32 modelId) const;
    CreatureModelInfo const* GetCreatureModelRandomGender(uint32* displayID);
    static uint32 ChooseDisplayId(CreatureTemplate const* cinfo, CreatureData const* data = nullptr);
    static void ChooseCreatureFlags(CreatureTemplate const* cinfo, uint32& npcflag, uint32& unit_flags, uint32& dynamicflags, CreatureData const* data = nullptr);
    EquipmentInfo const* GetEquipmentInfo(uint32 entry, int8& id);
    CreatureAddon const* GetCreatureAddon(ObjectGuid::LowType lowguid);
    GameObjectAddon const* GetGameObjectAddon(ObjectGuid::LowType lowguid);
    [[nodiscard]] GameObjectTemplateAddon const* GetGameObjectTemplateAddon(uint32 entry) const;
    CreatureAddon const* GetCreatureTemplateAddon(uint32 entry);
    CreatureMovementData const* GetCreatureMovementOverride(ObjectGuid::LowType spawnId) const;
    ItemTemplate const* GetItemTemplate(uint32 entry);
    [[nodiscard]] ItemTemplateContainer const* GetItemTemplateStore() const { return &_itemTemplateStore; }
    [[nodiscard]] std::vector<ItemTemplate*> const* GetItemTemplateStoreFast() const { return &_itemTemplateStoreFast; }

    ItemSetNameEntry const* GetItemSetNameEntry(uint32 itemId)
    {
        ItemSetNameContainer::iterator itr = _itemSetNameStore.find(itemId);
        if (itr != _itemSetNameStore.end())
            return &itr->second;
        return nullptr;
    }

    InstanceTemplate const* GetInstanceTemplate(uint32 mapId);

    [[nodiscard]] PetLevelInfo const* GetPetLevelInfo(uint32 creature_id, uint8 level) const;

    [[nodiscard]] PlayerClassInfo const* GetPlayerClassInfo(uint32 class_) const
    {
        if (class_ >= MAX_CLASSES)
            return nullptr;
        return _playerClassInfo[class_];
    }
    void GetPlayerClassLevelInfo(uint32 class_, uint8 level, PlayerClassLevelInfo* info) const;

    [[nodiscard]] PlayerInfo const* GetPlayerInfo(uint32 race, uint32 class_) const;

    void GetPlayerLevelInfo(uint32 race, uint32 class_, uint8 level, PlayerLevelInfo* info) const;

    uint32 GetNearestTaxiNode(float x, float y, float z, uint32 mapid, uint32 teamId);
    void GetTaxiPath(uint32 source, uint32 destination, uint32& path, uint32& cost);
    uint32 GetTaxiMountDisplayId(uint32 id, TeamId teamId, bool allowed_alt_team = false);

    [[nodiscard]] GameObjectQuestItemList const* GetGameObjectQuestItemList(uint32 id) const
    {
        GameObjectQuestItemMap::const_iterator itr = _gameObjectQuestItemStore.find(id);
        if (itr != _gameObjectQuestItemStore.end())
            return &itr->second;
        return nullptr;
    }
    [[nodiscard]] GameObjectQuestItemMap const* GetGameObjectQuestItemMap() const { return &_gameObjectQuestItemStore; }

    [[nodiscard]] CreatureQuestItemList const* GetCreatureQuestItemList(uint32 id) const
    {
        CreatureQuestItemMap::const_iterator itr = _creatureQuestItemStore.find(id);
        if (itr != _creatureQuestItemStore.end())
            return &itr->second;
        return nullptr;
    }
    [[nodiscard]] CreatureQuestItemMap const* GetCreatureQuestItemMap() const { return &_creatureQuestItemStore; }

    [[nodiscard]] Quest const* GetQuestTemplate(uint32 quest_id) const
    {
        return quest_id < _questTemplatesFast.size() ? _questTemplatesFast[quest_id] : nullptr;
    }

    [[nodiscard]] QuestMap const& GetQuestTemplates() const { return _questTemplates; }

    [[nodiscard]] uint32 GetQuestForAreaTrigger(uint32 Trigger_ID) const
    {
        QuestAreaTriggerContainer::const_iterator itr = _questAreaTriggerStore.find(Trigger_ID);
        if (itr != _questAreaTriggerStore.end())
            return itr->second;
        return 0;
    }

    [[nodiscard]] bool IsTavernAreaTrigger(uint32 triggerID, uint32 faction) const
    {
        auto itr = _tavernAreaTriggerStore.find(triggerID);
        if (itr != _tavernAreaTriggerStore.end())
        {
            return (itr->second & faction) != 0;
        }

        return false;
    }

    [[nodiscard]] GossipText const* GetGossipText(uint32 Text_ID) const;

    [[nodiscard]] AreaTrigger const* GetAreaTrigger(uint32 trigger) const
    {
        AreaTriggerContainer::const_iterator itr = _areaTriggerStore.find(trigger);
        if (itr != _areaTriggerStore.end())
            return &itr->second;
        return nullptr;
    }

    [[nodiscard]] AreaTriggerTeleportContainer const& GetAllAreaTriggerTeleports() const { return _areaTriggerTeleportStore; }
    [[nodiscard]] AreaTriggerTeleport const* GetAreaTriggerTeleport(uint32 trigger) const
    {
        AreaTriggerTeleportContainer::const_iterator itr = _areaTriggerTeleportStore.find(trigger);
        if (itr != _areaTriggerTeleportStore.end())
            return &itr->second;
        return nullptr;
    }

    [[nodiscard]] DungeonProgressionRequirements const* GetAccessRequirement(uint32 mapid, Difficulty difficulty) const
    {
        DungeonProgressionRequirementsContainer::const_iterator itr = _accessRequirementStore.find(mapid);
        if (itr != _accessRequirementStore.end())
        {
            std::unordered_map<uint8, DungeonProgressionRequirements*> difficultiesProgressionRequirements = itr->second;
            auto difficultiesItr = difficultiesProgressionRequirements.find(difficulty);
            if (difficultiesItr != difficultiesProgressionRequirements.end())
            {
                return difficultiesItr->second;
            }
        }
        return nullptr;
    }

    [[nodiscard]] AreaTriggerTeleport const* GetGoBackTrigger(uint32 Map) const;
    [[nodiscard]] AreaTriggerTeleport const* GetMapEntranceTrigger(uint32 Map) const;

    uint32 GetAreaTriggerScriptId(uint32 trigger_id);
    SpellScriptsBounds GetSpellScriptsBounds(uint32 spell_id);

    [[nodiscard]] RepRewardRate const* GetRepRewardRate(uint32 factionId) const
    {
        RepRewardRateContainer::const_iterator itr = _repRewardRateStore.find(factionId);
        if (itr != _repRewardRateStore.end())
            return &itr->second;

        return nullptr;
    }

    [[nodiscard]] ReputationOnKillEntry const* GetReputationOnKilEntry(uint32 id) const
    {
        RepOnKillContainer::const_iterator itr = _repOnKillStore.find(id);
        if (itr != _repOnKillStore.end())
            return &itr->second;
        return nullptr;
    }

    int32 GetBaseReputationOf(FactionEntry const* factionEntry, uint8 race, uint8 playerClass);

    [[nodiscard]] RepSpilloverTemplate const* GetRepSpilloverTemplate(uint32 factionId) const
    {
        RepSpilloverTemplateContainer::const_iterator itr = _repSpilloverTemplateStore.find(factionId);
        if (itr != _repSpilloverTemplateStore.end())
            return &itr->second;

        return nullptr;
    }

    [[nodiscard]] PointOfInterest const* GetPointOfInterest(uint32 id) const
    {
        PointOfInterestContainer::const_iterator itr = _pointsOfInterestStore.find(id);
        if (itr != _pointsOfInterestStore.end())
            return &itr->second;
        return nullptr;
    }

    QuestPOIVector const* GetQuestPOIVector(uint32 questId)
    {
        QuestPOIContainer::const_iterator itr = _questPOIStore.find(questId);
        if (itr != _questPOIStore.end())
            return &itr->second;
        return nullptr;
    }

    VehicleAccessoryList const* GetVehicleAccessoryList(Vehicle* veh) const;

    DungeonEncounterList const* GetDungeonEncounterList(uint32 mapId, Difficulty difficulty)
    {
        std::unordered_map<uint32, DungeonEncounterList>::const_iterator itr = _dungeonEncounterStore.find(MAKE_PAIR32(mapId, difficulty));
        if (itr != _dungeonEncounterStore.end())
            return &itr->second;
        return nullptr;
    }

    void LoadQuests();
    void LoadQuestMoneyRewards();
    void LoadQuestStartersAndEnders()
    {
        LOG_INFO("server.loading", "Loading GO Start Quest Data...");
        LoadGameobjectQuestStarters();
        LOG_INFO("server.loading", "Loading GO End Quest Data...");
        LoadGameobjectQuestEnders();
        LOG_INFO("server.loading", "Loading Creature Start Quest Data...");
        LoadCreatureQuestStarters();
        LOG_INFO("server.loading", "Loading Creature End Quest Data...");
        LoadCreatureQuestEnders();
    }
    void LoadGameobjectQuestStarters();
    void LoadGameobjectQuestEnders();
    void LoadCreatureQuestStarters();
    void LoadCreatureQuestEnders();

    QuestRelations* GetGOQuestRelationMap()
    {
        return &_goQuestRelations;
    }

    QuestRelations* GetGOQuestInvolvedRelationMap()
    {
        return &_goQuestInvolvedRelations;
    }

    QuestRelationBounds GetGOQuestRelationBounds(uint32 go_entry)
    {
        return _goQuestRelations.equal_range(go_entry);
    }

    QuestRelationBounds GetGOQuestInvolvedRelationBounds(uint32 go_entry)
    {
        return _goQuestInvolvedRelations.equal_range(go_entry);
    }

    QuestRelations* GetCreatureQuestRelationMap()
    {
        return &_creatureQuestRelations;
    }

    QuestRelations* GetCreatureQuestInvolvedRelationMap()
    {
        return &_creatureQuestInvolvedRelations;
    }

    QuestRelationBounds GetCreatureQuestRelationBounds(uint32 creature_entry)
    {
        return _creatureQuestRelations.equal_range(creature_entry);
    }

    QuestRelationBounds GetCreatureQuestInvolvedRelationBounds(uint32 creature_entry)
    {
        return _creatureQuestInvolvedRelations.equal_range(creature_entry);
    }

    void LoadEventScripts();
    void LoadSpellScripts();
    void LoadWaypointScripts();

    void LoadSpellScriptNames();
    void ValidateSpellScripts();
    void InitializeSpellInfoPrecomputedData();

    bool LoadAcoreStrings();
    void LoadBroadcastTexts();
    void LoadBroadcastTextLocales();
    void LoadCreatureClassLevelStats();
    void LoadCreatureLocales();
    void LoadCreatureTemplates();
    void LoadCreatureTemplate(Field* fields, bool triggerHook = false);
    void LoadCreatureTemplateAddons();
    void LoadCreatureTemplateResistances();
    void LoadCreatureTemplateSpells();
    void LoadCreatureCustomIDs();
    void CheckCreatureTemplate(CreatureTemplate const* cInfo);
    void CheckCreatureMovement(char const* table, uint64 id, CreatureMovementData& creatureMovement);
    void LoadGameObjectQuestItems();
    void LoadCreatureQuestItems();
    void LoadTempSummons();
    void LoadCreatures();
    void LoadLinkedRespawn();
    bool SetCreatureLinkedRespawn(ObjectGuid::LowType guid, ObjectGuid::LowType linkedGuid);
    void LoadCreatureAddons();
    void LoadGameObjectAddons();
    void LoadCreatureModelInfo();
    void LoadEquipmentTemplates();
    void LoadCreatureMovementOverrides();
    void LoadGameObjectLocales();
    void LoadGameobjects();
    void LoadItemTemplates();
    void LoadItemLocales();
    void LoadItemSetNames();
    void LoadItemSetNameLocales();
    void LoadQuestLocales();
    void LoadNpcTextLocales();
    void LoadQuestOfferRewardLocale();
    void LoadQuestRequestItemsLocale();
    void LoadPageTextLocales();
    void LoadGossipMenuItemsLocales();
    void LoadPointOfInterestLocales();
    void LoadQuestGreetingsLocales();
    void LoadInstanceTemplate();
    void LoadInstanceEncounters();
    void LoadMailLevelRewards();
    void LoadMailServerTemplates();
    void LoadVehicleTemplateAccessories();
    void LoadVehicleAccessories();

    void LoadGossipText();

    void LoadAreaTriggers();
    void LoadAreaTriggerTeleports();
    void LoadAccessRequirements();
    void LoadQuestAreaTriggers();
    void LoadQuestGreetings();
    void LoadAreaTriggerScripts();
    void LoadTavernAreaTriggers();
    void LoadGameObjectForQuests();

    void LoadPageTexts();
    PageText const* GetPageText(uint32 pageEntry);

    void LoadPlayerInfo();
    void LoadPetLevelInfo();
    void LoadExplorationBaseXP();
    void LoadPetNames();
    void LoadPetNamesLocales();
    void LoadPetNumber();
    void LoadFishingBaseSkillLevel();
    void ChangeFishingBaseSkillLevel(uint32 entry, int32 skill);

    void LoadReputationRewardRate();
    void LoadReputationOnKill();
    void LoadReputationSpilloverTemplate();

    void LoadPointsOfInterest();
    void LoadQuestPOI();

    void LoadNPCSpellClickSpells();

    void LoadGameTele();

    void LoadGossipMenu();
    void LoadGossipMenuItems();

    void LoadVendors();
    void LoadTrainerSpell();
    void AddSpellToTrainer(uint32 entry, uint32 spell, uint32 spellCost, uint32 reqSkill, uint32 reqSkillValue, uint32 reqLevel, uint32 reqSpell);

    std::string GeneratePetName(uint32 entry);
    std::string GeneratePetNameLocale(uint32 entry, LocaleConstant locale);
    uint32 GetBaseXP(uint8 level);
    [[nodiscard]] uint32 GetXPForLevel(uint8 level) const;

    [[nodiscard]] int32 GetFishingBaseSkillLevel(uint32 entry) const
    {
        FishingBaseSkillContainer::const_iterator itr = _fishingBaseForAreaStore.find(entry);
        return itr != _fishingBaseForAreaStore.end() ? itr->second : 0;
    }

    void ReturnOrDeleteOldMails(bool serverUp);

    CreatureBaseStats const* GetCreatureBaseStats(uint8 level, uint8 unitClass);

    void SetHighestGuids();

    template<HighGuid type>
    inline ObjectGuidGeneratorBase& GetGenerator()
    {
        static_assert(ObjectGuidTraits<type>::Global, "Only global guid can be generated in ObjectMgr context");
        return GetGuidSequenceGenerator<type>();
    }

    uint32 GenerateAuctionID();
    uint64 GenerateEquipmentSetGuid();
    uint32 GenerateMailID();
    uint32 GeneratePetNumber();
    ObjectGuid::LowType GenerateCreatureSpawnId();
    ObjectGuid::LowType GenerateGameObjectSpawnId();

    typedef std::multimap<int32, uint32> ExclusiveQuestGroups;
    typedef std::pair<ExclusiveQuestGroups::const_iterator, ExclusiveQuestGroups::const_iterator> ExclusiveQuestGroupsBounds;

    ExclusiveQuestGroups mExclusiveQuestGroups;

    MailLevelReward const* GetMailLevelReward(uint32 level, uint32 raceMask)
    {
        MailLevelRewardContainer::const_iterator map_itr = _mailLevelRewardStore.find(level);
        if (map_itr == _mailLevelRewardStore.end())
            return nullptr;

        for (const auto & set_itr : map_itr->second)
            if (set_itr.raceMask & raceMask)
                return &set_itr;

        return nullptr;
    }

    CellObjectGuids const& GetCellObjectGuids(uint16 mapid, uint8 spawnMode, uint32 cell_id)
    {
        MapObjectGuids::const_iterator itr1 = _mapObjectGuidsStore.find(MAKE_PAIR32(mapid, spawnMode));
        if (itr1 != _mapObjectGuidsStore.end())
        {
            CellObjectGuidsMap::const_iterator itr2 = itr1->second.find(cell_id);
            if (itr2 != itr1->second.end())
                return itr2->second;
        }
        return _emptyCellObjectGuids;
    }

    CellObjectGuidsMap const& GetMapObjectGuids(uint16 mapid, uint8 spawnMode)
    {
        MapObjectGuids::const_iterator itr1 = _mapObjectGuidsStore.find(MAKE_PAIR32(mapid, spawnMode));
        if (itr1 != _mapObjectGuidsStore.end())
            return itr1->second;
        return _emptyCellObjectGuidsMap;
    }

    /**
     * Gets temp summon data for all creatures of specified group.
     *
     * @param summonerId   Summoner's entry.
     * @param summonerType Summoner's type, see SummonerType for available types.
     * @param group        Id of required group.
     *
     * @return null if group was not found, otherwise reference to the creature group data
     */
    [[nodiscard]] std::vector<TempSummonData> const* GetSummonGroup(uint32 summonerId, SummonerType summonerType, uint8 group) const
    {
        TempSummonDataContainer::const_iterator itr = _tempSummonDataStore.find(TempSummonGroupKey(summonerId, summonerType, group));
        if (itr != _tempSummonDataStore.end())
            return &itr->second;

        return nullptr;
    }

    [[nodiscard]] ServerMailContainer const& GetAllServerMailStore() const { return _serverMailStore; }

    [[nodiscard]] BroadcastText const* GetBroadcastText(uint32 id) const
    {
        BroadcastTextContainer::const_iterator itr = _broadcastTextStore.find(id);
        if (itr != _broadcastTextStore.end())
            return &itr->second;
        return nullptr;
    }
    [[nodiscard]] CreatureDataContainer const& GetAllCreatureData() const { return _creatureDataStore; }
    [[nodiscard]] CreatureData const* GetCreatureData(ObjectGuid::LowType spawnId) const
    {
        CreatureDataContainer::const_iterator itr = _creatureDataStore.find(spawnId);
        if (itr == _creatureDataStore.end()) return nullptr;
        return &itr->second;
    }
    CreatureData& NewOrExistCreatureData(ObjectGuid::LowType spawnId) { return _creatureDataStore[spawnId]; }
    void DeleteCreatureData(ObjectGuid::LowType spawnId);
    [[nodiscard]] ObjectGuid GetLinkedRespawnGuid(ObjectGuid guid) const
    {
        LinkedRespawnContainer::const_iterator itr = _linkedRespawnStore.find(guid);
        if (itr == _linkedRespawnStore.end())
            return ObjectGuid::Empty;
        return itr->second;
    }

    [[nodiscard]] GameObjectDataContainer const& GetAllGOData() const { return _gameObjectDataStore; }
    [[nodiscard]] GameObjectData const* GetGameObjectData(ObjectGuid::LowType spawnId) const
    {
        GameObjectDataContainer::const_iterator itr = _gameObjectDataStore.find(spawnId);
        if (itr == _gameObjectDataStore.end()) return nullptr;
            return &itr->second;
    }
    [[nodiscard]] CreatureLocale const* GetCreatureLocale(uint32 entry) const
    {
        CreatureLocaleContainer::const_iterator itr = _creatureLocaleStore.find(entry);
        if (itr == _creatureLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] GameObjectLocale const* GetGameObjectLocale(uint32 entry) const
    {
        GameObjectLocaleContainer::const_iterator itr = _gameObjectLocaleStore.find(entry);
        if (itr == _gameObjectLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] ItemLocale const* GetItemLocale(uint32 entry) const
    {
        ItemLocaleContainer::const_iterator itr = _itemLocaleStore.find(entry);
        if (itr == _itemLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] ItemSetNameLocale const* GetItemSetNameLocale(uint32 entry) const
    {
        ItemSetNameLocaleContainer::const_iterator itr = _itemSetNameLocaleStore.find(entry);
        if (itr == _itemSetNameLocaleStore.end())return nullptr;
        return &itr->second;
    }
    [[nodiscard]] PageTextLocale const* GetPageTextLocale(uint32 entry) const
    {
        PageTextLocaleContainer::const_iterator itr = _pageTextLocaleStore.find(entry);
        if (itr == _pageTextLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] QuestLocale const* GetQuestLocale(uint32 entry) const
    {
        QuestLocaleContainer::const_iterator itr = _questLocaleStore.find(entry);
        if (itr == _questLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] GossipMenuItemsLocale const* GetGossipMenuItemsLocale(uint32 entry) const
    {
        GossipMenuItemsLocaleContainer::const_iterator itr = _gossipMenuItemsLocaleStore.find(entry);
        if (itr == _gossipMenuItemsLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] PointOfInterestLocale const* GetPointOfInterestLocale(uint32 poi_id) const
    {
        PointOfInterestLocaleContainer::const_iterator itr = _pointOfInterestLocaleStore.find(poi_id);
        if (itr == _pointOfInterestLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] QuestGreetingLocale const* GetQuestGreetingLocale(TypeID type, uint32 id) const
    {
        uint32 typeIndex;
        if (type == TYPEID_UNIT)
        {
            typeIndex = 0;
        }
        else if (type == TYPEID_GAMEOBJECT)
        {
            typeIndex = 1;
        }
        else
        {
            return nullptr;
        }

        QuestGreetingLocaleContainer::const_iterator itr = _questGreetingLocaleStore.find(MAKE_PAIR32(typeIndex, id));
        if (itr == _questGreetingLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] QuestOfferRewardLocale const* GetQuestOfferRewardLocale(uint32 entry) const
    {
        auto itr = _questOfferRewardLocaleStore.find(entry);
        if (itr == _questOfferRewardLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] QuestRequestItemsLocale const* GetQuestRequestItemsLocale(uint32 entry) const
    {
        auto itr = _questRequestItemsLocaleStore.find(entry);
        if (itr == _questRequestItemsLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] NpcTextLocale const* GetNpcTextLocale(uint32 entry) const
    {
        NpcTextLocaleContainer::const_iterator itr = _npcTextLocaleStore.find(entry);
        if (itr == _npcTextLocaleStore.end()) return nullptr;
        return &itr->second;
    }
    QuestGreeting const* GetQuestGreeting(TypeID type, uint32 id) const;

    GameObjectData& NewGOData(ObjectGuid::LowType guid) { return _gameObjectDataStore[guid]; }
    void DeleteGOData(ObjectGuid::LowType guid);

    [[nodiscard]] AcoreString const* GetAcoreString(uint32 entry) const
    {
        AcoreStringContainer::const_iterator itr = _acoreStringStore.find(entry);
        if (itr == _acoreStringStore.end())
            return nullptr;

        return &itr->second;
    }
    [[nodiscard]] char const* GetAcoreString(uint32 entry, LocaleConstant locale) const;
    [[nodiscard]] char const* GetAcoreStringForDBCLocale(uint32 entry) const { return GetAcoreString(entry, DBCLocaleIndex); }
    [[nodiscard]] LocaleConstant GetDBCLocaleIndex() const { return DBCLocaleIndex; }
    void SetDBCLocaleIndex(LocaleConstant locale) { DBCLocaleIndex = locale; }

    // grid objects
    void AddCreatureToGrid(ObjectGuid::LowType guid, CreatureData const* data);
    void RemoveCreatureFromGrid(ObjectGuid::LowType guid, CreatureData const* data);
    void AddGameobjectToGrid(ObjectGuid::LowType guid, GameObjectData const* data);
    void RemoveGameobjectFromGrid(ObjectGuid::LowType guid, GameObjectData const* data);
    uint32 AddGOData(uint32 entry, uint32 map, float x, float y, float z, float o, uint32 spawntimedelay = 0, float rotation0 = 0, float rotation1 = 0, float rotation2 = 0, float rotation3 = 0);
    uint32 AddCreData(uint32 entry, uint32 map, float x, float y, float z, float o, uint32 spawntimedelay = 0);

    // reserved names
    void LoadReservedPlayersNames();
    [[nodiscard]] bool IsReservedName(std::string_view name) const;
    void AddReservedPlayerName(std::string const& name);

    // profanity names
    void LoadProfanityPlayersNames();
    [[nodiscard]] bool IsProfanityName(std::string_view name) const;
    void AddProfanityPlayerName(std::string const& name);

    // name with valid structure and symbols
    static uint8 CheckPlayerName(std::string_view name, bool create = false);
    static PetNameInvalidReason CheckPetName(std::string_view name);
    static bool IsValidCharterName(std::string_view name);
    static bool IsValidChannelName(std::string const& name);

    static bool CheckDeclinedNames(std::wstring w_ownname, DeclinedName const& names);

    [[nodiscard]] GameTele const* GetGameTele(uint32 id) const
    {
        GameTeleContainer::const_iterator itr = _gameTeleStore.find(id);
        if (itr == _gameTeleStore.end()) return nullptr;
        return &itr->second;
    }
    [[nodiscard]] GameTele const* GetGameTele(std::string_view name) const;
    [[nodiscard]] GameTeleContainer const& GetGameTeleMap() const { return _gameTeleStore; }
    bool AddGameTele(GameTele& data);
    bool DeleteGameTele(std::string_view name);

    [[nodiscard]] TrainerSpellData const* GetNpcTrainerSpells(uint32 entry) const
    {
        CacheTrainerSpellContainer::const_iterator  iter = _cacheTrainerSpellStore.find(entry);
        if (iter == _cacheTrainerSpellStore.end())
            return nullptr;

        return &iter->second;
    }

    [[nodiscard]] VendorItemData const* GetNpcVendorItemList(uint32 entry) const
    {
        CacheVendorItemContainer::const_iterator iter = _cacheVendorItemStore.find(entry);
        if (iter == _cacheVendorItemStore.end())
            return nullptr;

        return &iter->second;
    }

    void AddVendorItem(uint32 entry, uint32 item, int32 maxcount, uint32 incrtime, uint32 extendedCost, bool persist = true); // for event
    bool RemoveVendorItem(uint32 entry, uint32 item, bool persist = true); // for event
    bool IsVendorItemValid(uint32 vendor_entry, uint32 item, int32 maxcount, uint32 ptime, uint32 ExtendedCost, Player* player = nullptr, std::set<uint32>* skip_vendors = nullptr, uint32 ORnpcflag = 0) const;

    void LoadScriptNames();
    ScriptNameContainer& GetScriptNames() { return _scriptNamesStore; }
    [[nodiscard]] std::string const& GetScriptName(uint32 id) const;
    uint32 GetScriptId(std::string const& name);

    [[nodiscard]] SpellClickInfoMapBounds GetSpellClickInfoMapBounds(uint32 creature_id) const
    {
        return _spellClickInfoStore.equal_range(creature_id);
    }

    [[nodiscard]] GossipMenusMapBounds GetGossipMenusMapBounds(uint32 uiMenuId) const
    {
        return _gossipMenusStore.equal_range(uiMenuId);
    }

    GossipMenusMapBoundsNonConst GetGossipMenusMapBoundsNonConst(uint32 uiMenuId)
    {
        return _gossipMenusStore.equal_range(uiMenuId);
    }

    [[nodiscard]] GossipMenuItemsMapBounds GetGossipMenuItemsMapBounds(uint32 uiMenuId) const
    {
        return _gossipMenuItemsStore.equal_range(uiMenuId);
    }
    GossipMenuItemsMapBoundsNonConst GetGossipMenuItemsMapBoundsNonConst(uint32 uiMenuId)
    {
        return _gossipMenuItemsStore.equal_range(uiMenuId);
    }

    static void AddLocaleString(std::string&& s, LocaleConstant locale, std::vector<std::string>& data);
    static std::string_view GetLocaleString(std::vector<std::string> const& data, size_t locale)
    {
        if (locale < data.size())
            return data[locale];
        else
            return {};
    }
    static inline void GetLocaleString(const std::vector<std::string>& data, int loc_idx, std::string& value)
    {
        if (data.size() > size_t(loc_idx) && !data[loc_idx].empty())
            value = data[loc_idx];
    }

    CharacterConversionMap FactionChangeAchievements;
    CharacterConversionMap FactionChangeItems;
    CharacterConversionMap FactionChangeQuests;
    CharacterConversionMap FactionChangeReputation;
    CharacterConversionMap FactionChangeSpells;
    CharacterConversionMap FactionChangeTitles;

    void LoadFactionChangeAchievements();
    void LoadFactionChangeItems();
    void LoadFactionChangeQuests();
    void LoadFactionChangeReputations();
    void LoadFactionChangeSpells();
    void LoadFactionChangeTitles();

    [[nodiscard]] bool IsTransportMap(uint32 mapId) const { return _transportMaps.count(mapId) != 0; }

    [[nodiscard]] uint32 GetQuestMoneyReward(uint8 level, uint32 questMoneyDifficulty) const;
    void SendServerMail(Player* player, uint32 id, uint32 reqLevel, uint32 reqPlayTime, uint32 rewardMoneyA, uint32 rewardMoneyH, uint32 rewardItemA, uint32 rewardItemCountA, uint32 rewardItemH, uint32 rewardItemCountH, std::string subject, std::string body, uint8 active) const;
private:
    // first free id for selected id type
    uint32 _auctionId; // pussywizard: accessed by a single thread
    uint64 _equipmentSetGuid; // pussywizard: accessed by a single thread
    uint32 _mailId;
    std::mutex _mailIdMutex;
    uint32 _hiPetNumber;
    std::mutex _hiPetNumberMutex;

    ObjectGuid::LowType _creatureSpawnId;
    ObjectGuid::LowType _gameObjectSpawnId;

    // first free low guid for selected guid type
    template<HighGuid high>
    inline ObjectGuidGeneratorBase& GetGuidSequenceGenerator()
    {
        auto itr = _guidGenerators.find(high);
        if (itr == _guidGenerators.end())
            itr = _guidGenerators.insert(std::make_pair(high, std::unique_ptr<ObjectGuidGenerator<high>>(new ObjectGuidGenerator<high>()))).first;

        return *itr->second;
    }

    std::map<HighGuid, std::unique_ptr<ObjectGuidGeneratorBase>> _guidGenerators;

    QuestMap _questTemplates;
    std::vector<Quest*> _questTemplatesFast; // pussywizard

    typedef std::unordered_map<uint32, GossipText> GossipTextContainer;
    typedef std::unordered_map<uint32, uint32> QuestAreaTriggerContainer;
    typedef std::unordered_map<uint32, uint32> TavernAreaTriggerContainer;

    QuestAreaTriggerContainer _questAreaTriggerStore;
    TavernAreaTriggerContainer _tavernAreaTriggerStore;
    GossipTextContainer _gossipTextStore;
    QuestGreetingContainer _questGreetingStore;
    AreaTriggerContainer _areaTriggerStore;
    AreaTriggerTeleportContainer _areaTriggerTeleportStore;
    AreaTriggerScriptContainer _areaTriggerScriptStore;
    DungeonProgressionRequirementsContainer _accessRequirementStore;
    DungeonEncounterContainer _dungeonEncounterStore;

    RepRewardRateContainer _repRewardRateStore;
    RepOnKillContainer _repOnKillStore;
    RepSpilloverTemplateContainer _repSpilloverTemplateStore;

    GossipMenusContainer _gossipMenusStore;
    GossipMenuItemsContainer _gossipMenuItemsStore;
    PointOfInterestContainer _pointsOfInterestStore;

    QuestPOIContainer _questPOIStore;

    QuestRelations _goQuestRelations;
    QuestRelations _goQuestInvolvedRelations;
    QuestRelations _creatureQuestRelations;
    QuestRelations _creatureQuestInvolvedRelations;

    //character reserved names
    typedef std::set<std::wstring> ReservedNamesContainer;
    ReservedNamesContainer _reservedNamesStore;

    //character profanity names
    typedef std::set<std::wstring> ProfanityNamesContainer;
    ReservedNamesContainer _profanityNamesStore;

    GameTeleContainer _gameTeleStore;

    ScriptNameContainer _scriptNamesStore;

    SpellClickInfoContainer _spellClickInfoStore;

    SpellScriptsContainer _spellScriptsStore;

    VehicleAccessoryContainer _vehicleTemplateAccessoryStore;
    VehicleAccessoryContainer _vehicleAccessoryStore;

    LocaleConstant DBCLocaleIndex;

    PageTextContainer _pageTextStore;
    InstanceTemplateContainer _instanceTemplateStore;

private:
    void LoadScripts(ScriptsType type);
    void LoadQuestRelationsHelper(QuestRelations& map, std::string const& table, bool starter, bool go);
    void PlayerCreateInfoAddItemHelper(uint32 race_, uint32 class_, uint32 itemId, int32 count);

    MailLevelRewardContainer _mailLevelRewardStore;

    CreatureBaseStatsContainer _creatureBaseStatsStore;

    typedef std::map<uint32, PetLevelInfo*> PetLevelInfoContainer;
    // PetLevelInfoContainer[creature_id][level]
    PetLevelInfoContainer _petInfoStore;                            // [creature_id][level]

    PlayerClassInfo* _playerClassInfo[MAX_CLASSES];

    void BuildPlayerLevelInfo(uint8 race, uint8 class_, uint8 level, PlayerLevelInfo* plinfo) const;

    PlayerInfo* _playerInfo[MAX_RACES][MAX_CLASSES];

    typedef std::vector<uint32> PlayerXPperLevel;       // [level]
    PlayerXPperLevel _playerXPperLevel;

    typedef std::map<uint32, uint32> BaseXPContainer;          // [area level][base xp]
    BaseXPContainer _baseXPTable;

    typedef std::map<uint32, int32> FishingBaseSkillContainer; // [areaId][base skill level]
    FishingBaseSkillContainer _fishingBaseForAreaStore;

    typedef std::map<uint32, std::vector<std::string>> HalfNameContainer;
    HalfNameContainer _petHalfName0;
    HalfNameContainer _petHalfName1;
    typedef std::map<std::pair<uint32, LocaleConstant>, std::vector<std::string>> HalfNameContainerLocale;
    HalfNameContainerLocale _petHalfLocaleName0;
    HalfNameContainerLocale _petHalfLocaleName1;

    typedef std::unordered_map<uint32, ItemSetNameEntry> ItemSetNameContainer;
    ItemSetNameContainer _itemSetNameStore;

    MapObjectGuids _mapObjectGuidsStore;
    CellObjectGuidsMap _emptyCellObjectGuidsMap;
    CellObjectGuids _emptyCellObjectGuids;
    CreatureDataContainer _creatureDataStore;
    CreatureTemplateContainer _creatureTemplateStore;
    CreatureCustomIDsContainer _creatureCustomIDsStore;
    std::vector<CreatureTemplate*> _creatureTemplateStoreFast; // pussywizard
    CreatureModelContainer _creatureModelStore;
    CreatureAddonContainer _creatureAddonStore;
    CreatureAddonContainer _creatureTemplateAddonStore;
    std::unordered_map<ObjectGuid::LowType, CreatureMovementData> _creatureMovementOverrides;
    GameObjectAddonContainer _gameObjectAddonStore;
    GameObjectQuestItemMap _gameObjectQuestItemStore;
    CreatureQuestItemMap _creatureQuestItemStore;
    EquipmentInfoContainer _equipmentInfoStore;
    LinkedRespawnContainer _linkedRespawnStore;
    CreatureLocaleContainer _creatureLocaleStore;
    GameObjectDataContainer _gameObjectDataStore;
    GameObjectLocaleContainer _gameObjectLocaleStore;
    GameObjectTemplateContainer _gameObjectTemplateStore;
    GameObjectTemplateAddonContainer _gameObjectTemplateAddonStore;
    /// Stores temp summon data grouped by summoner's entry, summoner's type and group id
    TempSummonDataContainer _tempSummonDataStore;

    BroadcastTextContainer _broadcastTextStore;
    ItemTemplateContainer _itemTemplateStore;
    std::vector<ItemTemplate*> _itemTemplateStoreFast; // pussywizard
    ItemLocaleContainer _itemLocaleStore;
    ItemSetNameLocaleContainer _itemSetNameLocaleStore;
    QuestLocaleContainer _questLocaleStore;
    QuestOfferRewardLocaleContainer _questOfferRewardLocaleStore;
    QuestRequestItemsLocaleContainer _questRequestItemsLocaleStore;
    NpcTextLocaleContainer _npcTextLocaleStore;
    PageTextLocaleContainer _pageTextLocaleStore;
    AcoreStringContainer _acoreStringStore;
    GossipMenuItemsLocaleContainer _gossipMenuItemsLocaleStore;
    PointOfInterestLocaleContainer _pointOfInterestLocaleStore;
    QuestGreetingLocaleContainer _questGreetingLocaleStore;

    CacheVendorItemContainer _cacheVendorItemStore;
    CacheTrainerSpellContainer _cacheTrainerSpellStore;

    ServerMailContainer _serverMailStore;

    std::set<uint32> _difficultyEntries[MAX_DIFFICULTY - 1]; // already loaded difficulty 1 value in creatures, used in CheckCreatureTemplate
    std::set<uint32> _hasDifficultyEntries[MAX_DIFFICULTY - 1]; // already loaded creatures with difficulty 1 values, used in CheckCreatureTemplate

    enum CreatureLinkedRespawnType
    {
        CREATURE_TO_CREATURE,
        CREATURE_TO_GO,         // Creature is dependant on GO
        GO_TO_GO,
        GO_TO_CREATURE,         // GO is dependant on creature
    };

    std::set<uint32> _transportMaps; // Helper container storing map ids that are for transports only, loaded from gameobject_template

    QuestMoneyRewardStore _questMoneyRewards;

    struct GameobjectInstanceSavedState
    {
        uint32 m_instance;
        uint32 m_guid;
        unsigned short m_state;
    };
    std::vector<GameobjectInstanceSavedState> GameobjectInstanceSavedStateList;
};

#define sObjectMgr ObjectMgr::instance()

#endif
