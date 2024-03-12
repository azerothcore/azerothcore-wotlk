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

#include "boss_xt002.h"
#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "Opcodes.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "ulduar.h"

void AddSC_boss_xt002()
{
    // Npcs
    new boss_xt002();
    new npc_xt002_heart();
    new npc_xt002_scrapbot();
    new npc_xt002_pummeller();
    new npc_xt002_boombot();
    new npc_xt002_life_spark();

    // Spells
    new spell_xt002_tympanic_tantrum();
    new spell_xt002_gravity_bomb_aura();
    new spell_xt002_gravity_bomb_damage();
    new spell_xt002_searing_light_spawn_life_spark();

    // Achievements
    new achievement_xt002_nerf_engineering();
    new achievement_xt002_nerf_gravity_bombs();
}
