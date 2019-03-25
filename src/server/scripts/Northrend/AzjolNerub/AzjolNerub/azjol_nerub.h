/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_AZJOL_NERUB_H
#define DEF_AZJOL_NERUB_H

#include "SpellScript.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"

enum ANData
{
    DATA_KRIKTHIR_THE_GATEWATCHER_EVENT = 0,
    DATA_HADRONOX_EVENT                 = 1,
    DATA_ANUBARAK_EVENT                 = 2,
    MAX_ENCOUNTERS                      = 3
};

enum ANIds
{
    NPC_SKITTERING_SWARMER              = 28735,
    NPC_SKITTERING_INFECTIOR            = 28736,
    NPC_KRIKTHIR_THE_GATEWATCHER        = 28684,
    NPC_HADRONOX                        = 28921,
    NPC_ANUB_AR_CHAMPION                = 29062,
    NPC_ANUB_AR_NECROMANCER             = 29063,
    NPC_ANUB_AR_CRYPTFIEND              = 29064,

    GO_KRIKTHIR_DOORS                   = 192395,
    GO_ANUBARAK_DOORS1                  = 192396,
    GO_ANUBARAK_DOORS2                  = 192397,
    GO_ANUBARAK_DOORS3                  = 192398,

    SPELL_WEB_WRAP_TRIGGER              = 52087
};

#endif
