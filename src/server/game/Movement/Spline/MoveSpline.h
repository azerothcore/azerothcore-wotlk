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

#ifndef TRINITYSERVER_MOVEPLINE_H
#define TRINITYSERVER_MOVEPLINE_H

#include "MoveSplineInitArgs.h"
#include "Spline.h"

namespace Movement
{
    struct Location : public Vector3
    {
        Location()  = default;
        Location(float x, float y, float z, float o) : Vector3(x, y, z), orientation(o) {}
        Location(const Vector3& v) : Vector3(v) {}
        Location(const Vector3& v, float o) : Vector3(v), orientation(o) {}

        float orientation{0};
    };

    // MoveSpline represents smooth catmullrom or linear curve and point that moves belong it
    // curve can be cyclic - in this case movement will be cyclic
    // point can have vertical acceleration motion componemt(used in fall, parabolic movement)
    class MoveSpline
    {
    public:
        typedef Spline<int32> MySpline;
        enum UpdateResult
        {
            Result_None         = 0x01,
            Result_Arrived      = 0x02,
            Result_NextCycle    = 0x04,
            Result_NextSegment  = 0x08,
            Result_JustArrived  = 0x10,
        };
        friend class PacketBuilder;
    protected:
        MySpline        spline;

        FacingInfo      facing;

        uint32          m_Id;

        MoveSplineFlag  splineflags;

        int32           time_passed;
        // currently duration mods are unused, but its _currently_
        //float           duration_mod;
        //float           duration_mod_next;
        float           vertical_acceleration;
        float           initialOrientation;
        int32           effect_start_time;
        int32           point_Idx;
        int32           point_Idx_offset;

        void init_spline(const MoveSplineInitArgs& args);

    protected:
        [[nodiscard]] auto getPath(bool visual) const -> const MySpline::ControlArray& { return spline.getPoints(visual); }
        void computeParabolicElevation(float& el) const;
        void computeFallElevation(float& el) const;

        auto _updateState(int32& ms_time_diff) -> UpdateResult;
        [[nodiscard]] auto next_timestamp() const -> int32 { return spline.length(point_Idx + 1); }
        [[nodiscard]] auto segment_time_elapsed() const -> int32 { return next_timestamp() - time_passed; }

    public:
        [[nodiscard]] auto timeElapsed() const -> int32 { return Duration() - time_passed; }  // xinef: moved to public for waypoint movegen
        [[nodiscard]] auto timePassed() const -> int32 { return time_passed; }                // xinef: moved to public for waypoint movegen
        [[nodiscard]] auto Duration() const -> int32 { return spline.length(); }
        [[nodiscard]] auto _Spline() const -> MySpline const& { return spline; }
        [[nodiscard]] auto _currentSplineIdx() const -> int32 { return point_Idx; }
        void _Finalize();
        void _Interrupt() { splineflags.done = true; }

    public:
        void Initialize(const MoveSplineInitArgs&);
        [[nodiscard]] auto Initialized() const -> bool { return !spline.empty(); }

        MoveSpline();

        template<class UpdateHandler>
        void updateState(int32 difftime, UpdateHandler& handler)
        {
            ASSERT(Initialized());
            do
                handler(_updateState(difftime));
            while (difftime > 0);
        }

        void updateState(int32 difftime)
        {
            ASSERT(Initialized());
            do _updateState(difftime);
            while (difftime > 0);
        }

        [[nodiscard]] auto ComputePosition() const -> Location;

        [[nodiscard]] auto GetId() const -> uint32 { return m_Id; }
        [[nodiscard]] auto Finalized() const -> bool { return splineflags.done; }
        [[nodiscard]] auto isCyclic() const -> bool { return splineflags.cyclic; }
        [[nodiscard]] auto isFalling() const -> bool { return splineflags.falling; }
        [[nodiscard]] auto isWalking() const -> bool { return splineflags.walkmode; }
        [[nodiscard]] auto FinalDestination() const -> Vector3 { return Initialized() ? spline.getPoint(spline.last(), false) : Vector3(); }
        [[nodiscard]] auto CurrentDestination() const -> Vector3 { return Initialized() ? spline.getPoint(point_Idx + 1, false) : Vector3(); }
        [[nodiscard]] auto currentPathIdx() const -> int32;

        [[nodiscard]] auto HasAnimation() const -> bool { return splineflags.animation; }
        [[nodiscard]] auto GetAnimationType() const -> uint8 { return splineflags.animId; }

        bool onTransport;
        [[nodiscard]] auto ToString() const -> std::string;
        [[nodiscard]] auto HasStarted() const -> bool
        {
            return time_passed > 0;
        }
    };
}
#endif // TRINITYSERVER_MOVEPLINE_H
