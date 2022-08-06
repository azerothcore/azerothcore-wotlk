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

#include "ScriptObject.h"
#include "ScriptedCreature.h"
#include "hellfire_ramparts.h"

enum Says
{
    SAY_TAUNT               = 0,
    SAY_HEAL                = 1,
    SAY_SURGE               = 2,
    SAY_AGGRO               = 3,
    SAY_KILL                = 4,
    SAY_DIE                 = 5
};

enum Spells
{
    SPELL_MORTAL_WOUND      = 30641,
    SPELL_SURGE             = 34645,
    SPELL_RETALIATION       = 22857
};

enum Misc
{
    NPC_HELLFIRE_WATCHER    = 17309,

    EVENT_MORTAL_WOUND      = 1,
    EVENT_SURGE             = 2,
    EVENT_RETALIATION       = 3,
    EVENT_KILL_TALK         = 4,
    EVENT_CHECK_HEALTH      = 5
};

class boss_watchkeeper_gargolmar : public CreatureScript
{
public:
    boss_watchkeeper_gargolmar() : CreatureScript("boss_watchkeeper_gargolmar") { }

    struct boss_watchkeeper_gargolmarAI : public BossAI
    {
        boss_watchkeeper_gargolmarAI(Creature* creature) : BossAI(creature, DATA_WATCHKEEPER_GARGOLMAR)
        {
            _taunted = false;
        }

        void Reset() override
        {
            BossAI::Reset();
        }

        void EnterCombat(Unit* who) override
        {
            Talk(SAY_AGGRO);
            BossAI::EnterCombat(who);
            events.ScheduleEvent(EVENT_MORTAL_WOUND, 5000);
            events.ScheduleEvent(EVENT_SURGE, 3000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
            events.ScheduleEvent(EVENT_RETALIATION, 1000);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!_taunted)
            {
                if (who->GetTypeId() == TYPEID_PLAYER)
                {
                    _taunted = true;
                    Talk(SAY_TAUNT);
                }
            }

            BossAI::MoveInLineOfSight(who);
        }

        void KilledUnit(Unit*) override
        {
            if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(SAY_KILL);
                events.ScheduleEvent(EVENT_KILL_TALK, 6000);
            }
        }

        void JustDied(Unit* killer) override
        {
            Talk(SAY_DIE);
            BossAI::JustDied(killer);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_MORTAL_WOUND:
                    me->CastSpell(me->GetVictim(), SPELL_MORTAL_WOUND, false);
                    events.ScheduleEvent(EVENT_MORTAL_WOUND, 8000);
                    break;
                case EVENT_SURGE:
                    Talk(SAY_SURGE);
                    if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0))
                        me->CastSpell(target, SPELL_SURGE, false);
                    events.ScheduleEvent(EVENT_SURGE, 11000);
                    break;
                case EVENT_RETALIATION:
                    if (me->HealthBelowPct(20))
                    {
                        me->CastSpell(me, SPELL_RETALIATION, false);
                        events.ScheduleEvent(EVENT_RETALIATION, 30000);
                    }
                    else
                        events.ScheduleEvent(EVENT_RETALIATION, 500);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (me->HealthBelowPct(50))
                    {
                        Talk(SAY_HEAL);
                        std::list<Creature*> clist;
                        me->GetCreaturesWithEntryInRange(clist, 100.0f, NPC_HELLFIRE_WATCHER);
                        for (std::list<Creature*>::const_iterator itr = clist.begin(); itr != clist.end(); ++itr)
                            (*itr)->AI()->SetData(NPC_HELLFIRE_WATCHER, 0);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH, 500);
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        bool _taunted;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHellfireRampartsAI<boss_watchkeeper_gargolmarAI>(creature);
    }
};

void AddSC_boss_watchkeeper_gargolmar()
{
    new boss_watchkeeper_gargolmar();
}
