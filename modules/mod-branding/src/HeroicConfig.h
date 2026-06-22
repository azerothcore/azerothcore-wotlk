#ifndef MOD_BRANDING_SRC_HEROICCONFIG_H
#define MOD_BRANDING_SRC_HEROICCONFIG_H

#include "branding/scaling/HeroicConfig.h"
#include <cstdint>

namespace Branding
{
    // Production IHeroicConfig over sConfigMgr for the heroic overlay (§2.4).
    class HeroicConfig : public IHeroicConfig
    {
    public:
        void Load();
        bool Enabled() const { return _enabled; }
        uint8_t LevelCap() const { return _levelCap; }

        // Instanced boss-reward trigger (§2.4, issue #26) -- opt-in, separate from the scaling gate.
        bool BossRewardEnabled() const { return _bossRewardEnable; }
        double BossRewardCurrencyMultiplier() const { return _bossRewardCurrencyMul; }

        double HeroicHealthMul() const override { return _healthMul; }
        double HeroicDamageMul() const override { return _damageMul; }
        uint8_t HeroicTierBonus() const override { return _tierBonus; }

    private:
        bool _enabled = false;
        uint8_t _levelCap = 80;
        double _healthMul = 2.0;
        double _damageMul = 1.5;
        uint8_t _tierBonus = 1;
        bool _bossRewardEnable = false;
        double _bossRewardCurrencyMul = 1.0;
    };
}

#endif // MOD_BRANDING_SRC_HEROICCONFIG_H
