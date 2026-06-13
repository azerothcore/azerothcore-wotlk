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
    static BanMgr* instance();

    BanReturn BanAccount(std::string const& AccountName, std::string const& Duration, std::string const& Reason, std::string const& Author);
    BanReturn BanAccountByPlayerName(std::string const& CharacterName, std::string const& Duration, std::string const& Reason, std::string const& Author);
    BanReturn BanIP(std::string const& IP, std::string const& Duration, std::string const& Reason, std::string const& Author);
    BanReturn BanCharacter(std::string const& CharacterName, std::string const& Duration, std::string const& Reason, std::string const& Author);

    bool RemoveBanAccount(std::string const& AccountName);
    bool RemoveBanAccountByPlayerName(std::string const& CharacterName);
    bool RemoveBanIP(std::string const& IP);
    bool RemoveBanCharacter(std::string const& CharacterName);
};

#define sBan BanMgr::instance()

#endif // _BAN_MANAGER_H
