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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Spells
{
    // Sulfuron Harbringer
    SPELL_DEMORALIZING_SHOUT    = 19778,
    SPELL_INSPIRE               = 19779,
    SPELL_KNOCKDOWN             = 19780,
    SPELL_FLAMESPEAR            = 19781,

    // Adds
    SPELL_DARK_MENDING          = 19775,
    SPELL_SHADOW_WORD_PAIN      = 19776,
    SPELL_DARK_STRIKE           = 19777,
    SPELL_IMMOLATE              = 20294,
};

enum Events
{
    EVENT_DEMORALIZING_SHOUT    = 1,
    EVENT_INSPIRE,
    EVENT_KNOCKDOWN,
    EVENT_FLAMESPEAR,

    EVENT_DARK_MENDING,
    EVENT_SHADOW_WORD_PAIN,
    EVENT_DARK_STRIKE,
    EVENT_IMMOLATE,
};

class boss_sulfuron : public CreatureScript
{
public:
    boss_sulfuron() : CreatureScript("boss_sulfuron") {}

    struct boss_sulfuronAI : public BossAI
    {
        boss_sulfuronAI(Creature* creature) : BossAI(creature, DATA_SULFURON) {}

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(EVENT_DEMORALIZING_SHOUT, 6s, 20s);
            events.ScheduleEvent(EVENT_INSPIRE, 7s, 10s);
            events.ScheduleEvent(EVENT_KNOCKDOWN, 6s);
            events.ScheduleEvent(EVENT_FLAMESPEAR, 2s);
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_DEMORALIZING_SHOUT:
                {
                    DoCastVictim(SPELL_DEMORALIZING_SHOUT);
                    events.RepeatEvent(urand(12000, 18000));
                    break;
                }
                case EVENT_INSPIRE:
                {
                    std::list<Creature*> healers = DoFindFriendlyMissingBuff(45.0f, SPELL_INSPIRE);
                    if (!healers.empty())
                    {
                        DoCast(Acore::Containers::SelectRandomContainerElement(healers), SPELL_INSPIRE);
                    }

                    DoCastSelf(SPELL_INSPIRE);
                    events.RepeatEvent(urand(13000, 20000));
                    break;
                }
                case EVENT_KNOCKDOWN:
                {
                    DoCastVictim(SPELL_KNOCKDOWN);
                    events.RepeatEvent(urand(10000, 20000));
                    break;
                }
                case EVENT_FLAMESPEAR:
                {
                    DoCastRandomTarget(SPELL_FLAMESPEAR);
                    events.RepeatEvent(urand(12000, 16000));
                    break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_sulfuronAI>(creature);
    }
};

class npc_flamewaker_priest : public CreatureScript
{
public:
    npc_flamewaker_priest() : CreatureScript("npc_flamewaker_priest") {}

    struct npc_flamewaker_priestAI : public ScriptedAI
    {
        npc_flamewaker_priestAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset() override
        {
            events.Reset();
        }

        void JustDied(Unit* /*killer*/) override
        {
            events.Reset();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_DARK_STRIKE, 4s, 7s);
            events.ScheduleEvent(EVENT_DARK_MENDING, 15s, 30s);
            events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, 2s, 4s);
            events.ScheduleEvent(EVENT_IMMOLATE, 3500ms, 6000ms);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_DARK_STRIKE:
                    {
                        DoCastVictim(SPELL_DARK_STRIKE);
                        events.RepeatEvent(urand(4000, 7000));
                        break;
                    }
                    case EVENT_DARK_MENDING:
                    {
                        if (Unit* target = DoSelectLowestHpFriendly(60.0f, 1))
                        {
                            if (target->GetGUID() != me->GetGUID())
                            {
                                DoCast(target, SPELL_DARK_MENDING);
                            }
                        }
                        events.RepeatEvent(urand(15000, 20000));
                        break;
                    }
                    case EVENT_SHADOW_WORD_PAIN:
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, true, -SPELL_SHADOW_WORD_PAIN))
                        {
                            DoCast(target, SPELL_SHADOW_WORD_PAIN);
                        }
                        events.RepeatEvent(urand(2500, 5000));
                        break;
                    }
                    case EVENT_IMMOLATE:
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, true, -SPELL_IMMOLATE))
                        {
                            DoCast(target, SPELL_IMMOLATE);
                        }
                        events.RepeatEvent(urand(5000, 7000));
                        break;
                    }
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<npc_flamewaker_priestAI>(creature);
    }
};

void AddSC_boss_sulfuron()
{
    new boss_sulfuron();
    new npc_flamewaker_priest();
}
