/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _ACCMGR_H
#define _ACCMGR_H

#include "Define.h"
#include <string>

enum AccountOpResult
{
    AOR_OK,
    AOR_NAME_TOO_LONG,
    AOR_PASS_TOO_LONG,
    AOR_EMAIL_TOO_LONG,
    AOR_NAME_ALREADY_EXIST,
    AOR_NAME_NOT_EXIST,
    AOR_DB_INTERNAL_ERROR
};

enum AccountFlag
{
    FLAG_GM                   = 0x1,        // Account is GM
    FLAG_NOKICK               = 0x2,        // NYI UNK
    FLAG_COLLECTOR            = 0x4,        // NYI UNK
    FLAG_TRIAL                = 0x8,        // NYI UNK
    FLAG_CANCELLED            = 0x10,       // NYI UNK
    FLAG_IGR                  = 0x20,       // NYI UNK
    FLAG_WHOLESALER           = 0x40,       // NYI UNK
    FLAG_PRIVILEGED           = 0x80,       // NYI UNK
    FLAG_EU_FORBID_ELV        = 0x100,      // NYI UNK
    FLAG_EU_FORBID_BILLING    = 0x200,      // NYI UNK
    FLAG_RESTRICTED           = 0x400,      // NYI UNK
    FLAG_REFERRAL             = 0x800,      // NYI UNK
    FLAG_BLIZZARD             = 0x1000,     // NYI UNK
    FLAG_RECURRING_BILLING    = 0x2000,     // NYI UNK
    FLAG_NOELECTUP            = 0x4000,     // NYI UNK
    FLAG_KR_CERTIFICATE       = 0x8000,     // NYI UNK
    FLAG_EXPANSION_COLLECTOR  = 0x10000,    // NYI UNK
    FLAG_DISABLE_VOICE        = 0x20000,    // NYI Can't join voice chat
    FLAG_DISABLE_VOICE_SPEAK  = 0x40000,    // NYI Can't speak in voice chat
    FLAG_REFERRAL_RESURRECT   = 0x80000,    // NYI UNK
    FLAG_EU_FORBID_CC         = 0x100000,   // NYI UNK
    FLAG_OPENBETA_DELL        = 0x200000,   // NYI UNK
    FLAG_PROPASS              = 0x400000,   // NYI UNK
    FLAG_PROPASS_LOCK         = 0x800000,   // NYI UNK
    FLAG_PENDING_UPGRADE      = 0x1000000,  // NYI UNK
    FLAG_RETAIL_FROM_TRIAL    = 0x2000000,  // NYI UNK
    FLAG_EXPANSION2_COLLECTOR = 0x4000000,  // NYI UNK
    FLAG_OVERMIND_LINKED      = 0x8000000,  // NYI UNK
    FLAG_DEMOS                = 0x10000000, // NYI UNK
    FLAG_DEATH_KNIGHT_OK      = 0x20000000, // NYI UNK
    FLAG_S2_REQUIRE_IGR       = 0x40000000, // NYI UNK
    FLAG_S2_TRIAL             = 0x80000000, // NYI UNK
    FLAG_S2_RESTRICTED        = 0xFFFFFFFF  // NYI UNK
};

#define MAX_ACCOUNT_STR 17
#define MAX_PASS_STR 16
#define MAX_EMAIL_STR 255

namespace AccountMgr
{
    AccountOpResult CreateAccount(std::string username, std::string password, std::string email = "");
    AccountOpResult DeleteAccount(uint32 accountId);
    AccountOpResult ChangeUsername(uint32 accountId, std::string newUsername, std::string newPassword);
    AccountOpResult ChangePassword(uint32 accountId, std::string newPassword);
    AccountOpResult ChangeEmail(uint32 accountId, std::string email);
    bool CheckPassword(uint32 accountId, std::string password);

    uint32 GetId(std::string const& username);
    uint32 GetSecurity(uint32 accountId);
    uint32 GetSecurity(uint32 accountId, int32 realmId);
    bool GetName(uint32 accountId, std::string& name);
    uint32 GetCharactersCount(uint32 accountId);

    bool IsPlayerAccount(uint32 gmlevel);
    bool IsGMAccount(uint32 gmlevel);
    bool IsAdminAccount(uint32 gmlevel);
    bool IsConsoleAccount(uint32 gmlevel);

    bool HasAccountFlag(uint32 accountId, uint32 flag);
    void UpdateAccountFlag(uint32 accountId, uint32 flag, bool remove = false);
    void ValidateAccountFlags(uint32 accountId, uint32 flags, uint32 security);
};

#endif
