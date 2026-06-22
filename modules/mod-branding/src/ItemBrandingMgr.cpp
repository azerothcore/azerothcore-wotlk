#include "ItemBrandingMgr.h"
#include "LoadoutMgr.h"
#include "ProficiencyMgr.h"
#include "branding/effects/ItemBrand.h"
#include "branding/proficiency/Knowledge.h"
#include "Configuration/Config.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "Player.h"

namespace Branding
{
    ItemBrandingMgr* ItemBrandingMgr::instance()
    {
        static ItemBrandingMgr mgr;
        return &mgr;
    }

    void ItemBrandingMgr::LoadConfig()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Item.Enable", false);
        _etchEnabled = sConfigMgr->GetOption<bool>("Branding.Etch.Enable", false);
        _essenceItemId = sConfigMgr->GetOption<uint32>("Branding.Etch.EssenceItemId", 190002);
        _essenceCost = sConfigMgr->GetOption<uint32>("Branding.Etch.EssenceCost", 500);
        _config.Load();
    }

    uint32_t ItemBrandingMgr::EquippedItemGuid(Player* player) const
    {
        if (!player)
            return 0;

        Item* weapon = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);
        return weapon ? weapon->GetGUID().GetCounter() : 0;
    }

    void ItemBrandingMgr::Save(uint32_t itemGuid, ItemBrandState const& state)
    {
        CharacterDatabase.Execute(
            "REPLACE INTO `item_branding` (`item_guid`, `brand`, `step`, `level_in_step`, `etched`) "
            "VALUES ({}, {}, {}, {}, {})",
            itemGuid, static_cast<uint32>(state.brand), static_cast<uint32>(state.step),
            static_cast<uint32>(state.levelInStep), static_cast<uint32>(state.etched ? 1 : 0));
    }

    void ItemBrandingMgr::LoadEquipped(Player* player)
    {
        if (!_enabled)
            return;

        uint32_t const itemGuid = EquippedItemGuid(player);
        if (itemGuid == 0)
            return;

        QueryResult result = CharacterDatabase.Query(
            "SELECT `brand`, `step`, `level_in_step`, `etched` FROM `item_branding` WHERE `item_guid` = {}",
            itemGuid);
        if (!result)
            return;

        Field* fields = result->Fetch();
        ItemBrandState state;
        state.brand = static_cast<BrandId>(fields[0].Get<uint8>());
        state.step = fields[1].Get<uint8>();
        state.levelInStep = fields[2].Get<uint8>();
        state.etched = fields[3].Get<uint8>() != 0;
        _items[itemGuid] = state;
    }

    bool ItemBrandingMgr::BrandEquipped(Player* player, BrandId brand)
    {
        uint32_t const itemGuid = EquippedItemGuid(player);
        if (itemGuid == 0)
            return false;

        ItemBrandState state;
        state.brand = brand;
        _items[itemGuid] = state;
        Save(itemGuid, state);
        return true;
    }

    uint8_t ItemBrandingMgr::UpgradeEquipped(Player* player, uint32_t resources)
    {
        uint32_t const itemGuid = EquippedItemGuid(player);
        if (itemGuid == 0)
            return 0;

        ItemBrandState& state = _items[itemGuid];
        ItemUpgradeResult const result = ApplyItemUpgrade(state, resources, _config);
        Save(itemGuid, state);
        return result.levelsGained;
    }

    double ItemBrandingMgr::EquippedIntensity(Player* player) const
    {
        uint32_t const itemGuid = EquippedItemGuid(player);
        auto it = _items.find(itemGuid);
        if (itemGuid == 0 || it == _items.end())
            return 1.0;

        bool canExpress = player &&
            CanExpressBrand(it->second.brand, sProficiencyMgr->AccountKnowledge(player->GetSession()->GetAccountId()));

        // Etch (#31, decision 2): an Etched item's proc expresses ONLY while its brand is the player's
        // active school -- a stronger gate than account Knowledge alone. Switch active school and it goes
        // dormant. (Crafted Branded items keep the §05 Knowledge-only gate, unchanged.)
        if (canExpress && it->second.etched)
            canExpress = sLoadoutMgr->GetLoadout(player->GetGUID()).activeBrand == it->second.brand;

        return ResolvedItemEffectIntensity(it->second, canExpress, _config);
    }

    EtchResult ItemBrandingMgr::EtchEquipped(Player* player)
    {
        if (!EtchEnabled())
            return EtchResult::Disabled;

        uint32_t const itemGuid = EquippedItemGuid(player);
        if (itemGuid == 0)
            return EtchResult::NoWeapon;

        // One Etch per item, permanent: refuse if this item already carries any Brand (etched or crafted).
        // Authoritative DB check, not just the cache -- the cache only holds items loaded at login, so a
        // weapon branded earlier and equipped mid-session would otherwise be re-etched (double-charging
        // the premium Essence). A rare command, so a blocking lookup is fine.
        if (_items.find(itemGuid) != _items.end())
            return EtchResult::AlreadyBranded;
        if (CharacterDatabase.Query("SELECT 1 FROM `item_branding` WHERE `item_guid` = {}", itemGuid))
            return EtchResult::AlreadyBranded;

        BrandId const brand = sLoadoutMgr->GetLoadout(player->GetGUID()).activeBrand;

        // Gated behind enrollment (#31 decision 6): the active school must be account-unlocked, which is
        // also what lets the Etched proc express (decision 2 / anti-P2W §1).
        if (!CanExpressBrand(brand, sProficiencyMgr->AccountKnowledge(player->GetSession()->GetAccountId())))
            return EtchResult::NotEnrolled;

        if (player->GetItemCount(_essenceItemId, false) < _essenceCost)
            return EtchResult::InsufficientEssence;

        // Commit only past every gate: consume the premium BoP Essence, write the rank-locked Etched
        // state, and soulbind the weapon (BoE -> BoP, #31 decision 3 / §16.3).
        player->DestroyItemCount(_essenceItemId, _essenceCost, true);

        ItemBrandState state;
        state.brand = brand;
        state.etched = true;
        _items[itemGuid] = state;
        Save(itemGuid, state);

        if (Item* weapon = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND))
        {
            weapon->SetBinding(true);
            weapon->SetState(ITEM_CHANGED, player);
        }

        return EtchResult::Success;
    }

    bool ItemBrandingMgr::EquippedState(Player* player, ItemBrandState& out) const
    {
        auto it = _items.find(EquippedItemGuid(player));
        if (it == _items.end())
            return false;

        out = it->second;
        return true;
    }
}
