#include "ItemBrandingMgr.h"
#include "mod_branding_loader.h"
#include "Item.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes item-branding config on startup and on `.reload config`.
class BrandingItemWorldScript : public WorldScript
{
public:
    BrandingItemWorldScript() : WorldScript("BrandingItemWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sItemBrandingMgr->LoadConfig();
    }
};

// Loads equipped items' brand state on login, and refreshes the cache when an Etch-eligible item is
// equipped mid-session (so the multi-slot aggregate / gates stay correct without a relog, #31).
class BrandingItemPlayerScript : public PlayerScript
{
public:
    BrandingItemPlayerScript() : PlayerScript("BrandingItemPlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        sItemBrandingMgr->LoadEquipped(player);
    }

    void OnPlayerEquip(Player* /*player*/, Item* it, uint8 bag, uint8 slot, bool /*update*/) override
    {
        if (bag == INVENTORY_SLOT_BAG_0 && ItemBrandingMgr::EtchEligibleSlot(slot))
            sItemBrandingMgr->CacheItem(it);
    }
};

void AddBrandingItemScripts()
{
    new BrandingItemWorldScript();
    new BrandingItemPlayerScript();
}
