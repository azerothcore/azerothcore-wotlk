
#ifndef DEF_AHNKAHET_H
#define DEF_AHNKAHET_H

enum AhnkahetData
{
    // Main encounters
    DATA_ELDER_NADOX            = 0,
    DATA_PRINCE_TALDARAM,
    DATA_JEDOGA_SHADOWSEEKER,
    DATA_HERALD_VOLAZJ,
    DATA_AMANITAR,
    MAX_ENCOUNTER,

    // Teldram encounter related
    DATA_PRINCE_TALDARAM_PLATFORM,
    DATA_TELDRAM_SPHERE1,
    DATA_TELDRAM_SPHERE2,
};

enum AhnKahetCreatures
{
    NPC_ELDER_NADOX                 = 29309,
    NPC_PRINCE_TALDARAM             = 29308,
    NPC_JEDOGA_SHADOWSEEKER         = 29310,
    NPC_HERALD_JOLAZJ               = 29311,
    NPC_AMANITAR                    = 30258,

    // Teldaram and Jedoga encounter related
    NPC_JEDOGA_CONTROLLER           = 30181,
};

enum AhnkahetSpells
{
    SPELL_SHADOW_SICKLE             = 56701, // Shadow Sickle Normal
    SPELL_SHADOW_SICKLE_H           = 59104  // Shadow Sickle Heroic
};

enum AhnkahetObjects
{
    GO_TELDARAM_DOOR                = 192236,
    GO_TELDARAM_SPHERE1             = 193093,
    GO_TELDARAM_SPHERE2             = 193094,
    GO_TELDARAM_PLATFORM            = 193564,
};

enum AhnKahetActions
{
    ACTION_REMOVE_PRISON            = -1
};

#endif // DEF_AHNKAHET_H
