#ifndef MOD_BRANDING_SRC_BRANDINGCONFIG_H
#define MOD_BRANDING_SRC_BRANDINGCONFIG_H

#include "branding/common/Config.h"
#include <array>
#include <cstddef>

namespace Branding
{
    // Production IBrandingConfig: snapshots tunables from sConfigMgr at load time. The pure core
    // reads no globals; this adapter is the only place sConfigMgr is touched for branding tunables.
    class BrandingConfig : public IBrandingConfig
    {
    public:
        // (Re)reads all options from sConfigMgr. Call on startup and on config reload.
        void Load();

        bool Enabled() const { return _enabled; }

        double SourceWeight(ActivitySource source) const override { return _sourceWeight[static_cast<size_t>(source)]; }
        double RelevanceMul(ActivitySource source) const override { return _relevance[static_cast<size_t>(source)]; }
        double MatchBonus() const override { return _matchBonus; }
        double RoleMul(RoleContribution role) const override { return _roleMul[static_cast<size_t>(role)]; }

        uint32_t DrSoftCap() const override { return _drSoftCap; }
        double DrFloor() const override { return _drFloor; }
        double DrSlope() const override { return _drSlope; }
        uint64_t DrWindowSeconds() const override { return _drWindowSeconds; }

        double BaseXp() const override { return _baseXp; }
        double Exponent() const override { return _exponent; }
        uint8_t MaxLevel() const override { return _maxLevel; }

    private:
        bool _enabled = false;
        std::array<double, static_cast<size_t>(ActivitySource::COUNT)> _sourceWeight{ { 1.0, 1.0, 0.8, 0.5, 0.5, 0.7 } };
        std::array<double, static_cast<size_t>(ActivitySource::COUNT)> _relevance{ { 1.0, 1.0, 0.9, 0.5, 0.6, 0.8 } };
        std::array<double, static_cast<size_t>(RoleContribution::COUNT)> _roleMul{ { 1.0, 1.0, 1.0, 1.0, 1.1, 1.1 } };
        double _matchBonus = 1.25;
        uint32_t _drSoftCap = 50000;
        double _drFloor = 0.1;
        double _drSlope = 0.00001;
        uint64_t _drWindowSeconds = 3600;
        double _baseXp = 100.0;
        double _exponent = 2.0;
        uint8_t _maxLevel = 50;
    };
}

#endif // MOD_BRANDING_SRC_BRANDINGCONFIG_H
