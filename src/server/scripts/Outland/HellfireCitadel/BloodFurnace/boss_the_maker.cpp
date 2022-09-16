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
#include "blood_furnace.h"

enum eEnums
{
    SAY_AGGRO                   = 0,
    SAY_KILL                    = 1,
    SAY_DIE                     = 2,

    SPELL_ACID_SPRAY            = 38153,
    SPELL_EXPLODING_BREAKER     = 30925,
    SPELL_KNOCKDOWN             = 20276,
    SPELL_DOMINATION            = 25772,

    EVENT_SPELL_ACID                = 1,
    EVENT_SPELL_EXPLODING           = 2,
    EVENT_SPELL_DOMINATION          = 3,
    EVENT_SPELL_KNOCKDOWN           = 4,
};

class boss_the_maker : public CreatureScript
{
public:
    boss_the_maker() : CreatureScript("boss_the_maker")
    {
    }

    struct boss_the_makerAI : public ScriptedAI
    {
        boss_the_makerAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
            if (!instance)
                return;

            instance->SetData(DATA_THE_MAKER, NOT_STARTED);
            instance->HandleGameObject(instance->GetGuidData(DATA_DOOR2), true);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_ACID, 15000);
            events.ScheduleEvent(EVENT_SPELL_EXPLODING, 6000);
            events.ScheduleEvent(EVENT_SPELL_DOMINATION, 120000);
            events.ScheduleEvent(EVENT_SPELL_KNOCKDOWN, 10000);

            if (!instance)
                return;

            instance->SetData(DATA_THE_MAKER, IN_PROGRESS);
            instance->HandleGameObject(instance->GetGuidData(DATA_DOOR2), false);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER && urand(0, 1))
                Talk(SAY_KILL);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DIE);

            if (!instance)
                return;

            instance->SetData(DATA_THE_MAKER, DONE);
            instance->HandleGameObject(instance->GetGuidData(DATA_DOOR2), true);
            instance->HandleGameObject(instance->GetGuidData(DATA_DOOR3), true);
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
                case EVENT_SPELL_ACID:
                    me->CastSpell(me->GetVictim(), SPELL_ACID_SPRAY, false);
                    events.RepeatEvent(urand(15000, 23000));
                    break;
                case EVENT_SPELL_EXPLODING:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_EXPLODING_BREAKER, false);
                    events.RepeatEvent(urand(7000, 11000));
                    break;
                case EVENT_SPELL_DOMINATION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_DOMINATION, false);
                    events.RepeatEvent(120000);
                    break;
                case EVENT_SPELL_KNOCKDOWN:
                    me->CastSpell(me->GetVictim(), SPELL_KNOCKDOWN, false);
                    events.RepeatEvent(urand(4000, 12000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBloodFurnaceAI<boss_the_makerAI>(creature);
    }
};

void AddSC_boss_the_maker()
{
    new boss_the_maker();
}
