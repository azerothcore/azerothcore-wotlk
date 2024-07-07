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

#ifndef DEF_NAXXRAMAS_H
#define DEF_NAXXRAMAS_H

#include "CreatureAIImpl.h"
#include "SpellScript.h"

#define DataHeader "NAX"

#define NaxxramasScriptName "instance_naxxramas"

enum Encouters
{
    BOSS_PATCHWERK                 = 0,
    BOSS_GROBBULUS                 = 1,
    BOSS_GLUTH                     = 2,
    BOSS_NOTH                      = 3,
    BOSS_HEIGAN                    = 4,
    BOSS_LOATHEB                   = 5,
    BOSS_ANUB                      = 6,
    BOSS_FAERLINA                  = 7,
    BOSS_MAEXXNA                   = 8,
    BOSS_THADDIUS                  = 9,
    BOSS_RAZUVIOUS                 = 10,
    BOSS_GOTHIK                    = 11,
    BOSS_HORSEMAN                  = 12,
    BOSS_SAPPHIRON                 = 13,
    BOSS_KELTHUZAD                 = 14,
    MAX_ENCOUNTERS,
};

enum NXData
{
    DATA_NOTH_ENTRY_GATE            = 100,
    DATA_HEIGAN_ERUPTION            = 101,
    DATA_HEIGAN_ENTER_GATE          = 102,
    DATA_LOATHEB_GATE               = 103,
    DATA_ANUB_GATE                  = 104,
    DATA_FAERLINA_WEB               = 105,
    DATA_MAEXXNA_GATE               = 106,
    DATA_THADDIUS_BOSS              = 107,
    DATA_STALAGG_BOSS               = 108,
    DATA_FEUGEN_BOSS                = 109,
    DATA_THADDIUS_GATE              = 110,
    DATA_RAZUVIOUS                  = 111,
    DATA_GOTHIK_BOSS                = 112,
    DATA_GOTHIK_ENTER_GATE          = 113,
    DATA_GOTHIK_INNER_GATE          = 114,
    DATA_GOTHIK_EXIT_GATE           = 115,
    DATA_HORSEMEN_GATE              = 116,
    DATA_LICH_KING_BOSS             = 117,
    DATA_KELTHUZAD_FLOOR            = 118,
    DATA_ABOMINATION_KILLED         = 119,
    DATA_FRENZY_REMOVED             = 120,
    DATA_CHARGES_CROSSED            = 121,
    DATA_SPORE_KILLED               = 122,
    DATA_HUNDRED_CLUB               = 123,
    DATA_DANCE_FAIL                 = 124,
    DATA_IMMORTAL_FAIL              = 125,
    DATA_KELTHUZAD_GATE             = 126,
    DATA_HAD_THADDIUS_GREET         = 127,
    DATA_KELTHUZAD_PORTAL_1         = 128,
    DATA_KELTHUZAD_PORTAL_2         = 129,
    DATA_KELTHUZAD_PORTAL_3         = 130,
    DATA_KELTHUZAD_PORTAL_4         = 131
};

enum NXGOs
{
    GO_PATCHWERK_GATE               = 181123,
    GO_GLUTH_GATE                   = 181120,
    GO_NOTH_ENTRY_GATE              = 181200,
    GO_NOTH_EXIT_GATE               = 181201,
    GO_HEIGAN_ENTRY_GATE            = 181202,
    GO_HEIGAN_EXIT_GATE             = 181203,
    GO_LOATHEB_GATE                 = 181241,
    GO_ANUB_GATE                    = 181126,
    GO_ANUB_NEXT_GATE               = 181195,
    GO_FAERLINA_WEB                 = 181235,
    GO_FAERLINA_GATE                = 194022,
    GO_MAEXXNA_GATE                 = 181209,
    GO_THADDIUS_GATE                = 181121,
    GO_GOTHIK_ENTER_GATE            = 181124,
    GO_GOTHIK_INNER_GATE            = 181170,
    GO_GOTHIK_EXIT_GATE             = 181125,
    GO_HORSEMEN_GATE                = 181119,
    GO_SAPPHIRON_GATE               = 181225,

    GO_HORSEMEN_CHEST_10            = 181366,
    GO_HORSEMEN_CHEST_25            = 193426,

    GO_SAPPHIRON_BIRTH              = 181356,
    GO_KELTHUZAD_FLOOR              = 181444,
    GO_KELTHUZAD_GATE               = 181228,
    GO_KELTHUZAD_PORTAL_1           = 181402,
    GO_KELTHUZAD_PORTAL_2           = 181403,
    GO_KELTHUZAD_PORTAL_3           = 181404,
    GO_KELTHUZAD_PORTAL_4           = 181405,

    GO_LOATHEB_PORTAL               = 181577,
    GO_THADDIUS_PORTAL              = 181576,
    GO_MAEXXNA_PORTAL               = 181575,
    GO_HORSEMAN_PORTAL              = 181578,

    // "Glow" effect on center-side portal
    GO_DEATHKNIGHT_EYE_PORTAL       = 181210,
    GO_PLAGUE_EYE_PORTAL            = 181211,
    GO_SPIDER_EYE_PORTAL            = 181212,
    GO_ABOM_EYE_PORTAL              = 181213,

    // "Glow" effect on boss-side portal
    GO_ARAC_EYE_RAMP_BOSS           = 181233,
    GO_PLAG_EYE_RAMP_BOSS           = 181231,
    GO_MILI_EYE_RAMP_BOSS           = 181230,
    GO_CONS_EYE_RAMP_BOSS           = 181232
};

enum NXNPCs
{
    // Thaddius
    NPC_THADDIUS                    = 15928,
    NPC_STALAGG                     = 15929,
    NPC_FEUGEN                      = 15930,

    // Razuvious
    NPC_RAZUVIOUS                   = 16061,

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
    NPC_MR_BIGGLESWORTH             = 16998,

    // Patchwerk
    NPC_PATCHWERK                   = 16028,
    NPC_PATCHWORK_GOLEM             = 16017,
    NPC_BILE_RETCHER                = 16018,
    NPC_MAD_SCIENTIST               = 16020,
    NPC_LIVING_MONSTROSITY          = 16021,
    NPC_SURGICAL_ASSIST             = 16022,
    NPC_SLUDGE_BELCHER              = 16029,

    // Gothik
    NPC_GOTHIK                      = 16060
};

enum NXMisc
{
    SPELL_ERUPTION                  = 29371,
    SPELL_FROGGER_EXPLODE           = 28433,

    ACTION_SAPPHIRON_BIRTH          = 1,

    // Background screams in instance if Thaddius still alive, four of them from 8873 to 8876
    SOUND_SCREAM                    = 8873
};

enum NXSays
{
    SAY_SAPP_DIALOG1                = 0,
    SAY_SAPP_DIALOG2_LICH           = 1,
    SAY_SAPP_DIALOG3                = 2,
    SAY_SAPP_DIALOG4_LICH           = 2,
    SAY_SAPP_DIALOG5                = 4,
    SAY_SAPP_DIALOG6                = 20,
    SAY_CAT_DIED                    = 5,
    SAY_FIRST_WING_TAUNT            = 16
};

enum NXEvents
{
    EVENT_THADDIUS_SCREAMS          = 0,
    EVENT_KELTHUZAD_WING_TAUNT      = 1,
    EVENT_FROSTWYRM_WATERFALL_DOOR  = 2
};

template <class AI, class T>
inline AI* GetNaxxramasAI(T* obj)
{
    return GetInstanceAI<AI>(obj, NaxxramasScriptName);
}

#endif
