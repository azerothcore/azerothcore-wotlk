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
    DATA_WINTERCHILL            = 1,
    DATA_ANETHERON              = 2,
    DATA_KAZROGAL               = 3,
    DATA_AZGALOR                = 4,
    DATA_ARCHIMONDE             = 5,

    DATA_ALLIANCE_RETREAT       = 11,
    DATA_HORDE_RETREAT          = 12,

    DATA_JAINA                  = 13,
    DATA_THRALL                 = 14,
    DATA_TYRANDE                = 15,

    DATA_SPAWN_WAVES            = 20,
    DATA_SPAWN_INFERNALS        = 21,
    DATA_RESET_ALLIANCE         = 22,
    DATA_RESET_HORDE            = 23,
    DATA_RESET_NIGHT_ELF        = 24,
    DATA_RESET_WAVES            = 25,
    DATA_WAVE_STATUS            = 26,
    DATA_BOSS_WAVE              = 27
};

enum HyjalWorldStateIds
{
    WORLD_STATE_WAVES           = 2842,
    WORLD_STATE_ENEMY           = 2453,
    WORLD_STATE_ENEMYCOUNT      = 2454
};

enum HyjalCreaturesIds
{
    // Trash Mobs summoned in waves
    NPC_GHOUL                   = 17895,
    NPC_CRYPT                   = 17897,
    NPC_ABOMI                   = 17898,
    NPC_NECRO                   = 17899,
    NPC_BANSH                   = 17905,
    NPC_GARGO                   = 17906,
    NPC_FROST                   = 17907,
    NPC_INFER                   = 17908,
    NPC_STALK                   = 17916,
    NPC_BUILD                   = 18304,    // Serverside creature? Not found in CreateObject packets, but seen as targets

    // Summoned necromancer mobs
    NPC_SKELETON_INVADER        = 17902,
    NPC_SKELETON_MAGE           = 17903,

    // Alliance Base
    NPC_JAINA                   = 17772,
    NPC_ALLIANCE_PEASANT        = 17931,
    NPC_ALLIANCE_KNIGHT         = 17920,
    NPC_ALLIANCE_FOOTMAN        = 17919,
    NPC_ALLIANCE_RIFLEMAN       = 17921,
    NPC_ALLIANCE_PRIEST         = 17928,
    NPC_ALLIANCE_SORCERESS      = 17922,
    NPC_GUARDIAN_ELEMENTAL      = 18001,

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
    NPC_DIRE_WOLF               = 17854,

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
    NPC_WORLD_TRIGGER_TINY      = 21987,

    // Boss summons
    NPC_TOWERING_INFERNAL       = 17818,
    NPC_LESSER_DOOMGUARD        = 17864
};

enum HyjalGameobjectIds
{
    GO_HORDE_ENCAMPMENT_PORTAL  = 182060,
    GO_NIGHT_ELF_VILLAGE_PORTAL = 182061,
    GO_ANCIENT_GEM              = 185557,
    GO_FLAME                    = 182260
};

enum HyjalMisc
{
    MAX_WAVES_STANDARD          = 9,
    MAX_WAVES_RETREAT           = 3,
    MAX_WAVES_NIGHT_ELF         = 1,
    START_WAVE_WINTERCHILL      = 0,
    START_WAVE_ANETHERON        = 9,
    START_WAVE_KAZROGAL         = 18,
    START_WAVE_AZGALOR          = 27,
    START_WAVE_ALLIANCE_RETREAT = 36,
    START_WAVE_HORDE_RETREAT    = 39,
    START_WAVE_NIGHT_ELF        = 42,

    CONTEXT_GROUP_WAVES         = 1,

    AREA_NORDRASSIL             = 3710,

    SPELL_ETERNAL_SILENCE       = 42201
};

enum HyjalPaths
{
    ALLIANCE_BASE_CHARGE_1      = 177721,
    ALLIANCE_BASE_CHARGE_2      = 177722,
    ALLIANCE_BASE_CHARGE_3      = 177723,
    ALLIANCE_BASE_PATROL_1      = 177724,
    ALLIANCE_BASE_PATROL_2      = 177725,
    ALLIANCE_BASE_PATROL_3      = 177726,
    JAINA_RETREAT_PATH          = 177727,

    HORDE_BASE_CHARGE_1         = 178521,
    HORDE_BASE_CHARGE_2         = 178522,
    HORDE_BASE_CHARGE_3         = 178523,
    HORDE_BASE_PATROL_1         = 178524,
    HORDE_BASE_PATROL_2         = 178525,
    HORDE_BASE_PATROL_3         = 178526,

    NIGHT_ELF_BASE_CHARGE_1     = 179481,
    NIGHT_ELF_BASE_CHARGE_2     = 179482,
    NIGHT_ELF_BASE_CHARGE_3     = 179483,

    GARGOYLE_PATH_TROLL_CAMP_1  = 179061,
    GARGOYLE_PATH_TROLL_CAMP_2  = 179062,
    GARGOYLE_PATH_TROLL_CAMP_3  = 179063,
    GARGOYLE_PATH_FORTRESS_1    = 179064,
    GARGOYLE_PATH_FORTRESS_2    = 179065,
    GARGOYLE_PATH_FORTRESS_3    = 179066,

    FROST_WYRM_TROLL_CAMP       = 179071,
    FROST_WYRM_FORTRESS         = 179072,
    FROST_WYRM_FORTRESS_PATROL  = 179073,

    HORDE_BOSS_PATH             = 178527
};

enum BossActions
{
    ACTION_BECOME_ACTIVE_AND_CHANNEL = 0
};

template <class AI, class T>
inline AI* GetHyjalAI(T* obj)
{
    return GetInstanceAI<AI>(obj, HyjalScriptName);
}

#define RegisterHyjalAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetHyjalAI)

#endif
