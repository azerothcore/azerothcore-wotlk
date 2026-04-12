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

#ifndef AZEROTHCORE_SPAWNDATA_H
#define AZEROTHCORE_SPAWNDATA_H

#include "Define.h"
#include "ObjectGuid.h"
#include <string>

enum SpawnObjectType : uint8
{
    SPAWN_TYPE_CREATURE  = 0,
    SPAWN_TYPE_GAMEOBJECT = 1,

    SPAWN_TYPE_MAX
};

enum SpawnObjectTypeMask : uint8
{
    SPAWN_TYPEMASK_CREATURE   = (1 << SPAWN_TYPE_CREATURE),
    SPAWN_TYPEMASK_GAMEOBJECT = (1 << SPAWN_TYPE_GAMEOBJECT),

    SPAWN_TYPEMASK_ALL = SPAWN_TYPEMASK_CREATURE | SPAWN_TYPEMASK_GAMEOBJECT
};

enum SpawnGroupFlags : uint32
{
    SPAWNGROUP_FLAG_NONE                = 0x00,
    SPAWNGROUP_FLAG_SYSTEM              = 0x01,
    SPAWNGROUP_FLAG_COMPATIBILITY_MODE  = 0x02,
    SPAWNGROUP_FLAG_MANUAL_SPAWN        = 0x04,
    SPAWNGROUP_FLAG_DYNAMIC_SPAWN_RATE  = 0x08,
    SPAWNGROUP_FLAG_ESCORTQUESTNPC      = 0x10,

    SPAWNGROUP_FLAG_ALL = SPAWNGROUP_FLAG_SYSTEM | SPAWNGROUP_FLAG_COMPATIBILITY_MODE |
                          SPAWNGROUP_FLAG_MANUAL_SPAWN | SPAWNGROUP_FLAG_DYNAMIC_SPAWN_RATE |
                          SPAWNGROUP_FLAG_ESCORTQUESTNPC
};

constexpr uint32 SPAWNGROUP_MAP_UNSET = 0xFFFFFFFF;

struct SpawnGroupTemplateData
{
    uint32 groupId;
    std::string name;
    uint32 mapId;
    SpawnGroupFlags flags;
};

struct SpawnData
{
    SpawnObjectType const type;
    ObjectGuid::LowType spawnId{0};
    uint16 mapid{0};
    uint32 phaseMask{0};
    float posX{0.0f};
    float posY{0.0f};
    float posZ{0.0f};
    float orientation{0.0f};
    uint8 spawnMask{0};
    uint32 ScriptId{0};
    bool dbData{true};
    uint32 spawnGroupId{0};

protected:
    SpawnData(SpawnObjectType t) : type(t) {}
};

#endif // AZEROTHCORE_SPAWNDATA_H
