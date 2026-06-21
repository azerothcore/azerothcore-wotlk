#include "branding/contribution/PersistenceRow.h"
#include <gtest/gtest.h>

using namespace Branding;

namespace
{
    bool Equal(ParticipationState const& a, ParticipationState const& b)
    {
        return a.pointsThisHour == b.pointsThisHour
            && a.hourWindowStart == b.hourWindowStart
            && a.dayStart == b.dayStart
            && a.dailyCount == b.dailyCount;
    }

    bool Equal(AccountEconomyState const& a, AccountEconomyState const& b)
    {
        return a.materialsThisPeriod == b.materialsThisPeriod
            && a.currencyThisPeriod == b.currencyThisPeriod
            && a.periodStart == b.periodStart;
    }
}

// ToRow projects every ParticipationState field 1:1 onto its column.
TEST(PersistenceRow, ParticipationToRowProjectsAllFields)
{
    ParticipationState state;
    state.pointsThisHour = 42;
    state.hourWindowStart = 1700000000ull;
    state.dayStart = 1699990000ull;
    state.dailyCount[0] = 3;
    state.dailyCount[static_cast<size_t>(EventType::COUNT) - 1] = 7;

    ParticipationRow row = ToRow(state);
    EXPECT_EQ(row.pointsThisHour, 42u);
    EXPECT_EQ(row.hourWindowStart, 1700000000ull);
    EXPECT_EQ(row.dayStart, 1699990000ull);
    EXPECT_EQ(row.dailyCount[0], 3u);
    EXPECT_EQ(row.dailyCount[static_cast<size_t>(EventType::COUNT) - 1], 7u);
}

// §12 acceptance: load(save(state)) == state for participation pacing state.
TEST(PersistenceRow, ParticipationRoundTrip)
{
    ParticipationState state;
    state.pointsThisHour = 1234;
    state.hourWindowStart = 1700001111ull;
    state.dayStart = 1700000000ull;
    for (size_t i = 0; i < state.dailyCount.size(); ++i)
        state.dailyCount[i] = static_cast<uint32_t>(i * 11 + 1);

    ParticipationState restored = FromRow(ToRow(state));
    EXPECT_TRUE(Equal(state, restored));
}

// A default (never-touched) participation state round-trips to the default.
TEST(PersistenceRow, ParticipationRoundTripDefault)
{
    ParticipationState state;
    ParticipationState restored = FromRow(ToRow(state));
    EXPECT_TRUE(Equal(state, restored));
}

// §12 acceptance: the account economy ceiling survives a save/load (so it survives a relog).
TEST(PersistenceRow, AccountEconomyRoundTrip)
{
    AccountEconomyState state;
    state.materialsThisPeriod = 950;
    state.currencyThisPeriod = 480;
    state.periodStart = 1700002222ull;

    AccountEconomyState restored = FromAccountRow(ToRow(state));
    EXPECT_TRUE(Equal(state, restored));
}

// The account ledger projection maps each field 1:1.
TEST(PersistenceRow, AccountEconomyToRowProjectsAllFields)
{
    AccountEconomyState state;
    state.materialsThisPeriod = 12;
    state.currencyThisPeriod = 34;
    state.periodStart = 56;

    AccountEconomyRow row = ToRow(state);
    EXPECT_EQ(row.materialsThisPeriod, 12u);
    EXPECT_EQ(row.currencyThisPeriod, 34u);
    EXPECT_EQ(row.periodStart, 56ull);
}
