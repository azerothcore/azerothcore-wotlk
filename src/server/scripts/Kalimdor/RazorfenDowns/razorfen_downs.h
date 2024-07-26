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

#ifndef DEF_RAZORFEN_DOWNS_H
#define DEF_RAZORFEN_DOWNS_H

#include "CreatureAIImpl.h"

#define DataHeader "RFD"

#define RazorfenDownsScriptName "instance_razorfen_downs"

enum CreatureIds
{
    NPC_IDOL_ROOM_SPAWNER                  = 8611,
    NPC_WITHERED_BATTLE_BOAR               = 7333,
    NPC_DEATHS_HEAD_GEOMANCER              = 7335,
    NPC_WITHERED_QUILGUARD                 = 7329,
    NPC_PLAGUEMAW_THE_ROTTING              = 7356
};

enum GameObjectIds
{
    GO_GONG                                = 148917,

    GO_IDOL_OVEN_FIRE                      = 151951,
    GO_IDOL_CUP_FIRE                       = 151952,
    GO_IDOL_MOUTH_FIRE                     = 151973,
    GO_BELNISTRASZS_BRAZIER                = 152097
};

template <class AI, class T>
inline AI* GetRazorfenDownsAI(T* obj)
{
    return GetInstanceAI<AI>(obj, RazorfenDownsScriptName);
}

#endif
