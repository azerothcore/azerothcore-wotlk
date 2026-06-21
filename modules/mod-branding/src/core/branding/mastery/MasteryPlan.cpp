#include "branding/mastery/MasteryPlan.h"
#include "branding/effects/EffectModel.h"

namespace Branding
{
    namespace
    {
        // §14.12 classification: a cell reaches the raid when it is an Offensive/raid window OR a
        // non-situational sustained Support utility (flame aura, raid-heal, intellect-mana aura, circle
        // of healing). Everything else is personal: Defensive personal spikes + the situational (SM/SE)
        // Support cells, which are the character's own mitigation/exposure.
        bool IsRaidWide(LatticeCellDef const& def)
        {
            if (def.sustained)
                return !def.situational;   // sustained Support: raid utility vs school-matched mitigation

            return def.kind == EffectKind::RaidWindow;  // windowed: Off is raid-wide, personal spikes are not
        }

        // Rank of the player's cell in its (school, tree) bucket: 1 + prior matching roster entries +
        // prior matching cells of the player's OWN set (the player sits after the surrounding raid).
        uint8_t BucketRank(CatalystKey const& key, CatalystKey const* roster, std::size_t rosterCount,
            ActiveMasterySet const& set, uint8_t ownIndex)
        {
            uint8_t rank = 1;
            for (std::size_t r = 0; r < rosterCount; ++r)
                if (SameCatalystBucket(roster[r], key))
                    ++rank;

            for (uint8_t j = 0; j < ownIndex; ++j)
            {
                CatalystKey const prior{ set.entries[j].school, set.entries[j].tree };
                if (SameCatalystBucket(prior, key))
                    ++rank;
            }

            return rank;
        }

        // §14.3 #2 / §7.9: cadence between windowed procs derived from the resolved PPM. The expected
        // gap between procs is 60000/ppm ms; the cooldown is what is left after the window opens (>= 0).
        // This is what makes a windowed cell's uptime fraction strictly < 1.0 -- the §14.3 #1 rail.
        uint32_t WindowCooldownMs(ResolvedCell const& cell)
        {
            if (cell.ppm <= 0.0)
                return cell.windowDurationMs;   // no procs -> treat as a full cooldown gap (uptime -> 0)

            double const intervalMs = 60000.0 / cell.ppm;
            double const cooldown = intervalMs - static_cast<double>(cell.windowDurationMs);
            return cooldown > 0.0 ? static_cast<uint32_t>(cooldown + 0.5) : 1u;   // >= 1ms -> uptime < 1
        }
    }

    MasteryPlan BuildMasteryPlan(ActiveMasterySet const& set, MasterySchoolState const& state,
        RoleContribution role, CatalystKey const* raidRoster, std::size_t raidRosterCount,
        IMasteryTreeConfig const& treeCfg, IMasteryLoadoutConfig const& loadoutCfg,
        IEffectConfig const& effectCfg, ICatalystConfig const& catalystCfg)
    {
        MasteryPlan plan;

        for (uint8_t i = 0; i < set.count; ++i)
        {
            ActiveMasteryEntry const& entry = set.entries[i];

            // Default-deny on an out-of-range school (anti-P2W: locked, level 0).
            std::size_t const sIdx = static_cast<std::size_t>(entry.school);
            bool const accountUnlocked = sIdx < static_cast<std::size_t>(BrandId::COUNT)
                && state.unlocked[sIdx];
            uint8_t const schoolLevel = sIdx < static_cast<std::size_t>(BrandId::COUNT)
                ? state.level[sIdx] : 0;

            // Dual-key + archetype-in-range + points-within-budget (§14.10/§14.11).
            if (!IsActiveEntryValid(entry, accountUnlocked, schoolLevel, loadoutCfg))
                continue;

            // §7.9/§14.4.1: the selected archetype must be unlocked at the earned level (finer than the
            // flat MaxArchetypesPerCell gate -- a locked secondary is excluded from the plan).
            if (!IsLatticeArchetypeUnlocked(entry.school, entry.tree, entry.archetype, schoolLevel, treeCfg))
                continue;

            ResolvedMasteryEffect eff;
            eff.school = entry.school;
            eff.tree = entry.tree;
            eff.archetype = entry.archetype;
            eff.masteryLevel = schoolLevel;
            eff.def = LatticeArchetype(entry.school, entry.tree, entry.archetype);

            // §14.10: point-buy -> normalized shares -> concrete proc params at the earned level.
            TreeAllocation const alloc = PointsToAllocation(entry.pointsPerAxis, eff.def.applicableAxes,
                loadoutCfg);
            eff.resolved = ResolveTreeCell(alloc, eff.def.applicableAxes, schoolLevel, treeCfg);

            // §14.9 catalyst DR bucket (school, tree) rank across the raid + the player's own set.
            CatalystKey const key{ entry.school, entry.tree };
            eff.catalystRank = BucketRank(key, raidRoster, raidRosterCount, set, i);

            // §7.9 magnitude bound. The EffectProfile carries the resolved window/cooldown so the
            // windowed-uptime fraction is computed from the actual proc params, not a fixed profile.
            eff.raidWide = IsRaidWide(eff.def);
            uint32_t const windowMs = eff.resolved.windowDurationMs;
            uint32_t const cooldownMs = WindowCooldownMs(eff.resolved);
            EffectProfile profile{ eff.def.kind, role, windowMs, cooldownMs };

            if (eff.raidWide)
            {
                // Bounded by MaxRaidMul, catalyst-DR'd by the bucket rank (1st full, 2nd reduced, ...).
                double const weight = CatalystStackWeight(eff.catalystRank, catalystCfg);
                eff.magnitude = RaidMultiplier(schoolLevel, profile, weight, effectCfg);
            }
            else
            {
                // Bounded by MaxPersonalMul, role-scaled (tank dramatic, dps restrained).
                eff.magnitude = PersonalMultiplier(schoolLevel, profile, effectCfg);
            }

            // §14.2: sustained Support auras run at constant uptime; windowed cells have no passive
            // uptime -- fraction = window / (window + cooldown) < 1.0 (§7.9).
            eff.uptimeFraction = eff.def.sustained ? 1.0 : WindowUptimeFraction(profile);

            plan.effects[plan.count] = eff;
            ++plan.count;
        }

        return plan;
    }
}
