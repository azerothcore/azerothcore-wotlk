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

enum TheradrimGuardian
{
    SPELL_KNOCKDDON                   = 16790,
    SPELL_SUMMON_THERADRIM_SHARDLING  = 21057,

    EVENT_KNOCKDDON                   = 1
};

struct npc_theradrim_guardian : public ScriptedAI
{
    npc_theradrim_guardian(Creature* creature) : ScriptedAI(creature) { }

    void EnterCombat(Unit* /*who*/) override
    {
        events.ScheduleEvent(EVENT_KNOCKDDON, urand(1000, 6000));
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoCastSelf(SPELL_SUMMON_THERADRIM_SHARDLING, true);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        switch (events.ExecuteEvent())
        {
            case EVENT_KNOCKDDON:
                DoCastVictim(SPELL_KNOCKDDON);
                events.RepeatEvent(urand(8000, 14000));
                break;
        }

        DoMeleeAttackIfReady();
    }
};

void AddSC_maraudon()
{
    RegisterCreatureAI(npc_theradrim_guardian);
}
