#include "EconomyConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void EconomyConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Economy.Enable", false);
        _materialItem = sConfigMgr->GetOption<uint32_t>("Branding.Economy.MaterialItemId", 190000);
        _fragmentItem = sConfigMgr->GetOption<uint32_t>("Branding.Economy.FragmentItemId", 190001);
    }
}
