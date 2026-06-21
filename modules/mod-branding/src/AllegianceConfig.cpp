#include "AllegianceConfig.h"
#include "Configuration/Config.h"

namespace Branding
{
    void AllegianceConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Allegiance.Enable", false);
        _matchEfficiency = sConfigMgr->GetOption<float>("Branding.Allegiance.MatchEfficiency", 1.15f);

        // Defense-in-depth: allegiance is soft (§12) and must never become a penalty. Clamp any
        // misconfigured value back to neutral so a match is never worse than a mismatch.
        if (_matchEfficiency < 1.0)
            _matchEfficiency = 1.0;
    }
}
