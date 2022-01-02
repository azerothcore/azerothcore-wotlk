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

#ifndef _BAN_MANAGER_H
#define _BAN_MANAGER_H

#include "Common.h"

/// Ban function return codes
enum BanReturn
{
    BAN_SUCCESS,
    BAN_SYNTAX_ERROR,
    BAN_NOTFOUND,
    BAN_LONGER_EXISTS
};

class BanMgr
{
public:
    static auto instance() -> BanMgr*;

    auto BanAccount(std::string const& AccountName, std::string const& Duration, std::string const& Reason, std::string const& Author) -> BanReturn;
    auto BanAccountByPlayerName(std::string const& CharacterName, std::string const& Duration, std::string const& Reason, std::string const& Author) -> BanReturn;
    auto BanIP(std::string const& IP, std::string const& Duration, std::string const& Reason, std::string const& Author) -> BanReturn;
    auto BanCharacter(std::string const& CharacterName, std::string const& Duration, std::string const& Reason, std::string const& Author) -> BanReturn;

    auto RemoveBanAccount(std::string const& AccountName) -> bool;
    auto RemoveBanAccountByPlayerName(std::string const& CharacterName) -> bool;
    auto RemoveBanIP(std::string const& IP) -> bool;
    auto RemoveBanCharacter(std::string const& CharacterName) -> bool;
};

#define sBan BanMgr::instance()

#endif // _BAN_MANAGER_H
