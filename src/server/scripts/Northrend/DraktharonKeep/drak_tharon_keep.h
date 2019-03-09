/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_DRAK_THARON_H
#define DEF_DRAK_THARON_H

#include "SpellScript.h"
#include "SpellAuraEffects.h"

enum Data
{
    DATA_TROLLGORE              = 0,
    DATA_NOVOS                  = 1,
    DATA_NOVOS_CRYSTALS         = 2,
    DATA_DRED                   = 3,
    DATA_THARON_JA              = 4,
    MAX_ENCOUNTERS              = 5
};

enum Creatures
{
    NPC_KURZEL                  = 26664,
    NPC_DRAKKARI_GUARDIAN       = 26620,
    NPC_RISEN_DRAKKARI_WARRIOR  = 26635,
};

enum GameObjects
{
    GO_NOVOS_CRYSTAL_1          = 189299,
    GO_NOVOS_CRYSTAL_2          = 189300,
    GO_NOVOS_CRYSTAL_3          = 189301,
    GO_NOVOS_CRYSTAL_4          = 189302,
};

enum DTKSpells
{
    SPELL_SUMMON_DRAKKARI_SHAMAN    = 49958,
    SPELL_SUMMON_DRAKKARI_GUARDIAN  = 49959
};

#endif
