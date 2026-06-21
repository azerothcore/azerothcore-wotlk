#ifndef MOD_BRANDING_TESTS_FAKES_FAKESCALINGCONFIG_H
#define MOD_BRANDING_TESTS_FAKES_FAKESCALINGCONFIG_H

#include "branding/scaling/ScalingConfig.h"

namespace Branding::Test
{
    // Pinned, tweakable scaling config for deterministic tests.
    class FakeScalingConfig : public IScalingConfig
    {
    public:
        double statScalingExponent = 2.0;
        double groupHealthFloor = 0.3;
        double groupDamageFloor = 0.6;
        uint32_t maxGroupMaterials = 20;
        uint8_t maxRewardTier = 4;
        double rareChanceMulMin = 0.5;
        double rareChanceMulMax = 2.0;

        double StatScalingExponent() const override { return statScalingExponent; }
        double GroupHealthFloor() const override { return groupHealthFloor; }
        double GroupDamageFloor() const override { return groupDamageFloor; }
        uint32_t MaxGroupMaterials() const override { return maxGroupMaterials; }
        uint8_t MaxRewardTier() const override { return maxRewardTier; }
        double RareChanceMulMin() const override { return rareChanceMulMin; }
        double RareChanceMulMax() const override { return rareChanceMulMax; }
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKESCALINGCONFIG_H
