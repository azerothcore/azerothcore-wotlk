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

#ifndef DEF_ZULGURUB_H
#define DEF_ZULGURUB_H

#include "CreatureAIImpl.h"

uint32 const EncounterCount = 13;

#define DataHeader "ZG"

#define ZGScriptName "instance_zulgurub"

enum DataTypes
{
    DATA_JEKLIK             = 0,  // Main boss
    DATA_VENOXIS            = 1,  // Main boss
    DATA_MARLI              = 2,  // Main boss
    DATA_ARLOKK             = 3,  // Main boss
    DATA_THEKAL             = 4,  // Main boss
    DATA_HAKKAR             = 5,  // End boss
    DATA_MANDOKIR           = 6,  // Optional boss
    DATA_JINDO              = 7,  // Optional boss
    DATA_GAHZRANKA          = 8,  // Optional boss
    DATA_EDGE_OF_MADNESS    = 9,  // Optional Event Edge of Madness - one of: Gri'lek, Renataki, Hazza'rah, or Wushoolay
    DATA_LORKHAN            = 10, // Zealot Lor'Khan add to High priest Thekal!
    DATA_ZATH               = 11, // Zealot Zath add to High priest Thekal!
    DATA_OHGAN              = 12, // Bloodlord Mandokir's raptor mount
    TYPE_EDGE_OF_MADNESS    = 13  // Boss storage
};

enum CreatureIds
{
    NPC_ARLOKK              = 14515, // Arlokk Event
    NPC_PANTHER_TRIGGER     = 15091, // Arlokk Event
    NPC_ZULIAN_PROWLER      = 15101, // Arlokk Event
    NPC_ZEALOT_LORKHAN      = 11347,
    NPC_ZEALOT_ZATH         = 11348,
    NPC_PRIESTESS_JEKLIK    = 14517,
    NPC_PRIESTESS_MARLI     = 14510,
    NPC_SPAWN_OF_MARLI      = 15041,
    NPC_HIGH_PRIEST_THEKAL  = 14509,
    NPC_JINDO_THE_HEXXER    = 11380,
    NPC_NIGHTMARE_ILLUSION  = 15163,
    NPC_SHADE_OF_JINDO      = 14986,
    NPC_SACRIFICED_TROLL    = 14826,
    NPC_MANDOKIR            = 11382, // Mandokir Event
    NPC_OHGAN               = 14988, // Mandokir Event
    NPC_VILEBRANCH_SPEAKER  = 11391, // Mandokir Event
    NPC_CHAINED_SPIRIT      = 15117, // Mandokir Event
    NPC_HAKKAR              = 14834,
    NPC_ZULGURUB_TIGER      = 11361,
    NPC_BRAIN_WASH_TOTEM    = 15112,
    NPC_GAHZRANKA           = 15114,
    NPC_GRILEK              = 15082,
    NPC_HAZZARAH            = 15083,
    NPC_RENATAKI            = 15084,
    NPC_WUSHOOLAY           = 15085
};

enum GameobjectIds
{
    GO_FORCEFIELD           = 180497, // Arlokk Event
    GO_GONG_OF_BETHEKK      = 180526  // Arlokk Event
};

enum SpellIds
{
    SPELL_HAKKAR_POWER      = 24692,
    SPELL_HAKKAR_POWER_DOWN = 24693
};

template <class AI, class T>
inline AI* GetZulGurubAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ZGScriptName);
}

#define RegisterZulGurubCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetZulGurubAI)

#endif
