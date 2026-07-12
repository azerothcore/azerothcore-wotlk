#ifndef MOD_BRANDING_SRC_SCALINGCONFIG_H
#define MOD_BRANDING_SRC_SCALINGCONFIG_H

#include "branding/scaling/ScalingConfig.h"
#include <cstdint>

namespace Branding
{
    // Production IScalingConfig over sConfigMgr. Implements both the player-downscaling dial used by
    // the combat adapter and the group-scaling dials (reserved for a future group-scaling adapter).
    class ScalingConfig : public IScalingConfig
    {
    public:
        void Load();
        bool Enabled() const { return _enabled; }

        // §2.7 branding-rank drop bonus (issue #81): toggled independently of the §2.1 downscaling.
        bool RankDropBonusEnabled() const { return _rankDropBonusEnabled; }

        double StatScalingExponent() const override { return _exponent; }
        double GroupHealthFloor() const override { return _groupHealthFloor; }
        double GroupDamageFloor() const override { return _groupDamageFloor; }
        uint32_t MaxGroupMaterials() const override { return _maxGroupMaterials; }
        uint8_t MaxRewardTier() const override { return _maxRewardTier; }
        double RareChanceMulMin() const override { return _rareChanceMulMin; }
        double RareChanceMulMax() const override { return _rareChanceMulMax; }
        double CurrencyReductionExponent() const override { return _currencyReductionExponent; }
        double CurrencyMulFloor() const override { return _currencyMulFloor; }
        double RankDropBonusPerRank() const override { return _rankDropBonusPerRank; }
        double RankDropMulCap() const override { return _rankDropMulCap; }

    private:
        bool _enabled = false;
        double _exponent = 2.0;
        double _groupHealthFloor = 0.3;
        double _groupDamageFloor = 0.6;
        uint32_t _maxGroupMaterials = 20;
        uint8_t _maxRewardTier = 4;
        double _rareChanceMulMin = 0.5;
        double _rareChanceMulMax = 2.0;
        double _currencyReductionExponent = 2.0;
        double _currencyMulFloor = 0.05;
        bool _rankDropBonusEnabled = false;
        double _rankDropBonusPerRank = 0.01;
        double _rankDropMulCap = 1.5;
    };
}

#endif // MOD_BRANDING_SRC_SCALINGCONFIG_H
