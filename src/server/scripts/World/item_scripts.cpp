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

#include "AreaDefines.h"
#include "BlackRoseGemSystem.h"
#include "Chat.h"
#include "ItemScript.h"
#include "Player.h"
#include "PlayerScript.h"
#include "QuestDef.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellMgr.h"

/*#####
# item_only_for_flight
#####*/

enum OnlyForFlight
{
    SPELL_ARCANE_CHARGES    = 45072
};

class item_only_for_flight : public ItemScript
{
public:
    item_only_for_flight() : ItemScript("item_only_for_flight") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        uint32 itemId = item->GetEntry();
        bool disabled = false;

        //for special scripts
        switch (itemId)
        {
            case 24538:
                if (player->GetAreaId() != AREA_HALAA)
                    disabled = true;
                break;
            case 34489:
                if (player->GetZoneId() != AREA_ISLE_OF_QUEL_DANAS)
                    disabled = true;
                break;
            case 34475:
                if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_ARCANE_CHARGES))
                    Spell::SendCastResult(player, spellInfo, 1, SPELL_FAILED_NOT_ON_GROUND);
                break;
        }

        // allow use in flight only
        if (player->IsInFlight() && !disabled)
            return false;

        // error
        player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, nullptr);
        return true;
    }
};

/*#####
# item_incendiary_explosives
#####*/

class item_incendiary_explosives : public ItemScript
{
public:
    item_incendiary_explosives() : ItemScript("item_incendiary_explosives") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        if (player->FindNearestCreature(26248, 15) || player->FindNearestCreature(26249, 15))
            return false;
        else
        {
            player->SendEquipError(EQUIP_ERR_OUT_OF_RANGE, item, nullptr);
            return true;
        }
    }
};

/*#####
# item_mysterious_egg
#####*/

class item_mysterious_egg : public ItemScript
{
public:
    item_mysterious_egg() : ItemScript("item_mysterious_egg") { }

    bool OnExpire(Player* player, ItemTemplate const* /*pItemProto*/) override
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 39883, 1); // Cracked Egg
        if (msg == EQUIP_ERR_OK)
            player->StoreNewItem(dest, 39883, true);

        return true;
    }
};

/*#####
# item_disgusting_jar
#####*/

class item_disgusting_jar : public ItemScript
{
public:
    item_disgusting_jar() : ItemScript("item_disgusting_jar") { }

    bool OnExpire(Player* player, ItemTemplate const* /*pItemProto*/) override
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 44718, 1); // Ripe Disgusting Jar
        if (msg == EQUIP_ERR_OK)
            player->StoreNewItem(dest, 44718, true);

        return true;
    }
};

/*#####
# item_petrov_cluster_bombs
#####*/

enum PetrovClusterBombs
{
    SPELL_PETROV_BOMB           = 42406
};

class item_petrov_cluster_bombs : public ItemScript
{
public:
    item_petrov_cluster_bombs() : ItemScript("item_petrov_cluster_bombs") { }

    bool OnUse(Player* player, Item* item, const SpellCastTargets& /*targets*/) override
    {
        if (player->GetZoneId() != AREA_HOWLING_FJORD)
            return false;

        if (!player->GetTransport() || player->GetAreaId() != AREA_SHATTERED_STRAITS)
        {
            player->SendEquipError(EQUIP_ERR_NONE, item, nullptr);

            if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_PETROV_BOMB))
                Spell::SendCastResult(player, spellInfo, 1, SPELL_FAILED_NOT_HERE);

            return true;
        }

        return false;
    }
};

enum CapturedFrog
{
    QUEST_THE_PERFECT_SPIES      = 25444,
    NPC_VANIRAS_SENTRY_TOTEM     = 40187
};

class item_captured_frog : public ItemScript
{
public:
    item_captured_frog() : ItemScript("item_captured_frog") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        if (player->GetQuestStatus(QUEST_THE_PERFECT_SPIES) == QUEST_STATUS_INCOMPLETE)
        {
            if (player->FindNearestCreature(NPC_VANIRAS_SENTRY_TOTEM, 10.0f))
                return false;
            else
                player->SendEquipError(EQUIP_ERR_OUT_OF_RANGE, item, nullptr);
        }
        else
            player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, nullptr);
        return true;
    }
};

// Only used currently for
// 19169: Nightfall
class item_generic_limit_chance_above_60 : public ItemScript
{
public:
    item_generic_limit_chance_above_60() : ItemScript("item_generic_limit_chance_above_60") { }

    bool OnCastItemCombatSpell(Player* /*player*/, Unit* victim, SpellInfo const* /*spellInfo*/, Item* /*item*/) override
    {
        // spell proc chance gets severely reduced on victims > 60 (formula unknown)
        if (victim->GetLevel() > 60)
        {
            // gives ~0.1% proc chance at lvl 70
            float const lvlPenaltyFactor = 9.93f;
            float const failureChance = (victim->GetLevel() - 60) * lvlPenaltyFactor;

            // base ppm chance was already rolled, only roll success chance
            return !roll_chance_f(failureChance);
        }

        return true;
    }
};

enum BlackRoseBagUpgradeItems
{
    ITEM_BLACK_ROSE_BAG_26          = 900102,
    ITEM_BLACK_ROSE_BAG_28          = 900120,
    ITEM_BLACK_ROSE_BAG_30          = 900121,
    ITEM_BLACK_ROSE_BAG_32          = 900122,
    ITEM_BLACK_ROSE_BAG_34          = 900123,
    ITEM_BLACK_ROSE_BAG_36          = 900124,
    ITEM_BLACK_ROSE_BAG_UPGRADE_28  = 900130,
    ITEM_BLACK_ROSE_BAG_UPGRADE_30  = 900131,
    ITEM_BLACK_ROSE_BAG_UPGRADE_32  = 900132,
    ITEM_BLACK_ROSE_BAG_UPGRADE_34  = 900133,
    ITEM_BLACK_ROSE_BAG_UPGRADE_36  = 900134
};

struct BlackRoseBagUpgradeTier
{
    uint32 Token;
    uint32 CurrentBag;
    uint32 UpgradedBag;
    uint8 Slots;
};

BlackRoseBagUpgradeTier const* GetBlackRoseBagUpgradeTier(uint32 token)
{
    static BlackRoseBagUpgradeTier const upgrades[] =
    {
        { ITEM_BLACK_ROSE_BAG_UPGRADE_28, ITEM_BLACK_ROSE_BAG_26,
          ITEM_BLACK_ROSE_BAG_28, 28 },
        { ITEM_BLACK_ROSE_BAG_UPGRADE_30, ITEM_BLACK_ROSE_BAG_28,
          ITEM_BLACK_ROSE_BAG_30, 30 },
        { ITEM_BLACK_ROSE_BAG_UPGRADE_32, ITEM_BLACK_ROSE_BAG_30,
          ITEM_BLACK_ROSE_BAG_32, 32 },
        { ITEM_BLACK_ROSE_BAG_UPGRADE_34, ITEM_BLACK_ROSE_BAG_32,
          ITEM_BLACK_ROSE_BAG_34, 34 },
        { ITEM_BLACK_ROSE_BAG_UPGRADE_36, ITEM_BLACK_ROSE_BAG_34,
          ITEM_BLACK_ROSE_BAG_36, 36 }
    };

    for (BlackRoseBagUpgradeTier const& upgrade : upgrades)
        if (upgrade.Token == token)
            return &upgrade;

    return nullptr;
}

class item_black_rose_bag_upgrade : public ItemScript
{
public:
    item_black_rose_bag_upgrade() : ItemScript("item_black_rose_bag_upgrade") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        BlackRoseBagUpgradeTier const* tier =
            GetBlackRoseBagUpgradeTier(item->GetEntry());

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

class item_black_rose_trinket : public ItemScript
{
public:
    item_black_rose_trinket() : ItemScript("item_black_rose_trinket") { }

    bool OnUse(Player* player, Item* item,
        SpellCastTargets const& /*targets*/) override
    {
        if (player->HasSpellCooldown(BlackRose::SpellBlackRoseAura))
        {
            player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, nullptr);
            return true;
        }

        SpellCastResult result = player->CastSpell(player,
            BlackRose::SpellBlackRoseAura, TRIGGERED_FULL_MASK, item);
        if (result != SPELL_CAST_OK)
        {
            if (SpellInfo const* spellInfo =
                sSpellMgr->GetSpellInfo(BlackRose::SpellBlackRoseAura))
                Spell::SendCastResult(player, spellInfo, 1, result);

            return true;
        }

        player->AddSpellCooldown(BlackRose::SpellBlackRoseAura,
            item->GetEntry(), 3 * MINUTE * IN_MILLISECONDS, true);
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

class player_black_rose_gem_system : public PlayerScript
{
public:
    player_black_rose_gem_system() : PlayerScript(
        "player_black_rose_gem_system",
        { PLAYERHOOK_ON_BEFORE_BUY_ITEM_FROM_VENDOR,
          PLAYERHOOK_ON_APPLY_ENCHANTMENT_ITEM_MODS_BEFORE,
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

        if (BlackRose::HasSocketedEnchant(player, upgrade.LowerEnchant))
            return;

        ChatHandler(player->GetSession()).SendNotification(
            "Rosy will only sell that upgrade after the previous rank "
            "is socketed.");
        item = 0;
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
        ItemPosCountVec dest;
        InventoryResult result = player->CanStoreNewItem(
            NULL_BAG, NULL_SLOT, dest, itemId, 1);
        if (result != EQUIP_ERR_OK)
        {
            player->SendEquipError(result, nullptr, nullptr);
            return;
        }

        player->StoreNewItem(dest, itemId, true);
    }
};

void AddSC_item_scripts()
{
    new item_only_for_flight();
    new item_incendiary_explosives();
    new item_mysterious_egg();
    new item_disgusting_jar();
    new item_petrov_cluster_bombs();
    new item_captured_frog();
    new item_generic_limit_chance_above_60();
    new item_black_rose_bag_upgrade();
    new item_black_rose_trinket();
    new item_black_rose_gem_upgrade();
    new player_black_rose_gem_system();
}
