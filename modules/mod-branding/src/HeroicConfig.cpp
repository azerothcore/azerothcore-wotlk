#include "HeroicConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void HeroicConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Heroic.Enable", false);
        _levelCap = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Heroic.LevelCap", 80));
        _healthMul = sConfigMgr->GetOption<float>("Branding.Heroic.HealthMul", 2.0f);
        _damageMul = sConfigMgr->GetOption<float>("Branding.Heroic.DamageMul", 1.5f);
        _tierBonus = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Heroic.TierBonus", 1));
        _bossRewardEnable = sConfigMgr->GetOption<bool>("Branding.Heroic.BossReward.Enable", false);
        _bossRewardCurrencyMul = sConfigMgr->GetOption<float>("Branding.Heroic.BossReward.CurrencyMultiplier", 1.0f);
    }
}
