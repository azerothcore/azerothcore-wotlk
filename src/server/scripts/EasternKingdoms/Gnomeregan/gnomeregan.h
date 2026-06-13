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

#ifndef DEF_GNOMEREGAN_H
#define DEF_GNOMEREGAN_H

#include "CreatureAIImpl.h"

#define DataHeader "GNO"

#define GnomereganScriptName "instance_gnomeregan"

template <class AI, class T>
inline AI* GetGnomereganAI(T* obj)
{
    return GetInstanceAI<AI>(obj, GnomereganScriptName);
}

enum DataTypes
{
    TYPE_GRUBBIS    = 0,
    MAX_ENCOUNTERS  = 1
};

enum GameObjects
{
    GO_CAVE_IN_1            = 146085,
    GO_CAVE_IN_2            = 146086,
    GO_WORKSHOP_DOOR        = 90858,
    GO_FINAL_CHAMBER_DOOR   = 142207,
};

enum NPCs
{
    NPC_EMI_SHORTFUSE = 7998
};

#endif
