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

#include "BlackRose.h"

#include "Chat.h"
#include "Creature.h"
#include "CreatureScript.h"
#include "Formulas.h"
#include "GlobalScript.h"
#include "Group.h"
#include "ItemScript.h"
#include "LootMgr.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "PlayerScript.h"
#include "QuestDef.h"
#include "ScriptedGossip.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "WorldSession.h"

#include <string>

namespace
{
    constexpr uint32 GOSSIP_ACTION_SHOW_GEM_UPGRADES = GOSSIP_ACTION_INFO_DEF + 1;
    constexpr uint32 GOSSIP_ACTION_GEM_UPGRADE_BASE = GOSSIP_ACTION_INFO_DEF + 100;

    uint32 GetGossipActionForGemUpgrade(uint32 token)
    {
        if (BlackRose::IsUpgradeToken(token, BlackRose::RedUpgradeBase,
                BlackRose::RedGemFamilies))
            return GOSSIP_ACTION_GEM_UPGRADE_BASE +
                token - BlackRose::RedUpgradeBase;

        if (BlackRose::IsUpgradeToken(token, BlackRose::YellowUpgradeBase,
                BlackRose::YellowGemFamilies))
            return GOSSIP_ACTION_GEM_UPGRADE_BASE +
                BlackRose::RedGemFamilies * 10 +
                token - BlackRose::YellowUpgradeBase;

        if (BlackRose::IsUpgradeToken(token, BlackRose::JewelUpgradeBase,
                BlackRose::JewelGemFamilies))
            return GOSSIP_ACTION_GEM_UPGRADE_BASE +
                BlackRose::RedGemFamilies * 10 +
                BlackRose::YellowGemFamilies * 10 +
                token - BlackRose::JewelUpgradeBase;

        return 0;
    }

    uint32 GetGemUpgradeForGossipAction(uint32 action)
    {
        if (action < GOSSIP_ACTION_GEM_UPGRADE_BASE)
            return 0;

        uint32 offset = action - GOSSIP_ACTION_GEM_UPGRADE_BASE;
        if (offset < BlackRose::RedGemFamilies * 10)
            return BlackRose::RedUpgradeBase + offset;

        offset -= BlackRose::RedGemFamilies * 10;
        if (offset < BlackRose::YellowGemFamilies * 10)
            return BlackRose::YellowUpgradeBase + offset;

        offset -= BlackRose::YellowGemFamilies * 10;
        if (offset < BlackRose::JewelGemFamilies * 10)
            return BlackRose::JewelUpgradeBase + offset;

        return 0;
    }

    std::string GetItemName(uint32 itemId)
    {
        if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemId))
            return itemTemplate->Name1;

        return "Unknown Item";
    }

    std::string GetUpgradeGossipText(uint32 token)
    {
        uint32 currency = BlackRose::GetGemUpgradeCurrency(token);
        uint32 cost = BlackRose::GetGemUpgradeCost(token);

        return "Buy " + GetItemName(token) + " (" + std::to_string(cost) +
            " " + GetItemName(currency) + ")";
    }

    std::string GetUnlockQuestName(uint32 questId)
    {
        if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
            return quest->GetTitle();

        return "the required Black Rose unlock quest";
    }

    bool CheckUpgradeUnlocked(Player* player, uint32 token, bool notify)
    {
        uint32 questId = BlackRose::GetGemUpgradeRequiredQuest(token);
        if (!questId || BlackRose::IsGemUpgradeUnlocked(player, token))
            return true;

        if (notify)
            ChatHandler(player->GetSession()).SendNotification(
                "Complete {} before buying that upgrade.",
                GetUnlockQuestName(questId));

        return false;
    }

    template <typename Callback>
    void ForEachGemUpgradeToken(Callback&& callback)
    {
        for (uint8 family = 0; family < BlackRose::RedGemFamilies; ++family)
            for (uint8 rank = 2; rank <= BlackRose::GemRanks; ++rank)
                callback(BlackRose::RedUpgradeBase + family * 10 + rank - 2);

        for (uint8 family = 0; family < BlackRose::YellowGemFamilies; ++family)
            for (uint8 rank = 2; rank <= BlackRose::GemRanks; ++rank)
                callback(BlackRose::YellowUpgradeBase + family * 10 + rank - 2);

        for (uint8 family = 0; family < BlackRose::JewelGemFamilies; ++family)
            for (uint8 rank = 2; rank <= BlackRose::GemRanks; ++rank)
                callback(BlackRose::JewelUpgradeBase + family * 10 + rank - 2);
    }

    bool AddEligibleUpgradeOptions(Player* player)
    {
        bool added = false;

        ForEachGemUpgradeToken([&](uint32 token)
        {
            BlackRose::GemUpgrade upgrade;
            if (!BlackRose::GetGemUpgrade(token, upgrade) ||
                !BlackRose::HasSocketedEnchant(player, upgrade.LowerEnchant) ||
                !CheckUpgradeUnlocked(player, token, false))
                return;

            AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG,
                GetUpgradeGossipText(token), GOSSIP_SENDER_MAIN,
                GetGossipActionForGemUpgrade(token));
            added = true;
        });

        return added;
    }

    bool IsBlackRoseCurrency(uint32 itemId)
    {
        return itemId == BlackRose::ItemBlackMiasma ||
            itemId == BlackRose::ItemBlackPetals ||
            itemId == BlackRose::ItemBlackThorns;
    }

    bool IsBlackRoseCurrencyGroup(LootStoreItemList const& items)
    {
        bool hasCurrency = false;
        for (LootStoreItem const* item : items)
        {
            if (!item)
                continue;

            if (!IsBlackRoseCurrency(item->itemid) || item->reference)
                return false;

            hasCurrency = true;
        }

        return hasCurrency;
    }

    bool PlayerCountsForTrivialCheck(Player const* player, Creature const* boss)
    {
        return player && player->IsAlive() &&
            player->IsAtGroupRewardDistance(boss);
    }

    bool IsNonTrivialForPlayer(Player const* player, Creature const* boss)
    {
        if (!PlayerCountsForTrivialCheck(player, boss))
            return true;

        return boss->GetLevel() > Acore::XP::GetGrayLevel(player->GetLevel());
    }

    bool IsNonTrivialForLootOwnerGroup(Player const* owner, Creature const* boss)
    {
        if (!owner || !boss)
            return true;

        if (Group const* group = owner->GetGroup())
        {
            bool checkedAnyMember = false;
            for (GroupReference const* itr = group->GetFirstMember();
                 itr != nullptr; itr = itr->next())
            {
                Player const* member = itr->GetSource();
                if (!PlayerCountsForTrivialCheck(member, boss))
                    continue;

                checkedAnyMember = true;
                if (!IsNonTrivialForPlayer(member, boss))
                    return false;
            }

            return checkedAnyMember;
        }

        return IsNonTrivialForPlayer(owner, boss);
    }

    bool GrantItem(Player* player, uint32 itemId, uint32 count = 1)
    {
        ItemPosCountVec dest;
        InventoryResult result = player->CanStoreNewItem(
            NULL_BAG, NULL_SLOT, dest, itemId, count);
        if (result != EQUIP_ERR_OK)
        {
            player->SendEquipError(result, nullptr, nullptr);
            return false;
        }

        player->StoreNewItem(dest, itemId, true);
        return true;
    }

    bool BuyGemUpgradeToken(Player* player, uint32 token)
    {
        BlackRose::GemUpgrade upgrade;
        if (!BlackRose::GetGemUpgrade(token, upgrade))
            return false;

        if (!BlackRose::HasSocketedEnchant(player, upgrade.LowerEnchant))
        {
            ChatHandler(player->GetSession()).SendNotification(
                "Socket the previous rank into The Black Rose first.");
            return false;
        }

        if (!CheckUpgradeUnlocked(player, token, true))
            return false;

        uint32 currency = BlackRose::GetGemUpgradeCurrency(token);
        uint32 cost = BlackRose::GetGemUpgradeCost(token);
        if (!currency || !cost || !player->HasItemCount(currency, cost, true))
        {
            ChatHandler(player->GetSession()).SendNotification(
                "Rosy requires {} {} for that upgrade.", cost,
                GetItemName(currency));
            return false;
        }

        ItemPosCountVec dest;
        InventoryResult result = player->CanStoreNewItem(
            NULL_BAG, NULL_SLOT, dest, token, 1);
        if (result != EQUIP_ERR_OK)
        {
            player->SendEquipError(result, nullptr, nullptr);
            return false;
        }

        player->DestroyItemCount(currency, cost, true);
        player->StoreNewItem(dest, token, true);
        ChatHandler(player->GetSession()).SendNotification(
            "Rosy gives you {}.", GetItemName(token));
        return true;
    }
}

class item_black_rose_bag_upgrade : public ItemScript
{
public:
    item_black_rose_bag_upgrade() : ItemScript("item_black_rose_bag_upgrade") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        BlackRose::BagUpgradeTier const* tier =
            BlackRose::GetBagUpgradeTier(item->GetEntry());

        if (!tier)
            return true;

        Item* blackRoseBag = nullptr;
        uint8 blackRoseBagSlot = NULL_SLOT;

        for (uint8 slot = INVENTORY_SLOT_BAG_START;
             slot < INVENTORY_SLOT_BAG_END; ++slot)
        {
            Item* equippedBag = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
            if (!equippedBag || equippedBag->GetEntry() != tier->CurrentBag)
                continue;

            blackRoseBag = equippedBag;
            blackRoseBagSlot = slot;
            break;
        }

        if (!blackRoseBag)
        {
            ChatHandler(player->GetSession()).SendNotification(
                "Equip the current Bag of the Black Rose before using this.");
            return true;
        }

        if (blackRoseBag->IsNotEmptyBag())
        {
            ChatHandler(player->GetSession()).SendNotification(
                "Empty your Bag of the Black Rose before upgrading it.");
            return true;
        }

        uint16 equipDestination = 0;
        InventoryResult result = player->CanEquipNewItem(
            blackRoseBagSlot, equipDestination, tier->UpgradedBag, true);

        if (result != EQUIP_ERR_OK)
        {
            player->SendEquipError(result, item, nullptr);
            return true;
        }

        uint8 tokenBag = item->GetBagSlot();
        uint8 tokenSlot = item->GetSlot();

        // Replace only an empty equipped bag so no contained items can be lost.
        player->DestroyItem(INVENTORY_SLOT_BAG_0, blackRoseBagSlot, true);

        if (!player->EquipNewItem(equipDestination, tier->UpgradedBag, true))
        {
            player->EquipNewItem(equipDestination, tier->CurrentBag, true);
            player->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, item, nullptr);
            return true;
        }

        player->DestroyItem(tokenBag, tokenSlot, true);
        ChatHandler(player->GetSession()).SendNotification(
            "Your Bag of the Black Rose now has {} slots.", tier->Slots);

        return true;
    }
};

class item_black_rose_gem_upgrade : public ItemScript
{
public:
    item_black_rose_gem_upgrade() : ItemScript("item_black_rose_gem_upgrade") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        BlackRose::GemUpgrade upgrade;
        if (!BlackRose::GetGemUpgrade(item->GetEntry(), upgrade))
            return true;

        if (!CheckUpgradeUnlocked(player, item->GetEntry(), true))
            return true;

        Item* blackRose = BlackRose::GetEquippedBlackRose(player);
        if (!blackRose)
        {
            ChatHandler(player->GetSession()).SendNotification(
                "Equip The Black Rose before using this upgrade.");
            return true;
        }

        EnchantmentSlot socketSlot = MAX_ENCHANTMENT_SLOT;
        for (uint32 slot = SOCK_ENCHANTMENT_SLOT;
             slot < SOCK_ENCHANTMENT_SLOT + MAX_GEM_SOCKETS; ++slot)
        {
            EnchantmentSlot enchantSlot = EnchantmentSlot(slot);
            if (blackRose->GetEnchantmentId(enchantSlot) != upgrade.LowerEnchant)
                continue;

            socketSlot = enchantSlot;
            break;
        }

        if (socketSlot == MAX_ENCHANTMENT_SLOT)
        {
            ChatHandler(player->GetSession()).SendNotification(
                "Socket the previous rank into The Black Rose first.");
            return true;
        }

        ItemPosCountVec dest;
        InventoryResult result = player->CanStoreNewItem(
            NULL_BAG, NULL_SLOT, dest, upgrade.NextGem, 1);
        if (result != EQUIP_ERR_OK)
        {
            player->SendEquipError(result, item, nullptr);
            return true;
        }

        uint8 tokenBag = item->GetBagSlot();
        uint8 tokenSlot = item->GetSlot();

        player->ApplyEnchantment(blackRose, socketSlot, false);
        blackRose->ClearEnchantment(socketSlot);
        blackRose->SendUpdateSockets();

        player->StoreNewItem(dest, upgrade.NextGem, true);
        player->DestroyItem(tokenBag, tokenSlot, true);

        ChatHandler(player->GetSession()).SendNotification(
            "The Black Rose releases the socketed gem's next rank.");

        return true;
    }
};

class item_black_rose_magic_stick : public ItemScript
{
public:
    item_black_rose_magic_stick() : ItemScript(
        "item_black_rose_magic_stick") { }

    bool OnUse(Player* player, Item* item,
        SpellCastTargets const& /*targets*/) override
    {
        BlackRose::GemSocketFamily family =
            BlackRose::GetMagicStickFamily(item->GetEntry());
        if (family == BlackRose::GemSocketFamily::None)
            return true;

        Item* blackRose = BlackRose::GetEquippedBlackRose(player);
        if (!blackRose)
        {
            ChatHandler(player->GetSession()).SendNotification(
                "Equip The Black Rose before using this stick.");
            return true;
        }

        EnchantmentSlot socketSlot = EnchantmentSlot(MAX_ENCHANTMENT_SLOT);
        uint32 gemItem = 0;
        for (uint32 slot = SOCK_ENCHANTMENT_SLOT;
             slot < SOCK_ENCHANTMENT_SLOT + MAX_GEM_SOCKETS; ++slot)
        {
            EnchantmentSlot enchantSlot = EnchantmentSlot(slot);
            uint32 enchantId = blackRose->GetEnchantmentId(enchantSlot);
            if (BlackRose::GetBlackRoseGemFamily(enchantId) != family)
                continue;

            socketSlot = enchantSlot;
            gemItem = enchantId;
            break;
        }

        if (socketSlot == EnchantmentSlot(MAX_ENCHANTMENT_SLOT) || !gemItem)
        {
            ChatHandler(player->GetSession()).SendNotification(
                "The Black Rose has no socketed {} to recover.",
                BlackRose::GetGemFamilyName(family));
            return true;
        }

        ItemPosCountVec dest;
        InventoryResult result = player->CanStoreNewItem(
            NULL_BAG, NULL_SLOT, dest, gemItem, 1);
        if (result != EQUIP_ERR_OK)
        {
            player->SendEquipError(result, item, nullptr);
            return true;
        }

        uint8 stickBag = item->GetBagSlot();
        uint8 stickSlot = item->GetSlot();

        player->ApplyEnchantment(blackRose, socketSlot, false);
        blackRose->ClearEnchantment(socketSlot);
        blackRose->SendUpdateSockets();

        player->StoreNewItem(dest, gemItem, true);
        player->DestroyItem(stickBag, stickSlot, true);

        ChatHandler(player->GetSession()).SendNotification(
            "Rosy's Magic Stick recovers your {}.",
            BlackRose::GetGemFamilyName(family));

        return true;
    }
};

class npc_black_rose_rosy : public CreatureScript
{
public:
    npc_black_rose_rosy() : CreatureScript("npc_black_rose_rosy") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        ClearGossipMenuFor(player);
        AddGossipItemFor(player, GOSSIP_ICON_VENDOR,
            "I'd like to browse your goods.", GOSSIP_SENDER_MAIN,
            GOSSIP_ACTION_TRADE);
        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG,
            "Empower a Black Rose gem.", GOSSIP_SENDER_MAIN,
            GOSSIP_ACTION_SHOW_GEM_UPGRADES);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/,
        uint32 action) override
    {
        ClearGossipMenuFor(player);

        if (action == GOSSIP_ACTION_TRADE)
        {
            player->GetSession()->SendListInventory(creature->GetGUID());
            return true;
        }

        if (action == GOSSIP_ACTION_SHOW_GEM_UPGRADES)
        {
            if (!BlackRose::GetEquippedBlackRose(player))
            {
                CloseGossipMenuFor(player);
                ChatHandler(player->GetSession()).SendNotification(
                    "Equip The Black Rose before empowering its gems.");
                return true;
            }

            if (!AddEligibleUpgradeOptions(player))
            {
                CloseGossipMenuFor(player);
                ChatHandler(player->GetSession()).SendNotification(
                    "Socket a Black Rose gem before buying its next upgrade.");
                return true;
            }

            SendGossipMenuFor(player, player->GetGossipTextId(creature),
                creature);
            return true;
        }

        uint32 token = GetGemUpgradeForGossipAction(action);
        if (token && BuyGemUpgradeToken(player, token))
            CloseGossipMenuFor(player);

        return true;
    }
};

class player_black_rose_gem_system : public PlayerScript
{
public:
    player_black_rose_gem_system() : PlayerScript(
        "player_black_rose_gem_system",
        { PLAYERHOOK_ON_BEFORE_BUY_ITEM_FROM_VENDOR,
          PLAYERHOOK_ON_APPLY_ENCHANTMENT_ITEM_MODS_BEFORE,
          PLAYERHOOK_CAN_APPLY_ENCHANTMENT,
          PLAYERHOOK_ON_PLAYER_COMPLETE_QUEST }) { }

    void OnPlayerCompleteQuest(Player* player, Quest const* quest) override
    {
        uint32 questId = quest->GetQuestId();
        if (questId != BlackRose::QuestTheBlackRoseAlliance &&
            questId != BlackRose::QuestTheBlackRoseHorde)
            return;

        GrantQuestCurrency(player, BlackRose::ItemBlackMiasma);
        GrantQuestCurrency(player, BlackRose::ItemBlackPetals);
        GrantQuestCurrency(player, BlackRose::ItemBlackThorns);
    }

    void OnPlayerBeforeBuyItemFromVendor(Player* player,
        ObjectGuid /*vendorguid*/, uint32 /*vendorslot*/, uint32& item,
        uint8 /*count*/, uint8 /*bag*/, uint8 /*slot*/) override
    {
        BlackRose::GemUpgrade upgrade;
        if (!BlackRose::GetGemUpgrade(item, upgrade))
            return;

        if (!BlackRose::HasSocketedEnchant(player, upgrade.LowerEnchant))
        {
            ChatHandler(player->GetSession()).SendNotification(
                "Rosy will only sell that upgrade after the previous rank "
                "is socketed.");
            item = 0;
            return;
        }

        if (!CheckUpgradeUnlocked(player, item, true))
            item = 0;
    }

    bool OnPlayerCanApplyEnchantment(Player* player, Item* item,
        EnchantmentSlot slot, bool apply, bool /*apply_dur*/,
        bool /*ignore_condition*/) override
    {
        if (!apply || !item)
            return true;

        if (slot < SOCK_ENCHANTMENT_SLOT ||
            slot >= SOCK_ENCHANTMENT_SLOT + MAX_GEM_SOCKETS)
            return true;

        uint32 enchantId = item->GetEnchantmentId(slot);
        if (!BlackRose::IsBlackRoseGemEnchantment(enchantId) ||
            item->GetEntry() == BlackRose::ItemTheBlackRose)
            return true;

        player->SendEquipError(EQUIP_ERR_ITEM_DOESNT_GO_TO_SLOT, item, nullptr);
        item->ClearEnchantment(slot);
        item->SendUpdateSockets();

        if (GrantItem(player, enchantId))
            ChatHandler(player->GetSession()).SendNotification(
                "Black Rose gems can only be socketed into The Black Rose.");
        else
            ChatHandler(player->GetSession()).SendNotification(
                "Black Rose gems can only be socketed into The Black Rose. "
                "Make room in your bags before trying again.");

        return false;
    }

    void OnPlayerApplyEnchantmentItemModsBefore(Player* player, Item* item,
        EnchantmentSlot slot, bool /*apply*/, uint32 /*enchant_spell_id*/,
        uint32& enchant_amount) override
    {
        if (!item || item->GetEntry() != BlackRose::ItemTheBlackRose)
            return;

        if (slot < SOCK_ENCHANTMENT_SLOT ||
            slot >= SOCK_ENCHANTMENT_SLOT + MAX_GEM_SOCKETS)
            return;

        if (!BlackRose::IsBlackRoseGemEnchantment(item->GetEnchantmentId(slot)))
            return;

        if (!BlackRose::ShouldBoostGemStats(player))
            return;

        enchant_amount = enchant_amount * 5 / 2;
    }

private:
    static void GrantQuestCurrency(Player* player, uint32 itemId)
    {
        if (!GrantItem(player, itemId))
            return;
    }
};

class global_black_rose_loot_system : public GlobalScript
{
public:
    global_black_rose_loot_system() : GlobalScript(
        "global_black_rose_loot_system",
        { GLOBALHOOK_ON_BEFORE_LOOT_EQUAL_CHANCED }) { }

    bool OnBeforeLootEqualChanced(Player const* player,
        LootStoreItemList equalChanced, Loot& loot,
        LootStore const& /*store*/) override
    {
        if (!IsBlackRoseCurrencyGroup(equalChanced))
            return true;

        if (!player || !loot.sourceWorldObjectGUID)
            return true;

        Creature const* boss = ObjectAccessor::GetCreature(
            *player, loot.sourceWorldObjectGUID);
        if (!boss || !boss->GetMap() || !boss->GetMap()->IsNonRaidDungeon())
            return true;

        return IsNonTrivialForLootOwnerGroup(player, boss);
    }
};

class spell_black_rose_power : public AuraScript
{
    PrepareAuraScript(spell_black_rose_power);

    void AfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Player* player = GetTarget()->ToPlayer())
            BlackRose::ReapplySocketEnchants(player, false, true);
    }

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Player* player = GetTarget()->ToPlayer())
            BlackRose::ReapplySocketEnchants(player, true, false);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_black_rose_power::AfterApply,
            EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(
            spell_black_rose_power::AfterRemove, EFFECT_0, SPELL_AURA_DUMMY,
            AURA_EFFECT_HANDLE_REAL);
    }
};

void AddBlackRoseScripts()
{
    new npc_black_rose_rosy();
    new item_black_rose_bag_upgrade();
    new item_black_rose_gem_upgrade();
    new item_black_rose_magic_stick();
    new player_black_rose_gem_system();
    new global_black_rose_loot_system();
    RegisterSpellScript(spell_black_rose_power);
}
