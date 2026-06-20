#include "EventMgr.h"
#include "contribution/Containment.h"
#include "contribution/Contribution.h"
#include "contribution/RewardDiversity.h"
#include "contribution/RewardTier.h"

namespace Branding
{
    namespace
    {
        // Base economy reward by tier; only the field matching the selected category is filled.
        RewardGrant BaseGrant(RewardTier tier, RewardCategory category)
        {
            uint32_t mats = 0;
            uint32_t currency = 0;
            switch (tier)
            {
                case RewardTier::Bronze: mats = 10; currency = 1000; break;
                case RewardTier::Silver: mats = 25; currency = 3000; break;
                case RewardTier::Gold:   mats = 60; currency = 8000; break;
                default: break;
            }

            RewardGrant grant;
            if (category == RewardCategory::CraftingMats)
                grant.materials = mats;
            else if (category == RewardCategory::Currency)
                grant.currency = currency;
            return grant;
        }
    }
}

namespace Branding
{
    EventMgr* EventMgr::instance()
    {
        static EventMgr mgr;
        return &mgr;
    }

    void EventMgr::LoadConfig()
    {
        _config.Load();
    }

    bool EventMgr::StartEvent(uint32_t zoneId, EventType type, uint64_t goal)
    {
        if (zoneId == 0)
            return false;

        ActiveEvent& event = _events[zoneId];
        event.type = type;
        event.goal = goal;
        event.contributed = 0;
        return true;
    }

    bool EventMgr::StopEvent(uint32_t zoneId)
    {
        return _events.erase(zoneId) > 0;
    }

    bool EventMgr::ActiveEventType(uint32_t zoneId, EventType& outType) const
    {
        auto it = _events.find(zoneId);
        if (it == _events.end())
            return false;

        outType = it->second.type;
        return true;
    }

    double EventMgr::Containment(uint32_t zoneId) const
    {
        auto it = _events.find(zoneId);
        if (it == _events.end())
            return 0.0;

        return Branding::Containment(it->second.contributed, it->second.goal);
    }

    void EventMgr::CaptureKill(ObjectGuid guid, uint32_t zoneId, bool elite, bool boss)
    {
        auto eventIt = _events.find(zoneId);
        if (eventIt == _events.end())
            return;     // no active event in this zone

        EventAction const action = boss ? EventAction::MiniBoss
            : (elite ? EventAction::EliteKill : EventAction::InvadingKill);

        // The killer performed the action, so it clears the anti-leech action floor.
        ActivitySignal signal;
        signal.actions = 1;

        PlayerState& state = _players[guid];
        uint32_t const granted = ApplyEventAction(state.participation, eventIt->second.type, action, 0,
            signal, _config, _clock);

        state.totalPoints += granted;
        eventIt->second.contributed += granted;
    }

    uint32_t EventMgr::PlayerPoints(ObjectGuid guid) const
    {
        auto it = _players.find(guid);
        return it != _players.end() ? it->second.totalPoints : 0;
    }

    RewardTier EventMgr::PlayerTier(ObjectGuid guid) const
    {
        return TierForContribution(PlayerPoints(guid), _config);
    }

    void EventMgr::Unload(ObjectGuid guid)
    {
        _players.erase(guid);
    }

    EventMgr::ResolvedReward EventMgr::ResolveReward(ObjectGuid guid, uint32_t accountId, uint32_t zoneId)
    {
        ResolvedReward reward;
        reward.tier = PlayerTier(guid);
        if (reward.tier == RewardTier::None)
            return reward;

        EventType type = EventType::Invasion;
        ActiveEventType(zoneId, type);      // falls back to Invasion if no active event in the zone

        // §9.5 diversity: pick an allowed category for this event type.
        reward.category = SelectRewardCategory(type, _rng, _config);

        // §9.3#5: economy output (mats/currency) is clamped to the account ceiling for the period.
        reward.grant = ClampToAccountCeiling(BaseGrant(reward.tier, reward.category),
            _accountState[accountId], _config, _clock);
        return reward;
    }
}
