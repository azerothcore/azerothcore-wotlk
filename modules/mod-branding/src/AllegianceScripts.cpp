#include "AllegianceMgr.h"
#include "mod_branding_loader.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes allegiance config on startup and on `.reload config`.
class BrandingAllegianceWorldScript : public WorldScript
{
public:
    BrandingAllegianceWorldScript() : WorldScript("BrandingAllegianceWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sAllegianceMgr->LoadConfig();
    }
};

// Per-character allegiance lifecycle: load the chosen side on login, drop the cache on logout.
// Selection itself is persisted immediately by `.branding allegiance set`, so there is no save here.
class BrandingAllegiancePlayerScript : public PlayerScript
{
public:
    BrandingAllegiancePlayerScript() : PlayerScript("BrandingAllegiancePlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        sAllegianceMgr->LoadPlayer(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        sAllegianceMgr->UnloadPlayer(player->GetGUID());
    }
};

void AddBrandingAllegianceScripts()
{
    new BrandingAllegianceWorldScript();
    new BrandingAllegiancePlayerScript();
}
