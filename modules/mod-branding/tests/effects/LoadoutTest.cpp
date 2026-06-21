#include "effects/ItemBrand.h"
#include "fakes/FakeEffectConfig.h"
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

// Issue #02 (§7.9): the per-character loadout-selection contract the LoadoutMgr adapter relies on.
// Validation must gate the active brand on account Knowledge and gate the proc archetype on the
// character's proficiency level. These tests pin the exact boundaries used by `.branding setproc`.

// The archetype index must be strictly below ArchetypesAtLevel(profLevel): the boundary itself is
// out of range, one below is in range.
TEST(Loadout, ArchetypeBoundaryIsExclusive)
{
    FakeItemBrandConfig cfg;
    KnowledgeState fire = Unlocked(BrandId::Fire);

    // FakeItemBrandConfig: ArchetypesAtLevel(level) == 1 + level/10.
    uint8_t const profLevel = 30;
    uint8_t const count = cfg.ArchetypesAtLevel(profLevel); // 1 + 30/10 = 4 archetypes (indices 0..3)

    EXPECT_TRUE(IsLoadoutValid(BrandLoadout{ BrandId::Fire, static_cast<uint8_t>(count - 1) }, fire, profLevel, cfg));
    EXPECT_FALSE(IsLoadoutValid(BrandLoadout{ BrandId::Fire, count }, fire, profLevel, cfg));
}

// Raising proficiency unlocks higher archetypes: an archetype rejected at a low level becomes valid
// once the character's proficiency reaches the gating level.
TEST(Loadout, HigherArchetypeGatesBehindProficiency)
{
    FakeItemBrandConfig cfg;
    KnowledgeState fire = Unlocked(BrandId::Fire);

    BrandLoadout const loadout{ BrandId::Fire, 2 }; // archetype index 2 needs >= 3 archetypes -> level >= 20

    EXPECT_FALSE(IsLoadoutValid(loadout, fire, 10, cfg)); // 2 archetypes at lvl 10
    EXPECT_TRUE(IsLoadoutValid(loadout, fire, 20, cfg));  // 3 archetypes at lvl 20
}

// The active brand must be account-unlocked regardless of how low the chosen archetype is.
TEST(Loadout, LockedBrandRejectedEvenForBaseArchetype)
{
    FakeItemBrandConfig cfg;
    KnowledgeState fire = Unlocked(BrandId::Fire);

    EXPECT_FALSE(IsLoadoutValid(BrandLoadout{ BrandId::Frost, 0 }, fire, 50, cfg));
    EXPECT_TRUE(IsLoadoutValid(BrandLoadout{ BrandId::Fire, 0 }, fire, 0, cfg));
}
