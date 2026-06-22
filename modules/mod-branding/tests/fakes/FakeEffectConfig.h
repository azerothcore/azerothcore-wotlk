#ifndef MOD_BRANDING_TESTS_FAKES_FAKEEFFECTCONFIG_H
#define MOD_BRANDING_TESTS_FAKES_FAKEEFFECTCONFIG_H

#include "branding/effects/EffectConfig.h"
#include "branding/effects/ItemBrand.h"
#include <array>
#include <cstddef>

namespace Branding::Test
{
    class FakeEffectConfig : public IEffectConfig
    {
    public:
        double maxPersonalMul = 3.5;
        double maxRaidMul = 2.0;
        uint8_t maxEffectLevel = 50;
        // None, Tank, Healer, Damage, Control, Support
        std::array<double, static_cast<size_t>(RoleContribution::COUNT)> rolePersonalScale{ { 0.5, 1.0, 0.7, 0.5, 0.6, 0.6 } };

        double MaxPersonalMul() const override { return maxPersonalMul; }
        double MaxRaidMul() const override { return maxRaidMul; }
        uint8_t MaxEffectLevel() const override { return maxEffectLevel; }
        double RolePersonalScale(RoleContribution role) const override { return rolePersonalScale[static_cast<size_t>(role)]; }
    };

    class FakeItemBrandConfig : public IItemBrandConfig
    {
    public:
        uint8_t levelsPerStep = 8;
        uint8_t maxStep = 3;
        double baseIntensity = 1.0;
        double intensityPerLevel = 0.05;
        uint32_t upgradeCostPerLevel = 100;
        uint32_t accountKnowledgeCost = 100000;
        double statBonusAtMaxRank = 0.25;

        uint8_t LevelsPerStep() const override { return levelsPerStep; }
        uint8_t MaxStep() const override { return maxStep; }
        double BaseIntensity() const override { return baseIntensity; }
        double IntensityPerLevel() const override { return intensityPerLevel; }
        uint32_t UpgradeCostPerLevel() const override { return upgradeCostPerLevel; }
        uint32_t AccountKnowledgeCost() const override { return accountKnowledgeCost; }
        double StatBonusAtMaxRank() const override { return statBonusAtMaxRank; }
        uint8_t ArchetypesAtLevel(uint8_t profLevel) const override { return static_cast<uint8_t>(1 + profLevel / 10); }
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKEEFFECTCONFIG_H
