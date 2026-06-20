#ifndef MOD_BRANDING_SRC_EVENTCONFIG_H
#define MOD_BRANDING_SRC_EVENTCONFIG_H

#include "contribution/ContributionConfig.h"
#include "contribution/ContributionTypes.h"
#include <array>
#include <cstddef>

namespace Branding
{
    // Production IContributionConfig over sConfigMgr. Defaults mirror the §9.2 table; the most
    // commonly-tuned dials are read from config, the rest use sensible defaults.
    class EventConfig : public IContributionConfig
    {
    public:
        void Load();
        bool Enabled() const { return _enabled; }

        // Adapter-specific (not part of IContributionConfig): item granted for CraftingMats rewards.
        uint32_t RewardMaterialItem() const { return _rewardMaterialItem; }

        uint32_t ActionBasePoints(EventAction action) const override { return _actionPoints[static_cast<size_t>(action)]; }
        uint32_t HealUnitsPerPoint() const override { return _healUnitsPerPoint; }
        uint32_t HealMaxPoints() const override { return _healMaxPoints; }

        uint32_t HourlyCap() const override { return _hourlyCap; }
        uint64_t HourWindowSeconds() const override { return _hourWindowSeconds; }
        double EventDrSlope() const override { return _eventDrSlope; }
        double EventDrFloor() const override { return _eventDrFloor; }
        uint64_t DayWindowSeconds() const override { return _dayWindowSeconds; }
        uint32_t LeechDamageFloor() const override { return _leechDamageFloor; }
        uint32_t LeechActionFloor() const override { return _leechActionFloor; }

        uint32_t BronzeThreshold() const override { return _bronze; }
        uint32_t SilverThreshold() const override { return _silver; }
        uint32_t GoldThreshold() const override { return _gold; }

        uint32_t AllowedCategoryMask(EventType type) const override { return _allowedCategoryMask[static_cast<size_t>(type)]; }
        uint32_t AccountMaterialsCeiling() const override { return _accountMaterialsCeiling; }
        uint32_t AccountCurrencyCeiling() const override { return _accountCurrencyCeiling; }
        uint64_t AccountCeilingPeriodSeconds() const override { return _accountCeilingPeriodSeconds; }

    private:
        bool _enabled = false;
        std::array<uint32_t, static_cast<size_t>(EventAction::COUNT)> _actionPoints{ { 1, 5, 15, 1, 2, 10, 8 } };
        uint32_t _healUnitsPerPoint = 5000;
        uint32_t _healMaxPoints = 3;

        uint32_t _hourlyCap = 100000;
        uint64_t _hourWindowSeconds = 3600;
        double _eventDrSlope = 0.1;
        double _eventDrFloor = 0.1;
        uint64_t _dayWindowSeconds = 86400;
        uint32_t _leechDamageFloor = 100;
        uint32_t _leechActionFloor = 1;

        uint32_t _bronze = 50;
        uint32_t _silver = 150;
        uint32_t _gold = 400;

        std::array<uint32_t, static_cast<size_t>(EventType::COUNT)> _allowedCategoryMask{ { 21u, 3u, 28u, 11u } };
        uint32_t _accountMaterialsCeiling = 1000;
        uint32_t _accountCurrencyCeiling = 500;
        uint64_t _accountCeilingPeriodSeconds = 86400;

        uint32_t _rewardMaterialItem = 2589;   // Linen Cloth (placeholder reward material)
    };
}

#endif // MOD_BRANDING_SRC_EVENTCONFIG_H
