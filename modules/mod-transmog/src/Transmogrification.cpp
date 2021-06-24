#include "Transmogrification.h"

Transmogrification* Transmogrification::instance()
{
    static Transmogrification instance;
    return &instance;
}

#ifdef PRESETS
void Transmogrification::PresetTransmog(Player* player, Item* itemTransmogrified, uint32 fakeEntry, uint8 slot)
{
    LOG_DEBUG("modules", "Transmogrification::PresetTransmog");

    if (!EnableSets)
        return;
    if (!player || !itemTransmogrified)
        return;
    if (slot >= EQUIPMENT_SLOT_END)
        return;
    if (!CanTransmogrifyItemWithItem(player, itemTransmogrified->GetTemplate(), sObjectMgr->GetItemTemplate(fakeEntry)))
        return;

    // [AZTH] Custom
    if (GetFakeEntry(itemTransmogrified->GetGUID()))
        DeleteFakeEntry(player, slot, itemTransmogrified);

    SetFakeEntry(player, fakeEntry, slot, itemTransmogrified); // newEntry


    itemTransmogrified->UpdatePlayedTime(player);

    itemTransmogrified->SetOwnerGUID(player->GetGUID());
    itemTransmogrified->SetNotRefundable(player);
    itemTransmogrified->ClearSoulboundTradeable(player);
}

void Transmogrification::LoadPlayerSets(ObjectGuid pGUID)
{
    LOG_DEBUG("modules", "Transmogrification::LoadPlayerSets");

    for (presetData::iterator it = presetById[pGUID].begin(); it != presetById[pGUID].end(); ++it)
        it->second.clear();

    presetById[pGUID].clear();

    presetByName[pGUID].clear();

    QueryResult result = CharacterDatabase.PQuery("SELECT `PresetID`, `SetName`, `SetData` FROM `custom_transmogrification_sets` WHERE Owner = %u", pGUID.GetCounter());
    if (result)
    {
        do
        {
            uint8 PresetID = (*result)[0].GetUInt8();
            std::string SetName = (*result)[1].GetString();
            std::istringstream SetData((*result)[2].GetString());
            while (SetData.good())
            {
                uint32 slot;
                uint32 entry;
                SetData >> slot >> entry;
                if (SetData.fail())
                    break;
                if (slot >= EQUIPMENT_SLOT_END)
                {
                    sLog->outError("Item entry (FakeEntry: %u, player: %s, slot: %u, presetId: %u) has invalid slot, ignoring.", entry, pGUID.ToString().c_str(), slot, uint32(PresetID));
                    continue;
                }
                if (sObjectMgr->GetItemTemplate(entry))
                    presetById[pGUID][PresetID][slot] = entry; // Transmogrification::Preset(presetName, fakeEntry);
                                                               //else
                                                               //sLog->outError(LOG_FILTER_SQL, "Item entry (FakeEntry: %u, playerGUID: %u, slot: %u, presetId: %u) does not exist, ignoring.", entry, GUID_LOPART(pGUID), uint32(slot), uint32(PresetID));
            }

            if (!presetById[pGUID][PresetID].empty())
            {
                presetByName[pGUID][PresetID] = SetName;
                // load all presets anyways
                //if (presetByName[pGUID].size() >= GetMaxSets())
                //    break;
            }
            else // should be deleted on startup, so  this never runs (shouldnt..)
            {
                presetById[pGUID].erase(PresetID);
                CharacterDatabase.PExecute("DELETE FROM `custom_transmogrification_sets` WHERE Owner = %u AND PresetID = %u", pGUID.GetCounter(), PresetID);
            }
        } while (result->NextRow());
    }
}

bool Transmogrification::GetEnableSets() const
{
    return EnableSets;
}
uint8 Transmogrification::GetMaxSets() const
{
    return MaxSets;
}
float Transmogrification::GetSetCostModifier() const
{
    return SetCostModifier;
}
int32 Transmogrification::GetSetCopperCost() const
{
    return SetCopperCost;
}

void Transmogrification::UnloadPlayerSets(ObjectGuid pGUID)
{
    for (presetData::iterator it = presetById[pGUID].begin(); it != presetById[pGUID].end(); ++it)
        it->second.clear();
    presetById[pGUID].clear();

    presetByName[pGUID].clear();
}
#endif

const char* Transmogrification::GetSlotName(uint8 slot, WorldSession* /*session*/) const
{
    LOG_DEBUG("modules", "Transmogrification::GetSlotName");

    switch (slot)
    {
        case EQUIPMENT_SLOT_HEAD: return  "Head";// session->GetAcoreString(LANG_SLOT_NAME_HEAD);
        case EQUIPMENT_SLOT_SHOULDERS: return  "Shoulders";// session->GetAcoreString(LANG_SLOT_NAME_SHOULDERS);
        case EQUIPMENT_SLOT_BODY: return  "Shirt";// session->GetAcoreString(LANG_SLOT_NAME_BODY);
        case EQUIPMENT_SLOT_CHEST: return  "Chest";// session->GetAcoreString(LANG_SLOT_NAME_CHEST);
        case EQUIPMENT_SLOT_WAIST: return  "Waist";// session->GetAcoreString(LANG_SLOT_NAME_WAIST);
        case EQUIPMENT_SLOT_LEGS: return  "Legs";// session->GetAcoreString(LANG_SLOT_NAME_LEGS);
        case EQUIPMENT_SLOT_FEET: return  "Feet";// session->GetAcoreString(LANG_SLOT_NAME_FEET);
        case EQUIPMENT_SLOT_WRISTS: return  "Wrists";// session->GetAcoreString(LANG_SLOT_NAME_WRISTS);
        case EQUIPMENT_SLOT_HANDS: return  "Hands";// session->GetAcoreString(LANG_SLOT_NAME_HANDS);
        case EQUIPMENT_SLOT_BACK: return  "Back";// session->GetAcoreString(LANG_SLOT_NAME_BACK);
        case EQUIPMENT_SLOT_MAINHAND: return  "Main hand";// session->GetAcoreString(LANG_SLOT_NAME_MAINHAND);
        case EQUIPMENT_SLOT_OFFHAND: return  "Off hand";// session->GetAcoreString(LANG_SLOT_NAME_OFFHAND);
        case EQUIPMENT_SLOT_RANGED: return  "Ranged";// session->GetAcoreString(LANG_SLOT_NAME_RANGED);
        case EQUIPMENT_SLOT_TABARD: return  "Tabard";// session->GetAcoreString(LANG_SLOT_NAME_TABARD);
        default: return NULL;
    }
}

std::string Transmogrification::GetItemIcon(uint32 entry, uint32 width, uint32 height, int x, int y) const
{
    LOG_DEBUG("modules", "Transmogrification::GetItemIcon");

    std::ostringstream ss;
    ss << "|TInterface";
    const ItemTemplate* temp = sObjectMgr->GetItemTemplate(entry);
    const ItemDisplayInfoEntry* dispInfo = NULL;
    if (temp)
    {
        dispInfo = sItemDisplayInfoStore.LookupEntry(temp->DisplayInfoID);
        if (dispInfo)
            ss << "/ICONS/" << dispInfo->inventoryIcon;
    }
    if (!dispInfo)
        ss << "/InventoryItems/WoWUnknownItem01";
    ss << ":" << width << ":" << height << ":" << x << ":" << y << "|t";
    return ss.str();
}

std::string Transmogrification::GetSlotIcon(uint8 slot, uint32 width, uint32 height, int x, int y) const
{
    LOG_DEBUG("modules", "Transmogrification::GetSlotIcon");

    std::ostringstream ss;
    ss << "|TInterface/PaperDoll/";
    switch (slot)
    {
        case EQUIPMENT_SLOT_HEAD: ss << "UI-PaperDoll-Slot-Head"; break;
        case EQUIPMENT_SLOT_SHOULDERS: ss << "UI-PaperDoll-Slot-Shoulder"; break;
        case EQUIPMENT_SLOT_BODY: ss << "UI-PaperDoll-Slot-Shirt"; break;
        case EQUIPMENT_SLOT_CHEST: ss << "UI-PaperDoll-Slot-Chest"; break;
        case EQUIPMENT_SLOT_WAIST: ss << "UI-PaperDoll-Slot-Waist"; break;
        case EQUIPMENT_SLOT_LEGS: ss << "UI-PaperDoll-Slot-Legs"; break;
        case EQUIPMENT_SLOT_FEET: ss << "UI-PaperDoll-Slot-Feet"; break;
        case EQUIPMENT_SLOT_WRISTS: ss << "UI-PaperDoll-Slot-Wrists"; break;
        case EQUIPMENT_SLOT_HANDS: ss << "UI-PaperDoll-Slot-Hands"; break;
        case EQUIPMENT_SLOT_BACK: ss << "UI-PaperDoll-Slot-Chest"; break;
        case EQUIPMENT_SLOT_MAINHAND: ss << "UI-PaperDoll-Slot-MainHand"; break;
        case EQUIPMENT_SLOT_OFFHAND: ss << "UI-PaperDoll-Slot-SecondaryHand"; break;
        case EQUIPMENT_SLOT_RANGED: ss << "UI-PaperDoll-Slot-Ranged"; break;
        case EQUIPMENT_SLOT_TABARD: ss << "UI-PaperDoll-Slot-Tabard"; break;
        default: ss << "UI-Backpack-EmptySlot";
    }
    ss << ":" << width << ":" << height << ":" << x << ":" << y << "|t";
    return ss.str();
}

std::string Transmogrification::GetItemLink(Item* item, WorldSession* session) const
{
    LOG_DEBUG("modules", "Transmogrification::GetItemLink");

    int loc_idx = session->GetSessionDbLocaleIndex();
    const ItemTemplate* temp = item->GetTemplate();
    std::string name = temp->Name1;
    if (ItemLocale const* il = sObjectMgr->GetItemLocale(temp->ItemId))
        ObjectMgr::GetLocaleString(il->Name, loc_idx, name);

    if (int32 itemRandPropId = item->GetItemRandomPropertyId())
    {
        char* const* suffix = NULL;
        if (itemRandPropId < 0)
        {
            const ItemRandomSuffixEntry* itemRandEntry = sItemRandomSuffixStore.LookupEntry(-item->GetItemRandomPropertyId());
            if (itemRandEntry)
                suffix = itemRandEntry->nameSuffix;
        }
        else
        {
            const ItemRandomPropertiesEntry* itemRandEntry = sItemRandomPropertiesStore.LookupEntry(item->GetItemRandomPropertyId());
            if (itemRandEntry)
                suffix = itemRandEntry->nameSuffix;
        }
        if (suffix)
        {
            std::string test(suffix[(name != temp->Name1) ? loc_idx : DEFAULT_LOCALE]);
            if (!test.empty())
            {
                name += ' ';
                name += test;
            }
        }
    }

    std::ostringstream oss;
    oss << "|c" << std::hex << ItemQualityColors[temp->Quality] << std::dec <<
        "|Hitem:" << temp->ItemId << ":" <<
        item->GetEnchantmentId(PERM_ENCHANTMENT_SLOT) << ":" <<
        item->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT) << ":" <<
        item->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2) << ":" <<
        item->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3) << ":" <<
        item->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT) << ":" <<
        item->GetItemRandomPropertyId() << ":" << item->GetItemSuffixFactor() << ":" <<
        (uint32)item->GetOwner()->getLevel() << "|h[" << name << "]|h|r";

    return oss.str();
}

std::string Transmogrification::GetItemLink(uint32 entry, WorldSession* session) const
{
    LOG_DEBUG("modules", "Transmogrification::GetItemLink");

    const ItemTemplate* temp = sObjectMgr->GetItemTemplate(entry);
    int loc_idx = session->GetSessionDbLocaleIndex();
    std::string name = temp->Name1;
    if (ItemLocale const* il = sObjectMgr->GetItemLocale(entry))
        ObjectMgr::GetLocaleString(il->Name, loc_idx, name);

    std::ostringstream oss;
    oss << "|c" << std::hex << ItemQualityColors[temp->Quality] << std::dec <<
        "|Hitem:" << entry << ":0:0:0:0:0:0:0:0:0|h[" << name << "]|h|r";

    return oss.str();
}

uint32 Transmogrification::GetFakeEntry(ObjectGuid itemGUID) const
{
    LOG_DEBUG("modules", "Transmogrification::GetFakeEntry");

    transmogData::const_iterator itr = dataMap.find(itemGUID);
    if (itr == dataMap.end()) return 0;
    transmogMap::const_iterator itr2 = entryMap.find(itr->second);
    if (itr2 == entryMap.end()) return 0;
    transmog2Data::const_iterator itr3 = itr2->second.find(itemGUID);
    if (itr3 == itr2->second.end()) return 0;
    return itr3->second;
}

void Transmogrification::UpdateItem(Player* player, Item* item) const
{
    LOG_DEBUG("modules", "Transmogrification::UpdateItem");

    if (item->IsEquipped())
    {
        player->SetVisibleItemSlot(item->GetSlot(), item);
        if (player->IsInWorld())
            item->SendUpdateToPlayer(player);
    }
}

void Transmogrification::DeleteFakeEntry(Player* player, uint8 /*slot*/, Item* itemTransmogrified, CharacterDatabaseTransaction* trans /*= nullptr*/)
{
    //if (!GetFakeEntry(item))
    //    return false;
    DeleteFakeFromDB(itemTransmogrified->GetGUID().GetCounter(), trans);
    UpdateItem(player, itemTransmogrified);
}

void Transmogrification::SetFakeEntry(Player* player, uint32 newEntry, uint8 /*slot*/, Item* itemTransmogrified)
{
    ObjectGuid itemGUID = itemTransmogrified->GetGUID();
    entryMap[player->GetGUID()][itemGUID] = newEntry;
    dataMap[itemGUID] = player->GetGUID();
    CharacterDatabase.PExecute("REPLACE INTO custom_transmogrification (GUID, FakeEntry, Owner) VALUES (%u, %u, %u)", itemGUID.GetCounter(), newEntry, player->GetGUID().GetCounter());
    UpdateItem(player, itemTransmogrified);
}

TransmogAcoreStrings Transmogrification::Transmogrify(Player* player, ObjectGuid itemGUID, uint8 slot, /*uint32 newEntry, */bool no_cost)
{
    int32 cost = 0;
    // slot of the transmogrified item
    if (slot >= EQUIPMENT_SLOT_END)
    {
        // TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: HandleTransmogrifyItems - Player (GUID: %u, name: %s) tried to transmogrify an item (lowguid: %u) with a wrong slot (%u) when transmogrifying items.", player->GetGUIDLow(), player->GetName().c_str(), GUID_LOPART(itemGUID), slot);
        return LANG_ERR_TRANSMOG_INVALID_SLOT;
    }

    Item* itemTransmogrifier = NULL;
    // guid of the transmogrifier item, if it's not 0
    if (itemGUID)
    {
        itemTransmogrifier = player->GetItemByGuid(itemGUID);
        if (!itemTransmogrifier)
        {
            //TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: HandleTransmogrifyItems - Player (GUID: %u, name: %s) tried to transmogrify with an invalid item (lowguid: %u).", player->GetGUIDLow(), player->GetName().c_str(), GUID_LOPART(itemGUID));
            return LANG_ERR_TRANSMOG_MISSING_SRC_ITEM;
        }
    }

    // transmogrified item
    Item* itemTransmogrified = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
    if (!itemTransmogrified)
    {
        //TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: HandleTransmogrifyItems - Player (GUID: %u, name: %s) tried to transmogrify an invalid item in a valid slot (slot: %u).", player->GetGUIDLow(), player->GetName().c_str(), slot);
        return LANG_ERR_TRANSMOG_MISSING_DEST_ITEM;
    }

    if (!itemTransmogrifier) // reset look newEntry
    {
        // Custom
        DeleteFakeEntry(player, slot, itemTransmogrified);
    }
    else
    {
        if (!CanTransmogrifyItemWithItem(player, itemTransmogrified->GetTemplate(), itemTransmogrifier->GetTemplate()))
        {
            //TC_LOG_DEBUG(LOG_FILTER_NETWORKIO, "WORLD: HandleTransmogrifyItems - Player (GUID: %u, name: %s) failed CanTransmogrifyItemWithItem (%u with %u).", player->GetGUIDLow(), player->GetName().c_str(), itemTransmogrified->GetEntry(), itemTransmogrifier->GetEntry());
            return LANG_ERR_TRANSMOG_INVALID_ITEMS;
        }

        if (!no_cost)
        {
            if (RequireToken)
            {
                if (player->HasItemCount(TokenEntry, TokenAmount))
                    player->DestroyItemCount(TokenEntry, TokenAmount, true);
                else
                    return LANG_ERR_TRANSMOG_NOT_ENOUGH_TOKENS;
            }

            cost = GetSpecialPrice(itemTransmogrified->GetTemplate());
            cost *= ScaledCostModifier;
            cost += CopperCost;

            if (cost) // 0 cost if reverting look
            {
                if (cost < 0)
                    LOG_DEBUG("modules", "Transmogrification::Transmogrify - %s (%s) transmogrification invalid cost (non negative, amount %i). Transmogrified %u with %u",
                        player->GetName().c_str(), player->GetGUID().ToString().c_str(), -cost, itemTransmogrified->GetEntry(), itemTransmogrifier->GetEntry());
                else
                {
                    if (!player->HasEnoughMoney(cost))
                        return LANG_ERR_TRANSMOG_NOT_ENOUGH_MONEY;
                    player->ModifyMoney(-cost, false);
                }
            }
        }

        // Custom
        SetFakeEntry(player, itemTransmogrifier->GetEntry(), slot, itemTransmogrified); // newEntry

        itemTransmogrified->UpdatePlayedTime(player);

        itemTransmogrified->SetOwnerGUID(player->GetGUID());
        itemTransmogrified->SetNotRefundable(player);
        itemTransmogrified->ClearSoulboundTradeable(player);

        if (itemTransmogrifier->GetTemplate()->Bonding == BIND_WHEN_EQUIPED || itemTransmogrifier->GetTemplate()->Bonding == BIND_WHEN_USE)
            itemTransmogrifier->SetBinding(true);

        itemTransmogrifier->SetOwnerGUID(player->GetGUID());
        itemTransmogrifier->SetNotRefundable(player);
        itemTransmogrifier->ClearSoulboundTradeable(player);
    }

    return LANG_ERR_TRANSMOG_OK;
}

bool Transmogrification::CanTransmogrifyItemWithItem(Player* player, ItemTemplate const* target, ItemTemplate const* source) const
{

    if (!target || !source)
        return false;

    if (source->ItemId == target->ItemId)
        return false;

    if (source->DisplayInfoID == target->DisplayInfoID)
        return false;

    if (source->Class != target->Class)
        return false;

    if (source->InventoryType == INVTYPE_BAG ||
        source->InventoryType == INVTYPE_RELIC ||
        // source->InventoryType == INVTYPE_BODY ||
        source->InventoryType == INVTYPE_FINGER ||
        source->InventoryType == INVTYPE_TRINKET ||
        source->InventoryType == INVTYPE_AMMO ||
        source->InventoryType == INVTYPE_QUIVER)
        return false;

    if (target->InventoryType == INVTYPE_BAG ||
        target->InventoryType == INVTYPE_RELIC ||
        // target->InventoryType == INVTYPE_BODY ||
        target->InventoryType == INVTYPE_FINGER ||
        target->InventoryType == INVTYPE_TRINKET ||
        target->InventoryType == INVTYPE_AMMO ||
        target->InventoryType == INVTYPE_QUIVER)
        return false;

    if (!SuitableForTransmogrification(player, target) || !SuitableForTransmogrification(player, source)) // if (!transmogrified->CanTransmogrify() || !transmogrifier->CanBeTransmogrified())
        return false;

    if (IsRangedWeapon(source->Class, source->SubClass) != IsRangedWeapon(target->Class, target->SubClass))
        return false;

    if (source->SubClass != target->SubClass && !IsRangedWeapon(target->Class, target->SubClass))
    {
        if (!IsAllowed(source->ItemId))
        {
            if (source->Class == ITEM_CLASS_ARMOR && !AllowMixedArmorTypes)
                return false;
            if (source->Class == ITEM_CLASS_WEAPON && !AllowMixedWeaponTypes)
                return false;
        }
    }

    if (source->InventoryType != target->InventoryType)
    {
        if (source->Class == ITEM_CLASS_WEAPON && !(IsRangedWeapon(target->Class, target->SubClass) ||
            (
                // [AZTH] Yehonal: fixed weapon check
                (target->InventoryType == INVTYPE_WEAPON || target->InventoryType == INVTYPE_2HWEAPON || target->InventoryType == INVTYPE_WEAPONMAINHAND || target->InventoryType == INVTYPE_WEAPONOFFHAND)
                && (source->InventoryType == INVTYPE_WEAPON || source->InventoryType == INVTYPE_2HWEAPON || source->InventoryType == INVTYPE_WEAPONMAINHAND || source->InventoryType == INVTYPE_WEAPONOFFHAND)
            )
        ))
            return false;
        if (source->Class == ITEM_CLASS_ARMOR &&
            !((source->InventoryType == INVTYPE_CHEST || source->InventoryType == INVTYPE_ROBE) &&
                (target->InventoryType == INVTYPE_CHEST || target->InventoryType == INVTYPE_ROBE)))
            return false;
    }

    return true;
}

bool Transmogrification::SuitableForTransmogrification(Player* player, ItemTemplate const* proto) const
{
    // ItemTemplate const* proto = item->GetTemplate();
    if (!player || !proto)
        return false;

    if (proto->Class != ITEM_CLASS_ARMOR &&
        proto->Class != ITEM_CLASS_WEAPON)
        return false;

    // Skip all checks for allowed items
    if (IsAllowed(proto->ItemId))
        return true;

    //[AZTH] Yehonal
    if (proto->SubClass > 0 && player->GetSkillValue(proto->GetSkill()) == 0)
    {
        if (proto->Class == ITEM_CLASS_ARMOR)
        {
            if (!AllowMixedArmorTypes)
                return false;
        }
        else if (proto->Class == ITEM_CLASS_WEAPON)
        {
            if (!AllowMixedWeaponTypes)
                return false;
        }
        else
            return false;
    }

    if (IsNotAllowed(proto->ItemId))
        return false;

    if (!AllowFishingPoles && proto->Class == ITEM_CLASS_WEAPON && proto->SubClass == ITEM_SUBCLASS_WEAPON_FISHING_POLE)
        return false;

    if (!IsAllowedQuality(proto->Quality)) // (proto->Quality == ITEM_QUALITY_LEGENDARY)
        return false;

    if ((proto->Flags2 & ITEM_FLAGS_EXTRA_HORDE_ONLY) && player->GetTeamId() != TEAM_HORDE)
        return false;

    if ((proto->Flags2 & ITEM_FLAGS_EXTRA_ALLIANCE_ONLY) && player->GetTeamId() != TEAM_ALLIANCE)
        return false;

    if (!IgnoreReqClass && (proto->AllowableClass & player->getClassMask()) == 0)
        return false;

    if (!IgnoreReqRace && (proto->AllowableRace & player->getRaceMask()) == 0)
        return false;

    if (!IgnoreReqSkill && proto->RequiredSkill != 0)
    {
        if (player->GetSkillValue(proto->RequiredSkill) == 0)
            return false;
        else if (player->GetSkillValue(proto->RequiredSkill) < proto->RequiredSkillRank)
            return false;
    }

    if (!IgnoreReqSpell && proto->RequiredSpell != 0 && !player->HasSpell(proto->RequiredSpell))
        return false;

    if (!IgnoreReqLevel && player->getLevel() < proto->RequiredLevel)
        return false;

    // If World Event is not active, prevent using event dependant items
    if (!IgnoreReqEvent && proto->HolidayId && !IsHolidayActive((HolidayIds)proto->HolidayId))
        return false;

    if (!IgnoreReqStats)
    {
        if (!proto->RandomProperty && !proto->RandomSuffix
                /*[AZTH] Yehonal: we should transmorg also items without stats*/
                && proto->StatsCount > 0)
        {
            bool found = false;
            for (uint8 i = 0; i < proto->StatsCount; ++i)
            {
                if (proto->ItemStat[i].ItemStatValue != 0)
                {
                    found = true;
                    break;
                }
            }
            if (!found)
                return false;
        }
    }

    return true;
}

uint32 Transmogrification::GetSpecialPrice(ItemTemplate const* proto) const
{
    uint32 cost = proto->SellPrice < 10000 ? 10000 : proto->SellPrice;
    return cost;
}
bool Transmogrification::IsRangedWeapon(uint32 Class, uint32 SubClass) const
{
    return Class == ITEM_CLASS_WEAPON && (
        SubClass == ITEM_SUBCLASS_WEAPON_BOW ||
        SubClass == ITEM_SUBCLASS_WEAPON_GUN ||
        SubClass == ITEM_SUBCLASS_WEAPON_CROSSBOW);
}

bool Transmogrification::IsAllowed(uint32 entry) const
{
    return Allowed.find(entry) != Allowed.end();
}

bool Transmogrification::IsNotAllowed(uint32 entry) const
{
    return NotAllowed.find(entry) != NotAllowed.end();
}

bool Transmogrification::IsAllowedQuality(uint32 quality) const
{
    switch (quality)
    {
        case ITEM_QUALITY_POOR: return AllowPoor;
        case ITEM_QUALITY_NORMAL: return AllowCommon;
        case ITEM_QUALITY_UNCOMMON: return AllowUncommon;
        case ITEM_QUALITY_RARE: return AllowRare;
        case ITEM_QUALITY_EPIC: return AllowEpic;
        case ITEM_QUALITY_LEGENDARY: return AllowLegendary;
        case ITEM_QUALITY_ARTIFACT: return AllowArtifact;
        case ITEM_QUALITY_HEIRLOOM: return AllowHeirloom;
        default: return false;
    }
}

void Transmogrification::LoadConfig(bool reload)
{
#ifdef PRESETS
    EnableSetInfo = sConfigMgr->GetBoolDefault("Transmogrification.EnableSetInfo", true);
    SetNpcText = uint32(sConfigMgr->GetIntDefault("Transmogrification.SetNpcText", 601084));

    EnableSets = sConfigMgr->GetBoolDefault("Transmogrification.EnableSets", true);
    MaxSets = (uint8)sConfigMgr->GetIntDefault("Transmogrification.MaxSets", 10);
    SetCostModifier = sConfigMgr->GetFloatDefault("Transmogrification.SetCostModifier", 3.0f);
    SetCopperCost = sConfigMgr->GetIntDefault("Transmogrification.SetCopperCost", 0);

    if (MaxSets > MAX_OPTIONS)
        MaxSets = MAX_OPTIONS;

    if (reload) // dont store presets for nothing
    {
        SessionMap const& sessions = sWorld->GetAllSessions();
        for (SessionMap::const_iterator it = sessions.begin(); it != sessions.end(); ++it)
        {
            if (Player* player = it->second->GetPlayer())
            {
                // skipping session check
                UnloadPlayerSets(player->GetGUID());
                if (GetEnableSets())
                    LoadPlayerSets(player->GetGUID());
            }
        }
    }
#endif

    EnableTransmogInfo = sConfigMgr->GetBoolDefault("Transmogrification.EnableTransmogInfo", true);
    TransmogNpcText = uint32(sConfigMgr->GetIntDefault("Transmogrification.TransmogNpcText", 601083));

    std::istringstream issAllowed(sConfigMgr->GetStringDefault("Transmogrification.Allowed", ""));
    std::istringstream issNotAllowed(sConfigMgr->GetStringDefault("Transmogrification.NotAllowed", ""));
    while (issAllowed.good())
    {
        uint32 entry;
        issAllowed >> entry;
        if (issAllowed.fail())
            break;
        Allowed.insert(entry);
    }
    while (issNotAllowed.good())
    {
        uint32 entry;
        issNotAllowed >> entry;
        if (issNotAllowed.fail())
            break;
        NotAllowed.insert(entry);
    }

    ScaledCostModifier = sConfigMgr->GetFloatDefault("Transmogrification.ScaledCostModifier", 1.0f);
    CopperCost = sConfigMgr->GetIntDefault("Transmogrification.CopperCost", 0);

    RequireToken = sConfigMgr->GetBoolDefault("Transmogrification.RequireToken", false);
    TokenEntry = uint32(sConfigMgr->GetIntDefault("Transmogrification.TokenEntry", 49426));
    TokenAmount = uint32(sConfigMgr->GetIntDefault("Transmogrification.TokenAmount", 1));

    AllowPoor = sConfigMgr->GetBoolDefault("Transmogrification.AllowPoor", false);
    AllowCommon = sConfigMgr->GetBoolDefault("Transmogrification.AllowCommon", false);
    AllowUncommon = sConfigMgr->GetBoolDefault("Transmogrification.AllowUncommon", true);
    AllowRare = sConfigMgr->GetBoolDefault("Transmogrification.AllowRare", true);
    AllowEpic = sConfigMgr->GetBoolDefault("Transmogrification.AllowEpic", true);
    AllowLegendary = sConfigMgr->GetBoolDefault("Transmogrification.AllowLegendary", false);
    AllowArtifact = sConfigMgr->GetBoolDefault("Transmogrification.AllowArtifact", false);
    AllowHeirloom = sConfigMgr->GetBoolDefault("Transmogrification.AllowHeirloom", true);

    AllowMixedArmorTypes = sConfigMgr->GetBoolDefault("Transmogrification.AllowMixedArmorTypes", false);
    AllowMixedWeaponTypes = sConfigMgr->GetBoolDefault("Transmogrification.AllowMixedWeaponTypes", false);
    AllowFishingPoles = sConfigMgr->GetBoolDefault("Transmogrification.AllowFishingPoles", false);

    IgnoreReqRace = sConfigMgr->GetBoolDefault("Transmogrification.IgnoreReqRace", false);
    IgnoreReqClass = sConfigMgr->GetBoolDefault("Transmogrification.IgnoreReqClass", false);
    IgnoreReqSkill = sConfigMgr->GetBoolDefault("Transmogrification.IgnoreReqSkill", false);
    IgnoreReqSpell = sConfigMgr->GetBoolDefault("Transmogrification.IgnoreReqSpell", false);
    IgnoreReqLevel = sConfigMgr->GetBoolDefault("Transmogrification.IgnoreReqLevel", false);
    IgnoreReqEvent = sConfigMgr->GetBoolDefault("Transmogrification.IgnoreReqEvent", false);
    IgnoreReqStats = sConfigMgr->GetBoolDefault("Transmogrification.IgnoreReqStats", false);

    if (!sObjectMgr->GetItemTemplate(TokenEntry))
    {
        //sLog->outError(LOG_FILTER_SERVER_LOADING, "Transmogrification.TokenEntry (%u) does not exist. Using default.", TokenEntry);
        TokenEntry = 49426;
    }
}

void Transmogrification::DeleteFakeFromDB(ObjectGuid::LowType itemLowGuid, CharacterDatabaseTransaction* trans /*= nullptr*/)
{
    ObjectGuid itemGUID = ObjectGuid::Create<HighGuid::Item>(itemLowGuid);

    if (dataMap.find(itemGUID) != dataMap.end())
    {
        if (entryMap.find(dataMap[itemGUID]) != entryMap.end())
            entryMap[dataMap[itemGUID]].erase(itemGUID);
        dataMap.erase(itemGUID);
    }
    if (trans)
        (*trans)->PAppend("DELETE FROM custom_transmogrification WHERE GUID = %u", itemLowGuid);
    else
        CharacterDatabase.PExecute("DELETE FROM custom_transmogrification WHERE GUID = %u", itemGUID.GetCounter());
}

bool Transmogrification::GetEnableTransmogInfo() const
{
    return EnableTransmogInfo;
}
uint32 Transmogrification::GetTransmogNpcText() const
{
    return TransmogNpcText;
}
bool Transmogrification::GetEnableSetInfo() const
{
    return EnableSetInfo;
}
uint32 Transmogrification::GetSetNpcText() const
{
    return SetNpcText;
}
float Transmogrification::GetScaledCostModifier() const
{
    return ScaledCostModifier;
}
int32 Transmogrification::GetCopperCost() const
{
    return CopperCost;
}
bool Transmogrification::GetRequireToken() const
{
    return RequireToken;
}
uint32 Transmogrification::GetTokenEntry() const
{
    return TokenEntry;
}
uint32 Transmogrification::GetTokenAmount() const
{
    return TokenAmount;
}
bool Transmogrification::GetAllowMixedArmorTypes() const
{
    return AllowMixedArmorTypes;
};
bool Transmogrification::GetAllowMixedWeaponTypes() const
{
    return AllowMixedWeaponTypes;
};
