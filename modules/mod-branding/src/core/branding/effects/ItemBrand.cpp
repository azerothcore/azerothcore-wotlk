#include "ItemBrand.h"
#include <algorithm>

namespace Branding
{
    namespace
    {
        uint32_t TotalLevels(ItemBrandState const& state, IItemBrandConfig const& cfg)
        {
            return static_cast<uint32_t>(state.step) * cfg.LevelsPerStep() + state.levelInStep;
        }

        // Max state = MaxStep fully filled, i.e. (MaxStep + 1) bands of LevelsPerStep.
        uint32_t MaxTotalLevels(IItemBrandConfig const& cfg)
        {
            return static_cast<uint32_t>(cfg.MaxStep() + 1) * cfg.LevelsPerStep();
        }
    }

    double ItemEffectIntensity(ItemBrandState const& state, IItemBrandConfig const& cfg)
    {
        // Behavior/proc intensity only -- never a flat character-stat delta (§1, §7.9).
        return cfg.BaseIntensity() + static_cast<double>(TotalLevels(state, cfg)) * cfg.IntensityPerLevel();
    }

    ItemUpgradeResult ApplyItemUpgrade(ItemBrandState& state, uint32_t resources, IItemBrandConfig const& cfg)
    {
        ItemUpgradeResult result;
        if (cfg.UpgradeCostPerLevel() == 0 || cfg.LevelsPerStep() == 0)
            return result;

        uint32_t const affordable = resources / cfg.UpgradeCostPerLevel();
        uint32_t const current = TotalLevels(state, cfg);
        uint32_t const maxTotal = MaxTotalLevels(cfg);
        uint32_t const gain = std::min(affordable, current < maxTotal ? maxTotal - current : 0u);

        uint32_t const newTotal = current + gain;
        uint8_t newStep = static_cast<uint8_t>(newTotal / cfg.LevelsPerStep());
        uint8_t newLevel = static_cast<uint8_t>(newTotal % cfg.LevelsPerStep());
        if (newStep > cfg.MaxStep())
        {
            newStep = cfg.MaxStep();
            newLevel = cfg.LevelsPerStep();
        }

        state.step = newStep;
        state.levelInStep = newLevel;
        result.levelsGained = static_cast<uint8_t>(gain);
        result.consumed = gain * cfg.UpgradeCostPerLevel();
        return result;
    }

    uint32_t ItemMaxCumulativeCost(IItemBrandConfig const& cfg)
    {
        return MaxTotalLevels(cfg) * cfg.UpgradeCostPerLevel();
    }

    double ResolvedItemEffectIntensity(ItemBrandState const& state, bool canExpress, IItemBrandConfig const& cfg)
    {
        if (!canExpress)
            return 0.0;

        return ItemEffectIntensity(state, cfg);
    }

    bool IsLoadoutValid(BrandLoadout const& loadout, KnowledgeState const& knowledge,
        uint8_t profLevel, IItemBrandConfig const& cfg)
    {
        if (!CanExpressBrand(loadout.activeBrand, knowledge))
            return false;

        return loadout.selectedProcArchetype < cfg.ArchetypesAtLevel(profLevel);
    }
}
