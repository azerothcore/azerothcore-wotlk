#include "GroupScaling.h"
#include <algorithm>
#include <cmath>
#include <functional>
#include <vector>

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

    namespace
    {
        // Per-axis multiplier cap. `None` has no bonus. Floored at 1.0 by the caller.
        double BoonAxisCap(BoonAxis axis, IScalingConfig const& cfg)
        {
            switch (axis)
            {
                case BoonAxis::Xp:   return cfg.BoonXpCap();
                case BoonAxis::Drop: return cfg.BoonDropCap();
                case BoonAxis::Gold: return cfg.BoonGoldCap();
                case BoonAxis::None:
                default:             return 1.0;
            }
        }
    }

    double BoonAxisMultiplier(BoonAxis axis, uint8_t const* ranks, std::size_t count,
                              IScalingConfig const& cfg)
    {
        if (axis == BoonAxis::None || ranks == nullptr || count == 0)
            return 1.0;

        // Floor the cap at 1.0: a misconfigured cap below 1.0 must not flip the bonus into a penalty
        // (and std::clamp with lo > hi is undefined behavior). Keeps the "never a penalty" invariant.
        double const cap = std::max(1.0, BoonAxisCap(axis, cfg));
        double const decay = std::clamp(cfg.BoonStackDecay(), 0.0, 1.0);
        double const maxRank = static_cast<double>(std::max<uint8_t>(1, cfg.BoonMaxRank()));

        // Per-selector proficiency strength in [0, 1]; a rank-0 (or non-loaded) member contributes 0.
        // This runs per dropped loot item (OnItemRoll), so avoid a heap allocation: a stack buffer
        // covers every real roster (WoW raids cap at 40); an implausibly larger caller falls back to
        // the heap for correctness. Sorting descending makes the result order-independent and
        // monotonic in any single rank -- best selector carries full weight, each subsequent one is
        // DR'd by decay^(position) (§7.9).
        constexpr std::size_t kStackSelectors = 40;
        double stackBuf[kStackSelectors];
        std::vector<double> heapBuf;
        double* strengths = stackBuf;
        if (count > kStackSelectors)
        {
            heapBuf.resize(count);
            strengths = heapBuf.data();
        }

        for (std::size_t i = 0; i < count; ++i)
            strengths[i] = std::clamp(static_cast<double>(ranks[i]) / maxRank, 0.0, 1.0);

        std::sort(strengths, strengths + count, std::greater<double>());

        double acc = 0.0;
        double weight = 1.0;
        for (std::size_t i = 0; i < count; ++i)
        {
            acc += strengths[i] * weight;
            weight *= decay;
        }

        double const mul = 1.0 + (cap - 1.0) * acc;
        return std::clamp(mul, 1.0, cap);
    }
}
