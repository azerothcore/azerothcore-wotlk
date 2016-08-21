/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-AGPL
*/

#ifndef DEF_NAXXRAMAS_H
#define DEF_NAXXRAMAS_H

#include "ScriptPCH.h"

enum NXEncounter
{
    EVENT_PATCHWERK                 = 0,
    EVENT_GROBBULUS                 = 1,
    EVENT_GLUTH                     = 2,
    EVENT_NOTH                      = 3,
    EVENT_HEIGAN                    = 4,
    EVENT_LOATHEB                   = 5,
    EVENT_ANUB                      = 6,
    EVENT_FAERLINA                  = 7,
    EVENT_MAEXXNA                   = 8,
    EVENT_THADDIUS                  = 9,
    EVENT_RAZUVIOUS                 = 10,
    EVENT_GOTHIK                    = 11,
    EVENT_HORSEMAN                  = 12,
    EVENT_SAPPHIRON                 = 13,
    EVENT_KELTHUZAD                 = 14,
    MAX_ENCOUNTERS,
};

enum NXData
{
    DATA_HEIGAN_ERUPTION            = 100,
    DATA_HEIGAN_ENTER_GATE          = 101,
    DATA_LOATHEB_GATE               = 102,
    DATA_ANUB_GATE                  = 103,
    DATA_MAEXXNA_GATE               = 104,
    DATA_THADDIUS_BOSS              = 105,
    DATA_STALAGG_BOSS               = 106,
    DATA_FEUGEN_BOSS                = 107,
    DATA_GOTHIK_ENTER_GATE          = 108,
    DATA_GOTHIK_INNER_GATE          = 109,
    DATA_GOTHIK_EXIT_GATE           = 110,
    DATA_LICH_KING_BOSS             = 111,
    DATA_KELTHUZAD_FLOOR            = 112,
    DATA_ABOMINATION_KILLED         = 113,
    DATA_FRENZY_REMOVED             = 114,
    DATA_CHARGES_CROSSED            = 115,
    DATA_SPORE_KILLED               = 116,
    DATA_HUNDRED_CLUB               = 117,
    DATA_DANCE_FAIL                 = 118,
    DATA_IMMORTAL_FAIL              = 119,
    DATA_KELTHUZAD_GATE             = 120,
};

enum NXGOs
{
    GO_PATCHWERK_GATE               = 181123,
    GO_GLUTH_GATE                   = 181120,
    GO_NOTH_GATE                    = 181201,
    GO_HEIGAN_ENTERANCE_GATE        = 181202,
    GO_HEIGAN_EXIT_GATE             = 181203,
    GO_LOATHEB_GATE                 = 181241,
    GO_ANUB_GATE                    = 181126,
    GO_ANUB_NEXT_GATE               = 181195,
    GO_FAERLINA_GATE                = 194022,
    GO_MAEXXNA_GATE                 = 181209,
    GO_THADDIUS_GATE                = 181121,
    GO_GOTHIK_ENTER_GATE            = 181124,
    GO_GOTHIK_INNER_GATE            = 181170,
    GO_GOTHIK_EXIT_GATE             = 181125,
    GO_HORSEMAN_GATE                = 181119,
    GO_SAPPHIRON_GATE               = 181225,
    
    GO_HORSEMEN_CHEST_10            = 181366,
    GO_HORSEMEN_CHEST_25            = 193426,

    GO_SAPPHIRON_BIRTH              = 181356,
    GO_KELTHUZAD_FLOOR              = 181444,
    GO_KELTHUZAD_GATE               = 181228,

    GO_DEATHKNIGHT_WING             = 181577, //Loatheb portal
    GO_THADDIUS_PORTAL              = 181576, //Thadius portal
    GO_MAEXXNA_PORTAL               = 181575, //Maexxna portal
    GO_HORSEMAN_PORTAL              = 181578, //Four Horseman portal
};

enum NXNPCs
{
    // Thaddius
    NPC_THADDIUS                    = 15928,
    NPC_STALAGG                     = 15929,
    NPC_FEUGEN                      = 15930,

    // Four horseman
    NPC_BARON_RIVENDARE             = 30549,
    NPC_SIR_ZELIEK                  = 16063,
    NPC_LADY_BLAUMEUX               = 16065,
    NPC_THANE_KORTHAZZ              = 16064,

    // Sapphiron
    NPC_SAPPHIRON                   = 15989,

    // Kel'Thuzad
    NPC_KELTHUZAD                   = 15990,
    NPC_LICH_KING                   = 16980,

    // Frogger
    NPC_LIVING_POISON               = 16027,
    NPC_NAXXRAMAS_TRIGGER           = 16082,
    NPC_MR_BIGGLESWORTH             = 16998
};

enum NXMisc
{
    // Spells
    SPELL_ERUPTION                  = 29371,
    SPELL_FROGGER_EXPLODE           = 28433,

    // Actions
    ACTION_SAPPHIRON_BIRTH          = 1
};

enum NXSays
{
    SAY_SAPP_DIALOG1                = 0,
    SAY_SAPP_DIALOG2_LICH           = 0,
    SAY_SAPP_DIALOG3                = 2,
    SAY_SAPP_DIALOG4_LICH           = 1,
    SAY_SAPP_DIALOG5                = 4,
    SAY_CAT_DIED                    = 0
};

#endif

