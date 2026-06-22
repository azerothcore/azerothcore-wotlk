#ifndef MOD_BRANDING_SRC_ITEMBRANDCONFIG_H
#define MOD_BRANDING_SRC_ITEMBRANDCONFIG_H

#include "branding/effects/ItemBrand.h"
#include <cstdint>

namespace Branding
{
    // Production IItemBrandConfig (§7.9): snapshots item-branding / loadout tunables from sConfigMgr.
    // The pure core (ItemBrand.h: IsLoadoutValid, ItemEffectIntensity, ...) reads no globals; this
    // adapter is the only place sConfigMgr is touched for these tunables. ArchetypesAtLevel encodes
    // how many proc archetypes the loadout exposes at a given character proficiency level.
    class ItemBrandConfig : public IItemBrandConfig
    {
    public:
        // (Re)reads all options from sConfigMgr. Call on startup and on config reload.
        void Load();

        uint8_t LevelsPerStep() const override { return _levelsPerStep; }
        uint8_t MaxStep() const override { return _maxStep; }
        double BaseIntensity() const override { return _baseIntensity; }
        double IntensityPerLevel() const override { return _intensityPerLevel; }
        uint32_t UpgradeCostPerLevel() const override { return _upgradeCostPerLevel; }
        uint32_t AccountKnowledgeCost() const override { return _accountKnowledgeCost; }
        double StatBonusAtMaxRank() const override { return _statBonusAtMaxRank; }

        // Number of proc archetypes unlocked at this proficiency level (§7.9 loadout gating):
        // BaseArchetypes + profLevel / ArchetypeLevelStep, capped at MaxArchetypes.
        uint8_t ArchetypesAtLevel(uint8_t profLevel) const override;

    private:
        uint8_t _levelsPerStep = 8;
        uint8_t _maxStep = 3;
        double _baseIntensity = 1.0;
        double _intensityPerLevel = 0.05;
        uint32_t _upgradeCostPerLevel = 100;
        uint32_t _accountKnowledgeCost = 100000;
        double _statBonusAtMaxRank = 0.25;

        uint8_t _baseArchetypes = 1;
        uint8_t _archetypeLevelStep = 10;
        uint8_t _maxArchetypes = 6;
    };
}

#endif // MOD_BRANDING_SRC_ITEMBRANDCONFIG_H
