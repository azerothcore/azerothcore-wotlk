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

#ifndef DEF_OBSIDIAN_SANCTUM_H
#define DEF_OBSIDIAN_SANCTUM_H

#include "CreatureAIImpl.h"

#define DataHeader "OS"

#define ObsidianSanctumScriptName "instance_obsidian_sanctum"

enum Data : uint32
{
    // Encounters
    DATA_SARTHARION                 = 0,
    DATA_TENEBRON                   = 1,
    DATA_VESPERON                   = 2,
    DATA_SHADRON                    = 3,
    MAX_ENCOUNTERS                  = 4,

    // Achievements
    DATA_ACHIEVEMENT_DRAGONS_COUNT  = 30,
    DATA_VOLCANO_BLOWS              = 31,

    // NPCs
    NPC_SARTHARION                  = 28860,
    NPC_TENEBRON                    = 30452,
    NPC_SHADRON                     = 30451,
    NPC_VESPERON                    = 30449,
    NPC_FIRE_CYCLONE                = 30648,

    // GOs
    GO_TWILIGHT_PORTAL              = 193988,
    GO_NORMAL_PORTAL                = 193989,

    // Spells
    SPELL_TWILIGHT_SHIFT            = 57620,
    SPELL_TWILIGHT_TORMENT_SARTHARION = 58835,
};

enum OSActions
{
    // Portal
    ACTION_CLEAR_PORTAL               = -1,
    ACTION_ADD_PORTAL                 = -2,
};

template <class AI, class T>
inline AI* GetObsidianSanctumAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ObsidianSanctumScriptName);
}

#endif
