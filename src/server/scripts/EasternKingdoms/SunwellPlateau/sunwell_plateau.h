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

#ifndef SUNWELL_PLATEAU_H
#define SUNWELL_PLATEAU_H

#include "CreatureAIImpl.h"

#define DataHeader "SWP"

#define SWPScriptName "instance_sunwell_plateau"

enum BossIds
{
    DATA_KALECGOS                           = 0,
    DATA_BRUTALLUS                          = 1,
    DATA_FELMYST                            = 2,
    DATA_FELMYST_DOORS                      = 3,
    DATA_EREDAR_TWINS                       = 4,
    DATA_MURU                               = 5,
    DATA_KILJAEDEN                          = 6,
    MAX_ENCOUNTERS
};

enum DataTypes
{
    DATA_SACROLASH                          = 7,
    DATA_ALYTHESS                           = 8,
    DATA_MADRIGOSA                          = 9,
    DATA_SATHROVARR                         = 10,
    DATA_KJ_CONTROLLER                      = 11,
    DATA_ANVEENA                            = 12,
    DATA_KALECGOS_KJ                        = 13,
    DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_1     = 14,
    DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_2     = 15,
    DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_3     = 16,
    DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_4     = 17,
    DATA_ICEBARRIER                         = 18,
};

enum CreatureIds
{
    NPC_KALECGOS                            = 24850,
    NPC_KALEC                               = 24891,
    NPC_SATHROVARR                          = 24892,

    NPC_BRUTALLUS                           = 24882,
    NPC_MADRIGOSA                           = 24895,
    NPC_FELMYST                             = 25038,
    NPC_DEMONIC_VAPOR_TRAIL                 = 25267,
    NPC_UNYIELDING_DEAD                     = 25268,

    NPC_GRAND_WARLOCK_ALYTHESS              = 25166,
    NPC_LADY_SACROLASH                      = 25165,
    NPC_SHADOW_IMAGE                        = 25214,

    NPC_MURU                                = 25741,
    NPC_ENTROPIUS                           = 25840,
    NPC_DARKNESS                            = 25879,
    NPC_VOID_SENTINEL                       = 25772,
    NPC_VOID_SPAWN                          = 25824,

    NPC_KILJAEDEN_CONTROLLER                = 25608,
    NPC_KILJAEDEN                           = 25315,
    NPC_ANVEENA                             = 26046,
    NPC_KALECGOS_KJ                         = 25319,
    NPC_HAND_OF_THE_DECEIVER                = 25588,
    NPC_FELFIRE_PORTAL                      = 25603,
    NPC_VOLATILE_FELFIRE_FIEND              = 25598,
    NPC_SHIELD_ORB                          = 25502,
    NPC_SINISTER_REFLECTION                 = 25708,
    NPC_ARMAGEDDON_TARGET                   = 25735,
};

enum GameObjectIds
{
    GO_FORCE_FIELD                          = 188421,
    GO_BOSS_COLLISION_1                     = 188523,
    GO_BOSS_COLLISION_2                     = 188524,
    GO_FIRE_BARRIER                         = 188075,
    GO_MURUS_GATE_1                         = 187990,
    GO_MURUS_GATE_2                         = 188118,
    GO_ICE_BARRIER                          = 188119,

    GO_ORB_OF_THE_BLUE_DRAGONFLIGHT1        = 187869,
    GO_ORB_OF_THE_BLUE_DRAGONFLIGHT2        = 188114,
    GO_ORB_OF_THE_BLUE_DRAGONFLIGHT3        = 188115,
    GO_ORB_OF_THE_BLUE_DRAGONFLIGHT4        = 188116
};

enum SpellIds
{
    SPELL_SUMMON_FELBLAZE                    = 45069 // Felblaze? Summons Felmyst
};

template <class AI, class T>
inline AI* GetSunwellPlateauAI(T* obj)
{
    return GetInstanceAI<AI>(obj, SWPScriptName);
}

#define RegisterSunwellPlateauCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetSunwellPlateauAI)

#endif // SUNWELL_PLATEAU_H
