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

#ifndef ACORE_LOOTMGR_H
#define ACORE_LOOTMGR_H

#include "ByteBuffer.h"
#include "ConditionMgr.h"
#include "ObjectGuid.h"
#include "RefMgr.h"
#include "SharedDefines.h"
#include <list>
#include <map>
#include <unordered_map>
#include <vector>

enum RollType
{
    ROLL_PASS                           = 0,
    ROLL_NEED                           = 1,
    ROLL_GREED                          = 2,
    ROLL_DISENCHANT                     = 3,
    MAX_ROLL_TYPE                       = 4
};

enum RollMask
{
    ROLL_FLAG_TYPE_PASS                 = 0x01,
    ROLL_FLAG_TYPE_NEED                 = 0x02,
    ROLL_FLAG_TYPE_GREED                = 0x04,
    ROLL_FLAG_TYPE_DISENCHANT           = 0x08,

    ROLL_ALL_TYPE_NO_DISENCHANT         = 0x07,
    ROLL_ALL_TYPE_MASK                  = 0x0F
};

#define MAX_NR_LOOT_ITEMS 18
// note: the client cannot show more than 18 items in the loot window on 3.3.5a
#define MAX_NR_QUEST_ITEMS 32
// unrelated to the number of quest items shown, just for reserve

enum LootMethod
{
    FREE_FOR_ALL                        = 0,
    ROUND_ROBIN                         = 1,
    MASTER_LOOT                         = 2,
    GROUP_LOOT                          = 3,
    NEED_BEFORE_GREED                   = 4
};

enum PermissionTypes
{
    ALL_PERMISSION                      = 0,
    GROUP_PERMISSION                    = 1,
    MASTER_PERMISSION                   = 2,
    RESTRICTED_PERMISSION               = 3,
    ROUND_ROBIN_PERMISSION              = 4,
    OWNER_PERMISSION                    = 5,
    NONE_PERMISSION                     = 6
};

enum LootType
{
    LOOT_NONE                           = 0,

    LOOT_CORPSE                         = 1,
    LOOT_PICKPOCKETING                  = 2,
    LOOT_FISHING                        = 3,
    LOOT_DISENCHANTING                  = 4,
    // ignored always by client
    LOOT_SKINNING                       = 6,
    LOOT_PROSPECTING                    = 7,
    LOOT_MILLING                        = 8,

    LOOT_FISHINGHOLE                    = 20,   // unsupported by client, sending LOOT_FISHING instead
    LOOT_INSIGNIA                       = 21,   // unsupported by client, sending LOOT_CORPSE instead
    LOOT_FISHING_JUNK                   = 22    // unsupported by client, sending LOOT_FISHING instead
};

enum LootError
{
    LOOT_ERROR_DIDNT_KILL               = 0,    // You don't have permission to loot that corpse.
    LOOT_ERROR_TOO_FAR                  = 4,    // You are too far away to loot that corpse.
    LOOT_ERROR_BAD_FACING               = 5,    // You must be facing the corpse to loot it.
    LOOT_ERROR_LOCKED                   = 6,    // Someone is already looting that corpse.
    LOOT_ERROR_NOTSTANDING              = 8,    // You need to be standing up to loot something!
    LOOT_ERROR_STUNNED                  = 9,    // You can't loot anything while stunned!
    LOOT_ERROR_PLAYER_NOT_FOUND         = 10,   // Player not found
    LOOT_ERROR_PLAY_TIME_EXCEEDED       = 11,   // Maximum play time exceeded
    LOOT_ERROR_MASTER_INV_FULL          = 12,   // That player's inventory is full
    LOOT_ERROR_MASTER_UNIQUE_ITEM       = 13,   // Player has too many of that item already
    LOOT_ERROR_MASTER_OTHER             = 14,   // Can't assign item to that player
    LOOT_ERROR_ALREADY_PICKPOCKETED     = 15,   // Your target has already had its pockets picked
    LOOT_ERROR_NOT_WHILE_SHAPESHIFTED   = 16    // You can't do that while shapeshifted.
};

// type of Loot Item in Loot View
enum LootSlotType
{
    LOOT_SLOT_TYPE_ALLOW_LOOT           = 0,    // player can loot the item.
    LOOT_SLOT_TYPE_ROLL_ONGOING         = 1,    // roll is ongoing. player cannot loot.
    LOOT_SLOT_TYPE_MASTER               = 2,    // item can only be distributed by group loot master.
    LOOT_SLOT_TYPE_LOCKED               = 3,    // item is shown in red. player cannot loot.
    LOOT_SLOT_TYPE_OWNER                = 4,    // ignore binding confirmation and etc, for single player looting
};

class Player;
class LootStore;
class ConditionMgr;
class GameObject;
struct Loot;

struct LootStoreItem
{
    uint32  itemid;                             // id of the item
    int32   reference;                          // referenced TemplateleId
    float   chance;                             // chance to drop for both quest and non-quest items, chance to be used for refs
    bool    needs_quest : 1;                    // quest drop (quest is required for item to drop)
    uint16  lootmode;
    uint8   groupid     : 7;
    uint8   mincount;                           // mincount for drop items
    uint8   maxcount;                           // max drop count for the item mincount or Ref multiplicator
    ConditionList conditions;                   // additional loot condition

    // Constructor
    // displayid is filled in IsValid() which must be called after
    LootStoreItem(uint32 _itemid, int32 _reference, float _chance, bool _needs_quest, uint16 _lootmode, uint8 _groupid, int32 _mincount, uint8 _maxcount)
        : itemid(_itemid), reference(_reference), chance(_chance), needs_quest(_needs_quest),
          lootmode(_lootmode), groupid(_groupid), mincount(_mincount), maxcount(_maxcount)
    {}

    bool Roll(bool rate, Player const* player, Loot& loot, LootStore const& store) const;   // Checks if the entry takes it's chance (at loot generation)
    [[nodiscard]] bool IsValid(LootStore const& store, uint32 entry) const;
    // Checks correctness of values
};

typedef GuidSet AllowedLooterSet;

struct LootItem
{
    uint32  itemid;
    uint32  itemIndex;
    uint32  randomSuffix;
    int32   randomPropertyId;
    ConditionList conditions;                               // additional loot condition
    AllowedLooterSet allowedGUIDs;
    ObjectGuid rollWinnerGUID;                              // Stores the guid of person who won loot, if his bags are full only he can see the item in loot list!
    uint8   count             : 8;
    bool    is_looted         : 1;
    bool    is_blocked        : 1;
    bool    freeforall        : 1;                          // free for all
    bool    is_underthreshold : 1;
    bool    is_counted        : 1;
    bool    needs_quest       : 1;                          // quest drop
    bool    follow_loot_rules : 1;
    uint8   groupid           : 7;

    // Constructor, copies most fields from LootStoreItem, generates random count and random suffixes/properties
    // Should be called for non-reference LootStoreItem entries only (reference = 0)
    explicit LootItem(LootStoreItem const& li);

    LootItem() = default;

    // Basic checks for player/item compatibility - if false no chance to see the item in the loot
    bool AllowedForPlayer(Player const* player, ObjectGuid source) const;
    void AddAllowedLooter(Player const* player);
    [[nodiscard]] const AllowedLooterSet& GetAllowedLooters() const { return allowedGUIDs; }
};

struct QuestItem
{
    uint8   index{0};                                          // position in quest_items;
    bool    is_looted{false};

    QuestItem()
         = default;

    QuestItem(uint8 _index, bool _islooted = false)
        : index(_index), is_looted(_islooted) {}
};

class LootTemplate;

typedef std::vector<QuestItem> QuestItemList;
typedef std::vector<LootItem> LootItemList;
typedef std::map<ObjectGuid, QuestItemList*> QuestItemMap;
typedef std::list<LootStoreItem*> LootStoreItemList;
typedef std::unordered_map<uint32, LootTemplate*> LootTemplateMap;

typedef std::set<uint32> LootIdSet;

class LootStore
{
public:
    explicit LootStore(char const* name, char const* entryName, bool ratesAllowed)
        : m_name(name), m_entryName(entryName), m_ratesAllowed(ratesAllowed) {}

    virtual ~LootStore() { Clear(); }

    uint32 LoadAndCollectLootIds(LootIdSet& ids_set);
    void ResetConditions();

    void Verify() const;
    void CheckLootRefs(LootIdSet* ref_set = nullptr) const; // check existence reference and remove it from ref_set
    void ReportUnusedIds(LootIdSet const& ids_set) const;
    void ReportNonExistingId(uint32 lootId) const;
    void ReportNonExistingId(uint32 lootId, const char* ownerType, uint32 ownerId) const;
    void ReportInvalidCount(uint32 lootId, const char* ownerType, uint32 ownerId, uint32 itemId, uint8 minCount, uint8 maxCount) const;

    [[nodiscard]] bool HaveLootFor(uint32 loot_id) const { return m_LootTemplates.find(loot_id) != m_LootTemplates.end(); }
    [[nodiscard]] bool HaveQuestLootFor(uint32 loot_id) const;
    bool HaveQuestLootForPlayer(uint32 loot_id, Player const* player) const;

    [[nodiscard]] LootTemplate const* GetLootFor(uint32 loot_id) const;
    [[nodiscard]] LootTemplate* GetLootForConditionFill(uint32 loot_id) const;

    [[nodiscard]] char const* GetName() const { return m_name; }
    [[nodiscard]] char const* GetEntryName() const { return m_entryName; }
    [[nodiscard]] bool IsRatesAllowed() const { return m_ratesAllowed; }
protected:
    uint32 LoadLootTable();
    void Clear();
private:
    LootTemplateMap m_LootTemplates;
    char const* m_name;
    char const* m_entryName;
    bool m_ratesAllowed;
};

class LootTemplate
{
    class LootGroup;                                       // A set of loot definitions for items (refs are not allowed inside)
    typedef std::vector<LootGroup*> LootGroups;

public:
    LootTemplate() = default;
    ~LootTemplate();

    // Adds an entry to the group (at loading stage)
    void AddEntry(LootStoreItem* item);
    // Rolls for every item in the template and adds the rolled items the the loot
    void Process(Loot& loot, LootStore const& store, uint16 lootMode, Player const* player, uint8 groupId = 0, bool isTopLevel = true) const;
    void CopyConditions(ConditionList conditions);
    bool CopyConditions(LootItem* li, uint32 conditionLootId = 0) const;

    // True if template includes at least 1 quest drop entry
    [[nodiscard]] bool HasQuestDrop(LootTemplateMap const& store, uint8 groupId = 0) const;
    // True if template includes at least 1 quest drop for an active quest of the player
    bool HasQuestDropForPlayer(LootTemplateMap const& store, Player const* player, uint8 groupId = 0) const;

    // Checks integrity of the template
    void Verify(LootStore const& store, uint32 Id) const;
    void CheckLootRefs(LootStore const& lootstore, uint32 Id, LootIdSet* ref_set) const;
    bool addConditionItem(Condition* cond);
    [[nodiscard]] bool isReference(uint32 id) const;

private:
    LootStoreItemList Entries;                          // not grouped only
    LootGroups        Groups;                           // groups have own (optimised) processing, grouped entries go there

    // Objects of this class must never be copied, we are storing pointers in container
    LootTemplate(LootTemplate const&);
    LootTemplate& operator=(LootTemplate const&);
};

//=====================================================

class LootValidatorRef :  public Reference<Loot, LootValidatorRef>
{
public:
    LootValidatorRef() = default;
    void targetObjectDestroyLink() override {}
    void sourceObjectDestroyLink() override {}
};

//=====================================================

class LootValidatorRefMgr : public RefMgr<Loot, LootValidatorRef>
{
public:
    typedef LinkedListHead::Iterator< LootValidatorRef > iterator;

    LootValidatorRef* getFirst() { return (LootValidatorRef*)RefMgr<Loot, LootValidatorRef>::getFirst(); }
    LootValidatorRef* getLast() { return (LootValidatorRef*)RefMgr<Loot, LootValidatorRef>::getLast(); }

    iterator begin() { return iterator(getFirst()); }
    iterator end() { return iterator(nullptr); }
    iterator rbegin() { return iterator(getLast()); }
    iterator rend() { return iterator(nullptr); }
};

//=====================================================
struct LootView;

ByteBuffer& operator<<(ByteBuffer& b, LootItem const& li);
ByteBuffer& operator<<(ByteBuffer& b, LootView const& lv);

struct Loot
{
    friend ByteBuffer& operator<<(ByteBuffer& b, LootView const& lv);

    [[nodiscard]] QuestItemMap const& GetPlayerQuestItems() const { return PlayerQuestItems; }
    [[nodiscard]] QuestItemMap const& GetPlayerFFAItems() const { return PlayerFFAItems; }
    [[nodiscard]] QuestItemMap const& GetPlayerNonQuestNonFFAConditionalItems() const { return PlayerNonQuestNonFFAConditionalItems; }

    std::vector<LootItem> items;
    std::vector<LootItem> quest_items;
    uint32 gold;
    uint8 unlootedCount{0};
    ObjectGuid roundRobinPlayer;        // GUID of the player having the Round-Robin ownership for the loot. If 0, round robin owner has released.
    ObjectGuid lootOwnerGUID;
    LootType loot_type{LOOT_NONE};      // required for achievement system

    // GUID of container that holds this loot (item_instance.entry), set for items that can be looted
    ObjectGuid containerGUID;
    ObjectGuid sourceWorldObjectGUID;
    GameObject* sourceGameObject{nullptr};

    Loot(uint32 _gold = 0) : gold(_gold) { }
    ~Loot() { clear(); }

    // if loot becomes invalid this reference is used to inform the listener
    void addLootValidatorRef(LootValidatorRef* pLootValidatorRef)
    {
        i_LootValidatorRefMgr.insertFirst(pLootValidatorRef);
    }

    // void clear();
    void clear()
    {
        for (QuestItemMap::const_iterator itr = PlayerQuestItems.begin(); itr != PlayerQuestItems.end(); ++itr)
            delete itr->second;
        PlayerQuestItems.clear();

        for (QuestItemMap::const_iterator itr = PlayerFFAItems.begin(); itr != PlayerFFAItems.end(); ++itr)
            delete itr->second;
        PlayerFFAItems.clear();

        for (QuestItemMap::const_iterator itr = PlayerNonQuestNonFFAConditionalItems.begin(); itr != PlayerNonQuestNonFFAConditionalItems.end(); ++itr)
            delete itr->second;
        PlayerNonQuestNonFFAConditionalItems.clear();

        PlayersLooting.clear();
        items.clear();
        quest_items.clear();
        gold = 0;
        unlootedCount = 0;
        roundRobinPlayer.Clear();
        i_LootValidatorRefMgr.clearReferences();
        loot_type = LOOT_NONE;
    }

    [[nodiscard]] bool empty() const { return items.empty() && gold == 0; }
    [[nodiscard]] bool isLooted() const { return gold == 0 && unlootedCount == 0; }

    void NotifyItemRemoved(uint8 lootIndex);
    void NotifyQuestItemRemoved(uint8 questIndex);
    void NotifyMoneyRemoved();
    void AddLooter(ObjectGuid GUID) { PlayersLooting.insert(GUID); }
    void RemoveLooter(ObjectGuid GUID) { PlayersLooting.erase(GUID); }

    void generateMoneyLoot(uint32 minAmount, uint32 maxAmount);
    bool FillLoot(uint32 lootId, LootStore const& store, Player* lootOwner, bool personal, bool noEmptyError = false, uint16 lootMode = LOOT_MODE_DEFAULT, WorldObject* lootSource = nullptr);

    // Inserts the item into the loot (called by LootTemplate processors)
    void AddItem(LootStoreItem const& item);

    LootItem* LootItemInSlot(uint32 lootslot, Player* player, QuestItem** qitem = nullptr, QuestItem** ffaitem = nullptr, QuestItem** conditem = nullptr);
    uint32 GetMaxSlotInLootFor(Player* player) const;
    [[nodiscard]] bool hasItemForAll() const;
    bool hasItemFor(Player* player) const;
    [[nodiscard]] bool hasOverThresholdItem() const;
    void FillNotNormalLootFor(Player* player);

private:
    QuestItemList* FillFFALoot(Player* player);
    QuestItemList* FillQuestLoot(Player* player);
    QuestItemList* FillNonQuestNonFFAConditionalLoot(Player* player);

    typedef GuidSet PlayersLootingSet;
    PlayersLootingSet PlayersLooting;
    QuestItemMap PlayerQuestItems;
    QuestItemMap PlayerFFAItems;
    QuestItemMap PlayerNonQuestNonFFAConditionalItems;

    // All rolls are registered here. They need to know, when the loot is not valid anymore
    LootValidatorRefMgr i_LootValidatorRefMgr;
};

struct LootView
{
    Loot& loot;
    Player* viewer;
    PermissionTypes permission;
    LootView(Loot& _loot, Player* _viewer, PermissionTypes _permission = ALL_PERMISSION)
        : loot(_loot), viewer(_viewer), permission(_permission) {}
};

extern LootStore LootTemplates_Creature;
extern LootStore LootTemplates_Fishing;
extern LootStore LootTemplates_Gameobject;
extern LootStore LootTemplates_Item;
extern LootStore LootTemplates_Mail;
extern LootStore LootTemplates_Milling;
extern LootStore LootTemplates_Pickpocketing;
extern LootStore LootTemplates_Reference;
extern LootStore LootTemplates_Skinning;
extern LootStore LootTemplates_Disenchant;
extern LootStore LootTemplates_Prospecting;
extern LootStore LootTemplates_Spell;
extern LootStore LootTemplates_Player;

void LoadLootTemplates_Creature();
void LoadLootTemplates_Fishing();
void LoadLootTemplates_Gameobject();
void LoadLootTemplates_Item();
void LoadLootTemplates_Mail();
void LoadLootTemplates_Milling();
void LoadLootTemplates_Pickpocketing();
void LoadLootTemplates_Skinning();
void LoadLootTemplates_Disenchant();
void LoadLootTemplates_Prospecting();

void LoadLootTemplates_Spell();
void LoadLootTemplates_Reference();

void LoadLootTemplates_Player();

inline void LoadLootTables()
{
    LoadLootTemplates_Creature();
    LoadLootTemplates_Fishing();
    LoadLootTemplates_Gameobject();
    LoadLootTemplates_Item();
    LoadLootTemplates_Mail();
    LoadLootTemplates_Milling();
    LoadLootTemplates_Pickpocketing();
    LoadLootTemplates_Skinning();
    LoadLootTemplates_Disenchant();
    LoadLootTemplates_Prospecting();
    LoadLootTemplates_Spell();

    LoadLootTemplates_Reference();

    LoadLootTemplates_Player();
}

#endif
