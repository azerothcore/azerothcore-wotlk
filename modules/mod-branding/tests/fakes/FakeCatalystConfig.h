#ifndef MOD_BRANDING_TESTS_FAKES_FAKECATALYSTCONFIG_H
#define MOD_BRANDING_TESTS_FAKES_FAKECATALYSTCONFIG_H

#include "branding/catalyst/CatalystConfig.h"

namespace Branding::Test
{
    class FakeCatalystConfig : public ICatalystConfig
    {
    public:
        double maxRaidMul = 2.0;
        double stackDecay = 0.4;

        double MaxRaidMul() const override { return maxRaidMul; }
        double StackDecay() const override { return stackDecay; }
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKECATALYSTCONFIG_H
