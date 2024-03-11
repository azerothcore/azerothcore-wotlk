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

#include "boss_hodir.h"
#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ulduar.h"

void AddSC_boss_hodir()
{
    new boss_hodir();
    new npc_ulduar_icicle();
    new npc_ulduar_flash_freeze();
    new npc_ulduar_toasty_fire();

    new npc_ulduar_hodir_priest();
    new npc_ulduar_hodir_druid();
    new npc_ulduar_hodir_shaman();
    new npc_ulduar_hodir_mage();

    new spell_hodir_biting_cold_main_aura();
    new spell_hodir_biting_cold_player_aura();
    new spell_hodir_periodic_icicle();
    new spell_hodir_flash_freeze();
    new spell_hodir_storm_power();
    new spell_hodir_storm_cloud();
    new spell_hodir_shatter_chest();

    new achievement_cheese_the_freeze();
    new achievement_getting_cold_in_here();
    new achievement_i_could_say_that_this_cache_was_rare();
    new achievement_i_have_the_coolest_friends();
    new achievement_staying_buffed_all_winter_10();
    new achievement_staying_buffed_all_winter_25();
    new spell_hodir_toasty_fire();
    new spell_hodir_starlight();
}
