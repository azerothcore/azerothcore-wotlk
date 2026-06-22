#include "EventMgr.h"
#include "branding/contribution/Containment.h"
#include "branding/contribution/Contribution.h"
#include "branding/contribution/PersistenceRow.h"
#include "branding/contribution/RewardDiversity.h"
#include "branding/contribution/RewardTier.h"
#include "DatabaseEnv.h"
#include "Player.h"

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
        _invConfig.Load();
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

        // §2.5.2: scoring enrols the player into this zone's invasion crowd (anti-AFK -- presence
        // alone never inflates the field). Idempotent; they leave on zone change / logout / stop.
        eventIt->second.roster.insert(guid);
    }

    uint32_t EventMgr::ParticipantCount(uint32_t zoneId) const
    {
        auto it = _events.find(zoneId);
        return it != _events.end() ? static_cast<uint32_t>(it->second.roster.size()) : 0;
    }

    uint32_t EventMgr::EffectiveHeadcount(uint32_t zoneId) const
    {
        auto it = _events.find(zoneId);
        return it != _events.end() ? it->second.effectiveHeadcount : 0;
    }

    void EventMgr::SampleCrowds()
    {
        uint64_t const now = _clock.NowUnix();
        for (auto& [zoneId, event] : _events)
        {
            event.crowd.Sample(now, static_cast<uint32_t>(event.roster.size()), _invConfig);
            event.effectiveHeadcount = event.crowd.Effective(now, _invConfig);
        }
    }

    void EventMgr::DropFromRosters(ObjectGuid guid)
    {
        for (auto& [zoneId, event] : _events)
            event.roster.erase(guid);
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
        DropFromRosters(guid);

        // Drop the shared account economy row only when the last online alt unloads, so a relog of
        // one character can't reset the account ceiling while another alt is still online.
        auto accIt = _charAccount.find(guid);
        if (accIt != _charAccount.end())
        {
            uint32_t const accountId = accIt->second;
            _charAccount.erase(accIt);

            auto refIt = _accountRefs.find(accountId);
            if (refIt != _accountRefs.end() && --refIt->second == 0)
            {
                _accountRefs.erase(refIt);
                _accountState.erase(accountId);
            }
        }
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

    // --- Persistence (§9.3#5) -----------------------------------------------------------------
    // Thin IO adapter over the pure PersistenceRow projection. Loads run as blocking, primary-key
    // lookups on the login path (tiny rows), mirroring ProficiencyMgr. The DR counters are stored
    // as fixed columns (EventType::COUNT of them); the projection keeps the field mapping pure.

    void EventMgr::LoadCharacterParticipation(ObjectGuid guid, uint32_t lowGuid)
    {
        PlayerState& state = _players[guid];
        state = PlayerState{};

        QueryResult result = CharacterDatabase.Query(
            "SELECT `total_points`, `points_this_hour`, `hour_window_start`, `day_start`, "
            "`daily_invasion`, `daily_resource_surge`, `daily_elite_hunt`, `daily_profession_anomaly` "
            "FROM `character_event_participation` WHERE `guid` = {}",
            lowGuid);
        if (!result)
            return;

        Field* fields = result->Fetch();
        state.totalPoints = fields[0].Get<uint32>();

        ParticipationRow row;
        row.pointsThisHour = fields[1].Get<uint32>();
        row.hourWindowStart = fields[2].Get<uint64>();
        row.dayStart = fields[3].Get<uint64>();
        for (size_t i = 0; i < row.dailyCount.size(); ++i)
            row.dailyCount[i] = fields[4 + i].Get<uint32>();

        state.participation = FromRow(row);
    }

    void EventMgr::LoadAccountEconomy(uint32_t accountId)
    {
        AccountEconomyState& acc = _accountState[accountId];
        acc = AccountEconomyState{};

        QueryResult result = LoginDatabase.Query(
            "SELECT `materials_this_period`, `currency_this_period`, `period_start` "
            "FROM `account_economy_ledger` WHERE `account` = {}",
            accountId);
        if (!result)
            return;

        Field* fields = result->Fetch();
        AccountEconomyRow row;
        row.materialsThisPeriod = fields[0].Get<uint32>();
        row.currencyThisPeriod = fields[1].Get<uint32>();
        row.periodStart = fields[2].Get<uint64>();

        acc = FromAccountRow(row);
    }

    void EventMgr::SaveCharacterParticipation(uint32_t lowGuid, PlayerState const& state)
    {
        ParticipationRow const row = ToRow(state.participation);
        CharacterDatabase.Execute(
            "REPLACE INTO `character_event_participation` "
            "(`guid`, `total_points`, `points_this_hour`, `hour_window_start`, `day_start`, "
            "`daily_invasion`, `daily_resource_surge`, `daily_elite_hunt`, `daily_profession_anomaly`) "
            "VALUES ({}, {}, {}, {}, {}, {}, {}, {}, {})",
            lowGuid, state.totalPoints, row.pointsThisHour, row.hourWindowStart, row.dayStart,
            row.dailyCount[0], row.dailyCount[1], row.dailyCount[2], row.dailyCount[3]);
    }

    void EventMgr::SaveAccountEconomy(uint32_t accountId, AccountEconomyState const& state)
    {
        AccountEconomyRow const row = ToRow(state);
        LoginDatabase.Execute(
            "REPLACE INTO `account_economy_ledger` "
            "(`account`, `materials_this_period`, `currency_this_period`, `period_start`) "
            "VALUES ({}, {}, {}, {})",
            accountId, row.materialsThisPeriod, row.currencyThisPeriod, row.periodStart);
    }

    void EventMgr::LoadPlayer(Player* player)
    {
        if (!Enabled() || !player)
            return;

        ObjectGuid const guid = player->GetGUID();
        uint32_t const accountId = player->GetSession()->GetAccountId();

        LoadCharacterParticipation(guid, guid.GetCounter());

        // Account economy ledger is shared across alts: load once on the first online character of
        // the account, and ref-count so a later alt login does not re-read over live state.
        if (_accountRefs.find(accountId) == _accountRefs.end())
            LoadAccountEconomy(accountId);

        _charAccount[guid] = accountId;
        ++_accountRefs[accountId];
    }

    void EventMgr::SavePlayer(Player* player)
    {
        if (!Enabled() || !player)
            return;

        ObjectGuid const guid = player->GetGUID();
        auto it = _players.find(guid);
        if (it != _players.end())
            SaveCharacterParticipation(guid.GetCounter(), it->second);

        uint32_t const accountId = player->GetSession()->GetAccountId();
        auto accIt = _accountState.find(accountId);
        if (accIt != _accountState.end())
            SaveAccountEconomy(accountId, accIt->second);
    }

    void EventMgr::FlushAll()
    {
        if (!Enabled())
            return;

        for (auto const& [guid, state] : _players)
            SaveCharacterParticipation(guid.GetCounter(), state);

        for (auto const& [accountId, state] : _accountState)
            SaveAccountEconomy(accountId, state);
    }
}
