#include "EventScheduler.h"
#include "mod_branding_loader.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads the event schedule on startup / `.reload config` and ticks it each world update.
class BrandingEventSchedulerWorldScript : public WorldScript
{
public:
    BrandingEventSchedulerWorldScript() : WorldScript("BrandingEventSchedulerWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sEventScheduler->LoadConfig();
    }

    void OnUpdate(uint32 diff) override
    {
        sEventScheduler->Update(diff);
    }
};

void AddBrandingEventSchedulerScripts()
{
    new BrandingEventSchedulerWorldScript();
}
