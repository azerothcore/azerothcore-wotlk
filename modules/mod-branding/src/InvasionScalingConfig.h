#ifndef MOD_BRANDING_SRC_INVASIONSCALINGCONFIG_H
#define MOD_BRANDING_SRC_INVASIONSCALINGCONFIG_H

#include "branding/scaling/InvasionScalingConfig.h"
#include <cstdint>

namespace Branding
{
    // Production IInvasionScalingConfig over sConfigMgr (§2.5). Carries the invasion-specific dials;
    // the boss difficulty lever reuses the §2.2 ScalingConfig. `Enabled()` gates the creature-stat
    // hook (the spawn-count lever is gated by the scheduler + an active invasion).
    class InvasionScalingConfig : public IInvasionScalingConfig
    {
    public:
        void Load();
        bool Enabled() const { return _enabled; }

        uint8_t IntendedInvasionSize() const override { return _intendedSize; }
        uint64_t CrowdDecaySeconds() const override { return _decaySeconds; }
        double TrashMaxMul() const override { return _trashMaxMul; }
        double TrashExponent() const override { return _trashExponent; }
        uint32_t TierReleaseMargin() const override { return _tierReleaseMargin; }

    private:
        bool _enabled = false;
        uint8_t _intendedSize = 40;
        uint64_t _decaySeconds = 60;
        double _trashMaxMul = 1.5;
        double _trashExponent = 2.0;
        uint32_t _tierReleaseMargin = 3;
    };
}

#endif // MOD_BRANDING_SRC_INVASIONSCALINGCONFIG_H
