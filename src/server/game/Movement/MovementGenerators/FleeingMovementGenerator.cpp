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

#include "FleeingMovementGenerator.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "MapMgr.h"
#include "MoveSplineInit.h"
#include "ObjectAccessor.h"
#include "Player.h"

#define MIN_QUIET_DISTANCE 28.0f
#define MAX_QUIET_DISTANCE 43.0f
#define MIN_PATH_LENGTH 2.0f

template<class T>
void FleeingMovementGenerator<T>::DoInitialize(T* owner)
{
    if (!owner)
    {
        return;
    }

    owner->StopMoving();
    _path = nullptr;
    owner->SetUnitFlag(UNIT_FLAG_FLEEING);
    owner->AddUnitState(UNIT_STATE_FLEEING);
    SetTargetLocation(owner);
}

template<class T>
void FleeingMovementGenerator<T>::DoFinalize(T*)
{
}

template<>
void FleeingMovementGenerator<Player>::DoFinalize(Player* owner)
{
    owner->RemoveUnitFlag(UNIT_FLAG_FLEEING);
    owner->ClearUnitState(UNIT_STATE_FLEEING);
    owner->StopMoving();
}

template<>
void FleeingMovementGenerator<Creature>::DoFinalize(Creature* owner)
{
    owner->RemoveUnitFlag(UNIT_FLAG_FLEEING);
    owner->ClearUnitState(UNIT_STATE_FLEEING | UNIT_STATE_FLEEING_MOVE);

    if (Unit* victim = owner->GetVictim())
    {
        owner->SetTarget(victim->GetGUID());
    }
}

template<class T>
void FleeingMovementGenerator<T>::DoReset(T* owner)
{
    DoInitialize(owner);
}

template<class T>
bool FleeingMovementGenerator<T>::DoUpdate(T* owner, uint32 diff)
{
    if (!owner || !owner->IsAlive())
    {
        return false;
    }

    if (owner->HasUnitState(UNIT_STATE_NOT_MOVE) || owner->IsMovementPreventedByCasting())
    {
        _path = nullptr;
        _interrupt = true;
        owner->StopMoving();
        return true;
    }
    else
        _interrupt = false;

    _timer.Update(diff);
    if (!_interrupt && _timer.Passed() && owner->movespline->Finalized())
    {
        SetTargetLocation(owner);
    }

    return true;
}

template<class T>
void FleeingMovementGenerator<T>::SetTargetLocation(T* owner)
{
    if (!owner)
    {
        return;
    }

    if (owner->HasUnitState(UNIT_STATE_NOT_MOVE) || owner->IsMovementPreventedByCasting())
    {
        _path = nullptr;
        _interrupt = true;
        owner->StopMoving();
        return;
    }

    owner->AddUnitState(UNIT_STATE_FLEEING_MOVE);

    Position destination = owner->GetPosition();
    GetPoint(owner, destination);

    // Add LOS check for target point
    if (!owner->IsWithinLOS(destination.GetPositionX(), destination.GetPositionY(), destination.GetPositionZ()))
    {
        _timer.Reset(200);
        return;
    }

    if (!_path)
    {
        _path = std::make_unique<PathGenerator>(owner);
    }
    else
    {
        _path->Clear();
    }

    if (owner->IsPlayer())
        _path->SetSlopeCheck(true);

    _path->SetPathLengthLimit(30.0f);
    bool result = _path->CalculatePath(destination.GetPositionX(), destination.GetPositionY(), destination.GetPositionZ());
    if (!result || (_path->GetPathType() & PathType(PATHFIND_NOPATH | PATHFIND_SHORTCUT | PATHFIND_FARFROMPOLY | PATHFIND_NOT_USING_PATH)))
    {
        if (_fleeTargetGUID)
            ++_invalidPathsCount;

        _timer.Reset(100);
        return;
    }

    // Same position - recheck
    if (_path->getPathLength() < MIN_PATH_LENGTH)
    {
        if (_fleeTargetGUID)
            ++_invalidPathsCount;

        _timer.Reset(100);
        return;
    }

    _invalidPathsCount = 0;

    Movement::MoveSplineInit init(owner);
    init.MovebyPath(_path->GetPath());
    init.SetWalk(false);
    int32 traveltime = init.Launch();
    _timer.Reset(traveltime + urand(800, 1500));
}

template<class T>
void FleeingMovementGenerator<T>::GetPoint(T* owner, Position& position)
{
    float casterDistance = 0.f;
    float casterAngle = 0.f;
    Unit* fleeTarget = nullptr;
    if (_invalidPathsCount < 5)
        fleeTarget = ObjectAccessor::GetUnit(*owner, _fleeTargetGUID);

    if (fleeTarget)
    {
        casterDistance = fleeTarget->GetDistance(owner);
        if (casterDistance > 0.2f)
        {
            casterAngle = fleeTarget->GetAngle(owner);
        }
        else
        {
            casterAngle = frand(0.0f, 2.0f * float(M_PI));
        }
    }
    else
    {
        casterDistance = 0.0f;
        casterAngle = frand(0.0f, 2.0f * float(M_PI));
    }

    float distance = 0.f;
    float angle = 0.f;
    if (casterDistance < MIN_QUIET_DISTANCE)
    {
        distance = frand(0.4f, 1.3f) * (MIN_QUIET_DISTANCE - casterDistance);
        angle = casterAngle + frand(-float(M_PI) / 8.0f, float(M_PI) / 8.0f);
    }
    else if (casterDistance > MAX_QUIET_DISTANCE)
    {
        distance = frand(0.4f, 1.0f) * (MAX_QUIET_DISTANCE - MIN_QUIET_DISTANCE);
        angle = -casterAngle + frand(-float(M_PI) / 4.0f, float(M_PI) / 4.0f);
    }
    else    // we are inside quiet range
    {
        distance = frand(0.6f, 1.2f) * (MAX_QUIET_DISTANCE - MIN_QUIET_DISTANCE);
        angle = frand(0.0f, 2.0f * float(M_PI));
    }

    // In MovePositionToFirstCollision we have added owner's orientation
    // so now let's subtract it
    angle -= owner->GetOrientation();

    owner->MovePositionToFirstCollision(position, distance, angle);
}

template void FleeingMovementGenerator<Player>::DoInitialize(Player*);
template void FleeingMovementGenerator<Creature>::DoInitialize(Creature*);
template void FleeingMovementGenerator<Player>::DoReset(Player*);
template void FleeingMovementGenerator<Creature>::DoReset(Creature*);
template bool FleeingMovementGenerator<Player>::DoUpdate(Player*, uint32);
template bool FleeingMovementGenerator<Creature>::DoUpdate(Creature*, uint32);
template void FleeingMovementGenerator<Player>::SetTargetLocation(Player*);
template void FleeingMovementGenerator<Creature>::SetTargetLocation(Creature*);
template void FleeingMovementGenerator<Player>::GetPoint(Player*, Position&);
template void FleeingMovementGenerator<Creature>::GetPoint(Creature*, Position&);

void TimedFleeingMovementGenerator::Finalize(Unit* owner)
{
    owner->RemoveUnitFlag(UNIT_FLAG_FLEEING);
    owner->ClearUnitState(UNIT_STATE_FLEEING | UNIT_STATE_FLEEING_MOVE);

    if (Unit* victim = owner->GetVictim())
    {
        owner->SetTarget(victim->GetGUID());
    }

    if (Creature* ownerCreature = owner->ToCreature())
    {
        if (CreatureAI* AI = ownerCreature->AI())
        {
            AI->MovementInform(TIMED_FLEEING_MOTION_TYPE, 0);
        }
    }
}

bool TimedFleeingMovementGenerator::Update(Unit* owner, uint32 time_diff)
{
    if (!owner->IsAlive())
        return false;

    if (owner->HasUnitState(UNIT_STATE_NOT_MOVE) || owner->IsMovementPreventedByCasting())
    {
        owner->StopMoving();
        return true;
    }

    i_totalFleeTime.Update(time_diff);
    if (i_totalFleeTime.Passed())
        return false;

    // This calls grant-parent Update method hiden by FleeingMovementGenerator::Update(Creature &, uint32) version
    // This is done instead of casting Unit& to Creature& and call parent method, then we can use Unit directly
    return MovementGeneratorMedium< Creature, FleeingMovementGenerator<Creature> >::Update(owner, time_diff);
}
