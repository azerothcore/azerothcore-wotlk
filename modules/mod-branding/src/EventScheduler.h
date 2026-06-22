#ifndef MOD_BRANDING_SRC_EVENTSCHEDULER_H
#define MOD_BRANDING_SRC_EVENTSCHEDULER_H

#include "InvasionScalingConfig.h"
#include "branding/addon/Protocol.h"
#include "branding/contribution/ContributionTypes.h"
#include <cstdint>
#include <vector>

namespace Branding
{
    // Ambient event scheduler (§9.1). Auto-cycles events per the `branding_event_def` schedule by
    // driving EventMgr::StartEvent/StopEvent on a timer (active -> cooldown), and resolves an event
    // early when its zone reaches 100% containment. An event's authored content is a set of additive
    // spawn tiers (`branding_event_spawn`, §2.5.3): the base tier (min_participants 0) is up for the
    // whole active phase and reinforcement tiers layer in/out as the enrolled crowd grows, with the
    // live containment goal tracking the active tiers' goal contributions (§2.5.4).
    class EventScheduler
    {
    public:
        static EventScheduler* instance();

        void LoadConfig();          // reads enable + (re)loads branding_event_def + branding_event_spawn
        void Update(uint32_t diffMs);

        // Re-assert the active spawn tiers for any active event in a zone. Called on zone entry so a
        // player arriving mid-event still sees the invasion creatures even if the map was empty (and
        // thus skipped) at the start/reconcile transition.
        void EnsureSpawnedForZone(uint32_t zoneId);

        // §19.3: per-zone schedule snapshot for the client addon (state 1 = active, 0 = cooldown;
        // secondsRemaining = time left in the current phase). Empty when the scheduler is disabled.
        std::vector<Addon::ScheduleEntry> SnapshotSchedule() const;

    private:
        EventScheduler() = default;

        // One additive spawn tier (§2.5.3): a manual spawn_group gated on an enrolled-headcount
        // threshold, contributing to the live containment goal while active.
        struct Tier
        {
            uint32_t groupId = 0;
            uint16_t mapId = 0;
            uint32_t minParticipants = 0;
            uint64_t goalContribution = 0;
        };

        struct Scheduled
        {
            uint32_t zoneId = 0;
            EventType type = EventType::Invasion;
            uint64_t goal = 0;          // static fallback goal (used when no tier authors a contribution)
            uint32_t activeMs = 0;
            uint32_t cooldownMs = 0;
            bool active = false;
            uint32_t timerMs = 0;       // remaining time in the current phase

            std::vector<Tier> tiers;    // additive spawn tiers (empty => event reuses ambient mobs)
            uint64_t activeTierMask = 0;   // bit i set => tier i is currently spawned
            uint32_t healthHeadcount = UINT32_MAX;   // headcount the live creatures' health is scaled to
        };

        // Pull `branding_event_spawn` rows onto the matching schedule entries (one Tier per row).
        void LoadSpawnGroups();
        // Spawn (or despawn) one manual spawn group on its base (non-instance) map.
        static void DriveGroup(uint32_t groupId, uint16_t mapId, uint32_t zoneId, bool spawn);
        // Reconcile an active event's spawned tiers to the current crowd, and refresh its live goal.
        void ReconcileTiers(Scheduled& s);
        // Re-scale the live creatures of an event's active tiers to the current crowd (§2.5.1 dynamic
        // health -- players arrive/leave mid-invasion). Walks spawn-group -> spawn id -> Creature*.
        static void RescaleActiveTierHealth(Scheduled const& s);
        // Despawn every currently-active tier (event end) and clear the mask.
        void DespawnAllTiers(Scheduled& s);

        bool _enabled = false;
        InvasionScalingConfig _invConfig;
        std::vector<Scheduled> _zones;
    };
}

#define sEventScheduler Branding::EventScheduler::instance()

#endif // MOD_BRANDING_SRC_EVENTSCHEDULER_H
