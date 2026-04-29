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

#ifndef DEF_KARAZHAN_H
#define DEF_KARAZHAN_H

#include "CreatureAIImpl.h"

#define KarazhanScriptName "instance_karazhan"
#define DataHeader "KZ"

uint32 const EncounterCount = 12;

enum KZDataTypes
{
    DATA_ATTUMEN                    = 0,
    DATA_MOROES                     = 1,
    DATA_MAIDEN                     = 2,
    DATA_OPTIONAL_BOSS              = 3,
    DATA_OPERA_PERFORMANCE          = 4,
    DATA_CURATOR                    = 5,
    DATA_ARAN                       = 6,
    DATA_TERESTIAN                  = 7,
    DATA_NETHERSPITE                = 8,
    DATA_CHESS_EVENT                = 9,
    DATA_MALCHEZAAR                 = 10,
    DATA_NIGHTBANE                  = 11,
    DATA_SERVANT_QUARTERS           = 12,
    DATA_OPERA_OZ_DEATHCOUNT        = 13,
    DATA_KILREK                     = 14,

    MAX_ENCOUNTERS                  = 15,

    DATA_GO_CURTAINS                = 18,
    DATA_GO_STAGEDOORLEFT           = 19,
    DATA_GO_STAGEDOORRIGHT          = 20,
    DATA_GO_LIBRARY_DOOR            = 21,
    DATA_GO_MASSIVE_DOOR            = 22,
    DATA_GO_GAME_DOOR               = 24,
    DATA_GO_GAME_EXIT_DOOR          = 25,
    DATA_IMAGE_OF_MEDIVH            = 26,
    DATA_GO_SIDE_ENTRANCE_DOOR      = 29,
    DATA_PRINCE                     = 30,
    DATA_SPAWN_OPERA_DECORATIONS    = 31,
    DATA_MIDNIGHT                   = 32,

    // Chess Event
    CHESS_EVENT_TEAM                = 33,
    DATA_CHESS_REINIT_PIECES        = 34,
    DATA_CHESS_GAME_PHASE           = 35,
    DATA_ECHO_OF_MEDIVH             = 36,
    DATA_DUST_COVERED_CHEST         = 37,

    // Specific Opera Data
    DATA_DOROTHEE                   = 38,
    DATA_ROMULO                     = 39,
    DATA_JULIANNE                   = 40,

    DATA_ROAR                       = 41,
    DATA_STRAWMAN                   = 42,
    DATA_TINHEAD                    = 43,
    DATA_TITO                       = 44,

    DATA_MIRKBLOOD                  = 45
};

enum KZOperaEvents
{
    EVENT_OZ    = 1,
    EVENT_HOOD  = 2,
    EVENT_RAJ   = 3
};

enum KZCreatures
{
    NPC_HYAKISS_THE_LURKER              = 16179,
    NPC_ROKAD_THE_RAVAGER               = 16181,
    NPC_SHADIKITH_THE_GLIDER            = 16180,
    NPC_TERESTIAN_ILLHOOF               = 15688,
    NPC_MOROES                          = 15687,
    NPC_ATTUMEN_THE_HUNTSMAN            = 15550,
    NPC_ATTUMEN_THE_HUNTSMAN_MOUNTED    = 16152,
    NPC_MIDNIGHT                        = 16151,
    NPC_NIGHTBANE                       = 17225,
    NPC_SHADE_OF_ARAN                   = 16524,

    // Trash
    NPC_COLDMIST_WIDOW                  = 16171,
    NPC_COLDMIST_STALKER                = 16170,
    NPC_SHADOWBAT                       = 16173,
    NPC_VAMPIRIC_SHADOWBAT              = 16175,
    NPC_GREATER_SHADOWBAT               = 16174,
    NPC_PHASE_HOUND                     = 16178,
    NPC_DREADBEAST                      = 16177,
    NPC_SHADOWBEAST                     = 16176,
    NPC_KILREK                          = 17229,
    NPC_RELAY                           = 17645,
    NPC_BARNES                          = 16812,
    NPC_DOROTHEE                        = 17535,
    NPC_TITO                            = 17548,
    NPC_ROMULO                          = 17533,
    NPC_JULIANNE                        = 17534,
    NPC_ROAR                            = 17546,
    NPC_STRAWMAN                        = 17543,
    NPC_TINHEAD                         = 17547,
    NPC_FIENDISH_IMP                    = 17267,

    // Chess Event
    NPC_ECHO_OF_MEDIVH                  = 16816,
    NPC_PAWN_H                          = 17469,
    NPC_PAWN_A                          = 17211,
    NPC_KNIGHT_H                        = 21748,
    NPC_KNIGHT_A                        = 21664,
    NPC_QUEEN_H                         = 21750,
    NPC_QUEEN_A                         = 21683,
    NPC_BISHOP_H                        = 21747,
    NPC_BISHOP_A                        = 21682,
    NPC_ROOK_H                          = 21726,
    NPC_ROOK_A                          = 21160,
    NPC_KING_H                          = 21752,
    NPC_KING_A                          = 21684,
    NPC_CHESS_EVENT_MEDIVH_CHEAT_FIRES  = 22521,

    // Malchezaar Helpers
    NPC_INFERNAL_TARGET                 = 17644,
    NPC_INFERNAL_RELAY                  = 17645,

    NPC_TENRIS_MIRKBLOOD                = 28194

};

enum KZGameObjectIds
{
    GO_STAGE_CURTAIN                = 183932,
    GO_STAGE_DOOR_LEFT              = 184278,
    GO_STAGE_DOOR_RIGHT             = 184279,
    GO_PRIVATE_LIBRARY_DOOR         = 184517,
    GO_MASSIVE_DOOR                 = 185521,
    GO_GAMESMAN_HALL_DOOR           = 184276,
    GO_GAMESMAN_HALL_EXIT_DOOR      = 184277,
    GO_NETHERSPACE_DOOR             = 185134,
    GO_MASTERS_TERRACE_DOOR         = 184274,
    GO_MASTERS_TERRACE_DOOR2        = 184280,
    GO_SIDE_ENTRANCE_DOOR           = 184275,
    GO_DUST_COVERED_CHEST           = 185119,

     // Opera event stage decoration
    GO_OZ_BACKDROP                  = 183442,
    GO_OZ_HAY                       = 183496,
    GO_HOOD_BACKDROP                = 183491,
    GO_HOOD_TREE                    = 183492,
    GO_HOOD_HOUSE                   = 183493,
    GO_RAJ_BACKDROP                 = 183443,
    GO_RAJ_MOON                     = 183494,
    GO_RAJ_BALCONY                  = 183495
};

enum KZMisc
{
    OPTIONAL_BOSS_REQUIRED_DEATH_COUNT      = 50,

    ACTION_CHESS_PIECE_RESET_ORIENTATION    = 1
};

enum KarazhanSpells
{
    SPELL_RATTLED           = 32437,
    SPELL_OVERLOAD          = 29766,
    SPELL_BLINK             = 29884,

    // Chess Event
    SPELL_GAME_IN_SESSION   = 39331,
    SPELL_HAND_OF_MEDIVH    = 39339, // 1st cheat: AOE spell burn cell under enemy chesspieces.
    SPELL_FURY_OF_MEDIVH    = 39383  // 2nd cheat: Berserk own chesspieces.
};

enum KarazhanChessGamePhase
{
    CHESS_PHASE_NOT_STARTED     = 0,
    CHESS_PHASE_PVE_WARMUP      = 1, // Medivh has been spoken too but king isn't controlled yet
    CHESS_PHASE_INPROGRESS_PVE  = 2,
    CHESS_PHASE_FAILED          = 3,
    CHESS_PHASE_PVE_FINISHED    = 4,
    CHESS_PHASE_PVP_WARMUP      = 5,
    CHESS_PHASE_INPROGRESS_PVP  = 6  // Get back to PVE_FINISHED after that
};

enum KarazhanChessGameFactions
{
    CHESS_FACTION_HORDE         = 1689,
    CHESS_FACTION_ALLIANCE      = 1690,
    CHESS_FACTION_BOTH          = 536
};

enum InstanceActions
{
    ACTION_SCHEDULE_RAJ_CHECK,

    ACTION_DO_RESURRECT = 4,
    ACTION_RESS_ROMULO  = 5,
};

template <class AI, class T>
inline AI* GetKarazhanAI(T* obj)
{
    return GetInstanceAI<AI>(obj, KarazhanScriptName);
}

#define RegisterKarazhanCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetKarazhanAI)

#endif
