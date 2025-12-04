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
        std::tm date = HolidayDateCalculator::CalculateNthWeekday(year, 11, WEEKDAY_THURSDAY, 4);

        SCOPED_TRACE("Year: " + std::to_string(year));

        // Must be in November
        EXPECT_EQ(date.tm_mon + 1, 11);

        // Must be a Thursday
        EXPECT_EQ(date.tm_wday, WEEKDAY_THURSDAY);

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
            std::tm first = HolidayDateCalculator::CalculateNthWeekday(year, month, WEEKDAY_MONDAY, 1);
            std::tm second = HolidayDateCalculator::CalculateNthWeekday(year, month, WEEKDAY_MONDAY, 2);
            std::tm third = HolidayDateCalculator::CalculateNthWeekday(year, month, WEEKDAY_MONDAY, 3);
            std::tm fourth = HolidayDateCalculator::CalculateNthWeekday(year, month, WEEKDAY_MONDAY, 4);

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

TEST_F(HolidayDateCalculatorTest, Noblegarden_WeekAfterEaster_1900_2200)
{
    // Noblegarden should be Easter + 7 days for all years
    for (int year = 1900; year <= 2200; ++year)
    {
        std::tm easter = HolidayDateCalculator::CalculateEasterSunday(year);

        // Calculate expected Noblegarden date (Easter + 7)
        std::tm expectedNoblegarden = easter;
        expectedNoblegarden.tm_mday += 7;
        mktime(&expectedNoblegarden); // Normalize (handles month rollover)

        // Get calculated Noblegarden from holiday rule
        HolidayRule noblegarden = { 181, HolidayCalculationType::EASTER_OFFSET, 0, 0, 0, 7 };
        std::tm calculated = HolidayDateCalculator::CalculateHolidayDate(noblegarden, year);

        SCOPED_TRACE("Year: " + std::to_string(year));

        EXPECT_EQ(calculated.tm_year, expectedNoblegarden.tm_year);
        EXPECT_EQ(calculated.tm_mon, expectedNoblegarden.tm_mon);
        EXPECT_EQ(calculated.tm_mday, expectedNoblegarden.tm_mday);

        // Noblegarden should be a Sunday (7 days after Easter Sunday)
        EXPECT_EQ(calculated.tm_wday, 0) << "Noblegarden should be Sunday";
    }
}

// ============================================================
// Pilgrim's Bounty (Thanksgiving) Tests - Extended Range
// ============================================================

TEST_F(HolidayDateCalculatorTest, PilgrimsBounty_FourthThursdayNovember_1900_2200)
{
    // Pilgrim's Bounty = Thanksgiving = 4th Thursday of November
    for (int year = 1900; year <= 2200; ++year)
    {
        HolidayRule pilgrimsBounty = { 404, HolidayCalculationType::NTH_WEEKDAY, 11, 4, WEEKDAY_THURSDAY, 0 };
        std::tm date = HolidayDateCalculator::CalculateHolidayDate(pilgrimsBounty, year);

        SCOPED_TRACE("Year: " + std::to_string(year));

        EXPECT_EQ(date.tm_year + 1900, year);
        EXPECT_EQ(date.tm_mon + 1, 11);            // November
        EXPECT_EQ(date.tm_wday, WEEKDAY_THURSDAY); // Thursday
        EXPECT_GE(date.tm_mday, 22);               // 4th week starts at earliest on 22nd
        EXPECT_LE(date.tm_mday, 28);               // 4th week ends at latest on 28th
    }
}

// ============================================================
// Fixed Date Holidays Tests - Extended Range
// ============================================================

TEST_F(HolidayDateCalculatorTest, FixedDateHolidays_ConsistentAcrossYears_1900_2200)
{
    // Fixed date holidays should have same month/day every year
    struct FixedHolidayTestCase { uint32_t holidayId; int month; int day; const char* name; };
    std::vector<FixedHolidayTestCase> testCases = {
        { 327, 1, 22, "Lunar Festival" },
        { 423, 2,  6, "Love is in the Air" },
        { 201, 4, 30, "Children's Week" },
        { 321, 9, 28, "Harvest Festival" },
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
                std::tm date = HolidayDateCalculator::CalculateNthWeekday(year, month, WEEKDAY_THURSDAY, n);
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
        std::tm thanksgiving = HolidayDateCalculator::CalculateNthWeekday(year, 11, WEEKDAY_THURSDAY, 4);
        EXPECT_EQ(thanksgiving.tm_wday, WEEKDAY_THURSDAY);
        EXPECT_EQ(thanksgiving.tm_mon + 1, 11);
    }
}
