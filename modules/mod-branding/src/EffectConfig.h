#ifndef MOD_BRANDING_SRC_EFFECTCONFIG_H
#define MOD_BRANDING_SRC_EFFECTCONFIG_H

#include "effects/EffectConfig.h"
#include "common/Brand.h"
#include <array>
#include <cstddef>

namespace Branding
{
    // Production IEffectConfig over sConfigMgr (§7.9 magnitude caps + role asymmetry).
    class EffectConfig : public IEffectConfig
    {
    public:
        void Load();
        bool Enabled() const { return _enabled; }

        double MaxPersonalMul() const override { return _maxPersonalMul; }
        double MaxRaidMul() const override { return _maxRaidMul; }
        uint8_t MaxEffectLevel() const override { return _maxEffectLevel; }
        double RolePersonalScale(RoleContribution role) const override { return _roleScale[static_cast<size_t>(role)]; }

    private:
        bool _enabled = false;
        double _maxPersonalMul = 3.5;   // large (fantasy)
        double _maxRaidMul = 2.0;       // bounded (desirability, not mandate)
        uint8_t _maxEffectLevel = 50;
        // None, Tank, Healer, Damage, Control, Support -- tank highest (dramatic), dps restrained.
        std::array<double, static_cast<size_t>(RoleContribution::COUNT)> _roleScale{ { 0.5, 1.0, 0.7, 0.5, 0.6, 0.6 } };
    };
}

#endif // MOD_BRANDING_SRC_EFFECTCONFIG_H
