/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef BLACK_TEMPLE_H_
#define BLACK_TEMPLE_H_

#include "Player.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "PassiveAI.h"
#include "GridNotifiers.h"

enum DataTypes
{
    DATA_HIGH_WARLORD_NAJENTUS      = 0,
    DATA_SUPREMUS                   = 1,
    DATA_SHADE_OF_AKAMA             = 2,
    DATA_TERON_GOREFIEND            = 3,
    DATA_GURTOGG_BLOODBOIL          = 4,
    DATA_RELIQUARY_OF_SOULS         = 5,
    DATA_MOTHER_SHAHRAZ             = 6,
    DATA_ILLIDARI_COUNCIL           = 7,
    DATA_AKAMA_FINISHED             = 8,
    DATA_ILLIDAN_STORMRAGE          = 9,
    MAX_ENCOUNTERS                  = 10
};

enum CreatureIds
{
    NPC_SHADE_OF_AKAMA              = 22841,
    NPC_AKAMA_SHADE                 = 23191,
    NPC_STORM_FURY                  = 22848,
    NPC_TERON_GOREFIEND             = 22871,
    NPC_VENGEFUL_SPIRIT             = 23109,
    NPC_SHADOWY_CONSTRUCT           = 23111,
    NPC_ANGERED_SOUL_FRAGMENT       = 23398,
    NPC_HUNGERING_SOUL_FRAGMENT     = 23401,
    NPC_SUFFERING_SOUL_FRAGMENT     = 23399,
    NPC_RELIQUARY_OF_THE_LOST       = 22856,
    NPC_ENSLAVED_SOUL               = 23469,
    NPC_GATHIOS_THE_SHATTERER       = 22949,
    NPC_HIGH_NETHERMANCER_ZEREVOR   = 22950,
    NPC_LADY_MALANDE                = 22951,
    NPC_VERAS_DARKSHADOW            = 22952,
    NPC_ILLIDARI_COUNCIL            = 23426,
    NPC_AKAMA                       = 23089,
    NPC_ILLIDAN_STORMRAGE           = 22917,
    NPC_PARASITIC_SHADOWFIEND       = 23498,
    NPC_BLADE_OF_AZZINOTH           = 22996,
    NPC_FLAME_OF_AZZINOTH           = 22997,

    NPC_DRAGON_TURTLE               = 22885
};

enum GameObjectIds
{
    GO_NAJENTUS_GATE                = 185483,
    GO_SUPREMUS_GATE                = 185882,
    GO_SHADE_OF_AKAMA_DOOR          = 185478,
    GO_TERON_DOOR_1                 = 185480,
    GO_TERON_DOOR_2                 = 186153,
    GO_GURTOGG_DOOR                 = 185892,
    GO_TEMPLE_DOOR                  = 185479,
    GO_MOTHER_SHAHRAZ_DOOR          = 185482,
    GO_COUNCIL_DOOR_1               = 185481,
    GO_COUNCIL_DOOR_2               = 186152,
    GO_ILLIDAN_GATE                 = 185905,
    GO_ILLIDAN_DOOR_R               = 186261,
    GO_ILLIDAN_DOOR_L               = 186262
};

enum MiscIds
{
    SPELL_CHEST_PAINS               = 41356,
    SPELL_WYVERN_STING              = 24336,
    SPELL_SHADOW_INFERNO_DAMAGE     = 39646,
    SPELL_CHAOTIC_CHARGE            = 41033,
    SPELL_DEMENTIA1                 = 41406,
    SPELL_DEMENTIA2                 = 41409,

    FACTION_ASHTONGUE               = 1820
};

#endif // BLACK_TEMPLE_H_
