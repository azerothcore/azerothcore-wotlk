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

char const* localeNames[TOTAL_LOCALES] =
{
    "enUS",
    "koKR",
    "frFR",
    "deDE",
    "zhCN",
    "zhTW",
    "esES",
    "esMX",
    "ruRU"
};

AccountFlagName const accountFlagNames[MAX_ACCOUNT_FLAG] =
{
    { "ACCOUNT_FLAG_GM",                   "GM"                   },
    { "ACCOUNT_FLAG_NOKICK",               "NOKICK"               },
    { "ACCOUNT_FLAG_COLLECTOR",            "COLLECTOR"            },
    { "ACCOUNT_FLAG_TRIAL",                "TRIAL"                },
    { "ACCOUNT_FLAG_CANCELLED",            "CANCELLED"            },
    { "ACCOUNT_FLAG_IGR",                  "IGR"                  },
    { "ACCOUNT_FLAG_WHOLESALER",           "WHOLESALER"           },
    { "ACCOUNT_FLAG_PRIVILEGED",           "PRIVILEGED"           },
    { "ACCOUNT_FLAG_EU_FORBID_ELV",        "EU_FORBID_ELV"        },
    { "ACCOUNT_FLAG_EU_FORBID_BILLING",    "EU_FORBID_BILLING"    },
    { "ACCOUNT_FLAG_RESTRICTED",           "RESTRICTED"           },
    { "ACCOUNT_FLAG_REFERRAL",             "REFERRAL"             },
    { "ACCOUNT_FLAG_BLIZZARD",             "BLIZZARD"             },
    { "ACCOUNT_FLAG_RECURRING_BILLING",    "RECURRING_BILLING"    },
    { "ACCOUNT_FLAG_NOELECTUP",            "NOELECTUP"            },
    { "ACCOUNT_FLAG_KR_CERTIFICATE",       "KR_CERTIFICATE"       },
    { "ACCOUNT_FLAG_EXPANSION_COLLECTOR",  "EXPANSION_COLLECTOR"  },
    { "ACCOUNT_FLAG_DISABLE_VOICE",        "DISABLE_VOICE"        },
    { "ACCOUNT_FLAG_DISABLE_VOICE_SPEAK",  "DISABLE_VOICE_SPEAK"  },
    { "ACCOUNT_FLAG_REFERRAL_RESURRECT",   "REFERRAL_RESURRECT"   },
    { "ACCOUNT_FLAG_EU_FORBID_CC",         "EU_FORBID_CC"         },
    { "ACCOUNT_FLAG_OPENBETA_DELL",        "OPENBETA_DELL"        },
    { "ACCOUNT_FLAG_PROPASS",              "PROPASS"              },
    { "ACCOUNT_FLAG_PROPASS_LOCK",         "PROPASS_LOCK"         },
    { "ACCOUNT_FLAG_PENDING_UPGRADE",      "PENDING_UPGRADE"      },
    { "ACCOUNT_FLAG_RETAIL_FROM_TRIAL",    "RETAIL_FROM_TRIAL"    },
    { "ACCOUNT_FLAG_EXPANSION2_COLLECTOR", "EXPANSION2_COLLECTOR" },
    { "ACCOUNT_FLAG_OVERMIND_LINKED",      "OVERMIND_LINKED"      },
    { "ACCOUNT_FLAG_DEMOS",                "DEMOS"                },
    { "ACCOUNT_FLAG_DEATH_KNIGHT_OK",      "DEATH_KNIGHT_OK"      },
    { "ACCOUNT_FLAG_S2_REQUIRE_IGR",       "S2_REQUIRE_IGR"       },
    { "ACCOUNT_FLAG_S2_TRIAL",             "S2_TRIAL"             }
};

bool IsLocaleValid(std::string const& locale)
{
    for (int i = 0; i < TOTAL_LOCALES; ++i)
        if (locale == localeNames[i])
            return true;

    return false;
}

LocaleConstant GetLocaleByName(std::string const& name)
{
    for (uint32 i = 0; i < TOTAL_LOCALES; ++i)
        if (name == localeNames[i])
            return LocaleConstant(i);

    return LOCALE_enUS;                                     // including enGB case
}

const std::string GetNameByLocaleConstant(LocaleConstant localeConstant)
{
    if (localeConstant < TOTAL_LOCALES)
    {
        return localeNames[localeConstant];
    }

    return "enUS"; // Default value for unsupported or invalid LocaleConstant
}

void CleanStringForMysqlQuery(std::string& str)
{
    std::string::size_type n = 0;
    while ((n = str.find('\\')) != str.npos) { str.erase(n, 1); }
    while ((n = str.find('"')) != str.npos) { str.erase(n, 1); }
    while ((n = str.find('\'')) != str.npos) { str.erase(n, 1); }
}
