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

#ifndef DEF_FIREWORK_SHOW_H
#define DEF_FIREWORK_SHOW_H

#include "Define.h"

enum eFireworks
{
    GO_FIREWORK_SHOW_TYPE_1_RED         = 180703,
    GO_FIREWORK_SHOW_TYPE_2_RED         = 180704,
    GO_FIREWORK_SHOW_TYPE_1_RED_BIG     = 180707,
    GO_FIREWORK_SHOW_TYPE_2_RED_BIG     = 180708,
    GO_FIREWORK_SHOW_TYPE_1_BLUE        = 180720,
    GO_FIREWORK_SHOW_TYPE_2_BLUE        = 180721,
    GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG    = 180722,
    GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG    = 180723,
    GO_FIREWORK_SHOW_TYPE_1_GREEN       = 180724,
    GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG   = 180725,
    GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG   = 180726,
    GO_FIREWORK_SHOW_TYPE_2_GREEN       = 180727,
    GO_FIREWORK_SHOW_TYPE_1_WHITE       = 180728,
    GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG   = 180729,
    GO_FIREWORK_SHOW_TYPE_2_WHITE       = 180730,
    GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG   = 180731,
    GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG  = 180733,
    GO_FIREWORK_SHOW_TYPE_1_YELLOW      = 180736,
    GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG  = 180737,
    GO_FIREWORK_SHOW_TYPE_2_YELLOW      = 180738,
    GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG  = 180739,
    GO_FIREWORK_SHOW_TYPE_2_PURPLE      = 180740,
    GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG  = 180741,

    GO_TOASTING_GOBLET                  = 180754,

    NPC_STORMWIND_REVELER               = 15694,
    NPC_THUNDER_BLUFF_REVELER           = 15719,
    NPC_BOOTY_BAY_REVELER               = 15723,
    NPC_DARNASSUS_REVELER               = 15905,
    NPC_IRONFORGE_REVELER               = 15906,
    NPC_UNDERCITY_REVELER               = 15907,
    NPC_ORGRIMMAR_REVELER               = 15908,
    NPC_SCRYER_REVELER                  = 23023,
    NPC_ALDOR_REVELER                   = 23024,
    NPC_DRAENEI_REVELER                 = 23039,
    NPC_BLOOD_ELF_REVELER               = 23045,

    COUNT_REVELER_ID                    = 2,
};

struct FireworkShowGameobject
{
    float x;
    float y;
    float z;
    float o;
    float rot0;
    float rot1;
    float rot2;
    float rot3;
};

struct FireworkShowScheduleEntry
{
    uint32 timestamp;
    uint32 gameobjectId;
    uint32 spawnIndex;
};

struct FireworkShow
{
    struct{
        FireworkShowScheduleEntry const * entries;
        uint32 const size;
    } schedule;
    struct {
        FireworkShowGameobject const * entries;
        uint32 const size;
    } spawns;
    uint32 const revelerId[COUNT_REVELER_ID];
};

#endif
