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

#ifndef ACORE_OBJECTDEFINES_H
#define ACORE_OBJECTDEFINES_H

#include "Define.h"

#define CONTACT_DISTANCE             0.5f
#define INTERACTION_DISTANCE         5.5f
#define ATTACK_DISTANCE              5.0f
#define VISIBILITY_COMPENSATION      15.0f                  // increase searchers
#define INSPECT_DISTANCE             28.0f
#define VISIBILITY_INC_FOR_GOBJECTS  30.0f                  // pussywizard
#define SPELL_SEARCHER_COMPENSATION  30.0f                  // increase searchers size in case we have large npc near cell border
#define TRADE_DISTANCE               11.11f
#define MAX_VISIBILITY_DISTANCE      250.0f                 // max distance for visible objects, experimental
#define SIGHT_RANGE_UNIT             50.0f
#define MAX_SEARCHER_DISTANCE        150.0f                 // pussywizard: replace the use of MAX_VISIBILITY_DISTANCE in searchers, because MAX_VISIBILITY_DISTANCE is quite too big for this purpose
#define VISIBILITY_DISTANCE_INFINITE 533.0f
#define VISIBILITY_DISTANCE_GIGANTIC 400.0f
#define VISIBILITY_DISTANCE_LARGE    200.0f
#define VISIBILITY_DISTANCE_NORMAL   100.0f
#define VISIBILITY_DISTANCE_SMALL    50.0f
#define VISIBILITY_DISTANCE_TINY     25.0f
#define DEFAULT_VISIBILITY_DISTANCE  100.0f                 // default visible distance, 100 yards on continents
#define DEFAULT_VISIBILITY_INSTANCE  170.0f                 // default visible distance in instances, 170 yards
#define VISIBILITY_DIST_WINTERGRASP  175.0f
#define DEFAULT_VISIBILITY_BGARENAS  250.0f                 // default visible distance in BG/Arenas, roughly 250 yards

#define DEFAULT_WORLD_OBJECT_SIZE   0.388999998569489f      // player size, also currently used (correctly?) for any non Unit world objects
#define DEFAULT_COMBAT_REACH        1.5f
#define MIN_MELEE_REACH             2.0f
#define NOMINAL_MELEE_RANGE         5.0f
#define MELEE_RANGE                 (NOMINAL_MELEE_RANGE - MIN_MELEE_REACH * 2) //center to center for players
#define DEFAULT_COLLISION_HEIGHT    2.03128f                // Most common value in dbc

// used for creating values for respawn for example
inline uint32 PAIR64_HIPART(uint64 x);
inline uint32 PAIR64_LOPART(uint64 x);
inline uint16 MAKE_PAIR16(uint8 l, uint8 h);
inline uint32 MAKE_PAIR32(uint16 l, uint16 h);
inline uint16 PAIR32_HIPART(uint32 x);
inline uint16 PAIR32_LOPART(uint32 x);

enum class VisibilityDistanceType : uint8
{
    Normal   = 0,
    Tiny     = 1,
    Small    = 2,
    Large    = 3,
    Gigantic = 4,
    Infinite = 5,

    Max
};

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

#endif
