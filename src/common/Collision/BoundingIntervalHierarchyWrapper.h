/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _BIH_WRAP
#define _BIH_WRAP

#include "G3D/Table.h"
#include "G3D/Array.h"
#include "G3D/Set.h"
#include "BoundingIntervalHierarchy.h"


template<class T, class BoundsFunc = BoundsTrait<T> >
class BIHWrap
{
    template<class RayCallback>
    struct MDLCallback
    {
        const T* const* objects;
        RayCallback& _callback;
        uint32 objects_size;

        MDLCallback(RayCallback& callback, const T* const* objects_array, uint32 objects_size ) : objects(objects_array), _callback(callback), objects_size(objects_size) { }

        /// Intersect ray
        bool operator() (const G3D::Ray& ray, uint32 idx, float& maxDist, bool stopAtFirstHit)
        {
            if (idx >= objects_size)
                return false;
            if (const T* obj = objects[idx])
                return _callback(ray, *obj, maxDist, stopAtFirstHit);
            return false;
        }

        /// Intersect point
        void operator() (const G3D::Vector3& p, uint32 idx)
        {
            if (idx >= objects_size)
                return;
            if (const T* obj = objects[idx])
                _callback(p, *obj);
        }
    };

    typedef G3D::Array<const T*> ObjArray;

    BIH m_tree;
    ObjArray m_objects;
    G3D::Table<const T*, uint32> m_obj2Idx;
    G3D::Set<const T*> m_objects_to_push;
    int unbalanced_times;

public:
    BIHWrap() : unbalanced_times(0) { }

    void insert(const T& obj)
    {
        ++unbalanced_times;
        m_objects_to_push.insert(&obj);
    }

    void remove(const T& obj)
    {
        ++unbalanced_times;
        uint32 Idx = 0;
        const T * temp;
        if (m_obj2Idx.getRemove(&obj, temp, Idx))
            m_objects[Idx] = NULL;
        else
            m_objects_to_push.remove(&obj);
    }

    void balance()
    {
        if (unbalanced_times == 0)
            return;

        unbalanced_times = 0;
        m_objects.fastClear();
        m_obj2Idx.getKeys(m_objects);
        m_objects_to_push.getMembers(m_objects);
        //assert that m_obj2Idx has all the keys

        m_tree.build(m_objects, BoundsFunc::getBounds2);
    }

    template<typename RayCallback>
    void intersectRay(const G3D::Ray& ray, RayCallback& intersectCallback, float& maxDist, bool stopAtFirstHit)
    {
        balance();
        MDLCallback<RayCallback> temp_cb(intersectCallback, m_objects.getCArray(), m_objects.size());
        m_tree.intersectRay(ray, temp_cb, maxDist, stopAtFirstHit);
    }

    template<typename IsectCallback>
    void intersectPoint(const G3D::Vector3& point, IsectCallback& intersectCallback)
    {
        balance();
        MDLCallback<IsectCallback> callback(intersectCallback, m_objects.getCArray(), m_objects.size());
        m_tree.intersectPoint(point, callback);
    }
};

#endif // _BIH_WRAP
