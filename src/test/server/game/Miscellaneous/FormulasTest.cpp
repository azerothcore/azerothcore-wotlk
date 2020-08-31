#include "gtest/gtest.h"
#include "Formulas.h"

TEST(FormulasTest, hk_honor_at_level)
{
    EXPECT_EQ(acore::Honor::hk_honor_at_level(80), 124);
    EXPECT_EQ(acore::Honor::hk_honor_at_level(80, 2), 248);
    EXPECT_EQ(acore::Honor::hk_honor_at_level(80, 0.5), 62);
    EXPECT_EQ(acore::Honor::hk_honor_at_level(1), 2);
    EXPECT_EQ(acore::Honor::hk_honor_at_level(1, 10), 16);
    EXPECT_EQ(acore::Honor::hk_honor_at_level(2), 4);
    EXPECT_EQ(acore::Honor::hk_honor_at_level(3), 5);
}
