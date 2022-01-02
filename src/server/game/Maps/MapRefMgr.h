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

#ifndef _MAPREFMANAGER
#define _MAPREFMANAGER

#include "RefMgr.h"

class MapReference;

class MapRefMgr : public RefMgr<Map, Player>
{
public:
    typedef LinkedListHead::Iterator< MapReference > iterator;
    typedef LinkedListHead::Iterator< MapReference const > const_iterator;

    auto getFirst() -> MapReference* { return (MapReference*)RefMgr<Map, Player>::getFirst(); }
    [[nodiscard]] auto getFirst() const -> MapReference const* { return (MapReference const*)RefMgr<Map, Player>::getFirst(); }
    auto getLast() -> MapReference* { return (MapReference*)RefMgr<Map, Player>::getLast(); }
    [[nodiscard]] auto getLast() const -> MapReference const* { return (MapReference const*)RefMgr<Map, Player>::getLast(); }

    auto begin() -> iterator { return {getFirst()}; }
    auto end() -> iterator { return {nullptr}; }
    auto rbegin() -> iterator { return {getLast()}; }
    auto rend() -> iterator { return {nullptr}; }
    [[nodiscard]] auto begin() const -> const_iterator { return {getFirst()}; }
    [[nodiscard]] auto end() const -> const_iterator  { return {nullptr}; }
};
#endif
