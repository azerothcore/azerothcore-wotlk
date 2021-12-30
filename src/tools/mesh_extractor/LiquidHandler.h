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

#ifndef LIQUID_H
#define LIQUID_H
#include "ADT.h"
#include "Define.h"
#include "Utils.h"

#include <vector>

class LiquidHandler
{
public:
    LiquidHandler(ADT* adt);

    ADT* Source;
    std::vector<Vector3> Vertices;
    std::vector<Triangle<uint32>> Triangles;
    std::vector<MCNKLiquidData> MCNKData;
private:
    void HandleNewLiquid();
};
#endif
