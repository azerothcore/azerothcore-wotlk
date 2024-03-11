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

#include "boss_general_vezax.h"
#include "AccountMgr.h"
#include "AchievementCriteriaScript.h"
#include "BanMgr.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "WorldSession.h"
#include "ulduar.h"

void AddSC_boss_vezax()
{
    new boss_vezax();
    new npc_ulduar_saronite_vapors();
    new npc_ulduar_saronite_animus();

    new spell_aura_of_despair();
    new spell_mark_of_the_faceless_periodic();
    new spell_mark_of_the_faceless_drainhealth();
    new spell_saronite_vapors_dummy();
    new spell_saronite_vapors_damage();

    new achievement_smell_saronite();
    new achievement_shadowdodger();

    new go_ulduar_pure_saronite_deposit();
}
