#include "EventScheduler.h"
#include "mod_branding_loader.h"
#include "Player.h"
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

// Re-assert an active event's spawn group when a player enters its zone (covers the case where the
// map was empty at the start transition, so the initial spawn was skipped).
class BrandingEventSchedulerPlayerScript : public PlayerScript
{
public:
    BrandingEventSchedulerPlayerScript() : PlayerScript("BrandingEventSchedulerPlayerScript") { }

    void OnPlayerUpdateZone(Player* player, uint32 newZone, uint32 /*newArea*/) override
    {
        if (player)
            sEventScheduler->EnsureSpawnedForZone(newZone);
    }
};

void AddBrandingEventSchedulerScripts()
{
    new BrandingEventSchedulerWorldScript();
    new BrandingEventSchedulerPlayerScript();
}
