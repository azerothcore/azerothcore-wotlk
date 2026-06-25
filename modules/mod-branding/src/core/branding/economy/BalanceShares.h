#ifndef MOD_BRANDING_CORE_ECONOMY_BALANCESHARES_H
#define MOD_BRANDING_CORE_ECONOMY_BALANCESHARES_H

#include <array>
#include <cstddef>
#include <cstdint>

namespace Branding
{
    // The four XP sources the §8.5 anti-obsolescence invariant balances. There is deliberately no
    // separate "Events" bucket: invasion-containment XP is quest-equivalent (§10.1, quest-rate) and
    // folds into Questing, while §9.2 contribution points feed the event economy, not this mix.
    enum class XpSource : uint8_t
    {
        Questing,
        Professions,
        Exploration,
        Discoveries,
        COUNT
    };

    // Per-source accumulated XP (post-rate, §10.1). Built by the sim/adapter; pure aggregation input.
    struct SourceTotals
    {
        std::array<uint64_t, static_cast<size_t>(XpSource::COUNT)> xp{};

        void Add(XpSource source, uint64_t amount);
        uint64_t Get(XpSource source) const;
        uint64_t Total() const;
    };

    // Normalized shares: each in [0, 1], summing to 1.0 when Total() > 0; all zero for empty totals.
    // §8.5 target: Questing 0.45, Professions 0.25, Exploration 0.20, Discoveries 0.10, Questing largest.
    struct BalanceShares
    {
        std::array<double, static_cast<size_t>(XpSource::COUNT)> share{};

        double Share(XpSource source) const;
        // Source with the greatest share; ties resolve to the lowest-ordinal source (deterministic).
        XpSource Largest() const;
    };

    // Pure: per-source totals -> normalized shares. Empty totals yield all-zero shares (no div-by-zero).
    BalanceShares ComputeShares(SourceTotals const& totals);
}

#endif // MOD_BRANDING_CORE_ECONOMY_BALANCESHARES_H
