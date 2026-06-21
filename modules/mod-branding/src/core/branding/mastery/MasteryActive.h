#ifndef MOD_BRANDING_CORE_MASTERY_MASTERYACTIVE_H
#define MOD_BRANDING_CORE_MASTERY_MASTERYACTIVE_H

#include "branding/common/Brand.h"
#include "branding/mastery/MasteryTrees.h"
#include <array>
#include <cstddef>
#include <cstdint>

// Pure core (§14.10 / §14.11). No AzerothCore includes anywhere under core/.
//
// This is the SHARED multi-mastery loadout model the combat adapter (a later task) consumes. The
// EARNED layer (per-school level + account unlock, §6/§14) is shared across talent specs; the
// ALLOCATED layer modelled here -- which (school, tree) cells are active and how each spends its
// point-buy budget across the §14.10 proc axes -- is stored PER talent-spec slot by the adapter.
namespace Branding
{
    // §14.10 / §14.11 loadout dials, separate from IMasteryTreeConfig (the envelope) so the
    // READ-ONLY MasteryTrees.h need not change. The production MasteryConfig implements both.
    class IMasteryLoadoutConfig
    {
    public:
        virtual ~IMasteryLoadoutConfig() = default;

        // §14.10 point-buy: total discrete points a character may spend across a cell's axes.
        virtual uint8_t PointsBudget() const = 0;
        // §14.5 / §14.11: flat, expensive token cost to RE-ALLOCATE points (switching spec is free).
        virtual uint32_t RespecCost() const = 0;
        // §14.11: max simultaneously-active mastery cells. v1 = 1; the type handles N regardless.
        virtual uint8_t MaxActive() const = 0;
        // §7.9 / §14.10: how many proc archetypes a cell exposes (archetype index must be < this).
        virtual uint8_t MaxArchetypesPerCell() const = 0;
    };

    // §14.10: convert a discrete per-axis point spend into the normalized TreeAllocation.share[]
    // weights ResolveTreeCell consumes. The total spend over APPLICABLE axes is clamped to
    // cfg.PointsBudget() (conservation -- never overflowed); each applicable share = clampedPoints /
    // budget. Points on a non-applicable axis are ignored (the cell's mask governs). A zero spend
    // yields all-zero shares, which ResolveTreeCell normalizes to its even-split baseline.
    // Deterministic: same points + same mask -> identical shares.
    TreeAllocation PointsToAllocation(uint8_t const pointsPerAxis[static_cast<size_t>(ProcAxis::COUNT)],
        uint32_t applicableAxes, IMasteryLoadoutConfig const& cfg);

    // §14.5 / §14.11: a loadout change is either a free spec switch (loads a saved set) or a paid
    // re-allocation of points. Encoded so the adapter cannot accidentally charge a spec swap.
    enum class LoadoutChange : uint8_t { SwitchSpec, Reallocate };

    // Friction cost (abstract token unit) of applying a loadout change. SwitchSpec -> 0 (free);
    // Reallocate -> cfg.RespecCost(). Pure; the adapter charges the returned amount.
    uint32_t MasteryRespecCost(LoadoutChange change, IMasteryLoadoutConfig const& cfg);

    // §14.11: one active mastery cell with its §14.10 point-buy spend. (school, tree) is BOTH the
    // collection key here AND the catalyst-DR bucket key (§14.9). `archetype` selects among the
    // cell's available proc archetypes (§7.9). Persisted by the adapter per (guid, spec slot).
    struct ActiveMasteryEntry
    {
        BrandId     school = BrandId::Fire;
        MasteryTree tree = MasteryTree::Defensive;
        uint8_t     archetype = 0;
        uint8_t     pointsPerAxis[static_cast<size_t>(ProcAxis::COUNT)] = { 0, 0, 0, 0 };
    };

    // §14.10 / §14.11: a single entry is valid iff dual-keyed (account-unlocked AND char school
    // level > 0, mirroring §7.9 / §14), archetype within range, and total points within budget.
    bool IsActiveEntryValid(ActiveMasteryEntry const& entry, bool accountUnlocked, uint8_t schoolLevel,
        IMasteryLoadoutConfig const& cfg);

    // §14.11: the active loadout is a COLLECTION keyed by (school, tree), NOT a single active brand.
    // Fixed-cap (std::array + count -- no <vector> in core); capacity covers future multi-mastery so
    // schema/cache/validation never need a rebuild. v1 caps the *enforced* active count via
    // cfg.MaxActive(); this type always holds up to Capacity. Aggregation/validation iterate entries.
    struct ActiveMasterySet
    {
        // Generous fixed cap: every (school, tree) cell of the lattice could in principle be active.
        static constexpr size_t Capacity =
            static_cast<size_t>(BrandId::COUNT) * static_cast<size_t>(MasteryTree::COUNT);

        std::array<ActiveMasteryEntry, Capacity> entries{};
        uint8_t count = 0;

        uint8_t Count() const { return count; }

        // Find the entry for a (school, tree) cell, or nullptr. (school, tree) is the collection key.
        ActiveMasteryEntry const* Find(BrandId school, MasteryTree tree) const;

        // Add an entry. Rejected (returns false) if its (school, tree) already exists (no duplicate
        // cell) or the fixed Capacity is full. Does NOT consult cfg.MaxActive() -- that is a
        // validity rule checked by IsActiveSetValid, kept separate so the type stays config-free.
        bool Add(ActiveMasteryEntry const& entry);
    };

    // §14.11: the set is valid iff every entry is valid (iterates -- dual-key per entry), no
    // (school, tree) repeats, and count <= cfg.MaxActive(). The dual-key lookups are injected as
    // callables (school -> bool accountUnlocked, school -> uint8_t earned level) so core stays pure.
    template <class UnlockedFn, class LevelFn>
    bool IsActiveSetValid(ActiveMasterySet const& set, UnlockedFn accountUnlocked, LevelFn schoolLevel,
        IMasteryLoadoutConfig const& cfg)
    {
        if (set.count > ActiveMasterySet::Capacity || set.count > cfg.MaxActive())
            return false;

        for (uint8_t i = 0; i < set.count; ++i)
        {
            ActiveMasteryEntry const& e = set.entries[i];

            // No duplicate (school, tree) keys.
            for (uint8_t j = 0; j < i; ++j)
                if (set.entries[j].school == e.school && set.entries[j].tree == e.tree)
                    return false;

            if (!IsActiveEntryValid(e, accountUnlocked(e.school), schoolLevel(e.school), cfg))
                return false;
        }

        return true;
    }
}

#endif // MOD_BRANDING_CORE_MASTERY_MASTERYACTIVE_H
