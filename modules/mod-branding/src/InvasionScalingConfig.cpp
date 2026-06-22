#include "InvasionScalingConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void InvasionScalingConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Invasion.ScalingEnable", false);
        _intendedSize = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Invasion.IntendedSize", 40));
        _decaySeconds = sConfigMgr->GetOption<uint32_t>("Branding.Invasion.CrowdDecaySeconds", 60);
        _trashMaxMul = sConfigMgr->GetOption<float>("Branding.Invasion.TrashMaxMul", 1.5f);
        _trashExponent = sConfigMgr->GetOption<float>("Branding.Invasion.TrashExponent", 2.0f);
        _tierReleaseMargin = sConfigMgr->GetOption<uint32_t>("Branding.Invasion.TierReleaseMargin", 3);
    }
}
