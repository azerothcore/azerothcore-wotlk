#ifndef MOD_BRANDING_SRC_CATALYSTCONFIG_H
#define MOD_BRANDING_SRC_CATALYSTCONFIG_H

#include "branding/catalyst/CatalystConfig.h"

namespace Branding
{
    // Production ICatalystConfig over sConfigMgr (§7.9 / §9 catalyst stacking DR).
    class CatalystConfig : public ICatalystConfig
    {
    public:
        void Load();
        bool Enabled() const { return _enabled; }

        double MaxRaidMul() const override { return _maxRaidMul; }
        double StackDecay() const override { return _stackDecay; }

    private:
        bool _enabled = false;
        double _maxRaidMul = 2.0;
        double _stackDecay = 0.4;   // 1st full, 2nd 0.4, 3rd 0.16 (heavily reduced)
    };
}

#endif // MOD_BRANDING_SRC_CATALYSTCONFIG_H
