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

#include "boss_yoggsaron.h"
#include "AchievementCriteriaScript.h"
#include "CreatureAI.h"
#include "CreatureScript.h"
#include "Object.h"
#include "Opcodes.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ulduar.h"

void AddSC_boss_yoggsaron()
{
    new boss_yoggsaron();
    new boss_yoggsaron_sara();
    new boss_yoggsaron_cloud();
    new boss_yoggsaron_guardian_of_ys();
    new boss_yoggsaron_brain();
    new boss_yoggsaron_death_orb();
    new boss_yoggsaron_crusher_tentacle();
    new boss_yoggsaron_corruptor_tentacle();
    new boss_yoggsaron_constrictor_tentacle();
    new boss_yoggsaron_keeper();
    new boss_yoggsaron_descend_portal();
    new boss_yoggsaron_influence_tentacle();
    new boss_yoggsaron_immortal_guardian();
    new boss_yoggsaron_lich_king();
    new boss_yoggsaron_llane();
    new boss_yoggsaron_neltharion();
    new boss_yoggsaron_voice();

    // SPELLS
    new spell_yogg_saron_malady_of_the_mind();
    new spell_yogg_saron_brain_link();
    new spell_yogg_saron_shadow_beacon();
    new spell_yogg_saron_destabilization_matrix();
    new spell_yogg_saron_titanic_storm();
    new spell_yogg_saron_lunatic_gaze();
    new spell_yogg_saron_protective_gaze();
    new spell_yogg_saron_empowered();
    new spell_yogg_saron_insane_periodic_trigger();
    new spell_yogg_saron_insane();
    new spell_yogg_saron_sanity_well();
    new spell_yogg_saron_sanity_reduce();
    new spell_yogg_saron_empowering_shadows();
    new spell_yogg_saron_in_the_maws_of_the_old_god();
    new spell_yogg_saron_target_selectors();
    new spell_yogg_saron_grim_reprisal();

    // ACHIEVEMENTS
    new achievement_yogg_saron_drive_me_crazy();
    new achievement_yogg_saron_darkness("achievement_yogg_saron_three_lights_in_the_darkness", 3);
    new achievement_yogg_saron_darkness("achievement_yogg_saron_two_lights_in_the_darkness", 2);
    new achievement_yogg_saron_darkness("achievement_yogg_saron_one_light_in_the_darkness", 1);
    new achievement_yogg_saron_darkness("achievement_yogg_saron_alone_in_the_darkness", 0);
    new achievement_yogg_saron_he_waits_dreaming("achievement_yogg_saron_he_waits_dreaming_stormwind", ACTION_ILLUSION_STORMWIND);
    new achievement_yogg_saron_he_waits_dreaming("achievement_yogg_saron_he_waits_dreaming_chamber", ACTION_ILLUSION_DRAGONS);
    new achievement_yogg_saron_he_waits_dreaming("achievement_yogg_saron_he_waits_dreaming_icecrown", ACTION_ILLUSION_ICECROWN);
    new achievement_yogg_saron_kiss_and_make_up();
}
