/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef ACORE_RANDOMMOTIONGENERATOR_H
#define ACORE_RANDOMMOTIONGENERATOR_H

#include "MovementGenerator.h"
#include "PathGenerator.h"

#define RANDOM_POINTS_NUMBER        12
#define RANDOM_LINKS_COUNT          7
#define MIN_WANDER_DISTANCE_GROUND  6.0f
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
                    _validPointsVector[i].push_back((i + j + RANDOM_POINTS_NUMBER/2 - RANDOM_LINKS_COUNT/2) % RANDOM_POINTS_NUMBER);
            }

            _validPointsVector[RANDOM_POINTS_NUMBER].reserve(RANDOM_POINTS_NUMBER);
            for (uint8 i = 0; i < RANDOM_POINTS_NUMBER; ++i)
                _validPointsVector[RANDOM_POINTS_NUMBER].push_back(i);
        }

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
        PathGenerator* _pathGenerator;
        std::vector<G3D::Vector3> _destinationPoints;
        std::vector<uint8> _validPointsVector[RANDOM_POINTS_NUMBER+1];
        uint8 _currentPoint;
        std::map<uint16, Movement::PointsArray> _preComputedPaths;
        Position _initialPosition, _currDestPosition;
};
#endif
