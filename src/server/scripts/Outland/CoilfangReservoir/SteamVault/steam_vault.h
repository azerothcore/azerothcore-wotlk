/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-AGPL
*/

#ifndef DEF_STEAM_VAULT_H
#define DEF_STEAM_VAULT_H

#include "ScriptPCH.h"

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

#endif

