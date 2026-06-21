#ifndef MOD_BRANDING_SRC_ALLEGIANCECONFIG_H
#define MOD_BRANDING_SRC_ALLEGIANCECONFIG_H

#include "allegiance/Allegiance.h"

namespace Branding
{
    // Production IAllegianceConfig: snapshots the allegiance tunables from sConfigMgr at load time.
    // The pure core reads no globals; this adapter is the only place sConfigMgr is touched for the
    // allegiance system, keeping AllegianceEfficiency deterministic and unit-testable.
    class AllegianceConfig : public IAllegianceConfig
    {
    public:
        void Load();
        bool Enabled() const { return _enabled; }

        double MatchEfficiency() const override { return _matchEfficiency; }

    private:
        bool _enabled = false;
        double _matchEfficiency = 1.15;
    };
}

#endif // MOD_BRANDING_SRC_ALLEGIANCECONFIG_H
