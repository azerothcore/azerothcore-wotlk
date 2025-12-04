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
#include "SharedDefines.h"

// Static holiday rules configuration
static const std::vector<HolidayRule> s_HolidayRules = {
    // Lunar Festival: Fixed Jan 22 (simplification; Blizzard varied slightly)
    { HOLIDAY_LUNAR_FESTIVAL, HolidayCalculationType::FIXED_DATE, 1, 22, 0, 0 },

    // Love is in the Air: Fixed Feb 6
    { HOLIDAY_LOVE_IS_IN_THE_AIR, HolidayCalculationType::FIXED_DATE, 2, 6, 0, 0 },

    // Noblegarden: Week after Easter (Easter + 7 days)
    { HOLIDAY_NOBLEGARDEN, HolidayCalculationType::EASTER_OFFSET, 0, 0, 0, 7 },

    // Children's Week: Fixed Apr 30
    { HOLIDAY_CHILDRENS_WEEK, HolidayCalculationType::FIXED_DATE, 4, 30, 0, 0 },

    // Harvest Festival: Fixed Sep 28
    { HOLIDAY_HARVEST_FESTIVAL, HolidayCalculationType::FIXED_DATE, 9, 28, 0, 0 },

    // Pilgrim's Bounty: 4th Thursday of November (Thanksgiving)
    { HOLIDAY_PILGRIMS_BOUNTY, HolidayCalculationType::NTH_WEEKDAY, 11, 4, WEEKDAY_THURSDAY, 0 }
};

const std::vector<HolidayRule>& HolidayDateCalculator::GetHolidayRules()
{
    return s_HolidayRules;
}

std::tm HolidayDateCalculator::CalculateEasterSunday(int year)
{
    // Anonymous Gregorian algorithm (Computus)
    // This algorithm calculates the date of Easter Sunday for any year
    int a = year % 19;
    int b = year / 100;
    int c = year % 100;
    int d = b / 4;
    int e = b % 4;
    int f = (b + 8) / 25;
    int g = (b - f + 1) / 3;
    int h = (19 * a + b - d - g + 15) % 30;
    int i = c / 4;
    int k = c % 4;
    int l = (32 + 2 * e + 2 * i - h - k) % 7;
    int m = (a + 11 * h + 22 * l) / 451;
    int month = (h + l - 7 * m + 114) / 31;
    int day = ((h + l - 7 * m + 114) % 31) + 1;

    std::tm result = {};
    result.tm_year = year - 1900;
    result.tm_mon = month - 1;
    result.tm_mday = day;
    mktime(&result); // Normalize and fill in other fields

    return result;
}

std::tm HolidayDateCalculator::CalculateNthWeekday(int year, int month, Weekday weekday, int n)
{
    // Start with first day of the month
    std::tm date = {};
    date.tm_year = year - 1900;
    date.tm_mon = month - 1;
    date.tm_mday = 1;
    mktime(&date);

    // Find first occurrence of the target weekday
    int daysUntilWeekday = (weekday - date.tm_wday + 7) % 7;
    date.tm_mday = 1 + daysUntilWeekday;

    // Move to nth occurrence
    date.tm_mday += (n - 1) * 7;

    mktime(&date); // Normalize (handles month overflow)
    return date;
}

std::tm HolidayDateCalculator::CalculateHolidayDate(const HolidayRule& rule, int year)
{
    std::tm result = {};

    switch (rule.type)
    {
        case HolidayCalculationType::FIXED_DATE:
        {
            result.tm_year = year - 1900;
            result.tm_mon = rule.month - 1;
            result.tm_mday = rule.day;
            mktime(&result);
            break;
        }
        case HolidayCalculationType::NTH_WEEKDAY:
        {
            result = CalculateNthWeekday(year, rule.month, static_cast<Weekday>(rule.weekday), rule.day);
            break;
        }
        case HolidayCalculationType::EASTER_OFFSET:
        {
            result = CalculateEasterSunday(year);
            result.tm_mday += rule.offset;
            mktime(&result); // Normalize
            break;
        }
    }

    return result;
}

uint32_t HolidayDateCalculator::PackDate(const std::tm& date)
{
    // WoW packed date format:
    // bits 14-19: day (0-indexed)
    // bits 20-23: month (0-indexed)
    // bits 24-28: year offset from 2000
    uint32_t yearOffset = static_cast<uint32_t>((date.tm_year + 1900) - 2000);
    uint32_t month = static_cast<uint32_t>(date.tm_mon);         // Already 0-indexed
    uint32_t day = static_cast<uint32_t>(date.tm_mday - 1);      // Convert to 0-indexed

    return (yearOffset << 24) | (month << 20) | (day << 14);
}

std::tm HolidayDateCalculator::UnpackDate(uint32_t packed)
{
    std::tm result = {};
    result.tm_year = static_cast<int>(((packed >> 24) & 0x1F) + 2000 - 1900);
    result.tm_mon = static_cast<int>((packed >> 20) & 0xF);
    result.tm_mday = static_cast<int>(((packed >> 14) & 0x3F) + 1);
    mktime(&result);
    return result;
}

uint32_t HolidayDateCalculator::GetPackedHolidayDate(uint32_t holidayId, int year)
{
    for (const auto& rule : s_HolidayRules)
    {
        if (rule.holidayId == holidayId)
        {
            std::tm date = CalculateHolidayDate(rule, year);
            return PackDate(date);
        }
    }
    return 0; // Holiday not found
}
