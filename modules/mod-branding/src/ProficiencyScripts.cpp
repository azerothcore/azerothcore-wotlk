#include "LoadoutMgr.h"
#include "ProficiencyMgr.h"
#include "mod_branding_loader.h"
#include "branding/proficiency/Types.h"
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

// Player lifecycle + the con-independent kill rail (§7.4, issue #32). `OnPlayerCreatureKill` fires
// from Unit::Kill() unconditionally -- it is NOT gated on XP eligibility or con-color -- so a player
// earns Proficiency from whatever they kill, wherever they kill it. The per-kill amount is sized "as
// if at-level" then floored by difficulty so trivial kills still pay (>0) but never as much as
// level-appropriate content (anti-farm). Source/role and content-brand still arrive with the Slice 3
// contribution tracker (TODO).
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

    void OnPlayerCreatureKill(Player* killer, Creature* killed) override
    {
        if (!killer || !killed || !sProficiencyMgr->Config().Enabled())
            return;

        // Mirror vanilla's creature-level XP eligibility (NOT the con/level taper): totems, pets,
        // critters and explicit no-XP creatures never reward. This filter is con-independent -- grey
        // mob kills still qualify -- it only blocks summoned/filler targets that would otherwise be
        // an unlimited proficiency font.
        if (killed->IsTotem() || killed->IsPet() || killed->IsCritter()
            || killed->HasFlagsExtra(CREATURE_FLAG_EXTRA_NO_XP))
            return;

        uint32 const baseUnits = sProficiencyMgr->KillBaseUnits(killer, killed);
        if (baseUnits == 0)
            return;

        // The active brand comes from the player's selected loadout (§7.9, issue #02).
        BrandId const activeBrand = sLoadoutMgr->GetLoadout(killer->GetGUID()).activeBrand;

        XpActivity activity;
        activity.source = ActivitySource::Invasion;
        activity.activeBrand = activeBrand;
        activity.contentBrand = activeBrand;
        activity.role = RoleContribution::Damage;
        activity.baseUnits = baseUnits;

        sProficiencyMgr->ApplyActivity(killer->GetGUID(), killer->GetSession()->GetAccountId(), activity);
    }
};

void AddBrandingProficiencyScripts()
{
    new BrandingWorldScript();
    new BrandingProficiencyPlayerScript();
}
