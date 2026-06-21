#ifndef MOD_BRANDING_CORE_EFFECTS_EFFECTMODEL_H
#define MOD_BRANDING_CORE_EFFECTS_EFFECTMODEL_H

#include "EffectConfig.h"
#include "common/Brand.h"
#include <cstdint>

namespace Branding
{
    // §7.9: how a brand expresses. Never an always-on flat stat -- windows and transforms.
    enum class EffectKind : uint8_t
    {
        PersonalSpike = 0,      // tank-flavoured survivability spike
        RaidWindow,             // bounded raid burst window
        MechanicTransform       // structural change (overheal->shield, HoT spread, ...)
    };

    // Looked up by (BrandId, RoleContribution); embeds the role for asymmetric scaling.
    struct EffectProfile
    {
        EffectKind kind = EffectKind::RaidWindow;
        RoleContribution role = RoleContribution::None;
        uint32_t windowDurationMs = 0;
        uint32_t cooldownMs = 0;
    };

    // Personal effect magnitude (§7.9): may be large (fantasy), bounded by MaxPersonalMul. Tank
    // profiles yield strictly larger personal magnitude than dps at equal level.
    double PersonalMultiplier(uint8_t profLevel, EffectProfile const& profile, IEffectConfig const& cfg);

    // Raid effect magnitude (§7.9): ALWAYS bounded by MaxRaidMul, never below 1.0, and scaled by the
    // catalyst stacking weight (Slice 4) so it is monotonically non-increasing as same-role
    // specialists stack. `catalystStackWeight` in [0,1] comes from CatalystStackWeight(rank, ...).
    double RaidMultiplier(uint8_t profLevel, EffectProfile const& profile, double catalystStackWeight,
        IEffectConfig const& cfg);

    // §7.9: windowed effects have NO passive uptime -- fraction = window / (window + cooldown) < 1.0.
    double WindowUptimeFraction(EffectProfile const& profile);

    // §11/§7.9 prestige: at max proficiency level (unlocks cosmetic title/aura).
    bool IsPrestige(uint8_t profLevel, IEffectConfig const& cfg);

    // Default effect profile for a (brand, role) pairing (§7.9): Tank -> PersonalSpike (dramatic),
    // Healer -> MechanicTransform (structural), otherwise -> RaidWindow (restrained). Brand-specific
    // profiles are a later refinement; the role drives the kind + window timing for now.
    EffectProfile ProfileFor(BrandId brand, RoleContribution role);

    // Whether a windowed effect is in its active phase at server time `nowMs` (§7.9 "no passive
    // uptime"). PersonalSpike/RaidWindow cycle window-then-cooldown; MechanicTransform is always on.
    bool IsWindowActive(EffectProfile const& profile, uint64_t nowMs);
}

#endif // MOD_BRANDING_CORE_EFFECTS_EFFECTMODEL_H
