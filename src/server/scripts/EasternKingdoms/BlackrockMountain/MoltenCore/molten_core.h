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

#ifndef DEF_MOLTEN_CORE_H
#define DEF_MOLTEN_CORE_H

#include "CreatureAIImpl.h"
#include "Object.h"

#define DataHeader "MC"

constexpr auto MCScriptName = "instance_molten_core";

constexpr uint32 MAX_ENCOUNTER = 10;

enum MCData
{
    DATA_LUCIFRON                   = 0,
    DATA_MAGMADAR                   = 1,
    DATA_GEHENNAS                   = 2,
    DATA_GARR                       = 3,
    DATA_SHAZZRAH                   = 4,
    DATA_GEDDON                     = 5,
    DATA_SULFURON                   = 6,
    DATA_GOLEMAGG                   = 7,
    DATA_MAJORDOMO_EXECUTUS         = 8,
    DATA_RAGNAROS                   = 9,

    // Other data
    DATA_LAVA_STEAM                 = 10,
    DATA_LAVA_SPLASH                = 11,
};

enum MCActions
{
    ACTION_START_RAGNAROS_INTRO         = -1,
    ACTION_FINISH_RAGNAROS_INTRO        = -2,
    ACTION_RESET_GOLEMAGG_ENCOUNTER     = -3,   // Used when ragers are pulled far away
    ACTION_PREPARE_MAJORDOMO_RAGNA      = -4,
};

enum MCCreatures
{
    NPC_MAGMADAR                    = 11982,
    NPC_SHAZZRAH                    = 12264,
    NPC_BARON_GEDDON                = 12056,
    NPC_RAGNAROS                    = 11502,
    NPC_FLAMEWAKER_HEALER           = 11663,
    NPC_FLAMEWAKER_ELITE            = 11664,
    NPC_CORE_HOUND                  = 11671,

    // Garr
    NPC_GARR                        = 12057,
    NPC_FIRESWORN                   = 12099,

    // Gehennas
    NPC_GEHENNAS                    = 12259,
    NPC_FLAMEWALKER                 = 11661,

    // Golemagg
    NPC_GOLEMAGG_THE_INCINERATOR    = 11988,
    NPC_CORE_RAGER                  = 11672,

    // Lucifron
    NPC_LUCIFRON                    = 12118,
    NPC_FLAMEWALKER_PROTECTOR       = 12119,

    // Sulfuron
    NPC_SULFURON_HARBINGER          = 12098,
    NPC_FLAMEWALKER_PRIEST          = 11662,

    // Majordomo
    NPC_MAJORDOMO_EXECUTUS          = 12018,
    NPC_FLAMEWALKER_HEALER          = 11663,
    NPC_FLAMEWALKER_ELITE           = 11664,
};

enum MCGameObjects
{
    GO_CACHE_OF_THE_FIRELORD        = 179703,
    GO_CIRCLE_SULFURON              = 178187,
    GO_CIRCLE_GEDDON                = 178188,
    GO_CIRCLE_SHAZZRAH              = 178189,
    GO_CIRCLE_GOLEMAGG              = 178190,
    GO_CIRCLE_GARR                  = 178191,
    GO_CIRCLE_MAGMADAR              = 178192,
    GO_CIRCLE_GEHENNAS              = 178193,

    GO_RUNE_KRESS                   = 176956,   // Magmadar
    GO_RUNE_MOHN                    = 176957,   // Gehennas
    GO_RUNE_BLAZ                    = 176955,   // Garr
    GO_RUNE_MAZJ                    = 176953,   // Shazzrah
    GO_RUNE_ZETH                    = 176952,   // Geddon
    GO_RUNE_THERI                   = 176954,   // Golemagg
    GO_RUNE_KORO                    = 176951,   // Sulfuron

    // Ragnaros event related
    GO_LAVA_STEAM                   = 178107,
    GO_LAVA_SPLASH                  = 178108,
    GO_LAVA_BURST                   = 178088,
};

enum MCSpells
{
    SPELL_CORE_RAGER_QUIET_SUICIDE  = 3617,     // Server side
};

extern Position const MajordomoRagnaros;        // Teleport location to Ragnaros summons area
extern Position const MajordomoSummonPos;       // Majordomo summon position (battle)

template <class AI, class T>
inline AI* GetMoltenCoreAI(T* obj)
{
    return GetInstanceAI<AI>(obj, MCScriptName);
}

#endif
