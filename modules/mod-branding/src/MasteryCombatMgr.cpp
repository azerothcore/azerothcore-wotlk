#include "MasteryCombatMgr.h"

#include "MasteryConfig.h"
#include "MasteryLoadoutMgr.h"
#include "ProficiencyMgr.h"
#include "branding/effects/EffectModel.h"
#include "branding/mastery/MasteryActive.h"
#include "branding/proficiency/Knowledge.h"

#include "GameTime.h"
#include "Player.h"

namespace Branding
{
    namespace
    {
        // Best-effort role lens for the §7.9 personal asymmetry (tank dramatic, dps restrained). The
        // pure plan only consumes RoleContribution; this stays a coarse heuristic (the proper per-spec
        // role detection is the §14.11 talent-spec seam, deferred). Default Damage when unsure.
        RoleContribution DetectRole(Player* player)
        {
            if (!player)
                return RoleContribution::Damage;

            switch (player->getClass())
            {
                case CLASS_WARRIOR:
                case CLASS_DEATH_KNIGHT:
                    return RoleContribution::Tank;     // coarse: most likely the survivability fantasy
                case CLASS_PRIEST:
                case CLASS_DRUID:
                case CLASS_PALADIN:
                case CLASS_SHAMAN:
                    return RoleContribution::Healer;   // hybrid healers -> transform expression
                default:
                    return RoleContribution::Damage;
            }
        }
    }

    MasteryCombatMgr* MasteryCombatMgr::instance()
    {
        static MasteryCombatMgr mgr;
        return &mgr;
    }

    void MasteryCombatMgr::LoadConfig()
    {
        // The tree envelope + §14.10/§14.11 loadout dials are owned by MasteryLoadoutMgr (the shared
        // MasteryConfig that implements IMasteryTreeConfig + IMasteryLoadoutConfig); the combat layer
        // rides on the same load + enable switch. The §7.9 magnitude caps and the catalyst DR decay are
        // separate config domains, so this manager owns its own IEffectConfig + ICatalystConfig.
        sMasteryLoadoutMgr->LoadConfig();
        _effectConfig.Load();
        _catalystConfig.Load();
    }

    bool MasteryCombatMgr::Enabled() const
    {
        return sMasteryLoadoutMgr->Enabled();
    }

    MasterySchoolState MasteryCombatMgr::SchoolStateFor(ObjectGuid guid, uint32_t accountId) const
    {
        MasterySchoolState state;
        for (uint8_t b = 0; b < static_cast<uint8_t>(BrandId::COUNT); ++b)
        {
            BrandId const school = static_cast<BrandId>(b);
            // EARNED = per-school proficiency level (shared across specs, §14.11) AND account Brand
            // Knowledge (anti-P2W use-time gate, evaluated against the CURRENT account, §7.5).
            state.level[b] = sProficiencyMgr->BrandLevel(guid, school);
            state.unlocked[b] = sProficiencyMgr->IsBrandKnown(accountId, school);
        }
        return state;
    }

    std::size_t MasteryCombatMgr::OwnRoster(ActiveMasterySet const& set, CatalystKey* out, std::size_t cap)
    {
        std::size_t n = 0;
        for (uint8_t i = 0; i < set.Count() && n < cap; ++i)
            out[n++] = CatalystKey{ set.entries[i].school, set.entries[i].tree };
        return n;
    }

    MasteryPlan MasteryCombatMgr::BuildPlan(Player* player) const
    {
        if (!Enabled() || !player)
            return MasteryPlan{};

        ObjectGuid const guid = player->GetGUID();
        uint32_t const accountId = player->GetSession()->GetAccountId();

        ActiveMasterySet const& set = sMasteryLoadoutMgr->ActiveLoadout(guid);
        if (set.Count() == 0)
            return MasteryPlan{};

        MasterySchoolState const state = SchoolStateFor(guid, accountId);
        MasteryConfig const& cfg = sMasteryLoadoutMgr->Config();

        // §14.12 raid-roster seam: v1 passes the player's OWN active cells. A later task replaces this
        // with the surrounding raid's running cells so cross-player catalyst DR applies; the signature
        // does not change. The own-set is always counted, so same-cell stacking still sees DR.
        CatalystKey roster[ActiveMasterySet::Capacity];
        std::size_t const rosterCount = OwnRoster(set, roster, ActiveMasterySet::Capacity);

        return BuildMasteryPlan(set, state, DetectRole(player), roster, rosterCount,
            cfg, cfg, _effectConfig, _catalystConfig);
    }

    double MasteryCombatMgr::OutgoingMultiplierFor(Player* player) const
    {
        MasteryPlan const plan = BuildPlan(player);
        if (plan.count == 0)
            return 1.0;

        uint64_t const nowMs = static_cast<uint64_t>(GameTime::GetGameTimeMS().count());

        // Aggregate the active cells' magnitudes onto outgoing damage. Sustained Support utilities are
        // always on; windowed Off/personal cells only contribute during their active window phase
        // (§7.9 "no passive uptime"). The plan already bounded each magnitude to the §7.9 caps + DR.
        double multiplier = 1.0;
        for (uint8_t i = 0; i < plan.count; ++i)
        {
            ResolvedMasteryEffect const& eff = plan.effects[i];
            if (eff.def.sustained || IsCellWindowActive(eff, nowMs))
                multiplier *= eff.magnitude;
        }

        // Final clamp to the §7.9 personal fantasy ceiling so stacked cells can never exceed the cap.
        double const cap = _effectConfig.MaxPersonalMul();
        return cap >= 1.0 && multiplier > cap ? cap : multiplier;
    }

    bool MasteryCombatMgr::IsCellWindowActive(ResolvedMasteryEffect const& eff, uint64_t nowMs)
    {
        // Reconstruct the windowed cadence from the resolved window + the plan's uptime fraction:
        // uptime = window / (window + cooldown) => cooldown = window * (1 - uptime) / uptime.
        if (eff.resolved.windowDurationMs == 0 || eff.uptimeFraction <= 0.0 || eff.uptimeFraction >= 1.0)
            return true;   // degenerate -> treat as always-on (no spurious gating)

        double const window = static_cast<double>(eff.resolved.windowDurationMs);
        uint32_t const cooldown = static_cast<uint32_t>(window * (1.0 - eff.uptimeFraction) / eff.uptimeFraction);
        EffectProfile const profile{ eff.def.kind, RoleContribution::Damage,
            eff.resolved.windowDurationMs, cooldown };
        return IsWindowActive(profile, nowMs);
    }
}
