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

#ifndef __WHOLISTCACHE_H
#define __WHOLISTCACHE_H

#include "Common.h"
#include "SharedDefines.h"

struct WhoListPlayerInfo
{
    TeamId teamId;
    AccountTypes security;
    uint8 level;
    uint8 clas;
    uint8 race;
    uint32 zoneid;
    uint8 gender;
    std::wstring wpname;
    std::wstring wgname;
    std::string aname;
    std::string pname;
    std::string gname;

    WhoListPlayerInfo(TeamId teamId, AccountTypes security, uint8 level, uint8 clas, uint8 race, uint32 zoneid, uint8 gender, std::wstring wpname, std::wstring wgname, std::string aname, std::string pname, std::string gname) :
        teamId(teamId), security(security), level(level), clas(clas), race(race), zoneid(zoneid), gender(gender), wpname(wpname), wgname(wgname), aname(aname), pname(pname), gname(gname) {}
};

class WhoListCacheMgr
{
public:
    static void Update();
    static std::vector<WhoListPlayerInfo>* GetWhoList() { return &m_whoOpcodeList; }

protected:
    static std::vector<WhoListPlayerInfo> m_whoOpcodeList;
};

#endif
