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

#ifndef _PATH_GENERATOR_H
#define _PATH_GENERATOR_H

#include "DetourNavMesh.h"
#include "DetourNavMeshQuery.h"
#include "MMapFactory.h"
#include "MMapMgr.h"
#include "MapDefines.h"
#include "MoveSplineInitArgs.h"
#include "SharedDefines.h"
#include <G3D/Vector3.h>

class Unit;
class WorldObject;

// 74*4.0f=296y number_of_points*interval = max_path_len
// this is way more than actual evade range
// I think we can safely cut those down even more
#define MAX_PATH_LENGTH         74
#define MAX_POINT_PATH_LENGTH   74

#define SMOOTH_PATH_STEP_SIZE   4.0f
#define SMOOTH_PATH_SLOP        0.3f
#define DISALLOW_TIME_AFTER_FAIL    3 // secs
#define VERTEX_SIZE       3
#define INVALID_POLYREF   0

enum PathType
{
    PATHFIND_BLANK             = 0x00,   // path not built yet
    PATHFIND_NORMAL            = 0x01,   // normal path
    PATHFIND_SHORTCUT          = 0x02,   // travel through obstacles, terrain, air, etc (old behavior)
    PATHFIND_INCOMPLETE        = 0x04,   // we have partial path to follow - getting closer to target
    PATHFIND_NOPATH            = 0x08,   // no valid path at all or error in generating one
    PATHFIND_NOT_USING_PATH    = 0x10,   // used when we are either flying/swiming or on map w/o mmaps
    PATHFIND_SHORT             = 0x20,   // path is longer or equal to its limited path length
    PATHFIND_FARFROMPOLY_START = 0x40,   // start position is far from the mmap poligon
    PATHFIND_FARFROMPOLY_END   = 0x80,   // end positions is far from the mmap poligon
    PATHFIND_FARFROMPOLY       = PATHFIND_FARFROMPOLY_START | PATHFIND_FARFROMPOLY_END, // start or end positions are far from the mmap poligon
};

class PathGenerator
{
    public:
        explicit PathGenerator(WorldObject const* owner);
        ~PathGenerator();

        // Calculate the path from owner to given destination
        // return: true if new path was calculated, false otherwise (no change needed)
        auto CalculatePath(float destX, float destY, float destZ, bool forceDest = false) -> bool;
        auto CalculatePath(float x, float y, float z, float destX, float destY, float destZ, bool forceDest) -> bool;
        [[nodiscard]] auto IsInvalidDestinationZ(Unit const* target) const -> bool;
        [[nodiscard]] auto IsWalkableClimb(float const* v1, float const* v2) const -> bool;
        [[nodiscard]] auto IsWalkableClimb(float x, float y, float z, float destX, float destY, float destZ) const -> bool;
        [[nodiscard]] static auto IsWalkableClimb(float x, float y, float z, float destX, float destY, float destZ, float sourceHeight) -> bool;
        [[nodiscard]] auto IsWaterPath(Movement::PointsArray pathPoints) const -> bool;
        [[nodiscard]] auto IsSwimmableSegment(float const* v1, float const* v2, bool checkSwim = true) const -> bool;
        [[nodiscard]] auto IsSwimmableSegment(float x, float y, float z, float destX, float destY, float destZ, bool checkSwim = true) const -> bool;
        [[nodiscard]] static auto GetRequiredHeightToClimb(float x, float y, float z, float destX, float destY, float destZ, float sourceHeight) -> float;

        // option setters - use optional

        // when set, it skips paths with too high slopes (doesn't work with StraightPath enabled)
        void SetSlopeCheck(bool checkSlope) { _slopeCheck = checkSlope; }
        void SetUseStraightPath(bool useStraightPath) { _useStraightPath = useStraightPath; }
        void SetPathLengthLimit(float distance) { _pointPathLimit = std::min<uint32>(uint32(distance/SMOOTH_PATH_STEP_SIZE), MAX_POINT_PATH_LENGTH); }
        void SetUseRaycast(bool useRaycast) { _useRaycast = useRaycast; }

        // result getters
        [[nodiscard]] auto GetStartPosition() const -> G3D::Vector3 const& { return _startPosition; }
        [[nodiscard]] auto GetEndPosition() const -> G3D::Vector3 const& { return _endPosition; }
        [[nodiscard]] auto GetActualEndPosition() const -> G3D::Vector3 const& { return _actualEndPosition; }

        [[nodiscard]] auto GetPath() const -> Movement::PointsArray const& { return _pathPoints; }

        [[nodiscard]] auto GetPathType() const -> PathType { return _type; }

        // shortens the path until the destination is the specified distance from the target point
        void ShortenPathUntilDist(G3D::Vector3 const& point, float dist);

        [[nodiscard]] auto getPathLength() const -> float
        {
            float len = 0.0f;
            float dx, dy, dz;
            uint32 size = _pathPoints.size();
            if (size)
            {
                dx = _pathPoints[0].x - _startPosition.x;
                dy = _pathPoints[0].y - _startPosition.y;
                dz = _pathPoints[0].z - _startPosition.z;
                len += sqrt( dx * dx + dy * dy + dz * dz );
            }
            else
            {
                return len;
            }

            for (uint32 i = 1; i < size; ++i)
            {
                dx = _pathPoints[i].x - _pathPoints[i - 1].x;
                dy = _pathPoints[i].y - _pathPoints[i - 1].y;
                dz = _pathPoints[i].z - _pathPoints[i - 1].z;
                len += sqrt( dx * dx + dy * dy + dz * dz );
            }
            return len;
        }

        void Clear()
        {
            _polyLength = 0;
            _pathPoints.clear();
        }

    private:
        dtPolyRef _pathPolyRefs[MAX_PATH_LENGTH];   // array of detour polygon references
        uint32 _polyLength;                         // number of polygons in the path

        Movement::PointsArray _pathPoints;  // our actual (x,y,z) path to the target
        PathType _type;                     // tells what kind of path this is

        bool _useStraightPath;  // type of path will be generated (do not use it for movement paths)
        bool _forceDestination; // when set, we will always arrive at given point
        bool _slopeCheck;       // when set, it skips paths with too high slopes (doesn't work with _useStraightPath)
        uint32 _pointPathLimit; // limit point path size; min(this, MAX_POINT_PATH_LENGTH)
        bool _useRaycast;       // use raycast if true for a straight line path

        G3D::Vector3 _startPosition;        // {x, y, z} of current location
        G3D::Vector3 _endPosition;          // {x, y, z} of the destination
        G3D::Vector3 _actualEndPosition;    // {x, y, z} of the closest possible point to given destination

        WorldObject const* const _source;       // the object that is moving
        dtNavMesh const* _navMesh;              // the nav mesh
        dtNavMeshQuery const* _navMeshQuery;    // the nav mesh query used to find the path

        dtQueryFilterExt _filter;  // use single filter for all movements, update it when needed

        void SetStartPosition(G3D::Vector3 const& point) { _startPosition = point; }
        void SetEndPosition(G3D::Vector3 const& point) { _actualEndPosition = point; _endPosition = point; }
        void SetActualEndPosition(G3D::Vector3 const& point) { _actualEndPosition = point; }
        void NormalizePath();

        [[nodiscard]] auto InRange(G3D::Vector3 const& p1, G3D::Vector3 const& p2, float r, float h) const -> bool;
        [[nodiscard]] auto Dist3DSqr(G3D::Vector3 const& p1, G3D::Vector3 const& p2) const -> float;
        auto InRangeYZX(float const* v1, float const* v2, float r, float h) const -> bool;

        auto GetPathPolyByPosition(dtPolyRef const* polyPath, uint32 polyPathSize, float const* Point, float* Distance = nullptr) const -> dtPolyRef;
        auto GetPolyByLocation(float const* Point, float* Distance) const -> dtPolyRef;
        [[nodiscard]] auto HaveTile(G3D::Vector3 const& p) const -> bool;

        void BuildPolyPath(G3D::Vector3 const& startPos, G3D::Vector3 const& endPos);
        void BuildPointPath(float const* startPoint, float const* endPoint);
        void BuildShortcut();

        [[nodiscard]] auto GetNavTerrain(float x, float y, float z) const -> NavTerrain;
        void CreateFilter();
        void UpdateFilter();

        // smooth path aux functions
        auto FixupCorridor(dtPolyRef* path, uint32 npath, uint32 maxPath, dtPolyRef const* visited, uint32 nvisited) -> uint32;
        auto GetSteerTarget(float const* startPos, float const* endPos, float minTargetDist, dtPolyRef const* path, uint32 pathSize, float* steerPos,
                            unsigned char& steerPosFlag, dtPolyRef& steerPosRef) -> bool;
        auto FindSmoothPath(float const* startPos, float const* endPos,
                              dtPolyRef const* polyPath, uint32 polyPathSize,
                              float* smoothPath, int* smoothPathSize, uint32 smoothPathMaxSize) -> dtStatus;

        void AddFarFromPolyFlags(bool startFarFromPoly, bool endFarFromPoly);
};

#endif
