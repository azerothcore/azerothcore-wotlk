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

#ifndef DEF_STEAM_VAULT_H
#define DEF_STEAM_VAULT_H

#include "CreatureAIImpl.h"
#include "PassiveAI.h"

#define SteamVaultScriptName "instance_steam_vault"

enum steamVault
{
    TYPE_HYDROMANCER_THESPIA            = 0,
    TYPE_MEKGINEER_STEAMRIGGER          = 1,
    TYPE_WARLORD_KALITHRESH             = 2,
    MAX_ENCOUNTER                       = 3
};

enum steamVaultNPCGO
{
    GO_MAIN_CHAMBERS_DOOR               = 183049,
    GO_ACCESS_PANEL_HYDRO               = 184125,
    GO_ACCESS_PANEL_MEK                 = 184126,

    NPC_MEKGINEER_STEAMRIGGER           = 17796,
    NPC_WARLORD_KALITHRESH              = 17798,
};

template <class AI, class T>
inline AI* GetSteamVaultAI(T* obj)
{
    return GetInstanceAI<AI>(obj, SteamVaultScriptName);
}

#endif
