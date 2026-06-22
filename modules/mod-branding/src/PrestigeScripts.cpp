#include "PrestigeMgr.h"
#include "mod_branding_loader.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes prestige config on startup and on `.reload config`.
class BrandingPrestigeWorldScript : public WorldScript
{
public:
    BrandingPrestigeWorldScript() : WorldScript("BrandingPrestigeWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sPrestigeMgr->LoadConfig();
    }
};

// §14.13.4 graduation titles. CheckAndGrant is idempotent and cheap, so we drive it from a login
// catch-up and a low-frequency post-activity trigger (level change). Frequency affects only latency.
class BrandingPrestigePlayerScript : public PlayerScript
{
public:
    BrandingPrestigePlayerScript() : PlayerScript("BrandingPrestigePlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        sPrestigeMgr->CheckAndGrant(player);
    }

    void OnPlayerLevelChanged(Player* player, uint8 /*oldlevel*/) override
    {
        sPrestigeMgr->CheckAndGrant(player);
    }
};

void AddBrandingPrestigeScripts()
{
    new BrandingPrestigeWorldScript();
    new BrandingPrestigePlayerScript();
}
