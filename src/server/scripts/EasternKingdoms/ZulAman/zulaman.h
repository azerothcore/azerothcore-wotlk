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

#ifndef DEF_ZULAMAN_H
#define DEF_ZULAMAN_H

#include "CreatureAIImpl.h"

#define DataHeader "ZA"
#define ZulAmanScriptName "instance_zulaman"

enum DataTypes
{
    DATA_NALORAKK                       = 0,
    DATA_AKILZON                        = 1,
    DATA_JANALAI                        = 2,
    DATA_HALAZZI                        = 3,
    DATA_HEXLORD                        = 4,
    DATA_ZULJIN                         = 5,
    MAX_ENCOUNTER                       = 6,
    DATA_SPIRIT_LYNX                    = 7,
    TYPE_RAND_VENDOR_1                  = 8,
    TYPE_RAND_VENDOR_2                  = 9,
    DATA_STRANGE_GONG                   = 10,
    DATA_MASSIVE_GATE                   = 11,
    DATA_HEXLORD_GATE                   = 12,
    DATA_HARRISON_JONES                 = 13,
    TYPE_AKILZON_GAUNTLET               = 14,
    DATA_LOOKOUT                        = 15,
    DATA_ZULJIN_GATE                    = 16,
    DATA_CHEST_LOOTED                   = 17 // Used for hostage loot DB conditions
};

enum CreatureIds
{
    NPC_HARRISON_JONES                  = 24358,
    NPC_JANALAI                         = 23578,
    NPC_ZULJIN                          = 23863,
    NPC_HEXLORD                         = 24239,
    NPC_HALAZZI                         = 23577,
    NPC_NALORAKK                        = 23576,
    NPC_SPIRIT_LYNX                     = 24143,
    NPC_AMANISHI_SAVAGE                 = 23889,
    NPC_AMANISHI_WARBRINGER             = 23580,
    NPC_AMANISHI_TRIBESMAN              = 23582,
    NPC_AMANISHI_MEDICINE_MAN           = 23581,
    NPC_AMANISHI_AXE_THROWER            = 23542,
    NPC_AMANI_HATCHLING                 = 23598, // 42493
    NPC_AMANISHI_GUARDIAN               = 23597,
    // Akil'zon gauntlet
    NPC_AMANISHI_WIND_WALKER            = 24179,
    NPC_AMANISHI_LOOKOUT                = 24175,
    NPC_AMANISHI_PROTECTOR              = 24180,
    NPC_AMANISHI_TEMPEST                = 24549,
    NPC_EAGLE_TRASH_AGGRO_TRIGGER       = 24223
};

enum GameobjectIds
{
    GO_DOOR_HALAZZI                     = 186303,
    GO_LYNX_TEMPLE_ENTRANCE             = 186304,
    GO_GATE_HEXLORD                     = 186305,
    GO_GATE_ZULJIN                      = 186306,
    GO_MASSIVE_GATE                     = 186728,
    GO_DOOR_AKILZON                     = 186858,
    GO_ZULJIN_FIREWALL                  = 186859,
    GO_HARKORS_SATCHEL                  = 187021,
    GO_TANZARS_TRUNK                    = 186648,
    GO_ASHLIS_BAG                       = 186672,
    GO_KRAZS_PACKAGE                    = 186667,
    GO_STRANGE_GONG                     = 187359,
    GO_ALTAR_TORCH_EAGLE_GOD            = 187035,
    GO_ALTAR_TORCH_DRAGONHAWK_GOD       = 187036,
    GO_ALTAR_TORCH_LYNX_GOD             = 187037,
    GO_ALTAR_TORCH_BEAR_GOD             = 186860
};

enum MiscIds
{
    // Persistent data
    DATA_TIMED_RUN                      = 0,
    DATA_CHEST_COUNT                    = 1,

    ACTION_START_TIMED_RUN              = 0,
    ACTION_START_AKILZON_GAUNTLET       = 1,
    ACTION_RESET_AKILZON_GAUNTLET       = 2,
    GROUP_TIMED_RUN                     = 1
};

uint32 constexpr PersistentDataCount = 2;

template <class AI, class T>
inline AI* GetZulAmanAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ZulAmanScriptName);
}

#define RegisterZulAmanCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetZulAmanAI)

#endif
