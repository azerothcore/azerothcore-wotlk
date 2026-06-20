#include "DiscoveryMgr.h"
#include "mod_branding_loader.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes discovery config on startup and on `.reload config`.
class BrandingDiscoveryWorldScript : public WorldScript
{
public:
    BrandingDiscoveryWorldScript() : WorldScript("BrandingDiscoveryWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sDiscoveryMgr->LoadConfig();
    }
};

// §8.2: layer bonus discovery XP onto the host's exploration XP. The core fires explore XP only on
// a first visit, so this augments `amount` exactly when a new area is discovered -- no dedupe needed.
class BrandingDiscoveryPlayerScript : public PlayerScript
{
public:
    BrandingDiscoveryPlayerScript() : PlayerScript("BrandingDiscoveryPlayerScript") { }

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 xpSource) override
    {
        if (!player || xpSource != XPSOURCE_EXPLORE || !sDiscoveryMgr->Enabled())
            return;

        amount += sDiscoveryMgr->AreaDiscoveryBonus(player->GetLevel(), player->GetAreaId());
    }
};

void AddBrandingDiscoveryScripts()
{
    new BrandingDiscoveryWorldScript();
    new BrandingDiscoveryPlayerScript();
}
