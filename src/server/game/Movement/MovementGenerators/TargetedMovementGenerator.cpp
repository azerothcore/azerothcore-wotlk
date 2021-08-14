/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Creature.h"
#include "CreatureAI.h"
#include "MoveSplineInit.h"
#include "Pet.h"
#include "Player.h"
#include "Spell.h"
#include "TargetedMovementGenerator.h"
#include "Transport.h"

static bool IsMutualChase(Unit* owner, Unit* target)
{
    if (target->GetMotionMaster()->GetCurrentMovementGeneratorType() != CHASE_MOTION_TYPE)
        return false;

    return target->GetVictim() == owner;
}

template<class T>
bool ChaseMovementGenerator<T>::PositionOkay(T* owner, Unit* target, std::optional<float> maxDistance, std::optional<ChaseAngle> angle)
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
            cOwner2->SetCannotReachTarget(false);
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
    std::optional<ChaseAngle> angle = mutualChase ? std::optional<ChaseAngle>() : _angle;

    i_recheckDistance.Update(time_diff);
    if (i_recheckDistance.Passed())
    {
        i_recheckDistance.Reset(100);

        if (i_recalculateTravel && PositionOkay(owner, target, _movingTowards ? maxTarget : std::optional<float>(), angle))
        {
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
        i_recalculateTravel = false;
        i_path = nullptr;
        owner->ClearUnitState(UNIT_STATE_CHASE_MOVE);
        owner->SetInFront(target);
        MovementInform(owner);

        if (owner->IsWithinMeleeRange(this->i_target.getTarget()))
            owner->Attack(this->i_target.getTarget(), true);
    }

    if (_lastTargetPosition && i_target->GetPosition() == _lastTargetPosition.value() && mutualChase == _mutualChase)
        return true;

    _lastTargetPosition = i_target->GetPosition();

    if (PositionOkay(owner, target, maxRange, angle) && !owner->HasUnitState(UNIT_STATE_CHASE_MOVE))
        return true;

    bool moveToward = !owner->IsInDist(target, maxRange);
    _mutualChase = mutualChase;

    if (owner->HasUnitState(UNIT_STATE_CHASE_MOVE))
    {
        // can we get to the target?
        if (cOwner && !target->isInAccessiblePlaceFor(cOwner))
        {
            cOwner->SetCannotReachTarget(true);
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
            cOwner->SetCannotReachTarget(true);
        return true;
    }

    if (shortenPath)
        i_path->ShortenPathUntilDist(G3D::Vector3(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ()), maxTarget);

    if (cOwner)
        cOwner->SetCannotReachTarget(false);

    bool walk = false;
    if (cOwner && !cOwner->IsPet())
    {
        walk = owner->IsWalking();
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
    owner->AddUnitState(UNIT_STATE_CHASE);
}

template<>
void ChaseMovementGenerator<Creature>::DoInitialize(Creature* owner)
{
    i_path = nullptr;
    _lastTargetPosition.reset();
    owner->SetWalk(false);
    owner->AddUnitState(UNIT_STATE_CHASE);
}

template<class T>
void ChaseMovementGenerator<T>::DoFinalize(T* owner)
{
    owner->ClearUnitState(UNIT_STATE_CHASE | UNIT_STATE_CHASE_MOVE);
    if (Creature* cOwner = owner->ToCreature())
        cOwner->SetCannotReachTarget(false);
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

template<class T>
bool FollowMovementGenerator<T>::PositionOkay(Unit* target)
{
    if (!_lastTargetPosition)
        return false;

    float exactDistSq = target->GetExactDistSq(_lastTargetPosition->GetPositionX(), _lastTargetPosition->GetPositionY(), _lastTargetPosition->GetPositionZ());
    float distanceTolerance = 0.25f;
    // For creatures, increase tolerance
    if (target->GetTypeId() == TYPEID_UNIT)
    {
        distanceTolerance += _range;
    }

    return exactDistSq <= distanceTolerance;
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

    if (PositionOkay(target))
    {
        if (owner->HasUnitState(UNIT_STATE_FOLLOW_MOVE) && owner->movespline->Finalized())
        {
            owner->ClearUnitState(UNIT_STATE_FOLLOW_MOVE);
            i_path = nullptr;
            MovementInform(owner);
        }
    }
    else
    {
        _lastTargetPosition = target->GetPosition();

        if (!i_path)
            i_path = std::make_unique<PathGenerator>(owner);
        else
            i_path->Clear();

        float distance = _range - target->GetCombatReach();

        float relAngle = _angle.RelativeAngle;
        float x, y, z;
        target->GetNearPoint(owner, x, y, z, owner->GetCombatReach(), distance, target->ToAbsoluteAngle(relAngle));

        if (owner->IsHovering())
            owner->UpdateAllowedPositionZ(x, y, z);

        bool success = i_path->CalculatePath(x, y, z, forceDest);
        if (!success || i_path->GetPathType() & PATHFIND_NOPATH)
        {
            if (!owner->IsStopped())
                owner->StopMoving();

            return true;
        }

        owner->AddUnitState(UNIT_STATE_FOLLOW_MOVE);

        Movement::MoveSplineInit init(owner);
        init.MovebyPath(i_path->GetPath());
        init.SetFacing(target->GetOrientation());
        init.SetWalk(target->IsWalking());
        init.Launch();
    }

    return true;
}

template<>
void FollowMovementGenerator<Player>::_updateSpeed(Player* /*owner*/)
{
    // nothing to do for Player
}

template<>
void FollowMovementGenerator<Creature>::_updateSpeed(Creature* owner)
{
    // pet only sync speed with owner
    /// Make sure we are not in the process of a map change (IsInWorld)
    if (!owner->GetOwnerGUID().IsPlayer() || !owner->IsInWorld() || !i_target.isValid() || i_target->GetGUID() != owner->GetOwnerGUID())
        return;

    owner->UpdateSpeed(MOVE_RUN, true);
    owner->UpdateSpeed(MOVE_WALK, true);
    owner->UpdateSpeed(MOVE_SWIM, true);
}

template<class T>
void FollowMovementGenerator<T>::DoInitialize(T* owner)
{
    i_path = nullptr;
    _lastTargetPosition.reset();
    owner->AddUnitState(UNIT_STATE_FOLLOW);
    _updateSpeed(owner);
}

template<class T>
void FollowMovementGenerator<T>::DoFinalize(T* owner)
{
    owner->ClearUnitState(UNIT_STATE_FOLLOW | UNIT_STATE_FOLLOW_MOVE);
    _updateSpeed(owner);
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
