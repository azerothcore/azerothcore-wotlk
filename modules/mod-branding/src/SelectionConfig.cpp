#include "SelectionConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void SelectionConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Selection.Enable", false);
        _tuitionBase = sConfigMgr->GetOption<uint64_t>("Branding.Selection.TuitionBase", 100000);
        _tuitionFactor = sConfigMgr->GetOption<float>("Branding.Selection.TuitionFactor", 2.0f);
        _tuitionCap = sConfigMgr->GetOption<uint64_t>("Branding.Selection.TuitionCap", 5000000);
        _switchDecayDays = sConfigMgr->GetOption<uint32_t>("Branding.Selection.SwitchDecayDays", 7);
    }
}
