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

#ifndef ACORE_CONFUSEDGENERATOR_H
#define ACORE_CONFUSEDGENERATOR_H

#include "MovementGenerator.h"
#include "Timer.h"

#define MAX_CONF_WAYPOINTS 24 //! Allows a twelve second confusion if i_nextMove always is the absolute minimum timer.

template<class T>
class ConfusedMovementGenerator : public MovementGeneratorMedium< T, ConfusedMovementGenerator<T> >
{
public:
    explicit ConfusedMovementGenerator() : i_nextMoveTime(1) {}

    void DoInitialize(T*);
    void DoFinalize(T*);
    void DoReset(T*);
    bool DoUpdate(T*, uint32);

    MovementGeneratorType GetMovementGeneratorType() { return CONFUSED_MOTION_TYPE; }
private:
    void _InitSpecific(T*, bool&, bool&);
    TimeTracker i_nextMoveTime;
    float i_waypoints[MAX_CONF_WAYPOINTS + 1][3];
    uint32 i_nextMove;
};
#endif
