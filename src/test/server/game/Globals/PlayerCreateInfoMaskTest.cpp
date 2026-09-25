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

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/3113
//
// The playercreateinfo_* tables select rows by raceMask/classMask. ForEachRaceClass turns one such
// pair into the (race, class) combinations it covers, and is kept free of sWorld and DBC so the
// rule can be asserted here without a live world.

#include "ObjectMgr.h"
#include "SharedDefines.h"
#include "gtest/gtest.h"

#include <utility>
#include <vector>

namespace
{
    // RaceMgr stores the highest playable race id plus one. WotLK has ten playable races, ids 1-8,
    // 10 and 11, since id 9 is flagged not playable - hence 12 rather than 11.
    constexpr uint8 WOTLK_MAX_RACES = 12;

    std::vector<std::pair<uint8, uint8>> Expand(uint32 raceMask, uint32 classMask, bool allowAll = true,
        uint8 maxRaces = WOTLK_MAX_RACES)
    {
        std::vector<std::pair<uint8, uint8>> out;
        ForEachRaceClass(raceMask, classMask, maxRaces, allowAll,
            [&out](uint8 raceId, uint8 classId)
        {
            out.emplace_back(raceId, classId);
        });
        return out;
    }

    constexpr uint32 MaskOf(uint8 id)
    {
        return 1u << (id - 1);
    }
}

TEST(PlayerCreateInfoMaskTest, SingleBitPairSelectsOneCombination)
{
    auto const got = Expand(MaskOf(RACE_HUMAN), MaskOf(CLASS_WARRIOR));

    ASSERT_EQ(got.size(), 1u);
    EXPECT_EQ(got[0].first, RACE_HUMAN);
    EXPECT_EQ(got[0].second, CLASS_WARRIOR);
}

TEST(PlayerCreateInfoMaskTest, MultipleBitsSelectTheFullRectangle)
{
    // Two races by three classes is six pairs. This is the property that makes condensing safe:
    // a row stands for the complete cross product of its two masks, never a ragged subset.
    uint32 const races = MaskOf(RACE_ORC) | MaskOf(RACE_TROLL);
    uint32 const classes = MaskOf(CLASS_WARRIOR) | MaskOf(CLASS_HUNTER) | MaskOf(CLASS_ROGUE);

    auto const got = Expand(races, classes);

    ASSERT_EQ(got.size(), 6u);
    for (auto const& [raceId, classId] : got)
    {
        EXPECT_TRUE(raceId == RACE_ORC || raceId == RACE_TROLL) << "race " << uint32(raceId);
        EXPECT_TRUE(classId == CLASS_WARRIOR || classId == CLASS_HUNTER || classId == CLASS_ROGUE)
            << "class " << uint32(classId);
    }
}

TEST(PlayerCreateInfoMaskTest, ZeroMaskMeansEveryValueWhenAllowed)
{
    // playercreateinfo_item ships exactly one row, raceMask 0 and classMask 32 for the death
    // knight, stripping an unused item from every one of them. A zero race mask has to keep
    // meaning "all races".
    auto const got = Expand(0, MaskOf(CLASS_DEATH_KNIGHT));

    // Every id below the limit, so 11 - the walk covers ids rather than playable races, and the
    // unplayable id 9 simply finds no PlayerInfo to act on.
    ASSERT_EQ(got.size(), std::size_t(WOTLK_MAX_RACES - 1));
    for (auto const& [raceId, classId] : got)
    {
        EXPECT_EQ(classId, CLASS_DEATH_KNIGHT);
        EXPECT_GE(raceId, uint8(RACE_HUMAN));
    }
}

TEST(PlayerCreateInfoMaskTest, ZeroMaskSelectsNothingWhenNotAllowed)
{
    // playercreateinfo allocates the PlayerInfo entries, so a zero mask there must not expand.
    // Letting it through would create combinations the game does not have, such as a human shaman,
    // and make them selectable at character creation.
    EXPECT_TRUE(Expand(0, MaskOf(CLASS_WARRIOR), false).empty());
    EXPECT_TRUE(Expand(MaskOf(RACE_HUMAN), 0, false).empty());
    EXPECT_TRUE(Expand(0, 0, false).empty());
}

TEST(PlayerCreateInfoMaskTest, BitsBeyondTheKnownRangeAreIgnored)
{
    // A mask naming races or classes that do not exist must not index past the arrays the caller
    // writes into. Only the bits inside the range survive.
    uint32 const racesWithJunk = MaskOf(RACE_HUMAN) | (1u << 20);
    uint32 const classesWithJunk = MaskOf(CLASS_MAGE) | (1u << 20);

    auto const got = Expand(racesWithJunk, classesWithJunk);

    ASSERT_EQ(got.size(), 1u);
    EXPECT_EQ(got[0].first, RACE_HUMAN);
    EXPECT_EQ(got[0].second, CLASS_MAGE);
}

TEST(PlayerCreateInfoMaskTest, RaceIdsPastTheMaskWidthAreNotShifted)
{
    // raceMask is 32 bits, so an id above 32 has no bit to test. Without the guard the walk would
    // evaluate 1u << 32, which is undefined, and this is the only case that reaches it: a realm
    // whose ChrRaces.dbc carries more than 32 playable races.
    auto const got = Expand(0xFFFFFFFF, MaskOf(CLASS_WARRIOR), true, 40);

    ASSERT_EQ(got.size(), 32u);
    EXPECT_EQ(got.front().first, uint8(RACE_HUMAN));
    EXPECT_EQ(got.back().first, uint8(32));
}

TEST(PlayerCreateInfoMaskTest, RacesAreBoundedByMaxRaces)
{
    // RaceMgr reports how many races the DBC actually has. A mask naming more than that stops at
    // the limit rather than walking past it.
    uint32 const allRaces = 0xFFFFFFFF;

    auto const got = Expand(allRaces, MaskOf(CLASS_WARRIOR), true, 3);

    ASSERT_EQ(got.size(), 2u);
    EXPECT_EQ(got[0].first, uint8(RACE_HUMAN));
    EXPECT_EQ(got[1].first, uint8(RACE_ORC));
}
