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
#include "SmartScriptMgr.h"
#include "World.h"

inline G3D::Vector3 PositionToVector3(Position const& p) { return { p.GetPositionX(), p.GetPositionY(), p.GetPositionZ() }; }

WaypointMovementGenerator<Creature>::WaypointMovementGenerator(uint32 pathId, bool repeating, PathSource pathSource) : PathMovementBase((WaypointPath const*)nullptr),
    _lastSplineId(0), _pathId(pathId), _waypointDelay(0),
    _waypointReached(true), _recalculateSpeed(false), _repeating(repeating), _loadedFromDB(true), _stalled(false), _hasBeenStalled(false), _done(false), _pathSource(pathSource),
    _smoothSplineLaunched(false), _lastPassedSplineIdx(0)
{
}

WaypointMovementGenerator<Creature>::WaypointMovementGenerator(WaypointPath& path, bool repeating) : PathMovementBase((WaypointPath const*)nullptr),
    _lastSplineId(0), _pathId(0), _waypointDelay(0),
    _waypointReached(true), _recalculateSpeed(false), _repeating(repeating), _loadedFromDB(false), _stalled(false), _hasBeenStalled(false), _done(false), _pathSource(PathSource::WAYPOINT_MGR),
    _smoothSplineLaunched(false), _lastPassedSplineIdx(0)
{
    i_path = &path;
}

void WaypointMovementGenerator<Creature>::DoInitialize(Creature* creature)
{
    _done = false;

    if (_loadedFromDB)
    {
        if (!_pathId)
            _pathId = creature->GetWaypointPath();

        switch (_pathSource)
        {
            default:
            case PathSource::WAYPOINT_MGR:
                i_path = sWaypointMgr->GetPath(_pathId);
                break;
            case PathSource::SMART_WAYPOINT_MGR:
                i_path = sSmartWaypointMgr->GetPath(_pathId);
                break;
        }
    }

    if (!i_path)
    {
        LOG_ERROR("sql.sql", "WaypointMovementGenerator::DoInitialize: creature {} ({}) doesn't have waypoint path id: {}",
            creature->GetName(), creature->GetGUID().ToString(), _pathId);
        return;
    }

    // Determine our first waypoint from the creature's stored waypoint
    if (CreatureData const* creatureData = creature->GetCreatureData())
    {
        if (i_path->Nodes.size() > creatureData->currentwaypoint)
        {
            creature->UpdateCurrentWaypointInfo(creatureData->currentwaypoint, i_path->Id);
            i_currentNode = creatureData->currentwaypoint;
        }
    }

    creature->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);

    // Inform AI
    if (CreatureAI* AI = creature->AI())
        AI->WaypointPathStarted(i_path->Id);
}

void WaypointMovementGenerator<Creature>::DoFinalize(Creature* creature)
{
    creature->ClearUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
}

void WaypointMovementGenerator<Creature>::DoReset(Creature* creature)
{
    // We did not reach our last waypoint before reset, treat this scenario as resuming movement.
    if (!_done && !_waypointReached)
        _hasBeenStalled = true;
    else if (_done)
    {
        // mimic IdleMovementGenerator
        if (!creature->IsStopped())
            creature->StopMoving();
    }
}

inline void UpdateHomePosition(Creature* creature, WaypointNode const& waypointNode)
{
    float x = waypointNode.X;
    float y = waypointNode.Y;
    float z = waypointNode.Z;
    float o = creature->GetOrientation();

    bool transportPath = creature->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) && creature->GetTransGUID();
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
    }
}

void WaypointMovementGenerator<Creature>::ProcessWaypointArrival(Creature* creature, WaypointNode const& waypoint)
{
    if (_waypointReached)
        return;

    if (waypoint.Delay > 0)
    {
        creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
        _waypointDelay = waypoint.Delay;
    }

    bool pathEnded = (i_currentNode == i_path->Nodes.size() - 1) && !_repeating && !_done;
    if (pathEnded)
        _done = true;

    UpdateHomePosition(creature, waypoint);

    if (waypoint.EventId && urand(0, 99) < waypoint.EventChance)
    {
        LOG_DEBUG("maps.script", "Creature movement start script {} at point {} for {}.",
            waypoint.EventId, i_currentNode, creature->GetGUID().ToString());
        creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
        creature->GetMap()->ScriptsStart(sWaypointScripts, waypoint.EventId, creature, nullptr);
    }

    // scripts can invalidate current path, store what we need
    uint32 const waypointId = waypoint.Id;
    uint32 const pathId = i_path->Id;

    creature->UpdateWaypointID(waypointId);
    creature->UpdateCurrentWaypointInfo(waypointId, pathId);

    // Inform AI
    if (CreatureAI* AI = creature->AI())
    {
        AI->MovementInform(WAYPOINT_MOTION_TYPE, waypointId);
        AI->WaypointReached(waypointId, pathId);
    }

    if (Unit* owner = creature->GetCharmerOrOwner())
    {
        if (UnitAI* AI = owner->GetAI())
            AI->SummonMovementInform(creature, WAYPOINT_MOTION_TYPE, waypointId);
    }
    else
    {
        if (TempSummon* tempSummon = creature->ToTempSummon())
            if (Unit* owner2 = tempSummon->GetSummonerUnit())
                if (UnitAI* AI = owner2->GetAI())
                    AI->SummonMovementInform(creature, WAYPOINT_MOTION_TYPE, waypointId);
    }

    // Path end notifications fire after WaypointReached so that m_path_id
    // is still valid when SmartAI checks it for SMART_EVENT_WAYPOINT_REACHED.
    if (pathEnded)
    {
        creature->UpdateCurrentWaypointInfo(0, 0);

        if (CreatureAI* AI = creature->AI())
            AI->PathEndReached(pathId);

        // Re-fetch AI — PathEndReached may have despawned the creature or swapped its AI
        if (CreatureAI* AI = creature->AI())
            AI->WaypointPathEnded(waypointId, pathId);
    }

    // All hooks called and infos updated. Time to increment the waypoint node id
    if (i_path && !i_path->Nodes.empty()) // ensure that the path has not been changed in one of the hooks.
        i_currentNode = (i_currentNode + 1) % i_path->Nodes.size();

    _waypointReached = true;
}

void WaypointMovementGenerator<Creature>::StartMove(Creature* creature, bool relaunch /*= false*/)
{
    // Formation checks. Do not launch a new spline when one of our formation members is currently in combat.
    if (!relaunch)
    {
        if (!IsAllowedToMove(creature) || (creature->IsFormationLeader() && !creature->IsFormationLeaderMoveAllowed()))
        {
            _waypointDelay = 1000;
            return;
        }
    }

    // Dont allow dead creatures to move
    if (!creature->IsAlive())
        return;

    // Step two: node selection is done, build spline data
    creature->AddUnitState(UNIT_STATE_ROAMING_MOVE);
    WaypointNode const& waypoint = i_path->Nodes.at(i_currentNode);
    bool const useTransportPath = creature->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) && creature->GetTransGUID();

    Movement::MoveSplineInit init(creature);
    //! If the creature is on transport, we assume waypoints set in DB are already transport offsets
    if (useTransportPath)
        init.DisableTransportPathTransformations();

    if (waypoint.SmoothTransition && i_path->Nodes.size() > 2)
    {
        // Build a catmullrom spline segment, stopping at delay waypoints
        init.Path().push_back(PositionToVector3(creature->GetPosition()));

        bool hasDelayInSegment = false;
        uint32 segmentNodes = 0;
        for (uint32 i = 0; i < i_path->Nodes.size(); ++i)
        {
            uint32 idx = (i_currentNode + i) % i_path->Nodes.size();
            WaypointNode const& node = i_path->Nodes.at(idx);
            init.Path().push_back(G3D::Vector3(node.X, node.Y, node.Z));
            segmentNodes++;

            // Stop the segment at a waypoint with a delay
            if (node.Delay > 0)
            {
                hasDelayInSegment = true;
                break;
            }
        }

        // If no delays found and repeating, add wrap-around points for seamless loop
        if (!hasDelayInSegment && _repeating)
        {
            for (uint32 i = 0; i < std::min<uint32>(3, i_path->Nodes.size()); ++i)
            {
                uint32 idx = (i_currentNode + i) % i_path->Nodes.size();
                WaypointNode const& node = i_path->Nodes.at(idx);
                init.Path().push_back(G3D::Vector3(node.X, node.Y, node.Z));
            }
        }

        // Need at least 3 waypoints for a meaningful catmullrom spline
        if (segmentNodes >= 3)
        {
            init.SetFirstPointId(i_currentNode);
            init.SetSmooth();
            _smoothSplineLaunched = true;
            _lastPassedSplineIdx = i_currentNode;
        }
        else
        {
            // Too few points for catmullrom, fall back to linear point-to-point
            init.Path().clear();
            init.MoveTo(G3D::Vector3(waypoint.X, waypoint.Y, waypoint.Z));
        }
    }
    else if (!waypoint.SplinePoints.empty())
    {
        // We have spline points in waypoint_data_addon table
        int32 splineIndex = 0;

        auto itr = waypoint.SplinePoints.begin();
        if (splineIndex)
            std::advance(itr, splineIndex);

        init.Path().reserve(waypoint.SplinePoints.size() - splineIndex);
        std::copy(itr, waypoint.SplinePoints.end(), std::back_inserter(init.Path()));

        // Add starting vertex and destination
        init.Path().insert(init.Path().begin(), PositionToVector3(creature->GetPosition()));
        init.Path().insert(init.Path().end(), G3D::Vector3(waypoint.X, waypoint.Y, waypoint.Z));
    }
    else
    {
        // Smooth transition for short paths (<=2 nodes): use previous spline endpoint as start
        if (waypoint.SmoothTransition && !creature->movespline->Finalized() && _lastSplineId == creature->movespline->GetId())
        {
            init.MoveTo(creature->movespline->FinalDestination(), G3D::Vector3(waypoint.X, waypoint.Y, waypoint.Z));
            if (!init.Path().empty())
                init.Path().insert(init.Path().begin(), PositionToVector3(creature->GetPosition()));
        }
        else
            init.MoveTo(PositionToVector3(creature->GetPosition()), G3D::Vector3(waypoint.X, waypoint.Y, waypoint.Z));
    }

    if (waypoint.Orientation.has_value() && waypoint.Delay > 0)
        init.SetFacing(*waypoint.Orientation);

    switch (waypoint.MoveType)
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

    if (creature->CanFly())
        init.SetFly();

    if (waypoint.Velocity > 0.f)
        init.SetVelocity(waypoint.Velocity);

    init.Launch();

    if (!creature->movespline->Finalized())
        _lastSplineId = creature->movespline->GetId();

    // Inform formation
    creature->SignalFormationMovement();

    // Inform AI
    if (!relaunch)
        if (CreatureAI* AI = creature->AI())
            AI->WaypointStarted(waypoint.Id, i_path->Id);

    _waypointReached = false;
    _recalculateSpeed = false;
    _hasBeenStalled = false;
}

bool WaypointMovementGenerator<Creature>::DoUpdate(Creature* creature, uint32 diff)
{
    if (!creature || !creature->IsAlive())
        return true;

    if (_done || !i_path || i_path->Nodes.empty())
        return true;

    // Stop movement if paused, rooted, or casting
    if (!IsAllowedToMove(creature) && !creature->movespline->Finalized())
    {
        creature->StopMoving();
        _lastSplineId = 0;
        _smoothSplineLaunched = false;
    }

    // Set home position to current position.
    if (!creature->movespline->Finalized())
    {
        bool transportPath = creature->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) && creature->GetTransGUID();
        if (!transportPath)
            creature->SetHomePosition(creature->GetPosition());
    }

    // Smooth spline: track waypoint passages without rebuilding
    if (_smoothSplineLaunched && creature->movespline->GetId() == _lastSplineId)
    {
        int32 currentIdx = creature->movespline->currentPathIdx();

        // Process passed waypoints
        while (_lastPassedSplineIdx < currentIdx)
        {
            _lastPassedSplineIdx++;
            WaypointNode const& passedWp = i_path->Nodes.at(i_currentNode);

            UpdateHomePosition(creature, passedWp);

            // Save data before AI callbacks — they can invalidate the reference
            uint32 const wpId = passedWp.Id;
            uint32 const wpPathId = i_path->Id;
            uint32 const wpDelay = passedWp.Delay;
            std::optional<float> const wpOrientation = passedWp.Orientation;

            creature->UpdateWaypointID(wpId);
            creature->UpdateCurrentWaypointInfo(wpId, wpPathId);

            if (passedWp.EventId && urand(0, 99) < passedWp.EventChance)
            {
                creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
                creature->GetMap()->ScriptsStart(sWaypointScripts, passedWp.EventId, creature, nullptr);
            }

            if (CreatureAI* AI = creature->AI())
            {
                AI->MovementInform(WAYPOINT_MOTION_TYPE, wpId);
                AI->WaypointReached(wpId, wpPathId);
            }

            // Advance node
            if (i_path && !i_path->Nodes.empty())
                i_currentNode = (i_currentNode + 1) % i_path->Nodes.size();

            // If this waypoint has a delay, stop the spline and pause
            if (wpDelay > 0)
            {
                creature->StopMoving();
                creature->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
                _waypointDelay = wpDelay;
                _waypointReached = true;
                _smoothSplineLaunched = false;
                if (wpOrientation.has_value())
                    creature->SetFacingTo(*wpOrientation);

                return true;
            }
        }

        if (creature->movespline->Finalized())
        {
            if (!_repeating)
            {
                // Path ended
                uint32 const endWpId = i_path->Nodes.at(i_currentNode).Id;
                uint32 const endPathId = i_path->Id;
                _done = true;
                _smoothSplineLaunched = false;
                creature->UpdateCurrentWaypointInfo(0, 0);
                if (CreatureAI* AI = creature->AI())
                    AI->PathEndReached(endPathId);

                // Re-fetch AI — PathEndReached may have despawned the creature or swapped its AI
                if (CreatureAI* AI = creature->AI())
                    AI->WaypointPathEnded(endWpId, endPathId);
            }
            else
            {
                // Repeating: rebuild spline
                _smoothSplineLaunched = false;
                StartMove(creature);
            }
        }

        return true;
    }

    // Non-smooth: per-waypoint logic
    WaypointNode const& waypoint = i_path->Nodes.at(i_currentNode);
    UpdateWaypointState(creature, waypoint);

    // Process movement preventing timers
    if (_waypointDelay > 0)
    {
        _waypointDelay -= diff;
        if (_waypointDelay > 0)
            return true;
    }

    if (_pauseTime.has_value())
    {
        *_pauseTime -= diff;
        if (*_pauseTime > 0)
            return true;
        else
            _pauseTime.reset();
    }

    // Timers are ready, let's try to move
    if (IsAllowedToMove(creature) && (_waypointReached || _recalculateSpeed || _hasBeenStalled))
        StartMove(creature, _recalculateSpeed || _hasBeenStalled);

    return true;
}

void WaypointMovementGenerator<Creature>::Pause(uint32 timer /*= 0*/)
{
    _stalled = timer ? false : true;
    _hasBeenStalled = !_waypointReached;
    _pauseTime = timer;
}

void WaypointMovementGenerator<Creature>::Resume(uint32 overrideTimer /*= 0*/)
{
    _hasBeenStalled = !_waypointReached;
    _stalled = false;
    if (overrideTimer)
        _pauseTime = overrideTimer;
}

bool WaypointMovementGenerator<Creature>::GetResetPosition(float& x, float& y, float& z)
{
    // prevent a crash at empty waypoint path.
    if (!i_path || i_path->Nodes.empty())
        return false;

    ASSERT(i_currentNode < i_path->Nodes.size(), "WaypointMovementGenerator::GetResetPos: tried to reference a node id ({}) which is not included in path ({})", i_currentNode, i_path->Id);
    WaypointNode const& waypoint = i_path->Nodes.at(i_currentNode);

    x = waypoint.X;
    y = waypoint.Y;
    z = waypoint.Z;
    return true;
}

bool WaypointMovementGenerator<Creature>::IsAllowedToMove(Creature* creature) const
{
    if (_stalled || _done)
        return false;

    if (_pauseTime.has_value())
        return false;

    if (creature->HasUnitState(UNIT_STATE_NOT_MOVE) || creature->IsMovementPreventedByCasting())
        return false;

    return true;
}

void WaypointMovementGenerator<Creature>::UpdateWaypointState(Creature* creature, WaypointNode const& waypointNode)
{
    if (creature->movespline->GetId() != _lastSplineId)
        return;

    if (creature->movespline->Finalized())
        ProcessWaypointArrival(creature, waypointNode);
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
