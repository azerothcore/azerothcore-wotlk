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

#ifndef DEF_SCHOLOMANCE_H
#define DEF_SCHOLOMANCE_H

#include "CreatureAIImpl.h"

#define ScholomanceScriptName "instance_scholomance"

enum DataTypes
{
    DATA_KIRTONOS_THE_HERALD            = 0,
    DATA_MINI_BOSSES                    = 1,
    DATA_RAS_HUMAN                      = 2,
    DATA_DARKMASTER_GANDLING            = 3
};

enum ModelIds
{
    MODEL_RAS_HUMAN = 3975
};

enum TalkGroupIds
{
    TALK_RAS_HUMAN = 0
};

enum CreatureIds
{
    NPC_RISEN_GUARDIAN          = 11598,
    NPC_DARKMASTER_GANDLING     = 1853,
    NPC_KIRTONOS                = 10506
};

enum GameobjectIds
{
    GO_BRAZIER_KIRTONOS         = 175564,
    GO_GATE_KIRTONOS            = 175570,

    GO_DOOR_OPENED_WITH_KEY     = 175167,

    GO_GATE_GANDLING_ENTRANCE   = 177374,

    GO_GATE_GANDLING_DOWN_NORTH = 177371,
    GO_GATE_GANDLING_DOWN_EAST  = 177373,
    GO_GATE_GANDLING_DOWN_SOUTH = 177372,
    GO_GATE_GANDLING_UP_NORTH   = 177376,
    GO_GATE_GANDLING_UP_EAST    = 177377,
    GO_GATE_GANDLING_UP_SOUTH   = 177375
};

template <class AI, class T>
inline AI* GetScholomanceAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ScholomanceScriptName);
}

#define RegisterScholomanceCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetScholomanceAI)

#endif
