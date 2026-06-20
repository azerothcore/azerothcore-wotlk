#ifndef MOD_BRANDING_CORE_CONTRIBUTION_CONTRIBUTIONCONFIG_H
#define MOD_BRANDING_CORE_CONTRIBUTION_CONTRIBUTIONCONFIG_H

#include "ContributionTypes.h"
#include <cstdint>

namespace Branding
{
    // Injected tunables for the dynamic-event contribution engine (§9). Pure core reads no globals.
    class IContributionConfig
    {
    public:
        virtual ~IContributionConfig() = default;

        // --- §9.2 scoring ---
        virtual uint32_t ActionBasePoints(EventAction action) const = 0;
        virtual uint32_t HealUnitsPerPoint() const = 0;   // heal magnitude per extra point
        virtual uint32_t HealMaxPoints() const = 0;       // heal points capped here (1..max)

        // --- §9.3 guardrails ---
        virtual uint32_t HourlyCap() const = 0;           // max points credited per rolling hour
        virtual uint64_t HourWindowSeconds() const = 0;
        virtual double EventDrSlope() const = 0;          // per-repeat decay of same-event-type points
        virtual double EventDrFloor() const = 0;          // DR multiplier never drops below this
        virtual uint64_t DayWindowSeconds() const = 0;
        virtual uint32_t LeechDamageFloor() const = 0;    // anti-leech activity floors
        virtual uint32_t LeechActionFloor() const = 0;

        // --- §9.4 reward tiers ---
        virtual uint32_t BronzeThreshold() const = 0;
        virtual uint32_t SilverThreshold() const = 0;
        virtual uint32_t GoldThreshold() const = 0;
    };
}

#endif // MOD_BRANDING_CORE_CONTRIBUTION_CONTRIBUTIONCONFIG_H
