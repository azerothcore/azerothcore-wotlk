#include "branding/mastery/MasteryContent.h"
#include <algorithm>

namespace Branding
{
    namespace
    {
        // §14.2 per-cell magnitude ceilings (issue #30). A sustained Support aura is PERMANENT, so even
        // a bounded magnitude is strong -- these sit below the global MaxProcMagnitude default.
        //   - raid-utility: non-situational, raid-wide, always up -> the most conservative.
        //   - school-matched (SM/SE): school-gated + catalyst-DR'd -> moderate.
        // Windowed Def/Off cells set 0 (inherit the global cap): they have no passive uptime.
        constexpr double kRaidUtilityCeiling = 1.25;
        constexpr double kSchoolMatchedCeiling = 1.50;

        // §14.4.2 envelope builders. `maxMag == 0` inherits the global magnitude cap.
        constexpr CellEnvelope Single(double maxMag = 0.0)   // single-target windowed (no reach axis)
        {
            return CellEnvelope{ 0.0, 0, maxMag, ReachMode::None, 0.0, 0.0 };
        }
        constexpr CellEnvelope Radius(double minYd, double maxYd, double maxMag = 0.0)
        {
            return CellEnvelope{ 0.0, 0, maxMag, ReachMode::RadiusYards, minYd, maxYd };
        }
        constexpr CellEnvelope Count(double minTargets, double maxTargets, double maxMag = 0.0)
        {
            return CellEnvelope{ 0.0, 0, maxMag, ReachMode::TargetCount, minTargets, maxTargets };
        }

        constexpr LatticeCellContent Cell(uint32_t spellId, CellEnvelope env)
        {
            return LatticeCellContent{ spellId, env };
        }

        constexpr LatticeCellContentSet One(LatticeCellContent primary)
        {
            LatticeCellContentSet out{};
            out.archetype[0] = primary;
            out.count = 1;
            return out;
        }
        constexpr LatticeCellContentSet Two(LatticeCellContent primary, LatticeCellContent secondary)
        {
            LatticeCellContentSet out{};
            out.archetype[0] = primary;
            out.archetype[1] = secondary;
            out.count = 2;
            return out;
        }
    }

    LatticeCellContentSet LatticeContents(BrandId school, MasteryTree tree)
    {
        // Spell ids verified against the 3.3.5a / wowhead `wotlk` branch (docs/issues/30 + 16). The
        // adapter reuses the spell as a visual/mechanical shell and remaps proc behaviour onto it
        // (§1/§7.9). The archetype layout MIRRORS LatticeArchetypes (shape <-> content invariant).
        switch (school)
        {
            case BrandId::Fire:
                switch (tree)
                {
                    case MasteryTree::Defensive: return One(Cell(11681, Radius(5.0, 12.0)));  // Hellfire Effect
                    case MasteryTree::Offensive: return One(Cell(42833, Single()));           // Fireball
                    case MasteryTree::Support:   return Two(
                        Cell(25563, Radius(10.0, 30.0, kSchoolMatchedCeiling)),    // Fire Resistance Totem (SM)
                        Cell(30706, Radius(10.0, 40.0, kRaidUtilityCeiling)));     // Totem of Wrath (flame aura)
                    default: break;
                }
                break;

            case BrandId::Frost:
                switch (tree)
                {
                    case MasteryTree::Defensive: return One(Cell(11426, Single()));           // Ice Barrier
                    case MasteryTree::Offensive: return One(Cell(122, Radius(8.0, 12.0)));    // Frost Nova
                    case MasteryTree::Support:   return Two(
                        Cell(12579, Count(1.0, 3.0, kSchoolMatchedCeiling)),       // Winter's Chill (SE)
                        Cell(8181, Radius(10.0, 30.0, kSchoolMatchedCeiling)));    // Frost Resistance Totem (SM)
                    default: break;
                }
                break;

            case BrandId::Nature:
                switch (tree)
                {
                    case MasteryTree::Defensive: return One(Cell(48441, Single()));           // Rejuvenation (HoT)
                    case MasteryTree::Offensive: return One(Cell(57061, Radius(5.0, 12.0)));  // Poison Cloud
                    case MasteryTree::Support:   return Two(
                        Cell(58749, Radius(10.0, 30.0, kSchoolMatchedCeiling)),    // Nature Resistance Totem (SM)
                        Cell(48447, Radius(10.0, 30.0, kRaidUtilityCeiling)));     // Tranquility (raid-heal)
                    default: break;
                }
                break;

            case BrandId::Shadow:
                switch (tree)
                {
                    case MasteryTree::Defensive: return One(Cell(47860, Single()));           // Death Coil (life-steal)
                    case MasteryTree::Offensive: return One(Cell(55850, Radius(8.0, 15.0)));  // Shadow Bolt Volley
                    case MasteryTree::Support:   return Two(
                        Cell(47865, Count(1.0, 3.0, kSchoolMatchedCeiling)),       // Curse of the Elements (SE)
                        Cell(48943, Radius(10.0, 40.0, kSchoolMatchedCeiling)));   // Shadow Resistance Aura (SM)
                    default: break;
                }
                break;

            case BrandId::Arcane:
                switch (tree)
                {
                    case MasteryTree::Defensive: return One(Cell(43020, Single()));           // Mana Shield
                    case MasteryTree::Offensive: return One(Cell(42921, Radius(10.0, 18.0))); // Arcane Explosion
                    case MasteryTree::Support:   return Two(
                        Cell(28770, Radius(5.0, 30.0, kSchoolMatchedCeiling)),     // Arcane Resistance (SM)
                        Cell(43002, Radius(10.0, 40.0, kRaidUtilityCeiling)));     // Arcane Brilliance (int/mana)
                    default: break;
                }
                break;

            case BrandId::Holy:
                switch (tree)
                {
                    case MasteryTree::Defensive: return One(Cell(48066, Single()));           // Power Word: Shield
                    case MasteryTree::Offensive: return One(Cell(15237, Radius(10.0, 18.0))); // Holy Nova
                    case MasteryTree::Support:   return Two(
                        Cell(48135, Count(1.0, 3.0, kSchoolMatchedCeiling)),       // Holy Fire (SE proxy)
                        Cell(48089, Radius(10.0, 30.0, kRaidUtilityCeiling)));     // Circle of Healing (raid-heal)
                    default: break;
                }
                break;

            case BrandId::Physical:
                switch (tree)
                {
                    case MasteryTree::Defensive: return One(Cell(5277, Single()));            // Evasion (dodge spike)
                    // Off reach is a TARGET COUNT (2 -> N), not a radius: the adapter applies the cleave
                    // to N nearby targets regardless of Cleave's hardcoded 2-target cap (§14.4.2).
                    case MasteryTree::Offensive: return One(Cell(845, Count(2.0, 6.0)));      // Cleave (target count)
                    case MasteryTree::Support:   return One(
                        Cell(465, Radius(10.0, 40.0, kSchoolMatchedCeiling)));     // Devotion Aura (mitigation)
                    default: break;
                }
                break;

            default:
                break;  // exotic §7.10 schools: no authored tree-axis content yet (neutral default)
        }

        // Neutral default for unauthored (school, tree) pairs -- spell id 0, no reach.
        return One(Cell(0, Single()));
    }

    uint8_t LatticeContentCount(BrandId school, MasteryTree tree)
    {
        return LatticeContents(school, tree).count;
    }

    LatticeCellContent LatticeContent(BrandId school, MasteryTree tree, uint8_t archetypeIndex)
    {
        LatticeCellContentSet const set = LatticeContents(school, tree);
        // Out-of-range clamps to the primary -- mirrors LatticeArchetype (a bad selection never UB's).
        uint8_t const idx = archetypeIndex < set.count ? archetypeIndex : 0;
        return set.archetype[idx];
    }

    uint32_t LatticeSpellId(BrandId school, MasteryTree tree, uint8_t archetypeIndex)
    {
        return LatticeContent(school, tree, archetypeIndex).spellId;
    }

    ResolvedEnvelope EffectiveEnvelope(CellEnvelope const& cell, IMasteryTreeConfig const& cfg)
    {
        ResolvedEnvelope env = GlobalEnvelope(cfg);

        // Per-cell caps NARROW the global bound (never widen); 0 inherits.
        if (cell.maxPpm > 0.0)
            env.maxPpm = std::min(env.maxPpm, cell.maxPpm);
        if (cell.maxWindowMs > 0)
            env.maxWindowMs = std::min(env.maxWindowMs, cell.maxWindowMs);
        if (cell.maxMagnitude > 0.0)
            env.maxMagnitude = std::min(env.maxMagnitude, cell.maxMagnitude);
        if (env.maxMagnitude < 1.0)
            env.maxMagnitude = 1.0;   // the magnitude floor is always 1.0

        // A reach-bearing cell authors its own reach bounds in its own units (yards OR target count);
        // these REPLACE the whole-lattice 0..MaxReach default, which is meaningless for a count.
        if (cell.reachMode != ReachMode::None)
        {
            env.minReach = cell.minReach;
            env.maxReach = cell.maxReach;
        }

        // Keep each min <= its (possibly narrowed) max so the resolver's lerp stays well-formed.
        if (env.minPpm > env.maxPpm)
            env.minPpm = env.maxPpm;
        if (env.minWindowMs > env.maxWindowMs)
            env.minWindowMs = env.maxWindowMs;
        if (env.minReach > env.maxReach)
            env.minReach = env.maxReach;

        return env;
    }

    ResolvedCell ResolveContentCell(TreeAllocation const& alloc, uint32_t applicableAxes,
        CellEnvelope const& cell, uint8_t masteryLevel, IMasteryTreeConfig const& cfg)
    {
        return ResolveTreeCell(alloc, applicableAxes, masteryLevel, EffectiveEnvelope(cell, cfg),
            cfg.UpkeepHalfLevel());
    }
}
