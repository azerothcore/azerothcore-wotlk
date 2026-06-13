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

#ifndef ARCATRAZ_H
#define ARCATRAZ_H

#include "CreatureAIImpl.h"

#define DataHeader "AZ"

#define ArcatrazScriptName "instance_arcatraz"

enum DataTypes
{
    // Encounter States/Boss GUIDs
    DATA_ZEREKETH                               = 0,
    DATA_DALLIAH                                = 1,
    DATA_SOCCOTHRATES                           = 2,
    DATA_WARDEN_MELLICHAR                       = 3,
    MAX_ENCOUTER                                = 4,

    // Additional Data
    DATA_WARDEN_1                               = 5, // used by SmartAI
    DATA_WARDEN_2                               = 6, // used by SmartAI
    DATA_WARDEN_3                               = 7, // used by SmartAI
    DATA_WARDEN_4                               = 8, // used by SmartAI
    DATA_WARDEN_5                               = 9, // used by SmartAI
    DATA_WARDENS_SHIELD                         = 10
};

enum CreatureIds
{
    NPC_DALLIAH                                 = 20885,
    NPC_SOCCOTHRATES                            = 20886,
    NPC_MELLICHAR                               = 20904,
    NPC_HARBINGER_SKYRISS                       = 20912,
    NPC_ALPHA_POD_TARGET                        = 21436
};

enum GameObjectIds
{
    GO_CONTAINMENT_CORE_SECURITY_FIELD_ALPHA    = 184318, // door opened when Wrath-Scryer Soccothrates dies
    GO_CONTAINMENT_CORE_SECURITY_FIELD_BETA     = 184319, // door opened when Dalliah the Doomsayer dies
    GO_STASIS_POD_ALPHA                         = 183961, // pod first boss wave
    GO_STASIS_POD_BETA                          = 183963, // pod second boss wave
    GO_STASIS_POD_DELTA                         = 183964, // pod third boss wave
    GO_STASIS_POD_GAMMA                         = 183962, // pod fourth boss wave
    GO_STASIS_POD_OMEGA                         = 183965, // pod fifth boss wave
    GO_WARDENS_SHIELD                           = 184802  // shield 'protecting' mellichar
};

enum SpellIds
{
    SPELL_TELEPORT_VISUAL                   = 35517,
    SPELL_SOUL_STEAL                        = 36782
};

enum Texts
{
    SAY_RIVAL_DIED = 6 // Soccothrates & Delliah
};

template <class AI, class T>
inline AI* GetArcatrazAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ArcatrazScriptName);
}

#define RegisterArcatrazCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetArcatrazAI)

#endif // ARCATRAZ_H
