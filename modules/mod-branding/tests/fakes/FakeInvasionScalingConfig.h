#ifndef MOD_BRANDING_TESTS_FAKES_FAKEINVASIONSCALINGCONFIG_H
#define MOD_BRANDING_TESTS_FAKES_FAKEINVASIONSCALINGCONFIG_H

#include "branding/scaling/InvasionScalingConfig.h"

namespace Branding::Test
{
    // Pinned, tweakable invasion-scaling config for deterministic tests.
    class FakeInvasionScalingConfig : public IInvasionScalingConfig
    {
    public:
        uint8_t intendedInvasionSize = 40;
        uint64_t crowdDecaySeconds = 60;
        double trashMaxMul = 1.5;
        double trashExponent = 2.0;
        uint32_t tierReleaseMargin = 3;

        uint8_t IntendedInvasionSize() const override { return intendedInvasionSize; }
        uint64_t CrowdDecaySeconds() const override { return crowdDecaySeconds; }
        double TrashMaxMul() const override { return trashMaxMul; }
        double TrashExponent() const override { return trashExponent; }
        uint32_t TierReleaseMargin() const override { return tierReleaseMargin; }
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKEINVASIONSCALINGCONFIG_H
