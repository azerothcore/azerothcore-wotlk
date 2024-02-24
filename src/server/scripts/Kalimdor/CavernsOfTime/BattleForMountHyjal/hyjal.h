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

#ifndef DEF_HYJAL_H
#define DEF_HYJAL_H

#include "CreatureAIImpl.h"
#include "GridNotifiers.h"

#define DataHeader "HY"

#define HyjalScriptName "instance_hyjal"

uint32 const EncounterCount     = 5;

enum HyjalBosses
{
    BOSS_ARCHIMONDE = 0,
};

enum DataTypes
{
    DATA_ANETHERON              = 1,
    DATA_ANETHERONEVENT         = 2,
    DATA_ARCHIMONDE             = 3,
    DATA_ARCHIMONDEEVENT        = 4,
    DATA_AZGALOR                = 5,
    DATA_AZGALOREVENT           = 6,
    DATA_JAINAPROUDMOORE        = 7,
    DATA_KAZROGAL               = 8,
    DATA_KAZROGALEVENT          = 9,
    DATA_RAGEWINTERCHILL        = 10,
    DATA_RAGEWINTERCHILLEVENT   = 11,
    DATA_THRALL                 = 12,
    DATA_TYRANDEWHISPERWIND     = 13,
    DATA_TRASH                  = 14,
    DATA_RESET_TRASH_COUNT      = 15,
    DATA_ALLIANCE_RETREAT       = 16,
    DATA_HORDE_RETREAT          = 17,
    DATA_RAIDDAMAGE             = 18,
    DATA_RESET_RAIDDAMAGE       = 19,
    TYPE_RETREAT                = 20
};

enum WorldStateIds
{
    WORLD_STATE_WAVES           = 2842,
    WORLD_STATE_ENEMY           = 2453,
    WORLD_STATE_ENEMYCOUNT      = 2454
};

enum CreaturesIds
{
    // Trash Mobs summoned in waves
    NPC_NECRO                   = 17899,
    NPC_ABOMI                   = 17898,
    NPC_GHOUL                   = 17895,
    NPC_BANSH                   = 17905,
    NPC_CRYPT                   = 17897,
    NPC_GARGO                   = 17906,
    NPC_FROST                   = 17907,
    NPC_INFER                   = 17908,
    NPC_STALK                   = 17916,
    NPC_BUILD                   = 18304,    // Serverside creature? Not found in CreateObject packets, but seen as targets

    // Alliance Base
    NPC_JAINA                   = 17772,
    NPC_ALLIANCE_PEASANT        = 17931,
    NPC_ALLIANCE_KNIGHT         = 17920,
    NPC_ALLIANCE_FOOTMAN        = 17919,
    NPC_ALLIANCE_RIFLEMAN       = 17921,
    NPC_ALLIANCE_PRIEST         = 17928,
    NPC_ALLIANCE_SORCERESS      = 17922,

    // Horde Base
    NPC_THRALL                  = 17852,
    NPC_HORDE_HEADHUNTER        = 17934,
    NPC_HORDE_SHAMAN            = 17936,
    NPC_HORDE_GRUNT             = 17932,
    NPC_HORDE_HEALING_WARD      = 18036,
    NPC_TAUREN_WARRIOR          = 17933,
    NPC_HORDE_WITCH_DOCTOR      = 17935,
    NPC_HORDE_PEON              = 17937,
    NPC_INFERNAL_RELAY          = 18242,
    NPC_INFERNAL_TARGET         = 21075,

    // Night Elf Base
    NPC_TYRANDE                 = 17948,
    NPC_DRUID_OF_THE_TALON      = 3794,
    NPC_DRUID_OF_THE_CLAW       = 3795,
    NPC_NELF_ANCIENT_PROT       = 18487,
    NPC_NELF_ANCIENT_OF_LORE    = 18486,
    NPC_NELF_ANCIENT_OF_WAR     = 18485,
    NPC_NELF_ARCHER             = 17943,
    NPC_NELF_HUNTRESS           = 17945,
    NPC_DRYAD                   = 17944,

    // Bosses
    NPC_WINTERCHILL             = 17767,
    NPC_ANETHERON               = 17808,
    NPC_KAZROGAL                = 17888,
    NPC_AZGALOR                 = 17842,
    NPC_ARCHIMONDE              = 17968,
    NPC_WORLD_TRIGGER_TINY      = 21987
};

enum GameobjectIds
{
    GO_HORDE_ENCAMPMENT_PORTAL  = 182060,
    GO_NIGHT_ELF_VILLAGE_PORTAL = 182061,
    GO_ANCIENT_GEM              = 185557,
    GO_FLAME                    = 182260
};

enum Misc
{
    MAX_STANDARD_WAVES = 9
};

template <class AI, class T>
inline AI* GetHyjalAI(T* obj)
{
    return GetInstanceAI<AI>(obj, HyjalScriptName);
}

#endif
