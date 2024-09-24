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

#include "MotionMaster.h"
#include "ConfusedMovementGenerator.h"
#include "Creature.h"
#include "CreatureAISelector.h"
#include "EscortMovementGenerator.h"
#include "FleeingMovementGenerator.h"
#include "GameTime.h"
#include "HomeMovementGenerator.h"
#include "IdleMovementGenerator.h"
#include "Log.h"
#include "MoveSpline.h"
#include "MoveSplineInit.h"
#include "PointMovementGenerator.h"
#include "RandomMovementGenerator.h"
#include "TargetedMovementGenerator.h"
#include "WaypointMgr.h"
#include "WaypointMovementGenerator.h"

inline MovementGenerator* GetIdleMovementGenerator()
{
    return sMovementGeneratorRegistry->GetRegistryItem(IDLE_MOTION_TYPE)->Create();
}

 // ---- ChaseRange ---- //

ChaseRange::ChaseRange(float range) : MinRange(range > CONTACT_DISTANCE ? 0 : range - CONTACT_DISTANCE), MinTolerance(range), MaxRange(range + CONTACT_DISTANCE), MaxTolerance(range) { }
ChaseRange::ChaseRange(float _minRange, float _maxRange) : MinRange(_minRange), MinTolerance(std::min(_minRange + CONTACT_DISTANCE, (_minRange + _maxRange) / 2)), MaxRange(_maxRange), MaxTolerance(std::max(_maxRange - CONTACT_DISTANCE, MinTolerance)) { }
ChaseRange::ChaseRange(float _minRange, float _minTolerance, float _maxTolerance, float _maxRange) : MinRange(_minRange), MinTolerance(_minTolerance), MaxRange(_maxRange), MaxTolerance(_maxTolerance) { }

// ---- ChaseAngle ---- //

ChaseAngle::ChaseAngle(float angle, float _tolerance/* = M_PI_4*/) : RelativeAngle(Position::NormalizeOrientation(angle)), Tolerance(_tolerance) { }

float ChaseAngle::UpperBound() const
{
    return Position::NormalizeOrientation(RelativeAngle + Tolerance);
}

float ChaseAngle::LowerBound() const
{
    return Position::NormalizeOrientation(RelativeAngle - Tolerance);
}

bool ChaseAngle::IsAngleOkay(float relativeAngle) const
{
    float const diff = std::abs(relativeAngle - RelativeAngle);

    return (std::min(diff, float(2 * M_PI) - diff) <= Tolerance);
}

inline bool isStatic(MovementGenerator* movement)
{
    return (movement == GetIdleMovementGenerator());
}

void MotionMaster::Initialize()
{
    // clear ALL movement generators (including default)
    while (!empty())
    {
        MovementGenerator* curr = top();
        pop();
        if (curr) DirectDelete(curr);
    }

    InitDefault();
}

// set new default movement generator
void MotionMaster::InitDefault()
{
    Mutate(FactorySelector::SelectMovementGenerator(_owner), MOTION_SLOT_IDLE);
}

MotionMaster::~MotionMaster()
{
    // clear ALL movement generators (including default)
    while (!empty())
    {
        MovementGenerator* curr = top();
        pop();
        if (curr && !isStatic(curr))
            delete curr;    // Skip finalizing on delete, it might launch new movement
    }
}

void MotionMaster::UpdateMotion(uint32 diff)
{
    if (!_owner)
        return;

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
        for (std::size_t i = 0; i < _expList->size(); ++i)
        {
            MovementGenerator* mg = (*_expList)[i];
            DirectDelete(mg);
        }

        delete _expList;
        _expList = nullptr;

        if (empty())
            Initialize();
        else if (needInitTop())
            InitTop();
        else if (_cleanFlag & MMCF_RESET)
            top()->Reset(_owner);

        _cleanFlag &= ~MMCF_RESET;
    }

    _cleanFlag &= ~MMCF_INUSE;
}

void MotionMaster::DirectClean(bool reset)
{
    while (size() > 1)
    {
        MovementGenerator* curr = top();
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
        MovementGenerator* curr = top();
        pop();
        if (curr) DelayedDelete(curr);
    }
}

void MotionMaster::DirectExpire(bool reset)
{
    if (size() > 1)
    {
        MovementGenerator* curr = top();
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
        MovementGenerator* curr = top();
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
        MovementGenerator* curr = Impl[slot];

        // pussywizard: clear slot AND decrease top immediately to avoid crashes when referencing null top in DirectDelete
        Impl[slot] = nullptr;
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
        Mutate(GetIdleMovementGenerator(), MOTION_SLOT_IDLE);
}

/**
 * @brief Enable a random movement in desired range around the unit. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MoveRandom(float wanderDistance)
{
    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->IsCreature())
    {
        LOG_DEBUG("movement.motionmaster", "Creature ({}) start moving random", _owner->GetGUID().ToString());
        Mutate(new RandomMovementGenerator<Creature>(wanderDistance), MOTION_SLOT_IDLE);
    }
}

/**
 * @brief The unit will return this initial position (owner for pets and summoned creatures). Doesn't work with UNIT_FLAG_DISABLE_MOVE
 *
 * @param walk The unit will run by default, but you can set it to walk
 */
void MotionMaster::MoveTargetedHome(bool walk /*= false*/)
{
    Clear(false);

    if (_owner->IsCreature() && !_owner->ToCreature()->GetCharmerOrOwnerGUID())
    {
        LOG_DEBUG("movement.motionmaster", "Creature ({}) targeted home", _owner->GetGUID().ToString());
        Mutate(new HomeMovementGenerator<Creature>(walk), MOTION_SLOT_ACTIVE);
    }
    else if (_owner->IsCreature() && _owner->ToCreature()->GetCharmerOrOwnerGUID())
    {
        _owner->ClearUnitState(UNIT_STATE_EVADE);

        if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
            return;

        LOG_DEBUG("movement.motionmaster", "Pet or controlled creature ({}) targeting home", _owner->GetGUID().ToString());
        Unit* target = _owner->ToCreature()->GetCharmerOrOwner();
        if (target)
        {
            LOG_DEBUG("movement.motionmaster", "Following {} ({})", target->IsPlayer() ? "player" : "creature", target->GetGUID().ToString());
            Mutate(new FollowMovementGenerator<Creature>(target, PET_FOLLOW_DIST, _owner->GetFollowAngle(),true), MOTION_SLOT_ACTIVE);
        }
    }
    else
    {
        LOG_ERROR("movement.motionmaster", "Player ({}) attempt targeted home", _owner->GetGUID().ToString());
    }
}

/**
 * @brief Enable the confusion movement. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MoveConfused()
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->IsPlayer())
    {
        LOG_DEBUG("movement.motionmaster", "Player ({}) move confused", _owner->GetGUID().ToString());
        Mutate(new ConfusedMovementGenerator<Player>(), MOTION_SLOT_CONTROLLED);
    }
    else
    {
        LOG_DEBUG("movement.motionmaster", "Creature ({}) move confused", _owner->GetGUID().ToString());
        Mutate(new ConfusedMovementGenerator<Creature>(), MOTION_SLOT_CONTROLLED);
    }
}

/**
 * @brief Force the unit to chase this target. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MoveChase(Unit* target,  std::optional<ChaseRange> dist, std::optional<ChaseAngle> angle)
{
    // ignore movement request if target not exist
    if (!target || target == _owner || _owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    //_owner->ClearUnitState(UNIT_STATE_FOLLOW);
    if (_owner->IsPlayer())
    {
        LOG_DEBUG("movement.motionmaster", "Player ({}) chase to {} ({})",
            _owner->GetGUID().ToString(), target->IsPlayer() ? "player" : "creature", target->GetGUID().ToString());
        Mutate(new ChaseMovementGenerator<Player>(target, dist, angle), MOTION_SLOT_ACTIVE);
    }
    else
    {
        LOG_DEBUG("movement.motionmaster", "Creature ({}) chase to {} ({})",
            _owner->GetGUID().ToString(), target->IsPlayer() ? "player" : "creature", target->GetGUID().ToString());
        Mutate(new ChaseMovementGenerator<Creature>(target, dist, angle), MOTION_SLOT_ACTIVE);
    }
}

void MotionMaster::MoveBackwards(Unit* target, float dist)
{
    if (!target)
    {
        return;
    }

    Position const& pos = target->GetPosition();
    float angle = target->GetAngle(_owner);
    G3D::Vector3 point;
    point.x = pos.m_positionX + dist * cosf(angle);
    point.y = pos.m_positionY + dist * sinf(angle);
    point.z = pos.m_positionZ;

    if (!_owner->GetMap()->CanReachPositionAndGetValidCoords(_owner, point.x, point.y, point.z, true, true))
    {
        return;
    }

    Movement::MoveSplineInit init(_owner);
    init.MoveTo(point.x, point.y, point.z, false);
    init.SetFacing(target);
    init.SetOrientationInversed();
    init.Launch();
}

void MotionMaster::MoveForwards(Unit* target, float dist)
{
    //like movebackwards, but without the inversion
    if (!target)
    {
        return;
    }

    Position const& pos = target->GetPosition();
    float angle = target->GetAngle(_owner);
    G3D::Vector3 point;
    point.x = pos.m_positionX + dist * cosf(angle);
    point.y = pos.m_positionY + dist * sinf(angle);
    point.z = pos.m_positionZ;

    if (!_owner->GetMap()->CanReachPositionAndGetValidCoords(_owner, point.x, point.y, point.z, true, true))
    {
        return;
    }

    Movement::MoveSplineInit init(_owner);
    init.MoveTo(point.x, point.y, point.z, false);
    init.SetFacing(target);
    init.Launch();
}

void MotionMaster::MoveCircleTarget(Unit* target)
{
    if (!target)
    {
        return;
    }

    Position pos;
    if (!target->GetMeleeAttackPoint(_owner, pos))
    {
        return;
    }

    Movement::MoveSplineInit init(_owner);
    init.MoveTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), false);
    init.SetWalk(true);
    init.SetFacing(target);
    init.Launch();
}

/**
 * @brief The unit will follow this target. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MoveFollow(Unit* target, float dist, float angle, MovementSlot slot, bool inheritWalkState)
{
    // ignore movement request if target not exist
    if (!target || target == _owner || _owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
    {
        return;
    }

    //_owner->AddUnitState(UNIT_STATE_FOLLOW);
    if (_owner->IsPlayer())
    {
        LOG_DEBUG("movement.motionmaster", "Player ({}) follow to {} ({})",
            _owner->GetGUID().ToString(), target->IsPlayer() ? "player" : "creature", target->GetGUID().ToString());
        Mutate(new FollowMovementGenerator<Player>(target, dist, angle, inheritWalkState), slot);
    }
    else
    {
        LOG_DEBUG("movement.motionmaster", "Creature ({}) follow to {} ({})",
            _owner->GetGUID().ToString(), target->IsPlayer() ? "player" : "creature", target->GetGUID().ToString());
        Mutate(new FollowMovementGenerator<Creature>(target, dist, angle, inheritWalkState), slot);
    }
}

/**
 * @brief The unit will move to a specific point. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 *
 * For transition movement between the ground and the air, use MoveLand or MoveTakeoff instead.
 */
void MotionMaster::MovePoint(uint32 id, float x, float y, float z, bool generatePath, bool forceDestination, MovementSlot slot, float orientation /* = 0.0f*/)
{
    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->IsPlayer())
    {
        LOG_DEBUG("movement.motionmaster", "Player ({}) targeted point (Id: {} X: {} Y: {} Z: {})", _owner->GetGUID().ToString(), id, x, y, z);
        Mutate(new PointMovementGenerator<Player>(id, x, y, z, 0.0f, orientation, nullptr, generatePath, forceDestination), slot);
    }
    else
    {
        LOG_DEBUG("movement.motionmaster", "Creature ({}) targeted point (ID: {} X: {} Y: {} Z: {})", _owner->GetGUID().ToString(), id, x, y, z);
        Mutate(new PointMovementGenerator<Creature>(id, x, y, z, 0.0f, orientation, nullptr, generatePath, forceDestination), slot);
    }
}

void MotionMaster::MoveSplinePath(Movement::PointsArray* path)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->IsPlayer())
    {
        Mutate(new EscortMovementGenerator<Player>(path), MOTION_SLOT_ACTIVE);
    }
    else
    {
        Mutate(new EscortMovementGenerator<Creature>(path), MOTION_SLOT_ACTIVE);
    }
}

void MotionMaster::MoveSplinePath(uint32 path_id)
{
    // convert the path id to a Movement::PointsArray*
    Movement::PointsArray* points = new Movement::PointsArray();
    WaypointPath const* path = sWaypointMgr->GetPath(path_id);
    for (uint8 i = 0; i < path->size(); ++i)
    {
        WaypointData const* node = path->at(i);
        points->push_back(G3D::Vector3(node->x, node->y, node->z));
    }

    // pass the new PointsArray* to the appropriate MoveSplinePath function
    MoveSplinePath(points);
}

/**
 * @brief Use to move the unit from the air to the ground. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MoveLand(uint32 id, Position const& pos, float speed /* = 0.0f*/)
{
    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    float x, y, z;
    pos.GetPosition(x, y, z);

    LOG_DEBUG("movement.motionmaster", "Creature (Entry: {}) landing point (ID: {} X: {} Y: {} Z: {})", _owner->GetEntry(), id, x, y, z);

    Movement::MoveSplineInit init(_owner);
    init.MoveTo(x, y, z);

    if (speed > 0.0f)
    {
        init.SetVelocity(speed);
    }

    init.SetAnimation(Movement::ToGround);
    init.Launch();
    Mutate(new EffectMovementGenerator(id), MOTION_SLOT_ACTIVE);
}

/**
 * @brief Use to move the unit from the air to the ground. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MoveLand(uint32 id, float x, float y, float z, float speed /* = 0.0f*/)
{
    Position pos = {x, y, z, 0.0f};
    MoveLand(id, pos, speed);
}

/**
 * @brief Use to move the unit from the ground to the air. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MoveTakeoff(uint32 id, Position const& pos, float speed /* = 0.0f*/, bool skipAnimation)
{
    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    float x, y, z;
    pos.GetPosition(x, y, z);

    LOG_DEBUG("movement.motionmaster", "Creature (Entry: {}) landing point (ID: {} X: {} Y: {} Z: {})", _owner->GetEntry(), id, x, y, z);

    Movement::MoveSplineInit init(_owner);
    init.MoveTo(x, y, z);

    if (speed > 0.0f)
    {
        init.SetVelocity(speed);
    }

    if (!skipAnimation)
    {
        init.SetAnimation(Movement::ToFly);
    }
    init.Launch();
    Mutate(new EffectMovementGenerator(id), MOTION_SLOT_ACTIVE);
}

/**
 * @brief Use to move the unit from the air to the ground. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MoveTakeoff(uint32 id, float x, float y, float z, float speed /* = 0.0f*/, bool skipAnimation)
{
    Position pos = {x, y, z, 0.0f};
    MoveTakeoff(id, pos, speed, skipAnimation);
}

void MotionMaster::MoveKnockbackFrom(float srcX, float srcY, float speedXY, float speedZ)
{
    //this function may make players fall below map
    if (_owner->IsPlayer())
        return;

    if (speedXY <= 0.1f)
        return;

     Position dest = _owner->GetPosition();
    float moveTimeHalf = speedZ / Movement::gravity;
    float dist = 2 * moveTimeHalf * speedXY;
    float max_height = -Movement::computeFallElevation(moveTimeHalf, false, -speedZ);

    // Use a mmap raycast to get a valid destination.
    _owner->MovePositionToFirstCollision(dest, dist, _owner->GetRelativeAngle(srcX, srcY) + float(M_PI));

    Movement::MoveSplineInit init(_owner);
    init.MoveTo(dest.GetPositionX(), dest.GetPositionY(), dest.GetPositionZ());
    init.SetParabolic(max_height, 0);
    init.SetOrientationFixed(true);
    init.SetVelocity(speedXY);
    init.Launch();
    Mutate(new EffectMovementGenerator(0), MOTION_SLOT_CONTROLLED);
}

/**
 * @brief The unit will jump in a specific direction
 */
void MotionMaster::MoveJumpTo(float angle, float speedXY, float speedZ)
{
    //this function may make players fall below map
    if (_owner->IsPlayer())
        return;

    float x, y, z;

    float moveTimeHalf = speedZ / Movement::gravity;
    float dist = 2 * moveTimeHalf * speedXY;
    _owner->GetClosePoint(x, y, z, _owner->GetObjectSize(), dist, angle);
    MoveJump(x, y, z, speedXY, speedZ);
}

/**
 * @brief The unit will jump to a specific point
 */
void MotionMaster::MoveJump(float x, float y, float z, float speedXY, float speedZ, uint32 id, Unit const* target)
{
    LOG_DEBUG("movement.motionmaster", "Unit ({}) jump to point (X: {} Y: {} Z: {})", _owner->GetGUID().ToString(), x, y, z);

    if (speedXY <= 0.1f)
        return;

    //npcbot: blademaser only (disabled)
    /*
    if (_owner->IsNPCBot())
    {
        Movement::MoveSplineInit init(_owner);
        init.MoveTo(x, y, z, false);
        init.SetParabolic(speedZ, 0);
        init.SetFacing(o);
        init.SetOrientationFixed(true);
        init.SetVelocity(speedXY);

        GenericMovementGenerator* movement = new GenericMovementGenerator(std::move(init), EFFECT_MOTION_TYPE, EVENT_JUMP);
        movement->Priority = MOTION_PRIORITY_HIGHEST;
        movement->BaseUnitState = UNIT_STATE_JUMPING;
        Add(movement);
        return;
    }
    */
    //end npcbot

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

/**
 * @brief The unit will fall. Used when in the air. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MoveFall(uint32 id /*=0*/, bool addFlagForNPC)
{
    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    // use larger distance for vmap height search than in most other cases
    float tz = _owner->GetMapHeight(_owner->GetPositionX(), _owner->GetPositionY(), _owner->GetPositionZ(), true, MAX_FALL_DISTANCE);
    if (tz <= INVALID_HEIGHT)
    {
        LOG_DEBUG("movement.motionmaster", "MotionMaster::MoveFall: unable retrive a proper height at map {} (x: {}, y: {}, z: {}).",
                             _owner->GetMap()->GetId(), _owner->GetPositionX(), _owner->GetPositionX(), _owner->GetPositionZ() + _owner->GetPositionZ());
        return;
    }

    // Abort too if the ground is very near
    if (std::fabs(_owner->GetPositionZ() - tz) < 0.1f)
        return;

    if (_owner->IsPlayer())
    {
        _owner->AddUnitMovementFlag(MOVEMENTFLAG_FALLING);
        _owner->m_movementInfo.SetFallTime(0);
        _owner->ToPlayer()->SetFallInformation(GameTime::GetGameTime().count(), _owner->GetPositionZ());
    }
    else if (_owner->IsCreature() && addFlagForNPC) // pussywizard
    {
        _owner->RemoveUnitMovementFlag(MOVEMENTFLAG_MASK_MOVING);
        _owner->RemoveUnitMovementFlag(MOVEMENTFLAG_FLYING | MOVEMENTFLAG_CAN_FLY);
        _owner->AddUnitMovementFlag(MOVEMENTFLAG_FALLING);
        _owner->m_movementInfo.SetFallTime(0);
        _owner->SendMovementFlagUpdate();
    }

    Movement::MoveSplineInit init(_owner);
    init.MoveTo(_owner->GetPositionX(), _owner->GetPositionY(), tz + _owner->GetHoverHeight());
    init.SetFall();
    init.Launch();
    Mutate(new EffectMovementGenerator(id), MOTION_SLOT_CONTROLLED);
}

/**
 * @brief The unit will charge the target. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MoveCharge(float x, float y, float z, float speed, uint32 id, const Movement::PointsArray* path, bool generatePath, float orientation /* = 0.0f*/, ObjectGuid targetGUID /*= ObjectGuid::Empty*/)
{
    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    if (Impl[MOTION_SLOT_CONTROLLED] && Impl[MOTION_SLOT_CONTROLLED]->GetMovementGeneratorType() != DISTRACT_MOTION_TYPE)
        return;

    if (_owner->IsPlayer())
    {
        LOG_DEBUG("movement.motionmaster", "Player ({}) charge point (X: {} Y: {} Z: {})", _owner->GetGUID().ToString(), x, y, z);
        Mutate(new PointMovementGenerator<Player>(id, x, y, z, speed, orientation, path, generatePath, generatePath, targetGUID), MOTION_SLOT_CONTROLLED);
    }
    else
    {
        LOG_DEBUG("movement.motionmaster", "Creature ({}) charge point (X: {} Y: {} Z: {})", _owner->GetGUID().ToString(), x, y, z);
        Mutate(new PointMovementGenerator<Creature>(id, x, y, z, speed, orientation, path, generatePath, generatePath, targetGUID), MOTION_SLOT_CONTROLLED);
    }
}

/**
 * @brief The unit will charge the target. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MoveCharge(PathGenerator const& path, float speed /*= SPEED_CHARGE*/, ObjectGuid targetGUID /*= ObjectGuid::Empty*/)
{
    G3D::Vector3 dest = path.GetActualEndPosition();

    MoveCharge(dest.x, dest.y, dest.z, speed, EVENT_CHARGE_PREPATH, nullptr, false, 0.0f, targetGUID);

    // Charge movement is not started when using EVENT_CHARGE_PREPATH
    Movement::MoveSplineInit init(_owner);
    init.MovebyPath(path.GetPath());
    init.SetVelocity(speed);
    init.Launch();
}

void MotionMaster::MoveSeekAssistance(float x, float y, float z)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->IsPlayer())
    {
        LOG_ERROR("movement.motionmaster", "Player ({}) attempt to seek assistance", _owner->GetGUID().ToString());
    }
    else
    {
        LOG_DEBUG("movement.motionmaster", "Creature ({}) seek assistance (X: {} Y: {} Z: {})", _owner->GetGUID().ToString(), x, y, z);
        _owner->AttackStop();
        _owner->CastStop(0, false);
        _owner->ToCreature()->SetReactState(REACT_PASSIVE);
        Mutate(new AssistanceMovementGenerator(x, y, z), MOTION_SLOT_ACTIVE);
    }
}

void MotionMaster::MoveSeekAssistanceDistract(uint32 time)
{
    // Xinef: do not allow to move with UNIT_FLAG_DISABLE_MOVE
    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->IsPlayer())
    {
        LOG_ERROR("movement.motionmaster", "Player ({}) attempt to call distract after assistance", _owner->GetGUID().ToString());
    }
    else
    {
        LOG_DEBUG("movement.motionmaster", "Creature ({}) is distracted after assistance call (Time: {})", _owner->GetGUID().ToString(), time);
        Mutate(new AssistanceDistractMovementGenerator(time), MOTION_SLOT_ACTIVE);
    }
}

/**
 * @brief Enable the target's fleeing movement. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MoveFleeing(Unit* enemy, uint32 time)
{
    if (!enemy)
        return;

    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    if (_owner->IsPlayer())
    {
        LOG_DEBUG("movement.motionmaster", "Player ({}) flee from {} ({})",
            _owner->GetGUID().ToString(), enemy->IsPlayer() ? "player" : "creature", enemy->GetGUID().ToString());
        Mutate(new FleeingMovementGenerator<Player>(enemy->GetGUID()), MOTION_SLOT_CONTROLLED);
    }
    else
    {
        LOG_DEBUG("movement.motionmaster", "Creature ({}) flee from {} ({}) {}",
            _owner->GetGUID().ToString(), enemy->IsPlayer() ? "player" : "creature", enemy->GetGUID().ToString(), time ? " for a limited time" : "");
        if (time)
            Mutate(new TimedFleeingMovementGenerator(enemy->GetGUID(), time), MOTION_SLOT_CONTROLLED);
        else
            Mutate(new FleeingMovementGenerator<Creature>(enemy->GetGUID()), MOTION_SLOT_CONTROLLED);
    }
}

void MotionMaster::MoveTaxiFlight(uint32 path, uint32 pathnode)
{
    if (_owner->IsPlayer())
    {
        if (path < sTaxiPathNodesByPath.size())
        {
            LOG_DEBUG("movement.motionmaster", "{} taxi to (Path {} node {})", _owner->GetName(), path, pathnode);
            FlightPathMovementGenerator* mgen = new FlightPathMovementGenerator(pathnode);
            mgen->LoadPath(_owner->ToPlayer());
            Mutate(mgen, MOTION_SLOT_CONTROLLED);
        }
        else
        {
            LOG_ERROR("movement.motionmaster", "{} attempt taxi to (not existed Path {} node {})",
                           _owner->GetName(), path, pathnode);
        }
    }
    else
    {
        LOG_ERROR("movement.motionmaster", "Creature ({}) attempt taxi to (Path {} node {})", _owner->GetGUID().ToString(), path, pathnode);
    }
}

/**
 * @brief Enable the target's distract movement. Doesn't work with UNIT_FLAG_DISABLE_MOVE and
 * if the unit has MOTION_SLOT_CONTROLLED (generaly apply when the unit is controlled).
 */
void MotionMaster::MoveDistract(uint32 timer)
{
    if (Impl[MOTION_SLOT_CONTROLLED])
        return;

    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
        return;

    /*if (_owner->IsPlayer())
    {
        LOG_DEBUG("movement.motionmaster", "Player ({}) distracted (timer: {})", _owner->GetGUID().ToString(), timer);
    }
    else
    {
        LOG_DEBUG("movement.motionmaster", "Creature ({}) (timer: {})", _owner->GetGUID().ToString(), timer);
    }*/

    DistractMovementGenerator* mgen = new DistractMovementGenerator(timer);
    Mutate(mgen, MOTION_SLOT_CONTROLLED);
}

void MotionMaster::Mutate(MovementGenerator* m, MovementSlot slot)
{
    while (MovementGenerator* curr = Impl[slot])
    {
        bool delayed = (_top == slot && (_cleanFlag & MMCF_UPDATE));

        // clear slot AND decrease top immediately to avoid crashes when referencing null top in DirectDelete
        Impl[slot] = nullptr;
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

/**
 * @brief Move the unit following a specific path. Doesn't work with UNIT_FLAG_DISABLE_MOVE
 */
void MotionMaster::MovePath(uint32 path_id, bool repeatable)
{
    if (!path_id)
        return;

    if (_owner->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
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

    //_owner->IsPlayer() ?
    //Mutate(new WaypointMovementGenerator<Player>(path_id, repeatable)):
    Mutate(new WaypointMovementGenerator<Creature>(path_id, repeatable), MOTION_SLOT_IDLE);

    LOG_DEBUG("movement.motionmaster", "{} ({}) start moving over path(Id:{}, repeatable: {})",
        _owner->IsPlayer() ? "Player" : "Creature", _owner->GetGUID().ToString(), path_id, repeatable ? "YES" : "NO");
}

/**
 * @brief Rotate the unit. You can specify the time of the rotation.
 */
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
    LOG_DEBUG("movement.motionmaster", "Unit (Entry {}) is trying to delete its updating MG (Type {})!", _owner->GetEntry(), curr->GetMovementGeneratorType());
    if (isStatic(curr))
        return;
    if (!_expList)
        _expList = new ExpireList();
    _expList->push_back(curr);
}

bool MotionMaster::GetDestination(float& x, float& y, float& z)
{
    if (_owner->movespline->Finalized())
        return false;

    G3D::Vector3 const& dest = _owner->movespline->FinalDestination();
    x = dest.x;
    y = dest.y;
    z = dest.z;
    return true;
}
