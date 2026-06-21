#include "EventScheduler.h"
#include "EventMgr.h"
#include "Configuration/Config.h"
#include "DatabaseEnv.h"
#include "Field.h"
#include "QueryResult.h"

namespace Branding
{
    EventScheduler* EventScheduler::instance()
    {
        static EventScheduler mgr;
        return &mgr;
    }

    void EventScheduler::LoadConfig()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Event.SchedulerEnable", false);

        // Stop anything we had running, then rebuild the schedule from the table.
        for (Scheduled const& s : _zones)
            if (s.active)
                sEventMgr->StopEvent(s.zoneId);
        _zones.clear();

        QueryResult result = WorldDatabase.Query(
            "SELECT `zone_id`, `event_type`, `goal`, `active_seconds`, `cooldown_seconds` FROM `branding_event_def`");
        if (!result)
            return;

        do
        {
            Field* fields = result->Fetch();
            uint8 const type = fields[1].Get<uint8>();
            if (type >= static_cast<uint8>(EventType::COUNT))
                continue;

            Scheduled s;
            s.zoneId = fields[0].Get<uint32>();
            s.type = static_cast<EventType>(type);
            s.goal = fields[2].Get<uint32>();
            s.activeMs = fields[3].Get<uint32>() * 1000;
            s.cooldownMs = fields[4].Get<uint32>() * 1000;
            s.active = false;
            s.timerMs = s.cooldownMs;   // start in cooldown
            _zones.push_back(s);
        } while (result->NextRow());
    }

    void EventScheduler::Update(uint32_t diffMs)
    {
        if (!_enabled)
            return;

        for (Scheduled& s : _zones)
        {
            // Resolve early on full containment (§9.6), then enter cooldown.
            if (s.active && sEventMgr->Containment(s.zoneId) >= 1.0)
            {
                sEventMgr->StopEvent(s.zoneId);
                s.active = false;
                s.timerMs = s.cooldownMs;
                continue;
            }

            if (s.timerMs > diffMs)
            {
                s.timerMs -= diffMs;
                continue;
            }

            // Phase boundary: toggle active/cooldown.
            if (s.active)
            {
                sEventMgr->StopEvent(s.zoneId);
                s.active = false;
                s.timerMs = s.cooldownMs;
            }
            else
            {
                sEventMgr->StartEvent(s.zoneId, s.type, s.goal);
                s.active = true;
                s.timerMs = s.activeMs;
            }
        }
    }
}
