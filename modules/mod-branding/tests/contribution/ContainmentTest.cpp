#include "branding/contribution/Containment.h"
#include <gtest/gtest.h>

using namespace Branding;

// §9.6: containment is a bounded fraction of contributed vs goal
TEST(Containment, FractionOfGoal)
{
    EXPECT_DOUBLE_EQ(Containment(0, 100), 0.0);
    EXPECT_DOUBLE_EQ(Containment(50, 100), 0.5);
    EXPECT_DOUBLE_EQ(Containment(100, 100), 1.0);
}

// Saturates at 1.0 (an event cannot be more than fully contained)
TEST(Containment, SaturatesAtFull)
{
    EXPECT_DOUBLE_EQ(Containment(150, 100), 1.0);
}

// A zero goal is treated as already complete (no division by zero)
TEST(Containment, ZeroGoalIsComplete)
{
    EXPECT_DOUBLE_EQ(Containment(0, 0), 1.0);
}

// Monotonic non-decreasing in contributed, always within [0, 1]
TEST(Containment, MonotonicAndBounded)
{
    double prev = -1.0;
    for (uint64_t c = 0; c <= 200; c += 10)
    {
        double v = Containment(c, 100);
        EXPECT_GE(v, 0.0);
        EXPECT_LE(v, 1.0);
        EXPECT_GE(v, prev);
        prev = v;
    }
}
