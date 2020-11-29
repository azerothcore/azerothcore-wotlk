#include "gtest/gtest.h"
#include "Formulas.h"
#include "Log.h"
#include "../../../mocks/LogMock.h"

using namespace acore::Honor;
using namespace acore::XP;

TEST(FormulasTest, hk_honor_at_level)
{
    EXPECT_EQ(hk_honor_at_level(80), 124);
    EXPECT_EQ(hk_honor_at_level(80, 2), 248);
    EXPECT_EQ(hk_honor_at_level(80, 0.5), 62);
    EXPECT_EQ(hk_honor_at_level(1), 2);
    EXPECT_EQ(hk_honor_at_level(1, 10), 16);
    EXPECT_EQ(hk_honor_at_level(2), 4);
    EXPECT_EQ(hk_honor_at_level(3), 5);
}

TEST(FormulasTest, BaseGain)
{
    sLog.reset(new LogMock());
    EXPECT_EQ(BaseGain(60, 1, CONTENT_1_60), 0);
}
