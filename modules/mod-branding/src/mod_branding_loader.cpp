#include "mod_branding_loader.h"

// Single entrypoint the modules loader calls (Add<dir-with-underscores>Scripts). Fans out to each
// feature's registration so features stay in their own translation units.
void Addmod_brandingScripts()
{
    AddBrandingProficiencyScripts();
    AddBrandingDiscoveryScripts();
    AddBrandingScalingScripts();
    AddBrandingEventScripts();
    AddBrandingEventSchedulerScripts();
    AddBrandingLoadoutScripts();
    AddBrandingVaultScripts();
    AddBrandingMasteryScripts();
    AddBrandingMasteryLoadoutScripts();
    AddBrandingMasteryCombatScripts();
    AddBrandingMasteryEnemyScripts();
    AddBrandingAllegianceScripts();
    AddBrandingEconomyScripts();
    AddBrandingDiscoverableScripts();
    AddBrandingItemScripts();
    AddBrandingEffectScripts();
    AddBrandingCatalystScripts();
    AddBrandingInsightScripts();
    AddBrandingAddonScripts();
    AddBrandingSelectionScripts();
    AddBrandingPostCapXpScripts();
    AddBrandingCommandScripts();
}
