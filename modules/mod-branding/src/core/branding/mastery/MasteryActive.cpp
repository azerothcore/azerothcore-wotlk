#include "branding/mastery/MasteryActive.h"

namespace Branding
{
    TreeAllocation PointsToAllocation(uint8_t const pointsPerAxis[static_cast<size_t>(ProcAxis::COUNT)],
        uint32_t applicableAxes, IMasteryLoadoutConfig const& cfg)
    {
        constexpr auto AXES = static_cast<size_t>(ProcAxis::COUNT);
        TreeAllocation alloc;

        // Sum points on the APPLICABLE axes only; points on non-applicable axes are inert.
        uint32_t spent = 0;
        for (size_t i = 0; i < AXES; ++i)
            if (applicableAxes & AxisBit(static_cast<ProcAxis>(i)))
                spent += pointsPerAxis[i];

        uint32_t const budget = cfg.PointsBudget();

        // Conservation: clamp the *total* spend to the budget, distributing the overflow reduction
        // proportionally so the ratio between axes (which is all ResolveTreeCell consumes) is
        // preserved while no share's denominator can exceed the budget.
        double const scale = (budget > 0 && spent > budget)
            ? static_cast<double>(budget) / static_cast<double>(spent)
            : 1.0;

        for (size_t i = 0; i < AXES; ++i)
        {
            bool const applicable = (applicableAxes & AxisBit(static_cast<ProcAxis>(i))) != 0u;
            double const pts = applicable ? static_cast<double>(pointsPerAxis[i]) * scale : 0.0;
            // share == clamped points / budget (a fill fraction in [0, 1]); 0 when budget is 0.
            alloc.share[i] = (budget > 0) ? pts / static_cast<double>(budget) : 0.0;
        }

        return alloc;
    }

    uint32_t MasteryRespecCost(LoadoutChange change, IMasteryLoadoutConfig const& cfg)
    {
        // §14.11: switching talent spec loads a SAVED set -- no token. Only re-allocation is paid.
        return change == LoadoutChange::Reallocate ? cfg.RespecCost() : 0u;
    }

    bool IsActiveEntryValid(ActiveMasteryEntry const& entry, bool accountUnlocked, uint8_t schoolLevel,
        IMasteryLoadoutConfig const& cfg)
    {
        // Dual-key (§7.9 / §14): both the account unlock AND an earned per-school level are required.
        if (!accountUnlocked || schoolLevel == 0)
            return false;

        // Archetype within the cell's available range (§7.9 loadout).
        if (cfg.MaxArchetypesPerCell() == 0 || entry.archetype >= cfg.MaxArchetypesPerCell())
            return false;

        // §14.10 point-buy: the total spend may not exceed the budget.
        uint32_t spent = 0;
        for (size_t i = 0; i < static_cast<size_t>(ProcAxis::COUNT); ++i)
            spent += entry.pointsPerAxis[i];

        return spent <= cfg.PointsBudget();
    }

    ActiveMasteryEntry const* ActiveMasterySet::Find(BrandId school, MasteryTree tree) const
    {
        for (uint8_t i = 0; i < count; ++i)
            if (entries[i].school == school && entries[i].tree == tree)
                return &entries[i];

        return nullptr;
    }

    bool ActiveMasterySet::Add(ActiveMasteryEntry const& entry)
    {
        if (count >= Capacity)
            return false;

        // (school, tree) is the collection key -- no duplicate cell.
        if (Find(entry.school, entry.tree) != nullptr)
            return false;

        entries[count] = entry;
        ++count;
        return true;
    }
}
