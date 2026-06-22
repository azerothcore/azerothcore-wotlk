#ifndef MOD_BRANDING_SRC_EVENTMGR_H
#define MOD_BRANDING_SRC_EVENTMGR_H

#include "EventConfig.h"
#include "InvasionScalingConfig.h"
#include "ServerClock.h"
#include "ServerRng.h"
#include "branding/contribution/AccountCeiling.h"
#include "branding/contribution/ContributionTypes.h"
#include "branding/scaling/InvasionScaling.h"
#include "ObjectGuid.h"
#include <cstdint>
#include <unordered_map>
#include <unordered_set>

class Player;

namespace Branding
{
    // Minimal runtime scaffold for the §9 dynamic-event engine: GM-startable events per zone, kill
    // capture feeding the pure scoring engine (with all guardrails), containment aggregation, and
    // per-player tiering. Per-character participation pacing (`character_event_participation`) and
    // the per-account economy ceiling (`account_economy_ledger`) are persisted (§9.3#5) so the
    // account ceiling bounds an alt-army across sessions; spawner/scheduler are deferred.
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

        // Invasion crowd scaling (§2.5). A participant enrols when they first score in a zone with an
        // active event (CaptureKill); they leave the roster on zone change / logout / event end.
        // ParticipantCount is the live enrolled headcount; EffectiveHeadcount is the decayed-peak
        // value the spawn-tier reconcile and creature-stat hook key off (cached, refreshed by
        // SampleCrowds each tick). DropFromRosters removes a player from every zone roster.
        uint32_t ParticipantCount(uint32_t zoneId) const;
        uint32_t EffectiveHeadcount(uint32_t zoneId) const;
        void SampleCrowds();
        void DropFromRosters(ObjectGuid guid);

        // Persistence lifecycle (§9.3#5). Load pulls the character's participation pacing and the
        // account economy ledger into the caches on login (account loaded once per account); Save
        // flushes both back; Unload drops the character cache (account cache survives concurrent
        // alts). FlushAll persists every cached row for the periodic timer.
        void LoadPlayer(Player* player);
        void SavePlayer(Player* player);
        void FlushAll();

        // Reward resolution (§9.4/§9.5/§9.3#5): tier -> diversity-selected category -> grant clamped
        // to the account economy ceiling. The caller delivers the grant to the game (AddItem etc.).
        struct ResolvedReward
        {
            RewardTier tier = RewardTier::None;
            RewardCategory category = RewardCategory::CraftingMats;
            RewardGrant grant;
        };
        ResolvedReward ResolveReward(ObjectGuid guid, uint32_t accountId, uint32_t zoneId);
        uint32_t RewardMaterialItem() const { return _config.RewardMaterialItem(); }

    private:
        EventMgr() = default;

        struct ActiveEvent
        {
            EventType type = EventType::Invasion;
            uint64_t goal = 0;
            uint64_t contributed = 0;

            // §2.5 crowd scaling: enrolled participants, the decayed-peak tracker fed from them, and
            // the cached effective headcount (refreshed by SampleCrowds, read on the hot path).
            std::unordered_set<ObjectGuid> roster;
            CrowdTracker crowd;
            uint32_t effectiveHeadcount = 0;
        };

        struct PlayerState
        {
            ParticipationState participation;
            uint32_t totalPoints = 0;
        };

        void LoadCharacterParticipation(ObjectGuid guid, uint32_t lowGuid);
        void LoadAccountEconomy(uint32_t accountId);
        void SaveCharacterParticipation(uint32_t lowGuid, PlayerState const& state);
        void SaveAccountEconomy(uint32_t accountId, AccountEconomyState const& state);

        EventConfig _config;
        InvasionScalingConfig _invConfig;
        ServerClock _clock;
        ServerRng _rng;
        std::unordered_map<uint32_t, ActiveEvent> _events;
        std::unordered_map<ObjectGuid, PlayerState> _players;
        std::unordered_map<uint32_t, AccountEconomyState> _accountState;

        // Maps a loaded character to its account, and counts loaded chars per account so the shared
        // account economy row is only dropped/loaded once across concurrently-online alts.
        std::unordered_map<ObjectGuid, uint32_t> _charAccount;
        std::unordered_map<uint32_t, uint32_t> _accountRefs;
    };
}

#define sEventMgr Branding::EventMgr::instance()

#endif // MOD_BRANDING_SRC_EVENTMGR_H
