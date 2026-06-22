#ifndef MOD_BRANDING_CORE_SCALING_HEROICCONFIG_H
#define MOD_BRANDING_CORE_SCALING_HEROICCONFIG_H

#include <cstdint>

namespace Branding
{
    // Injected tunables for the heroic overlay (§2.4). Pure core reads no globals; production wraps
    // sConfigMgr, tests inject a pinned fake.
    class IHeroicConfig
    {
    public:
        virtual ~IHeroicConfig() = default;

        // Encounter multipliers applied ON TOP of §2.2 group scaling when the overlay engages
        // (heroic selected on a map without native heroic). Both >= 1.0.
        virtual double HeroicHealthMul() const = 0;
        virtual double HeroicDamageMul() const = 0;

        // Reward-tier bump added to the §2.2/§9.4 reward tier when the run is heroic.
        virtual uint8_t HeroicTierBonus() const = 0;
    };
}

#endif // MOD_BRANDING_CORE_SCALING_HEROICCONFIG_H
