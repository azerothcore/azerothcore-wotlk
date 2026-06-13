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

#ifndef DEF_TEMPLE_OF_AHNQIRAJ_H
#define DEF_TEMPLE_OF_AHNQIRAJ_H

#include "CreatureAIImpl.h"

#define DataHeader "AQT"
#define TempleOfAhnQirajScriptName "instance_temple_of_ahnqiraj"

enum DataTypes
{
    DATA_SKERAM             = 1,
    DATA_BUG_TRIO           = 2,
    DATA_SARTURA            = 3,
    DATA_FANKRISS           = 4,
    DATA_VISCIDUS           = 5,
    DATA_HUHURAN            = 6,
    DATA_TWIN_EMPERORS      = 7,
    DATA_OURO               = 8,
    DATA_CTHUN              = 9,

    MAX_BOSS_NUMBER         = 10,

    DATA_KRI                = 10,
    DATA_VEM                = 11,
    DATA_YAUJ               = 12,
    DATA_BUG_TRIO_DEATH     = 13,
    DATA_OURO_SPAWNER       = 14,
    DATA_VEKLOR             = 15,
    DATA_VEKNILASH          = 16,
    DATA_EYE_OF_CTHUN       = 18,
    DATA_MASTERS_EYE        = 19
};

enum Creatures
{
    NPC_MASTERS_EYE         = 15963,
    NPC_CTHUN               = 15727,
    NPC_EYE_OF_CTHUN        = 15589,
    NPC_CTHUN_PORTAL        = 15896,
    NPC_CLAW_TENTACLE       = 15725,
    NPC_EYE_TENTACLE        = 15726,
    NPC_SMALL_PORTAL        = 15904,
    NPC_BODY_OF_CTHUN       = 15809,
    NPC_GIANT_CLAW_TENTACLE = 15728,
    NPC_GIANT_EYE_TENTACLE  = 15334,
    NPC_FLESH_TENTACLE      = 15802,
    NPC_GIANT_PORTAL        = 15910,
    NPC_SARTURA_ROYAL_GUARD = 15984,
    NPC_VISCIDUS            = 15299,
    NPC_GLOB_OF_VISCIDUS    = 15667,

    NPC_SKERAM              = 15263,
    NPC_VEM                 = 15544,
    NPC_KRI                 = 15511,
    NPC_YAUJ                = 15543,
    NPC_HUHURAN             = 15509,
    NPC_VEKLOR              = 15276,
    NPC_VEKNILASH           = 15275,
    NPC_OURO                = 15517,
    NPC_OURO_SPAWNER        = 15957,
    NPC_SARTURA             = 15516,

    NPC_QIRAJI_SLAYER       = 15250,
    NPC_QIRAJI_MINDSLAYER   = 15246
};

enum ObjectsAQ40
{
    AQ40_DOOR_TE_ENTRANCE   = 180634,
    AQ40_DOOR_TE_EXIT       = 180635,
    AQ40_DOOR_SKERAM        = 180636,
    GO_CTHUN_GRASP          = 180745
};

enum CThunPhases
{
    PHASE_NOT_STARTED       = 0,

    // Main Phase 1 - EYE
    PHASE_EYE_GREEN_BEAM    = 1,
    PHASE_EYE_RED_BEAM      = 2,

    // Main Phase 2 - CTHUN
    PHASE_CTHUN_TRANSITION  = 3,
    PHASE_CTHUN_STOMACH     = 4,
    PHASE_CTHUN_WEAK        = 5,

    PHASE_CTHUN_DONE        = 6
};

template <class AI, class T>
inline AI* GetTempleOfAhnQirajAI(T* obj)
{
    return GetInstanceAI<AI>(obj, TempleOfAhnQirajScriptName);
}

#define RegisterTempleOfAhnQirajCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetTempleOfAhnQirajAI)

#endif
