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

#ifndef DEF_OCULUS_H
#define DEF_OCULUS_H

#include "CreatureAIImpl.h"
#include "SpellScript.h"

#define DataHeader "OC"

#define OculusScriptName "instance_oculus"

Position const VerdisaPOS = { 949.056f, 1032.97f, 359.967f, 1.035795f };
Position const BelgaristraszPOS = { 941.355f, 1044.26f,  359.967f, 0.222459f };
Position const EternosPOS = { 943.202f, 1059.35f, 359.967f, 5.757278f };

enum Data
{
    DATA_DRAKOS,            // Drakos the Interrogator
    DATA_VAROS,             // Varos Cloudstrider
    DATA_UROM,              // Mage-Lord Urom
    DATA_EREGOS,            // Ley-Guardian Eregos
    MAX_ENCOUNTER,
    DATA_CC_COUNT,
    DATA_AMBER_VOID,
    DATA_EMERALD_VOID,
    DATA_RUBY_VOID,
    DATA_DCD_1              = 100,
    DATA_DCD_2              = 101,
    DATA_DCD_3              = 102,
};

enum NPCs
{
    NPC_DRAKOS              = 27654,
    NPC_VAROS               = 27447,
    NPC_UROM                = 27655,
    NPC_EREGOS              = 27656,

    NPC_VERDISA             = 27657,
    NPC_BELGARISTRASZ       = 27658,
    NPC_ETERNOS             = 27659,

    NPC_AMBER_DRAKE         = 27755,
    NPC_EMERALD_DRAKE       = 27692,
    NPC_RUBY_DRAKE          = 27756,

    NPC_CENTRIFUGE_CONSTRUCT = 27641,

    NPC_IMAGE_OF_BELGARISTRASZ = 28012,
};

enum Talks
{
    SAY_BELGARISTRASZ = 0,
};

enum Items
{
    ITEM_EMERALD_ESSENCE    = 37815,
    ITEM_AMBER_ESSENCE      = 37859,
    ITEM_RUBY_ESSENCE       = 37860,
};

enum GOs
{
    GO_DRAGON_CAGE          = 189986,
    GO_DRAGON_CAGE_DOOR     = 193995,
    GO_CACHE_OF_EREGOS      = 191349,
    GO_CACHE_OF_EREGOS_HERO = 193603,
    GO_SPOTLIGHT            = 191351,
};

enum AchievData
{
    ACHIEV_MAKE_IT_COUNT_TIMED_EVENT    = 18153,
    CRITERIA_EXPERIENCED_AMBER          = 7177,
    CRITERIA_EXPERIENCED_EMERALD        = 7178,
    CRITERIA_EXPERIENCED_RUBY           = 7179,
    CRITERIA_AMBER_VOID                 = 7325,
    CRITERIA_EMERALD_VOID               = 7324,
    CRITERIA_RUBY_VOID                  = 7323,
};

enum OculusWorldStates
{
    WORLD_STATE_CENTRIFUGE_CONSTRUCT_SHOW   = 3524,
    WORLD_STATE_CENTRIFUGE_CONSTRUCT_AMOUNT = 3486
};

enum MISC
{
    POINT_MOVE_DRAKES
};

template <class AI, class T>
inline AI* GetOculusAI(T* obj)
{
    return GetInstanceAI<AI>(obj, OculusScriptName);
}

#endif
