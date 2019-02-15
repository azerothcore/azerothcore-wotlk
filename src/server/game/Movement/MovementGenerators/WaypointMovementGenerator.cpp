/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */
//Basic headers
#include "WaypointMovementGenerator.h"
//Extended headers
#include "ObjectMgr.h"
#include "World.h"
#include "Transport.h"
//Flightmaster grid preloading
#include "MapManager.h"
//Creature-specific headers
#include "Creature.h"
#include "CreatureAI.h"
#include "CreatureGroups.h"
//Player-specific
#include "Player.h"
#include "MoveSplineInit.h"
#include "MoveSpline.h"
#include "Spell.h"

void WaypointMovementGenerator<Creature>::LoadPath(Creature* creature)
{
    if (!path_id)
        path_id = creature->GetWaypointPath();

    i_path = sWaypointMgr->GetPath(path_id);

    if (!i_path)
    {
        // No movement found for entry
        sLog->outErrorDb("WaypointMovementGenerator::LoadPath: creature %s (Entry: %u GUID: %u) doesn't have waypoint path id: %u", creature->GetName().c_str(), creature->GetEntry(), creature->GetGUIDLow(), path_id);
        return;
    }

    StartMoveNow(creature);
}

void WaypointMovementGenerator<Creature>::DoInitialize(Creature* creature)
{
    LoadPath(creature);
    creature->AddUnitState(UNIT_STATE_ROAMING|UNIT_STATE_ROAMING_MOVE);
}

void WaypointMovementGenerator<Creature>::DoFinalize(Creature* creature)
{
    creature->ClearUnitState(UNIT_STATE_ROAMING|UNIT_STATE_ROAMING_MOVE);
    creature->SetWalk(false);
}

void WaypointMovementGenerator<Creature>::DoReset(Creature* creature)
{
    creature->AddUnitState(UNIT_STATE_ROAMING|UNIT_STATE_ROAMING_MOVE);
    StartMoveNow(creature);
}

void WaypointMovementGenerator<Creature>::OnArrived(Creature* creature)
{
    if (!i_path || i_path->empty())
        return;
    if (m_isArrivalDone)
        return;

    creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
    m_isArrivalDone = true;

    if (i_path->at(i_currentNode)->event_id && urand(0, 99) < i_path->at(i_currentNode)->event_chance)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_MAPSCRIPTS, "Creature movement start script %u at point %u for " UI64FMTD ".", i_path->at(i_currentNode)->event_id, i_currentNode, creature->GetGUID());
#endif
        creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
        creature->GetMap()->ScriptsStart(sWaypointScripts, i_path->at(i_currentNode)->event_id, creature, NULL);
    }

    // Inform script
    MovementInform(creature);
    creature->UpdateWaypointID(i_currentNode);

    if (i_path->at(i_currentNode)->delay)
    {
        creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
        Stop(i_path->at(i_currentNode)->delay);
    }
}

bool WaypointMovementGenerator<Creature>::StartMove(Creature* creature)
{
    if (!i_path || i_path->empty())
        return false;

    // Xinef: Dont allow dead creatures to move
    if (!creature->IsAlive())
        return false;

    if (Stopped())
        return true;

    bool transportPath = creature->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) && creature->GetTransGUID();

    if (m_isArrivalDone)
    {
        // Xinef: not true... update this at every waypoint!
        //if ((i_currentNode == i_path->size() - 1) && !repeating) // If that's our last waypoint
        {
            float x = i_path->at(i_currentNode)->x;
            float y = i_path->at(i_currentNode)->y;
            float z = i_path->at(i_currentNode)->z;
            float o = creature->GetOrientation();

            if (!transportPath)
                creature->SetHomePosition(x, y, z, o);
            else
            {
                if (Transport* trans = (creature->GetTransport() ? creature->GetTransport()->ToMotionTransport() : NULL))
                {
                    o -= trans->GetOrientation();
                    creature->SetTransportHomePosition(x, y, z, o);
                    trans->CalculatePassengerPosition(x, y, z, &o);
                    creature->SetHomePosition(x, y, z, o);
                }
                else
                    transportPath = false;
                // else if (vehicle) - this should never happen, vehicle offsets are const
            }
        }

        // Xinef: moved the upper IF here
        if ((i_currentNode == i_path->size() - 1) && !repeating) // If that's our last waypoint
        {
            creature->GetMotionMaster()->Initialize();
            return false;
        }

        i_currentNode = (i_currentNode+1) % i_path->size();
    }

    // xinef: do not initialize motion if we got stunned in movementinform
    if (creature->HasUnitState(UNIT_STATE_NOT_MOVE))
        return true;

    WaypointData const* node = i_path->at(i_currentNode);

    m_isArrivalDone = false;

    creature->AddUnitState(UNIT_STATE_ROAMING_MOVE);

    Movement::Location formationDest(node->x, node->y, node->z, 0.0f);
    Movement::MoveSplineInit init(creature);

    //! If creature is on transport, we assume waypoints set in DB are already transport offsets
    if (transportPath)
    {
        init.DisableTransportPathTransformations();
        if (TransportBase* trans = creature->GetDirectTransport())
            trans->CalculatePassengerPosition(formationDest.x, formationDest.y, formationDest.z, &formationDest.orientation);
    }

    //! Do not use formationDest here, MoveTo requires transport offsets due to DisableTransportPathTransformations() call
    //! but formationDest contains global coordinates
    init.MoveTo(node->x, node->y, node->z);

    //! Accepts angles such as 0.00001 and -0.00001, 0 must be ignored, default value in waypoint table
    if (node->orientation && node->delay)
        init.SetFacing(node->orientation);

    switch (node->move_type)
    {
        case WAYPOINT_MOVE_TYPE_LAND:
            init.SetAnimation(Movement::ToGround);
            break;
        case WAYPOINT_MOVE_TYPE_TAKEOFF:
            init.SetAnimation(Movement::ToFly);
            break;
        case WAYPOINT_MOVE_TYPE_RUN:
            init.SetWalk(false);
            break;
        case WAYPOINT_MOVE_TYPE_WALK:
            init.SetWalk(true);
            break;
    }

    init.Launch();

    //Call for creature group update
    if (creature->GetFormation() && creature->GetFormation()->getLeader() == creature)
        creature->GetFormation()->LeaderMoveTo(formationDest.x, formationDest.y, formationDest.z, node->move_type == WAYPOINT_MOVE_TYPE_RUN);

    return true;
}

bool WaypointMovementGenerator<Creature>::DoUpdate(Creature* creature, uint32 diff)
{
    // Waypoint movement can be switched on/off
    // This is quite handy for escort quests and other stuff
    if (creature->HasUnitState(UNIT_STATE_NOT_MOVE))
    {
        creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
        return true;
    }
    // prevent a crash at empty waypoint path.
    if (!i_path || i_path->empty())
        return false;

    // Xinef: Dont allow dead creatures to move
    if (!creature->IsAlive())
        return false;

    // prevent movement while casting spells with cast time or channel time
    if (creature->HasUnitState(UNIT_STATE_CASTING))
    {
        bool stop = true;
        if (Spell* spell = creature->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
            if (!(spell->GetSpellInfo()->ChannelInterruptFlags & (AURA_INTERRUPT_FLAG_MOVE | AURA_INTERRUPT_FLAG_TURNING)) && !(spell->GetSpellInfo()->InterruptFlags & SPELL_INTERRUPT_FLAG_MOVEMENT))
                stop = false;

        if (stop)
        {
            Stop(1000);
            if (!creature->IsStopped())
                creature->StopMoving();
            return true;
        }
    }

    if (Stopped())
    {
        if (CanMove(diff))
            return StartMove(creature);
    }
    else
    {
        if (creature->IsStopped())
            Stop(STOP_TIME_FOR_PLAYER);
        else
        {
            // xinef: code to detect pre-empetively if we should start movement to next waypoint
            // xinef: do not start pre-empetive movement if current node has delay or we are ending waypoint movement
            bool finished = creature->movespline->Finalized();
            if (!finished && !i_path->at(i_currentNode)->delay && ((i_currentNode != i_path->size() - 1) || repeating))
                finished = (creature->movespline->_Spline().length(creature->movespline->_currentSplineIdx()+1) - creature->movespline->timePassed()) < 200;

            if (finished)
            {
                OnArrived(creature);
                return StartMove(creature);
            }
        }
    }
     return true;
 }

void WaypointMovementGenerator<Creature>::MovementInform(Creature* creature)
{
    if (creature->AI())
        creature->AI()->MovementInform(WAYPOINT_MOTION_TYPE, i_currentNode);
}

//----------------------------------------------------//

uint32 FlightPathMovementGenerator::GetPathAtMapEnd() const
{
    if (i_currentNode >= i_path.size())
        return i_path.size();

    uint32 curMapId = i_path[i_currentNode]->mapid;
    for (uint32 i = i_currentNode; i < i_path.size(); ++i)
        if (i_path[i]->mapid != curMapId)
            return i;

    return i_path.size();
}

void FlightPathMovementGenerator::LoadPath(Player* player)
{
    _pointsForPathSwitch.clear();
    std::vector<uint32> const& taxi = player->m_taxi.GetPath();
    for (uint32 src = player->m_taxi.GetTaxiSegment(), dst = player->m_taxi.GetTaxiSegment()+1; dst < taxi.size(); src = dst++)
    {
        uint32 path, cost;
        sObjectMgr->GetTaxiPath(taxi[src], taxi[dst], path, cost);
        if (path > sTaxiPathNodesByPath.size())
            return;

        TaxiPathNodeList const& nodes = sTaxiPathNodesByPath[path];
        if (!nodes.empty())
        {
            for (uint32 i = 0; i < nodes.size(); ++i)
                i_path.push_back(nodes[i]);
        }

        _pointsForPathSwitch.push_back(uint32(i_path.size() - 1));
    }
}

void FlightPathMovementGenerator::DoInitialize(Player* player)
{
    Reset(player);
    InitEndGridInfo();
}

void FlightPathMovementGenerator::DoFinalize(Player* player)
{
    // remove flag to prevent send object build movement packets for flight state and crash (movement generator already not at top of stack)
    player->ClearUnitState(UNIT_STATE_IN_FLIGHT);

    // xinef: this should be cleaned by CleanupAfterTaxiFlight(); function!
    player->Dismount();
    player->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_TAXI_FLIGHT);

    if (player->m_taxi.empty())
    {
        player->getHostileRefManager().setOnlineOfflineState(true);
        // update z position to ground and orientation for landing point
        // this prevent cheating with landing  point at lags
        // when client side flight end early in comparison server side
        player->StopMoving();
        player->SetFallInformation(time(NULL), player->GetPositionZ());
    }

    player->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_TAXI_BENCHMARK);
}

#define PLAYER_FLIGHT_SPEED 32.0f

void FlightPathMovementGenerator::DoReset(Player* player)
{
    player->getHostileRefManager().setOnlineOfflineState(false);
    player->AddUnitState(UNIT_STATE_IN_FLIGHT);
    player->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_TAXI_FLIGHT);

    Movement::MoveSplineInit init(player);
    uint32 end = GetPathAtMapEnd();
    for (uint32 i = GetCurrentNode(); i < end; ++i)
    {
        G3D::Vector3 vertice(i_path[i]->x, i_path[i]->y, i_path[i]->z);
        init.Path().push_back(vertice);
    }
    init.SetFirstPointId(GetCurrentNode());
    init.SetFly();
    init.SetVelocity(PLAYER_FLIGHT_SPEED);
    init.Launch();
}

bool FlightPathMovementGenerator::DoUpdate(Player* player, uint32 /*diff*/)
{
    // xinef: map was switched
    if (_mapSwitch)
    {
        DoInitialize(player);
        _mapSwitch = false;
        return true;
    }

    uint32 pointId = (uint32)player->movespline->currentPathIdx();
    if (pointId > i_currentNode)
    {
        bool departureEvent = true;
        do
        {
            if (i_currentNode >= i_path.size())
            {
                sLog->outMisc("TAXI NODE WAS GREATER THAN PATH SIZE, GUID: %u, POINTID: %u, NODESIZE: %lu, CURRENT: %u", player->GetGUIDLow(), pointId, i_path.size(), i_currentNode);
                player->CleanupAfterTaxiFlight();
                return false;
            }

            if (i_path[i_currentNode]->mapid != player->GetMapId())
            {
                sLog->outMisc("Player on different map, curmap: %u, pointmap: %u, nodesize: %lu, currentnode: %u", player->GetMapId(), i_path[i_currentNode]->mapid, i_path.size(), i_currentNode);
                player->CleanupAfterTaxiFlight();
                return false;
            }

            DoEventIfAny(player, i_path[i_currentNode], departureEvent);

            // xinef: erase any previous points
            uint32 curSize = _pointsForPathSwitch.size();
            while (!_pointsForPathSwitch.empty() && _pointsForPathSwitch.front() <= i_currentNode)
                _pointsForPathSwitch.pop_front();

            // xinef: switch destination only once
            if (curSize != _pointsForPathSwitch.size())
                player->m_taxi.NextTaxiDestination();

            if (pointId == i_currentNode)
                break;

            if (i_currentNode == _preloadTargetNode && player->GetMapId() == _endMapId)
                PreloadEndGrid();
            i_currentNode += (uint32)departureEvent;
            departureEvent = !departureEvent;

            // xinef: map should be switched, do not rely on client packets QQ
            if (i_currentNode + 1 < i_path.size() && i_path[i_currentNode+1]->mapid != player->GetMapId())
            {
                ++i_currentNode;
                _mapSwitch = true;
                player->TeleportTo(i_path[i_currentNode]->mapid, i_path[i_currentNode]->x, i_path[i_currentNode]->y, i_path[i_currentNode]->z, player->GetOrientation(), TELE_TO_NOT_LEAVE_TAXI);
                return true;
            }

            // xinef: reached the end
            if (i_currentNode >= i_path.size() - 1)
            {
                player->CleanupAfterTaxiFlight();
                player->SetFallInformation(time(NULL), player->GetPositionZ());
                if (player->pvpInfo.IsHostile)
                    player->CastSpell(player, 2479, true);

                return false;
            }
        }
        while (true);
    }

    return i_currentNode < (i_path.size() - 1);
}

void FlightPathMovementGenerator::SetCurrentNodeAfterTeleport()
{
    if (i_path.empty() || i_currentNode >= i_path.size())
        return;

    uint32 map0 = i_path[i_currentNode]->mapid;
    for (size_t i = i_currentNode + 1; i < i_path.size(); ++i)
    {
        if (i_path[i]->mapid != map0)
        {
            i_currentNode = i;
            return;
        }
    }
}

void FlightPathMovementGenerator::DoEventIfAny(Player* player, TaxiPathNodeEntry const* node, bool departure)
{
    if (uint32 eventid = departure ? node->departureEventID : node->arrivalEventID)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_MAPSCRIPTS, "Taxi %s event %u of node %u of path %u for player %s", departure ? "departure" : "arrival", eventid, node->index, node->path, player->GetName().c_str());
#endif
        player->GetMap()->ScriptsStart(sEventScripts, eventid, player, player);
    }
}

void FlightPathMovementGenerator::InitEndGridInfo()
{
    /*! Storage to preload flightmaster grid at end of flight. For multi-stop flights, this will
       be reinitialized for each flightmaster at the end of each spline (or stop) in the flight. */
    uint32 nodeCount = i_path.size();        //! Number of nodes in path.
    _endMapId = i_path[nodeCount - 1]->mapid; //! MapId of last node

    // pussywizard:
    {
        _preloadTargetNode = nodeCount - 1;
        for (uint8 i = 3; i > 0; --i)
            if (nodeCount >= i && _endMapId == i_path[nodeCount - i]->mapid)
            {
                _preloadTargetNode = nodeCount - i;
                break;
            }
        //_preloadTargetNode = nodeCount - 3; // pussywizard: this can be on other map
    }

    _endGridX = i_path[nodeCount - 1]->x;
    _endGridY = i_path[nodeCount - 1]->y;
}

void FlightPathMovementGenerator::PreloadEndGrid()
{
    // used to preload the final grid where the flightmaster is
    Map* endMap = sMapMgr->FindBaseNonInstanceMap(_endMapId);

    // Load the grid
    if (endMap)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDetail("Preloading rid (%f, %f) for map %u at node index %u/%u", _endGridX, _endGridY, _endMapId, _preloadTargetNode, (uint32)(i_path.size()-1));
#endif
        endMap->LoadGrid(_endGridX, _endGridY);
    }
    else {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDetail("Unable to determine map to preload flightmaster grid");
#endif
    }
}
