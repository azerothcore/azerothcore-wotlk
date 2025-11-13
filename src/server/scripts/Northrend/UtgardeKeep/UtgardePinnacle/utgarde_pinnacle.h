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

#ifndef DEF_PINNACLE_H
#define DEF_PINNACLE_H

#include "CreatureAIImpl.h"

#define DataHeader "UP"

#define UtgardePinnacleScriptName "instance_utgarde_pinnacle"

enum Data
{
    DATA_SVALA_SORROWGRAVE              = 0,
    DATA_GORTOK_PALEHOOF                = 1,
    DATA_SKADI_THE_RUTHLESS             = 2,
    DATA_KING_YMIRON                    = 3,
    DATA_GRAUF                          = 4,

    DATA_NPC_FRENZIED_WORGEN            = 10,
    DATA_NPC_RAVENOUS_FURBOLG           = 11,
    DATA_NPC_MASSIVE_JORMUNGAR          = 12,
    DATA_NPC_FEROCIOUS_RHINO            = 13,

    YMIRON_DOOR                         = 20,
    STATIS_GENERATOR                    = 21,

    SKADI_HITS                          = 30,
    SKADI_IN_RANGE                      = 31,
    SKADI_DOOR                          = 32,

    MAX_ENCOUNTERS                      = 4,

    DATA_SVALA_ACHIEVEMENT              = 50,
    DATA_SKADI_ACHIEVEMENT              = 51,
    DATA_YMIRON_ACHIEVEMENT             = 52,
};

enum Objects
{
    // GOs
    GO_SKADI_THE_RUTHLESS_DOOR          = 192173,
    GO_KING_YMIRON_DOOR                 = 192174,
    GO_GORK_PALEHOOF_SPHERE             = 188593,
    GO_SVALA_MIRROR                     = 191745,

    // NPCs
    NPC_SCOURGE_HULK                    = 26555,
    NPC_DRAGONFLAYER_SPECTATOR          = 26667,
    NPC_SVALA_SORROWGRAVE               = 26668,
    NPC_GORTOK_PALEHOOF                 = 26687,
    NPC_SKADI_THE_RUTHLESS              = 26693,
    NPC_KING_YMIRON                     = 26861,
    NPC_FRENZIED_WORGEN                 = 26683,
    NPC_RAVENOUS_FURBOLG                = 26684,
    NPC_MASSIVE_JORMUNGAR               = 26685,
    NPC_FEROCIOUS_RHINO                 = 26686,
    NPC_GARUF                           = 26893,
};

template <class AI, class T>
inline AI* GetUtgardePinnacleAI(T* obj)
{
    return GetInstanceAI<AI>(obj, UtgardePinnacleScriptName);
}

#endif
