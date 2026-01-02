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

#ifndef ACORE_HOLIDAY_DATE_CALCULATOR_H
#define ACORE_HOLIDAY_DATE_CALCULATOR_H

#include <cstdint>
#include <ctime>
#include <vector>

enum class HolidayCalculationType
{
    FIXED_DATE,        // Same month/day every year (e.g., Dec 25)
    NTH_WEEKDAY,       // Nth weekday of month (e.g., 4th Thursday of Nov)
    EASTER_OFFSET,     // Days relative to Easter Sunday
    LUNAR_NEW_YEAR,    // Chinese New Year (new moon between Jan 21 - Feb 20)
    WEEKDAY_ON_OR_AFTER, // First weekday on or after a date (e.g., first Monday on or after Feb 3)
    AUTUMN_EQUINOX,    // Days relative to autumn equinox (offset in days)
    WINTER_SOLSTICE,   // Days relative to winter solstice (offset in days)
    DARKMOON_FAIRE     // First Sunday of months matching (month % 3 == locationOffset)
};

enum class Weekday
{
    SUNDAY = 0,
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY
};

struct HolidayRule
{
    uint32_t holidayId;
    HolidayCalculationType type;
    int month;      // 1-12
    int day;        // For FIXED_DATE: day of month. For NTH_WEEKDAY: which occurrence (1-5)
    int weekday;    // For NTH_WEEKDAY: 0=Sunday through 6=Saturday
    int offset;     // For EASTER_OFFSET: days after Easter (can be negative)
};

class HolidayDateCalculator
{
public:
    // Calculate Easter Sunday for a given year (Computus algorithm)
    static std::tm CalculateEasterSunday(int year);

    // Calculate Nth weekday of a month (e.g., 4th Thursday of November)
    static std::tm CalculateNthWeekday(int year, int month, Weekday weekday, int n);

    // Calculate first weekday on or after a specific date (e.g., first Monday on or after Feb 3)
    static std::tm CalculateWeekdayOnOrAfter(int year, int month, int day, Weekday weekday);

    // Calculate Chinese New Year (Lunar New Year) using astronomical algorithm
    // Based on Jean Meeus "Astronomical Algorithms" - finds new moon between Jan 21 - Feb 20
    static std::tm CalculateLunarNewYear(int year);

    // Calculate Autumn Equinox using astronomical algorithm
    // Based on Jean Meeus "Astronomical Algorithms" Chapter 27
    static std::tm CalculateAutumnEquinox(int year);

    // Calculate Winter Solstice using astronomical algorithm
    // Based on Jean Meeus "Astronomical Algorithms" Chapter 27
    static std::tm CalculateWinterSolstice(int year);

    // Calculate holiday start date for a given year
    static std::tm CalculateHolidayDate(const HolidayRule& rule, int year);

    // Convert std::tm to WoW's packed date format
    static uint32_t PackDate(const std::tm& date);

    // Convert WoW's packed date format to std::tm
    static std::tm UnpackDate(uint32_t packed);

    // Get all holiday rules
    static const std::vector<HolidayRule>& GetHolidayRules();

    // Calculate date for a specific holiday ID and year
    static uint32_t GetPackedHolidayDate(uint32_t holidayId, int year);

    // Calculate Darkmoon Faire dates for a location over a year range
    // locationOffset: 0=Elwynn (months 3,6,9,12), 1=Mulgore (months 1,4,7,10), 2=Terokkar (months 2,5,8,11)
    // dayOffset: days to offset from first Sunday (e.g., -2 for Friday start)
    // Returns packed dates for all occurrences in the year range
    static std::vector<uint32_t> GetDarkmoonFaireDates(int locationOffset, int startYear, int numYears, int dayOffset = 0);

private:
    // Julian Date conversions for lunar calculations
    static double DateToJulianDay(int year, int month, double day);
    static void JulianDayToDate(double jd, int& year, int& month, int& day);

    // Calculate new moon Julian Date for lunation k (Meeus algorithm)
    static double CalculateNewMoon(double k);
};

#endif // ACORE_HOLIDAY_DATE_CALCULATOR_H
