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

#ifndef DEF_SHADOW_LABYRINTH_H
#define DEF_SHADOW_LABYRINTH_H

#include "CreatureAIImpl.h"
#include "GridNotifiers.h"

#define ShadowLabyrinthScriptName "instance_shadow_labyrinth"

enum slEncounterData
{
    TYPE_HELLMAW                    = 0,
    DATA_BLACKHEARTTHEINCITEREVENT  = 1,
    DATA_GRANDMASTER_VORPIL         = 2,
    DATA_MURMUR                     = 3
};

enum slPersistentData
{
    TYPE_RITUALISTS             = 0
};

enum slNPCandGO
{
    NPC_CABAL_RITUALIST         = 18794,
    NPC_HELLMAW                 = 18731,
    NPC_CABAL_SUMMONER          = 18634,
    NPC_CABAL_SPELLBINDER       = 18639,

    GO_REFECTORY_DOOR           = 183296,                     //door opened when blackheart the inciter dies
    GO_SCREAMING_HALL_DOOR      = 183295                      //door opened when grandmaster vorpil dies
};

uint32 constexpr EncounterCount = 4;
uint32 constexpr PersistentDataCount = 1;

// Corridor Cabal Summoner/Spellbinder reinforcements, each an endless-respawn
// feed hung off a trash group's Cabal Executioner formation leader. They stop
// respawning once Murmur is dead so groups skipped en route to him don't keep
// feeding forever. Spawn ids are guids from the creature spawn table.
ObjectGuid::LowType constexpr MurmurReinforcementSpawnIds[] = { 146225, 146226, 146227, 146228, 146229 };

template <class AI, class T>
inline AI* GetShadowLabyrinthAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ShadowLabyrinthScriptName);
}

#define RegisterShadowLabyrinthCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetShadowLabyrinthAI)

#endif
