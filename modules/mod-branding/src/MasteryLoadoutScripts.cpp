#include "MasteryLoadoutMgr.h"
#include "mod_branding_loader.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes the §14.11 mastery-loadout config on startup and on `.reload config`.
class BrandingMasteryLoadoutWorldScript : public WorldScript
{
public:
    BrandingMasteryLoadoutWorldScript() : WorldScript("BrandingMasteryLoadoutWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sMasteryLoadoutMgr->LoadConfig();
    }
};

// Player lifecycle + the §14.11 free dual-spec loadout swap. The earned mastery layer (shared across
// specs) is owned by MasteryMgr; this only handles the per-spec ALLOCATED loadout.
class BrandingMasteryLoadoutPlayerScript : public PlayerScript
{
public:
    BrandingMasteryLoadoutPlayerScript() : PlayerScript("BrandingMasteryLoadoutPlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        sMasteryLoadoutMgr->LoadPlayer(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        sMasteryLoadoutMgr->SavePlayer(player);
        sMasteryLoadoutMgr->UnloadPlayer(player->GetGUID());
    }

    // §14.11: switching dual-spec auto-swaps the saved loadout for that slot -- free, no token.
    void OnPlayerAfterSpecSlotChanged(Player* player, uint8 newSlot) override
    {
        sMasteryLoadoutMgr->OnSpecChanged(player, newSlot);
    }
};

void AddBrandingMasteryLoadoutScripts()
{
    new BrandingMasteryLoadoutWorldScript();
    new BrandingMasteryLoadoutPlayerScript();
}
