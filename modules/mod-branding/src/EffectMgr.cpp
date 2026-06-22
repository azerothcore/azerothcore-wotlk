#include "EffectMgr.h"
#include "BrandRole.h"
#include "LoadoutMgr.h"
#include "ProficiencyMgr.h"
#include "branding/proficiency/Knowledge.h"
#include "Configuration/Config.h"
#include "GameTime.h"
#include "Player.h"

namespace Branding
{
    namespace
    {
        uint64_t NowMs()
        {
            return static_cast<uint64_t>(GameTime::GetGameTimeMS().count());
        }
    }

    EffectMgr* EffectMgr::instance()
    {
        static EffectMgr mgr;
        return &mgr;
    }

    void EffectMgr::LoadConfig()
    {
        _config.Load();
        // The absorb costume for the overheal transform. Default Power Word: Shield (48066); a clean
        // basepoint-driven SCHOOL_ABSORB id can be substituted via config (see #30 spell-costume work).
        _overhealShieldSpell = sConfigMgr->GetOption<uint32>("Branding.Effect.OverhealShieldSpell", 48066);
    }

    bool EffectMgr::Resolve(Player* player, EffectProfile& profile, uint8_t& level) const
    {
        if (!_config.Enabled() || !player)
            return false;

        ObjectGuid const guid = player->GetGUID();
        uint32 const account = player->GetSession()->GetAccountId();
        BrandId const brand = sLoadoutMgr->GetLoadout(guid).activeBrand;

        // Anti-P2W (§1/§7.5): inert unless the CURRENT account can express the brand.
        if (!CanExpressBrand(brand, sProficiencyMgr->AccountKnowledge(account)))
            return false;

        profile = ProfileFor(brand, DetectRole(player));
        level = sProficiencyMgr->BrandLevel(guid, brand);
        return true;
    }

    double EffectMgr::OutgoingMultiplierFor(Player* attacker) const
    {
        EffectProfile profile;
        uint8_t level = 0;
        if (!Resolve(attacker, profile, level))
            return 1.0;

        // v1 catalyst stack weight = 1.0 (full); the cross-raid roster weight is the issue #04 seam.
        return WindowedOutgoingMultiplier(profile, level, 1.0, NowMs(), _config);
    }

    double EffectMgr::IncomingDamageMultiplierFor(Player* victim) const
    {
        EffectProfile profile;
        uint8_t level = 0;
        if (!Resolve(victim, profile, level))
            return 1.0;

        return WindowedIncomingMultiplier(profile, level, NowMs(), _config);
    }

    uint32_t EffectMgr::OverhealShieldFor(Player* healer, Unit* target, uint32_t heal) const
    {
        EffectProfile profile;
        uint8_t level = 0;
        if (!target || !Resolve(healer, profile, level))
            return 0;

        // Only the healer MechanicTransform expresses as a shield (structural, always-on by kind).
        if (profile.kind != EffectKind::MechanicTransform)
            return 0;

        uint32 const maxHealth = target->GetMaxHealth();
        uint32 const curHealth = target->GetHealth();
        uint32 const missing = maxHealth > curHealth ? maxHealth - curHealth : 0u;
        return OverhealShieldAmount(heal, missing, maxHealth, level, _config);
    }

    bool EffectMgr::ResolveActiveProfile(Player* player, EffectProfile& profile, uint8_t& level) const
    {
        return Resolve(player, profile, level);
    }
}
