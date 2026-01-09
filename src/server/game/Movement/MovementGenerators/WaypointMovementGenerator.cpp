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

#include "WaypointMovementGenerator.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "CreatureGroups.h"
#include "GameTime.h"
#include "MapMgr.h"
#include "MoveSpline.h"
#include "MoveSplineInit.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "Spell.h"
#include "Transport.h"
#include "World.h"
#include "SmartScriptMgr.h"

void WaypointMovementGenerator<Creature>::LoadPath(Creature* creature)
{
    switch (i_pathSource)
    {
        case PathSource::WAYPOINT_MGR:
        {
            if (!path_id)
                path_id = creature->GetWaypointPath();

            i_path = sWaypointMgr->GetPath(path_id);
            break;
        }
        case PathSource::SMART_WAYPOINT_MGR:
        {
            i_path = sSmartWaypointMgr->GetPath(path_id);
            break;
        }
    }

    if (!i_path)
    {
        // No movement found for entry
        LOG_ERROR("sql.sql", "WaypointMovementGenerator::LoadPath: creature {} ({}) doesn't have waypoint path id: {}",
            creature->GetName(), creature->GetGUID().ToString(), path_id);
        return;
    }

    i_currentNode = i_path->begin()->first;

    StartMoveNow(creature);
}

void WaypointMovementGenerator<Creature>::DoInitialize(Creature* creature)
{
    LoadPath(creature);
    creature->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
}

void WaypointMovementGenerator<Creature>::DoFinalize(Creature* creature)
{
    creature->ClearUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
}

void WaypointMovementGenerator<Creature>::DoReset(Creature* creature)
{
    if (stalled)
    {
        return;
    }
    creature->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
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

    auto currentNodeItr = i_path->find(i_currentNode);

    if (currentNodeItr->second.event_id && urand(0, 99) < currentNodeItr->second.event_chance)
    {
        LOG_DEBUG("maps.script", "Creature movement start script {} at point {} for {}.",
            currentNodeItr->second.event_id, i_currentNode, creature->GetGUID().ToString());
        creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
        creature->GetMap()->ScriptsStart(sWaypointScripts, currentNodeItr->second.event_id, creature, nullptr);
    }

    // Inform script
    MovementInform(creature);
    creature->UpdateWaypointID(i_currentNode);

    if (currentNodeItr->second.delay)
    {
        creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
        Stop(currentNodeItr->second.delay);
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
        {
            auto currentNodeItr = i_path->find(i_currentNode);
            float x = currentNodeItr->second.x;
            float y = currentNodeItr->second.y;
            float z = currentNodeItr->second.z;
            float o = creature->GetOrientation();

            if (!transportPath)
                creature->SetHomePosition(x, y, z, o);
            else
            {
                if (Transport* trans = (creature->GetTransport() ? creature->GetTransport()->ToMotionTransport() : nullptr))
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
        uint32 lastPoint = i_path->rbegin()->first;
        if ((i_currentNode == lastPoint) && !repeating) // If that's our last waypoint
        {
            creature->AI()->PathEndReached(path_id);
            creature->GetMotionMaster()->Initialize();
            return false;
        }

        ++i_currentNode;
        if (lastPoint < i_currentNode)
            i_currentNode = i_path->begin()->first;
    }

    // xinef: do not initialize motion if we got stunned in movementinform
    if (creature->HasUnitState(UNIT_STATE_NOT_MOVE) || creature->IsMovementPreventedByCasting())
    {
        return true;
    }

    auto currentNodeItr = i_path->find(i_currentNode);
    WaypointData const& node = currentNodeItr->second;

    m_isArrivalDone = false;

    creature->AddUnitState(UNIT_STATE_ROAMING_MOVE);

    Movement::Location formationDest(node.x, node.y, node.z, 0.0f);
    Movement::MoveSplineInit init(creature);

    //! If creature is on transport, we assume waypoints set in DB are already transport offsets
    if (transportPath)
    {
        init.DisableTransportPathTransformations();
        if (TransportBase* trans = creature->GetDirectTransport())
            trans->CalculatePassengerPosition(formationDest.x, formationDest.y, formationDest.z, &formationDest.orientation);
    }

    float z = node.z;
    creature->UpdateAllowedPositionZ(node.x, node.y, z);
    //! Do not use formationDest here, MoveTo requires transport offsets due to DisableTransportPathTransformations() call
    //! but formationDest contains global coordinates
    init.MoveTo(node.x, node.y, z, true, true);

    if (node.orientation.has_value() && node.delay > 0)
        init.SetFacing(*node.orientation);

    switch (node.move_type)
    {
        case WAYPOINT_MOVE_TYPE_LAND:
            init.SetAnimation(AnimTier::Ground);
            break;
        case WAYPOINT_MOVE_TYPE_TAKEOFF:
            init.SetAnimation(AnimTier::Hover);
            break;
        case WAYPOINT_MOVE_TYPE_RUN:
            init.SetWalk(false);
            break;
        case WAYPOINT_MOVE_TYPE_WALK:
            init.SetWalk(true);
            break;
        default:
            break;
    }

    init.Launch();

    //Call for creature group update
    if (creature->GetFormation() && creature->GetFormation()->GetLeader() == creature)
        creature->GetFormation()->LeaderMoveTo(formationDest.x, formationDest.y, formationDest.z, node.move_type);

    return true;
}

bool WaypointMovementGenerator<Creature>::DoUpdate(Creature* creature, uint32 diff)
{
    // Waypoint movement can be switched on/off
    // This is quite handy for escort quests and other stuff
    if (stalled)
    {
        Stop(1000);
        return true;
    }
    if (creature->HasUnitState(UNIT_STATE_NOT_MOVE) || creature->IsMovementPreventedByCasting())
    {
        creature->StopMoving();
        Stop(1000);
        return true;
    }

    // prevent a crash at empty waypoint path.
    if (!i_path || i_path->empty())
        return false;

    // Xinef: Dont allow dead creatures to move
    if (!creature->IsAlive())
        return false;

    if (Stopped())
    {
        if (CanMove(diff))
            return StartMove(creature);
    }
    else
    {
        if (creature->movespline->Finalized())
        {
            OnArrived(creature);
            return StartMove(creature);
        }
    }
    return true;
}

void WaypointMovementGenerator<Creature>::MovementInform(Creature* creature)
{
    if (creature->AI())
        creature->AI()->MovementInform(WAYPOINT_MOTION_TYPE, i_currentNode);

    if (Unit* owner = creature->GetCharmerOrOwner())
    {
        if (UnitAI* AI = owner->GetAI())
            AI->SummonMovementInform(creature, WAYPOINT_MOTION_TYPE, i_currentNode);
    }
    else
    {
        if (TempSummon* tempSummon = creature->ToTempSummon())
            if (Unit* owner = tempSummon->GetSummonerUnit())
                if (UnitAI* AI = owner->GetAI())
                    AI->SummonMovementInform(creature, WAYPOINT_MOTION_TYPE, i_currentNode);
    }
}

void WaypointMovementGenerator<Creature>::Pause(uint32 timer)
{
    if (timer)
        i_nextMoveTime.Reset(timer);
    else
    {
        // No timer? Will be paused forever until ::Resume is called
        stalled = true;
        i_nextMoveTime.Reset(1);
    }
}

void WaypointMovementGenerator<Creature>::Resume(uint32 /*overrideTimer/*/)
{
    stalled = false;
}

//----------------------------------------------------//

uint32 FlightPathMovementGenerator::GetPathAtMapEnd() const
{
    if (i_currentNode >= i_path.size())
    {
        return i_path.size();
    }

    uint32 curMapId = i_path[i_currentNode]->mapid;
    for (uint32 i = i_currentNode; i < i_path.size(); ++i)
    {
        if (i_path[i]->mapid != curMapId)
        {
            return i;
        }
    }

    return i_path.size();
}

#define SKIP_SPLINE_POINT_DISTANCE_SQ (40.0f * 40.0f)

bool IsNodeIncludedInShortenedPath(TaxiPathNodeEntry const* p1, TaxiPathNodeEntry const* p2)
{
    return p1->mapid != p2->mapid || std::pow(p1->x - p2->x, 2) + std::pow(p1->y - p2->y, 2) > SKIP_SPLINE_POINT_DISTANCE_SQ;
}

void FlightPathMovementGenerator::LoadPath(Player* player)
{
    _pointsForPathSwitch.clear();
    std::deque<uint32> const& taxi = player->m_taxi.GetPath();
    float discount = player->GetReputationPriceDiscount(player->m_taxi.GetFlightMasterFactionTemplate());
    for (uint32 src = 0, dst = 1; dst < taxi.size(); src = dst++)
    {
        uint32 path, cost;
        sObjectMgr->GetTaxiPath(taxi[src], taxi[dst], path, cost);
        if (path > sTaxiPathNodesByPath.size())
        {
            return;
        }

        TaxiPathNodeList const& nodes = sTaxiPathNodesByPath[path];
        if (!nodes.empty())
        {
            TaxiPathNodeEntry const* start = nodes[0];
            TaxiPathNodeEntry const* end = nodes[nodes.size() - 1];
            bool passedPreviousSegmentProximityCheck = false;
            for (uint32 i = 0; i < nodes.size(); ++i)
            {
                if (passedPreviousSegmentProximityCheck || !src || i_path.empty() || IsNodeIncludedInShortenedPath(i_path[i_path.size() - 1], nodes[i]))
                {
                    if ((!src || (IsNodeIncludedInShortenedPath(start, nodes[i]) && i >= 2)) &&
                        (dst == taxi.size() - 1 || (IsNodeIncludedInShortenedPath(end, nodes[i]) && i < nodes.size() - 1)))
                    {
                        passedPreviousSegmentProximityCheck = true;
                        i_path.push_back(nodes[i]);
                    }
                }
                else
                {
                    i_path.pop_back();
                    --_pointsForPathSwitch.back().PathIndex;
                }
            }
        }

        _pointsForPathSwitch.push_back({ uint32(i_path.size() - 1), int32(ceil(cost * discount)) });
    }

    // TODO: fixes crash, but can be handled in a better way once we will know how to reproduce it.
    if (GetCurrentNode() >= i_path.size())
    {
        std::string paths;
        std::deque<uint32> const& taxi = player->m_taxi.GetPath();
        for (uint32 src = 0, dst = 1; dst < taxi.size(); src = dst++)
        {
            uint32 path, cost;
            sObjectMgr->GetTaxiPath(taxi[src], taxi[dst], path, cost);
            paths += std::to_string(path) + " ";
        }

        LOG_ERROR("movement.flightpath", "Failed to build correct path for player: {}. Current node: {}, max nodes: {}. Paths: {}. Player pos: {}.", player->GetGUID().ToString(), GetCurrentNode(), i_path.size(), paths, player->GetPosition().ToString());

        // Lets choose the second last element so that a player would still have some flight.
        if (i_path.size() >= 2)
            i_currentNode = uint32(i_path.size() - 2);
        else
            i_currentNode = 0;
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

    player->m_taxi.ClearTaxiDestinations();
    player->Dismount();
    player->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_TAXI_FLIGHT);
    player->UpdatePvPState(); // to account for cases such as flying into a PvP territory, as it does not flag on the way in

    if (player->m_taxi.empty())
    {
        player->getHostileRefMgr().setOnlineOfflineState(true);
        // update z position to ground and orientation for landing point
        // this prevent cheating with landing  point at lags
        // when client side flight end early in comparison server side
        player->StopMoving();

        // When the player reaches the last flight point, teleport to destination taxi node location
        player->SetFallInformation(GameTime::GetGameTime().count(), player->GetPositionZ());
    }

    player->RemovePlayerFlag(PLAYER_FLAGS_TAXI_BENCHMARK);
}

#define PLAYER_FLIGHT_SPEED 32.0f

void FlightPathMovementGenerator::DoReset(Player* player)
{
    uint32 end = GetPathAtMapEnd();
    uint32 currentNodeId = GetCurrentNode();

    if (currentNodeId == end)
    {
        LOG_DEBUG("movement.flightpath", "FlightPathMovementGenerator::DoReset: trying to start a flypath from the end point. {}", player->GetGUID().ToString());
        return;
    }

    if (player->pvpInfo.EndTimer)
        player->UpdatePvP(false, true); // PvP flag timer immediately ends when starting taxi

    player->getHostileRefMgr().setOnlineOfflineState(false);
    player->AddUnitState(UNIT_STATE_IN_FLIGHT);
    player->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_TAXI_FLIGHT);

    Movement::MoveSplineInit init(player);
    // Providing a starting vertex since the taxi paths do not provide such
    init.Path().push_back(G3D::Vector3(player->GetPositionX(), player->GetPositionY(), player->GetPositionZ()));
    for (uint32 i = currentNodeId; i != end; ++i)
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
    // skipping the first spline path point because it's our starting point and not a taxi path point
    uint32 pointId = player->movespline->currentPathIdx() <= 0 ? 0 : player->movespline->currentPathIdx() - 1;
    if (pointId > i_currentNode && i_currentNode < i_path.size() - 1)
    {
        bool departureEvent = true;
        do
        {
            ASSERT(i_currentNode < i_path.size(), "Point Id: {}\n{}", pointId, player->GetGUID().ToString());

            DoEventIfAny(player, i_path[i_currentNode], departureEvent);
            while (!_pointsForPathSwitch.empty() && _pointsForPathSwitch.front().PathIndex <= i_currentNode)
            {
                _pointsForPathSwitch.pop_front();
                player->m_taxi.NextTaxiDestination();
                if (!_pointsForPathSwitch.empty())
                {
                    player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GOLD_SPENT_FOR_TRAVELLING, _pointsForPathSwitch.front().Cost);
                    player->ModifyMoney(-_pointsForPathSwitch.front().Cost);
                }
            }

            if (pointId == i_currentNode)
            {
                break;
            }

            if (i_currentNode == _preloadTargetNode)
            {
                PreloadEndGrid();
            }

            i_currentNode += departureEvent ? 1 : 0;
            departureEvent = !departureEvent;
        } while (i_currentNode < i_path.size() - 1);
    }

    return i_currentNode < (i_path.size() - 1);
}

void FlightPathMovementGenerator::SetCurrentNodeAfterTeleport()
{
    if (i_path.empty() || i_currentNode >= i_path.size())
    {
        return;
    }

    uint32 map0 = i_path[i_currentNode]->mapid;
    for (std::size_t i = i_currentNode + 1; i < i_path.size(); ++i)
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
        LOG_DEBUG("maps.script", "Taxi {} event {} of node {} of path {} for player {}", departure ? "departure" : "arrival", eventid, node->index, node->path, player->GetName());
        player->GetMap()->ScriptsStart(sEventScripts, eventid, player, player);
    }
}

bool FlightPathMovementGenerator::GetResetPos(Player*, float& x, float& y, float& z)
{
    TaxiPathNodeEntry const* node = i_path[i_currentNode];
    x = node->x;
    y = node->y;
    z = node->z;
    return true;
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
        LOG_DEBUG("misc", "Preloading grid ({}, {}) for map {} at node index {}/{}", _endGridX, _endGridY, _endMapId, _preloadTargetNode, (uint32)(i_path.size() - 1));
        endMap->LoadGrid(_endGridX, _endGridY);
    }
    else
    {
        LOG_DEBUG("misc", "Unable to determine map to preload flightmaster grid");
    }
}
