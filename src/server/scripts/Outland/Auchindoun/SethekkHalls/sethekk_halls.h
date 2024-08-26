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

#ifndef DEF_SETHEKK_HALLS_H
#define DEF_SETHEKK_HALLS_H

#include "CreatureAIImpl.h"

#define DataHeaders "SH"

uint32 constexpr EncounterCount = 3;

#define SethekkHallsScriptName "instance_sethekk_halls"

enum Encounters
{
    DATA_DARKWEAVER_SYTH,
    DATA_ANZU,
    DATA_IKISS,
};

enum eTypes
{
    DATA_IKISSDOOREVENT = 1,
    TYPE_ANZU_ENCOUNTER = 2,
};

enum InstanceData
{
    DATA_GO_TALON_KING_COFFER,
    DATA_VOICE_OF_THE_RAVEN_GOD
};

enum eIds
{
    NPC_VOICE_OF_THE_RAVEN_GOD  = 21851,
    NPC_ANZU                    = 23035,

    GO_IKISS_DOOR               = 183398,
    GO_THE_TALON_KINGS_COFFER   = 187372
};

template <class AI, class T>
inline AI* GetSethekkHallsAI(T* obj)
{
    return GetInstanceAI<AI>(obj, SethekkHallsScriptName);
}

#define RegisterSethekkHallsCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetSethekkHallsAI)

#endif
