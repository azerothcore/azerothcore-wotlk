/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef AZEROTHCORE_PET_DEFINES_H
#define AZEROTHCORE_PET_DEFINES_H

enum PetType
{
    SUMMON_PET              = 0,
    HUNTER_PET              = 1,
    MAX_PET_TYPE            = 4
};

#define MAX_PET_STABLES         4

// stored in character_pet.slot
enum PetSaveMode
{
    PET_SAVE_AS_DELETED        = -1,                        // not saved in fact
    PET_SAVE_AS_CURRENT        =  0,                        // in current slot (with player)
    PET_SAVE_FIRST_STABLE_SLOT =  1,
    PET_SAVE_LAST_STABLE_SLOT  =  MAX_PET_STABLES,          // last in DB stable slot index (including), all higher have same meaning as PET_SAVE_NOT_IN_SLOT
    PET_SAVE_NOT_IN_SLOT       =  100                       // for avoid conflict with stable size grow will use 100
};

enum HappinessState
{
    UNHAPPY = 1,
    CONTENT = 2,
    HAPPY   = 3
};

enum PetSpellState
{
    PETSPELL_UNCHANGED = 0,
    PETSPELL_CHANGED   = 1,
    PETSPELL_NEW       = 2,
    PETSPELL_REMOVED   = 3
};

enum PetSpellType
{
    PETSPELL_NORMAL = 0,
    PETSPELL_FAMILY = 1,
    PETSPELL_TALENT = 2
};

enum ActionFeedback
{
    FEEDBACK_NONE            = 0,
    FEEDBACK_PET_DEAD        = 1,
    FEEDBACK_NOTHING_TO_ATT  = 2,
    FEEDBACK_CANT_ATT_TARGET = 3
};

enum PetTalk
{
    PET_TALK_SPECIAL_SPELL  = 0,
    PET_TALK_ATTACK         = 1
};

// used at pet loading query list preparing, and later result selection
enum PetLoadQueryIndex
{
    PET_LOAD_QUERY_LOADAURAS                    = 0,
    PET_LOAD_QUERY_LOADSPELLS                   = 1,
    PET_LOAD_QUERY_LOADSPELLCOOLDOWN            = 2,
    MAX_PET_LOAD_QUERY,
};

enum PetLoadStage
{
    PET_LOAD_DEFAULT                            = 0,
    PET_LOAD_HANDLE_UNSTABLE_CALLBACK           = 1, // used also in HandleStableSwapPetCallback, uses same error / ok messages
    PET_LOAD_BG_RESURRECT                       = 2,
    PET_LOAD_SUMMON_PET                         = 3,
    PET_LOAD_SUMMON_DEAD_PET                    = 4
};

enum PetLoadState
{
    PET_LOAD_OK                                 = 0,
    PET_LOAD_NO_RESULT                          = 1,
    PET_LOAD_ERROR                              = 2
};

enum NPCEntries
{
    // Warlock
    NPC_INFERNAL                = 89,
    NPC_IMP                     = 416,
    NPC_FELHUNTER               = 417,
    NPC_VOIDWALKER              = 1860,
    NPC_SUCCUBUS                = 1863,
    NPC_DOOMGUARD               = 11859,
    NPC_FELGUARD                = 17252,

    // Mage
    NPC_WATER_ELEMENTAL_TEMP    = 510,
    NPC_MIRROR_IMAGE            = 31216,
    NPC_WATER_ELEMENTAL_PERM    = 37994,

    // Druid
    NPC_TREANT                  = 1964,

    // Priest
    NPC_SHADOWFIEND             = 19668,

    // Shaman
    NPC_FIRE_ELEMENTAL          = 15438,
    NPC_EARTH_ELEMENTAL         = 15352,
    NPC_FERAL_SPIRIT            = 29264,

    // Death Knight
    NPC_RISEN_GHOUL             = 26125,
    NPC_BLOODWORM               = 28017,
    NPC_ARMY_OF_THE_DEAD        = 24207,
    NPC_EBON_GARGOYLE           = 27829,

    // Generic
    NPC_GENERIC_IMP             = 12922,
    NPC_GENERIC_VOIDWALKER      = 8996
};

enum PetScalingSpells
{
    SPELL_PET_AVOIDANCE                 = 32233,

    SPELL_HUNTER_PET_SCALING_01         = 34902,
    SPELL_HUNTER_PET_SCALING_02         = 34903,
    SPELL_HUNTER_PET_SCALING_03         = 34904,
    SPELL_HUNTER_PET_SCALING_04         = 61017, // Hit / Expertise

    // Warlock
    SPELL_WARLOCK_PET_SCALING_01        = 34947,
    SPELL_WARLOCK_PET_SCALING_02        = 34956,
    SPELL_WARLOCK_PET_SCALING_03        = 34957,
    SPELL_WARLOCK_PET_SCALING_04        = 34958,
    SPELL_WARLOCK_PET_SCALING_05        = 61013, // Hit / Expertise
    SPELL_GLYPH_OF_FELGUARD             = 56246,
    SPELL_INFERNAL_SCALING_01           = 36186,
    SPELL_INFERNAL_SCALING_02           = 36188,
    SPELL_INFERNAL_SCALING_03           = 36189,
    SPELL_INFERNAL_SCALING_04           = 36190,
    SPELL_RITUAL_ENSLAVEMENT            = 22987,

    // Shaman
    SPELL_FERAL_SPIRIT_SPIRIT_HUNT      = 58877,
    SPELL_FERAL_SPIRIT_SCALING_01       = 35674,
    SPELL_FERAL_SPIRIT_SCALING_02       = 35675,
    SPELL_FERAL_SPIRIT_SCALING_03       = 35676,
    SPELL_FIRE_ELEMENTAL_SCALING_01     = 35665,
    SPELL_FIRE_ELEMENTAL_SCALING_02     = 35666,
    SPELL_FIRE_ELEMENTAL_SCALING_03     = 35667,
    SPELL_FIRE_ELEMENTAL_SCALING_04     = 35668,
    SPELL_EARTH_ELEMENTAL_SCALING_01    = 65225,
    SPELL_EARTH_ELEMENTAL_SCALING_02    = 65226,
    SPELL_EARTH_ELEMENTAL_SCALING_03    = 65227,
    SPELL_EARTH_ELEMENTAL_SCALING_04    = 65228,

    // Priest
    SPELL_SHADOWFIEND_SCALING_01        = 35661,
    SPELL_SHADOWFIEND_SCALING_02        = 35662,
    SPELL_SHADOWFIEND_SCALING_03        = 35663,
    SPELL_SHADOWFIEND_SCALING_04        = 35664,

    // Druid
    SPELL_TREANT_SCALING_01             = 35669,
    SPELL_TREANT_SCALING_02             = 35670,
    SPELL_TREANT_SCALING_03             = 35671,
    SPELL_TREANT_SCALING_04             = 35672,

    // Mage
    SPELL_MAGE_PET_SCALING_01           = 35657,
    SPELL_MAGE_PET_SCALING_02           = 35658,
    SPELL_MAGE_PET_SCALING_03           = 35659,
    SPELL_MAGE_PET_SCALING_04           = 35660,

    // Death Knight
    SPELL_ORC_RACIAL_COMMAND            = 65221,
    SPELL_NIGHT_OF_THE_DEAD_AVOIDANCE   = 62137,
    SPELL_DK_PET_SCALING_01             = 51996,
    SPELL_DK_PET_SCALING_02             = 54566,
    SPELL_DK_PET_SCALING_03             = 61697

};

#define PET_FOLLOW_DIST  1.0f
#define PET_FOLLOW_ANGLE (M_PI/2)

#endif
