/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
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
