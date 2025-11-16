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

#ifndef DEF_FORGE_OF_SOULS_H
#define DEF_FORGE_OF_SOULS_H

#include "CreatureAIImpl.h"
#include "GridNotifiers.h"

#define DataHeader "FOS"

#define ForgeOfSoulsScriptName "instance_forge_of_souls"

enum Data
{
    DATA_BRONJAHM,
    DATA_DEVOURER,
    MAX_ENCOUNTER,
};

enum Creatures
{
    NPC_BRONJAHM                                  = 36497,
    NPC_DEVOURER                                  = 36502,

    NPC_SYLVANAS_PART1                            = 37596,
    NPC_SYLVANAS_PART2                            = 38161,
    NPC_JAINA_PART1                               = 37597,
    NPC_JAINA_PART2                               = 38160,
    NPC_KALIRA                                    = 37583,
    NPC_ELANDRA                                   = 37774,
    NPC_LORALEN                                   = 37779,
    NPC_KORELN                                    = 37582,

    NPC_CHAMPION_1_HORDE                          = 37584,
    NPC_CHAMPION_2_HORDE                          = 37587,
    NPC_CHAMPION_3_HORDE                          = 37588,
    NPC_CHAMPION_1_ALLIANCE                       = 37496,
    NPC_CHAMPION_2_ALLIANCE                       = 37497,
};

// OUTRO:

struct outroPosition
{
    uint32 entry[2];
    Position startPosition;
    uint32 pathId;
};

#define PATH_BEGIN_VALUE 3000100

const outroPosition outroPositions[] =
{
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 5590.47f, 2427.79f, 705.935f, 0.802851f }, PATH_BEGIN_VALUE + 14 },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 5593.59f, 2428.34f, 705.935f, 0.977384f }, PATH_BEGIN_VALUE + 15 },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 5600.81f, 2429.31f, 705.935f, 0.890118f }, PATH_BEGIN_VALUE + 5 },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 5600.81f, 2421.12f, 705.935f, 0.890118f }, PATH_BEGIN_VALUE + 18 },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 5601.43f, 2426.53f, 705.935f, 0.890118f }, PATH_BEGIN_VALUE + 6 },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 5601.55f, 2418.36f, 705.935f, 1.15192f }, PATH_BEGIN_VALUE + 17 },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 5598, 2429.14f, 705.935f, 1.0472f }, PATH_BEGIN_VALUE + 4 },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 5594.04f, 2424.87f, 705.935f, 1.15192f }, PATH_BEGIN_VALUE + 16 },
    { { NPC_CHAMPION_1_ALLIANCE, NPC_CHAMPION_1_HORDE }, { 5597.89f, 2421.54f, 705.935f, 0.610865f }, PATH_BEGIN_VALUE + 19 },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_2_HORDE }, { 5598.57f, 2434.62f, 705.935f, 1.13446f }, PATH_BEGIN_VALUE + 2 },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_2_HORDE }, { 5585.46f, 2417.99f, 705.935f, 1.06465f }, PATH_BEGIN_VALUE + 12 },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_2_HORDE }, { 5605.81f, 2428.42f, 705.935f, 0.820305f }, PATH_BEGIN_VALUE + 3 },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_2_HORDE }, { 5591.61f, 2412.66f, 705.935f, 0.925025f }, PATH_BEGIN_VALUE + 11 },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_2_HORDE }, { 5593.9f, 2410.64f, 705.935f, 0.872665f }, PATH_BEGIN_VALUE + 10 },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_2_HORDE }, { 5586.76f, 2416.73f, 705.935f, 0.942478f }, PATH_BEGIN_VALUE + 13 },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_3_HORDE }, { 5592.23f, 2419.14f, 705.935f, 0.855211f }, PATH_BEGIN_VALUE + 8 },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_3_HORDE }, { 5594.61f, 2416.87f, 705.935f, 0.907571f }, PATH_BEGIN_VALUE + 7 },
    { { NPC_CHAMPION_2_ALLIANCE, NPC_CHAMPION_3_HORDE }, { 5589.77f, 2421.03f, 705.935f, 0.855211f }, PATH_BEGIN_VALUE + 9 },

    { { NPC_KORELN, NPC_LORALEN }, { 5602.58f, 2435.95f, 705.935f, 0.959931f }, PATH_BEGIN_VALUE + 0 },
    { { NPC_ELANDRA, NPC_KALIRA }, { 5606.13f, 2433.16f, 705.935f, 0.785398f }, PATH_BEGIN_VALUE + 1 },

    { { 0, 0 }, { 0.0f, 0.0f, 0.0f, 0.0f }, 0 }
};

const Position outroSpawnPoint = {5618.139f, 2451.873f, 705.854f, 0.0f};

template <class AI, class T>
inline AI* GetForgeOfSoulsAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ForgeOfSoulsScriptName);
}

#endif
