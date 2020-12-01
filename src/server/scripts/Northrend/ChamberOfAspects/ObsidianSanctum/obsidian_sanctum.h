/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_OBSIDIAN_SANCTUM_H
#define DEF_OBSIDIAN_SANCTUM_H

enum Data : uint32
{
    // Encounters
    DATA_SARTHARION                 = 0,
    DATA_TENEBRON                   = 1,
    DATA_VESPERON                   = 2,
    DATA_SHADRON                    = 3,
    MAX_ENCOUNTERS                  = 4,

    // Achievements
    DATA_ACHIEVEMENT_DRAGONS_COUNT  = 30,
    DATA_VOLCANO_BLOWS              = 31,

    // NPCs
    NPC_SARTHARION                  = 28860,
    NPC_TENEBRON                    = 30452,
    NPC_SHADRON                     = 30451,
    NPC_VESPERON                    = 30449,
    NPC_FIRE_CYCLONE                = 30648,

    // GOs
    GO_TWILIGHT_PORTAL              = 193988,
    GO_NORMAL_PORTAL                = 193989,

    // Spells
    SPELL_TWILIGHT_SHIFT            = 57620,
    SPELL_TWILIGHT_TORMENT_SARTHARION = 58835,
};

enum OSActions
{
    // Portal
    ACTION_CLEAR_PORTAL               = -1,
    ACTION_ADD_PORTAL                 = -2,
};
#endif
