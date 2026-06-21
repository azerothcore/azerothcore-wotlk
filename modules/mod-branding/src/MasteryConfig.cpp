#include "MasteryConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void MasteryConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Mastery.Enable", false);
        _maxLevel = static_cast<uint8_t>(sConfigMgr->GetOption<uint32_t>("Branding.Mastery.MaxLevel", 50));
        _maxBonus = sConfigMgr->GetOption<float>("Branding.Mastery.MaxBonus", 0.20f);
    }
}
