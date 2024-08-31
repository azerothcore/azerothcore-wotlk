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

#include "Transport.h"
#include "Cell.h"
#include "CellImpl.h"
#include "Common.h"
#include "DBCStores.h"
#include "GameObjectAI.h"
#include "GameTime.h"
#include "MapMgr.h"
#include "MapReference.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "Vehicle.h"
#include "WorldModel.h"

MotionTransport::MotionTransport() : Transport(), _transportInfo(nullptr), _isMoving(true), _pendingStop(false), _triggeredArrivalEvent(false), _triggeredDepartureEvent(false), _passengersLoaded(false), _delayedTeleport(false)
{
    m_updateFlag = UPDATEFLAG_TRANSPORT | UPDATEFLAG_LOWGUID | UPDATEFLAG_STATIONARY_POSITION | UPDATEFLAG_ROTATION;
}

MotionTransport::~MotionTransport()
{
    HashMapHolder<MotionTransport>::Remove(this);

    ASSERT(_passengers.empty());
    UnloadStaticPassengers();
}

bool MotionTransport::CreateMoTrans(ObjectGuid::LowType guidlow, uint32 entry, uint32 mapid, float x, float y, float z, float ang, uint32 animprogress)
{
    Relocate(x, y, z, ang);

    if (!IsPositionValid())
    {
        LOG_ERROR("entities.transport", "Transport (GUID: {}) not created. Suggested coordinates isn't valid (X: {} Y: {})",
                       guidlow, x, y);
        return false;
    }

    Object::_Create(guidlow, 0, HighGuid::Mo_Transport);

    GameObjectTemplate const* goinfo = sObjectMgr->GetGameObjectTemplate(entry);

    if (!goinfo)
    {
        LOG_ERROR("entities.transport", "Transport not created: entry in `gameobject_template` not found, guidlow: {} map: {}  (X: {} Y: {} Z: {}) ang: {}", guidlow, mapid, x, y, z, ang);
        return false;
    }

    m_goInfo = goinfo;

    TransportTemplate const* tInfo = sTransportMgr->GetTransportTemplate(entry);
    if (!tInfo)
    {
        LOG_ERROR("entities.transport", "Transport {} (name: {}) will not be created, missing `transport_template` entry.", entry, goinfo->name);
        return false;
    }

    _transportInfo = tInfo;

    // initialize waypoints
    _nextFrame = tInfo->keyFrames.begin();
    _currentFrame = _nextFrame++;
    _triggeredArrivalEvent = false;
    _triggeredDepartureEvent = false;

    if (GameObjectTemplateAddon const* addon = GetTemplateAddon())
    {
        SetUInt32Value(GAMEOBJECT_FACTION, addon->faction);
        ReplaceAllGameObjectFlags((GameObjectFlags)addon->flags);
    }

    SetObjectScale(goinfo->size);
    SetPathProgress(0);
    SetPeriod(tInfo->pathTime);
    SetEntry(goinfo->entry);
    SetDisplayId(goinfo->displayId);
    SetGoState(!goinfo->moTransport.canBeStopped ? GO_STATE_READY : GO_STATE_ACTIVE);
    SetGoType(GAMEOBJECT_TYPE_MO_TRANSPORT);
    SetGoAnimProgress(animprogress);
    SetName(goinfo->name);

    // pussywizard: no WorldRotation for MotionTransports
    SetLocalRotation(G3D::Quat());
    // pussywizard: no PathRotation for MotionTransports
    SetTransportPathRotation(0.0f, 0.0f, 0.0f, 1.0f);

    m_model = CreateModel();

    return true;
}

void MotionTransport::CleanupsBeforeDelete(bool finalCleanup /*= true*/)
{
    UnloadStaticPassengers();
    while (!_passengers.empty())
    {
        WorldObject* obj = *_passengers.begin();
        RemovePassenger(obj);
        obj->SetTransport(nullptr);
        obj->m_movementInfo.transport.Reset();
        obj->m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
    }

    GameObject::CleanupsBeforeDelete(finalCleanup);
}

void MotionTransport::BuildUpdate(UpdateDataMapType& data_map, UpdatePlayerSet&)
{
    Map::PlayerList const& players = GetMap()->GetPlayers();
    if (players.IsEmpty())
        return;

    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
        BuildFieldsUpdate(itr->GetSource(), data_map);

    ClearUpdateMask(true);
}

void MotionTransport::Update(uint32 diff)
{
    uint32 const positionUpdateDelay = 1;

    if (AI())
        AI()->UpdateAI(diff);
    else if (!AIM_Initialize())
        LOG_ERROR("entities.transport", "Could not initialize GameObjectAI for Transport");

    if (GetKeyFrames().size() <= 1)
        return;

    if (IsMoving() || !_pendingStop)
        SetPathProgress(GetPathProgress() + diff);

    uint32 timer = GetPathProgress() % GetPeriod();

    // Set current waypoint
    // Desired outcome: _currentFrame->DepartureTime < timer < _nextFrame->ArriveTime
    // ... arrive | ... delay ... | departure
    //      event /         event /
    for (;;)
    {
        if (timer >= _currentFrame->ArriveTime)
        {
            if (!_triggeredArrivalEvent)
            {
                DoEventIfAny(*_currentFrame, false);
                _triggeredArrivalEvent = true;
            }

            if (timer < _currentFrame->DepartureTime)
            {
                SetMoving(false);
                if (_pendingStop && GetGoState() != GO_STATE_READY)
                {
                    SetGoState(GO_STATE_READY);
                    SetPathProgress(GetPathProgress() / GetPeriod());
                    SetPathProgress(GetPathProgress() * GetPeriod());
                    SetPathProgress(GetPathProgress() + _currentFrame->ArriveTime);
                }
                break;  // its a stop frame and we are waiting
            }
        }

        if (timer >= _currentFrame->DepartureTime && !_triggeredDepartureEvent)
        {
            DoEventIfAny(*_currentFrame, true); // departure event
            _triggeredDepartureEvent = true;
        }

        // not waiting anymore
        SetMoving(true);

        // Enable movement
        if (GetGOInfo()->moTransport.canBeStopped)
            SetGoState(GO_STATE_ACTIVE);

        if (timer >= _currentFrame->DepartureTime && timer < _currentFrame->NextArriveTime)
            break;  // found current waypoint

        MoveToNextWaypoint();

        sScriptMgr->OnRelocate(this, _currentFrame->Node->index, _currentFrame->Node->mapid, _currentFrame->Node->x, _currentFrame->Node->y, _currentFrame->Node->z);

        //LOG_DEBUG("entities.transport", "Transport {} ({}) moved to node {} {} {} {} {}", GetEntry(), GetName(), _currentFrame->Node->index, _currentFrame->Node->mapid, _currentFrame->Node->x, _currentFrame->Node->y, _currentFrame->Node->z);

        // Departure event
        if (_currentFrame->IsTeleportFrame())
            if (TeleportTransport(_nextFrame->Node->mapid, _nextFrame->Node->x, _nextFrame->Node->y, _nextFrame->Node->z, _nextFrame->InitialOrientation))
                return; // Update more in new map thread
    }

    // Set position
    _positionChangeTimer.Update(diff);
    if (_positionChangeTimer.Passed())
    {
        _positionChangeTimer.Reset(positionUpdateDelay);
        if (IsMoving())
        {
            float t = CalculateSegmentPos(float(timer) * 0.001f);
            G3D::Vector3 pos, dir;
            _currentFrame->Spline->evaluate_percent(_currentFrame->Index, t, pos);
            _currentFrame->Spline->evaluate_derivative(_currentFrame->Index, t, dir);
            UpdatePosition(pos.x, pos.y, pos.z, NormalizeOrientation(std::atan2(dir.y, dir.x) + M_PI));
        }
        else
        {
            /* There are four possible scenarios that trigger loading/unloading passengers:
              1. transport moves from inactive to active grid
              2. the grid that transport is currently in becomes active
              3. transport moves from active to inactive grid
              4. the grid that transport is currently in unloads
            */
            if (_staticPassengers.empty() && GetMap()->IsGridLoaded(GetPositionX(), GetPositionY())) // 2.
                LoadStaticPassengers();
        }
    }

    sScriptMgr->OnTransportUpdate(this, diff);
}

void MotionTransport::DelayedUpdate(uint32  /*diff*/)
{
    if (GetKeyFrames().size() <= 1)
        return;

    DelayedTeleportTransport();
}

void MotionTransport::UpdatePosition(float x, float y, float z, float o)
{
    if (!GetMap()->IsGridLoaded(x, y)) // pussywizard: should not happen, but just in case
        GetMap()->LoadGrid(x, y);

    Relocate(x, y, z, o);
    UpdateModelPosition();

    UpdatePassengerPositions(_passengers);

    if (_staticPassengers.empty())
        LoadStaticPassengers();
    else
        UpdatePassengerPositions(_staticPassengers);
}

void MotionTransport::AddPassenger(WorldObject* passenger, bool withAll)
{
    std::lock_guard<std::mutex> guard(Lock);
    if (_passengers.insert(passenger).second)
    {
        if (Player* plr = passenger->ToPlayer())
            sScriptMgr->OnAddPassenger(ToTransport(), plr);

        if (withAll)
        {
            if (Transport* t = passenger->GetTransport()) // SHOULD NEVER HAPPEN
                t->RemovePassenger(passenger, false);

            float x, y, z, o;
            passenger->GetPosition(x, y, z, o);
            CalculatePassengerOffset(x, y, z, &o);

            passenger->SetTransport(this);
            passenger->m_movementInfo.flags |= MOVEMENTFLAG_ONTRANSPORT;
            passenger->m_movementInfo.transport.guid = GetGUID();
            passenger->m_movementInfo.transport.pos.Relocate(x, y, z, o);
            if (passenger->ToUnit())
            {
                passenger->ToUnit()->AddUnitState(UNIT_STATE_IGNORE_PATHFINDING);
            }
        }
    }
}

void MotionTransport::RemovePassenger(WorldObject* passenger, bool withAll)
{
    std::lock_guard<std::mutex> guard(Lock);
    if (_passengers.erase(passenger) || _staticPassengers.erase(passenger))
    {
        if (Player* plr = passenger->ToPlayer())
        {
            sScriptMgr->OnRemovePassenger(ToTransport(), plr);
            plr->SetFallInformation(GameTime::GetGameTime().count(), plr->GetPositionZ());
        }

        if (withAll)
        {
            passenger->SetTransport(nullptr);
            passenger->m_movementInfo.flags &= ~MOVEMENTFLAG_ONTRANSPORT;
            passenger->m_movementInfo.transport.guid.Clear();
            passenger->m_movementInfo.transport.pos.Relocate(0.0f, 0.0f, 0.0f, 0.0f);
            if (passenger->ToUnit())
            {
                passenger->ToUnit()->ClearUnitState(UNIT_STATE_IGNORE_PATHFINDING);
            }
        }
    }
}

Creature* MotionTransport::CreateNPCPassenger(ObjectGuid::LowType guid, CreatureData const* data)
{
    Map* map = GetMap();
    Creature* creature = new Creature();

    if (!creature->LoadCreatureFromDB(guid, map, false))
    {
        delete creature;
        return nullptr;
    }

    float x = data->posX;
    float y = data->posY;
    float z = data->posZ;
    float o = data->orientation;

    creature->SetTransport(this);
    creature->AddUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
    creature->m_movementInfo.transport.guid = GetGUID();
    creature->m_movementInfo.transport.pos.Relocate(x, y, z, o);
    CalculatePassengerPosition(x, y, z, &o);
    creature->Relocate(x, y, z, o);
    creature->SetHomePosition(creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ(), creature->GetOrientation());
    creature->SetTransportHomePosition(creature->m_movementInfo.transport.pos);

    /// @HACK - transport models are not added to map's dynamic LoS calculations
    ///         because the current GameObjectModel cannot be moved without recreating
    creature->AddUnitState(UNIT_STATE_IGNORE_PATHFINDING);

    if (!creature->IsPositionValid())
    {
        LOG_ERROR("entities.transport", "Creature ({}) not created. Suggested coordinates aren't valid (X: {} Y: {})",
            creature->GetGUID().ToString(), creature->GetPositionX(), creature->GetPositionY());
        delete creature;
        return nullptr;
    }

    if (!map->AddToMap(creature))
    {
        delete creature;
        return nullptr;
    }

    _staticPassengers.insert(creature);
    sScriptMgr->OnAddCreaturePassenger(this, creature);
    return creature;
}

GameObject* MotionTransport::CreateGOPassenger(ObjectGuid::LowType guid, GameObjectData const* data)
{
    Map* map = GetMap();
    GameObject* go = new GameObject();
    ASSERT(!sObjectMgr->IsGameObjectStaticTransport(data->id));

    if (!go->LoadGameObjectFromDB(guid, map, false))
    {
        delete go;
        return nullptr;
    }

    float x = data->posX;
    float y = data->posY;
    float z = data->posZ;
    float o = data->orientation;

    go->SetTransport(this);
    go->m_movementInfo.transport.guid = GetGUID();
    go->m_movementInfo.transport.pos.Relocate(x, y, z, o);
    CalculatePassengerPosition(x, y, z, &o);
    go->Relocate(x, y, z, o);

    if (!go->IsPositionValid())
    {
        LOG_ERROR("entities.transport", "GameObject ({}) not created. Suggested coordinates aren't valid (X: {} Y: {})",
            go->GetGUID().ToString(), go->GetPositionX(), go->GetPositionY());
        delete go;
        return nullptr;
    }

    if (!map->AddToMap(go))
    {
        delete go;
        return nullptr;
    }

    _staticPassengers.insert(go);
    return go;
}

void MotionTransport::LoadStaticPassengers()
{
    if (PassengersLoaded())
        return;
    SetPassengersLoaded(true);
    if (uint32 mapId = GetGOInfo()->moTransport.mapID)
    {
        CellObjectGuidsMap const& cells = sObjectMgr->GetMapObjectGuids(mapId, GetMap()->GetSpawnMode());
        CellGuidSet::const_iterator guidEnd;
        for (CellObjectGuidsMap::const_iterator cellItr = cells.begin(); cellItr != cells.end(); ++cellItr)
        {
            // Creatures on transport
            guidEnd = cellItr->second.creatures.end();
            for (CellGuidSet::const_iterator guidItr = cellItr->second.creatures.begin(); guidItr != guidEnd; ++guidItr)
                CreateNPCPassenger(*guidItr, sObjectMgr->GetCreatureData(*guidItr));

            // GameObjects on transport
            guidEnd = cellItr->second.gameobjects.end();
            for (CellGuidSet::const_iterator guidItr = cellItr->second.gameobjects.begin(); guidItr != guidEnd; ++guidItr)
                CreateGOPassenger(*guidItr, sObjectMgr->GetGameObjectData(*guidItr));
        }
    }
}

void MotionTransport::UnloadStaticPassengers()
{
    SetPassengersLoaded(false);
    while (!_staticPassengers.empty())
    {
        WorldObject* obj = *_staticPassengers.begin();
        obj->AddObjectToRemoveList();   // also removes from _staticPassengers
    }
}

void MotionTransport::UnloadNonStaticPassengers()
{
    for (PassengerSet::iterator itr = _passengers.begin(); itr != _passengers.end(); )
    {
        if ((*itr)->IsPlayer())
        {
            ++itr;
            continue;
        }
        //npcbot: do not unload bots
        if ((*itr)->IsNPCBotOrPet())
        {
            ++itr;
            continue;
        }
        //end npcbot
        PassengerSet::iterator itr2 = itr++;
        (*itr2)->AddObjectToRemoveList();
    }
}

void MotionTransport::EnableMovement(bool enabled)
{
    if (!GetGOInfo()->moTransport.canBeStopped)
        return;

    _pendingStop = !enabled;
}

void MotionTransport::MoveToNextWaypoint()
{
    // Clear events flagging
    _triggeredArrivalEvent = false;
    _triggeredDepartureEvent = false;

    // Set frames
    _currentFrame = _nextFrame++;
    if (_nextFrame == GetKeyFrames().end())
        _nextFrame = GetKeyFrames().begin();
}

float MotionTransport::CalculateSegmentPos(float now)
{
    KeyFrame const& frame = *_currentFrame;
    const float speed = float(m_goInfo->moTransport.moveSpeed);
    const float accel = float(m_goInfo->moTransport.accelRate);
    float timeSinceStop = frame.TimeFrom + (now - (1.0f / IN_MILLISECONDS) * frame.DepartureTime);
    float timeUntilStop = frame.TimeTo - (now - (1.0f / IN_MILLISECONDS) * frame.DepartureTime);
    float segmentPos, dist;
    float accelTime = _transportInfo->accelTime;
    float accelDist = _transportInfo->accelDist;
    // calculate from nearest stop, less confusing calculation...
    if (timeSinceStop < timeUntilStop)
    {
        if (timeSinceStop < accelTime)
            dist = 0.5f * accel * timeSinceStop * timeSinceStop;
        else
            dist = accelDist + (timeSinceStop - accelTime) * speed;
        segmentPos = dist - frame.DistSinceStop;
    }
    else
    {
        if (timeUntilStop < _transportInfo->accelTime)
            dist = 0.5f * accel * timeUntilStop * timeUntilStop;
        else
            dist = accelDist + (timeUntilStop - accelTime) * speed;
        segmentPos = frame.DistUntilStop - dist;
    }

    return segmentPos / frame.NextDistFromPrev;
}

bool MotionTransport::TeleportTransport(uint32 newMapid, float x, float y, float z, float o)
{
    Map const* oldMap = GetMap();

    if (oldMap->GetId() != newMapid)
    {
        _delayedTeleport = true;
        UnloadStaticPassengers();
        return true;
    }
    else
    {
        // Teleport players, they need to know it
        for (PassengerSet::iterator itr = _passengers.begin(); itr != _passengers.end(); ++itr)
        {
            if ((*itr)->IsPlayer())
            {
                float destX, destY, destZ, destO;
                (*itr)->m_movementInfo.transport.pos.GetPosition(destX, destY, destZ, destO);
                TransportBase::CalculatePassengerPosition(destX, destY, destZ, &destO, x, y, z, o);

                (*itr)->ToUnit()->NearTeleportTo(destX, destY, destZ, destO);
            }
        }

        UpdatePosition(x, y, z, o);
        return false;
    }
}

void MotionTransport::DelayedTeleportTransport()
{
    if (!_delayedTeleport)
        return;

    _delayedTeleport = false;

    uint32 newMapId = _nextFrame->Node->mapid;
    float x = _nextFrame->Node->x,
          y = _nextFrame->Node->y,
          z = _nextFrame->Node->z,
          o = _nextFrame->InitialOrientation;

    PassengerSet _passengersCopy = _passengers;
    for (PassengerSet::iterator itr = _passengersCopy.begin(); itr != _passengersCopy.end(); )
    {
        WorldObject* obj = (*itr++);

        if (_passengers.find(obj) == _passengers.end())
            continue;

        switch (obj->GetTypeId())
        {
            case TYPEID_UNIT:
                //npcbot: do not add bots to transport (handled inside AI)
                if (obj->IsNPCBotOrPet())
                    break;
                //end npcbot
                _passengers.erase(obj);
                if (!obj->ToCreature()->IsPet())
                    obj->ToCreature()->DespawnOrUnsummon();
                break;
            case TYPEID_GAMEOBJECT:
                _passengers.erase(obj);
                obj->ToGameObject()->Delete();
                break;
            case TYPEID_DYNAMICOBJECT:
                _passengers.erase(obj);
                if (Unit* caster = obj->ToDynObject()->GetCaster())
                    if (Spell* s = caster->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
                        if (obj->ToDynObject()->GetSpellId() == s->GetSpellInfo()->Id)
                        {
                            s->SendChannelUpdate(0);
                            s->SendInterrupted(0);
                            caster->RemoveOwnedAura(s->GetSpellInfo()->Id, caster->GetGUID());
                        }
                obj->AddObjectToRemoveList();
                break;
            case TYPEID_PLAYER:
                {
                    float destX, destY, destZ, destO;
                    obj->m_movementInfo.transport.pos.GetPosition(destX, destY, destZ, destO);
                    TransportBase::CalculatePassengerPosition(destX, destY, destZ, &destO, x, y, z, o);
                    if (!obj->ToPlayer()->TeleportTo(newMapId, destX, destY, destZ, destO, TELE_TO_NOT_LEAVE_TRANSPORT))
                        _passengers.erase(obj);
                }
                break;
            default:
                break;
        }
    }

    Map* newMap = sMapMgr->CreateBaseMap(newMapId);
    GetMap()->RemoveFromMap<MotionTransport>(this, false);
    newMap->LoadGrid(x, y); // xinef: load before adding passengers to new map
    SetMap(newMap);

    Relocate(x, y, z, o);
    GetMap()->AddToMap<MotionTransport>(this);

    LoadStaticPassengers();
}

void MotionTransport::UpdatePassengerPositions(PassengerSet& passengers)
{
    for (PassengerSet::iterator itr = passengers.begin(); itr != passengers.end(); ++itr)
    {
        WorldObject* passenger = *itr;
        // transport teleported but passenger not yet (can happen for players)
        if (passenger->GetMap() != GetMap())
            continue;

        // if passenger is on vehicle we have to assume the vehicle is also on transport and its the vehicle that will be updating its passengers
        if (Unit* unit = passenger->ToUnit())
            if (unit->GetVehicle())
                continue;

        // Do not use Unit::UpdatePosition here, we don't want to remove auras as if regular movement occurred
        float x, y, z, o;
        passenger->m_movementInfo.transport.pos.GetPosition(x, y, z, o);
        CalculatePassengerPosition(x, y, z, &o);

        // check if position is valid
        if (!Acore::IsValidMapCoord(x, y, z))
            continue;

        switch (passenger->GetTypeId())
        {
            case TYPEID_UNIT:
                {
                    Creature* creature = passenger->ToCreature();
                    GetMap()->CreatureRelocation(creature, x, y, z, o);

                    creature->GetTransportHomePosition(x, y, z, o);
                    CalculatePassengerPosition(x, y, z, &o);
                    creature->SetHomePosition(x, y, z, o);
                }
                break;
            case TYPEID_PLAYER:
                if (passenger->IsInWorld())
                    GetMap()->PlayerRelocation(passenger->ToPlayer(), x, y, z, o);
                break;
            case TYPEID_GAMEOBJECT:
                GetMap()->GameObjectRelocation(passenger->ToGameObject(), x, y, z, o);
                break;
            case TYPEID_DYNAMICOBJECT:
                GetMap()->DynamicObjectRelocation(passenger->ToDynObject(), x, y, z, o);
                break;
            default:
                break;
        }
    }
}

void MotionTransport::DoEventIfAny(KeyFrame const& node, bool departure)
{
    if (uint32 eventid = departure ? node.Node->departureEventID : node.Node->arrivalEventID)
    {
        //LOG_DEBUG("maps.script", "Taxi {} event {} of node {} of {} path", departure ? "departure" : "arrival", eventid, node.Node->index, GetName());
        GetMap()->ScriptsStart(sEventScripts, eventid, this, this);
        EventInform(eventid);
    }
}

// pussywizard: StaticTransport below

StaticTransport::StaticTransport() : Transport(), _needDoInitialRelocation(false)
{
    m_updateFlag = UPDATEFLAG_TRANSPORT | UPDATEFLAG_LOWGUID | UPDATEFLAG_STATIONARY_POSITION | UPDATEFLAG_ROTATION;
}

StaticTransport::~StaticTransport()
{
    ASSERT(_passengers.empty());
}

bool StaticTransport::Create(ObjectGuid::LowType guidlow, uint32 name_id, Map* map, uint32 phaseMask, float x, float y, float z, float ang, G3D::Quat const& rotation, uint32 animprogress, GOState go_state, uint32 artKit)
{
    ASSERT(map);
    SetMap(map);

    Relocate(x, y, z, ang);
    m_stationaryPosition.Relocate(x, y, z, ang);
    if (!IsPositionValid())
    {
        LOG_ERROR("entities.transport", "Gameobject (GUID: {} Entry: {}) not created. Suggested coordinates isn't valid (X: {} Y: {})", guidlow, name_id, x, y);
        return false;
    }

    SetPhaseMask(phaseMask, false);

    UpdatePositionData();

    SetZoneScript();
    if (m_zoneScript)
    {
        name_id = m_zoneScript->GetGameObjectEntry(guidlow, name_id);
        if (!name_id)
            return false;
    }

    GameObjectTemplate const* goinfo = sObjectMgr->GetGameObjectTemplate(name_id);
    if (!goinfo)
    {
        LOG_ERROR("sql.sql", "Gameobject (GUID: {} Entry: {}) not created: non-existing entry in `gameobject_template`. Map: {} (X: {} Y: {} Z: {})", guidlow, name_id, map->GetId(), x, y, z);
        return false;
    }

    Object::_Create(guidlow, 0, HighGuid::Transport);

    m_goInfo = goinfo;

    if (goinfo->type >= MAX_GAMEOBJECT_TYPE)
    {
        LOG_ERROR("sql.sql", "Gameobject (GUID: {} Entry: {}) not created: non-existing GO type '{}' in `gameobject_template`. It will crash client if created.", guidlow, name_id, goinfo->type);
        return false;
    }

    // pussywizard: temporarily calculate WorldRotation from orientation, do so until values in db are correct
    //SetWorldRotation( /*for StaticTransport we need 2 rotation Quats in db for World- and Path- Rotation*/ );
    SetLocalRotationAngles(NormalizeOrientation(GetOrientation()), 0.0f, 0.0f);
    // pussywizard: PathRotation for StaticTransport (only StaticTransports have PathRotation)
    SetTransportPathRotation(rotation.x, rotation.y, rotation.z, rotation.w);

    SetObjectScale(goinfo->size);

    if (GameObjectTemplateAddon const* addon = GetTemplateAddon())
    {
        SetUInt32Value(GAMEOBJECT_FACTION, addon->faction);
        ReplaceAllGameObjectFlags((GameObjectFlags)addon->flags);
    }

    SetEntry(goinfo->entry);
    SetName(goinfo->name);

    SetDisplayId(goinfo->displayId);

    if (!m_model)
        m_model = CreateModel();

    SetGoType(GameobjectTypes(goinfo->type));
    SetGoState(go_state);
    SetGoArtKit(artKit);

    SetGoState(goinfo->transport.startOpen ? GO_STATE_ACTIVE : GO_STATE_READY);
    SetGoAnimProgress(animprogress);
    m_goValue.Transport.AnimationInfo = sTransportMgr->GetTransportAnimInfo(goinfo->entry);
    //ASSERT(m_goValue.Transport.AnimationInfo);
    if (!m_goValue.Transport.AnimationInfo)
    {
        LOG_ERROR("vehicle", "StaticTransport::Create: No AnimationInfo was found for GameObject entry ({})", goinfo->entry);
        return false;
    }
    //ASSERT(m_goValue.Transport.AnimationInfo->TotalTime > 0);
    if (!m_goValue.Transport.AnimationInfo->TotalTime)
    {
        LOG_ERROR("vehicle", "StaticTransport::Create: AnimationInfo->TotalTime is 0 for GameObject entry ({})", goinfo->entry);
        return false;
    }
    SetPauseTime(goinfo->transport.pauseAtTime);
    if (goinfo->transport.startOpen && goinfo->transport.pauseAtTime)
    {
        SetPathProgress(goinfo->transport.pauseAtTime);
        _needDoInitialRelocation = true;
    }
    else
        SetPathProgress(0);

    if (GameObjectAddon const* addon = sObjectMgr->GetGameObjectAddon(guidlow))
    {
        if (addon->InvisibilityValue)
        {
            m_invisibility.AddFlag(addon->invisibilityType);
            m_invisibility.AddValue(addon->invisibilityType, addon->InvisibilityValue);
        }
    }

    LastUsedScriptID = GetGOInfo()->ScriptId;
    AIM_Initialize();

    this->setActive(true);
    return true;
}

void StaticTransport::CleanupsBeforeDelete(bool finalCleanup /*= true*/)
{
    while (!_passengers.empty())
    {
        WorldObject* obj = *_passengers.begin();
        RemovePassenger(obj);
        obj->SetTransport(nullptr);
        obj->m_movementInfo.transport.Reset();
        obj->m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
    }

    GameObject::CleanupsBeforeDelete(finalCleanup);
}

void StaticTransport::BuildUpdate(UpdateDataMapType& data_map, UpdatePlayerSet&)
{
    Map::PlayerList const& players = GetMap()->GetPlayers();
    if (players.IsEmpty())
        return;

    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
        BuildFieldsUpdate(itr->GetSource(), data_map);

    ClearUpdateMask(true);
}

void StaticTransport::Update(uint32 diff)
{
    GameObject::Update(diff);

    if (!IsInWorld())
        return;

    if (!m_goValue.Transport.AnimationInfo)
        return;

    if (_needDoInitialRelocation)
    {
        _needDoInitialRelocation = false;
        RelocateToProgress(GetPathProgress());
    }

    if (GetPauseTime())
    {
        if (GetGoState() == GO_STATE_READY)
        {
            if (GetPathProgress() == 0) // waiting at it's destination for state change, do nothing
                return;

            if (GetPathProgress() < GetPauseTime()) // GOState has changed before previous state was reached, move to new destination immediately
                SetPathProgress(0);
            else if (GetPathProgress() + diff < GetPeriod())
                SetPathProgress(GetPathProgress() + diff);
            else
                SetPathProgress(0);
        }
        else
        {
            if (GetPathProgress() == GetPauseTime()) // waiting at it's destination for state change, do nothing
                return;

            if (GetPathProgress() > GetPauseTime()) // GOState has changed before previous state was reached, move to new destination immediately
                SetPathProgress(GetPauseTime());
            else if (GetPathProgress() + diff < GetPauseTime())
                SetPathProgress(GetPathProgress() + diff);
            else
                SetPathProgress(GetPauseTime());
        }
    }
    else
    {
        SetPathProgress(GetPathProgress() + diff);
        if (GetPathProgress() >= GetPeriod())
            SetPathProgress(GetPathProgress() % GetPeriod());
    }

    RelocateToProgress(GetPathProgress());
}

void StaticTransport::RelocateToProgress(uint32 progress)
{
    TransportAnimationEntry const* curr = nullptr, *next = nullptr;
    float percPos;
    if (m_goValue.Transport.AnimationInfo->GetAnimNode(progress, curr, next, percPos))
    {
        // curr node offset
        G3D::Vector3 pos = G3D::Vector3(curr->X, curr->Y, curr->Z);

        // move by percentage of segment already passed
        pos += G3D::Vector3(percPos * (next->X - curr->X), percPos * (next->Y - curr->Y), percPos * (next->Z - curr->Z));

        // rotate path by PathRotation
        // pussywizard: PathRotation in db is only simple orientation rotation, so don't use sophisticated and not working code
        // reminder: WorldRotation only influences model rotation, not the path
        float sign = GetFloatValue(GAMEOBJECT_PARENTROTATION + 2) >= 0.0f ? 1.0f : -1.0f;
        float pathRotAngle = sign * 2.0f * acos(GetFloatValue(GAMEOBJECT_PARENTROTATION + 3));
        float cs = cos(pathRotAngle), sn = std::sin(pathRotAngle);
        float nx = pos.x * cs - pos.y * sn;
        float ny = pos.x * sn + pos.y * cs;
        pos.x = nx;
        pos.y = ny;

        // add stationary position to the calculated offset
        pos += G3D::Vector3(GetStationaryX(), GetStationaryY(), GetStationaryZ());

        // rotate by AnimRotation at current segment
        // pussywizard: AnimRotation in dbc is only simple orientation rotation, so don't use sophisticated and not working code
        G3D::Quat currRot, nextRot;
        float percRot;
        m_goValue.Transport.AnimationInfo->GetAnimRotation(progress, currRot, nextRot, percRot);
        float signCurr = currRot.z >= 0.0f ? 1.0f : -1.0f;
        float oriRotAngleCurr = signCurr * 2.0f * acos(currRot.w);
        float signNext = nextRot.z >= 0.0f ? 1.0f : -1.0f;
        float oriRotAngleNext = signNext * 2.0f * acos(nextRot.w);
        float oriRotAngle = oriRotAngleCurr + percRot * (oriRotAngleNext - oriRotAngleCurr);

        // check if position is valid
        if (!Acore::IsValidMapCoord(pos.x, pos.y, pos.z))
            return;

        // update position to new one
        // also adding simplified orientation rotation here
        UpdatePosition(pos.x, pos.y, pos.z, NormalizeOrientation(GetStationaryO() + oriRotAngle));
    }
}

void StaticTransport::UpdatePosition(float x, float y, float z, float o)
{
    if (!GetMap()->IsGridLoaded(x, y)) // pussywizard: should not happen, but just in case
        GetMap()->LoadGrid(x, y);

    GetMap()->GameObjectRelocation(this, x, y, z, o); // this also relocates the model
    UpdatePassengerPositions();
}

void StaticTransport::UpdatePassengerPositions()
{
    for (PassengerSet::iterator itr = _passengers.begin(); itr != _passengers.end(); ++itr)
    {
        WorldObject* passenger = *itr;

        // if passenger is on vehicle we have to assume the vehicle is also on transport and its the vehicle that will be updating its passengers
        if (Unit* unit = passenger->ToUnit())
            if (unit->GetVehicle())
                continue;

        // Do not use Unit::UpdatePosition here, we don't want to remove auras as if regular movement occurred
        float x, y, z, o;
        passenger->m_movementInfo.transport.pos.GetPosition(x, y, z, o);
        CalculatePassengerPosition(x, y, z, &o);

        // check if position is valid
        if (!Acore::IsValidMapCoord(x, y, z))
            continue;

        switch (passenger->GetTypeId())
        {
            case TYPEID_UNIT:
                GetMap()->CreatureRelocation(passenger->ToCreature(), x, y, z, o);
                break;
            case TYPEID_PLAYER:
                if (passenger->IsInWorld())
                {
                    GetMap()->PlayerRelocation(passenger->ToPlayer(), x, y, z, o);
                    passenger->ToPlayer()->SetFallInformation(GameTime::GetGameTime().count(), z);
                }
                break;
            case TYPEID_GAMEOBJECT:
                GetMap()->GameObjectRelocation(passenger->ToGameObject(), x, y, z, o);
                break;
            case TYPEID_DYNAMICOBJECT:
                GetMap()->DynamicObjectRelocation(passenger->ToDynObject(), x, y, z, o);
                break;
            default:
                break;
        }
    }
}

void StaticTransport::AddPassenger(WorldObject* passenger, bool withAll)
{
    if (_passengers.insert(passenger).second)
    {
        if (Player* plr = passenger->ToPlayer())
            sScriptMgr->OnAddPassenger(ToTransport(), plr);

        if (withAll)
        {
            if (Transport* t = passenger->GetTransport()) // SHOULD NEVER HAPPEN
                t->RemovePassenger(passenger, false);

            float x, y, z, o;
            passenger->GetPosition(x, y, z, o);
            CalculatePassengerOffset(x, y, z, &o);

            passenger->SetTransport(this);
            passenger->m_movementInfo.flags |= MOVEMENTFLAG_ONTRANSPORT;
            passenger->m_movementInfo.transport.guid = GetGUID();
            passenger->m_movementInfo.transport.pos.Relocate(x, y, z, o);
        }
    }
}

void StaticTransport::RemovePassenger(WorldObject* passenger, bool withAll)
{
    if (_passengers.erase(passenger))
    {
        if (Player* plr = passenger->ToPlayer())
        {
            sScriptMgr->OnRemovePassenger(ToTransport(), plr);
            plr->SetFallInformation(GameTime::GetGameTime().count(), plr->GetPositionZ());
        }

        if (withAll)
        {
            passenger->SetTransport(nullptr);
            passenger->m_movementInfo.flags &= ~MOVEMENTFLAG_ONTRANSPORT;
            passenger->m_movementInfo.transport.guid.Clear();
            passenger->m_movementInfo.transport.pos.Relocate(0.0f, 0.0f, 0.0f, 0.0f);
        }
    }
}

std::string MotionTransport::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << GameObject::GetDebugInfo();
    return sstr.str();
}
