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

#include "boss_algalon_the_observer.h"
#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "MapMgr.h"
#include "MoveSplineInit.h"
#include "ObjectMgr.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ulduar.h"

void AddSC_boss_algalon_the_observer()
{
    // NPCs
    new boss_algalon_the_observer();
    new npc_brann_bronzebeard_algalon();
    new npc_collapsing_star();
    new npc_living_constellation();
    new npc_algalon_worm_hole();

    // GOs
    new go_celestial_planetarium_access();

    // Spells
    new spell_algalon_phase_punch();
    new spell_algalon_collapse();
    new spell_algalon_trigger_3_adds();
    new spell_algalon_cosmic_smash_damage();
    new spell_algalon_big_bang();
    new spell_algalon_remove_phase();
    new spell_algalon_supermassive_fail();

    // Achievements
    new achievement_algalon_he_feeds_on_your_tears();
    new achievement_algalon_herald_of_the_titans();
}
