#ifndef _BOTDATAMGR_H
#define _BOTDATAMGR_H

#include "botcommon.h"
#include "DatabaseEnvFwd.h"
#include "DBCEnums.h"

#include <functional>
#include <map>
#include <set>
#include <shared_mutex>

class BattlegroundQueue;
class Creature;
class Group;
class Item;
class Player;
class WanderNode;
class WorldLocation;

struct EquipmentInfo;
struct CreatureTemplate;
struct FactionEntry;
struct GroupQueueInfo;
struct ItemTemplate;
struct Position;
struct PvPDifficultyEntry;

enum LocaleConstant;

constexpr float MIN_WANDER_NODE_DISTANCE = 50.0f; // VISIBILITY_DISTANCE_NORMAL * 0.5f;
constexpr float MAX_WANDER_NODE_DISTANCE = 800.0f; //SIZE_OF_GRIDS * 1.5f;

struct NpcBotMgrData
{
    friend class BotDataMgr;
public:
    uint8 dist_follow;
    uint8 dist_attack;
    uint8 attack_range_mode;
    uint8 attack_angle_mode;
    uint32 engage_delay_dps;
    uint32 engage_delay_heal;
    uint32 flags;

    inline void SetFlag(uint32 flags_) { flags |= flags_; }
    inline void RemoveFlag(uint32 flags_) { flags &= ~flags_; }
    inline bool HasFlag(uint32 flags_) const { return !!(flags & flags_); }

private:
    explicit NpcBotMgrData(uint8 idist_follow, uint8 idist_attack, uint8 iattack_range_mode, uint8 iattack_angle_mode, uint32 iengage_delay_dps, uint32 iengage_delay_heal, uint32 iflags) :
        dist_follow(idist_follow), dist_attack(idist_attack), attack_range_mode(iattack_range_mode), attack_angle_mode(iattack_angle_mode),
        engage_delay_dps(iengage_delay_dps), engage_delay_heal(iengage_delay_heal), flags(iflags) { }
};

enum NpcBotDataUpdateType
{
    NPCBOT_UPDATE_OWNER                 = 1,
    NPCBOT_UPDATE_ROLES,
    NPCBOT_UPDATE_SPEC,
    NPCBOT_UPDATE_DISABLED_SPELLS,
    NPCBOT_UPDATE_MISCVALUES,
    NPCBOT_UPDATE_FACTION,
    NPCBOT_UPDATE_EQUIPS,
    NPCBOT_UPDATE_ERASE,
    NPCBOT_UPDATE_TRANSMOG_ERASE,
    NPCBOT_UPDATE_END
};

struct NpcBotData
{
    typedef std::set<uint32> DisabledSpellsContainer;
    typedef std::map<uint32, uint32> MiscValuesContainer;

    friend class BotDataMgr;
    friend struct WanderingBotsGenerator;
public:
    uint32 owner;
    uint64 hire_time;
    uint32 roles;
    uint32 faction;
    uint8 spec;
    uint32 equips[BOT_INVENTORY_SIZE];
    DisabledSpellsContainer disabled_spells;
    MiscValuesContainer miscvalues;

private:
    explicit NpcBotData(uint32 iroles, uint32 ifaction, uint8 ispec = 1) : owner(0), hire_time(0), roles(iroles), faction(ifaction), spec(ispec)
    {
        for (uint8 i = 0; i != BOT_INVENTORY_SIZE; ++i)
            equips[i] = 0;
    }
    NpcBotData(NpcBotData const&);
};

struct NpcBotAppearanceData
{
    friend class BotDataMgr;
    friend struct WanderingBotsGenerator;
public:
    uint8 gender;
    uint8 skin;
    uint8 face;
    uint8 hair;
    uint8 haircolor;
    uint8 features;
private:
    explicit NpcBotAppearanceData() {}
    NpcBotAppearanceData(NpcBotAppearanceData const&);
};

struct NpcBotExtras
{
    friend class BotDataMgr;
    friend struct WanderingBotsGenerator;
public:
    uint8 race;
    uint8 bclass;
private:
    explicit NpcBotExtras() {}
    NpcBotExtras(NpcBotExtras const&);
};

struct NpcBotTransmogData
{
    friend class BotDataMgr;
public:
    std::pair<uint32 /*item_id*/, int32 /*fake_id*/> transmogs[BOT_TRANSMOG_INVENTORY_SIZE];
private:
    explicit NpcBotTransmogData()
    {
        for (uint8 i = 0; i != BOT_TRANSMOG_INVENTORY_SIZE; ++i)
            transmogs[i] = { 0, -1 };
    }
    NpcBotTransmogData(NpcBotTransmogData const&);
};

struct NpcBotStats
{
public:
    NpcBotStats() {}

    uint32 entry;
    uint32 maxhealth;
    uint32 maxpower;
    uint32 strength;
    uint32 agility;
    uint32 stamina;
    uint32 intellect;
    uint32 spirit;
    uint32 armor;
    uint32 defense;
    uint32 resHoly;
    uint32 resFire;
    uint32 resNature;
    uint32 resFrost;
    uint32 resShadow;
    uint32 resArcane;
    float blockPct;
    float dodgePct;
    float parryPct;
    float critPct;
    uint32 attackPower;
    uint32 spellPower;
    uint32 spellPen;
    float hastePct;
    float hitBonusPct;
    uint32 expertise;
    float armorPenPct;
};

struct NpcBotItemSet
{
public:
    NpcBotItemSet() : name{}, items{} {}

    constexpr operator bool() const noexcept { return !empty(); }
    constexpr bool empty() const noexcept { return items_count() == 0; }

    constexpr uint8 items_count() const noexcept {
        uint8 count = 0;
        for (uint8 i = 0; i < BOT_INVENTORY_SIZE; ++i)
            if (!!items[i])
                ++count;
        return count;
    }

    void clear() { items = {}; name.clear(); }

    std::string name;
    std::array<uint32, BOT_INVENTORY_SIZE> items;
};

typedef std::set<Creature const*> NpcBotRegistry;

struct BotBankItemCompare{ bool operator()(Item const* item1, Item const* item2) const; };
typedef std::multiset<Item*, BotBankItemCompare> BotBankItemContainer;

constexpr uint8 ITEM_SORTING_LEVEL_STEP = 5;
constexpr uint8 LEVEL_STEPS = DEFAULT_MAX_LEVEL / ITEM_SORTING_LEVEL_STEP + 1;
typedef std::vector<uint32> ItemIdVector;
typedef std::array<NpcBotItemSet, MAX_BOT_EQUIPMENT_SETS> BotItemSetsArray;
typedef std::array<ItemIdVector, LEVEL_STEPS> ItemLeveledArr;
typedef std::array<ItemLeveledArr, BOT_INVENTORY_SIZE> ItemPerSlot;
typedef std::array<ItemPerSlot, BOT_CLASS_END> ItemPerBotClassMap;

class BotDataMgr
{
    public:
        static void Update(uint32 diff);

        static void LoadNpcBots(bool spawn = true);
        static void LoadNpcBotGroupData();
        static void LoadNpcBotGearStorage();
        static void LoadNpcBotGearSets();

        static void LoadNpcBotMgrData();

        static void DeleteOldLogs();

        static void AddNpcBotData(uint32 entry, uint32 roles, uint8 spec, uint32 faction);
        static NpcBotData const* SelectNpcBotData(uint32 entry);
        static void UpdateNpcBotData(uint32 entry, NpcBotDataUpdateType updateType, void* data = nullptr);
        static void UpdateNpcBotDataAll(uint32 playerGuid, NpcBotDataUpdateType updateType, void* data = nullptr);
        static void SaveNpcBotStats(NpcBotStats const* stats);

        static NpcBotAppearanceData const* SelectNpcBotAppearance(uint32 entry);
        static NpcBotExtras const* SelectNpcBotExtras(uint32 entry);

        static NpcBotTransmogData const* SelectNpcBotTransmogs(uint32 entry);
        static void UpdateNpcBotTransmogData(uint32 entry, uint8 slot, uint32 item_id, int32 fake_id, bool update_db = true);
        static void ResetNpcBotTransmogData(uint32 entry, bool update_db = true);

        static bool AllBotsLoaded();

        static void RegisterBot(Creature const* bot);
        static void UnregisterBot(Creature const* bot);
        static Creature const* FindBot(uint32 entry);
        static Creature const* FindBot(std::string_view name, LocaleConstant loc, std::vector<uint32> const* not_ids = nullptr);
        static NpcBotRegistry const& GetExistingNPCBots();
        static void GetNPCBotGuidsByOwner(std::vector<ObjectGuid> &guids_vec, ObjectGuid owner_guid);
        static ObjectGuid GetNPCBotGuid(uint32 entry);
        static std::vector<uint32> GetExistingNPCBotIds();
        static uint8 GetOwnedBotsCount(ObjectGuid owner_guid, uint32 class_mask = 0);
        static uint8 GetAccountBotsCount(uint32 account_id);

        static void DespawnWandererBot(uint32 entry);
        static void LoadWanderMap(bool reload = false, bool force_all_maps = false);
        static void GenerateWanderingBots();
        static bool GenerateBattlegroundBots(Player const* groupLeader, Group const* group, BattlegroundQueue* queue, PvPDifficultyEntry const* bracketEntry, GroupQueueInfo const* gqinfo);
        static void CreateWanderingBotsSortedGear();
        static ItemPerBotClassMap const& GetWanderingBotsSortedGearMap();
        static Item* GenerateWanderingBotItem(uint8 slot, uint8 botclass, uint8 level, std::function<bool(ItemTemplate const*)>&& check);
        static bool GenerateWanderingBotItemEnchants(Item* item, uint8 slot, uint8 spec);
        static CreatureTemplate const* GetBotExtraCreatureTemplate(uint32 entry);
        static EquipmentInfo const* GetBotEquipmentInfo(uint32 entry);

        static uint8 GetLevelBonusForBotRank(uint32 rank);
        static uint8 GetMinLevelForMapId(uint32 mapId);
        static uint8 GetMaxLevelForMapId(uint32 mapId);
        static uint8 GetMinLevelForBotClass(uint8 m_class);
        static int32 GetBotBaseReputation(Creature const* bot, FactionEntry const* factionEntry);
        static uint32 GetDefaultFactionForBotRaceClass(uint8 bot_class, uint8 bot_race);
        static TeamId GetTeamIdForFaction(uint32 factionTemplateId);
        static uint32 GetTeamForFaction(uint32 factionTemplateId);

        static bool CanDepositBotBankItemsCount(ObjectGuid playerGuid, uint32 items_count);
        static BotBankItemContainer const* GetBotBankItems(ObjectGuid playerGuid);
        static uint32 GetBotBankItemsCount(ObjectGuid playerGuid);
        static Item* WithdrawBotBankItem(ObjectGuid playerGuid, ObjectGuid::LowType itemGuidLow);
        static void DepositBotBankItem(ObjectGuid playerGuid, Item* item);
        static void SaveNpcBotStoredGear(ObjectGuid playerGuid, CharacterDatabaseTransaction trans);

        static uint32 GetBotItemSetsCount(ObjectGuid playerGuid);
        static BotItemSetsArray const* GetBotItemSets(ObjectGuid playerGuid);
        static NpcBotItemSet const* GetBotItemSet(ObjectGuid playerGuid, uint8 set_id);
        static NpcBotItemSet& CreateNewBotItemSet(ObjectGuid playerGuid);
        static void UpdateBotItemSet(ObjectGuid playerGuid, uint8 set_id, std::string const& set_name);
        static void UpdateBotItemSet(ObjectGuid playerGuid, uint8 set_id, uint8 slot, uint32 item_id);
        static void DeleteBotItemSet(ObjectGuid playerGuid, uint8 set_id);
        static void SaveNpcBotItemSets(ObjectGuid playerGuid, CharacterDatabaseTransaction trans);

        static NpcBotMgrData* SelectOrCreateNpcBotMgrData(ObjectGuid playerGuid);
        static void EraseNpcBotMgrData(ObjectGuid playerGuid);
        static void RemoveNpcBotMgrDataFromDB(ObjectGuid playerGuid);
        static void SaveNpcBotMgrData(ObjectGuid playerGuid, CharacterDatabaseTransaction trans);

        static std::shared_mutex* GetLock();

    private:
        BotDataMgr() {}
        BotDataMgr(BotDataMgr const&);
};

#endif
