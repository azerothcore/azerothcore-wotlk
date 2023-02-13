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

#ifndef DEF_RUINS_OF_AHNQIRAJ_H
#define DEF_RUINS_OF_AHNQIRAJ_H

#include "CreatureAIImpl.h"

#define DataHeader "RA"
#define RuinsOfAhnQirajScriptName "instance_ruins_of_ahnqiraj"

enum DataTypes
{
    DATA_KURINNAXX          = 0,
    DATA_RAJAXX             = 1,
    DATA_MOAM               = 2,
    DATA_BURU               = 3,
    DATA_AYAMISS            = 4,
    DATA_OSSIRIAN           = 5,
    NUM_ENCOUNTER           = 6,

    DATA_PARALYZED          = 7,

    DATA_QUUEZ              = 8,
    DATA_TUUBID             = 9,
    DATA_DRENN              = 10,
    DATA_XURREM             = 11,
    DATA_YEGGETH            = 12,
    DATA_PAKKON             = 13,
    DATA_ZERRAN             = 14,
    DATA_ANDOROV            = 15,

    DATA_BURU_PHASE         = 16,

    DATA_ENGAGED_FORMATION  = 1
};

enum Creatures
{
    NPC_KURINNAXX               = 15348,
    NPC_RAJAXX                  = 15341,
    NPC_MOAM                    = 15340,
    NPC_BURU                    = 15370,
    NPC_AYAMISS                 = 15369,
    NPC_OSSIRIAN                = 15339,
    NPC_HIVEZARA_HORNET         = 15934,
    NPC_HIVEZARA_SWARMER        = 15546,
    NPC_HIVEZARA_LARVA          = 15555,
    NPC_SAND_VORTEX             = 15428,
    NPC_OSSIRIAN_TRIGGER        = 15590,
    NPC_HATCHLING               = 15521,
    NPC_BURU_EGG                = 15514,

    // Rajaxx
    NPC_QUUEZ                   = 15391,
    NPC_TUUBID                  = 15392,
    NPC_DRENN                   = 15389,
    NPC_XURREM                  = 15390,
    NPC_YEGGETH                 = 15386,
    NPC_PAKKON                  = 15388,
    NPC_ZERRAN                  = 15385,
    NPC_ANDOROV                 = 15471,
    NPC_KALDOREI_ELITE          = 15473
};

enum GameObjects
{
    GO_OSSIRIAN_CRYSTAL         = 180619
};

template <class AI, class T>
inline AI* GetRuinsOfAhnQirajAI(T* obj)
{
    return GetInstanceAI<AI>(obj, RuinsOfAhnQirajScriptName);
}

#define RegisterRuinsOfAhnQirajCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetRuinsOfAhnQirajAI)

#endif
