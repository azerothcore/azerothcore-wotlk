#ifndef MOD_BRANDING_CORE_EFFECTS_ITEMBRAND_H
#define MOD_BRANDING_CORE_EFFECTS_ITEMBRAND_H

#include "branding/common/Brand.h"
#include "branding/proficiency/Knowledge.h"
#include "branding/proficiency/Types.h"
#include <cstdint>

namespace Branding
{
    class IItemBrandConfig
    {
    public:
        virtual ~IItemBrandConfig() = default;

        virtual uint8_t LevelsPerStep() const = 0;        // 5-10 internal levels per step
        virtual uint8_t MaxStep() const = 0;              // number of major steps
        virtual double BaseIntensity() const = 0;         // proc/behavior intensity at step 0 lvl 0
        virtual double IntensityPerLevel() const = 0;     // intensity added per internal level
        virtual uint32_t UpgradeCostPerLevel() const = 0; // economy resources per internal level
        virtual uint32_t AccountKnowledgeCost() const = 0;// for the difficulty-ordering invariant
        virtual double StatBonusAtMaxRank() const = 0;    // total flat-stat bonus at full upgrade, e.g. 0.25 = +25% (§7.9)
        virtual uint8_t ArchetypesAtLevel(uint8_t profLevel) const = 0; // proc archetypes unlocked
    };

    // An item's brand progression (§7.9): major Steps filled by internal levels.
    struct ItemBrandState
    {
        BrandId brand = BrandId::Fire;
        uint8_t step = 0;
        uint8_t levelInStep = 0;
        uint32_t upgradeProgress = 0;
    };

    // Effect/proc INTENSITY multiplier (behavior, not raw stats). Monotonic non-decreasing in
    // (step, levelInStep), bounded by the value at the fully-upgraded state.
    double ItemEffectIntensity(ItemBrandState const& state, IItemBrandConfig const& cfg);

    struct ItemUpgradeResult
    {
        uint8_t levelsGained = 0;
        uint32_t consumed = 0;
    };

    // Spends economy resources to fill internal levels, advancing the step; caps at the max state.
    ItemUpgradeResult ApplyItemUpgrade(ItemBrandState& state, uint32_t resources, IItemBrandConfig const& cfg);

    // Cumulative cost to fully upgrade an item's brand (used to assert it is < account-Knowledge cost).
    uint32_t ItemMaxCumulativeCost(IItemBrandConfig const& cfg);

    // Anti-P2W: item intensity contributes only when the current account can express the brand
    // (§1/§7.5). A traded/maxed branded item is inert without account access.
    double ResolvedItemEffectIntensity(ItemBrandState const& state, bool canExpress, IItemBrandConfig const& cfg);

    // Modest flat-stat MULTIPLIER from Brand Rank progression (§7.9 amended). 1.0 at rank 0, rising
    // linearly with upgrade progress to exactly 1 + StatBonusAtMaxRank() at the fully-upgraded state.
    // The single tuning knob is that headline percentage (e.g. 0.25 -> a maxed item is +25% stats);
    // the per-level step is derived, so the end-state is always what the designer set. Deliberately
    // modest -- the base item stays modest and the proc intensity (ItemEffectIntensity) remains the
    // primary power source (§1 anti-obsolescence). Multiplies the item's base stats; never the sole power.
    double ItemStatScale(ItemBrandState const& state, IItemBrandConfig const& cfg);

    // Anti-P2W gate, mirroring ResolvedItemEffectIntensity: without account access the upgrade bonus
    // falls away and the item keeps only its base stats (multiplier 1.0), never the upgraded delta.
    double ResolvedItemStatScale(ItemBrandState const& state, bool canExpress, IItemBrandConfig const& cfg);

    // Player-selected proc loadout (§7.9).
    struct BrandLoadout
    {
        BrandId activeBrand = BrandId::Fire;
        uint8_t selectedProcArchetype = 0;
    };

    // Valid when the account can express the brand AND the chosen archetype is unlocked at the
    // character's proficiency level.
    bool IsLoadoutValid(BrandLoadout const& loadout, KnowledgeState const& knowledge,
        uint8_t profLevel, IItemBrandConfig const& cfg);
}

#endif // MOD_BRANDING_CORE_EFFECTS_ITEMBRAND_H
