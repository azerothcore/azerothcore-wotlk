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

#include "OutdoorPvPMgr.h"
#include "DisableMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"

OutdoorPvPMgr::OutdoorPvPMgr()
{
    m_UpdateTimer = 0;
    //LOG_DEBUG("outdoorpvp", "Instantiating OutdoorPvPMgr");
}

OutdoorPvPMgr* OutdoorPvPMgr::instance()
{
    static OutdoorPvPMgr instance;
    return &instance;
}

void OutdoorPvPMgr::Die()
{
    m_OutdoorPvPSet.clear();
    m_OutdoorPvPDatas.clear();
}

void OutdoorPvPMgr::InitOutdoorPvP()
{
    uint32 oldMSTime = getMSTime();

    //                                                 0       1
    QueryResult result = WorldDatabase.Query("SELECT TypeId, ScriptName FROM outdoorpvp_template");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 outdoor PvP definitions. DB table `outdoorpvp_template` is empty.");
        LOG_INFO("server.loading", " ");
        return;
    }

    uint32 count = 0;
    uint32 typeId = 0;

    for (auto const& fields : *result)
    {
        typeId = fields[0].Get<uint8>();

        if (sDisableMgr->IsDisabledFor(DISABLE_TYPE_OUTDOORPVP, typeId, nullptr))
            continue;

        if (typeId >= MAX_OUTDOORPVP_TYPES)
        {
            LOG_ERROR("sql.sql", "Invalid OutdoorPvPTypes value {} in outdoorpvp_template; skipped.", typeId);
            continue;
        }

        auto data = std::make_unique<OutdoorPvPData>();
        auto realTypeId = OutdoorPvPTypes(typeId);
        data->TypeId = realTypeId;
        data->ScriptId = sObjectMgr->GetScriptId(fields[1].Get<std::string>());
        m_OutdoorPvPDatas[realTypeId] = std::move(data);

        ++count;
    }

    for (uint8 i = 1; i < MAX_OUTDOORPVP_TYPES; ++i)
    {
        auto iter = m_OutdoorPvPDatas.find(OutdoorPvPTypes(i));
        if (iter == m_OutdoorPvPDatas.end())
        {
            LOG_ERROR("sql.sql", "Could not initialize OutdoorPvP object for type ID {}; no entry in database.", uint32(i));
            continue;
        }

        auto pvp = std::unique_ptr<OutdoorPvP>(sScriptMgr->CreateOutdoorPvP(iter->second.get()));
        if (!pvp)
        {
            LOG_ERROR("outdoorpvp", "Could not initialize OutdoorPvP object for type ID {}; got nullptr pointer from script.", uint32(i));
            continue;
        }

        if (!pvp->SetupOutdoorPvP())
        {
            LOG_ERROR("outdoorpvp", "Could not initialize OutdoorPvP object for type ID {}; SetupOutdoorPvP failed.", uint32(i));
            continue;
        }

        m_OutdoorPvPSet.emplace_back(std::move(pvp));
    }

    LOG_INFO("server.loading", ">> Loaded {} outdoor PvP definitions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void OutdoorPvPMgr::AddZone(uint32 zoneid, OutdoorPvP* handle)
{
    m_OutdoorPvPMap[zoneid] = handle;
}

void OutdoorPvPMgr::HandlePlayerEnterZone(Player* player, uint32 zoneid)
{
    auto itr = m_OutdoorPvPMap.find(zoneid);
    if (itr == m_OutdoorPvPMap.end())
        return;

    std::lock_guard<std::mutex> guard(_lock); // pussywizard

    if (itr->second->HasPlayer(player))
        return;

    itr->second->HandlePlayerEnterZone(player, zoneid);
    LOG_DEBUG("outdoorpvp", "Player {} entered outdoorpvp id {}", player->GetGUID().ToString(), itr->second->GetTypeId());
}

void OutdoorPvPMgr::HandlePlayerLeaveZone(Player* player, uint32 zoneid)
{
    auto itr = m_OutdoorPvPMap.find(zoneid);
    if (itr == m_OutdoorPvPMap.end())
        return;

    std::lock_guard<std::mutex> guard(_lock); // pussywizard

    // teleport: remove once in removefromworld, once in updatezone
    if (!itr->second->HasPlayer(player))
        return;

    itr->second->HandlePlayerLeaveZone(player, zoneid);
    LOG_DEBUG("outdoorpvp", "Player {} left outdoorpvp id {}", player->GetGUID().ToString(), itr->second->GetTypeId());
}

OutdoorPvP* OutdoorPvPMgr::GetOutdoorPvPToZoneId(uint32 zoneid)
{
    auto itr = m_OutdoorPvPMap.find(zoneid);
    if (itr == m_OutdoorPvPMap.end())
    {
        // no handle for this zone, return
        return nullptr;
    }

    return itr->second;
}

void OutdoorPvPMgr::Update(uint32 diff)
{
    m_UpdateTimer += diff;

    if (m_UpdateTimer > OUTDOORPVP_OBJECTIVE_UPDATE_INTERVAL)
    {
        for (auto const& itr : m_OutdoorPvPSet)
        {
            itr->Update(m_UpdateTimer);
        }

        m_UpdateTimer = 0;
    }
}

bool OutdoorPvPMgr::HandleCustomSpell(Player* player, uint32 spellId, GameObject* go)
{
    // pussywizard: no mutex because not affecting other players
    for (auto& itr : m_OutdoorPvPSet)
    {
        if (itr->HandleCustomSpell(player, spellId, go))
        {
            return true;
        }
    }

    return false;
}

ZoneScript* OutdoorPvPMgr::GetZoneScript(uint32 zoneId)
{
    auto itr = m_OutdoorPvPMap.find(zoneId);
    if (itr != m_OutdoorPvPMap.end())
    {
        return itr->second;
    }

    return nullptr;
}

bool OutdoorPvPMgr::HandleOpenGo(Player* player, GameObject* go)
{
    std::lock_guard<std::mutex> guard(_lock); // pussywizard

    for (auto& itr : m_OutdoorPvPSet)
    {
        if (itr->HandleOpenGo(player, go))
        {
            return true;
        }
    }

    return false;
}

void OutdoorPvPMgr::HandleGossipOption(Player* player, Creature* creature, uint32 gossipid)
{
    std::lock_guard<std::mutex> guard(_lock); // pussywizard

    for (auto& itr : m_OutdoorPvPSet)
    {
        if (itr->HandleGossipOption(player, creature, gossipid))
        {
            return;
        }
    }
}

bool OutdoorPvPMgr::CanTalkTo(Player* player, Creature* creature, GossipMenuItems const& gso)
{
    for (auto& itr : m_OutdoorPvPSet)
    {
        if (itr->CanTalkTo(player, creature, gso))
        {
            return true;
        }
    }

    return false;
}

void OutdoorPvPMgr::HandleDropFlag(Player* player, uint32 spellId)
{
    // pussywizard: no mutex because not affecting other players
    for (auto& itr : m_OutdoorPvPSet)
    {
        if (itr->HandleDropFlag(player, spellId))
        {
            return;
        }
    }
}

void OutdoorPvPMgr::HandlePlayerResurrects(Player* player, uint32 zoneid)
{
    auto itr = m_OutdoorPvPMap.find(zoneid);
    if (itr == m_OutdoorPvPMap.end())
        return;

    // pussywizard: no mutex because not affecting other players

    if (itr->second->HasPlayer(player))
    {
        itr->second->HandlePlayerResurrects(player, zoneid);
    }
}
