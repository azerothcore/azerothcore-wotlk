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

#include "boss_assembly_of_iron.h"
#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ulduar.h"

bool IsEncounterComplete(InstanceScript* pInstance, Creature* me)
{
    if (!pInstance || !me)
        return false;

    for (uint8 i = 0; i < 3; ++i)
    {
        ObjectGuid guid = pInstance->GetGuidData(DATA_STEELBREAKER + i);
        if (!guid)
            return false;

        if (Creature* boss = (ObjectAccessor::GetCreature(*me, guid)))
        {
            if (boss->IsAlive())
                return false;
            continue;
        }
        else
            return false;
    }
    return true;
}

void RespawnAssemblyOfIron(InstanceScript* pInstance, Creature* me)
{
    if (!pInstance || !me)
        return;

    for (uint8 i = 0; i < 3; ++i)
    {
        ObjectGuid guid = pInstance->GetGuidData(DATA_STEELBREAKER + i);
        if (!guid)
            return;

        if (Creature* boss = (ObjectAccessor::GetCreature((*me), guid)))
            if (!boss->IsAlive())
                boss->Respawn();
    }
    return;
}

void RestoreAssemblyHealth(ObjectGuid guid1, ObjectGuid guid2, Creature* me)
{
    if (Creature* cr = ObjectAccessor::GetCreature(*me, guid1))
        if (cr->IsAlive())
            cr->SetHealth(cr->GetMaxHealth());

    if (Creature* cr2 = ObjectAccessor::GetCreature(*me, guid2))
        if (cr2->IsAlive())
            cr2->SetHealth(cr2->GetMaxHealth());
}


void AddSC_boss_assembly_of_iron()
{
    new boss_steelbreaker();
    new boss_runemaster_molgeim();
    new boss_stormcaller_brundir();
    new npc_assembly_lightning();

    new spell_shield_of_runes();
    new spell_assembly_meltdown();
    new spell_assembly_rune_of_summoning();

    new achievement_assembly_of_iron("achievement_but_im_on_your_side", 0);
    new achievement_assembly_of_iron("achievement_assembly_steelbreaker", NPC_STEELBREAKER);
    new achievement_assembly_of_iron("achievement_assembly_runemaster", NPC_MOLGEIM);
    new achievement_assembly_of_iron("achievement_assembly_stormcaller", NPC_BRUNDIR);
    new achievement_cant_do_that_while_stunned();
}
