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

#ifndef DEF_UTGARDE_KEEP_H
#define DEF_UTGARDE_KEEP_H

#include "CreatureAIImpl.h"

#define UtgardeKeepScriptName "instance_utgarde_keep"

enum eData
{
    DATA_KELESETH,
    DATA_DALRONN_AND_SKARVALD,
    DATA_INGVAR,
    MAX_ENCOUNTER,
    DATA_FORGE_EVENT_MASK,
    DATA_DALRONN,
    DATA_SKARVALD,
    DATA_DALRONN_GHOST,
    DATA_SKARVALD_GHOST,
    DATA_DARK_RANGER_MARRAH,
    DATA_ON_THE_ROCKS_ACHIEV,

    DATA_SPECIAL_DRAKE = 50,

    DATA_FORGE_1 = 100,
    DATA_FORGE_2,
    DATA_FORGE_3,

    DATA_UNLOCK_SKARVALD_LOOT = 200,
    DATA_UNLOCK_DALRONN_LOOT,
};

enum eGameObject
{
    GO_BELLOW_1                     = 186688,
    GO_BELLOW_2                     = 186689,
    GO_BELLOW_3                     = 186690,

    GO_FORGEFIRE_1                  = 186692,
    GO_FORGEFIRE_2                  = 186693,
    GO_FORGEFIRE_3                  = 186691,

    GO_GLOWING_ANVIL_1              = 186609,
    GO_GLOWING_ANVIL_2              = 186610,
    GO_GLOWING_ANVIL_3              = 186611,

    GO_GIANT_PORTCULLIS_1           = 186756,
    GO_GIANT_PORTCULLIS_2           = 186694,
};

enum eCreatures
{
    NPC_KELESETH                    = 23953,
    NPC_DALRONN                     = 24201,
    NPC_DALRONN_GHOST               = 27389,
    NPC_SKARVALD                    = 24200,
    NPC_SKARVALD_GHOST              = 27390,
    NPC_INGVAR                      = 23954,

    NPC_DARK_RANGER_MARRAH          = 24137,
    NPC_ENSLAVED_PROTO_DRAKE        = 24083,
};

template <class AI, class T>
inline AI* GetUtgardeKeepAI(T* obj)
{
    return GetInstanceAI<AI>(obj, UtgardeKeepScriptName);
}

#endif
