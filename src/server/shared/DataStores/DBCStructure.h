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

#ifndef ACORE_DBCSTRUCTURE_H
#define ACORE_DBCSTRUCTURE_H

#include "DBCEnums.h"
#include "Define.h"
#include "SharedDefines.h"
#include "Util.h"
#include <array>
#include <map>
#include <set>
#include <unordered_map>

// Structures using to access raw DBC data and required packing to portability

// GCC have alternative #pragma pack(N) syntax and old gcc version not support pack(push, N), also any gcc version not support it at some platform
#if defined(__GNUC__)
#pragma pack(1)
#else
#pragma pack(push, 1)
#endif

struct AchievementEntry
{
    uint32    ID;                                           // 0
    int32    requiredFaction;                               // 1 -1=all, 0=horde, 1=alliance
    int32    mapID;                                         // 2 -1=none
    //uint32 parentAchievement;                             // 3 its Achievement parent (can`t start while parent uncomplete, use its Criteria if don`t have own, use its progress on begin)
    std::array<char const*, 16> name;                       // 4-19
    //uint32 name_flags;                                    // 20
    //char *description[16];                                // 21-36
    //uint32 desc_flags;                                    // 37
    uint32    categoryId;                                   // 38
    uint32    points;                                       // 39 reward points
    //uint32 OrderInCategory;                               // 40
    uint32    flags;                                        // 41
    //uint32    icon;                                       // 42 icon (from SpellIcon.dbc)
    //char *titleReward[16];                                // 43-58
    //uint32 titleReward_flags;                             // 59
    uint32 count;                                           // 60 - need this count of completed criterias (own or referenced achievement criterias)
    uint32 refAchievement;                                  // 61 - referenced achievement (counting of all completed criterias)
};

struct AchievementCategoryEntry
{
    int32    ID;                                            // 0
    int32    parentCategory;                                // 1 -1 for main category
    //char *name[16];                                       // 2-17
    //uint32 name_flags;                                    // 18
    //uint32    sortOrder;                                  // 19
};

struct AchievementCriteriaEntry
{
    uint32  ID;                                             // 0
    uint32  referredAchievement;                            // 1
    uint32  requiredType;                                   // 2
    union
    {
        // ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE          = 0
        /// @todo: also used for player deaths..
        struct
        {
            uint32  creatureID;                             // 3
            uint32  creatureCount;                          // 4
        } kill_creature;

        // ACHIEVEMENT_CRITERIA_TYPE_WIN_BG                 = 1
        struct
        {
            uint32  bgMapID;                                // 3
            uint32  winCount;                               // 4
        } win_bg;

        // ACHIEVEMENT_CRITERIA_TYPE_REACH_LEVEL            = 5
        struct
        {
            uint32  unused;                                 // 3
            uint32  level;                                  // 4
        } reach_level;

        // ACHIEVEMENT_CRITERIA_TYPE_REACH_SKILL_LEVEL      = 7
        struct
        {
            uint32  skillID;                                // 3
            uint32  skillLevel;                             // 4
        } reach_skill_level;

        // ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_ACHIEVEMENT   = 8
        struct
        {
            uint32  linkedAchievement;                      // 3
        } complete_achievement;

        // ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST_COUNT   = 9
        struct
        {
            uint32  unused;                                 // 3
            uint32  totalQuestCount;                        // 4
        } complete_quest_count;

        // ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_DAILY_QUEST_DAILY = 10
        struct
        {
            uint32  unused;                                 // 3
            uint32  numberOfDays;                           // 4
        } complete_daily_quest_daily;

        // ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUESTS_IN_ZONE = 11
        struct
        {
            uint32  zoneID;                                 // 3
            uint32  questCount;                             // 4
        } complete_quests_in_zone;

        // ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_DAILY_QUEST   = 14
        struct
        {
            uint32  unused;                                 // 3
            uint32  questCount;                             // 4
        } complete_daily_quest;

        // ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_BATTLEGROUND  = 15
        struct
        {
            uint32  mapID;                                  // 3
        } complete_battleground;

        // ACHIEVEMENT_CRITERIA_TYPE_DEATH_AT_MAP           = 16
        struct
        {
            uint32  mapID;                                  // 3
        } death_at_map;

        // ACHIEVEMENT_CRITERIA_TYPE_DEATH_IN_DUNGEON       = 18
        struct
        {
            uint32  manLimit;                               // 3
        } death_in_dungeon;

        // ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_RAID          = 19
        struct
        {
            uint32  groupSize;                              // 3 can be 5, 10 or 25
        } complete_raid;

        // ACHIEVEMENT_CRITERIA_TYPE_KILLED_BY_CREATURE     = 20
        struct
        {
            uint32  creatureEntry;                          // 3
        } killed_by_creature;

        // ACHIEVEMENT_CRITERIA_TYPE_FALL_WITHOUT_DYING     = 24
        struct
        {
            uint32  unused;                                 // 3
            uint32  fallHeight;                             // 4
        } fall_without_dying;

        // ACHIEVEMENT_CRITERIA_TYPE_DEATHS_FROM            = 26
        struct
        {
            uint32 type;                                    // 3, see enum EnviromentalDamage
        } death_from;

        // ACHIEVEMENT_CRITERIA_TYPE_COMPLETE_QUEST         = 27
        struct
        {
            uint32  questID;                                // 3
            uint32  questCount;                             // 4
        } complete_quest;

        // ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET        = 28
        // ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2       = 69
        struct
        {
            uint32  spellID;                                // 3
            uint32  spellCount;                             // 4
        } be_spell_target;

        // ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL             = 29
        // ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL2            = 110
        struct
        {
            uint32  spellID;                                // 3
            uint32  castCount;                              // 4
        } cast_spell;

        // ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE
        struct
        {
            uint32 objectiveId;                             // 3
            uint32 completeCount;                           // 4
        } bg_objective;

        // ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL_AT_AREA = 31
        struct
        {
            uint32  areaID;                                 // 3 Reference to AreaTable.dbc
            uint32  killCount;                              // 4
        } honorable_kill_at_area;

        // ACHIEVEMENT_CRITERIA_TYPE_WIN_ARENA              = 32
        struct
        {
            uint32 mapID;                                   // 3 Reference to Map.dbc
            uint32 count;                                   // 4 Number of times that the arena must be won.
        } win_arena;

        // ACHIEVEMENT_CRITERIA_TYPE_PLAY_ARENA             = 33
        struct
        {
            uint32  mapID;                                  // 3 Reference to Map.dbc
        } play_arena;

        // ACHIEVEMENT_CRITERIA_TYPE_LEARN_SPELL            = 34
        struct
        {
            uint32  spellID;                                // 3 Reference to Map.dbc
        } learn_spell;

        // ACHIEVEMENT_CRITERIA_TYPE_OWN_ITEM               = 36
        struct
        {
            uint32  itemID;                                 // 3
            uint32  itemCount;                              // 4
        } own_item;

        // ACHIEVEMENT_CRITERIA_TYPE_WIN_RATED_ARENA        = 37
        struct
        {
            uint32  unused;                                 // 3
            uint32  count;                                  // 4
        } win_rated_arena;

        // ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_TEAM_RATING    = 38
        struct
        {
            uint32  teamtype;                               // 3 {2, 3, 5}
        } highest_team_rating;

        // ACHIEVEMENT_CRITERIA_TYPE_REACH_TEAM_RATING      = 39
        struct
        {
            uint32  teamtype;                               // 3 {2, 3, 5}
            uint32  PersonalRating;                         // 4
        } highest_personal_rating;

        // ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LEVEL      = 40
        struct
        {
            uint32  skillID;                                // 3
            uint32  skillLevel;                             // 4 apprentice=1, journeyman=2, expert=3, artisan=4, master=5, grand master=6
        } learn_skill_level;

        // ACHIEVEMENT_CRITERIA_TYPE_USE_ITEM               = 41
        struct
        {
            uint32  itemID;                                 // 3
            uint32  itemCount;                              // 4
        } use_item;

        // ACHIEVEMENT_CRITERIA_TYPE_LOOT_ITEM              = 42
        struct
        {
            uint32  itemID;                                 // 3
            uint32  itemCount;                              // 4
        } loot_item;

        // ACHIEVEMENT_CRITERIA_TYPE_EXPLORE_AREA           = 43
        struct
        {
            /// @todo: This rank is _NOT_ the index from AreaTable.dbc
            uint32  areaReference;                          // 3
        } explore_area;

        // ACHIEVEMENT_CRITERIA_TYPE_OWN_RANK               = 44
        struct
        {
            /// @todo: This rank is _NOT_ the index from CharTitles.dbc
            uint32  rank;                                   // 3
        } own_rank;

        // ACHIEVEMENT_CRITERIA_TYPE_BUY_BANK_SLOT          = 45
        struct
        {
            uint32  unused;                                 // 3
            uint32  numberOfSlots;                          // 4
        } buy_bank_slot;

        // ACHIEVEMENT_CRITERIA_TYPE_GAIN_REPUTATION        = 46
        struct
        {
            uint32  factionID;                              // 3
            uint32  reputationAmount;                       // 4 Total reputation amount, so 42000 = exalted
        } gain_reputation;

        // ACHIEVEMENT_CRITERIA_TYPE_GAIN_EXALTED_REPUTATION= 47
        struct
        {
            uint32  unused;                                 // 3
            uint32  numberOfExaltedFactions;                // 4
        } gain_exalted_reputation;

        // ACHIEVEMENT_CRITERIA_TYPE_VISIT_BARBER_SHOP      = 48
        struct
        {
            uint32 unused;                                  // 3
            uint32 numberOfVisits;                          // 4
        } visit_barber;

        // ACHIEVEMENT_CRITERIA_TYPE_EQUIP_EPIC_ITEM        = 49
        /// @todo: where is the required itemlevel stored?
        struct
        {
            uint32  itemSlot;                               // 3
            uint32  count;                                  // 4
        } equip_epic_item;

        // ACHIEVEMENT_CRITERIA_TYPE_ROLL_NEED_ON_LOOT      = 50
        struct
        {
            uint32  rollValue;                              // 3
            uint32  count;                                  // 4
        } roll_need_on_loot;
        // ACHIEVEMENT_CRITERIA_TYPE_ROLL_GREED_ON_LOOT      = 51
        struct
        {
            uint32  rollValue;                              // 3
            uint32  count;                                  // 4
        } roll_greed_on_loot;

        // ACHIEVEMENT_CRITERIA_TYPE_HK_CLASS               = 52
        struct
        {
            uint32  classID;                                // 3
            uint32  count;                                  // 4
        } hk_class;

        // ACHIEVEMENT_CRITERIA_TYPE_HK_RACE                = 53
        struct
        {
            uint32  raceID;                                 // 3
            uint32  count;                                  // 4
        } hk_race;

        // ACHIEVEMENT_CRITERIA_TYPE_DO_EMOTE               = 54
        /// @todo: where is the information about the target stored?
        struct
        {
            uint32  emoteID;                                // 3 enum TextEmotes
            uint32  count;                                  // 4 count of emotes, always required special target or requirements
        } do_emote;

        // ACHIEVEMENT_CRITERIA_TYPE_DAMAGE_DONE            = 13
        // ACHIEVEMENT_CRITERIA_TYPE_HEALING_DONE           = 55
        struct
        {
            uint32  unused;                                 // 3
            uint32  count;                                  // 4
        } healing_done;

        // ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS      = 56
        struct
        {
            uint32  unused;
            uint32  killCount;
        } get_killing_blow;

        // ACHIEVEMENT_CRITERIA_TYPE_EQUIP_ITEM             = 57
        struct
        {
            uint32  itemID;                                 // 3
            uint32  count;                                  // 4
        } equip_item;

        // ACHIEVEMENT_CRITERIA_TYPE_MONEY_FROM_QUEST_REWARD= 62
        struct
        {
            uint32  unused;                                 // 3
            uint32  goldInCopper;                           // 4
        } quest_reward_money;

        // ACHIEVEMENT_CRITERIA_TYPE_LOOT_MONEY             = 67
        struct
        {
            uint32  unused;                                 // 3
            uint32  goldInCopper;                           // 4
        } loot_money;

        // ACHIEVEMENT_CRITERIA_TYPE_USE_GAMEOBJECT         = 68
        struct
        {
            uint32  goEntry;                                // 3
            uint32  useCount;                               // 4
        } use_gameobject;

        // ACHIEVEMENT_CRITERIA_TYPE_SPECIAL_PVP_KILL       = 70
        /// @todo: are those special criteria stored in the dbc or do we have to add another sql table?
        struct
        {
            uint32  unused;                                 // 3
            uint32  killCount;                              // 4
        } special_pvp_kill;

        // ACHIEVEMENT_CRITERIA_TYPE_FISH_IN_GAMEOBJECT     = 72
        struct
        {
            uint32  goEntry;                                // 3
            uint32  lootCount;                              // 4
        } fish_in_gameobject;

        // ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILLLINE_SPELLS = 75
        struct
        {
            uint32  skillLine;                              // 3
            uint32  spellCount;                             // 4
        } learn_skillline_spell;

        // ACHIEVEMENT_CRITERIA_TYPE_WIN_DUEL               = 76
        struct
        {
            uint32  unused;                                 // 3
            uint32  duelCount;                              // 4
        } win_duel;

        // ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_POWER          = 96
        struct
        {
            uint32  powerType;                              // 3 mana=0, 1=rage, 3=energy, 6=runic power
        } highest_power;

        // ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_STAT           = 97
        struct
        {
            uint32  statType;                               // 3 4=spirit, 3=int, 2=stamina, 1=agi, 0=strength
        } highest_stat;

        // ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_SPELLPOWER     = 98
        struct
        {
            uint32  spellSchool;                            // 3
        } highest_spellpower;

        // ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_RATING         = 100
        struct
        {
            uint32  ratingType;                             // 3
        } highest_rating;

        // ACHIEVEMENT_CRITERIA_TYPE_LOOT_TYPE              = 109
        struct
        {
            uint32  lootType;                               // 3 3=fishing, 2=pickpocket, 4=disentchant
            uint32  lootTypeCount;                          // 4
        } loot_type;

        // ACHIEVEMENT_CRITERIA_TYPE_LEARN_SKILL_LINE       = 112
        struct
        {
            uint32  skillLine;                              // 3
            uint32  spellCount;                             // 4
        } learn_skill_line;

        // ACHIEVEMENT_CRITERIA_TYPE_EARN_HONORABLE_KILL    = 113
        struct
        {
            uint32  unused;                                 // 3
            uint32  killCount;                              // 4
        } honorable_kill;

        struct
        {
            uint32  unused;
            uint32  dungeonsComplete;
        } use_lfg;

        struct
        {
            uint32  field3;                                 // 3 main requirement
            uint32  count;                                  // 4 main requirement count
        } raw;
    };

    struct
    {
        uint32  additionalRequirement_type;
        uint32  additionalRequirement_value;
    } additionalRequirements[MAX_CRITERIA_REQUIREMENTS];

    //char const*  name[16];                                // 9-24
    //uint32 name_flags;                                    // 25
    uint32  flags;                                          // 26
    uint32  timedType;                                      // 27
    uint32  timerStartEvent;                                // 28 Alway appears with timed events
    // for timed spells it is spell id for
    // timed kills it is creature id
    uint32  timeLimit;                                      // 29 time limit in seconds
    //uint32 showOrder;                                     // 30 show order
};

struct AreaTableEntry
{
    uint32  ID;                                             // 0
    uint32  mapid;                                          // 1
    uint32  zone;                                           // 2 if 0 then it's zone, else it's zone id of this area
    uint32  exploreFlag;                                    // 3, main index
    uint32  flags;                                          // 4, unknown value but 312 for all cities
    // 5-9 unused
    int32   area_level;                                     // 10
    char const*   area_name[16];                            // 11-26
    // 27, string flags, unused
    uint32  team;                                           // 28
    uint32  LiquidTypeOverride[4];                          // 29-32 liquid override by type

    // helpers
    [[nodiscard]] bool IsSanctuary() const
    {
        if (mapid == 609)
            return true;
        return (flags & AREA_FLAG_SANCTUARY);
    }

    [[nodiscard]] bool IsFlyable() const
    {
        return flags & AREA_FLAG_OUTLAND;
    }
};

#define MAX_GROUP_AREA_IDS 6

struct AreaGroupEntry
{
    uint32  AreaGroupId;                                    // 0
    uint32  AreaId[MAX_GROUP_AREA_IDS];                     // 1-6
    uint32  nextGroup;                                      // 7 index of next group
};

struct AreaPOIEntry
{
    uint32 id;                  //0
    uint32 icon[11];            //1-11
    float x;                    //12
    float y;                    //13
    float z;                    //14
    uint32 mapId;               //15
    //uint32 val1;              //16
    uint32 zoneId;              //17
    //char const* name[16];     //18-33
    //uint32 name_flag;         //34
    //char const* name2[16];    //35-50
    //uint32 name_flag2;        //51
    uint32 worldState;          //52
    //uint32 val2;              //53
};

struct AuctionHouseEntry
{
    uint32    houseId;                                      // 0 index
    uint32    faction;                                      // 1 id of faction.dbc for player factions associated with city
    uint32    depositPercent;                               // 2 1/3 from real
    uint32    cutPercent;                                   // 3
    //char const*     name[16];                             // 4-19
    // 20 string flag, unused
};

struct BankBagSlotPricesEntry
{
    uint32  ID;
    uint32  price;
};

struct BarberShopStyleEntry
{
    uint32  Id;                                             // 0
    uint32  type;                                           // 1 value 0 -> hair, value 2 -> facialhair
    //char const*  displayNameLang[16];                     // 2-17 name of hair style
    //char const*  displayNameLangMask;                     // 18
    //char const*  descriptionLang[16];                     // 19-34, all empty
    //char const*  descriptionLangMask;                     // 35
    //float   costModifier;                                 // 36 values 1 and 0.75
    uint32  race;                                           // 37 race
    uint32  gender;                                         // 38 0 -> male, 1 -> female
    uint32  hair_id;                                        // 39 real ID to hair/facial hair
};

struct BattlemasterListEntry
{
    uint32  id;                                             // 0
    int32   mapid[8];                                       // 1-8 mapid
    uint32  type;                                           // 9 (3 - BG, 4 - arena)
    //uint32 canJoinAsGroup;                                // 10 (0 or 1)
    char const*   name[16];                                 // 11-26
    //uint32 nameFlags                                      // 27 string flag, unused
    uint32 maxGroupSize;                                    // 28 maxGroupSize, used for checking if queue as group
    uint32 HolidayWorldStateId;                             // 29 new 3.1
    //uint32 MinLevel;                                      // 30
    //uint32 SomeLevel;                                     // 31, may be max level
};

#define MAX_OUTFIT_ITEMS 24

struct CharStartOutfitEntry
{
    //uint32 ID;                                            // 0
    uint8 Race;                                             // 1
    uint8 Class;                                            // 2
    uint8 Gender;                                           // 3
    //uint8 outfitID;                                       // 4     unused
    int32 ItemId[MAX_OUTFIT_ITEMS];                         // 5-28
    //int32 ItemDisplayId[MAX_OUTFIT_ITEMS];                // 29-52 not required at server side
    //int32 ItemInventorySlot[MAX_OUTFIT_ITEMS];            // 53-76 not required at server side
};

struct CharTitlesEntry
{
    uint32  ID;                                             // 0, title ids, for example in Quest::GetCharTitleId()
    //uint32      conditionID;                              // 1  Never used by the client. Should be used serverside?
    char const*   nameMale[16];                             // 2-17
    //uint32 nameLangMask                                   // 18 string flag, unused
    char const*   nameFemale[16];                           // 19-34
    //uint32 nameLang1Mask                                  // 35 string flag, unused
    uint32  bit_index;                                      // 36 used in PLAYER_CHOSEN_TITLE and 1<<index in PLAYER__FIELD_KNOWN_TITLES
};

struct ChatChannelsEntry
{
    uint32  ChannelID;                                      // 0
    uint32  flags;                                          // 1
    char const*   pattern[16];                              // 3-18
    // 19 string flags, unused
    //char const*       name[16];                           // 20-35 unused
    // 36 string flag, unused
};

struct ChrClassesEntry
{
    uint32  ClassID;                                        // 0
    // 1, unused
    uint32  powerType;                                      // 2
    // 3-4, unused
    char const*       name[16];                             // 5-20 unused
    // 21 string flag, unused
    //char const*       nameFemale[16];                     // 21-36 unused, if different from base (male) case
    // 37 string flag, unused
    //char const*       nameNeutralGender[16];              // 38-53 unused, if different from base (male) case
    // 54 string flag, unused
    // 55, unused
    uint32  spellfamily;                                    // 56
    // 57, unused
    uint32  CinematicSequence;                              // 58 id from CinematicSequences.dbc
    uint32  expansion;                                      // 59 (0 - original race, 1 - tbc addon, ...)
};

enum ChrRacesFlags
{
    CHRRACES_FLAGS_NOT_PLAYABLE = 0x01,
    CHRRACES_FLAGS_BARE_FEET    = 0x02,
    CHRRACES_FLAGS_CAN_MOUNT    = 0x04
};

struct ChrRacesEntry
{
    uint32      RaceID;                                     // 0
    uint32      Flags;                                      // 1
    uint32      FactionID;                                  // 2 facton template id
    // 3 unused
    uint32      model_m;                                    // 4
    uint32      model_f;                                    // 5
    // 6 unused
    uint32      TeamID;                                     // 7 (7-Alliance 1-Horde)
    // 8-11 unused
    uint32      CinematicSequence;                          // 12 id from CinematicSequences.dbc
    //uint32    alliance;                                   // 13 faction (0 alliance, 1 horde, 2 not available?)
    char const*       name[16];                             // 14-29 used for DBC language detection/selection
    // 30 string flags, unused
    //char const*       nameFemale[16];                     // 31-46, if different from base (male) case
    // 47 string flags, unused
    //char const*       nameNeutralGender[16];              // 48-63, if different from base (male) case
    // 64 string flags, unused
    // 65-67 unused
    uint32      expansion;                                  // 68 (0 - original race, 1 - tbc addon, ...)

    inline bool HasFlag(ChrRacesFlags flag) const { return (Flags & flag) != 0; }
};

struct CinematicCameraEntry
{
    uint32 ID;                                              // 0
    char const* Model;                                      // 1    Model filename (translate .mdx to .m2)
    uint32 SoundID;                                         // 2    Sound ID       (voiceover for cinematic)
    DBCPosition3D Origin;                                   // 3-5  Position in map used for basis for M2 co-ordinates
    float OriginFacing;                                     // 6    Orientation in map used for basis for M2 co-ordinates
};

struct CinematicSequencesEntry
{
    uint32      Id;                                         // 0 index
    //uint32    soundID;                                    // 1 always 0
    uint32      cinematicCamera;                            // 2 id in CinematicCamera.dbc
    //uint32     cinematicCamera                            // 3-9 always 0
};

struct CreatureDisplayInfoEntry
{
    uint32      Displayid;                                  // 0        m_ID
    uint32      ModelId;                                    // 1        m_modelID
    // 2        m_soundID
    uint32      ExtendedDisplayInfoID;                      // 3
    float       scale;                                      // 4        m_creatureModelScale
    // 5        m_creatureModelAlpha
    // 6-8      m_textureVariation[3]
    // 9        m_portraitTextureName
    // 10       m_sizeClass
    // 11       m_bloodID
    // 12       m_NPCSoundID
    // 13       m_particleColorID
    // 14       m_creatureGeosetData
    // 15       m_objectEffectPackageID
};

struct CreatureDisplayInfoExtraEntry
{
    //uint32 ID;                                            // 0
    uint32 DisplayRaceID;                                   // 1
    //uint32 DisplaySexID;                                  // 2
    //uint32 SkinID;                                        // 3
    //uint32 FaceID;                                        // 4
    //uint32 HairStyleID;                                   // 5
    //uint32 HairColorID;                                   // 6
    //uint32 FacialHairID;                                  // 7
    //uint32 NPCItemDisplay[11];                            // 8-18
    //uint32 Flags;                                         // 19
    //char const* BakeName;                                 // 20
};

struct CreatureFamilyEntry
{
    uint32  ID;                                             // 0        m_ID
    float   minScale;                                       // 1        m_minScale
    uint32  minScaleLevel;                                  // 2        m_minScaleLevel
    float   maxScale;                                       // 3        m_maxScale
    uint32  maxScaleLevel;                                  // 4        m_maxScaleLevel
    uint32  skillLine[2];                                   // 5-6      m_skillLine
    uint32  petFoodMask;                                    // 7        m_petFoodMask
    int32   petTalentType;                                  // 8        m_petTalentType
    // 9        m_categoryEnumID
    char const*   Name[16];                                 // 10-25    m_name_lang
    // 26 string flags
    // 27       m_iconFile
};

enum CreatureModelDataFlags
{
    CREATURE_MODEL_DATA_FLAGS_CAN_MOUNT     = 0x00000080
};

struct CreatureModelDataEntry
{
    uint32 Id;
    uint32 Flags;
    //char const* ModelPath
    float Scale;                                             // Used in calculation of unit collision data
    //int32 bloodID
    //int32 footprintTexureID
    //float footprintTextureLength
    //float footprinTextureWidth
    //float footprintParticleScale
    //uint32 foleyMaterialID
    //float footstepShakeSize
    //uint32 deathThudShakeSize
    //uint32 soundID
    float CollisionWidth;
    float CollisionHeight;
    float MountHeight;                                       // Used in calculation of unit collision data when mounted
    //float geoBoxMinX
    //float geoBoxMinY
    //float geoBoxMinZ
    //float geoBoxMaxX
    //float geoBoxMaxY
    //float geoBoxMaxZ
    //float worldEffectScale
    //float attachedEffectScale
    //float missileCollisionRadius
    //float missileCollisionPush
    //float missileCollisionRaise

    inline bool HasFlag(CreatureModelDataFlags flag) const { return (Flags & flag) != 0; }
};

#define MAX_CREATURE_SPELL_DATA_SLOT 4

struct CreatureSpellDataEntry
{
    uint32    ID;                                           // 0        m_ID
    uint32    spellId[MAX_CREATURE_SPELL_DATA_SLOT];        // 1-4      m_spells[4]
    //uint32    availability[MAX_CREATURE_SPELL_DATA_SLOT]; // 4-7      m_availability[4]
};

struct CreatureTypeEntry
{
    uint32    ID;                                           // 0        m_ID
    //char const*   Name[16];                               // 1-16     name
    // 17       string flags
    //uint32    no_expirience;                              // 18 no exp? critters, non-combat pets, gas cloud.
};

/* not used
struct CurrencyCategoryEntry
{
    uint32    ID;                                           // 0
    uint32    flags;                                        // 1        0 for known categories and 3 for unknown one (3.0.9)
    char const*   Name[16];                                 // 2-17     name
    //                                                      // 18       string flags
};
*/

struct CurrencyTypesEntry
{
    //uint32    ID;                                         // 0        not used
    uint32    ItemId;                                       // 1        used as real index
    //uint32    Category;                                   // 2        may be category
    uint32    BitIndex;                                     // 3        bit index in PLAYER_FIELD_KNOWN_CURRENCIES (1 << (index-1))
};

struct DestructibleModelDataEntry
{
    uint32  Id;
    //uint32  DamagedUnk1;
    //uint32  DamagedUnk2;
    uint32  DamagedDisplayId;
    //uint32  DamagedUnk3;
    //uint32  DestroyedUnk1;
    //uint32  DestroyedUnk2;
    uint32  DestroyedDisplayId;
    //uint32  DestroyedUnk3;
    //uint32  RebuildingUnk1;
    //uint32  RebuildingUnk2;
    uint32  RebuildingDisplayId;
    //uint32  RebuildingUnk3;
    //uint32  SmokeUnk1;
    //uint32  SmokeUnk2;
    uint32  SmokeDisplayId;
    //uint32  SmokeUnk3;
    //uint32  Unk4;
    //uint32  Unk5;
};

struct DungeonEncounterEntry
{
    uint32 id;                                              // 0        unique id
    uint32 mapId;                                           // 1        map id
    uint32 difficulty;                                      // 2        instance mode
    //uint32 orderIndex;                                    // 3
    uint32 encounterIndex;                                  // 4        encounter index for creating completed mask
    char const*  encounterName[16];                         // 5-20     encounter name
    //uint32 nameFlags;                                     // 21
    //uint32 spellIconID;                                   // 22
};

struct DurabilityCostsEntry
{
    uint32    Itemlvl;                                      // 0
    uint32    multiplier[29];                               // 1-29
};

struct DurabilityQualityEntry
{
    uint32    Id;                                           // 0
    float     quality_mod;                                  // 1
};

struct EmotesEntry
{
    uint32  Id;                                             // 0
    //char const*   Name;                                   // 1, internal name
    //uint32  AnimationId;                                  // 2, ref to animationData
    uint32  Flags;                                          // 3, bitmask, may be unit_flags
    uint32  EmoteType;                                      // 4, Can be 0, 1 or 2 (determine how emote are shown)
    uint32  UnitStandState;                                 // 5, uncomfirmed, may be enum UnitStandStateType
    //uint32  SoundId;                                      // 6, ref to soundEntries
};

struct EmotesTextEntry
{
    uint32  Id;
    uint32  textid;
};

struct FactionEntry
{
    uint32      ID;                                         // 0        m_ID
    int32       reputationListID;                           // 1        m_reputationIndex
    uint32      BaseRepRaceMask[4];                         // 2-5      m_reputationRaceMask
    uint32      BaseRepClassMask[4];                        // 6-9      m_reputationClassMask
    int32       BaseRepValue[4];                            // 10-13    m_reputationBase
    uint32      ReputationFlags[4];                         // 14-17    m_reputationFlags
    uint32      team;                                       // 18       m_parentFactionID
    float       spilloverRateIn;                            // 19       Faction gains incoming rep * spilloverRateIn
    float       spilloverRateOut;                           // 20       Faction outputs rep * spilloverRateOut as spillover reputation
    uint32      spilloverMaxRankIn;                         // 21       The highest rank the faction will profit from incoming spillover
    //uint32    parentFactionCap;                           // 22       It does not seem to be the max standing at which a faction outputs spillover ...so no idea
    char const*       name[16];                             // 23-38    m_name_lang
    // 39 string flags
    //char const*     description[16];                      // 40-55    m_description_lang
    // 56 string flags

    // helpers
    [[nodiscard]] bool CanHaveReputation() const
    {
        return reputationListID >= 0;
    }

    [[nodiscard]] bool CanBeSetAtWar() const
    {
        return reputationListID >= 0 && BaseRepRaceMask[0] == 1791;
    }
};

#define MAX_FACTION_RELATIONS 4

struct FactionTemplateEntry
{
    uint32      ID;                                         // 0        m_ID
    uint32      faction;                                    // 1        m_faction
    uint32      factionFlags;                               // 2        m_flags
    uint32      ourMask;                                    // 3        m_factionGroup
    uint32      friendlyMask;                               // 4        m_friendGroup
    uint32      hostileMask;                                // 5        m_enemyGroup
    uint32      enemyFaction[MAX_FACTION_RELATIONS];        // 6        m_enemies[MAX_FACTION_RELATIONS]
    uint32      friendFaction[MAX_FACTION_RELATIONS];       // 10       m_friend[MAX_FACTION_RELATIONS]
    //-------------------------------------------------------  end structure

    // helpers
    [[nodiscard]] bool IsFriendlyTo(FactionTemplateEntry const& entry) const
    {
        // Xinef: Always friendly to self faction
        if (faction == entry.faction)
            return true;

        if (entry.faction)
        {
            for (unsigned int i : enemyFaction)
                if (i == entry.faction)
                    return false;
            for (unsigned int i : friendFaction)
                if (i == entry.faction)
                    return true;
        }
        return (friendlyMask & entry.ourMask) || (ourMask & entry.friendlyMask);
    }
    [[nodiscard]] bool IsHostileTo(FactionTemplateEntry const& entry) const
    {
        if (entry.faction)
        {
            for (unsigned int i : enemyFaction)
                if (i == entry.faction)
                    return true;
            for (unsigned int i : friendFaction)
                if (i == entry.faction)
                    return false;
        }
        return (hostileMask & entry.ourMask) != 0;
    }
    [[nodiscard]] bool IsHostileToPlayers() const { return (hostileMask & FACTION_MASK_PLAYER) != 0; }
    [[nodiscard]] bool IsNeutralToAll() const
    {
        for (unsigned int i : enemyFaction)
            if (i != 0)
                return false;
        return hostileMask == 0 && friendlyMask == 0;
    }
    [[nodiscard]] bool IsContestedGuardFaction() const { return (factionFlags & FACTION_TEMPLATE_FLAG_ATTACK_PVP_ACTIVE_PLAYERS) != 0; }
};

struct GameObjectArtKitEntry
{
    uint32 ID;                                              // 0
    //char* TextureVariation[3]                             // 1-3 m_textureVariations[3]
    //char* AttachModel[4]                                  // 4-8 m_attachModels[4]
};

struct GameObjectDisplayInfoEntry
{
    uint32      Displayid;                                  // 0        m_ID
    char const* filename;                                   // 1
    //uint32  sound[10];                                    //2-11
    float   minX;
    float   minY;
    float   minZ;
    float   maxX;
    float   maxY;
    float   maxZ;
    //uint32  transport;                                    //18
};

struct GemPropertiesEntry
{
    uint32      ID;
    uint32      spellitemenchantement;
    uint32      color;
};

struct GlyphPropertiesEntry
{
    uint32  Id;
    uint32  SpellId;
    uint32  TypeFlags;
    //uint32  spellIconID;                                       // GlyphIconId (SpellIcon.dbc)
};

struct GlyphSlotEntry
{
    uint32  Id;
    uint32  TypeFlags;
    uint32  Order;
};

// All Gt* DBC store data for 100 levels, some by 100 per class/race
#define GT_MAX_LEVEL    100

// gtOCTClassCombatRatingScalar.dbc stores data for 32 ratings, look at MAX_COMBAT_RATING for real used amount
#define GT_MAX_RATING   32

struct GtBarberShopCostBaseEntry
{
    float   cost;
};

struct GtCombatRatingsEntry
{
    float    ratio;
};

struct GtChanceToMeleeCritBaseEntry
{
    float    base;
};

struct GtChanceToMeleeCritEntry
{
    float    ratio;
};

struct GtChanceToSpellCritBaseEntry
{
    float    base;
};

struct GtNPCManaCostScalerEntry
{
    float    ratio;
};

struct GtChanceToSpellCritEntry
{
    float    ratio;
};

struct GtOCTClassCombatRatingScalarEntry
{
    float    ratio;
};

struct GtOCTRegenHPEntry
{
    float    ratio;
};

//struct GtOCTRegenMPEntry
//{
//    float    ratio;
//};

struct GtRegenHPPerSptEntry
{
    float    ratio;
};

struct GtRegenMPPerSptEntry
{
    float    ratio;
};

/* no used
struct HolidayDescriptionsEntry
{
    uint32 ID;                                              // 0, this is NOT holiday id
    //char const*     name[16]                              // 1-16 m_name_lang
                                                            // 17 name flags
};
*/

/* no used
struct HolidayNamesEntry
{
    uint32 ID;                                              // 0, this is NOT holiday id
    //char const*     name[16]                              // 1-16 m_name_lang
    // 17 name flags
};
*/

#define MAX_HOLIDAY_DURATIONS 10
#define MAX_HOLIDAY_DATES 26
#define MAX_HOLIDAY_FLAGS 10

struct HolidaysEntry
{
    uint32 Id;                                              // 0        m_ID
    uint32 Duration[MAX_HOLIDAY_DURATIONS];                 // 1-10     m_duration
    uint32 Date[MAX_HOLIDAY_DATES];                         // 11-36    m_date (dates in unix time starting at January, 1, 2000)
    uint32 Region;                                          // 37       m_region (wow region)
    uint32 Looping;                                         // 38       m_looping
    uint32 CalendarFlags[MAX_HOLIDAY_FLAGS];                // 39-48    m_calendarFlags
    //uint32 holidayNameId;                                 // 49       m_holidayNameID (HolidayNames.dbc)
    //uint32 holidayDescriptionId;                          // 50       m_holidayDescriptionID (HolidayDescriptions.dbc)
    char const* TextureFilename;                            // 51       m_textureFilename
    uint32 Priority;                                        // 52       m_priority
    int32 CalendarFilterType;                               // 53       m_calendarFilterType (-1 = Fishing Contest, 0 = Unk, 1 = Darkmoon Festival, 2 = Yearly holiday)
    //uint32 flags;                                         // 54       m_flags (0 = Darkmoon Faire, Fishing Contest and Wotlk Launch, rest is 1)
};

struct ItemEntry
{
    uint32 ID;                                               // 0
    uint32 ClassID;                                          // 1
    uint32 SubclassID;                                       // 2
    int32 SoundOverrideSubclassID;                           // 3
    int32 Material;                                          // 4
    uint32 DisplayInfoID;                                    // 5
    uint32 InventoryType;                                    // 6
    uint32 SheatheType;                                      // 7
};

struct ItemBagFamilyEntry
{
    uint32   ID;                                            // 0
    //char const*     name[16]                              // 1-16     m_name_lang
    //                                                      // 17       name flags
};

struct ItemDisplayInfoEntry
{
    uint32      ID;                                         // 0        m_ID
    // 1        m_modelName[2]
    // 2        m_modelTexture[2]
    char const*       inventoryIcon;                        // 3        m_inventoryIcon
    // 4        m_geosetGroup[3]
    // 5        m_flags
    // 6        m_spellVisualID
    // 7        m_groupSoundIndex
    // 8        m_helmetGeosetVis[2]
    // 9        m_texture[2]
    // 10       m_itemVisual[8]
    // 11       m_particleColorID
};

//struct ItemCondExtCostsEntry
//{
//    uint32      ID;
//    uint32      condExtendedCost;                         // ItemTemplate::CondExtendedCost
//    uint32      itemextendedcostentry;                    // ItemTemplate::ExtendedCost
//    uint32      arenaseason;                              // arena season number(1-4)
//};

#define MAX_ITEM_EXTENDED_COST_REQUIREMENTS 5

struct ItemExtendedCostEntry
{
    uint32      ID;                                                 // 0 extended-cost entry id
    uint32      reqhonorpoints;                                     // 1 required honor points
    uint32      reqarenapoints;                                     // 2 required arena points
    uint32      reqarenaslot;                                       // 3 arena slot restrctions (min slot value)
    uint32      reqitem[MAX_ITEM_EXTENDED_COST_REQUIREMENTS];       // 4-8 required item id
    uint32      reqitemcount[MAX_ITEM_EXTENDED_COST_REQUIREMENTS];  // 9-14 required count of 1st item
    uint32      reqpersonalarenarating;                             // 15 required personal arena rating};
};

struct ItemLimitCategoryEntry
{
    uint32      ID;                                         // 0 Id
    //char const*     name[16]                              // 1-16     m_name_lang
    // 17 name flags
    uint32      maxCount;                                   // 18, max allowed equipped as item or in gem slot
    uint32      mode;                                       // 19, 0 = have, 1 = equip (enum ItemLimitCategoryMode)
};

#define MAX_ITEM_ENCHANTMENT_EFFECTS 5

struct ItemRandomPropertiesEntry
{
    uint32 ID;                                                          // 0
    //char const* InternalName;                                         // 1
    std::array<uint32, MAX_ITEM_ENCHANTMENT_EFFECTS> Enchantment;       // 2-4
    //std::array<uint32, 2> UnusedEnchantment;                          // 5-6
    std::array<char const*, 16> Name;                                   // 7-22
    //uint32 Name_lang_mask;                                            // 23
};

struct ItemRandomSuffixEntry
{
    uint32 ID;                                                          // 0
    std::array<char const*, 16> Name;                                   // 1-16
    //uint32 Name_lang_mask;                                            // 17
    //char const* InternalName;                                         // 18
    std::array<uint32, MAX_ITEM_ENCHANTMENT_EFFECTS> Enchantment;       // 19-21
    //std::array<uint32, 2> UnusedEnchantment;                          // 22-23
    std::array<uint32, MAX_ITEM_ENCHANTMENT_EFFECTS> AllocationPct;     // 24-26
    //std::array<uint32, 2> UnusedAllocationPct;                        // 27-28
};

#define MAX_ITEM_SET_ITEMS 10
#define MAX_ITEM_SET_SPELLS 8

struct ItemSetEntry
{
    //uint32    id                                          // 0        m_ID
    char const*     name[16];                               // 1-16     m_name_lang
    // 17 string flags, unused
    uint32    itemId[MAX_ITEM_SET_ITEMS];                   // 18-27    m_itemID
    //uint32    itemID[7];                                  // 28-34
    uint32    spells[MAX_ITEM_SET_SPELLS];                  // 35-42    m_setSpellID
    uint32    items_to_triggerspell[MAX_ITEM_SET_SPELLS];   // 43-50    m_setThreshold
    uint32    required_skill_id;                            // 51       m_requiredSkill
    uint32    required_skill_value;                         // 52       m_requiredSkillRank
};

struct LFGDungeonEntry
{
    uint32 ID;                                              // 0
    char const* Name[16];                                   // 1-16
    //uint32 Name_lang_mask;                                // 17
    uint32 MinLevel;                                        // 18
    uint32 MaxLevel;                                        // 19
    uint32 TargetLevel;                                     // 20
    uint32 TargetLevelMin;                                  // 21
    uint32 TargetLevelMax;                                  // 22
    uint32 MapID;                                           // 23
    uint32 Difficulty;                                      // 24
    uint32 Flags;                                           // 25
    uint32 TypeID;                                          // 26
    //int32 Faction;                                        // 27
    //char const* TextureFilename;                          // 28
    uint32 ExpansionLevel;                                  // 29
    //uint32 OrderIndex;                                    // 30
    uint32 GroupID;                                         // 31
    //char const* Description[16];                          // 32-47
    //uint32 Description_lang_mask;                         // 48

    // Helpers
    [[nodiscard]] uint32 Entry() const { return ID + (TypeID << 24); }
};

struct LightEntry
{
    uint32 Id;
    uint32 MapId;
    float X;
    float Y;
    float Z;
    //float FalloffStart;
    //float FalloffEnd;
    //uint32 LightParamsID[8]       // Reference to LightParams.dbc
};

struct LiquidTypeEntry
{
    uint32 Id;
    //char const*  Name;
    //uint32 Flags;
    uint32 Type;
    //uint32 SoundId;
    uint32 SpellId;
    //float MaxDarkenDepth;
    //float FogDarkenIntensity;
    //float AmbDarkenIntensity;
    //float DirDarkenIntensity;
    //uint32 LightID;
    //float ParticleScale;
    //uint32 ParticleMovement;
    //uint32 ParticleTexSlots;
    //uint32 LiquidMaterialID;
    //char const* Texture[6];
    //uint32 Color[2];
    //float Unk1[18];
    //uint32 Unk2[4];
};

#define MAX_LOCK_CASE 8

struct LockEntry
{
    uint32      ID;                                         // 0        m_ID
    uint32      Type[MAX_LOCK_CASE];                        // 1-8      m_Type
    uint32      Index[MAX_LOCK_CASE];                       // 9-16     m_Index
    uint32      Skill[MAX_LOCK_CASE];                       // 17-24    m_Skill
    //uint32      Action[MAX_LOCK_CASE];                    // 25-32    m_Action
};

struct MailTemplateEntry
{
    uint32      ID;                                         // 0
    //char const*       subject[16];                        // 1-16
    // 17 name flags, unused
    char const*       content[16];                          // 18-33
};

struct MapEntry
{
    uint32  MapID;                                          // 0
    //char const*       internalname;                       // 1 unused
    uint32  map_type;                                       // 2
    uint32  Flags;                                          // 3
    // 4 0 or 1 for battlegrounds (not arenas)
    char const*   name[16];                                 // 5-20
    // 21 name flags, unused
    uint32  linked_zone;                                    // 22 common zone for instance and continent map
    //char const*     hordeIntro[16];                       // 23-38 text for PvP Zones
    // 39 intro text flags
    //char const*     allianceIntro[16];                    // 40-55 text for PvP Zones
    // 56 intro text flags
    uint32  multimap_id;                                    // 57
    //float BattlefieldMapIconScale;                        // 58
    int32   entrance_map;                                   // 59 map_id of entrance map
    float   entrance_x;                                     // 60 entrance x coordinate (if exist single entry)
    float   entrance_y;                                     // 61 entrance y coordinate (if exist single entry)
    //uint32 TimeOfDayOverride;                             // 62 -1, 0 and 720
    uint32  expansionID;                                    // 63 (0: Vanilla, 1:TBC, 2:WotLK)
    //uint32  raidOffset;                                   // 64 some kind of time?
    uint32  maxPlayers;                                     // 65 max players, fallback if not present in MapDifficulty.dbc

    // Helpers
    [[nodiscard]] uint32 Expansion() const { return expansionID; }

    [[nodiscard]] bool IsDungeon() const { return map_type == MAP_INSTANCE || map_type == MAP_RAID; }
    [[nodiscard]] bool IsNonRaidDungeon() const { return map_type == MAP_INSTANCE; }
    [[nodiscard]] bool Instanceable() const { return map_type == MAP_INSTANCE || map_type == MAP_RAID || map_type == MAP_BATTLEGROUND || map_type == MAP_ARENA; }
    [[nodiscard]] bool IsRaid() const { return map_type == MAP_RAID; }
    [[nodiscard]] bool IsBattleground() const { return map_type == MAP_BATTLEGROUND; }
    [[nodiscard]] bool IsBattleArena() const { return map_type == MAP_ARENA; }
    [[nodiscard]] bool IsBattlegroundOrArena() const { return map_type == MAP_BATTLEGROUND || map_type == MAP_ARENA; }
    [[nodiscard]] bool IsWorldMap() const { return map_type == MAP_COMMON; }

    bool GetEntrancePos(int32& mapid, float& x, float& y) const
    {
        if (entrance_map < 0)
            return false;
        mapid = entrance_map;
        x = entrance_x;
        y = entrance_y;
        return true;
    }

    [[nodiscard]] bool IsContinent() const
    {
        return MapID == 0 || MapID == 1 || MapID == 530 || MapID == 571;
    }

    [[nodiscard]] bool IsDynamicDifficultyMap() const { return Flags & MAP_FLAG_DYNAMIC_DIFFICULTY; }
};

struct MapDifficultyEntry
{
    //uint32      Id;                                       // 0
    uint32      MapId;                                      // 1
    uint32      Difficulty;                                 // 2 (for arenas: arena slot)
    char const*       areaTriggerText;                      // 3-18 text showed when transfer to map failed (missing requirements)
    //uint32      textFlags;                                // 19
    uint32      resetTime;                                  // 20
    uint32      maxPlayers;                                 // 21
    //char const*       difficultyString;                         // 22
};

struct MovieEntry
{
    uint32        Id;                                       // 0 index
    //char const* filename;                                 // 1
    //uint32      volume                                    // 2 always 100
};

struct NamesReservedEntry
{
    //uint32         ID;                                    // 0
    char const*      Pattern;                               // 1
    //uint32         Language;                              // 2
};

struct NamesProfanityEntry
{
    //uint32         ID;                                    // 0
    char const*      Pattern;                               // 1
    //uint32         Language;                              // 2
};

#define MAX_OVERRIDE_SPELL 10

struct OverrideSpellDataEntry
{
    uint32      id;                                         // 0
    uint32      spellId[MAX_OVERRIDE_SPELL];                // 1-10
    //uint32    flags;                                      // 11
};

struct PowerDisplayEntry
{
    uint32 Id;                                              // 0
    uint32 PowerType;                                       // 1
    //char const*  Name;                                    // 2
    //uint32 R;                                             // 3
    //uint32 G;                                             // 4
    //uint32 B;                                             // 5
};

struct PvPDifficultyEntry
{
    //uint32      id;                                       // 0        m_ID
    uint32      mapId;                                      // 1
    uint32      bracketId;                                  // 2
    uint32      minLevel;                                   // 3
    uint32      maxLevel;                                   // 4
    uint32      difficulty;                                 // 5

    // helpers
    PvPDifficultyEntry(uint32 mapId, uint32 bracketId, uint32 minLevel, uint32 maxLevel, uint32 difficulty) : mapId(mapId), bracketId(bracketId), minLevel(minLevel), maxLevel(maxLevel), difficulty(difficulty) {}
    [[nodiscard]] BattlegroundBracketId GetBracketId() const { return BattlegroundBracketId(bracketId); }
};

struct QuestSortEntry
{
    uint32      id;                                         // 0        m_ID
    //char const*       name[16];                                 // 1-16     m_SortName_lang
    // 17 name flags
};

struct QuestXPEntry
{
    uint32      id;
    uint32      Exp[10];
};

struct QuestFactionRewEntry
{
    uint32      id;
    int32       QuestRewFactionValue[10];
};

struct RandomPropertiesPointsEntry
{
    //uint32  Id;                                           // 0 hidden key
    uint32    itemLevel;                                    // 1
    uint32    EpicPropertiesPoints[5];                      // 2-6
    uint32    RarePropertiesPoints[5];                      // 7-11
    uint32    UncommonPropertiesPoints[5];                  // 12-16
};

struct ScalingStatDistributionEntry
{
    uint32  Id;                                             // 0
    int32   StatMod[10];                                    // 1-10
    uint32  Modifier[10];                                   // 11-20
    uint32  MaxLevel;                                       // 21
};

struct ScalingStatValuesEntry
{
    uint32  Id;                                             // 0
    uint32  Level;                                          // 1
    uint32  ssdMultiplier[4];                               // 2-5 Multiplier for ScalingStatDistribution
    uint32  armorMod[4];                                    // 6-9 Armor for level
    uint32  dpsMod[6];                                      // 10-15 DPS mod for level
    uint32  spellPower;                                     // 16 spell power for level
    uint32  ssdMultiplier2;                                 // 17 there's data from 3.1 dbc ssdMultiplier[3]
    uint32  ssdMultiplier3;                                 // 18 3.3
    uint32  armorMod2[5];                                   // 19-23 Armor for level

    [[nodiscard]] uint32 getssdMultiplier(uint32 mask) const
    {
        if (mask & 0x4001F)
        {
            if (mask & 0x00000001) return ssdMultiplier[0]; // Shoulder
            if (mask & 0x00000002) return ssdMultiplier[1]; // Trinket
            if (mask & 0x00000004) return ssdMultiplier[2]; // Weapon1H
            if (mask & 0x00000008) return ssdMultiplier2;
            if (mask & 0x00000010) return ssdMultiplier[3]; // Ranged
            if (mask & 0x00040000) return ssdMultiplier3;
        }
        return 0;
    }

    [[nodiscard]] uint32 getArmorMod(uint32 mask) const
    {
        if (mask & 0x00F801E0)
        {
            if (mask & 0x00000020) return armorMod[0];      // Cloth shoulder
            if (mask & 0x00000040) return armorMod[1];      // Leather shoulder
            if (mask & 0x00000080) return armorMod[2];      // Mail shoulder
            if (mask & 0x00000100) return armorMod[3];      // Plate shoulder

            if (mask & 0x00080000) return armorMod2[0];      // cloak
            if (mask & 0x00100000) return armorMod2[1];      // cloth
            if (mask & 0x00200000) return armorMod2[2];      // leather
            if (mask & 0x00400000) return armorMod2[3];      // mail
            if (mask & 0x00800000) return armorMod2[4];      // plate
        }
        return 0;
    }

    [[nodiscard]] uint32 getDPSMod(uint32 mask) const
    {
        if (mask & 0x7E00)
        {
            if (mask & 0x00000200) return dpsMod[0];        // Weapon 1h
            if (mask & 0x00000400) return dpsMod[1];        // Weapon 2h
            if (mask & 0x00000800) return dpsMod[2];        // Caster dps 1h
            if (mask & 0x00001000) return dpsMod[3];        // Caster dps 2h
            if (mask & 0x00002000) return dpsMod[4];        // Ranged
            if (mask & 0x00004000) return dpsMod[5];        // Wand
        }
        return 0;
    }

    bool IsTwoHand(uint32 mask) const
    {
        if (mask & 0x7E00)
        {
            if (mask & 0x00000400) return true;
            if (mask & 0x00001000) return true;
        }
        return false;
    }

    [[nodiscard]] uint32 getSpellBonus(uint32 mask) const
    {
        if (mask & 0x00008000) return spellPower;
        return 0;
    }

    [[nodiscard]] uint32 getFeralBonus(uint32 mask) const                 // removed in 3.2.x?
    {
        if (mask & 0x00010000) return 0;                    // not used?
        return 0;
    }
};

//struct SkillLineCategoryEntry{
//    uint32    id;                                         // 0      m_ID
//    char const*     name[16];                             // 1-17   m_name_lang
//                                                          // 18 string flag
//    uint32    displayOrder;                               // 19     m_sortIndex
//};

struct SkillRaceClassInfoEntry
{
    //uint32 ID;                                            // 0
    uint32 SkillID;                                         // 1
    uint32 RaceMask;                                        // 2
    uint32 ClassMask;                                       // 3
    uint32 Flags;                                           // 4
    //uint32 MinLevel;                                      // 5
    uint32 SkillTierID;                                     // 6
    //uint32 SkillCostIndex;                                // 7
};

#define MAX_SKILL_STEP 16

struct SkillLineEntry
{
    uint32    id;                                           // 0        m_ID
    int32     categoryId;                                   // 1        m_categoryID
    //uint32    skillCostID;                                // 2        m_skillCostsID
    char const*     name[16];                               // 3-18     m_displayName_lang
    // 19 string flags
    //char const*     description[16];                      // 20-35    m_description_lang
    // 36 string flags
    uint32    spellIcon;                                    // 37       m_spellIconID
    //char const*     alternateVerb[16];                    // 38-53    m_alternateVerb_lang
    // 54 string flags
    uint32    canLink;                                      // 55       m_canLink (prof. with recipes
};

struct SkillLineAbilityEntry
{
    uint32 ID;                                              // 0
    uint32 SkillLine;                                       // 1
    uint32 Spell;                                           // 2
    uint32 RaceMask;                                        // 3
    uint32 ClassMask;                                       // 4
    //uint32 ExcludeRace;                                   // 5
    //uint32 ExcludeClass;                                  // 6
    uint32 MinSkillLineRank;                                // 7
    uint32 SupercededBySpell;                               // 8
    uint32 AcquireMethod;                                   // 9
    uint32 TrivialSkillLineRankHigh;                        // 10
    uint32 TrivialSkillLineRankLow;                         // 11
    //uint32 CharacterPoints[2];                            // 12-13
};

struct SkillTiersEntry
{
    uint32 ID;                                              // 0
    //uint32 Cost[MAX_SKILL_STEP];                          // 1-16
    uint32 Value[MAX_SKILL_STEP];                           // 17-32
};

struct SoundEntriesEntry
{
    uint32    Id;                                           // 0        m_ID
    //uint32    Type;                                       // 1        m_soundType
    //char const*     InternalName;                         // 2        m_name
    //char const*     FileName[10];                         // 3-12     m_File[10]
    //uint32    Freq[10];                                   // 13-22    m_Freq[10]
    //char const*     Path;                                 // 23       m_DirectoryBase
    // 24       m_volumeFloat
    // 25       m_flags
    // 26       m_minDistance
    // 27       m_distanceCutoff
    // 28       m_EAXDef
    // 29       new in 3.1
};

#define MAX_SPELL_EFFECTS 3
#define MAX_EFFECT_MASK 7
#define MAX_SPELL_REAGENTS 8

struct SpellEntry
{
    uint32    Id;                                                   // 0        m_ID
    uint32    Category;                                             // 1        m_category
    uint32    Dispel;                                               // 2        m_dispelType
    uint32    Mechanic;                                             // 3        m_mechanic
    uint32    Attributes;                                           // 4        m_attributes
    uint32    AttributesEx;                                         // 5        m_attributesEx
    uint32    AttributesEx2;                                        // 6        m_attributesExB
    uint32    AttributesEx3;                                        // 7        m_attributesExC
    uint32    AttributesEx4;                                        // 8        m_attributesExD
    uint32    AttributesEx5;                                        // 9        m_attributesExE
    uint32    AttributesEx6;                                        // 10       m_attributesExF
    uint32    AttributesEx7;                                        // 11       m_attributesExG
    uint32    Stances;                                              // 12       m_shapeshiftMask
    uint32    StancesNot;                                           // 14       m_shapeshiftExclude
    uint32    Targets;                                              // 16       m_targets
    uint32    TargetCreatureType;                                   // 17       m_targetCreatureType
    uint32    RequiresSpellFocus;                                   // 18       m_requiresSpellFocus
    uint32    FacingCasterFlags;                                    // 19       m_facingCasterFlags
    uint32    CasterAuraState;                                      // 20       m_casterAuraState
    uint32    TargetAuraState;                                      // 21       m_targetAuraState
    uint32    CasterAuraStateNot;                                   // 22       m_excludeCasterAuraState
    uint32    TargetAuraStateNot;                                   // 23       m_excludeTargetAuraState
    uint32    CasterAuraSpell;                                      // 24       m_casterAuraSpell
    uint32    TargetAuraSpell;                                      // 25       m_targetAuraSpell
    uint32    ExcludeCasterAuraSpell;                               // 26       m_excludeCasterAuraSpell
    uint32    ExcludeTargetAuraSpell;                               // 27       m_excludeTargetAuraSpell
    uint32    CastingTimeIndex;                                     // 28       m_castingTimeIndex
    uint32    RecoveryTime;                                         // 29       m_recoveryTime
    uint32    CategoryRecoveryTime;                                 // 30       m_categoryRecoveryTime
    uint32    InterruptFlags;                                       // 31       m_interruptFlags
    uint32    AuraInterruptFlags;                                   // 32       m_auraInterruptFlags
    uint32    ChannelInterruptFlags;                                // 33       m_channelInterruptFlags
    uint32    ProcFlags;                                            // 34       m_procTypeMask
    uint32    ProcChance;                                           // 35       m_procChance
    uint32    ProcCharges;                                          // 36       m_procCharges
    uint32    MaxLevel;                                             // 37       m_maxLevel
    uint32    BaseLevel;                                            // 38       m_baseLevel
    uint32    SpellLevel;                                           // 39       m_spellLevel
    uint32    DurationIndex;                                        // 40       m_durationIndex
    uint32    PowerType;                                            // 41       m_powerType
    uint32    ManaCost;                                             // 42       m_manaCost
    uint32    ManaCostPerlevel;                                     // 43       m_manaCostPerLevel
    uint32    ManaPerSecond;                                        // 44       m_manaPerSecond
    uint32    ManaPerSecondPerLevel;                                // 45       m_manaPerSecondPerLeve
    uint32    RangeIndex;                                           // 46       m_rangeIndex
    float     Speed;                                                // 47       m_speed
    //uint32    ModalNextSpell;                                     // 48       m_modalNextSpell not used
    uint32    StackAmount;                                          // 49       m_cumulativeAura
    std::array<uint32, 2> Totem;                                    // 50-51    m_totem
    std::array<int32, MAX_SPELL_REAGENTS> Reagent;                  // 52-59    m_reagent
    std::array<uint32, MAX_SPELL_REAGENTS> ReagentCount;            // 60-67    m_reagentCount
    int32     EquippedItemClass;                                    // 68       m_equippedItemClass (value)
    int32     EquippedItemSubClassMask;                             // 69       m_equippedItemSubclass (mask)
    int32     EquippedItemInventoryTypeMask;                        // 70       m_equippedItemInvTypes (mask)
    std::array<uint32, MAX_SPELL_EFFECTS> Effect;                   // 71-73    m_effect
    std::array<int32, MAX_SPELL_EFFECTS> EffectDieSides;            // 74-76    m_effectDieSides
    std::array<float, MAX_SPELL_EFFECTS> EffectRealPointsPerLevel;  // 77-79    m_effectRealPointsPerLevel
    std::array<int32, MAX_SPELL_EFFECTS> EffectBasePoints;          // 80-82    m_effectBasePoints (must not be used in spell/auras explicitly, must be used cached Spell::m_currentBasePoints)
    std::array<uint32, MAX_SPELL_EFFECTS> EffectMechanic;           // 83-85    m_effectMechanic
    std::array<uint32, MAX_SPELL_EFFECTS> EffectImplicitTargetA;    // 86-88    m_implicitTargetA
    std::array<uint32, MAX_SPELL_EFFECTS> EffectImplicitTargetB;    // 89-91    m_implicitTargetB
    std::array<uint32, MAX_SPELL_EFFECTS> EffectRadiusIndex;        // 92-94    m_effectRadiusIndex - spellradius.dbc
    std::array<uint32, MAX_SPELL_EFFECTS> EffectApplyAuraName;      // 95-97    m_effectAura
    std::array<uint32, MAX_SPELL_EFFECTS> EffectAmplitude;          // 98-100   m_effectAuraPeriod
    std::array<float, MAX_SPELL_EFFECTS> EffectValueMultiplier;     // 101-103
    std::array<uint32, MAX_SPELL_EFFECTS> EffectChainTarget;        // 104-106  m_effectChainTargets
    std::array<uint32, MAX_SPELL_EFFECTS> EffectItemType;           // 107-109  m_effectItemType
    std::array<int32, MAX_SPELL_EFFECTS> EffectMiscValue;           // 110-112  m_effectMiscValue
    std::array<int32, MAX_SPELL_EFFECTS> EffectMiscValueB;          // 113-115  m_effectMiscValueB
    std::array<uint32, MAX_SPELL_EFFECTS> EffectTriggerSpell;       // 116-118  m_effectTriggerSpell
    std::array<float, MAX_SPELL_EFFECTS> EffectPointsPerComboPoint; // 119-121  m_effectPointsPerCombo
    std::array<flag96, MAX_SPELL_EFFECTS> EffectSpellClassMask;     // 122-130
    std::array<uint32, 2> SpellVisual;                              // 131-132  m_spellVisualID
    uint32    SpellIconID;                                          // 133      m_spellIconID
    uint32    ActiveIconID;                                         // 134      m_activeIconID
    uint32    SpellPriority;                                        // 135 not used
    std::array<char const*, 16> SpellName;                          // 136-151  m_name_lang
    //uint32    SpellNameFlag;                                      // 152 not used
    std::array<char const*, 16> Rank;                               // 153-168  m_nameSubtext_lang
    //uint32    RankFlags;                                          // 169 not used
    //char const*     Description[16];                              // 170-185  m_description_lang not used
    //uint32    DescriptionFlags;                                   // 186 not used
    //char const*     ToolTip[16];                                  // 187-202  m_auraDescription_lang not used
    //uint32    ToolTipFlags;                                       // 203 not used
    uint32    ManaCostPercentage;                                   // 204      m_manaCostPct
    uint32    StartRecoveryCategory;                                // 205      m_startRecoveryCategory
    uint32    StartRecoveryTime;                                    // 206      m_startRecoveryTime
    uint32    MaxTargetLevel;                                       // 207      m_maxTargetLevel
    uint32    SpellFamilyName;                                      // 208      m_spellClassSet
    flag96    SpellFamilyFlags;                                     // 209-211
    uint32    MaxAffectedTargets;                                   // 212      m_maxTargets
    uint32    DmgClass;                                             // 213      m_defenseType
    uint32    PreventionType;                                       // 214      m_preventionType
    //uint32    StanceBarOrder;                                     // 215      m_stanceBarOrder not used
    std::array<float, MAX_SPELL_EFFECTS> EffectDamageMultiplier;    // 216-218  m_effectChainAmplitude
    //uint32    MinFactionId;                                       // 219      m_minFactionID not used
    //uint32    MinReputation;                                      // 220      m_minReputation not used
    //uint32    RequiredAuraVision;                                 // 221      m_requiredAuraVision not used
    std::array<uint32, 2> TotemCategory;                            // 222-223  m_requiredTotemCategoryID
    int32     AreaGroupId;                                          // 224      m_requiredAreaGroupId
    uint32    SchoolMask;                                           // 225      m_schoolMask
    uint32    RuneCostID;                                           // 226      m_runeCostID
    //uint32    SpellMissileID;                                     // 227      m_spellMissileID not used
    //uint32  PowerDisplayId;                                       // 228      PowerDisplay.dbc, new in 3.1
    std::array<float, MAX_SPELL_EFFECTS> EffectBonusMultiplier;     // 229-231  3.2.0
    //uint32  SpellDescriptionVariableID;                           // 232      3.2.0
    //uint32  SpellDifficultyId;                                    // 233      3.3.0
};

typedef std::set<std::pair<bool, uint32>> SpellCategorySet;
typedef std::unordered_map<uint32, SpellCategorySet> SpellCategoryStore;
typedef std::set<uint32> PetFamilySpellsSet;
typedef std::map<uint32, PetFamilySpellsSet > PetFamilySpellsStore;

struct SpellCastTimesEntry
{
    uint32    ID;                                           // 0
    int32     CastTime;                                     // 1
    //float     CastTimePerLevel;                           // 2 unsure / per skill?
    //int32     MinCastTime;                                // 3 unsure
};

struct SpellCategoryEntry
{
    uint32 Id;
    uint32 Flags;
};

struct SpellDifficultyEntry
{
    uint32     ID;                                          // 0
    int32      SpellID[MAX_DIFFICULTY];                     // 1-4 instance modes: 10N, 25N, 10H, 25H or Normal/Heroic if only 1-2 is set, if 3-4 is 0 then Mode-2
};

struct SpellFocusObjectEntry
{
    uint32    ID;                                           // 0
    //char const*     Name[16];                             // 1-15 unused
    // 16 string flags, unused
};

struct SpellRadiusEntry
{
    uint32    ID;
    float     RadiusMin;
    float     RadiusPerLevel;
    float     RadiusMax;
};

struct SpellRangeEntry
{
    uint32 ID;          // 0
    float  RangeMin[2]; // 1-2 [0] Hostile [1] Friendly
    float  RangeMax[2]; // 3-4 [0] Hostile [1] Friendly
    uint32 Flags;       // 5
    // char const* DisplayName[16];                          // 6-21
    // uint32 DisplayName_lang_mask;                         // 22
    // char const* DisplayNameShort[16];                     // 23-38
    // uint32 DisplayNameShort_lang_mask;                    // 39
};

struct SpellRuneCostEntry
{
    uint32  ID;                                             // 0
    uint32  RuneCost[3];                                    // 1-3 (0=blood, 1=frost, 2=unholy)
    uint32  runePowerGain;                                  // 4

    [[nodiscard]] bool NoRuneCost() const { return RuneCost[0] == 0 && RuneCost[1] == 0 && RuneCost[2] == 0; }
    [[nodiscard]] bool NoRunicPowerGain() const { return runePowerGain == 0; }
};

#define MAX_SHAPESHIFT_SPELLS 8

struct SpellShapeshiftFormEntry
{
    uint32 ID;                                              // 0
    //uint32 bonusActionBar;                                // 1 unused
    //char const*  Name[16];                                // 2-17 unused
    //uint32 NameFlags;                                     // 18 unused
    uint32 flags1;                                          // 19
    int32  creatureType;                                    // 20 <= 0 humanoid, other normal creature types
    //uint32 attackIconID;                                  // 21 unused
    uint32 attackSpeed;                                     // 22
    uint32 modelID_A;                                       // 23 alliance modelid
    uint32 modelID_H;                                       // 24 horde modelid (only one form)
    //uint32 creatureDisplayID[2];                          // 25-26 unused
    uint32 stanceSpell[MAX_SHAPESHIFT_SPELLS];              // 27 - 34
};

struct SpellDurationEntry
{
    uint32    ID;
    int32     Duration[3];
};

#define MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS 3

struct SpellItemEnchantmentEntry
{
    uint32      ID;                                             // 0        m_ID
    uint32      charges;                                        // 1        m_charges
    uint32      type[MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS];       // 2-4      m_effect[MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS]
    uint32      amount[MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS];     // 5-7      m_effectPointsMin[MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS]
    //uint32      amount2[MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS]   // 8-10     m_effectPointsMax[MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS]
    uint32      spellid[MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS];    // 11-13    m_effectArg[MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS]
    char const*       description[16];                          // 14-29    m_name_lang[16]
    //uint32      descriptionFlags;                             // 30 name flags
    uint32      aura_id;                                        // 31       m_itemVisual
    uint32      slot;                                           // 32       m_flags
    uint32      GemID;                                          // 33       m_src_itemID
    uint32      EnchantmentCondition;                           // 34       m_condition_id
    uint32      requiredSkill;                                  // 35       m_requiredSkillID
    uint32      requiredSkillValue;                             // 36       m_requiredSkillRank
    uint32      requiredLevel;                                  // 37       m_requiredLevel
};

struct SpellItemEnchantmentConditionEntry
{
    uint32  ID;                                             // 0        m_ID
    uint8   Color[5];                                       // 1-5      m_lt_operandType[5]
    //uint32  LT_Operand[5];                                // 6-10     m_lt_operand[5]
    uint8   Comparator[5];                                  // 11-15    m_operator[5]
    uint8   CompareColor[5];                                // 15-20    m_rt_operandType[5]
    uint32  Value[5];                                       // 21-25    m_rt_operand[5]
    //uint8   Logic[5]                                      // 25-30    m_logic[5]
};

struct SpellVisualEntry
{
    //uint32 Id;
    //uint32 PrecastKit;
    //uint32 CastingKit;
    //uint32 ImpactKit;
    //uint32 StateKit;
    //uint32 StateDoneKit;
    //uint32 ChannelKit;
    uint32 HasMissile;
    int32 MissileModel;
    //uint32 MissilePathType;
    //uint32 MissileDestinationAttachment;
    //uint32 MissileSound;
    //uint32 AnimEventSoundID;
    //uint32 Flags;
    //uint32 CasterImpactKit;
    //uint32 TargetImpactKit;
    //int32 MissileAttachment;
    //uint32 MissileFollowGroundHeight;
    //uint32 MissileFollowGroundDropSpeed;
    //uint32 MissileFollowGroundApprach;
    //uint32 MissileFollowGroundFlags;
    //uint32 MissileMotionId;
    //uint32 MissileTargetingKit;
    //uint32 InstantAreaKit;
    //uint32 ImpactAreaKit;
    //uint32 PersistentAreaKit;
    //DBCPosition3D MissileCastOffset;
    //DBCPosition3D MissileImpactOffset;
};

struct StableSlotPricesEntry
{
    uint32 Slot;
    uint32 Price;
};

struct SummonPropertiesEntry
{
    uint32  Id;                                             // 0
    uint32  Category;                                       // 1, 0 - can't be controlled?, 1 - something guardian?, 2 - pet?, 3 - something controllable?, 4 - taxi/mount?
    uint32  Faction;                                        // 2, 14 rows > 0
    uint32  Type;                                           // 3, see enum
    uint32  Slot;                                           // 4, 0-6
    uint32  Flags;                                          // 5
};

#define MAX_TALENT_RANK 5
#define MAX_PET_TALENT_RANK 3                               // use in calculations, expected <= MAX_TALENT_RANK
#define MAX_TALENT_TABS 3

struct TalentEntry
{
    uint32    TalentID;                                     // 0
    uint32    TalentTab;                                    // 1 index in TalentTab.dbc (TalentTabEntry)
    uint32    Row;                                          // 2
    uint32    Col;                                          // 3
    std::array<uint32, MAX_TALENT_RANK> RankID;             // 4-8
    // uint32 spellRank [4]                                 // 9-12 not used, always 0, maybe not used high ranks
    uint32    DependsOn;                                    // 13 preReqTalent1 index in Talent.dbc (TalentEntry)
    // uint32 preReqTalent[2]                               // 14-15 not used
    uint32    DependsOnRank;                                // 16 preReqRank1
    // uint32 preReqRank[2]                                 // 17-18 not used
    uint32    addToSpellBook;                               // 19  also need disable higest ranks on reset talent tree
    //uint32  requiredSpellID;                              // 20, all 0
    //uint64  categoryMask[2];                              // 21-22 its a 64 bit mask for pet 1<<m_categoryEnumID in CreatureFamily.dbc
};

struct TalentTabEntry
{
    uint32  TalentTabID;                                    // 0
    //char const* name[16];                                 // 1-16, unused
    //uint32  nameFlags;                                    // 17, unused
    //unit32  spellicon;                                    // 18
    // 19 not used
    uint32  ClassMask;                                      // 20
    uint32  petTalentMask;                                  // 21
    uint32  tabpage;                                        // 22
    //char const* internalname;                             // 23
};

struct TaxiNodesEntry
{
    uint32    ID;                                           // 0        m_ID
    uint32    map_id;                                       // 1        m_ContinentID
    float     x;                                            // 2        m_x
    float     y;                                            // 3        m_y
    float     z;                                            // 4        m_z
    char const*     name[16];                               // 5-21     m_Name_lang
    // 22 string flags
    uint32    MountCreatureID[2];                           // 23-24    m_MountCreatureID[2]
};

struct TaxiPathEntry
{
    uint32    ID;                                           // 0        m_ID
    uint32    from;                                         // 1        m_FromTaxiNode
    uint32    to;                                           // 2        m_ToTaxiNode
    uint32    price;                                        // 3        m_Cost
};

struct TaxiPathNodeEntry
{
    // 0        m_ID
    uint32    path;                                         // 1        m_PathID
    uint32    index;                                        // 2        m_NodeIndex
    uint32    mapid;                                        // 3        m_ContinentID
    float     x;                                            // 4        m_LocX
    float     y;                                            // 5        m_LocY
    float     z;                                            // 6        m_LocZ
    uint32    actionFlag;                                   // 7        m_flags
    uint32    delay;                                        // 8        m_delay
    uint32    arrivalEventID;                               // 9        m_arrivalEventID
    uint32    departureEventID;                             // 10       m_departureEventID
};

struct TeamContributionPointsEntry
{
    //uint32    entry;                                      // 0
    float     value;                                        // 1 (???)
};

struct TotemCategoryEntry
{
    uint32    ID;                                           // 0
    //char const*   name[16];                               // 1-16
    // 17 string flags, unused
    uint32    categoryType;                                 // 18 (one for specialization)
    uint32    categoryMask;                                 // 19 (compatibility mask for same type: different for totems, compatible from high to low for rods)
};

struct TransportAnimationEntry
{
    //uint32  Id;
    uint32  TransportEntry;
    uint32  TimeSeg;
    float   X;
    float   Y;
    float   Z;
    //uint32  MovementId;
};

struct TransportRotationEntry
{
    //uint32  Id;
    uint32  TransportEntry;
    uint32  TimeSeg;
    float   X;
    float   Y;
    float   Z;
    float   W;
};

#define MAX_VEHICLE_SEATS 8

struct VehicleEntry
{
    uint32  m_ID;                                           // 0
    uint32  m_flags;                                        // 1
    float   m_turnSpeed;                                    // 2
    float   m_pitchSpeed;                                   // 3
    float   m_pitchMin;                                     // 4
    float   m_pitchMax;                                     // 5
    uint32  m_seatID[MAX_VEHICLE_SEATS];                    // 6-13
    float   m_mouseLookOffsetPitch;                         // 14
    float   m_cameraFadeDistScalarMin;                      // 15
    float   m_cameraFadeDistScalarMax;                      // 16
    float   m_cameraPitchOffset;                            // 17
    //int32     m_powerType[3];                             //       removed in 3.1
    //int32     m_powerToken[3];                            //       removed in 3.1
    float   m_facingLimitRight;                             // 18
    float   m_facingLimitLeft;                              // 19
    float   m_msslTrgtTurnLingering;                        // 20
    float   m_msslTrgtPitchLingering;                       // 21
    float   m_msslTrgtMouseLingering;                       // 22
    float   m_msslTrgtEndOpacity;                           // 23
    float   m_msslTrgtArcSpeed;                             // 24
    float   m_msslTrgtArcRepeat;                            // 25
    float   m_msslTrgtArcWidth;                             // 26
    float   m_msslTrgtImpactRadius[2];                      // 27-28
    char const*   m_msslTrgtArcTexture;                     // 29
    char const*   m_msslTrgtImpactTexture;                  // 30
    char const*   m_msslTrgtImpactModel[2];                 // 31-32
    float   m_cameraYawOffset;                              // 33
    uint32  m_uiLocomotionType;                             // 34
    float   m_msslTrgtImpactTexRadius;                      // 35
    uint32  m_uiSeatIndicatorType;                          // 36
    uint32  m_powerDisplayId;                               // 37, new in 3.1
    // 38, new in 3.1
    // 39, new in 3.1
};

struct VehicleSeatEntry
{
    uint32  m_ID;                                           // 0
    uint32  m_flags;                                        // 1
    int32   m_attachmentID;                                 // 2
    float   m_attachmentOffsetX;                            // 3
    float   m_attachmentOffsetY;                            // 4
    float   m_attachmentOffsetZ;                            // 5
    float   m_enterPreDelay;                                // 6
    float   m_enterSpeed;                                   // 7
    float   m_enterGravity;                                 // 8
    float   m_enterMinDuration;                             // 9
    float   m_enterMaxDuration;                             // 10
    float   m_enterMinArcHeight;                            // 11
    float   m_enterMaxArcHeight;                            // 12
    int32   m_enterAnimStart;                               // 13
    int32   m_enterAnimLoop;                                // 14
    int32   m_rideAnimStart;                                // 15
    int32   m_rideAnimLoop;                                 // 16
    int32   m_rideUpperAnimStart;                           // 17
    int32   m_rideUpperAnimLoop;                            // 18
    float   m_exitPreDelay;                                 // 19
    float   m_exitSpeed;                                    // 20
    float   m_exitGravity;                                  // 21
    float   m_exitMinDuration;                              // 22
    float   m_exitMaxDuration;                              // 23
    float   m_exitMinArcHeight;                             // 24
    float   m_exitMaxArcHeight;                             // 25
    int32   m_exitAnimStart;                                // 26
    int32   m_exitAnimLoop;                                 // 27
    int32   m_exitAnimEnd;                                  // 28
    float   m_passengerYaw;                                 // 29
    float   m_passengerPitch;                               // 30
    float   m_passengerRoll;                                // 31
    int32   m_passengerAttachmentID;                        // 32
    int32   m_vehicleEnterAnim;                             // 33
    int32   m_vehicleExitAnim;                              // 34
    int32   m_vehicleRideAnimLoop;                          // 35
    int32   m_vehicleEnterAnimBone;                         // 36
    int32   m_vehicleExitAnimBone;                          // 37
    int32   m_vehicleRideAnimLoopBone;                      // 38
    float   m_vehicleEnterAnimDelay;                        // 39
    float   m_vehicleExitAnimDelay;                         // 40
    uint32  m_vehicleAbilityDisplay;                        // 41
    uint32  m_enterUISoundID;                               // 42
    uint32  m_exitUISoundID;                                // 43
    int32   m_uiSkin;                                       // 44
    uint32  m_flagsB;                                       // 45
    // 46-57 added in 3.1, floats mostly

    [[nodiscard]] bool CanEnterOrExit() const
    {
        return ((m_flags & VEHICLE_SEAT_FLAG_CAN_ENTER_OR_EXIT) != 0 ||
                //If it has anmation for enter/ride, means it can be entered/exited by logic
                (m_flags & (VEHICLE_SEAT_FLAG_HAS_LOWER_ANIM_FOR_ENTER | VEHICLE_SEAT_FLAG_HAS_LOWER_ANIM_FOR_RIDE)) != 0);
    }
    [[nodiscard]] bool CanSwitchFromSeat() const { return m_flags & VEHICLE_SEAT_FLAG_CAN_SWITCH; }
    [[nodiscard]] bool IsUsableByOverride() const
    {
        return (m_flags & (VEHICLE_SEAT_FLAG_UNCONTROLLED | VEHICLE_SEAT_FLAG_UNK18)
                || (m_flagsB & (VEHICLE_SEAT_FLAG_B_USABLE_FORCED | VEHICLE_SEAT_FLAG_B_USABLE_FORCED_2 |
                                VEHICLE_SEAT_FLAG_B_USABLE_FORCED_3 | VEHICLE_SEAT_FLAG_B_USABLE_FORCED_4)));
    }
    [[nodiscard]] bool IsEjectable() const { return m_flagsB & VEHICLE_SEAT_FLAG_B_EJECTABLE; }
    [[nodiscard]] bool CanControl() const { return (m_flags & VEHICLE_SEAT_FLAG_CAN_CONTROL) != 0; }
};

struct WMOAreaTableEntry
{
    uint32 Id;                                              // 0 index
    int32 rootId;                                           // 1 used in root WMO
    int32 adtId;                                            // 2 used in adt file
    int32 groupId;                                          // 3 used in group WMO
    //uint32 field4;
    //uint32 field5;
    //uint32 field6;
    //uint32 field7;
    //uint32 field8;
    uint32 Flags;                                           // 9 used for indoor/outdoor determination
    uint32 areaId;                                          // 10 link to AreaTableEntry.ID
    //char *Name[16];
    //uint32 nameFlags;
};

struct WorldMapAreaEntry
{
    //uint32  ID;                                           // 0
    uint32  map_id;                                         // 1
    uint32  area_id;                                        // 2 index (continent 0 areas ignored)
    //char const* internal_name                             // 3
    float   y1;                                             // 4
    float   y2;                                             // 5
    float   x1;                                             // 6
    float   x2;                                             // 7
    int32   virtual_map_id;                                 // 8 -1 (map_id have correct map) other: virtual map where zone show (map_id - where zone in fact internally)
    // int32   dungeonMap_id;                               // 9 pointer to DungeonMap.dbc (owerride x1, x2, y1, y2 coordinates)
    // uint32  parentMapID;                                 // 10
};

#define MAX_WORLD_MAP_OVERLAY_AREA_IDX 4

struct WorldMapOverlayEntry
{
    uint32    ID;                                           // 0
    //uint32    worldMapAreaId;                             // 1 idx in WorldMapArea.dbc
    uint32    areatableID[MAX_WORLD_MAP_OVERLAY_AREA_IDX];  // 2-5
    // 6-7 always 0, possible part of areatableID[]
    //char const* internal_name                                   // 8
    // 9-16 some ints
};

/*
struct WorldStateZoneSounds
{
    uint32    ID;                                           // 0
    uint32    WorldStateID;                                 // 1
    uint32    WorldStateValue;                              // 2
    uint32    AreaID;                                       // 3
    uint32    WMOAreaID;                                    // 4
    uint32    zoneIntroMusic;                               // 5
    uint32    zoneMusic;                                    // 6
    uint32    soundAmbience;                                // 7
    uint32    soundProviderPreferences;                     // 8
};
*/

/*
struct WorldStateUI
{
    uint32    ID;                                           // 0
    uint32    mapID;                                        // 1        Can be -1 to show up everywhere.
    uint32    zone;                                         // 2        Can be zero for "everywhere".
    uint32    phaseMask;                                    // 3        Phase this WorldState is avaliable in
    char const*     icon;                                   // 4        The icon that is used in the interface.
    char const*     text;                                   // 5-20     The text displayed in the UI.
    char const*     textLangMask                            // 21
    char const*     tooltip;                                // 22-37    Text shown when hovering mouse on icon
    char const*     tooltipLangMask                         // 38
    uint32    worldStateID;                                 // 39       This is the actual ID used
    uint32    type;                                         // 40       0 = unknown, 1 = unknown, 2 = battleground scores ("Captured flags", ...)
    char const*     dynamicIcon;                            // 41       Only set for warsong-gulch-flags.
    char const*     dynamicTooltip;                         // 42-57    Again, set for the flags. "Flag is picked up".
    char const*     dynamicTooltipLangMask;                 // 58
    uint32    extendedUI;                                   // 59       If set, then its "CAPTUREPOINT". Used for points that need to be tapped over time. (Progress: *%)
    uint32    extendedUIStateVariable;                      // 60       This worldstate tells how far the captureing proceeded. 100: Alliance / left, 0: Horde / right
    uint32    extendedUIStateVariableNeutral                // 61       This state defines the grey part of the bar. In percent of the whole bar.
    uint32    extendedUIStateVariable                       // 62       unused in 3.3.5
};
*/

// GCC have alternative #pragma pack() syntax and old gcc version not support pack(pop), also any gcc version not support it at some platform
#if defined(__GNUC__)
#pragma pack()
#else
#pragma pack(pop)
#endif

// Structures not used for casting to loaded DBC data and not required then packing
struct MapDifficulty
{
    MapDifficulty()  = default;
    MapDifficulty(uint32 _resetTime, uint32 _maxPlayers, bool _hasErrorMessage) : resetTime(_resetTime), maxPlayers(_maxPlayers), hasErrorMessage(_hasErrorMessage) {}

    uint32 resetTime{0};
    uint32 maxPlayers{0};
    bool hasErrorMessage{false};
};

struct TalentSpellPos
{
    TalentSpellPos()  = default;
    TalentSpellPos(uint16 _talent_id, uint8 _rank) : talent_id(_talent_id), rank(_rank) {}

    uint16 talent_id{0};
    uint8  rank{0};
};

typedef std::map<uint32, TalentSpellPos> TalentSpellPosMap;

typedef std::map<uint32, TaxiPathEntry const*> TaxiPathSetForSource;
typedef std::map<uint32, TaxiPathSetForSource> TaxiPathSetBySource;

typedef std::vector<TaxiPathNodeEntry const*> TaxiPathNodeList;
typedef std::vector<TaxiPathNodeList> TaxiPathNodesByPath;

static constexpr size_t TaxiMaskSize = 14;
typedef std::array<uint32, TaxiMaskSize> TaxiMask;

#endif
