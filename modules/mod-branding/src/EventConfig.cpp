#include "EventConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void EventConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Event.Enable", false);
        _hourlyCap = sConfigMgr->GetOption<uint32_t>("Branding.Event.HourlyCap", 100000);
        _eventDrSlope = sConfigMgr->GetOption<float>("Branding.Event.DrSlope", 0.1f);
        _eventDrFloor = sConfigMgr->GetOption<float>("Branding.Event.DrFloor", 0.1f);
        _bronze = sConfigMgr->GetOption<uint32_t>("Branding.Event.BronzeThreshold", 50);
        _silver = sConfigMgr->GetOption<uint32_t>("Branding.Event.SilverThreshold", 150);
        _gold = sConfigMgr->GetOption<uint32_t>("Branding.Event.GoldThreshold", 400);
        _rewardMaterialItem = sConfigMgr->GetOption<uint32_t>("Branding.Event.RewardItemId", 190000);
    }
}
