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

#ifndef _PLAYER_H
#define _PLAYER_H

#include "ArenaTeam.h"
#include "Battleground.h"
#include "CharacterCache.h"
#include "CinematicMgr.h"
#include "DBCStores.h"
#include "DatabaseEnvFwd.h"
#include "EnumFlag.h"
#include "GroupReference.h"
#include "InstanceSaveMgr.h"
#include "Item.h"
#include "KillRewarder.h"
#include "MapReference.h"
#include "ObjectMgr.h"
#include "Optional.h"
#include "PetDefines.h"
#include "PlayerSettings.h"
#include "PlayerTaxi.h"
#include "QuestDef.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "TradeData.h"
#include "Unit.h"
#include "WorldSession.h"
#include <string>
#include <vector>

struct CreatureTemplate;
struct Mail;
struct TrainerSpell;
struct VendorItem;

class AchievementMgr;
class ReputationMgr;
class Channel;
class CharacterCreateInfo;
class Creature;
class DynamicObject;
class Group;
class Guild;
class OutdoorPvP;
class Pet;
class PlayerMenu;
class PlayerSocial;
class SpellCastTargets;
class UpdateMask;

typedef std::deque<Mail*> PlayerMails;
typedef void(*bgZoneRef)(Battleground*, WorldPacket&);

#define PLAYER_MAX_SKILLS           127
#define PLAYER_MAX_DAILY_QUESTS     25
#define PLAYER_EXPLORED_ZONES_SIZE  128

// corpse reclaim times
#define DEATH_EXPIRE_STEP (5*MINUTE)
#define MAX_DEATH_COUNT 3

#define PLAYER_SKILL_INDEX(x)       (PLAYER_SKILL_INFO_1_1 + ((x)*3))
#define PLAYER_SKILL_VALUE_INDEX(x) (PLAYER_SKILL_INDEX(x)+1)
#define PLAYER_SKILL_BONUS_INDEX(x) (PLAYER_SKILL_INDEX(x)+2)

#define SKILL_VALUE(x)         PAIR32_LOPART(x)
#define SKILL_MAX(x)           PAIR32_HIPART(x)
#define MAKE_SKILL_VALUE(v, m) MAKE_PAIR32(v, m)

#define SKILL_TEMP_BONUS(x)    int16(PAIR32_LOPART(x))
#define SKILL_PERM_BONUS(x)    int16(PAIR32_HIPART(x))
#define MAKE_SKILL_BONUS(t, p) MAKE_PAIR32(t, p)

// Note: SPELLMOD_* values is aura types in fact
enum SpellModType
{
    SPELLMOD_FLAT         = 107,                            // SPELL_AURA_ADD_FLAT_MODIFIER
    SPELLMOD_PCT          = 108                             // SPELL_AURA_ADD_PCT_MODIFIER
};

// 2^n values, Player::m_isunderwater is a bitmask. These are Trinity internal values, they are never send to any client
enum PlayerUnderwaterState
{
    UNDERWATER_NONE                     = 0x00,
    UNDERWATER_INWATER                  = 0x01,             // terrain type is water and player is afflicted by it
    UNDERWATER_INLAVA                   = 0x02,             // terrain type is lava and player is afflicted by it
    UNDERWATER_INSLIME                  = 0x04,             // terrain type is lava and player is afflicted by it
    UNDERWATER_INDARKWATER              = 0x08,             // terrain type is dark water and player is afflicted by it

    UNDERWATER_EXIST_TIMERS             = 0x10
};

enum BuyBankSlotResult
{
    ERR_BANKSLOT_FAILED_TOO_MANY    = 0,
    ERR_BANKSLOT_INSUFFICIENT_FUNDS = 1,
    ERR_BANKSLOT_NOTBANKER          = 2,
    ERR_BANKSLOT_OK                 = 3
};

enum PlayerSpellState
{
    PLAYERSPELL_UNCHANGED = 0,
    PLAYERSPELL_CHANGED   = 1,
    PLAYERSPELL_NEW       = 2,
    PLAYERSPELL_REMOVED   = 3,
    PLAYERSPELL_TEMPORARY = 4
};

struct PlayerSpell
{
    PlayerSpellState State : 7; // UPPER CASE TO CAUSE CONSOLE ERRORS (CHECK EVERY USAGE)!
    bool Active            : 1; // UPPER CASE TO CAUSE CONSOLE ERRORS (CHECK EVERY USAGE)! lower rank of a spell are not useable, but learnt
    uint8 specMask         : 8;
    bool IsInSpec(uint8 spec) { return (specMask & (1 << spec)); }
};

struct PlayerTalent
{
    PlayerSpellState State : 8; // UPPER CASE TO CAUSE CONSOLE ERRORS (CHECK EVERY USAGE)!
    uint8 specMask         : 8;
    uint32 talentID;
    bool inSpellBook;
    bool IsInSpec(uint8 spec) { return (specMask & (1 << spec)); }
};

enum TalentTree // talent tabs
{
    TALENT_TREE_WARRIOR_ARMS = 161,
    TALENT_TREE_WARRIOR_FURY = 164,
    TALENT_TREE_WARRIOR_PROTECTION = 163,
    TALENT_TREE_PALADIN_HOLY = 382,
    TALENT_TREE_PALADIN_PROTECTION = 383,
    TALENT_TREE_PALADIN_RETRIBUTION = 381,
    TALENT_TREE_HUNTER_BEAST_MASTERY = 361,
    TALENT_TREE_HUNTER_MARKSMANSHIP = 363,
    TALENT_TREE_HUNTER_SURVIVAL = 362,
    TALENT_TREE_ROGUE_ASSASSINATION = 182,
    TALENT_TREE_ROGUE_COMBAT = 181,
    TALENT_TREE_ROGUE_SUBTLETY = 183,
    TALENT_TREE_PRIEST_DISCIPLINE = 201,
    TALENT_TREE_PRIEST_HOLY = 202,
    TALENT_TREE_PRIEST_SHADOW = 203,
    TALENT_TREE_DEATH_KNIGHT_BLOOD = 398,
    TALENT_TREE_DEATH_KNIGHT_FROST = 399,
    TALENT_TREE_DEATH_KNIGHT_UNHOLY = 400,
    TALENT_TREE_SHAMAN_ELEMENTAL = 261,
    TALENT_TREE_SHAMAN_ENHANCEMENT = 263,
    TALENT_TREE_SHAMAN_RESTORATION = 262,
    TALENT_TREE_MAGE_ARCANE = 81,
    TALENT_TREE_MAGE_FIRE = 41,
    TALENT_TREE_MAGE_FROST = 61,
    TALENT_TREE_WARLOCK_AFFLICTION = 302,
    TALENT_TREE_WARLOCK_DEMONOLOGY = 303,
    TALENT_TREE_WARLOCK_DESTRUCTION = 301,
    TALENT_TREE_DRUID_BALANCE = 283,
    TALENT_TREE_DRUID_FERAL_COMBAT = 281,
    TALENT_TREE_DRUID_RESTORATION = 282
};

#define SPEC_MASK_ALL 255

// Spell modifier (used for modify other spells)
struct SpellModifier
{
    SpellModifier(Aura* _ownerAura = nullptr) : op(SPELLMOD_DAMAGE), type(SPELLMOD_FLAT), charges(0),  mask(), ownerAura(_ownerAura) {}
    SpellModOp   op   : 8;
    SpellModType type : 8;
    int16 charges     : 16;
    int32 value{0};
    flag96 mask;
    uint32 spellId{0};
    Aura* const ownerAura;
};

typedef std::unordered_map<uint32, PlayerTalent*> PlayerTalentMap;
typedef std::unordered_map<uint32, PlayerSpell*> PlayerSpellMap;
typedef std::list<SpellModifier*> SpellModList;

typedef GuidList WhisperListContainer;

struct SpellCooldown
{
    uint32 end;
    uint16 category;
    uint32 itemid;
    uint32 maxduration;
    bool sendToSpectator: 1;
    bool needSendToClient: 1;
};

typedef std::map<uint32, SpellCooldown> SpellCooldowns;
typedef std::unordered_map<uint32 /*instanceId*/, time_t/*releaseTime*/> InstanceTimeMap;

enum TrainerSpellState
{
    TRAINER_SPELL_GREEN = 0,
    TRAINER_SPELL_RED   = 1,
    TRAINER_SPELL_GRAY  = 2,
    TRAINER_SPELL_GREEN_DISABLED = 10                       // custom value, not send to client: formally green but learn not allowed
};

enum ActionButtonUpdateState
{
    ACTIONBUTTON_UNCHANGED = 0,
    ACTIONBUTTON_CHANGED   = 1,
    ACTIONBUTTON_NEW       = 2,
    ACTIONBUTTON_DELETED   = 3
};

enum ActionButtonType
{
    ACTION_BUTTON_SPELL     = 0x00,
    ACTION_BUTTON_C         = 0x01,                         // click?
    ACTION_BUTTON_EQSET     = 0x20,
    ACTION_BUTTON_MACRO     = 0x40,
    ACTION_BUTTON_CMACRO    = ACTION_BUTTON_C | ACTION_BUTTON_MACRO,
    ACTION_BUTTON_ITEM      = 0x80
};

enum ReputationSource
{
    REPUTATION_SOURCE_KILL,
    REPUTATION_SOURCE_QUEST,
    REPUTATION_SOURCE_DAILY_QUEST,
    REPUTATION_SOURCE_WEEKLY_QUEST,
    REPUTATION_SOURCE_MONTHLY_QUEST,
    REPUTATION_SOURCE_REPEATABLE_QUEST,
    REPUTATION_SOURCE_SPELL
};

#define ACTION_BUTTON_ACTION(X) (uint32(X) & 0x00FFFFFF)
#define ACTION_BUTTON_TYPE(X)   ((uint32(X) & 0xFF000000) >> 24)
#define MAX_ACTION_BUTTON_ACTION_VALUE (0x00FFFFFF+1)

struct ActionButton
{
    ActionButton()  = default;

    uint32 packedData{0};
    ActionButtonUpdateState uState{ACTIONBUTTON_NEW};

    // helpers
    [[nodiscard]] ActionButtonType GetType() const { return ActionButtonType(ACTION_BUTTON_TYPE(packedData)); }
    [[nodiscard]] uint32 GetAction() const { return ACTION_BUTTON_ACTION(packedData); }
    void SetActionAndType(uint32 action, ActionButtonType type)
    {
        uint32 newData = action | (uint32(type) << 24);
        if (newData != packedData || uState == ACTIONBUTTON_DELETED)
        {
            packedData = newData;
            if (uState != ACTIONBUTTON_NEW)
                uState = ACTIONBUTTON_CHANGED;
        }
    }
};

#define  MAX_ACTION_BUTTONS 144                             //checked in 3.2.0

typedef std::map<uint8, ActionButton> ActionButtonList;

struct PlayerCreateInfoItem
{
    PlayerCreateInfoItem(uint32 id, uint32 amount) : item_id(id), item_amount(amount) {}

    uint32 item_id;
    uint32 item_amount;
};

typedef std::list<PlayerCreateInfoItem> PlayerCreateInfoItems;

struct PlayerClassLevelInfo
{
    PlayerClassLevelInfo()  = default;
    uint32 basehealth{0};
    uint32 basemana{0};
};

struct PlayerClassInfo
{
    PlayerClassInfo()  = default;

    PlayerClassLevelInfo* levelInfo{nullptr};                        //[level-1] 0..MaxPlayerLevel-1
};

struct PlayerLevelInfo
{
    PlayerLevelInfo()
    {
        stats.fill(0);
    }

    std::array<uint32, MAX_STATS> stats = { };
};

typedef std::list<uint32> PlayerCreateInfoSpells;

struct PlayerCreateInfoAction
{
    PlayerCreateInfoAction()  = default;
    PlayerCreateInfoAction(uint8 _button, uint32 _action, uint8 _type) : button(_button), type(_type), action(_action) {}

    uint8 button{0};
    uint8 type{0};
    uint32 action{0};
};

typedef std::list<PlayerCreateInfoAction> PlayerCreateInfoActions;

struct PlayerCreateInfoSkill
{
    uint16 SkillId;
    uint16 Rank;
};

typedef std::list<PlayerCreateInfoSkill> PlayerCreateInfoSkills;

struct PlayerInfo
{
    // existence checked by displayId != 0
    PlayerInfo()  = default;

    uint32 mapId{0};
    uint32 areaId{0};
    float positionX{0.0f};
    float positionY{0.0f};
    float positionZ{0.0f};
    float orientation{0.0f};
    uint16 displayId_m{0};
    uint16 displayId_f{0};
    PlayerCreateInfoItems item;
    PlayerCreateInfoSpells customSpells;
    PlayerCreateInfoSpells  castSpells;
    PlayerCreateInfoActions action;
    PlayerCreateInfoSkills skills;

    PlayerLevelInfo* levelInfo{nullptr};                             //[level-1] 0..MaxPlayerLevel-1
};

struct PvPInfo
{
    PvPInfo()  = default;

    bool IsHostile{false};
    bool IsInHostileArea{false};               ///> Marks if player is in an area which forces PvP flag
    bool IsInNoPvPArea{false};                 ///> Marks if player is in a sanctuary or friendly capital city
    bool IsInFFAPvPArea{false};                ///> Marks if player is in an FFAPvP area (such as Gurubashi Arena)
    time_t EndTimer{0};                        ///> Time when player unflags himself for PvP (flag removed after 5 minutes)
    time_t FFAPvPEndTimer{0};                  ///> Time when player unflags himself for FFA PvP (flag removed after 30 sec)
};

enum DuelState
{
    DUEL_STATE_CHALLENGED,
    DUEL_STATE_COUNTDOWN,
    DUEL_STATE_IN_PROGRESS,
    DUEL_STATE_COMPLETED
};

struct DuelInfo
{
    DuelInfo(Player* opponent, Player* initiator, bool isMounted) : Opponent(opponent), Initiator(initiator), IsMounted(isMounted) {}

    Player* const Opponent;
    Player* const Initiator;
    bool const IsMounted;
    DuelState State = DUEL_STATE_CHALLENGED;
    time_t StartTime = 0;
    time_t OutOfBoundsTime = 0;
};

struct Areas
{
    uint32 areaID;
    uint32 areaFlag;
    float x1;
    float x2;
    float y1;
    float y2;
};

#define MAX_RUNES       6

enum RuneCooldowns
{
    RUNE_BASE_COOLDOWN  = 10000,
    RUNE_GRACE_PERIOD   = 2500,     // xinef: maximum possible grace period
    RUNE_MISS_COOLDOWN  = 1500,     // cooldown applied on runes when the spell misses
};

enum RuneType
{
    RUNE_BLOOD      = 0,
    RUNE_UNHOLY     = 1,
    RUNE_FROST      = 2,
    RUNE_DEATH      = 3,
    NUM_RUNE_TYPES  = 4
};

struct RuneInfo
{
    uint8 BaseRune;
    uint8 CurrentRune;
    uint32 Cooldown;
    uint32 GracePeriod;
    AuraEffect const* ConvertAura;
};

struct Runes
{
    RuneInfo runes[MAX_RUNES];
    uint8 runeState;                                        // mask of available runes
    RuneType lastUsedRune;

    void SetRuneState(uint8 index, bool set = true)
    {
        if (set)
            runeState |= (1 << index);                      // usable
        else
            runeState &= ~(1 << index);                     // on cooldown
    }
};

struct EnchantDuration
{
    EnchantDuration()  = default;;
    EnchantDuration(Item* _item, EnchantmentSlot _slot, uint32 _leftduration) : item(_item), slot(_slot),
        leftduration(_leftduration) { ASSERT(item); };

    Item* item{nullptr};
    EnchantmentSlot slot{MAX_ENCHANTMENT_SLOT};
    uint32 leftduration{0};
};

typedef std::list<EnchantDuration> EnchantDurationList;
typedef std::list<Item*> ItemDurationList;

enum PlayerMovementType
{
    MOVE_ROOT       = 1,
    MOVE_UNROOT     = 2,
    MOVE_WATER_WALK = 3,
    MOVE_LAND_WALK  = 4
};

enum DrunkenState
{
    DRUNKEN_SOBER   = 0,
    DRUNKEN_TIPSY   = 1,
    DRUNKEN_DRUNK   = 2,
    DRUNKEN_SMASHED = 3
};

#define MAX_DRUNKEN   4

enum PlayerFlags : uint32
{
    PLAYER_FLAGS_GROUP_LEADER      = 0x00000001,
    PLAYER_FLAGS_AFK               = 0x00000002,
    PLAYER_FLAGS_DND               = 0x00000004,
    PLAYER_FLAGS_GM                = 0x00000008,
    PLAYER_FLAGS_GHOST             = 0x00000010,
    PLAYER_FLAGS_RESTING           = 0x00000020,
    PLAYER_FLAGS_UNK6              = 0x00000040,
    PLAYER_FLAGS_UNK7              = 0x00000080,               // pre-3.0.3 PLAYER_FLAGS_FFA_PVP flag for FFA PVP state
    PLAYER_FLAGS_CONTESTED_PVP     = 0x00000100,               // Player has been involved in a PvP combat and will be attacked by contested guards
    PLAYER_FLAGS_IN_PVP            = 0x00000200,
    PLAYER_FLAGS_HIDE_HELM         = 0x00000400,
    PLAYER_FLAGS_HIDE_CLOAK        = 0x00000800,
    PLAYER_FLAGS_PLAYED_LONG_TIME  = 0x00001000,               // played long time
    PLAYER_FLAGS_PLAYED_TOO_LONG   = 0x00002000,               // played too long time
    PLAYER_FLAGS_IS_OUT_OF_BOUNDS  = 0x00004000,
    PLAYER_FLAGS_DEVELOPER         = 0x00008000,               // <Dev> prefix for something?
    PLAYER_FLAGS_UNK16             = 0x00010000,               // pre-3.0.3 PLAYER_FLAGS_SANCTUARY flag for player entered sanctuary
    PLAYER_FLAGS_TAXI_BENCHMARK    = 0x00020000,               // taxi benchmark mode (on/off) (2.0.1)
    PLAYER_FLAGS_PVP_TIMER         = 0x00040000,               // 3.0.2, pvp timer active (after you disable pvp manually)
    PLAYER_FLAGS_UBER              = 0x00080000,
    PLAYER_FLAGS_UNK20             = 0x00100000,
    PLAYER_FLAGS_UNK21             = 0x00200000,
    PLAYER_FLAGS_COMMENTATOR2      = 0x00400000,
    PLAYER_ALLOW_ONLY_ABILITY      = 0x00800000,                // used by bladestorm and killing spree, allowed only spells with SPELL_ATTR0_USES_RANGED_SLOT, SPELL_EFFECT_ATTACK, checked only for active player
    PLAYER_FLAGS_UNK24             = 0x01000000,                // disabled all melee ability on tab include autoattack
    PLAYER_FLAGS_NO_XP_GAIN        = 0x02000000,
    PLAYER_FLAGS_UNK26             = 0x04000000,
    PLAYER_FLAGS_UNK27             = 0x08000000,
    PLAYER_FLAGS_UNK28             = 0x10000000,
    PLAYER_FLAGS_UNK29             = 0x20000000,
    PLAYER_FLAGS_UNK30             = 0x40000000,
    PLAYER_FLAGS_UNK31             = 0x80000000,
};

DEFINE_ENUM_FLAG(PlayerFlags);

enum PlayerBytesOffsets //@todo: Implement
{
    PLAYER_BYTES_OFFSET_SKIN_ID         = 0,
    PLAYER_BYTES_OFFSET_FACE_ID         = 1,
    PLAYER_BYTES_OFFSET_HAIR_STYLE_ID   = 2,
    PLAYER_BYTES_OFFSET_HAIR_COLOR_ID   = 3
};

enum PlayerBytes2Offsets //@todo: Implement
{
    PLAYER_BYTES_2_OFFSET_FACIAL_STYLE      = 0,
    PLAYER_BYTES_2_OFFSET_PARTY_TYPE        = 1,
    PLAYER_BYTES_2_OFFSET_BANK_BAG_SLOTS    = 2,
    PLAYER_BYTES_2_OFFSET_REST_STATE        = 3
};

enum PlayerBytes3Offsets //@todo: Implement
{
    PLAYER_BYTES_3_OFFSET_GENDER        = 0,
    PLAYER_BYTES_3_OFFSET_INEBRIATION   = 1,
    PLAYER_BYTES_3_OFFSET_PVP_TITLE     = 2,
    PLAYER_BYTES_3_OFFSET_ARENA_FACTION = 3
};

enum PlayerFieldBytesOffsets //@todo: Implement
{
    PLAYER_FIELD_BYTES_OFFSET_FLAGS                 = 0,
    PLAYER_FIELD_BYTES_OFFSET_RAF_GRANTABLE_LEVEL   = 1,
    PLAYER_FIELD_BYTES_OFFSET_ACTION_BAR_TOGGLES    = 2,
    PLAYER_FIELD_BYTES_OFFSET_LIFETIME_MAX_PVP_RANK = 3
};

enum PlayerFieldBytes2Offsets
{
    PLAYER_FIELD_BYTES_2_OFFSET_OVERRIDE_SPELLS_ID                  = 0,    // uint16!
    PLAYER_FIELD_BYTES_2_OFFSET_IGNORE_POWER_REGEN_PREDICTION_MASK  = 2,
    PLAYER_FIELD_BYTES_2_OFFSET_AURA_VISION                         = 3
};

static_assert((PLAYER_FIELD_BYTES_2_OFFSET_OVERRIDE_SPELLS_ID & 1) == 0, "PLAYER_FIELD_BYTES_2_OFFSET_OVERRIDE_SPELLS_ID must be aligned to 2 byte boundary");

#define PLAYER_BYTES_2_OVERRIDE_SPELLS_UINT16_OFFSET (PLAYER_FIELD_BYTES_2_OFFSET_OVERRIDE_SPELLS_ID / 2)

#define KNOWN_TITLES_SIZE   3
#define MAX_TITLE_INDEX     (KNOWN_TITLES_SIZE*64)          // 3 uint64 fields

// used in PLAYER_FIELD_BYTES values
enum PlayerFieldByteFlags
{
    PLAYER_FIELD_BYTE_TRACK_STEALTHED   = 0x00000002,
    PLAYER_FIELD_BYTE_RELEASE_TIMER     = 0x00000008,       // Display time till auto release spirit
    PLAYER_FIELD_BYTE_NO_RELEASE_WINDOW = 0x00000010        // Display no "release spirit" window at all
};

// used in PLAYER_FIELD_BYTES2 values
enum PlayerFieldByte2Flags
{
    PLAYER_FIELD_BYTE2_NONE                 = 0x00,
    PLAYER_FIELD_BYTE2_STEALTH              = 0x20,
    PLAYER_FIELD_BYTE2_INVISIBILITY_GLOW    = 0x40
};

enum MirrorTimerType
{
    FATIGUE_TIMER      = 0,
    BREATH_TIMER       = 1,
    FIRE_TIMER         = 2
};
#define MAX_TIMERS      3
#define DISABLED_MIRROR_TIMER   -1

// 2^n values
enum PlayerExtraFlags
{
    // gm abilities
    PLAYER_EXTRA_GM_ON              = 0x0001,
    PLAYER_EXTRA_ACCEPT_WHISPERS    = 0x0004,
    PLAYER_EXTRA_TAXICHEAT          = 0x0008,
    PLAYER_EXTRA_GM_INVISIBLE       = 0x0010,
    PLAYER_EXTRA_GM_CHAT            = 0x0020,               // Show GM badge in chat messages
    PLAYER_EXTRA_HAS_310_FLYER      = 0x0040,               // Marks if player already has 310% speed flying mount
    PLAYER_EXTRA_SPECTATOR_ON       = 0x0080,               // Marks if player is spectactor
    PLAYER_EXTRA_PVP_DEATH          = 0x0100,               // store PvP death status until corpse creating.
    PLAYER_EXTRA_SHOW_DK_PET        = 0x0400,               // Marks if player should see ghoul on login screen
};

// 2^n values
enum AtLoginFlags
{
    AT_LOGIN_NONE              = 0x00,
    AT_LOGIN_RENAME            = 0x01,
    AT_LOGIN_RESET_SPELLS      = 0x02,
    AT_LOGIN_RESET_TALENTS     = 0x04,
    AT_LOGIN_CUSTOMIZE         = 0x08,
    AT_LOGIN_RESET_PET_TALENTS = 0x10,
    AT_LOGIN_FIRST             = 0x20,
    AT_LOGIN_CHANGE_FACTION    = 0x40,
    AT_LOGIN_CHANGE_RACE       = 0x80,
    AT_LOGIN_RESET_AP          = 0x100,
    AT_LOGIN_RESET_ARENA       = 0x200,
    AT_LOGIN_CHECK_ACHIEVS     = 0x400,
    AT_LOGIN_RESURRECT         = 0x800
};

typedef std::map<uint32, QuestStatusData> QuestStatusMap;
typedef std::unordered_set<uint32> RewardedQuestSet;

//               quest,  keep
typedef std::map<uint32, bool> QuestStatusSaveMap;

enum QuestSlotOffsets
{
    QUEST_ID_OFFSET     = 0,
    QUEST_STATE_OFFSET  = 1,
    QUEST_COUNTS_OFFSET = 2,
    QUEST_TIME_OFFSET   = 4
};

#define MAX_QUEST_OFFSET 5

enum QuestSlotStateMask
{
    QUEST_STATE_NONE     = 0x0000,
    QUEST_STATE_COMPLETE = 0x0001,
    QUEST_STATE_FAIL     = 0x0002
};

enum SkillUpdateState
{
    SKILL_UNCHANGED     = 0,
    SKILL_CHANGED       = 1,
    SKILL_NEW           = 2,
    SKILL_DELETED       = 3
};

struct SkillStatusData
{
    SkillStatusData(uint8 _pos, SkillUpdateState _uState) : pos(_pos), uState(_uState)
    {
    }
    uint8 pos;
    SkillUpdateState uState;
};

typedef std::unordered_map<uint32, SkillStatusData> SkillStatusMap;

class Quest;
class Spell;
class Item;
class WorldSession;

enum PlayerSlots
{
    // first slot for item stored (in any way in player m_items data)
    PLAYER_SLOT_START           = 0,
    // last+1 slot for item stored (in any way in player m_items data)
    PLAYER_SLOT_END             = 150,
    PLAYER_SLOTS_COUNT          = (PLAYER_SLOT_END - PLAYER_SLOT_START)
};

#define INVENTORY_SLOT_BAG_0    255

enum EquipmentSlots                                         // 19 slots
{
    EQUIPMENT_SLOT_START        = 0,
    EQUIPMENT_SLOT_HEAD         = 0,
    EQUIPMENT_SLOT_NECK         = 1,
    EQUIPMENT_SLOT_SHOULDERS    = 2,
    EQUIPMENT_SLOT_BODY         = 3,
    EQUIPMENT_SLOT_CHEST        = 4,
    EQUIPMENT_SLOT_WAIST        = 5,
    EQUIPMENT_SLOT_LEGS         = 6,
    EQUIPMENT_SLOT_FEET         = 7,
    EQUIPMENT_SLOT_WRISTS       = 8,
    EQUIPMENT_SLOT_HANDS        = 9,
    EQUIPMENT_SLOT_FINGER1      = 10,
    EQUIPMENT_SLOT_FINGER2      = 11,
    EQUIPMENT_SLOT_TRINKET1     = 12,
    EQUIPMENT_SLOT_TRINKET2     = 13,
    EQUIPMENT_SLOT_BACK         = 14,
    EQUIPMENT_SLOT_MAINHAND     = 15,
    EQUIPMENT_SLOT_OFFHAND      = 16,
    EQUIPMENT_SLOT_RANGED       = 17,
    EQUIPMENT_SLOT_TABARD       = 18,
    EQUIPMENT_SLOT_END          = 19
};

enum InventorySlots                                         // 4 slots
{
    INVENTORY_SLOT_BAG_START    = 19,
    INVENTORY_SLOT_BAG_END      = 23
};

enum InventoryPackSlots                                     // 16 slots
{
    INVENTORY_SLOT_ITEM_START   = 23,
    INVENTORY_SLOT_ITEM_END     = 39
};

enum BankItemSlots                                          // 28 slots
{
    BANK_SLOT_ITEM_START        = 39,
    BANK_SLOT_ITEM_END          = 67
};

enum BankBagSlots                                           // 7 slots
{
    BANK_SLOT_BAG_START         = 67,
    BANK_SLOT_BAG_END           = 74
};

enum BuyBackSlots                                           // 12 slots
{
    // stored in m_items, there is no more m_buybackitems
    BUYBACK_SLOT_START          = 74,
    BUYBACK_SLOT_END            = 86
};

enum KeyRingSlots                                           // 32 slots
{
    KEYRING_SLOT_START          = 86,
    KEYRING_SLOT_END            = 118
};

enum CurrencyTokenSlots                                     // 32 slots
{
    CURRENCYTOKEN_SLOT_START    = 118,
    CURRENCYTOKEN_SLOT_END      = 150
};

enum EquipmentSetUpdateState
{
    EQUIPMENT_SET_UNCHANGED = 0,
    EQUIPMENT_SET_CHANGED   = 1,
    EQUIPMENT_SET_NEW       = 2,
    EQUIPMENT_SET_DELETED   = 3
};

struct EquipmentSet
{
    EquipmentSet() = default;

    uint64 Guid;
    std::string Name;
    std::string IconName;
    uint32 IgnoreMask{0};
    ObjectGuid Items[EQUIPMENT_SLOT_END];
    EquipmentSetUpdateState state{EQUIPMENT_SET_NEW};
};

#define MAX_EQUIPMENT_SET_INDEX 10                          // client limit

typedef std::map<uint32, EquipmentSet> EquipmentSets;

struct ItemPosCount
{
    ItemPosCount(uint16 _pos, uint32 _count) : pos(_pos), count(_count) {}
    [[nodiscard]] bool isContainedIn(std::vector<ItemPosCount> const& vec) const;
    uint16 pos;
    uint32 count;
};
typedef std::vector<ItemPosCount> ItemPosCountVec;

struct SavedItem
{
    Item* item;
    uint16 dstpos;

    SavedItem(Item* _item, uint16 dstpos) : item(_item), dstpos(dstpos) {}
};

enum TransferAbortReason
{
    TRANSFER_ABORT_NONE                     = 0x00,
    TRANSFER_ABORT_ERROR                    = 0x01,
    TRANSFER_ABORT_MAX_PLAYERS              = 0x02,         // Transfer Aborted: instance is full
    TRANSFER_ABORT_NOT_FOUND                = 0x03,         // Transfer Aborted: instance not found
    TRANSFER_ABORT_TOO_MANY_INSTANCES       = 0x04,         // You have entered too many instances recently.
    TRANSFER_ABORT_ZONE_IN_COMBAT           = 0x06,         // Unable to zone in while an encounter is in progress.
    TRANSFER_ABORT_INSUF_EXPAN_LVL          = 0x07,         // You must have <TBC, WotLK> expansion installed to access this area.
    TRANSFER_ABORT_DIFFICULTY               = 0x08,         // <Normal, Heroic, Epic> difficulty mode is not available for %s.
    TRANSFER_ABORT_UNIQUE_MESSAGE           = 0x09,         // Until you've escaped TLK's grasp, you cannot leave this place!
    TRANSFER_ABORT_TOO_MANY_REALM_INSTANCES = 0x0A,         // Additional instances cannot be launched, please try again later.
    TRANSFER_ABORT_NEED_GROUP               = 0x0B,         // 3.1
    TRANSFER_ABORT_NOT_FOUND1               = 0x0C,         // 3.1
    TRANSFER_ABORT_NOT_FOUND2               = 0x0D,         // 3.1
    TRANSFER_ABORT_NOT_FOUND3               = 0x0E,         // 3.2
    TRANSFER_ABORT_REALM_ONLY               = 0x0F,         // All players on party must be from the same realm.
    TRANSFER_ABORT_MAP_NOT_ALLOWED          = 0x10,         // Map can't be entered at this time.
};

enum InstanceResetWarningType
{
    RAID_INSTANCE_WARNING_HOURS     = 1,                    // WARNING! %s is scheduled to reset in %d hour(s).
    RAID_INSTANCE_WARNING_MIN       = 2,                    // WARNING! %s is scheduled to reset in %d minute(s)!
    RAID_INSTANCE_WARNING_MIN_SOON  = 3,                    // WARNING! %s is scheduled to reset in %d minute(s). Please exit the zone or you will be returned to your bind location!
    RAID_INSTANCE_WELCOME           = 4,                    // Welcome to %s. This raid instance is scheduled to reset in %s.
    RAID_INSTANCE_EXPIRED           = 5
};

class InstanceSave;

enum RestFlag
{
    REST_FLAG_IN_TAVERN         = 0x1,
    REST_FLAG_IN_CITY           = 0x2,
    REST_FLAG_IN_FACTION_AREA   = 0x4, // used with AREA_FLAG_REST_ZONE_*
};

enum TeleportToOptions
{
    TELE_TO_GM_MODE             = 0x01,
    TELE_TO_NOT_LEAVE_TRANSPORT = 0x02,
    TELE_TO_NOT_LEAVE_COMBAT    = 0x04,
    TELE_TO_NOT_UNSUMMON_PET    = 0x08,
    TELE_TO_SPELL               = 0x10,
    TELE_TO_NOT_LEAVE_VEHICLE   = 0x20,
    TELE_TO_WITH_PET            = 0x40,
    TELE_TO_NOT_LEAVE_TAXI      = 0x80
};

/// Type of environmental damages
enum EnviromentalDamage
{
    DAMAGE_EXHAUSTED = 0,
    DAMAGE_DROWNING  = 1,
    DAMAGE_FALL      = 2,
    DAMAGE_LAVA      = 3,
    DAMAGE_SLIME     = 4,
    DAMAGE_FIRE      = 5,
    DAMAGE_FALL_TO_VOID = 6                                 // custom case for fall without durability loss
};

enum PlayerChatTag
{
    CHAT_TAG_NONE       = 0x00,
    CHAT_TAG_AFK        = 0x01,
    CHAT_TAG_DND        = 0x02,
    CHAT_TAG_GM         = 0x04,
    CHAT_TAG_COM        = 0x08, // Commentator tag. Do not exist in clean client
    CHAT_TAG_DEV        = 0x10,
};

enum PlayedTimeIndex
{
    PLAYED_TIME_TOTAL = 0,
    PLAYED_TIME_LEVEL = 1
};

#define MAX_PLAYED_TIME_INDEX 2

// used at player loading query list preparing, and later result selection
enum PlayerLoginQueryIndex
{
    PLAYER_LOGIN_QUERY_LOAD_FROM                    = 0,
    PLAYER_LOGIN_QUERY_LOAD_AURAS                   = 3,
    PLAYER_LOGIN_QUERY_LOAD_SPELLS                  = 4,
    PLAYER_LOGIN_QUERY_LOAD_QUEST_STATUS            = 5,
    PLAYER_LOGIN_QUERY_LOAD_DAILY_QUEST_STATUS      = 6,
    PLAYER_LOGIN_QUERY_LOAD_REPUTATION              = 7,
    PLAYER_LOGIN_QUERY_LOAD_INVENTORY               = 8,
    PLAYER_LOGIN_QUERY_LOAD_ACTIONS                 = 9,
    PLAYER_LOGIN_QUERY_LOAD_MAILS                   = 10,
    PLAYER_LOGIN_QUERY_LOAD_MAIL_ITEMS              = 11,
    PLAYER_LOGIN_QUERY_LOAD_SOCIAL_LIST             = 13,
    PLAYER_LOGIN_QUERY_LOAD_HOME_BIND               = 14,
    PLAYER_LOGIN_QUERY_LOAD_SPELL_COOLDOWNS         = 15,
    PLAYER_LOGIN_QUERY_LOAD_DECLINED_NAMES          = 16,
    PLAYER_LOGIN_QUERY_LOAD_ACHIEVEMENTS            = 18,
    PLAYER_LOGIN_QUERY_LOAD_CRITERIA_PROGRESS       = 19,
    PLAYER_LOGIN_QUERY_LOAD_EQUIPMENT_SETS          = 20,
    PLAYER_LOGIN_QUERY_LOAD_ENTRY_POINT             = 21,
    PLAYER_LOGIN_QUERY_LOAD_GLYPHS                  = 22,
    PLAYER_LOGIN_QUERY_LOAD_TALENTS                 = 23,
    PLAYER_LOGIN_QUERY_LOAD_ACCOUNT_DATA            = 24,
    PLAYER_LOGIN_QUERY_LOAD_SKILLS                  = 25,
    PLAYER_LOGIN_QUERY_LOAD_WEEKLY_QUEST_STATUS     = 26,
    PLAYER_LOGIN_QUERY_LOAD_RANDOM_BG               = 27,
    PLAYER_LOGIN_QUERY_LOAD_BANNED                  = 28,
    PLAYER_LOGIN_QUERY_LOAD_QUEST_STATUS_REW        = 29,
    PLAYER_LOGIN_QUERY_LOAD_INSTANCE_LOCK_TIMES     = 30,
    PLAYER_LOGIN_QUERY_LOAD_SEASONAL_QUEST_STATUS   = 31,
    PLAYER_LOGIN_QUERY_LOAD_MONTHLY_QUEST_STATUS    = 32,
    PLAYER_LOGIN_QUERY_LOAD_BREW_OF_THE_MONTH       = 34,
    PLAYER_LOGIN_QUERY_LOAD_CORPSE_LOCATION         = 35,
    PLAYER_LOGIN_QUERY_LOAD_CHARACTER_SETTINGS      = 36,
    PLAYER_LOGIN_QUERY_LOAD_PET_SLOTS               = 37,
    MAX_PLAYER_LOGIN_QUERY
};

enum PlayerDelayedOperations
{
    DELAYED_SAVE_PLAYER         = 0x01,
    DELAYED_RESURRECT_PLAYER    = 0x02,
    DELAYED_SPELL_CAST_DESERTER = 0x04,
    DELAYED_BG_MOUNT_RESTORE    = 0x08,                     ///< Flag to restore mount state after teleport from BG
    DELAYED_BG_TAXI_RESTORE     = 0x10,                     ///< Flag to restore taxi state after teleport from BG
    DELAYED_BG_GROUP_RESTORE    = 0x20,                     ///< Flag to restore group state after teleport from BG
    DELAYED_VEHICLE_TELEPORT    = 0x40,
    DELAYED_END
};

enum PlayerCharmedAISpells
{
    SPELL_T_STUN,
    SPELL_ROOT_OR_FEAR,
    SPELL_INSTANT_DAMAGE,
    SPELL_INSTANT_DAMAGE2,
    SPELL_HIGH_DAMAGE1,
    SPELL_HIGH_DAMAGE2,
    SPELL_DOT_DAMAGE,
    SPELL_T_CHARGE,
    SPELL_IMMUNITY,
    SPELL_FAST_RUN,
    NUM_CAI_SPELLS
};

// Player summoning auto-decline time (in secs)
#define MAX_PLAYER_SUMMON_DELAY                   (2*MINUTE)
#define MAX_MONEY_AMOUNT                       (0x7FFFFFFF-1)

struct ProgressionRequirement
{
    uint32 id;
    TeamId faction;
    std::string note;
    uint32 priority;
    bool checkLeaderOnly;
};

struct DungeonProgressionRequirements
{
    uint8  levelMin;
    uint8  levelMax;
    uint16 reqItemLevel;
    std::vector<ProgressionRequirement*> quests;
    std::vector<ProgressionRequirement*> items;
    std::vector<ProgressionRequirement*> achievements;
};

enum CharDeleteMethod
{
    CHAR_DELETE_REMOVE = 0,                      // Completely remove from the database
    CHAR_DELETE_UNLINK = 1                       // The character gets unlinked from the account,
                         // the name gets freed up and appears as deleted ingame
};

enum CurrencyItems
{
    ITEM_HONOR_POINTS_ID    = 43308,
    ITEM_ARENA_POINTS_ID    = 43307
};

enum ReferAFriendError
{
    ERR_REFER_A_FRIEND_NONE                          = 0x00,
    ERR_REFER_A_FRIEND_NOT_REFERRED_BY               = 0x01,
    ERR_REFER_A_FRIEND_TARGET_TOO_HIGH               = 0x02,
    ERR_REFER_A_FRIEND_INSUFFICIENT_GRANTABLE_LEVELS = 0x03,
    ERR_REFER_A_FRIEND_TOO_FAR                       = 0x04,
    ERR_REFER_A_FRIEND_DIFFERENT_FACTION             = 0x05,
    ERR_REFER_A_FRIEND_NOT_NOW                       = 0x06,
    ERR_REFER_A_FRIEND_GRANT_LEVEL_MAX_I             = 0x07,
    ERR_REFER_A_FRIEND_NO_TARGET                     = 0x08,
    ERR_REFER_A_FRIEND_NOT_IN_GROUP                  = 0x09,
    ERR_REFER_A_FRIEND_SUMMON_LEVEL_MAX_I            = 0x0A,
    ERR_REFER_A_FRIEND_SUMMON_COOLDOWN               = 0x0B,
    ERR_REFER_A_FRIEND_INSUF_EXPAN_LVL               = 0x0C,
    ERR_REFER_A_FRIEND_SUMMON_OFFLINE_S              = 0x0D
};

enum PlayerRestState
{
    REST_STATE_RESTED                                = 0x01,
    REST_STATE_NOT_RAF_LINKED                        = 0x02,
    REST_STATE_RAF_LINKED                            = 0x06
};

enum AdditionalSaving
{
    ADDITIONAL_SAVING_NONE                      = 0x00,
    ADDITIONAL_SAVING_INVENTORY_AND_GOLD        = 0x01,
    ADDITIONAL_SAVING_QUEST_STATUS              = 0x02,
};

enum PlayerCommandStates
{
    CHEAT_NONE = 0x00,
    CHEAT_GOD = 0x01,
    CHEAT_CASTTIME = 0x02,
    CHEAT_COOLDOWN = 0x04,
    CHEAT_POWER = 0x08,
    CHEAT_WATERWALK = 0x10
};

// Used for OnGiveXP PlayerScript hook
enum PlayerXPSource
{
    XPSOURCE_KILL = 0,
    XPSOURCE_QUEST = 1,
    XPSOURCE_QUEST_DF = 2,
    XPSOURCE_EXPLORE = 3,
    XPSOURCE_BATTLEGROUND = 4
};

enum InstantFlightGossipAction
{
    GOSSIP_ACTION_TOGGLE_INSTANT_FLIGHT = 500
};

enum EmoteBroadcastTextID
{
    EMOTE_BROADCAST_TEXT_ID_STRANGE_GESTURES = 91243
};

std::ostringstream& operator<< (std::ostringstream& ss, PlayerTaxi const& taxi);

class Player;

// holder for Battleground data (pussywizard: not stored in db)
struct BGData
{
    BGData()  = default;

    uint32 bgInstanceID{0};
    BattlegroundTypeId bgTypeID{BATTLEGROUND_TYPE_NONE};
    TeamId bgTeamId{TEAM_NEUTRAL};
    uint32 bgQueueSlot{PLAYER_MAX_BATTLEGROUND_QUEUES};
    bool isInvited{false};
    bool bgIsRandom{false};

    GuidSet            bgAfkReporter;
    uint8              bgAfkReportedCount{0};
    time_t             bgAfkReportedTimer{0};
};

// holder for Entry Point data (pussywizard: stored in db)
struct EntryPointData
{
    EntryPointData()
    {
        ClearTaxiPath();
    }

    uint32 mountSpell{0};
    std::array<uint32, 2> taxiPath;
    WorldLocation joinPos;

    void ClearTaxiPath() { taxiPath.fill(0); }
    [[nodiscard]] bool HasTaxiPath() const { return taxiPath[0] && taxiPath[1]; }
};

class Player : public Unit, public GridObject<Player>
{
    friend class WorldSession;
    friend class CinematicMgr;
    friend void Item::AddToUpdateQueueOf(Player* player);
    friend void Item::RemoveFromUpdateQueueOf(Player* player);
public:
    explicit Player(WorldSession* session);
    ~Player() override;

    void CleanupsBeforeDelete(bool finalCleanup = true) override;

    void AddToWorld() override;
    void RemoveFromWorld() override;

    void SetObjectScale(float scale) override
    {
        Unit::SetObjectScale(scale);
        SetFloatValue(UNIT_FIELD_BOUNDINGRADIUS, scale * DEFAULT_WORLD_OBJECT_SIZE);
        SetFloatValue(UNIT_FIELD_COMBATREACH, scale * DEFAULT_COMBAT_REACH);
    }

    [[nodiscard]] bool hasSpanishClient()
    {
        return GetSession()->GetSessionDbLocaleIndex() == LOCALE_esES || GetSession()->GetSessionDbLocaleIndex() == LOCALE_esMX;
    }

    bool TeleportTo(uint32 mapid, float x, float y, float z, float orientation, uint32 options = 0, Unit* target = nullptr, bool newInstance = false);
    bool TeleportTo(WorldLocation const& loc, uint32 options = 0, Unit* target = nullptr)
    {
        return TeleportTo(loc.GetMapId(), loc.GetPositionX(), loc.GetPositionY(), loc.GetPositionZ(), loc.GetOrientation(), options, target);
    }
    bool TeleportToEntryPoint();

    void SetSummonPoint(uint32 mapid, float x, float y, float z, uint32 delay = 0, bool asSpectator = false);
    [[nodiscard]] bool IsSummonAsSpectator() const;
    void SetSummonAsSpectator(bool on) { m_summon_asSpectator = on; }
    void SummonIfPossible(bool agree, ObjectGuid summoner_guid);
    [[nodiscard]] time_t GetSummonExpireTimer() const { return m_summon_expire; }

    bool Create(ObjectGuid::LowType guidlow, CharacterCreateInfo* createInfo);

    void Update(uint32 time) override;

    PlayerFlags GetPlayerFlags() const { return PlayerFlags(GetUInt32Value(PLAYER_FLAGS)); }
    bool HasPlayerFlag(PlayerFlags flags) const { return HasFlag(PLAYER_FLAGS, flags) != 0; }
    void SetPlayerFlag(PlayerFlags flags) { SetFlag(PLAYER_FLAGS, flags); }
    void RemovePlayerFlag(PlayerFlags flags) { RemoveFlag(PLAYER_FLAGS, flags); }
    void ReplaceAllPlayerFlags(PlayerFlags flags) { SetUInt32Value(PLAYER_FLAGS, flags); }

    static bool BuildEnumData(PreparedQueryResult result, WorldPacket* data);

    [[nodiscard]] bool IsClass(Classes playerClass, ClassContext context = CLASS_CONTEXT_NONE) const override;

    void SetInWater(bool apply);

    [[nodiscard]] bool IsInWater() const override { return m_isInWater; }
    [[nodiscard]] bool IsFalling() const;
    bool IsInAreaTriggerRadius(AreaTrigger const* trigger, float delta = 0.f) const;

    void SendInitialPacketsBeforeAddToMap();
    void SendInitialPacketsAfterAddToMap();
    void SendTransferAborted(uint32 mapid, TransferAbortReason reason, uint8 arg = 0);
    void SendInstanceResetWarning(uint32 mapid, Difficulty difficulty, uint32 time, bool onEnterMap);

    bool CanInteractWithQuestGiver(Object* questGiver);
    Creature* GetNPCIfCanInteractWith(ObjectGuid guid, uint32 npcflagmask);
    [[nodiscard]] GameObject* GetGameObjectIfCanInteractWith(ObjectGuid guid, GameobjectTypes type) const;

    void ToggleAFK();
    void ToggleDND();
    [[nodiscard]] bool isAFK() const { return HasPlayerFlag(PLAYER_FLAGS_AFK); }
    [[nodiscard]] bool isDND() const { return HasPlayerFlag(PLAYER_FLAGS_DND); }
    [[nodiscard]] uint8 GetChatTag() const;
    std::string autoReplyMsg;

    uint32 GetBarberShopCost(uint8 newhairstyle, uint8 newhaircolor, uint8 newfacialhair, BarberShopStyleEntry const* newSkin = nullptr);

    PlayerSocial* GetSocial() { return m_social; }

    PlayerTaxi m_taxi;
    void InitTaxiNodesForLevel() { m_taxi.InitTaxiNodesForLevel(getRace(), getClass(), GetLevel()); }
    bool ActivateTaxiPathTo(std::vector<uint32> const& nodes, Creature* npc = nullptr, uint32 spellid = 1);
    bool ActivateTaxiPathTo(uint32 taxi_path_id, uint32 spellid = 1);
    void CleanupAfterTaxiFlight();
    void ContinueTaxiFlight();
    void SendTaxiNodeStatusMultiple();
    // mount_id can be used in scripting calls

    [[nodiscard]] bool IsCommentator() const { return HasPlayerFlag(PLAYER_FLAGS_COMMENTATOR2); }
    void SetCommentator(bool on) { ApplyModFlag(PLAYER_FLAGS, PLAYER_FLAGS_COMMENTATOR2, on); }
    [[nodiscard]] bool IsDeveloper() const { return HasPlayerFlag(PLAYER_FLAGS_DEVELOPER); }
    void SetDeveloper(bool on) { ApplyModFlag(PLAYER_FLAGS, PLAYER_FLAGS_DEVELOPER, on); }
    [[nodiscard]] bool isAcceptWhispers() const { return m_ExtraFlags & PLAYER_EXTRA_ACCEPT_WHISPERS; }
    void SetAcceptWhispers(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_ACCEPT_WHISPERS; else m_ExtraFlags &= ~PLAYER_EXTRA_ACCEPT_WHISPERS; }
    [[nodiscard]] bool IsGameMaster() const { return m_ExtraFlags & PLAYER_EXTRA_GM_ON; }
    void SetGameMaster(bool on);
    [[nodiscard]] bool isGMChat() const { return m_ExtraFlags & PLAYER_EXTRA_GM_CHAT; }
    void SetGMChat(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_GM_CHAT; else m_ExtraFlags &= ~PLAYER_EXTRA_GM_CHAT; }
    [[nodiscard]] bool isTaxiCheater() const { return m_ExtraFlags & PLAYER_EXTRA_TAXICHEAT; }
    void SetTaxiCheater(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_TAXICHEAT; else m_ExtraFlags &= ~PLAYER_EXTRA_TAXICHEAT; }
    [[nodiscard]] bool isGMVisible() const { return !(m_ExtraFlags & PLAYER_EXTRA_GM_INVISIBLE); }
    void SetGMVisible(bool on);
    bool Has310Flyer(bool checkAllSpells, uint32 excludeSpellId = 0);
    void SetHas310Flyer(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_HAS_310_FLYER; else m_ExtraFlags &= ~PLAYER_EXTRA_HAS_310_FLYER; }
    void SetPvPDeath(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_PVP_DEATH; else m_ExtraFlags &= ~PLAYER_EXTRA_PVP_DEATH; }

    void GiveXP(uint32 xp, Unit* victim, float group_rate = 1.0f, bool isLFGReward = false);
    void GiveLevel(uint8 level);

    void InitStatsForLevel(bool reapplyMods = false);

    [[nodiscard]] bool HasActivePowerType(Powers power) override;

    // .cheat command related
    [[nodiscard]] bool GetCommandStatus(uint32 command) const { return _activeCheats & command; }
    void SetCommandStatusOn(uint32 command) { _activeCheats |= command; }
    void SetCommandStatusOff(uint32 command) { _activeCheats &= ~command; }

    // Played Time Stuff
    time_t m_logintime;
    time_t m_Last_tick;
    uint32 m_Played_time[MAX_PLAYED_TIME_INDEX];
    uint32 GetTotalPlayedTime() { return m_Played_time[PLAYED_TIME_TOTAL]; }
    uint32 GetLevelPlayedTime() { return m_Played_time[PLAYED_TIME_LEVEL]; }

    void setDeathState(DeathState s, bool despawn = false) override;                   // overwrite Unit::setDeathState

    void SetRestState(uint32 triggerId);
    void RemoveRestState();
    uint32 GetXPRestBonus(uint32 xp);
    [[nodiscard]] float GetRestBonus() const { return _restBonus; }
    void SetRestBonus(float rest_bonus_new);

    [[nodiscard]] bool HasRestFlag(RestFlag restFlag) const { return (_restFlagMask & restFlag) != 0; }
    void SetRestFlag(RestFlag restFlag, uint32 triggerId = 0);
    void RemoveRestFlag(RestFlag restFlag);
    [[nodiscard]] uint32 GetInnTriggerId() const { return _innTriggerId; }

    PetStable* GetPetStable() { return m_petStable.get(); }
    PetStable& GetOrInitPetStable();
    [[nodiscard]] PetStable const* GetPetStable() const { return m_petStable.get(); }

    [[nodiscard]] Pet* GetPet() const;
    Pet* SummonPet(uint32 entry, float x, float y, float z, float ang, PetType petType, Milliseconds duration = 0s, uint32 healthPct = 0);
    void RemovePet(Pet* pet, PetSaveMode mode, bool returnreagent = false);
    bool CanPetResurrect();
    bool IsExistPet();
    Pet* CreatePet(Creature* creatureTarget, uint32 spellID = 0);
    Pet* CreatePet(uint32 creatureEntry, uint32 spellID = 0);

    [[nodiscard]] uint32 GetPhaseMaskForSpawn() const;                // used for proper set phase for DB at GM-mode creature/GO spawn

    /// Handles said message in regular chat based on declared language and in config pre-defined Range.
    void Say(std::string_view text, Language language, WorldObject const* = nullptr) override;
    void Say(uint32 textId, WorldObject const* target = nullptr) override;
    /// Handles yelled message in regular chat based on declared language and in config pre-defined Range.
    void Yell(std::string_view text, Language language, WorldObject const* = nullptr) override;
    void Yell(uint32 textId, WorldObject const* target = nullptr) override;
    /// Outputs an universal text which is supposed to be an action.
    void TextEmote(std::string_view text, WorldObject const* = nullptr, bool = false) override;
    void TextEmote(uint32 textId, WorldObject const* target = nullptr, bool isBossEmote = false) override;
    /// Handles whispers from Addons and players based on sender, receiver's guid and language.
    void Whisper(std::string_view text, Language language, Player* receiver, bool = false) override;
    void Whisper(uint32 textId, Player* target, bool isBossWhisper = false) override;

    /*********************************************************/
    /***                    STORAGE SYSTEM                 ***/
    /*********************************************************/

    void SetVirtualItemSlot(uint8 i, Item* item);
    void SetSheath(SheathState sheathed) override;             // overwrite Unit version
    uint8 FindEquipSlot(ItemTemplate const* proto, uint32 slot, bool swap) const;
    uint32 GetItemCount(uint32 item, bool inBankAlso = false, Item* skipItem = nullptr) const;
    uint32 GetItemCountWithLimitCategory(uint32 limitCategory, Item* skipItem = nullptr) const;
    [[nodiscard]] Item* GetItemByGuid(ObjectGuid guid) const;
    [[nodiscard]] Item* GetItemByEntry(uint32 entry) const;
    [[nodiscard]] Item* GetItemByPos(uint16 pos) const;
    [[nodiscard]] Item* GetItemByPos(uint8 bag, uint8 slot) const;
    [[nodiscard]] Bag*  GetBagByPos(uint8 slot) const;
    [[nodiscard]] uint32 GetFreeInventorySpace() const;
    [[nodiscard]] inline Item* GetUseableItemByPos(uint8 bag, uint8 slot) const //Does additional check for disarmed weapons
    {
        if (!CanUseAttackType(GetAttackBySlot(slot)))
            return nullptr;
        return GetItemByPos(bag, slot);
    }
    [[nodiscard]] Item* GetWeaponForAttack(WeaponAttackType attackType, bool useable = false) const;
    [[nodiscard]] Item* GetShield(bool useable = false) const;
    static uint8 GetAttackBySlot(uint8 slot);        // MAX_ATTACK if not weapon slot
    std::vector<Item*>& GetItemUpdateQueue() { return m_itemUpdateQueue; }
    static bool IsInventoryPos(uint16 pos) { return IsInventoryPos(pos >> 8, pos & 255); }
    static bool IsInventoryPos(uint8 bag, uint8 slot);
    static bool IsEquipmentPos(uint16 pos) { return IsEquipmentPos(pos >> 8, pos & 255); }
    static bool IsEquipmentPos(uint8 bag, uint8 slot);
    static bool IsBagPos(uint16 pos);
    static bool IsBankPos(uint16 pos) { return IsBankPos(pos >> 8, pos & 255); }
    static bool IsBankPos(uint8 bag, uint8 slot);
    bool IsValidPos(uint16 pos, bool explicit_pos) { return IsValidPos(pos >> 8, pos & 255, explicit_pos); }
    bool IsValidPos(uint8 bag, uint8 slot, bool explicit_pos);
    [[nodiscard]] uint8 GetBankBagSlotCount() const { return GetByteValue(PLAYER_BYTES_2, 2); }
    void SetBankBagSlotCount(uint8 count) { SetByteValue(PLAYER_BYTES_2, 2, count); }
    [[nodiscard]] bool HasItemCount(uint32 item, uint32 count = 1, bool inBankAlso = false) const;
    bool HasItemFitToSpellRequirements(SpellInfo const* spellInfo, Item const* ignoreItem = nullptr) const;
    bool CanNoReagentCast(SpellInfo const* spellInfo) const;
    [[nodiscard]] bool HasItemOrGemWithIdEquipped(uint32 item, uint32 count, uint8 except_slot = NULL_SLOT) const;
    [[nodiscard]] bool HasItemOrGemWithLimitCategoryEquipped(uint32 limitCategory, uint32 count, uint8 except_slot = NULL_SLOT) const;
    InventoryResult CanTakeMoreSimilarItems(Item* pItem) const { return CanTakeMoreSimilarItems(pItem->GetEntry(), pItem->GetCount(), pItem); }
    [[nodiscard]] InventoryResult CanTakeMoreSimilarItems(uint32 entry, uint32 count) const { return CanTakeMoreSimilarItems(entry, count, nullptr); }
    InventoryResult CanStoreNewItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, uint32 item, uint32 count, uint32* no_space_count = nullptr) const
    {
        return CanStoreItem(bag, slot, dest, item, count, nullptr, false, no_space_count);
    }
    InventoryResult CanStoreItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, Item* pItem, bool swap = false) const
    {
        if (!pItem)
            return EQUIP_ERR_ITEM_NOT_FOUND;
        uint32 count = pItem->GetCount();
        return CanStoreItem(bag, slot, dest, pItem->GetEntry(), count, pItem, swap, nullptr);
    }
    InventoryResult CanStoreItems(Item** pItem, int32 count) const;
    InventoryResult CanEquipNewItem(uint8 slot, uint16& dest, uint32 item, bool swap) const;
    InventoryResult CanEquipItem(uint8 slot, uint16& dest, Item* pItem, bool swap, bool not_loading = true) const;

    InventoryResult CanEquipUniqueItem(Item* pItem, uint8 except_slot = NULL_SLOT, uint32 limit_count = 1) const;
    InventoryResult CanEquipUniqueItem(ItemTemplate const* itemProto, uint8 except_slot = NULL_SLOT, uint32 limit_count = 1) const;
    [[nodiscard]] InventoryResult CanUnequipItems(uint32 item, uint32 count) const;
    [[nodiscard]] InventoryResult CanUnequipItem(uint16 src, bool swap) const;
    InventoryResult CanBankItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, Item* pItem, bool swap, bool not_loading = true) const;
    InventoryResult CanUseItem(Item* pItem, bool not_loading = true) const;
    [[nodiscard]] bool HasItemTotemCategory(uint32 TotemCategory) const;
    bool IsTotemCategoryCompatiableWith(ItemTemplate const* pProto, uint32 requiredTotemCategoryId) const;
    InventoryResult CanUseItem(ItemTemplate const* pItem) const;
    [[nodiscard]] InventoryResult CanUseAmmo(uint32 item) const;
    InventoryResult CanRollForItemInLFG(ItemTemplate const* item, WorldObject const* lootedObject) const;
    Item* StoreNewItem(ItemPosCountVec const& pos, uint32 item, bool update, int32 randomPropertyId = 0);
    Item* StoreNewItem(ItemPosCountVec const& pos, uint32 item, bool update, int32 randomPropertyId, AllowedLooterSet& allowedLooters);
    Item* StoreItem(ItemPosCountVec const& pos, Item* pItem, bool update);
    Item* EquipNewItem(uint16 pos, uint32 item, bool update);
    Item* EquipItem(uint16 pos, Item* pItem, bool update);
    void AutoUnequipOffhandIfNeed(bool force = false);
    bool StoreNewItemInBestSlots(uint32 item_id, uint32 item_count);
    void AutoStoreLoot(uint8 bag, uint8 slot, uint32 loot_id, LootStore const& store, bool broadcast = false);
    void AutoStoreLoot(uint32 loot_id, LootStore const& store, bool broadcast = false) { AutoStoreLoot(NULL_BAG, NULL_SLOT, loot_id, store, broadcast); }
    LootItem* StoreLootItem(uint8 lootSlot, Loot* loot, InventoryResult& msg);
    void UpdateLootAchievements(LootItem* item, Loot* loot);
    void UpdateTitansGrip();

    InventoryResult CanTakeMoreSimilarItems(uint32 entry, uint32 count, Item* pItem, uint32* no_space_count = nullptr) const;
    InventoryResult CanStoreItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, uint32 entry, uint32 count, Item* pItem = nullptr, bool swap = false, uint32* no_space_count = nullptr) const;

    void AddRefundReference(ObjectGuid itemGUID);
    void DeleteRefundReference(ObjectGuid itemGUID);

    void ApplyEquipCooldown(Item* pItem);
    void SetAmmo(uint32 item);
    void RemoveAmmo();
    [[nodiscard]] float GetAmmoDPS() const { return m_ammoDPS; }
    bool CheckAmmoCompatibility(ItemTemplate const* ammo_proto) const;
    void QuickEquipItem(uint16 pos, Item* pItem);
    void VisualizeItem(uint8 slot, Item* pItem);
    void SetVisibleItemSlot(uint8 slot, Item* pItem);
    Item* BankItem(ItemPosCountVec const& dest, Item* pItem, bool update)
    {
        return StoreItem(dest, pItem, update);
    }
    Item* BankItem(uint16 pos, Item* pItem, bool update);
    void RemoveItem(uint8 bag, uint8 slot, bool update, bool swap = false);
    void MoveItemFromInventory(uint8 bag, uint8 slot, bool update);
    // in trade, auction, guild bank, mail....
    void MoveItemToInventory(ItemPosCountVec const& dest, Item* pItem, bool update, bool in_characterInventoryDB = false);
    // in trade, guild bank, mail....
    void RemoveItemDependentAurasAndCasts(Item* pItem);
    void DestroyItem(uint8 bag, uint8 slot, bool update);
    void DestroyItemCount(uint32 item, uint32 count, bool update, bool unequip_check = false);
    void DestroyItemCount(Item* item, uint32& count, bool update);
    void DestroyConjuredItems(bool update);
    void DestroyZoneLimitedItem(bool update, uint32 new_zone);
    void SplitItem(uint16 src, uint16 dst, uint32 count);
    void SwapItem(uint16 src, uint16 dst);
    void AddItemToBuyBackSlot(Item* pItem, uint32 money);
    Item* GetItemFromBuyBackSlot(uint32 slot);
    void RemoveItemFromBuyBackSlot(uint32 slot, bool del);
    [[nodiscard]] uint32 GetMaxKeyringSize() const { return KEYRING_SLOT_END - KEYRING_SLOT_START; }
    void SendEquipError(InventoryResult msg, Item* pItem, Item* pItem2 = nullptr, uint32 itemid = 0);
    void SendBuyError(BuyResult msg, Creature* creature, uint32 item, uint32 param);
    void SendSellError(SellResult msg, Creature* creature, ObjectGuid guid, uint32 param);
    void AddWeaponProficiency(uint32 newflag) { m_WeaponProficiency |= newflag; }
    void AddArmorProficiency(uint32 newflag) { m_ArmorProficiency |= newflag; }
    [[nodiscard]] uint32 GetWeaponProficiency() const { return m_WeaponProficiency; }
    [[nodiscard]] uint32 GetArmorProficiency() const { return m_ArmorProficiency; }

    [[nodiscard]] bool IsTwoHandUsed() const
    {
        Item* mainItem = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);
        return mainItem && mainItem->GetTemplate()->InventoryType == INVTYPE_2HWEAPON && !CanTitanGrip();
    }
    void SendNewItem(Item* item, uint32 count, bool received, bool created, bool broadcast = false, bool sendChatMessage = true);
    bool BuyItemFromVendorSlot(ObjectGuid vendorguid, uint32 vendorslot, uint32 item, uint8 count, uint8 bag, uint8 slot);
    bool _StoreOrEquipNewItem(uint32 vendorslot, uint32 item, uint8 count, uint8 bag, uint8 slot, int32 price, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore);

    [[nodiscard]] float GetReputationPriceDiscount(Creature const* creature) const;
    [[nodiscard]] float GetReputationPriceDiscount(FactionTemplateEntry const* factionTemplate) const;

    [[nodiscard]] Player* GetTrader() const { return m_trade ? m_trade->GetTrader() : nullptr; }
    [[nodiscard]] TradeData* GetTradeData() const { return m_trade; }
    void TradeCancel(bool sendback);

    CinematicMgr* GetCinematicMgr() const { return _cinematicMgr; }

    void UpdateEnchantTime(uint32 time);
    void UpdateSoulboundTradeItems();
    void AddTradeableItem(Item* item);
    void RemoveTradeableItem(Item* item);
    void UpdateItemDuration(uint32 time, bool realtimeonly = false);
    void AddEnchantmentDurations(Item* item);
    void RemoveEnchantmentDurations(Item* item);
    void RemoveEnchantmentDurationsReferences(Item* item); // pussywizard
    void RemoveArenaEnchantments(EnchantmentSlot slot);
    void AddEnchantmentDuration(Item* item, EnchantmentSlot slot, uint32 duration);
    void ApplyEnchantment(Item* item, EnchantmentSlot slot, bool apply, bool apply_dur = true, bool ignore_condition = false);
    void ApplyEnchantment(Item* item, bool apply);
    void UpdateSkillEnchantments(uint16 skill_id, uint16 curr_value, uint16 new_value);
    void SendEnchantmentDurations();
    void UpdateEnchantmentDurations();
    void BuildEnchantmentsInfoData(WorldPacket* data);
    void AddItemDurations(Item* item);
    void RemoveItemDurations(Item* item);
    void SendItemDurations();
    void LoadCorpse(PreparedQueryResult result);
    void LoadPet();

    bool AddItem(uint32 itemId, uint32 count);

    /*********************************************************/
    /***                    GOSSIP SYSTEM                  ***/
    /*********************************************************/

    void PrepareGossipMenu(WorldObject* source, uint32 menuId = 0, bool showQuests = false);
    void SendPreparedGossip(WorldObject* source);
    void OnGossipSelect(WorldObject* source, uint32 gossipListId, uint32 menuId);

    uint32 GetGossipTextId(uint32 menuId, WorldObject* source);
    uint32 GetGossipTextId(WorldObject* source);
    static uint32 GetDefaultGossipMenuForSource(WorldObject* source);

    void ToggleInstantFlight();

    /*********************************************************/
    /***                    QUEST SYSTEM                   ***/
    /*********************************************************/

    int32 GetQuestLevel(Quest const* quest) const { return quest && (quest->GetQuestLevel() > 0) ? quest->GetQuestLevel() : GetLevel(); }

    void PrepareQuestMenu(ObjectGuid guid);
    void SendPreparedQuest(ObjectGuid guid);
    [[nodiscard]] bool IsActiveQuest(uint32 quest_id) const;
    Quest const* GetNextQuest(ObjectGuid guid, Quest const* quest);
    bool CanSeeStartQuest(Quest const* quest);
    bool CanTakeQuest(Quest const* quest, bool msg);
    bool CanAddQuest(Quest const* quest, bool msg);
    bool CanCompleteQuest(uint32 quest_id, const QuestStatusData* q_savedStatus = nullptr);
    bool CanCompleteRepeatableQuest(Quest const* quest);
    bool CanRewardQuest(Quest const* quest, bool msg);
    bool CanRewardQuest(Quest const* quest, uint32 reward, bool msg);
    void AddQuestAndCheckCompletion(Quest const* quest, Object* questGiver);
    void AddQuest(Quest const* quest, Object* questGiver);
    void AbandonQuest(uint32 quest_id);
    void CompleteQuest(uint32 quest_id);
    void IncompleteQuest(uint32 quest_id);
    void RewardQuest(Quest const* quest, uint32 reward, Object* questGiver, bool announce = true, bool isLFGReward = false);
    void FailQuest(uint32 quest_id);
    bool SatisfyQuestSkill(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestLevel(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestLog(bool msg);
    bool SatisfyQuestPreviousQuest(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestClass(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestRace(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestReputation(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestStatus(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestConditions(Quest const* qInfo, bool msg);
    bool SatisfyQuestTimed(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestExclusiveGroup(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestNextChain(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestPrevChain(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestDay(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestWeek(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestMonth(Quest const* qInfo, bool msg) const;
    bool SatisfyQuestSeasonal(Quest const* qInfo, bool msg) const;
    bool GiveQuestSourceItem(Quest const* quest);
    bool TakeQuestSourceItem(uint32 questId, bool msg);
    [[nodiscard]] bool GetQuestRewardStatus(uint32 quest_id) const;
    [[nodiscard]] QuestStatus GetQuestStatus(uint32 quest_id) const;
    void SetQuestStatus(uint32 questId, QuestStatus status, bool update = true);
    void RemoveActiveQuest(uint32 questId, bool update = true);
    void RemoveRewardedQuest(uint32 questId, bool update = true);
    void SendQuestUpdate(uint32 questId);
    QuestGiverStatus GetQuestDialogStatus(Object* questGiver);
    float GetQuestRate(bool isDFQuest = false);
    void SetDailyQuestStatus(uint32 quest_id);
    bool IsDailyQuestDone(uint32 quest_id);
    void SetWeeklyQuestStatus(uint32 quest_id);
    void SetMonthlyQuestStatus(uint32 quest_id);
    void SetSeasonalQuestStatus(uint32 quest_id);
    void ResetDailyQuestStatus();
    void ResetWeeklyQuestStatus();
    void ResetMonthlyQuestStatus();
    void ResetSeasonalQuestStatus(uint16 event_id);

    [[nodiscard]] uint16 FindQuestSlot(uint32 quest_id) const;
    [[nodiscard]] uint32 GetQuestSlotQuestId(uint16 slot) const { return GetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_ID_OFFSET); }
    [[nodiscard]] uint32 GetQuestSlotState(uint16 slot)   const { return GetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_STATE_OFFSET); }
    [[nodiscard]] uint16 GetQuestSlotCounter(uint16 slot, uint8 counter) const { return (uint16)(GetUInt64Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_COUNTS_OFFSET) >> (counter * 16)); }
    [[nodiscard]] uint32 GetQuestSlotTime(uint16 slot)    const { return GetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_TIME_OFFSET); }
    void SetQuestSlot(uint16 slot, uint32 quest_id, uint32 timer = 0)
    {
        SetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_ID_OFFSET, quest_id);
        SetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_STATE_OFFSET, 0);
        SetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_COUNTS_OFFSET, 0);
        SetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_COUNTS_OFFSET + 1, 0);
        SetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_TIME_OFFSET, timer);
    }
    void SetQuestSlotCounter(uint16 slot, uint8 counter, uint16 count)
    {
        uint64 val = GetUInt64Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_COUNTS_OFFSET);
        val &= ~((uint64)0xFFFF << (counter * 16));
        val |= ((uint64)count << (counter * 16));
        SetUInt64Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_COUNTS_OFFSET, val);
    }
    void SetQuestSlotState(uint16 slot, uint32 state) { SetFlag(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_STATE_OFFSET, state); }
    void RemoveQuestSlotState(uint16 slot, uint32 state) { RemoveFlag(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_STATE_OFFSET, state); }
    void SetQuestSlotTimer(uint16 slot, uint32 timer) { SetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_TIME_OFFSET, timer); }
    void SwapQuestSlot(uint16 slot1, uint16 slot2)
    {
        for (int i = 0; i < MAX_QUEST_OFFSET; ++i)
        {
            uint32 temp1 = GetUInt32Value(PLAYER_QUEST_LOG_1_1 + MAX_QUEST_OFFSET * slot1 + i);
            uint32 temp2 = GetUInt32Value(PLAYER_QUEST_LOG_1_1 + MAX_QUEST_OFFSET * slot2 + i);

            SetUInt32Value(PLAYER_QUEST_LOG_1_1 + MAX_QUEST_OFFSET * slot1 + i, temp2);
            SetUInt32Value(PLAYER_QUEST_LOG_1_1 + MAX_QUEST_OFFSET * slot2 + i, temp1);
        }
    }
    uint16 GetReqKillOrCastCurrentCount(uint32 quest_id, int32 entry);
    void AreaExploredOrEventHappens(uint32 questId);
    void GroupEventHappens(uint32 questId, WorldObject const* pEventObject);
    void ItemAddedQuestCheck(uint32 entry, uint32 count);
    void ItemRemovedQuestCheck(uint32 entry, uint32 count);
    void KilledMonster(CreatureTemplate const* cInfo, ObjectGuid guid);
    void KilledMonsterCredit(uint32 entry, ObjectGuid guid = ObjectGuid::Empty);
    void KilledPlayerCredit(uint16 count = 1);
    void KilledPlayerCreditForQuest(uint16 count, Quest const* quest);
    void KillCreditGO(uint32 entry, ObjectGuid guid = ObjectGuid::Empty);
    void TalkedToCreature(uint32 entry, ObjectGuid guid);
    void MoneyChanged(uint32 value);
    void ReputationChanged(FactionEntry const* factionEntry);
    void ReputationChanged2(FactionEntry const* factionEntry);
    [[nodiscard]] bool HasQuestForItem(uint32 itemId, uint32 excludeQuestId = 0, bool turnIn = false, bool* showInLoot = nullptr) const;
    [[nodiscard]] bool HasQuestForGO(int32 GOId) const;
    [[nodiscard]] bool HasQuest(uint32 questId) const;
    void UpdateForQuestWorldObjects();
    [[nodiscard]] bool CanShareQuest(uint32 quest_id) const;

    void SendQuestComplete(uint32 quest_id);
    void SendQuestReward(Quest const* quest, uint32 XP);
    void SendQuestFailed(uint32 questId, InventoryResult reason = EQUIP_ERR_OK);
    void SendQuestTimerFailed(uint32 quest_id);
    void SendCanTakeQuestResponse(uint32 msg) const;
    void SendQuestConfirmAccept(Quest const* quest, Player* pReceiver);
    void SendPushToPartyResponse(Player const* player, uint8 msg) const;
    void SendQuestUpdateAddItem(Quest const* quest, uint32 item_idx, uint16 count);
    void SendQuestUpdateAddCreatureOrGo(Quest const* quest, ObjectGuid guid, uint32 creatureOrGO_idx, uint16 old_count, uint16 add_count);
    void SendQuestUpdateAddPlayer(Quest const* quest, uint16 old_count, uint16 add_count);

    ObjectGuid GetDivider() { return m_divider; }
    void SetDivider(ObjectGuid guid = ObjectGuid::Empty) { m_divider = guid; }

    uint32 GetInGameTime() { return m_ingametime; }

    void SetInGameTime(uint32 time) { m_ingametime = time; }

    void AddTimedQuest(uint32 quest_id) { m_timedquests.insert(quest_id); }
    void RemoveTimedQuest(uint32 quest_id) { m_timedquests.erase(quest_id); }

    [[nodiscard]] bool HasPvPForcingQuest() const;

    /*********************************************************/
    /***                   LOAD SYSTEM                     ***/
    /*********************************************************/

    bool LoadFromDB(ObjectGuid guid, CharacterDatabaseQueryHolder const& holder);
    [[nodiscard]] bool isBeingLoaded() const override;

    void Initialize(ObjectGuid::LowType guid);
    static uint32 GetZoneIdFromDB(ObjectGuid guid);
    static bool   LoadPositionFromDB(uint32& mapid, float& x, float& y, float& z, float& o, bool& in_flight, ObjectGuid::LowType guid);

    static bool IsValidGender(uint8 Gender) { return Gender <= GENDER_FEMALE; }

    /*********************************************************/
    /***                   SAVE SYSTEM                     ***/
    /*********************************************************/

    void SaveToDB(bool create, bool logout);
    void SaveToDB(CharacterDatabaseTransaction trans, bool create, bool logout);
    void SaveInventoryAndGoldToDB(CharacterDatabaseTransaction trans);                    // fast save function for item/money cheating preventing
    void SaveGoldToDB(CharacterDatabaseTransaction trans);
    void _SaveSkills(CharacterDatabaseTransaction trans);

    static void Customize(CharacterCustomizeInfo const* customizeInfo, CharacterDatabaseTransaction trans);
    static void SavePositionInDB(uint32 mapid, float x, float y, float z, float o, uint32 zone, ObjectGuid guid);
    static void SavePositionInDB(WorldLocation const& loc, uint16 zoneId, ObjectGuid guid, CharacterDatabaseTransaction trans);

    static void DeleteFromDB(ObjectGuid::LowType lowGuid, uint32 accountId, bool updateRealmChars, bool deleteFinally);
    static void DeleteOldCharacters();
    static void DeleteOldCharacters(uint32 keepDays);

    bool m_mailsUpdated;

    void SetBindPoint(ObjectGuid guid);
    void SendTalentWipeConfirm(ObjectGuid guid);
    void ResetPetTalents();
    void CalcRage(uint32 damage, bool attacker);
    void RegenerateAll();
    void Regenerate(Powers power);
    void RegenerateHealth();
    void setRegenTimerCount(uint32 time) {m_regenTimerCount = time;}
    void setWeaponChangeTimer(uint32 time) {m_weaponChangeTimer = time;}

    [[nodiscard]] uint32 GetMoney() const { return GetUInt32Value(PLAYER_FIELD_COINAGE); }
    bool ModifyMoney(int32 amount, bool sendError = true);
    [[nodiscard]] bool HasEnoughMoney(uint32 amount) const { return (GetMoney() >= amount); }
    [[nodiscard]] bool HasEnoughMoney(int32 amount) const
    {
        if (amount > 0)
            return (GetMoney() >= (uint32) amount);
        return true;
    }

    void SetMoney(uint32 value)
    {
        SetUInt32Value(PLAYER_FIELD_COINAGE, value);
        MoneyChanged(value);
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_GOLD_VALUE_OWNED);
    }

    [[nodiscard]] RewardedQuestSet const& getRewardedQuests() const { return m_RewardedQuests; }
    QuestStatusMap& getQuestStatusMap() { return m_QuestStatus; }
    QuestStatusSaveMap& GetQuestStatusSaveMap() { return m_QuestStatusSave; }

    [[nodiscard]] size_t GetRewardedQuestCount() const { return m_RewardedQuests.size(); }
    [[nodiscard]] bool IsQuestRewarded(uint32 quest_id) const
    {
        return m_RewardedQuests.find(quest_id) != m_RewardedQuests.end();
    }

    [[nodiscard]] Unit* GetSelectedUnit() const;
    [[nodiscard]] Player* GetSelectedPlayer() const;

    void SetTarget(ObjectGuid /*guid*/ = ObjectGuid::Empty) override { } /// Used for serverside target changes, does not apply to players
    void SetSelection(ObjectGuid guid);

    void SendMailResult(uint32 mailId, MailResponseType mailAction, MailResponseResult mailError, uint32 equipError = 0, ObjectGuid::LowType item_guid = 0, uint32 item_count = 0);
    void SendNewMail();
    void UpdateNextMailTimeAndUnreads();
    void AddNewMailDeliverTime(time_t deliver_time);

    void RemoveMail(uint32 id);

    void AddMail(Mail* mail) { m_mail.push_front(mail); }// for call from WorldSession::SendMailTo
    uint32 GetMailSize() { return m_mail.size();}
    Mail* GetMail(uint32 id);

    [[nodiscard]] PlayerMails const& GetMails() const { return m_mail; }
    void SendItemRetrievalMail(uint32 itemEntry, uint32 count); // Item retrieval mails sent by The Postmaster (34337)
    void SendItemRetrievalMail(std::vector<std::pair<uint32, uint32>> mailItems); // Item retrieval mails sent by The Postmaster (34337)

    /*********************************************************/
    /*** MAILED ITEMS SYSTEM ***/
    /*********************************************************/

    uint8 unReadMails;
    time_t m_nextMailDelivereTime;

    typedef std::unordered_map<ObjectGuid::LowType, Item*> ItemMap;

    ItemMap mMitems;                                    //template defined in objectmgr.cpp

    Item* GetMItem(ObjectGuid::LowType itemLowGuid)
    {
        ItemMap::const_iterator itr = mMitems.find(itemLowGuid);
        return itr != mMitems.end() ? itr->second : nullptr;
    }

    void AddMItem(Item* it)
    {
        ASSERT(it);
        //ASSERT deleted, because items can be added before loading
        mMitems[it->GetGUID().GetCounter()] = it;
    }

    bool RemoveMItem(ObjectGuid::LowType itemLowGuid)
    {
        return !!mMitems.erase(itemLowGuid);
    }

    void PetSpellInitialize();
    void CharmSpellInitialize();
    void PossessSpellInitialize();
    void VehicleSpellInitialize();
    void SendRemoveControlBar();
    [[nodiscard]] bool HasSpell(uint32 spell) const override;
    [[nodiscard]] bool HasActiveSpell(uint32 spell) const;            // show in spellbook
    TrainerSpellState GetTrainerSpellState(TrainerSpell const* trainer_spell) const;
    [[nodiscard]] bool IsSpellFitByClassAndRace(uint32 spell_id) const;
    bool IsNeedCastPassiveSpellAtLearn(SpellInfo const* spellInfo) const;

    void SendProficiency(ItemClass itemClass, uint32 itemSubclassMask);
    void SendInitialSpells();
    void SendLearnPacket(uint32 spellId, bool learn);
    bool addSpell(uint32 spellId, uint8 addSpecMask, bool updateActive, bool temporary = false, bool learnFromSkill = false);
    bool _addSpell(uint32 spellId, uint8 addSpecMask, bool temporary, bool learnFromSkill = false);
    void learnSpell(uint32 spellId, bool temporary = false, bool learnFromSkill = false);
    void removeSpell(uint32 spellId, uint8 removeSpecMask, bool onlyTemporary);
    void resetSpells();
    void LearnCustomSpells();
    void LearnDefaultSkills();
    void LearnDefaultSkill(uint32 skillId, uint16 rank);
    void learnQuestRewardedSpells();
    void learnQuestRewardedSpells(Quest const* quest);
    void learnSpellHighRank(uint32 spellid);
    void SetReputation(uint32 factionentry, float value);
    [[nodiscard]] uint32 GetReputation(uint32 factionentry) const;
    std::string const& GetGuildName();
    [[nodiscard]] uint32 GetFreeTalentPoints() const { return GetUInt32Value(PLAYER_CHARACTER_POINTS1); }
    void SetFreeTalentPoints(uint32 points);
    bool resetTalents(bool noResetCost = false);
    [[nodiscard]] uint32 resetTalentsCost() const;
    bool IsMaxLevel() const;
    void InitTalentForLevel();
    void BuildPlayerTalentsInfoData(WorldPacket* data);
    void BuildPetTalentsInfoData(WorldPacket* data);
    void SendTalentsInfoData(bool pet);
    void LearnTalent(uint32 talentId, uint32 talentRank, bool command = false);
    void LearnPetTalent(ObjectGuid petGuid, uint32 talentId, uint32 talentRank);

    bool addTalent(uint32 spellId, uint8 addSpecMask, uint8 oldTalentRank);
    void _removeTalent(PlayerTalentMap::iterator& itr, uint8 specMask);
    void _removeTalent(uint32 spellId, uint8 specMask);
    void _removeTalentAurasAndSpells(uint32 spellId);
    void _addTalentAurasAndSpells(uint32 spellId);
    [[nodiscard]] bool HasTalent(uint32 spell_id, uint8 spec) const;

    [[nodiscard]] uint32 CalculateTalentsPoints() const;

    // Dual Spec
    void UpdateSpecCount(uint8 count);
    [[nodiscard]] uint8 GetActiveSpec() const { return m_activeSpec; }
    [[nodiscard]] uint8 GetActiveSpecMask() const { return (1 << m_activeSpec); }
    void SetActiveSpec(uint8 spec) { m_activeSpec = spec; }
    [[nodiscard]] uint8 GetSpecsCount() const { return m_specsCount; }
    void SetSpecsCount(uint8 count) { m_specsCount = count; }
    void ActivateSpec(uint8 spec);
    void LoadActions(PreparedQueryResult result);
    void GetTalentTreePoints(uint8 (&specPoints)[3]) const;
    [[nodiscard]] uint8 GetMostPointsTalentTree() const;
    bool HasTankSpec();
    bool HasMeleeSpec();
    bool HasCasterSpec();
    bool HasHealSpec();
    uint32 GetSpec(int8 spec = -1);

    void InitGlyphsForLevel();
    void SetGlyphSlot(uint8 slot, uint32 slottype) { SetUInt32Value(PLAYER_FIELD_GLYPH_SLOTS_1 + slot, slottype); }
    [[nodiscard]] uint32 GetGlyphSlot(uint8 slot) const { return GetUInt32Value(PLAYER_FIELD_GLYPH_SLOTS_1 + slot); }
    void SetGlyph(uint8 slot, uint32 glyph, bool save)
    {
        m_Glyphs[m_activeSpec][slot] = glyph;
        SetUInt32Value(PLAYER_FIELD_GLYPHS_1 + slot, glyph);

        if (save)
            SetNeedToSaveGlyphs(true);
    }
    [[nodiscard]] uint32 GetGlyph(uint8 slot) const { return m_Glyphs[m_activeSpec][slot]; }

    [[nodiscard]] uint32 GetFreePrimaryProfessionPoints() const { return GetUInt32Value(PLAYER_CHARACTER_POINTS2); }
    void SetFreePrimaryProfessions(uint16 profs) { SetUInt32Value(PLAYER_CHARACTER_POINTS2, profs); }
    void InitPrimaryProfessions();

    [[nodiscard]] PlayerSpellMap const& GetSpellMap() const { return m_spells; }
    PlayerSpellMap&       GetSpellMap()       { return m_spells; }

    [[nodiscard]] SpellCooldowns const& GetSpellCooldownMap() const { return m_spellCooldowns; }
    SpellCooldowns&       GetSpellCooldownMap()       { return m_spellCooldowns; }

    void AddSpellMod(SpellModifier* mod, bool apply);
    bool IsAffectedBySpellmod(SpellInfo const* spellInfo, SpellModifier* mod, Spell* spell = nullptr);
    bool HasSpellMod(SpellModifier* mod, Spell* spell);
    template <class T>
    void ApplySpellMod(uint32 spellId, SpellModOp op, T& basevalue, Spell* spell = nullptr, bool temporaryPet = false);
    void RemoveSpellMods(Spell* spell);
    void RestoreSpellMods(Spell* spell, uint32 ownerAuraId = 0, Aura* aura = nullptr);
    void RestoreAllSpellMods(uint32 ownerAuraId = 0, Aura* aura = nullptr);
    void DropModCharge(SpellModifier* mod, Spell* spell);
    void SetSpellModTakingSpell(Spell* spell, bool apply);

    [[nodiscard]] bool HasSpellCooldown(uint32 spell_id) const override;
    [[nodiscard]] bool HasSpellItemCooldown(uint32 spell_id, uint32 itemid) const override;
    [[nodiscard]] uint32 GetSpellCooldownDelay(uint32 spell_id) const;
    void AddSpellAndCategoryCooldowns(SpellInfo const* spellInfo, uint32 itemId, Spell* spell = nullptr, bool infinityCooldown = false);
    void AddSpellCooldown(uint32 spell_id, uint32 itemid, uint32 end_time, bool needSendToClient = false, bool forceSendToSpectator = false) override;
    void _AddSpellCooldown(uint32 spell_id, uint16 categoryId, uint32 itemid, uint32 end_time, bool needSendToClient = false, bool forceSendToSpectator = false);
    void ModifySpellCooldown(uint32 spellId, int32 cooldown);
    void SendCooldownEvent(SpellInfo const* spellInfo, uint32 itemId = 0, Spell* spell = nullptr, bool setCooldown = true);
    void ProhibitSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs) override;
    void RemoveSpellCooldown(uint32 spell_id, bool update = false);
    void SendClearCooldown(uint32 spell_id, Unit* target);

    GlobalCooldownMgr& GetGlobalCooldownMgr() { return m_GlobalCooldownMgr; }

    void RemoveCategoryCooldown(uint32 cat);
    void RemoveArenaSpellCooldowns(bool removeActivePetCooldowns = false);
    void RemoveAllSpellCooldown();
    void _LoadSpellCooldowns(PreparedQueryResult result);
    void _SaveSpellCooldowns(CharacterDatabaseTransaction trans, bool logout);
    uint32 GetLastPotionId() { return m_lastPotionId; }
    void SetLastPotionId(uint32 item_id) { m_lastPotionId = item_id; }
    void UpdatePotionCooldown(Spell* spell = nullptr);

    void setResurrectRequestData(ObjectGuid guid, uint32 mapId, float X, float Y, float Z, uint32 health, uint32 mana)
    {
        m_resurrectGUID = guid;
        m_resurrectMap = mapId;
        m_resurrectX = X;
        m_resurrectY = Y;
        m_resurrectZ = Z;
        m_resurrectHealth = health;
        m_resurrectMana = mana;
    }
    void clearResurrectRequestData() { setResurrectRequestData(ObjectGuid::Empty, 0, 0.0f, 0.0f, 0.0f, 0, 0); }
    [[nodiscard]] bool isResurrectRequestedBy(ObjectGuid guid) const { return m_resurrectGUID && m_resurrectGUID == guid; }
    [[nodiscard]] bool isResurrectRequested() const { return m_resurrectGUID; }
    void ResurectUsingRequestData();

    [[nodiscard]] uint8 getCinematic() const
    {
        return m_cinematic;
    }
    void setCinematic(uint8 cine)
    {
        m_cinematic = cine;
    }

    ActionButton* addActionButton(uint8 button, uint32 action, uint8 type);
    void removeActionButton(uint8 button);
    ActionButton const* GetActionButton(uint8 button);
    void SendInitialActionButtons() const { SendActionButtons(1); }
    void SendActionButtons(uint32 state) const;
    bool IsActionButtonDataValid(uint8 button, uint32 action, uint8 type);

    PvPInfo pvpInfo;
    void UpdatePvPState();
    void UpdateFFAPvPState(bool reset = true);
    void SetPvP(bool state)
    {
        Unit::SetPvP(state);
        if (!m_Controlled.empty())
            for (auto& itr : m_Controlled)
                itr->SetPvP(state);
    }
    void UpdatePvP(bool state, bool _override = false);
    void UpdateZone(uint32 newZone, uint32 newArea);
    void UpdateArea(uint32 newArea);
    void SetNeedZoneUpdate(bool needUpdate) { m_needZoneUpdate = needUpdate; }

    void UpdateZoneDependentAuras(uint32 zone_id);    // zones
    void UpdateAreaDependentAuras(uint32 area_id);    // subzones

    void UpdateAfkReport(time_t currTime);
    void UpdatePvPFlag(time_t currTime);
    void UpdateFFAPvPFlag(time_t currTime);
    void UpdateContestedPvP(uint32 currTime);
    void SetContestedPvPTimer(uint32 newTime) {m_contestedPvPTimer = newTime;}
    void ResetContestedPvP()
    {
        ClearUnitState(UNIT_STATE_ATTACK_PLAYER);
        RemovePlayerFlag(PLAYER_FLAGS_CONTESTED_PVP);
        m_contestedPvPTimer = 0;
    }

    /** todo: -maybe move UpdateDuelFlag+DuelComplete to independent DuelHandler.. **/
    std::unique_ptr<DuelInfo> duel;
    void UpdateDuelFlag(time_t currTime);
    void CheckDuelDistance(time_t currTime);
    void DuelComplete(DuelCompleteType type);
    void SendDuelCountdown(uint32 counter);

    bool IsGroupVisibleFor(Player const* p) const;
    bool IsInSameGroupWith(Player const* p) const;
    bool IsInSameRaidWith(Player const* p) const { return p == this || (GetGroup() != nullptr && GetGroup() == p->GetGroup()); }
    void UninviteFromGroup();
    static void RemoveFromGroup(Group* group, ObjectGuid guid, RemoveMethod method = GROUP_REMOVEMETHOD_DEFAULT, ObjectGuid kicker = ObjectGuid::Empty, const char* reason = nullptr);
    void RemoveFromGroup(RemoveMethod method = GROUP_REMOVEMETHOD_DEFAULT) { RemoveFromGroup(GetGroup(), GetGUID(), method); }
    void SendUpdateToOutOfRangeGroupMembers();

    void SetInGuild(uint32 GuildId)
    {
        SetUInt32Value(PLAYER_GUILDID, GuildId);
        // xinef: update global storage
        sCharacterCache->UpdateCharacterGuildId(GetGUID(), GetGuildId());
    }
    void SetRank(uint8 rankId) { SetUInt32Value(PLAYER_GUILDRANK, rankId); }
    [[nodiscard]] uint8 GetRank() const { return uint8(GetUInt32Value(PLAYER_GUILDRANK)); }
    void SetGuildIdInvited(uint32 GuildId) { m_GuildIdInvited = GuildId; }
    [[nodiscard]] uint32 GetGuildId() const { return GetUInt32Value(PLAYER_GUILDID);  }
    [[nodiscard]] Guild* GetGuild() const;
    uint32 GetGuildIdInvited() { return m_GuildIdInvited; }
    static void RemovePetitionsAndSigns(ObjectGuid guid, uint32 type);

    // Arena Team
    void SetInArenaTeam(uint32 ArenaTeamId, uint8 slot, uint8 type)
    {
        SetArenaTeamInfoField(slot, ARENA_TEAM_ID, ArenaTeamId);
        SetArenaTeamInfoField(slot, ARENA_TEAM_TYPE, type);
    }
    void SetArenaTeamInfoField(uint8 slot, ArenaTeamInfoType type, uint32 value);
    [[nodiscard]] uint32 GetArenaPersonalRating(uint8 slot) const;
    static uint32 GetArenaTeamIdFromDB(ObjectGuid guid, uint8 slot);
    static void LeaveAllArenaTeams(ObjectGuid guid);
    [[nodiscard]] uint32 GetArenaTeamId(uint8 slot) const;
    void SetArenaTeamIdInvited(uint32 ArenaTeamId) { m_ArenaTeamIdInvited = ArenaTeamId; }
    uint32 GetArenaTeamIdInvited() { return m_ArenaTeamIdInvited; }

    [[nodiscard]] Difficulty GetDifficulty(bool isRaid) const { return isRaid ? m_raidDifficulty : m_dungeonDifficulty; }
    [[nodiscard]] Difficulty GetDungeonDifficulty() const { return m_dungeonDifficulty; }
    [[nodiscard]] Difficulty GetRaidDifficulty() const { return m_raidDifficulty; }
    [[nodiscard]] Difficulty GetStoredRaidDifficulty() const { return m_raidMapDifficulty; } // only for use in difficulty packet after exiting to raid map
    void SetDungeonDifficulty(Difficulty dungeon_difficulty) { m_dungeonDifficulty = dungeon_difficulty; }
    void SetRaidDifficulty(Difficulty raid_difficulty) { m_raidDifficulty = raid_difficulty; }
    void StoreRaidMapDifficulty() { m_raidMapDifficulty = GetMap()->GetDifficulty(); }

    bool UpdateSkill(uint32 skill_id, uint32 step);
    bool UpdateSkillPro(uint16 SkillId, int32 Chance, uint32 step);

    bool UpdateCraftSkill(uint32 spellid);
    bool UpdateGatherSkill(uint32 SkillId, uint32 SkillValue, uint32 RedLevel, uint32 Multiplicator = 1);
    bool UpdateFishingSkill();

    [[nodiscard]] uint32 GetBaseDefenseSkillValue() const { return GetBaseSkillValue(SKILL_DEFENSE); }
    [[nodiscard]] uint32 GetBaseWeaponSkillValue(WeaponAttackType attType) const;

    uint32 GetSpellByProto(ItemTemplate* proto);

    float GetHealthBonusFromStamina();
    float GetManaBonusFromIntellect();

    bool UpdateStats(Stats stat) override;
    bool UpdateAllStats() override;
    void ApplySpellPenetrationBonus(int32 amount, bool apply);
    void UpdateResistances(uint32 school) override;
    void UpdateArmor() override;
    void UpdateMaxHealth() override;
    void UpdateMaxPower(Powers power) override;
    void ApplyFeralAPBonus(int32 amount, bool apply);
    void UpdateAttackPowerAndDamage(bool ranged = false) override;
    void UpdateShieldBlockValue();
    void ApplySpellPowerBonus(int32 amount, bool apply);
    void UpdateSpellDamageAndHealingBonus();
    void ApplyRatingMod(CombatRating cr, int32 value, bool apply);
    void UpdateRating(CombatRating cr);
    void UpdateAllRatings();

    void CalculateMinMaxDamage(WeaponAttackType attType, bool normalized, bool addTotalPct, float& minDamage, float& maxDamage, uint8 damageIndex) override;

    void UpdateDefenseBonusesMod();
    inline void RecalculateRating(CombatRating cr) { ApplyRatingMod(cr, 0, true);}
    float GetMeleeCritFromAgility();
    void GetDodgeFromAgility(float& diminishing, float& nondiminishing);
    [[nodiscard]] float GetMissPercentageFromDefence() const;
    float GetSpellCritFromIntellect();
    float OCTRegenHPPerSpirit();
    float OCTRegenMPPerSpirit();
    [[nodiscard]] float GetRatingMultiplier(CombatRating cr) const;
    [[nodiscard]] float GetRatingBonusValue(CombatRating cr) const;
    uint32 GetBaseSpellPowerBonus() { return m_baseSpellPower; }
    [[nodiscard]] int32 GetSpellPenetrationItemMod() const { return m_spellPenetrationItemMod; }

    [[nodiscard]] float GetExpertiseDodgeOrParryReduction(WeaponAttackType attType) const;
    void UpdateBlockPercentage();
    void UpdateCritPercentage(WeaponAttackType attType);
    void UpdateAllCritPercentages();
    void UpdateParryPercentage();
    void UpdateDodgePercentage();
    void UpdateMeleeHitChances();
    void UpdateRangedHitChances();
    void UpdateSpellHitChances();

    void UpdateAllSpellCritChances();
    void UpdateSpellCritChance(uint32 school);
    void UpdateArmorPenetration(int32 amount);
    void UpdateExpertise(WeaponAttackType attType);
    void ApplyManaRegenBonus(int32 amount, bool apply);
    void ApplyHealthRegenBonus(int32 amount, bool apply);
    void UpdateManaRegen();
    void UpdateRuneRegen(RuneType rune);

    [[nodiscard]] ObjectGuid GetLootGUID() const { return m_lootGuid; }
    void SetLootGUID(ObjectGuid guid) { m_lootGuid = guid; }

    void RemovedInsignia(Player* looterPlr);

    [[nodiscard]] WorldSession* GetSession() const { return m_session; }
    void SetSession(WorldSession* sess) { m_session = sess; }

    void BuildCreateUpdateBlockForPlayer(UpdateData* data, Player* target) override;
    void DestroyForPlayer(Player* target, bool onDeath = false) const override;
    void SendLogXPGain(uint32 GivenXP, Unit* victim, uint32 BonusXP, bool recruitAFriend = false, float group_rate = 1.0f);

    // notifiers
    void SendAttackSwingCantAttack();
    void SendAttackSwingCancelAttack();
    void SendAttackSwingDeadTarget();
    void SendAttackSwingNotInRange();
    void SendAttackSwingBadFacingAttack();
    void SendAutoRepeatCancel(Unit* target);
    void SendExplorationExperience(uint32 Area, uint32 Experience);

    void SendDungeonDifficulty(bool IsInGroup);
    void SendRaidDifficulty(bool IsInGroup, int32 forcedDifficulty = -1);
    static void ResetInstances(ObjectGuid guid, uint8 method, bool isRaid);
    void SendResetInstanceSuccess(uint32 MapId);
    void SendResetInstanceFailed(uint32 reason, uint32 MapId);
    void SendResetFailedNotify(uint32 mapid);

    bool UpdatePosition(float x, float y, float z, float orientation, bool teleport = false) override;
    bool UpdatePosition(const Position& pos, bool teleport = false) { return UpdatePosition(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), teleport); }

    void ProcessTerrainStatusUpdate() override;

    void SendMessageToSet(WorldPacket const* data, bool self) const override { SendMessageToSetInRange(data, GetVisibilityRange(), self, true); } // pussywizard!
    void SendMessageToSetInRange(WorldPacket const* data, float dist, bool self, bool includeMargin = false, Player const* skipped_rcvr = nullptr) const override; // pussywizard!
    void SendMessageToSetInRange_OwnTeam(WorldPacket const* data, float dist, bool self) const; // pussywizard! param includeMargin not needed here
    void SendMessageToSet(WorldPacket const* data, Player const* skipped_rcvr) const override { SendMessageToSetInRange(data, GetVisibilityRange(), skipped_rcvr != this, true, skipped_rcvr); } // pussywizard!

    void SendTeleportAckPacket();

    [[nodiscard]] Corpse* GetCorpse() const;
    void SpawnCorpseBones(bool triggerSave = true);
    Corpse* CreateCorpse();
    void RemoveCorpse();
    void KillPlayer();
    static void OfflineResurrect(ObjectGuid const guid, CharacterDatabaseTransaction trans);
    [[nodiscard]] bool HasCorpse() const { return _corpseLocation.GetMapId() != MAPID_INVALID; }
    [[nodiscard]] WorldLocation GetCorpseLocation() const { return _corpseLocation; }
    uint32 GetResurrectionSpellId();
    void ResurrectPlayer(float restore_percent, bool applySickness = false);
    void BuildPlayerRepop();
    void RepopAtGraveyard();

    void SendDurabilityLoss();
    void DurabilityLossAll(double percent, bool inventory);
    void DurabilityLoss(Item* item, double percent);
    void DurabilityPointsLossAll(int32 points, bool inventory);
    void DurabilityPointsLoss(Item* item, int32 points);
    void DurabilityPointLossForEquipSlot(EquipmentSlots slot);
    uint32 DurabilityRepairAll(bool cost, float discountMod, bool guildBank);
    uint32 DurabilityRepair(uint16 pos, bool cost, float discountMod, bool guildBank);

    void UpdateMirrorTimers();
    void StopMirrorTimers()
    {
        StopMirrorTimer(FATIGUE_TIMER);
        StopMirrorTimer(BREATH_TIMER);
        StopMirrorTimer(FIRE_TIMER);
    }
    bool IsMirrorTimerActive(MirrorTimerType type) { return m_MirrorTimer[type] == getMaxTimer(type); }

    void SetMovement(PlayerMovementType pType);

    bool CanJoinConstantChannelInZone(ChatChannelsEntry const* channel, AreaTableEntry const* zone);

    void JoinedChannel(Channel* c);
    void LeftChannel(Channel* c);
    void CleanupChannels();
    void ClearChannelWatch();
    void UpdateLocalChannels(uint32 newZone);

    void UpdateDefense();
    void UpdateWeaponSkill(Unit* victim, WeaponAttackType attType, Item* item = nullptr);
    void UpdateCombatSkills(Unit* victim, WeaponAttackType attType, bool defence, Item* item = nullptr);

    void SetSkill(uint16 id, uint16 step, uint16 currVal, uint16 maxVal);
    [[nodiscard]] uint16 GetMaxSkillValue(uint32 skill) const;        // max + perm. bonus + temp bonus
    [[nodiscard]] uint16 GetPureMaxSkillValue(uint32 skill) const;    // max
    [[nodiscard]] uint16 GetSkillValue(uint32 skill) const;           // skill value + perm. bonus + temp bonus
    [[nodiscard]] uint16 GetBaseSkillValue(uint32 skill) const;       // skill value + perm. bonus
    [[nodiscard]] uint16 GetPureSkillValue(uint32 skill) const;       // skill value
    [[nodiscard]] int16 GetSkillPermBonusValue(uint32 skill) const;
    [[nodiscard]] int16 GetSkillTempBonusValue(uint32 skill) const;
    [[nodiscard]] uint16 GetSkillStep(uint16 skill) const;            // 0...6
    [[nodiscard]] bool HasSkill(uint32 skill) const;
    void learnSkillRewardedSpells(uint32 id, uint32 value);

    WorldLocation& GetTeleportDest() { return teleportStore_dest; }
    [[nodiscard]] bool IsBeingTeleported() const { return mSemaphoreTeleport_Near != 0 || mSemaphoreTeleport_Far != 0; }
    [[nodiscard]] bool IsBeingTeleportedNear() const { return mSemaphoreTeleport_Near != 0; }
    [[nodiscard]] bool IsBeingTeleportedFar() const { return mSemaphoreTeleport_Far != 0; }
    void SetSemaphoreTeleportNear(time_t tm) { mSemaphoreTeleport_Near = tm; }
    void SetSemaphoreTeleportFar(time_t tm) { mSemaphoreTeleport_Far = tm; }
    [[nodiscard]] time_t GetSemaphoreTeleportNear() const { return mSemaphoreTeleport_Near; }
    [[nodiscard]] time_t GetSemaphoreTeleportFar() const { return mSemaphoreTeleport_Far; }
    void ProcessDelayedOperations();
    [[nodiscard]] uint32 GetDelayedOperations() const { return m_DelayedOperations; }
    void ScheduleDelayedOperation(uint32 operation)
    {
        if (operation < DELAYED_END)
            m_DelayedOperations |= operation;
    }

    void CheckAreaExploreAndOutdoor();

    static TeamId TeamIdForRace(uint8 race);
    [[nodiscard]] TeamId GetTeamId(bool original = false) const { return original ? TeamIdForRace(getRace(true)) : m_team; };
    void SetFactionForRace(uint8 race);
    void setTeamId(TeamId teamid) { m_team = teamid; };

    void InitDisplayIds();

    bool IsAtGroupRewardDistance(WorldObject const* pRewardSource) const;
    bool IsAtLootRewardDistance(WorldObject const* pRewardSource) const;
    bool IsAtRecruitAFriendDistance(WorldObject const* pOther) const;
    void RewardPlayerAndGroupAtKill(Unit* victim, bool isBattleGround);
    void RewardPlayerAndGroupAtEvent(uint32 creature_id, WorldObject* pRewardSource);
    bool isHonorOrXPTarget(Unit* victim) const;

    bool GetsRecruitAFriendBonus(bool forXP);
    uint8 GetGrantableLevels() { return m_grantableLevels; }
    void SetGrantableLevels(uint8 val) { m_grantableLevels = val; }

    ReputationMgr&       GetReputationMgr()       { return *m_reputationMgr; }
    [[nodiscard]] ReputationMgr const& GetReputationMgr() const { return *m_reputationMgr; }
    [[nodiscard]] ReputationRank GetReputationRank(uint32 faction_id) const;
    void RewardReputation(Unit* victim);
    void RewardReputation(Quest const* quest);

    float CalculateReputationGain(ReputationSource source, uint32 creatureOrQuestLevel, float rep, int32 faction, bool noQuestBonus = false);

    void UpdateSkillsForLevel();
    void UpdateSkillsToMaxSkillsForLevel();             // for .levelup
    void ModifySkillBonus(uint32 skillid, int32 val, bool talent);

    /**
     * A talent point boost.
     * Usage:
     * 1). Hot update situation (occurred when character is online, like PlayerScript:OnAchiComplete):
     *     Right after calling this function, character can reward talent points by calling function player->InitTalentForLevel().
     *
     * 2). Data initing situation (like PlayerScript:OnLoadFromDB)
     */
    void RewardExtraBonusTalentPoints(uint32 bonusTalentPoints);

    /*********************************************************/
    /***                  PVP SYSTEM                       ***/
    /*********************************************************/
    void UpdateHonorFields();
    bool RewardHonor(Unit* victim, uint32 groupsize, int32 honor = -1, bool awardXP = true);
    [[nodiscard]] uint32 GetHonorPoints() const { return GetUInt32Value(PLAYER_FIELD_HONOR_CURRENCY); }
    [[nodiscard]] uint32 GetArenaPoints() const { return GetUInt32Value(PLAYER_FIELD_ARENA_CURRENCY); }
    void ModifyHonorPoints(int32 value, CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr));      //! If trans is specified, honor save query will be added to trans
    void ModifyArenaPoints(int32 value, CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr));      //! If trans is specified, arena point save query will be added to trans
    [[nodiscard]] uint32 GetMaxPersonalArenaRatingRequirement(uint32 minarenaslot) const;
    void SetHonorPoints(uint32 value);
    void SetArenaPoints(uint32 value);

    // duel health and mana reset methods
    void SaveHealthBeforeDuel()     { healthBeforeDuel = GetHealth(); }
    void SaveManaBeforeDuel()       { manaBeforeDuel = GetPower(POWER_MANA); }
    void RestoreHealthAfterDuel()   { SetHealth(healthBeforeDuel); }
    void RestoreManaAfterDuel()     { SetPower(POWER_MANA, manaBeforeDuel); }

    //End of PvP System

    [[nodiscard]] inline SpellCooldowns GetSpellCooldowns() const { return m_spellCooldowns; }

    void SetDrunkValue(uint8 newDrunkValue, uint32 itemId = 0);
    [[nodiscard]] uint8 GetDrunkValue() const { return GetByteValue(PLAYER_BYTES_3, 1); }
    [[nodiscard]] int32 GetFakeDrunkValue() const { return GetInt32Value(PLAYER_FAKE_INEBRIATION); }
    void UpdateInvisibilityDrunkDetect();
    static DrunkenState GetDrunkenstateByValue(uint8 value);

    [[nodiscard]] uint32 GetDeathTimer() const { return m_deathTimer; }
    [[nodiscard]] uint32 GetCorpseReclaimDelay(bool pvp) const;
    void UpdateCorpseReclaimDelay();
    int32 CalculateCorpseReclaimDelay(bool load = false);
    void SendCorpseReclaimDelay(uint32 delay);

    [[nodiscard]] uint32 GetShieldBlockValue() const override;                 // overwrite Unit version (virtual)
    [[nodiscard]] bool CanParry() const { return m_canParry; }
    void SetCanParry(bool value);
    [[nodiscard]] bool CanBlock() const { return m_canBlock; }
    void SetCanBlock(bool value);
    [[nodiscard]] bool CanTitanGrip() const { return m_canTitanGrip; }
    void SetCanTitanGrip(bool value);
    [[nodiscard]] bool CanTameExoticPets() const { return IsGameMaster() || HasAuraType(SPELL_AURA_ALLOW_TAME_PET_TYPE); }

    void SetRegularAttackTime();
    void SetBaseModValue(BaseModGroup modGroup, BaseModType modType, float value) { m_auraBaseMod[modGroup][modType] = value; }
    void HandleBaseModValue(BaseModGroup modGroup, BaseModType modType, float amount, bool apply);
    [[nodiscard]] float GetBaseModValue(BaseModGroup modGroup, BaseModType modType) const;
    [[nodiscard]] float GetTotalBaseModValue(BaseModGroup modGroup) const;
    [[nodiscard]] float GetTotalPercentageModValue(BaseModGroup modGroup) const { return m_auraBaseMod[modGroup][FLAT_MOD] + m_auraBaseMod[modGroup][PCT_MOD]; }
    void _ApplyAllStatBonuses();
    void _RemoveAllStatBonuses();

    void ResetAllPowers();

    SpellSchoolMask GetMeleeDamageSchoolMask(WeaponAttackType attackType = BASE_ATTACK, uint8 damageIndex = 0) const override;

    void _ApplyWeaponDependentAuraMods(Item* item, WeaponAttackType attackType, bool apply);
    void _ApplyWeaponDependentAuraCritMod(Item* item, WeaponAttackType attackType, AuraEffect const* aura, bool apply);
    void _ApplyWeaponDependentAuraDamageMod(Item* item, WeaponAttackType attackType, AuraEffect const* aura, bool apply);

    void _ApplyItemMods(Item* item, uint8 slot, bool apply);
    void _RemoveAllItemMods();
    void _ApplyAllItemMods();
    void _ApplyAllLevelScaleItemMods(bool apply);
    void _ApplyItemBonuses(ItemTemplate const* proto, uint8 slot, bool apply, bool only_level_scale = false);
    void _ApplyWeaponDamage(uint8 slot, ItemTemplate const* proto, ScalingStatValuesEntry const* ssv, bool apply);
    void _ApplyAmmoBonuses();
    bool EnchantmentFitsRequirements(uint32 enchantmentcondition, int8 slot);
    void ToggleMetaGemsActive(uint8 exceptslot, bool apply);
    void CorrectMetaGemEnchants(uint8 slot, bool apply);
    void InitDataForForm(bool reapplyMods = false);

    void ApplyItemEquipSpell(Item* item, bool apply, bool form_change = false);
    void ApplyEquipSpell(SpellInfo const* spellInfo, Item* item, bool apply, bool form_change = false);
    void UpdateEquipSpellsAtFormChange();
    void CastItemCombatSpell(Unit* target, WeaponAttackType attType, uint32 procVictim, uint32 procEx);
    void CastItemUseSpell(Item* item, SpellCastTargets const& targets, uint8 cast_count, uint32 glyphIndex);
    void CastItemCombatSpell(Unit* target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, Item* item, ItemTemplate const* proto);

    void SendEquipmentSetList();
    void SetEquipmentSet(uint32 index, EquipmentSet eqset);
    void DeleteEquipmentSet(uint64 setGuid);

    void SendInitWorldStates(uint32 zone, uint32 area);
    void SendUpdateWorldState(uint32 variable, uint32 value) const;
    void SendDirectMessage(WorldPacket const* data) const;
    void SendBGWeekendWorldStates();
    void SendBattlefieldWorldStates();

    void GetAurasForTarget(Unit* target, bool force = false);

    PlayerMenu* PlayerTalkClass;
    std::vector<ItemSetEffect*> ItemSetEff;

    void SendLoot(ObjectGuid guid, LootType loot_type);
    void SendLootError(ObjectGuid guid, LootError error);
    void SendLootRelease(ObjectGuid guid);
    void SendNotifyLootItemRemoved(uint8 lootSlot);
    void SendNotifyLootMoneyRemoved();

    /*********************************************************/
    /***               BATTLEGROUND SYSTEM                 ***/
    /*********************************************************/

    [[nodiscard]] bool InBattleground() const { return m_bgData.bgInstanceID != 0; }
    [[nodiscard]] bool InArena() const;
    [[nodiscard]] uint32 GetBattlegroundId() const { return m_bgData.bgInstanceID; }
    [[nodiscard]] BattlegroundTypeId GetBattlegroundTypeId() const { return m_bgData.bgTypeID; }
    [[nodiscard]] uint32 GetCurrentBattlegroundQueueSlot() const { return m_bgData.bgQueueSlot; }
    [[nodiscard]] bool IsInvitedForBattlegroundInstance() const { return m_bgData.isInvited; }
    [[nodiscard]] bool IsCurrentBattlegroundRandom() const { return m_bgData.bgIsRandom; }
    BGData& GetBGData() { return m_bgData; }
    void SetBGData(BGData& bgdata) { m_bgData = bgdata; }
    [[nodiscard]] Battleground* GetBattleground(bool create = false) const;

    [[nodiscard]] bool InBattlegroundQueue(bool ignoreArena = false) const;
    [[nodiscard]] bool IsDeserter() const { return HasAura(26013); }

    [[nodiscard]] BattlegroundQueueTypeId GetBattlegroundQueueTypeId(uint32 index) const;
    [[nodiscard]] uint32 GetBattlegroundQueueIndex(BattlegroundQueueTypeId bgQueueTypeId) const;
    [[nodiscard]] bool IsInvitedForBattlegroundQueueType(BattlegroundQueueTypeId bgQueueTypeId) const;
    [[nodiscard]] bool InBattlegroundQueueForBattlegroundQueueType(BattlegroundQueueTypeId bgQueueTypeId) const;

    void SetBattlegroundId(uint32 id, BattlegroundTypeId bgTypeId, uint32 queueSlot, bool invited, bool isRandom, TeamId teamId);
    uint32 AddBattlegroundQueueId(BattlegroundQueueTypeId val);
    bool HasFreeBattlegroundQueueId() const;
    void RemoveBattlegroundQueueId(BattlegroundQueueTypeId val);
    void SetInviteForBattlegroundQueueType(BattlegroundQueueTypeId bgQueueTypeId, uint32 instanceId);
    bool IsInvitedForBattlegroundInstance(uint32 instanceId) const;

    [[nodiscard]] TeamId GetBgTeamId() const { return m_bgData.bgTeamId != TEAM_NEUTRAL ? m_bgData.bgTeamId : GetTeamId(); }

    void LeaveBattleground(Battleground* bg = nullptr);
    [[nodiscard]] bool CanJoinToBattleground() const;
    bool CanReportAfkDueToLimit();
    void ReportedAfkBy(Player* reporter);
    void ClearAfkReports() { m_bgData.bgAfkReporter.clear(); }

    [[nodiscard]] bool GetBGAccessByLevel(BattlegroundTypeId bgTypeId) const;
    bool CanUseBattlegroundObject(GameObject* gameobject) const;
    [[nodiscard]] bool isTotalImmune() const;
    [[nodiscard]] bool CanCaptureTowerPoint() const;

    bool GetRandomWinner() { return m_IsBGRandomWinner; }
    void SetRandomWinner(bool isWinner);

    /*********************************************************/
    /***               OUTDOOR PVP SYSTEM                  ***/
    /*********************************************************/

    [[nodiscard]] OutdoorPvP* GetOutdoorPvP() const;
    // returns true if the player is in active state for outdoor pvp objective capturing, false otherwise
    bool IsOutdoorPvPActive();

    /*********************************************************/
    /***              ENVIROMENTAL SYSTEM                  ***/
    /*********************************************************/

    bool IsImmuneToEnvironmentalDamage();
    uint32 EnvironmentalDamage(EnviromentalDamage type, uint32 damage);

    /*********************************************************/
    /***               FLOOD FILTER SYSTEM                 ***/
    /*********************************************************/

    struct ChatFloodThrottle
    {
        enum Index
        {
            REGULAR = 0,
            ADDON = 1,
            MAX
        };

        time_t Time = 0;
        uint32 Count = 0;
    };

    void UpdateSpeakTime(ChatFloodThrottle::Index index);
    [[nodiscard]] bool CanSpeak() const;

    /*********************************************************/
    /***                 VARIOUS SYSTEMS                   ***/
    /*********************************************************/
    void UpdateFallInformationIfNeed(MovementInfo const& minfo, uint16 opcode);
    SafeUnitPointer m_mover;
    WorldObject* m_seer;
    std::set<Unit*> m_isInSharedVisionOf;
    void SetFallInformation(uint32 time, float z)
    {
        m_lastFallTime = time;
        m_lastFallZ = z;
    }
    void HandleFall(MovementInfo const& movementInfo);

    [[nodiscard]] bool canFlyInZone(uint32 mapid, uint32 zone, SpellInfo const* bySpell);

    void SetClientControl(Unit* target, bool allowMove, bool packetOnly = false);

    void SetMover(Unit* target);

    void SetSeer(WorldObject* target) { m_seer = target; }
    void SetViewpoint(WorldObject* target, bool apply);
    [[nodiscard]] WorldObject* GetViewpoint() const;
    void StopCastingCharm(Aura* except = nullptr);
    void StopCastingBindSight(Aura* except = nullptr);

    [[nodiscard]] uint32 GetSaveTimer() const { return m_nextSave; }
    void SetSaveTimer(uint32 timer) { m_nextSave = timer; }

    // Recall position
    uint32 m_recallMap;
    float  m_recallX;
    float  m_recallY;
    float  m_recallZ;
    float  m_recallO;
    void   SaveRecallPosition();

    void SetHomebind(WorldLocation const& loc, uint32 areaId);

    // Homebind coordinates
    uint32 m_homebindMapId;
    uint16 m_homebindAreaId;
    float m_homebindX;
    float m_homebindY;
    float m_homebindZ;
    float m_homebindO;

    [[nodiscard]] WorldLocation GetStartPosition() const;

    [[nodiscard]] WorldLocation const& GetEntryPoint() const { return m_entryPointData.joinPos; }
    void SetEntryPoint();

    // currently visible objects at player client
    GuidUnorderedSet m_clientGUIDs;
    std::vector<Unit*> m_newVisible; // pussywizard

    [[nodiscard]] bool HaveAtClient(WorldObject const* u) const;
    [[nodiscard]] bool HaveAtClient(ObjectGuid guid) const;

    [[nodiscard]] bool IsNeverVisible() const override;

    bool IsVisibleGloballyFor(Player const* player) const;

    void GetInitialVisiblePackets(Unit* target);
    void UpdateObjectVisibility(bool forced = true, bool fromUpdate = false) override;
    void UpdateVisibilityForPlayer(bool mapChange = false);
    void UpdateVisibilityOf(WorldObject* target);
    void UpdateTriggerVisibility();

    template<class T>
    void UpdateVisibilityOf(T* target, UpdateData& data, std::vector<Unit*>& visibleNow);

    uint8 m_forced_speed_changes[MAX_MOVE_TYPE];

    [[nodiscard]] bool HasAtLoginFlag(AtLoginFlags f) const { return m_atLoginFlags & f; }
    void SetAtLoginFlag(AtLoginFlags f) { m_atLoginFlags |= f; }
    void RemoveAtLoginFlag(AtLoginFlags flags, bool persist = false);

    bool isUsingLfg();
    bool inRandomLfgDungeon();

    typedef std::set<uint32> DFQuestsDoneList;
    DFQuestsDoneList m_DFQuests;

    // Temporarily removed pet cache
    [[nodiscard]] uint32 GetTemporaryUnsummonedPetNumber() const { return m_temporaryUnsummonedPetNumber; }
    void SetTemporaryUnsummonedPetNumber(uint32 petnumber) { m_temporaryUnsummonedPetNumber = petnumber; }
    void UnsummonPetTemporaryIfAny();
    void ResummonPetTemporaryUnSummonedIfAny();
    [[nodiscard]] bool IsPetNeedBeTemporaryUnsummoned() const { return GetSession()->PlayerLogout() || !IsInWorld() || !IsAlive() || IsMounted()/*+in flight*/ || GetVehicle() || IsBeingTeleported(); }
    bool CanResummonPet(uint32 spellid);

    void SendCinematicStart(uint32 CinematicSequenceId) const;
    void SendMovieStart(uint32 MovieId);

    uint32 DoRandomRoll(uint32 minimum, uint32 maximum);

    [[nodiscard]] uint16 GetMaxSkillValueForLevel() const;
    bool IsFFAPvP();
    bool IsPvP();

    /*********************************************************/
    /***                 INSTANCE SYSTEM                   ***/
    /*********************************************************/

    void UpdateHomebindTime(uint32 time);

    uint32 m_HomebindTimer;
    bool m_InstanceValid;
    void BindToInstance();
    void SetPendingBind(uint32 instanceId, uint32 bindTimer) { _pendingBindId = instanceId; _pendingBindTimer = bindTimer; }
    [[nodiscard]] bool HasPendingBind() const { return _pendingBindId > 0; }
    [[nodiscard]] uint32 GetPendingBind() const { return _pendingBindId; }
    void SendRaidInfo();
    void SendSavedInstances();
    void PrettyPrintRequirementsQuestList(const std::vector<const ProgressionRequirement*>& missingQuests) const;
    void PrettyPrintRequirementsAchievementsList(const std::vector<const ProgressionRequirement*>& missingAchievements) const;
    void PrettyPrintRequirementsItemsList(const std::vector<const ProgressionRequirement*>& missingItems) const;
    bool Satisfy(DungeonProgressionRequirements const* ar, uint32 target_map, bool report = false);
    bool CheckInstanceLoginValid();
    [[nodiscard]] bool CheckInstanceCount(uint32 instanceId) const;

    void AddInstanceEnterTime(uint32 instanceId, time_t enterTime)
    {
        if (_instanceResetTimes.find(instanceId) == _instanceResetTimes.end())
            _instanceResetTimes.insert(InstanceTimeMap::value_type(instanceId, enterTime + HOUR));
    }

    // last used pet number (for BG's)
    [[nodiscard]] uint32 GetLastPetNumber() const { return m_lastpetnumber; }
    void SetLastPetNumber(uint32 petnumber) { m_lastpetnumber = petnumber; }
    [[nodiscard]] uint32 GetLastPetSpell() const { return m_oldpetspell; }
    void SetLastPetSpell(uint32 petspell) { m_oldpetspell = petspell; }

    /*********************************************************/
    /***                   GROUP SYSTEM                    ***/
    /*********************************************************/

    Group* GetGroupInvite() { return m_groupInvite; }
    void SetGroupInvite(Group* group) { m_groupInvite = group; }
    Group* GetGroup() { return m_group.getTarget(); }
    [[nodiscard]] const Group* GetGroup() const { return (const Group*)m_group.getTarget(); }
    GroupReference& GetGroupRef() { return m_group; }
    void SetGroup(Group* group, int8 subgroup = -1);
    [[nodiscard]] uint8 GetSubGroup() const { return m_group.getSubGroup(); }
    [[nodiscard]] uint32 GetGroupUpdateFlag() const { return m_groupUpdateMask; }
    void SetGroupUpdateFlag(uint32 flag) { m_groupUpdateMask |= flag; }
    [[nodiscard]] uint64 GetAuraUpdateMaskForRaid() const { return m_auraRaidUpdateMask; }
    void SetAuraUpdateMaskForRaid(uint8 slot) { m_auraRaidUpdateMask |= (uint64(1) << slot); }
    Player* GetNextRandomRaidMember(float radius);
    [[nodiscard]] PartyResult CanUninviteFromGroup(ObjectGuid targetPlayerGUID = ObjectGuid::Empty) const;

    // Battleground Group System
    void SetBattlegroundOrBattlefieldRaid(Group* group, int8 subgroup = -1);
    void RemoveFromBattlegroundOrBattlefieldRaid();
    Group* GetOriginalGroup() { return m_originalGroup.getTarget(); }
    GroupReference& GetOriginalGroupRef() { return m_originalGroup; }
    [[nodiscard]] uint8 GetOriginalSubGroup() const { return m_originalGroup.getSubGroup(); }
    void SetOriginalGroup(Group* group, int8 subgroup = -1);

    void SetPassOnGroupLoot(bool bPassOnGroupLoot) { m_bPassOnGroupLoot = bPassOnGroupLoot; }
    [[nodiscard]] bool GetPassOnGroupLoot() const { return m_bPassOnGroupLoot; }

    MapReference& GetMapRef() { return m_mapRef; }

    // Set map to player and add reference
    void SetMap(Map* map) override;
    void ResetMap() override;

    bool CanTeleport() { return m_canTeleport; }
    void SetCanTeleport(bool value) { m_canTeleport = value; }
    bool CanKnockback() { return m_canKnockback; }
    void SetCanKnockback(bool value) { m_canKnockback = value; }

    bool isAllowedToLoot(Creature const* creature);

    [[nodiscard]] DeclinedName const* GetDeclinedNames() const { return m_declinedname; }
    [[nodiscard]] uint8 GetRunesState() const { return m_runes->runeState; }
    [[nodiscard]] RuneType GetBaseRune(uint8 index) const { return RuneType(m_runes->runes[index].BaseRune); }
    [[nodiscard]] RuneType GetCurrentRune(uint8 index) const { return RuneType(m_runes->runes[index].CurrentRune); }
    [[nodiscard]] uint32 GetRuneCooldown(uint8 index) const { return m_runes->runes[index].Cooldown; }
    [[nodiscard]] uint32 GetGracePeriod(uint8 index) const { return m_runes->runes[index].GracePeriod; }
    uint32 GetRuneBaseCooldown(uint8 index, bool skipGrace);
    [[nodiscard]] bool IsBaseRuneSlotsOnCooldown(RuneType runeType) const;
    RuneType GetLastUsedRune() { return m_runes->lastUsedRune; }
    void SetLastUsedRune(RuneType type) { m_runes->lastUsedRune = type; }
    void SetBaseRune(uint8 index, RuneType baseRune) { m_runes->runes[index].BaseRune = baseRune; }
    void SetCurrentRune(uint8 index, RuneType currentRune) { m_runes->runes[index].CurrentRune = currentRune; }
    void SetRuneCooldown(uint8 index, uint32 cooldown) { m_runes->runes[index].Cooldown = cooldown; m_runes->SetRuneState(index, (cooldown == 0)); }
    void SetGracePeriod(uint8 index, uint32 period) { m_runes->runes[index].GracePeriod = period; }
    void SetRuneConvertAura(uint8 index, AuraEffect const* aura) { m_runes->runes[index].ConvertAura = aura; }
    void AddRuneByAuraEffect(uint8 index, RuneType newType, AuraEffect const* aura) { SetRuneConvertAura(index, aura); ConvertRune(index, newType); }
    void RemoveRunesByAuraEffect(AuraEffect const* aura);
    void RestoreBaseRune(uint8 index);
    void ConvertRune(uint8 index, RuneType newType);
    void ResyncRunes(uint8 count);
    void AddRunePower(uint8 index);
    void InitRunes();

    void SendRespondInspectAchievements(Player* player) const;
    [[nodiscard]] bool HasAchieved(uint32 achievementId) const;
    void ResetAchievements();
    void CheckAllAchievementCriteria();
    void ResetAchievementCriteria(AchievementCriteriaCondition condition, uint32 value, bool evenIfCriteriaComplete = false);
    void UpdateAchievementCriteria(AchievementCriteriaTypes type, uint32 miscValue1 = 0, uint32 miscValue2 = 0, Unit* unit = nullptr);
    void StartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry, uint32 timeLost = 0);
    void RemoveTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry);
    void CompletedAchievement(AchievementEntry const* entry);
    [[nodiscard]] AchievementMgr* GetAchievementMgr() const { return m_achievementMgr; }

    void SetCreationTime(Seconds creationTime) { m_creationTime = creationTime; }
    [[nodiscard]] Seconds GetCreationTime() const { return m_creationTime; }

    [[nodiscard]] bool HasTitle(uint32 bitIndex) const;
    bool HasTitle(CharTitlesEntry const* title) const { return HasTitle(title->bit_index); }
    void SetTitle(CharTitlesEntry const* title, bool lost = false);
    void SetCurrentTitle(CharTitlesEntry const* title, bool clear = false) { SetUInt32Value(PLAYER_CHOSEN_TITLE, clear ? 0 : title->bit_index); };

    //bool isActiveObject() const { return true; }
    bool CanSeeSpellClickOn(Creature const* creature) const;
    [[nodiscard]] bool CanSeeVendor(Creature const* creature) const;

    [[nodiscard]] uint32 GetChampioningFaction() const { return m_ChampioningFaction; }
    void SetChampioningFaction(uint32 faction) { m_ChampioningFaction = faction; }
    Spell* m_spellModTakingSpell;

    float GetAverageItemLevel();
    float GetAverageItemLevelForDF();
    bool isDebugAreaTriggers;

    void ClearWhisperWhiteList() { WhisperList.clear(); }
    void AddWhisperWhiteList(ObjectGuid guid) { WhisperList.push_back(guid); }
    bool IsInWhisperWhiteList(ObjectGuid guid);
    void RemoveFromWhisperWhiteList(ObjectGuid guid) { WhisperList.remove(guid); }

    bool SetDisableGravity(bool disable, bool packetOnly = false, bool updateAnimationTier = true) override;
    bool SetCanFly(bool apply, bool packetOnly = false) override;
    bool SetWaterWalking(bool apply, bool packetOnly = false) override;
    bool SetFeatherFall(bool apply, bool packetOnly = false) override;
    bool SetHover(bool enable, bool packetOnly = false, bool updateAnimationTier = true) override;

    [[nodiscard]] bool CanFly() const override { return m_movementInfo.HasMovementFlag(MOVEMENTFLAG_CAN_FLY); }
    [[nodiscard]] bool CanEnterWater() const override { return true; }

    // OURS
    // saving
    void AdditionalSavingAddMask(uint8 mask) { m_additionalSaveTimer = 2000; m_additionalSaveMask |= mask; }
    // arena spectator
    [[nodiscard]] bool IsSpectator() const { return m_ExtraFlags & PLAYER_EXTRA_SPECTATOR_ON; }
    void SetIsSpectator(bool on);
    [[nodiscard]] bool NeedSendSpectatorData() const;
    void SetPendingSpectatorForBG(uint32 bgInstanceId) { m_pendingSpectatorForBG = bgInstanceId; }
    [[nodiscard]] bool HasPendingSpectatorForBG(uint32 bgInstanceId) const { return m_pendingSpectatorForBG == bgInstanceId; }
    void SetPendingSpectatorInviteInstanceId(uint32 bgInstanceId) { m_pendingSpectatorInviteInstanceId = bgInstanceId; }
    [[nodiscard]] uint32 GetPendingSpectatorInviteInstanceId() const { return m_pendingSpectatorInviteInstanceId; }
    bool HasReceivedSpectatorResetFor(ObjectGuid guid) { return m_receivedSpectatorResetFor.find(guid) != m_receivedSpectatorResetFor.end(); }
    void ClearReceivedSpectatorResetFor() { m_receivedSpectatorResetFor.clear(); }
    void AddReceivedSpectatorResetFor(ObjectGuid guid) { m_receivedSpectatorResetFor.insert(guid); }
    void RemoveReceivedSpectatorResetFor(ObjectGuid guid) { m_receivedSpectatorResetFor.erase(guid); }
    uint32 m_pendingSpectatorForBG;
    uint32 m_pendingSpectatorInviteInstanceId;
    GuidSet m_receivedSpectatorResetFor;

    // Dancing Rune weapon
    void setRuneWeaponGUID(ObjectGuid guid) { m_drwGUID = guid; };
    ObjectGuid getRuneWeaponGUID() { return m_drwGUID; };
    ObjectGuid m_drwGUID;

    [[nodiscard]] bool CanSeeDKPet() const    { return m_ExtraFlags & PLAYER_EXTRA_SHOW_DK_PET; }
    void SetShowDKPet(bool on)  { if (on) m_ExtraFlags |= PLAYER_EXTRA_SHOW_DK_PET; else m_ExtraFlags &= ~PLAYER_EXTRA_SHOW_DK_PET; };
    void PrepareCharmAISpells();
    uint32 m_charmUpdateTimer;

    bool NeedToSaveGlyphs() { return m_NeedToSaveGlyphs; }
    void SetNeedToSaveGlyphs(bool val) { m_NeedToSaveGlyphs = val; }

    uint32 GetMountBlockId() { return m_MountBlockId; }
    void SetMountBlockId(uint32 mount) { m_MountBlockId = mount; }

    [[nodiscard]] float GetRealParry() const { return m_realParry; }
    [[nodiscard]] float GetRealDodge() const { return m_realDodge; }
    // mt maps
    [[nodiscard]] const PlayerTalentMap& GetTalentMap() const { return m_talents; }
    [[nodiscard]] uint32 GetNextSave() const { return m_nextSave; }
    [[nodiscard]] SpellModList const& GetSpellModList(uint32 type) const { return m_spellMods[type]; }

    void SetServerSideVisibility(ServerSideVisibilityType type, AccountTypes sec);
    void SetServerSideVisibilityDetect(ServerSideVisibilityType type, AccountTypes sec);

    static std::unordered_map<int, bgZoneRef> bgZoneIdToFillWorldStates; // zoneId -> FillInitialWorldStates

    void SetFarSightDistance(float radius);
    void ResetFarSightDistance();
    [[nodiscard]] Optional<float> GetFarSightDistance() const;

    float GetSightRange(WorldObject const* target = nullptr) const override;

    std::string GetPlayerName();

    // Settings
    [[nodiscard]] PlayerSetting GetPlayerSetting(std::string source, uint8 index);
    void UpdatePlayerSetting(std::string source, uint8 index, uint32 value);

    void SendSystemMessage(std::string_view msg, bool escapeCharacters = false);

    std::string GetDebugInfo() const override;

 protected:
    // Gamemaster whisper whitelist
    WhisperListContainer WhisperList;

    // Performance Varibales
    bool m_NeedToSaveGlyphs;
    // Mount block bug
    uint32 m_MountBlockId;
    // Real stats
    float m_realDodge;
    float m_realParry;

    uint32 m_charmAISpells[NUM_CAI_SPELLS];

    uint32 m_AreaID;
    uint32 m_regenTimerCount;
    uint32 m_foodEmoteTimerCount;
    float m_powerFraction[MAX_POWERS];
    uint32 m_contestedPvPTimer;

    /*********************************************************/
    /***               BATTLEGROUND SYSTEM                 ***/
    /*********************************************************/

    struct BgBattlegroundQueueID_Rec
    {
        BattlegroundQueueTypeId bgQueueTypeId;
        uint32 invitedToInstance;
    };

    std::array<BgBattlegroundQueueID_Rec, PLAYER_MAX_BATTLEGROUND_QUEUES> _BgBattlegroundQueueID;
    BGData m_bgData;
    bool m_IsBGRandomWinner;

    /*********************************************************/
    /***                   ENTRY POINT                     ***/
    /*********************************************************/

    EntryPointData m_entryPointData;

    /*********************************************************/
    /***                    QUEST SYSTEM                   ***/
    /*********************************************************/

    //We allow only one timed quest active at the same time. Below can then be simple value instead of set.
    typedef std::set<uint32> QuestSet;
    typedef std::set<uint32> SeasonalQuestSet;
    typedef std::unordered_map<uint32, SeasonalQuestSet> SeasonalEventQuestMap;
    QuestSet m_timedquests;
    QuestSet m_weeklyquests;
    QuestSet m_monthlyquests;
    SeasonalEventQuestMap m_seasonalquests;

    ObjectGuid m_divider;
    uint32 m_ingametime;

    /*********************************************************/
    /***                   LOAD SYSTEM                     ***/
    /*********************************************************/

    void _LoadActions(PreparedQueryResult result);
    void _LoadAuras(PreparedQueryResult result, uint32 timediff);
    void _LoadGlyphAuras();
    void _LoadInventory(PreparedQueryResult result, uint32 timeDiff);
    void _LoadMail(PreparedQueryResult mailsResult, PreparedQueryResult mailItemsResult);
    static Item* _LoadMailedItem(ObjectGuid const& playerGuid, Player* player, uint32 mailId, Mail* mail, Field* fields);
    void _LoadQuestStatus(PreparedQueryResult result);
    void _LoadQuestStatusRewarded(PreparedQueryResult result);
    void _LoadDailyQuestStatus(PreparedQueryResult result);
    void _LoadWeeklyQuestStatus(PreparedQueryResult result);
    void _LoadMonthlyQuestStatus(PreparedQueryResult result);
    void _LoadSeasonalQuestStatus(PreparedQueryResult result);
    void _LoadRandomBGStatus(PreparedQueryResult result);
    void _LoadGroup();
    void _LoadSkills(PreparedQueryResult result);
    void _LoadSpells(PreparedQueryResult result);
    void _LoadFriendList(PreparedQueryResult result);
    bool _LoadHomeBind(PreparedQueryResult result);
    void _LoadDeclinedNames(PreparedQueryResult result);
    void _LoadArenaTeamInfo();
    void _LoadEquipmentSets(PreparedQueryResult result);
    void _LoadEntryPointData(PreparedQueryResult result);
    void _LoadGlyphs(PreparedQueryResult result);
    void _LoadTalents(PreparedQueryResult result);
    void _LoadInstanceTimeRestrictions(PreparedQueryResult result);
    void _LoadBrewOfTheMonth(PreparedQueryResult result);
    void _LoadCharacterSettings(PreparedQueryResult result);
    void _LoadPetStable(uint8 petStableSlots, PreparedQueryResult result);

    /*********************************************************/
    /***                   SAVE SYSTEM                     ***/
    /*********************************************************/

    void _SaveActions(CharacterDatabaseTransaction trans);
    void _SaveAuras(CharacterDatabaseTransaction trans, bool logout);
    void _SaveInventory(CharacterDatabaseTransaction trans);
    void _SaveMail(CharacterDatabaseTransaction trans);
    void _SaveQuestStatus(CharacterDatabaseTransaction trans);
    void _SaveDailyQuestStatus(CharacterDatabaseTransaction trans);
    void _SaveWeeklyQuestStatus(CharacterDatabaseTransaction trans);
    void _SaveMonthlyQuestStatus(CharacterDatabaseTransaction trans);
    void _SaveSeasonalQuestStatus(CharacterDatabaseTransaction trans);
    void _SaveSpells(CharacterDatabaseTransaction trans);
    void _SaveEquipmentSets(CharacterDatabaseTransaction trans);
    void _SaveEntryPoint(CharacterDatabaseTransaction trans);
    void _SaveGlyphs(CharacterDatabaseTransaction trans);
    void _SaveTalents(CharacterDatabaseTransaction trans);
    void _SaveStats(CharacterDatabaseTransaction trans);
    void _SaveCharacter(bool create, CharacterDatabaseTransaction trans);
    void _SaveInstanceTimeRestrictions(CharacterDatabaseTransaction trans);
    void _SavePlayerSettings(CharacterDatabaseTransaction trans);

    /*********************************************************/
    /***              ENVIRONMENTAL SYSTEM                 ***/
    /*********************************************************/
    void HandleSobering();
    void SendMirrorTimer(MirrorTimerType Type, uint32 MaxValue, uint32 CurrentValue, int32 Regen);
    void StopMirrorTimer(MirrorTimerType Type);
    void HandleDrowning(uint32 time_diff);
    int32 getMaxTimer(MirrorTimerType timer);

    /*********************************************************/
    /***                  HONOR SYSTEM                     ***/
    /*********************************************************/
    time_t m_lastHonorUpdateTime;

    void outDebugValues() const;
    ObjectGuid m_lootGuid;

    TeamId m_team;
    uint32 m_nextSave; // pussywizard
    uint16 m_additionalSaveTimer; // pussywizard
    uint8 m_additionalSaveMask; // pussywizard
    uint16 m_hostileReferenceCheckTimer; // pussywizard
    std::array<ChatFloodThrottle, ChatFloodThrottle::MAX> m_chatFloodData;
    Difficulty m_dungeonDifficulty;
    Difficulty m_raidDifficulty;
    Difficulty m_raidMapDifficulty;

    uint32 m_atLoginFlags;

    Item* m_items[PLAYER_SLOTS_COUNT];
    uint32 m_currentBuybackSlot;

    std::vector<Item*> m_itemUpdateQueue;
    bool m_itemUpdateQueueBlocked;

    uint32 m_ExtraFlags;

    QuestStatusMap m_QuestStatus;
    QuestStatusSaveMap m_QuestStatusSave;

    RewardedQuestSet m_RewardedQuests;
    QuestStatusSaveMap m_RewardedQuestsSave;
    void SendQuestGiverStatusMultiple();

    SkillStatusMap mSkillStatus;

    uint32 m_GuildIdInvited;
    uint32 m_ArenaTeamIdInvited;

    PlayerMails m_mail;
    PlayerSpellMap m_spells;
    PlayerTalentMap m_talents;
    uint32 m_lastPotionId;                              // last used health/mana potion in combat, that block next potion use

    GlobalCooldownMgr m_GlobalCooldownMgr;

    uint8 m_activeSpec;
    uint8 m_specsCount;

    uint32 m_Glyphs[MAX_TALENT_SPECS][MAX_GLYPH_SLOT_INDEX];

    ActionButtonList m_actionButtons;

    float m_auraBaseMod[BASEMOD_END][MOD_END];
    int32 m_baseRatingValue[MAX_COMBAT_RATING];
    uint32 m_baseSpellPower;
    uint32 m_baseFeralAP;
    uint32 m_baseManaRegen;
    uint32 m_baseHealthRegen;
    int32 m_spellPenetrationItemMod;

    SpellModList m_spellMods[MAX_SPELLMOD];
    //uint32 m_pad;
    //        Spell* m_spellModTakingSpell;  // Spell for which charges are dropped in spell::finish

    EnchantDurationList m_enchantDuration;
    ItemDurationList m_itemDuration;
    ItemDurationList m_itemSoulboundTradeable;
    std::mutex m_soulboundTradableLock;

    ObjectGuid m_resurrectGUID;
    uint32 m_resurrectMap;
    float m_resurrectX, m_resurrectY, m_resurrectZ;
    uint32 m_resurrectHealth, m_resurrectMana;

    WorldSession* m_session;

    typedef std::list<Channel*> JoinedChannelsList;
    JoinedChannelsList m_channels;

    uint8 m_cinematic;

    TradeData* m_trade;

    bool   m_DailyQuestChanged;
    bool   m_WeeklyQuestChanged;
    bool   m_MonthlyQuestChanged;
    bool   m_SeasonalQuestChanged;
    time_t m_lastDailyQuestTime;

    uint32 m_drunkTimer;
    uint32 m_weaponChangeTimer;

    uint32 m_zoneUpdateId;
    uint32 m_zoneUpdateTimer;
    uint32 m_areaUpdateId;

    uint32 m_deathTimer;
    time_t m_deathExpireTime;

    uint32 m_WeaponProficiency;
    uint32 m_ArmorProficiency;
    bool m_canParry;
    bool m_canBlock;
    bool m_canTitanGrip;
    uint8 m_swingErrorMsg;
    float m_ammoDPS;

    ////////////////////Rest System/////////////////////
    time_t _restTime;
    uint32 _innTriggerId;
    float _restBonus;
    uint32 _restFlagMask;
    ////////////////////Rest System/////////////////////
    uint32 m_resetTalentsCost;
    time_t m_resetTalentsTime;
    uint32 m_usedTalentCount;
    uint32 m_questRewardTalentCount;
    uint32 m_extraBonusTalentCount;

    // Social
    PlayerSocial* m_social;

    // Groups
    GroupReference m_group;
    GroupReference m_originalGroup;
    Group* m_groupInvite;
    uint32 m_groupUpdateMask;
    uint64 m_auraRaidUpdateMask;
    bool m_bPassOnGroupLoot;

    // last used pet number (for BG's)
    uint32 m_lastpetnumber;

    // Player summoning
    time_t m_summon_expire;
    uint32 m_summon_mapid;
    float  m_summon_x;
    float  m_summon_y;
    float  m_summon_z;
    bool   m_summon_asSpectator;

    DeclinedName* m_declinedname;
    Runes* m_runes;
    EquipmentSets m_EquipmentSets;

    bool CanAlwaysSee(WorldObject const* obj) const override;

    bool IsAlwaysDetectableFor(WorldObject const* seer) const override;

    uint8 m_grantableLevels;

    bool m_needZoneUpdate;

private:
    // internal common parts for CanStore/StoreItem functions
    InventoryResult CanStoreItem_InSpecificSlot(uint8 bag, uint8 slot, ItemPosCountVec& dest, ItemTemplate const* pProto, uint32& count, bool swap, Item* pSrcItem) const;
    InventoryResult CanStoreItem_InBag(uint8 bag, ItemPosCountVec& dest, ItemTemplate const* pProto, uint32& count, bool merge, bool non_specialized, Item* pSrcItem, uint8 skip_bag, uint8 skip_slot) const;
    InventoryResult CanStoreItem_InInventorySlots(uint8 slot_begin, uint8 slot_end, ItemPosCountVec& dest, ItemTemplate const* pProto, uint32& count, bool merge, Item* pSrcItem, uint8 skip_bag, uint8 skip_slot) const;
    Item* _StoreItem(uint16 pos, Item* pItem, uint32 count, bool clone, bool update);
    Item* _LoadItem(CharacterDatabaseTransaction trans, uint32 zoneId, uint32 timeDiff, Field* fields);

    CinematicMgr* _cinematicMgr;

    typedef GuidSet RefundableItemsSet;
    RefundableItemsSet m_refundableItems;
    void SendRefundInfo(Item* item);
    void RefundItem(Item* item);

    // know currencies are not removed at any point (0 displayed)
    void AddKnownCurrency(uint32 itemId);

    void AdjustQuestReqItemCount(Quest const* quest, QuestStatusData& questStatusData);

    [[nodiscard]] bool MustDelayTeleport() const { return m_bMustDelayTeleport; } // pussywizard: must delay teleports during player update to the very end
    void SetMustDelayTeleport(bool setting) { m_bMustDelayTeleport = setting; }
    [[nodiscard]] bool HasDelayedTeleport() const { return m_bHasDelayedTeleport; }
    void SetHasDelayedTeleport(bool setting) { m_bHasDelayedTeleport = setting; }

    MapReference m_mapRef;

    void UpdateCharmedAI();

    uint32 m_lastFallTime;
    float  m_lastFallZ;

    int32 m_MirrorTimer[MAX_TIMERS];
    uint8 m_MirrorTimerFlags;
    uint8 m_MirrorTimerFlagsLast;
    bool m_isInWater;

    // Current teleport data
    WorldLocation teleportStore_dest;
    uint32 teleportStore_options;
    time_t mSemaphoreTeleport_Near;
    time_t mSemaphoreTeleport_Far;

    uint32 m_DelayedOperations;
    bool m_bMustDelayTeleport;
    bool m_bHasDelayedTeleport;
    bool m_canTeleport;
    bool m_canKnockback;

    std::unique_ptr<PetStable> m_petStable;

    // Temporary removed pet cache
    uint32 m_temporaryUnsummonedPetNumber;
    uint32 m_oldpetspell;

    AchievementMgr* m_achievementMgr;
    ReputationMgr*  m_reputationMgr;

    SpellCooldowns m_spellCooldowns;

    uint32 m_ChampioningFaction;

    InstanceTimeMap _instanceResetTimes;
    uint32 _pendingBindId;
    uint32 _pendingBindTimer;

    uint32 _activeCheats;

    // duel health and mana reset attributes
    uint32 healthBeforeDuel;
    uint32 manaBeforeDuel;

    bool m_isInstantFlightOn;

    uint32 m_flightSpellActivated;

    WorldLocation _corpseLocation;

    Optional<float> _farSightDistance = { };

    bool _wasOutdoor;

    PlayerSettingMap m_charSettingsMap;

    Seconds m_creationTime;
};

void AddItemsSetItem(Player* player, Item* item);
void RemoveItemsSetItem(Player* player, ItemTemplate const* proto);

#endif
