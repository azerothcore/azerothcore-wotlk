#ifndef MOD_BRANDING_SRC_EVENTMGR_H
#define MOD_BRANDING_SRC_EVENTMGR_H

#include "EventConfig.h"
#include "ServerClock.h"
#include "contribution/ContributionTypes.h"
#include "ObjectGuid.h"
#include <cstdint>
#include <unordered_map>

namespace Branding
{
    // Minimal runtime scaffold for the §9 dynamic-event engine: GM-startable events per zone, kill
    // capture feeding the pure scoring engine (with all guardrails), containment aggregation, and
    // per-player tiering. Runtime-only (no persistence); spawner/scheduler and reward delivery are
    // deferred. This makes the Slice 3 contribution core observable and testable in-world.
    class EventMgr
    {
    public:
        static EventMgr* instance();

        void LoadConfig();
        bool Enabled() const { return _config.Enabled(); }

        // Event lifecycle (GM-driven for now).
        bool StartEvent(uint32_t zoneId, EventType type, uint64_t goal);
        bool StopEvent(uint32_t zoneId);
        bool ActiveEventType(uint32_t zoneId, EventType& outType) const;
        double Containment(uint32_t zoneId) const;

        // Participation.
        void CaptureKill(ObjectGuid guid, uint32_t zoneId, bool elite, bool boss);
        uint32_t PlayerPoints(ObjectGuid guid) const;
        RewardTier PlayerTier(ObjectGuid guid) const;
        void Unload(ObjectGuid guid);

    private:
        EventMgr() = default;

        struct ActiveEvent
        {
            EventType type = EventType::Invasion;
            uint64_t goal = 0;
            uint64_t contributed = 0;
        };

        struct PlayerState
        {
            ParticipationState participation;
            uint32_t totalPoints = 0;
        };

        EventConfig _config;
        ServerClock _clock;
        std::unordered_map<uint32_t, ActiveEvent> _events;
        std::unordered_map<ObjectGuid, PlayerState> _players;
    };
}

#define sEventMgr Branding::EventMgr::instance()

#endif // MOD_BRANDING_SRC_EVENTMGR_H
