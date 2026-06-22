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
    }
}
