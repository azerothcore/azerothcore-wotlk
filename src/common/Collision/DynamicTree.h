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

#ifndef _DYNTREE_H
#define _DYNTREE_H

#include "Define.h"
#include "Optional.h"

namespace G3D
{
    class Ray;
    class Vector3;
}

namespace VMAP
{
    struct AreaAndLiquidData;
    enum class ModelIgnoreFlags : uint32;
}

class GameObjectModel;
struct DynTreeImpl;

class DynamicMapTree
{
    DynTreeImpl* impl;

public:
    DynamicMapTree();
    ~DynamicMapTree();

    [[nodiscard]] bool isInLineOfSight(float x1, float y1, float z1, float x2, float y2, float z2, uint32 phasemask, VMAP::ModelIgnoreFlags ignoreFlags) const;

    bool GetIntersectionTime(uint32 phasemask, const G3D::Ray& ray, const G3D::Vector3& endPos, float& maxDist) const;

    bool GetAreaAndLiquidData(float x, float y, float z, uint32 phasemask, Optional<uint8> reqLiquidType, VMAP::AreaAndLiquidData& data) const;

    bool GetObjectHitPos(uint32 phasemask, const G3D::Vector3& pPos1,
                         const G3D::Vector3& pPos2, G3D::Vector3& pResultHitPos,
                         float pModifyDist) const;

    [[nodiscard]] float getHeight(float x, float y, float z, float maxSearchDist, uint32 phasemask) const;

    void insert(const GameObjectModel&);
    void remove(const GameObjectModel&);
    [[nodiscard]] bool contains(const GameObjectModel&) const;
    [[nodiscard]] int size() const;

    void balance();
    void update(uint32 diff);
};

#endif // _DYNTREE_H
