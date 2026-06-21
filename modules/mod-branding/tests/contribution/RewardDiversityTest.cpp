#include "branding/contribution/RewardDiversity.h"
#include "fakes/FakeContributionConfig.h"
#include "fakes/FakeRng.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

namespace
{
    bool MaskHas(uint32_t mask, RewardCategory c)
    {
        return (mask & (1u << static_cast<int>(c))) != 0u;
    }

    const EventType kAllEvents[] = { EventType::Invasion, EventType::ResourceSurge,
                                     EventType::EliteHunt, EventType::ProfessionAnomaly };
}

// §9.5 invariant: no single EventType's reward pool spans ALL categories
TEST(RewardDiversity, NoEventTypeSpansAllCategories)
{
    FakeContributionConfig cfg;
    for (EventType type : kAllEvents)
        EXPECT_TRUE(CategorySetIsDiverse(type, cfg)) << "EventType " << static_cast<int>(type);
}

// A selected category is always within the EventType's allowed set
TEST(RewardDiversity, SelectionStaysWithinAllowedSet)
{
    FakeContributionConfig cfg;
    FakeRng rng(42);
    for (EventType type : kAllEvents)
    {
        for (int i = 0; i < 50; ++i)
        {
            RewardCategory picked = SelectRewardCategory(type, rng, cfg);
            EXPECT_TRUE(MaskHas(cfg.AllowedCategoryMask(type), picked));
        }
    }
}

// Deterministic under a fixed seed: same RNG seed -> same selection sequence
TEST(RewardDiversity, DeterministicUnderSeed)
{
    FakeContributionConfig cfg;
    FakeRng a(7);
    FakeRng b(7);
    for (int i = 0; i < 20; ++i)
        EXPECT_EQ(SelectRewardCategory(EventType::EliteHunt, a, cfg),
                  SelectRewardCategory(EventType::EliteHunt, b, cfg));
}

// Selection actually varies across the allowed set (not a constant) over many draws
TEST(RewardDiversity, SelectionVariesAcrossAllowedSet)
{
    FakeContributionConfig cfg;
    FakeRng rng(99);
    RewardCategory first = SelectRewardCategory(EventType::Invasion, rng, cfg);
    bool sawDifferent = false;
    for (int i = 0; i < 100 && !sawDifferent; ++i)
        if (SelectRewardCategory(EventType::Invasion, rng, cfg) != first)
            sawDifferent = true;
    EXPECT_TRUE(sawDifferent);
}
