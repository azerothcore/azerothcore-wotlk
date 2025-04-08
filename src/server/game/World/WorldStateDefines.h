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

#ifndef WORLD_STATE_DEFINES_H
#define WORLD_STATE_DEFINES_H

enum WorldStateIDs
{
    // Scourge Invasion
    WORLD_STATE_SCOURGE_INVASION_VICTORIES = 2219,

    // Active Invasion Indicators
    WORLD_STATE_SCOURGE_INVASION_WINTERSPRING = 2259,
    WORLD_STATE_SCOURGE_INVASION_AZSHARA = 2260,
    WORLD_STATE_SCOURGE_INVASION_BLASTED_LANDS = 2261,
    WORLD_STATE_SCOURGE_INVASION_BURNING_STEPPES = 2262,
    WORLD_STATE_SCOURGE_INVASION_TANARIS = 2263,
    WORLD_STATE_SCOURGE_INVASION_EASTERN_PLAGUELANDS = 2264,

    // Active Necropoli
    WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_AZSHARA = 2279,
    WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_BLASTED_LANDS = 2280,
    WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_BURNING_STEPPES = 2281,
    WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_EASTERN_PLAGUELANDS = 2282,
    WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_TANARIS = 2283,
    WORLD_STATE_SCOURGE_INVASION_NECROPOLIS_WINTERSPRING = 2284,

    // Sun's Reach Reclamation
    WORLD_STATE_QUEL_DANAS_MUSIC = 3426,
    WORLD_STATE_QUEL_DANAS_HARBOR = 3238,
    WORLD_STATE_QUEL_DANAS_ALCHEMY_LAB = 3223,
    WORLD_STATE_QUEL_DANAS_ARMORY = 3233,
    WORLD_STATE_QUEL_DANAS_SANCTUM = 3244,
    WORLD_STATE_QUEL_DANAS_PORTAL = 3269,
    WORLD_STATE_QUEL_DANAS_ANVIL = 3228,
    WORLD_STATE_QUEL_DANAS_MONUMENT = 3275,

    // Sunwell Gate
    WORLD_STATE_AGAMATH_THE_FIRST_GATE_HEALTH = 3253, // guessed, potentially wrong
    WORLD_STATE_ROHENDOR_THE_SECOND_GATE_HEALTH = 3255,
    WORLD_STATE_ARCHONISUS_THE_FINAL_GATE_HEALTH = 3257,
};

#endif
