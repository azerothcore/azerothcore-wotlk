#include "SelectionMgr.h"
#include "LoadoutMgr.h"
#include "ProficiencyMgr.h"
#include "branding/selection/Tuition.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Player.h"

namespace Branding
{
    SelectionMgr* SelectionMgr::instance()
    {
        static SelectionMgr mgr;
        return &mgr;
    }

    void SelectionMgr::LoadConfig()
    {
        _config.Load();
    }

    void SelectionMgr::LoadPlayer(Player* player)
    {
        // NOTE: blocking PK lookup on the login path (tiny, mirrors ProficiencyMgr/LoadoutMgr); the
        // async path is a TODO once running under a full build.
        if (!_config.Enabled() || !player)
            return;

        ObjectGuid const guid = player->GetGUID();
        SwitchState& state = _states[guid];
        state = SwitchState{};

        QueryResult result = CharacterDatabase.Query(
            "SELECT `recent_switches`, `last_switch_unix` FROM `character_branding_switch` WHERE `guid` = {}",
            guid.GetCounter());
        if (!result)
            return;

        Field* fields = result->Fetch();
        state.recentSwitches = fields[0].Get<uint32>();
        state.lastSwitchUnix = fields[1].Get<uint64>();

        // Apply decay on read so the counter (and the next tuition) reflects elapsed real time.
        state.recentSwitches = DecaySwitchCount(state.recentSwitches, state.lastSwitchUnix, _clock.NowUnix(), _config);
    }

    void SelectionMgr::SavePlayer(Player* player)
    {
        if (!_config.Enabled() || !player)
            return;

        auto it = _states.find(player->GetGUID());
        if (it == _states.end())
            return;

        Persist(player->GetGUID().GetCounter(), it->second);
    }

    void SelectionMgr::UnloadPlayer(ObjectGuid guid)
    {
        _states.erase(guid);
    }

    void SelectionMgr::Persist(uint32_t lowGuid, SwitchState const& state) const
    {
        CharacterDatabase.Execute(
            "REPLACE INTO `character_branding_switch` (`guid`, `recent_switches`, `last_switch_unix`) "
            "VALUES ({}, {}, {})",
            lowGuid, state.recentSwitches, state.lastSwitchUnix);
    }

    uint32_t SelectionMgr::RecentSwitches(ObjectGuid charGuid) const
    {
        auto it = _states.find(charGuid);
        if (it == _states.end())
            return 0;

        // Recompute the decay at read time so a long idle since login still reflects correctly.
        return DecaySwitchCount(it->second.recentSwitches, it->second.lastSwitchUnix, _clock.NowUnix(), _config);
    }

    SwitchResult SelectionMgr::SelectSchool(Player* player, BrandId brand)
    {
        SwitchResult result;
        if (!_config.Enabled() || !player)
        {
            result.outcome = SwitchOutcome::Disabled;
            return result;
        }

        ObjectGuid const guid = player->GetGUID();
        uint32_t const accountId = player->GetSession()->GetAccountId();

        // Gate on account Knowledge (#18). A never-known school must be Insight-unlocked first; we do
        // NOT charge in that case. IsBrandKnown == CanEarnProficiency against the account mask.
        if (!sProficiencyMgr->IsBrandKnown(accountId, brand))
        {
            result.outcome = SwitchOutcome::NotKnown;
            return result;
        }

        uint64_t const now = _clock.NowUnix();
        SwitchState& state = _states[guid];
        state.recentSwitches = DecaySwitchCount(state.recentSwitches, state.lastSwitchUnix, now, _config);

        uint64_t const tuition = TuitionCost(state.recentSwitches, _config);
        result.tuition = tuition;

        // Charge gold first (fail gracefully if insufficient -- nothing else mutates). ModifyMoney
        // returns false without deducting when the player can't afford the charge.
        if (tuition > 0)
        {
            if (!player->HasEnoughMoney(static_cast<uint32>(tuition)) ||
                !player->ModifyMoney(-static_cast<int32>(tuition)))
            {
                result.outcome = SwitchOutcome::InsufficientGold;
                return result;
            }
        }

        // Set the active brand (Proficiency rows are untouched -- retention is the default). The
        // account is known here, so LoadoutMgr's knowledge validation passes.
        sLoadoutMgr->SetActiveBrand(player, brand);

        // Bump + persist the recent-switch counter so the next switch escalates (anti-flip-flop).
        ++state.recentSwitches;
        state.lastSwitchUnix = now;
        Persist(guid.GetCounter(), state);

        LOG_INFO("module.branding", "School switch: {} -> brand {}, tuition {} copper, recent {}.",
            guid.ToString(), static_cast<uint32>(brand), tuition, state.recentSwitches);

        result.outcome = SwitchOutcome::Switched;
        return result;
    }
}
