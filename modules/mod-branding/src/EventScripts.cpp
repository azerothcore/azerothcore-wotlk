#include "EventMgr.h"
#include "mod_branding_loader.h"
#include "Creature.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

// Loads/refreshes event config on startup and on `.reload config`, and periodically flushes the
// cached participation/economy state to the DB (§9.3#5) so a crash loses at most one interval.
class BrandingEventWorldScript : public WorldScript
{
public:
    BrandingEventWorldScript() : WorldScript("BrandingEventWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sEventMgr->LoadConfig();
    }

    void OnUpdate(uint32 diff) override
    {
        if (!sEventMgr->Enabled())
            return;

        _flushTimer += diff;
        if (_flushTimer < FLUSH_INTERVAL_MS)
            return;

        _flushTimer = 0;
        sEventMgr->FlushAll();
    }

private:
    static constexpr uint32 FLUSH_INTERVAL_MS = 5u * 60u * 1000u;   // periodic persistence flush
    uint32 _flushTimer = 0;
};

// §9 capture: a kill in a zone with an active event scores through the full contribution engine
// (anti-leech, daily DR, hourly cap). Reward delivery is deferred -- progress is observable via
// `.branding event status`.
class BrandingEventPlayerScript : public PlayerScript
{
public:
    BrandingEventPlayerScript() : PlayerScript("BrandingEventPlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        sEventMgr->LoadPlayer(player);
    }

    void OnPlayerCreatureKill(Player* killer, Creature* killed) override
    {
        if (!killer || !killed || !sEventMgr->Enabled())
            return;

        sEventMgr->CaptureKill(killer->GetGUID(), killer->GetZoneId(), killed->isElite(), killed->isWorldBoss());
    }

    void OnPlayerLogout(Player* player) override
    {
        if (!player)
            return;

        sEventMgr->SavePlayer(player);
        sEventMgr->Unload(player->GetGUID());
    }
};

void AddBrandingEventScripts()
{
    new BrandingEventWorldScript();
    new BrandingEventPlayerScript();
}
