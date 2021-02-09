/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef TRINITYSERVER_MOVEPLINE_H
#define TRINITYSERVER_MOVEPLINE_H

#include "Spline.h"
#include "MoveSplineInitArgs.h"

namespace Movement
{
    struct Location : public Vector3
    {
        Location()  {}
        Location(float x, float y, float z, float o) : Vector3(x, y, z), orientation(o) {}
        Location(const Vector3& v) : Vector3(v), orientation(0) {}
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
        [[nodiscard]] const MySpline::ControlArray& getPath(bool visual) const { return spline.getPoints(visual); }
        void computeParabolicElevation(float& el) const;
        void computeFallElevation(float& el) const;

        UpdateResult _updateState(int32& ms_time_diff);
        [[nodiscard]] int32 next_timestamp() const { return spline.length(point_Idx + 1); }
        [[nodiscard]] int32 segment_time_elapsed() const { return next_timestamp() - time_passed; }

    public:
        [[nodiscard]] int32 timeElapsed() const { return Duration() - time_passed; }  // xinef: moved to public for waypoint movegen
        [[nodiscard]] int32 timePassed() const { return time_passed; }                // xinef: moved to public for waypoint movegen
        [[nodiscard]] int32 Duration() const { return spline.length(); }
        [[nodiscard]] MySpline const& _Spline() const { return spline; }
        [[nodiscard]] int32 _currentSplineIdx() const { return point_Idx; }
        void _Finalize();
        void _Interrupt() { splineflags.done = true; }

    public:
        void Initialize(const MoveSplineInitArgs&);
        [[nodiscard]] bool Initialized() const { return !spline.empty(); }

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

        [[nodiscard]] Location ComputePosition() const;

        [[nodiscard]] uint32 GetId() const { return m_Id; }
        [[nodiscard]] bool Finalized() const { return splineflags.done; }
        [[nodiscard]] bool isCyclic() const { return splineflags.cyclic; }
        [[nodiscard]] bool isFalling() const { return splineflags.falling; }
        [[nodiscard]] bool isWalking() const { return splineflags.walkmode; }
        [[nodiscard]] Vector3 FinalDestination() const { return Initialized() ? spline.getPoint(spline.last(), false) : Vector3(); }
        [[nodiscard]] Vector3 CurrentDestination() const { return Initialized() ? spline.getPoint(point_Idx + 1, false) : Vector3(); }
        [[nodiscard]] int32 currentPathIdx() const;

        bool onTransport;
        [[nodiscard]] std::string ToString() const;
        [[nodiscard]] bool HasStarted() const
        {
            return time_passed > 0;
        }
    };
}
#endif // TRINITYSERVER_MOVEPLINE_H
