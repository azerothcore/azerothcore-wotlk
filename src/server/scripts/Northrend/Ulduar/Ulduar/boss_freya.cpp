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

#include "boss_freya.h"
#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "ulduar.h"


void AddSC_boss_freya()
{
    new boss_freya();
    new boss_freya_elder_stonebark();
    new boss_freya_elder_brightleaf();
    new boss_freya_elder_ironbranch();
    new boss_freya_iron_root();
    new boss_freya_lifebinder();
    new boss_freya_healthy_spore();
    new boss_freya_summons();
    new boss_freya_nature_bomb();

    new achievement_freya_getting_back_to_nature();
    new achievement_freya_knock_on_wood("achievement_freya_knock_on_wood", 1);
    new achievement_freya_knock_on_wood("achievement_freya_knock_knock_on_wood", 2);
    new achievement_freya_knock_on_wood("achievement_freya_knock_knock_knock_on_wood", 3);
}

