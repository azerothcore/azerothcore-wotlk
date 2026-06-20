#ifndef MOD_BRANDING_CORE_EFFECTS_ITEMBRAND_H
#define MOD_BRANDING_CORE_EFFECTS_ITEMBRAND_H

#include "common/Brand.h"
#include "proficiency/Knowledge.h"
#include "proficiency/Types.h"
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
