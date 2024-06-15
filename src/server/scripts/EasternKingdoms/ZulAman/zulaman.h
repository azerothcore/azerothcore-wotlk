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

#ifndef DEF_ZULAMAN_H
#define DEF_ZULAMAN_H

#include "CreatureAIImpl.h"

#define DataHeader "ZA"
#define ZulAmanScriptName "instance_zulaman"

enum DataTypes
{
    DATA_GONGEVENT                      = 0,
    DATA_NALORAKKEVENT                  = 1,
    DATA_AKILZONEVENT                   = 2,
    DATA_JANALAIEVENT                   = 3,
    DATA_HALAZZIEVENT                   = 4,
    DATA_HEXLORDEVENT                   = 5,
    DATA_ZULJINEVENT                    = 6,
    DATA_SPIRIT_LYNX                    = 7,
    DATA_CHESTLOOTED                    = 8,
    TYPE_RAND_VENDOR_1                  = 9,
    TYPE_RAND_VENDOR_2                  = 10
};

enum CreatureIds
{
    NPC_HARRISON_JONES                  = 24358,
    NPC_JANALAI                         = 23578,
    NPC_ZULJIN                          = 23863,
    NPC_HEXLORD                         = 24239,
    NPC_HALAZZI                         = 23577,
    NPC_NALORAKK                        = 23576,
    NPC_SPIRIT_LYNX                     = 24143
};

enum GameobjectIds
{
    GO_DOOR_HALAZZI                     = 186303,
    GO_GATE_ZULJIN                      = 186304,
    GO_GATE_HEXLORD                     = 186305,
    GO_MASSIVE_GATE                     = 186728,
    GO_DOOR_AKILZON                     = 186858,
    GO_DOOR_ZULJIN                      = 186859,
    GO_HARKORS_SATCHEL                  = 187021,
    GO_TANZARS_TRUNK                    = 186648,
    GO_ASHLIS_BAG                       = 186672,
    GO_KRAZS_PACKAGE                    = 186667,
    GO_STRANGE_GONG                     = 187359
};

template <class AI, class T>
inline AI* GetZulAmanAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ZulAmanScriptName);
}

#define RegisterZulAmanCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetZulAmanAI)

#endif
