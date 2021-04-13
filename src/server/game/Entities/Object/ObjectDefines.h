/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_OBJECTDEFINES_H
#define ACORE_OBJECTDEFINES_H

#include "Define.h"

#define CONTACT_DISTANCE            0.5f
#define INTERACTION_DISTANCE        5.5f
#define ATTACK_DISTANCE             5.0f
#define MAX_SEARCHER_DISTANCE       150.0f // pussywizard: replace the use of MAX_VISIBILITY_DISTANCE in searchers, because MAX_VISIBILITY_DISTANCE is quite too big for this purpose
#define MAX_VISIBILITY_DISTANCE     250.0f // max distance for visible objects, experimental
#define VISIBILITY_INC_FOR_GOBJECTS 30.0f // pussywizard
#define VISIBILITY_COMPENSATION     15.0f // increase searchers
#define SPELL_SEARCHER_COMPENSATION 30.0f // increase searchers size in case we have large npc near cell border
#define VISIBILITY_DIST_WINTERGRASP 175.0f
#define SIGHT_RANGE_UNIT            50.0f
#define DEFAULT_VISIBILITY_DISTANCE 90.0f // default visible distance, 90 yards on continents
#define DEFAULT_VISIBILITY_INSTANCE 120.0f // default visible distance in instances, 120 yards
#define DEFAULT_VISIBILITY_BGARENAS 150.0f // default visible distance in BG/Arenas, 150 yards

#define DEFAULT_WORLD_OBJECT_SIZE   0.388999998569489f      // player size, also currently used (correctly?) for any non Unit world objects
#define DEFAULT_COMBAT_REACH        1.5f
#define MIN_MELEE_REACH             2.0f
#define NOMINAL_MELEE_RANGE         5.0f
#define MELEE_RANGE                 (NOMINAL_MELEE_RANGE - MIN_MELEE_REACH * 2) //center to center for players
#define DEFAULT_COLLISION_HEIGHT    2.03128f // Most common value in dbc

enum HighGuid
{
    HIGHGUID_ITEM           = 0x4000,                      // blizz 4000
    HIGHGUID_CONTAINER      = 0x4000,                      // blizz 4000
    HIGHGUID_PLAYER         = 0x0000,                      // blizz 0000
    HIGHGUID_GAMEOBJECT     = 0xF110,                      // blizz F110
    HIGHGUID_TRANSPORT      = 0xF120,                      // blizz F120 (for GAMEOBJECT_TYPE_TRANSPORT)
    HIGHGUID_UNIT           = 0xF130,                      // blizz F130
    HIGHGUID_PET            = 0xF140,                      // blizz F140
    HIGHGUID_VEHICLE        = 0xF150,                      // blizz F550
    HIGHGUID_DYNAMICOBJECT  = 0xF100,                      // blizz F100
    HIGHGUID_CORPSE         = 0xF101,                      // blizz F100
    HIGHGUID_MO_TRANSPORT   = 0x1FC0,                      // blizz 1FC0 (for GAMEOBJECT_TYPE_MO_TRANSPORT)
    HIGHGUID_GROUP          = 0x1F50,
    HIGHGUID_INSTANCE       = 0x1F42,                      // blizz 1F42/1F44/1F44/1F47
};

// used for creating values for respawn for example
inline uint64 MAKE_PAIR64(uint32 l, uint32 h);
inline uint32 PAIR64_HIPART(uint64 x);
inline uint32 PAIR64_LOPART(uint64 x);
inline uint16 MAKE_PAIR16(uint8 l, uint8 h);
inline uint32 MAKE_PAIR32(uint16 l, uint16 h);
inline uint16 PAIR32_HIPART(uint32 x);
inline uint16 PAIR32_LOPART(uint32 x);

inline bool IS_EMPTY_GUID(uint64 guid);
inline bool IS_CREATURE_GUID(uint64 guid);
inline bool IS_PET_GUID(uint64 guid);
inline bool IS_VEHICLE_GUID(uint64 guid);
inline bool IS_CRE_OR_VEH_GUID(uint64 guid);
inline bool IS_CRE_OR_VEH_OR_PET_GUID(uint64 guid);
inline bool IS_PLAYER_GUID(uint64 guid);
inline bool IS_UNIT_GUID(uint64 guid);
inline bool IS_ITEM_GUID(uint64 guid);
inline bool IS_GAMEOBJECT_GUID(uint64 guid);
inline bool IS_DYNAMICOBJECT_GUID(uint64 guid);
inline bool IS_CORPSE_GUID(uint64 guid);
inline bool IS_TRANSPORT_GUID(uint64 guid);
inline bool IS_MO_TRANSPORT_GUID(uint64 guid);
inline bool IS_GROUP_GUID(uint64 guid);

// l - OBJECT_FIELD_GUID
// e - OBJECT_FIELD_ENTRY for GO (except GAMEOBJECT_TYPE_MO_TRANSPORT) and creatures or UNIT_FIELD_PETNUMBER for pets
// h - OBJECT_FIELD_GUID + 1
inline uint64 MAKE_NEW_GUID(uint32 l, uint32 e, uint32 h);

//#define GUID_HIPART(x)   (uint32)((uint64(x) >> 52)) & 0x0000FFFF)
inline uint32 GUID_HIPART(uint64 guid);
inline uint32 GUID_ENPART(uint64 x);
inline uint32 GUID_LOPART(uint64 x);

inline bool IsGuidHaveEnPart(uint64 guid);
inline char const* GetLogNameForGuid(uint64 guid);

uint64 MAKE_PAIR64(uint32 l, uint32 h)
{
    return uint64(l | (uint64(h) << 32));
}

uint32 PAIR64_HIPART(uint64 x)
{
    return (uint32)((x >> 32) & UI64LIT(0x00000000FFFFFFFF));
}

uint32 PAIR64_LOPART(uint64 x)
{
    return (uint32)(x & UI64LIT(0x00000000FFFFFFFF));
}

uint16 MAKE_PAIR16(uint8 l, uint8 h)
{
    return uint16(l | (uint16(h) << 8));
}

uint32 MAKE_PAIR32(uint16 l, uint16 h)
{
    return uint32(l | (uint32(h) << 16));
}

uint16 PAIR32_HIPART(uint32 x)
{
    return (uint16)((x >> 16) & 0x0000FFFF);
}

uint16 PAIR32_LOPART(uint32 x)
{
    return (uint16)(x & 0x0000FFFF);
}

bool IS_EMPTY_GUID(uint64 guid)
{
    return guid == 0;
}

bool IS_CREATURE_GUID(uint64 guid)
{
    return GUID_HIPART(guid) == HIGHGUID_UNIT;
}

bool IS_PET_GUID(uint64 guid)
{
    return GUID_HIPART(guid) == HIGHGUID_PET;
}

bool IS_VEHICLE_GUID(uint64 guid)
{
    return GUID_HIPART(guid) == HIGHGUID_VEHICLE;
}

bool IS_CRE_OR_VEH_GUID(uint64 guid)
{
    return IS_CREATURE_GUID(guid) || IS_VEHICLE_GUID(guid);
}

bool IS_CRE_OR_VEH_OR_PET_GUID(uint64 guid)
{
    return IS_CRE_OR_VEH_GUID(guid) || IS_PET_GUID(guid);
}

bool IS_PLAYER_GUID(uint64 guid)
{
    return guid != 0 && GUID_HIPART(guid) == HIGHGUID_PLAYER;
}

bool IS_UNIT_GUID(uint64 guid)
{
    return IS_CRE_OR_VEH_OR_PET_GUID(guid) || IS_PLAYER_GUID(guid);
}

bool IS_ITEM_GUID(uint64 guid)
{
    return GUID_HIPART(guid) == HIGHGUID_ITEM;
}

bool IS_GAMEOBJECT_GUID(uint64 guid)
{
    return GUID_HIPART(guid) == HIGHGUID_GAMEOBJECT;
}

bool IS_DYNAMICOBJECT_GUID(uint64 guid)
{
    return GUID_HIPART(guid) == HIGHGUID_DYNAMICOBJECT;
}

bool IS_CORPSE_GUID(uint64 guid)
{
    return GUID_HIPART(guid) == HIGHGUID_CORPSE;
}

bool IS_TRANSPORT_GUID(uint64 guid)
{
    return GUID_HIPART(guid) == HIGHGUID_TRANSPORT;
}

bool IS_MO_TRANSPORT_GUID(uint64 guid)
{
    return GUID_HIPART(guid) == HIGHGUID_MO_TRANSPORT;
}

bool IS_GROUP_GUID(uint64 guid)
{
    return GUID_HIPART(guid) == HIGHGUID_GROUP;
}

uint64 MAKE_NEW_GUID(uint32 l, uint32 e, uint32 h)
{
    return uint64(uint64(l) | (uint64(e) << 24) | (uint64(h) << 48));
}

uint32 GUID_HIPART(uint64 guid)
{
    return (uint32)((uint64(guid) >> 48) & 0x0000FFFF);
}

uint32 GUID_ENPART(uint64 x)
{
    return IsGuidHaveEnPart(x)
           ? (uint32)((x >> 24) & UI64LIT(0x0000000000FFFFFF))
           : 0;
}

uint32 GUID_LOPART(uint64 x)
{
    return IsGuidHaveEnPart(x)
           ? (uint32)(x & UI64LIT(0x0000000000FFFFFF))
           : (uint32)(x & UI64LIT(0x00000000FFFFFFFF));
}

bool IsGuidHaveEnPart(uint64 guid)
{
    switch (GUID_HIPART(guid))
    {
        case HIGHGUID_ITEM:
        case HIGHGUID_PLAYER:
        case HIGHGUID_DYNAMICOBJECT:
        case HIGHGUID_CORPSE:
        case HIGHGUID_GROUP:
            return false;
        case HIGHGUID_GAMEOBJECT:
        case HIGHGUID_TRANSPORT:
        case HIGHGUID_UNIT:
        case HIGHGUID_PET:
        case HIGHGUID_VEHICLE:
        case HIGHGUID_MO_TRANSPORT:
        default:
            return true;
    }
}

char const* GetLogNameForGuid(uint64 guid)
{
    switch (GUID_HIPART(guid))
    {
        case HIGHGUID_ITEM:
            return "item";
        case HIGHGUID_PLAYER:
            return guid ? "player" : "none";
        case HIGHGUID_GAMEOBJECT:
            return "gameobject";
        case HIGHGUID_TRANSPORT:
            return "transport";
        case HIGHGUID_UNIT:
            return "creature";
        case HIGHGUID_PET:
            return "pet";
        case HIGHGUID_VEHICLE:
            return "vehicle";
        case HIGHGUID_DYNAMICOBJECT:
            return "dynobject";
        case HIGHGUID_CORPSE:
            return "corpse";
        case HIGHGUID_MO_TRANSPORT:
            return "mo_transport";
        case HIGHGUID_GROUP:
            return "group";
        default:
            return "<unknown>";
    }
}

#endif
