#include "EffectMgr.h"
#include "LoadoutMgr.h"
#include "ProficiencyMgr.h"
#include "branding/effects/EffectModel.h"
#include "branding/proficiency/Knowledge.h"
#include "GameTime.h"
#include "Player.h"

namespace Branding
{
    EffectMgr* EffectMgr::instance()
    {
        static EffectMgr mgr;
        return &mgr;
    }

    void EffectMgr::LoadConfig()
    {
        _config.Load();
    }

    double EffectMgr::PersonalMultiplierFor(Player* attacker) const
    {
        if (!_config.Enabled() || !attacker)
            return 1.0;

        ObjectGuid const guid = attacker->GetGUID();
        uint32 const account = attacker->GetSession()->GetAccountId();
        BrandId const brand = sLoadoutMgr->GetLoadout(guid).activeBrand;

        // Anti-P2W (§1/§7.5): inert unless the CURRENT account can express the brand.
        if (!CanExpressBrand(brand, sProficiencyMgr->AccountKnowledge(account)))
            return 1.0;

        // First cut: restrained Damage/RaidWindow personal burst. No passive uptime -- only fires
        // during the active window phase (§7.9).
        EffectProfile const profile = ProfileFor(brand, RoleContribution::Damage);
        if (!IsWindowActive(profile, static_cast<uint64_t>(GameTime::GetGameTimeMS().count())))
            return 1.0;

        return PersonalMultiplier(sProficiencyMgr->BrandLevel(guid, brand), profile, _config);
    }
}
