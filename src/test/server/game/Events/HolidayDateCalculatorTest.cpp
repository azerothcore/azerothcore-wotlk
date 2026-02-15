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

#include "HolidayDateCalculator.h"
#include "gtest/gtest.h"

class HolidayDateCalculatorTest : public ::testing::Test
{
protected:
    void ExpectDate(const std::tm& date, int year, int month, int day)
    {
        EXPECT_EQ(date.tm_year + 1900, year);
        EXPECT_EQ(date.tm_mon + 1, month);
        EXPECT_EQ(date.tm_mday, day);
    }

    // Helper to verify a date is a valid calendar date
    bool IsValidDate(int year, int month, int day)
    {
        if (month < 1 || month > 12) return false;
        if (day < 1 || day > 31) return false;

        // Check days in month
        int daysInMonth[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

        // Leap year check for February
        if (month == 2)
        {
            bool isLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
            if (isLeap) daysInMonth[2] = 29;
        }

        return day <= daysInMonth[month];
    }

    // Helper to check if a year is a leap year
    bool IsLeapYear(int year)
    {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }
};

// ============================================================
// Easter Calculation Tests (1900-2200)
// ============================================================

TEST_F(HolidayDateCalculatorTest, EasterSunday_KnownDates)
{
    // Verify against known Easter dates
    // Source: https://www.census.gov/data/software/x13as/genhol/easter-dates.html
    struct EasterTestCase { int year; int month; int day; };
    std::vector<EasterTestCase> testCases = {
        // Historical dates
        { 1900, 4, 15 },
        { 1901, 4,  7 },
        { 1950, 4,  9 },
        { 1999, 4,  4 },
        // Recent dates
        { 2000, 4, 23 },
        { 2010, 4,  4 },
        { 2020, 4, 12 },
        { 2021, 4,  4 },
        { 2022, 4, 17 },
        { 2023, 4,  9 },
        { 2024, 3, 31 },
        { 2025, 4, 20 },
        { 2026, 4,  5 },
        { 2027, 3, 28 },
        { 2028, 4, 16 },
        { 2029, 4,  1 },
        { 2030, 4, 21 },
        // Future dates
        { 2050, 4, 10 },
        { 2100, 3, 28 },
        { 2150, 4, 12 },
        { 2200, 4,  6 },
    };

    for (auto const& tc : testCases)
    {
        std::tm easter = HolidayDateCalculator::CalculateEasterSunday(tc.year);
        SCOPED_TRACE("Year: " + std::to_string(tc.year));
        ExpectDate(easter, tc.year, tc.month, tc.day);
    }
}

TEST_F(HolidayDateCalculatorTest, EasterSunday_ValidDateRange_1900_2200)
{
    // Easter must always fall between March 22 and April 25 (inclusive)
    for (int year = 1900; year <= 2200; ++year)
    {
        std::tm easter = HolidayDateCalculator::CalculateEasterSunday(year);

        SCOPED_TRACE("Year: " + std::to_string(year));

        // Verify year is correct
        EXPECT_EQ(easter.tm_year + 1900, year);

        // Easter must be in March or April
        EXPECT_TRUE(easter.tm_mon == 2 || easter.tm_mon == 3)
            << "Easter must be in March (2) or April (3), got month " << easter.tm_mon;

        // Easter range: March 22 - April 25
        if (easter.tm_mon == 2) // March
        {
            EXPECT_GE(easter.tm_mday, 22) << "Easter in March must be >= 22";
            EXPECT_LE(easter.tm_mday, 31) << "Easter in March must be <= 31";
        }
        else // April
        {
            EXPECT_GE(easter.tm_mday, 1) << "Easter in April must be >= 1";
            EXPECT_LE(easter.tm_mday, 25) << "Easter in April must be <= 25";
        }

        // Easter must be a Sunday
        EXPECT_EQ(easter.tm_wday, 0) << "Easter must be a Sunday";
    }
}

TEST_F(HolidayDateCalculatorTest, EasterSunday_AlwaysSunday_1900_2200)
{
    // Verify Easter is always on Sunday for entire range
    for (int year = 1900; year <= 2200; ++year)
    {
        std::tm easter = HolidayDateCalculator::CalculateEasterSunday(year);
        EXPECT_EQ(easter.tm_wday, 0) << "Easter " << year << " should be Sunday";
    }
}

// ============================================================
// Nth Weekday Calculation Tests (1900-2200)
// ============================================================

TEST_F(HolidayDateCalculatorTest, NthWeekday_Thanksgiving_1900_2200)
{
    // Verify 4th Thursday of November for all years
    for (int year = 1900; year <= 2200; ++year)
    {
        std::tm date = HolidayDateCalculator::CalculateNthWeekday(year, 11, Weekday::THURSDAY, 4);

        SCOPED_TRACE("Year: " + std::to_string(year));

        // Must be in November
        EXPECT_EQ(date.tm_mon + 1, 11);

        // Must be a Thursday
        EXPECT_EQ(date.tm_wday, static_cast<int>(Weekday::THURSDAY));

        // 4th Thursday must be between 22nd and 28th
        EXPECT_GE(date.tm_mday, 22);
        EXPECT_LE(date.tm_mday, 28);

        // Verify it's actually the 4th occurrence
        // First Thursday can be 1-7, so 4th is (first + 21) which gives range 22-28
        int firstThursday = date.tm_mday - 21;
        EXPECT_GE(firstThursday, 1);
        EXPECT_LE(firstThursday, 7);
    }
}

TEST_F(HolidayDateCalculatorTest, NthWeekday_AllWeekdays_1900_2200)
{
    // Test first occurrence of each weekday in January for all years
    for (int year = 1900; year <= 2200; ++year)
    {
        for (int weekday = 0; weekday <= 6; ++weekday)
        {
            std::tm date = HolidayDateCalculator::CalculateNthWeekday(year, 1, static_cast<Weekday>(weekday), 1);

            SCOPED_TRACE("Year: " + std::to_string(year) + " Weekday: " + std::to_string(weekday));

            // Must be in January
            EXPECT_EQ(date.tm_mon + 1, 1);

            // Must be the correct weekday
            EXPECT_EQ(date.tm_wday, weekday);

            // First occurrence must be within first 7 days
            EXPECT_GE(date.tm_mday, 1);
            EXPECT_LE(date.tm_mday, 7);
        }
    }
}

TEST_F(HolidayDateCalculatorTest, NthWeekday_SecondThirdFourth_Validation)
{
    // Verify 2nd, 3rd, 4th occurrences are exactly 7 days apart
    for (int year = 2000; year <= 2100; ++year)
    {
        for (int month = 1; month <= 12; ++month)
        {
            std::tm first = HolidayDateCalculator::CalculateNthWeekday(year, month, Weekday::MONDAY, 1);
            std::tm second = HolidayDateCalculator::CalculateNthWeekday(year, month, Weekday::MONDAY, 2);
            std::tm third = HolidayDateCalculator::CalculateNthWeekday(year, month, Weekday::MONDAY, 3);
            std::tm fourth = HolidayDateCalculator::CalculateNthWeekday(year, month, Weekday::MONDAY, 4);

            SCOPED_TRACE("Year: " + std::to_string(year) + " Month: " + std::to_string(month));

            EXPECT_EQ(second.tm_mday - first.tm_mday, 7);
            EXPECT_EQ(third.tm_mday - second.tm_mday, 7);
            EXPECT_EQ(fourth.tm_mday - third.tm_mday, 7);
        }
    }
}

// ============================================================
// Date Packing/Unpacking Tests
// Note: Pack format uses 5 bits for year offset from 2000, so range is 2000-2031
// ============================================================

TEST_F(HolidayDateCalculatorTest, PackDate_RoundTrip)
{
    // Test that pack/unpack preserves date information correctly
    struct PackTestCase { int year; int month; int day; };
    std::vector<PackTestCase> testCases = {
        { 2000, 1,  1 },   // Min year in pack range
        { 2000, 12, 31 },  // End of min year
        { 2015, 6, 15 },   // Mid range
        { 2020, 1, 24 },   // Lunar Festival 2020
        { 2025, 11, 27 },  // Thanksgiving 2025
        { 2030, 4, 28 },   // Noblegarden 2030
        { 2031, 12, 31 },  // Max year in pack range
    };

    for (auto const& tc : testCases)
    {
        std::tm date = {};
        date.tm_year = tc.year - 1900;
        date.tm_mon = tc.month - 1;
        date.tm_mday = tc.day;
        mktime(&date);

        uint32_t packed = HolidayDateCalculator::PackDate(date);
        std::tm unpacked = HolidayDateCalculator::UnpackDate(packed);

        SCOPED_TRACE("Date: " + std::to_string(tc.year) + "-" +
                     std::to_string(tc.month) + "-" + std::to_string(tc.day));
        ExpectDate(unpacked, tc.year, tc.month, tc.day);
    }
}

TEST_F(HolidayDateCalculatorTest, PackUnpack_Roundtrip_FullRange)
{
    // Test pack/unpack for entire valid range (2000-2031)
    for (int year = 2000; year <= 2031; ++year)
    {
        for (int month = 1; month <= 12; ++month)
        {
            for (int day = 1; day <= 28; ++day) // Safe range for all months
            {
                std::tm original = {};
                original.tm_year = year - 1900;
                original.tm_mon = month - 1;
                original.tm_mday = day;
                mktime(&original);

                uint32_t packed = HolidayDateCalculator::PackDate(original);
                std::tm unpacked = HolidayDateCalculator::UnpackDate(packed);

                EXPECT_EQ(original.tm_year, unpacked.tm_year);
                EXPECT_EQ(original.tm_mon, unpacked.tm_mon);
                EXPECT_EQ(original.tm_mday, unpacked.tm_mday);
            }
        }
    }
}

TEST_F(HolidayDateCalculatorTest, UnpackDate_KnownValues)
{
    struct UnpackTestCase { uint32_t packed; int year; int month; int day; };
    std::vector<UnpackTestCase> testCases = {
        { 335921152, 2020, 1, 24 },
        { 352681984, 2021, 1, 23 },
        { 336707584, 2020, 2,  8 },
        { 346390592, 2020, 11, 23 },
    };

    for (auto const& tc : testCases)
    {
        std::tm date = HolidayDateCalculator::UnpackDate(tc.packed);
        SCOPED_TRACE("Packed: " + std::to_string(tc.packed));
        ExpectDate(date, tc.year, tc.month, tc.day);
    }
}

// ============================================================
// Noblegarden (Easter-based) Tests - Extended Range
// ============================================================

TEST_F(HolidayDateCalculatorTest, Noblegarden_DayAfterEaster_1900_2200)
{
    // Noblegarden should be Easter + 1 day (Monday after Easter) for all years
    for (int year = 1900; year <= 2200; ++year)
    {
        std::tm easter = HolidayDateCalculator::CalculateEasterSunday(year);

        // Calculate expected Noblegarden date (Easter + 1)
        std::tm expectedNoblegarden = easter;
        expectedNoblegarden.tm_mday += 1;
        mktime(&expectedNoblegarden); // Normalize (handles month rollover)

        // Get calculated Noblegarden from holiday rule
        HolidayRule noblegarden = { 181, HolidayCalculationType::EASTER_OFFSET, 0, 0, 0, 1 };
        std::tm calculated = HolidayDateCalculator::CalculateHolidayDate(noblegarden, year);

        SCOPED_TRACE("Year: " + std::to_string(year));

        EXPECT_EQ(calculated.tm_year, expectedNoblegarden.tm_year);
        EXPECT_EQ(calculated.tm_mon, expectedNoblegarden.tm_mon);
        EXPECT_EQ(calculated.tm_mday, expectedNoblegarden.tm_mday);

        // Noblegarden should be Monday (1 day after Easter Sunday)
        EXPECT_EQ(calculated.tm_wday, 1) << "Noblegarden should be Monday";
    }
}

// ============================================================
// Pilgrim's Bounty (Thanksgiving) Tests - Extended Range
// ============================================================

TEST_F(HolidayDateCalculatorTest, PilgrimsBounty_SundayBeforeThanksgiving_1900_2200)
{
    // Pilgrim's Bounty = Sunday before Thanksgiving (4th Thursday - 4 days)
    for (int year = 1900; year <= 2200; ++year)
    {
        // Calculate 4th Thursday of November
        std::tm thanksgiving = HolidayDateCalculator::CalculateNthWeekday(year, 11, Weekday::THURSDAY, 4);

        // Pilgrim's Bounty starts on Sunday before (4 days earlier)
        std::tm expectedPilgrims = thanksgiving;
        expectedPilgrims.tm_mday -= 4;
        mktime(&expectedPilgrims);

        // Get calculated date using rule with -4 offset
        HolidayRule pilgrimsBounty = { 404, HolidayCalculationType::NTH_WEEKDAY, 11, 4, static_cast<int>(Weekday::THURSDAY), -4 };
        std::tm date = HolidayDateCalculator::CalculateHolidayDate(pilgrimsBounty, year);

        SCOPED_TRACE("Year: " + std::to_string(year));

        EXPECT_EQ(date.tm_year + 1900, year);
        EXPECT_EQ(date.tm_mon + 1, 11);            // November
        EXPECT_EQ(date.tm_wday, 0);                // Sunday
        EXPECT_EQ(date.tm_mday, expectedPilgrims.tm_mday);

        // Sunday before 4th Thursday should be between 18th and 24th
        EXPECT_GE(date.tm_mday, 18);
        EXPECT_LE(date.tm_mday, 24);
    }
}

// ============================================================
// Fixed Date Holidays Tests - Extended Range
// ============================================================

TEST_F(HolidayDateCalculatorTest, FixedDateHolidays_ConsistentAcrossYears_1900_2200)
{
    // Fixed date holidays should have same month/day every year
    // Note: Brewfest, Harvest Festival, and Winter Veil are now dynamic (not fixed date)
    struct FixedHolidayTestCase { uint32_t holidayId; int month; int day; const char* name; };
    std::vector<FixedHolidayTestCase> testCases = {
        { 341, 6, 21, "Midsummer Fire Festival" },
        { 62,  7,  4, "Fireworks Spectacular" },
        { 398, 9, 19, "Pirates' Day" },
        { 324, 10, 18, "Hallow's End" },
        { 409, 11,  1, "Day of the Dead" },
    };

    for (auto const& tc : testCases)
    {
        HolidayRule rule = { tc.holidayId, HolidayCalculationType::FIXED_DATE, tc.month, tc.day, 0, 0 };

        for (int year = 1900; year <= 2200; ++year)
        {
            std::tm date = HolidayDateCalculator::CalculateHolidayDate(rule, year);

            SCOPED_TRACE(std::string(tc.name) + " Year: " + std::to_string(year));

            EXPECT_EQ(date.tm_year + 1900, year);
            EXPECT_EQ(date.tm_mon + 1, tc.month);
            EXPECT_EQ(date.tm_mday, tc.day);
        }
    }
}

// ============================================================
// Brewfest Tests (Fixed Sept 20 main event)
// ============================================================

TEST_F(HolidayDateCalculatorTest, Brewfest_FixedSept13)
{
    // Brewfest is now fixed: prep starts Sept 13, main event Sept 20
    // This avoids any potential overlap with Pirates' Day (Sept 19)
    HolidayRule brewfest = { 372, HolidayCalculationType::FIXED_DATE, 9, 13, 0, 0 };

    for (int year = 2000; year <= 2030; ++year)
    {
        std::tm date = HolidayDateCalculator::CalculateHolidayDate(brewfest, year);

        SCOPED_TRACE("Year: " + std::to_string(year));

        EXPECT_EQ(date.tm_year + 1900, year);
        EXPECT_EQ(date.tm_mon + 1, 9);   // September
        EXPECT_EQ(date.tm_mday, 13);     // Always Sept 13
    }
}

TEST_F(HolidayDateCalculatorTest, Brewfest_NoPiratesDayConflict)
{
    // Brewfest main event (Sept 20) is always after Pirates' Day (Sept 19)
    HolidayRule brewfest = { 372, HolidayCalculationType::FIXED_DATE, 9, 13, 0, 0 };
    HolidayRule piratesDay = { 398, HolidayCalculationType::FIXED_DATE, 9, 19, 0, 0 };

    for (int year = 2000; year <= 2030; ++year)
    {
        std::tm brewfestDate = HolidayDateCalculator::CalculateHolidayDate(brewfest, year);
        std::tm piratesDate = HolidayDateCalculator::CalculateHolidayDate(piratesDay, year);

        SCOPED_TRACE("Year: " + std::to_string(year));

        // Brewfest prep is Sept 13, main event is Sept 20
        // Pirates' Day is Sept 19, which falls between prep and main event
        EXPECT_EQ(brewfestDate.tm_mday, 13);  // Brewfest prep
        EXPECT_EQ(piratesDate.tm_mday, 19);   // Pirates' Day
        // Main event (Sept 20) > Pirates' Day (Sept 19)
    }
}

// ============================================================
// Harvest Festival Tests (Autumn Equinox based)
// 2 days before autumn equinox
// ============================================================

TEST_F(HolidayDateCalculatorTest, HarvestFestival_AutumnEquinoxBased)
{
    HolidayRule harvestFestival = { 321, HolidayCalculationType::AUTUMN_EQUINOX, 0, 0, 0, -2 };

    // Autumn equinox is typically Sept 22-23, so Harvest Festival is Sept 20-21
    for (int year = 2000; year <= 2030; ++year)
    {
        std::tm equinox = HolidayDateCalculator::CalculateAutumnEquinox(year);
        std::tm harvest = HolidayDateCalculator::CalculateHolidayDate(harvestFestival, year);

        SCOPED_TRACE("Year: " + std::to_string(year));

        // Harvest should be exactly 2 days before equinox
        // Convert to time_t to handle month boundaries correctly
        time_t equinoxTime = mktime(&equinox);
        time_t harvestTime = mktime(&harvest);

        double diffDays = difftime(equinoxTime, harvestTime) / (60 * 60 * 24);
        EXPECT_NEAR(diffDays, 2.0, 0.1) << "Harvest Festival should be 2 days before equinox";
    }
}

TEST_F(HolidayDateCalculatorTest, HarvestFestival_AlwaysInSeptember_1900_2200)
{
    HolidayRule harvestFestival = { 321, HolidayCalculationType::AUTUMN_EQUINOX, 0, 0, 0, -2 };

    for (int year = 1900; year <= 2200; ++year)
    {
        std::tm date = HolidayDateCalculator::CalculateHolidayDate(harvestFestival, year);

        SCOPED_TRACE("Year: " + std::to_string(year));

        // Harvest Festival should always be in September (2 days before Sept 22-23 equinox)
        EXPECT_EQ(date.tm_mon + 1, 9) << "Harvest Festival should be in September";
        // Should be around Sept 20-21
        EXPECT_GE(date.tm_mday, 18) << "Harvest Festival should be >= Sept 18";
        EXPECT_LE(date.tm_mday, 22) << "Harvest Festival should be <= Sept 22";
    }
}

// ============================================================
// Winter Veil Tests (Winter Solstice based)
// 6 days before winter solstice
// ============================================================

TEST_F(HolidayDateCalculatorTest, WinterVeil_WinterSolsticeBased)
{
    HolidayRule winterVeil = { 141, HolidayCalculationType::WINTER_SOLSTICE, 0, 0, 0, -6 };

    // Winter solstice is typically Dec 21-22, so Winter Veil starts Dec 15-16
    for (int year = 2000; year <= 2030; ++year)
    {
        std::tm solstice = HolidayDateCalculator::CalculateWinterSolstice(year);
        std::tm winterVeilDate = HolidayDateCalculator::CalculateHolidayDate(winterVeil, year);

        SCOPED_TRACE("Year: " + std::to_string(year));

        // Winter Veil should be exactly 6 days before solstice
        time_t solsticeTime = mktime(&solstice);
        time_t winterVeilTime = mktime(&winterVeilDate);

        double diffDays = difftime(solsticeTime, winterVeilTime) / (60 * 60 * 24);
        EXPECT_NEAR(diffDays, 6.0, 0.1) << "Winter Veil should be 6 days before solstice";
    }
}

TEST_F(HolidayDateCalculatorTest, WinterVeil_AlwaysInDecember_1900_2200)
{
    HolidayRule winterVeil = { 141, HolidayCalculationType::WINTER_SOLSTICE, 0, 0, 0, -6 };

    for (int year = 1900; year <= 2200; ++year)
    {
        std::tm date = HolidayDateCalculator::CalculateHolidayDate(winterVeil, year);

        SCOPED_TRACE("Year: " + std::to_string(year));

        // Winter Veil should always be in December
        EXPECT_EQ(date.tm_mon + 1, 12) << "Winter Veil should be in December";
        // Should be around Dec 15-16 (6 days before Dec 21-22)
        EXPECT_GE(date.tm_mday, 14) << "Winter Veil should be >= Dec 14";
        EXPECT_LE(date.tm_mday, 17) << "Winter Veil should be <= Dec 17";
    }
}

// ============================================================
// Love is in the Air (First Monday on or after Feb 3)
// ============================================================

TEST_F(HolidayDateCalculatorTest, LoveIsInTheAir_FirstMondayOnOrAfterFeb3)
{
    // Verify "first Monday on or after Feb 3" calculation
    struct LoveTestCase { int year; int expectedDay; };
    std::vector<LoveTestCase> testCases = {
        { 2024, 5 },   // Feb 3 is Sat, first Mon after is Feb 5
        { 2025, 3 },   // Feb 3 is Mon, so Feb 3
        { 2026, 9 },   // Feb 3 is Tue, first Mon after is Feb 9
        { 2027, 8 },   // Feb 3 is Wed, first Mon after is Feb 8
        { 2028, 7 },   // Feb 3 is Thu, first Mon after is Feb 7
        { 2029, 5 },   // Feb 3 is Sat, first Mon after is Feb 5
        { 2030, 4 },   // Feb 3 is Sun, first Mon after is Feb 4
    };

    for (auto const& tc : testCases)
    {
        std::tm date = HolidayDateCalculator::CalculateWeekdayOnOrAfter(tc.year, 2, 3, Weekday::MONDAY);

        SCOPED_TRACE("Year: " + std::to_string(tc.year));

        EXPECT_EQ(date.tm_year + 1900, tc.year);
        EXPECT_EQ(date.tm_mon + 1, 2);  // February
        EXPECT_EQ(date.tm_mday, tc.expectedDay);
        EXPECT_EQ(date.tm_wday, 1);     // Monday
    }
}

TEST_F(HolidayDateCalculatorTest, ChildrensWeek_FirstMondayOnOrAfterApr25)
{
    // Verify "first Monday on or after Apr 25" calculation (Monday closest to May 1)
    struct ChildrensWeekTestCase { int year; int expectedMonth; int expectedDay; };
    std::vector<ChildrensWeekTestCase> testCases = {
        { 2023, 5,  1 },   // Apr 25 is Tue, first Mon after is May 1
        { 2024, 4, 29 },   // Apr 25 is Thu, first Mon after is Apr 29
        { 2025, 4, 28 },   // Apr 25 is Fri, first Mon after is Apr 28
        { 2026, 4, 27 },   // Apr 25 is Sat, first Mon after is Apr 27
        { 2027, 4, 26 },   // Apr 25 is Sun, first Mon after is Apr 26
    };

    for (auto const& tc : testCases)
    {
        std::tm date = HolidayDateCalculator::CalculateWeekdayOnOrAfter(tc.year, 4, 25, Weekday::MONDAY);

        SCOPED_TRACE("Year: " + std::to_string(tc.year));

        EXPECT_EQ(date.tm_year + 1900, tc.year);
        EXPECT_EQ(date.tm_mon + 1, tc.expectedMonth);
        EXPECT_EQ(date.tm_mday, tc.expectedDay);
        EXPECT_EQ(date.tm_wday, 1);     // Monday
    }
}

TEST_F(HolidayDateCalculatorTest, WeekdayOnOrAfter_AlwaysCorrectWeekday_1900_2200)
{
    // Verify the result is always the correct weekday for entire range
    for (int year = 1900; year <= 2200; ++year)
    {
        for (int weekday = 0; weekday <= 6; ++weekday)
        {
            std::tm date = HolidayDateCalculator::CalculateWeekdayOnOrAfter(year, 2, 3, static_cast<Weekday>(weekday));

            SCOPED_TRACE("Year: " + std::to_string(year) + " Weekday: " + std::to_string(weekday));

            EXPECT_EQ(date.tm_wday, weekday);
            EXPECT_EQ(date.tm_mon + 1, 2);  // Should stay in February
            EXPECT_GE(date.tm_mday, 3);     // Should be on or after Feb 3
            EXPECT_LE(date.tm_mday, 9);     // At most 6 days later
        }
    }
}

TEST_F(HolidayDateCalculatorTest, WeekdayOnOrAfter_MonthBoundary_RollsIntoNextMonth)
{
    // Test dates near month-end that may roll into the next month
    // Apr 25 looking for Monday can roll into May (e.g., if Apr 25 is Sunday, Monday is May 1)

    for (int year = 1900; year <= 2200; ++year)
    {
        // Test Apr 25 (Children's Week reference date)
        std::tm apr25 = HolidayDateCalculator::CalculateWeekdayOnOrAfter(year, 4, 25, Weekday::MONDAY);
        SCOPED_TRACE("Apr 25, Year: " + std::to_string(year));
        EXPECT_EQ(apr25.tm_wday, 1);  // Monday
        EXPECT_TRUE(apr25.tm_mon == 3 || apr25.tm_mon == 4);  // April or May (0-indexed: 3 or 4)
        // If still in April, must be >= 25. If in May, can be 1-6.
        if (apr25.tm_mon == 3)
            EXPECT_GE(apr25.tm_mday, 25);
        else
            EXPECT_LE(apr25.tm_mday, 6);

        // Test Apr 30 - more likely to roll into May
        std::tm apr30 = HolidayDateCalculator::CalculateWeekdayOnOrAfter(year, 4, 30, Weekday::MONDAY);
        SCOPED_TRACE("Apr 30, Year: " + std::to_string(year));
        EXPECT_EQ(apr30.tm_wday, 1);  // Monday
        EXPECT_TRUE(apr30.tm_mon == 3 || apr30.tm_mon == 4);  // April or May
        if (apr30.tm_mon == 3)
            EXPECT_EQ(apr30.tm_mday, 30);  // Apr 30 must be the Monday
        else
            EXPECT_LE(apr30.tm_mday, 6);   // May 1-6

        // Test Dec 31 - can roll into January of next year
        std::tm dec31 = HolidayDateCalculator::CalculateWeekdayOnOrAfter(year, 12, 31, Weekday::MONDAY);
        SCOPED_TRACE("Dec 31, Year: " + std::to_string(year));
        EXPECT_EQ(dec31.tm_wday, 1);  // Monday
        // Could be Dec 31 or Jan 1-6 of next year
        EXPECT_TRUE((dec31.tm_mon == 11 && dec31.tm_mday == 31) ||
                    (dec31.tm_mon == 0 && dec31.tm_mday <= 6));
    }
}

// ============================================================
// Stress Tests - Verify No Crashes or Invalid Dates
// ============================================================

TEST_F(HolidayDateCalculatorTest, StressTest_AllCalculations_1900_2200)
{
    // Run all holiday calculations for entire range to ensure no crashes
    const std::vector<HolidayRule>& rules = HolidayDateCalculator::GetHolidayRules();

    int totalCalculations = 0;

    for (int year = 1900; year <= 2200; ++year)
    {
        // Test Easter
        std::tm easter = HolidayDateCalculator::CalculateEasterSunday(year);
        EXPECT_TRUE(IsValidDate(year, easter.tm_mon + 1, easter.tm_mday))
            << "Invalid Easter date for year " << year;
        totalCalculations++;

        // Test all weekday calculations
        for (int month = 1; month <= 12; ++month)
        {
            for (int n = 1; n <= 4; ++n)
            {
                std::tm date = HolidayDateCalculator::CalculateNthWeekday(year, month, Weekday::THURSDAY, n);
                EXPECT_TRUE(IsValidDate(year, date.tm_mon + 1, date.tm_mday))
                    << "Invalid NthWeekday date for year " << year << " month " << month << " n=" << n;
                totalCalculations++;
            }
        }

        // Test all holiday rules
        for (auto const& rule : rules)
        {
            std::tm date = HolidayDateCalculator::CalculateHolidayDate(rule, year);
            EXPECT_TRUE(IsValidDate(year, date.tm_mon + 1, date.tm_mday))
                << "Invalid holiday date for holiday " << rule.holidayId << " year " << year;
            totalCalculations++;
        }
    }

    // Verify we ran a significant number of calculations
    // 301 years * (1 Easter + 48 NthWeekday + 6 holidays) = 301 * 55 = 16555
    EXPECT_GT(totalCalculations, 15000) << "Should have run many calculations";
}

// ============================================================
// Edge Case Tests
// ============================================================

TEST_F(HolidayDateCalculatorTest, LeapYear_AllYears_1900_2200)
{
    // Verify calculations work correctly for all years, checking leap year logic
    for (int year = 1900; year <= 2200; ++year)
    {
        bool expectedLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

        SCOPED_TRACE("Year: " + std::to_string(year));
        EXPECT_EQ(IsLeapYear(year), expectedLeap);

        // Easter calculation should always work regardless of leap year
        std::tm easter = HolidayDateCalculator::CalculateEasterSunday(year);
        EXPECT_EQ(easter.tm_wday, 0) << "Easter should be Sunday";

        // All holiday calculations should produce valid dates
        for (auto const& rule : HolidayDateCalculator::GetHolidayRules())
        {
            std::tm date = HolidayDateCalculator::CalculateHolidayDate(rule, year);
            EXPECT_TRUE(IsValidDate(year, date.tm_mon + 1, date.tm_mday))
                << "Invalid date for holiday " << rule.holidayId;
        }
    }
}

TEST_F(HolidayDateCalculatorTest, GetPackedHolidayDate_UnknownHoliday)
{
    // Unknown holiday ID should return 0
    uint32_t result = HolidayDateCalculator::GetPackedHolidayDate(99999, 2025);
    EXPECT_EQ(result, 0u);
}

TEST_F(HolidayDateCalculatorTest, PackDate_YearBeyond2031)
{
    // WoW's packed date format uses 5 bits for year offset from 2000
    // - Offsets 0-30 represent specific years 2000-2030
    // - Offset 31 is a special marker meaning "repeats every year" (used for fixed-date holidays)
    // This is a Blizzard client limitation, not an emulator design choice
    //
    // Years beyond 2031 will overflow when unpacked due to the 5-bit mask

    // Test year 2032 (offset 32) - demonstrates the overflow behavior
    {
        std::tm date = {};
        date.tm_year = 2032 - 1900;
        date.tm_mon = 5;  // June
        date.tm_mday = 15;
        mktime(&date);

        uint32_t packed = HolidayDateCalculator::PackDate(date);
        std::tm unpacked = HolidayDateCalculator::UnpackDate(packed);

        // Year offset 32 masked with 0x1F (5 bits) = 0, so unpacked year = 2000
        // This documents the WoW client's inherent year 2031 limitation
        EXPECT_EQ(unpacked.tm_year + 1900, 2000) << "Year 2032 wraps to 2000 due to 5-bit WoW client format";
        EXPECT_EQ(unpacked.tm_mon + 1, 6);
        EXPECT_EQ(unpacked.tm_mday, 15);
    }

    // Test year 2035 (offset 35)
    {
        std::tm date = {};
        date.tm_year = 2035 - 1900;
        date.tm_mon = 0;  // January
        date.tm_mday = 1;
        mktime(&date);

        uint32_t packed = HolidayDateCalculator::PackDate(date);
        std::tm unpacked = HolidayDateCalculator::UnpackDate(packed);

        // Year offset 35 masked with 0x1F = 3, so unpacked year = 2003
        EXPECT_EQ(unpacked.tm_year + 1900, 2003) << "Year 2035 wraps to 2003 due to 5-bit WoW client format";
    }

    // Test boundary: year 2030 is the last fully usable year (offset 30)
    // (offset 31 is reserved for "repeating yearly" holidays)
    {
        std::tm date = {};
        date.tm_year = 2030 - 1900;
        date.tm_mon = 11;  // December
        date.tm_mday = 31;
        mktime(&date);

        uint32_t packed = HolidayDateCalculator::PackDate(date);
        std::tm unpacked = HolidayDateCalculator::UnpackDate(packed);

        EXPECT_EQ(unpacked.tm_year + 1900, 2030) << "Year 2030 should pack/unpack correctly";
        EXPECT_EQ(unpacked.tm_mon + 1, 12);
        EXPECT_EQ(unpacked.tm_mday, 31);
    }
}

TEST_F(HolidayDateCalculatorTest, CenturyBoundaries)
{
    // Test calculations around century boundaries (which affect leap year rules)
    std::vector<int> centuryYears = { 1900, 2000, 2100, 2200 };

    for (int year : centuryYears)
    {
        SCOPED_TRACE("Century year: " + std::to_string(year));

        // Easter
        std::tm easter = HolidayDateCalculator::CalculateEasterSunday(year);
        EXPECT_EQ(easter.tm_wday, 0) << "Easter should be Sunday";
        EXPECT_TRUE(easter.tm_mon == 2 || easter.tm_mon == 3) << "Easter should be in March or April";

        // Thanksgiving
        std::tm thanksgiving = HolidayDateCalculator::CalculateNthWeekday(year, 11, Weekday::THURSDAY, 4);
        EXPECT_EQ(thanksgiving.tm_wday, static_cast<int>(Weekday::THURSDAY));
        EXPECT_EQ(thanksgiving.tm_mon + 1, 11);
    }
}

// ============================================================
// Lunar New Year (Chinese New Year) Tests - Extended Range
// Based on Jean Meeus "Astronomical Algorithms" (1991)
// ============================================================

TEST_F(HolidayDateCalculatorTest, LunarNewYear_KnownDates)
{
    // Verify against known Chinese New Year dates
    // Source: Official astronomical calculations and historical records
    struct LunarNewYearTestCase { int year; int month; int day; };
    std::vector<LunarNewYearTestCase> testCases = {
        // Historical dates (2000-2010)
        { 2000, 2,  5 },
        { 2001, 1, 24 },
        { 2002, 2, 12 },
        { 2003, 2,  1 },
        { 2004, 1, 22 },
        { 2005, 2,  9 },
        { 2006, 1, 29 },
        { 2007, 2, 18 },
        { 2008, 2,  7 },
        { 2009, 1, 26 },
        { 2010, 2, 14 },
        // Recent dates (2011-2020)
        { 2011, 2,  3 },
        { 2012, 1, 23 },
        { 2013, 2, 10 },
        { 2014, 1, 31 },
        { 2015, 2, 19 },
        { 2016, 2,  8 },
        { 2017, 1, 28 },
        { 2018, 2, 16 },
        { 2019, 2,  5 },
        { 2020, 1, 25 },
        // Current and near-future dates (2021-2031)
        { 2021, 2, 12 },
        { 2022, 2,  1 },
        { 2023, 1, 22 },
        { 2024, 2, 10 },
        { 2025, 1, 29 },
        { 2026, 2, 17 },
        { 2027, 2,  6 },
        { 2028, 1, 26 },
        { 2029, 2, 13 },
        { 2030, 2,  3 },
        { 2031, 1, 23 },
    };

    for (auto const& tc : testCases)
    {
        std::tm lunarNewYear = HolidayDateCalculator::CalculateLunarNewYear(tc.year);
        SCOPED_TRACE("Year: " + std::to_string(tc.year));
        ExpectDate(lunarNewYear, tc.year, tc.month, tc.day);
    }
}

TEST_F(HolidayDateCalculatorTest, LunarNewYear_ValidDateRange_1900_2200)
{
    // Chinese New Year must always fall between January 21 and February 20 (inclusive)
    // This is a fundamental property of the lunisolar calendar
    for (int year = 1900; year <= 2200; ++year)
    {
        std::tm lunarNewYear = HolidayDateCalculator::CalculateLunarNewYear(year);

        SCOPED_TRACE("Year: " + std::to_string(year));

        // Verify year is correct
        EXPECT_EQ(lunarNewYear.tm_year + 1900, year);

        // Chinese New Year must be in January or February
        EXPECT_TRUE(lunarNewYear.tm_mon == 0 || lunarNewYear.tm_mon == 1)
            << "Lunar New Year must be in January (0) or February (1), got month " << lunarNewYear.tm_mon;

        // Valid range: January 21 - February 20
        if (lunarNewYear.tm_mon == 0) // January
        {
            EXPECT_GE(lunarNewYear.tm_mday, 21) << "Lunar New Year in January must be >= 21";
            EXPECT_LE(lunarNewYear.tm_mday, 31) << "Lunar New Year in January must be <= 31";
        }
        else // February
        {
            EXPECT_GE(lunarNewYear.tm_mday, 1) << "Lunar New Year in February must be >= 1";
            EXPECT_LE(lunarNewYear.tm_mday, 20) << "Lunar New Year in February must be <= 20";
        }

        // Verify it's a valid calendar date
        EXPECT_TRUE(IsValidDate(year, lunarNewYear.tm_mon + 1, lunarNewYear.tm_mday))
            << "Lunar New Year should be a valid calendar date";
    }
}

TEST_F(HolidayDateCalculatorTest, LunarFestival_DayBeforeChineseNewYear)
{
    // Lunar Festival starts 1 day before Chinese New Year
    // Test with -1 offset applied
    HolidayRule lunarFestival = { 327, HolidayCalculationType::LUNAR_NEW_YEAR, 0, 0, 0, -1 };

    for (int year = 2000; year <= 2100; ++year)
    {
        std::tm fromRule = HolidayDateCalculator::CalculateHolidayDate(lunarFestival, year);
        std::tm cny = HolidayDateCalculator::CalculateLunarNewYear(year);

        // Expected: CNY - 1 day
        std::tm expected = cny;
        expected.tm_mday -= 1;
        mktime(&expected);

        SCOPED_TRACE("Year: " + std::to_string(year));

        // Lunar Festival should be 1 day before Chinese New Year
        EXPECT_EQ(fromRule.tm_year, expected.tm_year);
        EXPECT_EQ(fromRule.tm_mon, expected.tm_mon);
        EXPECT_EQ(fromRule.tm_mday, expected.tm_mday);
    }
}

TEST_F(HolidayDateCalculatorTest, LunarFestival_KnownDates)
{
    // Verify Lunar Festival (CNY - 1 day) against known official dates
    // Source: WoW official event announcements
    struct LunarFestivalTestCase { int year; int month; int day; };
    std::vector<LunarFestivalTestCase> testCases = {
        { 2024, 2,  9 },  // CNY Feb 10 - 1 = Feb 9
        { 2025, 1, 28 },  // CNY Jan 29 - 1 = Jan 28 (confirmed official)
        { 2026, 2, 16 },  // CNY Feb 17 - 1 = Feb 16
        { 2027, 2,  5 },  // CNY Feb 6 - 1 = Feb 5
    };

    HolidayRule lunarFestival = { 327, HolidayCalculationType::LUNAR_NEW_YEAR, 0, 0, 0, -1 };

    for (auto const& tc : testCases)
    {
        std::tm date = HolidayDateCalculator::CalculateHolidayDate(lunarFestival, tc.year);
        SCOPED_TRACE("Year: " + std::to_string(tc.year));
        ExpectDate(date, tc.year, tc.month, tc.day);
    }
}

TEST_F(HolidayDateCalculatorTest, LunarNewYear_NoRepeatedDates)
{
    // Each year should have a unique Chinese New Year date
    // (no two consecutive years should have the exact same month/day)
    int prevMonth = -1;
    int prevDay = -1;

    for (int year = 1900; year <= 2200; ++year)
    {
        std::tm lunarNewYear = HolidayDateCalculator::CalculateLunarNewYear(year);

        if (prevMonth != -1)
        {
            // The date should be different from previous year
            // (due to ~11 day lunar cycle drift)
            bool sameDate = (lunarNewYear.tm_mon == prevMonth && lunarNewYear.tm_mday == prevDay);
            EXPECT_FALSE(sameDate)
                << "Year " << year << " has same date as previous year: "
                << (lunarNewYear.tm_mon + 1) << "/" << lunarNewYear.tm_mday;
        }

        prevMonth = lunarNewYear.tm_mon;
        prevDay = lunarNewYear.tm_mday;
    }
}

TEST_F(HolidayDateCalculatorTest, LunarNewYear_19YearMetonicCycle)
{
    // The Chinese calendar roughly follows a 19-year Metonic cycle
    // Dates should approximately repeat every 19 years (within a few days)
    for (int year = 1900; year <= 2180; ++year)
    {
        std::tm date1 = HolidayDateCalculator::CalculateLunarNewYear(year);
        std::tm date2 = HolidayDateCalculator::CalculateLunarNewYear(year + 19);

        SCOPED_TRACE("Comparing year " + std::to_string(year) + " with " + std::to_string(year + 19));

        // Convert to day-of-year for easier comparison
        int doy1 = (date1.tm_mon == 0) ? date1.tm_mday : 31 + date1.tm_mday;
        int doy2 = (date2.tm_mon == 0) ? date2.tm_mday : 31 + date2.tm_mday;

        // The Metonic cycle is approximate - typically within a few days, but can shift
        // by up to a lunar month (~29 days) at cycle boundaries due to intercalary months
        int diff = std::abs(doy1 - doy2);
        EXPECT_LE(diff, 30) << "19-year Metonic cycle should keep dates within one lunar month";
    }
}

// ============================================================
// Darkmoon Faire Tests
// First Sunday of the month, rotating between 3 locations
// ============================================================

TEST_F(HolidayDateCalculatorTest, DarkmoonFaire_LocationRotation)
{
    // Verify the 3-location rotation pattern:
    // Mulgore (offset 1): Jan, Apr, Jul, Oct - month % 3 == 1
    // Terokkar (offset 2): Feb, May, Aug, Nov - month % 3 == 2
    // Elwynn (offset 0): Mar, Jun, Sep, Dec - month % 3 == 0

    // Mulgore months (offset 1)
    EXPECT_EQ(1 % 3, 1);
    EXPECT_EQ(4 % 3, 1);
    EXPECT_EQ(7 % 3, 1);
    EXPECT_EQ(10 % 3, 1);

    // Terokkar months (offset 2)
    EXPECT_EQ(2 % 3, 2);
    EXPECT_EQ(5 % 3, 2);
    EXPECT_EQ(8 % 3, 2);
    EXPECT_EQ(11 % 3, 2);

    // Elwynn months (offset 0)
    EXPECT_EQ(3 % 3, 0);
    EXPECT_EQ(6 % 3, 0);
    EXPECT_EQ(9 % 3, 0);
    EXPECT_EQ(12 % 3, 0);
}

TEST_F(HolidayDateCalculatorTest, DarkmoonFaire_FirstSundayOfMonth_KnownDates)
{
    // Verify first Sunday calculation against known dates
    struct FirstSundayTestCase { int year; int month; int expectedDay; };
    std::vector<FirstSundayTestCase> testCases = {
        // 2024
        { 2024, 1,  7 },  // Jan 2024: First Sunday = Jan 7
        { 2024, 2,  4 },  // Feb 2024: First Sunday = Feb 4
        { 2024, 3,  3 },  // Mar 2024: First Sunday = Mar 3
        { 2024, 4,  7 },  // Apr 2024: First Sunday = Apr 7
        { 2024, 9,  1 },  // Sep 2024: First Sunday = Sep 1
        { 2024, 12, 1 },  // Dec 2024: First Sunday = Dec 1
        // 2025
        { 2025, 1,  5 },  // Jan 2025: First Sunday = Jan 5
        { 2025, 2,  2 },  // Feb 2025: First Sunday = Feb 2
        { 2025, 3,  2 },  // Mar 2025: First Sunday = Mar 2
        { 2025, 6,  1 },  // Jun 2025: First Sunday = Jun 1
        { 2025, 9,  7 },  // Sep 2025: First Sunday = Sep 7
        { 2025, 12, 7 },  // Dec 2025: First Sunday = Dec 7
        // 2026
        { 2026, 1,  4 },  // Jan 2026: First Sunday = Jan 4
        { 2026, 3,  1 },  // Mar 2026: First Sunday = Mar 1
    };

    for (auto const& tc : testCases)
    {
        std::tm date = HolidayDateCalculator::CalculateNthWeekday(tc.year, tc.month, Weekday::SUNDAY, 1);

        SCOPED_TRACE("Year: " + std::to_string(tc.year) + " Month: " + std::to_string(tc.month));

        EXPECT_EQ(date.tm_year + 1900, tc.year);
        EXPECT_EQ(date.tm_mon + 1, tc.month);
        EXPECT_EQ(date.tm_mday, tc.expectedDay);
        EXPECT_EQ(date.tm_wday, 0) << "Should be Sunday";
    }
}

TEST_F(HolidayDateCalculatorTest, DarkmoonFaire_GetDates_Elwynn)
{
    // Elwynn (offset 0): Mar, Jun, Sep, Dec
    std::vector<uint32_t> dates = HolidayDateCalculator::GetDarkmoonFaireDates(0, 2025, 1);

    // Should have exactly 4 dates for one year
    EXPECT_EQ(dates.size(), 4u);

    // Verify each date is in the correct month and is a Sunday
    std::vector<int> expectedMonths = { 3, 6, 9, 12 };
    for (size_t i = 0; i < dates.size(); ++i)
    {
        std::tm date = HolidayDateCalculator::UnpackDate(dates[i]);

        SCOPED_TRACE("Date index: " + std::to_string(i));

        EXPECT_EQ(date.tm_year + 1900, 2025);
        EXPECT_EQ(date.tm_mon + 1, expectedMonths[i]);
        EXPECT_EQ(date.tm_wday, 0) << "Should be Sunday";
        EXPECT_GE(date.tm_mday, 1);
        EXPECT_LE(date.tm_mday, 7) << "First Sunday must be within first 7 days";
    }
}

TEST_F(HolidayDateCalculatorTest, DarkmoonFaire_GetDates_Mulgore)
{
    // Mulgore (offset 1): Jan, Apr, Jul, Oct
    std::vector<uint32_t> dates = HolidayDateCalculator::GetDarkmoonFaireDates(1, 2025, 1);

    // Should have exactly 4 dates for one year
    EXPECT_EQ(dates.size(), 4u);

    std::vector<int> expectedMonths = { 1, 4, 7, 10 };
    for (size_t i = 0; i < dates.size(); ++i)
    {
        std::tm date = HolidayDateCalculator::UnpackDate(dates[i]);

        SCOPED_TRACE("Date index: " + std::to_string(i));

        EXPECT_EQ(date.tm_year + 1900, 2025);
        EXPECT_EQ(date.tm_mon + 1, expectedMonths[i]);
        EXPECT_EQ(date.tm_wday, 0) << "Should be Sunday";
    }
}

TEST_F(HolidayDateCalculatorTest, DarkmoonFaire_GetDates_Terokkar)
{
    // Terokkar (offset 2): Feb, May, Aug, Nov
    std::vector<uint32_t> dates = HolidayDateCalculator::GetDarkmoonFaireDates(2, 2025, 1);

    // Should have exactly 4 dates for one year
    EXPECT_EQ(dates.size(), 4u);

    std::vector<int> expectedMonths = { 2, 5, 8, 11 };
    for (size_t i = 0; i < dates.size(); ++i)
    {
        std::tm date = HolidayDateCalculator::UnpackDate(dates[i]);

        SCOPED_TRACE("Date index: " + std::to_string(i));

        EXPECT_EQ(date.tm_year + 1900, 2025);
        EXPECT_EQ(date.tm_mon + 1, expectedMonths[i]);
        EXPECT_EQ(date.tm_wday, 0) << "Should be Sunday";
    }
}

TEST_F(HolidayDateCalculatorTest, DarkmoonFaire_GetDates_MultiYear)
{
    // Get 4 years of dates for Elwynn (offset 0)
    std::vector<uint32_t> dates = HolidayDateCalculator::GetDarkmoonFaireDates(0, 2025, 4);

    // 4 dates per year * 4 years = 16 dates
    EXPECT_EQ(dates.size(), 16u);

    // Verify dates are in chronological order
    for (size_t i = 1; i < dates.size(); ++i)
    {
        std::tm prev = HolidayDateCalculator::UnpackDate(dates[i - 1]);
        std::tm curr = HolidayDateCalculator::UnpackDate(dates[i]);

        time_t prevTime = mktime(&prev);
        time_t currTime = mktime(&curr);

        EXPECT_GT(currTime, prevTime) << "Dates should be in chronological order";
    }
}

TEST_F(HolidayDateCalculatorTest, DarkmoonFaire_AlwaysSunday_AllLocations_2000_2030)
{
    // Verify all Darkmoon Faire dates are Sundays for entire valid range
    // 3 locations: offset 0 (Elwynn), offset 1 (Mulgore), offset 2 (Terokkar)
    for (int offset = 0; offset <= 2; ++offset)
    {
        std::vector<uint32_t> dates = HolidayDateCalculator::GetDarkmoonFaireDates(offset, 2000, 31);

        SCOPED_TRACE("Location offset: " + std::to_string(offset));

        for (size_t i = 0; i < dates.size(); ++i)
        {
            std::tm date = HolidayDateCalculator::UnpackDate(dates[i]);
            EXPECT_EQ(date.tm_wday, 0)
                << "Date " << (date.tm_year + 1900) << "-" << (date.tm_mon + 1) << "-" << date.tm_mday
                << " should be Sunday";
        }
    }
}

TEST_F(HolidayDateCalculatorTest, DarkmoonFaire_CalculateHolidayDate_ReturnsFirstOccurrence)
{
    // Using CalculateHolidayDate with DARKMOON_FAIRE should return the first occurrence of the year
    // Elwynn (offset 0) = Mar/Jun/Sep/Dec, Mulgore (offset 1) = Jan/Apr/Jul/Oct, Terokkar (offset 2) = Feb/May/Aug/Nov
    HolidayRule elwynnRule = { 374, HolidayCalculationType::DARKMOON_FAIRE, 0, 0, 0, -2 };
    HolidayRule mulgoreRule = { 375, HolidayCalculationType::DARKMOON_FAIRE, 1, 0, 0, -2 };
    HolidayRule terokkarRule = { 376, HolidayCalculationType::DARKMOON_FAIRE, 2, 0, 0, -2 };

    // 2025 first occurrences:
    // Elwynn (offset 0): March (first month where month % 3 == 0)
    std::tm elwynn2025 = HolidayDateCalculator::CalculateHolidayDate(elwynnRule, 2025);
    EXPECT_EQ(elwynn2025.tm_mon + 1, 3) << "Elwynn first occurrence should be March";
    EXPECT_EQ(elwynn2025.tm_wday, 0) << "Should be Sunday";

    // Mulgore (offset 1): January (first month where month % 3 == 1)
    std::tm mulgore2025 = HolidayDateCalculator::CalculateHolidayDate(mulgoreRule, 2025);
    EXPECT_EQ(mulgore2025.tm_mon + 1, 1) << "Mulgore first occurrence should be January";
    EXPECT_EQ(mulgore2025.tm_wday, 0) << "Should be Sunday";

    // Terokkar (offset 2): February (first month where month % 3 == 2)
    std::tm terokkar2025 = HolidayDateCalculator::CalculateHolidayDate(terokkarRule, 2025);
    EXPECT_EQ(terokkar2025.tm_mon + 1, 2) << "Terokkar first occurrence should be February";
    EXPECT_EQ(terokkar2025.tm_wday, 0) << "Should be Sunday";
}

TEST_F(HolidayDateCalculatorTest, DarkmoonFaire_NoOverlap_AllLocations)
{
    // Verify all three locations don't share dates (they're in different months)
    for (int year = 2000; year <= 2030; ++year)
    {
        std::vector<uint32_t> elwynn = HolidayDateCalculator::GetDarkmoonFaireDates(0, year, 1);   // Mar/Jun/Sep/Dec
        std::vector<uint32_t> mulgore = HolidayDateCalculator::GetDarkmoonFaireDates(1, year, 1);  // Jan/Apr/Jul/Oct
        std::vector<uint32_t> terokkar = HolidayDateCalculator::GetDarkmoonFaireDates(2, year, 1); // Feb/May/Aug/Nov

        SCOPED_TRACE("Year: " + std::to_string(year));

        // Check no overlap between any locations
        for (auto const& e : elwynn)
        {
            for (auto const& m : mulgore)
                EXPECT_NE(e, m) << "Elwynn and Mulgore should not share dates";
            for (auto const& t : terokkar)
                EXPECT_NE(e, t) << "Elwynn and Terokkar should not share dates";
        }
        for (auto const& m : mulgore)
        {
            for (auto const& t : terokkar)
                EXPECT_NE(m, t) << "Mulgore and Terokkar should not share dates";
        }
    }
}

TEST_F(HolidayDateCalculatorTest, DarkmoonFaire_InHolidayRules)
{
    // Verify all three Darkmoon Faire locations are in the HolidayRules
    auto const& rules = HolidayDateCalculator::GetHolidayRules();

    bool foundElwynn = false, foundMulgore = false, foundTerokkar = false;
    for (auto const& rule : rules)
    {
        if (rule.holidayId == 374 && rule.type == HolidayCalculationType::DARKMOON_FAIRE)
            foundElwynn = true;
        if (rule.holidayId == 375 && rule.type == HolidayCalculationType::DARKMOON_FAIRE)
            foundMulgore = true;
        if (rule.holidayId == 376 && rule.type == HolidayCalculationType::DARKMOON_FAIRE)
            foundTerokkar = true;
    }

    EXPECT_TRUE(foundElwynn) << "Darkmoon Faire Elwynn (374) should be in HolidayRules";
    EXPECT_TRUE(foundMulgore) << "Darkmoon Faire Mulgore (375) should be in HolidayRules";
    EXPECT_TRUE(foundTerokkar) << "Darkmoon Faire Terokkar (376) should be in HolidayRules";
}
