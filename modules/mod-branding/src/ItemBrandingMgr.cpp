#include "ItemBrandingMgr.h"
#include "ProficiencyMgr.h"
#include "effects/ItemBrand.h"
#include "proficiency/Knowledge.h"
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
            "REPLACE INTO `item_branding` (`item_guid`, `brand`, `step`, `level_in_step`) VALUES ({}, {}, {}, {})",
            itemGuid, static_cast<uint32>(state.brand), static_cast<uint32>(state.step),
            static_cast<uint32>(state.levelInStep));
    }

    void ItemBrandingMgr::LoadEquipped(Player* player)
    {
        if (!_enabled)
            return;

        uint32_t const itemGuid = EquippedItemGuid(player);
        if (itemGuid == 0)
            return;

        QueryResult result = CharacterDatabase.Query(
            "SELECT `brand`, `step`, `level_in_step` FROM `item_branding` WHERE `item_guid` = {}", itemGuid);
        if (!result)
            return;

        Field* fields = result->Fetch();
        ItemBrandState state;
        state.brand = static_cast<BrandId>(fields[0].Get<uint8>());
        state.step = fields[1].Get<uint8>();
        state.levelInStep = fields[2].Get<uint8>();
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

        bool const canExpress = player &&
            CanExpressBrand(it->second.brand, sProficiencyMgr->AccountKnowledge(player->GetSession()->GetAccountId()));
        return ResolvedItemEffectIntensity(it->second, canExpress, _config);
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
