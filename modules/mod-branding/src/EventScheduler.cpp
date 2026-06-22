#include "EventScheduler.h"
#include "AddonProtocolMgr.h"
#include "EventMgr.h"
#include "branding/scaling/InvasionScaling.h"
#include "Configuration/Config.h"
#include "DatabaseEnv.h"
#include "Field.h"
#include "Log.h"
#include "Map.h"
#include "MapMgr.h"
#include "QueryResult.h"
#include <vector>

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
        _invConfig.Load();

        // Stop anything we had running (and despawn its tiers), then rebuild from the table.
        for (Scheduled& s : _zones)
            if (s.active)
            {
                sEventMgr->StopEvent(s.zoneId);
                DespawnAllTiers(s);
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
        // Each (zone, type) owns one Tier per row -- the base tier plus any reinforcement tiers.
        QueryResult result = WorldDatabase.Query(
            "SELECT `zone_id`, `event_type`, `group_id`, `map_id`, `min_participants`, `goal_contribution` "
            "FROM `branding_event_spawn`");
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

                if (s.tiers.size() >= 64)
                    break;      // bitmask ceiling -- far above any authored invasion

                Tier tier;
                tier.groupId = fields[2].Get<uint32>();
                tier.mapId = fields[3].Get<uint16>();
                tier.minParticipants = fields[4].Get<uint32>();
                tier.goalContribution = fields[5].Get<uint32>();
                if (tier.groupId != 0)
                    s.tiers.push_back(tier);
                break;
            }
        } while (result->NextRow());
    }

    void EventScheduler::DriveGroup(uint32_t groupId, uint16_t mapId, uint32_t zoneId, bool spawn)
    {
        // World zones live on the continent's base, non-instance map. If no players are on the
        // continent the map is not instantiated yet -- nothing to (de)spawn, so just skip.
        Map* map = sMapMgr->FindBaseNonInstanceMap(mapId);
        if (!map)
            return;

        if (spawn)
            map->SpawnGroupSpawn(groupId, true, true);
        else
            map->SpawnGroupDespawn(groupId, true);

        LOG_DEBUG("module.branding", "EventScheduler: {} spawn group {} on map {} (zone {})",
            spawn ? "spawned" : "despawned", groupId, mapId, zoneId);
    }

    void EventScheduler::ReconcileTiers(Scheduled& s)
    {
        if (s.tiers.empty())
            return;

        std::vector<uint32_t> thresholds;
        std::vector<uint64_t> goalContribs;
        thresholds.reserve(s.tiers.size());
        goalContribs.reserve(s.tiers.size());
        for (Tier const& t : s.tiers)
        {
            thresholds.push_back(t.minParticipants);
            goalContribs.push_back(t.goalContribution);
        }

        uint32_t const headcount = sEventMgr->EffectiveHeadcount(s.zoneId);
        uint64_t const newMask = ReconcileSpawnTiers(
            std::span<uint32_t const>(thresholds.data(), thresholds.size()), headcount, s.activeTierMask, _invConfig);

        // Apply only the deltas -- spawn newly-crossed tiers, despawn released ones.
        for (std::size_t i = 0; i < s.tiers.size() && i < 64; ++i)
        {
            bool const wasUp = ((s.activeTierMask >> i) & 1ULL) != 0;
            bool const nowUp = ((newMask >> i) & 1ULL) != 0;
            if (nowUp != wasUp)
                DriveGroup(s.tiers[i].groupId, s.tiers[i].mapId, s.zoneId, nowUp);
        }
        s.activeTierMask = newMask;

        // §2.5.4: the live containment goal is the sum of the active tiers' contributions; fall back
        // to the static `branding_event_def` goal when no tier authors a contribution.
        uint64_t liveGoal = LiveContainmentGoal(
            std::span<uint64_t const>(goalContribs.data(), goalContribs.size()), newMask);
        if (liveGoal == 0)
            liveGoal = s.goal;
        sEventMgr->SetGoal(s.zoneId, liveGoal);
    }

    void EventScheduler::DespawnAllTiers(Scheduled& s)
    {
        for (std::size_t i = 0; i < s.tiers.size() && i < 64; ++i)
            if (((s.activeTierMask >> i) & 1ULL) != 0)
                DriveGroup(s.tiers[i].groupId, s.tiers[i].mapId, s.zoneId, false);
        s.activeTierMask = 0;
    }

    void EventScheduler::EnsureSpawnedForZone(uint32_t zoneId)
    {
        if (!_enabled)
            return;

        // A zone may host several event types; re-assert every active tier. The entering player makes
        // the map live, so DriveGroup resolves it (idempotent if the group is already up).
        for (Scheduled const& s : _zones)
        {
            if (s.zoneId != zoneId || !s.active)
                continue;

            for (std::size_t i = 0; i < s.tiers.size() && i < 64; ++i)
                if (((s.activeTierMask >> i) & 1ULL) != 0)
                    DriveGroup(s.tiers[i].groupId, s.tiers[i].mapId, s.zoneId, true);
        }
    }

    std::vector<Addon::ScheduleEntry> EventScheduler::SnapshotSchedule() const
    {
        std::vector<Addon::ScheduleEntry> out;
        out.reserve(_zones.size());
        for (Scheduled const& s : _zones)
        {
            Addon::ScheduleEntry e;
            e.zoneId = s.zoneId;
            e.type = static_cast<uint8_t>(s.type);
            e.state = s.active ? 1 : 0;
            e.secondsRemaining = s.timerMs / 1000;
            out.push_back(e);
        }
        return out;
    }

    void EventScheduler::Update(uint32_t diffMs)
    {
        if (!_enabled)
            return;

        for (Scheduled& s : _zones)
        {
            // Keep the spawn tiers + live goal in step with the crowd before any containment check.
            if (s.active)
                ReconcileTiers(s);

            // Resolve early on full containment (§9.6), then enter cooldown.
            if (s.active && sEventMgr->Containment(s.zoneId) >= 1.0)
            {
                sEventMgr->StopEvent(s.zoneId);
                DespawnAllTiers(s);
                s.active = false;
                s.timerMs = s.cooldownMs;
                sAddonProtocolMgr->BroadcastZoneEvent(s.zoneId);
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
                DespawnAllTiers(s);
                s.active = false;
                s.timerMs = s.cooldownMs;
            }
            else
            {
                sEventMgr->StartEvent(s.zoneId, s.type, s.goal);
                s.active = true;
                s.timerMs = s.activeMs;
                ReconcileTiers(s);      // spawn the base tier(s) and set the live goal immediately
            }
            sAddonProtocolMgr->BroadcastZoneEvent(s.zoneId);
        }
    }
}
