/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _MAPREFMANAGER
#define _MAPREFMANAGER

#include "RefManager.h"

class MapReference;

class MapRefManager : public RefManager<Map, Player>
{
public:
    typedef LinkedListHead::Iterator< MapReference > iterator;
    typedef LinkedListHead::Iterator< MapReference const > const_iterator;

    MapReference* getFirst() { return (MapReference*)RefManager<Map, Player>::getFirst(); }
    [[nodiscard]] MapReference const* getFirst() const { return (MapReference const*)RefManager<Map, Player>::getFirst(); }
    MapReference* getLast() { return (MapReference*)RefManager<Map, Player>::getLast(); }
    [[nodiscard]] MapReference const* getLast() const { return (MapReference const*)RefManager<Map, Player>::getLast(); }

    iterator begin() { return iterator(getFirst()); }
    iterator end() { return iterator(nullptr); }
    iterator rbegin() { return iterator(getLast()); }
    iterator rend() { return iterator(nullptr); }
    [[nodiscard]] const_iterator begin() const { return const_iterator(getFirst()); }
    [[nodiscard]] const_iterator end() const  { return const_iterator(nullptr); }
};
#endif
