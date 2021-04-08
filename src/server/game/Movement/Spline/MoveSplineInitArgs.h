/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef TRINITYSERVER_MOVESPLINEINIT_ARGS_H
#define TRINITYSERVER_MOVESPLINEINIT_ARGS_H

#include "MoveSplineFlag.h"
#include <G3D/Vector3.h>

class Unit;

namespace Movement
{
    typedef std::vector<Vector3> PointsArray;

    union FacingInfo
    {
        struct
        {
            float x, y, z;
        } f;
        uint64 target;
        float angle;

        FacingInfo(float o) : angle(o) {}
        FacingInfo(uint64 t) : target(t) {}
        FacingInfo() = default;
    };

    struct MoveSplineInitArgs
    {
        MoveSplineInitArgs(size_t path_capacity = 16)
        {
            path.reserve(path_capacity);
        }

        PointsArray path;
        FacingInfo facing;
        MoveSplineFlag flags;
        int32 path_Idx_offset{0};
        float velocity{0.f};
        float parabolic_amplitude{0.f};
        float time_perc{0.f};
        uint32 splineId{0};
        float initialOrientation{0.f};
        bool HasVelocity{false};
        bool TransformForTransport{true};

        /** Returns true to show that the arguments were configured correctly and MoveSpline initialization will succeed. */
        bool Validate(Unit* unit) const;

    private:
        [[nodiscard]] bool _checkPathBounds() const;
    };
}

#endif // TRINITYSERVER_MOVESPLINEINIT_ARGS_H
