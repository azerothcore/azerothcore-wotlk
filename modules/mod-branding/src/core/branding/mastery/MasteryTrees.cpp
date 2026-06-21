#include "branding/mastery/MasteryTrees.h"
#include <algorithm>
#include <cstddef>

namespace Branding
{
    double MasteryUpkeep(bool accountUnlocked, uint8_t masteryLevel, ProcCell const& cell,
        bool inMatchingSchoolContext, IMasteryTreeConfig const& cfg)
    {
        // §14/§6 dual-key: either key missing => inert.
        if (!accountUnlocked || masteryLevel == 0)
        {
            return 0.0;
        }

        // §14.3 #1: saturating hyperbola -- monotonic, diminishing increments, asymptotes to
        // MaxUptime from below (strictly < MaxUptime for every finite level), so upkeep can approach
        // but never reach permanent uptime.
        double const level = static_cast<double>(masteryLevel);
        double const half = cfg.UpkeepHalfLevel() > 0.0 ? cfg.UpkeepHalfLevel() : 1.0;
        double upkeep = cfg.MaxUptime() * level / (level + half);

        // §14.4 SM/SE: a situational cell (resistance / school-exposure) only delivers full value in
        // its matching invasion school; elsewhere it falls off by OffSchoolFactor.
        if (cell.situational && !inMatchingSchoolContext)
        {
            upkeep *= cfg.OffSchoolFactor();
        }

        return upkeep;
    }

    double ExpectedProcs(double ppm, uint32_t elapsedMs, double weaponSpeedS,
        IMasteryTreeConfig const& /*cfg*/)
    {
        if (ppm <= 0.0 || elapsedMs == 0 || weaponSpeedS <= 0.0)
        {
            return 0.0;
        }

        // §14.3 #2: PPM normalization, modelled per-swing -- per-swing chance scales WITH weapon
        // speed, swing count scales INVERSELY, so weaponSpeedS cancels and the result depends only on
        // ppm and elapsed real time. This is what decouples upkeep from action density.
        double const elapsedS = static_cast<double>(elapsedMs) / 1000.0;
        double const swings = elapsedS / weaponSpeedS;
        double const perSwingChance = ppm * weaponSpeedS / 60.0;
        return swings * perSwingChance;
    }

    ResolvedCell ResolveTreeCell(TreeAllocation const& alloc, uint32_t applicableAxes,
        uint8_t masteryLevel, IMasteryTreeConfig const& cfg)
    {
        constexpr auto AXES = static_cast<std::size_t>(ProcAxis::COUNT);

        // Collect non-negative shares for the APPLICABLE axes only; degenerate (all-zero / negative)
        // input falls back to an even split over those axes.
        double share[AXES] = {};
        double sum = 0.0;
        std::size_t applicableCount = 0;
        for (std::size_t i = 0; i < AXES; ++i)
        {
            if ((applicableAxes & AxisBit(static_cast<ProcAxis>(i))) == 0u)
                continue;

            ++applicableCount;
            share[i] = std::max(0.0, alloc.share[i]);
            sum += share[i];
        }
        if (sum <= 0.0)
        {
            for (std::size_t i = 0; i < AXES; ++i)
                share[i] = (applicableAxes & AxisBit(static_cast<ProcAxis>(i))) ? 1.0 : 0.0;
            sum = static_cast<double>(applicableCount);
        }

        // §14.10 budget: same saturating-below-1 shape as upkeep. The applicable fills sum to exactly
        // b, so maxing one axis leaves nothing for the others -- the conservation property.
        double const level = static_cast<double>(masteryLevel);
        double const half = cfg.UpkeepHalfLevel() > 0.0 ? cfg.UpkeepHalfLevel() : 1.0;
        double const budget = level / (level + half);

        // Normalized fill fraction for an axis: 0 if not applicable (resolves to its Min baseline).
        auto fill = [&](ProcAxis a) -> double
        {
            if ((applicableAxes & AxisBit(a)) == 0u || sum <= 0.0)
                return 0.0;
            return (share[static_cast<std::size_t>(a)] / sum) * budget;
        };

        ResolvedCell out;
        out.ppm = cfg.MinPpm() + (cfg.MaxPpm() - cfg.MinPpm()) * fill(ProcAxis::Ppm);

        double const minW = static_cast<double>(cfg.MinWindowMs());
        double const maxW = static_cast<double>(cfg.MaxWindowMs());
        out.windowDurationMs = static_cast<uint32_t>(minW + (maxW - minW) * fill(ProcAxis::Duration));

        out.magnitude = 1.0 + (cfg.MaxProcMagnitude() - 1.0) * fill(ProcAxis::Magnitude);

        out.reach = cfg.MinReach() + (cfg.MaxReach() - cfg.MinReach()) * fill(ProcAxis::Reach);

        return out;
    }

    namespace
    {
        // §14.10 axis masks. Windowed (Def/Off): ppm/duration/magnitude; +Reach for area/cleave.
        constexpr uint32_t BASE = AxisBit(ProcAxis::Ppm) | AxisBit(ProcAxis::Duration) |
            AxisBit(ProcAxis::Magnitude);
        constexpr uint32_t BASE_REACH = BASE | AxisBit(ProcAxis::Reach);
        // Sustained (Support) auras tune magnitude + reach only -- no proc cadence (ppm/duration).
        constexpr uint32_t SUSTAINED = AxisBit(ProcAxis::Magnitude) | AxisBit(ProcAxis::Reach);

        // Compact helpers for the §14.4 table below.
        constexpr LatticeCellDef Win(EffectKind kind, uint32_t axes)        // windowed Def/Off cell
        {
            return LatticeCellDef{ kind, /*situational*/ false, /*sustained*/ false, axes };
        }
        constexpr LatticeCellDef Sup(EffectKind kind)                       // sustained Support cell (SM/SE)
        {
            return LatticeCellDef{ kind, /*situational*/ true, /*sustained*/ true, SUSTAINED };
        }
    }

    LatticeCellDef LatticeCell(BrandId school, MasteryTree tree)
    {
        using EK = EffectKind;

        // §14.4 lattice. Off cells = RaidWindow (bounded raid damage); Def = personal survivability
        // or a healing transform; Support = a school-matched (situational) resistance/exposure. Reach
        // marks the area/cleave procs (radius OR target count).
        switch (school)
        {
            case BrandId::Fire:
                switch (tree)
                {
                    case MasteryTree::Defensive: return Win(EK::RaidWindow, BASE_REACH);  // fire AoE proc
                    case MasteryTree::Offensive: return Win(EK::RaidWindow, BASE);         // fire damage proc
                    case MasteryTree::Support:   return Sup(EK::PersonalSpike);            // fire resistance
                    default: break;
                }
                break;

            case BrandId::Nature:
                switch (tree)
                {
                    case MasteryTree::Defensive: return Win(EK::MechanicTransform, BASE);  // HoT proc (spread)
                    case MasteryTree::Offensive: return Win(EK::RaidWindow, BASE_REACH);    // poison cloud (area)
                    case MasteryTree::Support:   return Sup(EK::PersonalSpike);            // nature resistance
                    default: break;
                }
                break;

            case BrandId::Shadow:
                switch (tree)
                {
                    case MasteryTree::Defensive: return Win(EK::PersonalSpike, BASE);       // life-steal proc
                    case MasteryTree::Offensive: return Win(EK::RaidWindow, BASE_REACH);     // shadow volley (area)
                    case MasteryTree::Support:   return Sup(EK::RaidWindow);                // shadow-exposure vs Nature
                    default: break;
                }
                break;

            case BrandId::Frost:
                switch (tree)
                {
                    case MasteryTree::Defensive: return Win(EK::PersonalSpike, BASE);       // damage-reduction proc
                    case MasteryTree::Offensive: return Win(EK::RaidWindow, BASE_REACH);     // Frost Nova (area)
                    case MasteryTree::Support:   return Sup(EK::RaidWindow);                // frost-exposure vs Fire
                    default: break;
                }
                break;

            case BrandId::Physical:
                switch (tree)
                {
                    case MasteryTree::Defensive: return Win(EK::PersonalSpike, BASE);       // evasion proc
                    case MasteryTree::Offensive: return Win(EK::RaidWindow, BASE_REACH);     // cleave (target count)
                    case MasteryTree::Support:   return Sup(EK::PersonalSpike);            // physical mitigation
                    default: break;
                }
                break;

            default:
                break;  // Arcane / Holy: no authored trees yet.
        }

        // Neutral default for unauthored (school, tree) pairs.
        return Win(EK::RaidWindow, BASE);
    }

    double EnemyMasteryMultiplier(uint8_t masteryLevel, IMasteryTreeConfig const& cfg)
    {
        // §14.8: 1.0 at level 0, asymptotes toward MaxEnemyMul from below (same saturating shape as
        // upkeep, §14.2). Function of mastery level only -> group-size invariant; the spike rides on
        // top of the already §2.2-scaled baseline as a bounded fraction, never a flat addition.
        double const span = cfg.MaxEnemyMul() - 1.0;  // headroom above the baseline (>= 0)
        if (span <= 0.0 || masteryLevel == 0)
        {
            return 1.0;
        }
        double const level = static_cast<double>(masteryLevel);
        double const half = cfg.UpkeepHalfLevel() > 0.0 ? cfg.UpkeepHalfLevel() : 1.0;
        return 1.0 + span * level / (level + half);
    }
}
