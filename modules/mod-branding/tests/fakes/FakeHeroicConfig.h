#ifndef MOD_BRANDING_TESTS_FAKES_FAKEHEROICCONFIG_H
#define MOD_BRANDING_TESTS_FAKES_FAKEHEROICCONFIG_H

#include "branding/scaling/HeroicConfig.h"

namespace Branding::Test
{
    // Pinned, tweakable heroic config for deterministic tests.
    class FakeHeroicConfig : public IHeroicConfig
    {
    public:
        double heroicHealthMul = 2.0;
        double heroicDamageMul = 1.5;
        uint8_t heroicTierBonus = 1;

        double HeroicHealthMul() const override { return heroicHealthMul; }
        double HeroicDamageMul() const override { return heroicDamageMul; }
        uint8_t HeroicTierBonus() const override { return heroicTierBonus; }
    };
}

#endif // MOD_BRANDING_TESTS_FAKES_FAKEHEROICCONFIG_H
