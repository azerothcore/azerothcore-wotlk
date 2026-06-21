#include "PersistenceRow.h"

namespace Branding
{
    ParticipationRow ToRow(ParticipationState const& state)
    {
        ParticipationRow row;
        row.pointsThisHour = state.pointsThisHour;
        row.hourWindowStart = state.hourWindowStart;
        row.dayStart = state.dayStart;
        row.dailyCount = state.dailyCount;
        return row;
    }

    ParticipationState FromRow(ParticipationRow const& row)
    {
        ParticipationState state;
        state.pointsThisHour = row.pointsThisHour;
        state.hourWindowStart = row.hourWindowStart;
        state.dayStart = row.dayStart;
        state.dailyCount = row.dailyCount;
        return state;
    }

    AccountEconomyRow ToRow(AccountEconomyState const& state)
    {
        AccountEconomyRow row;
        row.materialsThisPeriod = state.materialsThisPeriod;
        row.currencyThisPeriod = state.currencyThisPeriod;
        row.periodStart = state.periodStart;
        return row;
    }

    AccountEconomyState FromAccountRow(AccountEconomyRow const& row)
    {
        AccountEconomyState state;
        state.materialsThisPeriod = row.materialsThisPeriod;
        state.currencyThisPeriod = row.currencyThisPeriod;
        state.periodStart = row.periodStart;
        return state;
    }
}
