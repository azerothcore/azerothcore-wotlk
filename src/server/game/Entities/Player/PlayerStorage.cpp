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

#include "AccountMgr.h"
#include "AchievementMgr.h"
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "Battlefield.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "Channel.h"
#include "CharacterDatabaseCleaner.h"
#include "Chat.h"
#include "Common.h"
#include "ConditionMgr.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DisableMgr.h"
#include "GameEventMgr.h"
#include "GameGraveyard.h"
#include "GameObjectAI.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "GroupMgr.h"
#include "Guild.h"
#include "InstanceSaveMgr.h"
#include "LFGMgr.h"
#include "Language.h"
#include "Log.h"
#include "LootItemStorage.h"
#include "MapMgr.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "OutdoorPvP.h"
#include "OutdoorPvPMgr.h"
#include "Pet.h"
#include "Player.h"
#include "QueryHolder.h"
#include "QuestDef.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "SocialMgr.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include "Transport.h"
#include "UpdateData.h"
#include "UpdateFieldFlags.h"
#include "Util.h"
#include "Vehicle.h"
#include "World.h"
#include "WorldPacket.h"

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

/*********************************************************/
/***                    STORAGE SYSTEM                 ***/
/*********************************************************/

void Player::SetVirtualItemSlot(uint8 i, Item* item)
{
    ASSERT(i < 3);
    if (i < 2 && item)
    {
        if (!item->GetEnchantmentId(TEMP_ENCHANTMENT_SLOT))
            return;
        uint32 charges = item->GetEnchantmentCharges(TEMP_ENCHANTMENT_SLOT);
        if (charges == 0)
            return;
        if (charges > 1)
            item->SetEnchantmentCharges(TEMP_ENCHANTMENT_SLOT, charges - 1);
        else if (charges <= 1)
        {
            ApplyEnchantment(item, TEMP_ENCHANTMENT_SLOT, false);
            item->ClearEnchantment(TEMP_ENCHANTMENT_SLOT);
        }
    }
}

void Player::SetSheath(SheathState sheathed)
{
    switch (sheathed)
    {
        case SHEATH_STATE_UNARMED:                          // no prepared weapon
            SetVirtualItemSlot(0, nullptr);
            SetVirtualItemSlot(1, nullptr);
            SetVirtualItemSlot(2, nullptr);
            break;
        case SHEATH_STATE_MELEE:                            // prepared melee weapon
            SetVirtualItemSlot(0, GetWeaponForAttack(BASE_ATTACK, true));
            SetVirtualItemSlot(1, GetWeaponForAttack(OFF_ATTACK, true));
            SetVirtualItemSlot(2, nullptr);
            break;
        case SHEATH_STATE_RANGED:                           // prepared ranged weapon
            SetVirtualItemSlot(0, nullptr);
            SetVirtualItemSlot(1, nullptr);
            SetVirtualItemSlot(2, GetWeaponForAttack(RANGED_ATTACK, true));
            break;
        default:
            SetVirtualItemSlot(0, nullptr);
            SetVirtualItemSlot(1, nullptr);
            SetVirtualItemSlot(2, nullptr);
            break;
    }
    Unit::SetSheath(sheathed);                              // this must visualize Sheath changing for other players...
}

uint8 Player::FindEquipSlot(ItemTemplate const* proto, uint32 slot, bool swap) const
{
    uint8 slots[4];
    slots[0] = NULL_SLOT;
    slots[1] = NULL_SLOT;
    slots[2] = NULL_SLOT;
    slots[3] = NULL_SLOT;
    switch (proto->InventoryType)
    {
        case INVTYPE_HEAD:
            slots[0] = EQUIPMENT_SLOT_HEAD;
            break;
        case INVTYPE_NECK:
            slots[0] = EQUIPMENT_SLOT_NECK;
            break;
        case INVTYPE_SHOULDERS:
            slots[0] = EQUIPMENT_SLOT_SHOULDERS;
            break;
        case INVTYPE_BODY:
            slots[0] = EQUIPMENT_SLOT_BODY;
            break;
        case INVTYPE_CHEST:
        case INVTYPE_ROBE:
            slots[0] = EQUIPMENT_SLOT_CHEST;
            break;
        case INVTYPE_WAIST:
            slots[0] = EQUIPMENT_SLOT_WAIST;
            break;
        case INVTYPE_LEGS:
            slots[0] = EQUIPMENT_SLOT_LEGS;
            break;
        case INVTYPE_FEET:
            slots[0] = EQUIPMENT_SLOT_FEET;
            break;
        case INVTYPE_WRISTS:
            slots[0] = EQUIPMENT_SLOT_WRISTS;
            break;
        case INVTYPE_HANDS:
            slots[0] = EQUIPMENT_SLOT_HANDS;
            break;
        case INVTYPE_FINGER:
            slots[0] = EQUIPMENT_SLOT_FINGER1;
            slots[1] = EQUIPMENT_SLOT_FINGER2;
            break;
        case INVTYPE_TRINKET:
            slots[0] = EQUIPMENT_SLOT_TRINKET1;
            slots[1] = EQUIPMENT_SLOT_TRINKET2;
            break;
        case INVTYPE_CLOAK:
            slots[0] = EQUIPMENT_SLOT_BACK;
            break;
        case INVTYPE_WEAPON:
        {
            slots[0] = EQUIPMENT_SLOT_MAINHAND;

            // suggest offhand slot only if know dual wielding
            // (this will be replace mainhand weapon at auto equip instead unwonted "you don't known dual wielding" ...
            if (CanDualWield())
                slots[1] = EQUIPMENT_SLOT_OFFHAND;
            break;
        }
        case INVTYPE_SHIELD:
        case INVTYPE_WEAPONOFFHAND:
        case INVTYPE_HOLDABLE:
            slots[0] = EQUIPMENT_SLOT_OFFHAND;
            break;
        case INVTYPE_RANGED:
        case INVTYPE_RANGEDRIGHT:
        case INVTYPE_THROWN:
            slots[0] = EQUIPMENT_SLOT_RANGED;
            break;
        case INVTYPE_2HWEAPON:
            slots[0] = EQUIPMENT_SLOT_MAINHAND;
            if (Item* mhWeapon = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND))
            {
                if (ItemTemplate const* mhWeaponProto = mhWeapon->GetTemplate())
                {
                    if (mhWeaponProto->SubClass == ITEM_SUBCLASS_WEAPON_POLEARM || mhWeaponProto->SubClass == ITEM_SUBCLASS_WEAPON_STAFF)
                    {
                        const_cast<Player*>(this)->AutoUnequipOffhandIfNeed(true);
                        break;
                    }
                }
            }

            if (GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND))
            {
                if (proto->SubClass == ITEM_SUBCLASS_WEAPON_POLEARM || proto->SubClass == ITEM_SUBCLASS_WEAPON_STAFF)
                {
                    const_cast<Player*>(this)->AutoUnequipOffhandIfNeed(true);
                    break;
                }
            }
            if (CanDualWield() && CanTitanGrip() && proto->SubClass != ITEM_SUBCLASS_WEAPON_POLEARM && proto->SubClass != ITEM_SUBCLASS_WEAPON_STAFF && proto->SubClass != ITEM_SUBCLASS_WEAPON_FISHING_POLE)
                slots[1] = EQUIPMENT_SLOT_OFFHAND;
            break;
        case INVTYPE_TABARD:
            slots[0] = EQUIPMENT_SLOT_TABARD;
            break;
        case INVTYPE_WEAPONMAINHAND:
            slots[0] = EQUIPMENT_SLOT_MAINHAND;
            break;
        case INVTYPE_BAG:
            slots[0] = INVENTORY_SLOT_BAG_START + 0;
            slots[1] = INVENTORY_SLOT_BAG_START + 1;
            slots[2] = INVENTORY_SLOT_BAG_START + 2;
            slots[3] = INVENTORY_SLOT_BAG_START + 3;
            break;
        case INVTYPE_RELIC:
        {
            switch (proto->SubClass)
            {
                case ITEM_SUBCLASS_ARMOR_LIBRAM:
                    if (IsClass(CLASS_PALADIN, CLASS_CONTEXT_EQUIP_RELIC))
                        slots[0] = EQUIPMENT_SLOT_RANGED;
                    break;
                case ITEM_SUBCLASS_ARMOR_IDOL:
                    if (IsClass(CLASS_DRUID, CLASS_CONTEXT_EQUIP_RELIC))
                        slots[0] = EQUIPMENT_SLOT_RANGED;
                    break;
                case ITEM_SUBCLASS_ARMOR_TOTEM:
                    if (IsClass(CLASS_SHAMAN, CLASS_CONTEXT_EQUIP_RELIC))
                        slots[0] = EQUIPMENT_SLOT_RANGED;
                    break;
                case ITEM_SUBCLASS_ARMOR_MISC:
                    if (IsClass(CLASS_WARLOCK, CLASS_CONTEXT_EQUIP_RELIC))
                        slots[0] = EQUIPMENT_SLOT_RANGED;
                    break;
                case ITEM_SUBCLASS_ARMOR_SIGIL:
                    if (IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_EQUIP_RELIC))
                        slots[0] = EQUIPMENT_SLOT_RANGED;
                    break;
            }
            break;
        }
        default:
            return NULL_SLOT;
    }

    if (slot != NULL_SLOT)
    {
        if (swap || !GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
            for (uint8 i = 0; i < 4; ++i)
                if (slots[i] == slot)
                    return slot;
    }
    else
    {
        // search free slot at first
        for (uint8 i = 0; i < 4; ++i)
            if (slots[i] != NULL_SLOT && !GetItemByPos(INVENTORY_SLOT_BAG_0, slots[i]))
                // in case 2hand equipped weapon (without titan grip) offhand slot empty but not free
                if (slots[i] != EQUIPMENT_SLOT_OFFHAND || !IsTwoHandUsed())
                    return slots[i];

        // if not found free and can swap return first appropriate from used
        for (uint8 i = 0; i < 4; ++i)
            if (slots[i] != NULL_SLOT && swap)
                return slots[i];
    }

    // no free position
    return NULL_SLOT;
}

InventoryResult Player::CanUnequipItems(uint32 item, uint32 count) const
{
    uint32 tempcount = 0;

    InventoryResult res = EQUIP_ERR_OK;

    for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->GetEntry() == item)
            {
                InventoryResult ires = CanUnequipItem(INVENTORY_SLOT_BAG_0 << 8 | i, false);
                if (ires == EQUIP_ERR_OK)
                {
                    tempcount += pItem->GetCount();
                    if (tempcount >= count)
                        return EQUIP_ERR_OK;
                }
                else
                    res = ires;
            }

    for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->GetEntry() == item)
            {
                tempcount += pItem->GetCount();
                if (tempcount >= count)
                    return EQUIP_ERR_OK;
            }

    for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->GetEntry() == item)
            {
                tempcount += pItem->GetCount();
                if (tempcount >= count)
                    return EQUIP_ERR_OK;
            }

    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
        if (Bag* pBag = GetBagByPos(i))
            for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
                if (Item* pItem = GetItemByPos(i, j))
                    if (pItem->GetEntry() == item)
                    {
                        tempcount += pItem->GetCount();
                        if (tempcount >= count)
                            return EQUIP_ERR_OK;
                    }

    // not found req. item count and have unequippable items
    return res;
}

uint32 Player::GetItemCount(uint32 item, bool inBankAlso, Item* skipItem) const
{
    uint32 count = 0;
    for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; i++)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem != skipItem &&  pItem->GetEntry() == item)
                count += pItem->GetCount();

    for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem != skipItem && pItem->GetEntry() == item)
                count += pItem->GetCount();

    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
        if (Bag* pBag = GetBagByPos(i))
            count += pBag->GetItemCount(item, skipItem);

    if (skipItem && skipItem->GetTemplate()->GemProperties)
        for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; ++i)
            if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                if (pItem != skipItem && pItem->GetTemplate()->Socket[0].Color)
                    count += pItem->GetGemCountWithID(item);

    if (inBankAlso)
    {
        // checking every item from 39 to 74 (including bank bags)
        for (uint8 i = BANK_SLOT_ITEM_START; i < BANK_SLOT_BAG_END; ++i)
            if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                if (pItem != skipItem && pItem->GetEntry() == item)
                    count += pItem->GetCount();

        for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
            if (Bag* pBag = GetBagByPos(i))
                count += pBag->GetItemCount(item, skipItem);

        if (skipItem && skipItem->GetTemplate()->GemProperties)
            for (uint8 i = BANK_SLOT_ITEM_START; i < BANK_SLOT_ITEM_END; ++i)
                if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                    if (pItem != skipItem && pItem->GetTemplate()->Socket[0].Color)
                        count += pItem->GetGemCountWithID(item);
    }

    return count;
}

uint32 Player::GetItemCountWithLimitCategory(uint32 limitCategory, Item* skipItem) const
{
    uint32 count = 0;
    for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem != skipItem)
                if (ItemTemplate const* pProto = pItem->GetTemplate())
                    if (pProto->ItemLimitCategory == limitCategory)
                        count += pItem->GetCount();

    for (int i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem != skipItem)
                if (ItemTemplate const* pProto = pItem->GetTemplate())
                    if (pProto->ItemLimitCategory == limitCategory)
                        count += pItem->GetCount();

    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
        if (Bag* pBag = GetBagByPos(i))
            count += pBag->GetItemCountWithLimitCategory(limitCategory, skipItem);

    for (int i = BANK_SLOT_ITEM_START; i < BANK_SLOT_BAG_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem != skipItem)
                if (ItemTemplate const* pProto = pItem->GetTemplate())
                    if (pProto->ItemLimitCategory == limitCategory)
                        count += pItem->GetCount();

    for (int i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
        if (Bag* pBag = GetBagByPos(i))
            count += pBag->GetItemCountWithLimitCategory(limitCategory, skipItem);

    return count;
}

Item* Player::GetItemByGuid(ObjectGuid guid) const
{
    for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->GetGUID() == guid)
                return pItem;

    for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->GetGUID() == guid)
                return pItem;

    for (int i = BANK_SLOT_ITEM_START; i < BANK_SLOT_BAG_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->GetGUID() == guid)
                return pItem;

    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
        if (Bag* pBag = GetBagByPos(i))
            for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
                if (Item* pItem = pBag->GetItemByPos(j))
                    if (pItem->GetGUID() == guid)
                        return pItem;

    for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; ++i)
        if (Bag* pBag = GetBagByPos(i))
            for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
                if (Item* pItem = pBag->GetItemByPos(j))
                    if (pItem->GetGUID() == guid)
                        return pItem;

    return nullptr;
}

Item* Player::GetItemByPos(uint16 pos) const
{
    uint8 bag = pos >> 8;
    uint8 slot = pos & 255;
    return GetItemByPos(bag, slot);
}

Item* Player::GetItemByPos(uint8 bag, uint8 slot) const
{
    if (bag == INVENTORY_SLOT_BAG_0 && (slot < BANK_SLOT_BAG_END || (slot >= KEYRING_SLOT_START && slot < CURRENCYTOKEN_SLOT_END)))
        return m_items[slot];
    else if (Bag* pBag = GetBagByPos(bag))
        return pBag->GetItemByPos(slot);
    return nullptr;
}

Bag* Player::GetBagByPos(uint8 bag) const
{
    if ((bag >= INVENTORY_SLOT_BAG_START && bag < INVENTORY_SLOT_BAG_END)
        || (bag >= BANK_SLOT_BAG_START && bag < BANK_SLOT_BAG_END))
        if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, bag))
            return item->ToBag();
    return nullptr;
}

uint32 Player::GetFreeInventorySpace() const
{
    uint32 freeSpace = 0;

    // Check backpack
    for (uint8 slot = INVENTORY_SLOT_ITEM_START; slot < INVENTORY_SLOT_ITEM_END; ++slot)
    {
        Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
        if (!item)
            freeSpace += 1;
    }

    // Check bags
    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (Bag* bag = GetBagByPos(i))
            freeSpace += bag->GetFreeSlots();
    }

    return freeSpace;
}

Item* Player::GetWeaponForAttack(WeaponAttackType attackType, bool useable /*= false*/) const
{
    uint8 slot;
    switch (attackType)
    {
        case BASE_ATTACK:
            slot = EQUIPMENT_SLOT_MAINHAND;
            break;
        case OFF_ATTACK:
            slot = EQUIPMENT_SLOT_OFFHAND;
            break;
        case RANGED_ATTACK:
            slot = EQUIPMENT_SLOT_RANGED;
            break;
        default:
            return nullptr;
    }

    Item* item = nullptr;
    if (useable)
        item = GetUseableItemByPos(INVENTORY_SLOT_BAG_0, slot);
    else
        item = GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
    if (!item || item->GetTemplate()->Class != ITEM_CLASS_WEAPON)
        return nullptr;

    if (!useable)
        return item;

    if (item->IsBroken() || IsInFeralForm())
        return nullptr;

    return item;
}

Item* Player::GetShield(bool useable) const
{
    Item* item = nullptr;
    if (useable)
        item = GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
    else
        item = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
    if (!item || item->GetTemplate()->Class != ITEM_CLASS_ARMOR)
        return nullptr;

    if (!useable)
        return item;

    if (item->IsBroken())
        return nullptr;

    return item;
}

uint8 Player::GetAttackBySlot(uint8 slot)
{
    switch (slot)
    {
        case EQUIPMENT_SLOT_MAINHAND:
            return BASE_ATTACK;
        case EQUIPMENT_SLOT_OFFHAND:
            return OFF_ATTACK;
        case EQUIPMENT_SLOT_RANGED:
            return RANGED_ATTACK;
        default:
            return MAX_ATTACK;
    }
}

bool Player::IsInventoryPos(uint8 bag, uint8 slot)
{
    if (bag == INVENTORY_SLOT_BAG_0 && slot == NULL_SLOT)
        return true;
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= INVENTORY_SLOT_ITEM_START && slot < INVENTORY_SLOT_ITEM_END))
        return true;
    if (bag >= INVENTORY_SLOT_BAG_START && bag < INVENTORY_SLOT_BAG_END)
        return true;
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= KEYRING_SLOT_START && slot < CURRENCYTOKEN_SLOT_END))
        return true;
    return false;
}

bool Player::IsEquipmentPos(uint8 bag, uint8 slot)
{
    if (bag == INVENTORY_SLOT_BAG_0 && (slot < EQUIPMENT_SLOT_END))
        return true;
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= INVENTORY_SLOT_BAG_START && slot < INVENTORY_SLOT_BAG_END))
        return true;
    return false;
}

bool Player::IsBankPos(uint8 bag, uint8 slot)
{
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= BANK_SLOT_ITEM_START && slot < BANK_SLOT_ITEM_END))
        return true;
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= BANK_SLOT_BAG_START && slot < BANK_SLOT_BAG_END))
        return true;
    if (bag >= BANK_SLOT_BAG_START && bag < BANK_SLOT_BAG_END)
        return true;
    return false;
}

bool Player::IsBagPos(uint16 pos)
{
    uint8 bag = pos >> 8;
    uint8 slot = pos & 255;
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= INVENTORY_SLOT_BAG_START && slot < INVENTORY_SLOT_BAG_END))
        return true;
    if (bag == INVENTORY_SLOT_BAG_0 && (slot >= BANK_SLOT_BAG_START && slot < BANK_SLOT_BAG_END))
        return true;
    return false;
}

bool Player::IsValidPos(uint8 bag, uint8 slot, bool explicit_pos)
{
    // post selected
    if (bag == NULL_BAG && !explicit_pos)
        return true;

    if (bag == INVENTORY_SLOT_BAG_0)
    {
        // any post selected
        if (slot == NULL_SLOT && !explicit_pos)
            return true;

        // equipment
        if (slot < EQUIPMENT_SLOT_END)
            return true;

        // bag equip slots
        if (slot >= INVENTORY_SLOT_BAG_START && slot < INVENTORY_SLOT_BAG_END)
            return true;

        // backpack slots
        if (slot >= INVENTORY_SLOT_ITEM_START && slot < INVENTORY_SLOT_ITEM_END)
            return true;

        // keyring slots
        if (slot >= KEYRING_SLOT_START && slot < KEYRING_SLOT_END)
            return true;

        // bank main slots
        if (slot >= BANK_SLOT_ITEM_START && slot < BANK_SLOT_ITEM_END)
            return true;

        // bank bag slots
        if (slot >= BANK_SLOT_BAG_START && slot < BANK_SLOT_BAG_END)
            return true;

        return false;
    }

    // bag content slots
    // bank bag content slots
    if (Bag* pBag = GetBagByPos(bag))
    {
        // any post selected
        if (slot == NULL_SLOT && !explicit_pos)
            return true;

        return slot < pBag->GetBagSize();
    }

    // where this?
    return false;
}

bool Player::HasItemCount(uint32 item, uint32 count, bool inBankAlso) const
{
    uint32 tempcount = 0;
    for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item && !pItem->IsInTrade())
        {
            tempcount += pItem->GetCount();
            if (tempcount >= count)
                return true;
        }
    }
    for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
    {
        Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item && !pItem->IsInTrade())
        {
            tempcount += pItem->GetCount();
            if (tempcount >= count)
                return true;
        }
    }
    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (Bag* pBag = GetBagByPos(i))
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
            {
                Item* pItem = GetItemByPos(i, j);
                if (pItem && pItem->GetEntry() == item && !pItem->IsInTrade())
                {
                    tempcount += pItem->GetCount();
                    if (tempcount >= count)
                        return true;
                }
            }
        }
    }

    if (inBankAlso)
    {
        for (uint8 i = BANK_SLOT_ITEM_START; i < BANK_SLOT_ITEM_END; i++)
        {
            Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem && pItem->GetEntry() == item && !pItem->IsInTrade())
            {
                tempcount += pItem->GetCount();
                if (tempcount >= count)
                    return true;
            }
        }
        for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
        {
            if (Bag* pBag = GetBagByPos(i))
            {
                for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                {
                    Item* pItem = GetItemByPos(i, j);
                    if (pItem && pItem->GetEntry() == item && !pItem->IsInTrade())
                    {
                        tempcount += pItem->GetCount();
                        if (tempcount >= count)
                            return true;
                    }
                }
            }
        }
    }

    return false;
}

bool Player::HasItemOrGemWithIdEquipped(uint32 item, uint32 count, uint8 except_slot) const
{
    uint32 tempcount = 0;
    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        if (i == except_slot)
            continue;

        Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == item)
        {
            tempcount += pItem->GetCount();
            if (tempcount >= count)
                return true;
        }
    }

    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(item);
    if (pProto && pProto->GemProperties)
    {
        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
        {
            if (i == except_slot)
                continue;

            Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem && pItem->GetTemplate()->Socket[0].Color)
            {
                tempcount += pItem->GetGemCountWithID(item);
                if (tempcount >= count)
                    return true;
            }
        }
    }

    return false;
}

bool Player::HasItemOrGemWithLimitCategoryEquipped(uint32 limitCategory, uint32 count, uint8 except_slot) const
{
    uint32 tempcount = 0;
    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        if (i == except_slot)
            continue;

        Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (!pItem)
            continue;

        ItemTemplate const* pProto = pItem->GetTemplate();
        if (!pProto)
            continue;

        if (pProto->ItemLimitCategory == limitCategory)
        {
            tempcount += pItem->GetCount();
            if (tempcount >= count)
                return true;
        }

        if (pProto->Socket[0].Color || pItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT))
        {
            tempcount += pItem->GetGemCountWithLimitCategory(limitCategory);
            if (tempcount >= count)
                return true;
        }
    }

    return false;
}

InventoryResult Player::CanTakeMoreSimilarItems(uint32 entry, uint32 count, Item* pItem, uint32* no_space_count) const
{
    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(entry);
    if (!pProto)
    {
        if (no_space_count)
            *no_space_count = count;
        return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
    }

    // no maximum
    if ((pProto->MaxCount <= 0 && pProto->ItemLimitCategory == 0) || pProto->MaxCount == 2147483647)
        return EQUIP_ERR_OK;

    if (pProto->MaxCount > 0)
    {
        uint32 curcount = GetItemCount(pProto->ItemId, true, pItem);
        if (curcount + count > uint32(pProto->MaxCount))
        {
            if (no_space_count)
                *no_space_count = count + curcount - pProto->MaxCount;
            return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
        }
    }

    // check unique-equipped limit
    if (pProto->ItemLimitCategory)
    {
        ItemLimitCategoryEntry const* limitEntry = sItemLimitCategoryStore.LookupEntry(pProto->ItemLimitCategory);
        if (!limitEntry)
        {
            if (no_space_count)
                *no_space_count = count;
            return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;
        }

        if (limitEntry->mode == ITEM_LIMIT_CATEGORY_MODE_HAVE)
        {
            uint32 curcount = GetItemCountWithLimitCategory(pProto->ItemLimitCategory, pItem);
            if (curcount + count > uint32(limitEntry->maxCount))
            {
                if (no_space_count)
                    *no_space_count = count + curcount - limitEntry->maxCount;
                return EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_COUNT_EXCEEDED;
            }
        }
    }

    return EQUIP_ERR_OK;
}

bool Player::HasItemTotemCategory(uint32 TotemCategory) const
{
    Item* pItem;
    for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; ++i)
    {
        pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && IsTotemCategoryCompatiableWith(pItem->GetTemplate(), TotemCategory))
            return true;
    }
    for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
    {
        pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && IsTotemCategoryCompatiableWith(pItem->GetTemplate(), TotemCategory))
            return true;
    }
    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
    {
        if (Bag* pBag = GetBagByPos(i))
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
            {
                pItem = GetItemByPos(i, j);
                if (pItem && IsTotemCategoryCompatiableWith(pItem->GetTemplate(), TotemCategory))
                    return true;
            }
        }
    }
    return false;
}

bool Player::IsTotemCategoryCompatiableWith(ItemTemplate const* pProto, uint32 requiredTotemCategoryId) const
{
    if (requiredTotemCategoryId == 0)
        return true;
    if (pProto->TotemCategory == 0)
        return false;

    TotemCategoryEntry const* itemEntry = sTotemCategoryStore.LookupEntry(pProto->TotemCategory);
    if (!itemEntry)
        return false;
    TotemCategoryEntry const* reqEntry = sTotemCategoryStore.LookupEntry(requiredTotemCategoryId);
    if (!reqEntry)
        return false;

    if (itemEntry->categoryType != reqEntry->categoryType)
        return false;

    if ((itemEntry->categoryMask & reqEntry->categoryMask) != reqEntry->categoryMask)
        return false;

    // xinef: check skill requirements, needed for enchants!
    if (pProto->RequiredSkill)
        if (this->GetSkillValue(pProto->RequiredSkill) < pProto->RequiredSkillRank)
            return false;

    return true;
}

InventoryResult Player::CanStoreItem_InSpecificSlot(uint8 bag, uint8 slot, ItemPosCountVec& dest, ItemTemplate const* pProto, uint32& count, bool swap, Item* pSrcItem) const
{
    Item* pItem2 = GetItemByPos(bag, slot);

    // ignore move item (this slot will be empty at move)
    if (pItem2 == pSrcItem)
        pItem2 = nullptr;

    uint32 need_space;

    // empty specific slot - check item fit to slot
    if (!pItem2 || swap)
    {
        if (bag == INVENTORY_SLOT_BAG_0)
        {
            // keyring case
            if (slot >= KEYRING_SLOT_START && slot < KEYRING_SLOT_START + GetMaxKeyringSize() && !(pProto->BagFamily & BAG_FAMILY_MASK_KEYS))
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

            // currencytoken case
            if (slot >= CURRENCYTOKEN_SLOT_START && slot < CURRENCYTOKEN_SLOT_END && !(pProto->IsCurrencyToken()))
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

            // prevent cheating
            if ((slot >= BUYBACK_SLOT_START && slot < BUYBACK_SLOT_END) || slot >= PLAYER_SLOT_END)
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;
        }
        else
        {
            Bag* pBag = GetBagByPos(bag);
            if (!pBag)
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

            ItemTemplate const* pBagProto = pBag->GetTemplate();
            if (!pBagProto)
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

            if (slot >= pBagProto->ContainerSlots)
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

            if (!ItemCanGoIntoBag(pProto, pBagProto))
                return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;
        }

        // non empty stack with space
        need_space = pProto->GetMaxStackSize();
    }
        // non empty slot, check item type
    else
    {
        // can be merged at least partly
        InventoryResult res  = pItem2->CanBeMergedPartlyWith(pProto);
        if (res != EQUIP_ERR_OK)
            return res;

        // free stack space or infinity
        need_space = pProto->GetMaxStackSize() - pItem2->GetCount();
    }

    if (need_space > count)
        need_space = count;

    ItemPosCount newPosition = ItemPosCount((bag << 8) | slot, need_space);
    if (!newPosition.isContainedIn(dest))
    {
        dest.push_back(newPosition);
        count -= need_space;
    }
    return EQUIP_ERR_OK;
}

InventoryResult Player::CanStoreItem_InBag(uint8 bag, ItemPosCountVec& dest, ItemTemplate const* pProto, uint32& count, bool merge, bool non_specialized, Item* pSrcItem, uint8 skip_bag, uint8 skip_slot) const
{
    // skip specific bag already processed in first called CanStoreItem_InBag
    if (bag == skip_bag)
        return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

    // skip not existed bag or self targeted bag
    Bag* pBag = GetBagByPos(bag);
    if (!pBag || pBag == pSrcItem || (pSrcItem && (pSrcItem->GetGUID() == pBag->GetGUID())) )
        return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

    if (pSrcItem && pSrcItem->IsNotEmptyBag())
        return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

    ItemTemplate const* pBagProto = pBag->GetTemplate();
    if (!pBagProto)
        return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

    // specialized bag mode or non-specilized
    if (non_specialized != (pBagProto->Class == ITEM_CLASS_CONTAINER && pBagProto->SubClass == ITEM_SUBCLASS_CONTAINER))
        return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

    if (!ItemCanGoIntoBag(pProto, pBagProto))
        return EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG;

    for (uint32 j = 0; j < pBag->GetBagSize(); j++)
    {
        // skip specific slot already processed in first called CanStoreItem_InSpecificSlot
        if (j == skip_slot)
            continue;

        Item* pItem2 = GetItemByPos(bag, j);

        // ignore move item (this slot will be empty at move)
        if (pItem2 == pSrcItem)
            pItem2 = nullptr;

        // if merge skip empty, if !merge skip non-empty
        if ((pItem2 != nullptr) != merge)
            continue;

        uint32 need_space = pProto->GetMaxStackSize();

        if (pItem2)
        {
            // can be merged at least partly
            uint8 res  = pItem2->CanBeMergedPartlyWith(pProto);
            if (res != EQUIP_ERR_OK)
                continue;

            // descrease at current stacksize
            need_space -= pItem2->GetCount();
        }

        if (need_space > count)
            need_space = count;

        ItemPosCount newPosition = ItemPosCount((bag << 8) | j, need_space);
        if (!newPosition.isContainedIn(dest))
        {
            dest.push_back(newPosition);
            count -= need_space;

            if (count == 0)
                return EQUIP_ERR_OK;
        }
    }
    return EQUIP_ERR_OK;
}

InventoryResult Player::CanStoreItem_InInventorySlots(uint8 slot_begin, uint8 slot_end, ItemPosCountVec& dest, ItemTemplate const* pProto, uint32& count, bool merge, Item* pSrcItem, uint8 skip_bag, uint8 skip_slot) const
{
    //this is never called for non-bag slots so we can do this
    if (pSrcItem && pSrcItem->IsNotEmptyBag())
        return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

    for (uint32 j = slot_begin; j < slot_end; j++)
    {
        // skip specific slot already processed in first called CanStoreItem_InSpecificSlot
        if (INVENTORY_SLOT_BAG_0 == skip_bag && j == skip_slot)
            continue;

        Item* pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, j);

        // ignore move item (this slot will be empty at move)
        if (pItem2 == pSrcItem)
            pItem2 = nullptr;

        // if merge skip empty, if !merge skip non-empty
        if ((pItem2 != nullptr) != merge)
            continue;

        uint32 need_space = pProto->GetMaxStackSize();

        if (pItem2)
        {
            // can be merged at least partly
            uint8 res  = pItem2->CanBeMergedPartlyWith(pProto);
            if (res != EQUIP_ERR_OK)
                continue;

            // descrease at current stacksize
            need_space -= pItem2->GetCount();
        }

        if (need_space > count)
            need_space = count;

        ItemPosCount newPosition = ItemPosCount((INVENTORY_SLOT_BAG_0 << 8) | j, need_space);
        if (!newPosition.isContainedIn(dest))
        {
            dest.push_back(newPosition);
            count -= need_space;

            if (count == 0)
                return EQUIP_ERR_OK;
        }
    }
    return EQUIP_ERR_OK;
}

InventoryResult Player::CanStoreItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, uint32 entry, uint32 count, Item* pItem, bool swap, uint32* no_space_count) const
{
    LOG_DEBUG("entities.player.items", "STORAGE: CanStoreItem bag = {}, slot = {}, item = {}, count = {}", bag, slot, entry, count);

    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(entry);
    if (!pProto)
    {
        if (no_space_count)
            *no_space_count = count;
        return swap ? EQUIP_ERR_ITEMS_CANT_BE_SWAPPED : EQUIP_ERR_ITEM_NOT_FOUND;
    }

    if (pItem)
    {
        // you bad chet0rz, wpe pro
        if( bag == NULL_BAG && slot == NULL_SLOT )
            if( pItem->IsBag() && pItem->IsNotEmptyBag() )
                return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

        // Xinef: Removed next loot generated check
        if (pItem->GetGUID() == GetLootGUID())
        {
            if (no_space_count)
                *no_space_count = count;
            return EQUIP_ERR_ALREADY_LOOTED;
        }

        if (pItem->IsBindedNotWith(this))
        {
            if (no_space_count)
                *no_space_count = count;
            return EQUIP_ERR_DONT_OWN_THAT_ITEM;
        }
    }

    // check count of items (skip for auto move for same player from bank)
    uint32 no_similar_count = 0;                            // can't store this amount similar items
    InventoryResult res = CanTakeMoreSimilarItems(entry, count, pItem, &no_similar_count);
    if (res != EQUIP_ERR_OK)
    {
        if (count == no_similar_count)
        {
            if (no_space_count)
                *no_space_count = no_similar_count;
            return res;
        }
        count -= no_similar_count;
    }

    // in specific slot
    if (bag != NULL_BAG && slot != NULL_SLOT)
    {
        res = CanStoreItem_InSpecificSlot(bag, slot, dest, pProto, count, swap, pItem);
        if (res != EQUIP_ERR_OK)
        {
            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return res;
        }

        if (count == 0)
        {
            if (no_similar_count == 0)
                return EQUIP_ERR_OK;

            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
        }
    }

    // not specific slot or have space for partly store only in specific slot

    // in specific bag
    if (bag != NULL_BAG)
    {
        // search stack in bag for merge to
        if (pProto->Stackable != 1)
        {
            if (bag == INVENTORY_SLOT_BAG_0)               // inventory
            {
                res = CanStoreItem_InInventorySlots(KEYRING_SLOT_START, CURRENCYTOKEN_SLOT_END, dest, pProto, count, true, pItem, bag, slot);
                if (res != EQUIP_ERR_OK)
                {
                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return res;
                }

                if (count == 0)
                {
                    if (no_similar_count == 0)
                        return EQUIP_ERR_OK;

                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
                }

                res = CanStoreItem_InInventorySlots(INVENTORY_SLOT_ITEM_START, INVENTORY_SLOT_ITEM_END, dest, pProto, count, true, pItem, bag, slot);
                if (res != EQUIP_ERR_OK)
                {
                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return res;
                }

                if (count == 0)
                {
                    if (no_similar_count == 0)
                        return EQUIP_ERR_OK;

                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
                }
            }
            else                                            // equipped bag
            {
                // we need check 2 time (specialized/non_specialized), use NULL_BAG to prevent skipping bag
                res = CanStoreItem_InBag(bag, dest, pProto, count, true, false, pItem, NULL_BAG, slot);
                if (res != EQUIP_ERR_OK)
                    res = CanStoreItem_InBag(bag, dest, pProto, count, true, true, pItem, NULL_BAG, slot);

                if (res != EQUIP_ERR_OK)
                {
                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return res;
                }

                if (count == 0)
                {
                    if (no_similar_count == 0)
                        return EQUIP_ERR_OK;

                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
                }
            }
        }

        // search free slot in bag for place to
        if (bag == INVENTORY_SLOT_BAG_0)                     // inventory
        {
            // search free slot - keyring case
            if (pProto->BagFamily & BAG_FAMILY_MASK_KEYS)
            {
                uint32 keyringSize = GetMaxKeyringSize();
                res = CanStoreItem_InInventorySlots(KEYRING_SLOT_START, KEYRING_SLOT_START + keyringSize, dest, pProto, count, false, pItem, bag, slot);
                if (res != EQUIP_ERR_OK)
                {
                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return res;
                }

                if (count == 0)
                {
                    if (no_similar_count == 0)
                        return EQUIP_ERR_OK;

                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
                }

                res = CanStoreItem_InInventorySlots(CURRENCYTOKEN_SLOT_START, CURRENCYTOKEN_SLOT_END, dest, pProto, count, false, pItem, bag, slot);
                if (res != EQUIP_ERR_OK)
                {
                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return res;
                }

                if (count == 0)
                {
                    if (no_similar_count == 0)
                        return EQUIP_ERR_OK;

                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
                }
            }
            else if (pProto->IsCurrencyToken())
            {
                res = CanStoreItem_InInventorySlots(CURRENCYTOKEN_SLOT_START, CURRENCYTOKEN_SLOT_END, dest, pProto, count, false, pItem, bag, slot);
                if (res != EQUIP_ERR_OK)
                {
                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return res;
                }

                if (count == 0)
                {
                    if (no_similar_count == 0)
                        return EQUIP_ERR_OK;

                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
                }
            }

            res = CanStoreItem_InInventorySlots(INVENTORY_SLOT_ITEM_START, INVENTORY_SLOT_ITEM_END, dest, pProto, count, false, pItem, bag, slot);
            if (res != EQUIP_ERR_OK)
            {
                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return res;
            }

            if (count == 0)
            {
                if (no_similar_count == 0)
                    return EQUIP_ERR_OK;

                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
            }
        }
        else                                                // equipped bag
        {
            res = CanStoreItem_InBag(bag, dest, pProto, count, false, false, pItem, NULL_BAG, slot);
            if (res != EQUIP_ERR_OK)
                res = CanStoreItem_InBag(bag, dest, pProto, count, false, true, pItem, NULL_BAG, slot);

            if (res != EQUIP_ERR_OK)
            {
                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return res;
            }

            if (count == 0)
            {
                if (no_similar_count == 0)
                    return EQUIP_ERR_OK;

                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
            }
        }
    }

    // not specific bag or have space for partly store only in specific bag

    // search stack for merge to
    if (pProto->Stackable != 1)
    {
        res = CanStoreItem_InInventorySlots(KEYRING_SLOT_START, CURRENCYTOKEN_SLOT_END, dest, pProto, count, true, pItem, bag, slot);
        if (res != EQUIP_ERR_OK)
        {
            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return res;
        }

        if (count == 0)
        {
            if (no_similar_count == 0)
                return EQUIP_ERR_OK;

            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
        }

        res = CanStoreItem_InInventorySlots(INVENTORY_SLOT_ITEM_START, INVENTORY_SLOT_ITEM_END, dest, pProto, count, true, pItem, bag, slot);
        if (res != EQUIP_ERR_OK)
        {
            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return res;
        }

        if (count == 0)
        {
            if (no_similar_count == 0)
                return EQUIP_ERR_OK;

            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
        }

        if (pProto->BagFamily)
        {
            for (uint32 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
            {
                res = CanStoreItem_InBag(i, dest, pProto, count, true, false, pItem, bag, slot);
                if (res != EQUIP_ERR_OK)
                    continue;

                if (count == 0)
                {
                    if (no_similar_count == 0)
                        return EQUIP_ERR_OK;

                    if (no_space_count)
                        *no_space_count = count + no_similar_count;
                    return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
                }
            }
        }

        for (uint32 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        {
            res = CanStoreItem_InBag(i, dest, pProto, count, true, true, pItem, bag, slot);
            if (res != EQUIP_ERR_OK)
                continue;

            if (count == 0)
            {
                if (no_similar_count == 0)
                    return EQUIP_ERR_OK;

                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
            }
        }
    }

    // search free slot - special bag case
    if (pProto->BagFamily)
    {
        if (pProto->BagFamily & BAG_FAMILY_MASK_KEYS)
        {
            uint32 keyringSize = GetMaxKeyringSize();
            res = CanStoreItem_InInventorySlots(KEYRING_SLOT_START, KEYRING_SLOT_START + keyringSize, dest, pProto, count, false, pItem, bag, slot);
            if (res != EQUIP_ERR_OK)
            {
                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return res;
            }

            if (count == 0)
            {
                if (no_similar_count == 0)
                    return EQUIP_ERR_OK;

                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
            }
        }
        else if (pProto->IsCurrencyToken())
        {
            res = CanStoreItem_InInventorySlots(CURRENCYTOKEN_SLOT_START, CURRENCYTOKEN_SLOT_END, dest, pProto, count, false, pItem, bag, slot);
            if (res != EQUIP_ERR_OK)
            {
                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return res;
            }

            if (count == 0)
            {
                if (no_similar_count == 0)
                    return EQUIP_ERR_OK;

                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
            }
        }

        for (uint32 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        {
            res = CanStoreItem_InBag(i, dest, pProto, count, false, false, pItem, bag, slot);
            if (res != EQUIP_ERR_OK)
                continue;

            if (count == 0)
            {
                if (no_similar_count == 0)
                    return EQUIP_ERR_OK;

                if (no_space_count)
                    *no_space_count = count + no_similar_count;
                return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
            }
        }
    }

    if (pItem && pItem->IsNotEmptyBag())
        return EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG;

    // search free slot
    res = CanStoreItem_InInventorySlots(INVENTORY_SLOT_ITEM_START, INVENTORY_SLOT_ITEM_END, dest, pProto, count, false, pItem, bag, slot);
    if (res != EQUIP_ERR_OK)
    {
        if (no_space_count)
            *no_space_count = count + no_similar_count;
        return res;
    }

    if (count == 0)
    {
        if (no_similar_count == 0)
            return EQUIP_ERR_OK;

        if (no_space_count)
            *no_space_count = count + no_similar_count;
        return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
    }

    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        res = CanStoreItem_InBag(i, dest, pProto, count, false, true, pItem, bag, slot);
        if (res != EQUIP_ERR_OK)
            continue;

        if (count == 0)
        {
            if (no_similar_count == 0)
                return EQUIP_ERR_OK;

            if (no_space_count)
                *no_space_count = count + no_similar_count;
            return EQUIP_ERR_CANT_CARRY_MORE_OF_THIS;
        }
    }

    if (no_space_count)
        *no_space_count = count + no_similar_count;

    return EQUIP_ERR_INVENTORY_FULL;
}

//////////////////////////////////////////////////////////////////////////
InventoryResult Player::CanStoreItems(Item** pItems, int count) const
{
    Item* pItem2;

    // fill space table
    int inv_slot_items[INVENTORY_SLOT_ITEM_END - INVENTORY_SLOT_ITEM_START];
    int inv_bags[INVENTORY_SLOT_BAG_END - INVENTORY_SLOT_BAG_START][MAX_BAG_SIZE];
    int inv_keys[KEYRING_SLOT_END - KEYRING_SLOT_START];
    int inv_tokens[CURRENCYTOKEN_SLOT_END - CURRENCYTOKEN_SLOT_START];

    memset(inv_slot_items, 0, sizeof(int) * (INVENTORY_SLOT_ITEM_END - INVENTORY_SLOT_ITEM_START));
    memset(inv_bags, 0, sizeof(int) * (INVENTORY_SLOT_BAG_END - INVENTORY_SLOT_BAG_START) * MAX_BAG_SIZE);
    memset(inv_keys, 0, sizeof(int) * (KEYRING_SLOT_END - KEYRING_SLOT_START));
    memset(inv_tokens, 0, sizeof(int) * (CURRENCYTOKEN_SLOT_END - CURRENCYTOKEN_SLOT_START));

    for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem2 && !pItem2->IsInTrade())
            inv_slot_items[i - INVENTORY_SLOT_ITEM_START] = pItem2->GetCount();
    }

    for (uint8 i = KEYRING_SLOT_START; i < KEYRING_SLOT_END; i++)
    {
        pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem2 && !pItem2->IsInTrade())
            inv_keys[i - KEYRING_SLOT_START] = pItem2->GetCount();
    }

    for (uint8 i = CURRENCYTOKEN_SLOT_START; i < CURRENCYTOKEN_SLOT_END; i++)
    {
        pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem2 && !pItem2->IsInTrade())
            inv_tokens[i - CURRENCYTOKEN_SLOT_START] = pItem2->GetCount();
    }

    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        if (Bag* pBag = GetBagByPos(i))
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
            {
                pItem2 = GetItemByPos(i, j);
                if (pItem2 && !pItem2->IsInTrade())
                    inv_bags[i - INVENTORY_SLOT_BAG_START][j] = pItem2->GetCount();
            }

    // check free space for all items
    for (int k = 0; k < count; ++k)
    {
        Item* pItem = pItems[k];

        // no item
        if (!pItem)
            continue;

        LOG_DEBUG("entities.player.items", "STORAGE: CanStoreItems {}. item = {}, count = {}", k + 1, pItem->GetEntry(), pItem->GetCount());
        ItemTemplate const* pProto = pItem->GetTemplate();

        // strange item
        if (!pProto)
            return EQUIP_ERR_ITEM_NOT_FOUND;

        // Xinef: Removed next loot generated check
        if (pItem->GetGUID() == GetLootGUID())
            return EQUIP_ERR_ALREADY_LOOTED;

        // item it 'bind'
        if (pItem->IsBindedNotWith(this))
            return EQUIP_ERR_DONT_OWN_THAT_ITEM;

        ItemTemplate const* pBagProto;

        // item is 'one item only'
        InventoryResult res = CanTakeMoreSimilarItems(pItem);
        if (res != EQUIP_ERR_OK)
            return res;

        // search stack for merge to
        if (pProto->Stackable != 1)
        {
            bool b_found = false;

            for (uint8 t = KEYRING_SLOT_START; t < KEYRING_SLOT_END; ++t)
            {
                pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, t);
                if (pItem2 && pItem2->CanBeMergedPartlyWith(pProto) == EQUIP_ERR_OK && inv_keys[t - KEYRING_SLOT_START] + pItem->GetCount() <= pProto->GetMaxStackSize())
                {
                    inv_keys[t - KEYRING_SLOT_START] += pItem->GetCount();
                    b_found = true;
                    break;
                }
            }
            if (b_found)
                continue;

            for (int t = CURRENCYTOKEN_SLOT_START; t < CURRENCYTOKEN_SLOT_END; ++t)
            {
                pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, t);
                if (pItem2 && pItem2->CanBeMergedPartlyWith(pProto) == EQUIP_ERR_OK && inv_tokens[t - CURRENCYTOKEN_SLOT_START] + pItem->GetCount() <= pProto->GetMaxStackSize())
                {
                    inv_tokens[t - CURRENCYTOKEN_SLOT_START] += pItem->GetCount();
                    b_found = true;
                    break;
                }
            }
            if (b_found)
                continue;

            for (int t = INVENTORY_SLOT_ITEM_START; t < INVENTORY_SLOT_ITEM_END; ++t)
            {
                pItem2 = GetItemByPos(INVENTORY_SLOT_BAG_0, t);
                if (pItem2 && pItem2->CanBeMergedPartlyWith(pProto) == EQUIP_ERR_OK && inv_slot_items[t - INVENTORY_SLOT_ITEM_START] + pItem->GetCount() <= pProto->GetMaxStackSize())
                {
                    inv_slot_items[t - INVENTORY_SLOT_ITEM_START] += pItem->GetCount();
                    b_found = true;
                    break;
                }
            }
            if (b_found)
                continue;

            for (int t = INVENTORY_SLOT_BAG_START; !b_found && t < INVENTORY_SLOT_BAG_END; ++t)
            {
                if (Bag* bag = GetBagByPos(t))
                {
                    if (ItemCanGoIntoBag(pItem->GetTemplate(), bag->GetTemplate()))
                    {
                        for (uint32 j = 0; j < bag->GetBagSize(); j++)
                        {
                            pItem2 = GetItemByPos(t, j);
                            if (pItem2 && pItem2->CanBeMergedPartlyWith(pProto) == EQUIP_ERR_OK && inv_bags[t - INVENTORY_SLOT_BAG_START][j] + pItem->GetCount() <= pProto->GetMaxStackSize())
                            {
                                inv_bags[t - INVENTORY_SLOT_BAG_START][j] += pItem->GetCount();
                                b_found = true;
                                break;
                            }
                        }
                    }
                }
            }
            if (b_found)
                continue;
        }

        // special bag case
        if (pProto->BagFamily)
        {
            bool b_found = false;
            if (pProto->BagFamily & BAG_FAMILY_MASK_KEYS)
            {
                uint32 keyringSize = GetMaxKeyringSize();
                for (uint32 t = KEYRING_SLOT_START; t < KEYRING_SLOT_START + keyringSize; ++t)
                {
                    if (inv_keys[t - KEYRING_SLOT_START] == 0)
                    {
                        inv_keys[t - KEYRING_SLOT_START] = 1;
                        b_found = true;
                        break;
                    }
                }
            }

            if (b_found)
                continue;

            if (pProto->IsCurrencyToken())
            {
                for (uint32 t = CURRENCYTOKEN_SLOT_START; t < CURRENCYTOKEN_SLOT_END; ++t)
                {
                    if (inv_tokens[t - CURRENCYTOKEN_SLOT_START] == 0)
                    {
                        inv_tokens[t - CURRENCYTOKEN_SLOT_START] = 1;
                        b_found = true;
                        break;
                    }
                }
            }

            if (b_found)
                continue;

            for (int t = INVENTORY_SLOT_BAG_START; !b_found && t < INVENTORY_SLOT_BAG_END; ++t)
            {
                if (Bag* bag = GetBagByPos(t))
                {
                    pBagProto = bag->GetTemplate();

                    // not plain container check
                    if (pBagProto && (pBagProto->Class != ITEM_CLASS_CONTAINER || pBagProto->SubClass != ITEM_SUBCLASS_CONTAINER) &&
                        ItemCanGoIntoBag(pProto, pBagProto))
                    {
                        for (uint32 j = 0; j < bag->GetBagSize(); j++)
                        {
                            if (inv_bags[t - INVENTORY_SLOT_BAG_START][j] == 0)
                            {
                                inv_bags[t - INVENTORY_SLOT_BAG_START][j] = 1;
                                b_found = true;
                                break;
                            }
                        }
                    }
                }
            }
            if (b_found)
                continue;
        }

        // search free slot
        bool b_found = false;
        for (int t = INVENTORY_SLOT_ITEM_START; t < INVENTORY_SLOT_ITEM_END; ++t)
        {
            if (inv_slot_items[t - INVENTORY_SLOT_ITEM_START] == 0)
            {
                inv_slot_items[t - INVENTORY_SLOT_ITEM_START] = 1;
                b_found = true;
                break;
            }
        }
        if (b_found)
            continue;

        // search free slot in bags
        for (int t = INVENTORY_SLOT_BAG_START; !b_found && t < INVENTORY_SLOT_BAG_END; ++t)
        {
            if (Bag* bag = GetBagByPos(t))
            {
                pBagProto = bag->GetTemplate();

                // special bag already checked
                if (pBagProto && (pBagProto->Class != ITEM_CLASS_CONTAINER || pBagProto->SubClass != ITEM_SUBCLASS_CONTAINER))
                    continue;

                for (uint32 j = 0; j < bag->GetBagSize(); j++)
                {
                    if (inv_bags[t - INVENTORY_SLOT_BAG_START][j] == 0)
                    {
                        inv_bags[t - INVENTORY_SLOT_BAG_START][j] = 1;
                        b_found = true;
                        break;
                    }
                }
            }
        }

        // no free slot found?
        if (!b_found)
            return EQUIP_ERR_INVENTORY_FULL;
    }

    return EQUIP_ERR_OK;
}

//////////////////////////////////////////////////////////////////////////
InventoryResult Player::CanEquipNewItem(uint8 slot, uint16& dest, uint32 item, bool swap) const
{
    dest = 0;
    Item* pItem = Item::CreateItem(item, 1, this);
    if (pItem)
    {
        InventoryResult result = CanEquipItem(slot, dest, pItem, swap);
        delete pItem;
        return result;
    }

    return EQUIP_ERR_ITEM_NOT_FOUND;
}

InventoryResult Player::CanEquipItem(uint8 slot, uint16& dest, Item* pItem, bool swap, bool not_loading) const
{
    dest = 0;
    if (pItem)
    {
        LOG_DEBUG("entities.player.items", "STORAGE: CanEquipItem slot = {}, item = {}, count = {}", slot, pItem->GetEntry(), pItem->GetCount());
        ItemTemplate const* pProto = pItem->GetTemplate();
        if (pProto)
        {
            if (!sScriptMgr->CanEquipItem(const_cast<Player*>(this), slot, dest, pItem, swap, not_loading))
                return EQUIP_ERR_CANT_DO_RIGHT_NOW;

            // item used
            if (pItem->m_lootGenerated)
                return EQUIP_ERR_ALREADY_LOOTED;

            if (pItem->IsBindedNotWith(this))
                return EQUIP_ERR_DONT_OWN_THAT_ITEM;

            // check count of items (skip for auto move for same player from bank)
            InventoryResult res = CanTakeMoreSimilarItems(pItem);
            if (res != EQUIP_ERR_OK)
                return res;

            // check this only in game
            if (not_loading)
            {
                // May be here should be more stronger checks; STUNNED checked
                // ROOT, CONFUSED, DISTRACTED, FLEEING this needs to be checked.
                if (HasUnitState(UNIT_STATE_STUNNED))
                    return EQUIP_ERR_YOU_ARE_STUNNED;

                // do not allow equipping gear except weapons, offhands, projectiles, relics in
                // - combat
                // - in-progress arenas
                if (!pProto->CanChangeEquipStateInCombat())
                {
                    if (IsInCombat())
                        return EQUIP_ERR_NOT_IN_COMBAT;

                    if (Battleground* bg = GetBattleground())
                        if (bg->isArena() && bg->GetStatus() == STATUS_IN_PROGRESS)
                            return EQUIP_ERR_NOT_DURING_ARENA_MATCH;
                }

                if (IsInCombat() && (pProto->Class == ITEM_CLASS_WEAPON || pProto->InventoryType == INVTYPE_RELIC) && m_weaponChangeTimer != 0)
                    return EQUIP_ERR_CANT_DO_RIGHT_NOW;         // maybe exist better err

                if (IsNonMeleeSpellCast(false))
                    return EQUIP_ERR_CANT_DO_RIGHT_NOW;
            }

            ScalingStatDistributionEntry const* ssd = pProto->ScalingStatDistribution ? sScalingStatDistributionStore.LookupEntry(pProto->ScalingStatDistribution) : 0;
            // check allowed level (extend range to upper values if MaxLevel more or equal max player level, this let GM set high level with 1...max range items)
            if (ssd && ssd->MaxLevel < DEFAULT_MAX_LEVEL && ssd->MaxLevel < GetLevel())
                return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;

            uint8 eslot = FindEquipSlot(pProto, slot, swap);
            if (eslot == NULL_SLOT)
                return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;

            // Xinef: dont allow to equip items on disarmed slot
            if (!CanUseAttackType(GetAttackBySlot(eslot)))
                return EQUIP_ERR_NOT_WHILE_DISARMED;

            res = CanUseItem(pItem, not_loading);
            if (res != EQUIP_ERR_OK)
                return res;

            if (!swap && GetItemByPos(INVENTORY_SLOT_BAG_0, eslot))
                return EQUIP_ERR_NO_EQUIPMENT_SLOT_AVAILABLE;

            // if we are swapping 2 equiped items, CanEquipUniqueItem check
            // should ignore the item we are trying to swap, and not the
            // destination item. CanEquipUniqueItem should ignore destination
            // item only when we are swapping weapon from bag
            uint8 ignore = uint8(NULL_SLOT);
            switch (eslot)
            {
                case EQUIPMENT_SLOT_MAINHAND:
                    ignore = EQUIPMENT_SLOT_OFFHAND;
                    break;
                case EQUIPMENT_SLOT_OFFHAND:
                    ignore = EQUIPMENT_SLOT_MAINHAND;
                    break;
                case EQUIPMENT_SLOT_FINGER1:
                    ignore = EQUIPMENT_SLOT_FINGER2;
                    break;
                case EQUIPMENT_SLOT_FINGER2:
                    ignore = EQUIPMENT_SLOT_FINGER1;
                    break;
                case EQUIPMENT_SLOT_TRINKET1:
                    ignore = EQUIPMENT_SLOT_TRINKET2;
                    break;
                case EQUIPMENT_SLOT_TRINKET2:
                    ignore = EQUIPMENT_SLOT_TRINKET1;
                    break;
            }

            if (ignore == uint8(NULL_SLOT) || pItem != GetItemByPos(INVENTORY_SLOT_BAG_0, ignore))
                ignore = eslot;

            InventoryResult res2 = CanEquipUniqueItem(pItem, swap ? ignore : uint8(NULL_SLOT));
            if (res2 != EQUIP_ERR_OK)
                return res2;

            // check unique-equipped special item classes
            if (pProto->Class == ITEM_CLASS_QUIVER)
                for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
                    if (Item* pBag = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                        if (pBag != pItem)
                            if (ItemTemplate const* pBagProto = pBag->GetTemplate())
                                if (pBagProto->Class == pProto->Class && (!swap || pBag->GetSlot() != eslot))
                                    return (pBagProto->SubClass == ITEM_SUBCLASS_AMMO_POUCH)
                                           ? EQUIP_ERR_CAN_EQUIP_ONLY1_AMMOPOUCH
                                           : EQUIP_ERR_CAN_EQUIP_ONLY1_QUIVER;

            uint32 type = pProto->InventoryType;

            if (eslot == EQUIPMENT_SLOT_OFFHAND)
            {
                // Do not allow polearm to be equipped in the offhand (rare case for the only 1h polearm 41750)
                // xinef: same for fishing poles
                if (type == INVTYPE_WEAPON && (pProto->SubClass == ITEM_SUBCLASS_WEAPON_POLEARM || pProto->SubClass == ITEM_SUBCLASS_WEAPON_FISHING_POLE))
                    return EQUIP_ERR_ITEM_DOESNT_GO_TO_SLOT;

                else if (type == INVTYPE_WEAPON || type == INVTYPE_WEAPONOFFHAND)
                {
                    if (!CanDualWield())
                        return EQUIP_ERR_CANT_DUAL_WIELD;
                }
                else if (type == INVTYPE_2HWEAPON)
                {
                    if (!CanDualWield() || !CanTitanGrip())
                        return EQUIP_ERR_CANT_DUAL_WIELD;
                }

                if (IsTwoHandUsed())
                    return EQUIP_ERR_CANT_EQUIP_WITH_TWOHANDED;
            }

            // equip two-hand weapon case (with possible unequip 2 items)
            if (type == INVTYPE_2HWEAPON)
            {
                if (eslot == EQUIPMENT_SLOT_OFFHAND)
                {
                    if (!CanTitanGrip())
                        return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;
                }
                else if (eslot != EQUIPMENT_SLOT_MAINHAND)
                    return EQUIP_ERR_ITEM_CANT_BE_EQUIPPED;

                if (!CanTitanGrip())
                {
                    // offhand item must can be stored in inventory for offhand item and it also must be unequipped
                    Item* offItem = GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
                    ItemPosCountVec off_dest;
                    if (offItem && (!not_loading ||
                                    CanUnequipItem(uint16(INVENTORY_SLOT_BAG_0) << 8 | EQUIPMENT_SLOT_OFFHAND, false) != EQUIP_ERR_OK ||
                                    CanStoreItem(NULL_BAG, NULL_SLOT, off_dest, offItem, false) != EQUIP_ERR_OK))
                        return swap ? EQUIP_ERR_ITEMS_CANT_BE_SWAPPED : EQUIP_ERR_INVENTORY_FULL;
                }
            }
            dest = ((INVENTORY_SLOT_BAG_0 << 8) | eslot);
            return EQUIP_ERR_OK;
        }
    }

    return !swap ? EQUIP_ERR_ITEM_NOT_FOUND : EQUIP_ERR_ITEMS_CANT_BE_SWAPPED;
}

InventoryResult Player::CanUnequipItem(uint16 pos, bool swap) const
{
    if (!sScriptMgr->CanUnequipItem(const_cast<Player*>(this), pos, swap))
        return EQUIP_ERR_CANT_DO_RIGHT_NOW;

    // Applied only to equipped items and bank bags
    if (!IsEquipmentPos(pos) && !IsBagPos(pos))
        return EQUIP_ERR_OK;

    Item* pItem = GetItemByPos(pos);

    // Applied only to existed equipped item
    if (!pItem)
        return EQUIP_ERR_OK;

    LOG_DEBUG("entities.player.items", "STORAGE: CanUnequipItem slot = {}, item = {}, count = {}", pos, pItem->GetEntry(), pItem->GetCount());

    ItemTemplate const* pProto = pItem->GetTemplate();
    if (!pProto)
        return EQUIP_ERR_ITEM_NOT_FOUND;

    // item used
    if (pItem->m_lootGenerated)
        return EQUIP_ERR_ALREADY_LOOTED;

    // do not allow unequipping gear except weapons, offhands, projectiles, relics in
    // - combat
    // - in-progress arenas
    if (!pProto->CanChangeEquipStateInCombat())
    {
        if (IsInCombat())
            return EQUIP_ERR_NOT_IN_COMBAT;

        if (Battleground* bg = GetBattleground())
            if (bg->isArena() && bg->GetStatus() == STATUS_IN_PROGRESS)
                return EQUIP_ERR_NOT_DURING_ARENA_MATCH;
    }

    // Xinef: dont allow to unequip items on disarmed slot
    if (!CanUseAttackType(GetAttackBySlot(pItem->GetSlot())))
        return EQUIP_ERR_NOT_WHILE_DISARMED;

    if (!swap && pItem->IsNotEmptyBag())
        return EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS;

    return EQUIP_ERR_OK;
}

InventoryResult Player::CanBankItem(uint8 bag, uint8 slot, ItemPosCountVec& dest, Item* pItem, bool swap, bool not_loading) const
{
    if (!pItem)
        return swap ? EQUIP_ERR_ITEMS_CANT_BE_SWAPPED : EQUIP_ERR_ITEM_NOT_FOUND;

    uint32 count = pItem->GetCount();

    LOG_DEBUG("entities.player.items", "STORAGE: CanBankItem bag = {}, slot = {}, item = {}, count = {}", bag, slot, pItem->GetEntry(), pItem->GetCount());
    ItemTemplate const* pProto = pItem->GetTemplate();
    if (!pProto)
        return swap ? EQUIP_ERR_ITEMS_CANT_BE_SWAPPED : EQUIP_ERR_ITEM_NOT_FOUND;

    // Xinef: Removed next loot generated check
    if (pItem->GetGUID() == GetLootGUID())
        return EQUIP_ERR_ALREADY_LOOTED;

    if (pItem->IsBindedNotWith(this))
        return EQUIP_ERR_DONT_OWN_THAT_ITEM;

    // Currency tokens are not supposed to be swapped out of their hidden bag
    uint8 pItemslot = pItem->GetSlot();
    if (pItemslot >= CURRENCYTOKEN_SLOT_START && pItemslot < CURRENCYTOKEN_SLOT_END)
    {
        LOG_ERROR("entities.player", "Possible hacking attempt: Player {} [{}] tried to move token [{}, entry: {}] out of the currency bag!",
                  GetName(), GetGUID().ToString(), pItem->GetGUID().ToString(), pProto->ItemId);
        return EQUIP_ERR_ITEMS_CANT_BE_SWAPPED;
    }

    // check count of items (skip for auto move for same player from bank)
    InventoryResult res = CanTakeMoreSimilarItems(pItem);
    if (res != EQUIP_ERR_OK)
        return res;

    // in specific slot
    if (bag != NULL_BAG && slot != NULL_SLOT)
    {
        if (slot >= BANK_SLOT_BAG_START && slot < BANK_SLOT_BAG_END)
        {
            if (!pItem->IsBag())
                return EQUIP_ERR_ITEM_DOESNT_GO_TO_SLOT;

            if (slot - BANK_SLOT_BAG_START >= GetBankBagSlotCount())
                return EQUIP_ERR_MUST_PURCHASE_THAT_BAG_SLOT;

            res = CanUseItem(pItem, not_loading);
            if (res != EQUIP_ERR_OK)
                return res;
        }

        res = CanStoreItem_InSpecificSlot(bag, slot, dest, pProto, count, swap, pItem);
        if (res != EQUIP_ERR_OK)
            return res;

        if (count == 0)
            return EQUIP_ERR_OK;
    }

    // not specific slot or have space for partly store only in specific slot

    // in specific bag
    if (bag != NULL_BAG)
    {
        if (pItem->IsNotEmptyBag())
            return EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG;

        // search stack in bag for merge to
        if (pProto->Stackable != 1)
        {
            if (bag == INVENTORY_SLOT_BAG_0)
            {
                res = CanStoreItem_InInventorySlots(BANK_SLOT_ITEM_START, BANK_SLOT_ITEM_END, dest, pProto, count, true, pItem, bag, slot);
                if (res != EQUIP_ERR_OK)
                    return res;

                if (count == 0)
                    return EQUIP_ERR_OK;
            }
            else
            {
                res = CanStoreItem_InBag(bag, dest, pProto, count, true, false, pItem, NULL_BAG, slot);
                if (res != EQUIP_ERR_OK)
                    res = CanStoreItem_InBag(bag, dest, pProto, count, true, true, pItem, NULL_BAG, slot);

                if (res != EQUIP_ERR_OK)
                    return res;

                if (count == 0)
                    return EQUIP_ERR_OK;
            }
        }

        // search free slot in bag
        if (bag == INVENTORY_SLOT_BAG_0)
        {
            res = CanStoreItem_InInventorySlots(BANK_SLOT_ITEM_START, BANK_SLOT_ITEM_END, dest, pProto, count, false, pItem, bag, slot);
            if (res != EQUIP_ERR_OK)
                return res;

            if (count == 0)
                return EQUIP_ERR_OK;
        }
        else
        {
            res = CanStoreItem_InBag(bag, dest, pProto, count, false, false, pItem, NULL_BAG, slot);
            if (res != EQUIP_ERR_OK)
                res = CanStoreItem_InBag(bag, dest, pProto, count, false, true, pItem, NULL_BAG, slot);

            if (res != EQUIP_ERR_OK)
                return res;

            if (count == 0)
                return EQUIP_ERR_OK;
        }
    }

    // not specific bag or have space for partly store only in specific bag

    // search stack for merge to
    if (pProto->Stackable != 1)
    {
        // in slots
        res = CanStoreItem_InInventorySlots(BANK_SLOT_ITEM_START, BANK_SLOT_ITEM_END, dest, pProto, count, true, pItem, bag, slot);
        if (res != EQUIP_ERR_OK)
            return res;

        if (count == 0)
            return EQUIP_ERR_OK;

        // in special bags
        if (pProto->BagFamily)
        {
            for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
            {
                res = CanStoreItem_InBag(i, dest, pProto, count, true, false, pItem, bag, slot);
                if (res != EQUIP_ERR_OK)
                    continue;

                if (count == 0)
                    return EQUIP_ERR_OK;
            }
        }

        for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
        {
            res = CanStoreItem_InBag(i, dest, pProto, count, true, true, pItem, bag, slot);
            if (res != EQUIP_ERR_OK)
                continue;

            if (count == 0)
                return EQUIP_ERR_OK;
        }
    }

    // search free place in special bag
    if (pProto->BagFamily)
    {
        for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
        {
            res = CanStoreItem_InBag(i, dest, pProto, count, false, false, pItem, bag, slot);
            if (res != EQUIP_ERR_OK)
                continue;

            if (count == 0)
                return EQUIP_ERR_OK;
        }
    }

    // search free space
    res = CanStoreItem_InInventorySlots(BANK_SLOT_ITEM_START, BANK_SLOT_ITEM_END, dest, pProto, count, false, pItem, bag, slot);
    if (res != EQUIP_ERR_OK)
        return res;

    if (count == 0)
        return EQUIP_ERR_OK;

    for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
    {
        res = CanStoreItem_InBag(i, dest, pProto, count, false, true, pItem, bag, slot);
        if (res != EQUIP_ERR_OK)
            continue;

        if (count == 0)
            return EQUIP_ERR_OK;
    }
    return EQUIP_ERR_BANK_FULL;
}

InventoryResult Player::CanUseItem(Item* pItem, bool not_loading) const
{
    if (pItem)
    {
        LOG_DEBUG("entities.player.items", "STORAGE: CanUseItem item = {}", pItem->GetEntry());

        if (!IsAlive() && not_loading)
            return EQUIP_ERR_YOU_ARE_DEAD;

        //if (isStunned())
        //    return EQUIP_ERR_YOU_ARE_STUNNED;

        ItemTemplate const* pProto = pItem->GetTemplate();
        if (pProto)
        {
            if (pItem->IsBindedNotWith(this))
                return EQUIP_ERR_DONT_OWN_THAT_ITEM;

            InventoryResult res = CanUseItem(pProto);
            if (res != EQUIP_ERR_OK)
                return res;

            if (pItem->GetSkill() != 0)
            {
                bool allowEquip = false;
                uint32 itemSkill = pItem->GetSkill();
                // Armor that is binded to account can "morph" from plate to mail, etc. if skill is not learned yet.
                if (pProto->Quality == ITEM_QUALITY_HEIRLOOM && pProto->Class == ITEM_CLASS_ARMOR && !HasSkill(itemSkill))
                {
                    /// @todo: when you right-click already equipped item it throws EQUIP_ERR_NO_REQUIRED_PROFICIENCY.

                    // In fact it's a visual bug, everything works properly... I need sniffs of operations with
                    // binded to account items from off server.

                    if (IsClass(CLASS_PALADIN, CLASS_CONTEXT_EQUIP_ARMOR_CLASS) || IsClass(CLASS_WARRIOR, CLASS_CONTEXT_EQUIP_ARMOR_CLASS))
                    {
                        allowEquip = (itemSkill == SKILL_PLATE_MAIL);
                    }
                    else if (IsClass(CLASS_HUNTER, CLASS_CONTEXT_EQUIP_ARMOR_CLASS) || IsClass(CLASS_SHAMAN, CLASS_CONTEXT_EQUIP_ARMOR_CLASS))
                    {
                        allowEquip = (itemSkill == SKILL_MAIL);
                    }
                }
                if (!allowEquip && GetSkillValue(itemSkill) == 0)
                    return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
            }

            if (pProto->RequiredReputationFaction && uint32(GetReputationRank(pProto->RequiredReputationFaction)) < pProto->RequiredReputationRank)
                return EQUIP_ERR_CANT_EQUIP_REPUTATION;

            return EQUIP_ERR_OK;
        }
    }
    return EQUIP_ERR_ITEM_NOT_FOUND;
}

InventoryResult Player::CanUseItem(ItemTemplate const* proto) const
{
    // Used by group, function NeedBeforeGreed, to know if a prototype can be used by a player

    if (!proto)
    {
        return EQUIP_ERR_ITEM_NOT_FOUND;
    }

    if ((proto->Flags2 & ITEM_FLAGS_EXTRA_HORDE_ONLY) && GetTeamId(true) != TEAM_HORDE)
    {
        return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;
    }

    if ((proto->Flags2 & ITEM_FLAGS_EXTRA_ALLIANCE_ONLY) && GetTeamId(true) != TEAM_ALLIANCE)
    {
        return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;
    }

    if ((proto->AllowableClass & getClassMask()) == 0 || (proto->AllowableRace & getRaceMask()) == 0)
    {
        return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;
    }

    if (proto->RequiredSkill != 0)
    {
        if (GetSkillValue(proto->RequiredSkill) == 0)
        {
            return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
        }
        else if (GetSkillValue(proto->RequiredSkill) < proto->RequiredSkillRank)
        {
            return EQUIP_ERR_CANT_EQUIP_SKILL;
        }
    }

    if (proto->RequiredSpell != 0 && !HasSpell(proto->RequiredSpell))
    {
        return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
    }

    if (GetLevel() < proto->RequiredLevel)
    {
        return EQUIP_ERR_CANT_EQUIP_LEVEL_I;
    }

    // If World Event is not active, prevent using event dependant items
    if (proto->HolidayId && !IsHolidayActive((HolidayIds)proto->HolidayId))
    {
        return EQUIP_ERR_CANT_DO_RIGHT_NOW;
    }

    InventoryResult result = EQUIP_ERR_OK;

    if (!sScriptMgr->CanUseItem(const_cast<Player*>(this), proto, result))
    {
        return result;
    }

    return EQUIP_ERR_OK;
}

InventoryResult Player::CanRollForItemInLFG(ItemTemplate const* proto, WorldObject const* lootedObject) const
{
    if (!GetGroup() || !GetGroup()->isLFGGroup(true))
        return EQUIP_ERR_OK;    // not in LFG group

    // check if looted object is inside the lfg dungeon
    Map const* map = lootedObject->GetMap();
    if (!sLFGMgr->inLfgDungeonMap(GetGroup()->GetGUID(), map->GetId(), map->GetDifficulty()))
        return EQUIP_ERR_OK;

    if (!proto)
        return EQUIP_ERR_ITEM_NOT_FOUND;
    // Used by group, function NeedBeforeGreed, to know if a prototype can be used by a player

    const static uint32 item_weapon_skills[MAX_ITEM_SUBCLASS_WEAPON] =
    {
        SKILL_AXES,     SKILL_2H_AXES,  SKILL_BOWS,          SKILL_GUNS,        SKILL_MACES,
        SKILL_2H_MACES, SKILL_POLEARMS, SKILL_SWORDS,        SKILL_2H_SWORDS,   0,
        SKILL_STAVES,   0,              0,                   SKILL_FIST_WEAPONS,0,
        SKILL_DAGGERS,  SKILL_THROWN,   SKILL_ASSASSINATION, SKILL_CROSSBOWS,   SKILL_WANDS,
        SKILL_FISHING
    }; //Copy from function Item::GetSkill()

    if ((proto->AllowableClass & getClassMask()) == 0 || (proto->AllowableRace & getRaceMask()) == 0)
        return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;

    if (proto->RequiredSpell != 0 && !HasSpell(proto->RequiredSpell))
        return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;

    if (proto->RequiredSkill != 0)
    {
        if (!GetSkillValue(proto->RequiredSkill))
            return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
        else if (GetSkillValue(proto->RequiredSkill) < proto->RequiredSkillRank)
            return EQUIP_ERR_CANT_EQUIP_SKILL;
    }

    if (proto->Class == ITEM_CLASS_WEAPON && GetSkillValue(item_weapon_skills[proto->SubClass]) == 0)
        return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;

    if (proto->Class == ITEM_CLASS_ARMOR)
    {
        // Check for shields
        if (proto->SubClass == ITEM_SUBCLASS_ARMOR_SHIELD && !(
            IsClass(CLASS_PALADIN, CLASS_CONTEXT_EQUIP_SHIELDS)
            || IsClass(CLASS_WARRIOR, CLASS_CONTEXT_EQUIP_SHIELDS)
            || IsClass(CLASS_SHAMAN, CLASS_CONTEXT_EQUIP_SHIELDS)))
        {
            return EQUIP_ERR_NO_REQUIRED_PROFICIENCY;
        }

        // Check for librams.
        if (proto->SubClass == ITEM_SUBCLASS_ARMOR_LIBRAM && !IsClass(CLASS_PALADIN, CLASS_CONTEXT_EQUIP_RELIC))
        {
            return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;
        }

        // CHeck for idols.
        if (proto->SubClass == ITEM_SUBCLASS_ARMOR_IDOL && !IsClass(CLASS_DRUID, CLASS_CONTEXT_EQUIP_RELIC))
        {
            return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;
        }

        // Check for totems.
        if (proto->SubClass == ITEM_SUBCLASS_ARMOR_TOTEM && !IsClass(CLASS_SHAMAN, CLASS_CONTEXT_EQUIP_RELIC))
        {
            return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;
        }

        // Check for sigils.
        if (proto->SubClass == ITEM_SUBCLASS_ARMOR_SIGIL && !IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_EQUIP_RELIC))
        {
            return EQUIP_ERR_YOU_CAN_NEVER_USE_THAT_ITEM;
        }
    }

    if (proto->Class == ITEM_CLASS_ARMOR && proto->SubClass > ITEM_SUBCLASS_ARMOR_MISC && proto->SubClass < ITEM_SUBCLASS_ARMOR_BUCKLER &&
        proto->InventoryType != INVTYPE_CLOAK)
    {
        uint32 subclassToCompare = ITEM_SUBCLASS_ARMOR_CLOTH;
        if (IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_EQUIP_ARMOR_CLASS) || IsClass(CLASS_PALADIN, CLASS_CONTEXT_EQUIP_ARMOR_CLASS))
        {
            subclassToCompare = ITEM_SUBCLASS_ARMOR_PLATE;
        }
        else if (IsClass(CLASS_WARRIOR, CLASS_CONTEXT_EQUIP_ARMOR_CLASS))
        {
            if ((proto->HasStat(ITEM_MOD_SPELL_POWER) || proto->HasSpellPowerStat()))
            {
                return EQUIP_ERR_CANT_DO_RIGHT_NOW;
            }
            subclassToCompare = ITEM_SUBCLASS_ARMOR_PLATE;
        }
        else if (IsClass(CLASS_HUNTER, CLASS_CONTEXT_EQUIP_ARMOR_CLASS) || IsClass(CLASS_SHAMAN, CLASS_CONTEXT_EQUIP_ARMOR_CLASS))
        {
            subclassToCompare = ITEM_SUBCLASS_ARMOR_MAIL;
        }
        else if (IsClass(CLASS_DRUID, CLASS_CONTEXT_EQUIP_ARMOR_CLASS))
        {
            subclassToCompare = ITEM_SUBCLASS_ARMOR_LEATHER;
        }
        else if (IsClass(CLASS_ROGUE, CLASS_CONTEXT_EQUIP_ARMOR_CLASS))
        {
            if (proto->HasStat(ITEM_MOD_SPELL_POWER) || proto->HasSpellPowerStat())
            {
                return EQUIP_ERR_CANT_DO_RIGHT_NOW;
            }
            subclassToCompare = ITEM_SUBCLASS_ARMOR_LEATHER;
        }

        if (proto->SubClass > subclassToCompare)
        {
            return EQUIP_ERR_CANT_DO_RIGHT_NOW;
        }
        else if (sWorld->getIntConfig(CONFIG_LOOT_NEED_BEFORE_GREED_ILVL_RESTRICTION) && proto->ItemLevel > sWorld->getIntConfig(CONFIG_LOOT_NEED_BEFORE_GREED_ILVL_RESTRICTION))
        {
            if (proto->SubClass < subclassToCompare)
            {
                return EQUIP_ERR_CANT_DO_RIGHT_NOW;
            }
        }
    }

    return EQUIP_ERR_OK;
}

InventoryResult Player::CanUseAmmo(uint32 item) const
{
    LOG_DEBUG("entities.player.items", "STORAGE: CanUseAmmo item = {}", item);
    if (!IsAlive())
        return EQUIP_ERR_YOU_ARE_DEAD;
    //if (isStunned())
    //    return EQUIP_ERR_YOU_ARE_STUNNED;
    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(item);
    if (pProto)
    {
        if (pProto->InventoryType != INVTYPE_AMMO)
            return EQUIP_ERR_ONLY_AMMO_CAN_GO_HERE;

        InventoryResult res = CanUseItem(pProto);
        if (res != EQUIP_ERR_OK)
            return res;

        /*if (GetReputationMgr().GetReputation() < pProto->RequiredReputation)
        return EQUIP_ERR_CANT_EQUIP_REPUTATION;
        */

        // Requires No Ammo
        if (HasAura(46699))
            return EQUIP_ERR_BAG_FULL6;

        return EQUIP_ERR_OK;
    }
    return EQUIP_ERR_ITEM_NOT_FOUND;
}

void Player::SetAmmo(uint32 item)
{
    if (!item)
        return;

    // already set
    if (GetUInt32Value(PLAYER_AMMO_ID) == item)
        return;

    // check ammo
    InventoryResult msg = CanUseAmmo(item);
    if (msg != EQUIP_ERR_OK)
    {
        SendEquipError(msg, nullptr, nullptr, item);
        return;
    }

    SetUInt32Value(PLAYER_AMMO_ID, item);

    _ApplyAmmoBonuses();
}

void Player::RemoveAmmo()
{
    SetUInt32Value(PLAYER_AMMO_ID, 0);

    m_ammoDPS = 0.0f;

    if (CanModifyStats())
        UpdateDamagePhysical(RANGED_ATTACK);
}

Item* Player::StoreNewItem(ItemPosCountVec const& dest, uint32 item, bool update, int32 randomPropertyId)
{
    AllowedLooterSet allowedLooters;
    return StoreNewItem(dest, item, update, randomPropertyId, allowedLooters);
}

// Return stored item (if stored to stack, it can diff. from pItem). And pItem ca be deleted in this case.
Item* Player::StoreNewItem(ItemPosCountVec const& dest, uint32 item, bool update, int32 randomPropertyId, AllowedLooterSet& allowedLooters)
{
    uint32 count = 0;
    for (ItemPosCountVec::const_iterator itr = dest.begin(); itr != dest.end(); ++itr)
        count += itr->count;

    Item* pItem = Item::CreateItem(item, count, this, false, randomPropertyId);
    if (pItem)
    {
        // pussywizard: obtaining blue or better items saves to db
        if (ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(item))
            if (pProto->Quality >= ITEM_QUALITY_RARE)
                AdditionalSavingAddMask(ADDITIONAL_SAVING_INVENTORY_AND_GOLD);

        ItemAddedQuestCheck(item, count);
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_RECEIVE_EPIC_ITEM, item, count);
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_OWN_ITEM, item, count);
        pItem = StoreItem(dest, pItem, update);

        if (allowedLooters.size() > 1 && pItem->GetTemplate()->GetMaxStackSize() == 1 && pItem->IsSoulBound() && sWorld->getBoolConfig(CONFIG_SET_BOP_ITEM_TRADEABLE))
        {
            pItem->SetSoulboundTradeable(allowedLooters);
            pItem->SetUInt32Value(ITEM_FIELD_CREATE_PLAYED_TIME, GetTotalPlayedTime());
            AddTradeableItem(pItem);

            // save data
            std::ostringstream ss;
            AllowedLooterSet::const_iterator itr = allowedLooters.begin();
            ss << (*itr).GetCounter();
            for (++itr; itr != allowedLooters.end(); ++itr)
                ss << ' ' << (*itr).GetCounter();

            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ITEM_BOP_TRADE);
            stmt->SetData(0, pItem->GetGUID().GetCounter());
            stmt->SetData(1, ss.str());
            CharacterDatabase.Execute(stmt);
        }

        sScriptMgr->OnStoreNewItem(this, pItem, count);
    }
    return pItem;
}

Item* Player::StoreItem(ItemPosCountVec const& dest, Item* pItem, bool update)
{
    if (!pItem)
        return nullptr;

    Item* lastItem = pItem;
    ItemTemplate const* proto = pItem->GetTemplate();

    for (ItemPosCountVec::const_iterator itr = dest.begin(); itr != dest.end();)
    {
        uint16 pos = itr->pos;
        uint32 count = itr->count;

        ++itr;

        if (itr == dest.end())
        {
            lastItem = _StoreItem(pos, pItem, count, false, update);
            break;
        }

        lastItem = _StoreItem(pos, pItem, count, true, update);
    }

    // cast after item storing - some checks in checkcast requires item to be present!!
    if (lastItem)
        for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
            if (proto->Spells[i].SpellTrigger == ITEM_SPELLTRIGGER_ON_NO_DELAY_USE && proto->Spells[i].SpellId > 0) // On obtain trigger
                if (!HasAura(proto->Spells[i].SpellId))
                    CastSpell(this, proto->Spells[i].SpellId, true, lastItem);

    return lastItem;
}

// Return stored item (if stored to stack, it can diff. from pItem). And pItem ca be deleted in this case.
Item* Player::_StoreItem(uint16 pos, Item* pItem, uint32 count, bool clone, bool update)
{
    if (!pItem)
        return nullptr;

    uint8 bag = pos >> 8;
    uint8 slot = pos & 255;

    LOG_DEBUG("entities.player.items", "STORAGE: StoreItem bag = {}, slot = {}, item = {}, count = {}, {}", bag, slot, pItem->GetEntry(), count, pItem->GetGUID().ToString());

    Item* pItem2 = GetItemByPos(bag, slot);

    if (!pItem2)
    {
        if (clone)
            pItem = pItem->CloneItem(count, this);
        else
            pItem->SetCount(count);

        if (!pItem)
            return nullptr;

        if (pItem->GetTemplate()->Bonding == BIND_WHEN_PICKED_UP ||
            pItem->GetTemplate()->Bonding == BIND_QUEST_ITEM ||
            (pItem->GetTemplate()->Bonding == BIND_WHEN_EQUIPED && IsBagPos(pos)))
            pItem->SetBinding(true);

        Bag* pBag = (bag == INVENTORY_SLOT_BAG_0) ? nullptr : GetBagByPos(bag);
        if (!pBag)
        {
            m_items[slot] = pItem;
            SetGuidValue(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2), pItem->GetGUID());
            pItem->SetGuidValue(ITEM_FIELD_CONTAINED, GetGUID());
            pItem->SetGuidValue(ITEM_FIELD_OWNER, GetGUID());

            pItem->SetSlot(slot);
            pItem->SetContainer(nullptr);

            // need update known currency
            if (slot >= CURRENCYTOKEN_SLOT_START && slot < CURRENCYTOKEN_SLOT_END)
                AddKnownCurrency(pItem->GetEntry());
        }
        else
            pBag->StoreItem(slot, pItem, update);

        if (IsInWorld() && update)
        {
            pItem->AddToWorld();
            pItem->SendUpdateToPlayer(this);
        }

        pItem->SetState(ITEM_CHANGED, this);
        if (pBag)
            pBag->SetState(ITEM_CHANGED, this);

        AddEnchantmentDurations(pItem);
        AddItemDurations(pItem);

        return pItem;
    }
    else
    {
        if (pItem2->GetTemplate()->Bonding == BIND_WHEN_PICKED_UP ||
            pItem2->GetTemplate()->Bonding == BIND_QUEST_ITEM ||
            (pItem2->GetTemplate()->Bonding == BIND_WHEN_EQUIPED && IsBagPos(pos)))
            pItem2->SetBinding(true);

        pItem2->SetCount(pItem2->GetCount() + count);
        if (IsInWorld() && update)
            pItem2->SendUpdateToPlayer(this);

        if (!clone)
        {
            // delete item (it not in any slot currently)
            if (IsInWorld() && update)
            {
                pItem->RemoveFromWorld();
                pItem->DestroyForPlayer(this);
            }

            RemoveEnchantmentDurations(pItem);
            RemoveItemDurations(pItem);

            pItem->SetOwnerGUID(GetGUID());                 // prevent error at next SetState in case trade/mail/buy from vendor
            pItem->SetNotRefundable(this);
            pItem->ClearSoulboundTradeable(this);
            RemoveTradeableItem(pItem);
            pItem->SetState(ITEM_REMOVED, this);
        }

        AddEnchantmentDurations(pItem2);

        pItem2->SetState(ITEM_CHANGED, this);

        return pItem2;
    }
}

Item* Player::EquipNewItem(uint16 pos, uint32 item, bool update)
{
    Item* _item = Item::CreateItem(item, 1, this);
    if (!_item)
        return nullptr;

    if (!IsEquipmentPos(pos) || sScriptMgr->CanSaveEquipNewItem(this, _item, pos, update))
    {
        // pussywizard: obtaining blue or better items saves to db
        if (ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(item))
            if (pProto->Quality >= ITEM_QUALITY_RARE)
                AdditionalSavingAddMask(ADDITIONAL_SAVING_INVENTORY_AND_GOLD);

        ItemAddedQuestCheck(item, 1);
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_RECEIVE_EPIC_ITEM, item, 1);
    }

    return EquipItem(pos, _item, update);
}

Item* Player::EquipItem(uint16 pos, Item* pItem, bool update)
{
    AddEnchantmentDurations(pItem);
    AddItemDurations(pItem);

    uint8 bag = pos >> 8;
    uint8 slot = pos & 255;

    Item* pItem2 = GetItemByPos(bag, slot);

    if (!pItem2)
    {
        VisualizeItem(slot, pItem);

        if (IsAlive())
        {
            ItemTemplate const* pProto = pItem->GetTemplate();

            // item set bonuses applied only at equip and removed at unequip, and still active for broken items
            if (pProto && pProto->ItemSet)
                AddItemsSetItem(this, pItem);

            _ApplyItemMods(pItem, slot, true);

            if (pProto && IsInCombat() && (pProto->Class == ITEM_CLASS_WEAPON || pProto->InventoryType == INVTYPE_RELIC) && m_weaponChangeTimer == 0)
            {
                uint32 cooldownSpell = IsClass(CLASS_ROGUE, CLASS_CONTEXT_WEAPON_SWAP) ? 6123 : 6119;
                SpellInfo const* spellProto = sSpellMgr->GetSpellInfo(cooldownSpell);

                if (!spellProto)
                    LOG_ERROR("entities.player", "Weapon switch cooldown spell {} couldn't be found in Spell.dbc", cooldownSpell);
                else
                {
                    m_weaponChangeTimer = spellProto->StartRecoveryTime;

                    GetGlobalCooldownMgr().AddGlobalCooldown(spellProto, m_weaponChangeTimer);

                    WorldPacket data;
                    BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_INCLUDE_GCD, cooldownSpell, 0);
                    GetSession()->SendPacket(&data);
                }
            }
        }

        if (IsInWorld() && update)
        {
            pItem->AddToWorld();
            pItem->SendUpdateToPlayer(this);
        }

        ApplyEquipCooldown(pItem);

        // update expertise and armor penetration - passive auras may need it

        if (slot == EQUIPMENT_SLOT_MAINHAND)
            UpdateExpertise(BASE_ATTACK);

        else if (slot == EQUIPMENT_SLOT_OFFHAND)
            UpdateExpertise(OFF_ATTACK);

        switch (slot)
        {
            case EQUIPMENT_SLOT_MAINHAND:
            case EQUIPMENT_SLOT_OFFHAND:
            case EQUIPMENT_SLOT_RANGED:
                RecalculateRating(CR_ARMOR_PENETRATION);
            default:
                break;
        }
    }
    else
    {
        pItem2->SetCount(pItem2->GetCount() + pItem->GetCount());
        if (IsInWorld() && update)
            pItem2->SendUpdateToPlayer(this);

        // delete item (it not in any slot currently)
        //pItem->DeleteFromDB();
        if (IsInWorld() && update)
        {
            pItem->RemoveFromWorld();
            pItem->DestroyForPlayer(this);
        }

        RemoveEnchantmentDurations(pItem);
        RemoveItemDurations(pItem);

        pItem->SetOwnerGUID(GetGUID());                     // prevent error at next SetState in case trade/mail/buy from vendor
        pItem->SetNotRefundable(this);
        pItem->ClearSoulboundTradeable(this);
        RemoveTradeableItem(pItem);
        pItem->SetState(ITEM_REMOVED, this);
        pItem2->SetState(ITEM_CHANGED, this);

        ApplyEquipCooldown(pItem2);
        sScriptMgr->OnEquip(this, pItem2, bag, slot, update);
        return pItem2;
    }

    // only for full equip instead adding to stack
    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EQUIP_ITEM, pItem->GetEntry());
    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EQUIP_EPIC_ITEM, pItem->GetEntry(), slot);

    sScriptMgr->OnEquip(this, pItem, bag, slot, update);
    UpdateForQuestWorldObjects();
    return pItem;
}

void Player::QuickEquipItem(uint16 pos, Item* pItem)
{
    if (pItem)
    {
        AddEnchantmentDurations(pItem);
        AddItemDurations(pItem);

        uint8 slot = pos & 255;
        VisualizeItem(slot, pItem);

        if (IsInWorld())
        {
            pItem->AddToWorld();
            pItem->SendUpdateToPlayer(this);
        }

        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EQUIP_ITEM, pItem->GetEntry());
        UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EQUIP_EPIC_ITEM, pItem->GetEntry(), slot);

        sScriptMgr->OnEquip(this, pItem, (pos >> 8), slot, true);
    }
}

void Player::SetVisibleItemSlot(uint8 slot, Item* pItem)
{
    if (pItem)
    {
        SetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + (slot * 2), pItem->GetEntry());
        SetUInt16Value(PLAYER_VISIBLE_ITEM_1_ENCHANTMENT + (slot * 2), 0, pItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT));
        SetUInt16Value(PLAYER_VISIBLE_ITEM_1_ENCHANTMENT + (slot * 2), 1, pItem->GetEnchantmentId(TEMP_ENCHANTMENT_SLOT));
    }
    else
    {
        SetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + (slot * 2), 0);
        SetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENCHANTMENT + (slot * 2), 0);
    }

    sScriptMgr->OnAfterPlayerSetVisibleItemSlot(this, slot, pItem);
}

void Player::VisualizeItem(uint8 slot, Item* pItem)
{
    if (!pItem)
        return;

    // check also  BIND_WHEN_PICKED_UP and BIND_QUEST_ITEM for .additem or .additemset case by GM (not binded at adding to inventory)
    if (pItem->GetTemplate()->Bonding == BIND_WHEN_EQUIPED || pItem->GetTemplate()->Bonding == BIND_WHEN_PICKED_UP || pItem->GetTemplate()->Bonding == BIND_QUEST_ITEM)
        pItem->SetBinding(true);

    LOG_DEBUG("entities.player.items", "STORAGE: EquipItem slot = {}, item = {}", slot, pItem->GetEntry());

    m_items[slot] = pItem;
    SetGuidValue(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2), pItem->GetGUID());
    pItem->SetGuidValue(ITEM_FIELD_CONTAINED, GetGUID());
    pItem->SetGuidValue(ITEM_FIELD_OWNER, GetGUID());
    pItem->SetSlot(slot);
    pItem->SetContainer(nullptr);

    if (slot < EQUIPMENT_SLOT_END)
        SetVisibleItemSlot(slot, pItem);

    pItem->SetState(ITEM_CHANGED, this);
}

void Player::RemoveItem(uint8 bag, uint8 slot, bool update, bool swap)
{
    // note: removeitem does not actually change the item
    // it only takes the item out of storage temporarily
    // note2: if removeitem is to be used for delinking
    // the item must be removed from the player's updatequeue

    Item* pItem = GetItemByPos(bag, slot);
    if (pItem)
    {
        LOG_DEBUG("entities.player.items", "STORAGE: RemoveItem bag = {}, slot = {}, item = {}", bag, slot, pItem->GetEntry());

        RemoveEnchantmentDurations(pItem);
        RemoveItemDurations(pItem);
        RemoveTradeableItem(pItem);

        if (bag == INVENTORY_SLOT_BAG_0)
        {
            if (slot < INVENTORY_SLOT_BAG_END)
            {
                ItemTemplate const* pProto = pItem->GetTemplate();
                // item set bonuses applied only at equip and removed at unequip, and still active for broken items

                if (pProto && pProto->ItemSet)
                    RemoveItemsSetItem(this, pProto);

                _ApplyItemMods(pItem, slot, false);
            }

            m_items[slot] = nullptr;

            // remove item dependent auras and casts (only weapon and armor slots)
            if (slot < INVENTORY_SLOT_BAG_END && slot < EQUIPMENT_SLOT_END)
            {
                // Xinef: Ensure that this function is called for places with swap=true
                if (!swap)
                {
                    RemoveItemDependentAurasAndCasts(pItem);
                }

                // remove held enchantments, update expertise
                if (slot == EQUIPMENT_SLOT_MAINHAND)
                {
                    UpdateExpertise(BASE_ATTACK);
                }
                else if (slot == EQUIPMENT_SLOT_OFFHAND)
                {
                    UpdateExpertise(OFF_ATTACK);
                }

                // update armor penetration - passive auras may need it
                switch (slot)
                {
                    case EQUIPMENT_SLOT_MAINHAND:
                    case EQUIPMENT_SLOT_OFFHAND:
                    case EQUIPMENT_SLOT_RANGED:
                        RecalculateRating(CR_ARMOR_PENETRATION);
                    default:
                        break;
                }
            }

            SetGuidValue(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2), ObjectGuid::Empty);

            if (slot < EQUIPMENT_SLOT_END)
                SetVisibleItemSlot(slot, nullptr);
        }
        else if (Bag* pBag = GetBagByPos(bag))
            pBag->RemoveItem(slot, update);

        pItem->SetGuidValue(ITEM_FIELD_CONTAINED, ObjectGuid::Empty);
        // pItem->SetGuidValue(ITEM_FIELD_OWNER, ObjectGuid::Empty); not clear owner at remove (it will be set at store). This used in mail and auction code
        pItem->SetSlot(NULL_SLOT);
        if (IsInWorld() && update)
            pItem->SendUpdateToPlayer(this);
    }
}

// Common operation need to remove item from inventory without delete in trade, auction, guild bank, mail....
void Player::MoveItemFromInventory(uint8 bag, uint8 slot, bool update)
{
    if (Item* it = GetItemByPos(bag, slot))
    {
        ItemRemovedQuestCheck(it->GetEntry(), it->GetCount());
        RemoveItem(bag, slot, update);
        UpdateTitansGrip();
        it->SetNotRefundable(this, false);
        it->RemoveFromUpdateQueueOf(this);
        if (it->IsInWorld())
        {
            it->RemoveFromWorld();
            it->DestroyForPlayer(this);
        }

        sScriptMgr->OnAfterPlayerMoveItemFromInventory(this, it, bag, slot, update);
    }
}

// Common operation need to add item from inventory without delete in trade, guild bank, mail....
void Player::MoveItemToInventory(ItemPosCountVec const& dest, Item* pItem, bool update, bool in_characterInventoryDB)
{
    // update quest counters
    ItemAddedQuestCheck(pItem->GetEntry(), pItem->GetCount());
    UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_RECEIVE_EPIC_ITEM, pItem->GetEntry(), pItem->GetCount());

    // store item
    Item* pLastItem = StoreItem(dest, pItem, update);

    // only set if not merged to existed stack (pItem can be deleted already but we can compare pointers any way)
    if (pLastItem == pItem)
    {
        // update owner for last item (this can be original item with wrong owner
        if (pLastItem->GetOwnerGUID() != GetGUID())
            pLastItem->SetOwnerGUID(GetGUID());

        // if this original item then it need create record in inventory
        // in case trade we already have item in other player inventory
        pLastItem->SetState(in_characterInventoryDB ? ITEM_CHANGED : ITEM_NEW, this);

        if (pLastItem->HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_BOP_TRADEABLE))
            AddTradeableItem(pLastItem);
    }
}

void Player::DestroyItem(uint8 bag, uint8 slot, bool update)
{
    Item* pItem = GetItemByPos(bag, slot);
    if (pItem)
    {
        LOG_DEBUG("entities.player.items", "STORAGE: DestroyItem bag = {}, slot = {}, item = {}", bag, slot, pItem->GetEntry());
        // Also remove all contained items if the item is a bag.
        // This if () prevents item saving crashes if the condition for a bag to be empty before being destroyed was bypassed somehow.
        if (pItem->IsNotEmptyBag())
            for (uint8 i = 0; i < MAX_BAG_SIZE; ++i)
                DestroyItem(slot, i, update);

        if (pItem->HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_WRAPPED))
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GIFT);
            stmt->SetData(0, pItem->GetGUID().GetCounter());
            CharacterDatabase.Execute(stmt);
        }

        RemoveEnchantmentDurations(pItem);
        RemoveItemDurations(pItem);

        pItem->SetNotRefundable(this);
        pItem->ClearSoulboundTradeable(this);
        RemoveTradeableItem(pItem);

        ItemTemplate const* proto = pItem->GetTemplate();
        for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
            if (proto->Spells[i].SpellTrigger == ITEM_SPELLTRIGGER_ON_NO_DELAY_USE && proto->Spells[i].SpellId > 0) // On obtain trigger
                RemoveAurasDueToSpell(proto->Spells[i].SpellId);

        ItemRemovedQuestCheck(pItem->GetEntry(), pItem->GetCount());

        sScriptMgr->OnItemRemove(this, pItem);

        if (bag == INVENTORY_SLOT_BAG_0)
        {
            SetGuidValue(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2), ObjectGuid::Empty);

            // equipment and equipped bags can have applied bonuses
            if (slot < INVENTORY_SLOT_BAG_END)
            {
                ItemTemplate const* pProto = pItem->GetTemplate();

                // item set bonuses applied only at equip and removed at unequip, and still active for broken items
                if (pProto && pProto->ItemSet)
                    RemoveItemsSetItem(this, pProto);

                _ApplyItemMods(pItem, slot, false);
            }

            if (slot < EQUIPMENT_SLOT_END)
            {
                // remove item dependent auras and casts (only weapon and armor slots)
                RemoveItemDependentAurasAndCasts(pItem);

                // update expertise and armor penetration - passive auras may need it
                switch (slot)
                {
                    case EQUIPMENT_SLOT_MAINHAND:
                    case EQUIPMENT_SLOT_OFFHAND:
                    case EQUIPMENT_SLOT_RANGED:
                        RecalculateRating(CR_ARMOR_PENETRATION);
                    default:
                        break;
                }

                if (slot == EQUIPMENT_SLOT_MAINHAND)
                    UpdateExpertise(BASE_ATTACK);
                else if (slot == EQUIPMENT_SLOT_OFFHAND)
                    UpdateExpertise(OFF_ATTACK);

                // equipment visual show
                SetVisibleItemSlot(slot, nullptr);
            }

            m_items[slot] = nullptr;
        }
        else if (Bag* pBag = GetBagByPos(bag))
            pBag->RemoveItem(slot, update);

        // Xinef: item is removed, remove loot from storage if any
        if (proto->Flags & ITEM_FLAG_HAS_LOOT)
            sLootItemStorage->RemoveStoredLoot(pItem->GetGUID());

        if (IsInWorld() && update)
        {
            pItem->RemoveFromWorld();
            pItem->DestroyForPlayer(this);
        }

        //pItem->SetOwnerGUID(0);
        pItem->SetGuidValue(ITEM_FIELD_CONTAINED, ObjectGuid::Empty);
        pItem->SetSlot(NULL_SLOT);
        pItem->SetState(ITEM_REMOVED, this);
    }
}

void Player::DestroyItemCount(uint32 itemEntry, uint32 count, bool update, bool unequip_check)
{
    LOG_DEBUG("entities.player.items", "STORAGE: DestroyItemCount item = {}, count = {}", itemEntry, count);
    uint32 remcount = 0;

    // in inventory
    for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
    {
        if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
        {
            if (item->GetEntry() == itemEntry && !item->IsInTrade())
            {
                if (item->GetCount() + remcount <= count)
                {
                    // all items in inventory can unequipped
                    remcount += item->GetCount();
                    DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

                    if (remcount >= count)
                        return;
                }
                else
                {
                    ItemRemovedQuestCheck(item->GetEntry(), count - remcount);
                    item->SetCount(item->GetCount() - count + remcount);
                    if (IsInWorld() && update)
                        item->SendUpdateToPlayer(this);
                    item->SetState(ITEM_CHANGED, this);
                    return;
                }
            }
        }
    }

    for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
    {
        if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
        {
            if (item->GetEntry() == itemEntry && !item->IsInTrade())
            {
                if (item->GetCount() + remcount <= count)
                {
                    // all keys can be unequipped
                    remcount += item->GetCount();
                    DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

                    if (remcount >= count)
                        return;
                }
                else
                {
                    ItemRemovedQuestCheck(item->GetEntry(), count - remcount);
                    item->SetCount(item->GetCount() - count + remcount);
                    if (IsInWorld() && update)
                        item->SendUpdateToPlayer(this);
                    item->SetState(ITEM_CHANGED, this);
                    return;
                }
            }
        }
    }

    // in inventory bags
    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (Bag* bag = GetBagByPos(i))
        {
            for (uint32 j = 0; j < bag->GetBagSize(); j++)
            {
                if (Item* item = bag->GetItemByPos(j))
                {
                    if (item->GetEntry() == itemEntry && !item->IsInTrade())
                    {
                        // all items in bags can be unequipped
                        if (item->GetCount() + remcount <= count)
                        {
                            remcount += item->GetCount();
                            DestroyItem(i, j, update);

                            if (remcount >= count)
                                return;
                        }
                        else
                        {
                            ItemRemovedQuestCheck(item->GetEntry(), count - remcount);
                            item->SetCount(item->GetCount() - count + remcount);
                            if (IsInWorld() && update)
                                item->SendUpdateToPlayer(this);
                            item->SetState(ITEM_CHANGED, this);
                            return;
                        }
                    }
                }
            }
        }
    }

    // in equipment and bag list
    for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
        {
            if (item && item->GetEntry() == itemEntry && !item->IsInTrade())
            {
                if (item->GetCount() + remcount <= count)
                {
                    if (!unequip_check || CanUnequipItem(INVENTORY_SLOT_BAG_0 << 8 | i, false) == EQUIP_ERR_OK)
                    {
                        remcount += item->GetCount();
                        DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

                        if (remcount >= count)
                            return;
                    }
                }
                else
                {
                    ItemRemovedQuestCheck(item->GetEntry(), count - remcount);
                    item->SetCount(item->GetCount() - count + remcount);
                    if (IsInWorld() && update)
                        item->SendUpdateToPlayer(this);
                    item->SetState(ITEM_CHANGED, this);
                    return;
                }
            }
        }
    }

    // in bank
    for (uint8 i = BANK_SLOT_ITEM_START; i < BANK_SLOT_ITEM_END; i++)
    {
        if (Item* item = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
        {
            if (item->GetEntry() == itemEntry && !item->IsInTrade())
            {
                if (item->GetCount() + remcount <= count)
                {
                    remcount += item->GetCount();
                    DestroyItem(INVENTORY_SLOT_BAG_0, i, update);
                    if (remcount >= count)
                        return;
                }
                else
                {
                    ItemRemovedQuestCheck(item->GetEntry(), count - remcount);
                    item->SetCount(item->GetCount() - count + remcount);
                    if (IsInWorld() && update)
                        item->SendUpdateToPlayer(this);
                    item->SetState(ITEM_CHANGED, this);
                    return;
                }
            }
        }
    }

    // in bank bags
    for (uint8 i = BANK_SLOT_BAG_START; i < BANK_SLOT_BAG_END; i++)
    {
        if (Bag* bag = GetBagByPos(i))
        {
            for (uint32 j = 0; j < bag->GetBagSize(); j++)
            {
                if (Item* item = bag->GetItemByPos(j))
                {
                    if (item->GetEntry() == itemEntry && !item->IsInTrade())
                    {
                        // all items in bags can be unequipped
                        if (item->GetCount() + remcount <= count)
                        {
                            remcount += item->GetCount();
                            DestroyItem(i, j, update);

                            if (remcount >= count)
                                return;
                        }
                        else
                        {
                            ItemRemovedQuestCheck(item->GetEntry(), count - remcount);
                            item->SetCount(item->GetCount() - count + remcount);
                            if (IsInWorld() && update)
                                item->SendUpdateToPlayer(this);
                            item->SetState(ITEM_CHANGED, this);
                            return;
                        }
                    }
                }
            }
        }
    }
}

void Player::DestroyZoneLimitedItem(bool update, uint32 new_zone)
{
    LOG_DEBUG("entities.player.items", "STORAGE: DestroyZoneLimitedItem in map {} and area {}", GetMapId(), new_zone);

    // in inventory
    for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->IsLimitedToAnotherMapOrZone(GetMapId(), new_zone))
                DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

    for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->IsLimitedToAnotherMapOrZone(GetMapId(), new_zone))
                DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

    // in inventory bags
    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        if (Bag* pBag = GetBagByPos(i))
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                if (Item* pItem = pBag->GetItemByPos(j))
                    if (pItem->IsLimitedToAnotherMapOrZone(GetMapId(), new_zone))
                        DestroyItem(i, j, update);

    // in equipment and bag list
    for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; i++)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->IsLimitedToAnotherMapOrZone(GetMapId(), new_zone))
                DestroyItem(INVENTORY_SLOT_BAG_0, i, update);
}

void Player::DestroyConjuredItems(bool update)
{
    // used when entering arena
    // destroys all conjured items
    LOG_DEBUG("entities.player.items", "STORAGE: DestroyConjuredItems");

    // in inventory
    for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->IsConjuredConsumable())
                DestroyItem(INVENTORY_SLOT_BAG_0, i, update);

    // in inventory bags
    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        if (Bag* pBag = GetBagByPos(i))
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                if (Item* pItem = pBag->GetItemByPos(j))
                    if (pItem->IsConjuredConsumable())
                        DestroyItem(i, j, update);

    // in equipment and bag list
    for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; i++)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->IsConjuredConsumable())
                DestroyItem(INVENTORY_SLOT_BAG_0, i, update);
}

Item* Player::GetItemByEntry(uint32 entry) const
{
    // in inventory
    for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->GetEntry() == entry)
                return pItem;

    for (uint8 i = KEYRING_SLOT_START; i < CURRENCYTOKEN_SLOT_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->GetEntry() == entry)
                return pItem;

    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
        if (Bag* pBag = GetBagByPos(i))
            for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
                if (Item* pItem = pBag->GetItemByPos(j))
                    if (pItem->GetEntry() == entry)
                        return pItem;

    for (int i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_BAG_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (pItem->GetEntry() == entry)
                return pItem;

    return nullptr;
}

void Player::DestroyItemCount(Item* pItem, uint32& count, bool update)
{
    if (!pItem)
        return;

    LOG_DEBUG("entities.player.items", "STORAGE: DestroyItemCount item ({}, Entry: {}) count = {}", pItem->GetGUID().ToString(), pItem->GetEntry(), count);

    if (pItem->GetCount() <= count)
    {
        count -= pItem->GetCount();

        DestroyItem(pItem->GetBagSlot(), pItem->GetSlot(), update);
    }
    else
    {
        ItemRemovedQuestCheck(pItem->GetEntry(), count);
        pItem->SetCount(pItem->GetCount() - count);
        count = 0;
        if (IsInWorld() && update)
            pItem->SendUpdateToPlayer(this);
        pItem->SetState(ITEM_CHANGED, this);
    }
}

void Player::SplitItem(uint16 src, uint16 dst, uint32 count)
{
    uint8 srcbag = src >> 8;
    uint8 srcslot = src & 255;

    uint8 dstbag = dst >> 8;
    uint8 dstslot = dst & 255;

    Item* pSrcItem = GetItemByPos(srcbag, srcslot);
    if (!pSrcItem)
    {
        SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, pSrcItem, nullptr);
        return;
    }

    if (pSrcItem->m_lootGenerated)                           // prevent split looting item (item
    {
        //best error message found for attempting to split while looting
        SendEquipError(EQUIP_ERR_COULDNT_SPLIT_ITEMS, pSrcItem, nullptr);
        return;
    }

    // not let split all items (can be only at cheating)
    if (pSrcItem->GetCount() == count)
    {
        SendEquipError(EQUIP_ERR_COULDNT_SPLIT_ITEMS, pSrcItem, nullptr);
        return;
    }

    // not let split more existed items (can be only at cheating)
    if (pSrcItem->GetCount() < count)
    {
        SendEquipError(EQUIP_ERR_TRIED_TO_SPLIT_MORE_THAN_COUNT, pSrcItem, nullptr);
        return;
    }

    //! If trading
    if (TradeData* tradeData = GetTradeData())
    {
        //! If current item is in trade window (only possible with packet spoofing - silent return)
        if (tradeData->GetTradeSlotForItem(pSrcItem->GetGUID()) != TRADE_SLOT_INVALID)
            return;
    }

    LOG_DEBUG("entities.player.items", "STORAGE: SplitItem bag = {}, slot = {}, item = {}, count = {}", dstbag, dstslot, pSrcItem->GetEntry(), count);
    Item* pNewItem = pSrcItem->CloneItem(count, this);
    if (!pNewItem)
    {
        SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, pSrcItem, nullptr);
        return;
    }

    if (IsInventoryPos(dst))
    {
        // change item amount before check (for unique max count check)
        pSrcItem->SetCount(pSrcItem->GetCount() - count);

        ItemPosCountVec dest;
        InventoryResult msg = CanStoreItem(dstbag, dstslot, dest, pNewItem, false);
        if (msg != EQUIP_ERR_OK)
        {
            delete pNewItem;
            pSrcItem->SetCount(pSrcItem->GetCount() + count);
            SendEquipError(msg, pSrcItem, nullptr);
            return;
        }

        if (IsInWorld())
            pSrcItem->SendUpdateToPlayer(this);
        pSrcItem->SetState(ITEM_CHANGED, this);
        StoreItem(dest, pNewItem, true);
    }
    else if (IsBankPos(dst))
    {
        // change item amount before check (for unique max count check)
        pSrcItem->SetCount(pSrcItem->GetCount() - count);

        ItemPosCountVec dest;
        InventoryResult msg = CanBankItem(dstbag, dstslot, dest, pNewItem, false);
        if (msg != EQUIP_ERR_OK)
        {
            delete pNewItem;
            pSrcItem->SetCount(pSrcItem->GetCount() + count);
            SendEquipError(msg, pSrcItem, nullptr);
            return;
        }

        if (IsInWorld())
            pSrcItem->SendUpdateToPlayer(this);
        pSrcItem->SetState(ITEM_CHANGED, this);
        BankItem(dest, pNewItem, true);
    }
    else if (IsEquipmentPos(dst))
    {
        // change item amount before check (for unique max count check), provide space for splitted items
        pSrcItem->SetCount(pSrcItem->GetCount() - count);

        uint16 dest;
        InventoryResult msg = CanEquipItem(dstslot, dest, pNewItem, false);
        if (msg != EQUIP_ERR_OK)
        {
            delete pNewItem;
            pSrcItem->SetCount(pSrcItem->GetCount() + count);
            SendEquipError(msg, pSrcItem, nullptr);
            return;
        }

        if (IsInWorld())
            pSrcItem->SendUpdateToPlayer(this);
        pSrcItem->SetState(ITEM_CHANGED, this);
        EquipItem(dest, pNewItem, true);
        AutoUnequipOffhandIfNeed();
    }
}

void Player::SwapItem(uint16 src, uint16 dst)
{
    uint8 srcbag = src >> 8;
    uint8 srcslot = src & 255;

    uint8 dstbag = dst >> 8;
    uint8 dstslot = dst & 255;

    Item* pSrcItem = GetItemByPos(srcbag, srcslot);
    Item* pDstItem = GetItemByPos(dstbag, dstslot);

    if (!pSrcItem)
        return;

    LOG_DEBUG("entities.player.items", "STORAGE: SwapItem bag = {}, slot = {}, item = {}", dstbag, dstslot, pSrcItem->GetEntry());

    if (!IsAlive())
    {
        SendEquipError(EQUIP_ERR_YOU_ARE_DEAD, pSrcItem, pDstItem);
        return;
    }

    // SRC checks

    if (GetLootGUID() == pSrcItem->GetGUID())                           // prevent swap looting item
    {
        //best error message found for attempting to swap while looting
        SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, pSrcItem, nullptr);
        return;
    }

    // check unequip potability for equipped items and bank bags
    if (IsEquipmentPos(src) || IsBagPos(src))
    {
        // bags can be swapped with empty bag slots, or with empty bag (items move possibility checked later)
        InventoryResult msg = CanUnequipItem(src, !IsBagPos(src) || IsBagPos(dst) || (pDstItem && pDstItem->ToBag() && pDstItem->ToBag()->IsEmpty()));
        if (msg != EQUIP_ERR_OK)
        {
            SendEquipError(msg, pSrcItem, pDstItem);
            return;
        }
    }

    // anti-wpe
    if (pSrcItem->IsBag() && pSrcItem->IsNotEmptyBag() && !IsBagPos(dst))
    {
        SendEquipError(EQUIP_ERR_CAN_ONLY_DO_WITH_EMPTY_BAGS, pSrcItem, pDstItem);
        return;
    }

    // prevent put equipped/bank bag in self
    if (IsBagPos(src) && srcslot == dstbag)
    {
        SendEquipError(EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG, pSrcItem, pDstItem);
        return;
    }

    // prevent equipping bag in the same slot from its inside
    if (IsBagPos(dst) && srcbag == dstslot)
    {
        SendEquipError(EQUIP_ERR_ITEMS_CANT_BE_SWAPPED, pSrcItem, pDstItem);
        return;
    }

    // DST checks

    if (pDstItem)
    {
        // Xinef: Removed next loot generated check
        if (pDstItem->GetGUID() == GetLootGUID())                       // prevent swap looting item
        {
            //best error message found for attempting to swap while looting
            SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, pDstItem, nullptr);
            return;
        }

        // check unequip potability for equipped items and bank bags
        if (IsEquipmentPos(dst) || IsBagPos(dst))
        {
            // bags can be swapped with empty bag slots, or with empty bag (items move possibility checked later)
            InventoryResult msg = CanUnequipItem(dst, !IsBagPos(dst) || IsBagPos(src) || (pSrcItem->ToBag() && pSrcItem->ToBag()->IsEmpty()));
            if (msg != EQUIP_ERR_OK)
            {
                SendEquipError(msg, pSrcItem, pDstItem);
                return;
            }
        }
    }

    // NOW this is or item move (swap with empty), or swap with another item (including bags in bag possitions)
    // or swap empty bag with another empty or not empty bag (with items exchange)

    // Move case
    if (!pDstItem)
    {
        if (IsInventoryPos(dst))
        {
            ItemPosCountVec dest;
            InventoryResult msg = CanStoreItem(dstbag, dstslot, dest, pSrcItem, false);
            if (msg != EQUIP_ERR_OK)
            {
                SendEquipError(msg, pSrcItem, nullptr);
                return;
            }

            RemoveItem(srcbag, srcslot, true);
            StoreItem(dest, pSrcItem, true);
            UpdateTitansGrip();
            if (IsBankPos(src))
                ItemAddedQuestCheck(pSrcItem->GetEntry(), pSrcItem->GetCount());
        }
        else if (IsBankPos(dst))
        {
            ItemPosCountVec dest;
            InventoryResult msg = CanBankItem(dstbag, dstslot, dest, pSrcItem, false);
            if (msg != EQUIP_ERR_OK)
            {
                SendEquipError(msg, pSrcItem, nullptr);
                return;
            }

            RemoveItem(srcbag, srcslot, true);
            BankItem(dest, pSrcItem, true);
            UpdateTitansGrip();
            ItemRemovedQuestCheck(pSrcItem->GetEntry(), pSrcItem->GetCount());
        }
        else if (IsEquipmentPos(dst))
        {
            uint16 dest;
            InventoryResult msg = CanEquipItem(dstslot, dest, pSrcItem, false);
            if (msg != EQUIP_ERR_OK)
            {
                SendEquipError(msg, pSrcItem, nullptr);
                return;
            }

            RemoveItem(srcbag, srcslot, true);
            EquipItem(dest, pSrcItem, true);
            AutoUnequipOffhandIfNeed();
        }

        return;
    }

    // attempt merge to / fill target item
    if (!pSrcItem->IsBag() && !pDstItem->IsBag())
    {
        InventoryResult msg;
        ItemPosCountVec sDest;
        uint16 eDest = 0;
        if (IsInventoryPos(dst))
            msg = CanStoreItem(dstbag, dstslot, sDest, pSrcItem, false);
        else if (IsBankPos(dst))
            msg = CanBankItem(dstbag, dstslot, sDest, pSrcItem, false);
        else if (IsEquipmentPos(dst))
            msg = CanEquipItem(dstslot, eDest, pSrcItem, false);
        else
            return;

        // can be merge/fill
        if (msg == EQUIP_ERR_OK)
        {
            if (pSrcItem->GetCount() + pDstItem->GetCount() <= pSrcItem->GetTemplate()->GetMaxStackSize())
            {
                RemoveItem(srcbag, srcslot, true);

                if (IsInventoryPos(dst))
                    StoreItem(sDest, pSrcItem, true);
                else if (IsBankPos(dst))
                    BankItem(sDest, pSrcItem, true);
                else if (IsEquipmentPos(dst))
                {
                    EquipItem(eDest, pSrcItem, true);
                    AutoUnequipOffhandIfNeed();
                }
            }
            else
            {
                pSrcItem->SetCount(pSrcItem->GetCount() + pDstItem->GetCount() - pSrcItem->GetTemplate()->GetMaxStackSize());
                pDstItem->SetCount(pSrcItem->GetTemplate()->GetMaxStackSize());
                pSrcItem->SetState(ITEM_CHANGED, this);
                pDstItem->SetState(ITEM_CHANGED, this);
                if (IsInWorld())
                {
                    pSrcItem->SendUpdateToPlayer(this);
                    pDstItem->SendUpdateToPlayer(this);
                }
            }
            SendRefundInfo(pDstItem);
            return;
        }
    }

    // Remove item enchantments for now and restore it later
    // Needed for swap sanity checks
    ApplyEnchantment(pSrcItem, false);
    if (pDstItem)
    {
        ApplyEnchantment(pDstItem, false);
    }

    // impossible merge/fill, do real swap
    InventoryResult msg = EQUIP_ERR_OK;

    // check src->dest move possibility
    ItemPosCountVec sDest;
    uint16 eDest = 0;
    if (IsInventoryPos(dst))
        msg = CanStoreItem(dstbag, dstslot, sDest, pSrcItem, true);
    else if (IsBankPos(dst))
        msg = CanBankItem(dstbag, dstslot, sDest, pSrcItem, true);
    else if (IsEquipmentPos(dst))
    {
        msg = CanEquipItem(dstslot, eDest, pSrcItem, true);
        if (msg == EQUIP_ERR_OK)
            msg = CanUnequipItem(eDest, true);
    }

    if (msg != EQUIP_ERR_OK)
    {
        // Restore enchantments
        ApplyEnchantment(pSrcItem, true);
        if (pDstItem)
        {
            ApplyEnchantment(pDstItem, true);
        }

        SendEquipError(msg, pSrcItem, pDstItem);
        return;
    }

    // check dest->src move possibility
    ItemPosCountVec sDest2;
    uint16 eDest2 = 0;
    if (IsInventoryPos(src))
        msg = CanStoreItem(srcbag, srcslot, sDest2, pDstItem, true);
    else if (IsBankPos(src))
        msg = CanBankItem(srcbag, srcslot, sDest2, pDstItem, true);
    else if (IsEquipmentPos(src))
    {
        msg = CanEquipItem(srcslot, eDest2, pDstItem, true);
        if (msg == EQUIP_ERR_OK)
            msg = CanUnequipItem(eDest2, true);
    }

    if (msg != EQUIP_ERR_OK)
    {
        // Restore enchantments
        ApplyEnchantment(pSrcItem, true);
        if (pDstItem)
        {
            ApplyEnchantment(pDstItem, true);
        }

        SendEquipError(msg, pDstItem, pSrcItem);
        return;
    }

    // Restore enchantments
    ApplyEnchantment(pSrcItem, true);
    if (pDstItem)
    {
        ApplyEnchantment(pDstItem, true);
    }

    // Check bag swap with item exchange (one from empty in not bag possition (equipped (not possible in fact) or store)
    if (Bag* srcBag = pSrcItem->ToBag())
    {
        if (Bag* dstBag = pDstItem->ToBag())
        {
            Bag* emptyBag = nullptr;
            Bag* fullBag = nullptr;
            if (srcBag->IsEmpty() && !IsBagPos(src))
            {
                emptyBag = srcBag;
                fullBag  = dstBag;
            }
            else if (dstBag->IsEmpty() && !IsBagPos(dst))
            {
                emptyBag = dstBag;
                fullBag  = srcBag;
            }

            // bag swap (with items exchange) case
            if (emptyBag && fullBag)
            {
                ItemTemplate const* emptyProto = emptyBag->GetTemplate();

                uint32 count = 0;

                for (uint32 i = 0; i < fullBag->GetBagSize(); ++i)
                {
                    Item* bagItem = fullBag->GetItemByPos(i);
                    if (!bagItem)
                        continue;

                    ItemTemplate const* bagItemProto = bagItem->GetTemplate();
                    if (!bagItemProto || !ItemCanGoIntoBag(bagItemProto, emptyProto))
                    {
                        // one from items not go to empty target bag
                        SendEquipError(EQUIP_ERR_NONEMPTY_BAG_OVER_OTHER_BAG, pSrcItem, pDstItem);
                        return;
                    }

                    ++count;
                }

                if (count > emptyBag->GetBagSize())
                {
                    // too small targeted bag
                    SendEquipError(EQUIP_ERR_ITEMS_CANT_BE_SWAPPED, pSrcItem, pDstItem);
                    return;
                }

                // Items swap
                count = 0;                                      // will pos in new bag
                for (uint32 i = 0; i < fullBag->GetBagSize(); ++i)
                {
                    Item* bagItem = fullBag->GetItemByPos(i);
                    if (!bagItem)
                        continue;

                    fullBag->RemoveItem(i, true);
                    emptyBag->StoreItem(count, bagItem, true);
                    bagItem->SetState(ITEM_CHANGED, this);

                    ++count;
                }
            }
        }
    }

    // now do moves, remove...
    RemoveItem(dstbag, dstslot, false, true);
    RemoveItem(srcbag, srcslot, false, true);

    // add to dest
    if (IsInventoryPos(dst))
        StoreItem(sDest, pSrcItem, true);
    else if (IsBankPos(dst))
        BankItem(sDest, pSrcItem, true);
    else if (IsEquipmentPos(dst))
        EquipItem(eDest, pSrcItem, true);

    // add to src
    if (IsInventoryPos(src))
        StoreItem(sDest2, pDstItem, true);
    else if (IsBankPos(src))
        BankItem(sDest2, pDstItem, true);
    else if (IsEquipmentPos(src))
        EquipItem(eDest2, pDstItem, true);

    // Xinef: Call this here after all needed items are equipped
    RemoveItemDependentAurasAndCasts((Item*)nullptr);

    // if player is moving bags and is looting an item inside this bag
    // release the loot
    if (GetLootGUID())
    {
        bool released = false;
        if (IsBagPos(src))
        {
            Bag* bag = pSrcItem->ToBag();
            for (uint32 i = 0; i < bag->GetBagSize(); ++i)
            {
                if (Item* bagItem = bag->GetItemByPos(i))
                {
                    // Xinef: Removed next loot generated check
                    if (bagItem->GetGUID() == GetLootGUID())
                    {
                        m_session->DoLootRelease(GetLootGUID());
                        released = true;                    // so we don't need to look at dstBag
                        break;
                    }
                }
            }
        }

        if (!released && IsBagPos(dst))
        {
            Bag* bag = pDstItem->ToBag();
            for (uint32 i = 0; i < bag->GetBagSize(); ++i)
            {
                if (Item* bagItem = bag->GetItemByPos(i))
                {
                    // Xinef: Removed next loot generated check
                    if (bagItem->GetGUID() == GetLootGUID())
                    {
                        m_session->DoLootRelease(GetLootGUID());
                        released = true;                    // not realy needed here
                        break;
                    }
                }
            }
        }
    }

    AutoUnequipOffhandIfNeed();
}

void Player::AddItemToBuyBackSlot(Item* pItem, uint32 money)
{
    if (pItem)
    {
        uint32 slot = m_currentBuybackSlot;
        // if current back slot non-empty search oldest or free
        if (m_items[slot])
        {
            uint32 oldest_time = GetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1);
            uint32 oldest_slot = BUYBACK_SLOT_START;

            for (uint32 i = BUYBACK_SLOT_START + 1; i < BUYBACK_SLOT_END; ++i)
            {
                // found empty
                if (!m_items[i])
                {
                    slot = i;
                    break;
                }

                uint32 i_time = GetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1 + i - BUYBACK_SLOT_START);

                if (oldest_time > i_time)
                {
                    oldest_time = i_time;
                    oldest_slot = i;
                }
            }

            // find oldest
            slot = oldest_slot;
        }

        RemoveItemFromBuyBackSlot(slot, true);
        LOG_DEBUG("entities.player.items", "STORAGE: AddItemToBuyBackSlot item = {}, slot = {}", pItem->GetEntry(), slot);

        m_items[slot] = pItem;
        time_t base = GameTime::GetGameTime().count();
        uint32 etime = uint32(base - m_logintime + (30 * 3600));
        uint32 eslot = slot - BUYBACK_SLOT_START;

        SetGuidValue(PLAYER_FIELD_VENDORBUYBACK_SLOT_1 + (eslot * 2), pItem->GetGUID());
        SetUInt32Value(PLAYER_FIELD_BUYBACK_PRICE_1 + eslot, money);
        SetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1 + eslot, (uint32)etime);

        // move to next (for non filled list is move most optimized choice)
        if (m_currentBuybackSlot < BUYBACK_SLOT_END - 1)
            ++m_currentBuybackSlot;
    }
}

Item* Player::GetItemFromBuyBackSlot(uint32 slot)
{
    LOG_DEBUG("entities.player.items", "STORAGE: GetItemFromBuyBackSlot slot = {}", slot);
    if (slot >= BUYBACK_SLOT_START && slot < BUYBACK_SLOT_END)
        return m_items[slot];
    return nullptr;
}

void Player::RemoveItemFromBuyBackSlot(uint32 slot, bool del)
{
    LOG_DEBUG("entities.player.items", "STORAGE: RemoveItemFromBuyBackSlot slot = {}", slot);
    if (slot >= BUYBACK_SLOT_START && slot < BUYBACK_SLOT_END)
    {
        Item* pItem = m_items[slot];
        if (pItem)
        {
            pItem->RemoveFromWorld();
            if (del)
                pItem->SetState(ITEM_REMOVED, this);
        }

        m_items[slot] = nullptr;

        uint32 eslot = slot - BUYBACK_SLOT_START;
        SetGuidValue(PLAYER_FIELD_VENDORBUYBACK_SLOT_1 + (eslot * 2), ObjectGuid::Empty);
        SetUInt32Value(PLAYER_FIELD_BUYBACK_PRICE_1 + eslot, 0);
        SetUInt32Value(PLAYER_FIELD_BUYBACK_TIMESTAMP_1 + eslot, 0);

        // if current backslot is filled set to now free slot
        if (m_items[m_currentBuybackSlot])
            m_currentBuybackSlot = slot;
    }
}

void Player::SendEquipError(InventoryResult msg, Item* pItem, Item* pItem2, uint32 itemid)
{
    LOG_DEBUG("network", "WORLD: Sent SMSG_INVENTORY_CHANGE_FAILURE ({})", msg);
    WorldPacket data(SMSG_INVENTORY_CHANGE_FAILURE, (msg == EQUIP_ERR_CANT_EQUIP_LEVEL_I ? 22 : 18));
    data << uint8(msg);

    if (msg != EQUIP_ERR_OK)
    {
        data << (pItem ? pItem->GetGUID() : ObjectGuid::Empty);
        data << (pItem2 ? pItem2->GetGUID() : ObjectGuid::Empty);
        data << uint8(0);                                   // bag type subclass, used with EQUIP_ERR_EVENT_AUTOEQUIP_BIND_CONFIRM and EQUIP_ERR_ITEM_DOESNT_GO_INTO_BAG2

        switch (msg)
        {
            case EQUIP_ERR_CANT_EQUIP_LEVEL_I:
            case EQUIP_ERR_PURCHASE_LEVEL_TOO_LOW:
            {
                ItemTemplate const* proto = pItem ? pItem->GetTemplate() : sObjectMgr->GetItemTemplate(itemid);
                data << uint32(proto ? proto->RequiredLevel : 0);
                break;
            }
            case EQUIP_ERR_EVENT_AUTOEQUIP_BIND_CONFIRM:    // no idea about this one...
            {
                data << ObjectGuid::Empty;  // item guid
                data << uint32(0);          // slot
                data << ObjectGuid::Empty;  // container
                break;
            }
            case EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_COUNT_EXCEEDED:
            case EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_SOCKETED_EXCEEDED:
            case EQUIP_ERR_ITEM_MAX_LIMIT_CATEGORY_EQUIPPED_EXCEEDED:
            {
                ItemTemplate const* proto = pItem ? pItem->GetTemplate() : sObjectMgr->GetItemTemplate(itemid);
                data << uint32(proto ? proto->ItemLimitCategory : 0);
                break;
            }
            default:
                break;
        }
    }
    GetSession()->SendPacket(&data);
}

void Player::SendBuyError(BuyResult msg, Creature* creature, uint32 item, uint32 param)
{
    LOG_DEBUG("network", "WORLD: Sent SMSG_BUY_FAILED");
    WorldPacket data(SMSG_BUY_FAILED, (8 + 4 + 4 + 1));
    data << (creature ? creature->GetGUID() : ObjectGuid::Empty);
    data << uint32(item);
    if (param > 0)
        data << uint32(param);
    data << uint8(msg);
    GetSession()->SendPacket(&data);
}

void Player::SendSellError(SellResult msg, Creature* creature, ObjectGuid guid, uint32 param)
{
    LOG_DEBUG("network", "WORLD: Sent SMSG_SELL_ITEM");
    WorldPacket data(SMSG_SELL_ITEM, (8 + 8 + (param ? 4 : 0) + 1)); // last check 2.0.10
    data << (creature ? creature->GetGUID() : ObjectGuid::Empty);
    data << guid;
    if (param > 0)
        data << uint32(param);
    data << uint8(msg);
    GetSession()->SendPacket(&data);
}

void Player::TradeCancel(bool sendback)
{
    if (m_trade)
    {
        Player* trader = m_trade->GetTrader();

        // send yellow "Trade canceled" message to both traders
        if (sendback)
            GetSession()->SendCancelTrade();

        trader->GetSession()->SendCancelTrade();

        // cleanup
        delete m_trade;
        m_trade = nullptr;
        delete trader->m_trade;
        trader->m_trade = nullptr;
    }
}

void Player::UpdateSoulboundTradeItems()
{
    std::lock_guard<std::mutex> guard(m_soulboundTradableLock);
    if (m_itemSoulboundTradeable.empty())
        return;

    // also checks for garbage data
    for (ItemDurationList::iterator itr = m_itemSoulboundTradeable.begin(); itr != m_itemSoulboundTradeable.end();)
    {
        ASSERT(*itr);
        if ((*itr)->GetOwnerGUID() != GetGUID())
        {
            m_itemSoulboundTradeable.erase(itr++);
            continue;
        }
        if ((*itr)->CheckSoulboundTradeExpire())
        {
            m_itemSoulboundTradeable.erase(itr++);
            continue;
        }
        ++itr;
    }
}

void Player::AddTradeableItem(Item* item)
{
    std::lock_guard<std::mutex> guard(m_soulboundTradableLock);
    m_itemSoulboundTradeable.push_back(item);
}

//TODO: should never allow an item to be added to m_itemSoulboundTradeable twice
void Player::RemoveTradeableItem(Item* item)
{
    std::lock_guard<std::mutex> guard(m_soulboundTradableLock);
    m_itemSoulboundTradeable.remove(item);
}

void Player::UpdateItemDuration(uint32 time, bool realtimeonly)
{
    if (m_itemDuration.empty())
        return;

    LOG_DEBUG("entities.player.items", "Player::UpdateItemDuration({}, {})", time, realtimeonly);

    for (ItemDurationList::const_iterator itr = m_itemDuration.begin(); itr != m_itemDuration.end();)
    {
        Item* item = *itr;
        ++itr;                                              // current element can be erased in UpdateDuration

        if (!realtimeonly || item->GetTemplate()->FlagsCu & ITEM_FLAGS_CU_DURATION_REAL_TIME)
            item->UpdateDuration(this, time);
    }
}

void Player::UpdateEnchantTime(uint32 time)
{
    for (EnchantDurationList::iterator itr = m_enchantDuration.begin(), next; itr != m_enchantDuration.end(); itr = next)
    {
        ASSERT(itr->item);
        next = itr;
        if (!itr->item->GetEnchantmentId(itr->slot))
        {
            next = m_enchantDuration.erase(itr);
        }
        else if (itr->leftduration <= time)
        {
            ApplyEnchantment(itr->item, itr->slot, false, false);
            itr->item->ClearEnchantment(itr->slot);
            next = m_enchantDuration.erase(itr);
        }
        else if (itr->leftduration > time)
        {
            itr->leftduration -= time;
            ++next;
        }
    }
}

void Player::AddEnchantmentDurations(Item* item)
{
    for (int x = 0; x < MAX_ENCHANTMENT_SLOT; ++x)
    {
        if (!item->GetEnchantmentId(EnchantmentSlot(x)))
            continue;

        uint32 duration = item->GetEnchantmentDuration(EnchantmentSlot(x));
        if (duration > 0)
            AddEnchantmentDuration(item, EnchantmentSlot(x), duration);
    }
}

void Player::RemoveEnchantmentDurations(Item* item)
{
    for (EnchantDurationList::iterator itr = m_enchantDuration.begin(); itr != m_enchantDuration.end();)
    {
        if (itr->item == item)
        {
            // save duration in item
            item->SetEnchantmentDuration(EnchantmentSlot(itr->slot), itr->leftduration, this);
            itr = m_enchantDuration.erase(itr);
        }
        else
            ++itr;
    }
}

void Player::RemoveEnchantmentDurationsReferences(Item* item)
{
    for (EnchantDurationList::iterator itr = m_enchantDuration.begin(); itr != m_enchantDuration.end();)
    {
        if (itr->item == item)
            itr = m_enchantDuration.erase(itr);
        else
            ++itr;
    }
}

void Player::RemoveArenaEnchantments(EnchantmentSlot slot)
{
    // remove enchantments from equipped items first to clean up the m_enchantDuration list
    for (EnchantDurationList::iterator itr = m_enchantDuration.begin(), next; itr != m_enchantDuration.end(); itr = next)
    {
        next = itr;
        if (itr->slot == slot)
        {
            if (itr->item && itr->item->GetEnchantmentId(slot))
            {
                // Poisons and DK runes are enchants which are allowed on arenas
                if (sSpellMgr->IsArenaAllowedEnchancment(itr->item->GetEnchantmentId(slot)))
                {
                    ++next;
                    continue;
                }
                // remove from stats
                ApplyEnchantment(itr->item, slot, false, false);
                // remove visual
                itr->item->ClearEnchantment(slot);
            }
            // remove from update list
            next = m_enchantDuration.erase(itr);
        }
        else
            ++next;
    }

    // Xinef: check arena allowed enchantments :)
    // remove enchants from inventory items
    // NOTE: no need to remove these from stats, since these aren't equipped
    // in inventory
    for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
        if (Item* pItem = GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            if (uint32 enchId = pItem->GetEnchantmentId(slot))
                if (!sSpellMgr->IsArenaAllowedEnchancment(enchId))
                    pItem->ClearEnchantment(slot);

    // in inventory bags
    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
        if (Bag* pBag = GetBagByPos(i))
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
                if (Item* pItem = pBag->GetItemByPos(j))
                    if (uint32 enchId = pItem->GetEnchantmentId(slot))
                        if (!sSpellMgr->IsArenaAllowedEnchancment(enchId))
                            pItem->ClearEnchantment(slot);
}

// duration == 0 will remove item enchant
void Player::AddEnchantmentDuration(Item* item, EnchantmentSlot slot, uint32 duration)
{
    if (!item)
        return;

    if (slot >= MAX_ENCHANTMENT_SLOT)
        return;

    for (EnchantDurationList::iterator itr = m_enchantDuration.begin(); itr != m_enchantDuration.end(); ++itr)
    {
        if (itr->item == item && itr->slot == slot)
        {
            itr->item->SetEnchantmentDuration(itr->slot, itr->leftduration, this);
            m_enchantDuration.erase(itr);
            break;
        }
    }
    if (item && duration > 0)
    {
        GetSession()->SendItemEnchantTimeUpdate(GetGUID(), item->GetGUID(), slot, uint32(duration / 1000));
        m_enchantDuration.push_back(EnchantDuration(item, slot, duration));
    }
}

void Player::ApplyEnchantment(Item* item, bool apply)
{
    for (uint32 slot = 0; slot < MAX_ENCHANTMENT_SLOT; ++slot)
        ApplyEnchantment(item, EnchantmentSlot(slot), apply);
}

void Player::ApplyEnchantment(Item* item, EnchantmentSlot slot, bool apply, bool apply_dur, bool ignore_condition)
{
    if (!item || !item->IsEquipped())
        return;

    if (slot >= MAX_ENCHANTMENT_SLOT)
        return;

    uint32 enchant_id = item->GetEnchantmentId(slot);
    if (!enchant_id)
        return;

    SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
    if (!pEnchant)
        return;

    if (!ignore_condition && pEnchant->EnchantmentCondition && !EnchantmentFitsRequirements(pEnchant->EnchantmentCondition, -1))
        return;

    if (pEnchant->requiredLevel > GetLevel())
        return;

    if (pEnchant->requiredSkill > 0 && pEnchant->requiredSkillValue > GetSkillValue(pEnchant->requiredSkill))
        return;

    if (!sScriptMgr->CanApplyEnchantment(this, item, slot, apply, apply_dur, ignore_condition))
        return;

    // If we're dealing with a gem inside a prismatic socket we need to check the prismatic socket requirements
    // rather than the gem requirements itself. If the socket has no color it is a prismatic socket.
    if ((slot == SOCK_ENCHANTMENT_SLOT || slot == SOCK_ENCHANTMENT_SLOT_2 || slot == SOCK_ENCHANTMENT_SLOT_3)
        && !item->GetTemplate()->Socket[slot - SOCK_ENCHANTMENT_SLOT].Color)
    {
        // Check if the requirements for the prismatic socket are met before applying the gem stats
        SpellItemEnchantmentEntry const* pPrismaticEnchant = sSpellItemEnchantmentStore.LookupEntry(item->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
        if (!pPrismaticEnchant || (pPrismaticEnchant->requiredSkill > 0 && pPrismaticEnchant->requiredSkillValue > GetSkillValue(pPrismaticEnchant->requiredSkill)))
            return;
    }

    if (!item->IsBroken())
    {
        for (int s = 0; s < MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS; ++s)
        {
            uint32 enchant_display_type = pEnchant->type[s];
            uint32 enchant_amount = pEnchant->amount[s];
            uint32 enchant_spell_id = pEnchant->spellid[s];

            switch (enchant_display_type)
            {
                case ITEM_ENCHANTMENT_TYPE_NONE:
                    break;
                case ITEM_ENCHANTMENT_TYPE_COMBAT_SPELL:
                    // processed in Player::CastItemCombatSpell
                    break;
                case ITEM_ENCHANTMENT_TYPE_DAMAGE:
                    if (item->GetSlot() == EQUIPMENT_SLOT_MAINHAND)
                        HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_VALUE, float(enchant_amount), apply);
                    else if (item->GetSlot() == EQUIPMENT_SLOT_OFFHAND)
                        HandleStatModifier(UNIT_MOD_DAMAGE_OFFHAND, TOTAL_VALUE, float(enchant_amount), apply);
                    else if (item->GetSlot() == EQUIPMENT_SLOT_RANGED)
                        HandleStatModifier(UNIT_MOD_DAMAGE_RANGED, TOTAL_VALUE, float(enchant_amount), apply);
                    break;
                case ITEM_ENCHANTMENT_TYPE_EQUIP_SPELL:
                    if (enchant_spell_id)
                    {
                        if (apply)
                        {
                            int32 basepoints = 0;
                            // Random Property Exist - try found basepoints for spell (basepoints depends from item suffix factor)
                            if (item->GetItemRandomPropertyId())
                            {
                                ItemRandomSuffixEntry const* item_rand = sItemRandomSuffixStore.LookupEntry(std::abs(item->GetItemRandomPropertyId()));
                                if (item_rand)
                                {
                                    // Search enchant_amount
                                    for (int k = 0; k < MAX_ITEM_ENCHANTMENT_EFFECTS; ++k)
                                    {
                                        if (item_rand->Enchantment[k] == enchant_id)
                                        {
                                            basepoints = int32((item_rand->AllocationPct[k] * item->GetItemSuffixFactor()) / 10000);
                                            break;
                                        }
                                    }
                                }
                            }
                            // Cast custom spell vs all equal basepoints got from enchant_amount
                            if (basepoints)
                                CastCustomSpell(this, enchant_spell_id, &basepoints, &basepoints, &basepoints, true, item);
                            else
                                CastSpell(this, enchant_spell_id, true, item);
                        }
                        else
                            RemoveAurasDueToItemSpell(enchant_spell_id, item->GetGUID());
                    }
                    break;
                case ITEM_ENCHANTMENT_TYPE_RESISTANCE:
                    if (!enchant_amount)
                    {
                        ItemRandomSuffixEntry const* item_rand = sItemRandomSuffixStore.LookupEntry(std::abs(item->GetItemRandomPropertyId()));
                        if (item_rand)
                        {
                            for (int k = 0; k < MAX_ITEM_ENCHANTMENT_EFFECTS; ++k)
                            {
                                if (item_rand->Enchantment[k] == enchant_id)
                                {
                                    enchant_amount = uint32((item_rand->AllocationPct[k] * item->GetItemSuffixFactor()) / 10000);
                                    break;
                                }
                            }
                        }
                    }

                    HandleStatModifier(UnitMods(UNIT_MOD_RESISTANCE_START + enchant_spell_id), TOTAL_VALUE, float(enchant_amount), apply);
                    break;
                case ITEM_ENCHANTMENT_TYPE_STAT:
                {
                    if (!enchant_amount)
                    {
                        ItemRandomSuffixEntry const* item_rand_suffix = sItemRandomSuffixStore.LookupEntry(std::abs(item->GetItemRandomPropertyId()));
                        if (item_rand_suffix)
                        {
                            for (int k = 0; k < MAX_ITEM_ENCHANTMENT_EFFECTS; ++k)
                            {
                                if (item_rand_suffix->Enchantment[k] == enchant_id)
                                {
                                    enchant_amount = uint32((item_rand_suffix->AllocationPct[k] * item->GetItemSuffixFactor()) / 10000);
                                    break;
                                }
                            }
                        }
                    }

                    sScriptMgr->OnApplyEnchantmentItemModsBefore(this, item, slot, apply, enchant_spell_id, enchant_amount);

                    LOG_DEBUG("entities.player.items", "Adding {} to stat nb {}", enchant_amount, enchant_spell_id);
                    switch (enchant_spell_id)
                    {
                        case ITEM_MOD_MANA:
                            LOG_DEBUG("entities.player.items", "+ {} MANA", enchant_amount);
                            HandleStatModifier(UNIT_MOD_MANA, BASE_VALUE, float(enchant_amount), apply);
                            break;
                        case ITEM_MOD_HEALTH:
                            LOG_DEBUG("entities.player.items", "+ {} HEALTH", enchant_amount);
                            HandleStatModifier(UNIT_MOD_HEALTH, BASE_VALUE, float(enchant_amount), apply);
                            break;
                        case ITEM_MOD_AGILITY:
                            LOG_DEBUG("entities.player.items", "+ {} AGILITY", enchant_amount);
                            HandleStatModifier(UNIT_MOD_STAT_AGILITY, TOTAL_VALUE, float(enchant_amount), apply);
                            ApplyStatBuffMod(STAT_AGILITY, (float)enchant_amount, apply);
                            break;
                        case ITEM_MOD_STRENGTH:
                            LOG_DEBUG("entities.player.items", "+ {} STRENGTH", enchant_amount);
                            HandleStatModifier(UNIT_MOD_STAT_STRENGTH, TOTAL_VALUE, float(enchant_amount), apply);
                            ApplyStatBuffMod(STAT_STRENGTH, (float)enchant_amount, apply);
                            break;
                        case ITEM_MOD_INTELLECT:
                            LOG_DEBUG("entities.player.items", "+ {} INTELLECT", enchant_amount);
                            HandleStatModifier(UNIT_MOD_STAT_INTELLECT, TOTAL_VALUE, float(enchant_amount), apply);
                            ApplyStatBuffMod(STAT_INTELLECT, (float)enchant_amount, apply);
                            break;
                        case ITEM_MOD_SPIRIT:
                            LOG_DEBUG("entities.player.items", "+ {} SPIRIT", enchant_amount);
                            HandleStatModifier(UNIT_MOD_STAT_SPIRIT, TOTAL_VALUE, float(enchant_amount), apply);
                            ApplyStatBuffMod(STAT_SPIRIT, (float)enchant_amount, apply);
                            break;
                        case ITEM_MOD_STAMINA:
                            LOG_DEBUG("entities.player.items", "+ {} STAMINA", enchant_amount);
                            HandleStatModifier(UNIT_MOD_STAT_STAMINA, TOTAL_VALUE, float(enchant_amount), apply);
                            ApplyStatBuffMod(STAT_STAMINA, (float)enchant_amount, apply);
                            break;
                        case ITEM_MOD_DEFENSE_SKILL_RATING:
                            ApplyRatingMod(CR_DEFENSE_SKILL, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} DEFENCE", enchant_amount);
                            break;
                        case  ITEM_MOD_DODGE_RATING:
                            ApplyRatingMod(CR_DODGE, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} DODGE", enchant_amount);
                            break;
                        case ITEM_MOD_PARRY_RATING:
                            ApplyRatingMod(CR_PARRY, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} PARRY", enchant_amount);
                            break;
                        case ITEM_MOD_BLOCK_RATING:
                            ApplyRatingMod(CR_BLOCK, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} SHIELD_BLOCK", enchant_amount);
                            break;
                        case ITEM_MOD_HIT_MELEE_RATING:
                            ApplyRatingMod(CR_HIT_MELEE, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} MELEE_HIT", enchant_amount);
                            break;
                        case ITEM_MOD_HIT_RANGED_RATING:
                            ApplyRatingMod(CR_HIT_RANGED, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} RANGED_HIT", enchant_amount);
                            break;
                        case ITEM_MOD_HIT_SPELL_RATING:
                            ApplyRatingMod(CR_HIT_SPELL, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} SPELL_HIT", enchant_amount);
                            break;
                        case ITEM_MOD_CRIT_MELEE_RATING:
                            ApplyRatingMod(CR_CRIT_MELEE, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} MELEE_CRIT", enchant_amount);
                            break;
                        case ITEM_MOD_CRIT_RANGED_RATING:
                            ApplyRatingMod(CR_CRIT_RANGED, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} RANGED_CRIT", enchant_amount);
                            break;
                        case ITEM_MOD_CRIT_SPELL_RATING:
                            ApplyRatingMod(CR_CRIT_SPELL, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} SPELL_CRIT", enchant_amount);
                            break;
                            //                        Values from ITEM_STAT_MELEE_HA_RATING to ITEM_MOD_HASTE_RANGED_RATING are never used
                            //                        in Enchantments
                            //                        case ITEM_MOD_HIT_TAKEN_MELEE_RATING:
                            //                            ApplyRatingMod(CR_HIT_TAKEN_MELEE, enchant_amount, apply);
                            //                            break;
                            //                        case ITEM_MOD_HIT_TAKEN_RANGED_RATING:
                            //                            ApplyRatingMod(CR_HIT_TAKEN_RANGED, enchant_amount, apply);
                            //                            break;
                            //                        case ITEM_MOD_HIT_TAKEN_SPELL_RATING:
                            //                            ApplyRatingMod(CR_HIT_TAKEN_SPELL, enchant_amount, apply);
                            //                            break;
                            //                        case ITEM_MOD_CRIT_TAKEN_MELEE_RATING:
                            //                            ApplyRatingMod(CR_CRIT_TAKEN_MELEE, enchant_amount, apply);
                            //                            break;
                            //                        case ITEM_MOD_CRIT_TAKEN_RANGED_RATING:
                            //                            ApplyRatingMod(CR_CRIT_TAKEN_RANGED, enchant_amount, apply);
                            //                            break;
                            //                        case ITEM_MOD_CRIT_TAKEN_SPELL_RATING:
                            //                            ApplyRatingMod(CR_CRIT_TAKEN_SPELL, enchant_amount, apply);
                            //                            break;
                            //                        case ITEM_MOD_HASTE_MELEE_RATING:
                            //                            ApplyRatingMod(CR_HASTE_MELEE, enchant_amount, apply);
                            //                            break;
                        case ITEM_MOD_HASTE_RANGED_RATING:
                            ApplyRatingMod(CR_HASTE_RANGED, enchant_amount, apply);
                            break;
                        case ITEM_MOD_HASTE_SPELL_RATING:
                            ApplyRatingMod(CR_HASTE_SPELL, enchant_amount, apply);
                            break;
                        case ITEM_MOD_HIT_RATING:
                            ApplyRatingMod(CR_HIT_MELEE, enchant_amount, apply);
                            ApplyRatingMod(CR_HIT_RANGED, enchant_amount, apply);
                            ApplyRatingMod(CR_HIT_SPELL, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} HIT", enchant_amount);
                            break;
                        case ITEM_MOD_CRIT_RATING:
                            ApplyRatingMod(CR_CRIT_MELEE, enchant_amount, apply);
                            ApplyRatingMod(CR_CRIT_RANGED, enchant_amount, apply);
                            ApplyRatingMod(CR_CRIT_SPELL, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} CRITICAL", enchant_amount);
                            break;
                            //                        Values ITEM_MOD_HIT_TAKEN_RATING and ITEM_MOD_CRIT_TAKEN_RATING are never used in Enchantment
                            //                        case ITEM_MOD_HIT_TAKEN_RATING:
                            //                            ApplyRatingMod(CR_HIT_TAKEN_MELEE, enchant_amount, apply);
                            //                            ApplyRatingMod(CR_HIT_TAKEN_RANGED, enchant_amount, apply);
                            //                            ApplyRatingMod(CR_HIT_TAKEN_SPELL, enchant_amount, apply);
                            //                            break;
                            //                        case ITEM_MOD_CRIT_TAKEN_RATING:
                            //                            ApplyRatingMod(CR_CRIT_TAKEN_MELEE, enchant_amount, apply);
                            //                            ApplyRatingMod(CR_CRIT_TAKEN_RANGED, enchant_amount, apply);
                            //                            ApplyRatingMod(CR_CRIT_TAKEN_SPELL, enchant_amount, apply);
                            //                            break;
                        case ITEM_MOD_RESILIENCE_RATING:
                            ApplyRatingMod(CR_CRIT_TAKEN_MELEE, enchant_amount, apply);
                            ApplyRatingMod(CR_CRIT_TAKEN_RANGED, enchant_amount, apply);
                            ApplyRatingMod(CR_CRIT_TAKEN_SPELL, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} RESILIENCE", enchant_amount);
                            break;
                        case ITEM_MOD_HASTE_RATING:
                            ApplyRatingMod(CR_HASTE_MELEE, enchant_amount, apply);
                            ApplyRatingMod(CR_HASTE_RANGED, enchant_amount, apply);
                            ApplyRatingMod(CR_HASTE_SPELL, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} HASTE", enchant_amount);
                            break;
                        case ITEM_MOD_EXPERTISE_RATING:
                            ApplyRatingMod(CR_EXPERTISE, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} EXPERTISE", enchant_amount);
                            break;
                        case ITEM_MOD_ATTACK_POWER:
                            HandleStatModifier(UNIT_MOD_ATTACK_POWER, TOTAL_VALUE, float(enchant_amount), apply);
                            HandleStatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, float(enchant_amount), apply);
                            LOG_DEBUG("entities.player.items", "+ {} ATTACK_POWER", enchant_amount);
                            break;
                        case ITEM_MOD_RANGED_ATTACK_POWER:
                            HandleStatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, float(enchant_amount), apply);
                            LOG_DEBUG("entities.player.items", "+ {} RANGED_ATTACK_POWER", enchant_amount);
                            break;
                            //                        case ITEM_MOD_FERAL_ATTACK_POWER:
                            //                            ApplyFeralAPBonus(enchant_amount, apply);
                            //                            LOG_DEBUG("entities.player.items", "+ {} FERAL_ATTACK_POWER", enchant_amount);
                            //                            break;
                        case ITEM_MOD_MANA_REGENERATION:
                            ApplyManaRegenBonus(enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} MANA_REGENERATION", enchant_amount);
                            break;
                        case ITEM_MOD_ARMOR_PENETRATION_RATING:
                            ApplyRatingMod(CR_ARMOR_PENETRATION, enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} ARMOR PENETRATION", enchant_amount);
                            break;
                        case ITEM_MOD_SPELL_POWER:
                            ApplySpellPowerBonus(enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} SPELL_POWER", enchant_amount);
                            break;
                        case ITEM_MOD_HEALTH_REGEN:
                            ApplyHealthRegenBonus(enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} HEALTH_REGENERATION", enchant_amount);
                            break;
                        case ITEM_MOD_SPELL_PENETRATION:
                            ApplySpellPenetrationBonus(enchant_amount, apply);
                            LOG_DEBUG("entities.player.items", "+ {} SPELL_PENETRATION", enchant_amount);
                            break;
                        case ITEM_MOD_BLOCK_VALUE:
                            HandleBaseModValue(SHIELD_BLOCK_VALUE, FLAT_MOD, float(enchant_amount), apply);
                            LOG_DEBUG("entities.player.items", "+ {} BLOCK_VALUE", enchant_amount);
                            break;
                        case ITEM_MOD_SPELL_HEALING_DONE:   // deprecated
                        case ITEM_MOD_SPELL_DAMAGE_DONE:    // deprecated
                        default:
                            break;
                    }
                    break;
                }
                case ITEM_ENCHANTMENT_TYPE_TOTEM:           // Shaman Rockbiter Weapon
                {
                    if (IsClass(CLASS_SHAMAN, CLASS_CONTEXT_ABILITY))
                    {
                        float addValue = 0.0f;
                        if (item->GetSlot() == EQUIPMENT_SLOT_MAINHAND)
                        {
                            addValue = float(enchant_amount * item->GetTemplate()->Delay / 1000.0f);
                            HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_VALUE, addValue, apply);
                        }
                        else if (item->GetSlot() == EQUIPMENT_SLOT_OFFHAND)
                        {
                            addValue = float(enchant_amount * item->GetTemplate()->Delay / 1000.0f);
                            HandleStatModifier(UNIT_MOD_DAMAGE_OFFHAND, TOTAL_VALUE, addValue, apply);
                        }
                    }
                    break;
                }
                case ITEM_ENCHANTMENT_TYPE_USE_SPELL:
                    // processed in Player::CastItemUseSpell
                    break;
                case ITEM_ENCHANTMENT_TYPE_PRISMATIC_SOCKET:
                    // nothing do..
                    break;
                default:
                    LOG_ERROR("entities.player", "Unknown item enchantment (id = {}) display type: {}", enchant_id, enchant_display_type);
                    break;
            }                                               /*switch (enchant_display_type)*/
        }                                                   /*for*/
    }

    // visualize enchantment at player and equipped items
    if (slot == PERM_ENCHANTMENT_SLOT)
        SetUInt16Value(PLAYER_VISIBLE_ITEM_1_ENCHANTMENT + (item->GetSlot() * 2), 0, apply ? item->GetEnchantmentId(slot) : 0);

    if (slot == TEMP_ENCHANTMENT_SLOT)
        SetUInt16Value(PLAYER_VISIBLE_ITEM_1_ENCHANTMENT + (item->GetSlot() * 2), 1, apply ? item->GetEnchantmentId(slot) : 0);

    if (apply_dur)
    {
        if (apply)
        {
            // set duration
            uint32 duration = item->GetEnchantmentDuration(slot);
            if (duration > 0)
                AddEnchantmentDuration(item, slot, duration);
        }
        else
        {
            // duration == 0 will remove EnchantDuration
            AddEnchantmentDuration(item, slot, 0);
        }
    }
}

void Player::UpdateSkillEnchantments(uint16 skill_id, uint16 curr_value, uint16 new_value)
{
    for (uint8 i = 0; i < INVENTORY_SLOT_BAG_END; ++i)
    {
        if (m_items[i])
        {
            for (uint8 slot = 0; slot < MAX_ENCHANTMENT_SLOT; ++slot)
            {
                uint32 ench_id = m_items[i]->GetEnchantmentId(EnchantmentSlot(slot));
                if (!ench_id)
                    continue;

                SpellItemEnchantmentEntry const* Enchant = sSpellItemEnchantmentStore.LookupEntry(ench_id);
                if (!Enchant)
                    return;

                if (Enchant->requiredSkill == skill_id)
                {
                    // Checks if the enchantment needs to be applied or removed
                    if (curr_value < Enchant->requiredSkillValue && new_value >= Enchant->requiredSkillValue)
                        ApplyEnchantment(m_items[i], EnchantmentSlot(slot), true);
                    else if (new_value < Enchant->requiredSkillValue && curr_value >= Enchant->requiredSkillValue)
                        ApplyEnchantment(m_items[i], EnchantmentSlot(slot), false);
                }

                // If we're dealing with a gem inside a prismatic socket we need to check the prismatic socket requirements
                // rather than the gem requirements itself. If the socket has no color it is a prismatic socket.
                if ((slot == SOCK_ENCHANTMENT_SLOT || slot == SOCK_ENCHANTMENT_SLOT_2 || slot == SOCK_ENCHANTMENT_SLOT_3)
                    && !m_items[i]->GetTemplate()->Socket[slot - SOCK_ENCHANTMENT_SLOT].Color)
                {
                    SpellItemEnchantmentEntry const* pPrismaticEnchant = sSpellItemEnchantmentStore.LookupEntry(m_items[i]->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));

                    if (pPrismaticEnchant && pPrismaticEnchant->requiredSkill == skill_id)
                    {
                        if (curr_value < pPrismaticEnchant->requiredSkillValue && new_value >= pPrismaticEnchant->requiredSkillValue)
                            ApplyEnchantment(m_items[i], EnchantmentSlot(slot), true);
                        else if (new_value < pPrismaticEnchant->requiredSkillValue && curr_value >= pPrismaticEnchant->requiredSkillValue)
                            ApplyEnchantment(m_items[i], EnchantmentSlot(slot), false);
                    }
                }
            }
        }
    }
}

void Player::SendEnchantmentDurations()
{
    for (EnchantDurationList::const_iterator itr = m_enchantDuration.begin(); itr != m_enchantDuration.end(); ++itr)
    {
        GetSession()->SendItemEnchantTimeUpdate(GetGUID(), itr->item->GetGUID(), itr->slot, uint32(itr->leftduration) / 1000);
    }
}

void Player::UpdateEnchantmentDurations()
{
    for (EnchantDurationList::iterator itr = m_enchantDuration.begin(); itr != m_enchantDuration.end(); ++itr)
    {
        itr->item->SetEnchantmentDuration(itr->slot, itr->leftduration, this);
    }
}

void Player::SendItemDurations()
{
    for (ItemDurationList::const_iterator itr = m_itemDuration.begin(); itr != m_itemDuration.end(); ++itr)
    {
        (*itr)->SendTimeUpdate(this);
    }
}

void Player::SendNewItem(Item* item, uint32 count, bool received, bool created, bool broadcast, bool sendChatMessage)
{
    if (!item)                                               // prevent crash
        return;

    // last check 2.0.10
    WorldPacket data(SMSG_ITEM_PUSH_RESULT, (8 + 4 + 4 + 4 + 1 + 4 + 4 + 4 + 4 + 4));
    data << GetGUID();                                      // player GUID
    data << uint32(received);                               // 0=looted, 1=from npc
    data << uint32(created);                                // 0=received, 1=created
    data << uint32(sendChatMessage);                        // bool print message to chat
    data << uint8(item->GetBagSlot());                      // bagslot
    // item slot, but when added to stack: 0xFFFFFFFF
    data << uint32((item->GetCount() == count) ? item->GetSlot() : -1);
    data << uint32(item->GetEntry());                       // item id
    data << uint32(item->GetItemSuffixFactor());            // SuffixFactor
    data << int32(item->GetItemRandomPropertyId());         // random item property id
    data << uint32(count);                                  // count of items
    data << uint32(GetItemCount(item->GetEntry()));         // count of items in inventory

    if (broadcast && GetGroup())
        GetGroup()->BroadcastPacket(&data, true);
    else
        GetSession()->SendPacket(&data);
}

/*********************************************************/
/***                   LOAD SYSTEM                     ***/
/*********************************************************/

void Player::Initialize(ObjectGuid::LowType guid)
{
    Object::_Create(guid, 0, HighGuid::Player);
}

void Player::_LoadDeclinedNames(PreparedQueryResult result)
{
    if (!result)
        return;

    delete m_declinedname;
    m_declinedname = new DeclinedName;
    for (uint8 i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
        m_declinedname->name[i] = (*result)[i].Get<std::string>();
}

void Player::_LoadArenaTeamInfo()
{
    memset((void*)&m_uint32Values[PLAYER_FIELD_ARENA_TEAM_INFO_1_1], 0, sizeof(uint32) * MAX_ARENA_SLOT * ARENA_TEAM_END);

    for (auto const& itr : ArenaTeam::ArenaSlotByType)
        if (uint32 arenaTeamId = sCharacterCache->GetCharacterArenaTeamIdByGuid(GetGUID(), itr.second))
        {
            ArenaTeam* arenaTeam = sArenaTeamMgr->GetArenaTeamById(arenaTeamId);
            if (!arenaTeam)
            {
                LOG_ERROR("bg.arena", "Player::_LoadArenaTeamInfo: No arena team was found.");
                continue;
            }
            ArenaTeamMember const* member = arenaTeam->GetMember(GetGUID());
            if (!member)
            {
                LOG_ERROR("bg.arena", "Player::_LoadArenaTeamInfo: No members in the arena team ({}) was found.", arenaTeamId);
                continue;
            }
            uint8 slot = itr.second;

            SetArenaTeamInfoField(slot, ARENA_TEAM_ID, arenaTeamId);
            SetArenaTeamInfoField(slot, ARENA_TEAM_TYPE, arenaTeam->GetType());
            SetArenaTeamInfoField(slot, ARENA_TEAM_MEMBER, (arenaTeam->GetCaptain() == GetGUID()) ? 0 : 1);
            SetArenaTeamInfoField(slot, ARENA_TEAM_GAMES_WEEK, member->WeekGames);
            SetArenaTeamInfoField(slot, ARENA_TEAM_GAMES_SEASON, member->SeasonGames);
            SetArenaTeamInfoField(slot, ARENA_TEAM_WINS_SEASON, member->SeasonWins);
            SetArenaTeamInfoField(slot, ARENA_TEAM_PERSONAL_RATING, member->PersonalRating);
        }
}

void Player::_LoadEquipmentSets(PreparedQueryResult result)
{
    // SetQuery(PLAYER_LOGIN_QUERY_LOADEQUIPMENTSETS,   "SELECT setguid, setindex, name, iconname, item0, item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14, item15, item16, item17, item18 FROM character_equipmentsets WHERE guid = '{}' ORDER BY setindex", m_guid.GetCounter());
    if (!result)
        return;

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        EquipmentSet eqSet;

        eqSet.Guid      = fields[0].Get<uint64>();
        uint8 index    = fields[1].Get<uint8>();
        eqSet.Name      = fields[2].Get<std::string>();
        eqSet.IconName  = fields[3].Get<std::string>();
        eqSet.IgnoreMask = fields[4].Get<uint32>();
        eqSet.state     = EQUIPMENT_SET_UNCHANGED;

        for (uint32 i = 0; i < EQUIPMENT_SLOT_END; ++i)
            eqSet.Items[i] = ObjectGuid::Create<HighGuid::Item>(fields[5 + i].Get<uint32>());

        m_EquipmentSets[index] = eqSet;

        ++count;

        if (count >= MAX_EQUIPMENT_SET_INDEX)                // client limit
            break;
    } while (result->NextRow());
}

void Player::_LoadEntryPointData(PreparedQueryResult result)
{
    if (!result)
        return;

    Field* fields = result->Fetch();
    m_entryPointData.joinPos = WorldLocation(fields[4].Get<uint32>(),  // Map
                                             fields[0].Get<float>(),   // X
                                             fields[1].Get<float>(),   // Y
                                             fields[2].Get<float>(),   // Z
                                             fields[3].Get<float>());  // Orientation

    m_entryPointData.taxiPath[0] = fields[5].Get<uint32>();
    m_entryPointData.taxiPath[1] = fields[6].Get<uint32>();
    m_entryPointData.mountSpell = fields[7].Get<uint32>();
}

bool Player::LoadPositionFromDB(uint32& mapid, float& x, float& y, float& z, float& o, bool& in_flight, ObjectGuid::LowType guid)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_POSITION);
    stmt->SetData(0, guid);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);

    if (!result)
        return false;

    Field* fields = result->Fetch();

    x = fields[0].Get<float>();
    y = fields[1].Get<float>();
    z = fields[2].Get<float>();
    o = fields[3].Get<float>();
    mapid = fields[4].Get<uint16>();
    in_flight = !fields[5].Get<std::string>().empty();

    return true;
}

void Player::SetHomebind(WorldLocation const& loc, uint32 areaId)
{
    loc.GetPosition(m_homebindX, m_homebindY, m_homebindZ);
    m_homebindMapId = loc.GetMapId();
    m_homebindAreaId = areaId;

    // update sql homebind
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_PLAYER_HOMEBIND);
    stmt->SetData(0, m_homebindMapId);
    stmt->SetData(1, m_homebindAreaId);
    stmt->SetData (2, m_homebindX);
    stmt->SetData (3, m_homebindY);
    stmt->SetData (4, m_homebindZ);
    stmt->SetData(5, GetGUID().GetCounter());
    CharacterDatabase.Execute(stmt);
}

bool Player::isBeingLoaded() const
{
    return GetSession()->PlayerLoading();
}

bool Player::LoadFromDB(ObjectGuid playerGuid, CharacterDatabaseQueryHolder const& holder)
{
    ////                                                     0     1        2     3     4        5      6    7      8     9    10    11         12         13           14         15         16
    //QueryResult* result = CharacterDatabase.Query("SELECT guid, account, name, race, class, gender, level, xp, money, skin, face, hairStyle, hairColor, facialStyle, bankSlots, restState, playerFlags, "
    // 17          18          19          20   21           22        23        24         25         26          27           28                 29
    //"position_x, position_y, position_z, map, orientation, taximask, cinematic, totaltime, leveltime, rest_bonus, logout_time, is_logout_resting, resettalents_cost, "
    // 30                 31       32       33       34       35         36           37             38        39    40      41                 42         43
    //"resettalents_time, trans_x, trans_y, trans_z, trans_o, transguid, extra_flags, stable_slots, at_login, zone, online, death_expire_time, taxi_path, instance_mode_mask, "
    // 44           45                46                 47                    48          49          50              51           52               53              54
    //"arenaPoints, totalHonorPoints, todayHonorPoints, yesterdayHonorPoints, totalKills, todayKills, yesterdayKills, chosenTitle, knownCurrencies, watchedFaction, drunk, "
    // 55      56      57      58      59      60      61      62      63           64                 65                 66             67              68      69
    //"health, power1, power2, power3, power4, power5, power6, power7, instance_id, talentGroupsCount, activeTalentGroup, exploredZones, equipmentCache, ammoId, knownTitles,
    // 70          71               72            73                     74
    //"actionBars, grantableLevels, innTriggerId, extraBonusTalentCount, UNIX_TIMESTAMP(creation_date) FROM characters WHERE guid = '{}'", guid);
    PreparedQueryResult result = holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_FROM);

    if (!result)
    {
        LOG_ERROR("entities.player", "Player ({}) not found in table `characters`, can't load. ", playerGuid.ToString());
        return false;
    }

    Field* fields = result->Fetch();

    uint32 dbAccountId = fields[1].Get<uint32>();

    // check if the character's account in the db and the logged in account match.
    // player should be able to load/delete character only with correct account!
    if (dbAccountId != GetSession()->GetAccountId())
    {
        LOG_ERROR("entities.player", "Player ({}) loading from wrong account (is: {}, should be: {})", playerGuid.ToString(), GetSession()->GetAccountId(), dbAccountId);
        return false;
    }

    if (holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_BANNED))
    {
        LOG_ERROR("entities.player", "Player ({}) is banned, can't load.", playerGuid.ToString());
        return false;
    }

    ObjectGuid::LowType guid = playerGuid.GetCounter();

    Object::_Create(guid, 0, HighGuid::Player);

    m_name = fields[2].Get<std::string>();

    // check name limitations
    if (ObjectMgr::CheckPlayerName(m_name) != CHAR_NAME_SUCCESS)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
        stmt->SetData(0, uint16(AT_LOGIN_RENAME));
        stmt->SetData(1, guid);
        CharacterDatabase.Execute(stmt);
        return false;
    }

    uint8 Gender = fields[5].Get<uint8>();
    if (!IsValidGender(Gender))
    {
        LOG_ERROR("entities.player", "Player (GUID: {}) has wrong gender ({}), can't be loaded.", guid, Gender);
        return false;
    }

    // overwrite some data fields
    uint32 bytes0 = 0;
    bytes0 |= fields[3].Get<uint8>();                         // race
    bytes0 |= fields[4].Get<uint8>() << 8;                    // class
    bytes0 |= Gender << 16;                                 // gender
    SetUInt32Value(UNIT_FIELD_BYTES_0, bytes0);

    m_realRace = fields[3].Get<uint8>(); // set real race
    m_race = fields[3].Get<uint8>(); // set real race

    SetUInt32Value(UNIT_FIELD_LEVEL, fields[6].Get<uint8>());
    SetUInt32Value(PLAYER_XP, fields[7].Get<uint32>());

    if (!_LoadIntoDataField(fields[66].Get<std::string>(), PLAYER_EXPLORED_ZONES_1, PLAYER_EXPLORED_ZONES_SIZE))
    {
        LOG_WARN("entities.player.loading", "Player::LoadFromDB: Player ({}) has invalid exploredzones data ({}). Forcing partial load.", guid, fields[66].Get<std::string_view>());
    }

    if (!_LoadIntoDataField(fields[69].Get<std::string>(), PLAYER__FIELD_KNOWN_TITLES, KNOWN_TITLES_SIZE * 2))
    {
        LOG_WARN("entities.player.loading", "Player::LoadFromDB: Player ({}) has invalid knowntitles mask ({}). Forcing partial load.", guid, fields[69].Get<std::string_view>());
    }

    SetObjectScale(1.0f);
    SetFloatValue(UNIT_FIELD_HOVERHEIGHT, 1.0f);

    // load character creation date, relevant for achievements of type average
    SetCreationTime(fields[74].Get<Seconds>());

    // load achievements before anything else to prevent multiple gains for the same achievement/criteria on every loading (as loading does call UpdateAchievementCriteria)
    m_achievementMgr->LoadFromDB(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_ACHIEVEMENTS), holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_CRITERIA_PROGRESS));

    uint32 money = fields[8].Get<uint32>();
    if (money > MAX_MONEY_AMOUNT)
        money = MAX_MONEY_AMOUNT;
    SetMoney(money);

    SetByteValue(PLAYER_BYTES, 0, fields[9].Get<uint8>());
    SetByteValue(PLAYER_BYTES, 1, fields[10].Get<uint8>());
    SetByteValue(PLAYER_BYTES, 2, fields[11].Get<uint8>());
    SetByteValue(PLAYER_BYTES, 3, fields[12].Get<uint8>());
    SetByteValue(PLAYER_BYTES_2, 0, fields[13].Get<uint8>());
    SetByteValue(PLAYER_BYTES_2, 2, fields[14].Get<uint8>());
    SetByteValue(PLAYER_BYTES_2, 3, fields[15].Get<uint8>());
    SetByteValue(PLAYER_BYTES_3, 0, fields[5].Get<uint8>());
    SetByteValue(PLAYER_BYTES_3, 1, fields[54].Get<uint8>());
    ReplaceAllPlayerFlags((PlayerFlags)fields[16].Get<uint32>());
    SetInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX, fields[53].Get<uint32>());

    SetUInt64Value(PLAYER_FIELD_KNOWN_CURRENCIES, fields[52].Get<uint64>());

    SetUInt32Value(PLAYER_AMMO_ID, fields[68].Get<uint32>());

    // set which actionbars the client has active - DO NOT REMOVE EVER AGAIN (can be changed though, if it does change fieldwise)
    SetByteValue(PLAYER_FIELD_BYTES, 2, fields[70].Get<uint8>());

    InitDisplayIds();

    // cleanup inventory related item value fields (its will be filled correctly in _LoadInventory)
    for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
    {
        SetGuidValue(PLAYER_FIELD_INV_SLOT_HEAD + (slot * 2), ObjectGuid::Empty);
        SetVisibleItemSlot(slot, nullptr);

        delete m_items[slot];
        m_items[slot] = nullptr;
    }

    LOG_DEBUG("entities.player.loading", "Load Basic value of player {} is: ", m_name);
    outDebugValues();

    //Need to call it to initialize m_team (m_team can be calculated from race)
    //Other way is to saves m_team into characters table.
    SetFactionForRace(getRace(true));

    // pussywizard: create empty instance bind containers if necessary
    sInstanceSaveMgr->PlayerCreateBoundInstancesMaps(playerGuid);

    // load home bind and check in same time class/race pair, it used later for restore broken positions
    if (!_LoadHomeBind(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_HOME_BIND)))
        return false;

    InitPrimaryProfessions();                               // to max set before any spell loaded

    // init saved position, and fix it later if problematic
    int32 transLowGUID = fields[35].Get<int32>();
    Relocate(fields[17].Get<float>(), fields[18].Get<float>(), fields[19].Get<float>(), fields[21].Get<float>());
    uint32 mapId = fields[20].Get<uint16>();
    uint32 instanceId = fields[63].Get<uint32>();

    uint32 dungeonDiff = fields[43].Get<uint8>() & 0x0F;
    if (dungeonDiff >= MAX_DUNGEON_DIFFICULTY)
        dungeonDiff = DUNGEON_DIFFICULTY_NORMAL;
    uint32 raidDiff = (fields[43].Get<uint8>() >> 4) & 0x0F;
    if (raidDiff >= MAX_RAID_DIFFICULTY)
        raidDiff = RAID_DIFFICULTY_10MAN_NORMAL;
    SetDungeonDifficulty(Difficulty(dungeonDiff));          // may be changed in _LoadGroup
    SetRaidDifficulty(Difficulty(raidDiff));                // may be changed in _LoadGroup

    std::string taxi_nodes = fields[42].Get<std::string>();

    auto RelocateToHomebind = [this, &mapId, &instanceId]() { mapId = m_homebindMapId; instanceId = 0; Relocate(m_homebindX, m_homebindY, m_homebindZ); };

    _LoadGroup();

    _LoadArenaTeamInfo();

    SetArenaPoints(fields[44].Get<uint32>());

    SetHonorPoints(fields[45].Get<uint32>());
    SetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, fields[46].Get<uint32>());
    SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, fields[47].Get<uint32>());
    SetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, fields[48].Get<uint32>());
    SetUInt16Value(PLAYER_FIELD_KILLS, 0, fields[49].Get<uint16>());
    SetUInt16Value(PLAYER_FIELD_KILLS, 1, fields[50].Get<uint16>());

    _LoadInstanceTimeRestrictions(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_INSTANCE_LOCK_TIMES));
    _LoadEntryPointData(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_ENTRY_POINT));

    GetSession()->SetPlayer(this);
    MapEntry const* mapEntry = sMapStore.LookupEntry(mapId);

    Map* map = nullptr;

    // pussywizard: group changed difficulty when player was offline, teleport to the enterance of new difficulty
    if (mapEntry && ((mapEntry->IsNonRaidDungeon() && dungeonDiff != GetDungeonDifficulty()) || (mapEntry->IsRaid() && raidDiff != GetRaidDifficulty())))
    {
        bool fixed = false;
        if (uint32 destInstId = sInstanceSaveMgr->PlayerGetDestinationInstanceId(this, mapId, GetDifficulty(mapEntry->IsRaid())))
        {
            instanceId = destInstId;
            if (AreaTriggerTeleport const* at = sObjectMgr->GetMapEntranceTrigger(mapId))
            {
                Relocate(at->target_X, at->target_Y, at->target_Z, at->target_Orientation);
                fixed = true;
            }
        }
        if (!fixed)
        {
            RelocateToHomebind();
            mapEntry = sMapStore.LookupEntry(mapId);
        }
    }

    if (!mapEntry || !IsPositionValid())
    {
        LOG_ERROR("entities.player", "Player (guidlow {}) have invalid coordinates (MapId: {} X: {} Y: {} Z: {} O: {}). Teleport to default race/class locations.", guid, mapId, GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
        RelocateToHomebind();
    }
        // Player was saved in Arena or Bg
    else if (mapEntry->IsBattlegroundOrArena())
    {
        // xinef: resurrect player, cant log in dead without corpse
        {
            if (HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
                RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);
            if (!IsAlive())
                ResurrectPlayer(1.0f);
        }

        const WorldLocation& _loc = GetEntryPoint();
        mapId = _loc.GetMapId();
        instanceId = 0;

        if (mapId == MAPID_INVALID)
        {
            RelocateToHomebind();
        }
        else
        {
            Relocate(&_loc);

            // xinef: restore taxi flight from entry point data
            if (m_entryPointData.HasTaxiPath())
            {
                m_taxi.AddTaxiDestination(m_entryPointData.taxiPath[0]);
                m_taxi.AddTaxiDestination(m_entryPointData.taxiPath[1]);
                m_entryPointData.ClearTaxiPath();
            }
        }
    }
        // currently we do not support transport in bg
    else if (transLowGUID != 0)
    {
        // transLowGUID > 0 ---> motion transport guid
        // transLowGUID < 0 ---> static transport spawn id
        Transport* transGO = nullptr;
        if (transLowGUID > 0)
        {
            ObjectGuid transGUID = ObjectGuid::Create<HighGuid::Mo_Transport>(transLowGUID);
            transGO = HashMapHolder<MotionTransport>::Find(transGUID);
        }
        else
        {
            map = sMapMgr->CreateMap(mapId, this);
            if (map)
            {
                auto bounds = map->GetGameObjectBySpawnIdStore().equal_range(std::abs(transLowGUID));
                if (bounds.first != bounds.second)
                    transGO = bounds.first->second->ToTransport();
            }
        }

        // pussywizard: must be on map, for one world tick transport is not in map and has old GetMapId(), player would be added to old map and to the transport, multithreading crashfix
        if (transGO && transGO->IsInWorld() && transGO->FindMap())
            m_transport = transGO;

        if (m_transport)
        {
            float x = fields[31].Get<float>(), y = fields[32].Get<float>(), z = fields[33].Get<float>(), o = fields[34].Get<float>();
            m_movementInfo.transport.guid = m_transport->GetGUID();
            m_movementInfo.transport.pos.Relocate(x, y, z, o);
            m_transport->CalculatePassengerPosition(x, y, z, &o);

            if (!Acore::IsValidMapCoord(x, y, z, o) || std::fabs(m_movementInfo.transport.pos.GetPositionX()) > 75.0f || std::fabs(m_movementInfo.transport.pos.GetPositionY()) > 75.0f || std::fabs(m_movementInfo.transport.pos.GetPositionZ()) > 75.0f)
            {
                m_transport = nullptr;
                m_movementInfo.transport.Reset();
                m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
                RelocateToHomebind();
            }
            else
            {
                Relocate(x, y, z, o);
                mapId = m_transport->GetMapId();
                m_transport->AddPassenger(this);
                AddUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
            }
        }
        else
        {
            bool fixed = false;
            if (mapEntry->Instanceable())
                if (AreaTriggerTeleport const* at = sObjectMgr->GetMapEntranceTrigger(mapId))
                {
                    fixed = true;
                    Relocate(at->target_X, at->target_Y, at->target_Z, at->target_Orientation);
                }
            if (!fixed)
            RelocateToHomebind();
        }
    }
        // currently we do not support taxi in instance
    else if (!taxi_nodes.empty())
    {
        instanceId = 0;
        if (!m_taxi.LoadTaxiDestinationsFromString(taxi_nodes, GetTeamId(true)))
        {
            // xinef: could no load valid data for taxi, relocate to homebind and clear
            m_taxi.ClearTaxiDestinations();
            RelocateToHomebind();
        }
    }

    // Map could be changed before
    mapEntry = sMapStore.LookupEntry(mapId);
    // client without expansion support
    if (mapEntry)
    {
        if (GetSession()->Expansion() < mapEntry->Expansion())
        {
            LOG_DEBUG("entities.player.loading", "Player {} using client without required expansion tried login at non accessible map {}", GetName(), mapId);
            RelocateToHomebind();
        }

        // check whether player was unbound or is bound to another instance
        if (instanceId)
        {
            InstanceSave* save = sInstanceSaveMgr->PlayerGetInstanceSave(GetGUID(), mapId, GetDifficulty(mapEntry->IsRaid()));
            if (!save || save->GetInstanceId() != instanceId)
                instanceId = 0;
        }
    }

    // if the player is in an instance and it has been reset in the meantime teleport him to the entrance
    if ((instanceId && !sInstanceSaveMgr->GetInstanceSave(instanceId) && !mapEntry->IsBattlegroundOrArena()) || (!instanceId && mapEntry->IsDungeon()))
    {
        AreaTriggerTeleport const* at = sObjectMgr->GetMapEntranceTrigger(mapId);
        if (at)
            Relocate(at->target_X, at->target_Y, at->target_Z, at->target_Orientation);
        else
            RelocateToHomebind();
    }

    // NOW player must have valid map
    // load the player's map here if it's not already loaded
    if (!map)
        map = sMapMgr->CreateMap(mapId, this);

    if (!map)
    {
        instanceId = 0;
        AreaTriggerTeleport const* at = sObjectMgr->GetGoBackTrigger(mapId);
        if (at)
        {
            LOG_ERROR("entities.player", "Player (guidlow {}) is teleported to gobacktrigger (Map: {} X: {} Y: {} Z: {} O: {}).", guid, mapId, GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
            Relocate(at->target_X, at->target_Y, at->target_Z, GetOrientation());
            mapId = at->target_mapId;
        }
        else
        {
            LOG_ERROR("entities.player", "Player (guidlow {}) is teleported to home (Map: {} X: {} Y: {} Z: {} O: {}).", guid, mapId, GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
            RelocateToHomebind();
        }

        map = sMapMgr->CreateMap(mapId, this);
        if (!map)
        {
            PlayerInfo const* info = sObjectMgr->GetPlayerInfo(getRace(true), getClass());
            mapId = info->mapId;
            Relocate(info->positionX, info->positionY, info->positionZ, 0.0f);
            LOG_ERROR("entities.player", "Player (guidlow {}) have invalid coordinates (X: {} Y: {} Z: {} O: {}). Teleport to default race/class locations.", guid, GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
            map = sMapMgr->CreateMap(mapId, this);
            if (!map)
            {
                LOG_ERROR("entities.player", "Player (guidlow {}) has invalid default map coordinates (X: {} Y: {} Z: {} O: {}). or instance couldn't be created", guid, GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());
                return false;
            }
        }
    }

    SetMap(map);
    StoreRaidMapDifficulty();

    UpdatePositionData();

    SaveRecallPosition();

    time_t now = GameTime::GetGameTime().count();
    time_t logoutTime = time_t(fields[27].Get<uint32>());

    // since last logout (in seconds)
    uint32 time_diff = uint32(now - logoutTime); //uint64 is excessive for a time_diff in seconds.. uint32 allows for 136~ year difference.

    // randomize first save time in range [CONFIG_INTERVAL_SAVE] around [CONFIG_INTERVAL_SAVE]
    // this must help in case next save after mass player load after server startup
    m_nextSave = urand(m_nextSave / 2, m_nextSave * 3 / 2);

    // set value, including drunk invisibility detection
    // calculate sobering. after 15 minutes logged out, the player will be sober again
    uint8 newDrunkValue = 0;
    if (time_diff < uint32(GetDrunkValue()) * 9)
        newDrunkValue = GetDrunkValue() - time_diff / 9;

    SetDrunkValue(newDrunkValue);

    m_cinematic = fields[23].Get<uint8>();
    m_Played_time[PLAYED_TIME_TOTAL] = fields[24].Get<uint32>();
    m_Played_time[PLAYED_TIME_LEVEL] = fields[25].Get<uint32>();

    m_resetTalentsCost = fields[29].Get<uint32>();
    m_resetTalentsTime = time_t(fields[30].Get<uint32>());

    m_taxi.LoadTaxiMask(fields[22].Get<std::string_view>());            // must be before InitTaxiNodesForLevel

    uint32 extraflags = fields[36].Get<uint16>();

    _LoadPetStable(fields[37].Get<uint8>(), holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_PET_SLOTS));

    m_atLoginFlags = fields[38].Get<uint16>();

    if (HasAtLoginFlag(AT_LOGIN_RENAME))
    {
        LOG_ERROR("entities.player", "Player {} tried to login while forced to rename, can't load.'", GetGUID().ToString());
        return false;
    }

    // Honor system
    // Update Honor kills data
    m_lastHonorUpdateTime = logoutTime;
    UpdateHonorFields();

    m_deathExpireTime = time_t(fields[41].Get<uint32>());

    if (m_deathExpireTime > now + MAX_DEATH_COUNT * DEATH_EXPIRE_STEP)
        m_deathExpireTime = now + MAX_DEATH_COUNT * DEATH_EXPIRE_STEP - 1;

    // clear channel spell data (if saved at channel spell casting)
    SetGuidValue(UNIT_FIELD_CHANNEL_OBJECT, ObjectGuid::Empty);
    SetUInt32Value(UNIT_CHANNEL_SPELL, 0);

    // clear charm/summon related fields
    SetOwnerGUID(ObjectGuid::Empty);
    SetGuidValue(UNIT_FIELD_CHARMEDBY, ObjectGuid::Empty);
    SetGuidValue(UNIT_FIELD_CHARM, ObjectGuid::Empty);
    SetGuidValue(UNIT_FIELD_SUMMON, ObjectGuid::Empty);
    SetGuidValue(PLAYER_FARSIGHT, ObjectGuid::Empty);
    SetCreatorGUID(ObjectGuid::Empty);

    RemoveUnitFlag2(UNIT_FLAG2_FORCE_MOVEMENT);

    // reset some aura modifiers before aura apply
    SetUInt32Value(PLAYER_TRACK_CREATURES, 0);
    SetUInt32Value(PLAYER_TRACK_RESOURCES, 0);

    // make sure the unit is considered not in duel for proper loading
    SetGuidValue(PLAYER_DUEL_ARBITER, ObjectGuid::Empty);
    SetUInt32Value(PLAYER_DUEL_TEAM, 0);

    // reset stats before loading any modifiers
    InitStatsForLevel();
    InitGlyphsForLevel();
    InitTaxiNodesForLevel();
    InitRunes();

    sScriptMgr->OnPlayerLoadFromDB(this);

    // make sure the unit is considered out of combat for proper loading
    ClearInCombat();

    // rest bonus can only be calculated after InitStatsForLevel()
    _restBonus = fields[26].Get<float>();

    if (time_diff > 0)
    {
        //speed collect rest bonus in offline, in logout, far from tavern, city (section/in hour)
        float bubble0 = 0.031f;
        //speed collect rest bonus in offline, in logout, in tavern, city (section/in hour)
        float bubble1 = 0.125f;
        float bubble  = fields[28].Get<uint8>() > 0
                       ? bubble1 * sWorld->getRate(RATE_REST_OFFLINE_IN_TAVERN_OR_CITY)
                       : bubble0 * sWorld->getRate(RATE_REST_OFFLINE_IN_WILDERNESS);

        // Client automatically doubles the value sent so we have to divide it by 2
        SetRestBonus(GetRestBonus() + time_diff * ((float)GetUInt32Value(PLAYER_NEXT_LEVEL_XP) / 144000)*bubble);
    }

    uint32 innTriggerId = fields[72].Get<uint32>();
    if (innTriggerId)
    {
        SetRestFlag(REST_FLAG_IN_TAVERN, innTriggerId);
    }

    // load skills after InitStatsForLevel because it triggering aura apply also
    _LoadSkills(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_SKILLS));
    UpdateSkillsForLevel(); //update skills after load, to make sure they are correctly update at player load

    // apply original stats mods before spell loading or item equipment that call before equip _RemoveStatsMods()

    m_specsCount = fields[64].Get<uint8>();
    m_activeSpec = fields[65].Get<uint8>();

    LearnDefaultSkills();
    LearnCustomSpells();

    _LoadSpells(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_SPELLS));
    _LoadTalents(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_TALENTS));

    _LoadGlyphs(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_GLYPHS));
    _LoadGlyphAuras();
    _LoadAuras(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_AURAS), time_diff);
    // add ghost flag (must be after aura load: PLAYER_FLAGS_GHOST set in aura)
    if (HasPlayerFlag(PLAYER_FLAGS_GHOST))
    {
        m_deathState = DeathState::Dead;
        AddUnitState(UNIT_STATE_ISOLATED);
    }

    // pussywizard: remove auras that are removed at map change (after _LoadAuras)
    RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_CHANGE_MAP);

    // after spell load, learn rewarded spell if need also
    _LoadQuestStatus(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_QUEST_STATUS));
    _LoadQuestStatusRewarded(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_QUEST_STATUS_REW));
    _LoadDailyQuestStatus(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_DAILY_QUEST_STATUS));
    _LoadWeeklyQuestStatus(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_WEEKLY_QUEST_STATUS));
    _LoadSeasonalQuestStatus(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_SEASONAL_QUEST_STATUS));
    _LoadMonthlyQuestStatus(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_MONTHLY_QUEST_STATUS));
    _LoadRandomBGStatus(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_RANDOM_BG));

    // Extra Bonus Talent Points
    m_extraBonusTalentCount = fields[73].Get<uint8>();

    // after spell, bonus talents, and quest load
    InitTalentForLevel();

    // must be before inventory (some items required reputation check)
    m_reputationMgr->LoadFromDB(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_REPUTATION));

    // xinef: load mails before inventory, so problematic items can be added to already loaded mails
    _LoadMail(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_MAILS), holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_MAIL_ITEMS));

    _LoadInventory(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_INVENTORY), time_diff);

    // update items with duration and realtime
    UpdateItemDuration(time_diff, true);

    _LoadActions(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_ACTIONS));

    m_social = sSocialMgr->LoadFromDB(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_SOCIAL_LIST), GetGUID());

    // check PLAYER_CHOSEN_TITLE compatibility with PLAYER__FIELD_KNOWN_TITLES
    // note: PLAYER__FIELD_KNOWN_TITLES updated at quest status loaded
    uint32 curTitle = fields[51].Get<uint32>();
    if (curTitle && !HasTitle(curTitle))
        curTitle = 0;

    SetUInt32Value(PLAYER_CHOSEN_TITLE, curTitle);

    // has to be called after last Relocate() in Player::LoadFromDB
    SetFallInformation(GameTime::GetGameTime().count(), GetPositionZ());

    _LoadSpellCooldowns(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_SPELL_COOLDOWNS));

    // Spell code allow apply any auras to dead character in load time in aura/spell/item loading
    // Do now before stats re-calculation cleanup for ghost state unexpected auras
    if (!IsAlive())
        RemoveAllAurasOnDeath();
    else
        RemoveAllAurasRequiringDeadTarget();

    //apply all stat bonuses from items and auras
    SetCanModifyStats(true);
    UpdateAllStats();

    // restore remembered power/health values (but not more max values)
    uint32 savedHealth = fields[55].Get<uint32>();
    SetHealth(savedHealth > GetMaxHealth() ? GetMaxHealth() : savedHealth);
    for (uint8 i = 0; i < MAX_POWERS; ++i)
    {
        uint32 savedPower = fields[56 + i].Get<uint32>();
        SetPower(Powers(i), savedPower > GetMaxPower(Powers(i)) ? GetMaxPower(Powers(i)) : savedPower);
    }

    LOG_DEBUG("entities.player.loading", "The value of player {} after load item and aura is: ", m_name);
    outDebugValues();

    // GM state
    if (!AccountMgr::IsPlayerAccount(GetSession()->GetSecurity()))
    {
        switch (sWorld->getIntConfig(CONFIG_GM_LOGIN_STATE))
        {
            default:
            case 0:
                break;             // disable
            case 1:
                SetGameMaster(true);
                break;             // enable
            case 2:                                         // save state
                if (extraflags & PLAYER_EXTRA_GM_ON)
                    SetGameMaster(true);
                break;
        }

        switch (sWorld->getIntConfig(CONFIG_GM_VISIBLE_STATE))
        {
            default:
            case 0:
                SetGMVisible(false);
                break;             // invisible
            case 1:
                break;             // visible
            case 2:                                         // save state
                if (extraflags & PLAYER_EXTRA_GM_INVISIBLE)
                    SetGMVisible(false);
                break;
        }

        switch (sWorld->getIntConfig(CONFIG_GM_CHAT))
        {
            default:
            case 0:
                break;                 // disable
            case 1:
                SetGMChat(true);
                break;                 // enable
            case 2:                                         // save state
                if (extraflags & PLAYER_EXTRA_GM_CHAT)
                    SetGMChat(true);
                break;
        }

        switch (sWorld->getIntConfig(CONFIG_GM_WHISPERING_TO))
        {
            default:
            case 0:
                break;         // disable
            case 1:
                SetAcceptWhispers(true);
                break;         // enable
            case 2:                                         // save state
                if (extraflags & PLAYER_EXTRA_ACCEPT_WHISPERS)
                    SetAcceptWhispers(true);
                break;
        }
    }

    // RaF stuff.
    m_grantableLevels = fields[71].Get<uint8>();
    if (GetSession()->IsARecruiter() || (GetSession()->GetRecruiterId() != 0))
        SetDynamicFlag(UNIT_DYNFLAG_REFER_A_FRIEND);

    if (m_grantableLevels > 0)
        SetByteValue(PLAYER_FIELD_BYTES, 1, 0x01);

    _LoadDeclinedNames(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_DECLINED_NAMES));

    //m_achievementMgr->CheckAllAchievementCriteria(); // pussywizard: disabled this

    _LoadEquipmentSets(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_EQUIPMENT_SETS));

    _LoadBrewOfTheMonth(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_BREW_OF_THE_MONTH));

    _LoadCharacterSettings(holder.GetPreparedResult(PLAYER_LOGIN_QUERY_LOAD_CHARACTER_SETTINGS));

    // Players are immune to taunt
    ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
    ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, true);

    // Init charm info
    PrepareCharmAISpells();

    // Fix aurastate auras, depending on health!
    // Set aurastate manualy, prevents aura switching
    if (HealthBelowPct(20))
        SetFlag(UNIT_FIELD_AURASTATE, 1 << (AURA_STATE_HEALTHLESS_20_PERCENT - 1));
    if (HealthBelowPct(35))
        SetFlag(UNIT_FIELD_AURASTATE, 1 << (AURA_STATE_HEALTHLESS_35_PERCENT - 1));
    if (HealthAbovePct(75))
        SetFlag(UNIT_FIELD_AURASTATE, 1 << (AURA_STATE_HEALTH_ABOVE_75_PERCENT - 1));

    // unapply aura stats if dont meet requirements
    AuraApplicationMap const& Auras = GetAppliedAuras();
    for (AuraApplicationMap::const_iterator itr = Auras.begin(); itr != Auras.end(); ++itr)
    {
        // we assume that all auras are applied now, aurastate was modfied MANUALY preventing any apply/unapply state switching
        Aura* aura = itr->second->GetBase();
        SpellInfo const* m_spellInfo = aura->GetSpellInfo();
        if (m_spellInfo->CasterAuraState != AURA_STATE_HEALTHLESS_20_PERCENT &&
            m_spellInfo->CasterAuraState != AURA_STATE_HEALTHLESS_35_PERCENT &&
            m_spellInfo->CasterAuraState != AURA_STATE_HEALTH_ABOVE_75_PERCENT)
            continue;

        if (!HasAuraState((AuraStateType)m_spellInfo->CasterAuraState))
            aura->HandleAllEffects(itr->second, AURA_EFFECT_HANDLE_REAL, false);
    }
    return true;
}

bool Player::isAllowedToLoot(Creature const* creature)
{
    if (!creature->isDead() || !creature->IsDamageEnoughForLootingAndReward())
        return false;

    if (HasPendingBind())
        return false;

    const Loot* loot = &creature->loot;
    if (loot->isLooted()) // nothing to loot or everything looted.
        return false;

    if (!loot->hasItemForAll() && !loot->hasItemFor(this)) // no loot in creature for this player
        return false;

    if (loot->loot_type == LOOT_SKINNING)
        return creature->GetLootRecipientGUID() == GetGUID();

    Group* thisGroup = GetGroup();
    if (!thisGroup)
        return this == creature->GetLootRecipient();
    else if (thisGroup != creature->GetLootRecipientGroup())
        return false;

    switch (thisGroup->GetLootMethod())
    {
        case MASTER_LOOT:
        case FREE_FOR_ALL:
            return true;
        case ROUND_ROBIN:
            // may only loot if the player is the loot roundrobin player
            // or if there are free/quest/conditional item for the player
            if (!loot->roundRobinPlayer || loot->roundRobinPlayer == GetGUID())
                return true;

            return loot->hasItemFor(this);
        case GROUP_LOOT:
        case NEED_BEFORE_GREED:
            // may only loot if the player is the loot roundrobin player
            // or item over threshold (so roll(s) can be launched)
            // or if there are free/quest/conditional item for the player
            if (!loot->roundRobinPlayer || loot->roundRobinPlayer == GetGUID())
                return true;

            if (loot->hasOverThresholdItem())
                return true;

            return loot->hasItemFor(this);
    }

    return false;
}

void Player::_LoadActions(PreparedQueryResult result)
{
    m_actionButtons.clear();

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            uint8 button = fields[0].Get<uint8>();
            uint32 action = fields[1].Get<uint32>();
            uint8 type = fields[2].Get<uint8>();

            if (ActionButton* ab = addActionButton(button, action, type))
                ab->uState = ACTIONBUTTON_UNCHANGED;
            else
            {
                LOG_ERROR("entities.player", "ActionButton loading problem, will be deleted from db...");

                // Will deleted in DB at next save (it can create data until save but marked as deleted)
                m_actionButtons[button].uState = ACTIONBUTTON_DELETED;
            }
        } while (result->NextRow());
    }
}

void Player::_LoadAuras(PreparedQueryResult result, uint32 timediff)
{
    LOG_DEBUG("entities.player.loading", "Loading auras for player {}", GetGUID().ToString());

    /*                                                     0           1         2           3      4                5           6        7        8        9             10            11
    QueryResult* result = CharacterDatabase.Query("SELECT casterGuid, itemGuid, spell, effectMask, recalculateMask, stackCount, amount0, amount1, amount2, base_amount0, base_amount1, base_amount2,
                                                    12           13          14
                                                    maxDuration, remainTime, remainCharges FROM character_aura WHERE guid = '{}'", GetGUID().GetCounter());
    */

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            int32 damage[3];
            int32 baseDamage[3];
            ObjectGuid caster_guid = ObjectGuid(fields[0].Get<uint64>());
            ObjectGuid itemGuid = ObjectGuid(fields[1].Get<uint64>());
            uint32 spellid = fields[2].Get<uint32>();
            uint8 effmask = fields[3].Get<uint8>();
            uint8 recalculatemask = fields[4].Get<uint8>();
            uint8 stackcount = fields[5].Get<uint8>();
            damage[0] = fields[6].Get<int32>();
            damage[1] = fields[7].Get<int32>();
            damage[2] = fields[8].Get<int32>();
            baseDamage[0] = fields[9].Get<int32>();
            baseDamage[1] = fields[10].Get<int32>();
            baseDamage[2] = fields[11].Get<int32>();
            int32 maxduration = fields[12].Get<int32>();
            int32 remaintime = fields[13].Get<int32>();
            uint8 remaincharges = fields[14].Get<uint8>();

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellid);
            if (!spellInfo)
            {
                LOG_ERROR("entities.player", "Unknown aura (spellid {}), ignore.", spellid);
                continue;
            }

            // Xinef: leave this
            if (spellInfo->HasAura(SPELL_AURA_MOUNTED))
            {
                SetMountBlockId(spellInfo->Id);
                continue;
            }

            // negative effects should continue counting down after logout
            if (remaintime != -1 && ((!spellInfo->IsPositive() && spellInfo->Id != 15007) || spellInfo->HasAttribute(SPELL_ATTR4_AURA_EXPIRES_OFFLINE))) // Xinef: resurrection sickness should not tick when logged off
            {
                if (remaintime / IN_MILLISECONDS <= int32(timediff))
                    continue;

                remaintime -= timediff * IN_MILLISECONDS;
            }

            // prevent wrong values of remaincharges
            if (spellInfo->ProcCharges)
            {
                // we have no control over the order of applying auras and modifiers allow auras
                // to have more charges than value in SpellInfo
                if (remaincharges <= 0/* || remaincharges > spellproto->procCharges*/)
                    remaincharges = spellInfo->ProcCharges;
            }
            else
                remaincharges = 0;

            if (Aura* aura = Aura::TryCreate(spellInfo, effmask, this, nullptr, &baseDamage[0], nullptr, caster_guid, itemGuid))
            {
                if (!aura->CanBeSaved())
                {
                    aura->Remove();
                    continue;
                }

                aura->SetLoadedState(maxduration, remaintime, remaincharges, stackcount, recalculatemask, &damage[0]);
                aura->ApplyForTargets();
                LOG_DEBUG("entities.player", "Added aura spellid {}, effectmask {}", spellInfo->Id, effmask);
            }
        } while (result->NextRow());
    }
}

void Player::_LoadGlyphAuras()
{
    for (uint8 i = 0; i < MAX_GLYPH_SLOT_INDEX; ++i)
    {
        if (uint32 glyph = GetGlyph(i))
        {
            if (GlyphPropertiesEntry const* glyphEntry = sGlyphPropertiesStore.LookupEntry(glyph))
            {
                if (GlyphSlotEntry const* glyphSlotEntry = sGlyphSlotStore.LookupEntry(GetGlyphSlot(i)))
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(glyphEntry->SpellId);
                    if (glyphEntry->TypeFlags == glyphSlotEntry->TypeFlags)
                    {
                        if (!spellInfo->Stances)
                            CastSpell(this, glyphEntry->SpellId, TriggerCastFlags(TRIGGERED_FULL_MASK & ~(TRIGGERED_IGNORE_SHAPESHIFT | TRIGGERED_IGNORE_CASTER_AURASTATE)));
                        continue;
                    }
                    else
                        LOG_ERROR("entities.player", "Player {} has glyph with typeflags {} in slot with typeflags {}, removing.", m_name, glyphEntry->TypeFlags, glyphSlotEntry->TypeFlags);
                }
                else
                    LOG_ERROR("entities.player", "Player {} has not existing glyph slot entry {} on index {}", m_name, GetGlyphSlot(i), i);
            }
            else
                LOG_ERROR("entities.player", "Player {} has not existing glyph entry {} on index {}", m_name, glyph, i);

            // On any error remove glyph
            SetGlyph(i, 0, true);
        }
    }
}

void Player::LoadCorpse(PreparedQueryResult result)
{
    if (IsAlive() || HasAtLoginFlag(AT_LOGIN_RESURRECT))
        SpawnCorpseBones(false);

    if (!IsAlive())
    {
        if (result && !HasAtLoginFlag(AT_LOGIN_RESURRECT))
        {
            Field* fields = result->Fetch();
            _corpseLocation.WorldRelocate(fields[0].Get<uint16>(), fields[1].Get<float>(), fields[2].Get<float>(), fields[3].Get<float>(), fields[4].Get<float>());
            ApplyModFlag(PLAYER_FIELD_BYTES, PLAYER_FIELD_BYTE_RELEASE_TIMER, !sMapStore.LookupEntry(_corpseLocation.GetMapId())->Instanceable());
        }
        else
            ResurrectPlayer(0.5f);
    }

    RemoveAtLoginFlag(AT_LOGIN_RESURRECT);
}

void Player::_LoadInventory(PreparedQueryResult result, uint32 timeDiff)
{
    //QueryResult* result = CharacterDatabase.Query("SELECT data, text, bag, slot, item, item_template FROM character_inventory JOIN item_instance ON character_inventory.item = item_instance.guid WHERE character_inventory.guid = '{}' ORDER BY bag, slot", GetGUID().GetCounter());
    //NOTE: the "order by `bag`" is important because it makes sure
    //the bagMap is filled before items in the bags are loaded
    //NOTE2: the "order by `slot`" is needed because mainhand weapons are (wrongly?)
    //expected to be equipped before offhand items (TODO: fixme)

    if (result)
    {
        uint32 zoneId = GetZoneId();

        std::map<ObjectGuid::LowType, Bag*> bagMap;                 // fast guid lookup for bags
        std::map<ObjectGuid::LowType, Item*> invalidBagMap;         // fast guid lookup for bags
        std::list<Item*> problematicItems;
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        // Prevent items from being added to the queue while loading
        m_itemUpdateQueueBlocked = true;
        do
        {
            Field* fields = result->Fetch();
            if (Item* item = _LoadItem(trans, zoneId, timeDiff, fields))
            {
                ObjectGuid::LowType bagGuid  = fields[11].Get<uint32>();
                uint8  slot     = fields[12].Get<uint8>();

                uint8 err = EQUIP_ERR_OK;
                // Item is not in bag
                if (!bagGuid)
                {
                    item->SetContainer(nullptr);
                    item->SetSlot(slot);

                    if (IsInventoryPos(INVENTORY_SLOT_BAG_0, slot))
                    {
                        ItemPosCountVec dest;
                        err = CanStoreItem(INVENTORY_SLOT_BAG_0, slot, dest, item, false);
                        if (err == EQUIP_ERR_OK)
                            item = StoreItem(dest, item, true);
                    }
                    else if (IsEquipmentPos(INVENTORY_SLOT_BAG_0, slot))
                    {
                        uint16 dest;
                        if (sScriptMgr->CheckItemInSlotAtLoadInventory(this, item, slot, err, dest))
                            err = CanEquipItem(slot, dest, item, false, false);
                        if (err == EQUIP_ERR_OK)
                            QuickEquipItem(dest, item);
                    }
                    else if (IsBankPos(INVENTORY_SLOT_BAG_0, slot))
                    {
                        ItemPosCountVec dest;
                        err = CanBankItem(INVENTORY_SLOT_BAG_0, slot, dest, item, false, false);
                        if (err == EQUIP_ERR_OK)
                            item = BankItem(dest, item, true);
                    }

                    // Remember bags that may contain items in them
                    if (err == EQUIP_ERR_OK)
                    {
                        if (IsBagPos(item->GetPos()))
                            if (Bag* pBag = item->ToBag())
                                bagMap[item->GetGUID().GetCounter()] = pBag;
                    }
                    else if (IsBagPos(item->GetPos()))
                        if (item->IsBag())
                            invalidBagMap[item->GetGUID().GetCounter()] = item;
                }
                else
                {
                    item->SetSlot(NULL_SLOT);
                    // Item is in the bag, find the bag
                    std::map<ObjectGuid::LowType, Bag*>::iterator itr = bagMap.find(bagGuid);
                    if (itr != bagMap.end())
                    {
                        ItemPosCountVec dest;
                        err = CanStoreItem(itr->second->GetSlot(), slot, dest, item);
                        if (err == EQUIP_ERR_OK)
                            item = StoreItem(dest, item, true);
                    }
                    else if (invalidBagMap.find(bagGuid) != invalidBagMap.end())
                    {
                        std::map<ObjectGuid::LowType, Item*>::iterator iterator = invalidBagMap.find(bagGuid);
                        if (std::find(problematicItems.begin(), problematicItems.end(), iterator->second) != problematicItems.end())
                        {
                            err = EQUIP_ERR_INT_BAG_ERROR;
                        }
                    }
                    else
                    {
                        LOG_ERROR("entities.player", "Player::_LoadInventory: player ({}, name: '{}') has item ({}, entry: {}) which doesnt have a valid bag (Bag GUID: {}, slot: {}). Possible cheat?",
                                  GetGUID().ToString(), GetName(), item->GetGUID().ToString(), item->GetEntry(), bagGuid, slot);
                        item->DeleteFromInventoryDB(trans);
                        delete item;
                        continue;
                    }
                }

                // Item's state may have changed after storing
                if (err == EQUIP_ERR_OK)
                    item->SetState(ITEM_UNCHANGED, this);
                else
                {
                    LOG_ERROR("entities.player", "Player::_LoadInventory: player ({}, name: '{}') has item ({}, entry: {}) which can't be loaded into inventory (Bag GUID: {}, slot: {}) by reason {}. Item will be sent by mail.",
                              GetGUID().ToString(), GetName(), item->GetGUID().ToString(), item->GetEntry(), bagGuid, slot, err);
                    item->DeleteFromInventoryDB(trans);
                    problematicItems.push_back(item);
                }
            }
        } while (result->NextRow());

        m_itemUpdateQueueBlocked = false;

        // Send problematic items by mail
        while (!problematicItems.empty())
        {
            std::string subject = GetSession()->GetAcoreString(LANG_NOT_EQUIPPED_ITEM);

            MailDraft draft(subject, "There were problems with equipping item(s).");
            for (uint8 i = 0; !problematicItems.empty() && i < MAX_MAIL_ITEMS; ++i)
            {
                draft.AddItem(problematicItems.front());
                problematicItems.pop_front();
            }
            draft.SendMailTo(trans, this, MailSender(this, MAIL_STATIONERY_GM), MAIL_CHECK_MASK_COPIED);
        }
        CharacterDatabase.CommitTransaction(trans);
    }
    //if (IsAlive())
    _ApplyAllItemMods();
}

Item* Player::_LoadItem(CharacterDatabaseTransaction trans, uint32 zoneId, uint32 timeDiff, Field* fields)
{
    Item* item = nullptr;
    ObjectGuid::LowType itemGuid  = fields[13].Get<uint32>();
    uint32 itemEntry = fields[14].Get<uint32>();
    if (ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemEntry))
    {
        bool remove = false;
        item = NewItemOrBag(proto);
        if (item->LoadFromDB(itemGuid, GetGUID(), fields, itemEntry))
        {
            CharacterDatabasePreparedStatement* stmt = nullptr;

            // Do not allow to have item limited to another map/zone in alive state
            if (IsAlive() && item->IsLimitedToAnotherMapOrZone(GetMapId(), zoneId))
            {
                LOG_DEBUG("entities.player.loading", "Player::_LoadInventory: player ({}, name: '{}', map: {}) has item ({}, entry: {}) limited to another map ({}). Deleting item.",
                          GetGUID().ToString(), GetName(), GetMapId(), item->GetGUID().ToString(), item->GetEntry(), zoneId);
                remove = true;
            }
                // "Conjured items disappear if you are logged out for more than 15 minutes"
            else if (timeDiff > 15 * MINUTE && proto->Flags & ITEM_FLAG_CONJURED)
            {
                LOG_DEBUG("entities.player.loading", "Player::_LoadInventory: player ({}, name: '{}', diff: {}) has conjured item ({}, entry: {}) with expired lifetime (15 minutes). Deleting item.",
                          GetGUID().ToString(), GetName(), timeDiff, item->GetGUID().ToString(), item->GetEntry());
                remove = true;
            }
            else if (item->HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_REFUNDABLE))
            {
                if (item->GetPlayedTime() > (2 * HOUR))
                {
                    LOG_DEBUG("entities.player.loading", "Player::_LoadInventory: player ({}, name: '{}') has item ({}, entry: {}) with expired refund time ({}). Deleting refund data and removing refundable flag.",
                              GetGUID().ToString(), GetName(), item->GetGUID().ToString(), item->GetEntry(), item->GetPlayedTime());
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_REFUND_INSTANCE);
                    stmt->SetData(0, item->GetGUID().GetCounter());
                    trans->Append(stmt);

                    item->RemoveFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_REFUNDABLE);
                }
                else
                {
                    // xinef: sync query
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ITEM_REFUNDS);
                    stmt->SetData(0, item->GetGUID().GetCounter());
                    stmt->SetData(1, GetGUID().GetCounter());
                    if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
                    {
                        item->SetRefundRecipient((*result)[0].Get<uint32>());
                        item->SetPaidMoney((*result)[1].Get<uint32>());
                        item->SetPaidExtendedCost((*result)[2].Get<uint16>());
                        AddRefundReference(item->GetGUID());
                    }
                    else
                    {
                        LOG_DEBUG("entities.player.loading", "Player::_LoadInventory: player ({}, name: '{}') has item ({}, entry: {}) with refundable flags, but without data in item_refund_instance. Removing flag.",
                                  GetGUID().ToString(), GetName(), item->GetGUID().ToString(), item->GetEntry());
                        item->RemoveFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_REFUNDABLE);
                    }
                }
            }
            else if (item->HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_BOP_TRADEABLE))
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ITEM_BOP_TRADE);
                stmt->SetData(0, item->GetGUID().GetCounter());

                if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
                {
                    AllowedLooterSet looters;
                    for (std::string_view guidStr : Acore::Tokenize((*result)[0].Get<std::string_view>(), ' ', false))
                    {
                        if (Optional<ObjectGuid::LowType> guid = Acore::StringTo<ObjectGuid::LowType>(guidStr))
                        {
                            looters.insert(ObjectGuid::Create<HighGuid::Player>(*guid));
                        }
                        else
                        {
                            LOG_WARN("entities.player.loading", "Player::_LoadInventory: invalid item_soulbound_trade_data GUID '{}' for item {}. Skipped.", guidStr, item->GetGUID().ToString());
                        }
                    }

                    if (looters.size() > 1 && item->GetTemplate()->GetMaxStackSize() == 1 && item->IsSoulBound())
                    {
                        item->SetSoulboundTradeable(looters);
                        AddTradeableItem(item);
                    }
                    else
                        item->ClearSoulboundTradeable(this);
                }
                else
                {
                    LOG_DEBUG("entities.player.loading", "Player::_LoadInventory: player ({}, name: '{}') has item ({}, entry: {}) with ITEM_FIELD_FLAG_BOP_TRADEABLE flag, but without data in item_soulbound_trade_data. Removing flag.",
                              GetGUID().ToString(), GetName(), item->GetGUID().ToString(), item->GetEntry());
                    item->RemoveFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_BOP_TRADEABLE);
                }
            }
            else if (proto->HolidayId)
            {
                remove = true;
                GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();
                GameEventMgr::ActiveEvents const& activeEventsList = sGameEventMgr->GetActiveEventList();
                for (GameEventMgr::ActiveEvents::const_iterator itr = activeEventsList.begin(); itr != activeEventsList.end(); ++itr)
                {
                    if (uint32(events[*itr].holiday_id) == proto->HolidayId)
                    {
                        remove = false;
                        break;
                    }
                }
            }
        }
        else
        {
            LOG_ERROR("entities.player", "Player::_LoadInventory: player ({}, name: '{}') has broken item (GUID: {}, entry: {}) in inventory. Deleting item.",
                      GetGUID().ToString(), GetName(), itemGuid, itemEntry);
            remove = true;
        }
        // Remove item from inventory if necessary
        if (remove)
        {
            Item::DeleteFromInventoryDB(trans, itemGuid);
            item->FSetState(ITEM_REMOVED);
            item->SaveToDB(trans);                           // it also deletes item object!
            item = nullptr;
        }
    }
    else
    {
        LOG_ERROR("entities.player", "Player::_LoadInventory: player ({}, name: '{}') has unknown item (entry: {}) in inventory. Deleting item.",
                  GetGUID().ToString(), GetName(), itemEntry);
        Item::DeleteFromInventoryDB(trans, itemGuid);
        Item::DeleteFromDB(trans, itemGuid);
    }
    return item;
}

// load mailed item which should receive current player
Item* Player::_LoadMailedItem(ObjectGuid const& playerGuid, Player* player, uint32 mailId, Mail* mail, Field* fields)
{
    ObjectGuid::LowType itemGuid = fields[11].Get<uint32>();
    uint32 itemEntry = fields[12].Get<uint32>();

    ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemEntry);
    if (!proto)
    {
        LOG_ERROR("entities.player", "Player {} ({}) has unknown item in mailed items (GUID: {}, Entry: {}) in mail ({}), deleted.",
            player ? player->GetName() : "<unknown>", playerGuid.ToString(), itemGuid, itemEntry, mailId);

        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_INVALID_MAIL_ITEM);
        stmt->SetData(0, itemGuid);
        trans->Append(stmt);

        CharacterDatabase.CommitTransaction(trans);
        return nullptr;
    }

    Item* item = NewItemOrBag(proto);

    ObjectGuid ownerGuid = fields[13].Get<uint32>() ? ObjectGuid::Create<HighGuid::Player>(fields[13].Get<uint32>()) : ObjectGuid::Empty;
    if (!item->LoadFromDB(itemGuid, ownerGuid, fields, itemEntry))
    {
        LOG_ERROR("entities.player", "Player::_LoadMailedItems: Item (GUID: {}) in mail ({}) doesn't exist, deleted from mail.", itemGuid, mailId);

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM);
        stmt->SetData(0, itemGuid);
        CharacterDatabase.Execute(stmt);

        item->FSetState(ITEM_REMOVED);

        CharacterDatabaseTransaction temp = CharacterDatabaseTransaction(nullptr);
        item->SaveToDB(temp);
        return nullptr;
    }

    if (mail)
    {
        mail->AddItem(itemGuid, itemEntry);
    }

    if (player)
    {
        player->AddMItem(item);
    }

    return item;
}

void Player::_LoadMail(PreparedQueryResult mailsResult, PreparedQueryResult mailItemsResult)
{
    time_t cur_time = GameTime::GetGameTime().count();

    m_mail.clear();

    std::unordered_map<uint32, Mail*> mailById;

    if (mailsResult)
    {
        do
        {
            Field* fields = mailsResult->Fetch();
            Mail* m = new Mail;

            m->messageID      = fields[0].Get<uint32>();
            m->messageType    = fields[1].Get<uint8>();
            m->sender         = fields[2].Get<uint32>();
            m->receiver       = fields[3].Get<uint32>();
            m->subject        = fields[4].Get<std::string>();
            m->body           = fields[5].Get<std::string>();
            m->expire_time    = time_t(fields[6].Get<uint32>());
            m->deliver_time   = time_t(fields[7].Get<uint32>());
            m->money          = fields[8].Get<uint32>();
            m->COD            = fields[9].Get<uint32>();
            m->checked        = fields[10].Get<uint8>();
            m->stationery     = fields[11].Get<uint8>();
            m->mailTemplateId = fields[12].Get<int16>();

            if (cur_time > m->expire_time)
            {
                LOG_DEBUG("entities.player", "Player::_LoadMail: Mail ({}) has expired - ignored.", m->messageID);
                continue;
            }

            if (m->mailTemplateId && !sMailTemplateStore.LookupEntry(m->mailTemplateId))
            {
                LOG_ERROR("entities.player", "Player::_LoadMail: Mail ({}) has nonexistent MailTemplateId ({}), remove at load", m->messageID, m->mailTemplateId);
                m->mailTemplateId = 0;
            }

            m->state = MAIL_STATE_UNCHANGED;

            m_mail.push_back(m);
            mailById[m->messageID] = m;
        } while (mailsResult->NextRow());
    }

    if (mailItemsResult)
    {
        do
        {
            Field* fields = mailItemsResult->Fetch();
            uint32 mailId = fields[14].Get<uint32>();
            _LoadMailedItem(GetGUID(), this, mailId, mailById[mailId], fields);
        } while (mailItemsResult->NextRow());
    }

    UpdateNextMailTimeAndUnreads();
}

void Player::LoadPet()
{
    //fixme: the pet should still be loaded if the player is not in world
    // just not added to the map
    if (m_petStable && IsInWorld())
    {
        Pet* pet = new Pet(this);
        if (!pet->LoadPetFromDB(this, 0, 0, true))
            delete pet;
    }
}

void Player::_LoadQuestStatus(PreparedQueryResult result)
{
    uint16 slot = 0;

    ////                                                       0      1       2        3        4           5          6         7           8           9           10
    //QueryResult* result = CharacterDatabase.Query("SELECT quest, status, explored, timer, mobcount1, mobcount2, mobcount3, mobcount4, itemcount1, itemcount2, itemcount3,
    //                                                    11          12          13           14
    //                                                itemcount4, itemcount5, itemcount6, playercount FROM character_queststatus WHERE guid = '{}'", GetGUID().GetCounter());

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();

            uint32 quest_id = fields[0].Get<uint32>();
            // used to be new, no delete?
            Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
            if (quest)
            {
                // find or create
                QuestStatusData& questStatusData = m_QuestStatus[quest_id];

                uint8 qstatus = fields[1].Get<uint8>();
                if (qstatus < MAX_QUEST_STATUS)
                    questStatusData.Status = QuestStatus(qstatus);
                else
                {
                    questStatusData.Status = QUEST_STATUS_INCOMPLETE;
                    LOG_ERROR("entities.player", "Player {} ({}) has invalid quest {} status ({}), replaced by QUEST_STATUS_INCOMPLETE(3).",
                              GetName(), GetGUID().ToString(), quest_id, qstatus);
                }

                questStatusData.Explored = (fields[2].Get<uint8>() > 0);

                time_t quest_time = time_t(fields[3].Get<uint32>());

                if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED) && !GetQuestRewardStatus(quest_id))
                {
                    AddTimedQuest(quest_id);

                    if (quest_time <= GameTime::GetGameTime().count())
                        questStatusData.Timer = 1;
                    else
                        questStatusData.Timer = uint32((quest_time - GameTime::GetGameTime().count()) * IN_MILLISECONDS);
                }
                else
                    quest_time = 0;

                for (uint32 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
                    questStatusData.CreatureOrGOCount[i] = fields[4 + i].Get<uint16>();

                for (uint32 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; ++i)
                    questStatusData.ItemCount[i] = fields[8 + i].Get<uint16>();

                questStatusData.PlayerCount = fields[14].Get<uint16>();

                // add to quest log
                if (slot < MAX_QUEST_LOG_SIZE && questStatusData.Status != QUEST_STATUS_NONE)
                {
                    SetQuestSlot(slot, quest_id, uint32(quest_time)); // cast can't be helped

                    if (questStatusData.Status == QUEST_STATUS_COMPLETE)
                        SetQuestSlotState(slot, QUEST_STATE_COMPLETE);
                    else if (questStatusData.Status == QUEST_STATUS_FAILED)
                        SetQuestSlotState(slot, QUEST_STATE_FAIL);

                    for (uint8 idx = 0; idx < QUEST_OBJECTIVES_COUNT; ++idx)
                        if (questStatusData.CreatureOrGOCount[idx])
                            SetQuestSlotCounter(slot, idx, questStatusData.CreatureOrGOCount[idx]);

                    if (questStatusData.PlayerCount)
                        SetQuestSlotCounter(slot, QUEST_PVP_KILL_SLOT, questStatusData.PlayerCount);

                    ++slot;
                }

                LOG_DEBUG("entities.player.loading", "Quest status is {{}} for quest {{}} for player ({})", questStatusData.Status, quest_id, GetGUID().ToString());
            }
        } while (result->NextRow());
    }

    // clear quest log tail
    for (uint16 i = slot; i < MAX_QUEST_LOG_SIZE; ++i)
        SetQuestSlot(i, 0);
}

void Player::_LoadQuestStatusRewarded(PreparedQueryResult result)
{
    // SELECT quest FROM character_queststatus_rewarded WHERE guid = ?

    if (result)
    {
        m_RewardedQuests.rehash(result->GetRowCount());
        do
        {
            Field* fields = result->Fetch();

            uint32 quest_id = fields[0].Get<uint32>();
            // used to be new, no delete?
            Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
            if (quest)
            {
                // learn rewarded spell if unknown
                learnQuestRewardedSpells(quest);

                // set rewarded title if any
                if (quest->GetCharTitleId())
                {
                    if (CharTitlesEntry const* titleEntry = sCharTitlesStore.LookupEntry(quest->GetCharTitleId()))
                        SetTitle(titleEntry);
                }

                if (quest->GetBonusTalents())
                    m_questRewardTalentCount += quest->GetBonusTalents();
            }

            m_RewardedQuests.insert(quest_id);
        } while (result->NextRow());
    }
}

void Player::_LoadDailyQuestStatus(PreparedQueryResult result)
{
    for (uint32 quest_daily_idx = 0; quest_daily_idx < PLAYER_MAX_DAILY_QUESTS; ++quest_daily_idx)
        SetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx, 0);

    m_DFQuests.clear();

    //QueryResult* result = CharacterDatabase.Query("SELECT quest, time FROM character_queststatus_daily WHERE guid = '{}'", GetGUID().GetCounter());

    if (result)
    {
        uint32 quest_daily_idx = 0;

        do
        {
            Field* fields = result->Fetch();
            if (Quest const* qQuest = sObjectMgr->GetQuestTemplate(fields[0].Get<uint32>()))
            {
                if (qQuest->IsDFQuest())
                {
                    m_DFQuests.insert(qQuest->GetQuestId());
                    m_lastDailyQuestTime = time_t(fields[1].Get<uint32>());
                    continue;
                }
            }

            if (quest_daily_idx >= PLAYER_MAX_DAILY_QUESTS)  // max amount with exist data in query
            {
                LOG_ERROR("entities.player", "Player ({}) have more 25 daily quest records in `charcter_queststatus_daily`", GetGUID().ToString());
                break;
            }

            uint32 quest_id = fields[0].Get<uint32>();

            // save _any_ from daily quest times (it must be after last reset anyway)
            m_lastDailyQuestTime = time_t(fields[1].Get<uint32>());

            Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
            if (!quest)
                continue;

            SetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx, quest_id);
            ++quest_daily_idx;

            LOG_DEBUG("entities.player.loading", "Daily quest ({}) cooldown for player ({})", quest_id, GetGUID().ToString());
        } while (result->NextRow());
    }

    m_DailyQuestChanged = false;
}

void Player::_LoadWeeklyQuestStatus(PreparedQueryResult result)
{
    m_weeklyquests.clear();

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 quest_id = fields[0].Get<uint32>();
            Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
            if (!quest)
                continue;

            m_weeklyquests.insert(quest_id);
            LOG_DEBUG("entities.player.loading", "Weekly quest {{}} cooldown for player ({})", quest_id, GetGUID().ToString());
        } while (result->NextRow());
    }

    m_WeeklyQuestChanged = false;
}

void Player::_LoadSeasonalQuestStatus(PreparedQueryResult result)
{
    m_seasonalquests.clear();

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 quest_id = fields[0].Get<uint32>();
            uint32 event_id = fields[1].Get<uint32>();
            Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
            if (!quest)
                continue;

            m_seasonalquests[event_id].insert(quest_id);
            LOG_DEBUG("entities.player.loading", "Seasonal quest {{}} cooldown for player ({})", quest_id, GetGUID().ToString());
        } while (result->NextRow());
    }

    m_SeasonalQuestChanged = false;
}

void Player::_LoadMonthlyQuestStatus(PreparedQueryResult result)
{
    m_monthlyquests.clear();

    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 quest_id = fields[0].Get<uint32>();
            Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
            if (!quest)
                continue;

            m_monthlyquests.insert(quest_id);
            LOG_DEBUG("entities.player.loading", "Monthly quest {{}} cooldown for player ({})", quest_id, GetGUID().ToString());
        } while (result->NextRow());
    }

    m_MonthlyQuestChanged = false;
}

void Player::_LoadSpells(PreparedQueryResult result)
{
    //QueryResult* result = CharacterDatabase.Query("SELECT spell, specMask FROM character_spell WHERE guid = '{}'", GetGUID().GetCounter());

    if (result)
    {
        do
            // xinef: checked
            addSpell((*result)[0].Get<uint32>(), (*result)[1].Get<uint8>(), true);
        while (result->NextRow());
    }
}

void Player::_LoadGroup()
{
    if (ObjectGuid groupId = sCharacterCache->GetCharacterGroupGuidByGuid(GetGUID()))
    {
        if (Group* group = sGroupMgr->GetGroupByGUID(groupId.GetCounter()))
        {
            if (group->GetMemberGroup(GetGUID()) <= MAX_RAID_SUBGROUPS)
            {
                if (group->IsLeader(GetGUID()))
                {
                    SetPlayerFlag(PLAYER_FLAGS_GROUP_LEADER);
                }

                uint8 subgroup = group->GetMemberGroup(GetGUID());
                SetGroup(group, subgroup);

                // the group leader may change the instance difficulty while the player is offline
                SetDungeonDifficulty(group->GetDungeonDifficulty());
                SetRaidDifficulty(group->GetRaidDifficulty());
            }
        }
    }

    if (!GetGroup() || !GetGroup()->IsLeader(GetGUID()))
        RemovePlayerFlag(PLAYER_FLAGS_GROUP_LEADER);
}

void Player::BindToInstance()
{
    InstanceSave* mapSave = sInstanceSaveMgr->GetInstanceSave(_pendingBindId);
    if (!mapSave) //it seems sometimes mapSave is nullptr, but I did not check why
        return;

    WorldPacket data(SMSG_INSTANCE_SAVE_CREATED, 4);
    data << uint32(0);
    GetSession()->SendPacket(&data);
    sInstanceSaveMgr->PlayerBindToInstance(this->GetGUID(), mapSave, true, this);
}

void Player::SendRaidInfo()
{
    uint32 counter = 0;

    WorldPacket data(SMSG_RAID_INSTANCE_INFO, 4);

    size_t p_counter = data.wpos();
    data << uint32(counter);                                // placeholder

    time_t now = GameTime::GetGameTime().count();

    for (uint8 i = 0; i < MAX_DIFFICULTY; ++i)
    {
        BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(GetGUID(), Difficulty(i));
        for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
        {
            if (itr->second.perm)
            {
                InstanceSave* save = itr->second.save;
                time_t resetTime = itr->second.extended ? save->GetExtendedResetTime() : save->GetResetTime();
                data << uint32(save->GetMapId());           // map id
                data << uint32(save->GetDifficulty());      // difficulty
                data << ObjectGuid::Create<HighGuid::Instance>(save->GetInstanceId()); // instance id
                data << uint8(1);                           // expired = 0
                data << uint8(itr->second.extended ? 1 : 0);// extended = 1
                data << uint32(resetTime >= now ? resetTime - now : 0); // reset time
                ++counter;
            }
        }
    }
    data.put<uint32>(p_counter, counter);
    GetSession()->SendPacket(&data);
}

/*
- called on every successful teleportation to a map
*/
void Player::SendSavedInstances()
{
    bool hasBeenSaved = false;
    WorldPacket data;

    for (uint8 i = 0; i < MAX_DIFFICULTY; ++i)
    {
        BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(GetGUID(), Difficulty(i));
        for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
        {
            if (itr->second.perm)                               // only permanent binds are sent
            {
                hasBeenSaved = true;
                break;
            }
        }
    }

    //Send opcode 811. true or false means, whether you have current raid/heroic instances
    data.Initialize(SMSG_UPDATE_INSTANCE_OWNERSHIP);
    data << uint32(hasBeenSaved);
    GetSession()->SendPacket(&data);

    if (!hasBeenSaved)
        return;

    for (uint8 i = 0; i < MAX_DIFFICULTY; ++i)
    {
        BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(GetGUID(), Difficulty(i));
        for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
        {
            if (itr->second.perm)
            {
                data.Initialize(SMSG_UPDATE_LAST_INSTANCE);
                data << uint32(itr->second.save->GetMapId());
                GetSession()->SendPacket(&data);
            }
        }
    }
}

void Player::PrettyPrintRequirementsQuestList(const std::vector<const ProgressionRequirement*>& missingQuests) const
{
    LocaleConstant loc_idx = GetSession()->GetSessionDbLocaleIndex();
    for (const ProgressionRequirement* missingReq : missingQuests)
    {
        Quest const* questTemplate = sObjectMgr->GetQuestTemplate(missingReq->id);
        if (!questTemplate)
        {
            continue;
        }

        std::string questTitle = questTemplate->GetTitle();
        if (QuestLocale const* questLocale = sObjectMgr->GetQuestLocale(questTemplate->GetQuestId()))
        {
            ObjectMgr::GetLocaleString(questLocale->Title, loc_idx, questTitle);
        }

        std::stringstream stream;
        stream << "|cffff7c0a|Hquest:";
        stream << questTemplate->GetQuestId();
        stream << ":";
        stream << questTemplate->GetQuestLevel();
        stream << "|h[";
        stream << questTitle;
        stream << "]|h|r";

        if (missingReq->note.empty())
        {
            ChatHandler(GetSession()).PSendSysMessage("    - {}", stream.str());
        }
        else
        {
            ChatHandler(GetSession()).PSendSysMessage("    - {} {} {}", stream.str(), sObjectMgr->GetAcoreString(LANG_ACCESS_REQUIREMENT_NOTE, loc_idx), missingReq->note);
        }
    }
}

void Player::PrettyPrintRequirementsAchievementsList(const std::vector<const ProgressionRequirement*>& missingAchievements) const
{
    LocaleConstant loc_idx = GetSession()->GetSessionDbLocaleIndex();
    for (const ProgressionRequirement* missingReq : missingAchievements)
    {
        AchievementEntry const* achievementEntry = sAchievementStore.LookupEntry(missingReq->id);
        if (!achievementEntry)
        {
            continue;
        }

        std::string name = achievementEntry->name[sObjectMgr->GetDBCLocaleIndex()];

        std::stringstream stream;
        stream << "|cffff7c0a|Hachievement:";
        stream << missingReq->id;
        stream << ":";
        stream << GetGUID().ToString();
        stream << ":0:0:0:0:0:0:0:0|h[";
        stream << name;
        stream << "]|h|r";

        if (missingReq->note.empty())
        {
            ChatHandler(GetSession()).PSendSysMessage("    - {}", stream.str());
        }
        else
        {
            ChatHandler(GetSession()).PSendSysMessage("    - {} {} {}", stream.str(), sObjectMgr->GetAcoreString(LANG_ACCESS_REQUIREMENT_NOTE, loc_idx), missingReq->note);
        }
    }
}

void Player::PrettyPrintRequirementsItemsList(const std::vector<const ProgressionRequirement*>& missingItems) const
{
    LocaleConstant loc_idx = GetSession()->GetSessionDbLocaleIndex();
    for (const ProgressionRequirement* missingReq : missingItems)
    {
        ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(missingReq->id);
        if (!itemTemplate)
        {
            continue;
        }

        //Get the localised name
        std::string name = itemTemplate->Name1;
        if (ItemLocale const* il = sObjectMgr->GetItemLocale(itemTemplate->ItemId))
        {
            ObjectMgr::GetLocaleString(il->Name, loc_idx, name);
        }

        std::stringstream stream;
        stream << "|c";
        stream << std::hex << ItemQualityColors[itemTemplate->Quality] << std::dec;
        stream << "|Hitem:";
        stream << itemTemplate->ItemId;
        stream << ":0:0:0:0:0:0:0:0:0|h[";
        stream << name;
        stream << "]|h|r";

        if (missingReq->note.empty())
        {
            ChatHandler(GetSession()).PSendSysMessage("    - {}", stream.str());
        }
        else
        {
            ChatHandler(GetSession()).PSendSysMessage("    - {} {} {}", stream.str(), sObjectMgr->GetAcoreString(LANG_ACCESS_REQUIREMENT_NOTE, loc_idx), missingReq->note);
        }
    }
}

bool Player::Satisfy(DungeonProgressionRequirements const* ar, uint32 target_map, bool report)
{
    if (!IsGameMaster() && ar)
    {
        uint8 LevelMin = 0;
        uint8 LevelMax = 0;

        MapEntry const* mapEntry = sMapStore.LookupEntry(target_map);
        if (!mapEntry)
            return false;

        if (!sWorld->getBoolConfig(CONFIG_INSTANCE_IGNORE_LEVEL))
        {
            if (ar->levelMin && GetLevel() < ar->levelMin)
                LevelMin = ar->levelMin;
            if (ar->levelMax && GetLevel() > ar->levelMax)
                LevelMax = ar->levelMax;
        }

        if (DisableMgr::IsDisabledFor(DISABLE_TYPE_MAP, target_map, this))
        {
            GetSession()->SendAreaTriggerMessage("%s", GetSession()->GetAcoreString(LANG_INSTANCE_CLOSED));
            return false;
        }

        Player* partyLeader = this;
        std::string leaderName = m_session->GetAcoreString(LANG_YOU);
        {
            ObjectGuid leaderGuid = GetGroup() ? GetGroup()->GetLeaderGUID() : GetGUID();
            Player* tempLeader = HashMapHolder<Player>::Find(leaderGuid);
            if (leaderGuid != GetGUID())
            {
                if (tempLeader != nullptr)
                {
                    partyLeader = tempLeader;
                }
                leaderName = GetGroup()->GetLeaderName();
            }
        }

        //Check all items
        std::vector<const ProgressionRequirement*> missingPlayerItems;
        std::vector<const ProgressionRequirement*> missingLeaderItems;
        for (const ProgressionRequirement* itemRequirement : ar->items)
        {
            Player* checkPlayer = this;
            std::vector<const ProgressionRequirement*>* missingItems = &missingPlayerItems;
            if (itemRequirement->checkLeaderOnly)
            {
                checkPlayer = partyLeader;
                missingItems = &missingLeaderItems;
            }

            if (itemRequirement->faction == TEAM_NEUTRAL || itemRequirement->faction == checkPlayer->GetTeamId(true))
            {
                if (!checkPlayer->HasItemCount(itemRequirement->id, 1))
                {
                    missingItems->push_back(itemRequirement);
                }
            }
        }

        //Check all achievements
        std::vector<const ProgressionRequirement*> missingPlayerAchievements;
        std::vector<const ProgressionRequirement*> missingLeaderAchievements;
        for (const ProgressionRequirement* achievementRequirement : ar->achievements)
        {
            Player* checkPlayer = this;
            std::vector<const ProgressionRequirement*>* missingAchievements = &missingPlayerAchievements;
            if (achievementRequirement->checkLeaderOnly)
            {
                checkPlayer = partyLeader;
                missingAchievements = &missingLeaderAchievements;
            }

            if (achievementRequirement->faction == TEAM_NEUTRAL || achievementRequirement->faction == GetTeamId(true))
            {
                if (!checkPlayer || !checkPlayer->HasAchieved(achievementRequirement->id))
                {
                    missingAchievements->push_back(achievementRequirement);
                }
            }
        }

        //Check all quests
        std::vector<const ProgressionRequirement*> missingPlayerQuests;
        std::vector<const ProgressionRequirement*> missingLeaderQuests;
        for (const ProgressionRequirement* questRequirement : ar->quests)
        {
            Player* checkPlayer = this;
            std::vector<const ProgressionRequirement*>* missingQuests = &missingPlayerQuests;
            if (questRequirement->checkLeaderOnly)
            {
                checkPlayer = partyLeader;
                missingQuests = &missingLeaderQuests;
            }

            if (questRequirement->faction == TEAM_NEUTRAL || questRequirement->faction == checkPlayer->GetTeamId(true))
            {
                if (!checkPlayer->GetQuestRewardStatus(questRequirement->id))
                {
                    missingQuests->push_back(questRequirement);
                }
            }
        }

        //Check if avg ILVL requirement is allowed
        bool ilvlRequirementNotMet = false;
        if (sWorld->getBoolConfig(CONFIG_DUNGEON_ACCESS_REQUIREMENTS_PORTAL_CHECK_ILVL))
        {
            const int32 currentIlvl = (int32)GetAverageItemLevelForDF();
            if (ar->reqItemLevel > currentIlvl)
            {
                ilvlRequirementNotMet = true;
            }
        }

        Difficulty target_difficulty = GetDifficulty(mapEntry->IsRaid());
        MapDifficulty const* mapDiff = GetDownscaledMapDifficultyData(target_map, target_difficulty);
        if (LevelMin || LevelMax || ilvlRequirementNotMet
            || missingPlayerItems.size() || missingPlayerQuests.size() || missingPlayerAchievements.size()
            || missingLeaderItems.size() || missingLeaderQuests.size() || missingLeaderAchievements.size())
        {
            if (!sScriptMgr->NotAvoidSatisfy(partyLeader, ar, target_map, report))
                return true;

            if (report)
            {
                uint8 requirementPrintMode = sWorld->getIntConfig(CONFIG_DUNGEON_ACCESS_REQUIREMENTS_PRINT_MODE);

                if (requirementPrintMode == 0)
                {
                    //Just print out the requirements are not met
                    ChatHandler(GetSession()).SendSysMessage(LANG_ACCESS_REQUIREMENT_NOT_MET);
                }
                else if (requirementPrintMode == 1)
                {
                    //Blizzlike method of printing out the requirements
                    if (missingPlayerQuests.size() && !missingPlayerQuests[0]->note.empty())
                    {
                        ChatHandler(GetSession()).PSendSysMessage("{}", missingPlayerQuests[0]->note);
                    }
                    else if (missingLeaderQuests.size() && !missingLeaderQuests[0]->note.empty())
                    {
                        ChatHandler(GetSession()).PSendSysMessage("{}", missingLeaderQuests[0]->note);
                    }
                    else if (mapDiff->hasErrorMessage)
                    {
                        // if (missingAchievement) covered by this case
                        SendTransferAborted(target_map, TRANSFER_ABORT_DIFFICULTY, target_difficulty);
                    }
                    else if (missingPlayerItems.size())
                    {
                        LocaleConstant loc_idx = GetSession()->GetSessionDbLocaleIndex();
                        std::string name = sObjectMgr->GetItemTemplate(missingPlayerItems[0]->id)->Name1;
                        if (ItemLocale const* il = sObjectMgr->GetItemLocale(missingPlayerItems[0]->id))
                        {
                            ObjectMgr::GetLocaleString(il->Name, loc_idx, name);
                        }
                        GetSession()->SendAreaTriggerMessage(GetSession()->GetAcoreString(LANG_LEVEL_MINREQUIRED_AND_ITEM), ar->levelMin, name.c_str());
                    }
                    else if (LevelMin)
                    {
                        GetSession()->SendAreaTriggerMessage(GetSession()->GetAcoreString(LANG_LEVEL_MINREQUIRED), LevelMin);
                    }
                    else if (ilvlRequirementNotMet)
                    {
                        ChatHandler(GetSession()).PSendSysMessage(LANG_ACCESS_REQUIREMENT_AVERAGE_ILVL_NOT_MET, ar->reqItemLevel, (uint16)GetAverageItemLevelForDF());
                    }
                }
                else
                {
                    bool errorAlreadyPrinted = false;
                    //Pretty way of printing out requirements
                    if (missingPlayerQuests.size())
                    {
                        ChatHandler(GetSession()).SendSysMessage(LANG_ACCESS_REQUIREMENT_COMPLETE_QUESTS);
                        PrettyPrintRequirementsQuestList(missingPlayerQuests);
                        errorAlreadyPrinted = true;
                    }
                    if (missingLeaderQuests.size())
                    {
                        ChatHandler(GetSession()).PSendSysMessage(LANG_ACCESS_REQUIREMENT_LEADER_COMPLETE_QUESTS, leaderName);
                        PrettyPrintRequirementsQuestList(missingLeaderQuests);
                        errorAlreadyPrinted = true;
                    }

                    if (missingPlayerAchievements.size())
                    {
                        ChatHandler(GetSession()).SendSysMessage(LANG_ACCESS_REQUIREMENT_COMPLETE_ACHIEVEMENTS);
                        PrettyPrintRequirementsAchievementsList(missingPlayerAchievements);
                        errorAlreadyPrinted = true;
                    }
                    if (missingLeaderAchievements.size())
                    {
                        ChatHandler(GetSession()).PSendSysMessage(LANG_ACCESS_REQUIREMENT_LEADER_COMPLETE_ACHIEVEMENTS, leaderName);
                        PrettyPrintRequirementsAchievementsList(missingLeaderAchievements);
                        errorAlreadyPrinted = true;
                    }

                    if (missingPlayerItems.size())
                    {
                        ChatHandler(GetSession()).SendSysMessage(LANG_ACCESS_REQUIREMENT_OBTAIN_ITEMS);
                        PrettyPrintRequirementsItemsList(missingPlayerItems);
                        errorAlreadyPrinted = true;
                    }

                    if (missingLeaderItems.size())
                    {
                        ChatHandler(GetSession()).PSendSysMessage(LANG_ACCESS_REQUIREMENT_LEADER_OBTAIN_ITEMS, leaderName);
                        PrettyPrintRequirementsItemsList(missingLeaderItems);
                        errorAlreadyPrinted = true;
                    }

                    if (ilvlRequirementNotMet)
                    {
                        ChatHandler(GetSession()).PSendSysMessage(LANG_ACCESS_REQUIREMENT_AVERAGE_ILVL_NOT_MET, ar->reqItemLevel, (uint16)GetAverageItemLevelForDF());
                    }

                    if (LevelMin)
                    {
                        GetSession()->SendAreaTriggerMessage(GetSession()->GetAcoreString(LANG_LEVEL_MINREQUIRED), LevelMin);
                    }
                    else if (LevelMax)
                    {
                        GetSession()->SendAreaTriggerMessage(GetSession()->GetAcoreString(LANG_ACCESS_REQUIREMENT_MAX_LEVEL), LevelMax);
                    }
                    else if (mapDiff->hasErrorMessage && !errorAlreadyPrinted)
                    {
                        SendTransferAborted(target_map, TRANSFER_ABORT_DIFFICULTY, target_difficulty);
                    }
                }

                //Print the extra string
                uint32 optionalStringID = sWorld->getIntConfig(CONFIG_DUNGEON_ACCESS_REQUIREMENTS_OPTIONAL_STRING_ID);
                if (optionalStringID > 0)
                {
                    ChatHandler(GetSession()).SendSysMessage(optionalStringID);
                }
            }
            return false;
        }
    }
    return true;
}

bool Player::CheckInstanceLoginValid()
{
    if (!GetMap())
        return false;

    if (!GetMap()->IsDungeon() || IsGameMaster())
        return true;

    if (GetMap()->IsRaid())
    {
        // cannot be in raid instance without a group
        if (!GetGroup() && !sWorld->getBoolConfig(CONFIG_INSTANCE_IGNORE_RAID))
            return false;
    }
    else
    {
        // cannot be in normal instance without a group and more players than 1 in instance
        if (!GetGroup() && GetMap()->GetPlayersCountExceptGMs() > 1)
            return false;
    }

    // pussywizard: check CanEnter for GetMap(), because in PlayerCannotEnter it is called for a map decided before loading screen (can change)
    if (GetMap()->CannotEnter(this, true))
        return false;

    // do checks for satisfy accessreqs, instance full, encounter in progress (raid), perm bind group != perm bind player
    return sMapMgr->PlayerCannotEnter(GetMap()->GetId(), this, true) == Map::CAN_ENTER;
}

bool Player::CheckInstanceCount(uint32 instanceId) const
{
    if (_instanceResetTimes.size() < sWorld->getIntConfig(CONFIG_MAX_INSTANCES_PER_HOUR))
        return true;
    return _instanceResetTimes.find(instanceId) != _instanceResetTimes.end();
}

bool Player::_LoadHomeBind(PreparedQueryResult result)
{
    PlayerInfo const* info = sObjectMgr->GetPlayerInfo(getRace(true), getClass());
    if (!info)
    {
        LOG_ERROR("entities.player", "Player (Name {}) has incorrect race/class pair. Can't be loaded.", GetName());
        return false;
    }

    bool ok = false;
    // SELECT mapId, zoneId, posX, posY, posZ FROM character_homebind WHERE guid = ?
    if (result)
    {
        Field* fields = result->Fetch();

        m_homebindMapId = fields[0].Get<uint16>();
        m_homebindAreaId = fields[1].Get<uint16>();
        m_homebindX = fields[2].Get<float>();
        m_homebindY = fields[3].Get<float>();
        m_homebindZ = fields[4].Get<float>();

        MapEntry const* bindMapEntry = sMapStore.LookupEntry(m_homebindMapId);

        // accept saved data only for valid position (and non instanceable), and accessable
        if (MapMgr::IsValidMapCoord(m_homebindMapId, m_homebindX, m_homebindY, m_homebindZ) &&
            !bindMapEntry->Instanceable() && GetSession()->Expansion() >= bindMapEntry->Expansion())
            ok = true;
        else
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PLAYER_HOMEBIND);
            stmt->SetData(0, GetGUID().GetCounter());
            CharacterDatabase.Execute(stmt);
        }
    }

    if (!ok)
    {
        m_homebindMapId = info->mapId;
        m_homebindAreaId = info->areaId;
        m_homebindX = info->positionX;
        m_homebindY = info->positionY;
        m_homebindZ = info->positionZ;

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PLAYER_HOMEBIND);
        stmt->SetData(0, GetGUID().GetCounter());
        stmt->SetData(1, m_homebindMapId);
        stmt->SetData(2, m_homebindAreaId);
        stmt->SetData (3, m_homebindX);
        stmt->SetData (4, m_homebindY);
        stmt->SetData (5, m_homebindZ);
        CharacterDatabase.Execute(stmt);
    }

    LOG_DEBUG("entities.player", "Setting player home position - mapid: {}, areaid: {}, X: {}, Y: {}, Z: {}",
              m_homebindMapId, m_homebindAreaId, m_homebindX, m_homebindY, m_homebindZ);
    return true;
}

/*********************************************************/
/***                   SAVE SYSTEM                     ***/
/*********************************************************/

void Player::SaveToDB(bool create, bool logout)
{
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    SaveToDB(trans, create, logout);

    CharacterDatabase.CommitTransaction(trans);
}

void Player::SaveToDB(CharacterDatabaseTransaction trans, bool create, bool logout)
{
    // delay auto save at any saves (manual, in code, or autosave)
    m_nextSave = sWorld->getIntConfig(CONFIG_INTERVAL_SAVE);

    //lets allow only players in world to be saved
    if (IsBeingTeleportedFar())
    {
        ScheduleDelayedOperation(DELAYED_SAVE_PLAYER);
        return;
    }

    // pussywizard: full save now, so clear partial additional saves
    m_additionalSaveTimer = 0;
    m_additionalSaveMask = 0;

    // first save/honor gain after midnight will also update the player's honor fields
    UpdateHonorFields();

    LOG_DEBUG("entities.unit", "The value of player {} at save: ", m_name);
    outDebugValues();

    if (!create)
        sScriptMgr->OnPlayerSave(this);

    _SaveCharacter(create, trans);

    if (m_mailsUpdated)                                     //save mails only when needed
        _SaveMail(trans);

    _SaveEntryPoint(trans);
    _SaveInventory(trans);
    _SaveQuestStatus(trans);
    _SaveDailyQuestStatus(trans);
    _SaveWeeklyQuestStatus(trans);
    _SaveSeasonalQuestStatus(trans);
    _SaveMonthlyQuestStatus(trans);
    _SaveTalents(trans);
    _SaveSpells(trans);
    _SaveSpellCooldowns(trans, logout);
    _SaveActions(trans);
    _SaveAuras(trans, logout);
    _SaveSkills(trans);
    m_achievementMgr->SaveToDB(trans);
    m_reputationMgr->SaveToDB(trans);
    _SaveEquipmentSets(trans);
    GetSession()->SaveTutorialsData(trans);                 // changed only while character in game
    _SaveGlyphs(trans);
    _SaveInstanceTimeRestrictions(trans);
    _SavePlayerSettings(trans);

    // check if stats should only be saved on logout
    // save stats can be out of transaction
    if (m_session->isLogingOut() || !sWorld->getBoolConfig(CONFIG_STATS_SAVE_ONLY_ON_LOGOUT))
        _SaveStats(trans);

    // save pet (hunter pet level and experience and all type pets health/mana).
    if (Pet* pet = GetPet())
        pet->SavePetToDB(PET_SAVE_AS_CURRENT);
}

// fast save function for item/money cheating preventing - save only inventory and money state
void Player::SaveInventoryAndGoldToDB(CharacterDatabaseTransaction trans)
{
    _SaveInventory(trans);
    SaveGoldToDB(trans);
}

void Player::SaveGoldToDB(CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_MONEY);
    stmt->SetData(0, GetMoney());
    stmt->SetData(1, GetGUID().GetCounter());
    trans->Append(stmt);
}

void Player::_SaveActions(CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = nullptr;

    for (ActionButtonList::iterator itr = m_actionButtons.begin(); itr != m_actionButtons.end();)
    {
        switch (itr->second.uState)
        {
            case ACTIONBUTTON_NEW:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_ACTION);
                stmt->SetData(0, GetGUID().GetCounter());
                stmt->SetData(1, m_activeSpec);
                stmt->SetData(2, itr->first);
                stmt->SetData(3, itr->second.GetAction());
                stmt->SetData(4, uint8(itr->second.GetType()));
                trans->Append(stmt);

                itr->second.uState = ACTIONBUTTON_UNCHANGED;
                ++itr;
                break;
            case ACTIONBUTTON_CHANGED:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_ACTION);
                stmt->SetData(0, itr->second.GetAction());
                stmt->SetData(1, uint8(itr->second.GetType()));
                stmt->SetData(2, GetGUID().GetCounter());
                stmt->SetData(3, itr->first);
                stmt->SetData(4, m_activeSpec);
                trans->Append(stmt);

                itr->second.uState = ACTIONBUTTON_UNCHANGED;
                ++itr;
                break;
            case ACTIONBUTTON_DELETED:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_ACTION_BY_BUTTON_SPEC);
                stmt->SetData(0, GetGUID().GetCounter());
                stmt->SetData(1, itr->first);
                stmt->SetData(2, m_activeSpec);
                trans->Append(stmt);

                m_actionButtons.erase(itr++);
                break;
            default:
                ++itr;
                break;
        }
    }
}

void Player::_SaveAuras(CharacterDatabaseTransaction trans, bool logout)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_AURA);
    stmt->SetData(0, GetGUID().GetCounter());
    trans->Append(stmt);

    for (AuraMap::const_iterator itr = m_ownedAuras.begin(); itr != m_ownedAuras.end(); ++itr)
    {
        if (!itr->second->CanBeSaved())
            continue;

        Aura* aura = itr->second;
        if( !logout && aura->GetDuration() < 60 * IN_MILLISECONDS )
            continue;

        int32 damage[MAX_SPELL_EFFECTS];
        int32 baseDamage[MAX_SPELL_EFFECTS];
        uint8 effMask = 0;
        uint8 recalculateMask = 0;
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (AuraEffect const* effect = aura->GetEffect(i))
            {
                baseDamage[i] = effect->GetBaseAmount();
                damage[i] = effect->GetAmount();
                effMask |= 1 << i;
                if (effect->CanBeRecalculated())
                    recalculateMask |= 1 << i;
            }
            else
            {
                baseDamage[i] = 0;
                damage[i] = 0;
            }
        }

        uint8 index = 0;
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_AURA);
        stmt->SetData(index++, GetGUID().GetCounter());
        stmt->SetData(index++, itr->second->GetCasterGUID().GetRawValue());
        stmt->SetData(index++, itr->second->GetCastItemGUID().GetRawValue());
        stmt->SetData(index++, itr->second->GetId());
        stmt->SetData(index++, effMask);
        stmt->SetData(index++, recalculateMask);
        stmt->SetData(index++, itr->second->GetStackAmount());
        stmt->SetData(index++, damage[0]);
        stmt->SetData(index++, damage[1]);
        stmt->SetData(index++, damage[2]);
        stmt->SetData(index++, baseDamage[0]);
        stmt->SetData(index++, baseDamage[1]);
        stmt->SetData(index++, baseDamage[2]);
        stmt->SetData(index++, itr->second->GetMaxDuration());
        stmt->SetData(index++, itr->second->GetDuration());
        stmt->SetData(index, itr->second->GetCharges());
        trans->Append(stmt);
    }
}

void Player::_SaveInventory(CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = nullptr;
    // force items in buyback slots to new state
    // and remove those that aren't already
    for (uint8 i = BUYBACK_SLOT_START; i < BUYBACK_SLOT_END; ++i)
    {
        Item* item = m_items[i];
        if (!item)
            continue;

        if (item->GetState() == ITEM_NEW)
        {
            // Xinef: item is removed, remove loot from storage if any
            if (item->GetTemplate()->Flags & ITEM_FLAG_HAS_LOOT)
                sLootItemStorage->RemoveStoredLoot(item->GetGUID());
            continue;
        }

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INVENTORY_BY_ITEM);
        stmt->SetData(0, item->GetGUID().GetCounter());
        trans->Append(stmt);

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
        stmt->SetData(0, item->GetGUID().GetCounter());
        trans->Append(stmt);
        m_items[i]->FSetState(ITEM_NEW);

        // Xinef: item is removed, remove loot from storage if any
        if (item->GetTemplate()->Flags & ITEM_FLAG_HAS_LOOT)
            sLootItemStorage->RemoveStoredLoot(item->GetGUID());
    }

    // Updated played time for refundable items. We don't do this in Player::Update because there's simply no need for it,
    // the client auto counts down in real time after having received the initial played time on the first
    // SMSG_ITEM_REFUND_INFO_RESPONSE packet.
    // Item::UpdatePlayedTime is only called when needed, which is in DB saves, and item refund info requests.
    RefundableItemsSet::iterator i_next;
    for (RefundableItemsSet::iterator itr = m_refundableItems.begin(); itr != m_refundableItems.end(); itr = i_next)
    {
        // use copy iterator because itr may be invalid after operations in this loop
        i_next = itr;
        ++i_next;

        Item* iPtr = GetItemByGuid((*itr));
        if (iPtr)
        {
            iPtr->UpdatePlayedTime(this);
            continue;
        }
        else
        {
            LOG_ERROR("entities.player", "Can't find item {} but is in refundable storage for player {} ! Removing.", (*itr).ToString(), GetGUID().ToString());
            m_refundableItems.erase(itr);
        }
    }

    // update enchantment durations
    for (EnchantDurationList::iterator itr = m_enchantDuration.begin(); itr != m_enchantDuration.end(); ++itr)
        itr->item->SetEnchantmentDuration(itr->slot, itr->leftduration, this);

    // if no changes
    if (m_itemUpdateQueue.empty())
        return;

    ObjectGuid::LowType lowGuid = GetGUID().GetCounter();
    for (size_t i = 0; i < m_itemUpdateQueue.size(); ++i)
    {
        Item* item = m_itemUpdateQueue[i];
        if (!item)
            continue;

        Bag* container = item->GetContainer();
        ObjectGuid::LowType bag_guid = container ? container->GetGUID().GetCounter() : 0;

        if (item->GetState() != ITEM_REMOVED)
        {
            Item* test = GetItemByPos(item->GetBagSlot(), item->GetSlot());
            if (!test)
            {
                ObjectGuid::LowType bagTestGUID = 0;
                if (Item* test2 = GetItemByPos(INVENTORY_SLOT_BAG_0, item->GetBagSlot()))
                    bagTestGUID = test2->GetGUID().GetCounter();
                LOG_ERROR("entities.player", "Player(GUID: {} Name: {})::_SaveInventory - the bag({}) and slot({}) values for the item {} (state {}) are incorrect, the player doesn't have an item at that position!",
                          lowGuid, GetName(), item->GetBagSlot(), item->GetSlot(), item->GetGUID().ToString(), (int32)item->GetState());
                // according to the test that was just performed nothing should be in this slot, delete
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INVENTORY_BY_BAG_SLOT);
                stmt->SetData(0, bagTestGUID);
                stmt->SetData(1, item->GetSlot());
                stmt->SetData(2, lowGuid);
                trans->Append(stmt);

                RemoveTradeableItem(item); // pussywizard
                RemoveEnchantmentDurationsReferences(item); // pussywizard
                RemoveItemDurations(item); // pussywizard

                // also THIS item should be somewhere else, cheat attempt
                item->FSetState(ITEM_REMOVED); // we are IN updateQueue right now, can't use SetState which modifies the queue
                DeleteRefundReference(item->GetGUID());
                // don't skip, let the switch delete it
                continue;
            }
            else if (test != item)
            {
                LOG_ERROR("entities.player", "Player(GUID: {} Name: {})::_SaveInventory - the bag({}) and slot({}) values for the item ({}) are incorrect, the item ({}) is there instead!",
                          lowGuid, GetName(), item->GetBagSlot(), item->GetSlot(), item->GetGUID().ToString(), test->GetGUID().ToString());
                // save all changes to the item...
                if (item->GetState() != ITEM_NEW) // only for existing items, no dupes
                    item->SaveToDB(trans);
                // ...but do not save position in invntory
                continue;
            }
        }

        switch (item->GetState())
        {
            case ITEM_NEW:
            case ITEM_CHANGED:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_INVENTORY_ITEM);
                stmt->SetData(0, lowGuid);
                stmt->SetData(1, bag_guid);
                stmt->SetData (2, item->GetSlot());
                stmt->SetData(3, item->GetGUID().GetCounter());
                trans->Append(stmt);
                break;
            case ITEM_REMOVED:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_INVENTORY_BY_ITEM);
                stmt->SetData(0, item->GetGUID().GetCounter());
                trans->Append(stmt);
            case ITEM_UNCHANGED:
                break;
        }

        item->SaveToDB(trans);                                   // item have unchanged inventory record and can be save standalone
    }
    m_itemUpdateQueue.clear();
}

void Player::_SaveMail(CharacterDatabaseTransaction trans)
{
    if (!GetMailSize() || !m_mailsUpdated)
    {
        return;
    }

    CharacterDatabasePreparedStatement* stmt = nullptr;

    for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end(); ++itr)
    {
        Mail* m = (*itr);
        if (m->state == MAIL_STATE_CHANGED)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_MAIL);
            stmt->SetData(0, uint8(m->HasItems() ? 1 : 0));
            stmt->SetData(1, uint32(m->expire_time));
            stmt->SetData(2, uint32(m->deliver_time));
            stmt->SetData(3, m->money);
            stmt->SetData(4, m->COD);
            stmt->SetData(5, uint8(m->checked));
            stmt->SetData(6, m->messageID);

            trans->Append(stmt);

            if (!m->removedItems.empty())
            {
                for (std::vector<uint32>::iterator itr2 = m->removedItems.begin(); itr2 != m->removedItems.end(); ++itr2)
                {
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM);
                    stmt->SetData(0, *itr2);
                    trans->Append(stmt);
                }
                m->removedItems.clear();
            }
            m->state = MAIL_STATE_UNCHANGED;
        }
        else if (m->state == MAIL_STATE_DELETED)
        {
            if (m->HasItems())
            {
                for (MailItemInfoVec::iterator itr2 = m->items.begin(); itr2 != m->items.end(); ++itr2)
                {
                    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_ITEM_INSTANCE);
                    stmt->SetData(0, itr2->item_guid);
                    trans->Append(stmt);
                }
            }
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_BY_ID);
            stmt->SetData(0, m->messageID);
            trans->Append(stmt);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_MAIL_ITEM_BY_ID);
            stmt->SetData(0, m->messageID);
            trans->Append(stmt);
        }
    }

    //deallocate deleted mails...
    for (PlayerMails::iterator itr = m_mail.begin(); itr != m_mail.end();)
    {
        if ((*itr)->state == MAIL_STATE_DELETED)
        {
            Mail* m = *itr;
            m_mail.erase(itr);
            delete m;
            itr = m_mail.begin();
        }
        else
            ++itr;
    }

    m_mailsUpdated = false;
}

void Player::_SaveQuestStatus(CharacterDatabaseTransaction trans)
{
    bool isTransaction = static_cast<bool>(trans);
    if (!isTransaction)
        trans = CharacterDatabase.BeginTransaction();

    QuestStatusSaveMap::iterator saveItr;
    QuestStatusMap::iterator statusItr;
    CharacterDatabasePreparedStatement* stmt = nullptr;

    bool keepAbandoned = !(sWorld->GetCleaningFlags() & CharacterDatabaseCleaner::CLEANING_FLAG_QUESTSTATUS);

    for (saveItr = m_QuestStatusSave.begin(); saveItr != m_QuestStatusSave.end(); ++saveItr)
    {
        if (saveItr->second)
        {
            statusItr = m_QuestStatus.find(saveItr->first);
            if (statusItr != m_QuestStatus.end() && (keepAbandoned || statusItr->second.Status != QUEST_STATUS_NONE))
            {
                uint8 index = 0;
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_CHAR_QUESTSTATUS);

                stmt->SetData(index++, GetGUID().GetCounter());
                stmt->SetData(index++, statusItr->first);
                stmt->SetData(index++, uint8(statusItr->second.Status));
                stmt->SetData(index++, statusItr->second.Explored);
                stmt->SetData(index++, uint32(statusItr->second.Timer / IN_MILLISECONDS + GameTime::GetGameTime().count()));

                for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; i++)
                    stmt->SetData(index++, statusItr->second.CreatureOrGOCount[i]);

                for (uint8 i = 0; i < QUEST_ITEM_OBJECTIVES_COUNT; i++)
                    stmt->SetData(index++, statusItr->second.ItemCount[i]);

                stmt->SetData(index, statusItr->second.PlayerCount);
                trans->Append(stmt);
            }
        }
        else
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS_BY_QUEST);
            stmt->SetData(0, GetGUID().GetCounter());
            stmt->SetData(1, saveItr->first);
            trans->Append(stmt);
        }
    }

    m_QuestStatusSave.clear();

    for (saveItr = m_RewardedQuestsSave.begin(); saveItr != m_RewardedQuestsSave.end(); ++saveItr)
    {
        if (saveItr->second)
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_QUESTSTATUS_REWARDED);
        else // xinef: what the is this? quest can be removed by spelleffect if (!keepAbandoned)
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_QUESTSTATUS_REWARDED_BY_QUEST);

        stmt->SetData(0, GetGUID().GetCounter());
        stmt->SetData(1, saveItr->first);
        trans->Append(stmt);
    }

    m_RewardedQuestsSave.clear();

    if (!isTransaction)
        CharacterDatabase.CommitTransaction(trans);
}

void Player::_SaveDailyQuestStatus(CharacterDatabaseTransaction trans)
{
    if (!m_DailyQuestChanged)
        return;

    m_DailyQuestChanged = false;

    // save last daily quest time for all quests: we need only mostly reset time for reset check anyway

    // we don't need transactions here.
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_DAILY_CHAR);
    stmt->SetData(0, GetGUID().GetCounter());
    trans->Append(stmt);
    for (uint32 quest_daily_idx = 0; quest_daily_idx < PLAYER_MAX_DAILY_QUESTS; ++quest_daily_idx)
    {
        if (GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx))
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_DAILYQUESTSTATUS);
            stmt->SetData(0, GetGUID().GetCounter());
            stmt->SetData(1, GetUInt32Value(PLAYER_FIELD_DAILY_QUESTS_1 + quest_daily_idx));
            stmt->SetData(2, uint64(m_lastDailyQuestTime));
            trans->Append(stmt);
        }
    }

    if (!m_DFQuests.empty())
    {
        for (DFQuestsDoneList::iterator itr = m_DFQuests.begin(); itr != m_DFQuests.end(); ++itr)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_DAILYQUESTSTATUS);
            stmt->SetData(0, GetGUID().GetCounter());
            stmt->SetData(1, (*itr));
            stmt->SetData(2, uint64(m_lastDailyQuestTime));
            trans->Append(stmt);
        }
    }
}

void Player::_SaveWeeklyQuestStatus(CharacterDatabaseTransaction trans)
{
    if (!m_WeeklyQuestChanged || m_weeklyquests.empty())
        return;

    // we don't need transactions here.
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_WEEKLY_CHAR);
    stmt->SetData(0, GetGUID().GetCounter());
    trans->Append(stmt);

    for (QuestSet::const_iterator iter = m_weeklyquests.begin(); iter != m_weeklyquests.end(); ++iter)
    {
        uint32 quest_id  = *iter;

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_WEEKLYQUESTSTATUS);
        stmt->SetData(0, GetGUID().GetCounter());
        stmt->SetData(1, quest_id);
        trans->Append(stmt);
    }

    m_WeeklyQuestChanged = false;
}

void Player::_SaveSeasonalQuestStatus(CharacterDatabaseTransaction trans)
{
    if (!m_SeasonalQuestChanged)
    {
        return;
    }

    // we don't need transactions here.
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_SEASONAL_CHAR);
    stmt->SetData(0, GetGUID().GetCounter());
    trans->Append(stmt);

    m_SeasonalQuestChanged = false;

    if (m_seasonalquests.empty())
    {
        return;
    }

    for (SeasonalEventQuestMap::const_iterator iter = m_seasonalquests.begin(); iter != m_seasonalquests.end(); ++iter)
    {
        uint16 eventId = iter->first;

        for (SeasonalQuestSet::const_iterator itr = iter->second.begin(); itr != iter->second.end(); ++itr)
        {
            uint32 questId = *itr;

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_SEASONALQUESTSTATUS);
            stmt->SetArguments(GetGUID().GetCounter(), questId, eventId);
            trans->Append(stmt);
        }
    }
}

void Player::_SaveMonthlyQuestStatus(CharacterDatabaseTransaction trans)
{
    if (!m_MonthlyQuestChanged || m_monthlyquests.empty())
        return;

    // we don't need transactions here.
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_QUEST_STATUS_MONTHLY_CHAR);
    stmt->SetData(0, GetGUID().GetCounter());
    trans->Append(stmt);

    for (QuestSet::const_iterator iter = m_monthlyquests.begin(); iter != m_monthlyquests.end(); ++iter)
    {
        uint32 quest_id = *iter;
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_MONTHLYQUESTSTATUS);
        stmt->SetData(0, GetGUID().GetCounter());
        stmt->SetData(1, quest_id);
        trans->Append(stmt);
    }

    m_MonthlyQuestChanged = false;
}

void Player::_SaveSkills(CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = nullptr;
    // we don't need transactions here.
    for (SkillStatusMap::iterator itr = mSkillStatus.begin(); itr != mSkillStatus.end();)
    {
        if (itr->second.uState == SKILL_UNCHANGED)
        {
            ++itr;
            continue;
        }

        if (itr->second.uState == SKILL_DELETED)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SKILL_BY_SKILL);
            stmt->SetData(0, GetGUID().GetCounter());
            stmt->SetData(1, itr->first);
            trans->Append(stmt);

            mSkillStatus.erase(itr++);
            continue;
        }

        uint32 valueData = GetUInt32Value(PLAYER_SKILL_VALUE_INDEX(itr->second.pos));
        uint16 value = SKILL_VALUE(valueData);
        uint16 max = SKILL_MAX(valueData);

        switch (itr->second.uState)
        {
            case SKILL_NEW:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_SKILLS);
                stmt->SetData(0, GetGUID().GetCounter());
                stmt->SetData(1, uint16(itr->first));
                stmt->SetData(2, value);
                stmt->SetData(3, max);
                trans->Append(stmt);

                break;
            case SKILL_CHANGED:
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_SKILLS);
                stmt->SetData(0, value);
                stmt->SetData(1, max);
                stmt->SetData(2, GetGUID().GetCounter());
                stmt->SetData(3, uint16(itr->first));
                trans->Append(stmt);

                break;
            default:
                break;
        }
        itr->second.uState = SKILL_UNCHANGED;

        ++itr;
    }
}

void Player::_SaveSpells(CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = nullptr;

    for (PlayerSpellMap::iterator itr = m_spells.begin(); itr != m_spells.end();)
    {
        // xinef: skip temporary spells
        if (itr->second->State == PLAYERSPELL_TEMPORARY)
        {
            ++itr;
            continue;
        }

        // xinef: Delete statement for removed / updated spell
        if (itr->second->State == PLAYERSPELL_REMOVED || itr->second->State == PLAYERSPELL_CHANGED)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_SPELL_BY_SPELL);
            stmt->SetData(0, GetGUID().GetCounter());
            stmt->SetData(1, itr->first);
            trans->Append(stmt);
        }

        // xinef: insert statement for new / updated spell
        if (itr->second->State == PLAYERSPELL_NEW || itr->second->State == PLAYERSPELL_CHANGED)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_SPELL);
            stmt->SetData(0, GetGUID().GetCounter());
            stmt->SetData(1, itr->first);
            stmt->SetData(2, itr->second->specMask);
            trans->Append(stmt);
        }

        if (itr->second->State == PLAYERSPELL_REMOVED)
        {
            delete itr->second;
            m_spells.erase(itr++);
        }
        else
        {
            itr->second->State = PLAYERSPELL_UNCHANGED;
            ++itr;
        }
    }
}

// save player stats -- only for external usage
// real stats will be recalculated on player login
void Player::_SaveStats(CharacterDatabaseTransaction trans)
{
    // check if stat saving is enabled and if char level is high enough
    if (!sWorld->getIntConfig(CONFIG_MIN_LEVEL_STAT_SAVE) || GetLevel() < sWorld->getIntConfig(CONFIG_MIN_LEVEL_STAT_SAVE))
        return;

    CharacterDatabasePreparedStatement* stmt = nullptr;

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_STATS);
    stmt->SetData(0, GetGUID().GetCounter());
    trans->Append(stmt);

    uint8 index = 0;

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_STATS);
    stmt->SetData(index++, GetGUID().GetCounter());
    stmt->SetData(index++, GetMaxHealth());

    for (uint8 i = 0; i < MAX_POWERS; ++i)
        stmt->SetData(index++, GetMaxPower(Powers(i)));

    for (uint8 i = 0; i < MAX_STATS; ++i)
        stmt->SetData(index++, GetStat(Stats(i)));

    for (int i = 0; i < MAX_SPELL_SCHOOL; ++i)
        stmt->SetData(index++, GetResistance(SpellSchools(i)));

    stmt->SetData(index++, GetFloatValue(PLAYER_BLOCK_PERCENTAGE));
    stmt->SetData(index++, GetFloatValue(PLAYER_DODGE_PERCENTAGE));
    stmt->SetData(index++, GetFloatValue(PLAYER_PARRY_PERCENTAGE));
    stmt->SetData(index++, GetFloatValue(PLAYER_CRIT_PERCENTAGE));
    stmt->SetData(index++, GetFloatValue(PLAYER_RANGED_CRIT_PERCENTAGE));
    stmt->SetData(index++, GetFloatValue(PLAYER_SPELL_CRIT_PERCENTAGE1));
    stmt->SetData(index++, GetUInt32Value(UNIT_FIELD_ATTACK_POWER));
    stmt->SetData(index++, GetUInt32Value(UNIT_FIELD_RANGED_ATTACK_POWER));
    stmt->SetData(index++, GetBaseSpellPowerBonus());
    stmt->SetData(index++, GetUInt32Value(PLAYER_FIELD_COMBAT_RATING_1 + static_cast<uint16>(CR_CRIT_TAKEN_SPELL)));

    trans->Append(stmt);
}

void Player::outDebugValues() const
{
    if (!sLog->ShouldLog("entities.player", LogLevel::LOG_LEVEL_DEBUG))                                  // optimize disabled debug output
        return;

    LOG_DEBUG("entities.player", "HP is: \t\t\t{}\t\tMP is: \t\t\t{}", GetMaxHealth(), GetMaxPower(POWER_MANA));
    LOG_DEBUG("entities.player", "AGILITY is: \t\t{}\t\tSTRENGTH is: \t\t{}", GetStat(STAT_AGILITY), GetStat(STAT_STRENGTH));
    LOG_DEBUG("entities.player", "INTELLECT is: \t\t{}\t\tSPIRIT is: \t\t{}", GetStat(STAT_INTELLECT), GetStat(STAT_SPIRIT));
    LOG_DEBUG("entities.player", "STAMINA is: \t\t{}", GetStat(STAT_STAMINA));
    LOG_DEBUG("entities.player", "Armor is: \t\t{}\t\tBlock is: \t\t{}", GetArmor(), GetFloatValue(PLAYER_BLOCK_PERCENTAGE));
    LOG_DEBUG("entities.player", "HolyRes is: \t\t{}\t\tFireRes is: \t\t{}", GetResistance(SPELL_SCHOOL_HOLY), GetResistance(SPELL_SCHOOL_FIRE));
    LOG_DEBUG("entities.player", "NatureRes is: \t\t{}\t\tFrostRes is: \t\t{}", GetResistance(SPELL_SCHOOL_NATURE), GetResistance(SPELL_SCHOOL_FROST));
    LOG_DEBUG("entities.player", "ShadowRes is: \t\t{}\t\tArcaneRes is: \t\t{}", GetResistance(SPELL_SCHOOL_SHADOW), GetResistance(SPELL_SCHOOL_ARCANE));
    LOG_DEBUG("entities.player", "MIN_DAMAGE is: \t\t{}\tMAX_DAMAGE is: \t\t{}", GetFloatValue(UNIT_FIELD_MINDAMAGE), GetFloatValue(UNIT_FIELD_MAXDAMAGE));
    LOG_DEBUG("entities.player", "MIN_OFFHAND_DAMAGE is: \t{}\tMAX_OFFHAND_DAMAGE is: \t{}", GetFloatValue(UNIT_FIELD_MINOFFHANDDAMAGE), GetFloatValue(UNIT_FIELD_MAXOFFHANDDAMAGE));
    LOG_DEBUG("entities.player", "MIN_RANGED_DAMAGE is: \t{}\tMAX_RANGED_DAMAGE is: \t{}", GetFloatValue(UNIT_FIELD_MINRANGEDDAMAGE), GetFloatValue(UNIT_FIELD_MAXRANGEDDAMAGE));
    LOG_DEBUG("entities.player", "ATTACK_TIME is: \t{}\t\tRANGE_ATTACK_TIME is: \t{}", GetAttackTime(BASE_ATTACK), GetAttackTime(RANGED_ATTACK));
}
