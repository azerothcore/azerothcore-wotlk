#include "CatalystConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void CatalystConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Catalyst.Enable", false);
        _maxRaidMul = sConfigMgr->GetOption<float>("Branding.Catalyst.MaxRaidMul", 2.0f);
        _stackDecay = sConfigMgr->GetOption<float>("Branding.Catalyst.StackDecay", 0.4f);
    }
}
