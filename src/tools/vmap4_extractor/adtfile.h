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

#ifndef ADT_H
#define ADT_H

#include "model.h"
#include "mpq_libmpq04.h"
#include "wmo.h"

#pragma pack(push, 1)
namespace ADT
{
    struct MDDF
    {
        uint32 Id;
        uint32 UniqueId;
        Vec3D Position;
        Vec3D Rotation;
        uint16 Scale;
        uint16 Flags;
    };

    struct MODF
    {
        uint32 Id;
        uint32 UniqueId;
        Vec3D Position;
        Vec3D Rotation;
        AaBox3D Bounds;
        uint16 Flags;
        uint16 DoodadSet;
        uint16 NameSet;
        uint16 Scale;
    };
}
#pragma pack(pop)

class ADTFile
{
private:
    MPQFile _file;
    std::string Adtfilename;
public:
    ADTFile(char* filename);
    ~ADTFile();
    std::vector<std::string> WmoInstanceNames;
    std::vector<std::string> ModelInstanceNames;
    bool init(uint32 map_num, uint32 tileX, uint32 tileY);
    //void LoadMapChunks();

    //uint32 wmo_count;
    /*
        const mcell& Getmcell() const
        {
            return Mcell;
        }
    */
};

const char* GetPlainName(const char* FileName);
char* GetPlainName(char* FileName);
char* GetExtension(char* FileName);
void fixnamen(char* name, std::size_t len);
void fixname2(char* name, std::size_t len);
//void fixMapNamen(char *name, std::size_t len);

#endif
