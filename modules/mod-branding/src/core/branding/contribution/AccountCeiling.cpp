#include "AccountCeiling.h"
#include <algorithm>

namespace Branding
{
    namespace
    {
        bool PeriodElapsed(uint64_t now, uint64_t start, uint64_t period)
        {
            return start == 0 || (now >= start && now - start >= period);
        }

        uint32_t Remaining(uint32_t used, uint32_t ceiling)
        {
            return used >= ceiling ? 0 : ceiling - used;
        }
    }

    RewardGrant ClampToAccountCeiling(RewardGrant proposed, AccountEconomyState& state,
        IContributionConfig const& cfg, IClock const& clock)
    {
        uint64_t const now = clock.NowUnix();
        if (PeriodElapsed(now, state.periodStart, cfg.AccountCeilingPeriodSeconds()))
        {
            state.materialsThisPeriod = 0;
            state.currencyThisPeriod = 0;
            state.periodStart = now;
        }

        RewardGrant granted;
        granted.materials = std::min(proposed.materials, Remaining(state.materialsThisPeriod, cfg.AccountMaterialsCeiling()));
        granted.currency = std::min(proposed.currency, Remaining(state.currencyThisPeriod, cfg.AccountCurrencyCeiling()));

        state.materialsThisPeriod += granted.materials;
        state.currencyThisPeriod += granted.currency;
        return granted;
    }
}
