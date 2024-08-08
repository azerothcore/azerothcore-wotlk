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

#ifndef AC_MOVESPLINEINIT_ARGS_H
#define AC_MOVESPLINEINIT_ARGS_H

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
        MoveSplineInitArgs(std::size_t path_capacity = 16)
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

#endif // AC_MOVESPLINEINIT_ARGS_H
