/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ConfusedMovementGenerator.h"
#include "Creature.h"
#include "MapManager.h"
#include "MoveSpline.h"
#include "MoveSplineInit.h"
#include "Player.h"
#include "VMapFactory.h"

#ifdef MAP_BASED_RAND_GEN
#define rand_norm() unit.rand_norm()
#define urand(a, b) unit.urand(a, b)
#endif

template<class T>
void ConfusedMovementGenerator<T>::DoInitialize(T* unit)
{
    unit->StopMoving();
    float const wander_distance = 4;
    float x = unit->GetPositionX();
    float y = unit->GetPositionY();
    float z = unit->GetPositionZ();

    Map const* map = unit->GetBaseMap();

    bool is_water_ok, is_land_ok;
    _InitSpecific(unit, is_water_ok, is_land_ok);

    for (uint8 idx = 0; idx < MAX_CONF_WAYPOINTS + 1; ++idx)
    {
        float wanderX = x + (wander_distance * (float)rand_norm() - wander_distance / 2);
        float wanderY = y + (wander_distance * (float)rand_norm() - wander_distance / 2);

        // prevent invalid coordinates generation
        Acore::NormalizeMapCoord(wanderX);
        Acore::NormalizeMapCoord(wanderY);

        float new_z = unit->GetMapHeight(wanderX, wanderY, z);
        if (new_z <= INVALID_HEIGHT || fabs(z - new_z) > 3.0f) // pussywizard
        {
            i_waypoints[idx][0] = idx > 0 ? i_waypoints[idx - 1][0] : x;
            i_waypoints[idx][1] = idx > 0 ? i_waypoints[idx - 1][1] : y;
            i_waypoints[idx][2] = idx > 0 ? i_waypoints[idx - 1][2] : z;
            continue;
        }
        else if (unit->IsWithinLOS(wanderX, wanderY, z))
        {
            bool is_water = map->IsInWater(wanderX, wanderY, z);

            if ((is_water && !is_water_ok) || (!is_water && !is_land_ok))
            {
                //! Cannot use coordinates outside our InhabitType. Use the current or previous position.
                i_waypoints[idx][0] = idx > 0 ? i_waypoints[idx - 1][0] : x;
                i_waypoints[idx][1] = idx > 0 ? i_waypoints[idx - 1][1] : y;
                i_waypoints[idx][2] = idx > 0 ? i_waypoints[idx - 1][2] : z;
                continue;
            }
        }
        else
        {
            //! Trying to access path outside line of sight. Skip this by using the current or previous position.
            i_waypoints[idx][0] = idx > 0 ? i_waypoints[idx - 1][0] : x;
            i_waypoints[idx][1] = idx > 0 ? i_waypoints[idx - 1][1] : y;
            i_waypoints[idx][2] = idx > 0 ? i_waypoints[idx - 1][2] : z;
            continue;
        }

        //unit->UpdateAllowedPositionZ(wanderX, wanderY, z);

        //! Positions are fine - apply them to this waypoint
        i_waypoints[idx][0] = wanderX;
        i_waypoints[idx][1] = wanderY;
        i_waypoints[idx][2] = new_z;
    }

    // Xinef: Call movement immediately to broadcast movement packet
    // Xinef: Initial timer is set to 1 so update with 1
    i_nextMove = urand(1, MAX_CONF_WAYPOINTS);
    DoUpdate(unit, 1);

    unit->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_CONFUSED);
    unit->AddUnitState(UNIT_STATE_CONFUSED | UNIT_STATE_CONFUSED_MOVE);
}

template<>
void ConfusedMovementGenerator<Creature>::_InitSpecific(Creature* creature, bool& is_water_ok, bool& is_land_ok)
{
    is_water_ok = creature->CanEnterWater();
    is_land_ok  = creature->CanWalk();
}

template<>
void ConfusedMovementGenerator<Player>::_InitSpecific(Player*, bool& is_water_ok, bool& is_land_ok)
{
    is_water_ok = true;
    is_land_ok  = true;
}

template<class T>
void ConfusedMovementGenerator<T>::DoReset(T* unit)
{
    DoInitialize(unit);
}

template<class T>
bool ConfusedMovementGenerator<T>::DoUpdate(T* unit, uint32 diff)
{
    if (unit->HasUnitState(UNIT_STATE_ROOT | UNIT_STATE_STUNNED | UNIT_STATE_DISTRACTED))
        return true;

    if (i_nextMoveTime.Passed())
    {
        // currently moving, update location
        unit->AddUnitState(UNIT_STATE_CONFUSED_MOVE);

        if (unit->movespline->Finalized())
        {
            i_nextMove = urand(1, MAX_CONF_WAYPOINTS);
            i_nextMoveTime.Reset(urand(600, 1200)); // Guessed
        }
    }
    else
    {
        // waiting for next move
        i_nextMoveTime.Update(diff);
        if (i_nextMoveTime.Passed())
        {
            // start moving
            unit->AddUnitState(UNIT_STATE_CONFUSED_MOVE);

            ASSERT(i_nextMove <= MAX_CONF_WAYPOINTS);
            float x = i_waypoints[i_nextMove][0];
            float y = i_waypoints[i_nextMove][1];
            float z = i_waypoints[i_nextMove][2];
            Movement::MoveSplineInit init(unit);
            init.MoveTo(x, y, z, true);
            init.Launch();
        }
    }

    return true;
}

template<>
void ConfusedMovementGenerator<Player>::DoFinalize(Player* unit)
{
    unit->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_CONFUSED);
    unit->ClearUnitState(UNIT_STATE_CONFUSED | UNIT_STATE_CONFUSED_MOVE);
    unit->StopMoving();
}

template<>
void ConfusedMovementGenerator<Creature>::DoFinalize(Creature* unit)
{
    unit->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_CONFUSED);
    unit->ClearUnitState(UNIT_STATE_CONFUSED | UNIT_STATE_CONFUSED_MOVE);
    if (unit->GetVictim())
        unit->SetTarget(unit->GetVictim()->GetGUID());
}

template void ConfusedMovementGenerator<Player>::DoInitialize(Player*);
template void ConfusedMovementGenerator<Creature>::DoInitialize(Creature*);
template void ConfusedMovementGenerator<Player>::DoReset(Player*);
template void ConfusedMovementGenerator<Creature>::DoReset(Creature*);
template bool ConfusedMovementGenerator<Player>::DoUpdate(Player*, uint32 diff);
template bool ConfusedMovementGenerator<Creature>::DoUpdate(Creature*, uint32 diff);
