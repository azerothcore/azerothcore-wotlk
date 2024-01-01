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

/* ScriptData
SDName: Boss_Wushoolay
SD%Complete: 100
SDComment:
SDCategory: Zul'Gurub
EndScriptData */

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_LIGHTNING_CLOUD       = 24683,
    SPELL_CHAIN_LIGHTNING       = 24680,
    SPELL_FORKED_LIGHTNING      = 24682
};

enum Events
{
    EVENT_LIGHTNING_CLOUD       = 1,
    EVENT_CHAIN_LIGHTNING       = 2,
    EVENT_FORKED_LIGHTNING      = 3
};

class boss_wushoolay : public CreatureScript
{
public:
    boss_wushoolay() : CreatureScript("boss_wushoolay") { }

    struct boss_wushoolayAI : public BossAI
    {
        boss_wushoolayAI(Creature* creature) : BossAI(creature, DATA_EDGE_OF_MADNESS) { }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(EVENT_LIGHTNING_CLOUD, 7s, 15s);
            events.ScheduleEvent(EVENT_CHAIN_LIGHTNING, 12s, 16s);
            events.ScheduleEvent(EVENT_FORKED_LIGHTNING, 8s, 12s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_LIGHTNING_CLOUD:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        {
                            me->CastSpell(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), SPELL_LIGHTNING_CLOUD, false);
                        }
                        events.ScheduleEvent(EVENT_LIGHTNING_CLOUD, 9s, 20s);
                        break;
                    case EVENT_CHAIN_LIGHTNING:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        {
                            DoCast(target, SPELL_CHAIN_LIGHTNING);
                        }
                        events.ScheduleEvent(EVENT_CHAIN_LIGHTNING, 12s, 24s);
                        break;
                    case EVENT_FORKED_LIGHTNING:
                        DoCastAOE(SPELL_FORKED_LIGHTNING);
                        events.ScheduleEvent(EVENT_FORKED_LIGHTNING, 8s, 20s);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<boss_wushoolayAI>(creature);
    }
};

void AddSC_boss_wushoolay()
{
    new boss_wushoolay();
}
