#include "EffectConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void EffectConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Effect.Enable", false);
        _maxPersonalMul = sConfigMgr->GetOption<float>("Branding.Effect.MaxPersonalMul", 3.5f);
        _maxRaidMul = sConfigMgr->GetOption<float>("Branding.Effect.MaxRaidMul", 2.0f);
        _maxEffectLevel = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Effect.MaxEffectLevel", 50));
        _maxOverhealShieldFraction = sConfigMgr->GetOption<float>("Branding.Effect.MaxOverhealShieldFraction", 0.30f);

        // §7.11 leveling-scoped branding (issue #77).
        _levelingEnabled = sConfigMgr->GetOption<bool>("Branding.Leveling.Enable", true);
        _maxLevelingMul = sConfigMgr->GetOption<float>("Branding.Leveling.MaxLevelingMul", 4.0f);
        _levelingStandingScale = sConfigMgr->GetOption<float>("Branding.Leveling.StandingScale", 0.5f);
        _maxCharacterLevel = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Leveling.MaxCharacterLevel", 80));
        _levelingGrantsTransforms = sConfigMgr->GetOption<bool>("Branding.Leveling.GrantTransforms", true);
    }
}
