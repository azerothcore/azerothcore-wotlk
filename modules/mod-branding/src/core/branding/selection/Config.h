#ifndef MOD_BRANDING_CORE_SELECTION_CONFIG_H
#define MOD_BRANDING_CORE_SELECTION_CONFIG_H

#include <cstdint>

namespace Branding
{
    // Injected tunables for the active-school switch fee (§14.13.2). The pure core reads no globals;
    // production wraps sConfigMgr, tests inject a fake with pinned values so the curve is deterministic.
    class ISelectionConfig
    {
    public:
        virtual ~ISelectionConfig() = default;

        // Gold tuition (copper) for the FIRST switch (recentSwitches == 0).
        virtual uint64_t TuitionBase() const = 0;
        // Geometric escalation factor per recent switch (>= 1.0 keeps the curve non-decreasing).
        virtual double TuitionFactor() const = 0;
        // Upper bound (copper) the tuition is clamped to, however many recent switches.
        virtual uint64_t TuitionCap() const = 0;
        // After this many days with no switch, the recent-switch counter decays back to 0.
        virtual uint32_t SwitchDecayDays() const = 0;
    };
}

#endif // MOD_BRANDING_CORE_SELECTION_CONFIG_H
