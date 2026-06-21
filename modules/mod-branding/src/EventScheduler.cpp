#include "EventScheduler.h"
#include "EventMgr.h"
#include "Configuration/Config.h"
#include "DatabaseEnv.h"
#include "Field.h"
#include "Log.h"
#include "Map.h"
#include "MapMgr.h"
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

        // Stop anything we had running (and despawn its group), then rebuild from the table.
        for (Scheduled const& s : _zones)
            if (s.active)
            {
                sEventMgr->StopEvent(s.zoneId);
                DriveSpawnGroup(s, false);
            }
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

        LoadSpawnGroups();
    }

    void EventScheduler::LoadSpawnGroups()
    {
        // Map each (zone, type) schedule entry to its authored manual spawn group, if any.
        QueryResult result = WorldDatabase.Query(
            "SELECT `zone_id`, `event_type`, `group_id`, `map_id` FROM `branding_event_spawn`");
        if (!result)
            return;     // table absent or empty -- events simply have no authored spawns

        do
        {
            Field* fields = result->Fetch();
            uint32 const zoneId = fields[0].Get<uint32>();
            uint8 const type = fields[1].Get<uint8>();

            for (Scheduled& s : _zones)
            {
                if (s.zoneId != zoneId || static_cast<uint8>(s.type) != type)
                    continue;

                s.spawnGroupId = fields[2].Get<uint32>();
                s.mapId = fields[3].Get<uint16>();
                s.hasSpawnGroup = s.spawnGroupId != 0;
                break;
            }
        } while (result->NextRow());
    }

    void EventScheduler::DriveSpawnGroup(Scheduled const& s, bool spawn)
    {
        if (!s.hasSpawnGroup)
            return;

        // World zones live on the continent's base, non-instance map. If no players are on the
        // continent the map is not instantiated yet -- nothing to (de)spawn, so just skip.
        Map* map = sMapMgr->FindBaseNonInstanceMap(s.mapId);
        if (!map)
            return;

        if (spawn)
            map->SpawnGroupSpawn(s.spawnGroupId, true, true);
        else
            map->SpawnGroupDespawn(s.spawnGroupId, true);

        LOG_DEBUG("module.branding", "EventScheduler: {} spawn group {} on map {} (zone {})",
            spawn ? "spawned" : "despawned", s.spawnGroupId, s.mapId, s.zoneId);
    }

    void EventScheduler::EnsureSpawnedForZone(uint32_t zoneId)
    {
        if (!_enabled)
            return;

        // A zone may host several event types; re-assert every active one. The entering player makes
        // the map live, so DriveSpawnGroup will resolve it (idempotent if the group is already up).
        for (Scheduled const& s : _zones)
            if (s.zoneId == zoneId && s.active && s.hasSpawnGroup)
                DriveSpawnGroup(s, true);
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
                DriveSpawnGroup(s, false);
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
                DriveSpawnGroup(s, false);
                s.active = false;
                s.timerMs = s.cooldownMs;
            }
            else
            {
                sEventMgr->StartEvent(s.zoneId, s.type, s.goal);
                DriveSpawnGroup(s, true);
                s.active = true;
                s.timerMs = s.activeMs;
            }
        }
    }
}
