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

#include "OutdoorPvP.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "Map.h"
#include "MapMgr.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "OutdoorPvPMgr.h"
#include "WorldPacket.h"

OPvPCapturePoint::OPvPCapturePoint(OutdoorPvP* pvp) :
    _pvp(pvp)
{
}

bool OPvPCapturePoint::HandlePlayerEnter(Player* player)
{
    if (_capturePoint)
    {
        player->SendUpdateWorldState(_capturePoint->GetGOInfo()->capturePoint.worldState1, 1);
        player->SendUpdateWorldState(_capturePoint->GetGOInfo()->capturePoint.worldstate2, (uint32)std::ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f));
        player->SendUpdateWorldState(_capturePoint->GetGOInfo()->capturePoint.worldstate3, _neutralValuePct);
    }

    return _activePlayers[player->GetTeamId()].insert(player->GetGUID()).second;
}

void OPvPCapturePoint::HandlePlayerLeave(Player* player)
{
    if (_capturePoint)
    {
        player->SendUpdateWorldState(_capturePoint->GetGOInfo()->capturePoint.worldState1, 0);
    }

    _activePlayers[player->GetTeamId()].erase(player->GetGUID());
}

void OPvPCapturePoint::SendChangePhase()
{
    if (!_capturePoint)
        return;

    // send this too, sometimes the slider disappears, dunno why :(
    SendUpdateWorldState(_capturePoint->GetGOInfo()->capturePoint.worldState1, 1);

    // send these updates to only the ones in this objective
    SendUpdateWorldState(_capturePoint->GetGOInfo()->capturePoint.worldstate2, (uint32)std::ceil((_value + _maxValue) / (2 * _maxValue) * 100.0f));

    // send this too, sometimes it resets :S
    SendUpdateWorldState(_capturePoint->GetGOInfo()->capturePoint.worldstate3, _neutralValuePct);
}

void OPvPCapturePoint::AddGO(uint32 type, ObjectGuid::LowType guid, uint32 entry)
{
    if (!entry)
    {
        const GameObjectData* data = sObjectMgr->GetGameObjectData(guid);
        if (!data)
        {
            return;
        }

        entry = data->id;
    }

    _objects[type] = guid;
    _objectTypes[_objects[type]] = type;
}

void OPvPCapturePoint::AddCre(uint32 type, ObjectGuid::LowType guid, uint32 entry)
{
    if (!entry)
    {
        const CreatureData* data = sObjectMgr->GetCreatureData(guid);
        if (!data)
        {
            return;
        }

        entry = data->id1;
    }

    _creatures[type] = guid;
    _creatureTypes[_creatures[type]] = type;
}

bool OPvPCapturePoint::AddObject(uint32 type, uint32 entry, uint32 map, float x, float y, float z, float o, float rotation0, float rotation1, float rotation2, float rotation3)
{
    if (ObjectGuid::LowType guid = sObjectMgr->AddGOData(entry, map, x, y, z, o, 0, rotation0, rotation1, rotation2, rotation3))
    {
        AddGO(type, guid, entry);
        return true;
    }

    return false;
}

bool OPvPCapturePoint::AddCreature(uint32 type, uint32 entry, uint32 map, float x, float y, float z, float o, uint32 spawntimeDelay)
{
    if (ObjectGuid::LowType guid = sObjectMgr->AddCreData(entry, map, x, y, z, o, spawntimeDelay))
    {
        AddCre(type, guid, entry);
        return true;
    }

    return false;
}

bool OPvPCapturePoint::SetCapturePointData(uint32 entry, uint32 map, float x, float y, float z, float o, float rotation0, float rotation1, float rotation2, float rotation3)
{
    LOG_DEBUG("outdoorpvp", "Creating capture point {}", entry);

    // check info existence
    GameObjectTemplate const* goinfo = sObjectMgr->GetGameObjectTemplate(entry);
    if (!goinfo || goinfo->type != GAMEOBJECT_TYPE_CAPTURE_POINT)
    {
        LOG_ERROR("outdoorpvp", "OutdoorPvP: GO {} is not capture point!", entry);
        return false;
    }

    m_capturePointSpawnId = sObjectMgr->AddGOData(entry, map, x, y, z, o, 0, rotation0, rotation1, rotation2, rotation3);
    if (!m_capturePointSpawnId)
        return false;

    // get the needed values from goinfo
    _maxValue = (float)goinfo->capturePoint.maxTime;
    _maxSpeed = _maxValue / float(goinfo->capturePoint.minTime ? goinfo->capturePoint.minTime : 60);
    _neutralValuePct = goinfo->capturePoint.neutralPercent;
    _minValue = CalculatePct(_maxValue, _neutralValuePct);
    return true;
}

bool OPvPCapturePoint::DelCreature(uint32 type)
{
    ObjectGuid::LowType spawnId = _creatures[type];
    if (!spawnId)
    {
        LOG_DEBUG("outdoorpvp", "OutdoorPvP: Creature type {} was already deleted", type);
        return false;
    }

    auto bounds = _pvp->GetMap()->GetCreatureBySpawnIdStore().equal_range(spawnId);
    for (auto itr = bounds.first; itr != bounds.second;)
    {
        // can happen when closing the core
        Creature* c = itr->second;
        ++itr;

        // Don't save respawn time
        c->SetRespawnTime(0);
        c->RemoveCorpse();
        c->AddObjectToRemoveList();
    }

    LOG_DEBUG("outdoorpvp", "OutdoorPvP: Deleting creature type {}", type);

    // explicit removal from map
    // beats me why this is needed, but with the recent removal "cleanup" some creatures stay in the map if "properly" deleted
    // so this is a big fat workaround, if AddObjectToRemoveList and DoDelayedMovesAndRemoves worked correctly, this wouldn't be needed
    //if (Map* map = sMapMgr->FindMap(cr->GetMapId()))
    //    map->Remove(cr, false);
    // delete respawn time for this creature
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CREATURE_RESPAWN);
    stmt->SetData(0, spawnId);
    stmt->SetData(1, _pvp->GetMap()->GetId());
    stmt->SetData(2, 0);  // instance id, always 0 for world maps
    CharacterDatabase.Execute(stmt);

    sObjectMgr->DeleteCreatureData(spawnId);
    _creatureTypes[_creatures[type]] = 0;
    _creatures[type] = 0;
    return true;
}

bool OPvPCapturePoint::DelObject(uint32 type)
{
    ObjectGuid::LowType spawnId = _objects[type];
    if (!spawnId)
        return false;

    auto bounds = _pvp->GetMap()->GetGameObjectBySpawnIdStore().equal_range(spawnId);
    for (auto itr = bounds.first; itr != bounds.second;)
    {
        GameObject* go = itr->second;
        ++itr;
        // Don't save respawn time
        go->SetRespawnTime(0);
        go->Delete();
    }

    sObjectMgr->DeleteGOData(spawnId);
    _objectTypes[_objects[type]] = 0;
    _objects[type] = 0;
    return true;
}

bool OPvPCapturePoint::DelCapturePoint()
{
    sObjectMgr->DeleteGOData(m_capturePointSpawnId);
    m_capturePointSpawnId = 0;

    if (_capturePoint)
    {
        _capturePoint->SetRespawnTime(0);                                 // not save respawn time
        _capturePoint->Delete();
    }

    return true;
}

void OPvPCapturePoint::DeleteSpawns()
{
    for (auto const& [type, guid] : _objects)
    {
        DelObject(type);
    }

    for (auto const& [type, guid] : _creatures)
    {
        DelCreature(type);
    }

    DelCapturePoint();
}

void OutdoorPvP::DeleteSpawns()
{
    // Remove script from any registered gameobjects/creatures
    for (auto& itr : _goScriptStore)
    {
        if (GameObject* go = itr.second)
            go->ClearZoneScript();
    }

    _goScriptStore.clear();

    for (auto& itr : _creatureScriptStore)
    {
        if (Creature* creature = itr.second)
            creature->ClearZoneScript();
    }

    _creatureScriptStore.clear();

    for (auto& capturePoint : _capturePoints)
    {
        capturePoint.second->DeleteSpawns();
        delete capturePoint.second;
    }

    _capturePoints.clear();
}

OutdoorPvP::~OutdoorPvP()
{
    DeleteSpawns();
}

void OutdoorPvP::HandlePlayerEnterZone(Player* player, uint32 /*zone*/)
{
    _players[player->GetTeamId()].insert(player->GetGUID());
}

void OutdoorPvP::HandlePlayerLeaveZone(Player* player, uint32 /*zone*/)
{
    // inform the objectives of the leaving
    for (auto& _capturePoint : _capturePoints)
    {
        _capturePoint.second->HandlePlayerLeave(player);
    }

    // remove the world state information from the player (we can't keep everyone up to date, so leave out those who are not in the concerning zones)
    if (!player->GetSession()->PlayerLogout())
    {
        SendRemoveWorldStates(player);
    }

    _players[player->GetTeamId()].erase(player->GetGUID());
    LOG_DEBUG("outdoorpvp", "OutdoorPvP: Player {} left an outdoorpvp zone", player->GetName());
}

void OutdoorPvP::HandlePlayerResurrects(Player* /*player*/, uint32 /*zone*/)
{

}

bool OutdoorPvP::Update(uint32 diff)
{
    bool objective_changed = false;
    for (auto& capturePoint : _capturePoints)
    {
        if (capturePoint.second->Update(diff))
            objective_changed = true;
    }

    return objective_changed;
}

bool OPvPCapturePoint::Update(uint32 diff)
{
    if (!_capturePoint)
        return false;

    auto radius = (float)_capturePoint->GetGOInfo()->capturePoint.radius;

    for (auto const& activePlayer : _activePlayers)
    {
        for (auto itr = activePlayer.begin(); itr != activePlayer.end();)
        {
            ObjectGuid playerGuid = *itr;
            ++itr;

            if (Player* player = ObjectAccessor::FindPlayer(playerGuid))
                if (!_capturePoint->IsWithinDistInMap(player, radius) || !player->IsOutdoorPvPActive())
                    HandlePlayerLeave(player);
        }
    }

    std::list<Player*> players;
    Acore::AnyPlayerInObjectRangeCheck checker(_capturePoint, radius);
    Acore::PlayerListSearcher<Acore::AnyPlayerInObjectRangeCheck> searcher(_capturePoint, players, checker);
    Cell::VisitWorldObjects(_capturePoint, searcher, radius);

    for (auto& itr : players)
    {
        Player* const player = itr;
        if (player->IsOutdoorPvPActive())
        {
            if (_activePlayers[player->GetTeamId()].insert(player->GetGUID()).second)
                HandlePlayerEnter(itr);
        }
    }

    // get the difference of numbers
    float factDiff = ((float)_activePlayers[0].size() - (float)_activePlayers[1].size()) * float(diff) / OUTDOORPVP_OBJECTIVE_UPDATE_INTERVAL;
    if (factDiff == 0.f)
        return false;

    //npcbots - count bots as players but 2 times less affect and only if there is a players difference
    uint32 botsCount[2];

    for (uint8 team = 0; team != 2; ++team)
    {
        botsCount[team] = 0;

        for (GuidSet::iterator itr = _activePlayers[team].begin(); itr != _activePlayers[team].end(); ++itr)
        {
            if (Player* player = ObjectAccessor::FindPlayer(*itr))
                botsCount[team] += player->GetNpcBotsCount();
        }
    }

    factDiff += 0.5f * ((float)botsCount[0] - (float)botsCount[1]) * diff / OUTDOORPVP_OBJECTIVE_UPDATE_INTERVAL;
    //end npcbot

    TeamId ChallengerId = TEAM_NEUTRAL;
    float maxDiff = _maxSpeed * float(diff);

    if (factDiff < 0.f)
    {
        // horde is in majority, but it's already horde-controlled -> no change
        if (_state == OBJECTIVESTATE_HORDE && _value <= -_maxValue)
            return false;

        if (factDiff < -maxDiff)
            factDiff = -maxDiff;

        ChallengerId = TEAM_HORDE;
    }
    else
    {
        // ally is in majority, but it's already ally-controlled -> no change
        if (_state == OBJECTIVESTATE_ALLIANCE && _value >= _maxValue)
            return false;

        if (factDiff > maxDiff)
            factDiff = maxDiff;

        ChallengerId = TEAM_ALLIANCE;
    }

    float oldValue = _value;
    TeamId oldTeam = _team;

    _oldState = _state;
    _value += factDiff;

    if (_value < -_minValue) // red
    {
        if (_value < -_maxValue)
        {
            _value = -_maxValue;
        }

        _state = OBJECTIVESTATE_HORDE;
        _team = TEAM_HORDE;
    }
    else if (_value > _minValue) // blue
    {
        if (_value > _maxValue)
        {
            _value = _maxValue;
        }

        _state = OBJECTIVESTATE_ALLIANCE;
        _team = TEAM_ALLIANCE;
    }
    else if (oldValue * _value <= 0) // grey, go through mid-point
    {
        // if challenger is ally, then n->a challenge
        if (ChallengerId == TEAM_ALLIANCE)
        {
            _state = OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE;
        }
        else if (ChallengerId == TEAM_HORDE) // if challenger is horde, then n->h challenge
        {
            _state = OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE;
        }

        _team = TEAM_NEUTRAL;
    }
    else // grey, did not go through mid-point
    {
        // old phase and current are on the same side, so one team challenges the other
        if (ChallengerId == TEAM_ALLIANCE && (_oldState == OBJECTIVESTATE_HORDE || _oldState == OBJECTIVESTATE_NEUTRAL_HORDE_CHALLENGE))
        {
            _state = OBJECTIVESTATE_HORDE_ALLIANCE_CHALLENGE;
        }
        else if (ChallengerId == TEAM_HORDE && (_oldState == OBJECTIVESTATE_ALLIANCE || _oldState == OBJECTIVESTATE_NEUTRAL_ALLIANCE_CHALLENGE))
        {
            _state = OBJECTIVESTATE_ALLIANCE_HORDE_CHALLENGE;
        }

        _team = TEAM_NEUTRAL;
    }

    if (_value != oldValue)
    {
        SendChangePhase();
    }

    if (_oldState != _state)
    {
        if (oldTeam != _team)
        {
            ChangeTeam(oldTeam);
        }

        ChangeState();
        return true;
    }

    return false;
}

void OutdoorPvP::SendUpdateWorldState(uint32 field, uint32 value)
{
    if (_sendUpdate)
        for (auto const& _player : _players)
            for (auto itr : _player)
                if (Player* const player = ObjectAccessor::FindPlayer(itr))
                    player->SendUpdateWorldState(field, value);
}

void OPvPCapturePoint::SendUpdateWorldState(uint32 field, uint32 value)
{
    for (auto const& activePlayer : _activePlayers)
    {
        // send to all players present in the area
        for (auto itr : activePlayer)
            if (Player* const player = ObjectAccessor::FindPlayer(itr))
                player->SendUpdateWorldState(field, value);
    }
}

void OPvPCapturePoint::SendObjectiveComplete(uint32 id, ObjectGuid guid)
{
    uint32 team;
    switch (_state)
    {
        case OBJECTIVESTATE_ALLIANCE:
            team = 0;
            break;
        case OBJECTIVESTATE_HORDE:
            team = 1;
            break;
        default:
            return;
    }

    // send to all players present in the area
    for (auto itr : _activePlayers[team])
        if (Player* const player = ObjectAccessor::FindPlayer(itr))
            player->KilledMonsterCredit(id, guid);
}

void OutdoorPvP::HandleKill(Player* killer, Unit* killed)
{
    ASSERT(killer);

    if (Group* group = killer->GetGroup())
    {
        for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* groupGuy = itr->GetSource();
            if (!groupGuy)
                continue;

            // skip if too far away
            if (!groupGuy->IsAtGroupRewardDistance(killed) && killer != groupGuy)
                continue;

            // creature kills must be notified, even if not inside objective / not outdoor pvp active
            // player kills only count if active and inside objective
            if ((groupGuy->IsOutdoorPvPActive() && IsInsideObjective(groupGuy)) || killed->IsCreature())
            {
                HandleKillImpl(groupGuy, killed);
            }
        }
    }
    else
    {
        // creature kills must be notified, even if not inside objective / not outdoor pvp active
        if ((killer->IsOutdoorPvPActive() && IsInsideObjective(killer)) || killed->IsCreature())
        {
            HandleKillImpl(killer, killed);
        }
    }
}

bool OutdoorPvP::IsInsideObjective(Player* player) const
{
    for (auto& capturePoint : _capturePoints)
        if (capturePoint.second->IsInsideObjective(player))
            return true;

    return false;
}

bool OPvPCapturePoint::IsInsideObjective(Player* player) const
{
    PlayerSet const& plSet = _activePlayers[player->GetTeamId()];
    return plSet.find(player->GetGUID()) != plSet.end();
}

bool OutdoorPvP::HandleCustomSpell(Player* player, uint32 spellId, GameObject* go)
{
    for (auto& capturePoint : _capturePoints)
        if (capturePoint.second->HandleCustomSpell(player, spellId, go))
            return true;

    return false;
}

bool OPvPCapturePoint::HandleCustomSpell(Player* /*player*/, uint32 /*spellId*/, GameObject* /*go*/)
{
    return false;
}

bool OutdoorPvP::HandleOpenGo(Player* player, GameObject* go)
{
    for (auto& capturePoint : _capturePoints)
        if (capturePoint.second->HandleOpenGo(player, go) >= 0)
            return true;

    return false;
}

bool OutdoorPvP::HandleGossipOption(Player* player, Creature* creature, uint32 id)
{
    for (auto& capturePoint : _capturePoints)
        if (capturePoint.second->HandleGossipOption(player, creature, id))
            return true;

    return false;
}

bool OutdoorPvP::CanTalkTo(Player* player, Creature* c, GossipMenuItems const& gso)
{
    for (auto& capturePoint : _capturePoints)
        if (capturePoint.second->CanTalkTo(player, c, gso))
            return true;

    return false;
}

bool OutdoorPvP::HandleDropFlag(Player* player, uint32 id)
{
    for (auto& capturePoint : _capturePoints)
        if (capturePoint.second->HandleDropFlag(player, id))
            return true;

    return false;
}

bool OPvPCapturePoint::HandleGossipOption(Player* /*player*/, Creature* /*creature*/, uint32 /*id*/)
{
    return false;
}

bool OPvPCapturePoint::CanTalkTo(Player* /*player*/, Creature* /*c*/, GossipMenuItems const& /*gso*/)
{
    return false;
}

bool OPvPCapturePoint::HandleDropFlag(Player* /*player*/, uint32 /*id*/)
{
    return false;
}

int32 OPvPCapturePoint::HandleOpenGo(Player* /*player*/, GameObject* go)
{
    auto const itr = _objectTypes.find(go->GetSpawnId());
    if (itr != _objectTypes.end())
    {
        return (int32)itr->second;
    }

    return -1;
}

void OPvPCapturePoint::SetSlider(float slider)
{
    _value = std::clamp<float>(slider, -_maxValue, _maxValue);
}

bool OutdoorPvP::HandleAreaTrigger(Player* /*player*/, uint32 /*trigger*/)
{
    return false;
}

void OutdoorPvP::BroadcastPacket(WorldPacket& data) const
{
    // This is faster than sWorld->SendZoneMessage
    for (auto const& playerSet : _players)
        for (auto itr : playerSet)
            if (Player* const player = ObjectAccessor::FindPlayer(itr))
                player->GetSession()->SendPacket(&data);
}

void OutdoorPvP::RegisterZone(uint32 zoneId)
{
    sOutdoorPvPMgr->AddZone(zoneId, this);
}

bool OutdoorPvP::HasPlayer(Player const* player) const
{
    PlayerSet const& plSet = _players[player->GetTeamId()];
    return plSet.find(player->GetGUID()) != plSet.end();
}

void OutdoorPvP::TeamCastSpell(TeamId team, int32 spellId, Player* sameMapPlr)
{
    if (spellId > 0)
    {
        for (auto itr : _players[team])
            if (Player* const player = ObjectAccessor::FindPlayer(itr))
                if (!sameMapPlr || sameMapPlr->FindMap() == player->FindMap())
                    player->CastSpell(player, (uint32)spellId, true);
    }
    else
    {
        for (auto itr : _players[team])
            if (Player* const player = ObjectAccessor::FindPlayer(itr))
                if (!sameMapPlr || sameMapPlr->FindMap() == player->FindMap())
                    player->RemoveAura((uint32) - spellId); // by stack?
    }
}

void OutdoorPvP::TeamApplyBuff(TeamId teamId, uint32 spellId, uint32 spellId2, Player* sameMapPlr)
{
    TeamCastSpell(teamId, (int32)spellId, sameMapPlr);
    TeamCastSpell(teamId == TEAM_ALLIANCE ? TEAM_HORDE : TEAM_ALLIANCE, spellId2 ? -(int32)spellId2 : -(int32)spellId, sameMapPlr);
}

void OutdoorPvP::OnGameObjectCreate(GameObject* go)
{
    GoScriptPair sp(go->GetGUID().GetCounter(), go);
    _goScriptStore.insert(sp);

    if (go->GetGoType() != GAMEOBJECT_TYPE_CAPTURE_POINT)
    {
        return;
    }

    if (OPvPCapturePoint* cp = GetCapturePoint(go->GetSpawnId()))
    {
        cp->_capturePoint = go;
    }
}

void OutdoorPvP::OnGameObjectRemove(GameObject* go)
{
    _goScriptStore.erase(go->GetGUID().GetCounter());

    if (go->GetGoType() != GAMEOBJECT_TYPE_CAPTURE_POINT)
    {
        return;
    }

    if (OPvPCapturePoint* cp = GetCapturePoint(go->GetSpawnId()))
    {
        cp->_capturePoint = nullptr;
    }
}

void OutdoorPvP::OnCreatureCreate(Creature* creature)
{
    CreatureScriptPair sp(creature->GetGUID().GetCounter(), creature);
    _creatureScriptStore.insert(sp);
}

void OutdoorPvP::OnCreatureRemove(Creature* creature)
{
    _creatureScriptStore.erase(creature->GetGUID().GetCounter());
}

void OutdoorPvP::SetMapFromZone(uint32 zone)
{
    AreaTableEntry const* areaTable = sAreaTableStore.LookupEntry(zone);
    ASSERT(areaTable);

    Map* map = sMapMgr->CreateBaseMap(areaTable->mapid);
    ASSERT(!map->Instanceable());
    _map = map;
}

OPvPCapturePoint* OutdoorPvP::GetCapturePoint(ObjectGuid::LowType spawnId) const
{
    auto const itr = _capturePoints.find(spawnId);
    if (itr != _capturePoints.end())
    {
        return itr->second;
    }

    return nullptr;
}
