#ifndef MOD_BRANDING_CORE_CONTRIBUTION_PERSISTENCEROW_H
#define MOD_BRANDING_CORE_CONTRIBUTION_PERSISTENCEROW_H

#include "AccountCeiling.h"
#include "ContributionTypes.h"
#include <array>
#include <cstddef>
#include <cstdint>

namespace Branding
{
    // Flat, DB-shaped projection of the per-character pacing state (§9.3#5). The adapter maps these
    // fields 1:1 to columns of `character_event_participation`; keeping the projection pure lets the
    // round-trip (load(save(state)) == state) be tested without any AzerothCore/DB dependency.
    struct ParticipationRow
    {
        uint32_t pointsThisHour = 0;
        uint64_t hourWindowStart = 0;
        uint64_t dayStart = 0;
        // Per-EventType daily DR counters, stored as fixed columns (EventType::COUNT of them).
        std::array<uint32_t, static_cast<size_t>(EventType::COUNT)> dailyCount{};
    };

    // Flat, DB-shaped projection of the account economy ceiling state (§9.3#5). The adapter maps
    // these fields 1:1 to columns of `account_economy_ledger`.
    struct AccountEconomyRow
    {
        uint32_t materialsThisPeriod = 0;
        uint32_t currencyThisPeriod = 0;
        uint64_t periodStart = 0;
    };

    ParticipationRow ToRow(ParticipationState const& state);
    ParticipationState FromRow(ParticipationRow const& row);

    AccountEconomyRow ToRow(AccountEconomyState const& state);
    AccountEconomyState FromAccountRow(AccountEconomyRow const& row);
}

#endif // MOD_BRANDING_CORE_CONTRIBUTION_PERSISTENCEROW_H
