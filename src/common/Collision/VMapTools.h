/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _VMAPTOOLS_H
#define _VMAPTOOLS_H

#include <G3D/CollisionDetection.h>
#include <G3D/AABox.h>

#include "NodeValueAccess.h"

/**
The Class is mainly taken from G3D/AABSPTree.h but modified to be able to use our internal data structure.
This is an iterator that helps us analysing the BSP-Trees.
The collision detection is modified to return true, if we are inside an object.
*/

namespace VMAP
{
    template<class TValue>
    class IntersectionCallBack {
    public:
        TValue*      closestEntity;
        G3D::Vector3 hitLocation;
        G3D::Vector3 hitNormal;

        void operator()(const G3D::Ray& ray, const TValue* entity, bool StopAtFirstHit, float& distance) {
            entity->intersect(ray, distance, StopAtFirstHit, hitLocation, hitNormal);
        }
    };

    //==============================================================
    //==============================================================
    //==============================================================

    class MyCollisionDetection
    {
    private:
    public:

        static bool collisionLocationForMovingPointFixedAABox(
            const G3D::Vector3&     origin,
            const G3D::Vector3&     dir,
            const G3D::AABox&       box,
            G3D::Vector3&           location,
            bool&                   Inside)
        {

            // Integer representation of a floating-point value.
#define IR(x)   (reinterpret_cast<G3D::uint32 const&>(x))

            Inside = true;
            const G3D::Vector3& MinB = box.low();
            const G3D::Vector3& MaxB = box.high();
            G3D::Vector3 MaxT(-1.0f, -1.0f, -1.0f);

            // Find candidate planes.
            for (int i = 0; i < 3; ++i)
            {
                if (origin[i] < MinB[i])
                {
                    location[i] = MinB[i];
                    Inside      = false;

                    // Calculate T distances to candidate planes
                    if (IR(dir[i]))
                    {
                        MaxT[i] = (MinB[i] - origin[i]) / dir[i];
                    }
                }
                else if (origin[i] > MaxB[i])
                {
                    location[i] = MaxB[i];
                    Inside      = false;

                    // Calculate T distances to candidate planes
                    if (IR(dir[i]))
                    {
                        MaxT[i] = (MaxB[i] - origin[i]) / dir[i];
                    }
                }
            }

            if (Inside)
            {
                // definite hit
                location = origin;
                return true;
            }

            // Get largest of the maxT's for final choice of intersection
            int WhichPlane = 0;
            if (MaxT[1] > MaxT[WhichPlane])
            {
                WhichPlane = 1;
            }

            if (MaxT[2] > MaxT[WhichPlane])
            {
                WhichPlane = 2;
            }

            // Check final candidate actually inside box
            if (IR(MaxT[WhichPlane]) & 0x80000000)
            {
                // Miss the box
                return false;
            }

            for (int i = 0; i < 3; ++i)
            {
                if (i != WhichPlane)
                {
                    location[i] = origin[i] + MaxT[WhichPlane] * dir[i];
                    if ((location[i] < MinB[i]) ||
                        (location[i] > MaxB[i]))
                    {
                        // On this plane we're outside the box extents, so
                        // we miss the box
                        return false;
                    }
                }
            }
            /*
            // Choose the normal to be the plane normal facing into the ray
            normal = G3D::Vector3::zero();
            normal[WhichPlane] = (dir[WhichPlane] > 0) ? -1.0 : 1.0;
            */
            return true;

#undef IR
        }
    };
}
#endif
