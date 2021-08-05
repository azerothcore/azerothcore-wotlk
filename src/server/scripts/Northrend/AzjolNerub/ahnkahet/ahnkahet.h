/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef DEF_AHNKAHET_H
#define DEF_AHNKAHET_H

#define AhnahetScriptName "instance_ahnkahet"

enum AhnkahetData
{
    // Main encounters
    DATA_ELDER_NADOX            = 0,
    DATA_PRINCE_TALDARAM        = 1,
    DATA_JEDOGA_SHADOWSEEKER    = 2,
    DATA_HERALD_VOLAZJ          = 3,
    DATA_AMANITAR               = 4,
    MAX_ENCOUNTER               = 5,

    // MISC DATA
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

template <class AI, class T>
inline AI* GetAhnkahetAI(T* obj)
{
    return GetInstanceAI<AI>(obj, AhnahetScriptName);
}

#endif // DEF_AHNKAHET_H
