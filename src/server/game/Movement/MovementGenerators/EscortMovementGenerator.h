/*
Written by Xinef
 */

#ifndef ACORE_ESCORTMOVEMENTGENERATOR_H
#define ACORE_ESCORTMOVEMENTGENERATOR_H

#include "MovementGenerator.h"

template<class T>
class EscortMovementGenerator : public MovementGeneratorMedium< T, EscortMovementGenerator<T> >
{
    public:
        EscortMovementGenerator(Movement::PointsArray* _path = nullptr) : i_recalculateSpeed(false)
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
};

#endif

