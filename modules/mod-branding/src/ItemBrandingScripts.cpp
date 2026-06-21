#include "ItemBrandingMgr.h"
#include "mod_branding_loader.h"
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

// Loads the equipped weapon's brand state on login.
class BrandingItemPlayerScript : public PlayerScript
{
public:
    BrandingItemPlayerScript() : PlayerScript("BrandingItemPlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        sItemBrandingMgr->LoadEquipped(player);
    }
};

void AddBrandingItemScripts()
{
    new BrandingItemWorldScript();
    new BrandingItemPlayerScript();
}
