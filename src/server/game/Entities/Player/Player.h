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
#include "DatabaseEnvFwd.h"
#include "DBCStores.h"
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
    auto IsInSpec(uint8 spec) -> bool { return (specMask & (1 << spec)); }
};

struct PlayerTalent
{
    PlayerSpellState State : 8; // UPPER CASE TO CAUSE CONSOLE ERRORS (CHECK EVERY USAGE)!
    uint8 specMask         : 8;
    uint32 talentID;
    bool inSpellBook;
    auto IsInSpec(uint8 spec) -> bool { return (specMask & (1 << spec)); }
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
    SpellModifier(Aura* _ownerAura = nullptr) : op(SPELLMOD_DAMAGE), type(SPELLMOD_FLAT), charges(0),  mask(),  ownerAura(_ownerAura) {}
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
    [[nodiscard]] auto GetType() const -> ActionButtonType { return ActionButtonType(ACTION_BUTTON_TYPE(packedData)); }
    [[nodiscard]] auto GetAction() const -> uint32 { return ACTION_BUTTON_ACTION(packedData); }
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
    uint16 basehealth{0};
    uint16 basemana{0};
};

struct PlayerClassInfo
{
    PlayerClassInfo()  = default;

    PlayerClassLevelInfo* levelInfo{nullptr};                        //[level-1] 0..MaxPlayerLevel-1
};

struct PlayerLevelInfo
{
    PlayerLevelInfo() { for (unsigned char & stat : stats) stat = 0; }

    uint8 stats[MAX_STATS];
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

enum PlayerFlags
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
    // stored in m_buybackitems
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
    [[nodiscard]] auto isContainedIn(std::vector<ItemPosCount> const& vec) const -> bool;
    uint16 pos;
    uint32 count;
};
typedef std::vector<ItemPosCount> ItemPosCountVec;

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
    CHAT_TAG_COM        = 0x08, // Commentator
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

enum InstantFlightGossipAction
{
    GOSSIP_ACTION_TOGGLE_INSTANT_FLIGHT = 500
};

enum EmoteBroadcastTextID
{
    EMOTE_BROADCAST_TEXT_ID_STRANGE_GESTURES = 91243
};

auto operator<< (std::ostringstream& ss, PlayerTaxi const& taxi) -> std::ostringstream&;

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
    std::vector<uint32> taxiPath;
    WorldLocation joinPos;

    void ClearTaxiPath()     { taxiPath.clear(); }
    [[nodiscard]] auto HasTaxiPath() const -> bool { return !taxiPath.empty(); }
};

class Player : public Unit, public GridObject<Player>
{
    friend class WorldSession;
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

    [[nodiscard]] auto hasSpanishClient() -> bool
    {
        return GetSession()->GetSessionDbLocaleIndex() == LOCALE_esES || GetSession()->GetSessionDbLocaleIndex() == LOCALE_esMX;
    }

    auto TeleportTo(uint32 mapid, float x, float y, float z, float orientation, uint32 options = 0, Unit* target = nullptr, bool newInstance = false) -> bool;
    auto TeleportTo(WorldLocation const& loc, uint32 options = 0, Unit* target = nullptr) -> bool
    {
        return TeleportTo(loc.GetMapId(), loc.GetPositionX(), loc.GetPositionY(), loc.GetPositionZ(), loc.GetOrientation(), options, target);
    }
    auto TeleportToEntryPoint() -> bool;

    void SetSummonPoint(uint32 mapid, float x, float y, float z, uint32 delay = 0, bool asSpectator = false)
    {
        m_summon_expire = time(nullptr) + (delay ? delay : MAX_PLAYER_SUMMON_DELAY);
        m_summon_mapid = mapid;
        m_summon_x = x;
        m_summon_y = y;
        m_summon_z = z;
        m_summon_asSpectator = asSpectator;
    }
    [[nodiscard]] auto IsSummonAsSpectator() const -> bool { return m_summon_asSpectator && m_summon_expire >= time(nullptr); }
    void SetSummonAsSpectator(bool on) { m_summon_asSpectator = on; }
    void SummonIfPossible(bool agree, ObjectGuid summoner_guid);
    [[nodiscard]] auto GetSummonExpireTimer() const -> time_t { return m_summon_expire; }

    auto Create(ObjectGuid::LowType guidlow, CharacterCreateInfo* createInfo) -> bool;

    void Update(uint32 time) override;

    static auto BuildEnumData(PreparedQueryResult result, WorldPacket* data) -> bool;

    [[nodiscard]] auto IsFalling() const -> bool;
    auto IsInAreaTriggerRadius(const AreaTrigger* trigger) const -> bool;

    void SendInitialPacketsBeforeAddToMap();
    void SendInitialPacketsAfterAddToMap();
    void SendTransferAborted(uint32 mapid, TransferAbortReason reason, uint8 arg = 0);
    void SendInstanceResetWarning(uint32 mapid, Difficulty difficulty, uint32 time, bool onEnterMap);

    auto CanInteractWithQuestGiver(Object* questGiver) -> bool;
    auto GetNPCIfCanInteractWith(ObjectGuid guid, uint32 npcflagmask) -> Creature*;
    [[nodiscard]] auto GetGameObjectIfCanInteractWith(ObjectGuid guid, GameobjectTypes type) const -> GameObject*;

    void ToggleAFK();
    void ToggleDND();
    [[nodiscard]] auto isAFK() const -> bool { return HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_AFK); }
    [[nodiscard]] auto isDND() const -> bool { return HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_DND); }
    [[nodiscard]] auto GetChatTag() const -> uint8;
    std::string autoReplyMsg;

    auto GetBarberShopCost(uint8 newhairstyle, uint8 newhaircolor, uint8 newfacialhair, BarberShopStyleEntry const* newSkin = nullptr) -> uint32;

    auto GetSocial() -> PlayerSocial* { return m_social; }

    PlayerTaxi m_taxi;
    void InitTaxiNodesForLevel() { m_taxi.InitTaxiNodesForLevel(getRace(), getClass(), getLevel()); }
    auto ActivateTaxiPathTo(std::vector<uint32> const& nodes, Creature* npc = nullptr, uint32 spellid = 1) -> bool;
    auto ActivateTaxiPathTo(uint32 taxi_path_id, uint32 spellid = 1) -> bool;
    void CleanupAfterTaxiFlight();
    void ContinueTaxiFlight();
    // mount_id can be used in scripting calls

    [[nodiscard]] auto IsDeveloper() const -> bool { return HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_DEVELOPER); }
    void SetDeveloper(bool on) { ApplyModFlag(PLAYER_FLAGS, PLAYER_FLAGS_DEVELOPER, on); }
    [[nodiscard]] auto isAcceptWhispers() const -> bool { return m_ExtraFlags & PLAYER_EXTRA_ACCEPT_WHISPERS; }
    void SetAcceptWhispers(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_ACCEPT_WHISPERS; else m_ExtraFlags &= ~PLAYER_EXTRA_ACCEPT_WHISPERS; }
    [[nodiscard]] auto IsGameMaster() const -> bool { return m_ExtraFlags & PLAYER_EXTRA_GM_ON; }
    void SetGameMaster(bool on);
    [[nodiscard]] auto isGMChat() const -> bool { return m_ExtraFlags & PLAYER_EXTRA_GM_CHAT; }
    void SetGMChat(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_GM_CHAT; else m_ExtraFlags &= ~PLAYER_EXTRA_GM_CHAT; }
    [[nodiscard]] auto isTaxiCheater() const -> bool { return m_ExtraFlags & PLAYER_EXTRA_TAXICHEAT; }
    void SetTaxiCheater(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_TAXICHEAT; else m_ExtraFlags &= ~PLAYER_EXTRA_TAXICHEAT; }
    [[nodiscard]] auto isGMVisible() const -> bool { return !(m_ExtraFlags & PLAYER_EXTRA_GM_INVISIBLE); }
    void SetGMVisible(bool on);
    auto Has310Flyer(bool checkAllSpells, uint32 excludeSpellId = 0) -> bool;
    void SetHas310Flyer(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_HAS_310_FLYER; else m_ExtraFlags &= ~PLAYER_EXTRA_HAS_310_FLYER; }
    void SetPvPDeath(bool on) { if (on) m_ExtraFlags |= PLAYER_EXTRA_PVP_DEATH; else m_ExtraFlags &= ~PLAYER_EXTRA_PVP_DEATH; }

    void GiveXP(uint32 xp, Unit* victim, float group_rate = 1.0f, bool isLFGReward = false);
    void GiveLevel(uint8 level);

    void InitStatsForLevel(bool reapplyMods = false);

    // .cheat command related
    [[nodiscard]] auto GetCommandStatus(uint32 command) const -> bool { return _activeCheats & command; }
    void SetCommandStatusOn(uint32 command) { _activeCheats |= command; }
    void SetCommandStatusOff(uint32 command) { _activeCheats &= ~command; }

    // Played Time Stuff
    time_t m_logintime;
    time_t m_Last_tick;
    uint32 m_Played_time[MAX_PLAYED_TIME_INDEX];
    auto GetTotalPlayedTime() -> uint32 { return m_Played_time[PLAYED_TIME_TOTAL]; }
    auto GetLevelPlayedTime() -> uint32 { return m_Played_time[PLAYED_TIME_LEVEL]; }

    void setDeathState(DeathState s, bool despawn = false) override;                   // overwrite Unit::setDeathState

    void SetRestState(uint32 triggerId);
    void RemoveRestState();
    auto GetXPRestBonus(uint32 xp) -> uint32;
    [[nodiscard]] auto GetRestBonus() const -> float { return _restBonus; }
    void SetRestBonus(float rest_bonus_new);

    [[nodiscard]] auto HasRestFlag(RestFlag restFlag) const -> bool { return (_restFlagMask & restFlag) != 0; }
    void SetRestFlag(RestFlag restFlag, uint32 triggerId = 0);
    void RemoveRestFlag(RestFlag restFlag);
    [[nodiscard]] auto GetInnTriggerId() const -> uint32 { return _innTriggerId; }

    auto GetPetStable() -> PetStable* { return m_petStable.get(); }
    auto GetOrInitPetStable() -> PetStable&;
    [[nodiscard]] auto GetPetStable() const -> PetStable const* { return m_petStable.get(); }

    [[nodiscard]] auto GetPet() const -> Pet*;
    auto SummonPet(uint32 entry, float x, float y, float z, float ang, PetType petType, Milliseconds duration = 0s) -> Pet*;
    void RemovePet(Pet* pet, PetSaveMode mode, bool returnreagent = false);
    [[nodiscard]] auto GetPhaseMaskForSpawn() const -> uint32;                // used for proper set phase for DB at GM-mode creature/GO spawn

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
    auto FindEquipSlot(ItemTemplate const* proto, uint32 slot, bool swap) const -> uint8;
    auto GetItemCount(uint32 item, bool inBankAlso = false, Item* skipItem = nullptr) const -> uint32;
    auto GetItemCountWithLimitCategory(uint32 limitCategory, Item* skipItem = nullptr) const -> uint32;
    [[nodiscard]] auto GetItemByGuid(ObjectGuid guid) const -> Item*;
    [[nodiscard]] auto GetItemByEntry(uint32 entry) const -> Item*;
    [[nodiscard]] auto GetItemByPos(uint16 pos) const -> Item*;
    [[nodiscard]] auto GetItemByPos(uint8 bag, uint8 slot) const -> Item*;
    [[nodiscard]] auto  GetBagByPos(uint8 slot) const -> Bag*;
    [[nodiscard]] auto GetFreeInventorySpace() const -> uint32;
    [[nodiscard]] inline auto GetUseableItemByPos(uint8 bag, uint8 slot) const -> Item* //Does additional check for disarmed weapons
    {
        if (!CanUseAttackType(GetAttackBySlot(slot)))
            return nullptr;
        return GetItemByPos(bag, slot);
    }
    [[nodiscard]] auto GetWeaponForAttack(WeaponAttackType attackType, bool useable = false) const -> Item*;
    [[nodiscard]] auto GetShield(bool useable = false) const -> Item*;
    static auto GetAttackBySlot(uint8 slot) -> uint8;        // MAX_ATTACK if not weapon slot
    auto GetItemUpdateQueue() -> std::vector<Item*>& { return m_itemUpdateQueue; }
    static auto IsInventoryPos(uint16 pos) -> bool { return IsInventoryPos(pos >> 8, pos & 255); }
    static auto IsInventoryPos(uint8 bag, uint8 slot) -> bool;
    static auto IsEquipmentPos(uint16 pos) -> bool { return IsEquipmentPos(pos >> 8, pos & 255); }
    static auto IsEquipmentPos(uint8 bag, uint8 slot) -> bool;
    static auto IsBagPos(uint16 pos) -> bool;
    static auto IsBankPos(uint16 pos) -> bool { return IsBankPos(pos >> 8, pos & 255); }
    static auto IsBankPos(uint8 bag, uint8 slot) -> bool;
    auto IsValidPos(uint16 pos, bool explicit_pos) -> bool { return IsValidPos(pos >> 8, pos & 255, explicit_pos); }
    auto IsValidPos(uint8 bag, uint8 slot, bool explicit_pos) -> bool;
    [[nodiscard]] auto GetBankBagSlotCount() const -> uint8 { return GetByteValue(PLAYER_BYTES_2, 2); }
    void SetBankBagSlotCount(uint8 count) { SetByteValue(PLAYER_BYTES_2, 2, count); }
    [[nodiscard]] auto HasItemCount(uint32 item, uint32 count = 1, bool inBankAlso = false) const -> bool;
    auto HasItemFitToSpellRequirements(SpellInfo const* spellInfo, Item const* ignoreItem = nullptr) const -> bool;
    auto CanNoReagentCast(SpellInfo const* spellInfo) const -> bool;
    [[nodiscard]] auto HasItemOrGemWithIdEquipped(uint32 item, uint32 count, uint8 except_slot = NULL_SLOT) const -> bool;
    [[nodiscard]] auto HasItemOrGemWithLimitCategoryEquipped(uint32 limitCategory, uint32 count, uint8 except_slot = NULL_SLOT) const -> bool;
    auto CanTakeMoreSimilarItems(Item* pItem) const -> InventoryResult { return CanTakeMoreSimilarItems(pItem->GetEntry(), pItem->GetCount(), pItem); }
    [[nodiscard]] auto CanTakeMoreSimilarItems(uint32 entry, uint32 count) const -> InventoryResult { return CanTakeMoreSimilarItems(entry, count, nullptr); }
    auto CanStoreNewItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, uint32 item, uint32 count, uint32* no_space_count = nullptr) const -> InventoryResult
    {
        return CanStoreItem(bag, slot, dest, item, count, nullptr, false, no_space_count);
    }
    auto CanStoreItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, Item* pItem, bool swap = false) const -> InventoryResult
    {
        if (!pItem)
            return EQUIP_ERR_ITEM_NOT_FOUND;
        uint32 count = pItem->GetCount();
        return CanStoreItem(bag, slot, dest, pItem->GetEntry(), count, pItem, swap, nullptr);
    }
    auto CanStoreItems(Item** pItem, int32 count) const -> InventoryResult;
    auto CanEquipNewItem(uint8 slot, uint16& dest, uint32 item, bool swap) const -> InventoryResult;
    auto CanEquipItem(uint8 slot, uint16& dest, Item* pItem, bool swap, bool not_loading = true) const -> InventoryResult;

    auto CanEquipUniqueItem(Item* pItem, uint8 except_slot = NULL_SLOT, uint32 limit_count = 1) const -> InventoryResult;
    auto CanEquipUniqueItem(ItemTemplate const* itemProto, uint8 except_slot = NULL_SLOT, uint32 limit_count = 1) const -> InventoryResult;
    [[nodiscard]] auto CanUnequipItems(uint32 item, uint32 count) const -> InventoryResult;
    [[nodiscard]] auto CanUnequipItem(uint16 src, bool swap) const -> InventoryResult;
    auto CanBankItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, Item* pItem, bool swap, bool not_loading = true) const -> InventoryResult;
    auto CanUseItem(Item* pItem, bool not_loading = true) const -> InventoryResult;
    [[nodiscard]] auto HasItemTotemCategory(uint32 TotemCategory) const -> bool;
    auto IsTotemCategoryCompatiableWith(const ItemTemplate* pProto, uint32 requiredTotemCategoryId) const -> bool;
    auto CanUseItem(ItemTemplate const* pItem) const -> InventoryResult;
    [[nodiscard]] auto CanUseAmmo(uint32 item) const -> InventoryResult;
    auto CanRollForItemInLFG(ItemTemplate const* item, WorldObject const* lootedObject) const -> InventoryResult;
    auto StoreNewItem(ItemPosCountVec const& pos, uint32 item, bool update, int32 randomPropertyId = 0) -> Item*;
    auto StoreNewItem(ItemPosCountVec const& pos, uint32 item, bool update, int32 randomPropertyId, AllowedLooterSet& allowedLooters) -> Item*;
    auto StoreItem(ItemPosCountVec const& pos, Item* pItem, bool update) -> Item*;
    auto EquipNewItem(uint16 pos, uint32 item, bool update) -> Item*;
    auto EquipItem(uint16 pos, Item* pItem, bool update) -> Item*;
    void AutoUnequipOffhandIfNeed(bool force = false);
    auto StoreNewItemInBestSlots(uint32 item_id, uint32 item_count) -> bool;
    void AutoStoreLoot(uint8 bag, uint8 slot, uint32 loot_id, LootStore const& store, bool broadcast = false);
    void AutoStoreLoot(uint32 loot_id, LootStore const& store, bool broadcast = false) { AutoStoreLoot(NULL_BAG, NULL_SLOT, loot_id, store, broadcast); }
    void StoreLootItem(uint8 lootSlot, Loot* loot);
    void UpdateLootAchievements(LootItem* item, Loot* loot);
    void UpdateTitansGrip();

    auto CanTakeMoreSimilarItems(uint32 entry, uint32 count, Item* pItem, uint32* no_space_count = nullptr) const -> InventoryResult;
    auto CanStoreItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, uint32 entry, uint32 count, Item* pItem = nullptr, bool swap = false, uint32* no_space_count = nullptr) const -> InventoryResult;

    void AddRefundReference(ObjectGuid itemGUID);
    void DeleteRefundReference(ObjectGuid itemGUID);

    void ApplyEquipCooldown(Item* pItem);
    void SetAmmo(uint32 item);
    void RemoveAmmo();
    [[nodiscard]] auto GetAmmoDPS() const -> float { return m_ammoDPS; }
    auto CheckAmmoCompatibility(const ItemTemplate* ammo_proto) const -> bool;
    void QuickEquipItem(uint16 pos, Item* pItem);
    void VisualizeItem(uint8 slot, Item* pItem);
    void SetVisibleItemSlot(uint8 slot, Item* pItem);
    auto BankItem(ItemPosCountVec const& dest, Item* pItem, bool update) -> Item*
    {
        return StoreItem(dest, pItem, update);
    }
    auto BankItem(uint16 pos, Item* pItem, bool update) -> Item*;
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
    void AddItemToBuyBackSlot(Item* pItem);
    auto GetItemFromBuyBackSlot(uint32 slot) -> Item*;
    void RemoveItemFromBuyBackSlot(uint32 slot, bool del);
    [[nodiscard]] auto GetMaxKeyringSize() const -> uint32 { return KEYRING_SLOT_END - KEYRING_SLOT_START; }
    void SendEquipError(InventoryResult msg, Item* pItem, Item* pItem2 = nullptr, uint32 itemid = 0);
    void SendBuyError(BuyResult msg, Creature* creature, uint32 item, uint32 param);
    void SendSellError(SellResult msg, Creature* creature, ObjectGuid guid, uint32 param);
    void AddWeaponProficiency(uint32 newflag) { m_WeaponProficiency |= newflag; }
    void AddArmorProficiency(uint32 newflag) { m_ArmorProficiency |= newflag; }
    [[nodiscard]] auto GetWeaponProficiency() const -> uint32 { return m_WeaponProficiency; }
    [[nodiscard]] auto GetArmorProficiency() const -> uint32 { return m_ArmorProficiency; }

    [[nodiscard]] auto IsTwoHandUsed() const -> bool
    {
        Item* mainItem = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);
        return mainItem && mainItem->GetTemplate()->InventoryType == INVTYPE_2HWEAPON && !CanTitanGrip();
    }
    void SendNewItem(Item* item, uint32 count, bool received, bool created, bool broadcast = false, bool sendChatMessage = true);
    auto BuyItemFromVendorSlot(ObjectGuid vendorguid, uint32 vendorslot, uint32 item, uint8 count, uint8 bag, uint8 slot) -> bool;
    auto _StoreOrEquipNewItem(uint32 vendorslot, uint32 item, uint8 count, uint8 bag, uint8 slot, int32 price, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore) -> bool;

    auto GetReputationPriceDiscount(Creature const* creature) const -> float;

    [[nodiscard]] auto GetTrader() const -> Player* { return m_trade ? m_trade->GetTrader() : nullptr; }
    [[nodiscard]] auto GetTradeData() const -> TradeData* { return m_trade; }
    void TradeCancel(bool sendback);

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
    void BuildEnchantmentsInfoData(WorldPacket* data);
    void AddItemDurations(Item* item);
    void RemoveItemDurations(Item* item);
    void SendItemDurations();
    void LoadCorpse(PreparedQueryResult result);
    void LoadPet();

    auto AddItem(uint32 itemId, uint32 count) -> bool;

    /*********************************************************/
    /***                    GOSSIP SYSTEM                  ***/
    /*********************************************************/

    void PrepareGossipMenu(WorldObject* source, uint32 menuId = 0, bool showQuests = false);
    void SendPreparedGossip(WorldObject* source);
    void OnGossipSelect(WorldObject* source, uint32 gossipListId, uint32 menuId);

    auto GetGossipTextId(uint32 menuId, WorldObject* source) -> uint32;
    auto GetGossipTextId(WorldObject* source) -> uint32;
    static auto GetDefaultGossipMenuForSource(WorldObject* source) -> uint32;

    void ToggleInstantFlight();

    /*********************************************************/
    /***                    QUEST SYSTEM                   ***/
    /*********************************************************/

    auto GetQuestLevel(Quest const* quest) const -> int32 { return quest && (quest->GetQuestLevel() > 0) ? quest->GetQuestLevel() : getLevel(); }

    void PrepareQuestMenu(ObjectGuid guid);
    void SendPreparedQuest(ObjectGuid guid);
    [[nodiscard]] auto IsActiveQuest(uint32 quest_id) const -> bool;
    auto GetNextQuest(ObjectGuid guid, Quest const* quest) -> Quest const*;
    auto CanSeeStartQuest(Quest const* quest) -> bool;
    auto CanTakeQuest(Quest const* quest, bool msg) -> bool;
    auto CanAddQuest(Quest const* quest, bool msg) -> bool;
    auto CanCompleteQuest(uint32 quest_id, const QuestStatusData* q_savedStatus = nullptr) -> bool;
    auto CanCompleteRepeatableQuest(Quest const* quest) -> bool;
    auto CanRewardQuest(Quest const* quest, bool msg) -> bool;
    auto CanRewardQuest(Quest const* quest, uint32 reward, bool msg) -> bool;
    void AddQuestAndCheckCompletion(Quest const* quest, Object* questGiver);
    void AddQuest(Quest const* quest, Object* questGiver);
    void AbandonQuest(uint32 quest_id);
    void CompleteQuest(uint32 quest_id);
    void IncompleteQuest(uint32 quest_id);
    void RewardQuest(Quest const* quest, uint32 reward, Object* questGiver, bool announce = true, bool isLFGReward = false);
    void FailQuest(uint32 quest_id);
    auto SatisfyQuestSkill(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestLevel(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestLog(bool msg) -> bool;
    auto SatisfyQuestPreviousQuest(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestClass(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestRace(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestReputation(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestStatus(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestConditions(Quest const* qInfo, bool msg) -> bool;
    auto SatisfyQuestTimed(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestExclusiveGroup(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestNextChain(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestPrevChain(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestDay(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestWeek(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestMonth(Quest const* qInfo, bool msg) const -> bool;
    auto SatisfyQuestSeasonal(Quest const* qInfo, bool msg) const -> bool;
    auto GiveQuestSourceItem(Quest const* quest) -> bool;
    auto TakeQuestSourceItem(uint32 questId, bool msg) -> bool;
    [[nodiscard]] auto GetQuestRewardStatus(uint32 quest_id) const -> bool;
    [[nodiscard]] auto GetQuestStatus(uint32 quest_id) const -> QuestStatus;
    void SetQuestStatus(uint32 questId, QuestStatus status, bool update = true);
    void RemoveActiveQuest(uint32 questId, bool update = true);
    void RemoveRewardedQuest(uint32 questId, bool update = true);
    void SendQuestUpdate(uint32 questId);
    auto GetQuestDialogStatus(Object* questGiver) -> QuestGiverStatus;
    auto GetQuestRate(bool isDFQuest = false) -> float;
    void SetDailyQuestStatus(uint32 quest_id);
    auto IsDailyQuestDone(uint32 quest_id) -> bool;
    void SetWeeklyQuestStatus(uint32 quest_id);
    void SetMonthlyQuestStatus(uint32 quest_id);
    void SetSeasonalQuestStatus(uint32 quest_id);
    void ResetDailyQuestStatus();
    void ResetWeeklyQuestStatus();
    void ResetMonthlyQuestStatus();
    void ResetSeasonalQuestStatus(uint16 event_id);

    [[nodiscard]] auto FindQuestSlot(uint32 quest_id) const -> uint16;
    [[nodiscard]] auto GetQuestSlotQuestId(uint16 slot) const -> uint32 { return GetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_ID_OFFSET); }
    [[nodiscard]] auto GetQuestSlotState(uint16 slot)   const -> uint32 { return GetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_STATE_OFFSET); }
    [[nodiscard]] auto GetQuestSlotCounter(uint16 slot, uint8 counter) const -> uint16 { return (uint16)(GetUInt64Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_COUNTS_OFFSET) >> (counter * 16)); }
    [[nodiscard]] auto GetQuestSlotTime(uint16 slot)    const -> uint32 { return GetUInt32Value(PLAYER_QUEST_LOG_1_1 + slot * MAX_QUEST_OFFSET + QUEST_TIME_OFFSET); }
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
    auto GetReqKillOrCastCurrentCount(uint32 quest_id, int32 entry) -> uint16;
    void AreaExploredOrEventHappens(uint32 questId);
    void GroupEventHappens(uint32 questId, WorldObject const* pEventObject);
    void ItemAddedQuestCheck(uint32 entry, uint32 count);
    void ItemRemovedQuestCheck(uint32 entry, uint32 count);
    void KilledMonster(CreatureTemplate const* cInfo, ObjectGuid guid);
    void KilledMonsterCredit(uint32 entry, ObjectGuid guid = ObjectGuid::Empty);
    void KilledPlayerCredit();
    void KillCreditGO(uint32 entry, ObjectGuid guid = ObjectGuid::Empty);
    void TalkedToCreature(uint32 entry, ObjectGuid guid);
    void MoneyChanged(uint32 value);
    void ReputationChanged(FactionEntry const* factionEntry);
    void ReputationChanged2(FactionEntry const* factionEntry);
    [[nodiscard]] auto HasQuestForItem(uint32 itemId, uint32 excludeQuestId = 0, bool turnIn = false, bool* showInLoot = nullptr) const -> bool;
    [[nodiscard]] auto HasQuestForGO(int32 GOId) const -> bool;
    [[nodiscard]] auto HasQuest(uint32 questId) const -> bool;
    void UpdateForQuestWorldObjects();
    [[nodiscard]] auto CanShareQuest(uint32 quest_id) const -> bool;

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

    auto GetDivider() -> ObjectGuid { return m_divider; }
    void SetDivider(ObjectGuid guid = ObjectGuid::Empty) { m_divider = guid; }

    auto GetInGameTime() -> uint32 { return m_ingametime; }

    void SetInGameTime(uint32 time) { m_ingametime = time; }

    void AddTimedQuest(uint32 quest_id) { m_timedquests.insert(quest_id); }
    void RemoveTimedQuest(uint32 quest_id) { m_timedquests.erase(quest_id); }

    [[nodiscard]] auto HasPvPForcingQuest() const -> bool;

    /*********************************************************/
    /***                   LOAD SYSTEM                     ***/
    /*********************************************************/

    auto LoadFromDB(ObjectGuid guid, CharacterDatabaseQueryHolder const& holder) -> bool;
    [[nodiscard]] auto isBeingLoaded() const -> bool override;

    void Initialize(ObjectGuid::LowType guid);
    static auto GetUInt32ValueFromArray(Tokenizer const& data, uint16 index) -> uint32;
    static auto  GetFloatValueFromArray(Tokenizer const& data, uint16 index) -> float;
    static auto GetZoneIdFromDB(ObjectGuid guid) -> uint32;
    static auto   LoadPositionFromDB(uint32& mapid, float& x, float& y, float& z, float& o, bool& in_flight, ObjectGuid::LowType guid) -> bool;

    static auto IsValidGender(uint8 Gender) -> bool { return Gender <= GENDER_FEMALE; }

    /*********************************************************/
    /***                   SAVE SYSTEM                     ***/
    /*********************************************************/

    void SaveToDB(bool create, bool logout);
    void SaveToDB(CharacterDatabaseTransaction trans, bool create, bool logout);
    void SaveInventoryAndGoldToDB(CharacterDatabaseTransaction trans);                    // fast save function for item/money cheating preventing
    void SaveGoldToDB(CharacterDatabaseTransaction trans);

    static void SetUInt32ValueInArray(Tokenizer& data, uint16 index, uint32 value);
    static void SetFloatValueInArray(Tokenizer& data, uint16 index, float value);
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

    [[nodiscard]] auto GetMoney() const -> uint32 { return GetUInt32Value(PLAYER_FIELD_COINAGE); }
    auto ModifyMoney(int32 amount, bool sendError = true) -> bool;
    [[nodiscard]] auto HasEnoughMoney(uint32 amount) const -> bool { return (GetMoney() >= amount); }
    [[nodiscard]] auto HasEnoughMoney(int32 amount) const -> bool
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

    [[nodiscard]] auto getRewardedQuests() const -> RewardedQuestSet const& { return m_RewardedQuests; }
    auto getQuestStatusMap() -> QuestStatusMap& { return m_QuestStatus; }
    auto GetQuestStatusSaveMap() -> QuestStatusSaveMap& { return m_QuestStatusSave; }

    [[nodiscard]] auto GetRewardedQuestCount() const -> size_t { return m_RewardedQuests.size(); }
    [[nodiscard]] auto IsQuestRewarded(uint32 quest_id) const -> bool
    {
        return m_RewardedQuests.find(quest_id) != m_RewardedQuests.end();
    }

    [[nodiscard]] auto GetSelectedUnit() const -> Unit*;
    [[nodiscard]] auto GetSelectedPlayer() const -> Player*;

    void SetTarget(ObjectGuid /*guid*/ = ObjectGuid::Empty) override { } /// Used for serverside target changes, does not apply to players
    void SetSelection(ObjectGuid guid);

    [[nodiscard]] auto GetComboPoints() const -> uint8 { return m_comboPoints; }
    [[nodiscard]] auto GetComboTarget() const -> ObjectGuid { return m_comboTarget; }

    void AddComboPoints(Unit* target, int8 count);
    void ClearComboPoints();
    void SendComboPoints();

    void SendMailResult(uint32 mailId, MailResponseType mailAction, MailResponseResult mailError, uint32 equipError = 0, ObjectGuid::LowType item_guid = 0, uint32 item_count = 0);
    void SendNewMail();
    void UpdateNextMailTimeAndUnreads();
    void AddNewMailDeliverTime(time_t deliver_time);

    void RemoveMail(uint32 id);

    void AddMail(Mail* mail) { m_mail.push_front(mail); }// for call from WorldSession::SendMailTo
    auto GetMailSize() -> uint32 { return m_mail.size();}
    auto GetMail(uint32 id) -> Mail*;

    [[nodiscard]] auto GetMails() const -> PlayerMails const& { return m_mail; }
    void SendItemRetrievalMail(uint32 itemEntry, uint32 count); // Item retrieval mails sent by The Postmaster (34337)
    void SendItemRetrievalMail(std::vector<std::pair<uint32, uint32>> mailItems); // Item retrieval mails sent by The Postmaster (34337)

    /*********************************************************/
    /*** MAILED ITEMS SYSTEM ***/
    /*********************************************************/

    uint8 unReadMails;
    time_t m_nextMailDelivereTime;

    typedef std::unordered_map<ObjectGuid::LowType, Item*> ItemMap;

    ItemMap mMitems;                                    //template defined in objectmgr.cpp

    auto GetMItem(ObjectGuid::LowType itemLowGuid) -> Item*
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

    auto RemoveMItem(ObjectGuid::LowType itemLowGuid) -> bool
    {
        return !!mMitems.erase(itemLowGuid);
    }

    void PetSpellInitialize();
    void CharmSpellInitialize();
    void PossessSpellInitialize();
    void VehicleSpellInitialize();
    void SendRemoveControlBar();
    [[nodiscard]] auto HasSpell(uint32 spell) const -> bool override;
    [[nodiscard]] auto HasActiveSpell(uint32 spell) const -> bool;            // show in spellbook
    auto GetTrainerSpellState(TrainerSpell const* trainer_spell) const -> TrainerSpellState;
    [[nodiscard]] auto IsSpellFitByClassAndRace(uint32 spell_id) const -> bool;
    auto IsNeedCastPassiveSpellAtLearn(SpellInfo const* spellInfo) const -> bool;

    void SendProficiency(ItemClass itemClass, uint32 itemSubclassMask);
    void SendInitialSpells();
    void SendLearnPacket(uint32 spellId, bool learn);
    auto addSpell(uint32 spellId, uint8 addSpecMask, bool updateActive, bool temporary = false, bool learnFromSkill = false) -> bool;
    auto _addSpell(uint32 spellId, uint8 addSpecMask, bool temporary, bool learnFromSkill = false) -> bool;
    void learnSpell(uint32 spellId, bool temporary = false, bool learnFromSkill = false);
    void removeSpell(uint32 spellId, uint8 removeSpecMask, bool onlyTemporary);
    void resetSpells();
    void LearnCustomSpells();
    void LearnDefaultSkills();
    void LearnDefaultSkill(uint32 skillId, uint16 rank);
    void learnQuestRewardedSpells();
    void learnQuestRewardedSpells(Quest const* quest);
    void learnSpellHighRank(uint32 spellid);
    void SetReputation(uint32 factionentry, uint32 value);
    [[nodiscard]] auto GetReputation(uint32 factionentry) const -> uint32;
    auto GetGuildName() -> std::string const&;
    [[nodiscard]] auto GetFreeTalentPoints() const -> uint32 { return GetUInt32Value(PLAYER_CHARACTER_POINTS1); }
    void SetFreeTalentPoints(uint32 points);
    auto resetTalents(bool noResetCost = false) -> bool;
    [[nodiscard]] auto resetTalentsCost() const -> uint32;
    void InitTalentForLevel();
    void BuildPlayerTalentsInfoData(WorldPacket* data);
    void BuildPetTalentsInfoData(WorldPacket* data);
    void SendTalentsInfoData(bool pet);
    void LearnTalent(uint32 talentId, uint32 talentRank);
    void LearnPetTalent(ObjectGuid petGuid, uint32 talentId, uint32 talentRank);

    auto addTalent(uint32 spellId, uint8 addSpecMask, uint8 oldTalentRank) -> bool;
    void _removeTalent(PlayerTalentMap::iterator& itr, uint8 specMask);
    void _removeTalent(uint32 spellId, uint8 specMask);
    void _removeTalentAurasAndSpells(uint32 spellId);
    void _addTalentAurasAndSpells(uint32 spellId);
    [[nodiscard]] auto HasTalent(uint32 spell_id, uint8 spec) const -> bool;

    [[nodiscard]] auto CalculateTalentsPoints() const -> uint32;

    // Dual Spec
    void UpdateSpecCount(uint8 count);
    [[nodiscard]] auto GetActiveSpec() const -> uint8 { return m_activeSpec; }
    [[nodiscard]] auto GetActiveSpecMask() const -> uint8 { return (1 << m_activeSpec); }
    void SetActiveSpec(uint8 spec) { m_activeSpec = spec; }
    [[nodiscard]] auto GetSpecsCount() const -> uint8 { return m_specsCount; }
    void SetSpecsCount(uint8 count) { m_specsCount = count; }
    void ActivateSpec(uint8 spec);
    void LoadActions(PreparedQueryResult result);
    void GetTalentTreePoints(uint8 (&specPoints)[3]) const;
    [[nodiscard]] auto GetMostPointsTalentTree() const -> uint8;
    auto HasTankSpec() -> bool;
    auto HasMeleeSpec() -> bool;
    auto HasCasterSpec() -> bool;
    auto HasHealSpec() -> bool;
    auto GetSpec(int8 spec = -1) -> uint32;

    void InitGlyphsForLevel();
    void SetGlyphSlot(uint8 slot, uint32 slottype) { SetUInt32Value(PLAYER_FIELD_GLYPH_SLOTS_1 + slot, slottype); }
    [[nodiscard]] auto GetGlyphSlot(uint8 slot) const -> uint32 { return GetUInt32Value(PLAYER_FIELD_GLYPH_SLOTS_1 + slot); }
    void SetGlyph(uint8 slot, uint32 glyph, bool save)
    {
        m_Glyphs[m_activeSpec][slot] = glyph;
        SetUInt32Value(PLAYER_FIELD_GLYPHS_1 + slot, glyph);

        if (save)
            SetNeedToSaveGlyphs(true);
    }
    [[nodiscard]] auto GetGlyph(uint8 slot) const -> uint32 { return m_Glyphs[m_activeSpec][slot]; }

    [[nodiscard]] auto GetFreePrimaryProfessionPoints() const -> uint32 { return GetUInt32Value(PLAYER_CHARACTER_POINTS2); }
    void SetFreePrimaryProfessions(uint16 profs) { SetUInt32Value(PLAYER_CHARACTER_POINTS2, profs); }
    void InitPrimaryProfessions();

    [[nodiscard]] auto GetSpellMap() const -> PlayerSpellMap const& { return m_spells; }
    auto       GetSpellMap() -> PlayerSpellMap&       { return m_spells; }

    [[nodiscard]] auto GetSpellCooldownMap() const -> SpellCooldowns const& { return m_spellCooldowns; }
    auto       GetSpellCooldownMap() -> SpellCooldowns&       { return m_spellCooldowns; }

    void AddSpellMod(SpellModifier* mod, bool apply);
    auto IsAffectedBySpellmod(SpellInfo const* spellInfo, SpellModifier* mod, Spell* spell = nullptr) -> bool;
    auto HasSpellMod(SpellModifier* mod, Spell* spell) -> bool;
    template <class T> auto ApplySpellMod(uint32 spellId, SpellModOp op, T& basevalue, Spell* spell = nullptr, bool temporaryPet = false) -> T;
    void RemoveSpellMods(Spell* spell);
    void RestoreSpellMods(Spell* spell, uint32 ownerAuraId = 0, Aura* aura = nullptr);
    void RestoreAllSpellMods(uint32 ownerAuraId = 0, Aura* aura = nullptr);
    void DropModCharge(SpellModifier* mod, Spell* spell);
    void SetSpellModTakingSpell(Spell* spell, bool apply);

    [[nodiscard]] auto HasSpellCooldown(uint32 spell_id) const -> bool override
    {
        SpellCooldowns::const_iterator itr = m_spellCooldowns.find(spell_id);
        return itr != m_spellCooldowns.end() && itr->second.end > World::GetGameTimeMS();
    }
    [[nodiscard]] auto HasSpellItemCooldown(uint32 spell_id, uint32 itemid) const -> bool override
    {
        SpellCooldowns::const_iterator itr = m_spellCooldowns.find(spell_id);
        return itr != m_spellCooldowns.end() && itr->second.end > World::GetGameTimeMS() && itr->second.itemid == itemid;
    }
    [[nodiscard]] auto GetSpellCooldownDelay(uint32 spell_id) const -> uint32
    {
        SpellCooldowns::const_iterator itr = m_spellCooldowns.find(spell_id);
        return uint32(itr != m_spellCooldowns.end() && itr->second.end > World::GetGameTimeMS() ? itr->second.end - World::GetGameTimeMS() : 0);
    }
    void AddSpellAndCategoryCooldowns(SpellInfo const* spellInfo, uint32 itemId, Spell* spell = nullptr, bool infinityCooldown = false);
    void AddSpellCooldown(uint32 spell_id, uint32 itemid, uint32 end_time, bool needSendToClient = false, bool forceSendToSpectator = false) override;
    void _AddSpellCooldown(uint32 spell_id, uint16 categoryId, uint32 itemid, uint32 end_time, bool needSendToClient = false, bool forceSendToSpectator = false);
    void ModifySpellCooldown(uint32 spellId, int32 cooldown);
    void SendCooldownEvent(SpellInfo const* spellInfo, uint32 itemId = 0, Spell* spell = nullptr, bool setCooldown = true);
    void ProhibitSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs) override;
    void RemoveSpellCooldown(uint32 spell_id, bool update = false);
    void SendClearCooldown(uint32 spell_id, Unit* target);

    auto GetGlobalCooldownMgr() -> GlobalCooldownMgr& { return m_GlobalCooldownMgr; }

    void RemoveCategoryCooldown(uint32 cat);
    void RemoveArenaSpellCooldowns(bool removeActivePetCooldowns = false);
    void RemoveAllSpellCooldown();
    void _LoadSpellCooldowns(PreparedQueryResult result);
    void _SaveSpellCooldowns(CharacterDatabaseTransaction trans, bool logout);
    auto GetLastPotionId() -> uint32 { return m_lastPotionId; }
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
    [[nodiscard]] auto isResurrectRequestedBy(ObjectGuid guid) const -> bool { return m_resurrectGUID && m_resurrectGUID == guid; }
    [[nodiscard]] auto isResurrectRequested() const -> bool { return m_resurrectGUID; }
    void ResurectUsingRequestData();

    [[nodiscard]] auto getCinematic() const -> uint8
    {
        return m_cinematic;
    }
    void setCinematic(uint8 cine)
    {
        m_cinematic = cine;
    }

    auto addActionButton(uint8 button, uint32 action, uint8 type) -> ActionButton*;
    void removeActionButton(uint8 button);
    auto GetActionButton(uint8 button) -> ActionButton const*;
    void SendInitialActionButtons() const { SendActionButtons(1); }
    void SendActionButtons(uint32 state) const;
    auto IsActionButtonDataValid(uint8 button, uint32 action, uint8 type) -> bool;

    PvPInfo pvpInfo;
    void UpdatePvPState();
    void UpdateFFAPvPState(bool reset = true);
    void SetPvP(bool state)
    {
        Unit::SetPvP(state);
        if (!m_Controlled.empty())
            for (auto itr : m_Controlled)
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
        RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_CONTESTED_PVP);
        m_contestedPvPTimer = 0;
    }

    /** todo: -maybe move UpdateDuelFlag+DuelComplete to independent DuelHandler.. **/
    std::unique_ptr<DuelInfo> duel;
    void UpdateDuelFlag(time_t currTime);
    void CheckDuelDistance(time_t currTime);
    void DuelComplete(DuelCompleteType type);
    void SendDuelCountdown(uint32 counter);

    auto IsGroupVisibleFor(Player const* p) const -> bool;
    auto IsInSameGroupWith(Player const* p) const -> bool;
    auto IsInSameRaidWith(Player const* p) const -> bool { return p == this || (GetGroup() != nullptr && GetGroup() == p->GetGroup()); }
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
    [[nodiscard]] auto GetRank() const -> uint8 { return uint8(GetUInt32Value(PLAYER_GUILDRANK)); }
    void SetGuildIdInvited(uint32 GuildId) { m_GuildIdInvited = GuildId; }
    [[nodiscard]] auto GetGuildId() const -> uint32 { return GetUInt32Value(PLAYER_GUILDID);  }
    [[nodiscard]] auto GetGuild() const -> Guild*;
    auto GetGuildIdInvited() -> uint32 { return m_GuildIdInvited; }
    static void RemovePetitionsAndSigns(ObjectGuid guid, uint32 type);

    // Arena Team
    void SetInArenaTeam(uint32 ArenaTeamId, uint8 slot, uint8 type)
    {
        SetArenaTeamInfoField(slot, ARENA_TEAM_ID, ArenaTeamId);
        SetArenaTeamInfoField(slot, ARENA_TEAM_TYPE, type);
    }
    void SetArenaTeamInfoField(uint8 slot, ArenaTeamInfoType type, uint32 value);
    [[nodiscard]] auto GetArenaPersonalRating(uint8 slot) const -> uint32;
    static auto GetArenaTeamIdFromDB(ObjectGuid guid, uint8 slot) -> uint32;
    static void LeaveAllArenaTeams(ObjectGuid guid);
    [[nodiscard]] auto GetArenaTeamId(uint8 slot) const -> uint32;
    void SetArenaTeamIdInvited(uint32 ArenaTeamId) { m_ArenaTeamIdInvited = ArenaTeamId; }
    auto GetArenaTeamIdInvited() -> uint32 { return m_ArenaTeamIdInvited; }

    [[nodiscard]] auto GetDifficulty(bool isRaid) const -> Difficulty { return isRaid ? m_raidDifficulty : m_dungeonDifficulty; }
    [[nodiscard]] auto GetDungeonDifficulty() const -> Difficulty { return m_dungeonDifficulty; }
    [[nodiscard]] auto GetRaidDifficulty() const -> Difficulty { return m_raidDifficulty; }
    [[nodiscard]] auto GetStoredRaidDifficulty() const -> Difficulty { return m_raidMapDifficulty; } // only for use in difficulty packet after exiting to raid map
    void SetDungeonDifficulty(Difficulty dungeon_difficulty) { m_dungeonDifficulty = dungeon_difficulty; }
    void SetRaidDifficulty(Difficulty raid_difficulty) { m_raidDifficulty = raid_difficulty; }
    void StoreRaidMapDifficulty() { m_raidMapDifficulty = GetMap()->GetDifficulty(); }

    auto UpdateSkill(uint32 skill_id, uint32 step) -> bool;
    auto UpdateSkillPro(uint16 SkillId, int32 Chance, uint32 step) -> bool;

    auto UpdateCraftSkill(uint32 spellid) -> bool;
    auto UpdateGatherSkill(uint32 SkillId, uint32 SkillValue, uint32 RedLevel, uint32 Multiplicator = 1) -> bool;
    auto UpdateFishingSkill() -> bool;

    [[nodiscard]] auto GetBaseDefenseSkillValue() const -> uint32 { return GetBaseSkillValue(SKILL_DEFENSE); }
    [[nodiscard]] auto GetBaseWeaponSkillValue(WeaponAttackType attType) const -> uint32;

    auto GetSpellByProto(ItemTemplate* proto) -> uint32;

    auto GetHealthBonusFromStamina() -> float;
    auto GetManaBonusFromIntellect() -> float;

    auto UpdateStats(Stats stat) -> bool override;
    auto UpdateAllStats() -> bool override;
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

    void CalculateMinMaxDamage(WeaponAttackType attType, bool normalized, bool addTotalPct, float& minDamage, float& maxDamage) override;

    void UpdateDefenseBonusesMod();
    inline void RecalculateRating(CombatRating cr) { ApplyRatingMod(cr, 0, true);}
    auto GetMeleeCritFromAgility() -> float;
    void GetDodgeFromAgility(float& diminishing, float& nondiminishing);
    [[nodiscard]] auto GetMissPercentageFromDefence() const -> float;
    auto GetSpellCritFromIntellect() -> float;
    auto OCTRegenHPPerSpirit() -> float;
    auto OCTRegenMPPerSpirit() -> float;
    [[nodiscard]] auto GetRatingMultiplier(CombatRating cr) const -> float;
    [[nodiscard]] auto GetRatingBonusValue(CombatRating cr) const -> float;
    auto GetBaseSpellPowerBonus() -> uint32 { return m_baseSpellPower; }
    [[nodiscard]] auto GetSpellPenetrationItemMod() const -> int32 { return m_spellPenetrationItemMod; }

    [[nodiscard]] auto GetExpertiseDodgeOrParryReduction(WeaponAttackType attType) const -> float;
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

    [[nodiscard]] auto GetLootGUID() const -> ObjectGuid { return m_lootGuid; }
    void SetLootGUID(ObjectGuid guid) { m_lootGuid = guid; }

    void RemovedInsignia(Player* looterPlr);

    [[nodiscard]] auto GetSession() const -> WorldSession* { return m_session; }
    void SetSession(WorldSession* sess) { m_session = sess; }

    void BuildCreateUpdateBlockForPlayer(UpdateData* data, Player* target) const override;
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

    auto UpdatePosition(float x, float y, float z, float orientation, bool teleport = false) -> bool override;
    auto UpdatePosition(const Position& pos, bool teleport = false) -> bool { return UpdatePosition(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), teleport); }

    void ProcessTerrainStatusUpdate() override;

    void SendMessageToSet(WorldPacket* data, bool self) override { SendMessageToSetInRange(data, GetVisibilityRange(), self, true); } // pussywizard!
    void SendMessageToSetInRange(WorldPacket* data, float dist, bool self, bool includeMargin = false, Player const* skipped_rcvr = nullptr) override; // pussywizard!
    void SendMessageToSetInRange_OwnTeam(WorldPacket* data, float dist, bool self); // pussywizard! param includeMargin not needed here
    void SendMessageToSet(WorldPacket* data, Player const* skipped_rcvr) override { SendMessageToSetInRange(data, GetVisibilityRange(), skipped_rcvr != this, true, skipped_rcvr); } // pussywizard!

    void SendTeleportAckPacket();

    [[nodiscard]] auto GetCorpse() const -> Corpse*;
    void SpawnCorpseBones(bool triggerSave = true);
    auto CreateCorpse() -> Corpse*;
    void RemoveCorpse();
    void KillPlayer();
    static void OfflineResurrect(ObjectGuid const guid, CharacterDatabaseTransaction trans);
    [[nodiscard]] auto HasCorpse() const -> bool { return _corpseLocation.GetMapId() != MAPID_INVALID; }
    [[nodiscard]] auto GetCorpseLocation() const -> WorldLocation { return _corpseLocation; }
    auto GetResurrectionSpellId() -> uint32;
    void ResurrectPlayer(float restore_percent, bool applySickness = false);
    void BuildPlayerRepop();
    void RepopAtGraveyard();

    void DurabilityLossAll(double percent, bool inventory);
    void DurabilityLoss(Item* item, double percent);
    void DurabilityPointsLossAll(int32 points, bool inventory);
    void DurabilityPointsLoss(Item* item, int32 points);
    void DurabilityPointLossForEquipSlot(EquipmentSlots slot);
    auto DurabilityRepairAll(bool cost, float discountMod, bool guildBank) -> uint32;
    auto DurabilityRepair(uint16 pos, bool cost, float discountMod, bool guildBank) -> uint32;

    void UpdateMirrorTimers();
    void StopMirrorTimers()
    {
        StopMirrorTimer(FATIGUE_TIMER);
        StopMirrorTimer(BREATH_TIMER);
        StopMirrorTimer(FIRE_TIMER);
    }
    auto IsMirrorTimerActive(MirrorTimerType type) -> bool { return m_MirrorTimer[type] == getMaxTimer(type); }

    void SetMovement(PlayerMovementType pType);

    auto CanJoinConstantChannelInZone(ChatChannelsEntry const* channel, AreaTableEntry const* zone) -> bool;

    void JoinedChannel(Channel* c);
    void LeftChannel(Channel* c);
    void CleanupChannels();
    void ClearChannelWatch();
    void UpdateLocalChannels(uint32 newZone);

    void UpdateDefense();
    void UpdateWeaponSkill(Unit* victim, WeaponAttackType attType, Item* item = nullptr);
    void UpdateCombatSkills(Unit* victim, WeaponAttackType attType, bool defence, Item* item = nullptr);

    void SetSkill(uint16 id, uint16 step, uint16 currVal, uint16 maxVal);
    [[nodiscard]] auto GetMaxSkillValue(uint32 skill) const -> uint16;        // max + perm. bonus + temp bonus
    [[nodiscard]] auto GetPureMaxSkillValue(uint32 skill) const -> uint16;    // max
    [[nodiscard]] auto GetSkillValue(uint32 skill) const -> uint16;           // skill value + perm. bonus + temp bonus
    [[nodiscard]] auto GetBaseSkillValue(uint32 skill) const -> uint16;       // skill value + perm. bonus
    [[nodiscard]] auto GetPureSkillValue(uint32 skill) const -> uint16;       // skill value
    [[nodiscard]] auto GetSkillPermBonusValue(uint32 skill) const -> int16;
    [[nodiscard]] auto GetSkillTempBonusValue(uint32 skill) const -> int16;
    [[nodiscard]] auto GetSkillStep(uint16 skill) const -> uint16;            // 0...6
    [[nodiscard]] auto HasSkill(uint32 skill) const -> bool;
    void learnSkillRewardedSpells(uint32 id, uint32 value);

    auto GetTeleportDest() -> WorldLocation& { return teleportStore_dest; }
    [[nodiscard]] auto IsBeingTeleported() const -> bool { return mSemaphoreTeleport_Near != 0 || mSemaphoreTeleport_Far != 0; }
    [[nodiscard]] auto IsBeingTeleportedNear() const -> bool { return mSemaphoreTeleport_Near != 0; }
    [[nodiscard]] auto IsBeingTeleportedFar() const -> bool { return mSemaphoreTeleport_Far != 0; }
    void SetSemaphoreTeleportNear(time_t tm) { mSemaphoreTeleport_Near = tm; }
    void SetSemaphoreTeleportFar(time_t tm) { mSemaphoreTeleport_Far = tm; }
    [[nodiscard]] auto GetSemaphoreTeleportNear() const -> time_t { return mSemaphoreTeleport_Near; }
    [[nodiscard]] auto GetSemaphoreTeleportFar() const -> time_t { return mSemaphoreTeleport_Far; }
    void ProcessDelayedOperations();
    [[nodiscard]] auto GetDelayedOperations() const -> uint32 { return m_DelayedOperations; }
    void ScheduleDelayedOperation(uint32 operation)
    {
        if (operation < DELAYED_END)
            m_DelayedOperations |= operation;
    }

    void CheckAreaExploreAndOutdoor();

    static auto TeamIdForRace(uint8 race) -> TeamId;
    [[nodiscard]] auto GetTeamId(bool original = false) const -> TeamId { return original ? TeamIdForRace(getRace(true)) : m_team; };
    void SetFactionForRace(uint8 race);
    void setTeamId(TeamId teamid) { m_team = teamid; };

    void InitDisplayIds();

    auto IsAtGroupRewardDistance(WorldObject const* pRewardSource) const -> bool;
    auto IsAtLootRewardDistance(WorldObject const* pRewardSource) const -> bool;
    auto IsAtRecruitAFriendDistance(WorldObject const* pOther) const -> bool;
    void RewardPlayerAndGroupAtKill(Unit* victim, bool isBattleGround);
    void RewardPlayerAndGroupAtEvent(uint32 creature_id, WorldObject* pRewardSource);
    auto isHonorOrXPTarget(Unit* victim) const -> bool;

    auto GetsRecruitAFriendBonus(bool forXP) -> bool;
    auto GetGrantableLevels() -> uint8 { return m_grantableLevels; }
    void SetGrantableLevels(uint8 val) { m_grantableLevels = val; }

    auto       GetReputationMgr() -> ReputationMgr&       { return *m_reputationMgr; }
    [[nodiscard]] auto GetReputationMgr() const -> ReputationMgr const& { return *m_reputationMgr; }
    [[nodiscard]] auto GetReputationRank(uint32 faction_id) const -> ReputationRank;
    void RewardReputation(Unit* victim, float rate);
    void RewardReputation(Quest const* quest);

    auto CalculateReputationGain(ReputationSource source, uint32 creatureOrQuestLevel, int32 rep, int32 faction, bool noQuestBonus = false) -> int32;

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
    auto RewardHonor(Unit* victim, uint32 groupsize, int32 honor = -1, bool awardXP = true) -> bool;
    [[nodiscard]] auto GetHonorPoints() const -> uint32 { return GetUInt32Value(PLAYER_FIELD_HONOR_CURRENCY); }
    [[nodiscard]] auto GetArenaPoints() const -> uint32 { return GetUInt32Value(PLAYER_FIELD_ARENA_CURRENCY); }
    void ModifyHonorPoints(int32 value, CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr));      //! If trans is specified, honor save query will be added to trans
    void ModifyArenaPoints(int32 value, CharacterDatabaseTransaction trans = CharacterDatabaseTransaction(nullptr));      //! If trans is specified, arena point save query will be added to trans
    [[nodiscard]] auto GetMaxPersonalArenaRatingRequirement(uint32 minarenaslot) const -> uint32;
    void SetHonorPoints(uint32 value);
    void SetArenaPoints(uint32 value);

    // duel health and mana reset methods
    void SaveHealthBeforeDuel()     { healthBeforeDuel = GetHealth(); }
    void SaveManaBeforeDuel()       { manaBeforeDuel = GetPower(POWER_MANA); }
    void RestoreHealthAfterDuel()   { SetHealth(healthBeforeDuel); }
    void RestoreManaAfterDuel()     { SetPower(POWER_MANA, manaBeforeDuel); }

    //End of PvP System

    [[nodiscard]] inline auto GetSpellCooldowns() const -> SpellCooldowns { return m_spellCooldowns; }

    void SetDrunkValue(uint8 newDrunkValue, uint32 itemId = 0);
    [[nodiscard]] auto GetDrunkValue() const -> uint8 { return GetByteValue(PLAYER_BYTES_3, 1); }
    static auto GetDrunkenstateByValue(uint8 value) -> DrunkenState;

    [[nodiscard]] auto GetDeathTimer() const -> uint32 { return m_deathTimer; }
    [[nodiscard]] auto GetCorpseReclaimDelay(bool pvp) const -> uint32;
    void UpdateCorpseReclaimDelay();
    auto CalculateCorpseReclaimDelay(bool load = false) -> int32;
    void SendCorpseReclaimDelay(uint32 delay);

    [[nodiscard]] auto GetShieldBlockValue() const -> uint32 override;                 // overwrite Unit version (virtual)
    [[nodiscard]] auto CanParry() const -> bool { return m_canParry; }
    void SetCanParry(bool value);
    [[nodiscard]] auto CanBlock() const -> bool { return m_canBlock; }
    void SetCanBlock(bool value);
    [[nodiscard]] auto CanTitanGrip() const -> bool { return m_canTitanGrip; }
    void SetCanTitanGrip(bool value);
    [[nodiscard]] auto CanTameExoticPets() const -> bool { return IsGameMaster() || HasAuraType(SPELL_AURA_ALLOW_TAME_PET_TYPE); }

    void SetRegularAttackTime();
    void SetBaseModValue(BaseModGroup modGroup, BaseModType modType, float value) { m_auraBaseMod[modGroup][modType] = value; }
    void HandleBaseModValue(BaseModGroup modGroup, BaseModType modType, float amount, bool apply);
    [[nodiscard]] auto GetBaseModValue(BaseModGroup modGroup, BaseModType modType) const -> float;
    [[nodiscard]] auto GetTotalBaseModValue(BaseModGroup modGroup) const -> float;
    [[nodiscard]] auto GetTotalPercentageModValue(BaseModGroup modGroup) const -> float { return m_auraBaseMod[modGroup][FLAT_MOD] + m_auraBaseMod[modGroup][PCT_MOD]; }
    void _ApplyAllStatBonuses();
    void _RemoveAllStatBonuses();

    void ResetAllPowers();

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
    auto EnchantmentFitsRequirements(uint32 enchantmentcondition, int8 slot) -> bool;
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
    void SendUpdateWorldState(uint32 Field, uint32 Value);
    void SendDirectMessage(WorldPacket const* data) const;
    void SendBGWeekendWorldStates();
    void SendBattlefieldWorldStates();

    void GetAurasForTarget(Unit* target);

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

    [[nodiscard]] auto InBattleground() const -> bool { return m_bgData.bgInstanceID != 0; }
    [[nodiscard]] auto InArena() const -> bool;
    [[nodiscard]] auto GetBattlegroundId() const -> uint32 { return m_bgData.bgInstanceID; }
    [[nodiscard]] auto GetBattlegroundTypeId() const -> BattlegroundTypeId { return m_bgData.bgTypeID; }
    [[nodiscard]] auto GetCurrentBattlegroundQueueSlot() const -> uint32 { return m_bgData.bgQueueSlot; }
    [[nodiscard]] auto IsInvitedForBattlegroundInstance() const -> bool { return m_bgData.isInvited; }
    [[nodiscard]] auto IsCurrentBattlegroundRandom() const -> bool { return m_bgData.bgIsRandom; }
    auto GetBGData() -> BGData& { return m_bgData; }
    void SetBGData(BGData& bgdata) { m_bgData = bgdata; }
    [[nodiscard]] auto GetBattleground(bool create = false) const -> Battleground*;

    [[nodiscard]] auto InBattlegroundQueue() const -> bool
    {
        for (auto i : m_bgBattlegroundQueueID)
            if (i != BATTLEGROUND_QUEUE_NONE)
                return true;
        return false;
    }

    [[nodiscard]] auto GetBattlegroundQueueTypeId(uint32 index) const -> BattlegroundQueueTypeId { return m_bgBattlegroundQueueID[index]; }

    [[nodiscard]] auto GetBattlegroundQueueIndex(BattlegroundQueueTypeId bgQueueTypeId) const -> uint32
    {
        for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
            if (m_bgBattlegroundQueueID[i] == bgQueueTypeId)
                return i;
        return PLAYER_MAX_BATTLEGROUND_QUEUES;
    }

    [[nodiscard]] auto InBattlegroundQueueForBattlegroundQueueType(BattlegroundQueueTypeId bgQueueTypeId) const -> bool
    {
        return GetBattlegroundQueueIndex(bgQueueTypeId) < PLAYER_MAX_BATTLEGROUND_QUEUES;
    }

    void SetBattlegroundId(uint32 id, BattlegroundTypeId bgTypeId, uint32 queueSlot, bool invited, bool isRandom, TeamId teamId);

    auto AddBattlegroundQueueId(BattlegroundQueueTypeId val) -> uint32
    {
        for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
            if (m_bgBattlegroundQueueID[i] == BATTLEGROUND_QUEUE_NONE || m_bgBattlegroundQueueID[i] == val)
            {
                m_bgBattlegroundQueueID[i] = val;
                return i;
            }
        return PLAYER_MAX_BATTLEGROUND_QUEUES;
    }

    auto HasFreeBattlegroundQueueId() -> bool
    {
        for (auto & i : m_bgBattlegroundQueueID)
            if (i == BATTLEGROUND_QUEUE_NONE)
                return true;
        return false;
    }

    void RemoveBattlegroundQueueId(BattlegroundQueueTypeId val)
    {
        for (auto & i : m_bgBattlegroundQueueID)
            if (i == val)
            {
                i = BATTLEGROUND_QUEUE_NONE;
                return;
            }
    }

    [[nodiscard]] auto GetBgTeamId() const -> TeamId { return m_bgData.bgTeamId != TEAM_NEUTRAL ? m_bgData.bgTeamId : GetTeamId(); }

    void LeaveBattleground(Battleground* bg = nullptr);
    [[nodiscard]] auto CanJoinToBattleground() const -> bool;
    auto CanReportAfkDueToLimit() -> bool;
    void ReportedAfkBy(Player* reporter);
    void ClearAfkReports() { m_bgData.bgAfkReporter.clear(); }

    [[nodiscard]] auto GetBGAccessByLevel(BattlegroundTypeId bgTypeId) const -> bool;
    auto CanUseBattlegroundObject(GameObject* gameobject) const -> bool;
    [[nodiscard]] auto isTotalImmune() const -> bool;
    [[nodiscard]] auto CanCaptureTowerPoint() const -> bool;

    auto GetRandomWinner() -> bool { return m_IsBGRandomWinner; }
    void SetRandomWinner(bool isWinner);

    /*********************************************************/
    /***               OUTDOOR PVP SYSTEM                  ***/
    /*********************************************************/

    [[nodiscard]] auto GetOutdoorPvP() const -> OutdoorPvP*;
    // returns true if the player is in active state for outdoor pvp objective capturing, false otherwise
    auto IsOutdoorPvPActive() -> bool;

    /*********************************************************/
    /***              ENVIROMENTAL SYSTEM                  ***/
    /*********************************************************/

    auto IsImmuneToEnvironmentalDamage() -> bool;
    auto EnvironmentalDamage(EnviromentalDamage type, uint32 damage) -> uint32;

    /*********************************************************/
    /***               FLOOD FILTER SYSTEM                 ***/
    /*********************************************************/

    void UpdateSpeakTime(uint32 specialMessageLimit = 0);
    [[nodiscard]] auto CanSpeak() const -> bool;
    void ChangeSpeakTime(int utime);

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

    [[nodiscard]] auto canFlyInZone(uint32 mapid, uint32 zone, SpellInfo const* bySpell) const -> bool;

    void SetClientControl(Unit* target, bool allowMove, bool packetOnly = false);

    void SetMover(Unit* target);

    void SetSeer(WorldObject* target) { m_seer = target; }
    void SetViewpoint(WorldObject* target, bool apply);
    [[nodiscard]] auto GetViewpoint() const -> WorldObject*;
    void StopCastingCharm();
    void StopCastingBindSight();

    [[nodiscard]] auto GetSaveTimer() const -> uint32 { return m_nextSave; }
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

    [[nodiscard]] auto GetStartPosition() const -> WorldLocation;

    [[nodiscard]] auto GetEntryPoint() const -> WorldLocation const& { return m_entryPointData.joinPos; }
    void SetEntryPoint();

    // currently visible objects at player client
    GuidUnorderedSet m_clientGUIDs;
    std::vector<Unit*> m_newVisible; // pussywizard

    auto HaveAtClient(WorldObject const* u) const -> bool { return u == this || m_clientGUIDs.find(u->GetGUID()) != m_clientGUIDs.end(); }
    [[nodiscard]] auto HaveAtClient(ObjectGuid guid) const -> bool { return guid == GetGUID() || m_clientGUIDs.find(guid) != m_clientGUIDs.end(); }

    [[nodiscard]] auto IsNeverVisible() const -> bool override;

    auto IsVisibleGloballyFor(Player const* player) const -> bool;

    void GetInitialVisiblePackets(Unit* target);
    void UpdateObjectVisibility(bool forced = true, bool fromUpdate = false) override;
    void UpdateVisibilityForPlayer(bool mapChange = false);
    void UpdateVisibilityOf(WorldObject* target);
    void UpdateTriggerVisibility();

    template<class T>
    void UpdateVisibilityOf(T* target, UpdateData& data, std::vector<Unit*>& visibleNow);

    uint8 m_forced_speed_changes[MAX_MOVE_TYPE];

    [[nodiscard]] auto HasAtLoginFlag(AtLoginFlags f) const -> bool { return m_atLoginFlags & f; }
    void SetAtLoginFlag(AtLoginFlags f) { m_atLoginFlags |= f; }
    void RemoveAtLoginFlag(AtLoginFlags flags, bool persist = false);

    auto isUsingLfg() -> bool;
    auto inRandomLfgDungeon() -> bool;

    typedef std::set<uint32> DFQuestsDoneList;
    DFQuestsDoneList m_DFQuests;

    // Temporarily removed pet cache
    [[nodiscard]] auto GetTemporaryUnsummonedPetNumber() const -> uint32 { return m_temporaryUnsummonedPetNumber; }
    void SetTemporaryUnsummonedPetNumber(uint32 petnumber) { m_temporaryUnsummonedPetNumber = petnumber; }
    void UnsummonPetTemporaryIfAny();
    void ResummonPetTemporaryUnSummonedIfAny();
    [[nodiscard]] auto IsPetNeedBeTemporaryUnsummoned() const -> bool { return GetSession()->PlayerLogout() || !IsInWorld() || !IsAlive() || IsMounted()/*+in flight*/ || GetVehicle() || IsBeingTeleported(); }
    auto CanResummonPet(uint32 spellid) -> bool;

    void SendCinematicStart(uint32 CinematicSequenceId);
    void SendMovieStart(uint32 MovieId);

    [[nodiscard]] auto GetMaxSkillValueForLevel() const -> uint16;
    auto IsFFAPvP() -> bool;
    auto IsPvP() -> bool;

    /*********************************************************/
    /***                 INSTANCE SYSTEM                   ***/
    /*********************************************************/

    void UpdateHomebindTime(uint32 time);

    uint32 m_HomebindTimer;
    bool m_InstanceValid;
    void BindToInstance();
    void SetPendingBind(uint32 instanceId, uint32 bindTimer) { _pendingBindId = instanceId; _pendingBindTimer = bindTimer; }
    [[nodiscard]] auto HasPendingBind() const -> bool { return _pendingBindId > 0; }
    [[nodiscard]] auto GetPendingBind() const -> uint32 { return _pendingBindId; }
    void SendRaidInfo();
    void SendSavedInstances();
    void PrettyPrintRequirementsQuestList(const std::vector<const ProgressionRequirement*>& missingQuests) const;
    void PrettyPrintRequirementsAchievementsList(const std::vector<const ProgressionRequirement*>& missingAchievements) const;
    void PrettyPrintRequirementsItemsList(const std::vector<const ProgressionRequirement*>& missingItems) const;
    auto Satisfy(DungeonProgressionRequirements const* ar, uint32 target_map, bool report = false) -> bool;
    auto CheckInstanceLoginValid() -> bool;
    [[nodiscard]] auto CheckInstanceCount(uint32 instanceId) const -> bool;

    void AddInstanceEnterTime(uint32 instanceId, time_t enterTime)
    {
        if (_instanceResetTimes.find(instanceId) == _instanceResetTimes.end())
            _instanceResetTimes.insert(InstanceTimeMap::value_type(instanceId, enterTime + HOUR));
    }

    // last used pet number (for BG's)
    [[nodiscard]] auto GetLastPetNumber() const -> uint32 { return m_lastpetnumber; }
    void SetLastPetNumber(uint32 petnumber) { m_lastpetnumber = petnumber; }
    [[nodiscard]] auto GetLastPetSpell() const -> uint32 { return m_oldpetspell; }
    void SetLastPetSpell(uint32 petspell) { m_oldpetspell = petspell; }

    /*********************************************************/
    /***                   GROUP SYSTEM                    ***/
    /*********************************************************/

    auto GetGroupInvite() -> Group* { return m_groupInvite; }
    void SetGroupInvite(Group* group) { m_groupInvite = group; }
    auto GetGroup() -> Group* { return m_group.getTarget(); }
    [[nodiscard]] auto GetGroup() const -> const Group* { return (const Group*)m_group.getTarget(); }
    auto GetGroupRef() -> GroupReference& { return m_group; }
    void SetGroup(Group* group, int8 subgroup = -1);
    [[nodiscard]] auto GetSubGroup() const -> uint8 { return m_group.getSubGroup(); }
    [[nodiscard]] auto GetGroupUpdateFlag() const -> uint32 { return m_groupUpdateMask; }
    void SetGroupUpdateFlag(uint32 flag) { m_groupUpdateMask |= flag; }
    [[nodiscard]] auto GetAuraUpdateMaskForRaid() const -> uint64 { return m_auraRaidUpdateMask; }
    void SetAuraUpdateMaskForRaid(uint8 slot) { m_auraRaidUpdateMask |= (uint64(1) << slot); }
    auto GetNextRandomRaidMember(float radius) -> Player*;
    [[nodiscard]] auto CanUninviteFromGroup(ObjectGuid targetPlayerGUID = ObjectGuid::Empty) const -> PartyResult;

    // Battleground Group System
    void SetBattlegroundOrBattlefieldRaid(Group* group, int8 subgroup = -1);
    void RemoveFromBattlegroundOrBattlefieldRaid();
    auto GetOriginalGroup() -> Group* { return m_originalGroup.getTarget(); }
    auto GetOriginalGroupRef() -> GroupReference& { return m_originalGroup; }
    [[nodiscard]] auto GetOriginalSubGroup() const -> uint8 { return m_originalGroup.getSubGroup(); }
    void SetOriginalGroup(Group* group, int8 subgroup = -1);

    void SetPassOnGroupLoot(bool bPassOnGroupLoot) { m_bPassOnGroupLoot = bPassOnGroupLoot; }
    [[nodiscard]] auto GetPassOnGroupLoot() const -> bool { return m_bPassOnGroupLoot; }

    auto GetMapRef() -> MapReference& { return m_mapRef; }

    // Set map to player and add reference
    void SetMap(Map* map) override;
    void ResetMap() override;

    auto isAllowedToLoot(const Creature* creature) -> bool;

    [[nodiscard]] auto GetDeclinedNames() const -> DeclinedName const* { return m_declinedname; }
    [[nodiscard]] auto GetRunesState() const -> uint8 { return m_runes->runeState; }
    [[nodiscard]] auto GetBaseRune(uint8 index) const -> RuneType { return RuneType(m_runes->runes[index].BaseRune); }
    [[nodiscard]] auto GetCurrentRune(uint8 index) const -> RuneType { return RuneType(m_runes->runes[index].CurrentRune); }
    [[nodiscard]] auto GetRuneCooldown(uint8 index) const -> uint32 { return m_runes->runes[index].Cooldown; }
    [[nodiscard]] auto GetGracePeriod(uint8 index) const -> uint32 { return m_runes->runes[index].GracePeriod; }
    auto GetRuneBaseCooldown(uint8 index, bool skipGrace) -> uint32;
    [[nodiscard]] auto IsBaseRuneSlotsOnCooldown(RuneType runeType) const -> bool;
    auto GetLastUsedRune() -> RuneType { return m_runes->lastUsedRune; }
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
    [[nodiscard]] auto HasAchieved(uint32 achievementId) const -> bool;
    void ResetAchievements();
    void CheckAllAchievementCriteria();
    void ResetAchievementCriteria(AchievementCriteriaCondition condition, uint32 value, bool evenIfCriteriaComplete = false);
    void UpdateAchievementCriteria(AchievementCriteriaTypes type, uint32 miscValue1 = 0, uint32 miscValue2 = 0, Unit* unit = nullptr);
    void StartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry, uint32 timeLost = 0);
    void RemoveTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry);
    void CompletedAchievement(AchievementEntry const* entry);

    [[nodiscard]] auto HasTitle(uint32 bitIndex) const -> bool;
    auto HasTitle(CharTitlesEntry const* title) const -> bool { return HasTitle(title->bit_index); }
    void SetTitle(CharTitlesEntry const* title, bool lost = false);
    void SetCurrentTitle(CharTitlesEntry const* title, bool clear = false) { SetUInt32Value(PLAYER_CHOSEN_TITLE, clear ? 0 : title->bit_index); };

    //bool isActiveObject() const { return true; }
    auto CanSeeSpellClickOn(Creature const* creature) const -> bool;

    [[nodiscard]] auto GetChampioningFaction() const -> uint32 { return m_ChampioningFaction; }
    void SetChampioningFaction(uint32 faction) { m_ChampioningFaction = faction; }
    Spell* m_spellModTakingSpell;

    auto GetAverageItemLevel() -> float;
    auto GetAverageItemLevelForDF() -> float;
    bool isDebugAreaTriggers;

    void ClearWhisperWhiteList() { WhisperList.clear(); }
    void AddWhisperWhiteList(ObjectGuid guid) { WhisperList.push_back(guid); }
    auto IsInWhisperWhiteList(ObjectGuid guid) -> bool;
    void RemoveFromWhisperWhiteList(ObjectGuid guid) { WhisperList.remove(guid); }

    auto SetDisableGravity(bool disable, bool packetOnly /* = false */) -> bool override;
    auto SetCanFly(bool apply, bool packetOnly = false) -> bool override;
    auto SetWaterWalking(bool apply, bool packetOnly = false) -> bool override;
    auto SetFeatherFall(bool apply, bool packetOnly = false) -> bool override;
    auto SetHover(bool enable, bool packetOnly = false) -> bool override;

    [[nodiscard]] auto CanFly() const -> bool override { return m_movementInfo.HasMovementFlag(MOVEMENTFLAG_CAN_FLY); }
    [[nodiscard]] auto CanEnterWater() const -> bool override { return true; }

    // OURS
    // saving
    void AdditionalSavingAddMask(uint8 mask) { m_additionalSaveTimer = 2000; m_additionalSaveMask |= mask; }
    // arena spectator
    [[nodiscard]] auto IsSpectator() const -> bool { return m_ExtraFlags & PLAYER_EXTRA_SPECTATOR_ON; }
    void SetIsSpectator(bool on);
    [[nodiscard]] auto NeedSendSpectatorData() const -> bool;
    void SetPendingSpectatorForBG(uint32 bgInstanceId) { m_pendingSpectatorForBG = bgInstanceId; }
    [[nodiscard]] auto HasPendingSpectatorForBG(uint32 bgInstanceId) const -> bool { return m_pendingSpectatorForBG == bgInstanceId; }
    void SetPendingSpectatorInviteInstanceId(uint32 bgInstanceId) { m_pendingSpectatorInviteInstanceId = bgInstanceId; }
    [[nodiscard]] auto GetPendingSpectatorInviteInstanceId() const -> uint32 { return m_pendingSpectatorInviteInstanceId; }
    auto HasReceivedSpectatorResetFor(ObjectGuid guid) -> bool { return m_receivedSpectatorResetFor.find(guid) != m_receivedSpectatorResetFor.end(); }
    void ClearReceivedSpectatorResetFor() { m_receivedSpectatorResetFor.clear(); }
    void AddReceivedSpectatorResetFor(ObjectGuid guid) { m_receivedSpectatorResetFor.insert(guid); }
    void RemoveReceivedSpectatorResetFor(ObjectGuid guid) { m_receivedSpectatorResetFor.erase(guid); }
    uint32 m_pendingSpectatorForBG;
    uint32 m_pendingSpectatorInviteInstanceId;
    GuidSet m_receivedSpectatorResetFor;

    // Dancing Rune weapon
    void setRuneWeaponGUID(ObjectGuid guid) { m_drwGUID = guid; };
    auto getRuneWeaponGUID() -> ObjectGuid { return m_drwGUID; };
    ObjectGuid m_drwGUID;

    [[nodiscard]] auto CanSeeDKPet() const -> bool    { return m_ExtraFlags & PLAYER_EXTRA_SHOW_DK_PET; }
    void SetShowDKPet(bool on)  { if (on) m_ExtraFlags |= PLAYER_EXTRA_SHOW_DK_PET; else m_ExtraFlags &= ~PLAYER_EXTRA_SHOW_DK_PET; };
    void PrepareCharmAISpells();
    uint32 m_charmUpdateTimer;

    auto GetComboPointGain() -> int8 { return m_comboPointGain; }
    void SetComboPointGain(int8 combo) { m_comboPointGain = combo; }

    auto NeedToSaveGlyphs() -> bool { return m_NeedToSaveGlyphs; }
    void SetNeedToSaveGlyphs(bool val) { m_NeedToSaveGlyphs = val; }

    auto GetMountBlockId() -> uint32 { return m_MountBlockId; }
    void SetMountBlockId(uint32 mount) { m_MountBlockId = mount; }

    [[nodiscard]] auto GetRealParry() const -> float { return m_realParry; }
    [[nodiscard]] auto GetRealDodge() const -> float { return m_realDodge; }
    // mt maps
    [[nodiscard]] auto GetTalentMap() const -> const PlayerTalentMap& { return m_talents; }
    [[nodiscard]] auto GetNextSave() const -> uint32 { return m_nextSave; }
    [[nodiscard]] auto GetSpellModList(uint32 type) const -> SpellModList const& { return m_spellMods[type]; }

    void SetServerSideVisibility(ServerSideVisibilityType type, AccountTypes sec);
    void SetServerSideVisibilityDetect(ServerSideVisibilityType type, AccountTypes sec);

    static std::unordered_map<int, bgZoneRef> bgZoneIdToFillWorldStates; // zoneId -> FillInitialWorldStates

    // Cinematic camera data and remote sight functions
    [[nodiscard]] auto GetActiveCinematicCamera() const -> uint32 { return m_activeCinematicCameraId; }
    void SetActiveCinematicCamera(uint32 cinematicCameraId = 0) { m_activeCinematicCameraId = cinematicCameraId; }
    [[nodiscard]] auto IsOnCinematic() const -> bool { return (m_cinematicCamera != nullptr); }
    void BeginCinematic();
    void EndCinematic();
    void UpdateCinematicLocation(uint32 diff);

    auto GetMapAreaAndZoneString() -> std::string;
    auto GetCoordsMapAreaAndZoneString() -> std::string;

    void SetFarSightDistance(float radius);
    void ResetFarSightDistance();
    [[nodiscard]] auto GetFarSightDistance() const -> Optional<float>;

    auto GetSightRange(const WorldObject* target = nullptr) const -> float override;

    auto GetPlayerName() -> std::string;

    // Settings
    [[nodiscard]] auto GetPlayerSetting(std::string source, uint8 index) -> PlayerSetting;
    void UpdatePlayerSetting(std::string source, uint8 index, uint32 value);

 protected:
    // Gamemaster whisper whitelist
    WhisperListContainer WhisperList;

    // Combo Points
    int8 m_comboPointGain;
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

    BattlegroundQueueTypeId m_bgBattlegroundQueueID[PLAYER_MAX_BATTLEGROUND_QUEUES];
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
    static auto _LoadMailedItem(ObjectGuid const& playerGuid, Player* player, uint32 mailId, Mail* mail, Field* fields) -> Item*;
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
    auto _LoadHomeBind(PreparedQueryResult result) -> bool;
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
    void _SaveSkills(CharacterDatabaseTransaction trans);
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
    auto getMaxTimer(MirrorTimerType timer) -> int32;

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
    time_t m_speakTime;
    uint32 m_speakCount;
    Difficulty m_dungeonDifficulty;
    Difficulty m_raidDifficulty;
    Difficulty m_raidMapDifficulty;

    uint32 m_atLoginFlags;

    Item* m_items[PLAYER_SLOTS_COUNT];
    uint32 m_currentBuybackSlot;

    std::vector<Item*> m_itemUpdateQueue;
    bool m_itemUpdateQueueBlocked;

    uint32 m_ExtraFlags;

    ObjectGuid m_comboTarget;
    int8 m_comboPoints;

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
    int16 m_baseRatingValue[MAX_COMBAT_RATING];
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

    auto CanAlwaysSee(WorldObject const* obj) const -> bool override;

    auto IsAlwaysDetectableFor(WorldObject const* seer) const -> bool override;

    uint8 m_grantableLevels;

    bool m_needZoneUpdate;

    [[nodiscard]] auto GetAchievementMgr() const -> AchievementMgr* { return m_achievementMgr; }

private:
    // internal common parts for CanStore/StoreItem functions
    auto CanStoreItem_InSpecificSlot(uint8 bag, uint8 slot, ItemPosCountVec& dest, ItemTemplate const* pProto, uint32& count, bool swap, Item* pSrcItem) const -> InventoryResult;
    auto CanStoreItem_InBag(uint8 bag, ItemPosCountVec& dest, ItemTemplate const* pProto, uint32& count, bool merge, bool non_specialized, Item* pSrcItem, uint8 skip_bag, uint8 skip_slot) const -> InventoryResult;
    auto CanStoreItem_InInventorySlots(uint8 slot_begin, uint8 slot_end, ItemPosCountVec& dest, ItemTemplate const* pProto, uint32& count, bool merge, Item* pSrcItem, uint8 skip_bag, uint8 skip_slot) const -> InventoryResult;
    auto _StoreItem(uint16 pos, Item* pItem, uint32 count, bool clone, bool update) -> Item*;
    auto _LoadItem(CharacterDatabaseTransaction trans, uint32 zoneId, uint32 timeDiff, Field* fields) -> Item*;

    typedef GuidSet RefundableItemsSet;
    RefundableItemsSet m_refundableItems;
    void SendRefundInfo(Item* item);
    void RefundItem(Item* item);

    // know currencies are not removed at any point (0 displayed)
    void AddKnownCurrency(uint32 itemId);

    void AdjustQuestReqItemCount(Quest const* quest, QuestStatusData& questStatusData);

    [[nodiscard]] auto MustDelayTeleport() const -> bool { return m_bMustDelayTeleport; } // pussywizard: must delay teleports during player update to the very end
    void SetMustDelayTeleport(bool setting) { m_bMustDelayTeleport = setting; }
    [[nodiscard]] auto HasDelayedTeleport() const -> bool { return m_bHasDelayedTeleport; }
    void SetHasDelayedTeleport(bool setting) { m_bHasDelayedTeleport = setting; }

    MapReference m_mapRef;

    void UpdateCharmedAI();

    uint32 m_lastFallTime;
    float  m_lastFallZ;

    int32 m_MirrorTimer[MAX_TIMERS];
    uint8 m_MirrorTimerFlags;
    uint8 m_MirrorTimerFlagsLast;

    // Current teleport data
    WorldLocation teleportStore_dest;
    uint32 teleportStore_options;
    time_t mSemaphoreTeleport_Near;
    time_t mSemaphoreTeleport_Far;

    uint32 m_DelayedOperations;
    bool m_bMustDelayTeleport;
    bool m_bHasDelayedTeleport;

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

    // Remote location information
    uint32 m_cinematicDiff;
    uint32 m_lastCinematicCheck;
    uint32 m_activeCinematicCameraId;
    FlyByCameraCollection* m_cinematicCamera;
    Position m_remoteSightPosition;
    Creature* m_CinematicObject;

    WorldLocation _corpseLocation;

    Optional<float> _farSightDistance = { };

    PlayerSettingMap m_charSettingsMap;
};

void AddItemsSetItem(Player* player, Item* item);
void RemoveItemsSetItem(Player* player, ItemTemplate const* proto);

// "the bodies of template functions must be made available in a header file"
template <class T> auto Player::ApplySpellMod(uint32 spellId, SpellModOp op, T& basevalue, Spell* spell, bool temporaryPet) -> T
{
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
        return 0;
    float totalmul = 1.0f;
    int32 totalflat = 0;

    // Drop charges for triggering spells instead of triggered ones
    if (m_spellModTakingSpell)
        spell = m_spellModTakingSpell;

    for (auto mod : m_spellMods[op])
    {
        // Charges can be set only for mods with auras
        if (!mod->ownerAura)
            ASSERT(mod->charges == 0);

        if (!IsAffectedBySpellmod(spellInfo, mod, spell))
            continue;

        // xinef: temporary pets cannot use charged mods of owner, needed for mirror image QQ they should use their own auras
        if (temporaryPet && mod->charges != 0)
            continue;

        if (mod->type == SPELLMOD_FLAT)
        {
            // xinef: do not allow to consume more than one 100% crit increasing spell
            if (mod->op == SPELLMOD_CRITICAL_CHANCE && totalflat >= 100)
                continue;

            totalflat += mod->value;
        }
        else if (mod->type == SPELLMOD_PCT)
        {
            // skip percent mods for null basevalue (most important for spell mods with charges)
            if (basevalue == T(0) || totalmul == 0.0f)
                continue;

            // special case (skip > 10sec spell casts for instant cast setting)
            if (mod->op == SPELLMOD_CASTING_TIME && basevalue >= T(10000) && mod->value <= -100)
                continue;
            // xinef: special exception for surge of light, dont affect crit chance if previous mods were not applied
            else if (mod->op == SPELLMOD_CRITICAL_CHANCE && spell && !HasSpellMod(mod, spell))
                continue;
            // xinef: special case for backdraft gcd reduce with backlast time reduction, dont affect gcd if cast time was not applied
            else if (mod->op == SPELLMOD_GLOBAL_COOLDOWN && spell && !HasSpellMod(mod, spell))
                continue;

            // xinef: those two mods should be multiplicative (Glyph of Renew)
            if (mod->op == SPELLMOD_DAMAGE || mod->op == SPELLMOD_DOT)
                totalmul *= CalculatePct(1.0f, 100.0f + mod->value);
            else
                totalmul += CalculatePct(1.0f, mod->value);
        }

        DropModCharge(mod, spell);
    }
    float diff = 0.0f;
    if (op == SPELLMOD_CASTING_TIME || op == SPELLMOD_DURATION)
        diff = ((float)basevalue + totalflat) * (totalmul - 1.0f) + (float)totalflat;
    else
        diff = (float)basevalue * (totalmul - 1.0f) + (float)totalflat;
    basevalue = T((float)basevalue + diff);
    return T(diff);
}
#endif
