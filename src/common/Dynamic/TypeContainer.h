/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_TYPECONTAINER_H
#define ACORE_TYPECONTAINER_H

/*
 * Here, you'll find a series of containers that allow you to hold multiple
 * types of object at the same time.
 */

#include "Define.h"
#include "Dynamic/TypeList.h"
#include "GridRefManager.h"
#include <map>
#include <unordered_map>
#include <vector>

/*
 * @class ContainerMapList is a mulit-type container for map elements
 * By itself its meaningless but collaborate along with TypeContainers,
 * it become the most powerfully container in the whole system.
 */
template<class OBJECT>
struct ContainerMapList
{
    //std::map<OBJECT_HANDLE, OBJECT *> _element;
    GridRefManager<OBJECT> _element;
};

template<>
struct ContainerMapList<TypeNull>                /* nothing is in type null */
{
};

template<class H, class T>
struct ContainerMapList<TypeList<H, T>>
{
    ContainerMapList<H> _elements;
    ContainerMapList<T> _TailElements;
};

template<class OBJECT, class KEY_TYPE>
struct ContainerUnorderedMap
{
    std::unordered_map<KEY_TYPE, OBJECT*> _element;
};

template<class KEY_TYPE>
struct ContainerUnorderedMap<TypeNull, KEY_TYPE>
{
};

template<class H, class T, class KEY_TYPE>
struct ContainerUnorderedMap<TypeList<H, T>, KEY_TYPE>
{
    ContainerUnorderedMap<H, KEY_TYPE> _elements;
    ContainerUnorderedMap<T, KEY_TYPE> _TailElements;
};

/*
 * @class ContainerList is a simple list of different types of elements
 *
 */
template<class OBJECT> struct ContainerList
{
    OBJECT _element;
};

/* TypeNull is underfined */
template<> struct ContainerList<TypeNull> { };
template<class H, class T> struct ContainerList<TypeList<H, T>>
{
    ContainerList<H> _elements;
    ContainerMapList<T> _TailElements;
};

#include "TypeContainerFunctions.h"

/*
 * @class TypeMapContainer contains a fixed number of types and is
 * determined at compile time.  This is probably the most complicated
 * class and do its simplest thing, that is, holds objects
 * of different types.
 */

template<class OBJECT_TYPES>
class TypeMapContainer
{
public:
    template<class SPECIFIC_TYPE> [[nodiscard]] size_t Count() const { return Acore::Count(i_elements, (SPECIFIC_TYPE*)nullptr); }

    /// inserts a specific object into the container
    template<class SPECIFIC_TYPE>
    bool insert(SPECIFIC_TYPE* obj)
    {
        SPECIFIC_TYPE* t = Acore::Insert(i_elements, obj);
        return (t != nullptr);
    }

    ///  Removes the object from the container, and returns the removed object
    //template<class SPECIFIC_TYPE>
    // bool remove(SPECIFIC_TYPE* obj)
    //{
    //    SPECIFIC_TYPE* t = Acore::Remove(i_elements, obj);
    //    return (t != nullptr);
    //}

    ContainerMapList<OBJECT_TYPES>& GetElements() { return i_elements; }
    [[nodiscard]] const ContainerMapList<OBJECT_TYPES>& GetElements() const { return i_elements;}

private:
    ContainerMapList<OBJECT_TYPES> i_elements;
};

template<class OBJECT_TYPES, class KEY_TYPE>
class TypeUnorderedMapContainer
{
public:
    template<class SPECIFIC_TYPE>
    bool Insert(KEY_TYPE const& handle, SPECIFIC_TYPE* obj)
    {
        return Acore::Insert(_elements, handle, obj);
    }

    template<class SPECIFIC_TYPE>
    bool Remove(KEY_TYPE const& handle)
    {
        return Acore::Remove(_elements, handle, (SPECIFIC_TYPE*)nullptr);
    }

    template<class SPECIFIC_TYPE>
    SPECIFIC_TYPE* Find(KEY_TYPE const& handle)
    {
        return Acore::Find(_elements, handle, (SPECIFIC_TYPE*)nullptr);
    }

    ContainerUnorderedMap<OBJECT_TYPES, KEY_TYPE>& GetElements() { return _elements; }
    ContainerUnorderedMap<OBJECT_TYPES, KEY_TYPE> const& GetElements() const { return _elements; }

private:
    ContainerUnorderedMap<OBJECT_TYPES, KEY_TYPE> _elements;
};

#endif
