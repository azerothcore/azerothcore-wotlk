/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _ITEM_RECOVERY_H
#define _ITEM_RECOVERY_H

#include "DatabaseEnvFwd.h"
#include "ObjectGuid.h"
#include <optional>
#include <string>
#include <utility>
#include <vector>

class Item;
class Player;

enum RecoveryItemSource : uint8
{
    RECOVERY_ITEM_SOURCE_DESTROYED    = 0,
    RECOVERY_ITEM_SOURCE_VENDORED     = 1,
    RECOVERY_ITEM_SOURCE_DISENCHANTED = 2
};

using RecoveryItemLoot = std::vector<std::pair<uint32 /*itemEntry*/, uint32 /*count*/>>;

struct RecoveryItem
{
    uint32 Id = 0;
    ObjectGuid::LowType OwnerGuid = 0;
    uint32 ItemEntry = 0;
    ObjectGuid::LowType ItemGuid = 0;   // the item that was lost, matched against the buyback tab
    uint32 Count = 0;
    RecoveryItemSource Source = RECOVERY_ITEM_SOURCE_DESTROYED;
    uint32 Money = 0;                   // copper the vendor paid, durability deduction included
    int32 RandomPropertyId = 0;
    std::string Enchantments;           // same format as item_instance.enchantments
    ObjectGuid::LowType CreatorGuid = 0;
    bool Bound = false;
    RecoveryItemLoot Loot;              // what the player looted from disenchanting it
};

namespace ItemRecovery
{
    // Returns false when the item is filtered out by the ItemDelete.* settings.
    bool Save(Item const* item, uint32 count, RecoveryItemSource source, uint32 money = 0, RecoveryItemLoot const& loot = { });
    [[nodiscard]] std::optional<RecoveryItem> Load(uint32 recoveryId);

    // Mails the item as it was recorded and deletes the recovery row. owner may be null when offline.
    bool Restore(RecoveryItem const& recovery, Player* owner);
    void DeleteFromDB(CharacterDatabaseTransaction trans, uint32 recoveryId);

    // A vendored item still in the buyback tab must not be restored, or the player could buy it back as well.
    [[nodiscard]] bool IsInBuyback(Player* player, RecoveryItem const& recovery);
}

#endif
