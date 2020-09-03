
#ifndef DEF_AHNKAHET_H
#define DEF_AHNKAHET_H

enum Data64
{
    // Main encounters
    DATA_ELDER_NADOX            = 0,
    DATA_PRINCE_TALDARAM,
    DATA_JEDOGA_SHADOWSEEKER,
    DATA_HERALD_VOLAZJ,
    DATA_AMANITAR,
    MAX_ENCOUNTER,

    // Rest dungeon data
    DATA_PRINCE_TALDARAM_PLATFORM,
    DATA_ELDER_NADOX_EVENT,
    DATA_PRINCE_TALDARAM_EVENT,
    DATA_JEDOGA_SHADOWSEEKER_EVENT,
    DATA_HERALD_VOLAZJ_EVENT,
    DATA_AMANITAR_EVENT,
    DATA_SPHERE_EVENT,

    DATA_NADOX_ACHIEVEMENT,
    DATA_JEDOGA_ACHIEVEMENT,
};

enum Npc
{
    NPC_ELDER_NADOX                 = 29309,
    NPC_PRINCE_TALDARAM             = 29308,
    NPC_JEDOGA_SHADOWSEEKER         = 29310,
    NPC_HERALD_JOLAZJ               = 29311,
    NPC_AMANITAR                    = 30258,
    
    //spells
    SPELL_SHADOW_SICKLE             = 56701, // Shadow Sickle Normal
    SPELL_SHADOW_SICKLE_H           = 59104  // Shadow Sickle Heroic
};

#endif // DEF_AHNKAHET_H
