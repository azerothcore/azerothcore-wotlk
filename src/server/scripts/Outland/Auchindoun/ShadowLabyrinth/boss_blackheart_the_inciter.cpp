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
#include "shadow_labyrinth.h"

enum BlackheartTheInciter
{
    SPELL_INCITE_CHAOS      = 33676,
    SPELL_INCITE_CHAOS_B    = 33684,                         //debuff applied to each member of party
    SPELL_CHARGE            = 33709,
    SPELL_WAR_STOMP         = 33707,

    SAY_INTRO               = 0,
    SAY_AGGRO               = 1,
    SAY_SLAY                = 2,
    SAY_HELP                = 3,
    SAY_DEATH               = 4,

    EVENT_SPELL_INCITE      = 1,
    EVENT_INCITE_WAIT       = 2,
    EVENT_SPELL_CHARGE      = 3,
    EVENT_SPELL_KNOCKBACK   = 4
};

class boss_blackheart_the_inciter : public CreatureScript
{
public:
    boss_blackheart_the_inciter() : CreatureScript("boss_blackheart_the_inciter") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetShadowLabyrinthAI<boss_blackheart_the_inciterAI>(creature);
    }

    struct boss_blackheart_the_inciterAI : public ScriptedAI
    {
        boss_blackheart_the_inciterAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;

        bool InciteChaos;

        void Reset() override
        {
            InciteChaos = false;
            events.Reset();

            if (instance)
                instance->SetData(DATA_BLACKHEARTTHEINCITEREVENT, NOT_STARTED);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER && urand(0, 1))
                Talk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (instance)
                instance->SetData(DATA_BLACKHEARTTHEINCITEREVENT, DONE);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_INCITE, 20000);
            events.ScheduleEvent(EVENT_INCITE_WAIT, 15000);
            events.ScheduleEvent(EVENT_SPELL_CHARGE, 0);
            events.ScheduleEvent(EVENT_SPELL_KNOCKBACK, 15000);

            if (instance)
                instance->SetData(DATA_BLACKHEARTTHEINCITEREVENT, IN_PROGRESS);
        }

        void EnterEvadeMode() override
        {
            if (InciteChaos && SelectTargetFromPlayerList(100.0f))
                return;
            CreatureAI::EnterEvadeMode();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_INCITE_WAIT:
                    InciteChaos = false;
                    break;
                case EVENT_SPELL_INCITE:
                    {
                        me->CastSpell(me, SPELL_INCITE_CHAOS, false);

                        std::list<HostileReference*> t_list = me->getThreatMgr().getThreatList();
                        for (std::list<HostileReference*>::const_iterator itr = t_list.begin(); itr != t_list.end(); ++itr)
                        {
                            Unit* target = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid());
                            if (target && target->GetTypeId() == TYPEID_PLAYER)
                                me->CastSpell(target, SPELL_INCITE_CHAOS_B, true);
                        }

                        DoResetThreat();
                        InciteChaos = true;
                        events.DelayEvents(15000);
                        events.RepeatEvent(40000);
                        events.ScheduleEvent(EVENT_INCITE_WAIT, 15000);
                        break;
                    }
                case EVENT_SPELL_CHARGE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_CHARGE, false);
                    events.RepeatEvent(urand(15000, 25000));
                    break;
                case EVENT_SPELL_KNOCKBACK:
                    me->CastSpell(me, SPELL_WAR_STOMP, false);
                    events.RepeatEvent(urand(18000, 24000));
                    break;
            }

            if (InciteChaos)
                return;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_blackheart_the_inciter()
{
    new boss_blackheart_the_inciter();
}
