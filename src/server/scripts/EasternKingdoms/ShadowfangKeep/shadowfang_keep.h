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

#ifndef DEF_SHADOWFANG_H
#define DEF_SHADOWFANG_H

#include "CreatureAIImpl.h"

#define DataHeader "SK"
#define ShadowfangKeepScriptName "instance_shadowfang_keep"

enum DataTypes
{
    TYPE_COURTYARD              = 0,
    TYPE_FENRUS_THE_DEVOURER    = 1,
    TYPE_WOLF_MASTER_NANDOS     = 2,
    MAX_ENCOUNTERS              = 3,
    DATA_APOTHECARY_HUMMEL      = 4,
    DATA_SPAWN_VALENTINE_ADDS   = 5
};

enum SKCreatures
{
    NPC_DND_CRAZED_APOTHECARY_GENERATOR = 36212,
    NPC_APOTHECARY_HUMMEL               = 36296,
    NPC_CRAZED_APOTHECARY               = 36568
};

enum GameObjects
{
    GO_COURTYARD_DOOR           = 18895,
    GO_SORCERER_DOOR            = 18972,
    GO_ARUGAL_DOOR              = 18971
};

template <class AI, class T>
inline AI* GetShadowfangKeepAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ShadowfangKeepScriptName);
}

#define RegisterShadowfangKeepCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetShadowfangKeepAI)

#endif
