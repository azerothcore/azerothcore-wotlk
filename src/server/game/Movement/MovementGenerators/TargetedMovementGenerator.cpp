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

#include "TargetedMovementGenerator.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "MoveSplineInit.h"
#include "Pet.h"
#include "Player.h"
#include "Spell.h"
#include "Transport.h"

static bool IsMutualChase(Unit* owner, Unit* target)
{
    if (target->GetMotionMaster()->GetCurrentMovementGeneratorType() != CHASE_MOTION_TYPE)
        return false;

    return target->GetVictim() == owner;
}

template<class T>
bool ChaseMovementGenerator<T>::PositionOkay(T* owner, Unit* target, Optional<float> maxDistance, Optional<ChaseAngle> angle)
{
    float const distSq = owner->GetExactDistSq(target);
    if (maxDistance && distSq > G3D::square(*maxDistance))
        return false;
    if (angle && !angle->IsAngleOkay(target->GetRelativeAngle(owner)))
        return false;
    if (!owner->IsWithinLOSInMap(target))
        return false;
    return true;
}

template<class T>
bool ChaseMovementGenerator<T>::DoUpdate(T* owner, uint32 time_diff)
{
    if (!i_target.isValid() || !i_target->IsInWorld() || !owner->IsInMap(i_target.getTarget()))
        return false;

    if (!owner || !owner->IsAlive())
        return false;

    Creature* cOwner = owner->ToCreature();

    // the owner might be unable to move (rooted or casting), or we have lost the target, pause movement
    if (owner->HasUnitState(UNIT_STATE_NOT_MOVE) || HasLostTarget(owner) || (cOwner && cOwner->IsMovementPreventedByCasting()))
    {
        owner->StopMoving();
        _lastTargetPosition.reset();
        if (Creature* cOwner2 = owner->ToCreature())
        {
            cOwner2->SetCannotReachTarget();
        }

        return true;
    }

    bool forceDest =
        //(cOwner && (cOwner->isWorldBoss() || cOwner->IsDungeonBoss())) || // force for all bosses, even not in instances
        (i_target->GetTypeId() == TYPEID_PLAYER && i_target->ToPlayer()->IsGameMaster()) || // for .npc follow
        (owner->CanFly())
        ; // closes "bool forceDest", that way it is more appropriate, so we can comment out crap whenever we need to

    Unit* target = i_target.getTarget();

    bool const mutualChase = IsMutualChase(owner, target);
    float const hitboxSum = owner->GetCombatReach() + target->GetCombatReach();
    float const minTarget = (_range ? _range->MinTolerance : 0.0f) + hitboxSum;
    float const maxRange = _range ? _range->MaxRange + hitboxSum : owner->GetMeleeRange(target); // melee range already includes hitboxes
    float const maxTarget = _range ? _range->MaxTolerance + hitboxSum : CONTACT_DISTANCE + hitboxSum;
    Optional<ChaseAngle> angle = mutualChase ? Optional<ChaseAngle>() : _angle;

    i_recheckDistance.Update(time_diff);
    if (i_recheckDistance.Passed())
    {
        i_recheckDistance.Reset(100);

        if (i_recalculateTravel && PositionOkay(owner, target, _movingTowards ? maxTarget : Optional<float>(), angle))
        {
            if (Creature* cOwner2 = owner->ToCreature())
            {
                cOwner2->SetCannotReachTarget(i_path && i_path->GetPathType() & PATHFIND_INCOMPLETE ? target->GetGUID() : ObjectGuid::Empty);
            }

            i_recalculateTravel = false;
            i_path = nullptr;
            if (Creature* cOwner2 = owner->ToCreature())
            {
                cOwner2->SetCannotReachTarget(false);
            }

            owner->StopMoving();
            owner->SetInFront(target);
            MovementInform(owner);
            return true;
        }
    }

    if (owner->HasUnitState(UNIT_STATE_CHASE_MOVE) && owner->movespline->Finalized())
    {
        owner->ClearUnitState(UNIT_STATE_CHASE_MOVE);
        owner->SetInFront(target);
        MovementInform(owner);

        if (owner->IsWithinMeleeRange(this->i_target.getTarget()))
        {
            owner->Attack(this->i_target.getTarget(), true);
        }
        else if (i_path && i_path->GetPathType() & PATHFIND_INCOMPLETE)
        {
            if (Creature* cOwner2 = owner->ToCreature())
            {
                cOwner2->SetCannotReachTarget(this->i_target.getTarget()->GetGUID());
            }
        }

        i_recalculateTravel = false;
        i_path = nullptr;
    }

    if (_lastTargetPosition && i_target->GetPosition() == _lastTargetPosition.value() && mutualChase == _mutualChase)
        return true;

    _lastTargetPosition = i_target->GetPosition();

    if (PositionOkay(owner, target, maxRange, angle) && !owner->HasUnitState(UNIT_STATE_CHASE_MOVE))
        return true;

    float tarX, tarY, tarZ;
    target->GetPosition(tarX, tarY, tarZ);

    bool withinRange = owner->IsInDist(target, maxRange);
    bool withinLOS   = owner->IsWithinLOS(tarX, tarY, tarZ);
    bool moveToward  = !(withinRange && withinLOS);

    _mutualChase = mutualChase;

    if (owner->HasUnitState(UNIT_STATE_CHASE_MOVE))
    {
        // can we get to the target?
        if (cOwner && !target->isInAccessiblePlaceFor(cOwner))
        {
            cOwner->SetCannotReachTarget(target->GetGUID());
            cOwner->StopMoving();
            i_path = nullptr;
            return true;
        }
    }

    if (!i_path || moveToward != _movingTowards)
        i_path = std::make_unique<PathGenerator>(owner);
    else
        i_path->Clear();

    float x, y, z;
    bool shortenPath;
    // if we want to move toward the target and there's no fixed angle...
    if (moveToward && !angle)
    {
        // ...we'll pathfind to the center, then shorten the path
        target->GetPosition(x, y, z);
        shortenPath = true;
    }
    else
    {
        // otherwise, we fall back to nearpoint finding
        target->GetNearPoint(owner, x, y, z, (moveToward ? maxTarget : minTarget) - hitboxSum, 0, angle ? target->ToAbsoluteAngle(angle->RelativeAngle) : target->GetAngle(owner));
        shortenPath = false;
    }

    if (owner->IsHovering())
        owner->UpdateAllowedPositionZ(x, y, z);

    i_recalculateTravel = true;

    bool success = i_path->CalculatePath(x, y, z, forceDest);
    if (!success || i_path->GetPathType() & PATHFIND_NOPATH)
    {
        if (cOwner)
        {
            cOwner->SetCannotReachTarget(target->GetGUID());
        }

        return true;
    }

    if (shortenPath)
        i_path->ShortenPathUntilDist(G3D::Vector3(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ()), maxTarget);

    if (cOwner)
    {
        cOwner->SetCannotReachTarget();
    }

    bool walk = false;
    if (cOwner && !cOwner->IsPet())
    {
        switch (cOwner->GetMovementTemplate().GetChase())
        {
        case CreatureChaseMovementType::CanWalk:
            if (owner->IsWalking())
                walk = true;
            break;
        case CreatureChaseMovementType::AlwaysWalk:
            walk = true;
            break;
        default:
            break;
        }
    }

    owner->AddUnitState(UNIT_STATE_CHASE_MOVE);

    Movement::MoveSplineInit init(owner);
    init.MovebyPath(i_path->GetPath());
    init.SetFacing(target);
    init.SetWalk(walk);
    init.Launch();

    return true;
}

//-----------------------------------------------//
template<>
void ChaseMovementGenerator<Player>::DoInitialize(Player* owner)
{
    i_path = nullptr;
    _lastTargetPosition.reset();
    owner->StopMoving();
    owner->AddUnitState(UNIT_STATE_CHASE);
}

template<>
void ChaseMovementGenerator<Creature>::DoInitialize(Creature* owner)
{
    i_path = nullptr;
    _lastTargetPosition.reset();
    owner->SetWalk(false);
    owner->StopMoving();
    owner->AddUnitState(UNIT_STATE_CHASE);
}

template<class T>
void ChaseMovementGenerator<T>::DoFinalize(T* owner)
{
    owner->ClearUnitState(UNIT_STATE_CHASE | UNIT_STATE_CHASE_MOVE);
    if (Creature* cOwner = owner->ToCreature())
    {
        cOwner->SetCannotReachTarget();
    }
}

template<class T>
void ChaseMovementGenerator<T>::DoReset(T* owner)
{
    DoInitialize(owner);
}

template<class T>
void ChaseMovementGenerator<T>::MovementInform(T* owner)
{
    if (owner->GetTypeId() != TYPEID_UNIT)
        return;

    // Pass back the GUIDLow of the target. If it is pet's owner then PetAI will handle
    if (CreatureAI* AI = owner->ToCreature()->AI())
        AI->MovementInform(CHASE_MOTION_TYPE, i_target.getTarget()->GetGUID().GetCounter());
}

//-----------------------------------------------//

static Optional<float> GetVelocity(Unit* owner, Unit* target, G3D::Vector3 const& dest, bool playerPet)
{
    Optional<float> speed = {};
    if (!owner->IsInCombat() && !owner->IsVehicle() && !owner->HasUnitFlag(UNIT_FLAG_POSSESSED) &&
        (owner->IsPet() || owner->IsGuardian() || owner->GetGUID() == target->GetCritterGUID() || owner->GetCharmerOrOwnerGUID() == target->GetGUID()))
    {
        UnitMoveType moveType = Movement::SelectSpeedType(target->GetUnitMovementFlags());
        speed = std::max(target->GetSpeed(moveType), owner->GetSpeed(moveType));

        if (playerPet)
        {
            float distance = owner->GetDistance2d(dest.x, dest.y) - (*speed / 2.f);
            if (distance > 0.f)
            {
                float multiplier = 1.f + (distance / 10.f);
                *speed *= multiplier;
            }
            else
            {
                switch (moveType)
                {
                    case MOVE_RUN_BACK:
                    case MOVE_SWIM_BACK:
                    case MOVE_FLIGHT_BACK:
                        break;
                    default:
                        *speed *= 0.9f;
                        break;
                }
            }
        }
    }

    return speed;
}

static Position const PredictPosition(Unit* target)
{
    Position pos = target->GetPosition();

     // 0.5 - it's time (0.5 sec) between starting movement opcode (e.g. MSG_MOVE_START_FORWARD) and MSG_MOVE_HEARTBEAT sent by client
    float speed = target->GetSpeed(Movement::SelectSpeedType(target->GetUnitMovementFlags())) * 0.5f;
    float orientation = target->GetOrientation();

    if (target->m_movementInfo.HasMovementFlag(MOVEMENTFLAG_FORWARD))
    {
        pos.m_positionX += cos(orientation) * speed;
        pos.m_positionY += std::sin(orientation) * speed;
    }
    else if (target->m_movementInfo.HasMovementFlag(MOVEMENTFLAG_BACKWARD))
    {
        pos.m_positionX -= cos(orientation) * speed;
        pos.m_positionY -= std::sin(orientation) * speed;
    }

    if (target->m_movementInfo.HasMovementFlag(MOVEMENTFLAG_STRAFE_LEFT))
    {
        pos.m_positionX += cos(orientation + M_PI / 2.f) * speed;
        pos.m_positionY += std::sin(orientation + M_PI / 2.f) * speed;
    }
    else if (target->m_movementInfo.HasMovementFlag(MOVEMENTFLAG_STRAFE_RIGHT))
    {
        pos.m_positionX += cos(orientation - M_PI / 2.f) * speed;
        pos.m_positionY += std::sin(orientation - M_PI / 2.f) * speed;
    }

    return pos;
}

template<class T>
bool FollowMovementGenerator<T>::PositionOkay(Unit* target, bool isPlayerPet, bool& targetIsMoving, uint32 diff)
{
    if (!_lastTargetPosition)
        return false;

    float exactDistSq = target->GetExactDistSq(_lastTargetPosition->GetPositionX(), _lastTargetPosition->GetPositionY(), _lastTargetPosition->GetPositionZ());
    float distanceTolerance = 0.25f;
    // For creatures, increase tolerance
    if (target->GetTypeId() == TYPEID_UNIT)
    {
        distanceTolerance += _range + _range;
    }

    if (isPlayerPet)
    {
        targetIsMoving = target->m_movementInfo.HasMovementFlag(MOVEMENTFLAG_FORWARD | MOVEMENTFLAG_BACKWARD | MOVEMENTFLAG_STRAFE_LEFT | MOVEMENTFLAG_STRAFE_RIGHT);
    }

    if (exactDistSq > distanceTolerance)
        return false;

    if (isPlayerPet)
    {
        if (!targetIsMoving)
        {
            if (i_recheckPredictedDistanceTimer.GetExpiry())
            {
                i_recheckPredictedDistanceTimer.Update(diff);
                if (i_recheckPredictedDistanceTimer.Passed())
                {
                    i_recheckPredictedDistanceTimer = 0;
                    return false;
                }
            }

            return true;
        }

        return false;
    }

    return true;
}

template<class T>
bool FollowMovementGenerator<T>::DoUpdate(T* owner, uint32 time_diff)
{
    if (!i_target.isValid() || !i_target->IsInWorld() || !owner->IsInMap(i_target.getTarget()))
        return false;

    if (!owner || !owner->IsAlive())
        return false;

    Creature* cOwner = owner->ToCreature();
    Unit* target = i_target.getTarget();

    // the owner might be unable to move (rooted or casting), or we have lost the target, pause movement
    if (owner->HasUnitState(UNIT_STATE_NOT_MOVE) || (cOwner && owner->ToCreature()->IsMovementPreventedByCasting()))
    {
        i_path = nullptr;
        owner->StopMoving();
        owner->SetCannotReachTarget(false, false);
        _lastTargetPosition.reset();
        return true;
    }

    bool followingMaster = false;
    Pet* oPet = owner->ToPet();
    if (oPet)
    {
        if (target->GetGUID() == oPet->GetOwnerGUID())
            followingMaster = true;
    }

    bool forceDest =
        (followingMaster) || // allow pets following their master to cheat while generating paths
        (i_target->GetTypeId() == TYPEID_PLAYER && i_target->ToPlayer()->IsGameMaster()) // for .npc follow
        ; // closes "bool forceDest", that way it is more appropriate, so we can comment out crap whenever we need to

    bool targetIsMoving = false;
    if (PositionOkay(target, owner->IsGuardian() && target->GetTypeId() == TYPEID_PLAYER, targetIsMoving, time_diff))
    {
        if (owner->HasUnitState(UNIT_STATE_FOLLOW_MOVE) && owner->movespline->Finalized())
        {
            owner->ClearUnitState(UNIT_STATE_FOLLOW_MOVE);
            owner->SetCannotReachTarget(false, false);
            i_path = nullptr;
            MovementInform(owner);

            if (i_recheckPredictedDistance)
            {
                i_recheckPredictedDistanceTimer.Reset(1000);
            }

            owner->SetFacingTo(target->GetOrientation());
        }
    }
    else
    {
        Position targetPosition = target->GetPosition();
        _lastTargetPosition = targetPosition;

        // If player is moving and their position is not updated, we need to predict position
        if (targetIsMoving)
        {
            Position predictedPosition = PredictPosition(target);
            if (_lastPredictedPosition && _lastPredictedPosition->GetExactDistSq(&predictedPosition) < 0.25f)
                return true;

            _lastPredictedPosition = predictedPosition;
            targetPosition = predictedPosition;
            i_recheckPredictedDistance = true;
        }
        else
        {
            i_recheckPredictedDistance = false;
            i_recheckPredictedDistanceTimer.Reset(0);
        }

        if (!i_path)
            i_path = std::make_unique<PathGenerator>(owner);
        else
            i_path->Clear();

        target->MovePositionToFirstCollision(targetPosition, owner->GetCombatReach() + _range, target->ToAbsoluteAngle(_angle.RelativeAngle) - target->GetOrientation());

        float x, y, z;
        targetPosition.GetPosition(x, y, z);

        if (owner->IsHovering())
            owner->UpdateAllowedPositionZ(x, y, z);

        bool success = i_path->CalculatePath(x, y, z, forceDest);
        if (!success || (i_path->GetPathType() & PATHFIND_NOPATH && !followingMaster))
        {
            if (!owner->IsStopped())
                owner->StopMoving();

            owner->SetCannotReachTarget(true, false);

            return true;
        }

        owner->SetCannotReachTarget(false, false);

        owner->AddUnitState(UNIT_STATE_FOLLOW_MOVE);

        Movement::MoveSplineInit init(owner);
        init.MovebyPath(i_path->GetPath());
        init.SetWalk(target->IsWalking());
        if (Optional<float> velocity = GetVelocity(owner, target, i_path->GetActualEndPosition(), owner->IsGuardian() && target->GetTypeId() == TYPEID_PLAYER))
            init.SetVelocity(*velocity);
        init.Launch();
    }

    return true;
}

template<class T>
void FollowMovementGenerator<T>::DoInitialize(T* owner)
{
    i_path = nullptr;
    _lastTargetPosition.reset();
    owner->AddUnitState(UNIT_STATE_FOLLOW);
}

template<class T>
void FollowMovementGenerator<T>::DoFinalize(T* owner)
{
    owner->ClearUnitState(UNIT_STATE_FOLLOW | UNIT_STATE_FOLLOW_MOVE);
    owner->SetCannotReachTarget(false, false);
}

template<class T>
void FollowMovementGenerator<T>::DoReset(T* owner)
{
    DoInitialize(owner);
}

template<class T>
void FollowMovementGenerator<T>::MovementInform(T* owner)
{
    if (owner->GetTypeId() != TYPEID_UNIT)
        return;

    // Pass back the GUIDLow of the target. If it is pet's owner then PetAI will handle
    if (CreatureAI* AI = owner->ToCreature()->AI())
        AI->MovementInform(FOLLOW_MOTION_TYPE, i_target.getTarget()->GetGUID().GetCounter());
}

//-----------------------------------------------//

template void ChaseMovementGenerator<Player>::DoFinalize(Player*);
template void ChaseMovementGenerator<Creature>::DoFinalize(Creature*);
template void ChaseMovementGenerator<Player>::DoReset(Player*);
template void ChaseMovementGenerator<Creature>::DoReset(Creature*);
template bool ChaseMovementGenerator<Player>::DoUpdate(Player*, uint32);
template bool ChaseMovementGenerator<Creature>::DoUpdate(Creature*, uint32);
template void ChaseMovementGenerator<Unit>::MovementInform(Unit*);

template void FollowMovementGenerator<Player>::DoInitialize(Player*);
template void FollowMovementGenerator<Creature>::DoInitialize(Creature*);
template void FollowMovementGenerator<Player>::DoFinalize(Player*);
template void FollowMovementGenerator<Creature>::DoFinalize(Creature*);
template void FollowMovementGenerator<Player>::DoReset(Player*);
template void FollowMovementGenerator<Creature>::DoReset(Creature*);
template bool FollowMovementGenerator<Player>::DoUpdate(Player*, uint32);
template bool FollowMovementGenerator<Creature>::DoUpdate(Creature*, uint32);
