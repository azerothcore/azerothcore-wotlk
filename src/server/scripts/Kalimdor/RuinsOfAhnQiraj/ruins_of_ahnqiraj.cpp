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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ruins_of_ahnqiraj.h"
#include "TaskScheduler.h"

enum Spells
{
    SPELL_HIVEZARA_CATALYST     = 25187,
    SPELL_STINGER_CHARGE_NORMAL = 25190,
    SPELL_STINGER_CHARGE_BUFFED = 25191
};

struct npc_hivezara_stinger : public ScriptedAI
{
    npc_hivezara_stinger(Creature* creature) : ScriptedAI(creature)
    {
    }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void EnterCombat(Unit* who) override
    {
        DoCast(who ,who->HasAura(SPELL_HIVEZARA_CATALYST) ? SPELL_STINGER_CHARGE_BUFFED : SPELL_STINGER_CHARGE_NORMAL, true);

        _scheduler.Schedule(5s, [this](TaskContext context)
        {
            Unit* target = SelectTarget(SelectTargetMethod::Random, 1, [&](Unit* u)
            {
                return u && !u->IsPet() && u->IsWithinDist2d(me, 20.f) && u->HasAura(SPELL_HIVEZARA_CATALYST);
            });
            if (!target)
            {
                target = SelectTarget(SelectTargetMethod::Random, 1, [&](Unit* u)
                {
                    return u && !u->IsPet() && u->IsWithinDist2d(me, 20.f);
                });
            }

            if (target)
            {
                DoCast(target, target->HasAura(SPELL_HIVEZARA_CATALYST) ? SPELL_STINGER_CHARGE_BUFFED : SPELL_STINGER_CHARGE_NORMAL, true);
            }

            context.Repeat(4500ms, 6500ms);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        _scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

private:
    TaskScheduler _scheduler;
};

void AddSC_ruins_of_ahnqiraj()
{
    RegisterRuinsOfAhnQirajCreatureAI(npc_hivezara_stinger);
}
