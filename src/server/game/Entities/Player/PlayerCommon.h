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

#ifndef __PLAYER_COMMON_H__
#define __PLAYER_COMMON_H__

#include "Common.h"
#include "Item.h"
#include "Unit.h"

struct CreatureTemplate;
struct Mail;
struct TrainerSpell;
struct VendorItem;
struct QuestStatusData;

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
class Battleground;

typedef std::deque<Mail*> PlayerMails;
typedef void(*bgZoneRef)(Battleground*, WorldPacket&);

constexpr auto PLAYER_MAX_SKILLS = 127;
constexpr auto PLAYER_MAX_DAILY_QUESTS = 25;
constexpr auto PLAYER_EXPLORED_ZONES_SIZE = 128;

// corpse reclaim times
constexpr auto DEATH_EXPIRE_STEP = 5 * MINUTE;
constexpr auto MAX_DEATH_COUNT = 3;

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

constexpr auto SPEC_MASK_ALL = 255;

// Spell modifier (used for modify other spells)
struct SpellModifier
{
    SpellModifier(Aura* _ownerAura = nullptr) :
        op(SPELLMOD_DAMAGE), type(SPELLMOD_FLAT), charges(0),  mask(),  ownerAura(_ownerAura) { }

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
    ActionButton() { }

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

constexpr auto MAX_ACTION_BUTTONS = 144; //checked in 3.2.0

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
    PlayerClassLevelInfo() { }
    uint16 basehealth{0};
    uint16 basemana{0};
};

struct PlayerClassInfo
{
    PlayerClassInfo() { }

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
    PlayerCreateInfoAction() { }
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
    PlayerInfo() { }

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
    PlayerCreateInfoActions action;
    PlayerCreateInfoSkills skills;

    PlayerLevelInfo* levelInfo{nullptr};                             //[level-1] 0..MaxPlayerLevel-1
};

struct PvPInfo
{
    PvPInfo() { }

    bool IsHostile{false};
    bool IsInHostileArea{false};               ///> Marks if player is in an area which forces PvP flag
    bool IsInNoPvPArea{false};                 ///> Marks if player is in a sanctuary or friendly capital city
    bool IsInFFAPvPArea{false};                ///> Marks if player is in an FFAPvP area (such as Gurubashi Arena)
    time_t EndTimer{0};                        ///> Time when player unflags himself for PvP (flag removed after 5 minutes)
    time_t FFAPvPEndTimer{0};                  ///> Time when player unflags himself for FFA PvP (flag removed after 30 sec)
};

struct DuelInfo
{
    DuelInfo() { }

    Player* initiator{nullptr};
    Player* opponent{nullptr};
    time_t startTimer{0};
    time_t startTime{0};
    time_t outOfBound{0};
    bool isMounted{false};
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

constexpr auto MAX_RUNES = 6;

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
    EnchantDuration()  {};
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

constexpr auto MAX_DRUNKEN = 4;

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

constexpr auto KNOWN_TITLES_SIZE = 3;
constexpr auto MAX_TITLE_INDEX = KNOWN_TITLES_SIZE * 64; // 3 uint64 fields

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

constexpr auto MAX_TIMERS = 3;
constexpr auto DISABLED_MIRROR_TIMER = -1;

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

constexpr auto MAX_QUEST_OFFSET = 5;

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
    SkillStatusData(uint8 _pos, SkillUpdateState _uState) :
        pos(_pos), uState(_uState) { }

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

constexpr auto INVENTORY_SLOT_BAG_0 = 255;

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
    EquipmentSet() { }

    uint64 Guid;
    std::string Name;
    std::string IconName;
    uint32 IgnoreMask{0};
    ObjectGuid Items[EQUIPMENT_SLOT_END];
    EquipmentSetUpdateState state{EQUIPMENT_SET_NEW};
};

constexpr auto MAX_EQUIPMENT_SET_INDEX = 10; // client limit

typedef std::map<uint32, EquipmentSet> EquipmentSets;

struct ItemPosCount
{
    ItemPosCount(uint16 _pos, uint32 _count) : pos(_pos), count(_count) { }
    [[nodiscard]] bool isContainedIn(std::vector<ItemPosCount> const& vec) const;
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

constexpr auto MAX_PLAYED_TIME_INDEX = 2;

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
constexpr auto MAX_PLAYER_SUMMON_DELAY = 2 * MINUTE;
constexpr auto MAX_MONEY_AMOUNT = 0x7FFFFFFF - 1;

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

// holder for Battleground data (pussywizard: not stored in db)
struct BGData
{
    BGData() { }

    uint32 bgInstanceID{0};
    BattlegroundTypeId bgTypeID{BATTLEGROUND_TYPE_NONE};
    TeamId bgTeamId{TEAM_NEUTRAL};
    uint32 bgQueueSlot{PLAYER_MAX_BATTLEGROUND_QUEUES};
    bool isInvited{false};
    bool bgIsRandom{false};

    GuidSet bgAfkReporter;
    uint8 bgAfkReportedCount{0};
    time_t bgAfkReportedTimer{0};
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
    [[nodiscard]] bool HasTaxiPath() const { return !taxiPath.empty(); }
};

#endif
