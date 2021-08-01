/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_MOTIONMASTER_H
#define ACORE_MOTIONMASTER_H

#include "Common.h"
#include "Object.h"
#include "SharedDefines.h"
#include "Spline/MoveSpline.h"
#include <optional>
#include <vector>

class MovementGenerator;
class Unit;

// Creature Entry ID used for waypoints show, visible only for GMs
#define VISUAL_WAYPOINT 1

// values 0 ... MAX_DB_MOTION_TYPE-1 used in DB
enum MovementGeneratorType
{
    IDLE_MOTION_TYPE      = 0,                              // IdleMovementGenerator.h
    RANDOM_MOTION_TYPE    = 1,                              // RandomMovementGenerator.h
    WAYPOINT_MOTION_TYPE  = 2,                              // WaypointMovementGenerator.h
    MAX_DB_MOTION_TYPE    = 3,                              // *** this and below motion types can't be set in DB.
    ANIMAL_RANDOM_MOTION_TYPE = MAX_DB_MOTION_TYPE,         // AnimalRandomMovementGenerator.h
    CONFUSED_MOTION_TYPE  = 4,                              // ConfusedMovementGenerator.h
    CHASE_MOTION_TYPE     = 5,                              // TargetedMovementGenerator.h
    HOME_MOTION_TYPE      = 6,                              // HomeMovementGenerator.h
    FLIGHT_MOTION_TYPE    = 7,                              // WaypointMovementGenerator.h
    POINT_MOTION_TYPE     = 8,                              // PointMovementGenerator.h
    FLEEING_MOTION_TYPE   = 9,                              // FleeingMovementGenerator.h
    DISTRACT_MOTION_TYPE  = 10,                             // IdleMovementGenerator.h
    ASSISTANCE_MOTION_TYPE = 11,                            // PointMovementGenerator.h (first part of flee for assistance)
    ASSISTANCE_DISTRACT_MOTION_TYPE = 12,                   // IdleMovementGenerator.h (second part of flee for assistance)
    TIMED_FLEEING_MOTION_TYPE = 13,                         // FleeingMovementGenerator.h (alt.second part of flee for assistance)
    FOLLOW_MOTION_TYPE    = 14,
    ROTATE_MOTION_TYPE    = 15,
    EFFECT_MOTION_TYPE    = 16,
    ESCORT_MOTION_TYPE    = 17,                             // xinef: EscortMovementGenerator.h
    NULL_MOTION_TYPE      = 18
};

enum MovementSlot
{
    MOTION_SLOT_IDLE,
    MOTION_SLOT_ACTIVE,
    MOTION_SLOT_CONTROLLED,
    MAX_MOTION_SLOT
};

enum MMCleanFlag
{
    MMCF_NONE   = 0x00,
    MMCF_UPDATE = 0x01, // Clear or Expire called from update
    MMCF_RESET  = 0x02, // Flag if need top()->Reset()
    MMCF_INUSE  = 0x04, // pussywizard: Flag if in MotionMaster::UpdateMotion
};

enum RotateDirection
{
    ROTATE_DIRECTION_LEFT,
    ROTATE_DIRECTION_RIGHT
};

struct ChaseRange
{
    ChaseRange(float range);
    ChaseRange(float _minRange, float _maxRange);
    ChaseRange(float _minRange, float _minTolerance, float _maxTolerance, float _maxRange);

    // this contains info that informs how we should path!
    float MinRange;     // we have to move if we are within this range...    (min. attack range)
    float MinTolerance; // ...and if we are, we will move this far away
    float MaxRange;     // we have to move if we are outside this range...   (max. attack range)
    float MaxTolerance; // ...and if we are, we will move into this range
};

struct ChaseAngle
{
    ChaseAngle(float angle, float _tolerance = M_PI_4);

    float RelativeAngle; // we want to be at this angle relative to the target (0 = front, M_PI = back)
    float Tolerance;     // but we'll tolerate anything within +- this much

    float UpperBound() const;
    float LowerBound() const;
    bool IsAngleOkay(float relativeAngle) const;
};

// assume it is 25 yard per 0.6 second
#define SPEED_CHARGE    42.0f

class MotionMaster //: private std::stack<MovementGenerator *>
{
private:
    //typedef std::stack<MovementGenerator *> Impl;
    typedef MovementGenerator* _Ty;

    void pop()
    {
        if (empty())
            return;

        Impl[_top] = nullptr;
        while (!empty() && !top())
            --_top;
    }

    [[nodiscard]] bool needInitTop() const
    {
        if (empty())
            return false;
        return _needInit[_top];
    }
    void InitTop();
public:
    explicit MotionMaster(Unit* unit) : _expList(nullptr), _top(-1), _owner(unit), _cleanFlag(MMCF_NONE)
    {
        for (uint8 i = 0; i < MAX_MOTION_SLOT; ++i)
        {
            Impl[i] = nullptr;
            _needInit[i] = true;
        }
    }
    ~MotionMaster();

    void Initialize();
    void InitDefault();

    [[nodiscard]] bool empty() const { return (_top < 0); }
    [[nodiscard]] int size() const { return _top + 1; }
    [[nodiscard]] _Ty top() const
    {
        ASSERT(!empty());
        return Impl[_top];
    }
    [[nodiscard]] _Ty GetMotionSlot(int slot) const
    {
        ASSERT(slot >= 0);
        return Impl[slot];
    }

    [[nodiscard]] uint8 GetCleanFlags() const { return _cleanFlag; }

    void DirectDelete(_Ty curr);
    void DelayedDelete(_Ty curr);

    void UpdateMotion(uint32 diff);
    void Clear(bool reset = true)
    {
        if (_cleanFlag & MMCF_UPDATE)
        {
            if (reset)
                _cleanFlag |= MMCF_RESET;
            else
                _cleanFlag &= ~MMCF_RESET;
            DelayedClean();
        }
        else
            DirectClean(reset);
    }
    void MovementExpired(bool reset = true)
    {
        if (_cleanFlag & MMCF_UPDATE)
        {
            if (reset)
                _cleanFlag |= MMCF_RESET;
            else
                _cleanFlag &= ~MMCF_RESET;
            DelayedExpire();
        }
        else
            DirectExpire(reset);
    }

    void MovementExpiredOnSlot(MovementSlot slot, bool reset = true)
    {
        // xinef: cannot be used during motion update!
        if (!(_cleanFlag & MMCF_UPDATE))
            DirectExpireSlot(slot, reset);
    }

    void MoveIdle();
    void MoveTargetedHome();
    void MoveRandom(float wanderDistance = 0.0f);
    void MoveFollow(Unit* target, float dist, float angle, MovementSlot slot = MOTION_SLOT_ACTIVE);
    void MoveChase(Unit* target, std::optional<ChaseRange> dist = {}, std::optional<ChaseAngle> angle = {});
    void MoveChase(Unit* target, float dist, float angle) { MoveChase(target, ChaseRange(dist), ChaseAngle(angle)); }
    void MoveChase(Unit* target, float dist) { MoveChase(target, ChaseRange(dist)); }
    void MoveCircleTarget(Unit* target);
    void MoveBackwards(Unit* target, float dist);
    void MoveConfused();
    void MoveFleeing(Unit* enemy, uint32 time = 0);
    void MovePoint(uint32 id, const Position& pos, bool generatePath = true, bool forceDestination = true)
    { MovePoint(id, pos.m_positionX, pos.m_positionY, pos.m_positionZ, generatePath, forceDestination, MOTION_SLOT_ACTIVE, pos.GetOrientation()); }
    void MovePoint(uint32 id, float x, float y, float z, bool generatePath = true, bool forceDestination = true, MovementSlot slot = MOTION_SLOT_ACTIVE, float orientation = 0.0f);
    void MoveSplinePath(Movement::PointsArray* path);

    // These two movement types should only be used with creatures having landing/takeoff animations
    void MoveLand(uint32 id, Position const& pos, float speed = 0.0f);
    void MoveLand(uint32 id, float x, float y, float z, float speed = 0.0f); // pussywizard: added for easy calling by passing 3 floats x, y, z
    void MoveTakeoff(uint32 id, Position const& pos, float speed = 0.0f);
    void MoveTakeoff(uint32 id, float x, float y, float z, float speed = 0.0f); // pussywizard: added for easy calling by passing 3 floats x, y, z

    void MoveCharge(float x, float y, float z, float speed = SPEED_CHARGE, uint32 id = EVENT_CHARGE, const Movement::PointsArray* path = nullptr, bool generatePath = false, float orientation = 0.0f);
    void MoveKnockbackFrom(float srcX, float srcY, float speedXY, float speedZ);
    void MoveJumpTo(float angle, float speedXY, float speedZ);
    void MoveJump(Position const& pos, float speedXY, float speedZ, uint32 id = 0)
    { MoveJump(pos.m_positionX, pos.m_positionY, pos.m_positionZ, speedXY, speedZ, id); };
    void MoveJump(float x, float y, float z, float speedXY, float speedZ, uint32 id = 0, Unit const* target = nullptr);
    void MoveFall(uint32 id = 0, bool addFlagForNPC = false);

    void MoveSeekAssistance(float x, float y, float z);
    void MoveSeekAssistanceDistract(uint32 timer);
    void MoveTaxiFlight(uint32 path, uint32 pathnode);
    void MoveDistract(uint32 time);
    void MovePath(uint32 path_id, bool repeatable);
    void MoveRotate(uint32 time, RotateDirection direction);

    [[nodiscard]] MovementGeneratorType GetCurrentMovementGeneratorType() const;
    [[nodiscard]] MovementGeneratorType GetMotionSlotType(int slot) const;
    [[nodiscard]] uint32 GetCurrentSplineId() const; // Xinef: Escort system

    void propagateSpeedChange();
    void ReinitializeMovement();

    bool GetDestination(float& x, float& y, float& z);
private:
    void Mutate(MovementGenerator* m, MovementSlot slot);                  // use Move* functions instead

    void DirectClean(bool reset);
    void DelayedClean();

    void DirectExpire(bool reset);
    void DirectExpireSlot(MovementSlot slot, bool reset);
    void DelayedExpire();

    typedef std::vector<_Ty> ExpireList;
    ExpireList* _expList;
    _Ty Impl[MAX_MOTION_SLOT];
    int _top;
    Unit* _owner;
    bool _needInit[MAX_MOTION_SLOT];
    uint8 _cleanFlag;
};
#endif
