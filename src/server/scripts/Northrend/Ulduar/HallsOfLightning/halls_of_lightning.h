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

#ifndef DEF_HALLS_OF_LIGHTNING_H
#define DEF_HALLS_OF_LIGHTNING_H

#include "CreatureAIImpl.h"

#define DataHeader "HOL"

#define HallsOfLightningScriptName "instance_halls_of_lightning"

enum HoLBossIds
{
    DATA_BJARNGRIM                          = 0,
    DATA_IONAR                              = 1,
    DATA_LOKEN                              = 2,
    DATA_VOLKHAN                            = 3,
    MAX_ENCOUNTERS
};

enum HoLDataTypes
{
    // GameObject data
    DATA_LOKEN_THRONE           = 0,

    // Achievement data
    DATA_BJARNGRIM_ACHIEVEMENT  = 10,
    DATA_VOLKHAN_ACHIEVEMENT    = 11,
};

enum HoLNPCs
{
    NPC_TITANIUM_THUNDERER    = 28965,
    NPC_TITANIUM_SIEGEBREAKER = 28961
};

enum HoLGOs
{
    GO_VOLKHAN_DOOR         = 191325,
    GO_IONAR_DOOR           = 191326,
    GO_LOKEN_THRONE         = 192654
};

enum HoLActions
{
    ACTION_ACTIVATE_TITANIUM_VRYKUL,
};

template <class AI, class T>
inline AI* GetHallsOfLightningAI(T* obj)
{
    return GetInstanceAI<AI>(obj, HallsOfLightningScriptName);
}

#define RegisterHallOfLightningCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetHallsOfLightningAI)

#endif
