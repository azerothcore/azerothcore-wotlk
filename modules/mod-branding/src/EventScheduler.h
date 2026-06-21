#ifndef MOD_BRANDING_SRC_EVENTSCHEDULER_H
#define MOD_BRANDING_SRC_EVENTSCHEDULER_H

#include "contribution/ContributionTypes.h"
#include <cstdint>
#include <vector>

namespace Branding
{
    // Ambient event scheduler (§9.1). Auto-cycles events per the `branding_event_def` schedule by
    // driving EventMgr::StartEvent/StopEvent on a timer (active -> cooldown), and resolves an event
    // early when its zone reaches 100% containment. Reuses the existing kill-capture path -- mobs
    // already in an active-event zone score -- so no creature spawning is required for this cut
    // (spawn groups are a data/follow-up enhancement).
    class EventScheduler
    {
    public:
        static EventScheduler* instance();

        void LoadConfig();          // reads enable + (re)loads branding_event_def
        void Update(uint32_t diffMs);

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
        };

        bool _enabled = false;
        std::vector<Scheduled> _zones;
    };
}

#define sEventScheduler Branding::EventScheduler::instance()

#endif // MOD_BRANDING_SRC_EVENTSCHEDULER_H
