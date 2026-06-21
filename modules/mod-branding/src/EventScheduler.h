#ifndef MOD_BRANDING_SRC_EVENTSCHEDULER_H
#define MOD_BRANDING_SRC_EVENTSCHEDULER_H

#include "contribution/ContributionTypes.h"
#include <cstdint>
#include <vector>

namespace Branding
{
    // Ambient event scheduler (§9.1). Auto-cycles events per the `branding_event_def` schedule by
    // driving EventMgr::StartEvent/StopEvent on a timer (active -> cooldown), and resolves an event
    // early when its zone reaches 100% containment. When an event has authored content (a manual
    // `spawn_group` linked via `branding_event_spawn`), the scheduler also spawns that group on the
    // event's map at start and despawns it at end -- so an invasion brings its own creatures.
    class EventScheduler
    {
    public:
        static EventScheduler* instance();

        void LoadConfig();          // reads enable + (re)loads branding_event_def + branding_event_spawn
        void Update(uint32_t diffMs);

        // Re-assert the spawn group for any active event in a zone. Called on zone entry so a player
        // arriving mid-event still sees the invasion creatures even if the map was empty (and thus
        // skipped) at the start transition.
        void EnsureSpawnedForZone(uint32_t zoneId);

    private:
        EventScheduler() = default;

        struct Scheduled
        {
            uint32_t zoneId = 0;
            EventType type = EventType::Invasion;
            uint64_t goal = 0;
            uint32_t activeMs = 0;
            uint32_t cooldownMs = 0;
            bool active = false;
            uint32_t timerMs = 0;   // remaining time in the current phase

            // Authored spawn group for this event (0/none if the event reuses ambient mobs).
            uint32_t spawnGroupId = 0;
            uint16_t mapId = 0;
            bool hasSpawnGroup = false;
        };

        // Pull `branding_event_spawn` rows onto the matching schedule entries.
        void LoadSpawnGroups();
        // Spawn (or despawn) an event's authored group on its base (non-instance) map.
        static void DriveSpawnGroup(Scheduled const& s, bool spawn);

        bool _enabled = false;
        std::vector<Scheduled> _zones;
    };
}

#define sEventScheduler Branding::EventScheduler::instance()

#endif // MOD_BRANDING_SRC_EVENTSCHEDULER_H
