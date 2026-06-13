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

#ifndef _MAPREFMANAGER
#define _MAPREFMANAGER

#include "RefMgr.h"

class MapReference;

class MapRefMgr : public RefMgr<Map, Player>
{
public:
    typedef LinkedListHead::Iterator< MapReference > iterator;
    typedef LinkedListHead::Iterator< MapReference const > const_iterator;

    MapReference* getFirst() { return (MapReference*)RefMgr<Map, Player>::getFirst(); }
    [[nodiscard]] MapReference const* getFirst() const { return (MapReference const*)RefMgr<Map, Player>::getFirst(); }
    MapReference* getLast() { return (MapReference*)RefMgr<Map, Player>::getLast(); }
    [[nodiscard]] MapReference const* getLast() const { return (MapReference const*)RefMgr<Map, Player>::getLast(); }

    iterator begin() { return iterator(getFirst()); }
    iterator end() { return iterator(nullptr); }
    iterator rbegin() { return iterator(getLast()); }
    iterator rend() { return iterator(nullptr); }
    [[nodiscard]] const_iterator begin() const { return const_iterator(getFirst()); }
    [[nodiscard]] const_iterator end() const  { return const_iterator(nullptr); }
};
#endif
