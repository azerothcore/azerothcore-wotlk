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

#ifndef _INTERMEDIATE_VALUES_H
#define _INTERMEDIATE_VALUES_H

#include "Recast.h"
#include "TerrainBuilder.h"

namespace MMAP
{
    // this class gathers all debug info holding and output
    struct IntermediateValues
    {
        rcHeightfield* heightfield{nullptr};
        rcCompactHeightfield* compactHeightfield{nullptr};
        rcContourSet* contours{nullptr};
        rcPolyMesh* polyMesh{nullptr};
        rcPolyMeshDetail* polyMeshDetail{nullptr};

        IntermediateValues()  {}
        ~IntermediateValues();

        void writeIV(uint32 mapID, uint32 tileX, uint32 tileY);

        void debugWrite(FILE* file, const rcHeightfield* mesh);
        void debugWrite(FILE* file, const rcCompactHeightfield* chf);
        void debugWrite(FILE* file, const rcContourSet* cs);
        void debugWrite(FILE* file, const rcPolyMesh* mesh);
        void debugWrite(FILE* file, const rcPolyMeshDetail* mesh);

        void generateObjFile(uint32 mapID, uint32 tileX, uint32 tileY, MeshData& meshData);
    };
}
#endif
