#include "SelectionMgr.h"
#include "mod_branding_loader.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes the active-school switch-fee config (§14.13.2) on startup and on `.reload config`.
class BrandingSelectionWorldScript : public WorldScript
{
public:
    BrandingSelectionWorldScript() : WorldScript("BrandingSelectionWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sSelectionMgr->LoadConfig();
    }
};

// Player lifecycle for the per-character recent-switch counter. Loads (with decay applied) on login,
// flushes on logout.
class BrandingSelectionPlayerScript : public PlayerScript
{
public:
    BrandingSelectionPlayerScript() : PlayerScript("BrandingSelectionPlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        sSelectionMgr->LoadPlayer(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        sSelectionMgr->SavePlayer(player);
        sSelectionMgr->UnloadPlayer(player->GetGUID());
    }
};

void AddBrandingSelectionScripts()
{
    new BrandingSelectionWorldScript();
    new BrandingSelectionPlayerScript();
}
