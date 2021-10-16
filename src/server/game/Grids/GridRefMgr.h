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

#ifndef _GRIDREFMANAGER
#define _GRIDREFMANAGER

#include "RefMgr.h"

template<class OBJECT>
class GridReference;

template<class OBJECT>
class GridRefMgr : public RefMgr<GridRefMgr<OBJECT>, OBJECT>
{
public:
    typedef LinkedListHead::Iterator< GridReference<OBJECT> > iterator;

    GridReference<OBJECT>* getFirst() { return (GridReference<OBJECT>*)RefMgr<GridRefMgr<OBJECT>, OBJECT>::getFirst(); }
    GridReference<OBJECT>* getLast() { return (GridReference<OBJECT>*)RefMgr<GridRefMgr<OBJECT>, OBJECT>::getLast(); }

    iterator begin() { return iterator(getFirst()); }
    iterator end() { return iterator(nullptr); }
    iterator rbegin() { return iterator(getLast()); }
    iterator rend() { return iterator(nullptr); }
};
#endif
