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
