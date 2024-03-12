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

#include "boss_thorim.h"
#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ulduar.h"

void AddSC_boss_thorim()
{
    // Main encounter
    new boss_thorim();
    new boss_thorim_sif();
    new boss_thorim_lightning_orb();
    new boss_thorim_trap();
    new boss_thorim_pillar();
    new boss_thorim_sif_blizzard();

    // Trash
    new boss_thorim_start_npcs();
    new boss_thorim_gauntlet_npcs();
    new boss_thorim_arena_npcs();

    // Mini bosses
    new boss_thorim_runic_colossus();
    new boss_thorim_ancient_rune_giant();

    // GOs
    new go_thorim_lever();

    // Spells
    new spell_thorim_lightning_pillar_P2();
    new spell_thorim_trash_impale();

    // Achievements
    new achievement_thorim_stand_in_the_lightning();
    new achievement_thorim_lose_your_illusion();
}
