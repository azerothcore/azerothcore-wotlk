#include "Proficiency.h"
#include "Knowledge.h"
#include <algorithm>
#include <cmath>

namespace Branding
{
    uint64_t XpForLevel(uint8_t level, IBrandingConfig const& cfg)
    {
        if (level == 0)
            return 0;

        uint8_t const capped = std::min<uint8_t>(level, cfg.MaxLevel());
        double const n = static_cast<double>(capped);
        double const growth = cfg.RankGrowth();

        // Geometric per-rank ladder (§7.4): cumulative cost of ranks 1..n. The closed-form sum of
        // RankBaseXp * growth^(k-1) for k in [1, n]. growth == 1 degenerates to a linear ladder.
        double xp;
        if (std::abs(growth - 1.0) < 1e-9)
            xp = cfg.RankBaseXp() * n;
        else
            xp = cfg.RankBaseXp() * (std::pow(growth, n) - 1.0) / (growth - 1.0);

        return static_cast<uint64_t>(std::llround(xp));
    }

    uint8_t LevelForXp(uint64_t totalXp, IBrandingConfig const& cfg)
    {
        uint8_t level = 0;
        for (uint8_t candidate = 1; candidate <= cfg.MaxLevel(); ++candidate)
        {
            if (XpForLevel(candidate, cfg) <= totalXp)
                level = candidate;
            else
                break;
        }
        return level;
    }

    LevelProgress ComputeLevelProgress(uint64_t totalXp, IBrandingConfig const& cfg)
    {
        LevelProgress p;
        p.maxLevel = cfg.MaxLevel();
        p.level = LevelForXp(totalXp, cfg);

        uint64_t const base = XpForLevel(p.level, cfg);

        // At or beyond the cap there is no further span -- the brand is graduated (§14.13.4). We
        // still report any XP earned past the cap (xpIntoLevel) so callers can show it if they wish.
        if (p.level >= p.maxLevel)
        {
            p.atMax = true;
            p.xpIntoLevel = totalXp > base ? totalXp - base : 0;
            p.xpForLevel = 0;
            return p;
        }

        uint64_t const next = XpForLevel(p.level + 1, cfg);
        p.xpIntoLevel = totalXp - base;
        p.xpForLevel = next - base;
        return p;
    }

    double EffectStrength(uint8_t level, IBrandingConfig const& cfg)
    {
        if (cfg.MaxLevel() == 0)
            return 0.0;

        double const strength = static_cast<double>(level) / static_cast<double>(cfg.MaxLevel());
        return std::min(1.0, strength);
    }

    double ResolvedEffectStrength(uint8_t level, BrandId brand,
        KnowledgeState const& currentAccount, IBrandingConfig const& cfg)
    {
        // Anti-P2W use-time gate: stored proficiency is inert without the current account's access.
        if (!CanExpressBrand(brand, currentAccount))
            return 0.0;

        return EffectStrength(level, cfg);
    }
}
