#include "LoadoutMgr.h"
#include "ProficiencyMgr.h"
#include "mod_branding_loader.h"
#include "branding/proficiency/Knowledge.h"
#include "branding/proficiency/Types.h"
#include "Configuration/Config.h"
#include "Log.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"

using namespace Branding;

namespace
{
    // Self-contained §14.13.3 tunables, refreshed on startup and on `.reload config`. The pure
    // Proficiency core reads none of these -- this adapter only converts a raw post-cap XP amount
    // into Proficiency `baseUnits`, which the core then runs through its source/match/DR formula.
    struct PostCapXpConfig
    {
        bool enabled = false;
        double conversionRatio = 0.01; // post-cap XP units -> Proficiency baseUnits

        void Load()
        {
            enabled = sConfigMgr->GetOption<bool>("Branding.PostCapXp.Enable", false);
            conversionRatio = sConfigMgr->GetOption<float>("Branding.PostCapXp.ConversionRatio", 0.01f);
        }
    };

    PostCapXpConfig g_postCapXpConfig;
}

// Refreshes the §14.13.3 post-cap config alongside the rest of the module's tunables.
class BrandingPostCapXpWorldScript : public WorldScript
{
public:
    BrandingPostCapXpWorldScript() : WorldScript("BrandingPostCapXpWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        g_postCapXpConfig.Load();
    }
};

// §14.13.3: at the server's max player level, normal XP has no sink -- redirect it into the active
// school's Proficiency. Only the active brand grows; dormant/unknown brands are untouched. Below the
// cap (or with the feature disabled) the vanilla `amount` is left exactly as the core produced it.
class BrandingPostCapXpPlayerScript : public PlayerScript
{
public:
    BrandingPostCapXpPlayerScript() : PlayerScript("BrandingPostCapXpPlayerScript") { }

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 /*xpSource*/) override
    {
        if (!player || !g_postCapXpConfig.enabled || !sProficiencyMgr->Config().Enabled())
            return;

        if (amount == 0)
            return;

        // Only redirect once the character has reached the configured server cap. Below it, normal
        // XP must keep levelling the character, so we leave `amount` alone.
        if (player->GetLevel() < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            return;

        ObjectGuid const guid = player->GetGUID();
        uint32 const accountId = player->GetSession()->GetAccountId();

        // Resolve the active brand from the player's selected loadout (§7.9). Only the active school
        // accrues (§14.13.4 serial pacing); dormant schools hold their totals.
        BrandId const activeBrand = sLoadoutMgr->GetLoadout(guid).activeBrand;

        // Knowledge gate (§6): a brand the account cannot earn does not grow. If so, leave the XP as
        // vanilla rather than silently discarding it.
        if (!CanEarnProficiency(activeBrand, sProficiencyMgr->AccountKnowledge(accountId)))
            return;

        uint32 const units = static_cast<uint32>(amount * g_postCapXpConfig.conversionRatio);
        if (units == 0)
            return;

        // The active brand IS the content brand here (the player's own progression), so the match
        // bonus applies; the core handles weighting + diminishing returns from `baseUnits`.
        XpActivity activity;
        activity.source = ActivitySource::Invasion;
        activity.activeBrand = activeBrand;
        activity.contentBrand = activeBrand;
        activity.role = RoleContribution::None;
        activity.baseUnits = units;

        XpResult const result = sProficiencyMgr->ApplyActivity(guid, accountId, activity);

        LOG_DEBUG("module.branding", "Post-cap XP redirect: {} drained {} XP -> brand {} (+{} prof).",
            guid.ToString(), amount, static_cast<uint32>(activeBrand), result.xpGained);

        // Drain the vanilla XP so it becomes Proficiency rather than being wasted at the cap.
        amount = 0;
    }
};

void AddBrandingPostCapXpScripts()
{
    new BrandingPostCapXpWorldScript();
    new BrandingPostCapXpPlayerScript();
}
