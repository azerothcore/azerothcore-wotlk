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

#ifndef CHNK_H
#define CHNK_H

#include "Chunk.h"
#include <vector>

class ChunkedData
{
public:
    ChunkedData(FILE* stream, uint32 maxLength, uint32 chunksHint = 300);
    ChunkedData(const std::string& file, uint32 chunksHint = 300);
    ~ChunkedData();

    int GetFirstIndex(const std::string& name);
    Chunk* GetChunkByName(const std::string& name);

    void Load(uint32 maxLength, uint32 chunksHint);
    std::vector<Chunk*> Chunks;
    FILE* Stream;
};
#endif
