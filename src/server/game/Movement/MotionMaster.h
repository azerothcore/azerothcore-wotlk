/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_MOTIONMASTER_H
#define ACORE_MOTIONMASTER_H

#include "Common.h"
#include <vector>
#include "SharedDefines.h"
#include "Object.h"
#include "Spline/MoveSpline.h"

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
    ASSISTANCE_MOTION_TYPE= 11,                             // PointMovementGenerator.h (first part of flee for assistance)
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

        bool needInitTop() const 
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

        bool empty() const { return (_top < 0); }
        int size() const { return _top + 1; }
        _Ty top() const 
        { 
            ASSERT(!empty());
            return Impl[_top]; 
        }
        _Ty GetMotionSlot(int slot) const 
        { 
            ASSERT(slot >= 0);
            return Impl[slot]; 
        }

        uint8 GetCleanFlags() const { return _cleanFlag; }

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
        void MoveChase(Unit* target, float dist = 0.0f, float angle = 0.0f);
        void MoveConfused();
        void MoveFleeing(Unit* enemy, uint32 time = 0);
        void MovePoint(uint32 id, const Position &pos, bool generatePath = true, bool forceDestination = true)
            { MovePoint(id, pos.m_positionX, pos.m_positionY, pos.m_positionZ, generatePath, forceDestination); }
        void MovePoint(uint32 id, float x, float y, float z, bool generatePath = true, bool forceDestination = true, MovementSlot slot = MOTION_SLOT_ACTIVE);
        void MoveSplinePath(Movement::PointsArray* path);

        // These two movement types should only be used with creatures having landing/takeoff animations
        void MoveLand(uint32 id, Position const& pos, float speed);
        void MoveLand(uint32 id, float x, float y, float z, float speed); // pussywizard: added for easy calling by passing 3 floats x, y, z
        void MoveTakeoff(uint32 id, Position const& pos, float speed);
        void MoveTakeoff(uint32 id, float x, float y, float z, float speed); // pussywizard: added for easy calling by passing 3 floats x, y, z

        void MoveCharge(float x, float y, float z, float speed = SPEED_CHARGE, uint32 id = EVENT_CHARGE, const Movement::PointsArray* path = NULL, bool generatePath = false);
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

        MovementGeneratorType GetCurrentMovementGeneratorType() const;
        MovementGeneratorType GetMotionSlotType(int slot) const;
        uint32 GetCurrentSplineId() const; // Xinef: Escort system

        void propagateSpeedChange();
        void ReinitializeMovement();

        bool GetDestination(float &x, float &y, float &z);
    private:
        void Mutate(MovementGenerator *m, MovementSlot slot);                  // use Move* functions instead

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
