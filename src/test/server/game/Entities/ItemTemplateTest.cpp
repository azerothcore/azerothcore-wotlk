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

#include "ItemTemplate.h"
#include "gtest/gtest.h"

TEST(ItemTemplateTest, ItemWithoutDurationIsNotTemporary)
{
    ItemTemplate proto{};
    proto.Duration = 0;

    EXPECT_FALSE(proto.IsTemporary());
}

TEST(ItemTemplateTest, ItemWithNineHundredSecondsDurationIsTemporary)
{
    ItemTemplate proto{};
    proto.Duration = 900;

    EXPECT_TRUE(proto.IsTemporary());
}

TEST(ItemTemplateTest, ItemWithOneSecondDurationIsTemporary)
{
    ItemTemplate proto{};
    proto.Duration = 1;

    EXPECT_TRUE(proto.IsTemporary());
}

TEST(ItemTemplateTest, MapAndAreaLimitsAloneDoNotMakeAnItemTemporary)
{
    ItemTemplate proto{};
    proto.Duration = 0;
    proto.Map = 550;
    proto.Area = 2017;

    EXPECT_FALSE(proto.IsTemporary());
}
