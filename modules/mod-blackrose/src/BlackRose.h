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

#ifndef MOD_BLACKROSE_BLACK_ROSE_H
#define MOD_BLACKROSE_BLACK_ROSE_H

#include "Common.h"
#include "Item.h"
#include "Player.h"

namespace BlackRose
{
    constexpr uint32 QuestTheBlackRoseAlliance = 900100;
    constexpr uint32 QuestTheBlackRoseHorde = 900101;

    constexpr uint32 ItemBag26 = 900102;
    constexpr uint32 ItemTheBlackRose = 900105;
    constexpr uint32 ItemBag28 = 900120;
    constexpr uint32 ItemBag30 = 900121;
    constexpr uint32 ItemBag32 = 900122;
    constexpr uint32 ItemBag34 = 900123;
    constexpr uint32 ItemBag36 = 900124;

    constexpr uint32 ItemBagUpgrade28 = 900130;
    constexpr uint32 ItemBagUpgrade30 = 900131;
    constexpr uint32 ItemBagUpgrade32 = 900132;
    constexpr uint32 ItemBagUpgrade34 = 900133;
    constexpr uint32 ItemBagUpgrade36 = 900134;

    constexpr uint32 NpcRosy = 900140;

    constexpr uint32 ItemBlackMiasma = 900200;
    constexpr uint32 ItemBlackPetals = 900201;
    constexpr uint32 ItemBlackThorns = 900202;

    constexpr uint32 ItemRosyRibbonStick = 901300;
    constexpr uint32 ItemRosyMistStick = 901301;
    constexpr uint32 ItemRosyJewelStick = 901302;

    constexpr uint32 RedGemBase = 900300;
    constexpr uint32 YellowGemBase = 900400;
    constexpr uint32 RedUpgradeBase = 900500;
    constexpr uint32 YellowUpgradeBase = 900600;
    constexpr uint32 JewelGemBase = 901000;
    constexpr uint32 JewelUpgradeBase = 901100;

    constexpr uint32 QuestUnlockTier5 = 901200;
    constexpr uint32 QuestUnlockTier6 = 901201;
    constexpr uint32 QuestUnlockTier7 = 901202;

    constexpr uint32 SpellBlackRoseAura = 900900;

    constexpr uint8 RedGemFamilies = 9;
    constexpr uint8 YellowGemFamilies = 5;
    constexpr uint8 JewelGemFamilies = 10;
    constexpr uint8 GemRanks = 7;

    enum class MultiplierMode
    {
        FromAura,
        ForceBase,
        ForceBoosted
    };

    enum class GemSocketFamily
    {
        None,
        Ribbon,
        Mist,
        Jewel
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

    struct BagUpgradeTier
    {
        uint32 Token;
        uint32 CurrentBag;
        uint32 UpgradedBag;
        uint8 Slots;
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
            IsRankedEntry(entry, YellowGemBase, YellowGemFamilies) ||
            IsRankedEntry(entry, JewelGemBase, JewelGemFamilies);
    }

    inline bool IsBlackRoseGemEnchantment(uint32 enchantId)
    {
        return IsBlackRoseGemItem(enchantId);
    }

    inline GemSocketFamily GetBlackRoseGemFamily(uint32 entry)
    {
        if (IsRankedEntry(entry, RedGemBase, RedGemFamilies))
            return GemSocketFamily::Ribbon;

        if (IsRankedEntry(entry, YellowGemBase, YellowGemFamilies))
            return GemSocketFamily::Mist;

        if (IsRankedEntry(entry, JewelGemBase, JewelGemFamilies))
            return GemSocketFamily::Jewel;

        return GemSocketFamily::None;
    }

    inline GemSocketFamily GetMagicStickFamily(uint32 entry)
    {
        switch (entry)
        {
            case ItemRosyRibbonStick:
                return GemSocketFamily::Ribbon;
            case ItemRosyMistStick:
                return GemSocketFamily::Mist;
            case ItemRosyJewelStick:
                return GemSocketFamily::Jewel;
            default:
                return GemSocketFamily::None;
        }
    }

    inline char const* GetGemFamilyName(GemSocketFamily family)
    {
        switch (family)
        {
            case GemSocketFamily::Ribbon:
                return "Ribbon";
            case GemSocketFamily::Mist:
                return "Mist";
            case GemSocketFamily::Jewel:
                return "Jewel";
            case GemSocketFamily::None:
                break;
        }

        return "Black Rose gem";
    }

    inline bool IsBlackRoseUpgradeToken(uint32 entry)
    {
        return IsUpgradeToken(entry, RedUpgradeBase, RedGemFamilies) ||
            IsUpgradeToken(entry, YellowUpgradeBase, YellowGemFamilies) ||
            IsUpgradeToken(entry, JewelUpgradeBase, JewelGemFamilies);
    }

    inline BagUpgradeTier const* GetBagUpgradeTier(uint32 token)
    {
        static BagUpgradeTier const upgrades[] =
        {
            { ItemBagUpgrade28, ItemBag26, ItemBag28, 28 },
            { ItemBagUpgrade30, ItemBag28, ItemBag30, 30 },
            { ItemBagUpgrade32, ItemBag30, ItemBag32, 32 },
            { ItemBagUpgrade34, ItemBag32, ItemBag34, 34 },
            { ItemBagUpgrade36, ItemBag34, ItemBag36, 36 }
        };

        for (BagUpgradeTier const& upgrade : upgrades)
            if (upgrade.Token == token)
                return &upgrade;

        return nullptr;
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
        else if (IsUpgradeToken(token, JewelUpgradeBase, JewelGemFamilies))
        {
            gemBase = JewelGemBase;
            tokenBase = JewelUpgradeBase;
            families = JewelGemFamilies;
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

    inline uint32 GetGemUpgradeCurrency(uint32 token)
    {
        if (IsUpgradeToken(token, RedUpgradeBase, RedGemFamilies))
            return ItemBlackMiasma;

        if (IsUpgradeToken(token, YellowUpgradeBase, YellowGemFamilies))
            return ItemBlackPetals;

        if (IsUpgradeToken(token, JewelUpgradeBase, JewelGemFamilies))
            return ItemBlackThorns;

        return 0;
    }

    inline uint32 GetGemUpgradeTargetRank(uint32 token)
    {
        uint32 offset = 0;
        if (IsUpgradeToken(token, RedUpgradeBase, RedGemFamilies))
            offset = token - RedUpgradeBase;
        else if (IsUpgradeToken(token, YellowUpgradeBase, YellowGemFamilies))
            offset = token - YellowUpgradeBase;
        else if (IsUpgradeToken(token, JewelUpgradeBase, JewelGemFamilies))
            offset = token - JewelUpgradeBase;
        else
            return 0;

        return (offset % 10) + 2;
    }

    inline uint32 GetGemUpgradeCost(uint32 token)
    {
        uint32 targetRank = GetGemUpgradeTargetRank(token);
        if (targetRank < 2 || targetRank > GemRanks)
            return 0;

        static uint32 constexpr costs[] = { 3, 8, 15, 30, 60, 100 };
        uint32 rankOffset = targetRank - 2;
        return rankOffset < (sizeof(costs) / sizeof(uint32))
            ? costs[rankOffset] : 0;
    }

    inline uint32 GetGemUpgradeRequiredQuest(uint32 token)
    {
        switch (GetGemUpgradeTargetRank(token))
        {
            case 5:
                return QuestUnlockTier5;
            case 6:
                return QuestUnlockTier6;
            case 7:
                return QuestUnlockTier7;
            default:
                return 0;
        }
    }

    inline bool IsGemUpgradeUnlocked(Player const* player, uint32 token)
    {
        uint32 questId = GetGemUpgradeRequiredQuest(token);
        return !questId || (player && player->GetQuestRewardStatus(questId));
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
