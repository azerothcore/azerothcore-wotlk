/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "MotionMaster.h"
#include "CreatureAISelector.h"
#include "Creature.h"

#include "ConfusedMovementGenerator.h"
#include "FleeingMovementGenerator.h"
#include "HomeMovementGenerator.h"
#include "IdleMovementGenerator.h"
#include "PointMovementGenerator.h"
#include "TargetedMovementGenerator.h"
#include "WaypointMovementGenerator.h"
#include "RandomMovementGenerator.h"
#include "EscortMovementGenerator.h"
#include "MoveSpline.h"
#include "MoveSplineInit.h"
#include <cassert>

inline bool isStatic(MovementGenerator *mv)
{
    return (mv == &si_idleMovement);
}

void MotionMaster::Initialize()
{
    // clear ALL movement generators (including default)
    while (!empty())
    {
        MovementGenerator *curr = top();
        pop();
        if (curr) DirectDelete(curr);
    }

    InitDefault();
}

// set new default movement generator
void MotionMaster::InitDefault()
{
    // Xinef: Do not allow to initialize any motion generator for dead creatures
    if (_owner->GetTypeId() == TYPEID_UNIT && _owner->IsAlive())
    {
        MovementGenerator* movement = FactorySelector::selectMovementGenerator(_owner->ToCreature());
        Mutate(movement == NULL ? &si_idleMovement : movement, MOTION_SLOT_IDLE);
    }
    else
    {
        Mutate(&si_idleMovement, MOTION_SLOT_IDLE);
    }
}

MotionMaster::~MotionMaster()
{
    // clear ALL movement generators (including default)
    while (!empty())
    {
        MovementGenerator *curr = top();
        pop();
        if (curr && !isStatic(curr))
            delete curr;    // Skip finalizing on delete, it might launch new movement
    }
}

void MotionMaster::UpdateMotion(uint32 diff)
{
    if (!_owner)
        return;

    if (_owner->HasUnitState(UNIT_STATE_ROOT | UNIT_STATE_STUNNED)) // what about UNIT_STATE_DISTRACTED? Why is this not included?
    {
        // pussywizard: the same as at the bottom of this function
        if (_owner->GetTypeId() == TYPEID_PLAYER)
            _owner->UpdateUnderwaterState(_owner->GetMap(), _owner->GetPositionX(), _owner->GetPositionY(), _owner->GetPositionZ());
        else
            _owner->UpdateEnvironmentIfNeeded(0);

        return;
    }

    ASSERT(!empty());

    _cleanFlag |= MMCF_INUSE;

    _cleanFlag |= MMCF_UPDATE;
    if (!top()->Update(_owner, diff))
    {
        _cleanFlag &= ~MMCF_UPDATE;
        MovementExpired();
    }
    else
        _cleanFlag &= ~MMCF_UPDATE;

    if (_expList)
    {
        for (size_t i = 0; i < _expList->size(); ++i)
        {
            MovementGenerator* mg = (*_expList)[i];
            DirectDelete(mg);
        }

        delete _expList;
        _expList = NULL;

        if (empty())
            Initialize();
        else if (needInitTop())
            InitTop();
        else if (_cleanFlag & MMCF_RESET)
            top()->Reset(_owner);

        _cleanFlag &= ~MMCF_RESET;
    }

    _cleanFlag &= ~MMCF_INUSE;

    if (_owner->GetTypeId() == TYPEID_PLAYER)
        _owner->UpdateUnderwaterState(_owner->GetMap(), _owner->GetPositionX(), _owner->GetPositionY(), _owner->GetPositionZ());
    else
        _owner->UpdateEnvironmentIfNeeded(0);
}

void MotionMaster::DirectClean(bool reset)
{
    while (size() > 1)
    {
        MovementGenerator *curr = top();
        pop();
        if (curr) DirectDelete(curr);
    }

    if (empty())
        return;

    if (needInitTop())
        InitTop();
    else if (reset)
        top()->Reset(_owner);
}

void MotionMaster::DelayedClean()
{
    while (size() > 1)
    {
        MovementGenerator *curr = top();
        pop();
        if (curr) DelayedDelete(curr);
    }
}

void MotionMaster::DirectExpire(bool reset)
{
    if (size() > 1)
    {
        MovementGenerator *curr = top();
        pop();
        if (curr) DirectDelete(curr);
    }

    while (!empty() && !top())
        --_top;

    if (empty())
        Initialize();
    else if (needInitTop())
        InitTop();
    else if (reset)
        top()->Reset(_owner);
}

void MotionMaster::DelayedExpire()
{
    if (size() > 1)
    {
        MovementGenerator *curr = top();
        pop();
        if (curr) DelayedDelete(curr);
    }

    while (!empty() && !top())
        --_top;
}

void MotionMaster::DirectExpireSlot(MovementSlot slot, bool reset)
{
    if (size() > 1)
    {
        MovementGenerator *curr = Impl[slot];

        // pussywizard: clear slot AND decrease top immediately to avoid crashes when referencing null top in DirectDelete
        Impl[slot] = NULL;
        while (!empty() && !top())
            --_top;

        if (curr) DirectDelete(curr);
    }

    while (!empty() && !top())
        --_top;

    if (empty())
        Initialize();
    else if (needInitTop())
        InitTop();
    else if (reset)
        top()->Reset(_owner);
}

void MotionMaster::MoveIdle()
{
    //! Should be preceded by MovementExpired or Clear if there's an overlying movementgenerator active
    if (empty() || !isStatic(top()))
        Mutate(&si_idleMovement, MOTION_SLOT_IDLE);
}

void MotionMaster::MoveRandom(float spawndist)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->GetTypeId() == TYPEID_UNIT)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Creature (GUID: %u) start moving random", _owner->GetGUIDLow());
#endif
        Mutate(new RandomMovementGenerator<Creature>(spawndist), MOTION_SLOT_IDLE);
    }
}

void MotionMaster::MoveTargetedHome()
{
    Clear(false);

    if (_owner->GetTypeId() == TYPEID_UNIT && !_owner->ToCreature()->GetCharmerOrOwnerGUID())
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Creature (Entry: %u GUID: %u) targeted home", _owner->GetEntry(), _owner->GetGUIDLow());
#endif
        Mutate(new HomeMovementGenerator<Creature>(), MOTION_SLOT_ACTIVE);
    }
    else if (_owner->GetTypeId() == TYPEID_UNIT && _owner->ToCreature()->GetCharmerOrOwnerGUID())
    {
        _owner->ClearUnitState(UNIT_STATE_EVADE);
        // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
        if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
            return;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Pet or controlled creature (Entry: %u GUID: %u) targeting home", _owner->GetEntry(), _owner->GetGUIDLow());
#endif
        Unit* target = _owner->ToCreature()->GetCharmerOrOwner();
        if (target)
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outStaticDebug("Following %s (GUID: %u)", target->GetTypeId() == TYPEID_PLAYER ? "player" : "creature", target->GetTypeId() == TYPEID_PLAYER ? target->GetGUIDLow() : ((Creature*)target)->GetDBTableGUIDLow());
#endif
            Mutate(new FollowMovementGenerator<Creature>(target, PET_FOLLOW_DIST, _owner->GetFollowAngle()), MOTION_SLOT_ACTIVE);
        }
    }
    else
    {
        sLog->outError("Player (GUID: %u) attempt targeted home", _owner->GetGUIDLow());
    }
}

void MotionMaster::MoveConfused()
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->GetTypeId() == TYPEID_PLAYER)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Player (GUID: %u) move confused", _owner->GetGUIDLow());
#endif
        Mutate(new ConfusedMovementGenerator<Player>(), MOTION_SLOT_CONTROLLED);
    }
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Creature (Entry: %u GUID: %u) move confused", _owner->GetEntry(), _owner->GetGUIDLow());
#endif
        Mutate(new ConfusedMovementGenerator<Creature>(), MOTION_SLOT_CONTROLLED);
    }
}

void MotionMaster::MoveChase(Unit* target, float dist, float angle)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    // ignore movement request if target not exist
    if (!target || target == _owner || _owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    //_owner->ClearUnitState(UNIT_STATE_FOLLOW);
    if (_owner->GetTypeId() == TYPEID_PLAYER)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Player (GUID: %u) chase to %s (GUID: %u)",
            _owner->GetGUIDLow(),
            target->GetTypeId() == TYPEID_PLAYER ? "player" : "creature",
            target->GetTypeId() == TYPEID_PLAYER ? target->GetGUIDLow() : target->ToCreature()->GetDBTableGUIDLow());
#endif
        Mutate(new ChaseMovementGenerator<Player>(target, dist, angle), MOTION_SLOT_ACTIVE);
    }
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Creature (Entry: %u GUID: %u) chase to %s (GUID: %u)",
            _owner->GetEntry(), _owner->GetGUIDLow(),
            target->GetTypeId() == TYPEID_PLAYER ? "player" : "creature",
            target->GetTypeId() == TYPEID_PLAYER ? target->GetGUIDLow() : target->ToCreature()->GetDBTableGUIDLow());
#endif
        Mutate(new ChaseMovementGenerator<Creature>(target, dist, angle), MOTION_SLOT_ACTIVE);
    }
}

void MotionMaster::MoveFollow(Unit* target, float dist, float angle, MovementSlot slot)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    // ignore movement request if target not exist
    if (!target || target == _owner || _owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    //_owner->AddUnitState(UNIT_STATE_FOLLOW);
    if (_owner->GetTypeId() == TYPEID_PLAYER)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Player (GUID: %u) follow to %s (GUID: %u)", _owner->GetGUIDLow(),
            target->GetTypeId() == TYPEID_PLAYER ? "player" : "creature",
            target->GetTypeId() == TYPEID_PLAYER ? target->GetGUIDLow() : target->ToCreature()->GetDBTableGUIDLow());
#endif
        Mutate(new FollowMovementGenerator<Player>(target, dist, angle), slot);
    }
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Creature (Entry: %u GUID: %u) follow to %s (GUID: %u)",
            _owner->GetEntry(), _owner->GetGUIDLow(),
            target->GetTypeId() == TYPEID_PLAYER ? "player" : "creature",
            target->GetTypeId() == TYPEID_PLAYER ? target->GetGUIDLow() : target->ToCreature()->GetDBTableGUIDLow());
#endif
        Mutate(new FollowMovementGenerator<Creature>(target, dist, angle), slot);
    }
}

void MotionMaster::MovePoint(uint32 id, float x, float y, float z, bool generatePath, bool forceDestination, MovementSlot slot)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->GetTypeId() == TYPEID_PLAYER)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Player (GUID: %u) targeted point (Id: %u X: %f Y: %f Z: %f)", _owner->GetGUIDLow(), id, x, y, z);
#endif
        Mutate(new PointMovementGenerator<Player>(id, x, y, z, 0.0f, NULL, generatePath, forceDestination), slot);
    }
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Creature (Entry: %u GUID: %u) targeted point (ID: %u X: %f Y: %f Z: %f)",
            _owner->GetEntry(), _owner->GetGUIDLow(), id, x, y, z);
#endif
        Mutate(new PointMovementGenerator<Creature>(id, x, y, z, 0.0f, NULL, generatePath, forceDestination), slot);
    }
}

void MotionMaster::MoveSplinePath(Movement::PointsArray* path)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->GetTypeId() == TYPEID_PLAYER)
    {
        Mutate(new EscortMovementGenerator<Player>(path), MOTION_SLOT_ACTIVE);
    }
    else
    {
        Mutate(new EscortMovementGenerator<Creature>(path), MOTION_SLOT_ACTIVE);
    }
}

void MotionMaster::MoveLand(uint32 id, Position const& pos, float speed)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    float x, y, z;
    pos.GetPosition(x, y, z);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("Creature (Entry: %u) landing point (ID: %u X: %f Y: %f Z: %f)", _owner->GetEntry(), id, x, y, z);
#endif

    Movement::MoveSplineInit init(_owner);
    init.MoveTo(x, y, z);
    init.SetVelocity(speed);
    init.SetAnimation(Movement::ToGround);
    init.Launch();
    Mutate(new EffectMovementGenerator(id), MOTION_SLOT_ACTIVE);
}

void MotionMaster::MoveLand(uint32 id, float x, float y, float z, float speed)
{
    Position pos = {x, y, z, 0.0f};
    MoveLand(id, pos, speed);
}

void MotionMaster::MoveTakeoff(uint32 id, Position const& pos, float speed)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    float x, y, z;
    pos.GetPosition(x, y, z);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("Creature (Entry: %u) landing point (ID: %u X: %f Y: %f Z: %f)", _owner->GetEntry(), id, x, y, z);
#endif

    Movement::MoveSplineInit init(_owner);
    init.MoveTo(x, y, z);
    init.SetVelocity(speed);
    init.SetAnimation(Movement::ToFly);
    init.Launch();
    Mutate(new EffectMovementGenerator(id), MOTION_SLOT_ACTIVE);
}

void MotionMaster::MoveTakeoff(uint32 id, float x, float y, float z, float speed)
{
    Position pos = {x, y, z, 0.0f};
    MoveTakeoff(id, pos, speed);
}

void MotionMaster::MoveKnockbackFrom(float srcX, float srcY, float speedXY, float speedZ)
{
    //this function may make players fall below map
    if (_owner->GetTypeId() == TYPEID_PLAYER)
        return;

    if (speedXY <= 0.1f)
        return;

    float moveTimeHalf = speedZ / Movement::gravity;
    float dist = 2 * moveTimeHalf * speedXY;
    float max_height = -Movement::computeFallElevation(moveTimeHalf, false, -speedZ);

    Position pos;
    _owner->GetNearPoint(_owner, pos.m_positionX, pos.m_positionY, pos.m_positionZ, _owner->GetCombatReach(), dist, _owner->GetAngle(srcX, srcY) + M_PI);

    // xinef: check LoS!
    if (!_owner->IsWithinLOS(pos.m_positionX, pos.m_positionY, pos.m_positionZ))
    {
        _owner->GetPosition(&pos);
        _owner->MovePositionToFirstCollision(pos, dist, _owner->GetAngle(srcX, srcY) + M_PI);
    }

    Movement::MoveSplineInit init(_owner);
    init.MoveTo(pos.m_positionX, pos.m_positionY, pos.m_positionZ);
    init.SetParabolic(max_height, 0);
    init.SetOrientationFixed(true);
    init.SetVelocity(speedXY);
    init.Launch();
    Mutate(new EffectMovementGenerator(0), MOTION_SLOT_CONTROLLED);
}

void MotionMaster::MoveJumpTo(float angle, float speedXY, float speedZ)
{
    //this function may make players fall below map
    if (_owner->GetTypeId() == TYPEID_PLAYER)
        return;

    float x, y, z;

    float moveTimeHalf = speedZ / Movement::gravity;
    float dist = 2 * moveTimeHalf * speedXY;
    _owner->GetNearPoint2D(x, y, dist, _owner->GetOrientation() + angle);
    z = _owner->GetPositionZ();
    _owner->UpdateAllowedPositionZ(x, y, z);
    MoveJump(x, y, z, speedXY, speedZ);
}

void MotionMaster::MoveJump(float x, float y, float z, float speedXY, float speedZ, uint32 id, Unit const* target)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("Unit (GUID: %u) jump to point (X: %f Y: %f Z: %f)", _owner->GetGUIDLow(), x, y, z);
#endif

    if (speedXY <= 0.1f)
        return;

    float moveTimeHalf = speedZ / Movement::gravity;
    float max_height = -Movement::computeFallElevation(moveTimeHalf, false, -speedZ);

    Movement::MoveSplineInit init(_owner);
    init.MoveTo(x, y, z);
    init.SetParabolic(max_height, 0);
    init.SetVelocity(speedXY);
    if (target)
        init.SetFacing(target);
    init.Launch();
    Mutate(new EffectMovementGenerator(id), MOTION_SLOT_CONTROLLED);
}

void MotionMaster::MoveFall(uint32 id /*=0*/, bool addFlagForNPC)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    // use larger distance for vmap height search than in most other cases
    float tz = _owner->GetMapHeight(_owner->GetPositionX(), _owner->GetPositionY(), _owner->GetPositionZ(), true, MAX_FALL_DISTANCE);
    if (tz <= INVALID_HEIGHT)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("MotionMaster::MoveFall: unable retrive a proper height at map %u (x: %f, y: %f, z: %f).",
            _owner->GetMap()->GetId(), _owner->GetPositionX(), _owner->GetPositionX(), _owner->GetPositionZ() + _owner->GetPositionZ());
#endif
        return;
    }

    // Abort too if the ground is very near
    if (fabs(_owner->GetPositionZ() - tz) < 0.1f)
        return;

    if (_owner->GetTypeId() == TYPEID_PLAYER)
    {
        _owner->AddUnitMovementFlag(MOVEMENTFLAG_FALLING);
        _owner->m_movementInfo.SetFallTime(0);
        _owner->ToPlayer()->SetFallInformation(time(NULL), _owner->GetPositionZ());
    }
    else if (_owner->GetTypeId() == TYPEID_UNIT && addFlagForNPC) // pussywizard
    {
        _owner->RemoveUnitMovementFlag(MOVEMENTFLAG_MASK_MOVING);
        _owner->RemoveUnitMovementFlag(MOVEMENTFLAG_FLYING|MOVEMENTFLAG_CAN_FLY);
        _owner->AddUnitMovementFlag(MOVEMENTFLAG_FALLING);
        _owner->m_movementInfo.SetFallTime(0);
        _owner->SendMovementFlagUpdate();
    }

    Movement::MoveSplineInit init(_owner);
    init.MoveTo(_owner->GetPositionX(), _owner->GetPositionY(), tz);
    init.SetFall();
    init.Launch();
    Mutate(new EffectMovementGenerator(id), MOTION_SLOT_CONTROLLED);
}

void MotionMaster::MoveCharge(float x, float y, float z, float speed, uint32 id, const Movement::PointsArray* path, bool generatePath)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    if (Impl[MOTION_SLOT_CONTROLLED] && Impl[MOTION_SLOT_CONTROLLED]->GetMovementGeneratorType() != DISTRACT_MOTION_TYPE)
        return;

    if (_owner->GetTypeId() == TYPEID_PLAYER)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Player (GUID: %u) charge point (X: %f Y: %f Z: %f)", _owner->GetGUIDLow(), x, y, z);
#endif
        Mutate(new PointMovementGenerator<Player>(id, x, y, z, speed, path, generatePath, generatePath), MOTION_SLOT_CONTROLLED);
    }
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Creature (Entry: %u GUID: %u) charge point (X: %f Y: %f Z: %f)",
            _owner->GetEntry(), _owner->GetGUIDLow(), x, y, z);
#endif
        Mutate(new PointMovementGenerator<Creature>(id, x, y, z, speed, path, generatePath, generatePath), MOTION_SLOT_CONTROLLED);
    }
}

void MotionMaster::MoveSeekAssistance(float x, float y, float z)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->GetTypeId() == TYPEID_PLAYER)
    {
        sLog->outError("Player (GUID: %u) attempt to seek assistance", _owner->GetGUIDLow());
    }
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Creature (Entry: %u GUID: %u) seek assistance (X: %f Y: %f Z: %f)",
            _owner->GetEntry(), _owner->GetGUIDLow(), x, y, z);
#endif
        _owner->AttackStop();
        _owner->CastStop(0, false);
        _owner->ToCreature()->SetReactState(REACT_PASSIVE);
        Mutate(new AssistanceMovementGenerator(x, y, z), MOTION_SLOT_ACTIVE);
    }
}

void MotionMaster::MoveSeekAssistanceDistract(uint32 time)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->GetTypeId() == TYPEID_PLAYER)
    {
        sLog->outError("Player (GUID: %u) attempt to call distract after assistance", _owner->GetGUIDLow());
    }
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Creature (Entry: %u GUID: %u) is distracted after assistance call (Time: %u)",
            _owner->GetEntry(), _owner->GetGUIDLow(), time);
#endif
        Mutate(new AssistanceDistractMovementGenerator(time), MOTION_SLOT_ACTIVE);
    }
}

void MotionMaster::MoveFleeing(Unit* enemy, uint32 time)
{
    if (!enemy)
        return;

    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->GetTypeId() == TYPEID_PLAYER)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Player (GUID: %u) flee from %s (GUID: %u)", _owner->GetGUIDLow(),
            enemy->GetTypeId() == TYPEID_PLAYER ? "player" : "creature",
            enemy->GetTypeId() == TYPEID_PLAYER ? enemy->GetGUIDLow() : enemy->ToCreature()->GetDBTableGUIDLow());
#endif
        Mutate(new FleeingMovementGenerator<Player>(enemy->GetGUID()), MOTION_SLOT_CONTROLLED);
    }
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Creature (Entry: %u GUID: %u) flee from %s (GUID: %u)%s",
            _owner->GetEntry(), _owner->GetGUIDLow(),
            enemy->GetTypeId() == TYPEID_PLAYER ? "player" : "creature",
            enemy->GetTypeId() == TYPEID_PLAYER ? enemy->GetGUIDLow() : enemy->ToCreature()->GetDBTableGUIDLow(),
            time ? " for a limited time" : "");
#endif
        if (time)
            Mutate(new TimedFleeingMovementGenerator(enemy->GetGUID(), time), MOTION_SLOT_CONTROLLED);
        else
            Mutate(new FleeingMovementGenerator<Creature>(enemy->GetGUID()), MOTION_SLOT_CONTROLLED);
    }
}

void MotionMaster::MoveTaxiFlight(uint32 path, uint32 pathnode)
{
    if (_owner->GetTypeId() == TYPEID_PLAYER)
    {
        if (path < sTaxiPathNodesByPath.size())
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outStaticDebug("%s taxi to (Path %u node %u)", _owner->GetName().c_str(), path, pathnode);
#endif
            FlightPathMovementGenerator* mgen = new FlightPathMovementGenerator(pathnode);
            mgen->LoadPath(_owner->ToPlayer());
            Mutate(mgen, MOTION_SLOT_CONTROLLED);
        }
        else
        {
            sLog->outError("%s attempt taxi to (not existed Path %u node %u)",
            _owner->GetName().c_str(), path, pathnode);
        }
    }
    else
    {
        sLog->outError("Creature (Entry: %u GUID: %u) attempt taxi to (Path %u node %u)",
            _owner->GetEntry(), _owner->GetGUIDLow(), path, pathnode);
    }
}

void MotionMaster::MoveDistract(uint32 timer)
{
    if (Impl[MOTION_SLOT_CONTROLLED])
        return;

    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    /*if (_owner->GetTypeId() == TYPEID_PLAYER)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Player (GUID: %u) distracted (timer: %u)", _owner->GetGUIDLow(), timer);
#endif
    }
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Creature (Entry: %u GUID: %u) (timer: %u)",
#endif
            _owner->GetEntry(), _owner->GetGUIDLow(), timer);
    }*/

    DistractMovementGenerator* mgen = new DistractMovementGenerator(timer);
    Mutate(mgen, MOTION_SLOT_CONTROLLED);
}

void MotionMaster::Mutate(MovementGenerator *m, MovementSlot slot)
{
    while (MovementGenerator *curr = Impl[slot])
    {
        bool delayed = (_top == slot && (_cleanFlag & MMCF_UPDATE));

        // pussywizard: clear slot AND decrease top immediately to avoid crashes when referencing null top in DirectDelete
        Impl[slot] = NULL;
        while (!empty() && !top())
            --_top;

        if (delayed)
            DelayedDelete(curr);
        else
            DirectDelete(curr);
    }

    if (_top < slot)
        _top = slot;

    Impl[slot] = m;
    if (_top > slot)
        _needInit[slot] = true;
    else
    {
        _needInit[slot] = false;
        m->Initialize(_owner);
    }
}

void MotionMaster::MovePath(uint32 path_id, bool repeatable)
{
    if (!path_id)
        return;

    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
        return;

    //We set waypoint movement as new default movement generator
    // clear ALL movement generators (including default)
    /*while (!empty())
    {
        MovementGenerator *curr = top();
        curr->Finalize(*_owner);
        pop();
        if (!isStatic(curr))
            delete curr;
    }*/

    //_owner->GetTypeId() == TYPEID_PLAYER ?
        //Mutate(new WaypointMovementGenerator<Player>(path_id, repeatable)):
    Mutate(new WaypointMovementGenerator<Creature>(path_id, repeatable), MOTION_SLOT_IDLE);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outStaticDebug("%s (GUID: %u) start moving over path(Id:%u, repeatable: %s)",
        _owner->GetTypeId() == TYPEID_PLAYER ? "Player" : "Creature",
        _owner->GetGUIDLow(), path_id, repeatable ? "YES" : "NO");
#endif
}

void MotionMaster::MoveRotate(uint32 time, RotateDirection direction)
{
    if (!time)
        return;

    Mutate(new RotateMovementGenerator(time, direction), MOTION_SLOT_ACTIVE);
}

void MotionMaster::propagateSpeedChange()
{
    /*Impl::container_type::iterator it = Impl::c.begin();
    for (; it != end(); ++it)
    {
        (*it)->unitSpeedChanged();
    }*/
    for (int i = 0; i <= _top; ++i)
    {
        if (Impl[i])
            Impl[i]->unitSpeedChanged();
    }
}

void MotionMaster::ReinitializeMovement()
{
    for (int i = 0; i <= _top; ++i)
    {
        if (Impl[i])
            Impl[i]->Reset(_owner);
    }
}

MovementGeneratorType MotionMaster::GetCurrentMovementGeneratorType() const
{
   if (empty())
       return IDLE_MOTION_TYPE;

   return top()->GetMovementGeneratorType();
}

MovementGeneratorType MotionMaster::GetMotionSlotType(int slot) const
{
    if (!Impl[slot])
        return NULL_MOTION_TYPE;
    else
        return Impl[slot]->GetMovementGeneratorType();
}

// Xinef: Escort system
uint32 MotionMaster::GetCurrentSplineId() const
{
   if (empty())
       return 0;

   return top()->GetSplineId();
}

void MotionMaster::InitTop()
{
    top()->Initialize(_owner);
    _needInit[_top] = false;
}

void MotionMaster::DirectDelete(_Ty curr)
{
    if (isStatic(curr))
        return;
    curr->Finalize(_owner);
    delete curr;
}

void MotionMaster::DelayedDelete(_Ty curr)
{
    sLog->outCrash("Unit (Entry %u) is trying to delete its updating MG (Type %u)!", _owner->GetEntry(), curr->GetMovementGeneratorType());
    if (isStatic(curr))
        return;
    if (!_expList)
        _expList = new ExpireList();
    _expList->push_back(curr);
}

bool MotionMaster::GetDestination(float &x, float &y, float &z)
{
    if (_owner->movespline->Finalized())
        return false;

    G3D::Vector3 const& dest = _owner->movespline->FinalDestination();
    x = dest.x;
    y = dest.y;
    z = dest.z;
    return true;
}
