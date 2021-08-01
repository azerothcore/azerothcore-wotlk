/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _DYNTREE_H
#define _DYNTREE_H

#include "Define.h"

namespace G3D
{
    class Ray;
    class Vector3;
}

class GameObjectModel;
struct DynTreeImpl;

class DynamicMapTree
{
    DynTreeImpl* impl;

public:
    DynamicMapTree();
    ~DynamicMapTree();

    [[nodiscard]] bool isInLineOfSight(float x1, float y1, float z1, float x2, float y2,
                                       float z2, uint32 phasemask) const;

    bool GetIntersectionTime(uint32 phasemask, const G3D::Ray& ray,
                             const G3D::Vector3& endPos, float& maxDist) const;

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
