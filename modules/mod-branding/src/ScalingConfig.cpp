#include "ScalingConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void ScalingConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Scaling.Enable", false);
        _exponent = sConfigMgr->GetOption<float>("Branding.Scaling.Exponent", 2.0f);

        // Group-scaling dials (reserved for the future group-scaling adapter).
        _groupHealthFloor = sConfigMgr->GetOption<float>("Branding.Scaling.GroupHealthFloor", 0.3f);
        _groupDamageFloor = sConfigMgr->GetOption<float>("Branding.Scaling.GroupDamageFloor", 0.6f);
        _maxGroupMaterials = sConfigMgr->GetOption<uint32_t>("Branding.Scaling.MaxGroupMaterials", 20);
        _maxRewardTier = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Scaling.MaxRewardTier", 4));
        _rareChanceMulMin = sConfigMgr->GetOption<float>("Branding.Scaling.RareChanceMulMin", 0.5f);
        _rareChanceMulMax = sConfigMgr->GetOption<float>("Branding.Scaling.RareChanceMulMax", 2.0f);

        // Branding-currency reduction (§2.4.3): currency falls off steeper than gear.
        _currencyReductionExponent = sConfigMgr->GetOption<float>("Branding.Scaling.CurrencyReductionExponent", 2.0f);
        _currencyMulFloor = sConfigMgr->GetOption<float>("Branding.Scaling.CurrencyMulFloor", 0.05f);
    }
}
