#include "proficiency/Knowledge.h"
#include "proficiency/Proficiency.h"
#include "fakes/FakeConfig.h"
#include <gtest/gtest.h>

using namespace Branding;
using namespace Branding::Test;

namespace
{
    KnowledgeState Unlocked(BrandId b)
    {
        return KnowledgeState{ static_cast<uint32_t>(1u << static_cast<int>(b)) };
    }
}

// CanEarnProficiency reflects the account's unlock mask
TEST(Knowledge, CanEarnProficiencyReflectsMask)
{
    KnowledgeState k = Unlocked(BrandId::Fire);
    EXPECT_TRUE(CanEarnProficiency(BrandId::Fire, k));
    EXPECT_FALSE(CanEarnProficiency(BrandId::Shadow, k));
}

// CanExpressBrand reflects the CURRENT account's unlock mask
TEST(Knowledge, CanExpressBrandReflectsCurrentAccount)
{
    KnowledgeState k = Unlocked(BrandId::Nature);
    EXPECT_TRUE(CanExpressBrand(BrandId::Nature, k));
    EXPECT_FALSE(CanExpressBrand(BrandId::Fire, k));
}

// Anti-P2W: expression requires the current account's knowledge, evaluated at use time
TEST(Knowledge, ExpressionRequiresCurrentAccountKnowledge)
{
    FakeConfig cfg;
    KnowledgeState hasFire = Unlocked(BrandId::Fire);
    KnowledgeState noFire = Unlocked(BrandId::Frost);

    EXPECT_GT(ResolvedEffectStrength(cfg.maxLevel, BrandId::Fire, hasFire, cfg), 0.0);
    EXPECT_DOUBLE_EQ(ResolvedEffectStrength(cfg.maxLevel, BrandId::Fire, noFire, cfg), 0.0);
}

// Anti-P2W: a traded, max-proficiency character is inert on an account lacking the access
TEST(Knowledge, TradedCharacterInertWithoutAccountAccess)
{
    FakeConfig cfg;
    KnowledgeState emptyAccount;          // bought a maxed character, but no Knowledge earned
    EXPECT_DOUBLE_EQ(ResolvedEffectStrength(cfg.maxLevel, BrandId::Fire, emptyAccount, cfg), 0.0);
}
