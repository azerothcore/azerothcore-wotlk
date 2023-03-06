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
#include "SpellScript.h"
#include "sethekk_halls.h"

enum Anzu
{
    SAY_ANZU_INTRO1             = 0,
    SAY_ANZU_INTRO2             = 1,
    SAY_SUMMON                  = 2,

    SPELL_PARALYZING_SCREECH    = 40184,
    SPELL_SPELL_BOMB            = 40303,
    SPELL_CYCLONE               = 40321,
    SPELL_BANISH_SELF           = 42354,
    SPELL_SHADOWFORM            = 40973,

    EVENT_SPELL_SCREECH         = 1,
    EVENT_SPELL_BOMB            = 2,
    EVENT_SPELL_CYCLONE         = 3,
    EVENT_ANZU_HEALTH1          = 4,
    EVENT_ANZU_HEALTH2          = 5
};

struct boss_anzu : public BossAI
{
    boss_anzu(Creature* creature) : BossAI(creature, DATA_ANZU)
    {
        talkTimer = 1;
        me->ReplaceAllUnitFlags(UNIT_FLAG_NON_ATTACKABLE);
        me->AddAura(SPELL_SHADOWFORM, me);
    }

    uint32 talkTimer;

    void SummonedCreatureDies(Creature* summon, Unit*) override
    {
        summons.Despawn(summon);
        summons.RemoveNotExisting();
        if (summons.empty())
            me->RemoveAurasDueToSpell(SPELL_BANISH_SELF);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        events.Reset();
        events.ScheduleEvent(EVENT_SPELL_SCREECH, 14000);
        events.ScheduleEvent(EVENT_SPELL_BOMB, 5000);
        events.ScheduleEvent(EVENT_SPELL_CYCLONE, 8000);
        events.ScheduleEvent(EVENT_ANZU_HEALTH1, 2000);
        events.ScheduleEvent(EVENT_ANZU_HEALTH2, 2001);
    }

    void SummonBroods()
    {
        Talk(SAY_SUMMON);
        me->CastSpell(me, SPELL_BANISH_SELF, true);
        for (uint8 i = 0; i < 5; ++i)
            me->SummonCreature(23132 /*NPC_BROOD_OF_ANZU*/, me->GetPositionX() + 20 * cos((float)i), me->GetPositionY() + 20 * std::sin((float)i), me->GetPositionZ() + 25.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
    }

    void UpdateAI(uint32 diff) override
    {
        if (talkTimer)
        {
            talkTimer += diff;
            if (talkTimer >= 1000 && talkTimer < 10000)
            {
                Talk(SAY_ANZU_INTRO1);
                talkTimer = 10000;
            }
            else if (talkTimer >= 16000)
            {
                me->ReplaceAllUnitFlags(UNIT_FLAG_NONE);
                me->RemoveAurasDueToSpell(SPELL_SHADOWFORM);
                Talk(SAY_ANZU_INTRO2);
                talkTimer = 0;
            }
        }

        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING | UNIT_STATE_STUNNED))
            return;

        switch (events.ExecuteEvent())
        {
        case EVENT_SPELL_SCREECH:
            me->CastSpell(me, SPELL_PARALYZING_SCREECH, false);
            events.RepeatEvent(23000);
            events.DelayEvents(3000);
            break;
        case EVENT_SPELL_BOMB:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                me->CastSpell(target, SPELL_SPELL_BOMB, false);
            events.RepeatEvent(urand(16000, 24500));
            events.DelayEvents(3000);
            break;
        case EVENT_SPELL_CYCLONE:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 45.0f, true))
                me->CastSpell(target, SPELL_CYCLONE, false);
            events.RepeatEvent(urand(22000, 27000));
            events.DelayEvents(3000);
            break;
        case EVENT_ANZU_HEALTH1:
            if (me->HealthBelowPct(66))
            {
                SummonBroods();
                events.DelayEvents(10000);
                return;
            }
            events.RepeatEvent(1000);
            break;
        case EVENT_ANZU_HEALTH2:
            if (me->HealthBelowPct(33))
            {
                SummonBroods();
                events.DelayEvents(10000);
                return;
            }
            events.RepeatEvent(1000);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_anzu()
{
    RegisterSethekkHallsCreatureAI(boss_anzu);
}
