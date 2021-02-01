/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef ARCATRAZ_H
#define ARCATRAZ_H

#include "SpellScript.h"
#include "Player.h"
#include "CreatureAI.h"

enum DataTypes
{
    // Encounter States/Boss GUIDs
    DATA_ZEREKETH                               = 0,
    DATA_DALLIAH                                = 1,
    DATA_SOCCOTHRATES                           = 2,
    DATA_WARDEN_MELLICHAR                       = 3,
    MAX_ENCOUTER                                = 4,

    // Additional Data
    DATA_WARDEN_1                               = 5, // used by SmartAI
    DATA_WARDEN_2                               = 6, // used by SmartAI
    DATA_WARDEN_3                               = 7, // used by SmartAI
    DATA_WARDEN_4                               = 8, // used by SmartAI
    DATA_WARDEN_5                               = 9, // used by SmartAI
    DATA_WARDENS_SHIELD                         = 10
};

enum CreatureIds
{
    NPC_DALLIAH                                 = 20885,
    NPC_SOCCOTHRATES                            = 20886,
    NPC_MELLICHAR                               = 20904,
    NPC_HARBINGER_SKYRISS                       = 20912,
    NPC_ALPHA_POD_TARGET                        = 21436
};

enum GameObjectIds
{
    GO_CONTAINMENT_CORE_SECURITY_FIELD_ALPHA    = 184318, // door opened when Wrath-Scryer Soccothrates dies
    GO_CONTAINMENT_CORE_SECURITY_FIELD_BETA     = 184319, // door opened when Dalliah the Doomsayer dies
    GO_STASIS_POD_ALPHA                         = 183961, // pod first boss wave
    GO_STASIS_POD_BETA                          = 183963, // pod second boss wave
    GO_STASIS_POD_DELTA                         = 183964, // pod third boss wave
    GO_STASIS_POD_GAMMA                         = 183962, // pod fourth boss wave
    GO_STASIS_POD_OMEGA                         = 183965, // pod fifth boss wave
    GO_WARDENS_SHIELD                           = 184802  // shield 'protecting' mellichar
};

enum SpellIds
{
    SPELL_TELEPORT_VISUAL                   = 35517,
    SPELL_SOUL_STEAL                        = 36782
};

#endif // ARCATRAZ_H
