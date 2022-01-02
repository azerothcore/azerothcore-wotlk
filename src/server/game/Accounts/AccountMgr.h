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
    AOR_NAME_ALREADY_EXIST,
    AOR_NAME_NOT_EXIST,
    AOR_DB_INTERNAL_ERROR
};

#define MAX_ACCOUNT_STR 20
#define MAX_PASS_STR 16

namespace AccountMgr
{
    auto CreateAccount(std::string username, std::string password) -> AccountOpResult;
    auto DeleteAccount(uint32 accountId) -> AccountOpResult;
    auto ChangeUsername(uint32 accountId, std::string newUsername, std::string newPassword) -> AccountOpResult;
    auto ChangePassword(uint32 accountId, std::string newPassword) -> AccountOpResult;
    auto CheckPassword(uint32 accountId, std::string password) -> bool;

    auto GetId(std::string const& username) -> uint32;
    auto GetSecurity(uint32 accountId) -> uint32;
    auto GetSecurity(uint32 accountId, int32 realmId) -> uint32;
    auto GetName(uint32 accountId, std::string& name) -> bool;
    auto GetCharactersCount(uint32 accountId) -> uint32;

    auto IsPlayerAccount(uint32 gmlevel) -> bool;
    auto IsGMAccount(uint32 gmlevel) -> bool;
    auto IsAdminAccount(uint32 gmlevel) -> bool;
    auto IsConsoleAccount(uint32 gmlevel) -> bool;
};

#endif
