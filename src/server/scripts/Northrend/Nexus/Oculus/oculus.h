/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_OCULUS_H
#define DEF_OCULUS_H

#include "SpellScript.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"

enum Data
{
    DATA_DRAKOS,            // Drakos the Interrogator
    DATA_VAROS,             // Varos Cloudstrider
    DATA_UROM,              // Mage-Lord Urom
    DATA_EREGOS,            // Ley-Guardian Eregos
    MAX_ENCOUNTER,
    DATA_CC_COUNT,
    DATA_AMBER_VOID,
    DATA_EMERALD_VOID,
    DATA_RUBY_VOID,
    DATA_DCD_1              = 100,
    DATA_DCD_2              = 101,
    DATA_DCD_3              = 102,
};

enum NPCs
{
    NPC_DRAKOS              = 27654,
    NPC_VAROS               = 27447,
    NPC_UROM                = 27655,
    NPC_EREGOS              = 27656,

    NPC_VERDISA             = 27657,
    NPC_BELGARISTRASZ       = 27658,
    NPC_ETERNOS             = 27659,

    NPC_AMBER_DRAKE         = 27755,
    NPC_EMERALD_DRAKE       = 27692,
    NPC_RUBY_DRAKE          = 27756,

    NPC_CENTRIFUGE_CONSTRUCT = 27641,

    NPC_IMAGE_OF_BELGARISTRASZ = 28012,
};

enum Items
{
    ITEM_EMERALD_ESSENCE    = 37815,
    ITEM_AMBER_ESSENCE      = 37859,
    ITEM_RUBY_ESSENCE       = 37860,
};

enum GOs
{
    GO_DRAGON_CAGE          = 189986,
    GO_DRAGON_CAGE_DOOR     = 193995,
    GO_CACHE_OF_EREGOS      = 191349,
    GO_CACHE_OF_EREGOS_HERO = 193603,
    GO_SPOTLIGHT            = 191351,
};

enum AchievData
{
    ACHIEV_MAKE_IT_COUNT_TIMED_EVENT    = 18153,
    CRITERIA_EXPERIENCED_AMBER          = 7177,
    CRITERIA_EXPERIENCED_EMERALD        = 7178,
    CRITERIA_EXPERIENCED_RUBY           = 7179,
    CRITERIA_AMBER_VOID                 = 7325,
    CRITERIA_EMERALD_VOID               = 7324,
    CRITERIA_RUBY_VOID                  = 7323,
};

enum OculusWorldStates
{
    WORLD_STATE_CENTRIFUGE_CONSTRUCT_SHOW   = 3524,
    WORLD_STATE_CENTRIFUGE_CONSTRUCT_AMOUNT = 3486
};

#endif
