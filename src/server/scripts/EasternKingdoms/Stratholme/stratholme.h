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

#ifndef DEF_STRATHOLME_H
#define DEF_STRATHOLME_H

#define DataHeader "STR"
#define StratholmeScriptName "instance_stratholme"

enum DataTypes
{
    TYPE_BARON_RUN                      = 0,
    TYPE_ZIGGURAT1                      = 1,
    TYPE_ZIGGURAT2                      = 2,
    TYPE_ZIGGURAT3                      = 3,
    TYPE_BARON_FIGHT                    = 4,
    TYPE_MALLOW                         = 5,
    TYPE_BARTHILAS_RUN                  = 6,

    DATA_BARON_RUN_NONE                 = 0,
    DATA_BARON_RUN_GATE                 = 1,
    DATA_JARIEN                         = 2,
    DATA_SOTHOS                         = 3
};

enum CreatureIds
{
    NPC_BARTHILAS                       = 10435,
    NPC_BARON_RIVENDARE                 = 10440,
    NPC_BILE_SPEWER                     = 10416,
    NPC_VENOM_BELCHER                   = 10417,
    NPC_RAMSTEIN_THE_GORGER             = 10439,
    NPC_MINDLESS_UNDEAD                 = 11030,
    NPC_BLACK_GUARD                     = 10394,
    NPC_YSIDA                           = 16031,
    NPC_PLAGUED_RAT                     = 10441,
    NPC_PLAGUED_INSECT                  = 10461,
    NPC_PLAGUED_MAGGOT                  = 10536,
    NPC_JARIEN                          = 16101,
    NPC_SOTHOS                          = 16102,
    NPC_SPIRIT_OF_JARIEN                = 16103,
    NPC_SPIRIT_OF_SOTHOS                = 16104
};

enum GameobjectIds
{
    GO_CRUSADER_SQUARE_DOOR             = 175967,
    GO_HOARD_DOOR                       = 175968,
    GO_HALL_OF_HIGH_COMMAND             = 176194,
    GO_GAUNTLET_DOOR_1                  = 175357,
    GO_GAUNTLET_DOOR_2                  = 175356,
    GO_ZIGGURAT_DOORS1                  = 175380,  // baroness
    GO_ZIGGURAT_DOORS2                  = 175379,  // nerub'enkan
    GO_ZIGGURAT_DOORS3                  = 175381,  // maleki
    GO_ZIGGURAT_DOORS4                  = 175405,  // rammstein
    GO_ZIGGURAT_DOORS5                  = 175796,  // baron
    GO_GAUNTLET_GATE                    = 175374,
    GO_SLAUGTHER_GATE                   = 175373,
    GO_SLAUGHTER_GATE_SIDE              = 175358,
    GO_EXIT_GATE                        = 176424,
    GO_PORT_TRAP_GATE_1                 = 175351,  // Portcullis used in the gate traps (rats trap)
    GO_PORT_TRAP_GATE_2                 = 175350,  // Gate trap scarlet side
    GO_PORT_TRAP_GATE_3                 = 175355,  // Gate trap undead side
    GO_PORT_TRAP_GATE_4                 = 175354,
    GO_JARIEN_AND_SOTHOS_HEIRLOOMS      = 181083
};

enum MiscIds
{
    SAY_BLACK_GUARD_INIT                = 0,
    SAY_BARON_INIT_YELL                 = 0,
    SAY_BRAON_ZIGGURAT_FALL_YELL        = 1,
    SAY_BARON_10M                       = 2,
    SAY_BARON_5M                        = 3,
    SAY_BARON_0M                        = 4,
    SAY_BRAON_SUMMON_RAMSTEIN           = 5,
    SAY_BARON_GUARD_DEAD                = 6,

    EVENT_BARON_TIME                    = 1,
    EVENT_SPAWN_MINDLESS                = 2,
    EVENT_FORCE_SLAUGHTER_EVENT         = 3,
    EVENT_SPAWN_BLACK_GUARD             = 4,
    EVENT_EXECUTE_PRISONER              = 5,
    EVENT_GATE1_TRAP                    = 6,
    EVENT_GATE1_DELAY                   = 7,
    EVENT_GATE1_CRITTER_DELAY           = 8,
    EVENT_GATE2_TRAP                    = 9,
    EVENT_GATE2_DELAY                   = 10,
    EVENT_GATE2_CRITTER_DELAY           = 11,

    SPELL_BARON_ULTIMATUM               = 27861
};

template <class AI, class T>
inline AI* GetStratholmeAI(T* obj)
{
    return GetInstanceAI<AI>(obj, StratholmeScriptName);
}

#define RegisterStratholmeCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetStratholmeAI)

#endif
