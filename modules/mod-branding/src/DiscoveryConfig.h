#ifndef MOD_BRANDING_SRC_DISCOVERYCONFIG_H
#define MOD_BRANDING_SRC_DISCOVERYCONFIG_H

#include "economy/Discovery.h"
#include <cstdint>

namespace Branding
{
    // Production IDiscoveryConfig: tunables from sConfigMgr; XP-to-next from the core XP table.
    class DiscoveryConfig : public IDiscoveryConfig
    {
    public:
        void Load();
        bool Enabled() const { return _enabled; }

        uint64_t XpToNextLevel(uint8_t playerLevel) const override;   // wraps sObjectMgr->GetXPForLevel
        double SubzonePct() const override { return _subzonePct; }
        double LandmarkPct() const override { return _landmarkPct; }
        double HiddenPct() const override { return _hiddenPct; }
        uint8_t DangerThreshold() const override { return _dangerThreshold; }
        double DangerMultiplier() const override { return _dangerMultiplier; }
        uint8_t CommonMaxLevel() const override { return _commonMax; }
        uint8_t UncommonMaxLevel() const override { return _uncommonMax; }
        uint8_t RareMaxLevel() const override { return _rareMax; }

    private:
        bool _enabled = false;
        double _subzonePct = 0.06;
        double _landmarkPct = 0.08;
        double _hiddenPct = 0.12;
        uint8_t _dangerThreshold = 5;
        double _dangerMultiplier = 2.0;
        uint8_t _commonMax = 20;
        uint8_t _uncommonMax = 40;
        uint8_t _rareMax = 60;
    };
}

#endif // MOD_BRANDING_SRC_DISCOVERYCONFIG_H
