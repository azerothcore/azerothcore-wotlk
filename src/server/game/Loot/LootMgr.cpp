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

#include "LootMgr.h"
#include "Containers.h"
#include "DisableMgr.h"
#include "Group.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "Util.h"
#include "World.h"

static Rates const qualityToRate[MAX_ITEM_QUALITY] =
{
    RATE_DROP_ITEM_POOR,                                    // ITEM_QUALITY_POOR
    RATE_DROP_ITEM_NORMAL,                                  // ITEM_QUALITY_NORMAL
    RATE_DROP_ITEM_UNCOMMON,                                // ITEM_QUALITY_UNCOMMON
    RATE_DROP_ITEM_RARE,                                    // ITEM_QUALITY_RARE
    RATE_DROP_ITEM_EPIC,                                    // ITEM_QUALITY_EPIC
    RATE_DROP_ITEM_LEGENDARY,                               // ITEM_QUALITY_LEGENDARY
    RATE_DROP_ITEM_ARTIFACT,                                // ITEM_QUALITY_ARTIFACT
};

LootStore LootTemplates_Creature("creature_loot_template",           "creature entry",                  true);
LootStore LootTemplates_Disenchant("disenchant_loot_template",       "item disenchant id",              true);
LootStore LootTemplates_Fishing("fishing_loot_template",             "area id",                         true);
LootStore LootTemplates_Gameobject("gameobject_loot_template",       "gameobject entry",                true);
LootStore LootTemplates_Item("item_loot_template",                   "item entry",                      true);
LootStore LootTemplates_Mail("mail_loot_template",                   "mail template id",                false);
LootStore LootTemplates_Milling("milling_loot_template",             "item entry (herb)",               true);
LootStore LootTemplates_Pickpocketing("pickpocketing_loot_template", "creature pickpocket lootid",      true);
LootStore LootTemplates_Prospecting("prospecting_loot_template",     "item entry (ore)",                true);
LootStore LootTemplates_Reference("reference_loot_template",         "reference id",                    false);
LootStore LootTemplates_Skinning("skinning_loot_template",           "creature skinning id",            true);
LootStore LootTemplates_Spell("spell_loot_template",                 "spell id (random item creating)", false);
LootStore LootTemplates_Player("player_loot_template",               "team id",                         true);

// Selects invalid loot items to be removed from group possible entries (before rolling)
struct LootGroupInvalidSelector : public Acore::unary_function<LootStoreItem*, bool>
{
    explicit LootGroupInvalidSelector(Loot const& loot, uint16 lootMode) : _loot(loot), _lootMode(lootMode) { }

    bool operator()(LootStoreItem* item) const
    {
        if (!(item->lootmode & _lootMode))
            return true;

        if (!item->reference)
        {
            ItemTemplate const* _proto = sObjectMgr->GetItemTemplate(item->itemid);
            if (!_proto)
                return true;

            uint8 foundDuplicates = 0;
            for (std::vector<LootItem>::const_iterator itr = _loot.items.begin(); itr != _loot.items.end(); ++itr)
                if (itr->itemid == item->itemid && itr->groupid == item->groupid)
                {
                    ++foundDuplicates;
                    if (_proto->InventoryType == 0 && foundDuplicates == 3 && _proto->ItemId != 47242 /*Trophy of the Crusade*/) // Non-equippable items are limited to 3 drops
                        return true;
                    else if (_proto->InventoryType != 0 && foundDuplicates == 1) // Equippable item are limited to 1 drop
                        return true;
                }
        }

        return false;
    }

private:
    Loot const& _loot;
    uint16 _lootMode;
};

class LootTemplate::LootGroup                               // A set of loot definitions for items (refs are not allowed)
{
public:
    LootGroup() { }
    ~LootGroup();

    void AddEntry(LootStoreItem* item);                     // Adds an entry to the group (at loading stage)
    bool HasQuestDrop(LootTemplateMap const& store) const;  // True if group includes at least 1 quest drop entry
    bool HasQuestDropForPlayer(Player const* player, LootTemplateMap const& store) const;
    // The same for active quests of the player
    void Process(Loot& loot, Player const* player, LootStore const& lootstore, uint16 lootMode, uint16 nonRefIterationsLeft) const;    // Rolls an item from the group (if any) and adds the item to the loot
    float RawTotalChance() const;                       // Overall chance for the group (without equal chanced items)
    float TotalChance() const;                          // Overall chance for the group

    void Verify(LootStore const& lootstore, uint32 id, uint8 group_id) const;
    void CollectLootIds(LootIdSet& set) const;
    void CheckLootRefs(LootTemplateMap const& store, LootIdSet* ref_set) const;
    LootStoreItemList* GetExplicitlyChancedItemList() { return &ExplicitlyChanced; }
    LootStoreItemList* GetEqualChancedItemList() { return &EqualChanced; }
    void CopyConditions(ConditionList conditions);
private:
    LootStoreItemList ExplicitlyChanced;                // Entries with chances defined in DB
    LootStoreItemList EqualChanced;                     // Zero chances - every entry takes the same chance

    LootStoreItem const* Roll(Loot& loot, Player const* player, LootStore const& store, uint16 lootMode) const;   // Rolls an item from the group, returns nullptr if all miss their chances

    // This class must never be copied - storing pointers
    LootGroup(LootGroup const&);
    LootGroup& operator=(LootGroup const&);
};

//Remove all data and free all memory
void LootStore::Clear()
{
    for (LootTemplateMap::const_iterator itr = m_LootTemplates.begin(); itr != m_LootTemplates.end(); ++itr)
        delete itr->second;
    m_LootTemplates.clear();
}

// Checks validity of the loot store
// Actual checks are done within LootTemplate::Verify() which is called for every template
void LootStore::Verify() const
{
    for (LootTemplateMap::const_iterator i = m_LootTemplates.begin(); i != m_LootTemplates.end(); ++i)
        i->second->Verify(*this, i->first);
}

// Loads a *_loot_template DB table into loot store
// All checks of the loaded template are called from here, no error reports at loot generation required
uint32 LootStore::LoadLootTable()
{
    LootTemplateMap::const_iterator tab;

    // Clearing store (for reloading case)
    Clear();

    //                                                  0     1            2               3         4         5             6
    QueryResult result = WorldDatabase.Query("SELECT Entry, Item, Reference, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount FROM {}", GetName());

    if (!result)
        return 0;

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 entry               = fields[0].Get<uint32>();
        uint32 item                = fields[1].Get<uint32>();
        int32  reference           = fields[2].Get<int32>();
        float  chance              = fields[3].Get<float>();
        bool   needsquest          = fields[4].Get<bool>();
        uint16 lootmode            = fields[5].Get<uint16>();
        uint8  groupid             = fields[6].Get<uint8>();
        int32  mincount            = fields[7].Get<uint8>();
        int32  maxcount            = fields[8].Get<uint8>();

        if (maxcount > std::numeric_limits<uint8>::max())
        {
            LOG_ERROR("sql.sql", "Table '{}' Entry {} Item {}: MaxCount value ({}) to large. must be less {} - skipped", GetName(), entry, item, maxcount, std::numeric_limits<uint8>::max());
            continue;                                   // error already printed to log/console.
        }

        if (lootmode == 0)
        {
            LOG_ERROR("sql.sql", "Table '{}' Entry {} Item {}: LootMode is equal to 0, item will never drop - setting mode 1", GetName(), entry, item);
            lootmode = 1;
        }

        LootStoreItem* storeitem = new LootStoreItem(item, reference, chance, needsquest, lootmode, groupid, mincount, maxcount);

        if (!storeitem->IsValid(*this, entry))            // Validity checks
        {
            delete storeitem;
            continue;
        }

        // Looking for the template of the entry
        // often entries are put together
        // cppcheck-suppress eraseDereference
        if (m_LootTemplates.empty() || tab->first != entry)
        {
            // Searching the template (in case template Id changed)
            tab = m_LootTemplates.find(entry);
            if (tab == m_LootTemplates.end())
            {
                std::pair< LootTemplateMap::iterator, bool > pr = m_LootTemplates.insert(LootTemplateMap::value_type(entry, new LootTemplate()));
                tab = pr.first;
            }
        }
        // else is empty - template Id and iter are the same
        // finally iter refers to already existed or just created <entry, LootTemplate>

        // Adds current row to the template
        tab->second->AddEntry(storeitem);
        ++count;
    } while (result->NextRow());

    Verify();                                           // Checks validity of the loot store

    return count;
}

bool LootStore::HaveQuestLootFor(uint32 loot_id) const
{
    LootTemplateMap::const_iterator itr = m_LootTemplates.find(loot_id);
    if (itr == m_LootTemplates.end())
        return false;

    // scan loot for quest items
    return itr->second->HasQuestDrop(m_LootTemplates);
}

bool LootStore::HaveQuestLootForPlayer(uint32 loot_id, Player const* player) const
{
    LootTemplateMap::const_iterator tab = m_LootTemplates.find(loot_id);
    if (tab != m_LootTemplates.end())
        if (tab->second->HasQuestDropForPlayer(m_LootTemplates, player))
            return true;

    return false;
}

void LootStore::ResetConditions()
{
    for (LootTemplateMap::iterator itr = m_LootTemplates.begin(); itr != m_LootTemplates.end(); ++itr)
    {
        ConditionList empty;
        itr->second->CopyConditions(empty);
    }
}

LootTemplate const* LootStore::GetLootFor(uint32 loot_id) const
{
    LootTemplateMap::const_iterator tab = m_LootTemplates.find(loot_id);

    if (tab == m_LootTemplates.end())
        return nullptr;

    return tab->second;
}

LootTemplate* LootStore::GetLootForConditionFill(uint32 loot_id) const
{
    LootTemplateMap::const_iterator tab = m_LootTemplates.find(loot_id);

    if (tab == m_LootTemplates.end())
        return nullptr;

    return tab->second;
}

uint32 LootStore::LoadAndCollectLootIds(LootIdSet& lootIdSet)
{
    uint32 count = LoadLootTable();

    for (LootTemplateMap::const_iterator tab = m_LootTemplates.begin(); tab != m_LootTemplates.end(); ++tab)
        lootIdSet.insert(tab->first);

    return count;
}

void LootStore::CheckLootRefs(LootIdSet* ref_set) const
{
    for (LootTemplateMap::const_iterator ltItr = m_LootTemplates.begin(); ltItr != m_LootTemplates.end(); ++ltItr)
        ltItr->second->CheckLootRefs(m_LootTemplates, ref_set);
}

void LootStore::ReportUnusedIds(LootIdSet const& lootIdSet) const
{
    // all still listed ids isn't referenced
    for (LootIdSet::const_iterator itr = lootIdSet.begin(); itr != lootIdSet.end(); ++itr)
        LOG_ERROR("sql.sql", "Table '{}' Entry {} isn't {} and not referenced from loot, and thus useless.", GetName(), *itr, GetEntryName());
}

void LootStore::ReportNonExistingId(uint32 lootId) const
{
    LOG_ERROR("sql.sql", "Table '{}' Entry {} does not exist", GetName(), lootId);
}

void LootStore::ReportNonExistingId(uint32 lootId, const char* ownerType, uint32 ownerId) const
{
    LOG_ERROR("sql.sql", "Table '{}' Entry {} does not exist but it is used by {} {}", GetName(), lootId, ownerType, ownerId);
}

//
// --------- LootStoreItem ---------
//

// Checks if the entry (quest, non-quest, reference) takes it's chance (at loot generation)
// RATE_DROP_ITEMS is no longer used for all types of entries
bool LootStoreItem::Roll(bool rate, Player const* player, Loot& loot, LootStore const& store) const
{
    float _chance = chance;

    if (!sScriptMgr->OnItemRoll(player, this, _chance, loot, store))
        return false;

    if (_chance >= 100.0f)
        return true;

    if (reference)                                   // reference case
        return roll_chance_f(_chance * (rate ? sWorld->getRate(RATE_DROP_ITEM_REFERENCED) : 1.0f));

    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(itemid);

    float qualityModifier = pProto && rate ? sWorld->getRate(qualityToRate[pProto->Quality]) : 1.0f;

    return roll_chance_f(_chance * qualityModifier);
}

// Checks correctness of values
bool LootStoreItem::IsValid(LootStore const& store, uint32 entry) const
{
    if (groupid >= 1 << 7)                                     // it stored in 7 bit field
    {
        LOG_ERROR("sql.sql", "Table '{}' Entry {} Item {}: GroupId ({}) must be less {} - skipped", store.GetName(), entry, itemid, groupid, 1 << 7);
        return false;
    }

    if (mincount == 0)
    {
        LOG_ERROR("sql.sql", "Table '{}' Entry {} Item {}: wrong MinCount ({}) - skipped", store.GetName(), entry, itemid, mincount);
        return false;
    }

    if (!reference)                                  // item (quest or non-quest) entry, maybe grouped
    {
        ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemid);
        if (!proto)
        {
            LOG_ERROR("sql.sql", "Table '{}' Entry {} Item {}: item entry not listed in `item_template` - skipped", store.GetName(), entry, itemid);
            return false;
        }

        if (chance == 0 && groupid == 0)                     // Zero chance is allowed for grouped entries only
        {
            LOG_ERROR("sql.sql", "Table '{}' Entry {} Item {}: equal-chanced grouped entry, but group not defined - skipped", store.GetName(), entry, itemid);
            return false;
        }

        if (chance != 0 && chance < 0.000001f)             // loot with low chance
        {
            LOG_ERROR("sql.sql", "Table '{}' Entry {} Item {}: low chance ({}) - skipped",
                             store.GetName(), entry, itemid, chance);
            return false;
        }

        if (maxcount < mincount)                       // wrong max count
        {
            LOG_ERROR("sql.sql", "Table '{}' Entry {} Item {}: MaxCount ({}) less that MinCount ({}) - skipped", store.GetName(), entry, itemid, int32(maxcount), mincount);
            return false;
        }
    }
    else                                                    // if reference loot
    {
        if (needs_quest)
            LOG_ERROR("sql.sql", "Table '{}' Entry {} Item {}: quest required will be ignored", store.GetName(), entry, itemid);
        else if (chance == 0)                              // no chance for the reference
        {
            LOG_ERROR("sql.sql", "Table '{}' Entry {} Item {}: zero chance is specified for a reference, skipped", store.GetName(), entry, itemid);
            return false;
        }
    }
    return true;                                            // Referenced template existence is checked at whole store level
}

//
// --------- LootItem ---------
//

// Constructor, copies most fields from LootStoreItem and generates random count
LootItem::LootItem(LootStoreItem const& li)
{
    itemid       = li.itemid;
    itemIndex    = 0;
    conditions   = li.conditions;

    ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemid);
    freeforall  = proto && (proto->Flags & ITEM_FLAG_MULTI_DROP);
    follow_loot_rules = proto && (proto->FlagsCu & ITEM_FLAGS_CU_FOLLOW_LOOT_RULES);

    needs_quest = li.needs_quest;

    randomSuffix = GenerateEnchSuffixFactor(itemid);
    randomPropertyId = Item::GenerateItemRandomPropertyId(itemid);
    count = 0;
    is_looted = 0;
    is_blocked = 0;
    is_underthreshold = 0;
    is_counted = 0;
    rollWinnerGUID = ObjectGuid::Empty;
    groupid = li.groupid;
}

// Basic checks for player/item compatibility - if false no chance to see the item in the loot
bool LootItem::AllowedForPlayer(Player const* player, ObjectGuid source) const
{
    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(itemid);
    if (!pProto)
    {
        return false;
    }

    if (DisableMgr::IsDisabledFor(DISABLE_TYPE_LOOT, itemid, nullptr))
    {
        return false;
    }

    bool isMasterLooter = player->GetGroup() && player->GetGroup()->GetMasterLooterGuid() == player->GetGUID();
    bool itemVisibleForMasterLooter = !needs_quest && (!follow_loot_rules || !is_underthreshold);

    // DB conditions check
    if (!sConditionMgr->IsObjectMeetToConditions(const_cast<Player*>(player), conditions))
    {
        // Master Looter can see conditioned recipes
        if (isMasterLooter && itemVisibleForMasterLooter)
        {
            if ((pProto->Flags & ITEM_FLAG_HIDE_UNUSABLE_RECIPE) || (pProto->Class == ITEM_CLASS_RECIPE && pProto->Bonding == BIND_WHEN_PICKED_UP && pProto->Spells[1].SpellId != 0))
            {
                return true;
            }
        }

        return false;
    }

    // not show loot for not own team
    if ((pProto->Flags2 & ITEM_FLAGS_EXTRA_HORDE_ONLY) && player->GetTeamId(true) != TEAM_HORDE)
    {
        return false;
    }

    if ((pProto->Flags2 & ITEM_FLAGS_EXTRA_ALLIANCE_ONLY) && player->GetTeamId(true) != TEAM_ALLIANCE)
    {
        return false;
    }

    // Master looter can see all items even if the character can't loot them
    if (isMasterLooter && itemVisibleForMasterLooter)
    {
        return true;
    }

    // Don't allow loot for players without profession or those who already know the recipe
    if ((pProto->Flags & ITEM_FLAG_HIDE_UNUSABLE_RECIPE) && (!player->HasSkill(pProto->RequiredSkill) || player->HasSpell(pProto->Spells[1].SpellId)))
    {
        return false;
    }

    // Don't allow to loot soulbound recipes that the player has already learned
    if (pProto->Class == ITEM_CLASS_RECIPE && pProto->Bonding == BIND_WHEN_PICKED_UP && pProto->Spells[1].SpellId != 0 && player->HasSpell(pProto->Spells[1].SpellId))
    {
        return false;
    }

    // check quest requirements
    if (!(pProto->FlagsCu & ITEM_FLAGS_CU_IGNORE_QUEST_STATUS))
    {
        //  Don't drop quest items if the player is missing the relevant quest
        if (needs_quest && !player->HasQuestForItem(itemid))
            return false;

        // for items that start quests
        if (pProto->StartQuest)
        {
            // Don't drop the item if the player has already finished the quest OR player already has the item in their inventory, and that item is unique OR the player has not finished a prerequisite quest
            uint32 prevQuestId = sObjectMgr->GetQuestTemplate(pProto->StartQuest) ? sObjectMgr->GetQuestTemplate(pProto->StartQuest)->GetPrevQuestId() : 0;
            if (player->GetQuestStatus(pProto->StartQuest) != QUEST_STATUS_NONE || (player->HasItemCount(itemid, pProto->MaxCount) && pProto->MaxCount) || (prevQuestId && !player->GetQuestRewardStatus(prevQuestId)))
                return false;
        }
    }

    if (!sScriptMgr->OnAllowedForPlayerLootCheck(player, source))
    {
        return false;
    }

    return true;
}

void LootItem::AddAllowedLooter(Player const* player)
{
    allowedGUIDs.insert(player->GetGUID());
}

//
// --------- Loot ---------
//

// Inserts the item into the loot (called by LootTemplate processors)
void Loot::AddItem(LootStoreItem const& item)
{
    ItemTemplate const* proto = sObjectMgr->GetItemTemplate(item.itemid);
    if (!proto)
        return;

    uint32 count = urand(item.mincount, item.maxcount);
    uint32 stacks = count / proto->GetMaxStackSize() + (count % proto->GetMaxStackSize() ? 1 : 0);

    std::vector<LootItem>& lootItems = item.needs_quest ? quest_items : items;
    uint32 limit = item.needs_quest ? MAX_NR_QUEST_ITEMS : MAX_NR_LOOT_ITEMS;

    for (uint32 i = 0; i < stacks && lootItems.size() < limit; ++i)
    {
        LootItem generatedLoot(item);
        generatedLoot.count = std::min(count, proto->GetMaxStackSize());
        generatedLoot.itemIndex = lootItems.size();
        lootItems.push_back(generatedLoot);
        count -= proto->GetMaxStackSize();

        // In some cases, a dropped item should be visible/lootable only for some players in group
        bool canSeeItemInLootWindow = false;
        if (auto player = ObjectAccessor::FindPlayer(lootOwnerGUID))
        {
            if (auto group = player->GetGroup())
            {
                for (auto itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                {
                    if (auto member = itr->GetSource())
                    {
                        if (generatedLoot.AllowedForPlayer(member, sourceWorldObjectGUID))
                        {
                            canSeeItemInLootWindow = true;
                            break;
                        }
                    }
                }
            }
            else if (generatedLoot.AllowedForPlayer(player, sourceWorldObjectGUID))
            {
                canSeeItemInLootWindow = true;
            }
        }

        if (!canSeeItemInLootWindow)
        {
            LOG_DEBUG("loot", "Skipping ++unlootedCount for unlootable item: {}", item.itemid);
            continue;
        }

        // non-conditional one-player only items are counted here,
        // free for all items are counted in FillFFALoot(),
        // non-ffa conditionals are counted in FillNonQuestNonFFAConditionalLoot()
        if (!item.needs_quest && item.conditions.empty() && !(proto->Flags & ITEM_FLAG_MULTI_DROP))
            ++unlootedCount;
    }
}

// Calls processor of corresponding LootTemplate (which handles everything including references)
bool Loot::FillLoot(uint32 lootId, LootStore const& store, Player* lootOwner, bool personal, bool noEmptyError, uint16 lootMode /*= LOOT_MODE_DEFAULT*/, WorldObject* lootSource /*= nullptr*/)
{
    // Must be provided
    if (!lootOwner)
        return false;

    lootOwnerGUID = lootOwner->GetGUID();

    LootTemplate const* tab = store.GetLootFor(lootId);

    if (!tab)
    {
        if (!noEmptyError)
            LOG_ERROR("sql.sql", "Table '{}' loot id #{} used but it doesn't have records.", store.GetName(), lootId);
        return false;
    }

    items.reserve(MAX_NR_LOOT_ITEMS);
    quest_items.reserve(MAX_NR_QUEST_ITEMS);

    // Initial group is 0, top level set to True
    tab->Process(*this, store, lootMode, lootOwner, 0, true);          // Processing is done there, callback via Loot::AddItem()

    sScriptMgr->OnAfterLootTemplateProcess(this, tab, store, lootOwner, personal, noEmptyError, lootMode);

    // Setting access rights for group loot case
    Group* group = lootOwner->GetGroup();
    if (!personal && group)
    {
        roundRobinPlayer = lootOwner->GetGUID();

        for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            if (Player* player = itr->GetSource()) // should actually be looted object instead of lootOwner but looter has to be really close so doesnt really matter
            {
                if (player->IsAtLootRewardDistance(lootSource ? lootSource : lootOwner))
                {
                    FillNotNormalLootFor(player);
                }
            }
        }

        for (uint8 i = 0; i < items.size(); ++i)
        {
            if (ItemTemplate const* proto = sObjectMgr->GetItemTemplate(items[i].itemid))
                if (proto->Quality < uint32(group->GetLootThreshold()))
                    items[i].is_underthreshold = true;
        }
    }
    // ... for personal loot
    else
        FillNotNormalLootFor(lootOwner);

    return true;
}

void Loot::FillNotNormalLootFor(Player* player)
{
    ObjectGuid playerGuid = player->GetGUID();

    QuestItemMap::const_iterator qmapitr = PlayerQuestItems.find(playerGuid);
    if (qmapitr == PlayerQuestItems.end())
        FillQuestLoot(player);

    qmapitr = PlayerFFAItems.find(playerGuid);
    if (qmapitr == PlayerFFAItems.end())
        FillFFALoot(player);

    qmapitr = PlayerNonQuestNonFFAConditionalItems.find(playerGuid);
    if (qmapitr == PlayerNonQuestNonFFAConditionalItems.end())
        FillNonQuestNonFFAConditionalLoot(player);

    // Process currency items
    uint32 max_slot = GetMaxSlotInLootFor(player);
    LootItem const* item = nullptr;
    uint32 itemsSize = uint32(items.size());
    for (uint32 i = 0; i < max_slot; ++i)
    {
        if (i < items.size())
            item = &items[i];
        else
            item = &quest_items[i - itemsSize];

        if (!item->is_looted && item->freeforall && item->AllowedForPlayer(player, sourceWorldObjectGUID))
            if (ItemTemplate const* proto = sObjectMgr->GetItemTemplate(item->itemid))
                if (proto->IsCurrencyToken())
                {
                    InventoryResult msg;
                    player->StoreLootItem(i, this, msg);
                }
    }
}

QuestItemList* Loot::FillFFALoot(Player* player)
{
    QuestItemList* ql = new QuestItemList();

    for (uint8 i = 0; i < items.size(); ++i)
    {
        LootItem& item = items[i];
        if (!item.is_looted && item.freeforall && item.AllowedForPlayer(player, containerGUID))
        {
            ql->push_back(QuestItem(i));
            ++unlootedCount;
        }
    }
    if (ql->empty())
    {
        delete ql;
        return nullptr;
    }

    PlayerFFAItems[player->GetGUID()] = ql;
    return ql;
}

QuestItemList* Loot::FillQuestLoot(Player* player)
{
    if (items.size() == MAX_NR_LOOT_ITEMS)
        return nullptr;

    QuestItemList* ql = new QuestItemList();

    Player* lootOwner = (roundRobinPlayer) ? ObjectAccessor::FindPlayer(roundRobinPlayer) : player;

    for (uint8 i = 0; i < quest_items.size(); ++i)
    {
        LootItem& item = quest_items[i];

        sScriptMgr->OnBeforeFillQuestLootItem(player, item);

        // Quest item is not free for all and is already assigned to another player
        // or player doesn't need it
        if (item.is_blocked || !item.AllowedForPlayer(player, sourceWorldObjectGUID))
        {
            continue;
        }

        // Player is not the loot owner, and loot owner still needs this quest item
        if (!item.freeforall && lootOwner != player && item.AllowedForPlayer(lootOwner, sourceWorldObjectGUID))
        {
            continue;
        }

        ql->push_back(QuestItem(i));
        ++unlootedCount;

        if (!item.freeforall)
        {
            item.is_blocked = true;
        }

        if (items.size() + ql->size() == MAX_NR_LOOT_ITEMS)
            break;
    }
    if (ql->empty())
    {
        delete ql;
        return nullptr;
    }

    PlayerQuestItems[player->GetGUID()] = ql;
    return ql;
}

QuestItemList* Loot::FillNonQuestNonFFAConditionalLoot(Player* player)
{
    QuestItemList* ql = new QuestItemList();

    for (uint8 i = 0; i < items.size(); ++i)
    {
        LootItem& item = items[i];

        if (!item.is_looted && !item.freeforall && item.AllowedForPlayer(player, sourceWorldObjectGUID))
        {
            item.AddAllowedLooter(player);

            if (!item.conditions.empty())
            {
                ql->push_back(QuestItem(i));
                if (!item.is_counted)
                {
                    ++unlootedCount;
                    item.is_counted = true;
                }
            }
        }
    }
    if (ql->empty())
    {
        delete ql;
        return nullptr;
    }

    PlayerNonQuestNonFFAConditionalItems[player->GetGUID()] = ql;
    return ql;
}

//===================================================

void Loot::NotifyItemRemoved(uint8 lootIndex)
{
    // notify all players that are looting this that the item was removed
    // convert the index to the slot the player sees
    PlayersLootingSet::iterator i_next;
    for (PlayersLootingSet::iterator i = PlayersLooting.begin(); i != PlayersLooting.end(); i = i_next)
    {
        i_next = i;
        ++i_next;
        if (Player* player = ObjectAccessor::FindPlayer(*i))
            player->SendNotifyLootItemRemoved(lootIndex);
        else
            PlayersLooting.erase(i);
    }
}

void Loot::NotifyMoneyRemoved()
{
    // notify all players that are looting this that the money was removed
    PlayersLootingSet::iterator i_next;
    for (PlayersLootingSet::iterator i = PlayersLooting.begin(); i != PlayersLooting.end(); i = i_next)
    {
        i_next = i;
        ++i_next;
        if (Player* player = ObjectAccessor::FindPlayer(*i))
            player->SendNotifyLootMoneyRemoved();
        else
            PlayersLooting.erase(i);
    }
}

void Loot::NotifyQuestItemRemoved(uint8 questIndex)
{
    // when a free for all questitem is looted
    // all players will get notified of it being removed
    // (other questitems can be looted by each group member)
    // bit inefficient but isn't called often

    PlayersLootingSet::iterator i_next;
    for (PlayersLootingSet::iterator i = PlayersLooting.begin(); i != PlayersLooting.end(); i = i_next)
    {
        i_next = i;
        ++i_next;
        if (Player* player = ObjectAccessor::FindPlayer(*i))
        {
            QuestItemMap::const_iterator pq = PlayerQuestItems.find(player->GetGUID());
            if (pq != PlayerQuestItems.end() && pq->second)
            {
                // find where/if the player has the given item in it's vector
                QuestItemList& pql = *pq->second;

                uint8 j;
                for (j = 0; j < pql.size(); ++j)
                    if (pql[j].index == questIndex)
                        break;

                if (j < pql.size())
                    player->SendNotifyLootItemRemoved(items.size() + j);
            }
        }
        else
            PlayersLooting.erase(i);
    }
}

void Loot::generateMoneyLoot(uint32 minAmount, uint32 maxAmount)
{
    if (maxAmount > 0)
    {
        if (maxAmount <= minAmount)
            gold = uint32(maxAmount * sWorld->getRate(RATE_DROP_MONEY));
        else if ((maxAmount - minAmount) < 32700)
            gold = uint32(urand(minAmount, maxAmount) * sWorld->getRate(RATE_DROP_MONEY));
        else
            gold = uint32(urand(minAmount >> 8, maxAmount >> 8) * sWorld->getRate(RATE_DROP_MONEY)) << 8;
    }
}

LootItem* Loot::LootItemInSlot(uint32 lootSlot, Player* player, QuestItem * *qitem, QuestItem * *ffaitem, QuestItem * *conditem)
{
    LootItem* item = nullptr;
    bool is_looted = true;
    if (lootSlot >= items.size())
    {
        uint32 questSlot = lootSlot - items.size();
        QuestItemMap::const_iterator itr = PlayerQuestItems.find(player->GetGUID());
        if (itr != PlayerQuestItems.end() && questSlot < itr->second->size())
        {
            QuestItem* qitem2 = &itr->second->at(questSlot);
            if (qitem)
                *qitem = qitem2;
            item = &quest_items[qitem2->index];
            if (item->follow_loot_rules && !item->AllowedForPlayer(player, sourceWorldObjectGUID)) // pussywizard: such items (follow_loot_rules) are added to every player, but not everyone is allowed, check it here
                return nullptr;
            is_looted = qitem2->is_looted;
        }
    }
    else
    {
        item = &items[lootSlot];
        is_looted = item->is_looted;
        if (item->freeforall)
        {
            QuestItemMap::const_iterator itr = PlayerFFAItems.find(player->GetGUID());
            if (itr != PlayerFFAItems.end())
            {
                for (QuestItemList::const_iterator iter = itr->second->begin(); iter != itr->second->end(); ++iter)
                    if (iter->index == lootSlot)
                    {
                        QuestItem* ffaitem2 = (QuestItem*) & (*iter);
                        if (ffaitem)
                            *ffaitem = ffaitem2;
                        is_looted = ffaitem2->is_looted;
                        break;
                    }
            }
        }
        else if (!item->conditions.empty())
        {
            QuestItemMap::const_iterator itr = PlayerNonQuestNonFFAConditionalItems.find(player->GetGUID());
            if (itr != PlayerNonQuestNonFFAConditionalItems.end())
            {
                for (QuestItemList::const_iterator iter = itr->second->begin(); iter != itr->second->end(); ++iter)
                {
                    if (iter->index == lootSlot)
                    {
                        QuestItem* conditem2 = (QuestItem*) & (*iter);
                        if (conditem)
                            *conditem = conditem2;
                        is_looted = conditem2->is_looted;
                        break;
                    }
                }
            }
        }
    }

    if (is_looted)
        return nullptr;

    return item;
}

uint32 Loot::GetMaxSlotInLootFor(Player* player) const
{
    QuestItemMap::const_iterator itr = PlayerQuestItems.find(player->GetGUID());
    return items.size() + (itr != PlayerQuestItems.end() ?  itr->second->size() : 0);
}

bool Loot::hasItemForAll() const
{
    // Gold is always lootable
    if (gold)
    {
        return true;
    }

    for (LootItem const& item : items)
        if (!item.is_looted && !item.freeforall && item.conditions.empty())
            return true;
    return false;
}

// return true if there is any FFA, quest or conditional item for the player.
bool Loot::hasItemFor(Player* player) const
{
    QuestItemMap const& lootPlayerQuestItems = GetPlayerQuestItems();
    QuestItemMap::const_iterator q_itr = lootPlayerQuestItems.find(player->GetGUID());
    if (q_itr != lootPlayerQuestItems.end())
    {
        QuestItemList* q_list = q_itr->second;
        for (QuestItemList::const_iterator qi = q_list->begin(); qi != q_list->end(); ++qi)
        {
            const LootItem& item = quest_items[qi->index];
            if (!qi->is_looted && !item.is_looted)
                return true;
        }
    }

    QuestItemMap const& lootPlayerFFAItems = GetPlayerFFAItems();
    QuestItemMap::const_iterator ffa_itr = lootPlayerFFAItems.find(player->GetGUID());
    if (ffa_itr != lootPlayerFFAItems.end())
    {
        QuestItemList* ffa_list = ffa_itr->second;
        for (QuestItemList::const_iterator fi = ffa_list->begin(); fi != ffa_list->end(); ++fi)
        {
            const LootItem& item = items[fi->index];
            if (!fi->is_looted && !item.is_looted)
                return true;
        }
    }

    QuestItemMap const& lootPlayerNonQuestNonFFAConditionalItems = GetPlayerNonQuestNonFFAConditionalItems();
    QuestItemMap::const_iterator nn_itr = lootPlayerNonQuestNonFFAConditionalItems.find(player->GetGUID());
    if (nn_itr != lootPlayerNonQuestNonFFAConditionalItems.end())
    {
        QuestItemList* conditional_list = nn_itr->second;
        for (QuestItemList::const_iterator ci = conditional_list->begin(); ci != conditional_list->end(); ++ci)
        {
            const LootItem& item = items[ci->index];
            if (!ci->is_looted && !item.is_looted)
                return true;
        }
    }

    return false;
}

// return true if there is any item over the group threshold (i.e. not underthreshold).
bool Loot::hasOverThresholdItem() const
{
    for (uint8 i = 0; i < items.size(); ++i)
    {
        if (!items[i].is_looted && !items[i].is_underthreshold && !items[i].freeforall)
            return true;
    }

    return false;
}

ByteBuffer& operator<<(ByteBuffer& b, LootItem const& li)
{
    b << uint32(li.itemid);
    b << uint32(li.count);                                  // nr of items of this type
    b << uint32(sObjectMgr->GetItemTemplate(li.itemid)->DisplayInfoID);
    b << uint32(li.randomSuffix);
    b << uint32(li.randomPropertyId);
    //b << uint8(0);                                        // slot type - will send after this function call
    return b;
}

ByteBuffer& operator<<(ByteBuffer& b, LootView const& lv)
{
    if (lv.permission == NONE_PERMISSION)
    {
        b << uint32(0);                                     //gold
        b << uint8(0);                                      // item count
        return b;                                           // nothing output more
    }

    Loot& l = lv.loot;

    uint8 itemsShown = 0;

    b << uint32(l.gold);                                    //gold

    size_t count_pos = b.wpos();                            // pos of item count byte
    b << uint8(0);                                          // item count placeholder

    switch (lv.permission)
    {
        case GROUP_PERMISSION:
        case MASTER_PERMISSION:
        case RESTRICTED_PERMISSION:
            {
                bool isMasterLooter = lv.viewer->GetGroup() && lv.viewer->GetGroup()->GetMasterLooterGuid() == lv.viewer->GetGUID();

                // if you are not the round-robin group looter, you can only see
                // blocked rolled items and quest items, and !ffa items
                for (uint8 i = 0; i < l.items.size(); ++i)
                {
                    if (!l.items[i].is_looted && !l.items[i].freeforall && (l.items[i].conditions.empty() || isMasterLooter) && l.items[i].AllowedForPlayer(lv.viewer, l.sourceWorldObjectGUID))
                    {
                        uint8 slot_type = 0;

                        if (l.items[i].is_blocked) // for ML & restricted is_blocked = !is_underthreshold
                        {
                            switch (lv.permission)
                            {
                                case GROUP_PERMISSION:
                                    slot_type = LOOT_SLOT_TYPE_ROLL_ONGOING;
                                    break;
                                case MASTER_PERMISSION:
                                    {
                                        if (lv.viewer->GetGroup())
                                        {
                                            if (lv.viewer->GetGroup()->GetMasterLooterGuid() == lv.viewer->GetGUID())
                                                slot_type = LOOT_SLOT_TYPE_MASTER;
                                            else
                                                slot_type = LOOT_SLOT_TYPE_LOCKED;
                                        }
                                        break;
                                    }
                                case RESTRICTED_PERMISSION:
                                    slot_type = LOOT_SLOT_TYPE_LOCKED;
                                    break;
                                default:
                                    continue;
                            }
                        }
                        else if (l.items[i].rollWinnerGUID)
                        {
                            if (l.items[i].rollWinnerGUID == lv.viewer->GetGUID())
                                slot_type = LOOT_SLOT_TYPE_OWNER;
                            else
                                continue;
                        }
                        else if (!l.roundRobinPlayer || lv.viewer->GetGUID() == l.roundRobinPlayer || !l.items[i].is_underthreshold)
                        {
                            // no round robin owner or he has released the loot
                            // or it IS the round robin group owner
                            // => item is lootable
                            slot_type = LOOT_SLOT_TYPE_ALLOW_LOOT;
                        }
                        else
                            // item shall not be displayed.
                            continue;

                        b << uint8(i) << l.items[i];
                        b << uint8(slot_type);
                        ++itemsShown;
                    }
                }
                break;
            }
        case ROUND_ROBIN_PERMISSION:
            {
                for (uint8 i = 0; i < l.items.size(); ++i)
                {
                    if (!l.items[i].is_looted && !l.items[i].freeforall && l.items[i].conditions.empty() && l.items[i].AllowedForPlayer(lv.viewer, l.sourceWorldObjectGUID))
                    {
                        if (l.roundRobinPlayer && lv.viewer->GetGUID() != l.roundRobinPlayer)
                            // item shall not be displayed.
                            continue;

                        b << uint8(i) << l.items[i];
                        b << uint8(LOOT_SLOT_TYPE_ALLOW_LOOT);
                        ++itemsShown;
                    }
                }
                break;
            }
        case ALL_PERMISSION:
        case OWNER_PERMISSION:
            {
                uint8 slot_type = lv.permission == OWNER_PERMISSION ? LOOT_SLOT_TYPE_OWNER : LOOT_SLOT_TYPE_ALLOW_LOOT;
                for (uint8 i = 0; i < l.items.size(); ++i)
                {
                    if (!l.items[i].is_looted && !l.items[i].freeforall && l.items[i].conditions.empty() && l.items[i].AllowedForPlayer(lv.viewer, l.sourceWorldObjectGUID))
                    {
                        b << uint8(i) << l.items[i];
                        b << uint8(slot_type);
                        ++itemsShown;
                    }
                }
                break;
            }
        default:
            return b;
    }

    LootSlotType slotType = lv.permission == OWNER_PERMISSION ? LOOT_SLOT_TYPE_OWNER : LOOT_SLOT_TYPE_ALLOW_LOOT;

    // Xinef: items that do not follow loot rules need this
    LootSlotType partySlotType = lv.permission == MASTER_PERMISSION ? LOOT_SLOT_TYPE_MASTER : slotType;

    QuestItemMap const& lootPlayerQuestItems = l.GetPlayerQuestItems();
    QuestItemMap::const_iterator q_itr = lootPlayerQuestItems.find(lv.viewer->GetGUID());
    if (q_itr != lootPlayerQuestItems.end())
    {
        QuestItemList* q_list = q_itr->second;
        for (QuestItemList::const_iterator qi = q_list->begin(); qi != q_list->end(); ++qi)
        {
            LootItem& item = l.quest_items[qi->index];
            if (!qi->is_looted && !item.is_looted)
            {
                bool showInLoot = true;
                bool hasQuestForItem = lv.viewer->HasQuestForItem(item.itemid, 0, false, &showInLoot);
                if (!hasQuestForItem)
                {
                    if (!showInLoot)
                    {
                        const_cast<QuestItem*>(&(*qi))->is_looted = true;
                        if (!item.freeforall)
                        {
                            item.is_looted = true;
                        }
                        continue;
                    }

                    b << uint8(l.items.size() + (qi - q_list->begin()));
                    b << item;
                    b << uint8(lv.permission == MASTER_PERMISSION ? LOOT_SLOT_TYPE_MASTER : LOOT_SLOT_TYPE_LOCKED);
                }
                else
                {
                    b << uint8(l.items.size() + (qi - q_list->begin()));
                    b << item;

                    if (item.follow_loot_rules)
                    {
                        switch (lv.permission)
                        {
                            case MASTER_PERMISSION:
                                b << uint8(LOOT_SLOT_TYPE_MASTER);
                                break;
                            case RESTRICTED_PERMISSION:
                                b << (item.is_blocked ? uint8(LOOT_SLOT_TYPE_LOCKED) : uint8(slotType));
                                break;
                            case GROUP_PERMISSION:
                            case ROUND_ROBIN_PERMISSION:
                                if (!item.is_blocked)
                                    b << uint8(LOOT_SLOT_TYPE_ALLOW_LOOT);
                                else
                                    b << uint8(LOOT_SLOT_TYPE_ROLL_ONGOING);
                                break;
                            default:
                                b << uint8(slotType);
                                break;
                        }
                    }
                    else if (!item.freeforall)
                        b << uint8(partySlotType);
                    else
                        b << uint8(slotType);
                }

                ++itemsShown;
            }
        }
    }

    QuestItemMap const& lootPlayerFFAItems = l.GetPlayerFFAItems();
    QuestItemMap::const_iterator ffa_itr = lootPlayerFFAItems.find(lv.viewer->GetGUID());
    if (ffa_itr != lootPlayerFFAItems.end())
    {
        QuestItemList* ffa_list = ffa_itr->second;
        for (QuestItemList::const_iterator fi = ffa_list->begin(); fi != ffa_list->end(); ++fi)
        {
            LootItem& item = l.items[fi->index];
            if (!fi->is_looted && !item.is_looted)
            {
                b << uint8(fi->index);
                b << item;
                // Xinef: Here are FFA items, so dont use owner permision
                b << uint8(LOOT_SLOT_TYPE_ALLOW_LOOT /*slotType*/);
                ++itemsShown;
            }
        }
    }

    QuestItemMap const& lootPlayerNonQuestNonFFAConditionalItems = l.GetPlayerNonQuestNonFFAConditionalItems();
    QuestItemMap::const_iterator nn_itr = lootPlayerNonQuestNonFFAConditionalItems.find(lv.viewer->GetGUID());
    if (nn_itr != lootPlayerNonQuestNonFFAConditionalItems.end())
    {
        QuestItemList* conditional_list = nn_itr->second;
        for (QuestItemList::const_iterator ci = conditional_list->begin(); ci != conditional_list->end(); ++ci)
        {
            LootItem& item = l.items[ci->index];
            if (!ci->is_looted && !item.is_looted)
            {
                b << uint8(ci->index);
                b << item;
                if (item.follow_loot_rules)
                {
                    switch (lv.permission)
                    {
                        case MASTER_PERMISSION:
                            b << uint8(LOOT_SLOT_TYPE_MASTER);
                            break;
                        case RESTRICTED_PERMISSION:
                            b << (item.is_blocked ? uint8(LOOT_SLOT_TYPE_LOCKED) : uint8(slotType));
                            break;
                        case GROUP_PERMISSION:
                        case ROUND_ROBIN_PERMISSION:
                            if (!item.is_blocked)
                                b << uint8(LOOT_SLOT_TYPE_ALLOW_LOOT);
                            else
                                b << uint8(LOOT_SLOT_TYPE_ROLL_ONGOING);
                            break;
                        default:
                            b << uint8(slotType);
                            break;
                    }
                }
                else if (!item.freeforall)
                    b << uint8(partySlotType);
                else
                    b << uint8(slotType);
                ++itemsShown;
            }
        }
    }

    //update number of items shown
    b.put<uint8>(count_pos, itemsShown);

    return b;
}

//
// --------- LootTemplate::LootGroup ---------
//

LootTemplate::LootGroup::~LootGroup()
{
    while (!ExplicitlyChanced.empty())
    {
        delete ExplicitlyChanced.back();
        ExplicitlyChanced.pop_back();
    }

    while (!EqualChanced.empty())
    {
        delete EqualChanced.back();
        EqualChanced.pop_back();
    }
}

// Adds an entry to the group (at loading stage)
void LootTemplate::LootGroup::AddEntry(LootStoreItem* item)
{
    if (item->chance != 0)
        ExplicitlyChanced.push_back(item);
    else
        EqualChanced.push_back(item);
}

// Rolls an item from the group, returns nullptr if all miss their chances
LootStoreItem const* LootTemplate::LootGroup::Roll(Loot& loot, Player const* player, LootStore const& store, uint16 lootMode) const
{
    LootStoreItemList possibleLoot = ExplicitlyChanced;
    possibleLoot.remove_if(LootGroupInvalidSelector(loot, lootMode));

    if (!possibleLoot.empty())                             // First explicitly chanced entries are checked
    {
        float roll = (float)rand_chance();

        for (LootStoreItemList::const_iterator itr = possibleLoot.begin(); itr != possibleLoot.end(); ++itr)   // check each explicitly chanced entry in the template and modify its chance based on quality.
        {
            LootStoreItem* item = *itr;
            float chance = item->chance;

            if (!sScriptMgr->OnItemRoll(player, item, chance, loot, store))
                return nullptr;

            if (chance >= 100.0f)
                return item;

            roll -= chance;
            if (roll < 0)
                return item;
        }
    }

    if (!sScriptMgr->OnBeforeLootEqualChanced(player, EqualChanced, loot, store))
        return nullptr;

    possibleLoot = EqualChanced;
    possibleLoot.remove_if(LootGroupInvalidSelector(loot, lootMode));
    if (!possibleLoot.empty())                              // If nothing selected yet - an item is taken from equal-chanced part
        return Acore::Containers::SelectRandomContainerElement(possibleLoot);

    return nullptr;                                            // Empty drop from the group
}

// True if group includes at least 1 quest drop entry
bool LootTemplate::LootGroup::HasQuestDrop(LootTemplateMap const& store) const
{
    for (LootStoreItemList::const_iterator i = ExplicitlyChanced.begin(); i != ExplicitlyChanced.end(); ++i)
    {
        LootStoreItem* item = *i;
        if (item->reference) // References
        {
            LootTemplateMap::const_iterator Referenced = store.find(std::abs(item->reference));
            if (Referenced == store.end())
            {
                continue; // Error message [should be] already printed at loading stage
            }

            if (Referenced->second->HasQuestDrop(store, item->groupid))
            {
                return true;
            }
        }
        else if (item->needs_quest)
        {
            return true;
        }
    }

    for (LootStoreItemList::const_iterator i = EqualChanced.begin(); i != EqualChanced.end(); ++i)
    {
        LootStoreItem* item = *i;
        if (item->reference) // References
        {
            LootTemplateMap::const_iterator Referenced = store.find(std::abs(item->reference));
            if (Referenced == store.end())
            {
                continue; // Error message [should be] already printed at loading stage
            }

            if (Referenced->second->HasQuestDrop(store, item->groupid))
            {
                return true;
            }
        }
        else if (item->needs_quest)
        {
            return true;
        }
    }

    return false;
}

// True if group includes at least 1 quest drop entry for active quests of the player
bool LootTemplate::LootGroup::HasQuestDropForPlayer(Player const* player, LootTemplateMap const& store) const
{
    for (LootStoreItemList::const_iterator i = ExplicitlyChanced.begin(); i != ExplicitlyChanced.end(); ++i)
    {
        LootStoreItem* item = *i;
        if (item->reference)                        // References processing
        {
            LootTemplateMap::const_iterator Referenced = store.find(std::abs(item->reference));
            if (Referenced == store.end())
            {
                continue;                                   // Error message already printed at loading stage
            }

            if (Referenced->second->HasQuestDropForPlayer(store, player, item->groupid))
            {
                return true;
            }
        }
        else if (player->HasQuestForItem(item->itemid))
        {
            return true;                                    // active quest drop found
        }
    }

    for (LootStoreItemList::const_iterator i = EqualChanced.begin(); i != EqualChanced.end(); ++i)
    {
        LootStoreItem* item = *i;
        if (item->reference)                        // References processing
        {
            LootTemplateMap::const_iterator Referenced = store.find(std::abs(item->reference));
            if (Referenced == store.end())
            {
                continue;                                   // Error message already printed at loading stage
            }

            if (Referenced->second->HasQuestDropForPlayer(store, player, item->groupid))
            {
                return true;
            }
        }
        else if (player->HasQuestForItem(item->itemid))
        {
            return true;                                    // active quest drop found
        }
    }

    return false;
}

void LootTemplate::LootGroup::CopyConditions(ConditionList /*conditions*/)
{
    for (LootStoreItemList::iterator i = ExplicitlyChanced.begin(); i != ExplicitlyChanced.end(); ++i)
        (*i)->conditions.clear();

    for (LootStoreItemList::iterator i = EqualChanced.begin(); i != EqualChanced.end(); ++i)
        (*i)->conditions.clear();
}

// Rolls an item from the group (if any takes its chance) and adds the item to the loot
void LootTemplate::LootGroup::Process(Loot& loot, Player const* player, LootStore const& store, uint16 lootMode, uint16 nonRefIterationsLeft) const
{
    if (LootStoreItem const* item = Roll(loot, player, store, lootMode))
    {
        bool rate = store.IsRatesAllowed();

        if (item->reference) // References processing
        {
            if (LootTemplate const* Referenced = LootTemplates_Reference.GetLootFor(std::abs(item->reference)))
            {
                uint32 maxcount = uint32(float(item->maxcount) * sWorld->getRate(RATE_DROP_ITEM_REFERENCED_AMOUNT));
                sScriptMgr->OnAfterRefCount(player, loot, rate, lootMode, const_cast<LootStoreItem*>(item), maxcount, store);
                for (uint32 loop = 0; loop < maxcount; ++loop) // Ref multiplicator
                    // This reference needs to be processed further, but it is marked isTopLevel=false so that any groups inside
                    // the reference are not multiplied by Rate.Drop.Item.GroupAmount
                    Referenced->Process(loot, store, lootMode, player, item->groupid, false);
            }
        }
        else
        {
            // Plain entries (not a reference, not grouped)
            sScriptMgr->OnBeforeDropAddItem(player, loot, rate, lootMode, const_cast<LootStoreItem*>(item), store);
            loot.AddItem(*item); // Chance is already checked, just add

            // If we still have non-ref runs to do for this group AND this item wasn't a reference,
            // recursively call this function to produce more items for this group.
            // However, if this is a quest item we shouldn't multiply this group.
            if (nonRefIterationsLeft > 1 && !item->needs_quest)
            {
                this->Process(loot, player, store, lootMode, nonRefIterationsLeft-1);
            }
        }
    }
}

// Overall chance for the group without equal chanced items
float LootTemplate::LootGroup::RawTotalChance() const
{
    float result = 0;

    for (LootStoreItemList::const_iterator i = ExplicitlyChanced.begin(); i != ExplicitlyChanced.end(); ++i)
        if (!(*i)->needs_quest)
            result += (*i)->chance;

    return result;
}

// Overall chance for the group
float LootTemplate::LootGroup::TotalChance() const
{
    float result = RawTotalChance();

    if (!EqualChanced.empty() && result < 100.0f)
        return 100.0f;

    return result;
}

void LootTemplate::LootGroup::Verify(LootStore const& lootstore, uint32 id, uint8 group_id) const
{
    float chance = RawTotalChance();
    if (chance > 101.0f)                                    /// @todo: replace with 100% when DBs will be ready
    {
        LOG_ERROR("sql.sql", "Table '{}' entry {} group {} has total chance > 100% ({})", lootstore.GetName(), id, group_id, chance);
    }

    if (chance >= 100.0f && !EqualChanced.empty())
    {
        LOG_ERROR("sql.sql", "Table '{}' entry {} group {} has items with chance=0% but group total chance >= 100% ({})", lootstore.GetName(), id, group_id, chance);
    }
}

void LootTemplate::LootGroup::CheckLootRefs(LootTemplateMap const& /*store*/, LootIdSet* ref_set) const
{
    for (LootStoreItemList::const_iterator ieItr = ExplicitlyChanced.begin(); ieItr != ExplicitlyChanced.end(); ++ieItr)
    {
        LootStoreItem* item = *ieItr;
        if (item->reference)
        {
            if (!LootTemplates_Reference.GetLootFor(std::abs(item->reference)))
            {
                LootTemplates_Reference.ReportNonExistingId(std::abs(item->reference), "Reference", item->itemid);
            }
            else if (ref_set)
            {
                ref_set->erase(std::abs(item->reference));
            }
        }
    }

    for (LootStoreItemList::const_iterator ieItr = EqualChanced.begin(); ieItr != EqualChanced.end(); ++ieItr)
    {
        LootStoreItem* item = *ieItr;
        if (item->reference)
        {
            if (!LootTemplates_Reference.GetLootFor(std::abs(item->reference)))
            {
                LootTemplates_Reference.ReportNonExistingId(std::abs(item->reference), "Reference", item->itemid);
            }
            else if (ref_set)
            {
                ref_set->erase(std::abs(item->reference));
            }
        }
    }
}

//
// --------- LootTemplate ---------
//

LootTemplate::~LootTemplate()
{
    while (!Entries.empty())
    {
        delete Entries.back();
        Entries.pop_back();
    }

    for (size_t i = 0; i < Groups.size(); ++i)
        delete Groups[i];
    Groups.clear();
}

// Adds an entry to the group (at loading stage)
void LootTemplate::AddEntry(LootStoreItem* item)
{
    // `item->reference` > 0 --> Reference is counted as a normal and non grouped entry
    // `item->reference` < 0 --> Reference is counted as grouped entry within shared groupid
    if (item->groupid > 0 && item->reference <= 0)  // Group and grouped reference
    {
        if (item->groupid >= Groups.size())
        {
            Groups.resize(item->groupid, nullptr);  // Adds new group the the loot template if needed
        }

        if (!Groups[item->groupid - 1])
        {
            Groups[item->groupid - 1] = new LootGroup();
        }

        Groups[item->groupid - 1]->AddEntry(item);  // Adds new entry to the group
    }
    else                                            // Non-grouped entries
        Entries.push_back(item);
}

void LootTemplate::CopyConditions(ConditionList conditions)
{
    for (LootStoreItemList::iterator i = Entries.begin(); i != Entries.end(); ++i)
        (*i)->conditions.clear();

    for (LootGroups::iterator i = Groups.begin(); i != Groups.end(); ++i)
        if (LootGroup* group = *i)
            group->CopyConditions(conditions);
}

bool LootTemplate::CopyConditions(LootItem* li, uint32 conditionLootId) const
{
    for (LootStoreItemList::const_iterator _iter = Entries.begin(); _iter != Entries.end(); ++_iter)
    {
        LootStoreItem* item = *_iter;
        if (item->reference)
        {
            if (LootTemplate const* Referenced = LootTemplates_Reference.GetLootFor(std::abs(item->reference)))
            {
                if (Referenced->CopyConditions(li, conditionLootId))
                {
                    return true;
                }
            }
        }
        else
        {
            if (item->itemid != li->itemid)
            {
                continue;
            }

            if (!item->conditions.empty() && conditionLootId && conditionLootId != item->conditions.front()->SourceGroup)
            {
                continue;
            }

            li->conditions = item->conditions;
            return true;
        }
    }

    for (LootGroups::const_iterator groupItr = Groups.begin(); groupItr != Groups.end(); ++groupItr)
    {
        LootGroup* group = *groupItr;
        if (!group)
            continue;

        LootStoreItemList* itemList = group->GetExplicitlyChancedItemList();
        for (LootStoreItemList::iterator i = itemList->begin(); i != itemList->end(); ++i)
        {
            LootStoreItem* item = *i;
            if (item->reference)
            {
                if (LootTemplate const* Referenced = LootTemplates_Reference.GetLootFor(std::abs(item->reference)))
                {
                    if (Referenced->CopyConditions(li, conditionLootId))
                    {
                        return true;
                    }
                }
            }
            else
            {
                if (item->itemid != li->itemid)
                {
                    continue;
                }

                if (!item->conditions.empty() && conditionLootId && conditionLootId != item->conditions.front()->SourceGroup)
                {
                    continue;
                }

                li->conditions = item->conditions;
                return true;
            }
        }

        itemList = group->GetEqualChancedItemList();
        for (LootStoreItemList::iterator i = itemList->begin(); i != itemList->end(); ++i)
        {
            LootStoreItem* item = *i;
            if (item->reference)
            {
                if (LootTemplate const* Referenced = LootTemplates_Reference.GetLootFor(std::abs(item->reference)))
                {
                    if (Referenced->CopyConditions(li, conditionLootId))
                    {
                        return true;
                    }
                }
            }
            else
            {
                if (item->itemid != li->itemid)
                {
                    continue;
                }

                if (!item->conditions.empty() && conditionLootId && conditionLootId != item->conditions.front()->SourceGroup)
                {
                    continue;
                }

                li->conditions = item->conditions;
                return true;
            }
        }
    }

    return false;
}

// Rolls for every item in the template and adds the rolled items the the loot
void LootTemplate::Process(Loot& loot, LootStore const& store, uint16 lootMode, Player const* player, uint8 groupId, bool isTopLevel) const
{
    bool rate = store.IsRatesAllowed();

    if (groupId)                                            // Group reference uses own processing of the group
    {
        if (groupId > Groups.size())
            return;                                         // Error message already printed at loading stage

        if (!Groups[groupId - 1])
            return;

        // Rate.Drop.Item.GroupAmount is only in effect for the top loot template level
        if (isTopLevel)
        {
            Groups[groupId - 1]->Process(loot, player, store, lootMode, sWorld->getRate(RATE_DROP_ITEM_GROUP_AMOUNT));
        }
        else
        {
            Groups[groupId - 1]->Process(loot, player, store, lootMode, 0);
        }
        return;
    }

    // Rolling non-grouped items
    for (LootStoreItemList::const_iterator i = Entries.begin(); i != Entries.end(); ++i)
    {
        LootStoreItem* item = *i;
        if (!(item->lootmode & lootMode))                         // Do not add if mode mismatch
            continue;
        if (!item->Roll(rate, player, loot, store))
            continue;                                           // Bad luck for the entry

        if (item->reference)                                    // References processing
        {
            LootTemplate const* Referenced = LootTemplates_Reference.GetLootFor(std::abs(item->reference));
            if (!Referenced)
                continue;                                       // Error message already printed at loading stage

            uint32 maxcount = uint32(float(item->maxcount) * sWorld->getRate(RATE_DROP_ITEM_REFERENCED_AMOUNT));
            sScriptMgr->OnAfterRefCount(player, loot, rate, lootMode, item, maxcount, store);
            for (uint32 loop = 0; loop < maxcount; ++loop)      // Ref multiplicator
                // we're no longer in the top level, so isTopLevel is false
                Referenced->Process(loot, store, lootMode, player, item->groupid, false);
        }
        else
        {
            // Plain entries (not a reference, not grouped)
            sScriptMgr->OnBeforeDropAddItem(player, loot, rate, lootMode, item, store);
            loot.AddItem(*item);                                // Chance is already checked, just add
        }
    }

    // Now processing groups
    for (LootGroups::const_iterator i = Groups.begin(); i != Groups.end(); ++i)
        if (LootGroup* group = *i)
        {
            // Rate.Drop.Item.GroupAmount is only in effect for the top loot template level
            if (isTopLevel)
            {
                uint32 groupAmount = sWorld->getRate(RATE_DROP_ITEM_GROUP_AMOUNT);
                sScriptMgr->OnAfterCalculateLootGroupAmount(player, loot, lootMode, groupAmount, store);
                group->Process(loot, player, store, lootMode, groupAmount);
            }
            else
            {
                group->Process(loot, player, store, lootMode, 0);
            }
        }
}

// True if template includes at least 1 quest drop entry
bool LootTemplate::HasQuestDrop(LootTemplateMap const& store, uint8 groupId) const
{
    if (groupId)                                            // Group reference
    {
        if (groupId > Groups.size())
            return false;                                   // Error message [should be] already printed at loading stage

        if (!Groups[groupId - 1])
            return false;

        return Groups[groupId - 1]->HasQuestDrop(store);
    }

    for (LootStoreItemList::const_iterator i = Entries.begin(); i != Entries.end(); ++i)
    {
        LootStoreItem* item = *i;
        if (item->reference)                                // References
        {
            LootTemplateMap::const_iterator Referenced = store.find(std::abs(item->reference));
            if (Referenced == store.end())
                continue;                                   // Error message [should be] already printed at loading stage

            if (Referenced->second->HasQuestDrop(store, item->groupid))
                return true;
        }
        else if (item->needs_quest)
            return true;                                    // quest drop found
    }

    // Now processing groups
    for (LootGroups::const_iterator i = Groups.begin(); i != Groups.end(); ++i)
    {
        if (LootGroup* group = *i)
        {
            if (group->HasQuestDrop(store))
            {
                return true;
            }
        }
    }

    return false;
}

// True if template includes at least 1 quest drop for an active quest of the player
bool LootTemplate::HasQuestDropForPlayer(LootTemplateMap const& store, Player const* player, uint8 groupId) const
{
    if (groupId)                                            // Group reference
    {
        if (groupId > Groups.size())
            return false;                                   // Error message already printed at loading stage

        if (!Groups[groupId - 1])
            return false;

        return Groups[groupId - 1]->HasQuestDropForPlayer(player, store);
    }

    // Checking non-grouped entries
    for (LootStoreItemList::const_iterator i = Entries.begin(); i != Entries.end(); ++i)
    {
        LootStoreItem* item = *i;
        if (item->reference)                                // References processing
        {
            LootTemplateMap::const_iterator Referenced = store.find(std::abs(item->reference));
            if (Referenced == store.end())
                continue;                                   // Error message already printed at loading stage
            if (Referenced->second->HasQuestDropForPlayer(store, player, item->groupid))
                return true;
        }
        else if (player->HasQuestForItem(item->itemid))
            return true;                                    // active quest drop found
    }

    // Now checking groups
    for (LootGroups::const_iterator i = Groups.begin(); i != Groups.end(); ++i)
    {
        if (LootGroup* group = *i)
        {
            if (group->HasQuestDropForPlayer(player, store))
            {
                return true;
            }
        }
    }

    return false;
}

// Checks integrity of the template
void LootTemplate::Verify(LootStore const& lootstore, uint32 id) const
{
    // Checking group chances
    for (uint32 i = 0; i < Groups.size(); ++i)
        if (Groups[i])
            Groups[i]->Verify(lootstore, id, i + 1);

    /// @todo: References validity checks
}

void LootTemplate::CheckLootRefs(LootTemplateMap const& store, LootIdSet* ref_set) const
{
    for (LootStoreItemList::const_iterator ieItr = Entries.begin(); ieItr != Entries.end(); ++ieItr)
    {
        LootStoreItem* item = *ieItr;
        if (item->reference)
        {
            if (!LootTemplates_Reference.GetLootFor(std::abs(item->reference)))
            {
                LootTemplates_Reference.ReportNonExistingId(std::abs(item->reference), "Reference", item->itemid);
            }
            else if (ref_set)
            {
                ref_set->erase(std::abs(item->reference));
            }
        }
    }

    for (LootGroups::const_iterator grItr = Groups.begin(); grItr != Groups.end(); ++grItr)
        if (LootGroup* group = *grItr)
            group->CheckLootRefs(store, ref_set);
}

bool LootTemplate::addConditionItem(Condition* cond)
{
    if (!cond || !cond->isLoaded())//should never happen, checked at loading
    {
        LOG_ERROR("condition", "LootTemplate::addConditionItem: condition is null");
        return false;
    }

    if (!Entries.empty())
    {
        for (LootStoreItemList::iterator i = Entries.begin(); i != Entries.end(); ++i)
        {
            if ((*i)->itemid == uint32(cond->SourceEntry))
            {
                (*i)->conditions.push_back(cond);
                return true;
            }
        }
    }

    if (!Groups.empty())
    {
        for (LootGroups::iterator groupItr = Groups.begin(); groupItr != Groups.end(); ++groupItr)
        {
            LootGroup* group = *groupItr;
            if (!group)
                continue;

            LootStoreItemList* itemList = group->GetExplicitlyChancedItemList();
            if (!itemList->empty())
            {
                for (LootStoreItemList::iterator i = itemList->begin(); i != itemList->end(); ++i)
                {
                    if ((*i)->itemid == uint32(cond->SourceEntry))
                    {
                        (*i)->conditions.push_back(cond);
                        return true;
                    }
                }
            }

            itemList = group->GetEqualChancedItemList();
            if (!itemList->empty())
            {
                for (LootStoreItemList::iterator i = itemList->begin(); i != itemList->end(); ++i)
                {
                    if ((*i)->itemid == uint32(cond->SourceEntry))
                    {
                        (*i)->conditions.push_back(cond);
                        return true;
                    }
                }
            }
        }
    }
    return false;
}

bool LootTemplate::isReference(uint32 id) const
{
    for (LootStoreItemList::const_iterator ieItr = Entries.begin(); ieItr != Entries.end(); ++ieItr)
    {
        if ((*ieItr)->itemid == id && (*ieItr)->reference)
        {
            return true;
        }
    }

    return false;//not found or not reference
}

void LoadLootTemplates_Creature()
{
    LOG_INFO("server.loading", "Loading Creature Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet, lootIdSetUsed;
    uint32 count = LootTemplates_Creature.LoadAndCollectLootIds(lootIdSet);

    // Remove real entries and check loot existence
    CreatureTemplateContainer const* ctc = sObjectMgr->GetCreatureTemplates();
    for (CreatureTemplateContainer::const_iterator itr = ctc->begin(); itr != ctc->end(); ++itr)
    {
        if (uint32 lootid = itr->second.lootid)
        {
            if (lootIdSet.find(lootid) == lootIdSet.end())
                LootTemplates_Creature.ReportNonExistingId(lootid, "Creature", itr->second.Entry);
            else
                lootIdSetUsed.insert(lootid);
        }
    }

    for (LootIdSet::const_iterator itr = lootIdSetUsed.begin(); itr != lootIdSetUsed.end(); ++itr)
        lootIdSet.erase(*itr);

    // output error for any still listed (not referenced from appropriate table) ids
    LootTemplates_Creature.ReportUnusedIds(lootIdSet);

    if (count)
        LOG_INFO("server.loading", ">> Loaded {} Creature Loot Templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    else
        LOG_WARN("server.loading", ">> Loaded 0 creature loot templates. DB table `creature_loot_template` is empty");

    LOG_INFO("server.loading", " ");
}

void LoadLootTemplates_Disenchant()
{
    LOG_INFO("server.loading", "Loading Disenchanting Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet, lootIdSetUsed;
    uint32 count = LootTemplates_Disenchant.LoadAndCollectLootIds(lootIdSet);

    ItemTemplateContainer const* its = sObjectMgr->GetItemTemplateStore();
    for (ItemTemplateContainer::const_iterator itr = its->begin(); itr != its->end(); ++itr)
    {
        if (uint32 lootid = itr->second.DisenchantID)
        {
            if (lootIdSet.find(lootid) == lootIdSet.end())
                LootTemplates_Disenchant.ReportNonExistingId(lootid);
            else
                lootIdSetUsed.insert(lootid);
        }
    }

    for (LootIdSet::const_iterator itr = lootIdSetUsed.begin(); itr != lootIdSetUsed.end(); ++itr)
        lootIdSet.erase(*itr);

    // output error for any still listed (not referenced from appropriate table) ids
    LootTemplates_Disenchant.ReportUnusedIds(lootIdSet);

    if (count)
        LOG_INFO("server.loading", ">> Loaded {} disenchanting loot templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    else
        LOG_WARN("server.loading", ">> Loaded 0 disenchanting loot templates. DB table `disenchant_loot_template` is empty");
    LOG_INFO("server.loading", " ");
}

void LoadLootTemplates_Fishing()
{
    LOG_INFO("server.loading", "Loading Fishing Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet;
    uint32 count = LootTemplates_Fishing.LoadAndCollectLootIds(lootIdSet);

    // remove real entries and check existence loot
    for (uint32 i = 1; i < sAreaTableStore.GetNumRows(); ++i)
        if (AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(i))
            if (lootIdSet.find(areaEntry->ID) != lootIdSet.end())
                lootIdSet.erase(areaEntry->ID);

    // output error for any still listed (not referenced from appropriate table) ids
    LootTemplates_Fishing.ReportUnusedIds(lootIdSet);

    if (count)
        LOG_INFO("server.loading", ">> Loaded {} Fishing Loot Templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    else
        LOG_WARN("server.loading", ">> Loaded 0 fishing loot templates. DB table `fishing_loot_template` is empty");

    LOG_INFO("server.loading", " ");
}

void LoadLootTemplates_Gameobject()
{
    LOG_INFO("server.loading", "Loading Gameobject Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet, lootIdSetUsed;
    uint32 count = LootTemplates_Gameobject.LoadAndCollectLootIds(lootIdSet);

    // remove real entries and check existence loot
    GameObjectTemplateContainer const* gotc = sObjectMgr->GetGameObjectTemplates();
    for (GameObjectTemplateContainer::const_iterator itr = gotc->begin(); itr != gotc->end(); ++itr)
    {
        if (uint32 lootid = itr->second.GetLootId())
        {
            if (lootIdSet.find(lootid) == lootIdSet.end())
                LootTemplates_Gameobject.ReportNonExistingId(lootid, "Gameobject", itr->second.entry);
            else
                lootIdSetUsed.insert(lootid);
        }
    }

    for (LootIdSet::const_iterator itr = lootIdSetUsed.begin(); itr != lootIdSetUsed.end(); ++itr)
        lootIdSet.erase(*itr);

    // output error for any still listed (not referenced from appropriate table) ids
    LootTemplates_Gameobject.ReportUnusedIds(lootIdSet);

    if (count)
        LOG_INFO("server.loading", ">> Loaded {} Gameobject Loot Templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    else
        LOG_WARN("server.loading", ">> Loaded 0 gameobject loot templates. DB table `gameobject_loot_template` is empty");

    LOG_INFO("server.loading", " ");
}

void LoadLootTemplates_Item()
{
    LOG_INFO("server.loading", "Loading Item Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet;
    uint32 count = LootTemplates_Item.LoadAndCollectLootIds(lootIdSet);

    // remove real entries and check existence loot
    ItemTemplateContainer const* its = sObjectMgr->GetItemTemplateStore();
    for (ItemTemplateContainer::const_iterator itr = its->begin(); itr != its->end(); ++itr)
        if (lootIdSet.find(itr->second.ItemId) != lootIdSet.end() && itr->second.Flags & ITEM_FLAG_HAS_LOOT)
            lootIdSet.erase(itr->second.ItemId);

    // output error for any still listed (not referenced from appropriate table) ids
    LootTemplates_Item.ReportUnusedIds(lootIdSet);

    if (count)
        LOG_INFO("server.loading", ">> Loaded {} item loot templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    else
        LOG_WARN("server.loading", ">> Loaded 0 item loot templates. DB table `item_loot_template` is empty");

    LOG_INFO("server.loading", " ");
}

void LoadLootTemplates_Milling()
{
    LOG_INFO("server.loading", "Loading Milling Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet;
    uint32 count = LootTemplates_Milling.LoadAndCollectLootIds(lootIdSet);

    // remove real entries and check existence loot
    ItemTemplateContainer const* its = sObjectMgr->GetItemTemplateStore();
    for (ItemTemplateContainer::const_iterator itr = its->begin(); itr != its->end(); ++itr)
    {
        if (!(itr->second.Flags & ITEM_FLAG_IS_MILLABLE))
            continue;

        if (lootIdSet.find(itr->second.ItemId) != lootIdSet.end())
            lootIdSet.erase(itr->second.ItemId);
    }

    // output error for any still listed (not referenced from appropriate table) ids
    LootTemplates_Milling.ReportUnusedIds(lootIdSet);

    if (count)
        LOG_INFO("server.loading", ">> Loaded {} milling loot templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    else
        LOG_WARN("server.loading", ">> Loaded 0 milling loot templates. DB table `milling_loot_template` is empty");

    LOG_INFO("server.loading", " ");
}

void LoadLootTemplates_Pickpocketing()
{
    LOG_INFO("server.loading", "Loading Pickpocketing Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet, lootIdSetUsed;
    uint32 count = LootTemplates_Pickpocketing.LoadAndCollectLootIds(lootIdSet);

    // Remove real entries and check loot existence
    CreatureTemplateContainer const* ctc = sObjectMgr->GetCreatureTemplates();
    for (CreatureTemplateContainer::const_iterator itr = ctc->begin(); itr != ctc->end(); ++itr)
    {
        if (uint32 lootid = itr->second.pickpocketLootId)
        {
            if (lootIdSet.find(lootid) == lootIdSet.end())
                LootTemplates_Pickpocketing.ReportNonExistingId(lootid, "Creature", itr->second.Entry);
            else
                lootIdSetUsed.insert(lootid);
        }
    }

    for (LootIdSet::const_iterator itr = lootIdSetUsed.begin(); itr != lootIdSetUsed.end(); ++itr)
        lootIdSet.erase(*itr);

    // output error for any still listed (not referenced from appropriate table) ids
    LootTemplates_Pickpocketing.ReportUnusedIds(lootIdSet);

    if (count)
        LOG_INFO("server.loading", ">> Loaded {} pickpocketing loot templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    else
        LOG_WARN("server.loading", ">> Loaded 0 pickpocketing loot templates. DB table `pickpocketing_loot_template` is empty");

    LOG_INFO("server.loading", " ");
}

void LoadLootTemplates_Prospecting()
{
    LOG_INFO("server.loading", "Loading Prospecting Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet;
    uint32 count = LootTemplates_Prospecting.LoadAndCollectLootIds(lootIdSet);

    // remove real entries and check existence loot
    ItemTemplateContainer const* its = sObjectMgr->GetItemTemplateStore();
    for (ItemTemplateContainer::const_iterator itr = its->begin(); itr != its->end(); ++itr)
    {
        if (!(itr->second.Flags & ITEM_FLAG_IS_PROSPECTABLE))
            continue;

        if (lootIdSet.find(itr->second.ItemId) != lootIdSet.end())
            lootIdSet.erase(itr->second.ItemId);
    }

    // output error for any still listed (not referenced from appropriate table) ids
    LootTemplates_Prospecting.ReportUnusedIds(lootIdSet);

    if (count)
        LOG_INFO("server.loading", ">> Loaded {} prospecting loot templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    else
        LOG_WARN("server.loading", ">> Loaded 0 prospecting loot templates. DB table `prospecting_loot_template` is empty");

    LOG_INFO("server.loading", " ");
}

void LoadLootTemplates_Mail()
{
    LOG_INFO("server.loading", "Loading Mail Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet;
    uint32 count = LootTemplates_Mail.LoadAndCollectLootIds(lootIdSet);

    // remove real entries and check existence loot
    for (uint32 i = 1; i < sMailTemplateStore.GetNumRows(); ++i)
        if (sMailTemplateStore.LookupEntry(i))
            if (lootIdSet.find(i) != lootIdSet.end())
                lootIdSet.erase(i);

    // output error for any still listed (not referenced from appropriate table) ids
    LootTemplates_Mail.ReportUnusedIds(lootIdSet);

    if (count)
        LOG_INFO("server.loading", ">> Loaded {} mail loot templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    else
        LOG_WARN("server.loading", ">> Loaded 0 mail loot templates. DB table `mail_loot_template` is empty");

    LOG_INFO("server.loading", " ");
}

void LoadLootTemplates_Skinning()
{
    LOG_INFO("server.loading", "Loading Skinning Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet, lootIdSetUsed;
    uint32 count = LootTemplates_Skinning.LoadAndCollectLootIds(lootIdSet);

    // remove real entries and check existence loot
    CreatureTemplateContainer const* ctc = sObjectMgr->GetCreatureTemplates();
    for (CreatureTemplateContainer::const_iterator itr = ctc->begin(); itr != ctc->end(); ++itr)
    {
        if (uint32 lootid = itr->second.SkinLootId)
        {
            if (lootIdSet.find(lootid) == lootIdSet.end())
                LootTemplates_Skinning.ReportNonExistingId(lootid, "Creature", itr->second.Entry);
            else
                lootIdSetUsed.insert(lootid);
        }
    }

    for (LootIdSet::const_iterator itr = lootIdSetUsed.begin(); itr != lootIdSetUsed.end(); ++itr)
        lootIdSet.erase(*itr);

    // output error for any still listed (not referenced from appropriate table) ids
    LootTemplates_Skinning.ReportUnusedIds(lootIdSet);

    if (count)
        LOG_INFO("server.loading", ">> Loaded {} skinning loot templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    else
        LOG_WARN("server.loading", ">> Loaded 0 skinning loot templates. DB table `skinning_loot_template` is empty");

    LOG_INFO("server.loading", " ");
}

void LoadLootTemplates_Spell()
{
    LOG_INFO("server.loading", "Loading Spell Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet;
    uint32 count = LootTemplates_Spell.LoadAndCollectLootIds(lootIdSet);

    // remove real entries and check existence loot
    for (uint32 spell_id = 1; spell_id < sSpellMgr->GetSpellInfoStoreSize(); ++spell_id)
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell_id);
        if (!spellInfo)
            continue;

        // possible cases
        if (!spellInfo->IsLootCrafting())
            continue;

        if (lootIdSet.find(spell_id) == lootIdSet.end())
        {
            // not report about not trainable spells (optionally supported by DB)
            // ignore 61756 (Northrend Inscription Research (FAST QA VERSION) for example
            if (!spellInfo->HasAttribute(SPELL_ATTR0_NOT_SHAPESHIFTED) || spellInfo->HasAttribute(SPELL_ATTR0_IS_TRADESKILL))
            {
                LootTemplates_Spell.ReportNonExistingId(spell_id, "Spell", spellInfo->Id);
            }
        }
        else
            lootIdSet.erase(spell_id);
    }

    // output error for any still listed (not referenced from appropriate table) ids
    LootTemplates_Spell.ReportUnusedIds(lootIdSet);

    if (count)
        LOG_INFO("server.loading", ">> Loaded {} spell loot templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    else
        LOG_WARN("server.loading", ">> Loaded 0 spell loot templates. DB table `spell_loot_template` is empty");
    LOG_INFO("server.loading", " ");
}

void LoadLootTemplates_Player()
{
    LOG_INFO("server.loading", "Loading Player Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet;
    uint32 count = LootTemplates_Player.LoadAndCollectLootIds(lootIdSet);

    if (count)
    {
        LOG_INFO("server.loading", ">> Loaded {} player loot templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    }
    else
    {
        LOG_WARN("server.loading", ">> Loaded 0 player loot templates. DB table `player_loot_template` is empty");
    }

    LOG_INFO("server.loading", " ");
}

void LoadLootTemplates_Reference()
{
    LOG_INFO("server.loading", "Loading Reference Loot Templates...");

    uint32 oldMSTime = getMSTime();

    LootIdSet lootIdSet;
    LootTemplates_Reference.LoadAndCollectLootIds(lootIdSet);

    // check references and remove used
    LootTemplates_Creature.CheckLootRefs(&lootIdSet);
    LootTemplates_Fishing.CheckLootRefs(&lootIdSet);
    LootTemplates_Gameobject.CheckLootRefs(&lootIdSet);
    LootTemplates_Item.CheckLootRefs(&lootIdSet);
    LootTemplates_Milling.CheckLootRefs(&lootIdSet);
    LootTemplates_Pickpocketing.CheckLootRefs(&lootIdSet);
    LootTemplates_Skinning.CheckLootRefs(&lootIdSet);
    LootTemplates_Disenchant.CheckLootRefs(&lootIdSet);
    LootTemplates_Prospecting.CheckLootRefs(&lootIdSet);
    LootTemplates_Mail.CheckLootRefs(&lootIdSet);
    LootTemplates_Reference.CheckLootRefs(&lootIdSet);

    // output error for any still listed ids (not referenced from any loot table)
    LootTemplates_Reference.ReportUnusedIds(lootIdSet);

    LOG_INFO("server.loading", ">> Loaded reference loot templates in {} ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}
