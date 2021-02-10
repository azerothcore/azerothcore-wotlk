/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef AZEROTHCORE_CREATURE_H
#define AZEROTHCORE_CREATURE_H

#include "Common.h"
#include "Unit.h"
#include "UpdateMask.h"
#include "ItemTemplate.h"
#include "LootMgr.h"
#include "DatabaseEnv.h"
#include "Cell.h"

#include <list>

class SpellInfo;

class CreatureAI;
class Quest;
class Player;
class WorldSession;
class CreatureGroup;

enum CreatureFlagsExtra : uint32
{
    // TODO: Implement missing flags from TC in places that custom flags from xinef&pussywizzard use flag values.
    CREATURE_FLAG_EXTRA_INSTANCE_BIND       = 0x00000001,   // creature kill bind instance with killer and killer's group
    CREATURE_FLAG_EXTRA_CIVILIAN            = 0x00000002,   // not aggro (ignore faction/reputation hostility)
    CREATURE_FLAG_EXTRA_NO_PARRY            = 0x00000004,   // creature can't parry
    CREATURE_FLAG_EXTRA_NO_PARRY_HASTEN     = 0x00000008,   // creature can't counter-attack at parry
    CREATURE_FLAG_EXTRA_NO_BLOCK            = 0x00000010,   // creature can't block
    CREATURE_FLAG_EXTRA_NO_CRUSH            = 0x00000020,   // creature can't do crush attacks
    CREATURE_FLAG_EXTRA_NO_XP_AT_KILL       = 0x00000040,   // creature kill not provide XP
    CREATURE_FLAG_EXTRA_TRIGGER             = 0x00000080,   // trigger creature
    CREATURE_FLAG_EXTRA_NO_TAUNT            = 0x00000100,   // creature is immune to taunt auras and effect attack me
    CREATURE_FLAG_EXTRA_UNUSED_10           = 0x00000200,   // TODO: Implement CREATURE_FLAG_EXTRA_NO_MOVE_FLAGS_UPDATE (creature won't update movement flags)
    CREATURE_FLAG_EXTRA_GHOST_VISIBILITY    = 0x00000400,   // creature will be only visible for dead players
    CREATURE_FLAG_EXTRA_UNUSED_12           = 0x00000800,   // TODO: Implement CREATURE_FLAG_EXTRA_USE_OFFHAND_ATTACK (creature will use offhand attacks)
    CREATURE_FLAG_EXTRA_NO_SELL_VENDOR      = 0x00001000,   // players can't sell items to this vendor
    CREATURE_FLAG_EXTRA_UNUSED_14           = 0x00002000,
    CREATURE_FLAG_EXTRA_WORLDEVENT          = 0x00004000,   // custom flag for world event creatures (left room for merging)
    CREATURE_FLAG_EXTRA_GUARD               = 0x00008000,   // Creature is guard
    CREATURE_FLAG_EXTRA_UNUSED_17           = 0x00010000,
    CREATURE_FLAG_EXTRA_NO_CRIT             = 0x00020000,   // creature can't do critical strikes
    CREATURE_FLAG_EXTRA_NO_SKILLGAIN        = 0x00040000,   // creature won't increase weapon skills
    CREATURE_FLAG_EXTRA_TAUNT_DIMINISH      = 0x00080000,   // Taunt is a subject to diminishing returns on this creautre
    CREATURE_FLAG_EXTRA_ALL_DIMINISH        = 0x00100000,   // Creature is subject to all diminishing returns as player are
    CREATURE_FLAG_EXTRA_UNUSED_22           = 0x00200000,
    CREATURE_FLAG_EXTRA_AVOID_AOE           = 0x00400000,   // pussywizard: ignored by aoe attacks (for icc blood prince council npc - Dark Nucleus)
    CREATURE_FLAG_EXTRA_NO_DODGE            = 0x00800000,   // xinef: target cannot dodge
    CREATURE_FLAG_EXTRA_UNUSED_25           = 0x01000000,
    CREATURE_FLAG_EXTRA_UNUSED_26           = 0x02000000,
    CREATURE_FLAG_EXTRA_UNUSED_27           = 0x04000000,
    CREATURE_FLAG_EXTRA_UNUSED_28           = 0x08000000,
    CREATURE_FLAG_EXTRA_DUNGEON_BOSS        = 0x10000000,   // creature is a dungeon boss (SET DYNAMICALLY, DO NOT ADD IN DB)
    CREATURE_FLAG_EXTRA_IGNORE_PATHFINDING  = 0x20000000,   // creature ignore pathfinding
    CREATURE_FLAG_EXTRA_IMMUNITY_KNOCKBACK  = 0x40000000,   // creature is immune to knockback effects
    CREATURE_FLAG_EXTRA_UNUSED_32           = 0x80000000,

    // Masks
    CREATURE_FLAG_EXTRA_UNUSED              = (CREATURE_FLAG_EXTRA_UNUSED_10 | CREATURE_FLAG_EXTRA_UNUSED_12 |
                                               CREATURE_FLAG_EXTRA_UNUSED_14 | CREATURE_FLAG_EXTRA_UNUSED_17 | CREATURE_FLAG_EXTRA_UNUSED_22 |
                                               CREATURE_FLAG_EXTRA_UNUSED_25 | CREATURE_FLAG_EXTRA_UNUSED_26 | CREATURE_FLAG_EXTRA_UNUSED_27 |
                                               CREATURE_FLAG_EXTRA_UNUSED_28 | CREATURE_FLAG_EXTRA_UNUSED_32),
    CREATURE_FLAG_EXTRA_DB_ALLOWED          = (0xFFFFFFFF & ~(CREATURE_FLAG_EXTRA_UNUSED | CREATURE_FLAG_EXTRA_DUNGEON_BOSS))
};

#define MAX_AGGRO_RESET_TIME 10 // in seconds

#define MAX_KILL_CREDIT 2
#define CREATURE_REGEN_INTERVAL 2 * IN_MILLISECONDS
#define PET_FOCUS_REGEN_INTERVAL 4 * IN_MILLISECONDS

#define MAX_CREATURE_QUEST_ITEMS 6

// from `creature_template` table
struct CreatureTemplate
{
    uint32  Entry;
    uint32  DifficultyEntry[MAX_DIFFICULTY - 1];
    uint32  KillCredit[MAX_KILL_CREDIT];
    uint32  Modelid1;
    uint32  Modelid2;
    uint32  Modelid3;
    uint32  Modelid4;
    std::string  Name;
    std::string  SubName;
    std::string  IconName;
    uint32  GossipMenuId;
    uint8   minlevel;
    uint8   maxlevel;
    uint32  expansion;
    uint32  faction;
    uint32  npcflag;
    float   speed_walk;
    float   speed_run;
    float   scale;
    uint32  rank;
    float   mindmg;
    float   maxdmg;
    uint32  dmgschool;
    uint32  attackpower;
    float   DamageModifier;
    uint32  BaseAttackTime;
    uint32  RangeAttackTime;
    uint32  unit_class;                                     // enum Classes. Note only 4 classes are known for creatures.
    uint32  unit_flags;                                     // enum UnitFlags mask values
    uint32  unit_flags2;                                    // enum UnitFlags2 mask values
    uint32  dynamicflags;
    uint32  family;                                         // enum CreatureFamily values (optional)
    uint32  trainer_type;
    uint32  trainer_spell;
    uint32  trainer_class;
    uint32  trainer_race;
    float   minrangedmg;
    float   maxrangedmg;
    uint32  rangedattackpower;
    uint32  type;                                           // enum CreatureType values
    uint32  type_flags;                                     // enum CreatureTypeFlags mask values
    uint32  lootid;
    uint32  pickpocketLootId;
    uint32  SkinLootId;
    int32   resistance[MAX_SPELL_SCHOOL];
    uint32  spells[CREATURE_MAX_SPELLS];
    uint32  PetSpellDataId;
    uint32  VehicleId;
    uint32  mingold;
    uint32  maxgold;
    std::string AIName;
    uint32  MovementType;
    uint32  InhabitType;
    float   HoverHeight;
    float   ModHealth;
    float   ModMana;
    float   ModArmor;
    bool    RacialLeader;
    uint32  movementId;
    bool    RegenHealth;
    uint32  MechanicImmuneMask;
    uint8   SpellSchoolImmuneMask;
    uint32  flags_extra;
    uint32  ScriptID;
    WorldPacket queryData; // pussywizard
    [[nodiscard]] uint32  GetRandomValidModelId() const;
    [[nodiscard]] uint32  GetFirstValidModelId() const;

    // helpers
    [[nodiscard]] SkillType GetRequiredLootSkill() const
    {
        if (type_flags & CREATURE_TYPE_FLAG_HERB_SKINNING_SKILL)
            return SKILL_HERBALISM;
        else if (type_flags & CREATURE_TYPE_FLAG_MINING_SKINNING_SKILL)
            return SKILL_MINING;
        else if (type_flags & CREATURE_TYPE_FLAG_ENGINEERING_SKINNING_SKILL)
            return SKILL_ENGINEERING;
        else
            return SKILL_SKINNING;                          // normal case
    }

    [[nodiscard]] bool IsExotic() const
    {
        return (type_flags & CREATURE_TYPE_FLAG_EXOTIC_PET) != 0;
    }

    [[nodiscard]] bool IsTameable(bool exotic) const
    {
        if (type != CREATURE_TYPE_BEAST || family == 0 || (type_flags & CREATURE_TYPE_FLAG_TAMEABLE_PET) == 0)
            return false;

        // if can tame exotic then can tame any tameable
        return exotic || (type_flags & CREATURE_TYPE_FLAG_EXOTIC_PET) == 0;
    }

    void InitializeQueryData();
};

typedef std::vector<uint32> CreatureQuestItemList;
typedef std::unordered_map<uint32, CreatureQuestItemList> CreatureQuestItemMap;

// Benchmarked: Faster than std::map (insert/find)
typedef std::unordered_map<uint32, CreatureTemplate> CreatureTemplateContainer;

// GCC have alternative #pragma pack(N) syntax and old gcc version not support pack(push, N), also any gcc version not support it at some platform
#if defined(__GNUC__)
#pragma pack(1)
#else
#pragma pack(push, 1)
#endif

// Defines base stats for creatures (used to calculate HP/mana/armor/attackpower/rangedattackpower/all damage).
struct CreatureBaseStats
{
    uint32 BaseHealth[MAX_EXPANSIONS];
    uint32 BaseMana;
    uint32 BaseArmor;
    uint32 AttackPower;
    uint32 RangedAttackPower;
    float BaseDamage[MAX_EXPANSIONS];

    // Helpers

    uint32 GenerateHealth(CreatureTemplate const* info) const
    {
        return uint32(ceil(BaseHealth[info->expansion] * info->ModHealth));
    }

    uint32 GenerateMana(CreatureTemplate const* info) const
    {
        // Mana can be 0.
        if (!BaseMana)
            return 0;

        return uint32(ceil(BaseMana * info->ModMana));
    }

    uint32 GenerateArmor(CreatureTemplate const* info) const
    {
        return uint32(ceil(BaseArmor * info->ModArmor));
    }

    float GenerateBaseDamage(CreatureTemplate const* info) const
    {
        return BaseDamage[info->expansion];
    }

    static CreatureBaseStats const* GetBaseStats(uint8 level, uint8 unitClass);
};

typedef std::unordered_map<uint16, CreatureBaseStats> CreatureBaseStatsContainer;

struct CreatureLocale
{
    StringVector Name;
    StringVector Title;
};

struct GossipMenuItemsLocale
{
    StringVector OptionText;
    StringVector BoxText;
};

struct PointOfInterestLocale
{
    StringVector Name;
};

#define MAX_EQUIPMENT_ITEMS 3

struct EquipmentInfo
{
    uint32  ItemEntry[MAX_EQUIPMENT_ITEMS];
};

// Benchmarked: Faster than std::map (insert/find)
typedef std::unordered_map<uint8, EquipmentInfo> EquipmentInfoContainerInternal;
typedef std::unordered_map<uint32, EquipmentInfoContainerInternal> EquipmentInfoContainer;

// from `creature` table
struct CreatureData
{
    CreatureData()  { }
    uint32 id{0};                                              // entry in creature_template
    uint16 mapid{0};
    uint32 phaseMask{0};
    uint32 displayid{0};
    int8 equipmentId{0};
    float posX{0.0f};
    float posY{0.0f};
    float posZ{0.0f};
    float orientation{0.0f};
    uint32 spawntimesecs{0};
    float wander_distance{0.0f};
    uint32 currentwaypoint{0};
    uint32 curhealth{0};
    uint32 curmana{0};
    uint8 movementType{0};
    uint8 spawnMask{0};
    uint32 npcflag{0};
    uint32 unit_flags{0};                                      // enum UnitFlags mask values
    uint32 dynamicflags{0};
    bool dbData{true};
    bool overwrittenZ{false};
};

struct CreatureModelInfo
{
    float bounding_radius;
    float combat_reach;
    uint8 gender;
    uint32 modelid_other_gender;
};

// Benchmarked: Faster than std::map (insert/find)
typedef std::unordered_map<uint16, CreatureModelInfo> CreatureModelContainer;

enum InhabitTypeValues
{
    INHABIT_GROUND = 1,
    INHABIT_WATER  = 2,
    INHABIT_AIR    = 4,
    INHABIT_ROOT   = 8,
    INHABIT_ANYWHERE = INHABIT_GROUND | INHABIT_WATER | INHABIT_AIR | INHABIT_ROOT
};

// Enums used by StringTextData::Type (CreatureEventAI)
enum ChatType
{
    CHAT_TYPE_SAY               = 0,
    CHAT_TYPE_YELL              = 1,
    CHAT_TYPE_TEXT_EMOTE        = 2,
    CHAT_TYPE_BOSS_EMOTE        = 3,
    CHAT_TYPE_WHISPER           = 4,
    CHAT_TYPE_BOSS_WHISPER      = 5,
    CHAT_TYPE_ZONE_YELL         = 6,
    CHAT_TYPE_END               = 255
};

// GCC have alternative #pragma pack() syntax and old gcc version not support pack(pop), also any gcc version not support it at some platform
#if defined(__GNUC__)
#pragma pack()
#else
#pragma pack(pop)
#endif

// `creature_addon` table
struct CreatureAddon
{
    uint32 path_id;
    uint32 mount;
    uint32 bytes1;
    uint32 bytes2;
    uint32 emote;
    bool isLarge;
    std::vector<uint32> auras;
};

typedef std::unordered_map<uint32, CreatureAddon> CreatureAddonContainer;

// Vendors
struct VendorItem
{
    VendorItem(uint32 _item, int32 _maxcount, uint32 _incrtime, uint32 _ExtendedCost)
        : item(_item), maxcount(_maxcount), incrtime(_incrtime), ExtendedCost(_ExtendedCost) {}

    uint32 item;
    uint32  maxcount;                                       // 0 for infinity item amount
    uint32 incrtime;                                        // time for restore items amount if maxcount != 0
    uint32 ExtendedCost;

    //helpers
    bool IsGoldRequired(ItemTemplate const* pProto) const { return pProto->Flags2 & ITEM_FLAGS_EXTRA_EXT_COST_REQUIRES_GOLD || !ExtendedCost; }
};
typedef std::vector<VendorItem*> VendorItemList;

struct VendorItemData
{
    VendorItemList m_items;

    [[nodiscard]] VendorItem* GetItem(uint32 slot) const
    {
        if (slot >= m_items.size())
            return nullptr;

        return m_items[slot];
    }
    [[nodiscard]] bool Empty() const { return m_items.empty(); }
    [[nodiscard]] uint8 GetItemCount() const { return m_items.size(); }
    void AddItem(uint32 item, int32 maxcount, uint32 ptime, uint32 ExtendedCost)
    {
        m_items.push_back(new VendorItem(item, maxcount, ptime, ExtendedCost));
    }
    bool RemoveItem(uint32 item_id);
    [[nodiscard]] VendorItem const* FindItemCostPair(uint32 item_id, uint32 extendedCost) const;
    void Clear()
    {
        for (VendorItemList::const_iterator itr = m_items.begin(); itr != m_items.end(); ++itr)
            delete (*itr);
        m_items.clear();
    }
};

struct VendorItemCount
{
    explicit VendorItemCount(uint32 _item, uint32 _count)
        : itemId(_item), count(_count), lastIncrementTime(time(nullptr)) {}

    uint32 itemId;
    uint32 count;
    time_t lastIncrementTime;
};

typedef std::list<VendorItemCount> VendorItemCounts;

struct TrainerSpell
{
    TrainerSpell()
    {
        for (unsigned int & i : learnedSpell)
            i = 0;
    }

    uint32 spell{0};
    uint32 spellCost{0};
    uint32 reqSkill{0};
    uint32 reqSkillValue{0};
    uint32 reqLevel{0};
    uint32 learnedSpell[3];

    // helpers
    [[nodiscard]] bool IsCastable() const { return learnedSpell[0] != spell; }
};

typedef std::unordered_map<uint32 /*spellid*/, TrainerSpell> TrainerSpellMap;

struct TrainerSpellData
{
    TrainerSpellData()  {}
    ~TrainerSpellData() { spellList.clear(); }

    TrainerSpellMap spellList;
    uint32 trainerType{0};                                     // trainer type based at trainer spells, can be different from creature_template value.
    // req. for correct show non-prof. trainers like weaponmaster, allowed values 0 and 2.
    [[nodiscard]] TrainerSpell const* Find(uint32 spell_id) const;
};

typedef std::map<uint32, time_t> CreatureSpellCooldowns;

// max different by z coordinate for creature aggro reaction
#define CREATURE_Z_ATTACK_RANGE 3

#define MAX_VENDOR_ITEMS 150                                // Limitation in 3.x.x item count in SMSG_LIST_INVENTORY

class Creature : public Unit, public GridObject<Creature>, public MovableMapObject
{
public:
    explicit Creature(bool isWorldObject = false);
    ~Creature() override;

    void AddToWorld() override;
    void RemoveFromWorld() override;

    void SetObjectScale(float scale) override;
    void SetDisplayId(uint32 modelId) override;

    void DisappearAndDie();

    bool Create(uint32 guidlow, Map* map, uint32 phaseMask, uint32 Entry, uint32 vehId, float x, float y, float z, float ang, const CreatureData* data = nullptr);
    bool LoadCreaturesAddon(bool reload = false);
    void SelectLevel(bool changelevel = true);
    void LoadEquipment(int8 id = 1, bool force = false);

    [[nodiscard]] uint32 GetDBTableGUIDLow() const { return m_DBTableGuid; }

    void Update(uint32 time) override;                         // overwrited Unit::Update
    void GetRespawnPosition(float& x, float& y, float& z, float* ori = nullptr, float* dist = nullptr) const;

    void SetCorpseDelay(uint32 delay) { m_corpseDelay = delay; }
    [[nodiscard]] uint32 GetCorpseDelay() const { return m_corpseDelay; }
    [[nodiscard]] bool IsRacialLeader() const { return GetCreatureTemplate()->RacialLeader; }
    [[nodiscard]] bool IsCivilian() const { return GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_CIVILIAN; }
    [[nodiscard]] bool IsTrigger() const { return GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_TRIGGER; }
    [[nodiscard]] bool IsGuard() const { return GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_GUARD; }
    [[nodiscard]] bool CanWalk() const { return GetCreatureTemplate()->InhabitType & INHABIT_GROUND; }
    [[nodiscard]] bool CanSwim() const override;
    [[nodiscard]] bool CanEnterWater() const override;
    [[nodiscard]] bool CanFly()  const override;
    [[nodiscard]] bool CanHover() const { return m_originalAnimTier & UNIT_BYTE1_FLAG_HOVER || IsHovering(); }

    void SetReactState(ReactStates st) { m_reactState = st; }
    [[nodiscard]] ReactStates GetReactState() const { return m_reactState; }
    [[nodiscard]] bool HasReactState(ReactStates state) const { return (m_reactState == state); }
    void InitializeReactState();

    ///// TODO RENAME THIS!!!!!
    bool isCanInteractWithBattleMaster(Player* player, bool msg) const;
    bool isCanTrainingAndResetTalentsOf(Player* player) const;
    bool CanCreatureAttack(Unit const* victim, bool skipDistCheck = false) const;
    void LoadSpellTemplateImmunity();
    bool IsImmunedToSpell(SpellInfo const* spellInfo) override;

    [[nodiscard]] bool HasMechanicTemplateImmunity(uint32 mask) const;
    // redefine Unit::IsImmunedToSpell
    bool IsImmunedToSpellEffect(SpellInfo const* spellInfo, uint32 index) const override;
    // redefine Unit::IsImmunedToSpellEffect
    [[nodiscard]] bool isElite() const
    {
        if (IsPet())
            return false;

        uint32 rank = GetCreatureTemplate()->rank;
        return rank != CREATURE_ELITE_NORMAL && rank != CREATURE_ELITE_RARE;
    }

    [[nodiscard]] bool isWorldBoss() const
    {
        if (IsPet())
            return false;

        return GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_BOSS_MOB;
    }

    [[nodiscard]] bool IsDungeonBoss() const;
    [[nodiscard]] bool IsImmuneToKnockback() const;
    [[nodiscard]] bool IsAvoidingAOE() const { return GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_AVOID_AOE; }

    uint8 getLevelForTarget(WorldObject const* target) const override; // overwrite Unit::getLevelForTarget for boss level support

    [[nodiscard]] bool IsInEvadeMode() const { return HasUnitState(UNIT_STATE_EVADE); }
    [[nodiscard]] bool IsEvadingAttacks() const { return IsInEvadeMode() || CanNotReachTarget(); }

    bool AIM_Initialize(CreatureAI* ai = nullptr);
    void Motion_Initialize();

    [[nodiscard]] CreatureAI* AI() const { return (CreatureAI*)i_AI; }

    bool SetWalk(bool enable) override;
    bool SetDisableGravity(bool disable, bool packetOnly = false) override;
    bool SetSwim(bool enable) override;
    bool SetCanFly(bool enable, bool packetOnly = false) override;
    bool SetWaterWalking(bool enable, bool packetOnly = false) override;
    bool SetFeatherFall(bool enable, bool packetOnly = false) override;
    bool SetHover(bool enable, bool packetOnly = false) override;
    bool HasSpellFocus(Spell const* focusSpell = nullptr) const;

    struct
    {
        ::Spell const* Spell = nullptr;
        uint32 Delay = 0;         // ms until the creature's target should snap back (0 = no snapback scheduled)
        uint64 Target;            // the creature's "real" target while casting
        float Orientation = 0.0f; // the creature's "real" orientation while casting
    } _spellFocusInfo;

    [[nodiscard]] uint32 GetShieldBlockValue() const override
    {
        return (getLevel() / 2 + uint32(GetStat(STAT_STRENGTH) / 20));
    }

    [[nodiscard]] SpellSchoolMask GetMeleeDamageSchoolMask() const override { return m_meleeDamageSchoolMask; }
    void SetMeleeDamageSchool(SpellSchools school) { m_meleeDamageSchoolMask = SpellSchoolMask(1 << school); }

    void _AddCreatureSpellCooldown(uint32 spell_id, uint32 end_time);
    void AddSpellCooldown(uint32 spell_id, uint32 /*itemid*/, uint32 end_time, bool needSendToClient = false, bool forceSendToSpectator = false) override;
    [[nodiscard]] bool HasSpellCooldown(uint32 spell_id) const override;
    [[nodiscard]] uint32 GetSpellCooldown(uint32 spell_id) const;
    void ProhibitSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs) override;
    [[nodiscard]] bool IsSpellProhibited(SpellSchoolMask idSchoolMask) const;

    [[nodiscard]] bool HasSpell(uint32 spellID) const override;

    bool UpdateEntry(uint32 entry, const CreatureData* data = nullptr, bool changelevel = true );
    bool UpdateStats(Stats stat) override;
    bool UpdateAllStats() override;
    void UpdateResistances(uint32 school) override;
    void UpdateArmor() override;
    void UpdateMaxHealth() override;
    void UpdateMaxPower(Powers power) override;
    void UpdateAttackPowerAndDamage(bool ranged = false) override;
    void CalculateMinMaxDamage(WeaponAttackType attType, bool normalized, bool addTotalPct, float& minDamage, float& maxDamage) override;

    void SetCanDualWield(bool value) override;
    [[nodiscard]] int8 GetOriginalEquipmentId() const { return m_originalEquipmentId; }
    uint8 GetCurrentEquipmentId() { return m_equipmentId; }
    void SetCurrentEquipmentId(uint8 id) { m_equipmentId = id; }

    float GetSpellDamageMod(int32 Rank);

    [[nodiscard]] VendorItemData const* GetVendorItems() const;
    uint32 GetVendorItemCurrentCount(VendorItem const* vItem);
    uint32 UpdateVendorItemCurrentCount(VendorItem const* vItem, uint32 used_count);

    [[nodiscard]] TrainerSpellData const* GetTrainerSpells() const;

    [[nodiscard]] CreatureTemplate const* GetCreatureTemplate() const { return m_creatureInfo; }
    [[nodiscard]] CreatureData const* GetCreatureData() const { return m_creatureData; }
    [[nodiscard]] CreatureAddon const* GetCreatureAddon() const;

    [[nodiscard]] std::string GetAIName() const;
    [[nodiscard]] std::string GetScriptName() const;
    [[nodiscard]] uint32 GetScriptId() const;

    // override WorldObject function for proper name localization
    [[nodiscard]] std::string const& GetNameForLocaleIdx(LocaleConstant locale_idx) const override;

    void setDeathState(DeathState s, bool despawn = false) override;                   // override virtual Unit::setDeathState

    bool LoadFromDB(uint32 guid, Map* map) { return LoadCreatureFromDB(guid, map, false, true); }
    bool LoadCreatureFromDB(uint32 guid, Map* map, bool addToMap = true, bool gridLoad = false);
    void SaveToDB();
    // overriden in Pet
    virtual void SaveToDB(uint32 mapid, uint8 spawnMask, uint32 phaseMask);
    virtual void DeleteFromDB();                        // overriden in Pet

    Loot loot;
    [[nodiscard]] uint64 GetLootRecipientGUID() const { return m_lootRecipient; }
    [[nodiscard]] Player* GetLootRecipient() const;
    [[nodiscard]] Group* GetLootRecipientGroup() const;
    [[nodiscard]] bool hasLootRecipient() const { return m_lootRecipient || m_lootRecipientGroup; }
    bool isTappedBy(Player const* player) const;                          // return true if the creature is tapped by the player or a member of his party.
    [[nodiscard]] bool CanGeneratePickPocketLoot() const { return lootPickPocketRestoreTime == 0 || lootPickPocketRestoreTime < time(nullptr); }
    void SetPickPocketLootTime() { lootPickPocketRestoreTime = time(nullptr) + MINUTE + GetCorpseDelay() + GetRespawnTime(); }
    void ResetPickPocketLootTime() { lootPickPocketRestoreTime = 0; }

    void SetLootRecipient (Unit* unit, bool withGroup = true);
    void AllLootRemovedFromCorpse();

    [[nodiscard]] uint16 GetLootMode() const { return m_LootMode; }
    [[nodiscard]] bool HasLootMode(uint16 lootMode) const { return m_LootMode & lootMode; }
    void SetLootMode(uint16 lootMode) { m_LootMode = lootMode; }
    void AddLootMode(uint16 lootMode) { m_LootMode |= lootMode; }
    void RemoveLootMode(uint16 lootMode) { m_LootMode &= ~lootMode; }
    void ResetLootMode() { m_LootMode = LOOT_MODE_DEFAULT; }

    SpellInfo const* reachWithSpellAttack(Unit* victim);
    SpellInfo const* reachWithSpellCure(Unit* victim);

    uint32 m_spells[CREATURE_MAX_SPELLS];
    CreatureSpellCooldowns m_CreatureSpellCooldowns;
    uint32 m_ProhibitSchoolTime[7];

    bool CanStartAttack(Unit const* u) const;
    float GetAggroRange(Unit const* target) const;
    float GetAttackDistance(Unit const* player) const;

    void SendAIReaction(AiReaction reactionType);

    [[nodiscard]] Unit* SelectNearestTarget(float dist = 0, bool playerOnly = false) const;
    [[nodiscard]] Unit* SelectNearestTargetInAttackDistance(float dist) const;

    void DoFleeToGetAssistance();
    void CallForHelp(float fRadius);
    void CallAssistance();
    void SetNoCallAssistance(bool val) { m_AlreadyCallAssistance = val; }
    void SetNoSearchAssistance(bool val) { m_AlreadySearchedAssistance = val; }
    bool HasSearchedAssistance() { return m_AlreadySearchedAssistance; }
    bool CanAssistTo(const Unit* u, const Unit* enemy, bool checkfaction = true) const;
    bool _IsTargetAcceptable(const Unit* target) const;
    bool _CanDetectFeignDeathOf(const Unit* target) const; // pussywizard

    // pussywizard: updated at faction change, disable move in line of sight if actual faction is not hostile to anyone
    void UpdateMoveInLineOfSightState();
    bool IsMoveInLineOfSightDisabled() { return m_moveInLineOfSightDisabled; }
    bool IsMoveInLineOfSightStrictlyDisabled() { return m_moveInLineOfSightStrictlyDisabled; }

    [[nodiscard]] MovementGeneratorType GetDefaultMovementType() const { return m_defaultMovementType; }
    void SetDefaultMovementType(MovementGeneratorType mgt) { m_defaultMovementType = mgt; }

    void RemoveCorpse(bool setSpawnTime = true, bool skipVisibility = false);

    void DespawnOrUnsummon(uint32 msTimeToDespawn = 0);

    [[nodiscard]] time_t const& GetRespawnTime() const { return m_respawnTime; }
    [[nodiscard]] time_t GetRespawnTimeEx() const;
    void SetRespawnTime(uint32 respawn) { m_respawnTime = respawn ? time(nullptr) + respawn : 0; }
    void Respawn(bool force = false);
    void SaveRespawnTime() override;

    [[nodiscard]] uint32 GetRespawnDelay() const { return m_respawnDelay; }
    void SetRespawnDelay(uint32 delay) { m_respawnDelay = delay; }

    [[nodiscard]] float GetWanderDistance() const { return m_wanderDistance; }
    void SetWanderDistance(float dist) { m_wanderDistance = dist; }

    uint32 m_groupLootTimer;                            // (msecs)timer used for group loot
    uint32 lootingGroupLowGUID;                         // used to find group which is looting corpse

    void SendZoneUnderAttackMessage(Player* attacker);

    void SetInCombatWithZone();

    [[nodiscard]] bool hasQuest(uint32 quest_id) const override;
    [[nodiscard]] bool hasInvolvedQuest(uint32 quest_id)  const override;

    bool isRegeneratingHealth() { return m_regenHealth; }
    void SetRegeneratingHealth(bool c) { m_regenHealth = c; }
    [[nodiscard]] virtual uint8 GetPetAutoSpellSize() const { return MAX_SPELL_CHARM; }
    [[nodiscard]] virtual uint32 GetPetAutoSpellOnPos(uint8 pos) const
    {
        if (pos >= MAX_SPELL_CHARM || m_charmInfo->GetCharmSpell(pos)->GetType() != ACT_ENABLED)
            return 0;
        else
            return m_charmInfo->GetCharmSpell(pos)->GetAction();
    }

    void SetCannotReachTarget(bool cannotReach);
    [[nodiscard]] bool CanNotReachTarget() const { return m_cannotReachTarget; }
    [[nodiscard]] bool IsNotReachable() const { return (m_cannotReachTimer >= (sWorld->getIntConfig(CONFIG_NPC_EVADE_IF_NOT_REACHABLE) * IN_MILLISECONDS)) && m_cannotReachTarget; }
    [[nodiscard]] bool IsNotReachableAndNeedRegen() const { return (m_cannotReachTimer >= (sWorld->getIntConfig(CONFIG_NPC_REGEN_TIME_IF_NOT_REACHABLE_IN_RAID) * IN_MILLISECONDS)) && m_cannotReachTarget; }

    void SetPosition(float x, float y, float z, float o);
    void SetPosition(const Position& pos) { SetPosition(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation()); }

    void SetHomePosition(float x, float y, float z, float o) { m_homePosition.Relocate(x, y, z, o); }
    void SetHomePosition(const Position& pos) { m_homePosition.Relocate(pos); }
    void GetHomePosition(float& x, float& y, float& z, float& ori) const { m_homePosition.GetPosition(x, y, z, ori); }
    [[nodiscard]] Position const& GetHomePosition() const { return m_homePosition; }

    void SetTransportHomePosition(float x, float y, float z, float o) { m_transportHomePosition.Relocate(x, y, z, o); }
    void SetTransportHomePosition(const Position& pos) { m_transportHomePosition.Relocate(pos); }
    void GetTransportHomePosition(float& x, float& y, float& z, float& ori) const { m_transportHomePosition.GetPosition(x, y, z, ori); }
    [[nodiscard]] Position const& GetTransportHomePosition() const { return m_transportHomePosition; }

    [[nodiscard]] uint32 GetWaypointPath() const { return m_path_id; }
    void LoadPath(uint32 pathid) { m_path_id = pathid; }

    [[nodiscard]] uint32 GetCurrentWaypointID() const { return m_waypointID; }
    void UpdateWaypointID(uint32 wpID) { m_waypointID = wpID; }

    void SearchFormation();
    [[nodiscard]] CreatureGroup* GetFormation() const { return m_formation; }
    void SetFormation(CreatureGroup* formation) { m_formation = formation; }

    Unit* SelectVictim();

    void SetDisableReputationGain(bool disable) { DisableReputationGain = disable; }
    [[nodiscard]] bool IsReputationGainDisabled() const { return DisableReputationGain; }
    [[nodiscard]] bool IsDamageEnoughForLootingAndReward() const { return m_PlayerDamageReq == 0; }
    void LowerPlayerDamageReq(uint32 unDamage)
    {
        if (m_PlayerDamageReq)
            m_PlayerDamageReq > unDamage ? m_PlayerDamageReq -= unDamage : m_PlayerDamageReq = 0;
    }
    void ResetPlayerDamageReq() { m_PlayerDamageReq = GetHealth() / 2; }
    uint32 m_PlayerDamageReq;

    [[nodiscard]] uint32 GetOriginalEntry() const { return m_originalEntry; }
    void SetOriginalEntry(uint32 entry) { m_originalEntry = entry; }

    static float _GetDamageMod(int32 Rank);

    float m_SightDistance, m_CombatDistance;

    bool m_isTempWorldObject; //true when possessed

    // Handling caster facing during spellcast
    void SetTarget(uint64 guid) override;
    void FocusTarget(Spell const* focusSpell, WorldObject const* target);
    void ReleaseFocus(Spell const* focusSpell);
    bool IsMovementPreventedByCasting() const;

    // Part of Evade mechanics
    [[nodiscard]] time_t GetLastDamagedTime() const { return _lastDamagedTime; }
    void SetLastDamagedTime(time_t val) { _lastDamagedTime = val; }

    bool IsFreeToMove();
    static constexpr uint32 MOVE_CIRCLE_CHECK_INTERVAL = 3000;
    static constexpr uint32 MOVE_BACKWARDS_CHECK_INTERVAL = 2000;
    uint32 m_moveCircleMovementTime = MOVE_CIRCLE_CHECK_INTERVAL;
    uint32 m_moveBackwardsMovementTime = MOVE_BACKWARDS_CHECK_INTERVAL;

    bool HasSwimmingFlagOutOfCombat() const
    {
        return !_isMissingSwimmingFlagOutOfCombat;
    }
    void RefreshSwimmingFlag(bool recheck = false);

protected:
    bool CreateFromProto(uint32 guidlow, uint32 Entry, uint32 vehId, const CreatureData* data = nullptr);
    bool InitEntry(uint32 entry, const CreatureData* data = nullptr);

    // vendor items
    VendorItemCounts m_vendorItemCounts;

    static float _GetHealthMod(int32 Rank);

    uint64 m_lootRecipient;
    uint32 m_lootRecipientGroup;

    /// Timers
    time_t m_corpseRemoveTime;                          // (msecs)timer for death or corpse disappearance
    time_t m_respawnTime;                               // (secs) time of next respawn
    uint32 m_respawnDelay;                              // (secs) delay between corpse disappearance and respawning
    uint32 m_corpseDelay;                               // (secs) delay between death and corpse disappearance
    float m_wanderDistance;
    uint16 m_transportCheckTimer;
    uint32 lootPickPocketRestoreTime;

    ReactStates m_reactState;                           // for AI, not charmInfo
    void RegenerateHealth();
    void Regenerate(Powers power);
    MovementGeneratorType m_defaultMovementType;
    uint32 m_DBTableGuid;                               ///< For new or temporary creatures is 0 for saved it is lowguid
    uint8 m_equipmentId;
    int8 m_originalEquipmentId; // can be -1

    uint8 m_originalAnimTier;

    bool m_AlreadyCallAssistance;
    bool m_AlreadySearchedAssistance;
    bool m_regenHealth;
    bool m_AI_locked;

    SpellSchoolMask m_meleeDamageSchoolMask;
    uint32 m_originalEntry;

    bool m_moveInLineOfSightDisabled;
    bool m_moveInLineOfSightStrictlyDisabled;

    Position m_homePosition;
    Position m_transportHomePosition;

    bool DisableReputationGain;

    CreatureTemplate const* m_creatureInfo;                 // in difficulty mode > 0 can different from sObjectMgr->GetCreatureTemplate(GetEntry())
    CreatureData const* m_creatureData;

    uint16 m_LootMode;                                  // bitmask, default LOOT_MODE_DEFAULT, determines what loot will be lootable

    [[nodiscard]] bool IsInvisibleDueToDespawn() const override;
    bool CanAlwaysSee(WorldObject const* obj) const override;

private:
    void ForcedDespawn(uint32 timeMSToDespawn = 0);

    //WaypointMovementGenerator vars
    uint32 m_waypointID;
    uint32 m_path_id;

    //Formation var
    CreatureGroup* m_formation;
    bool TriggerJustRespawned;

    time_t _lastDamagedTime; // Part of Evade mechanics

    bool m_cannotReachTarget;
    uint32 m_cannotReachTimer;

    Spell const* _focusSpell;   ///> Locks the target during spell cast for proper facing

    bool _isMissingSwimmingFlagOutOfCombat;
};

class AssistDelayEvent : public BasicEvent
{
public:
    AssistDelayEvent(uint64 victim, Unit& owner) : BasicEvent(), m_victim(victim), m_owner(owner) { }

    bool Execute(uint64 e_time, uint32 p_time) override;
    void AddAssistant(uint64 guid) { m_assistants.push_back(guid); }
private:
    AssistDelayEvent();

    uint64            m_victim;
    std::list<uint64> m_assistants;
    Unit&             m_owner;
};

class ForcedDespawnDelayEvent : public BasicEvent
{
public:
    ForcedDespawnDelayEvent(Creature& owner) : BasicEvent(), m_owner(owner) { }
    bool Execute(uint64 e_time, uint32 p_time) override;

private:
    Creature& m_owner;
};

#endif
