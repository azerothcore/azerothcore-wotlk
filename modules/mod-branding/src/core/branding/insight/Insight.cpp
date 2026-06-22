#include "Insight.h"
#include <algorithm>
#include <cmath>

namespace Branding
{
    bool RankIsWindowed(SourceRank rank)
    {
        // RaidBoss is throttled by its weekly lockout, not by the rolling DR window (design §14.13.1).
        return rank != SourceRank::RaidBoss;
    }

    double InsightForKill(SourceRank rank, uint32_t priorThisWindowAccountWide, IInsightConfig const& cfg)
    {
        double const base = std::max(0.0, cfg.BaseInsight(rank));

        // Raid bosses ignore prior kills (no intra-week DR). Windowed ranks apply a geometric
        // diminishing-returns factor per prior kill: yield = base * factor^prior. With factor in
        // [0, 1] this is non-increasing in priorThisWindowAccountWide and bounded >= 0.
        if (!RankIsWindowed(rank))
            return base;

        double const factor = std::clamp(cfg.DrFactor(rank), 0.0, 1.0);
        double const yield = base * std::pow(factor, static_cast<double>(priorThisWindowAccountWide));
        return std::max(0.0, yield);
    }

    bool UnlockReached(double points, IInsightConfig const& cfg)
    {
        return points >= cfg.UnlockThreshold();
    }

    double EarnInsight(InsightState& state, SourceRank rank, IInsightConfig const& cfg, IClock const& clock)
    {
        uint64_t const now = clock.NowUnix();

        // Roll the account-wide DR window forward if it has fully decayed since it started (mirrors
        // the §7.4 BrandXp window). Clock-skew guard: never treat a backwards clock as elapsed.
        if (state.windowStartUnix == 0
            || (now >= state.windowStartUnix && now - state.windowStartUnix >= cfg.WindowSeconds()))
        {
            state.windowUnits = 0;
            state.windowStartUnix = now;
        }

        double const granted = InsightForKill(rank, state.windowUnits, cfg);
        state.points += granted;

        // Only windowed ranks advance the DR counter; raid bosses leave the window untouched.
        if (RankIsWindowed(rank))
            ++state.windowUnits;

        return granted;
    }
}
