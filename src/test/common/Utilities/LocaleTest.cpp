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

#include "Common.h"
#include "gtest/gtest.h"

namespace
{
    constexpr LocaleConstant LOCALE_MODULE_SLOT = LocaleConstant(11);
}

TEST(LocaleTest, BuiltInLocalesAreRegistered)
{
    for (uint8 i = LOCALE_enUS; i <= LOCALE_ruRU; ++i)
    {
        EXPECT_TRUE(IsLocaleRegistered(LocaleConstant(i)));
        EXPECT_EQ(GetLocaleByName(localeNames[i]), LocaleConstant(i));
        EXPECT_EQ(GetNameByLocaleConstant(LocaleConstant(i)), localeNames[i]);
    }

    for (uint8 i = LOCALE_ruRU + 1; i < TOTAL_LOCALES; ++i)
        EXPECT_FALSE(IsLocaleRegistered(LocaleConstant(i)));

    EXPECT_FALSE(IsLocaleRegistered(TOTAL_LOCALES));
}

TEST(LocaleTest, EmptyNameDoesNotMatchFreeSlots)
{
    EXPECT_EQ(GetLocaleByName(""), LOCALE_enUS);
    EXPECT_FALSE(IsLocaleValid(""));
}

TEST(LocaleTest, UnknownNameFallsBackToEnUS)
{
    EXPECT_EQ(GetLocaleByName("enGB"), LOCALE_enUS);
    EXPECT_EQ(GetLocaleByName("xxXX"), LOCALE_enUS);
    EXPECT_FALSE(IsLocaleValid("enGB"));
    EXPECT_FALSE(IsLocaleValid("xxXX"));
}

TEST(LocaleTest, NameOfUnregisteredOrInvalidLocaleIsEnUS)
{
    EXPECT_EQ(GetNameByLocaleConstant(LOCALE_MODULE_SLOT), "enUS");
    EXPECT_EQ(GetNameByLocaleConstant(TOTAL_LOCALES), "enUS");
}

class ModuleLocaleTest : public testing::Test
{
protected:
    void SetUp() override { localeNames[LOCALE_MODULE_SLOT] = "itIT"; }
    void TearDown() override { localeNames[LOCALE_MODULE_SLOT] = nullptr; }
};

TEST_F(ModuleLocaleTest, RegisteredSlotResolves)
{
    EXPECT_TRUE(IsLocaleRegistered(LOCALE_MODULE_SLOT));
    EXPECT_EQ(GetLocaleByName("itIT"), LOCALE_MODULE_SLOT);
    EXPECT_TRUE(IsLocaleValid("itIT"));
    EXPECT_EQ(GetNameByLocaleConstant(LOCALE_MODULE_SLOT), "itIT");
}
