/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/2764
//
// Rate.<Profession>.DropAmount scales how many items a profession action yields. Two pure
// functions carry that: CalculateDropAmount does the arithmetic, RateForLootSource decides which
// rate a given loot source is scaled by. Both are kept free of sWorld and DBC so they can be
// asserted here without a live world.

#include "LootMgr.h"
#include "SharedDefines.h"
#include "WorldConfig.h"
#include "gtest/gtest.h"

#include <limits>

TEST(LootDropAmountTest, RateOfOneIsIdentity)
{
    // The default rate must not perturb blizzlike amounts at all.
    for (uint32 rolled = 0; rolled <= 20; ++rolled)
        EXPECT_EQ(CalculateDropAmount(rolled, 1.0f), rolled) << "rolled " << rolled;
}

TEST(LootDropAmountTest, ScalesWholeMultiples)
{
    EXPECT_EQ(CalculateDropAmount(1, 3.0f), 3u);
    EXPECT_EQ(CalculateDropAmount(2, 3.0f), 6u);
    EXPECT_EQ(CalculateDropAmount(4, 2.0f), 8u);
}

TEST(LootDropAmountTest, FractionalRatesRoundRatherThanTruncate)
{
    // 3 * 1.5 is 4.5. Truncating would quietly bias every fractional rate downwards.
    EXPECT_EQ(CalculateDropAmount(3, 1.5f), 5u);
    EXPECT_EQ(CalculateDropAmount(2, 1.5f), 3u);
    EXPECT_EQ(CalculateDropAmount(10, 1.25f), 13u);  // 12.5 rounds up
    EXPECT_EQ(CalculateDropAmount(10, 1.24f), 12u);  // 12.4 rounds down
}

TEST(LootDropAmountTest, RatesBelowOneThinStacksButNeverDeleteTheDrop)
{
    EXPECT_EQ(CalculateDropAmount(10, 0.5f), 5u);
    EXPECT_EQ(CalculateDropAmount(3, 0.5f), 2u);     // 1.5 rounds up

    // The item already passed its drop roll, so it must still be in the loot. Returning 0 here
    // would put a zero-count item in the loot window instead of dropping less of it.
    EXPECT_EQ(CalculateDropAmount(1, 0.5f), 1u);
    EXPECT_EQ(CalculateDropAmount(1, 0.1f), 1u);
    EXPECT_EQ(CalculateDropAmount(4, 0.01f), 1u);
}

TEST(LootDropAmountTest, NothingRolledStaysNothing)
{
    // A rate must not conjure an item out of a zero roll.
    EXPECT_EQ(CalculateDropAmount(0, 1.0f), 0u);
    EXPECT_EQ(CalculateDropAmount(0, 100.0f), 0u);
}

TEST(LootDropAmountTest, ExtremeRatesSaturateInsteadOfWrapping)
{
    // Config accepts any rate above 0, so the arithmetic must survive an absurd one rather than
    // wrapping around into a small count.
    uint32 const huge = CalculateDropAmount(std::numeric_limits<uint32>::max(), 1000.0f);
    EXPECT_EQ(huge, std::numeric_limits<uint32>::max());

    EXPECT_GT(CalculateDropAmount(200, 1.0e9f), 1u);
}

TEST(LootDropAmountTest, LimitedAndQuestItemsAreNeverScaled)
{
    // An ordinary item scales.
    EXPECT_FLOAT_EQ(ScalableDropRate(false, 0, 5.0f), 5.0f);

    // A quest row keeps its fixed count: the objective needs an exact number.
    EXPECT_FLOAT_EQ(ScalableDropRate(true, 0, 5.0f), 1.0f);

    // An item with a MaxCount - a Shadowforge Key from fishing, a Grim Guzzler Key from
    // pickpocketing - must never be duplicated. Loot::AddItem splits a scaled count into one row
    // per stack, and a player cannot take the copies past MaxCount, so unlootedCount would never
    // reach 0. Loot::isLooted() would then stay false forever and DoLootRelease would never clear
    // the loot, leaving the creature or fishing pool stuck with a dead loot window until respawn.
    EXPECT_FLOAT_EQ(ScalableDropRate(false, 1, 5.0f), 1.0f);
    EXPECT_FLOAT_EQ(ScalableDropRate(false, 3, 5.0f), 1.0f);

    // ItemTemplate::MaxCount documents <= 0 as "no limit", so a negative must not read as a cap.
    EXPECT_FLOAT_EQ(ScalableDropRate(false, -1, 5.0f), 5.0f);

    // A rate of 1 stays 1 whatever the flags.
    EXPECT_FLOAT_EQ(ScalableDropRate(false, 0, 1.0f), 1.0f);
}

TEST(LootDropAmountTest, EachProfessionStoreMapsToItsOwnRate)
{
    // lockSkillType is irrelevant for these: the store alone identifies the profession.
    EXPECT_EQ(RateForLootSource(LootTemplates_Skinning, 0, SKILL_SKINNING), RATE_SKINNING_DROP_AMOUNT);
    EXPECT_EQ(RateForLootSource(LootTemplates_Fishing, 0, 0), RATE_FISHING_DROP_AMOUNT);
    EXPECT_EQ(RateForLootSource(LootTemplates_Milling, 0, 0), RATE_MILLING_DROP_AMOUNT);
    EXPECT_EQ(RateForLootSource(LootTemplates_Prospecting, 0, 0), RATE_PROSPECTING_DROP_AMOUNT);
    EXPECT_EQ(RateForLootSource(LootTemplates_Disenchant, 0, 0), RATE_DISENCHANTING_DROP_AMOUNT);
    EXPECT_EQ(RateForLootSource(LootTemplates_Pickpocketing, 0, 0), RATE_PICKPOCKETING_DROP_AMOUNT);
}

TEST(LootDropAmountTest, GatheringNodesAreSplitByTheirLock)
{
    // Ore nodes, herbs and fishing pools all share gameobject_loot_template, so only the lock
    // separates them.
    EXPECT_EQ(RateForLootSource(LootTemplates_Gameobject, LOCKTYPE_MINING, 0), RATE_MINING_DROP_AMOUNT);
    EXPECT_EQ(RateForLootSource(LootTemplates_Gameobject, LOCKTYPE_HERBALISM, 0), RATE_HERBALISM_DROP_AMOUNT);
}

TEST(LootDropAmountTest, BothHalvesOfFishingUseTheFishingRate)
{
    // An open-water cast fills from fishing_loot_template, but a pool is looted as the fishing hole
    // itself and fills from gameobject_loot_template. One config key covers fishing, so both paths
    // must resolve to it - otherwise setting the rate multiplies open-water catches while every
    // school in the game stays blizzlike.
    EXPECT_EQ(RateForLootSource(LootTemplates_Fishing, 0, 0), RATE_FISHING_DROP_AMOUNT);
    EXPECT_EQ(RateForLootSource(LootTemplates_Gameobject, LOCKTYPE_FISHING, 0), RATE_FISHING_DROP_AMOUNT);
}

TEST(LootDropAmountTest, OtherGameobjectsAreNeverScaled)
{
    // The regression that matters: chests, quest objects and world containers read the same store
    // as gathering nodes. Scaling them would multiply quest and dungeon loot server-wide.
    EXPECT_EQ(RateForLootSource(LootTemplates_Gameobject, 0, 0), MAX_NUM_SERVER_CONFIGS);
    EXPECT_EQ(RateForLootSource(LootTemplates_Gameobject, LOCKTYPE_PICKLOCK, 0), MAX_NUM_SERVER_CONFIGS);
    EXPECT_EQ(RateForLootSource(LootTemplates_Gameobject, LOCKTYPE_OPEN, 0), MAX_NUM_SERVER_CONFIGS);
    EXPECT_EQ(RateForLootSource(LootTemplates_Gameobject, LOCKTYPE_TREASURE, 0), MAX_NUM_SERVER_CONFIGS);
    EXPECT_EQ(RateForLootSource(LootTemplates_Gameobject, LOCKTYPE_DISARM_TRAP, 0), MAX_NUM_SERVER_CONFIGS);
}

TEST(LootDropAmountTest, CorpsesFollowTheSkillThatOpensThem)
{
    // A "skinnable" corpse can require herbalism, mining or engineering instead of skinning
    // (CreatureTemplate::GetRequiredLootSkill), and all four read skinning_loot_template. Keying on
    // the store alone would put ore from a mechanical and herbs from a plant mob under
    // Rate.Skinning.DropAmount, so raising skinning for leatherworkers would quietly multiply both.
    EXPECT_EQ(RateForLootSource(LootTemplates_Skinning, 0, SKILL_MINING), RATE_MINING_DROP_AMOUNT);
    EXPECT_EQ(RateForLootSource(LootTemplates_Skinning, 0, SKILL_HERBALISM), RATE_HERBALISM_DROP_AMOUNT);

    // Gas clouds. Engineering has no drop-amount rate of its own, so they must stay blizzlike
    // rather than borrow the skinning one.
    EXPECT_EQ(RateForLootSource(LootTemplates_Skinning, 0, SKILL_ENGINEERING), MAX_NUM_SERVER_CONFIGS);
}

TEST(LootDropAmountTest, NonProfessionStoresAreNeverScaled)
{
    // Creature kills, openable items, mail and player loot keep blizzlike amounts whatever the
    // profession rates are set to.
    EXPECT_EQ(RateForLootSource(LootTemplates_Creature, 0, 0), MAX_NUM_SERVER_CONFIGS);
    EXPECT_EQ(RateForLootSource(LootTemplates_Item, 0, 0), MAX_NUM_SERVER_CONFIGS);
    EXPECT_EQ(RateForLootSource(LootTemplates_Mail, 0, 0), MAX_NUM_SERVER_CONFIGS);
    EXPECT_EQ(RateForLootSource(LootTemplates_Reference, 0, 0), MAX_NUM_SERVER_CONFIGS);
    EXPECT_EQ(RateForLootSource(LootTemplates_Spell, 0, 0), MAX_NUM_SERVER_CONFIGS);
    EXPECT_EQ(RateForLootSource(LootTemplates_Player, 0, 0), MAX_NUM_SERVER_CONFIGS);

    // A creature carrying a mining lock type must still not be scaled - the lock only ever
    // disambiguates within the gameobject store.
    EXPECT_EQ(RateForLootSource(LootTemplates_Creature, LOCKTYPE_MINING, 0), MAX_NUM_SERVER_CONFIGS);
}
