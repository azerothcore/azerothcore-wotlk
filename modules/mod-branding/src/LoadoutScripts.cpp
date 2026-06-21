#include "LoadoutMgr.h"
#include "mod_branding_loader.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes the loadout (item-branding) config on startup and on `.reload config`.
class BrandingLoadoutWorldScript : public WorldScript
{
public:
    BrandingLoadoutWorldScript() : WorldScript("BrandingLoadoutWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sLoadoutMgr->LoadConfig();
    }
};

// Player lifecycle for the active brand + proc loadout (§7.9). Loads on login, flushes on logout.
class BrandingLoadoutPlayerScript : public PlayerScript
{
public:
    BrandingLoadoutPlayerScript() : PlayerScript("BrandingLoadoutPlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        sLoadoutMgr->LoadPlayer(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        sLoadoutMgr->SavePlayer(player);
        sLoadoutMgr->UnloadPlayer(player->GetGUID());
    }
};

void AddBrandingLoadoutScripts()
{
    new BrandingLoadoutWorldScript();
    new BrandingLoadoutPlayerScript();
}
