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

#ifndef ACORE_ESCORTMOVEMENTGENERATOR_H
#define ACORE_ESCORTMOVEMENTGENERATOR_H

#include "MovementGenerator.h"

template<class T>
class EscortMovementGenerator : public MovementGeneratorMedium< T, EscortMovementGenerator<T> >
{
public:
    EscortMovementGenerator(ForcedMovement forcedMovement, Movement::PointsArray* _path = nullptr) : i_recalculateSpeed(false), _forcedMovement(forcedMovement)
    {
        if (_path)
            m_precomputedPath = *_path;
    }

    void DoInitialize(T*);
    void DoFinalize(T*);
    void DoReset(T*);
    bool DoUpdate(T*, uint32);

    void unitSpeedChanged() { i_recalculateSpeed = true; }

    MovementGeneratorType GetMovementGeneratorType() { return ESCORT_MOTION_TYPE; }

    uint32 GetSplineId() const { return _splineId; }

private:
    bool i_recalculateSpeed;
    Movement::PointsArray m_precomputedPath;

    uint32 _splineId;
    ForcedMovement _forcedMovement;
};

#endif
