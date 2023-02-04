#ifndef _BOTDATAMGR_H
#define _BOTDATAMGR_H

#include "botcommon.h"

#include <set>
#include <shared_mutex>
#include <vector>

class Creature;

enum NpcBotDataUpdateType
{
    NPCBOT_UPDATE_OWNER                 = 1,
    NPCBOT_UPDATE_ROLES,
    NPCBOT_UPDATE_SPEC,
    NPCBOT_UPDATE_DISABLED_SPELLS,
    NPCBOT_UPDATE_FACTION,
    NPCBOT_UPDATE_EQUIPS,
    NPCBOT_UPDATE_ERASE,
    NPCBOT_UPDATE_TRANSMOG_ERASE,
    NPCBOT_UPDATE_END
};

struct NpcBotData
{
    typedef std::set<uint32> DisabledSpellsContainer;

    friend class BotDataMgr;
public:
    uint32 owner;
    uint32 roles;
    uint32 faction;
    uint8 spec;
    uint32 equips[BOT_INVENTORY_SIZE];
    DisabledSpellsContainer disabled_spells;

private:
    explicit NpcBotData(uint32 iroles, uint32 ifaction, uint8 ispec = 1) : owner(0), roles(iroles), faction(ifaction), spec(ispec)
    {
        for (uint8 i = 0; i != BOT_INVENTORY_SIZE; ++i)
            equips[i] = 0;
    }
    NpcBotData(NpcBotData const&);
};

struct NpcBotAppearanceData
{
    friend class BotDataMgr;
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
    std::pair<uint32 /*item_id*/, uint32 /*fake_id*/> transmogs[BOT_TRANSMOG_INVENTORY_SIZE];
private:
    explicit NpcBotTransmogData()
    {
        for (uint8 i = 0; i != BOT_TRANSMOG_INVENTORY_SIZE; ++i)
            transmogs[i] = { 0, 0 };
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

typedef std::set<Creature const*> NpcBotRegistry;

class BotDataMgr
{
    public:
        static void LoadNpcBots(bool spawn = true);
        static void LoadNpcBotGroupData();

        static void AddNpcBotData(uint32 entry, uint32 roles, uint8 spec, uint32 faction);
        static NpcBotData const* SelectNpcBotData(uint32 entry);
        static void UpdateNpcBotData(uint32 entry, NpcBotDataUpdateType updateType, void* data = nullptr);
        static void UpdateNpcBotDataAll(uint32 playerGuid, NpcBotDataUpdateType updateType, void* data = nullptr);
        static void SaveNpcBotStats(NpcBotStats const* stats);

        static NpcBotAppearanceData const* SelectNpcBotAppearance(uint32 entry);
        static NpcBotExtras const* SelectNpcBotExtras(uint32 entry);

        static NpcBotTransmogData const* SelectNpcBotTransmogs(uint32 entry);
        static void UpdateNpcBotTransmogData(uint32 entry, uint8 slot, uint32 item_id, uint32 fake_id, bool update_db = true);
        static void ResetNpcBotTransmogData(uint32 entry, bool update_db = true);

        static bool AllBotsLoaded();

        static void RegisterBot(Creature const* bot);
        static void UnregisterBot(Creature const* bot);
        static Creature const* FindBot(uint32 entry);
        static Creature const* FindBot(std::string_view name, LocaleConstant loc);
        static NpcBotRegistry const& GetExistingNPCBots();
        static void GetNPCBotGuidsByOwner(std::vector<ObjectGuid> &guids_vec, ObjectGuid owner_guid);
        static ObjectGuid GetNPCBotGuid(uint32 entry);
        static std::vector<uint32> GetExistingNPCBotIds();
        static uint8 GetOwnedBotsCount(ObjectGuid owner_guid, uint32 class_mask = 0);

        static std::shared_mutex* GetLock();

    private:
        BotDataMgr() {}
        BotDataMgr(BotDataMgr const&);
};

#endif
