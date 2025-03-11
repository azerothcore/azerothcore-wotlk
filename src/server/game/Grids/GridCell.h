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

#ifndef ACORE_GRID_CELL_H
#define ACORE_GRID_CELL_H

/*
  @class GridCell
  Grid is a logical segment of the game world represented inside TrinIty.
  Grid is bind at compile time to a particular type of object which
  we call it the object of interested.  There are many types of loader,
  specially, dynamic loader, static loader, or on-demand loader.  There's
  a subtle difference between dynamic loader and on-demand loader but
  this is implementation specific to the loader class.  From the
  Grid's perspective, the loader meets its API requirement is suffice.
*/

#include "Define.h"
#include "TypeContainer.h"
#include "TypeContainerVisitor.h"

template
<
    class WORLD_OBJECT_TYPES,
    class GRID_OBJECT_TYPES
>
class GridCell
{
public:
    ~GridCell() = default;

    template<class SPECIFIC_OBJECT> void AddWorldObject(SPECIFIC_OBJECT* obj)
    {
        _worldObjects.template insert<SPECIFIC_OBJECT>(obj);
        ASSERT(obj->IsInGrid());
    }

    template<class SPECIFIC_OBJECT> void AddGridObject(SPECIFIC_OBJECT* obj)
    {
        _gridObjects.template insert<SPECIFIC_OBJECT>(obj);
        ASSERT(obj->IsInGrid());
    }

    // Visit grid objects
    template<class T>
    void Visit(TypeContainerVisitor<T, TypeMapContainer<GRID_OBJECT_TYPES> >& visitor)
    {
        visitor.Visit(_gridObjects);
    }

    // Visit world objects
    template<class T>
    void Visit(TypeContainerVisitor<T, TypeMapContainer<WORLD_OBJECT_TYPES> >& visitor)
    {
        visitor.Visit(_worldObjects);
    }
private:
    TypeMapContainer<GRID_OBJECT_TYPES> _gridObjects;
    TypeMapContainer<WORLD_OBJECT_TYPES> _worldObjects;
};
#endif
