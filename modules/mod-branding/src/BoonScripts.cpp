#include "ProficiencyMgr.h"
#include "ScalingMgr.h"
#include "mod_branding_loader.h"
#include "branding/scaling/GroupScaling.h"
#include "LootMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"

using namespace Branding;

// §2.7 Branding Boon -- Xp and Gold axes (issues #81/#83). The Drop axis lives in DropRateScripts.cpp
// (it hooks the loot roll); this TU applies the other two selectable, raid-wide economy multipliers:
//   - Xp:   multiplies awarded XP while LEVELLING. It deliberately does NOT touch XP at the server cap
//           -- that XP is redirected into Proficiency by PostCapXpScripts (§14.13.3), and amplifying it
//           would create a rank -> bigger-boon -> faster-rank feedback loop (spec §2.7.3).
//   - Gold: multiplies EARNED loot coin only (OnPlayerBeforeLootMoney). Money from vendors, trades,
//           mail and the AH is untouched -- multiplying those would be a gold-duplication exploit.
class BrandingBoonPlayerScript : public PlayerScript
{
public:
    BrandingBoonPlayerScript() : PlayerScript("BrandingBoonPlayerScript") { }

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 /*xpSource*/) override
    {
        if (!player || amount == 0 || !sScalingMgr->BoonEnabled())
            return;

        // Post-cap-safe: below the cap this is levelling XP (multiply it); at/above the cap the
        // PostCapXp adapter redirects the XP into Proficiency, so leave it exactly as produced.
        if (player->GetLevel() >= sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            return;

        double const mul = sScalingMgr->BoonMultiplier(player, BoonAxis::Xp);
        if (mul > 1.0)
            amount = static_cast<uint32>(amount * mul);
    }

    void OnPlayerBeforeLootMoney(Player* player, Loot* loot) override
    {
        if (!player || !loot || loot->gold == 0 || !sScalingMgr->BoonEnabled())
            return;

        double const mul = sScalingMgr->BoonMultiplier(player, BoonAxis::Gold);
        if (mul > 1.0)
            loot->gold = static_cast<uint32>(loot->gold * mul);
    }
};

void AddBrandingBoonScripts()
{
    new BrandingBoonPlayerScript();
}
