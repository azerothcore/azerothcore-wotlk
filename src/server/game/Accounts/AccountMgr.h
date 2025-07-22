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
    FLAG_GM                   = 0x1,
    FLAG_NOKICK               = 0x2,
    FLAG_COLLECTOR            = 0x4,
    FLAG_TRIAL                = 0x8,
    FLAG_CANCELLED            = 0x10,
    FLAG_IGR                  = 0x20,
    FLAG_WHOLESALER           = 0x40,
    FLAG_PRIVILEGED           = 0x80,
    FLAG_EU_FORBID_ELV        = 0x100,
    FLAG_EU_FORBID_BILLING    = 0x200,
    FLAG_RESTRICTED           = 0x400,
    FLAG_REFERRAL             = 0x800,
    FLAG_BLIZZARD             = 0x1000,
    FLAG_RECURRING_BILLING    = 0x2000,
    FLAG_NOELECTUP            = 0x4000,
    FLAG_KR_CERTIFICATE       = 0x8000,
    FLAG_EXPANSION_COLLECTOR  = 0x10000,
    FLAG_DISABLE_VOICE        = 0x20000,
    FLAG_DISABLE_VOICE_SPEAK  = 0x40000,
    FLAG_REFERRAL_RESURRECT   = 0x80000,
    FLAG_EU_FORBID_CC         = 0x100000,
    FLAG_OPENBETA_DELL        = 0x200000,
    FLAG_PROPASS              = 0x400000,
    FLAG_PROPASS_LOCK         = 0x800000,
    FLAG_PENDING_UPGRADE      = 0x1000000,
    FLAG_RETAIL_FROM_TRIAL    = 0x2000000,
    FLAG_EXPANSION2_COLLECTOR = 0x4000000,
    FLAG_OVERMIND_LINKED      = 0x8000000,
    FLAG_DEMOS                = 0x10000000,
    FLAG_DEATH_KNIGHT_OK      = 0x20000000,
    FLAG_S2_REQUIRE_IGR       = 0x40000000,
    FLAG_S2_TRIAL             = 0x80000000,
    FLAG_S2_RESTRICTED        = 0xFFFFFFFF
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
    void ValidateAccountFlags(uint32 accountId);
};

#endif
