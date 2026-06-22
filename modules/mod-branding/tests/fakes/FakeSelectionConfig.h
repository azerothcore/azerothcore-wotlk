#ifndef MOD_BRANDING_TESTS_FAKES_FAKESELECTIONCONFIG_H
#define MOD_BRANDING_TESTS_FAKES_FAKESELECTIONCONFIG_H

#include "branding/selection/Config.h"

namespace Branding::Test
{
    // Pinned, tweakable selection config for deterministic tuition-curve tests.
    class FakeSelectionConfig : public ISelectionConfig
    {
    public:
        uint64_t tuitionBase = 10000;       // 1 gold
        double tuitionFactor = 2.0;
        uint64_t tuitionCap = 1000000;      // 100 gold
        uint32_t switchDecayDays = 7;

        uint64_t TuitionBase() const override { return tuitionBase; }
        double TuitionFactor() const override { return tuitionFactor; }
        uint64_t TuitionCap() const override { return tuitionCap; }
        uint32_t SwitchDecayDays() const override { return switchDecayDays; }
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKESELECTIONCONFIG_H
