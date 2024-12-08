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

#ifndef ACORE_RANDOMMOTIONGENERATOR_H
#define ACORE_RANDOMMOTIONGENERATOR_H

#include "MovementGenerator.h"
#include "PathGenerator.h"
#include "Timer.h"

#define RANDOM_POINTS_NUMBER        12
#define RANDOM_LINKS_COUNT          7
#define MIN_WANDER_DISTANCE_GROUND  1.0f
#define MIN_WANDER_DISTANCE_AIR     10.0f
#define MAX_PATH_LENGHT_FACTOR      1.85f

template<class T>
class RandomMovementGenerator : public MovementGeneratorMedium< T, RandomMovementGenerator<T> >
{
public:
    RandomMovementGenerator(float wanderDistance = 0.0f) : _nextMoveTime(0), _moveCount(0), _wanderDistance(wanderDistance), _pathGenerator(nullptr), _currentPoint(RANDOM_POINTS_NUMBER)
    {
        _initialPosition.Relocate(0.0f, 0.0f, 0.0f, 0.0f);
        _destinationPoints.reserve(RANDOM_POINTS_NUMBER);

        for (uint8 i = 0; i < RANDOM_POINTS_NUMBER; ++i)
        {
            _validPointsVector[i].reserve(RANDOM_LINKS_COUNT);
            for (uint8 j = 0; j < RANDOM_LINKS_COUNT; ++j)
                _validPointsVector[i].push_back((i + j + RANDOM_POINTS_NUMBER / 2 - RANDOM_LINKS_COUNT / 2) % RANDOM_POINTS_NUMBER);
        }

        _validPointsVector[RANDOM_POINTS_NUMBER].reserve(RANDOM_POINTS_NUMBER);
        for (uint8 i = 0; i < RANDOM_POINTS_NUMBER; ++i)
            _validPointsVector[RANDOM_POINTS_NUMBER].push_back(i);
    }
    ~RandomMovementGenerator();

    void _setRandomLocation(T*);
    void DoInitialize(T*);
    void DoFinalize(T*);
    void DoReset(T*);
    bool DoUpdate(T*, const uint32);
    bool GetResetPosition(float& x, float& y, float& z);
    MovementGeneratorType GetMovementGeneratorType() { return RANDOM_MOTION_TYPE; }

private:
    TimeTrackerSmall _nextMoveTime;
    uint8 _moveCount;
    float _wanderDistance;
    std::unique_ptr<PathGenerator> _pathGenerator;
    std::vector<G3D::Vector3> _destinationPoints;
    std::vector<uint8> _validPointsVector[RANDOM_POINTS_NUMBER + 1];
    uint8 _currentPoint;
    std::map<uint16, Movement::PointsArray> _preComputedPaths;
    Position _initialPosition, _currDestPosition;
};
#endif
