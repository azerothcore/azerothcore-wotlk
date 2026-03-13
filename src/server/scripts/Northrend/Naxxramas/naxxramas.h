/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DEF_NAXXRAMAS_H
#define DEF_NAXXRAMAS_H

#define DataHeader "NAX"

#define NaxxramasScriptName "instance_naxxramas"

enum NaxxramasEncouter
{
    BOSS_PATCHWERK                  = 0,
    BOSS_GROBBULUS                  = 1,
    BOSS_GLUTH                      = 2,
    BOSS_NOTH                       = 3,
    BOSS_HEIGAN                     = 4,
    BOSS_LOATHEB                    = 5,
    BOSS_ANUB                       = 6,
    BOSS_FAERLINA                   = 7,
    BOSS_MAEXXNA                    = 8,
    BOSS_THADDIUS                   = 9,
    BOSS_RAZUVIOUS                  = 10,
    BOSS_GOTHIK                     = 11,
    BOSS_HORSEMAN                   = 12,
    BOSS_SAPPHIRON                  = 13,
    BOSS_KELTHUZAD                  = 14,
    MAX_ENCOUNTERS
};

enum NaxxramasData
{
    DATA_PATCHWERK_BOSS             = 100,
    DATA_STALAGG_BOSS               = 101,
    DATA_FEUGEN_BOSS                = 102,
    DATA_THADDIUS_BOSS              = 103,
    DATA_RAZUVIOUS_BOSS             = 104,
    DATA_GOTHIK_BOSS                = 105,
    DATA_HEIGAN_BOSS                = 106,
    DATA_BARON_RIVENDARE_BOSS       = 107,
    DATA_SIR_ZELIEK_BOSS            = 108,
    DATA_LADY_BLAUMEUX_BOSS         = 109,
    DATA_THANE_KORTHAZZ_BOSS        = 110,
    DATA_SAPPHIRON_BOSS             = 111,
    DATA_KELTHUZAD_BOSS             = 112,
    DATA_LICH_KING_BOSS             = 113,

    DATA_LOATHEB_PORTAL             = 200,
    DATA_MAEXXNA_PORTAL             = 201,
    DATA_THADDIUS_PORTAL            = 202,
    DATA_HORSEMAN_PORTAL            = 203,
    DATA_GOTHIK_INNER_GATE          = 204,
    DATA_SAPPHIRON_GATE             = 205,
    DATA_KELTHUZAD_GATE             = 206,
    DATA_KELTHUZAD_FLOOR            = 207,
    DATA_KELTHUZAD_PORTAL_1         = 208,
    DATA_KELTHUZAD_PORTAL_2         = 209,
    DATA_KELTHUZAD_PORTAL_3         = 210,
    DATA_KELTHUZAD_PORTAL_4         = 211,

    DATA_HEIGAN_ERUPTION            = 300,
    DATA_DANCE_FAIL                 = 301,
    DATA_SPORE_KILLED               = 302,
    DATA_FRENZY_REMOVED             = 303,
    DATA_CHARGES_CROSSED            = 304,
    DATA_HUNDRED_CLUB               = 305,
    DATA_ABOMINATION_KILLED         = 306,
};

enum NaxxramasPersistentData
{
    PERSISTENT_DATA_KELTHUZAD_DIALOG = 0,
    PERSISTENT_DATA_IMMORTAL_FAIL    = 1,
    PERSISTENT_DATA_COUNT
};

enum NaxxramasGameObject
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

enum NaxxramasGameObjectsDisplayId
{
    GO_DISPLAY_ID_HEIGAN_ERUPTION1     = 1287,
    GO_DISPLAY_ID_HEIGAN_ERUPTION2     = 6785
};

enum NaxxramasCreatureId
{
    // Anub'Rekhan
    NPC_CRYPT_GUARD                 = 16573,

    // Patchwerk
    NPC_PATCHWERK                   = 16028,
    NPC_PATCHWORK_GOLEM             = 16017,
    NPC_BILE_RETCHER                = 16018,
    NPC_MAD_SCIENTIST               = 16020,
    NPC_LIVING_MONSTROSITY          = 16021,
    NPC_SURGICAL_ASSIST             = 16022,
    NPC_SLUDGE_BELCHER              = 16029,

    NPC_LIVING_POISON               = 16027,

    // Thaddius
    NPC_THADDIUS                    = 15928,
    NPC_STALAGG                     = 15929,
    NPC_FEUGEN                      = 15930,

    // Razuvious
    NPC_RAZUVIOUS                   = 16061,

    // Gothik
    NPC_GOTHIK                      = 16060,

    // Heigan the Unclean
    NPC_HEIGAN                      = 15936,

    // Four horseman
    NPC_BARON_RIVENDARE             = 30549,
    NPC_SIR_ZELIEK                  = 16063,
    NPC_LADY_BLAUMEUX               = 16065,
    NPC_THANE_KORTHAZZ              = 16064,

    // Sapphiron
    NPC_SAPPHIRON                   = 15989,

    // Kel'Thuzad
    NPC_KELTHUZAD                   = 15990,
    NPC_LICH_KING                   = 16980
};

enum NaxxramasAchievemmentCriteria
{
    ACHIEV_CRITERIA_AND_THEY_WOULD_ALL_GO_DOWN_TOGETHER_10_PLAYER = 7600,  // And They Would All Go Down Together (10 player)
    ACHIEV_CRITERIA_AND_THEY_WOULD_ALL_GO_DOWN_TOGETHER_25_PLAYER = 7601,  // And They Would All Go Down Together (25 player)

    ACHIEV_CRITERIA_JUST_CANT_GET_ENOUGH_10_PLAYER                = 7614,  // Just Can't Get Enough (10 player)
    ACHIEV_CRITERIA_JUST_CANT_GET_ENOUGH_25_PLAYER                = 7615,  // Just Can't Get Enough (25 player)

    ACHIEV_CRITERIA_MOMMA_SAID_KNOCK_YOU_OUT_10_PLAYER            = 7265,  // Momma Said Knock You Out (10 player)
    ACHIEV_CRITERIA_MOMMA_SAID_KNOCK_YOU_OUT_25_PLAYER            = 7549,  // Momma Said Knock You Out (25 player)

    ACHIEV_CRITERIA_SHOKING_10_PLAYER                             = 7604,  // Shocking! (10 player)
    ACHIEV_CRITERIA_SHOKING_25_PLAYER                             = 7605,  // Shocking! (25 player)

    ACHIEV_CRITERIA_SPORE_LOSER_10_PLAYER                         = 7612,  // Spore Loser (10 player)
    ACHIEV_CRITERIA_SPORE_LOSER_25_PLAYER                         = 7613,  // Spore Loser (25 player)

    ACHIEV_CRITERIA_THE_SAFETY_DANCE_10_PLAYER                    = 7264,  // The Safety Dance (10 player)
    ACHIEV_CRITERIA_THE_SAFETY_DANCE_25_PLAYER                    = 7548,  // The Safety Dance (25 player)

    ACHIEV_CRITERIA_SUBTRACTION_10_PLAYER                         = 7608,  // Subtraction (10 player)
    ACHIEV_CRITERIA_SUBTRACTION_25_PLAYER                         = 7609,  // Subtraction (25 player)

    ACHIEV_CRITERIA_THE_HUNDRED_CLUB_10_PLAYER                    = 7567,  // The Hundred Club (10 player)
    ACHIEV_CRITERIA_THE_HUNDRED_CLUB_25_PLAYER                    = 7568,  // The Hundred Club (25 player)

    ACHIEV_CRITERIA_THE_DEDICATED_FEW_ANUB_10_PLAYER              = 7146,  // The Dedicated Few (25 player) - Anub'Rekhan
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_FAERLINA_10_PLAYER          = 7147,  // The Dedicated Few (25 player) - Grand Widow Faerlina
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_MAEXXNA_10_PLAYER           = 7148,  // The Dedicated Few (25 player) - Maexxna
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_PATCHWERK_10_PLAYER         = 7149,  // The Dedicated Few (25 player) - Patchwerk
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_GROBBULUS_10_PLAYER         = 7150,  // The Dedicated Few (25 player) - Grobbulus
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_GLUTH_10_PLAYER             = 7151,  // The Dedicated Few (25 player) - Gluth
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_THADDIUS_10_PLAYER          = 7152,  // The Dedicated Few (25 player) - Thaddius
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_NOTH_10_PLAYER              = 7153,  // The Dedicated Few (25 player) - Noth the Plaguebringer
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_HEIGAN_10_PLAYER            = 7154,  // The Dedicated Few (25 player) - Heigan the Unclean
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_LOATHEB_10_PLAYER           = 7155,  // The Dedicated Few (25 player) - Loatheb
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_RAZUVIOUS_10_PLAYER         = 7156,  // The Dedicated Few (25 player) - Instructor Razuvious
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_GOTHIK_10_PLAYER            = 7157,  // The Dedicated Few (25 player) - Gothik the Harvester
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_SAPPHIRON_10_PLAYER         = 7158,  // The Dedicated Few (25 player) - Sapphiron
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_KELTHUZAD_10_PLAYER         = 6802,  // The Dedicated Few (25 player) - Kel'Thuzad

    ACHIEV_CRITERIA_THE_DEDICATED_FEW_ANUB_25_PLAYER              = 7159,  // The Dedicated Few (25 player) - Anub'Rekhan
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_FAERLINA_25_PLAYER          = 7160,  // The Dedicated Few (25 player) - Grand Widow Faerlina
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_MAEXXNA_25_PLAYER           = 7161,  // The Dedicated Few (25 player) - Maexxna
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_PATCHWERK_25_PLAYER         = 7162,  // The Dedicated Few (25 player) - Patchwerk
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_GROBBULUS_25_PLAYER         = 7163,  // The Dedicated Few (25 player) - Grobbulus
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_GLUTH_25_PLAYER             = 7164,  // The Dedicated Few (25 player) - Gluth
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_THADDIUS_25_PLAYER          = 7165,  // The Dedicated Few (25 player) - Thaddius
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_NOTH_25_PLAYER              = 7166,  // The Dedicated Few (25 player) - Noth the Plaguebringer
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_HEIGAN_25_PLAYER            = 7167,  // The Dedicated Few (25 player) - Heigan the Unclean
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_LOATHEB_25_PLAYER           = 7168,  // The Dedicated Few (25 player) - Loatheb
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_RAZUVIOUS_25_PLAYER         = 7169,  // The Dedicated Few (25 player) - Instructor Razuvious
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_GOTHIK_25_PLAYER            = 7170,  // The Dedicated Few (25 player) - Gothik the Harvester
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_SAPPHIRON_25_PLAYER         = 7171,  // The Dedicated Few (25 player) - Sapphiron
    ACHIEV_CRITERIA_THE_DEDICATED_FEW_KELTHUZAD_25_PLAYER         = 7172,  // The Dedicated Few (25 player) - Kel'Thuzad

    ACHIEV_CRITERIA_THE_UNDYING_KELTHUZAD                         = 7617,  // The Undying - Kel'Thuzad
    ACHIEV_CRITERIA_THE_UNDYING_THE_FOUR_HORSEMEN                 = 13237, // The Undying - The Four Horsemen
    ACHIEV_CRITERIA_THE_UNDYING_MAEXXNA                           = 13238, // The Undying - Maexxna
    ACHIEV_CRITERIA_THE_UNDYING_LOATHEB                           = 13239, // The Undying - Loatheb
    ACHIEV_CRITERIA_THE_UNDYING_THADDIUS                          = 13240, // The Undying - Thaddius

    ACHIEV_CRITERIA_THE_IMMORTAL_KELTHUZAD                        = 7616,  // The Immortal - Kel'Thuzad
    ACHIEV_CRITERIA_THE_IMMORTAL_THE_FOUR_HORSEMEN                = 13233, // The Immortal - The Four Horsemen
    ACHIEV_CRITERIA_THE_IMMORTAL_MAEXXNA                          = 13234, // The Immortal - Maexxna
    ACHIEV_CRITERIA_THE_IMMORTAL_LOATHEB                          = 13235, // The Immortal - Loatheb
    ACHIEV_CRITERIA_THE_IMMORTAL_THADDIUS                         = 13236  // The Immortal - Thaddius
};

enum NaxxramasSay
{
    SAY_HORSEMEN_DIALOG1            = 5,
    SAY_HORSEMEN_DIALOG2            = 6,

    SAY_SAPP_DIALOG1                = 0,
    SAY_SAPP_DIALOG2_LICH           = 1,
    SAY_SAPP_DIALOG3                = 2,
    SAY_SAPP_DIALOG4_LICH           = 2,
    SAY_SAPP_DIALOG5                = 4,
    SAY_SAPP_DIALOG6                = 20,

    SAY_CAT_DIED                    = 5, // No!!! A curse upon you, interlopers! The armies of the Lich King will hunt you down. You will not escape your fate...
    SAY_FIRST_WING_TAUNT            = 16
};

enum NaxxramasEvent
{
    EVENT_SUMMON_LIVING_POISON                = 1,
    EVENT_THADDIUS_SCREAMS                    = 2,
    EVENT_AND_THEY_WOULD_ALL_GO_DOWN_TOGETHER = 3,
    EVENT_KELTHUZAD_WING_TAUNT                = 4,

    EVENT_HORSEMEN_INTRO1                     = 5,  // Thane Korth'azz: To arms, ye roustabouts! We've got company!
    EVENT_HORSEMEN_INTRO2                     = 6,  // Sir Zeliek:      Invaders, cease this foolish venture at once! Turn away while you still can!
    EVENT_HORSEMEN_INTRO3                     = 7,  // Lady Blaumeux:   Come, Zeliek, do not drive them out. Not before we've had our fun!
    EVENT_HORSEMEN_INTRO4                     = 8,  // Baron Rivendare: Enough prattling. Let them come. We shall grind their bones to dust.
    EVENT_HORSEMEN_INTRO5                     = 9,  // Lady Blaumeux:   I do hope they stay alive long enough for me to... introduce myself.
    EVENT_HORSEMEN_INTRO6                     = 10, // Sir Zeliek:      Perhaps they will come to their senses... and run away as fast as they can.
    EVENT_HORSEMEN_INTRO7                     = 11, // Thane Korth'azz: I've heard about enough a' yer snivelin'! Shut yer flytrap before I shut it for ye'!
    EVENT_HORSEMEN_INTRO8                     = 12, // Baron Rivendare: Conserve your anger. Harness your rage. You will all have outlets for your frustrations soon enough.

    EVENT_FROSTWYRM_WATERFALL_DOOR            = 13,
    EVENT_KELTHUZAD_LICH_KING_TALK1           = 14,
    EVENT_KELTHUZAD_LICH_KING_TALK2           = 15,
    EVENT_KELTHUZAD_LICH_KING_TALK3           = 16,
    EVENT_KELTHUZAD_LICH_KING_TALK4           = 17,
    EVENT_KELTHUZAD_LICH_KING_TALK5           = 18,
    EVENT_KELTHUZAD_LICH_KING_TALK6           = 19
};

enum NaxxramasMisc
{
    SPELL_ERUPTION                  = 29371,
    SPELL_EXPLODE                   = 28433,
    SPELL_THE_FOUR_HORSEMAN_CREDIT  = 59450,

    ACTION_SAPPHIRON_BIRTH          = 1,

    // Background screams in instance if Thaddius still alive, four of them from 8873 to 8876
    SOUND_SCREAM                    = 8873
};

static constexpr uint8 HeiganEruptSectionCount    = 4;
static constexpr uint8 HorsemanCount              = 4;
static constexpr uint8 AbominationKillCountReq    = 18;
static constexpr uint8 TheDedicatedFew10PlayerReq = 9;
static constexpr uint8 TheDedicatedFew25PlayerReq = 21;

template<typename AI, typename T>
inline AI* GetNaxxramasAI(T* obj)
{
    return GetInstanceAI<AI>(obj, NaxxramasScriptName);
}

#define RegisterNaxxramasCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetNaxxramasAI)

#endif
