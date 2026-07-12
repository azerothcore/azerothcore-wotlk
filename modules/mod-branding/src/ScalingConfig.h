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

        // §2.7 Branding Boon (issues #81, #83): toggled independently of the §2.1 downscaling.
        bool BoonEnabled() const { return _boonEnabled; }

        // Copper charged to CHANGE an already-chosen boon axis (the first pick from None is free).
        // Deliberately expensive so the choice is an identity commitment, not a per-pull swap (#83).
        uint32_t BoonReselectCost() const { return _boonReselectCost; }

        double StatScalingExponent() const override { return _exponent; }
        double GroupHealthFloor() const override { return _groupHealthFloor; }
        double GroupDamageFloor() const override { return _groupDamageFloor; }
        uint32_t MaxGroupMaterials() const override { return _maxGroupMaterials; }
        uint8_t MaxRewardTier() const override { return _maxRewardTier; }
        double RareChanceMulMin() const override { return _rareChanceMulMin; }
        double RareChanceMulMax() const override { return _rareChanceMulMax; }
        double CurrencyReductionExponent() const override { return _currencyReductionExponent; }
        double CurrencyMulFloor() const override { return _currencyMulFloor; }
        double BoonDropCap() const override { return _boonDropCap; }
        double BoonXpCap() const override { return _boonXpCap; }
        double BoonGoldCap() const override { return _boonGoldCap; }
        double BoonStackDecay() const override { return _boonStackDecay; }
        uint8_t BoonMaxRank() const override { return _boonMaxRank; }

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
        bool _boonEnabled = false;
        uint32_t _boonReselectCost = 1000000;   // 100g default -- "very expensive to re-select" (#83)
        double _boonDropCap = 1.5;
        double _boonXpCap = 1.5;
        double _boonGoldCap = 1.5;
        double _boonStackDecay = 0.4;
        uint8_t _boonMaxRank = 50;
    };
}

#endif // MOD_BRANDING_SRC_SCALINGCONFIG_H
