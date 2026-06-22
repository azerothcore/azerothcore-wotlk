#include "InvasionScaling.h"
#include <algorithm>
#include <cmath>

namespace Branding
{
    // --- Decayed-peak headcount (§2.5.2) -----------------------------------------------------------

    void CrowdTracker::Sample(uint64_t nowSec, uint32_t instantaneous, IInvasionScalingConfig const& cfg)
    {
        uint64_t const window = cfg.CrowdDecaySeconds();
        // Drop samples that have aged out of the trailing window (kept: at + window >= nowSec).
        std::erase_if(_samples, [&](Sampled const& s) { return s.at + window < nowSec; });
        _samples.push_back(Sampled{nowSec, instantaneous});
    }

    uint32_t CrowdTracker::Effective(uint64_t nowSec, IInvasionScalingConfig const& cfg) const
    {
        uint64_t const window = cfg.CrowdDecaySeconds();
        uint32_t peak = 0;
        for (auto const& s : _samples)
        {
            if (s.at + window >= nowSec)
                peak = std::max(peak, s.count);
        }
        return peak;
    }

    void CrowdTracker::Reset()
    {
        _samples.clear();
    }

    // --- Threshold-gated additive spawn tiers (§2.5.3) ---------------------------------------------

    uint64_t ActiveSpawnTiers(std::span<uint32_t const> thresholds, uint32_t headcount)
    {
        uint64_t mask = 0;
        std::size_t const count = std::min<std::size_t>(thresholds.size(), 64);
        for (std::size_t i = 0; i < count; ++i)
        {
            if (headcount >= thresholds[i])
                mask |= (1ULL << i);
        }
        return mask;
    }

    uint64_t ReconcileSpawnTiers(std::span<uint32_t const> thresholds, uint32_t headcount,
        uint64_t prevActiveMask, IInvasionScalingConfig const& cfg)
    {
        uint32_t const margin = cfg.TierReleaseMargin();
        uint64_t mask = 0;
        std::size_t const count = std::min<std::size_t>(thresholds.size(), 64);
        for (std::size_t i = 0; i < count; ++i)
        {
            bool const wasActive = ((prevActiveMask >> i) & 1ULL) != 0;
            // Off -> on at the threshold; on -> stays until headcount drops a full margin below it.
            // The +margin form keeps the comparison underflow-safe for small thresholds.
            bool const active = wasActive ? (headcount + margin >= thresholds[i])
                                          : (headcount >= thresholds[i]);
            if (active)
                mask |= (1ULL << i);
        }
        return mask;
    }

    uint64_t LiveContainmentGoal(std::span<uint64_t const> goalContributions, uint64_t activeMask)
    {
        uint64_t goal = 0;
        std::size_t const count = std::min<std::size_t>(goalContributions.size(), 64);
        for (std::size_t i = 0; i < count; ++i)
        {
            if (((activeMask >> i) & 1ULL) != 0)
                goal += goalContributions[i];
        }
        return goal;
    }

    // --- Gentle trash difficulty (§2.5.1) ----------------------------------------------------------

    double InvasionTrashMul(uint32_t headcount, IInvasionScalingConfig const& cfg)
    {
        uint8_t const intended = cfg.IntendedInvasionSize();
        if (intended <= 1)
            return cfg.TrashMaxMul();

        // Normalized crowd position in [0, 1]: 0 at a solo straggler, 1 at the intended size.
        uint32_t const clamped = std::clamp<uint32_t>(headcount, 1, intended);
        double const progress = static_cast<double>(clamped - 1) / static_cast<double>(intended - 1);

        // 1.0 baseline rising to TrashMaxMul; exponent >= 1 makes the ramp slow at first.
        double const shaped = std::pow(progress, cfg.TrashExponent());
        return 1.0 + (cfg.TrashMaxMul() - 1.0) * shaped;
    }
}
