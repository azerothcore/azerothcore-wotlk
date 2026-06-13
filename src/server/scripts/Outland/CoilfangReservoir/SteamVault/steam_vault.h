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

#ifndef DEF_STEAM_VAULT_H
#define DEF_STEAM_VAULT_H

#include "CreatureAIImpl.h"

#define DataHeaders "SV"

uint32 const EncounterCount = 3;

#define SteamVaultScriptName "instance_steam_vault"

enum steamVault
{
    DATA_HYDROMANCER_THESPIA            = 0,
    DATA_MEKGINEER_STEAMRIGGER          = 1,
    DATA_WARLORD_KALITHRESH             = 2,
    MAX_ENCOUNTER                       = 3,

    DATA_ACCESS_PANEL_HYDROMANCER       = 4,
    DATA_ACCESS_PANEL_MEKGINEER         = 5,
    DATA_MAIN_CHAMBERS_DOOR             = 6,
    DATA_DOOR_CONTROLLER                = 7
};

enum steamVaultNPCGO
{
    GO_MAIN_CHAMBERS_DOOR               = 183049,
    GO_ACCESS_PANEL_HYDRO               = 184125,
    GO_ACCESS_PANEL_MEK                 = 184126,

    NPC_MEKGINEER_STEAMRIGGER           = 17796,
    NPC_WARLORD_KALITHRESH              = 17798,
    NPC_DOOR_CONTROLLER                 = 20926
};

enum Creatures
{
    NPC_NAGA_DISTILLER                  = 17954,
    NPC_THESPIA_WATER_ELEMENTAL         = 17917
};

template <class AI, class T>
inline AI* GetSteamVaultAI(T* obj)
{
    return GetInstanceAI<AI>(obj, SteamVaultScriptName);
}

#define RegisterSteamvaultCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetSteamVaultAI)

#endif
