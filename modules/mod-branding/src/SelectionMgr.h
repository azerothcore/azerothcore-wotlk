#ifndef MOD_BRANDING_SRC_SELECTIONMGR_H
#define MOD_BRANDING_SRC_SELECTIONMGR_H

#include "SelectionConfig.h"
#include "ServerClock.h"
#include "branding/common/Brand.h"
#include "ObjectGuid.h"
#include <cstdint>
#include <unordered_map>

class Player;

namespace Branding
{
    // Outcome of a `.branding school select` attempt (§14.13.2). The adapter maps each result to a
    // player-facing message; only Switched mutates state.
    enum class SwitchOutcome : uint8_t
    {
        Disabled,           // Branding.Selection.Enable is off
        NotKnown,           // account lacks the Knowledge for this school -> point at Insight (#18)
        InsufficientGold,   // tuition exceeds the player's money -> nothing charged
        Switched,           // gold deducted, active brand set, recent-switch counter bumped
    };

    struct SwitchResult
    {
        SwitchOutcome outcome = SwitchOutcome::Disabled;
        uint64_t tuition = 0;       // copper charged (or that would have been charged)
    };

    // Adapter manager for the active-school switch fee (§14.13.2). Owns the per-character recent-switch
    // counter (escalates tuition, decays after SwitchDecayDays), gates on account Knowledge, charges
    // gold, and delegates the actual brand change to LoadoutMgr. No Player* is retained past a call --
    // the cache is keyed by ObjectGuid (project long-lived-reference rule). Proficiency is NEVER wiped:
    // per-school character_branding rows persist, so a switch back to a known school is gold-only.
    class SelectionMgr
    {
    public:
        static SelectionMgr* instance();

        void LoadConfig();
        SelectionConfig const& Config() const { return _config; }

        // Login/logout lifecycle for the per-character recent-switch counter.
        void LoadPlayer(Player* player);
        void SavePlayer(Player* player);
        void UnloadPlayer(ObjectGuid guid);

        // The current (decay-applied) recent-switch count for a character. For inspection / preview.
        uint32_t RecentSwitches(ObjectGuid charGuid) const;

        // Attempt to make `brand` the character's active school. See SwitchOutcome for the contract.
        SwitchResult SelectSchool(Player* player, BrandId brand);

    private:
        SelectionMgr() = default;

        struct SwitchState
        {
            uint32_t recentSwitches = 0;
            uint64_t lastSwitchUnix = 0;
        };

        void Persist(uint32_t lowGuid, SwitchState const& state) const;

        SelectionConfig _config;
        ServerClock _clock;
        std::unordered_map<ObjectGuid, SwitchState> _states;
    };
}

#define sSelectionMgr Branding::SelectionMgr::instance()

#endif // MOD_BRANDING_SRC_SELECTIONMGR_H
