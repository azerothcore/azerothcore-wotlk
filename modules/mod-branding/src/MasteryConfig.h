#ifndef MOD_BRANDING_SRC_MASTERYCONFIG_H
#define MOD_BRANDING_SRC_MASTERYCONFIG_H

#include "branding/mastery/Mastery.h"
#include <cstdint>

namespace Branding
{
    // Production IMasteryConfig: snapshots the §14 mastery tunables from sConfigMgr at load time.
    // The pure core reads no globals; this adapter is the only place sConfigMgr is touched here.
    class MasteryConfig : public IMasteryConfig
    {
    public:
        void Load();
        bool Enabled() const { return _enabled; }

        uint8_t MaxMasteryLevel() const override { return _maxLevel; }
        double MaxBonus() const override { return _maxBonus; }

    private:
        bool _enabled = false;
        uint8_t _maxLevel = 50;
        double _maxBonus = 0.20;
    };
}

#endif // MOD_BRANDING_SRC_MASTERYCONFIG_H
