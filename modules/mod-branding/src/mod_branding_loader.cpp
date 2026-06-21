#include "mod_branding_loader.h"

// Single entrypoint the modules loader calls (Add<dir-with-underscores>Scripts). Fans out to each
// feature's registration so features stay in their own translation units.
void Addmod_brandingScripts()
{
    AddBrandingProficiencyScripts();
    AddBrandingDiscoveryScripts();
    AddBrandingScalingScripts();
    AddBrandingEventScripts();
    AddBrandingLoadoutScripts();
    AddBrandingVaultScripts();
    AddBrandingMasteryScripts();
    AddBrandingAllegianceScripts();
    AddBrandingEconomyScripts();
    AddBrandingDiscoverableScripts();
    AddBrandingEffectScripts();
    AddBrandingCommandScripts();
}
