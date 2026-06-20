#ifndef MOD_BRANDING_CORE_CONTRIBUTION_ACCOUNTCEILING_H
#define MOD_BRANDING_CORE_CONTRIBUTION_ACCOUNTCEILING_H

#include "ContributionConfig.h"
#include "common/Clock.h"
#include <cstdint>

namespace Branding
{
    // Account-scoped economy counter (Hybrid decision, §9.3#5 / §10.3). Separate from the
    // per-character ParticipationState; persisted in the account DB.
    struct AccountEconomyState
    {
        uint32_t materialsThisPeriod = 0;
        uint32_t currencyThisPeriod = 0;
        uint64_t periodStart = 0;
    };

    // Economy-relevant outputs of a reward (NOT points/XP/cosmetics, which are uncapped).
    struct RewardGrant
    {
        uint32_t materials = 0;
        uint32_t currency = 0;
    };

    // Clamps a proposed grant to the account's remaining ceiling for the period, mutating the
    // account state. An alt-army cannot multiply mat/currency throughput; per-character points/XP
    // are untouched (they are not part of RewardGrant). Resets on the period boundary.
    RewardGrant ClampToAccountCeiling(RewardGrant proposed, AccountEconomyState& state,
        IContributionConfig const& cfg, IClock const& clock);
}

#endif // MOD_BRANDING_CORE_CONTRIBUTION_ACCOUNTCEILING_H
