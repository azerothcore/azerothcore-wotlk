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

#ifndef _MAPREFERENCE_H
#define _MAPREFERENCE_H

#include "Map.h"
#include "Reference.h"

class MapReference : public Reference<Map, Player>
{
protected:
    void targetObjectBuildLink() override
    {
        // called from link()
        getTarget()->m_mapRefMgr.insertFirst(this);
        getTarget()->m_mapRefMgr.incSize();
    }
    void targetObjectDestroyLink() override
    {
        // called from unlink()
        if (isValid()) getTarget()->m_mapRefMgr.decSize();
    }
    void sourceObjectDestroyLink() override
    {
        // called from invalidate()
        getTarget()->m_mapRefMgr.decSize();
    }
public:
    MapReference() : Reference<Map, Player>() {}
    ~MapReference() override { unlink(); }
    MapReference* next() { return (MapReference*)Reference<Map, Player>::next(); }
    [[nodiscard]] MapReference const* next() const { return (MapReference const*)Reference<Map, Player>::next(); }
    MapReference* nockeck_prev() { return (MapReference*)Reference<Map, Player>::nocheck_prev(); }
    [[nodiscard]] MapReference const* nocheck_prev() const { return (MapReference const*)Reference<Map, Player>::nocheck_prev(); }
};
#endif
