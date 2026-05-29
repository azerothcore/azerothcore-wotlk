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

#include "BattlefieldMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Zones/BattlefieldWG.h"

BattlefieldMgr::BattlefieldMgr() : _updateTimer(0)
{
}

BattlefieldMgr::~BattlefieldMgr()
{
    for (Battlefield* bf : _battlefieldSet)
        delete bf;
}

BattlefieldMgr* BattlefieldMgr::instance()
{
    static BattlefieldMgr instance;
    return &instance;
}

void BattlefieldMgr::InitBattlefield()
{
    if (sWorld->getIntConfig(CONFIG_WINTERGRASP_ENABLE) == 2)
    {
        LOG_INFO("server.loading", "Battlefield: Wintergrasp is disabled.");
        LOG_INFO("server.loading", " ");
        return;
    }
    Battlefield* bf = new BattlefieldWG;
    // respawn, init variables
    if (!bf->SetupBattlefield())
    {
        LOG_ERROR("server.loading", "Battlefield: Wintergrasp init failed.");
        LOG_INFO("server.loading", " ");
        delete bf;
    }
    else
    {
        _battlefieldSet.push_back(bf);
        LOG_INFO("server.loading", "Battlefield: Wintergrasp successfully initiated.");
        LOG_INFO("server.loading", " ");
    }
}

void BattlefieldMgr::AddZone(uint32 zoneId, Battlefield* handle)
{
    _battlefieldMap[zoneId] = handle;
}

void BattlefieldMgr::HandlePlayerEnterZone(Player* player, uint32 zoneId)
{
    auto itr = _battlefieldMap.find(zoneId);
    if (itr == _battlefieldMap.end())
        return;

    if (itr->second->HasPlayer(player) || !itr->second->IsEnabled())
        return;

    itr->second->HandlePlayerEnterZone(player, zoneId);
    LOG_DEBUG("bg.battlefield", "Player {} entered outdoorpvp id {}", player->GetGUID().ToString(), itr->second->GetTypeId());
}

void BattlefieldMgr::HandlePlayerLeaveZone(Player* player, uint32 zoneId)
{
    auto itr = _battlefieldMap.find(zoneId);
    if (itr == _battlefieldMap.end())
        return;

    // teleport: remove once in removefromworld, once in updatezone
    if (!itr->second->HasPlayer(player))
        return;
    sScriptMgr->OnBattlefieldPlayerLeaveZone(itr->second, player);
    itr->second->HandlePlayerLeaveZone(player, zoneId);
    LOG_DEBUG("bg.battlefield", "Player {} left outdoorpvp id {}", player->GetGUID().ToString(), itr->second->GetTypeId());
}

Battlefield* BattlefieldMgr::GetBattlefieldToZoneId(uint32 zoneId)
{
    auto itr = _battlefieldMap.find(zoneId);
    if (itr == _battlefieldMap.end())
        return nullptr;

    if (!itr->second->IsEnabled())
        return nullptr;
    return itr->second;
}

Battlefield* BattlefieldMgr::GetBattlefieldByBattleId(uint32 battleId)
{
    for (Battlefield* bf : _battlefieldSet)
        if (bf->GetBattleId() == battleId)
            return bf;

    return nullptr;
}

void BattlefieldMgr::Update(uint32 diff)
{
    _updateTimer += diff;
    if (_updateTimer > BATTLEFIELD_OBJECTIVE_UPDATE_INTERVAL)
    {
        for (Battlefield* bf : _battlefieldSet)
            bf->Update(_updateTimer);
        _updateTimer = 0;
    }
}

ZoneScript* BattlefieldMgr::GetZoneScript(uint32 zoneId)
{
    auto itr = _battlefieldMap.find(zoneId);
    if (itr != _battlefieldMap.end())
        return itr->second;

    return nullptr;
}
