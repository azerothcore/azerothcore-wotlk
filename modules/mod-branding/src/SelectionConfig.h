#ifndef MOD_BRANDING_SRC_SELECTIONCONFIG_H
#define MOD_BRANDING_SRC_SELECTIONCONFIG_H

#include "branding/selection/Config.h"

namespace Branding
{
    // Production ISelectionConfig: snapshots the active-school switch-fee tunables from sConfigMgr at
    // load time (§14.13.2). The pure core reads no globals; this adapter is the only place sConfigMgr
    // is touched for selection tunables.
    class SelectionConfig : public ISelectionConfig
    {
    public:
        // (Re)reads all options from sConfigMgr. Call on startup and on config reload.
        void Load();

        bool Enabled() const { return _enabled; }

        uint64_t TuitionBase() const override { return _tuitionBase; }
        double TuitionFactor() const override { return _tuitionFactor; }
        uint64_t TuitionCap() const override { return _tuitionCap; }
        uint32_t SwitchDecayDays() const override { return _switchDecayDays; }

    private:
        bool _enabled = false;
        uint64_t _tuitionBase = 100000;     // 10 gold
        double _tuitionFactor = 2.0;
        uint64_t _tuitionCap = 5000000;     // 500 gold
        uint32_t _switchDecayDays = 7;
    };
}

#endif // MOD_BRANDING_SRC_SELECTIONCONFIG_H
