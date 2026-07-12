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
        double currencyReductionExponent = 2.0;
        double currencyMulFloor = 0.05;
        double boonDropCap = 1.5;
        double boonXpCap = 1.5;
        double boonGoldCap = 1.5;
        double boonStackDecay = 0.4;
        uint8_t boonMaxRank = 50;

        double StatScalingExponent() const override { return statScalingExponent; }
        double GroupHealthFloor() const override { return groupHealthFloor; }
        double GroupDamageFloor() const override { return groupDamageFloor; }
        uint32_t MaxGroupMaterials() const override { return maxGroupMaterials; }
        uint8_t MaxRewardTier() const override { return maxRewardTier; }
        double RareChanceMulMin() const override { return rareChanceMulMin; }
        double RareChanceMulMax() const override { return rareChanceMulMax; }
        double CurrencyReductionExponent() const override { return currencyReductionExponent; }
        double CurrencyMulFloor() const override { return currencyMulFloor; }
        double BoonDropCap() const override { return boonDropCap; }
        double BoonXpCap() const override { return boonXpCap; }
        double BoonGoldCap() const override { return boonGoldCap; }
        double BoonStackDecay() const override { return boonStackDecay; }
        uint8_t BoonMaxRank() const override { return boonMaxRank; }
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKESCALINGCONFIG_H
