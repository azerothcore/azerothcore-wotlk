/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "PathGenerator.h"
#include "Map.h"
#include "Creature.h"
#include "Log.h"
#include "CellImpl.h"
#include "Cell.h"

#include "DetourCommon.h"
#include "DetourNavMeshQuery.h"

////////////////// PathGenerator //////////////////
PathGenerator::PathGenerator(const Unit* owner) :
    _polyLength(0), _type(PATHFIND_BLANK), _useStraightPath(false),
    _forceDestination(false), _pointPathLimit(MAX_POINT_PATH_LENGTH),
    _endPosition(G3D::Vector3::zero()), _sourceUnit(owner), _navMesh(nullptr),
    _navMeshQuery(nullptr)
{
    memset(_pathPolyRefs, 0, sizeof(_pathPolyRefs));

    uint32 mapId = _sourceUnit->GetMapId();
    //if (MMAP::MMapFactory::IsPathfindingEnabled(_sourceUnit->FindMap())) // pussywizard: checked before creating new PathGenerator
    {
        MMAP::MMapManager* mmap = MMAP::MMapFactory::createOrGetMMapManager();

        ACORE_READ_GUARD(ACE_RW_Thread_Mutex, mmap->GetManagerLock());
        _navMesh = mmap->GetNavMesh(mapId);
        _navMeshQuery = mmap->GetNavMeshQuery(mapId, _sourceUnit->GetInstanceId());
    }

    CreateFilter();
}

PathGenerator::~PathGenerator()
{
}

bool PathGenerator::CalculatePath(float destX, float destY, float destZ, bool forceDest)
{
    float x, y, z;
    if (!_sourceUnit->movespline->Finalized() && _sourceUnit->movespline->Initialized())
    {
        Movement::Location realpos = _sourceUnit->movespline->ComputePosition();
        x = realpos.x; y = realpos.y; z = realpos.z;
    }
    else
        _sourceUnit->GetPosition(x, y, z);

    if (!acore::IsValidMapCoord(destX, destY, destZ) || !acore::IsValidMapCoord(x, y, z))
        return false;

    G3D::Vector3 dest(destX, destY, destZ);
    SetEndPosition(dest);
    G3D::Vector3 start(x, y, z);
    SetStartPosition(start);
    _forceDestination = forceDest;

    // pussywizard: EnsureGridCreated may need map mutex, and it loads mmaps (may need mmap mutex)
    // pussywizard: a deadlock can occur if here the map mutex is requested after acquiring mmap lock below
    // pussywizard: so call EnsureGridCreated for all possible grids before acquiring mmap lock :/ this is so shit... because the core is shit :/
    {
        Cell cellS(start.x, start.y);
        _sourceUnit->GetMap()->EnsureGridCreated(GridCoord(cellS.GridX(), cellS.GridY()));
        Cell cellD(dest.x, dest.y);
        _sourceUnit->GetMap()->EnsureGridCreated(GridCoord(cellD.GridX(), cellD.GridY()));
    }

    UpdateFilter(); // no mmap operations inside, no mutex needed

    // pussywizard: mutex with new that can be release at any moment, DON'T FORGET TO RELEASE ON EVERY RETURN !!!
    const Map* base = _sourceUnit->GetBaseMap();
    ACE_RW_Thread_Mutex& mmapLock = (base ? base->GetMMapLock() : MMAP::MMapFactory::createOrGetMMapManager()->GetMMapGeneralLock());
    mmapLock.acquire_read();

    // make sure navMesh works - we can run on map w/o mmap
    // check if the start and end point have a .mmtile loaded (can we pass via not loaded tile on the way?)
    if (!_navMesh || !_navMeshQuery || _sourceUnit->HasUnitState(UNIT_STATE_IGNORE_PATHFINDING) ||
        _sourceUnit->GetObjectSize() >= SIZE_OF_GRIDS/2.0f || _sourceUnit->GetExactDistSq(destX, destY, destZ) >= (SIZE_OF_GRIDS*SIZE_OF_GRIDS/4.0f) || 
        !HaveTile(start) || !HaveTile(dest))
    {
        BuildShortcut();
        _type = PathType(PATHFIND_NORMAL | PATHFIND_NOT_USING_PATH);
        mmapLock.release();
        return true;
    }

    BuildPolyPath(start, dest, mmapLock);
    return true;
}

dtPolyRef PathGenerator::GetPathPolyByPosition(dtPolyRef const* polyPath, uint32 polyPathSize, float const* point, float* distance) const
{
    if (!polyPath || !polyPathSize)
        return INVALID_POLYREF;

    float polyHeight, height;
    for (uint32 i = 0; i < polyPathSize; ++i)
    {
        if (DT_SUCCESS != _navMeshQuery->getPolyHeight(polyPath[i], point, &polyHeight))
            continue;
        height = point[1]-polyHeight;
        if (height > 0.0f && height < ALLOWED_DIST_FROM_POLY+ADDED_Z_FOR_POLY_LOOKUP)
        {
            if (distance)
                *distance = height;
            return polyPath[i];
        }
    }

    return INVALID_POLYREF;
}

dtPolyRef PathGenerator::GetPolyByLocation(float* point, float* distance) const
{
    // first we check the current path
    // if the current path doesn't contain the current poly,
    // we need to use the expensive navMesh.findNearestPoly

    point[1] += ADDED_Z_FOR_POLY_LOOKUP;
    dtPolyRef polyRef = GetPathPolyByPosition(_pathPolyRefs, _polyLength, point, distance);
    point[1] -= ADDED_Z_FOR_POLY_LOOKUP;
    if (polyRef != INVALID_POLYREF)
        return polyRef;

    // we don't have it in our old path
    // try to get it by findNearestPoly()
    // first try with low search box
    float extents[VERTEX_SIZE] = {3.0f, 5.0f, 3.0f};    // bounds of poly search area
    float closestPoint[VERTEX_SIZE] = {0.0f, 0.0f, 0.0f};
    dtStatus result = _navMeshQuery->findNearestPoly(point, extents, &_filter, &polyRef, closestPoint);
    if (DT_SUCCESS == result && polyRef != INVALID_POLYREF)
    {
        *distance = dtVdist(closestPoint, point);
        return polyRef;
    }

    // still nothing ..
    // try with bigger search box
    // Note that the extent should not overlap more than 128 polygons in the navmesh (see dtNavMeshQuery::findNearestPoly)
    extents[1] = 50.0f;

    if (dtStatusSucceed(_navMeshQuery->findNearestPoly(point, extents, &_filter, &polyRef, closestPoint)) && polyRef != INVALID_POLYREF)
    {
        *distance = dtVdist(closestPoint, point);
        return polyRef;
    }

    return INVALID_POLYREF;
}

G3D::Vector3 ClosestPointOnLine(const G3D::Vector3 & a, const G3D::Vector3 & b, const G3D::Vector3 & Point)
{
    G3D::Vector3 c = Point - a; // Vector from a to Point
    G3D::Vector3 v = (b - a).unit(); // Unit Vector from a to b
    float d = (b - a).length(); // Length of the line segment
    float t = v.dot(c); // Intersection point Distance from a

    // Check to see if the point is on the line
    // if not then return the endpoint
    if(t < 0) return a;
    if(t > d) return b;

    // get the distance to move from point a
    v *= t;

    // move from point a to the nearest point on the segment
    return a + v;
}

template <class MUTEX_TYPE>
class MutexReleaser
{
public:
    MutexReleaser(MUTEX_TYPE& mutex) : _mutex(mutex) {}
    ~MutexReleaser() { _mutex.release(); }
private:
    MUTEX_TYPE& _mutex;
};

void PathGenerator::BuildPolyPath(G3D::Vector3 const& startPos, G3D::Vector3 const& endPos, ACE_RW_Thread_Mutex& mmapLock)
{
    bool endInWaterFar = false;
    bool cutToFirstHigher = false;

    {
    MutexReleaser<ACE_RW_Thread_Mutex> mutexReleaser(mmapLock);

    // *** getting start/end poly logic ***

    float distToStartPoly, distToEndPoly;
    float startPoint[VERTEX_SIZE] = {startPos.y, startPos.z, startPos.x};
    float endPoint[VERTEX_SIZE] = {endPos.y, endPos.z, endPos.x};

    dtPolyRef startPoly = GetPolyByLocation(startPoint, &distToStartPoly);
    dtPolyRef endPoly = GetPolyByLocation(endPoint, &distToEndPoly);

    bool sourceIsFlying = (_sourceUnit->GetUnitMovementFlags() & (MOVEMENTFLAG_CAN_FLY|MOVEMENTFLAG_FLYING)) || (_sourceUnit->HasUnitMovementFlag(MOVEMENTFLAG_DISABLE_GRAVITY) && !_sourceUnit->HasUnitMovementFlag(MOVEMENTFLAG_SWIMMING)) || (_sourceUnit->GetTypeId() == TYPEID_UNIT && ((Creature*)_sourceUnit)->CanFly());
    bool sourceCanSwim = _sourceUnit->GetTypeId() == TYPEID_UNIT ? _sourceUnit->ToCreature()->CanSwim() : true;
    bool sourceCanWalk = _sourceUnit->GetTypeId() == TYPEID_UNIT ? _sourceUnit->ToCreature()->CanWalk() : true;

    // we have a hole in our mesh
    // make shortcut path and mark it as NOPATH ( with flying and swimming exception )
    // its up to caller how he will use this info
    if (startPoly == INVALID_POLYREF || endPoly == INVALID_POLYREF)
    {
        BuildShortcut();
        if (sourceIsFlying)
        {
            _type = PathType(PATHFIND_NORMAL | PATHFIND_NOT_USING_PATH);
            return;
        }
        if (sourceCanSwim)
        {
            if ((startPoly == INVALID_POLYREF && LIQUID_MAP_NO_WATER == _sourceUnit->GetBaseMap()->getLiquidStatus(startPos.x, startPos.y, startPos.z, MAP_ALL_LIQUIDS, nullptr)) ||
                (endPoly == INVALID_POLYREF && LIQUID_MAP_NO_WATER == _sourceUnit->GetBaseMap()->getLiquidStatus(endPos.x, endPos.y, endPos.z, MAP_ALL_LIQUIDS, nullptr)))
                {
                    _type = PATHFIND_NOPATH;
                    return;
                }
            _type = PathType(PATHFIND_NORMAL | PATHFIND_NOT_USING_PATH);
            return;
        }
        _type = PATHFIND_NOPATH;
        return;
    }

    // we may need a better number here
    bool farFromStartPoly = (distToStartPoly > ALLOWED_DIST_FROM_POLY);
    bool farFromEndPoly = (distToEndPoly > ALLOWED_DIST_FROM_POLY);
    if (farFromStartPoly)
    {
        if (sourceIsFlying)
        {
            BuildShortcut();
            _type = PathType(PATHFIND_NORMAL | PATHFIND_NOT_USING_PATH);
            return;
        }
        if (sourceCanSwim)
        {
            if (LIQUID_MAP_NO_WATER == _sourceUnit->GetBaseMap()->getLiquidStatus(startPos.x, startPos.y, startPos.z, MAP_ALL_LIQUIDS, nullptr))
            {
                if (distToStartPoly > MAX_FIXABLE_Z_ERROR)
                {
                    BuildShortcut();
                    _type = PATHFIND_NOPATH;
                    return;
                }

                if (farFromEndPoly)
                {
                    if (LIQUID_MAP_NO_WATER == _sourceUnit->GetBaseMap()->getLiquidStatus(endPos.x, endPos.y, endPos.z, MAP_ALL_LIQUIDS, nullptr))
                    {
                        BuildShortcut();
                        _type = PATHFIND_NOPATH;
                        return;
                    }
                }
            }
            else if (LIQUID_MAP_NO_WATER == _sourceUnit->GetBaseMap()->getLiquidStatus(endPos.x, endPos.y, endPos.z, MAP_ALL_LIQUIDS, nullptr))
            {
                if (farFromEndPoly)
                {
                    BuildShortcut();
                    _type = PATHFIND_NOPATH;
                    return;
                }

                cutToFirstHigher = true;
            }
            else // starting and ending points are in water
            {
                BuildShortcut();
                _type = PathType(PATHFIND_NORMAL | PATHFIND_NOT_USING_PATH);
                return;
            }
        }
        else
        {
            if (distToStartPoly > MAX_FIXABLE_Z_ERROR || farFromEndPoly)
            {
                BuildShortcut();
                _type = PATHFIND_NOPATH;
                return;
            }
        }
    }
    else if (farFromEndPoly)
    {
        if (sourceIsFlying)
        {
            BuildShortcut();
            _type = PathType(PATHFIND_NORMAL | PATHFIND_NOT_USING_PATH);
            return;
        }
        if (LIQUID_MAP_NO_WATER == _sourceUnit->GetBaseMap()->getLiquidStatus(endPos.x, endPos.y, endPos.z, MAP_ALL_LIQUIDS, nullptr))
        {
            if (!sourceCanWalk)
            {
                BuildShortcut();
                _type = PATHFIND_NOPATH;
                return;
            }
        }
        else
        {
            if (!sourceCanSwim)
            {
                BuildShortcut();
                _type = PATHFIND_NOPATH;
                return;
            }

            // if both points are in water
            if (LIQUID_MAP_NO_WATER != _sourceUnit->GetBaseMap()->getLiquidStatus(startPos.x, startPos.y, startPos.z, MAP_ALL_LIQUIDS, nullptr))
            {
                BuildShortcut();
                _type = PathType(PATHFIND_NORMAL | PATHFIND_NOT_USING_PATH);
                return;
            }

            endInWaterFar = true;
        }

        if (startPoly != endPoly || !endInWaterFar)
        {
            float closestPoint[VERTEX_SIZE];
            if (dtStatusSucceed(_navMeshQuery->closestPointOnPoly(endPoly, endPoint, closestPoint, nullptr)))
            {
                dtVcopy(endPoint, closestPoint);
                SetActualEndPosition(G3D::Vector3(endPoint[2], endPoint[0], endPoint[1]));
            }
            _type = PATHFIND_INCOMPLETE;
        }
    }

    // *** poly path generating logic ***

    if (startPoly == endPoly)
    {
        BuildShortcut();
        _type = !farFromEndPoly || endInWaterFar ? PATHFIND_NORMAL : PATHFIND_INCOMPLETE;
        _pathPolyRefs[0] = startPoly;
        _polyLength = 1;
        return;
    }

    // look for startPoly/endPoly in current path
    /// @todo we can merge it with getPathPolyByPosition() loop
    bool startPolyFound = false;
    bool endPolyFound = false;
    uint32 pathStartIndex = 0;
    uint32 pathEndIndex = 0;

    if (_polyLength)
    {
        for (; pathStartIndex < _polyLength; ++pathStartIndex)
        {
            // here to catch few bugs
            ASSERT(_pathPolyRefs[pathStartIndex] != INVALID_POLYREF);

            if (_pathPolyRefs[pathStartIndex] == startPoly)
            {
                startPolyFound = true;
                break;
            }
        }

        for (pathEndIndex = _polyLength-1; pathEndIndex > pathStartIndex; --pathEndIndex)
            if (_pathPolyRefs[pathEndIndex] == endPoly)
            {
                endPolyFound = true;
                break;
            }
    }

    if (startPolyFound && endPolyFound)
    {
        _polyLength = pathEndIndex - pathStartIndex + 1;
        memmove(_pathPolyRefs, _pathPolyRefs + pathStartIndex, _polyLength * sizeof(dtPolyRef));
    }
    else if (startPolyFound && !endPolyFound && _polyLength-pathStartIndex >= 3 /*if (>=3) then 70% will return at least one more than just startPoly*/)
    {
        // we are moving on the old path but target moved out
        // so we have atleast part of poly-path ready

        _polyLength -= pathStartIndex;

        // try to adjust the suffix of the path instead of recalculating entire length
        // at given interval the target cannot get too far from its last location
        // thus we have less poly to cover
        // sub-path of optimal path is optimal

        // take ~65% of the original length
        /// @todo play with the values here
        uint32 prefixPolyLength = uint32(_polyLength * 0.7f + 0.5f); // this should be always >= 1
        memmove(_pathPolyRefs, _pathPolyRefs+pathStartIndex, prefixPolyLength * sizeof(dtPolyRef));

        dtPolyRef suffixStartPoly = _pathPolyRefs[prefixPolyLength-1];

        bool error = false; // can't use a part of old path, generate whole new

        // we need any point on our suffix start poly to generate poly-path, so we need last poly in prefix data
        float suffixEndPoint[VERTEX_SIZE];
        if (dtStatusFailed(_navMeshQuery->closestPointOnPoly(suffixStartPoly, endPoint, suffixEndPoint, nullptr)))
        {
            // we can hit offmesh connection as last poly - closestPointOnPoly() don't like that
            // try to recover by using prev polyref
            --prefixPolyLength;
            if (prefixPolyLength)
            {
                suffixStartPoly = _pathPolyRefs[prefixPolyLength-1];
                if (dtStatusFailed(_navMeshQuery->closestPointOnPoly(suffixStartPoly, endPoint, suffixEndPoint,NULL)))
                    error = true;
            }
            else
                error = true;
        }

        if (!error)
        {
            // generate suffix
            uint32 suffixPolyLength = 0;
            dtStatus dtResult = _navMeshQuery->findPath(
                                    suffixStartPoly,    // start polygon
                                    endPoly,            // end polygon
                                    suffixEndPoint,     // start position
                                    endPoint,           // end position
                                    &_filter,            // polygon search filter
                                    _pathPolyRefs + prefixPolyLength - 1,    // [out] path
                                    (int*)&suffixPolyLength,
                                    MAX_PATH_LENGTH-prefixPolyLength);   // max number of polygons in output path

            if (!_polyLength || dtStatusFailed(dtResult))
            {
                // this is probably an error state, but we'll leave it
                // and hopefully recover on the next Update
                // we still need to copy our preffix
            }

            // new path = prefix + suffix - overlap
            _polyLength = prefixPolyLength + suffixPolyLength - 1;
        }
        else
        {
            // free and invalidate old path data
            Clear();

            dtStatus dtResult = _navMeshQuery->findPath(
                    startPoly,          // start polygon
                    endPoly,            // end polygon
                    startPoint,         // start position
                    endPoint,           // end position
                    &_filter,           // polygon search filter
                    _pathPolyRefs,     // [out] path
                    (int*)&_polyLength,
                    MAX_PATH_LENGTH);   // max number of polygons in output path

            if (!_polyLength || dtStatusFailed(dtResult))
            {
                // only happens if we passed bad data to findPath(), or navmesh is messed up
                BuildShortcut();
                _type = PATHFIND_NOPATH;
                return;
            }
        }
    }
    else
    {
        // either we have no path at all -> first run
        // or something went really wrong -> we aren't moving along the path to the target
        // pussywizard: or knocked back away from our path, nothing special
        // just generate new path

        // free and invalidate old path data
        Clear();

        dtStatus dtResult = _navMeshQuery->findPath(
                startPoly,          // start polygon
                endPoly,            // end polygon
                startPoint,         // start position
                endPoint,           // end position
                &_filter,           // polygon search filter
                _pathPolyRefs,     // [out] path
                (int*)&_polyLength,
                MAX_PATH_LENGTH);   // max number of polygons in output path

        if (!_polyLength || dtStatusFailed(dtResult))
        {
            // only happens if we passed bad data to findPath(), or navmesh is messed up
            BuildShortcut();
            _type = PATHFIND_NOPATH;
            return;
        }
    }

    // by now we know what type of path we can get
    if (_pathPolyRefs[_polyLength - 1] == endPoly && !(_type & PATHFIND_INCOMPLETE))
        _type = PATHFIND_NORMAL;
    else
        _type = PATHFIND_INCOMPLETE;

    // generate the point-path out of our up-to-date poly-path
    BuildPointPath(startPoint, endPoint);

    // pussywizard: no mmap usage below, release mutex
    } // end of scope (mutex released in object destructor)

    if (_type == PATHFIND_NORMAL && cutToFirstHigher) // starting in water, far from bottom, target is on the ground (above starting Z) -> update beginning points that are lower than starting Z
    {
        uint32 i = 0;
        uint32 size = _pathPoints.size();
        for (; i < size; ++i)
            if (_pathPoints[i].z >= _sourceUnit->GetPositionZ()+0.1f)
                break;
        if (i && i != size && LIQUID_MAP_NO_WATER != _sourceUnit->GetBaseMap()->getLiquidStatus(_pathPoints[i-1].x, _pathPoints[i-1].y, _pathPoints[i-1].z, MAP_ALL_LIQUIDS, nullptr))
            for (uint32 j=0; j<i; ++j)
                _pathPoints[j].z = _sourceUnit->GetPositionZ();
    }

    if (!_forceDestination)
        if (uint32 lastIdx = _pathPoints.size())
        {
            lastIdx = lastIdx-1;
            if (endInWaterFar)
            {
                SetActualEndPosition(GetEndPosition());
                _pathPoints[lastIdx] = GetEndPosition();
            }
            else
                _sourceUnit->UpdateAllowedPositionZ(_pathPoints[lastIdx].x, _pathPoints[lastIdx].y, _pathPoints[lastIdx].z);
        }


    // pussywizard: fix for running back and forth while target moves
    // pussywizard: second point (first is actual position) is forward to current server position, but when received by the client it's already behind, so the npc runs back to that point
    // pussywizard: the higher speed, the more probable the situation is, so try to move second point as far forward the path as possible
    // pussywizard: changed path cannot differ much from the original (by max dist), because there might be walls and holes
    if (_sourceUnit->GetCreatureType() != CREATURE_TYPE_NON_COMBAT_PET)
        return;
    uint32 size = _pathPoints.size();
    bool ok = true;
    for (uint32 i = 2; i <= size; ++i)
    {
        // pussywizard: line between start point and i'th point
        // pussywizard: distance to that line of all points between 0 and i must be less than X and less than sourceUnit size

        if (i < size)
        {
            ok = true;
            if ((_pathPoints[i] - _pathPoints[0]).squaredLength() > 15.0f*15.0f)
                ok = false;
            else
                for (uint32 j = 1; j < i; ++j)
                {
                    float sqDist = (_pathPoints[j] - ClosestPointOnLine(_pathPoints[0], _pathPoints[i], _pathPoints[j])).squaredLength();
                    float oSize = _sourceUnit->GetObjectSize();
                    if (sqDist > 1.0f*1.0f || sqDist > oSize*oSize)
                    {
                        ok = false;
                        break;
                    }
                }
        }

        if (!ok)
        {
            if (i < size)
            {
                // pussywizard: check additional 3 quarter points after last fitting poly point

                G3D::Vector3 dir = _pathPoints[i] - _pathPoints[i-1];
                G3D::Vector3 increment = (dir.length()/4.0f) * dir.unit();
                for (uint8 k = 3; k > 0; --k)
                {
                    G3D::Vector3 newPoint = _pathPoints[i-1] + ((float)k)*increment;

                    bool ok2 = true;
                    if ((newPoint - _pathPoints[0]).squaredLength() > 15.0f*15.0f)
                        ok2 = false;
                    else
                        for (uint32 j = 1; j < i; ++j)
                        {
                            float sqDist = (_pathPoints[j] - ClosestPointOnLine(_pathPoints[0], newPoint, _pathPoints[j])).squaredLength();
                            float oSize = _sourceUnit->GetObjectSize();
                            if (sqDist > 1.0f*1.0f || sqDist > oSize*oSize)
                            {
                                ok2 = false;
                                break;
                            }
                        }

                    if (ok2)
                    {
                        _pathPoints[i-1] = newPoint;
                        break;
                    }
                }

                // pussywizard: memmove crashes o_O
                // memmove(&_pathPoints + sizeof(G3D::Vector3), &_pathPoints + (i-1)*sizeof(G3D::Vector3), (size-i+1)*sizeof(G3D::Vector3));
                for (uint8 k = 1; k <= size-i+1; ++k)
                    _pathPoints[k] = _pathPoints[k+i-2];
                _pathPoints.resize(size-i+2);
            }
            else if (size > 2)
            {
                _pathPoints[1] = _pathPoints[size-1];
                _pathPoints.resize(2);
            }

            break;
        }
    }
}

void PathGenerator::BuildPointPath(const float *startPoint, const float *endPoint)
{
    float pathPoints[MAX_POINT_PATH_LENGTH*VERTEX_SIZE];
    uint32 pointCount = 0;
    dtStatus dtResult = DT_FAILURE;
    if (_useStraightPath)
    {
        dtResult = _navMeshQuery->findStraightPath(
                startPoint,         // start position
                endPoint,           // end position
                _pathPolyRefs,     // current path
                _polyLength,       // lenth of current path
                pathPoints,         // [out] path corner points
                NULL,               // [out] flags
                NULL,               // [out] shortened path
                (int*)&pointCount,
                _pointPathLimit);   // maximum number of points/polygons to use
    }
    else
    {
        dtResult = FindSmoothPath(
                startPoint,         // start position
                endPoint,           // end position
                _pathPolyRefs,     // current path
                _polyLength,       // length of current path
                pathPoints,         // [out] path corner points
                (int*)&pointCount,
                _pointPathLimit);    // maximum number of points
    }

    if (pointCount < 2 || dtStatusFailed(dtResult))
    {
        // only happens if pass bad data to findStraightPath or navmesh is broken
        // single point paths can be generated here
        /// @todo check the exact cases
        BuildShortcut();
        _type = PATHFIND_NOPATH;
        return;
    }
    else if (pointCount == _pointPathLimit)
    {
        BuildShortcut();
        _type = PATHFIND_SHORT;
        return;
    }

    _pathPoints.resize(pointCount);
    for (uint32 i = 0; i < pointCount; ++i)
        _pathPoints[i] = G3D::Vector3(pathPoints[i*VERTEX_SIZE+2], pathPoints[i*VERTEX_SIZE], pathPoints[i*VERTEX_SIZE+1]);

    // first point is always our current location - we need the next one
    SetActualEndPosition(_pathPoints[pointCount-1]);

    if (_forceDestination && (!(_type & PATHFIND_NORMAL) || !InRange(GetEndPosition(), GetActualEndPosition(), 0.75f, 0.75f)))
    {
        // we may want to keep partial subpath
        if (Dist3DSqr(GetActualEndPosition(), GetEndPosition()) < 0.33f * Dist3DSqr(GetStartPosition(), GetEndPosition()))
        {
            SetActualEndPosition(GetEndPosition());
            _pathPoints[_pathPoints.size()-1] = GetEndPosition();
        }
        else
        {
            SetActualEndPosition(GetEndPosition());
            BuildShortcut();
        }

        _type = PathType(PATHFIND_NORMAL | PATHFIND_NOT_USING_PATH);
    }
}

void PathGenerator::BuildShortcut()
{
    Clear();
    _pathPoints.resize(2);
    _pathPoints[0] = GetStartPosition();
    _pathPoints[1] = GetActualEndPosition();
    _type = PATHFIND_SHORTCUT;
}

void PathGenerator::CreateFilter()
{
    uint16 includeFlags = 0;
    uint16 excludeFlags = 0;

    if (_sourceUnit->GetTypeId() == TYPEID_UNIT)
    {
        Creature* creature = (Creature*)_sourceUnit;
        if (creature->CanWalk())
            includeFlags |= NAV_GROUND;          // walk

        // creatures don't take environmental damage
        if (creature->CanSwim())
            includeFlags |= (NAV_WATER | NAV_MAGMA | NAV_SLIME);           // swim
    }
    else // assume Player
    {
        // perfect support not possible, just stay 'safe'
        includeFlags |= (NAV_GROUND | NAV_WATER | NAV_MAGMA | NAV_SLIME);
    }

    _filter.setIncludeFlags(includeFlags);
    _filter.setExcludeFlags(excludeFlags);

    UpdateFilter();
}

void PathGenerator::UpdateFilter()
{
    // allow creatures to cheat and use different movement types if they are moved
    // forcefully into terrain they can't normally move in
    if (_sourceUnit->IsInWater() || _sourceUnit->IsUnderWater())
    {
        uint16 includedFlags = _filter.getIncludeFlags();
        includedFlags |= GetNavTerrain(_sourceUnit->GetPositionX(),
                                       _sourceUnit->GetPositionY(),
                                       _sourceUnit->GetPositionZ());

        _filter.setIncludeFlags(includedFlags);
    }
}

NavTerrain PathGenerator::GetNavTerrain(float x, float y, float z)
{
    LiquidData data;
    ZLiquidStatus liquidStatus = _sourceUnit->GetBaseMap()->getLiquidStatus(x, y, z, MAP_ALL_LIQUIDS, &data);
    if (liquidStatus == LIQUID_MAP_NO_WATER)
        return NAV_GROUND;

    switch (data.type_flags)
    {
        case MAP_LIQUID_TYPE_WATER:
        case MAP_LIQUID_TYPE_OCEAN:
            return NAV_WATER;
        case MAP_LIQUID_TYPE_MAGMA:
            return NAV_MAGMA;
        case MAP_LIQUID_TYPE_SLIME:
            return NAV_SLIME;
        default:
            return NAV_GROUND;
    }
}

bool PathGenerator::HaveTile(const G3D::Vector3& p) const
{
    int tx = -1, ty = -1;
    float point[VERTEX_SIZE] = {p.y, p.z, p.x};

    _navMesh->calcTileLoc(point, &tx, &ty);

    /// Workaround
    /// For some reason, often the tx and ty variables wont get a valid value
    /// Use this check to prevent getting negative tile coords and crashing on getTileAt
    if (tx < 0 || ty < 0)
        return false;

    return (_navMesh->getTileAt(tx, ty, 0) != nullptr);
}

uint32 PathGenerator::FixupCorridor(dtPolyRef* path, uint32 npath, uint32 maxPath, dtPolyRef const* visited, uint32 nvisited)
{
    int32 furthestPath = -1;
    int32 furthestVisited = -1;

    // Find furthest common polygon.
    for (int32 i = npath-1; i >= 0; --i)
    {
        bool found = false;
        for (int32 j = nvisited-1; j >= 0; --j)
        {
            if (path[i] == visited[j])
            {
                furthestPath = i;
                furthestVisited = j;
                found = true;
            }
        }
        if (found)
            break;
    }

    // If no intersection found just return current path.
    if (furthestPath == -1 || furthestVisited == -1)
        return npath;

    // Concatenate paths.

    // Adjust beginning of the buffer to include the visited.
    uint32 req = nvisited - furthestVisited;
    uint32 orig = uint32(furthestPath + 1) < npath ? furthestPath + 1 : npath;
    uint32 size = npath > orig ? npath - orig : 0;
    if (req + size > maxPath)
        size = maxPath-req;

    if (size)
        memmove(path + req, path + orig, size * sizeof(dtPolyRef));

    // Store visited
    for (uint32 i = 0; i < req; ++i)
        path[i] = visited[(nvisited - 1) - i];

    return req+size;
}

bool PathGenerator::GetSteerTarget(float const* startPos, float const* endPos,
                              float minTargetDist, dtPolyRef const* path, uint32 pathSize,
                              float* steerPos, unsigned char& steerPosFlag, dtPolyRef& steerPosRef)
{
    // Find steer target.
    static const uint32 MAX_STEER_POINTS = 3;
    float steerPath[MAX_STEER_POINTS*VERTEX_SIZE];
    unsigned char steerPathFlags[MAX_STEER_POINTS];
    dtPolyRef steerPathPolys[MAX_STEER_POINTS];
    uint32 nsteerPath = 0;
    dtStatus dtResult = _navMeshQuery->findStraightPath(startPos, endPos, path, pathSize,
                                                steerPath, steerPathFlags, steerPathPolys, (int*)&nsteerPath, MAX_STEER_POINTS);
    if (!nsteerPath || dtStatusFailed(dtResult))
        return false;

    // Find vertex far enough to steer to.
    uint32 ns = 0;
    while (ns < nsteerPath)
    {
        // Stop at Off-Mesh link or when point is further than slop away.
        if ((steerPathFlags[ns] & DT_STRAIGHTPATH_OFFMESH_CONNECTION) ||
            !InRangeYZX(&steerPath[ns*VERTEX_SIZE], startPos, minTargetDist, 1000.0f))
            break;
        ns++;
    }
    // Failed to find good point to steer to.
    if (ns >= nsteerPath)
        return false;

    dtVcopy(steerPos, &steerPath[ns*VERTEX_SIZE]);
    steerPos[1] = startPos[1];  // keep Z value
    steerPosFlag = steerPathFlags[ns];
    steerPosRef = steerPathPolys[ns];

    return true;
}

dtStatus PathGenerator::FindSmoothPath(float const* startPos, float const* endPos,
                                     dtPolyRef const* polyPath, uint32 polyPathSize,
                                     float* smoothPath, int* smoothPathSize, uint32 maxSmoothPathSize)
{
    *smoothPathSize = 0;
    uint32 nsmoothPath = 0;

    dtPolyRef polys[MAX_PATH_LENGTH];
    memcpy(polys, polyPath, sizeof(dtPolyRef)*polyPathSize);
    uint32 npolys = polyPathSize;

    float iterPos[VERTEX_SIZE], targetPos[VERTEX_SIZE];
    if (DT_SUCCESS != _navMeshQuery->closestPointOnPolyBoundary(polys[0], startPos, iterPos))
        return DT_FAILURE;

    if (DT_SUCCESS != _navMeshQuery->closestPointOnPolyBoundary(polys[npolys-1], endPos, targetPos))
        return DT_FAILURE;

    dtVcopy(&smoothPath[nsmoothPath*VERTEX_SIZE], iterPos);
    nsmoothPath++;

    // Move towards target a small advancement at a time until target reached or
    // when ran out of memory to store the path.
    while (npolys && nsmoothPath < maxSmoothPathSize)
    {
        // Find location to steer towards.
        float steerPos[VERTEX_SIZE];
        unsigned char steerPosFlag;
        dtPolyRef steerPosRef = INVALID_POLYREF;

        if (!GetSteerTarget(iterPos, targetPos, SMOOTH_PATH_SLOP, polys, npolys, steerPos, steerPosFlag, steerPosRef))
            break;

        bool endOfPath = (steerPosFlag & DT_STRAIGHTPATH_END);
        bool offMeshConnection = (steerPosFlag & DT_STRAIGHTPATH_OFFMESH_CONNECTION);

        // Find movement delta.
        float delta[VERTEX_SIZE];
        dtVsub(delta, steerPos, iterPos);
        float len = dtMathSqrtf(dtVdot(delta, delta));
        // If the steer target is end of path or off-mesh link, do not move past the location.
        if ((endOfPath || offMeshConnection) && len < SMOOTH_PATH_STEP_SIZE)
            len = 1.0f;
        else
            len = SMOOTH_PATH_STEP_SIZE / len;

        float moveTgt[VERTEX_SIZE];
        dtVmad(moveTgt, iterPos, delta, len);

        // Move
        float result[VERTEX_SIZE];
        const static uint32 MAX_VISIT_POLY = 16;
        dtPolyRef visited[MAX_VISIT_POLY];

        uint32 nvisited = 0;
        _navMeshQuery->moveAlongSurface(polys[0], iterPos, moveTgt, &_filter, result, visited, (int*)&nvisited, MAX_VISIT_POLY);
        npolys = FixupCorridor(polys, npolys, MAX_PATH_LENGTH, visited, nvisited);

        _navMeshQuery->getPolyHeight(polys[0], result, &result[1]);
        result[1] += 0.5f;
        dtVcopy(iterPos, result);

        // Handle end of path and off-mesh links when close enough.
        if (endOfPath && InRangeYZX(iterPos, steerPos, SMOOTH_PATH_SLOP, 1.0f))
        {
            // Reached end of path.
            dtVcopy(iterPos, targetPos);
            if (nsmoothPath < maxSmoothPathSize)
            {
                dtVcopy(&smoothPath[nsmoothPath*VERTEX_SIZE], iterPos);
                nsmoothPath++;
            }
            break;
        }
        else if (offMeshConnection && InRangeYZX(iterPos, steerPos, SMOOTH_PATH_SLOP, 1.0f))
        {
            // Advance the path up to and over the off-mesh connection.
            dtPolyRef prevRef = INVALID_POLYREF;
            dtPolyRef polyRef = polys[0];
            uint32 npos = 0;
            while (npos < npolys && polyRef != steerPosRef)
            {
                prevRef = polyRef;
                polyRef = polys[npos];
                npos++;
            }

            for (uint32 i = npos; i < npolys; ++i)
                polys[i-npos] = polys[i];

            npolys -= npos;

            // Handle the connection.
            float startPos[VERTEX_SIZE], endPos[VERTEX_SIZE];
            if (DT_SUCCESS == _navMesh->getOffMeshConnectionPolyEndPoints(prevRef, polyRef, startPos, endPos))
            {
                if (nsmoothPath < maxSmoothPathSize)
                {
                    dtVcopy(&smoothPath[nsmoothPath*VERTEX_SIZE], startPos);
                    nsmoothPath++;
                }
                // Move position at the other side of the off-mesh link.
                dtVcopy(iterPos, endPos);
                _navMeshQuery->getPolyHeight(polys[0], iterPos, &iterPos[1]);
                iterPos[1] += 0.5f;
            }
        }

        // Store results.
        if (nsmoothPath < maxSmoothPathSize)
        {
            dtVcopy(&smoothPath[nsmoothPath*VERTEX_SIZE], iterPos);
            nsmoothPath++;
        }
    }

    *smoothPathSize = nsmoothPath;

    // this is most likely a loop
    return nsmoothPath < MAX_POINT_PATH_LENGTH ? DT_SUCCESS : DT_FAILURE;
}

bool PathGenerator::InRangeYZX(const float* v1, const float* v2, float r, float h) const
{
    const float dx = v2[0] - v1[0];
    const float dy = v2[1] - v1[1]; // elevation
    const float dz = v2[2] - v1[2];
    return (dx * dx + dz * dz) < r * r && fabsf(dy) < h;
}

bool PathGenerator::InRange(G3D::Vector3 const& p1, G3D::Vector3 const& p2, float r, float h) const
{
    G3D::Vector3 d = p1 - p2;
    return (d.x * d.x + d.y * d.y) < r * r && fabsf(d.z) < h;
}

float PathGenerator::Dist3DSqr(G3D::Vector3 const& p1, G3D::Vector3 const& p2) const
{
    return (p1 - p2).squaredLength();
}
