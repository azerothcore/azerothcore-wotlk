#include "BrandingConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void BrandingConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Enable", false);

        _matchBonus = sConfigMgr->GetOption<float>("Branding.Xp.MatchBonus", 1.25f);
        _drSoftCap = sConfigMgr->GetOption<uint32>("Branding.Xp.DrSoftCap", 50000);
        _drFloor = sConfigMgr->GetOption<float>("Branding.Xp.DrFloor", 0.1f);
        _drSlope = sConfigMgr->GetOption<float>("Branding.Xp.DrSlope", 0.00001f);
        _drWindowSeconds = sConfigMgr->GetOption<uint32>("Branding.Xp.DrWindowSeconds", 3600);

        _baseXp = sConfigMgr->GetOption<float>("Branding.Level.BaseXp", 100.0f);
        _exponent = sConfigMgr->GetOption<float>("Branding.Level.Exponent", 2.0f);
        _maxLevel = static_cast<uint8_t>(sConfigMgr->GetOption<uint32>("Branding.Level.Max", 50));
    }
}
