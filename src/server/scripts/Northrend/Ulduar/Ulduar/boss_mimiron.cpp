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

#include "boss_mimiron.h"
#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "GameTime.h"
#include "MapMgr.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "ulduar.h"

void AddSC_boss_mimiron()
{
    new boss_mimiron();
    new npc_ulduar_leviathan_mkii();
    new npc_ulduar_vx001();
    new npc_ulduar_aerial_command_unit();

    new npc_ulduar_proximity_mine();
    new npc_ulduar_mimiron_rocket();
    new npc_ulduar_magnetic_core();
    new npc_ulduar_bot_summon_trigger();
    new spell_mimiron_rapid_burst();
    new spell_mimiron_p3wx2_laser_barrage();
    new go_ulduar_do_not_push_this_button();
    new npc_ulduar_flames_initial();
    new npc_ulduar_flames_spread();
    new npc_ulduar_emergency_fire_bot();
    new npc_ulduar_rocket_strike_trigger();

    new achievement_mimiron_firefighter();
    new achievement_mimiron_set_up_us_the_bomb_11();
    new achievement_mimiron_set_up_us_the_bomb_12();
    new achievement_mimiron_set_up_us_the_bomb_13();
}
