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

#ifndef ACORE_SKILLDISCOVERY_H
#define ACORE_SKILLDISCOVERY_H

#include "Common.h"

class Player;

void LoadSkillDiscoveryTable();
uint32 GetSkillDiscoverySpell(uint32 skillId, uint32 spellId, Player* player);
bool HasDiscoveredAllSpells(uint32 spellId, Player* player);
uint32 GetExplicitDiscoverySpell(uint32 spellId, Player* player);
#endif
