#ifndef MOD_BRANDING_CORE_EFFECTS_EFFECTCONFIG_H
#define MOD_BRANDING_CORE_EFFECTS_EFFECTCONFIG_H

#include "branding/common/Brand.h"
#include <cstdint>

namespace Branding
{
    // Injected tunables for the branding effect model (§7.9). The caps are the legendary-vs-mandatory
    // dials: large personal (fantasy), bounded raid (desirability, not mandate).
    class IEffectConfig
    {
    public:
        virtual ~IEffectConfig() = default;

        virtual double MaxPersonalMul() const = 0;   // large, e.g. 3.0-4.0 (felt by the player)
        virtual double MaxRaidMul() const = 0;       // bounded, e.g. 2.0 (granted to the raid)
        virtual uint8_t MaxEffectLevel() const = 0;  // proficiency level that yields full strength

        // Healer MechanicTransform (§7.9 #3): hard cap on the overheal->shield grant, as a fraction of
        // the target's max health. Anti-degenerate -- a single transform can never snowball. In [0, 1].
        virtual double MaxOverhealShieldFraction() const = 0;

        // Role asymmetry (§7.9): tank effects are dramatic, dps restrained. In (0, 1], tank highest.
        virtual double RolePersonalScale(RoleContribution role) const = 0;

        // §7.11 leveling-scoped branding (issue #77). A separate, account-keyed budget for sub-max
        // characters in dungeons/invasions; independent of the §7.9 proficiency caps above.
        virtual bool LevelingEnabled() const = 0;         // master switch for the whole behaviour
        virtual double MaxLevelingMul() const = 0;        // its own cap, distinct from Max{Personal,Raid}Mul
        virtual double LevelingStandingScale() const = 0; // per-maxed-brand contribution (mild)
        virtual uint8_t MaxCharacterLevel() const = 0;    // the ding-to-cap boundary (e.g. 80)
        virtual bool LevelingGrantsTransforms() const = 0;// grant §7.9 MechanicTransforms while leveling
    };
}

#endif // MOD_BRANDING_CORE_EFFECTS_EFFECTCONFIG_H
