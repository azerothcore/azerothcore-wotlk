/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef BLACK_ROSE_GEM_SYSTEM_H
#define BLACK_ROSE_GEM_SYSTEM_H

#include "Common.h"
#include "Item.h"
#include "Player.h"

namespace BlackRose
{
    constexpr uint32 ItemTheBlackRose = 900105;
    constexpr uint32 ItemBlackMiasma = 900200;
    constexpr uint32 ItemBlackPetals = 900201;
    constexpr uint32 ItemBlackThorns = 900202;
    constexpr uint32 NpcRosy = 900140;
    constexpr uint32 QuestTheBlackRoseAlliance = 900100;
    constexpr uint32 QuestTheBlackRoseHorde = 900101;
    constexpr uint32 SpellBlackRoseAura = 900900;

    constexpr uint32 RedGemBase = 900300;
    constexpr uint32 YellowGemBase = 900400;
    constexpr uint32 RedUpgradeBase = 900500;
    constexpr uint32 YellowUpgradeBase = 900600;

    constexpr uint8 RedGemFamilies = 9;
    constexpr uint8 YellowGemFamilies = 2;
    constexpr uint8 GemRanks = 7;

    enum class MultiplierMode
    {
        FromAura,
        ForceBase,
        ForceBoosted
    };

    inline thread_local MultiplierMode GemMultiplierMode =
        MultiplierMode::FromAura;

    class ScopedGemMultiplierMode
    {
    public:
        explicit ScopedGemMultiplierMode(MultiplierMode mode)
            : _previous(GemMultiplierMode)
        {
            GemMultiplierMode = mode;
        }

        ~ScopedGemMultiplierMode()
        {
            GemMultiplierMode = _previous;
        }

    private:
        MultiplierMode _previous;
    };

    struct GemUpgrade
    {
        uint32 Token;
        uint32 LowerGem;
        uint32 NextGem;
        uint32 LowerEnchant;
    };

    inline bool IsRankedEntry(uint32 entry, uint32 base, uint8 families)
    {
        if (entry < base || entry >= base + families * 10)
            return false;

        return ((entry - base) % 10) < GemRanks;
    }

    inline bool IsUpgradeToken(uint32 entry, uint32 base, uint8 families)
    {
        if (entry < base || entry >= base + families * 10)
            return false;

        return ((entry - base) % 10) < (GemRanks - 1);
    }

    inline bool IsBlackRoseGemItem(uint32 entry)
    {
        return IsRankedEntry(entry, RedGemBase, RedGemFamilies) ||
            IsRankedEntry(entry, YellowGemBase, YellowGemFamilies);
    }

    inline bool IsBlackRoseGemEnchantment(uint32 enchantId)
    {
        return IsBlackRoseGemItem(enchantId);
    }

    inline bool IsBlackRoseUpgradeToken(uint32 entry)
    {
        return IsUpgradeToken(entry, RedUpgradeBase, RedGemFamilies) ||
            IsUpgradeToken(entry, YellowUpgradeBase, YellowGemFamilies);
    }

    inline bool GetGemUpgrade(uint32 token, GemUpgrade& upgrade)
    {
        uint32 gemBase = 0;
        uint32 tokenBase = 0;
        uint8 families = 0;

        if (IsUpgradeToken(token, RedUpgradeBase, RedGemFamilies))
        {
            gemBase = RedGemBase;
            tokenBase = RedUpgradeBase;
            families = RedGemFamilies;
        }
        else if (IsUpgradeToken(token, YellowUpgradeBase, YellowGemFamilies))
        {
            gemBase = YellowGemBase;
            tokenBase = YellowUpgradeBase;
            families = YellowGemFamilies;
        }
        else
            return false;

        uint32 offset = token - tokenBase;
        uint32 family = offset / 10;
        uint32 targetRank = (offset % 10) + 2;

        if (family >= families || targetRank < 2 || targetRank > GemRanks)
            return false;

        upgrade.Token = token;
        upgrade.LowerGem = gemBase + family * 10 + targetRank - 2;
        upgrade.NextGem = gemBase + family * 10 + targetRank - 1;
        upgrade.LowerEnchant = upgrade.LowerGem;
        return true;
    }

    inline Item* GetEquippedBlackRose(Player* player)
    {
        if (!player)
            return nullptr;

        for (uint8 slot = EQUIPMENT_SLOT_TRINKET1;
             slot <= EQUIPMENT_SLOT_TRINKET2; ++slot)
        {
            Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
            if (item && item->GetEntry() == ItemTheBlackRose)
                return item;
        }

        return nullptr;
    }

    inline bool HasSocketedEnchant(Item const* item, uint32 enchantId)
    {
        if (!item)
            return false;

        for (uint32 slot = SOCK_ENCHANTMENT_SLOT;
             slot < SOCK_ENCHANTMENT_SLOT + MAX_GEM_SOCKETS; ++slot)
        {
            if (item->GetEnchantmentId(EnchantmentSlot(slot)) == enchantId)
                return true;
        }

        return false;
    }

    inline bool HasSocketedEnchant(Player* player, uint32 enchantId)
    {
        return HasSocketedEnchant(GetEquippedBlackRose(player), enchantId);
    }

    inline bool ShouldShowRosyVendorItem(Player* player, uint32 itemId)
    {
        GemUpgrade upgrade;
        if (!GetGemUpgrade(itemId, upgrade))
            return true;

        return HasSocketedEnchant(player, upgrade.LowerEnchant);
    }

    inline void ReapplySocketEnchants(Player* player, bool oldBoosted,
                                      bool newBoosted)
    {
        Item* item = GetEquippedBlackRose(player);
        if (!item)
            return;

        for (uint32 slot = SOCK_ENCHANTMENT_SLOT;
             slot < SOCK_ENCHANTMENT_SLOT + MAX_GEM_SOCKETS; ++slot)
        {
            EnchantmentSlot enchantSlot = EnchantmentSlot(slot);
            if (!IsBlackRoseGemEnchantment(item->GetEnchantmentId(enchantSlot)))
                continue;

            {
                ScopedGemMultiplierMode mode(oldBoosted
                    ? MultiplierMode::ForceBoosted
                    : MultiplierMode::ForceBase);
                player->ApplyEnchantment(item, enchantSlot, false);
            }

            {
                ScopedGemMultiplierMode mode(newBoosted
                    ? MultiplierMode::ForceBoosted
                    : MultiplierMode::ForceBase);
                player->ApplyEnchantment(item, enchantSlot, true);
            }
        }
    }

    inline bool ShouldBoostGemStats(Player* player)
    {
        switch (GemMultiplierMode)
        {
            case MultiplierMode::ForceBase:
                return false;
            case MultiplierMode::ForceBoosted:
                return true;
            case MultiplierMode::FromAura:
                return player && player->HasAura(SpellBlackRoseAura);
        }

        return false;
    }
}

#endif
