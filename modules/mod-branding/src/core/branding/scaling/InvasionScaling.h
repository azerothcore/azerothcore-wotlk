#ifndef MOD_BRANDING_CORE_SCALING_INVASIONSCALING_H
#define MOD_BRANDING_CORE_SCALING_INVASIONSCALING_H

#include "InvasionScalingConfig.h"
#include <cstdint>
#include <span>
#include <vector>

namespace Branding
{
    // §2.5 invasion crowd scaling -- pure, deterministic, no AzerothCore deps and no RNG.
    //
    // Three independent pieces: a decayed-peak headcount tracker, the threshold-gated additive
    // spawn-tier reconciler (+ its containment goal), and the gentle trash difficulty curve. The
    // BOSS difficulty lever is the §2.2 GroupScaling core reused with headcount as the group size
    // (small crowd => easier boss); only the trash lever is invasion-specific.

    // --- Decayed-peak headcount (§2.5.2) -----------------------------------------------------------
    // Feed periodic instantaneous samples; Effective() returns the high-water mark over the trailing
    // CrowdDecaySeconds window relative to `nowSec`. Resets when the event ends.
    class CrowdTracker
    {
    public:
        void Sample(uint64_t nowSec, uint32_t instantaneous, IInvasionScalingConfig const& cfg);
        uint32_t Effective(uint64_t nowSec, IInvasionScalingConfig const& cfg) const;
        void Reset();

    private:
        struct Sampled
        {
            uint64_t at = 0;
            uint32_t count = 0;
        };

        std::vector<Sampled> _samples;
    };

    // --- Threshold-gated additive spawn tiers (§2.5.3) ---------------------------------------------
    // Tiers identified by bit index into the returned mask (bit i <=> thresholds[i]). At most 64
    // tiers (far above any authored invasion). A tier is active when headcount >= its threshold;
    // membership is order-independent and monotonic (more headcount => superset mask).
    uint64_t ActiveSpawnTiers(std::span<uint32_t const> thresholds, uint32_t headcount);

    // Hysteresis-aware reconcile: a tier already active stays active until headcount drops a full
    // TierReleaseMargin below its threshold; an inactive tier turns on at headcount >= threshold.
    uint64_t ReconcileSpawnTiers(std::span<uint32_t const> thresholds, uint32_t headcount,
        uint64_t prevActiveMask, IInvasionScalingConfig const& cfg);

    inline bool TierActive(uint64_t mask, std::size_t tier)
    {
        return tier < 64 && ((mask >> tier) & 1ULL) != 0;
    }

    // Live containment goal (§2.5.4): sum of the per-tier goal contributions for the active tiers, so
    // the crowd that summons a wave must also clear it.
    uint64_t LiveContainmentGoal(std::span<uint64_t const> goalContributions, uint64_t activeMask);

    // --- Gentle trash difficulty (§2.5.1) ----------------------------------------------------------
    // Outgoing/health multiplier for invasion TRASH: 1.0 at a solo straggler (authored baseline,
    // always completable), rising via TrashExponent to TrashMaxMul at IntendedInvasionSize. Crowd
    // beyond the intended size is clamped (no further hardening).
    double InvasionTrashMul(uint32_t headcount, IInvasionScalingConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_SCALING_INVASIONSCALING_H
