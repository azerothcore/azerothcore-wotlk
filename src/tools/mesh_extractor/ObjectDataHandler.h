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

#ifndef ODATA_HNDL_H
#define ODATA_HNDL_H
#include "ADT.h"
#include "MapChunk.h"

class ObjectDataHandler
{
public:
    ObjectDataHandler(ADT* _adt) : Source(_adt) {}

    void ProcessMapChunk(MapChunk* chunk);
    virtual void ProcessInternal(MapChunk* data) = 0;
    ADT* Source;
};
#endif
