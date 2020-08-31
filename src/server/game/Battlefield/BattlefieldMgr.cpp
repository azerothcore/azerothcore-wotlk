/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "BattlefieldMgr.h"
#include "Zones/BattlefieldWG.h"
#include "ObjectMgr.h"
#include "Player.h"

BattlefieldMgr::BattlefieldMgr()
{
    m_UpdateTimer = 0;
    //sLog->outDebug(LOG_FILTER_BATTLEFIELD, "Instantiating BattlefieldMgr");
}

BattlefieldMgr::~BattlefieldMgr()
{
    //sLog->outDebug(LOG_FILTER_BATTLEFIELD, "Deleting BattlefieldMgr");
    for (BattlefieldSet::iterator itr = m_BattlefieldSet.begin(); itr != m_BattlefieldSet.end(); ++itr)
        delete *itr;
}

BattlefieldMgr* BattlefieldMgr::instance()
{
    static BattlefieldMgr instance;
    return &instance;
}

void BattlefieldMgr::InitBattlefield()
{
    Battlefield* pBf = new BattlefieldWG;
    // respawn, init variables
    if (!pBf->SetupBattlefield())
    {
        sLog->outString();
        sLog->outString("Battlefield : Wintergrasp init failed.");
        delete pBf;
    }
    else
    {
        m_BattlefieldSet.push_back(pBf);
        sLog->outString();
        sLog->outString("Battlefield : Wintergrasp successfully initiated.");
    }

    /* For Cataclysm: Tol Barad
       pBf = new BattlefieldTB;
       // respawn, init variables
       if(!pBf->SetupBattlefield())
       {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
       sLog->outDebug(LOG_FILTER_BATTLEFIELD, "Battlefield : Tol Barad init failed.");
#endif
       delete pBf;
       }
       else
       {
       m_BattlefieldSet.push_back(pBf);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
       sLog->outDebug(LOG_FILTER_BATTLEFIELD, "Battlefield : Tol Barad successfully initiated.");
#endif
       } */
}

void BattlefieldMgr::AddZone(uint32 zoneid, Battlefield *handle)
{
    m_BattlefieldMap[zoneid] = handle;
}

void BattlefieldMgr::HandlePlayerEnterZone(Player * player, uint32 zoneid)
{
    BattlefieldMap::iterator itr = m_BattlefieldMap.find(zoneid);
    if (itr == m_BattlefieldMap.end())
        return;

    if (itr->second->HasPlayer(player) || !itr->second->IsEnabled())
        return;

    itr->second->HandlePlayerEnterZone(player, zoneid);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_BATTLEFIELD, "Player %u entered outdoorpvp id %u", player->GetGUIDLow(), itr->second->GetTypeId());
#endif
}

void BattlefieldMgr::HandlePlayerLeaveZone(Player * player, uint32 zoneid)
{
    BattlefieldMap::iterator itr = m_BattlefieldMap.find(zoneid);
    if (itr == m_BattlefieldMap.end())
        return;

    // teleport: remove once in removefromworld, once in updatezone
    if (!itr->second->HasPlayer(player))
        return;
    itr->second->HandlePlayerLeaveZone(player, zoneid);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_BATTLEFIELD, "Player %u left outdoorpvp id %u", player->GetGUIDLow(), itr->second->GetTypeId());
#endif
}

Battlefield *BattlefieldMgr::GetBattlefieldToZoneId(uint32 zoneid)
{
    BattlefieldMap::iterator itr = m_BattlefieldMap.find(zoneid);
    if (itr == m_BattlefieldMap.end())
    {
        // no handle for this zone, return
        return nullptr;
    }
    if (!itr->second->IsEnabled())
        return nullptr;
    return itr->second;
}

Battlefield *BattlefieldMgr::GetBattlefieldByBattleId(uint32 battleid)
{
    for (BattlefieldSet::iterator itr = m_BattlefieldSet.begin(); itr != m_BattlefieldSet.end(); ++itr)
    {
        if ((*itr)->GetBattleId() == battleid)
            return (*itr);
    }
    return nullptr;
}

void BattlefieldMgr::Update(uint32 diff)
{
    m_UpdateTimer += diff;
    if (m_UpdateTimer > BATTLEFIELD_OBJECTIVE_UPDATE_INTERVAL)
    {
        for (BattlefieldSet::iterator itr = m_BattlefieldSet.begin(); itr != m_BattlefieldSet.end(); ++itr)
            //if ((*itr)->IsEnabled())
                (*itr)->Update(m_UpdateTimer);
        m_UpdateTimer = 0;
    }
}

ZoneScript *BattlefieldMgr::GetZoneScript(uint32 zoneId)
{
    BattlefieldMap::iterator itr = m_BattlefieldMap.find(zoneId);
    if (itr != m_BattlefieldMap.end())
        return itr->second;
    else
        return nullptr;
}
