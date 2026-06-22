#include "branding/economy/Economy.h"
#include "branding/economy/RecipeBook.h"
#include <gtest/gtest.h>

using namespace Branding;

// --- Recipe registry (§8.6) ---

TEST(RecipeBook, StartsEmptyAndFindMisses)
{
    RecipeBook book;
    EXPECT_TRUE(book.Empty());
    EXPECT_EQ(book.Size(), 0u);
    EXPECT_EQ(book.Find(1), nullptr);
}

TEST(RecipeBook, AddThenFindReturnsStoredRecipe)
{
    RecipeBook book;
    Recipe recipe{ 10, 5, 42, 100 };
    EXPECT_TRUE(book.Add(7, recipe));
    EXPECT_FALSE(book.Empty());
    EXPECT_EQ(book.Size(), 1u);

    Recipe const* found = book.Find(7);
    ASSERT_NE(found, nullptr);
    EXPECT_EQ(found->materials, 10u);
    EXPECT_EQ(found->fragments, 5u);
    EXPECT_EQ(found->outputItemId, 42u);
    EXPECT_EQ(found->charXp, 100u);
}

TEST(RecipeBook, RejectsRecipeWithNoOutput)
{
    RecipeBook book;
    Recipe bad{ 10, 5, 0, 100 };   // no output item -> malformed
    EXPECT_FALSE(book.Add(3, bad));
    EXPECT_TRUE(book.Empty());
    EXPECT_EQ(book.Find(3), nullptr);
}

TEST(RecipeBook, AddReplacesExistingId)
{
    RecipeBook book;
    book.Add(1, Recipe{ 1, 1, 100, 10 });
    book.Add(1, Recipe{ 2, 2, 200, 20 });
    EXPECT_EQ(book.Size(), 1u);

    Recipe const* found = book.Find(1);
    ASSERT_NE(found, nullptr);
    EXPECT_EQ(found->outputItemId, 200u);
    EXPECT_EQ(found->materials, 2u);
}

TEST(RecipeBook, ClearEmptiesTheBook)
{
    RecipeBook book;
    book.Add(1, Recipe{ 1, 1, 100, 10 });
    book.Add(2, Recipe{ 1, 1, 200, 10 });
    EXPECT_EQ(book.Size(), 2u);
    book.Clear();
    EXPECT_TRUE(book.Empty());
    EXPECT_EQ(book.Find(1), nullptr);
}

// The closed-loop contract: a recipe resolved from the book consumes exact inputs and yields the
// stored output (mirrors the in-world craft path through ResolveCraft).
TEST(RecipeBook, ResolvedRecipeFromBookCraftsExactly)
{
    RecipeBook book;
    book.Add(5, Recipe{ 10, 5, 42, 100 });

    Recipe const* recipe = book.Find(5);
    ASSERT_NE(recipe, nullptr);

    Resources have{ 30, 20 };
    CraftResult r = ResolveCraft(*recipe, have);
    EXPECT_TRUE(r.crafted);
    EXPECT_EQ(r.consumed.materials, 10u);
    EXPECT_EQ(r.consumed.fragments, 5u);
    EXPECT_EQ(r.outputItemId, 42u);
    EXPECT_EQ(r.charXp, 100u);

    Resources broke{ 8, 5 };
    EXPECT_FALSE(ResolveCraft(*recipe, broke).crafted);
}

// §16 per-school Fragments: a recipe carries the BrandId of the Fragment it consumes. The pure core
// only routes the *count* (ResolveCraft is school-blind); the adapter maps school -> Fragment entry.
TEST(RecipeBook, RecipeDefaultsToNoSchool)
{
    Recipe recipe;
    EXPECT_EQ(recipe.school, BrandId::COUNT);   // COUNT == "no school" -> generic Fragment
}

TEST(RecipeBook, SchoolRoundTripsThroughTheBook)
{
    RecipeBook book;
    Recipe recipe{ 10, 5, 42, 100 };
    recipe.school = BrandId::Fire;
    book.Add(7, recipe);

    Recipe const* found = book.Find(7);
    ASSERT_NE(found, nullptr);
    EXPECT_EQ(found->school, BrandId::Fire);
}

TEST(RecipeBook, ResolveCraftIsSchoolBlind)
{
    // Two recipes identical but for school resolve to the same craft outcome -- school never changes
    // what or how much is consumed; it only tells the adapter which Fragment item to draw from.
    Recipe fire{ 10, 5, 42, 100 };
    fire.school = BrandId::Fire;
    Recipe frost{ 10, 5, 42, 100 };
    frost.school = BrandId::Frost;

    Resources have{ 30, 20 };
    CraftResult a = ResolveCraft(fire, have);
    CraftResult b = ResolveCraft(frost, have);
    EXPECT_TRUE(a.crafted);
    EXPECT_TRUE(b.crafted);
    EXPECT_EQ(a.consumed.fragments, b.consumed.fragments);
    EXPECT_EQ(a.consumed.materials, b.consumed.materials);
    EXPECT_EQ(a.outputItemId, b.outputItemId);
}
