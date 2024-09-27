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

#ifndef DEF_ZULFARRACK_H
#define DEF_ZULFARRACK_H

#include "CreatureAIImpl.h"

#define DataHeader "ZF"

#define ZFScriptName "instance_zulfarrak"

enum ZulFarrakCreatures
{
    NPC_SANDFURY_CRETIN         = 7789,
    NPC_SANDFURY_SLAVE          = 7787,
    NPC_SANDFURY_ACOLYTE        = 8876,
    NPC_SANDFURY_DRUDGE         = 7788,
    NPC_SANDFURY_ZEALOT         = 8877,
    NPC_SHADOWPRIEST_SEZZZIZ    = 7275,
    NPC_NEKRUM_GUTCHEWER        = 7796,

    NPC_BLY                     = 7604,
    NPC_RAVEN                   = 7605,
    NPC_ORO                     = 7606,
    NPC_WEEGLI                  = 7607,
    NPC_MURTA                   = 7608
};

enum ZulFarrakGameobjects
{
    GO_END_DOOR                 = 146084
};

enum ZulFarrakData
{
    DATA_PYRAMID                = 0,
    DATA_GAHZRILLA              = 1
};

enum ZFPyramidPhases
{
    PYRAMID_NOT_STARTED, //default
    PYRAMID_CAGES_OPEN, //happens in GO hello for cages
    PYRAMID_ARRIVED_AT_STAIR, //happens in Weegli's movementinform
    PYRAMID_WAVE_1,
    PYRAMID_PRE_WAVE_2,
    PYRAMID_WAVE_2,
    PYRAMID_PRE_WAVE_3,
    PYRAMID_WAVE_3,
    PYRAMID_KILLED_ALL_TROLLS,
    PYRAMID_MOVED_DOWNSTAIRS,
    PYRAMID_DESTROY_GATES,
    PYRAMID_GATES_DESTROYED,
    PYRAMID_DONE
};

template <class AI, class T>
inline AI* GetZulFarrakAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ZFScriptName);
}

#endif
