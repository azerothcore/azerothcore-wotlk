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

        // §2.5.2: refresh the decayed-peak crowd headcount for every active event. Throttled to
        // ~1s -- the field reacts on a human timescale, not per server tick.
        _sampleTimer += diff;
        if (_sampleTimer >= SAMPLE_INTERVAL_MS)
        {
            _sampleTimer = 0;
            sEventMgr->SampleCrowds();
        }

        _flushTimer += diff;
        if (_flushTimer < FLUSH_INTERVAL_MS)
            return;

        _flushTimer = 0;
        sEventMgr->FlushAll();
    }

private:
    static constexpr uint32 FLUSH_INTERVAL_MS = 5u * 60u * 1000u;   // periodic persistence flush
    static constexpr uint32 SAMPLE_INTERVAL_MS = 1000u;             // crowd-headcount sampling cadence
    uint32 _flushTimer = 0;
    uint32 _sampleTimer = 0;
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

    // §2.5.2: leaving a zone drops the player from its invasion roster; they re-enrol by scoring in
    // whichever zone they move to. (Intra-zone area changes do not fire this hook.)
    void OnPlayerUpdateZone(Player* player, uint32 /*newZone*/, uint32 /*newArea*/) override
    {
        if (player)
            sEventMgr->DropFromRosters(player->GetGUID());
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
