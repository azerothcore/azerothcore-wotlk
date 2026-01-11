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
#include <cmath>

// Constants for astronomical calculations
constexpr double PI = 3.14159265358979323846;
constexpr double DEG_TO_RAD = PI / 180.0;

// Helper: sin/cos in degrees
inline double sind(double deg) { return std::sin(deg * DEG_TO_RAD); }

// Static holiday rules configuration
static const std::vector<HolidayRule> HolidayRules = {
    // Lunar Festival: Chinese New Year - 1 day (event starts day before CNY)
    { HOLIDAY_LUNAR_FESTIVAL, HolidayCalculationType::LUNAR_NEW_YEAR, 0, 0, 0, -1 },

    // Love is in the Air: First Monday on or after Feb 3
    { HOLIDAY_LOVE_IS_IN_THE_AIR, HolidayCalculationType::WEEKDAY_ON_OR_AFTER, 2, 3, static_cast<int>(Weekday::MONDAY), 0 },

    // Noblegarden: Day after Easter Sunday (Easter + 1 day)
    { HOLIDAY_NOBLEGARDEN, HolidayCalculationType::EASTER_OFFSET, 0, 0, 0, 1 },

    // Children's Week: First Monday on or after Apr 25 (Monday closest to May 1)
    { HOLIDAY_CHILDRENS_WEEK, HolidayCalculationType::WEEKDAY_ON_OR_AFTER, 4, 25, static_cast<int>(Weekday::MONDAY), 0 },

    // Midsummer Fire Festival: Fixed Jun 21
    { HOLIDAY_FIRE_FESTIVAL, HolidayCalculationType::FIXED_DATE, 6, 21, 0, 0 },

    // Fireworks Spectacular: Fixed Jul 4
    { HOLIDAY_FIREWORKS_SPECTACULAR, HolidayCalculationType::FIXED_DATE, 7, 4, 0, 0 },

    // Pirates' Day: Fixed Sep 19
    { HOLIDAY_PIRATES_DAY, HolidayCalculationType::FIXED_DATE, 9, 19, 0, 0 },

    // Brewfest: Fixed Sept 20 main event, prep starts Sept 13
    { HOLIDAY_BREWFEST, HolidayCalculationType::FIXED_DATE, 9, 13, 0, 0 },

    // Harvest Festival: 2 days before autumn equinox (Sept 20-21)
    { HOLIDAY_HARVEST_FESTIVAL, HolidayCalculationType::AUTUMN_EQUINOX, 0, 0, 0, -2 },

    // Hallow's End: Fixed Oct 18
    { HOLIDAY_HALLOWS_END, HolidayCalculationType::FIXED_DATE, 10, 18, 0, 0 },

    // Day of the Dead: Fixed Nov 1
    { HOLIDAY_DAY_OF_DEAD, HolidayCalculationType::FIXED_DATE, 11, 1, 0, 0 },

    // Pilgrim's Bounty: Sunday before Thanksgiving (4th Thursday - 4 days)
    { HOLIDAY_PILGRIMS_BOUNTY, HolidayCalculationType::NTH_WEEKDAY, 11, 4, static_cast<int>(Weekday::THURSDAY), -4 },

    // Winter Veil: 6 days before winter solstice (Dec 15-16)
    { HOLIDAY_FEAST_OF_WINTER_VEIL, HolidayCalculationType::WINTER_SOLSTICE, 0, 0, 0, -6 },

    // Darkmoon Faire: First Sunday of months matching (month % 3 == locationOffset)
    // Rotates monthly: Mulgore (Jan) -> Terokkar (Feb) -> Elwynn (Mar) -> repeat
    // rule.month stores the location offset
    // rule.offset is -2 (building phase starts Friday, 2 days before faire opens on Sunday)
    { HOLIDAY_DARKMOON_FAIRE_ELWYNN, HolidayCalculationType::DARKMOON_FAIRE, 0, 0, 0, -2 },    // Mar, Jun, Sep, Dec
    { HOLIDAY_DARKMOON_FAIRE_THUNDER, HolidayCalculationType::DARKMOON_FAIRE, 1, 0, 0, -2 },   // Jan, Apr, Jul, Oct
    { HOLIDAY_DARKMOON_FAIRE_SHATTRATH, HolidayCalculationType::DARKMOON_FAIRE, 2, 0, 0, -2 }  // Feb, May, Aug, Nov
};

const std::vector<HolidayRule>& HolidayDateCalculator::GetHolidayRules()
{
    return HolidayRules;
}

std::tm HolidayDateCalculator::CalculateEasterSunday(int year)
{
    // Anonymous Gregorian algorithm (Computus)
    // Reference: https://en.wikipedia.org/wiki/Date_of_Easter#Anonymous_Gregorian_algorithm
    int const a = year % 19;
    int const b = year / 100;
    int const c = year % 100;
    int const d = b / 4;
    int const e = b % 4;
    int const f = (b + 8) / 25;
    int const g = (b - f + 1) / 3;
    int const h = (19 * a + b - d - g + 15) % 30;
    int const i = c / 4;
    int const k = c % 4;
    int const l = (32 + 2 * e + 2 * i - h - k) % 7;
    int const m = (a + 11 * h + 22 * l) / 451;
    int const month = (h + l - 7 * m + 114) / 31;
    int const day = ((h + l - 7 * m + 114) % 31) + 1;

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
    int const daysUntilWeekday = (static_cast<int>(weekday) - date.tm_wday + 7) % 7;
    date.tm_mday = 1 + daysUntilWeekday;

    // Move to nth occurrence
    date.tm_mday += (n - 1) * 7;

    mktime(&date); // Normalize (handles month overflow)
    return date;
}

std::tm HolidayDateCalculator::CalculateWeekdayOnOrAfter(int year, int month, int day, Weekday weekday)
{
    // Start with the specified date
    std::tm date = {};
    date.tm_year = year - 1900;
    date.tm_mon = month - 1;
    date.tm_mday = day;
    mktime(&date);

    // Find days until the target weekday (0 if already on that day)
    int const daysUntilWeekday = (static_cast<int>(weekday) - date.tm_wday + 7) % 7;
    date.tm_mday += daysUntilWeekday;

    mktime(&date); // Normalize
    return date;
}

// ============================================================================
// LUNAR NEW YEAR CALCULATION
// Based on Jean Meeus "Astronomical Algorithms" (1991), Chapter 49
// Reference: https://celestialprogramming.com/moonphases.html
// Chinese New Year = new moon falling between January 21 and February 20
// ============================================================================

double HolidayDateCalculator::DateToJulianDay(int year, int month, double day)
{
    if (month <= 2)
    {
        year -= 1;
        month += 12;
    }
    int const A = year / 100;
    int const B = 2 - A + (A / 4);
    return std::floor(365.25 * (year + 4716)) + std::floor(30.6001 * (month + 1)) + day + B - 1524.5;
}

void HolidayDateCalculator::JulianDayToDate(double jd, int& year, int& month, int& day)
{
    jd += 0.5;
    int const Z = static_cast<int>(jd);
    int A = Z;
    if (Z >= 2299161)
    {
        int const alpha = static_cast<int>((Z - 1867216.25) / 36524.25);
        A = Z + 1 + alpha - (alpha / 4);
    }
    int const B = A + 1524;
    int const C = static_cast<int>((B - 122.1) / 365.25);
    int const D = static_cast<int>(365.25 * C);
    int const E = static_cast<int>((B - D) / 30.6001);

    day = B - D - static_cast<int>(30.6001 * E);
    month = (E < 14) ? E - 1 : E - 13;
    year = (month > 2) ? C - 4716 : C - 4715;
}

double HolidayDateCalculator::CalculateNewMoon(double k)
{
    // Meeus "Astronomical Algorithms" Chapter 49
    double const T = k / 1236.85;
    double const T2 = T * T;
    double const T3 = T2 * T;
    double const T4 = T3 * T;

    // Mean phase (Eq 49.1)
    double const JDE = 2451550.09766 + 29.530588861 * k + 0.00015437 * T2
                     - 0.000000150 * T3 + 0.00000000073 * T4;

    // Eccentricity correction
    double const E = 1.0 - 0.002516 * T - 0.0000074 * T2;
    double const E2 = E * E;

    // Sun's mean anomaly (Eq 49.4)
    double const M = 2.5534 + 29.10535670 * k - 0.0000014 * T2 - 0.00000011 * T3;

    // Moon's mean anomaly (Eq 49.5)
    double const MPrime = 201.5643 + 385.81693528 * k + 0.0107582 * T2
                        + 0.00001238 * T3 - 0.000000058 * T4;

    // Moon's argument of latitude (Eq 49.6)
    double const F = 160.7108 + 390.67050284 * k - 0.0016118 * T2
                   - 0.00000227 * T3 + 0.000000011 * T4;

    // Longitude of ascending node (Eq 49.7)
    double const Omega = 124.7746 - 1.56375588 * k + 0.0020672 * T2 + 0.00000215 * T3;

    // New Moon corrections (Table 49.A)
    double correction =
        - 0.40720 * sind(MPrime)
        + 0.17241 * E * sind(M)
        + 0.01608 * sind(2 * MPrime)
        + 0.01039 * sind(2 * F)
        + 0.00739 * E * sind(MPrime - M)
        - 0.00514 * E * sind(MPrime + M)
        + 0.00208 * E2 * sind(2 * M)
        - 0.00111 * sind(MPrime - 2 * F)
        - 0.00057 * sind(MPrime + 2 * F)
        + 0.00056 * E * sind(2 * MPrime + M)
        - 0.00042 * sind(3 * MPrime)
        + 0.00042 * E * sind(M + 2 * F)
        + 0.00038 * E * sind(M - 2 * F)
        - 0.00024 * E * sind(2 * MPrime - M)
        - 0.00017 * sind(Omega);

    // Additional planetary corrections (Table 49.B)
    double const A1  = 299.77 +  0.107408 * k - 0.009173 * T2;
    double const A2  = 251.88 +  0.016321 * k;
    double const A3  = 251.83 + 26.651886 * k;
    double const A4  = 349.42 + 36.412478 * k;
    double const A5  =  84.66 + 18.206239 * k;
    double const A6  = 141.74 + 53.303771 * k;
    double const A7  = 207.14 +  2.453732 * k;
    double const A8  = 154.84 +  7.306860 * k;
    double const A9  =  34.52 + 27.261239 * k;
    double const A10 = 207.19 +  0.121824 * k;
    double const A11 = 291.34 +  1.844379 * k;
    double const A12 = 161.72 + 24.198154 * k;
    double const A13 = 239.56 + 25.513099 * k;
    double const A14 = 331.55 +  3.592518 * k;

    correction += 0.000325 * sind(A1) + 0.000165 * sind(A2) + 0.000164 * sind(A3)
                + 0.000126 * sind(A4) + 0.000110 * sind(A5) + 0.000062 * sind(A6)
                + 0.000060 * sind(A7) + 0.000056 * sind(A8) + 0.000047 * sind(A9)
                + 0.000042 * sind(A10) + 0.000040 * sind(A11) + 0.000037 * sind(A12)
                + 0.000035 * sind(A13) + 0.000023 * sind(A14);

    return JDE + correction;
}

std::tm HolidayDateCalculator::CalculateLunarNewYear(int year)
{
    // Chinese New Year always falls on the new moon between Jan 21 and Feb 20
    double const jan21JD = DateToJulianDay(year, 1, 21.0);
    double const feb21JD = DateToJulianDay(year, 2, 21.0);

    // Approximate lunation number k for January of target year
    double const approxK = (year - 2000.0) * 12.3685;
    double const k = std::floor(approxK);

    // Search for the new moon in the valid range
    for (int i = -2; i <= 2; ++i)
    {
        double const nmJDE = CalculateNewMoon(k + i);

        // Convert TT (Terrestrial Time) to UT (approximate DeltaT ~70s for 2020s)
        double nmJD = nmJDE - 70.0 / 86400.0;

        // Add 8 hours for China Standard Time (UTC+8)
        nmJD += 8.0 / 24.0;

        if (nmJD >= jan21JD && nmJD < feb21JD)
        {
            int cnyYear, cnyMonth, cnyDay;
            JulianDayToDate(nmJD, cnyYear, cnyMonth, cnyDay);

            std::tm result = {};
            result.tm_year = cnyYear - 1900;
            result.tm_mon = cnyMonth - 1;
            result.tm_mday = cnyDay;
            mktime(&result);
            return result;
        }
    }

    // Fallback (should never happen for years 2000-2031)
    std::tm fallback = {};
    fallback.tm_year = year - 1900;
    fallback.tm_mon = 0;  // January
    fallback.tm_mday = 25;
    mktime(&fallback);
    return fallback;
}

// ============================================================================
// AUTUMN EQUINOX CALCULATION
// Based on Jean Meeus "Astronomical Algorithms" (1991), Chapter 27
// Reference: https://en.wikipedia.org/wiki/Equinox#Calculation
// ============================================================================

std::tm HolidayDateCalculator::CalculateAutumnEquinox(int year)
{
    // Meeus algorithm for mean September equinox (Table 27.C)
    // Valid for years 2000-3000
    double const Y = (year - 2000.0) / 1000.0;
    double const Y2 = Y * Y;
    double const Y3 = Y2 * Y;
    double const Y4 = Y3 * Y;

    // Mean equinox JDE0 (Eq 27.1 for September equinox after 2000)
    double const JDE0 = 2451810.21715 + 365242.01767 * Y - 0.11575 * Y2
                      + 0.00337 * Y3 + 0.00078 * Y4;

    // Periodic terms for correction (Table 27.B)
    double const T = (JDE0 - 2451545.0) / 36525.0;
    double const W = 35999.373 * T - 2.47;
    double const deltaLambda = 1.0 + 0.0334 * std::cos(W * DEG_TO_RAD)
                             + 0.0007 * std::cos(2.0 * W * DEG_TO_RAD);

    // Simplified correction (sum of periodic terms from Table 27.C)
    // Using first few significant terms
    double const S = 485 * std::cos((324.96 + 1934.136 * T) * DEG_TO_RAD)
                   + 203 * std::cos((337.23 + 32964.467 * T) * DEG_TO_RAD)
                   + 199 * std::cos((342.08 + 20.186 * T) * DEG_TO_RAD)
                   + 182 * std::cos((27.85 + 445267.112 * T) * DEG_TO_RAD)
                   + 156 * std::cos((73.14 + 45036.886 * T) * DEG_TO_RAD)
                   + 136 * std::cos((171.52 + 22518.443 * T) * DEG_TO_RAD)
                   + 77 * std::cos((222.54 + 65928.934 * T) * DEG_TO_RAD)
                   + 74 * std::cos((296.72 + 3034.906 * T) * DEG_TO_RAD)
                   + 70 * std::cos((243.58 + 9037.513 * T) * DEG_TO_RAD)
                   + 58 * std::cos((119.81 + 33718.147 * T) * DEG_TO_RAD)
                   + 52 * std::cos((297.17 + 150.678 * T) * DEG_TO_RAD)
                   + 50 * std::cos((21.02 + 2281.226 * T) * DEG_TO_RAD);

    double const JDE = JDE0 + (0.00001 * S) / deltaLambda;

    // Convert JDE to calendar date
    int eqYear;
    int eqMonth;
    int eqDay;
    JulianDayToDate(JDE, eqYear, eqMonth, eqDay);

    std::tm result = {};
    result.tm_year = eqYear - 1900;
    result.tm_mon = eqMonth - 1;
    result.tm_mday = eqDay;
    mktime(&result);
    return result;
}

// ============================================================================
// WINTER SOLSTICE CALCULATION
// Based on Jean Meeus "Astronomical Algorithms" (1991), Chapter 27
// ============================================================================

std::tm HolidayDateCalculator::CalculateWinterSolstice(int year)
{
    // Meeus algorithm for mean December solstice (Table 27.C)
    // Valid for years 2000-3000
    double const Y = (year - 2000.0) / 1000.0;
    double const Y2 = Y * Y;
    double const Y3 = Y2 * Y;
    double const Y4 = Y3 * Y;

    // Mean solstice JDE0 (Eq 27.1 for December solstice after 2000)
    double const JDE0 = 2451900.05952 + 365242.74049 * Y - 0.06223 * Y2
                      - 0.00823 * Y3 + 0.00032 * Y4;

    // Periodic terms for correction (Table 27.B)
    double const T = (JDE0 - 2451545.0) / 36525.0;
    double const W = 35999.373 * T - 2.47;
    double const deltaLambda = 1.0 + 0.0334 * std::cos(W * DEG_TO_RAD)
                             + 0.0007 * std::cos(2.0 * W * DEG_TO_RAD);

    // Simplified correction (sum of periodic terms from Table 27.C)
    double const S = 485 * std::cos((324.96 + 1934.136 * T) * DEG_TO_RAD)
                   + 203 * std::cos((337.23 + 32964.467 * T) * DEG_TO_RAD)
                   + 199 * std::cos((342.08 + 20.186 * T) * DEG_TO_RAD)
                   + 182 * std::cos((27.85 + 445267.112 * T) * DEG_TO_RAD)
                   + 156 * std::cos((73.14 + 45036.886 * T) * DEG_TO_RAD)
                   + 136 * std::cos((171.52 + 22518.443 * T) * DEG_TO_RAD)
                   + 77 * std::cos((222.54 + 65928.934 * T) * DEG_TO_RAD)
                   + 74 * std::cos((296.72 + 3034.906 * T) * DEG_TO_RAD)
                   + 70 * std::cos((243.58 + 9037.513 * T) * DEG_TO_RAD)
                   + 58 * std::cos((119.81 + 33718.147 * T) * DEG_TO_RAD)
                   + 52 * std::cos((297.17 + 150.678 * T) * DEG_TO_RAD)
                   + 50 * std::cos((21.02 + 2281.226 * T) * DEG_TO_RAD);

    double const JDE = JDE0 + (0.00001 * S) / deltaLambda;

    // Convert JDE to calendar date
    int solYear;
    int solMonth;
    int solDay;
    JulianDayToDate(JDE, solYear, solMonth, solDay);

    std::tm result = {};
    result.tm_year = solYear - 1900;
    result.tm_mon = solMonth - 1;
    result.tm_mday = solDay;
    mktime(&result);
    return result;
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
            if (rule.offset != 0)
            {
                result.tm_mday += rule.offset;
                mktime(&result); // Normalize
            }
            break;
        }
        case HolidayCalculationType::EASTER_OFFSET:
        {
            result = CalculateEasterSunday(year);
            result.tm_mday += rule.offset;
            mktime(&result); // Normalize
            break;
        }
        case HolidayCalculationType::LUNAR_NEW_YEAR:
        {
            result = CalculateLunarNewYear(year);
            if (rule.offset != 0)
            {
                result.tm_mday += rule.offset;
                mktime(&result); // Normalize
            }
            break;
        }
        case HolidayCalculationType::WEEKDAY_ON_OR_AFTER:
        {
            result = CalculateWeekdayOnOrAfter(year, rule.month, rule.day, static_cast<Weekday>(rule.weekday));
            if (rule.offset != 0)
            {
                result.tm_mday += rule.offset;
                mktime(&result); // Normalize
            }
            break;
        }
        case HolidayCalculationType::AUTUMN_EQUINOX:
        {
            result = CalculateAutumnEquinox(year);
            if (rule.offset != 0)
            {
                result.tm_mday += rule.offset;
                mktime(&result); // Normalize
            }
            break;
        }
        case HolidayCalculationType::WINTER_SOLSTICE:
        {
            result = CalculateWinterSolstice(year);
            if (rule.offset != 0)
            {
                result.tm_mday += rule.offset;
                mktime(&result); // Normalize
            }
            break;
        }
        case HolidayCalculationType::DARKMOON_FAIRE:
        {
            // Return first occurrence for the year
            // rule.month contains the location offset (0, 1, or 2)
            int const locationOffset = rule.month;

            // Find first month in the year where month % 3 == locationOffset
            for (int month = 1; month <= 12; ++month)
            {
                if (month % 3 == locationOffset)
                {
                    result = CalculateNthWeekday(year, month, Weekday::SUNDAY, 1);
                    break;
                }
            }
            break;
        }
    }

    return result;
}

uint32_t HolidayDateCalculator::PackDate(const std::tm& date)
{
    // WoW packed date format (same as ByteBuffer::AppendPackedTime):
    // bits 24-28: year offset from 2000 (5 bits = 0-31, valid years 2000-2031)
    // bits 20-23: month (0-indexed)
    // bits 14-19: day (0-indexed)
    // bits 11-13: weekday (0=Sunday, 6=Saturday - POSIX tm_wday)
    // bits 6-10: hour
    // bits 0-5: minute
    int const year = date.tm_year + 1900;
    // Client uses 5-bit year offset from 2000, so years before 2000 clamp to 0.
    // If client is patched to support earlier years, update this logic.
    uint32_t const yearOffset = (year < 2000) ? 0 : static_cast<uint32_t>(year - 2000);
    uint32_t const month = static_cast<uint32_t>(date.tm_mon);         // Already 0-indexed
    uint32_t const day = static_cast<uint32_t>(date.tm_mday - 1);      // Convert to 0-indexed
    uint32_t const weekday = static_cast<uint32_t>(date.tm_wday);      // 0=Sunday, 6=Saturday

    return (yearOffset << 24) | (month << 20) | (day << 14) | (weekday << 11);
}

std::tm HolidayDateCalculator::UnpackDate(uint32_t packed)
{
    std::tm result = {};
    result.tm_year = static_cast<int>(((packed >> 24) & 0x1F) + 2000 - 1900);
    result.tm_mon = static_cast<int>((packed >> 20) & 0xF);
    result.tm_mday = static_cast<int>(((packed >> 14) & 0x3F) + 1);
    result.tm_wday = static_cast<int>((packed >> 11) & 0x7);
    result.tm_hour = static_cast<int>((packed >> 6) & 0x1F);
    result.tm_min = static_cast<int>(packed & 0x3F);
    mktime(&result); // Normalize and fill in tm_yday, tm_isdst
    return result;
}

uint32_t HolidayDateCalculator::GetPackedHolidayDate(uint32_t holidayId, int year)
{
    for (auto const& rule : HolidayRules)
    {
        if (rule.holidayId == holidayId)
        {
            std::tm const date = CalculateHolidayDate(rule, year);
            return PackDate(date);
        }
    }
    return 0; // Holiday not found
}

std::vector<uint32_t> HolidayDateCalculator::GetDarkmoonFaireDates(int locationOffset, int startYear, int numYears, int dayOffset)
{
    std::vector<uint32_t> dates;

    // Darkmoon Faire is first Sunday of months where (month % 3) == locationOffset
    // locationOffset 0: Mar, Jun, Sep, Dec - Elwynn (Alliance)
    // locationOffset 1: Jan, Apr, Jul, Oct - Mulgore (Horde)
    // locationOffset 2: Feb, May, Aug, Nov - Terokkar (Outland)

    for (int year = startYear; year < startYear + numYears && year <= 2030; ++year)
    {
        for (int month = 1; month <= 12; ++month)
        {
            if (month % 3 == locationOffset)
            {
                // Calculate first Sunday of this month, then apply day offset
                std::tm date = CalculateNthWeekday(year, month, Weekday::SUNDAY, 1);
                if (dayOffset != 0)
                {
                    date.tm_mday += dayOffset;
                    mktime(&date); // Normalize
                }
                dates.push_back(PackDate(date));
            }
        }
    }

    return dates;
}
