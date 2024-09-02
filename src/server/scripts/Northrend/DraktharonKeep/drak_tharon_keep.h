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

#ifndef DEF_DRAK_THARON_H
#define DEF_DRAK_THARON_H

#include "CreatureAIImpl.h"

#define DataHeader "DTK"

#define DraktharonKeepScriptName "instance_drak_tharon_keep"

enum Data
{
    DATA_TROLLGORE              = 0,
    DATA_NOVOS                  = 1,
    DATA_NOVOS_CRYSTALS         = 2,
    DATA_DRED                   = 3,
    DATA_THARON_JA              = 4,
    MAX_ENCOUNTERS              = 5
};

enum Creatures
{
    NPC_KURZEL                  = 26664,
    NPC_DRAKKARI_GUARDIAN       = 26620,
    NPC_RISEN_DRAKKARI_WARRIOR  = 26635,
};

enum GameObjects
{
    GO_NOVOS_CRYSTAL_1          = 189299,
    GO_NOVOS_CRYSTAL_2          = 189300,
    GO_NOVOS_CRYSTAL_3          = 189301,
    GO_NOVOS_CRYSTAL_4          = 189302,
};

enum DTKSpells
{
    SPELL_SUMMON_DRAKKARI_SHAMAN    = 49958,
    SPELL_SUMMON_DRAKKARI_GUARDIAN  = 49959
};

template <class AI, class T>
inline AI* GetDraktharonKeepAI(T* obj)
{
    return GetInstanceAI<AI>(obj, DraktharonKeepScriptName);
}

#endif
