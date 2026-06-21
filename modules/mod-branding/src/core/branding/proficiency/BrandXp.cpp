#include "BrandXp.h"
#include "Knowledge.h"
#include "Proficiency.h"
#include <algorithm>
#include <cmath>

namespace Branding
{
    namespace
    {
        // The recent-window value after time-based decay. Returns 0 once the window has elapsed,
        // so XP is fully restored after cfg.DrWindowSeconds() (design §7.4).
        uint32_t EffectiveWindow(ProficiencyState const& state, IClock const& clock, IBrandingConfig const& cfg)
        {
            if (state.windowStartUnix == 0)
                return 0;

            uint64_t const now = clock.NowUnix();
            if (now < state.windowStartUnix)
                return state.recentXpWindow;        // clock-skew guard

            if (now - state.windowStartUnix >= cfg.DrWindowSeconds())
                return 0;

            return state.recentXpWindow;
        }

        // Diminishing-returns multiplier: 1.0 until the soft cap, then a linear decay toward the
        // floor. Bounded in [DrFloor, 1.0] (design §7.4 / §7.5 invariant).
        double DrMultiplier(uint32_t effectiveWindow, IBrandingConfig const& cfg)
        {
            if (effectiveWindow <= cfg.DrSoftCap())
                return 1.0;

            double const over = static_cast<double>(effectiveWindow - cfg.DrSoftCap());
            double const multiplier = 1.0 - over * cfg.DrSlope();
            return std::max(cfg.DrFloor(), multiplier);
        }
    }

    uint32_t ComputeXpGain(XpActivity const& activity, ProficiencyState const& state,
        IBrandingConfig const& cfg, IClock const& clock)
    {
        double value = static_cast<double>(activity.baseUnits) * cfg.SourceWeight(activity.source);
        value *= cfg.RelevanceMul(activity.source);

        if (activity.activeBrand == activity.contentBrand)
            value *= cfg.MatchBonus();

        value *= cfg.RoleMul(activity.role);
        value *= DrMultiplier(EffectiveWindow(state, clock, cfg), cfg);

        if (value <= 0.0)
            return 0;

        return static_cast<uint32_t>(std::llround(value));
    }

    XpResult ApplyActivity(ProficiencyState& state, XpActivity const& activity,
        KnowledgeState const& knowledge, IBrandingConfig const& cfg, IClock const& clock)
    {
        XpResult result;
        result.levelBefore = LevelForXp(state.totalXp, cfg);
        result.levelAfter = result.levelBefore;

        // Knowledge gate (§7.5): locked brand earns nothing and leaves state untouched.
        if (!CanEarnProficiency(activity.activeBrand, knowledge))
            return result;

        // Roll the DR window forward if it has fully decayed since it started.
        uint64_t const now = clock.NowUnix();
        if (state.windowStartUnix == 0 || now - state.windowStartUnix >= cfg.DrWindowSeconds())
        {
            state.recentXpWindow = 0;
            state.windowStartUnix = now;
        }

        uint32_t const gain = ComputeXpGain(activity, state, cfg, clock);
        state.totalXp += gain;
        state.recentXpWindow += gain;

        result.xpGained = gain;
        result.levelAfter = LevelForXp(state.totalXp, cfg);
        result.reachedPrestige = result.levelAfter >= cfg.MaxLevel() && result.levelBefore < cfg.MaxLevel();
        return result;
    }
}
