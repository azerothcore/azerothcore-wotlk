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

#ifndef RUBY_SANCTUM_H_
#define RUBY_SANCTUM_H_

#include "CreatureAIImpl.h"

#define DataHeader "RS"

#define RubySanctumScriptName "instance_ruby_sanctum"

enum DataTypes
{
    // Encounter States/Boss GUIDs
    DATA_BALTHARUS_THE_WARBORN              = 0,
    DATA_GENERAL_ZARITHRIAN                 = 1,
    DATA_SAVIANA_RAGEFIRE                   = 2,
    DATA_HALION_INTRO1                      = 3,
    DATA_HALION_INTRO2                      = 4,
    DATA_HALION_INTRO_DONE                  = 5,
    DATA_HALION                             = 6,

    MAX_ENCOUNTERS                          = 7,

    // Etc
    DATA_ZARITHRIAN_SPAWN_STALKER_1         = 8,
    DATA_ZARITHRIAN_SPAWN_STALKER_2         = 9
};

enum SharedActions
{
    ACTION_INTRO_HALION                     = -4014601,
};

enum CreaturesIds
{
    // Baltharus the Warborn
    NPC_BALTHARUS_THE_WARBORN               = 39751,
    NPC_BALTHARUS_THE_WARBORN_CLONE         = 39899,
    NPC_XERESTRASZA                         = 40429,

    // General Zarithrian
    NPC_GENERAL_ZARITHRIAN                  = 39746,
    NPC_ONYX_FLAMECALLER                    = 39814,
    NPC_ZARITHRIAN_SPAWN_STALKER            = 39794,

    // Saviana Ragefire
    NPC_SAVIANA_RAGEFIRE                    = 39747,

    // Halion
    NPC_HALION                              = 39863,
    NPC_TWILIGHT_HALION                     = 40142,
    NPC_HALION_CONTROLLER                   = 40146,
    NPC_LIVING_INFERNO                      = 40681,
    NPC_LIVING_EMBER                        = 40683,
    NPC_ORB_CARRIER                         = 40081,
    NPC_METEOR_STRIKE_MARK                  = 40029,
    NPC_METEOR_STRIKE_NORTH                 = 40041,
    NPC_METEOR_STRIKE_EAST                  = 40042,
    NPC_METEOR_STRIKE_WEST                  = 40043,
    NPC_METEOR_STRIKE_SOUTH                 = 40044,
    NPC_METEOR_STRIKE_FLAME                 = 40055,
    NPC_COMBUSTION                          = 40001,
    NPC_CONSUMPTION                         = 40135,
    NPC_COMBAT_STALKER                      = 40151 // Seen in sniffs but not used, so no wonder.
};

enum GameObjectsIds
{
    GO_HALION_PORTAL_1                      = 202794,
    GO_HALION_PORTAL_2                      = 202795,
    GO_HALION_PORTAL_EXIT                   = 202796,
    GO_FIRE_FIELD                           = 203005,
    GO_FLAME_WALLS                          = 203006,
    GO_FLAME_RING                           = 203007,
    GO_TWILIGHT_FLAME_RING                  = 203624,
    GO_BURNING_TREE_1                       = 203034,
    GO_BURNING_TREE_2                       = 203035,
    GO_BURNING_TREE_3                       = 203036,
    GO_BURNING_TREE_4                       = 203037
};

enum InstanceSpell
{
    SPELL_BERSERK                       = 26662,
    SPELL_RALLY                         = 75416
};

template <class AI, class T>
inline AI* GetRubySanctumAI(T* obj)
{
    return GetInstanceAI<AI>(obj, RubySanctumScriptName);
}

#endif // RUBY_SANCTUM_H_
