#include "CatalystMgr.h"
#include "mod_branding_loader.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes catalyst config on startup and on `.reload config`.
class BrandingCatalystWorldScript : public WorldScript
{
public:
    BrandingCatalystWorldScript() : WorldScript("BrandingCatalystWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sCatalystMgr->LoadConfig();
    }
};

void AddBrandingCatalystScripts()
{
    new BrandingCatalystWorldScript();
}
