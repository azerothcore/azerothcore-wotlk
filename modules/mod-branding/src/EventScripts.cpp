#include "EventMgr.h"
#include "mod_branding_loader.h"
#include "Creature.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes event config on startup and on `.reload config`.
class BrandingEventWorldScript : public WorldScript
{
public:
    BrandingEventWorldScript() : WorldScript("BrandingEventWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sEventMgr->LoadConfig();
    }
};

// §9 capture: a kill in a zone with an active event scores through the full contribution engine
// (anti-leech, daily DR, hourly cap). Reward delivery is deferred -- progress is observable via
// `.branding event status`.
class BrandingEventPlayerScript : public PlayerScript
{
public:
    BrandingEventPlayerScript() : PlayerScript("BrandingEventPlayerScript") { }

    void OnPlayerCreatureKill(Player* killer, Creature* killed) override
    {
        if (!killer || !killed || !sEventMgr->Enabled())
            return;

        sEventMgr->CaptureKill(killer->GetGUID(), killer->GetZoneId(), killed->isElite(), killed->isWorldBoss());
    }

    void OnPlayerLogout(Player* player) override
    {
        if (player)
            sEventMgr->Unload(player->GetGUID());
    }
};

void AddBrandingEventScripts()
{
    new BrandingEventWorldScript();
    new BrandingEventPlayerScript();
}
