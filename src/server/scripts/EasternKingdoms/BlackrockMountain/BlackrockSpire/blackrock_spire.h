/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DEF_BLACKROCK_SPIRE_H
#define DEF_BLACKROCK_SPIRE_H

uint32 const EncounterCount         = 23;

#define BRSScriptName "instance_blackrock_spire"

enum DataTypes
{
    DATA_HIGHLORD_OMOKK             = 0,
    DATA_SHADOW_HUNTER_VOSHGAJIN    = 1,
    DATA_WARMASTER_VOONE            = 2,
    DATA_MOTHER_SMOLDERWEB          = 3,
    DATA_UROK_DOOMHOWL              = 4,
    DATA_QUARTERMASTER_ZIGRIS       = 5,
    DATA_GIZRUL_THE_SLAVENER        = 6,
    DATA_HALYCON                    = 7,
    DATA_OVERLORD_WYRMTHALAK        = 8,
    DATA_PYROGAURD_EMBERSEER        = 9,
    DATA_WARCHIEF_REND_BLACKHAND    = 10,
    DATA_GYTH                       = 11,
    DATA_THE_BEAST                  = 12,
    DATA_GENERAL_DRAKKISATH         = 13,
    DATA_LORD_VALTHALAK             = 14,
    // Extra
    DATA_DRAGONSPIRE_ROOM           = 15,
    DATA_HALL_RUNE_1                = 16,
    DATA_HALL_RUNE_2                = 17,
    DATA_HALL_RUNE_3                = 18,
    DATA_HALL_RUNE_4                = 19,
    DATA_HALL_RUNE_5                = 20,
    DATA_HALL_RUNE_6                = 21,
    DATA_HALL_RUNE_7                = 22
};

enum CreaturesIds
{
    NPC_HIGHLORD_OMOKK              = 9196,
    NPC_SHADOW_HUNTER_VOSHGAJIN     = 9236,
    NPC_WARMASTER_VOONE             = 9237,
    NPC_MOTHER_SMOLDERWEB           = 10596,
    NPC_UROK_DOOMHOWL               = 10584,
    NPC_QUARTERMASTER_ZIGRIS        = 9736,
    NPC_GIZRUL_THE_SLAVENER         = 10268,
    NPC_HALYCON                     = 10220,
    NPC_OVERLORD_WYRMTHALAK         = 9568,
    NPC_PYROGAURD_EMBERSEER         = 9816,
    NPC_WARCHIEF_REND_BLACKHAND     = 10429,
    NPC_GYTH                        = 10339,
    NPC_THE_BEAST                   = 10430,
    NPC_GENERAL_DRAKKISATH          = 10363,
    NPC_BLACKHAND_DREADWEAVER       = 9817,
    NPC_BLACKHAND_SUMMONER          = 9818,
    NPC_BLACKHAND_VETERAN           = 9819,
    NPC_BLACKHAND_INCARCERATOR      = 10316,
    NPC_LORD_VICTOR_NEFARIUS        = 10162
};

enum AdditionalData
{
    SPELL_SUMMON_ROOKERY_WHELP      = 15745,
    EVENT_UROK_DOOMHOWL             = 4845,
    EVENT_PYROGUARD_EMBERSEER       = 4884,
    AREATRIGGER                     = 1,
    AREATRIGGER_DRAGONSPIRE_HALL    = 2046,
    AREATRIGGER_BLACKROCK_STADIUM   = 2026
};

enum GameObjectsIds
{
    GO_WHELP_SPAWNER                = 175622, // trap spawned by go id 175124
    // Doors
    GO_EMBERSEER_IN                 = 175244, // First door to Pyroguard Emberseer
    GO_DOORS                        = 175705, // Second door to Pyroguard Emberseer
    GO_EMBERSEER_OUT                = 175153, // Door after Pyroguard Emberseer event
    GO_GYTH_ENTRY_DOOR              = 164726,
    GO_GYTH_COMBAT_DOOR             = 175185,
    GO_GYTH_EXIT_DOOR               = 175186,
    GO_DRAKKISATH_DOOR_1            = 175946,
    GO_DRAKKISATH_DOOR_2            = 175947,
    // Runes in dragonspire hall
    GO_HALL_RUNE_1                  = 175197,
    GO_HALL_RUNE_2                  = 175199,
    GO_HALL_RUNE_3                  = 175195,
    GO_HALL_RUNE_4                  = 175200,
    GO_HALL_RUNE_5                  = 175198,
    GO_HALL_RUNE_6                  = 175196,
    GO_HALL_RUNE_7                  = 175194,
    // Runes in emberseers room
    GO_EMBERSEER_RUNE_1             = 175266,
    GO_EMBERSEER_RUNE_2             = 175267,
    GO_EMBERSEER_RUNE_3             = 175268,
    GO_EMBERSEER_RUNE_4             = 175269,
    GO_EMBERSEER_RUNE_5             = 175270,
    GO_EMBERSEER_RUNE_6             = 175271,
    GO_EMBERSEER_RUNE_7             = 175272,
    // For Gyth event
    GO_DR_PORTCULLIS                = 175185,
    GO_PORTCULLIS_ACTIVE            = 164726,
    GO_PORTCULLIS_TOBOSSROOMS       = 175186,
    // Urok Doomhowl
    GO_UROK_PILE                    = 175621,
};

enum npcspells
{
    SPELL_FINKLE_IS_EINHORN         = 16710
};

#endif
