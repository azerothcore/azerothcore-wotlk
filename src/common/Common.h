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

#ifndef AZEROTHCORE_COMMON_H
#define AZEROTHCORE_COMMON_H

#include "Define.h"
#include <string>

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
#include <ws2tcpip.h>
#if AC_COMPILER == AC_COMPILER_INTEL
#    if !defined(BOOST_ASIO_HAS_MOVE)
#      define BOOST_ASIO_HAS_MOVE
#    endif // !defined(BOOST_ASIO_HAS_MOVE)
#  endif // if AC_COMPILER == AC_COMPILER_INTEL
#else
#include <cstdlib>
#include <netdb.h>
#include <netinet/in.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
#endif

#define STRINGIZE(a) #a

#define MAX_NETCLIENT_PACKET_SIZE (32767 - 1)               // Client hardcap: int16 with trailing zero space otherwise crash on memory free

// TimeConstants
constexpr auto SECOND = 1;
constexpr auto MINUTE = SECOND * 60;
constexpr auto HOUR = MINUTE * 60;
constexpr auto DAY = HOUR * 24;
constexpr auto WEEK = DAY * 7;
constexpr auto MONTH = DAY * 30;
constexpr auto YEAR = DAY * 365;
constexpr auto IN_MILLISECONDS = 1000;

enum AccountTypes
{
    SEC_PLAYER         = 0,
    SEC_MODERATOR      = 1,
    SEC_GAMEMASTER     = 2,
    SEC_ADMINISTRATOR  = 3,
    SEC_CONSOLE        = 4                                  // must be always last in list, accounts must have less security level always also
};

#define MAX_ACCOUNT_FLAG 32
enum AccountFlag
{
    ACCOUNT_FLAG_GM                   = 0x1,        // Account is GM
    ACCOUNT_FLAG_NOKICK               = 0x2,        // NYI UNK
    ACCOUNT_FLAG_COLLECTOR            = 0x4,        // NYI Collector's Edition
    ACCOUNT_FLAG_TRIAL                = 0x8,        // NYI Trial account
    ACCOUNT_FLAG_CANCELLED            = 0x10,       // NYI UNK
    ACCOUNT_FLAG_IGR                  = 0x20,       // NYI Internet Game Room (Internet cafe?)
    ACCOUNT_FLAG_WHOLESALER           = 0x40,       // NYI UNK
    ACCOUNT_FLAG_PRIVILEGED           = 0x80,       // NYI UNK
    ACCOUNT_FLAG_EU_FORBID_ELV        = 0x100,      // NYI UNK
    ACCOUNT_FLAG_EU_FORBID_BILLING    = 0x200,      // NYI UNK
    ACCOUNT_FLAG_RESTRICTED           = 0x400,      // NYI UNK
    ACCOUNT_FLAG_REFERRAL             = 0x800,      // NYI Recruit-A-Friend, either referer or referee
    ACCOUNT_FLAG_BLIZZARD             = 0x1000,     // NYI UNK
    ACCOUNT_FLAG_RECURRING_BILLING    = 0x2000,     // NYI UNK
    ACCOUNT_FLAG_NOELECTUP            = 0x4000,     // NYI UNK
    ACCOUNT_FLAG_KR_CERTIFICATE       = 0x8000,     // NYI Korean certificate?
    ACCOUNT_FLAG_EXPANSION_COLLECTOR  = 0x10000,    // NYI TBC Collector's Edition
    ACCOUNT_FLAG_DISABLE_VOICE        = 0x20000,    // NYI Can't join voice chat
    ACCOUNT_FLAG_DISABLE_VOICE_SPEAK  = 0x40000,    // NYI Can't speak in voice chat
    ACCOUNT_FLAG_REFERRAL_RESURRECT   = 0x80000,    // NYI Scroll of Resurrection
    ACCOUNT_FLAG_EU_FORBID_CC         = 0x100000,   // NYI UNK
    ACCOUNT_FLAG_OPENBETA_DELL        = 0x200000,   // NYI https://wowpedia.fandom.com/wiki/Dell_XPS_M1730_World_of_Warcraft_Edition
    ACCOUNT_FLAG_PROPASS              = 0x400000,   // NYI UNK
    ACCOUNT_FLAG_PROPASS_LOCK         = 0x800000,   // NYI Pro pass (arena tournament)
    ACCOUNT_FLAG_PENDING_UPGRADE      = 0x1000000,  // NYI UNK
    ACCOUNT_FLAG_RETAIL_FROM_TRIAL    = 0x2000000,  // NYI UNK
    ACCOUNT_FLAG_EXPANSION2_COLLECTOR = 0x4000000,  // NYI WotLK Collector's Edition
    ACCOUNT_FLAG_OVERMIND_LINKED      = 0x8000000,  // NYI Linked with Battle.net account
    ACCOUNT_FLAG_DEMOS                = 0x10000000, // NYI UNK
    ACCOUNT_FLAG_DEATH_KNIGHT_OK      = 0x20000000, // NYI Has level 55 on account?
    // Below might be StarCraft II related
    ACCOUNT_FLAG_S2_REQUIRE_IGR       = 0x40000000, // NYI UNK
    ACCOUNT_FLAG_S2_TRIAL             = 0x80000000, // NYI UNK
    // ACCOUNT_FLAG_S2_RESTRICTED        = 0xFFFFFFFF,  // NYI UNK
};

constexpr uint32 ACCOUNT_FLAGS_ALL =
    ACCOUNT_FLAG_GM | ACCOUNT_FLAG_NOKICK | ACCOUNT_FLAG_COLLECTOR |
    ACCOUNT_FLAG_TRIAL | ACCOUNT_FLAG_CANCELLED | ACCOUNT_FLAG_IGR |
    ACCOUNT_FLAG_WHOLESALER | ACCOUNT_FLAG_PRIVILEGED | ACCOUNT_FLAG_EU_FORBID_ELV |
    ACCOUNT_FLAG_EU_FORBID_BILLING | ACCOUNT_FLAG_RESTRICTED | ACCOUNT_FLAG_REFERRAL |
    ACCOUNT_FLAG_BLIZZARD | ACCOUNT_FLAG_RECURRING_BILLING | ACCOUNT_FLAG_NOELECTUP |
    ACCOUNT_FLAG_KR_CERTIFICATE | ACCOUNT_FLAG_EXPANSION_COLLECTOR | ACCOUNT_FLAG_DISABLE_VOICE |
    ACCOUNT_FLAG_DISABLE_VOICE_SPEAK | ACCOUNT_FLAG_REFERRAL_RESURRECT | ACCOUNT_FLAG_EU_FORBID_CC |
    ACCOUNT_FLAG_OPENBETA_DELL | ACCOUNT_FLAG_PROPASS | ACCOUNT_FLAG_PROPASS_LOCK |
    ACCOUNT_FLAG_PENDING_UPGRADE | ACCOUNT_FLAG_RETAIL_FROM_TRIAL | ACCOUNT_FLAG_EXPANSION2_COLLECTOR |
    ACCOUNT_FLAG_OVERMIND_LINKED | ACCOUNT_FLAG_DEMOS | ACCOUNT_FLAG_DEATH_KNIGHT_OK |
    ACCOUNT_FLAG_S2_REQUIRE_IGR | ACCOUNT_FLAG_S2_TRIAL;

enum LocaleConstant
{
    LOCALE_enUS = 0,
    LOCALE_koKR = 1,
    LOCALE_frFR = 2,
    LOCALE_deDE = 3,
    LOCALE_zhCN = 4,
    LOCALE_zhTW = 5,
    LOCALE_esES = 6,
    LOCALE_esMX = 7,
    LOCALE_ruRU = 8,

    TOTAL_LOCALES
};

#define DEFAULT_LOCALE LOCALE_enUS

#define MAX_LOCALES 8
#define MAX_ACCOUNT_TUTORIAL_VALUES 8

AC_COMMON_API extern char const* localeNames[TOTAL_LOCALES];

AC_COMMON_API bool IsLocaleValid(std::string const& locale);
AC_COMMON_API LocaleConstant GetLocaleByName(const std::string& name);
AC_COMMON_API const std::string GetNameByLocaleConstant(LocaleConstant localeConstant);
AC_COMMON_API void CleanStringForMysqlQuery(std::string& str);

#define MAX_QUERY_LEN 32*1024

namespace Acore
{
    template<class ArgumentType, class ResultType>
    struct unary_function
    {
        typedef ArgumentType argument_type;
        typedef ResultType result_type;
    };
}

#endif
