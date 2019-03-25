/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_SCHOLOMANCE_H
#define DEF_SCHOLOMANCE_H

enum DataTypes
{
    DATA_KIRTONOS_THE_HERALD            = 0,
    DATA_MINI_BOSSES                    = 1
};

enum CreatureIds
{
    NPC_RISEN_GUARDIAN                  = 11598
};

enum GameobjectIds
{
    GO_GATE_KIRTONOS                    = 175570,
    GO_GATE_RAVENIAN                    = 177372,
    GO_GATE_THEOLEN                     = 177377,
    GO_GATE_ILLUCIA                     = 177371,
    GO_GATE_MALICIA                     = 177375,
    GO_GATE_BAROV                       = 177373,
    GO_GATE_POLKELT                     = 177376
};

enum SpellIds
{
    SPELL_SUMMON_BONE_MAGE_FRONT_LEFT           = 27696,
    SPELL_SUMMON_BONE_MAGE_FRONT_RIGHT          = 27697,
    SPELL_SUMMON_BONE_MAGE_BACK_RIGHT           = 27698,
    SPELL_SUMMON_BONE_MAGE_BACK_LEFT            = 27699,

    SPELL_SUMMON_BONE_MINION1                   = 27690,
    SPELL_SUMMON_BONE_MINION2                   = 27691,
    SPELL_SUMMON_BONE_MINION3                   = 27692,
    SPELL_SUMMON_BONE_MINION4                   = 27693,

    SPELL_SHADOW_PORTAL_HALLOFSECRETS           = 17863,
    SPELL_SHADOW_PORTAL_HALLOFTHEDAMNED         = 17939,
    SPELL_SHADOW_PORTAL_THECOVEN                = 17943,
    SPELL_SHADOW_PORTAL_THESHADOWVAULT          = 17944,
    SPELL_SHADOW_PORTAL_BAROVFAMILYVAULT        = 17946,
    SPELL_SHADOW_PORTAL_VAULTOFTHERAVENIAN      = 17948
};

#endif
