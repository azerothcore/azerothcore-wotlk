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

#include "boss_razorscale.h"
#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "WaypointMgr.h"
#include "ulduar.h"

void AddSC_boss_razorscale()
{
    new boss_razorscale();
    new npc_ulduar_expedition_commander();
    new npc_ulduar_harpoonfirestate();
    new npc_ulduar_expedition_engineer();
    new go_ulduar_working_harpoon();
    new npc_ulduar_dark_rune_guardian();
    new npc_ulduar_dark_rune_watcher();
    new npc_ulduar_dark_rune_sentinel();
    new achievement_quick_shave();
    new achievement_iron_dwarf_medium_rare();
}

