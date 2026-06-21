#include "AddonProtocolMgr.h"
#include "EventMgr.h"
#include "contribution/ContributionTypes.h"
#include "mod_branding_loader.h"

#include "Player.h"
#include "ScriptMgr.h"
#include "WorldSessionMgr.h"

using namespace Branding;

// §19.3 transport adapter (server-push only): load config, push on login / zone change, and a
// throttled world tick that refreshes live containment (and, more slowly, the character snapshot).
class BrandingAddonWorldScript : public WorldScript
{
public:
    BrandingAddonWorldScript() : WorldScript("BrandingAddonWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sAddonProtocolMgr->LoadConfig();
    }

    void OnUpdate(uint32 diff) override
    {
        if (!sAddonProtocolMgr->Enabled())
            return;

        uint32 const interval = sAddonProtocolMgr->PushIntervalMs();
        _timer += diff;
        if (_timer < interval)
            return;
        _timer = 0;

        // Every SLOW_REFRESH_TICKS fast ticks, also re-push the slower-changing CHAR + SCHED frames.
        bool const slowRefresh = (++_tick % SLOW_REFRESH_TICKS) == 0;

        for (auto const& pair : sWorldSessionMgr->GetAllSessions())
        {
            Player* player = pair.second ? pair.second->GetPlayer() : nullptr;
            if (!player || !player->IsInWorld())
                continue;

            uint32 const zone = player->GetZoneId();
            EventType type;
            if (sEventMgr->ActiveEventType(zone, type))
                sAddonProtocolMgr->SendZoneEvent(player, zone);   // live containment

            if (slowRefresh)
            {
                sAddonProtocolMgr->SendCharSnapshot(player);
                sAddonProtocolMgr->SendSchedule(player);
            }
        }
    }

private:
    static constexpr uint32 SLOW_REFRESH_TICKS = 6;   // CHAR/SCHED refresh = 6 x push interval
    uint32 _timer = 0;
    uint32 _tick = 0;
};

class BrandingAddonPlayerScript : public PlayerScript
{
public:
    BrandingAddonPlayerScript() : PlayerScript("BrandingAddonPlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        sAddonProtocolMgr->SendLoginSnapshot(player);
    }

    void OnPlayerUpdateZone(Player* player, uint32 newZone, uint32 /*newArea*/) override
    {
        sAddonProtocolMgr->SendZoneEvent(player, newZone);
        sAddonProtocolMgr->SendSchedule(player);
    }
};

void AddBrandingAddonScripts()
{
    new BrandingAddonWorldScript();
    new BrandingAddonPlayerScript();
}
