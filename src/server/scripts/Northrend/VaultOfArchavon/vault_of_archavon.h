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

#ifndef DEF_ARCHAVON_H
#define DEF_ARCHAVON_H

#include "CreatureAIImpl.h"

#define DataHeader "VA"

#define VaultOfArchavonScriptName "instance_vault_of_archavon"

enum Creatures
{
    CREATURE_ARCHAVON                           = 31125,
    CREATURE_EMALON                             = 33993,
    CREATURE_KORALON                            = 35013,
    CREATURE_TORAVON                            = 38433,
};

enum Data
{
    EVENT_ARCHAVON          = 0,
    EVENT_EMALON            = 1,
    EVENT_KORALON           = 2,
    EVENT_TORAVON           = 3,
    MAX_ENCOUNTER           = 4,
    DATA_STONED             = 5,
};

enum AchievementCriteriaIds
{
    CRITERIA_EARTH_WIND_FIRE_10 = 12018,
    CRITERIA_EARTH_WIND_FIRE_25 = 12019,
};

enum AchievementSpells
{
    SPELL_EARTH_WIND_FIRE_ACHIEVEMENT_CHECK = 68308,
    SPELL_STONED_AURA                       = 63080,
};

template <class AI, class T>
inline AI* GetVaultOfArchavonAI(T* obj)
{
    return GetInstanceAI<AI>(obj, VaultOfArchavonScriptName);
}

#endif
