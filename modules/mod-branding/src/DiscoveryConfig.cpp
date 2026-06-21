#include "DiscoveryConfig.h"
#include "Configuration/Config.h"
#include "ObjectMgr.h"

namespace Branding
{
    void DiscoveryConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Discovery.Enable", false);
        _subzonePct = sConfigMgr->GetOption<float>("Branding.Discovery.SubzonePct", 0.06f);
        _landmarkPct = sConfigMgr->GetOption<float>("Branding.Discovery.LandmarkPct", 0.08f);
        _hiddenPct = sConfigMgr->GetOption<float>("Branding.Discovery.HiddenPct", 0.12f);
        _dangerThreshold = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Discovery.DangerThreshold", 5));
        _dangerMultiplier = sConfigMgr->GetOption<float>("Branding.Discovery.DangerMultiplier", 2.0f);
        _commonMax = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Discovery.CommonMaxLevel", 20));
        _uncommonMax = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Discovery.UncommonMaxLevel", 40));
        _rareMax = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Discovery.RareMaxLevel", 60));
    }

    uint64_t DiscoveryConfig::XpToNextLevel(uint8_t playerLevel) const
    {
        return sObjectMgr->GetXPForLevel(playerLevel);
    }
}
