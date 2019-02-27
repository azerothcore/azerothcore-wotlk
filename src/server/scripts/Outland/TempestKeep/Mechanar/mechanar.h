/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_MECHANAR_H
#define DEF_MECHANAR_H

#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Player.h"
#include "CreatureAI.h"

enum DataTypes
{
    DATA_GATEWATCHER_GYROKILL           = 0,
    DATA_GATEWATCHER_IRON_HAND          = 1,
    DATA_MECHANOLORD_CAPACITUS          = 2,
    DATA_NETHERMANCER_SEPRETHREA        = 3,
    DATA_PATHALEON_THE_CALCULATOR       = 4,
    MAX_ENCOUNTER                       = 5,

    ENCOUNTER_PASSAGE_NOT_STARTED       = 0,
    ENCOUNTER_PASSAGE_PHASE1            = 1,
    ENCOUNTER_PASSAGE_PHASE2            = 2,
    ENCOUNTER_PASSAGE_PHASE3            = 3,
    ENCOUNTER_PASSAGE_PHASE4            = 4,
    ENCOUNTER_PASSAGE_PHASE5            = 5,
    ENCOUNTER_PASSAGE_PHASE6            = 6,
    ENCOUNTER_PASSAGE_DONE              = 7,
};

enum NpcIds
{
    NPC_SUNSEEKER_ASTROMAGE             = 19168,
    NPC_SUNSEEKER_ENGINEER              = 20988,
    NPC_BLOODWARDER_CENTURION           = 19510,
    NPC_BLOODWARDER_PHYSICIAN           = 20990,
    NPC_TEMPEST_KEEPER_DESTROYER        = 19735,

    NPC_PATHALEON_THE_CALCULATOR        = 19220
};

enum GameobjectIds
{
    GO_DOOR_MOARG_1                     = 184632,
    GO_DOOR_MOARG_2                     = 184322,
    GO_DOOR_NETHERMANCER                = 184449
};

enum SpellIds
{
    SPELL_TELEPORT_VISUAL               = 35517
};

#endif
