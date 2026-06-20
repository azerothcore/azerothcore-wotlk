#ifndef MOD_BRANDING_TESTS_FAKES_FAKECONTRIBUTIONCONFIG_H
#define MOD_BRANDING_TESTS_FAKES_FAKECONTRIBUTIONCONFIG_H

#include "contribution/ContributionConfig.h"
#include <array>
#include <cstddef>

namespace Branding::Test
{
    // Pinned config for deterministic contribution tests. Action base points mirror the §9.2 table.
    class FakeContributionConfig : public IContributionConfig
    {
    public:
        // InvadingKill 1, EliteKill 5, MiniBoss 15, Heal (base 1, magnitude-scaled), Gather 2,
        // Craft 10, DiscoverObjective 8.
        std::array<uint32_t, static_cast<size_t>(EventAction::COUNT)> actionPoints{ { 1, 5, 15, 1, 2, 10, 8 } };
        uint32_t healUnitsPerPoint = 5000;
        uint32_t healMaxPoints = 3;

        uint32_t hourlyCap = 100000;          // effectively off unless a test lowers it
        uint64_t hourWindowSeconds = 3600;
        double eventDrSlope = 0.1;
        double eventDrFloor = 0.1;
        uint64_t dayWindowSeconds = 86400;
        uint32_t leechDamageFloor = 100;
        uint32_t leechActionFloor = 1;

        uint32_t bronzeThreshold = 50;
        uint32_t silverThreshold = 150;
        uint32_t goldThreshold = 400;

        // Per-EventType allowed reward categories (bits over RewardCategory). None spans all 5.
        // Invasion: Mats|Currency|Rep; ResourceSurge: Mats|Xp; EliteHunt: Currency|Cosmetic|Rep;
        // ProfessionAnomaly: Mats|Xp|Cosmetic.
        std::array<uint32_t, static_cast<size_t>(EventType::COUNT)> allowedCategoryMask{ { 21u, 3u, 28u, 11u } };

        uint32_t accountMaterialsCeiling = 1000;
        uint32_t accountCurrencyCeiling = 500;
        uint64_t accountCeilingPeriodSeconds = 86400;

        uint32_t ActionBasePoints(EventAction action) const override { return actionPoints[static_cast<size_t>(action)]; }
        uint32_t HealUnitsPerPoint() const override { return healUnitsPerPoint; }
        uint32_t HealMaxPoints() const override { return healMaxPoints; }

        uint32_t HourlyCap() const override { return hourlyCap; }
        uint64_t HourWindowSeconds() const override { return hourWindowSeconds; }
        double EventDrSlope() const override { return eventDrSlope; }
        double EventDrFloor() const override { return eventDrFloor; }
        uint64_t DayWindowSeconds() const override { return dayWindowSeconds; }
        uint32_t LeechDamageFloor() const override { return leechDamageFloor; }
        uint32_t LeechActionFloor() const override { return leechActionFloor; }

        uint32_t BronzeThreshold() const override { return bronzeThreshold; }
        uint32_t SilverThreshold() const override { return silverThreshold; }
        uint32_t GoldThreshold() const override { return goldThreshold; }

        uint32_t AllowedCategoryMask(EventType type) const override { return allowedCategoryMask[static_cast<size_t>(type)]; }
        uint32_t AccountMaterialsCeiling() const override { return accountMaterialsCeiling; }
        uint32_t AccountCurrencyCeiling() const override { return accountCurrencyCeiling; }
        uint64_t AccountCeilingPeriodSeconds() const override { return accountCeilingPeriodSeconds; }
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKECONTRIBUTIONCONFIG_H
