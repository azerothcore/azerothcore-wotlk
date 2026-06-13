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

#ifndef ACORE_FLEEINGMOVEMENTGENERATOR_H
#define ACORE_FLEEINGMOVEMENTGENERATOR_H

#include "Creature.h"
#include "MovementGenerator.h"
#include "Timer.h"

template<class T>
class FleeingMovementGenerator : public MovementGeneratorMedium< T, FleeingMovementGenerator<T> >
{
    public:
        explicit FleeingMovementGenerator(ObjectGuid fleeTargetGUID) : _path(nullptr), _fleeTargetGUID(fleeTargetGUID), _timer(0), _interrupt(false), _invalidPathsCount(0) { }

        MovementGeneratorType GetMovementGeneratorType() override { return FLEEING_MOTION_TYPE; }

        void DoInitialize(T*);
        void DoFinalize(T*);
        void DoReset(T*);
        bool DoUpdate(T*, uint32);

    private:
        void SetTargetLocation(T*);
        void GetPoint(T*, Position& position);

        std::unique_ptr<PathGenerator> _path;
        ObjectGuid _fleeTargetGUID;
        TimeTracker _timer;
        bool _interrupt;
        uint8 _invalidPathsCount;
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
