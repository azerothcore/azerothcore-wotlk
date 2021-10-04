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

#include "Player.h"

#ifndef DEF_MOLTEN_CORE_H
#define DEF_MOLTEN_CORE_H

#include "CreatureAIImpl.h"

#define MCScriptName "instance_molten_core"

enum Encounters
{
    BOSS_LUCIFRON                   = 0,
    BOSS_MAGMADAR                   = 1,
    BOSS_GEHENNAS                   = 2,
    BOSS_GARR                       = 3,
    BOSS_SHAZZRAH                   = 4,
    BOSS_BARON_GEDDON               = 5,
    BOSS_SULFURON_HARBINGER         = 6,
    BOSS_GOLEMAGG_THE_INCINERATOR   = 7,
    BOSS_MAJORDOMO_EXECUTUS         = 8,
    BOSS_RAGNAROS                   = 9,
    MAX_ENCOUNTER,
};

enum Actions
{
    ACTION_START_RAGNAROS       = 0,
    ACTION_START_RAGNAROS_ALT   = 1,
};

Position const RagnarosTelePos   = {829.159f, -815.773f, -228.972f, 5.30500f};
Position const RagnarosSummonPos = {838.510f, -829.840f, -232.000f, 2.00000f};

enum Creatures
{
    NPC_LUCIFRON                    = 12118,
    NPC_MAGMADAR                    = 11982,
    NPC_GEHENNAS                    = 12259,
    NPC_GARR                        = 12057,
    NPC_SHAZZRAH                    = 12264,
    NPC_BARON_GEDDON                = 12056,
    NPC_SULFURON_HARBINGER          = 12098,
    NPC_GOLEMAGG_THE_INCINERATOR    = 11988,
    NPC_MAJORDOMO_EXECUTUS          = 12018,
    NPC_RAGNAROS                    = 11502,
    NPC_FLAMEWAKER_HEALER           = 11663,
    NPC_FLAMEWAKER_ELITE            = 11664,
    NPC_CORE_RAGER                  = 11672,
    NPC_CORE_HOUND                  = 11671,
};

enum GameObjects
{
    GO_CACHE_OF_THE_FIRELORD        = 179703,
    GO_CIRCLE_SULFURON              = 178187,
    GO_CIRCLE_BARON                 = 178188,
    GO_CIRCLE_SHAZZRAH              = 178189,
    GO_CIRCLE_GOLEMAGG              = 178190,
    GO_CIRCLE_GARR                  = 178191,
    GO_CIRCLE_MAGMADAR              = 178192,
    GO_CIRCLE_GEHENNAS              = 178193,
};

enum Data
{
    DATA_RAGNAROS_ADDS  = 0,
};

template <class AI, class T>
inline AI* GetMoltenCoreAI(T* obj)
{
    return GetInstanceAI<AI>(obj, MCScriptName);
}

#endif
