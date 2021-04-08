/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_FLEEINGMOVEMENTGENERATOR_H
#define ACORE_FLEEINGMOVEMENTGENERATOR_H

#include "MovementGenerator.h"

template<class T>
class FleeingMovementGenerator : public MovementGeneratorMedium< T, FleeingMovementGenerator<T> >
{
public:
    FleeingMovementGenerator(ObjectGuid fright) : i_frightGUID(fright), i_nextCheckTime(0) {}

    void DoInitialize(T*);
    void DoFinalize(T*);
    void DoReset(T*);
    bool DoUpdate(T*, uint32);

    MovementGeneratorType GetMovementGeneratorType() { return FLEEING_MOTION_TYPE; }

private:
    void _setTargetLocation(T*);
    bool _getPoint(T*, float& x, float& y, float& z);
    bool _setMoveData(T* owner);
    void _Init(T* );

    bool is_water_ok   : 1;
    bool is_land_ok    : 1;
    bool i_only_forward: 1;

    float i_caster_x;
    float i_caster_y;
    float i_caster_z;
    float i_last_distance_from_caster;
    float i_to_distance_from_caster;
    float i_cur_angle;
    ObjectGuid i_frightGUID;
    TimeTracker i_nextCheckTime;
};

class TimedFleeingMovementGenerator : public FleeingMovementGenerator<Creature>
{
public:
    TimedFleeingMovementGenerator(ObjectGuid fright, uint32 time) :
        FleeingMovementGenerator<Creature>(fright),
        i_totalFleeTime(time) {}

    MovementGeneratorType GetMovementGeneratorType() { return TIMED_FLEEING_MOTION_TYPE; }
    bool Update(Unit*, uint32);
    void Finalize(Unit*);

private:
    TimeTracker i_totalFleeTime;
};

#endif
