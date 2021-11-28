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

#ifndef DEF_BRD_H
#define DEF_BRD_H

#include "CreatureAIImpl.h"
#define BRDScriptName "instance_blackrock_depths"

enum BRDBosses
{
    BOSS_AMBASSADOR_FLAMELASH = 0,
};

enum DataTypes
{
    TYPE_RING_OF_LAW                = 1,
    TYPE_VAULT                      = 2,
    TYPE_BAR                        = 3,
    TYPE_TOMB_OF_SEVEN              = 4,
    TYPE_LYCEUM                     = 5,
    TYPE_IRON_HALL                  = 6,

    DATA_EMPEROR                    = 10,
    DATA_PHALANX                    = 11,

    DATA_ARENA1                     = 12,
    DATA_ARENA2                     = 13,
    DATA_ARENA3                     = 14,
    DATA_ARENA4                     = 15,

    DATA_GO_BAR_KEG                 = 16,
    DATA_GO_BAR_KEG_TRAP            = 17,
    DATA_GO_BAR_DOOR                = 18,
    DATA_GO_CHALICE                 = 19,

    DATA_GOLEM_DOOR_N               = 22,
    DATA_GOLEM_DOOR_S               = 23,

    DATA_THRONE_DOOR                = 24,

    DATA_SF_BRAZIER_N               = 25,
    DATA_SF_BRAZIER_S               = 26,
    DATA_MOIRA                      = 27,

    DATA_OPEN_COFFER_DOORS          = 30,

    DATA_GOLEM_LORD_ARGELMACH_INIT  = 31,
    DATA_GOLEM_LORD_ARGELMACH_ADDS  = 32,

    DATA_MAGMUS                     = 33,

    DATA_COREN                      = 34
};

enum CreatureIds
{
    NPC_MAGMUS = 9938
};

template <class AI, class T>
inline AI* GetBlackrockDepthsAI(T* obj)
{
    return GetInstanceAI<AI>(obj, BRDScriptName);
}

#endif
