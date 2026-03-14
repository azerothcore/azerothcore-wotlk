/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
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
    EVENT_PREFIGHT_1                = 3,
    EVENT_PREFIGHT_2                = 4,
    EVENT_PREFIGHT_3                = 5,
    EVENT_PREFIGHT_4                = 6,
    EVENT_PREFIGHT_5                = 7,
    EVENT_PREFIGHT_6                = 8,
    EVENT_PREFIGHT_7                = 9,
    EVENT_PREFIGHT_8                = 10,
    EVENT_PREFIGHT_9                = 11
};

struct boss_wrath_scryer_soccothrates : public BossAI
{
    boss_wrath_scryer_soccothrates(Creature* creature) : BossAI(creature, DATA_SOCCOTHRATES)
    {
        preFight = instance->GetBossState(DATA_DALLIAH) == DONE;
    }

    void Reset() override
    {
        _Reset();
        events2.Reset();
        me->CastSpell(me, SPELL_FEL_IMMOLATION, true);

        ScheduleHealthCheckEvent(25, [&]
        {
            if (Creature* dalliah = instance->GetCreature(DATA_DALLIAH))
            {
                if (dalliah->IsAlive())
                {
                    dalliah->AI()->Talk(SAY_SOCCOTHRATES_25_PERCENT);
                }
            }
        });
    }

    void InitializeAI() override
    {
        BossAI::InitializeAI();
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);

        if (Creature* dalliah = instance->GetCreature(DATA_DALLIAH))
        {
            if (dalliah->IsAlive() && !dalliah->IsInCombat())
            {
                dalliah->AI()->Talk(SAY_RIVAL_DIED + 1, 6s);
            }
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        events2.Reset();

        Talk(SAY_AGGRO);

        if (Creature* dalliah = instance->GetCreature(DATA_DALLIAH))
        {
            if (dalliah->IsAlive() && !dalliah->IsInCombat())
            {
                dalliah->AI()->Talk(SAY_AGGRO_SOCCOTHRATES_FIRST, 6s);
            }
        }

        scheduler.Schedule(30s, 35s, [this](TaskContext context)
        {
            scheduler.DelayAll(5s);
            me->CastSpell(me, SPELL_KNOCK_AWAY, false);
            Talk(SAY_KNOCK_AWAY);
            me->HandleEmoteCommand(EMOTE_ONESHOT_POINT);

            scheduler.Schedule(4600ms, [this](TaskContext)
            {
                DoCastAOE(SPELL_CHARGE);
                DoCastSelf(SPELL_FELFIRE, true);

                scheduler.Schedule(300ms, [this](TaskContext context2)
                {
                    DoCastAOE(SPELL_FELFIRE, true);

                    if (context2.GetRepeatCounter() <= 6)
                    {
                        context2.Repeat();
                    }
                });
            });

            context.Repeat(20s, 35s);
        }).Schedule(8500ms, 22s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_FELFIRE_SHOCK);
            context.Repeat();
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!preFight && who->IsPlayer() && me->IsWithinDistInMap(who, 70.0f))
        {
            Talk(SAY_SOCCOTHRATES_CONVO_1);
            events2.ScheduleEvent(EVENT_PREFIGHT_1, 2s);
            preFight = true;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        events2.Update(diff);
        switch (events2.ExecuteEvent())
        {
        case EVENT_PREFIGHT_1:
            if (Creature* dalliah = instance->GetCreature(DATA_DALLIAH))
                dalliah->AI()->Talk(SAY_DALLIAH_CONVO_1);
            events2.ScheduleEvent(EVENT_PREFIGHT_2, 3s);
            break;
        case EVENT_PREFIGHT_2:
            Talk(SAY_SOCCOTHRATES_CONVO_2);
            events2.ScheduleEvent(EVENT_PREFIGHT_3, 3s);
            break;
        case EVENT_PREFIGHT_3:
            if (Creature* dalliah = instance->GetCreature(DATA_DALLIAH))
                dalliah->AI()->Talk(SAY_DALLIAH_CONVO_2);
            events2.ScheduleEvent(EVENT_PREFIGHT_4, 6s);
            break;
        case EVENT_PREFIGHT_4:
            Talk(SAY_SOCCOTHRATES_CONVO_3);
            events2.ScheduleEvent(EVENT_PREFIGHT_5, 2s);
            break;
        case EVENT_PREFIGHT_5:
            if (Creature* dalliah = instance->GetCreature(DATA_DALLIAH))
                dalliah->AI()->Talk(SAY_DALLIAH_CONVO_3);
            events2.ScheduleEvent(EVENT_PREFIGHT_6, 3s);
            break;
        case EVENT_PREFIGHT_6:
            Talk(SAY_SOCCOTHRATES_CONVO_4);
            events2.ScheduleEvent(EVENT_PREFIGHT_7, 2s);
            break;
        case EVENT_PREFIGHT_7:
            if (Creature* dalliah = instance->GetCreature(DATA_DALLIAH))
                dalliah->GetMotionMaster()->MovePoint(0, 118.6048f, 96.84852f, 22.44115f);
            events2.ScheduleEvent(EVENT_PREFIGHT_8, 4s);
            break;
        case EVENT_PREFIGHT_8:
            me->GetMotionMaster()->MovePoint(0, 122.1035f, 192.7203f, 22.44115f);
            events2.ScheduleEvent(EVENT_PREFIGHT_9, 4s);
            break;
        case EVENT_PREFIGHT_9:
            if (Creature* dalliah = instance->GetCreature(DATA_DALLIAH))
            {
                dalliah->SetFacingToObject(me);
                dalliah->SetImmuneToAll(false);
                me->SetFacingToObject(dalliah);
                me->SetImmuneToAll(false);
                dalliah->SetHomePosition(dalliah->GetPositionX(), dalliah->GetPositionY(), dalliah->GetPositionZ(), 1.51737f);
                me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 4.725722f);
            }
            break;
        }

        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }

private:
    bool preFight;
    EventMap events2;
};

void AddSC_boss_wrath_scryer_soccothrates()
{
    RegisterArcatrazCreatureAI(boss_wrath_scryer_soccothrates);
}
