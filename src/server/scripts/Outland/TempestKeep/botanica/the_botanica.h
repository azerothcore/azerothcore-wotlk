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

#ifndef DEF_THE_BOTANICA_H
#define DEF_THE_BOTANICA_H

#include "CreatureAIImpl.h"

#define TheBotanicaScriptName "instance_the_botanica"

#define DataHeader "BC"

enum DataTypes
{
    DATA_COMMANDER_SARANNIS             = 0,
    DATA_HIGH_BOTANIST_FREYWINN         = 1,
    DATA_THORNGRIN_THE_TENDER           = 2,
    DATA_LAJ                            = 3,
    DATA_WARP_SPLINTER                  = 4,
    MAX_ENCOUNTER                       = 5
};

enum CreatureIds
{
    NPC_COMMANDER_SARANNIS              = 17976,
    NPC_HIGH_BOTANIST_FREYWINN          = 17975,
    NPC_THORNGRIN_THE_TENDER            = 17978,
    NPC_LAJ                             = 17980,
    NPC_WARP_SPLINTER                   = 17977,

    NPC_BLOODFALCON                     = 18155
};

enum SpellIds
{
    SPELL_ARCANE_FORM                   = 34204,
    SPELL_FIRE_FORM                     = 34203,
    SPELL_FROST_FORM                    = 34202,
    SPELL_SHADOW_FORM                   = 34205
};

template <class AI, class T>
inline AI* GetTheBotanicaAI(T* obj)
{
    return GetInstanceAI<AI>(obj, TheBotanicaScriptName);
}

#define RegisterTheBotanicaCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetTheBotanicaAI)

#endif
