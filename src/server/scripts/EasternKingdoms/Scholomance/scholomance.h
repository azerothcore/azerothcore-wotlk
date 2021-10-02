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

#ifndef DEF_SCHOLOMANCE_H
#define DEF_SCHOLOMANCE_H

#include "CreatureAIImpl.h"

#define ScholomanceScriptName "instance_scholomance"

enum DataTypes
{
    DATA_KIRTONOS_THE_HERALD            = 0,
    DATA_MINI_BOSSES                    = 1,
    DATA_RAS_HUMAN                      = 2
};

enum ModelIds
{
    MODEL_RAS_HUMAN                     = 3975
};

enum TalkGroupIds
{
    TALK_RAS_HUMAN                      = 0
};

enum CreatureIds
{
    NPC_RISEN_GUARDIAN                  = 11598
};

enum GameobjectIds
{
    GO_GATE_KIRTONOS                    = 175570,
    GO_GATE_RAVENIAN                    = 177372,
    GO_GATE_THEOLEN                     = 177377,
    GO_GATE_ILLUCIA                     = 177371,
    GO_GATE_MALICIA                     = 177375,
    GO_GATE_BAROV                       = 177373,
    GO_GATE_POLKELT                     = 177376
};

enum SpellIds
{
    SPELL_SUMMON_BONE_MAGE_FRONT_LEFT           = 27696,
    SPELL_SUMMON_BONE_MAGE_FRONT_RIGHT          = 27697,
    SPELL_SUMMON_BONE_MAGE_BACK_RIGHT           = 27698,
    SPELL_SUMMON_BONE_MAGE_BACK_LEFT            = 27699,

    SPELL_SUMMON_BONE_MINION1                   = 27690,
    SPELL_SUMMON_BONE_MINION2                   = 27691,
    SPELL_SUMMON_BONE_MINION3                   = 27692,
    SPELL_SUMMON_BONE_MINION4                   = 27693,

    SPELL_SHADOW_PORTAL_HALLOFSECRETS           = 17863,
    SPELL_SHADOW_PORTAL_HALLOFTHEDAMNED         = 17939,
    SPELL_SHADOW_PORTAL_THECOVEN                = 17943,
    SPELL_SHADOW_PORTAL_THESHADOWVAULT          = 17944,
    SPELL_SHADOW_PORTAL_BAROVFAMILYVAULT        = 17946,
    SPELL_SHADOW_PORTAL_VAULTOFTHERAVENIAN      = 17948
};

template <class AI, class T>
inline AI* GetScholomanceAI(T* obj)
{
    return GetInstanceAI<AI>(obj, ScholomanceScriptName);
}

#endif
