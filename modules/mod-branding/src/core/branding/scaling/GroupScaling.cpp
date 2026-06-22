#include "GroupScaling.h"
#include <algorithm>
#include <cmath>

namespace Branding
{
    namespace
    {
        // Normalized position of the group within [1, contentSize]: 0 at a solo, 1 at full content.
        double Progress(GroupContext const& group)
        {
            if (group.contentSize <= 1)
                return 1.0;

            uint8_t const clamped = std::clamp<uint8_t>(group.groupSize, 1, group.contentSize);
            return static_cast<double>(clamped - 1) / static_cast<double>(group.contentSize - 1);
        }

        double Lerp(double floor, double ceil, double t)
        {
            return floor + (ceil - floor) * t;
        }
    }

    double EncounterHealthMul(GroupContext const& group, IScalingConfig const& cfg)
    {
        return Lerp(cfg.GroupHealthFloor(), 1.0, Progress(group));
    }

    double EncounterDamageMul(GroupContext const& group, IScalingConfig const& cfg)
    {
        return Lerp(cfg.GroupDamageFloor(), 1.0, Progress(group));
    }

    RewardScale RewardScaleForGroup(GroupContext const& group, IScalingConfig const& cfg)
    {
        uint8_t const content = std::max<uint8_t>(group.contentSize, 1);
        uint8_t const clamped = std::clamp<uint8_t>(group.groupSize, 1, content);
        double const fraction = static_cast<double>(clamped) / static_cast<double>(content);

        RewardScale reward;
        // Floor of 1 keeps the smallest group beatable-rewarding; totals scale up to the full caps.
        reward.materialQuantity = std::max<uint32_t>(1, static_cast<uint32_t>(cfg.MaxGroupMaterials() * fraction + 0.5));
        reward.maxTier = std::max<uint8_t>(1, static_cast<uint8_t>(cfg.MaxRewardTier() * fraction + 0.5));
        reward.rareChanceMul = Lerp(cfg.RareChanceMulMin(), cfg.RareChanceMulMax(), Progress(group));

        // Currency falls off steeper than gear: fraction^exp (exp >= 1), floored so a small group is
        // never zeroed out but a trivialised clear is no farm (§2.4.3).
        double const currency = std::pow(fraction, cfg.CurrencyReductionExponent());
        reward.currencyMul = std::clamp(currency, cfg.CurrencyMulFloor(), 1.0);
        return reward;
    }
}
