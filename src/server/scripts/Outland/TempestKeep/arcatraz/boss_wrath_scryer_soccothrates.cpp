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
#include "arcatraz.h"

enum Say
{
    // Wrath-Scryer Soccothrates
    SAY_AGGRO                       = 1,
    SAY_SLAY                        = 2,
    SAY_KNOCK_AWAY                  = 3,
    SAY_DEATH                       = 4,
    SAY_DALLIAH_DEATH               = 6,
    SAY_SOCCOTHRATES_CONVO_1        = 7,
    SAY_SOCCOTHRATES_CONVO_2        = 8,
    SAY_SOCCOTHRATES_CONVO_3        = 9,
    SAY_SOCCOTHRATES_CONVO_4        = 10,

    // Dalliah the Doomsayer
    SAY_AGGRO_SOCCOTHRATES_FIRST    = 0,
    SAY_SOCCOTHRATES_25_PERCENT     = 6,
    SAY_DALLIAH_CONVO_1             = 8,
    SAY_DALLIAH_CONVO_2             = 9,
    SAY_DALLIAH_CONVO_3             = 10
};

enum Spells
{
    SPELL_FEL_IMMOLATION            = 36051,
    SPELL_FELFIRE_SHOCK             = 35759,
    SPELL_KNOCK_AWAY                = 36512,
    SPELL_FELFIRE                   = 35769,
    SPELL_CHARGE                    = 35754
};

enum Events
{
    EVENT_FELFIRE_SHOCK             = 1,
    EVENT_KNOCK_AWAY                = 2,

    EVENT_PREFIGHT_1                = 3,
    EVENT_PREFIGHT_2                = 4,
    EVENT_PREFIGHT_3                = 5,
    EVENT_PREFIGHT_4                = 6,
    EVENT_PREFIGHT_5                = 7,
    EVENT_PREFIGHT_6                = 8,
    EVENT_PREFIGHT_7                = 9,
    EVENT_PREFIGHT_8                = 10,
    EVENT_PREFIGHT_9                = 11,
    EVENT_ME_FIRST                  = 12,
    EVENT_DALLIAH_DEATH             = 13,
    EVENT_CHECK_HEALTH              = 14,
    EVENT_SPELL_CHARGE              = 15,
    EVENT_FELFIRE                   = 16,
};

class boss_wrath_scryer_soccothrates : public CreatureScript
{
public:
    boss_wrath_scryer_soccothrates() : CreatureScript("boss_wrath_scryer_soccothrates") { }

    struct boss_wrath_scryer_soccothratesAI : public BossAI
    {
        boss_wrath_scryer_soccothratesAI(Creature* creature) : BossAI(creature, DATA_SOCCOTHRATES)
        {
            preFight = instance->GetBossState(DATA_DALLIAH) == DONE;
        }

        void Reset() override
        {
            _Reset();
            events2.Reset();
            me->CastSpell(me, SPELL_FEL_IMMOLATION, true);
            me->SetImmuneToAll(false);
        }

        void InitializeAI() override
        {
            BossAI::InitializeAI();
            if (!preFight)
                me->SetImmuneToAll(true);
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_DEATH);

            if (Creature* dalliah = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_DALLIAH)))
                if (dalliah->IsAlive() && !dalliah->IsInCombat())
                    dalliah->AI()->SetData(1, 1);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events2.Reset();
            events.ScheduleEvent(EVENT_FELFIRE_SHOCK, urand(12000, 14000));
            events.ScheduleEvent(EVENT_KNOCK_AWAY, urand(11000, 12000));
            events.ScheduleEvent(EVENT_ME_FIRST, 6000);
            events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
            Talk(SAY_AGGRO);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!preFight && who->GetTypeId() == TYPEID_PLAYER && me->IsWithinDistInMap(who, 70.0f))
            {
                Talk(SAY_SOCCOTHRATES_CONVO_1);
                events2.ScheduleEvent(EVENT_PREFIGHT_1, 2000);
                preFight = true;
            }
        }

        void SetData(uint32 /*type*/, uint32 data) override
        {
            if (data == 1)
                events2.RescheduleEvent(EVENT_DALLIAH_DEATH, 6000);
        }

        void UpdateAI(uint32 diff) override
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case EVENT_PREFIGHT_1:
                    if (Creature* dalliah = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_DALLIAH)))
                        dalliah->AI()->Talk(SAY_DALLIAH_CONVO_1);
                    events2.ScheduleEvent(EVENT_PREFIGHT_2, 3000);
                    break;
                case EVENT_PREFIGHT_2:
                    Talk(SAY_SOCCOTHRATES_CONVO_2);
                    events2.ScheduleEvent(EVENT_PREFIGHT_3, 3000);
                    break;
                case EVENT_PREFIGHT_3:
                    if (Creature* dalliah = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_DALLIAH)))
                        dalliah->AI()->Talk(SAY_DALLIAH_CONVO_2);
                    events2.ScheduleEvent(EVENT_PREFIGHT_4, 6000);
                    break;
                case EVENT_PREFIGHT_4:
                    Talk(SAY_SOCCOTHRATES_CONVO_3);
                    events2.ScheduleEvent(EVENT_PREFIGHT_5, 2000);
                    break;
                case EVENT_PREFIGHT_5:
                    if (Creature* dalliah = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_DALLIAH)))
                        dalliah->AI()->Talk(SAY_DALLIAH_CONVO_3);
                    events2.ScheduleEvent(EVENT_PREFIGHT_6, 3000);
                    break;
                case EVENT_PREFIGHT_6:
                    Talk(SAY_SOCCOTHRATES_CONVO_4);
                    events2.ScheduleEvent(EVENT_PREFIGHT_7, 2000);
                    break;
                case EVENT_PREFIGHT_7:
                    if (Creature* dalliah = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_DALLIAH)))
                        dalliah->GetMotionMaster()->MovePoint(0, 118.6048f, 96.84852f, 22.44115f);
                    events2.ScheduleEvent(EVENT_PREFIGHT_8, 4000);
                    break;
                case EVENT_PREFIGHT_8:
                    me->GetMotionMaster()->MovePoint(0, 122.1035f, 192.7203f, 22.44115f);
                    events2.ScheduleEvent(EVENT_PREFIGHT_9, 4000);
                    break;
                case EVENT_PREFIGHT_9:
                    if (Creature* dalliah = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_DALLIAH)))
                    {
                        dalliah->SetFacingToObject(me);
                        dalliah->SetImmuneToAll(false);
                        me->SetFacingToObject(dalliah);
                        me->SetImmuneToAll(false);
                        dalliah->SetHomePosition(dalliah->GetPositionX(), dalliah->GetPositionY(), dalliah->GetPositionZ(), 1.51737f);
                        me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 4.725722f);
                    }
                    break;
                case EVENT_DALLIAH_DEATH:
                    Talk(SAY_DALLIAH_DEATH);
                    break;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_FELFIRE_SHOCK:
                    me->CastSpell(me->GetVictim(), SPELL_FELFIRE_SHOCK, false);
                    events.ScheduleEvent(EVENT_FELFIRE_SHOCK, urand(12000, 14000));
                    break;
                case EVENT_KNOCK_AWAY:
                    me->CastSpell(me, SPELL_KNOCK_AWAY, false);
                    Talk(SAY_KNOCK_AWAY);
                    events.ScheduleEvent(EVENT_KNOCK_AWAY, urand(11000, 12000));
                    events.ScheduleEvent(EVENT_SPELL_CHARGE, 4600);
                    break;
                case EVENT_SPELL_CHARGE:
                    me->CastSpell(me, SPELL_CHARGE, true);
                    me->CastSpell(me, SPELL_FELFIRE, true);
                    events.ScheduleEvent(EVENT_FELFIRE, 300);
                    events.ScheduleEvent(EVENT_FELFIRE, 600);
                    events.ScheduleEvent(EVENT_FELFIRE, 900);
                    events.ScheduleEvent(EVENT_FELFIRE, 1200);
                    events.ScheduleEvent(EVENT_FELFIRE, 1500);
                    events.ScheduleEvent(EVENT_FELFIRE, 1800);
                    break;
                case EVENT_FELFIRE:
                    me->CastSpell(me, SPELL_FELFIRE, true);
                    break;
                case EVENT_ME_FIRST:
                    if (Creature* dalliah = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_DALLIAH)))
                        if (dalliah->IsAlive() && !dalliah->IsInCombat())
                            dalliah->AI()->Talk(SAY_AGGRO_SOCCOTHRATES_FIRST);
                    break;
                case EVENT_CHECK_HEALTH:
                    if (HealthBelowPct(25))
                    {
                        if (Creature* dalliah = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_DALLIAH)))
                            dalliah->AI()->Talk(SAY_SOCCOTHRATES_25_PERCENT);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        bool preFight;
        EventMap events2;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetArcatrazAI<boss_wrath_scryer_soccothratesAI>(creature);
    }
};

void AddSC_boss_wrath_scryer_soccothrates()
{
    new boss_wrath_scryer_soccothrates();
}
