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

#include "GuildMgr.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "WhoListCache.h"
#include "World.h"

std::vector<WhoListPlayerInfo> WhoListCacheMgr::m_whoOpcodeList;

void WhoListCacheMgr::Update()
{
    // clear current list
    m_whoOpcodeList.clear();
    m_whoOpcodeList.reserve(sWorld->GetPlayerCount() + 1);

    std::shared_lock<std::shared_mutex> lock(*HashMapHolder<Player>::GetLock());
    HashMapHolder<Player>::MapType const& m = ObjectAccessor::GetPlayers();
    for (HashMapHolder<Player>::MapType::const_iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->second->FindMap() || itr->second->GetSession()->PlayerLoading())
            continue;

        if (itr->second->GetSession()->GetSecurity() > SEC_PLAYER)
            continue;

        std::string pname = itr->second->GetName();
        std::wstring wpname;
        if (!Utf8toWStr(pname, wpname))
            continue;
        wstrToLower(wpname);

        std::string gname = sGuildMgr->GetGuildNameById(itr->second->GetGuildId());
        std::wstring wgname;
        if (!Utf8toWStr(gname, wgname))
            continue;
        wstrToLower(wgname);

        std::string aname;
        if (AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(itr->second->GetZoneId()))
            aname = areaEntry->area_name[sWorld->GetDefaultDbcLocale()];

        if (itr->second->IsSpectator())
            aname = "Dalaran";

        m_whoOpcodeList.push_back( WhoListPlayerInfo(itr->second->GetTeamId(), itr->second->GetSession()->GetSecurity(), itr->second->getLevel(), itr->second->getClass(), itr->second->getRace(), (itr->second->IsSpectator() ? 4395 /*Dalaran*/ : itr->second->GetZoneId()), itr->second->getGender(), wpname, wgname, aname, pname, gname) );
    }
}
