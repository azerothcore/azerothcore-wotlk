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

#ifndef DEF_GUNDRAK_H
#define DEF_GUNDRAK_H

#include "CreatureAIImpl.h"

#define DataHeader "GD"

#define GundrakScriptName "instance_gundrak"

enum Data
{
    DATA_SLAD_RAN                       = 0,
    DATA_MOORABI                        = 1,
    DATA_DRAKKARI_COLOSSUS              = 2,
    DATA_GAL_DARAH                      = 3,
    DATA_ECK_THE_FEROCIOUS              = 4,
    MAX_ENCOUNTERS                      = 5
};

enum Creatures
{
    NPC_RUINS_DWELLER                   = 29920,
    NPC_ECK_THE_FEROCIOUS               = 29932
};

enum GDTexts
{
    EMOTE_SUMMON_ECK                    = 0
};

enum GameObjects
{
    GO_ALTAR_OF_SLAD_RAN                = 192518,
    GO_STATUE_OF_SLAD_RAN               = 192564,
    GO_ALTAR_OF_DRAKKARI                = 192520,
    GO_STATUE_OF_DRAKKARI               = 192567,
    GO_ALTAR_OF_MOORABI                 = 192519,
    GO_STATUE_OF_MOORABI                = 192565,
    GO_STATUE_OF_GAL_DARAH              = 192566,

    GO_GUNDRAK_BRIDGE                   = 193188,
    GO_GUNDRAK_COLLISION                = 192633,

    GO_ECK_DOORS                        = 192632,
    GO_ECK_UNDERWATER_GATE              = 192569,
    GO_GAL_DARAH_DOORS0                 = 192568,
    GO_GAL_DARAH_DOORS1                 = 193208,
    GO_GAL_DARAH_DOORS2                 = 193209
};

template <class AI, class T>
inline AI* GetGundrakAI(T* obj)
{
    return GetInstanceAI<AI>(obj, GundrakScriptName);
}

#define RegisterGundrakCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetGundrakAI)

#endif
