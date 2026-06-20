#include "ProficiencyMgr.h"
#include "proficiency/Types.h"
#include "Creature.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes branding config on startup and on `.reload config`.
class BrandingWorldScript : public WorldScript
{
public:
    BrandingWorldScript() : WorldScript("BrandingWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sProficiencyMgr->LoadConfig();
    }
};

// Player lifecycle + a demonstration activity hook. The full activity sources (invasions, raids,
// gathering, ...) arrive with Slice 3; this single kill hook proves the load -> earn -> save loop.
class BrandingProficiencyPlayerScript : public PlayerScript
{
public:
    BrandingProficiencyPlayerScript() : PlayerScript("BrandingProficiencyPlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        sProficiencyMgr->LoadPlayer(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        sProficiencyMgr->SavePlayer(player);
        sProficiencyMgr->UnloadPlayer(player->GetGUID());
    }

    void OnPlayerCreatureKill(Player* killer, Creature* /*killed*/) override
    {
        if (!killer || !sProficiencyMgr->Config().Enabled())
            return;

        // TODO(Slice 3): source/brand/role come from the contribution tracker + active loadout.
        XpActivity activity;
        activity.source = ActivitySource::Invasion;
        activity.activeBrand = BrandId::Fire;
        activity.contentBrand = BrandId::Fire;
        activity.role = RoleContribution::Damage;
        activity.baseUnits = 1;

        sProficiencyMgr->ApplyActivity(killer->GetGUID(), killer->GetSession()->GetAccountId(), activity);
    }
};

// Entrypoint invoked by the modules loader (Add<dir-with-underscores>Scripts).
void Addmod_brandingScripts()
{
    new BrandingWorldScript();
    new BrandingProficiencyPlayerScript();
}
