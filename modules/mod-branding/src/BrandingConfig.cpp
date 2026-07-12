#include "BrandingConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void BrandingConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Enable", false);

        _matchBonus = sConfigMgr->GetOption<float>("Branding.Xp.MatchBonus", 1.25f);

        _greyFloor = sConfigMgr->GetOption<float>("Branding.Proficiency.GreyFloor", 0.25f);
        _classWeight[static_cast<size_t>(KillClassification::Elite)] =
            sConfigMgr->GetOption<float>("Branding.Proficiency.ClassWeight.Elite", 2.0f);
        _classWeight[static_cast<size_t>(KillClassification::Rare)] =
            sConfigMgr->GetOption<float>("Branding.Proficiency.ClassWeight.Rare", 3.0f);
        _classWeight[static_cast<size_t>(KillClassification::WorldBoss)] =
            sConfigMgr->GetOption<float>("Branding.Proficiency.ClassWeight.WorldBoss", 5.0f);

        _drSoftCap = sConfigMgr->GetOption<uint32_t>("Branding.Xp.DrSoftCap", 50000);
        _drFloor = sConfigMgr->GetOption<float>("Branding.Xp.DrFloor", 0.1f);
        _drSlope = sConfigMgr->GetOption<float>("Branding.Xp.DrSlope", 0.00001f);
        _drWindowSeconds = sConfigMgr->GetOption<uint32_t>("Branding.Xp.DrWindowSeconds", 3600);

        _rankBaseXp = sConfigMgr->GetOption<float>("Branding.Level.RankBaseXp", 1670800.0f);
        _rankGrowth = sConfigMgr->GetOption<float>("Branding.Level.RankGrowth", 1.01f);
        _maxLevel = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Level.Max", 50));
    }
}
