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

enum Says
{
    SAY_INTRO                   = 0,
    SAY_AGGRO                   = 1,
    SAY_KILL                    = 2,
    SAY_MIND                    = 3,
    SAY_FEAR                    = 4,
    SAY_IMAGE                   = 5,
    SAY_DEATH                   = 6
};

enum Spells
{
    SPELL_FEAR                  = 39415,
    SPELL_MIND_REND             = 36924,
    SPELL_DOMINATION            = 37162,
    SPELL_MANA_BURN             = 39020,
    SPELL_66_ILLUSION           = 36931,
    SPELL_33_ILLUSION           = 36932,

    SPELL_MIND_REND_IMAGE   = 36929,
    H_SPELL_MIND_REND_IMAGE = 39021
};

enum Misc
{
    NPC_HARBINGER_SKYRISS_66    = 21466,

    EVENT_SUMMON_IMAGE1         = 1,
    EVENT_SUMMON_IMAGE2         = 2,
    EVENT_SPELL_MIND_REND       = 3,
    EVENT_SPELL_FEAR            = 4,
    EVENT_SPELL_DOMINATION      = 5,
    EVENT_SPELL_MANA_BURN       = 6
};

class boss_harbinger_skyriss : public CreatureScript
{
public:
    boss_harbinger_skyriss() : CreatureScript("boss_harbinger_skyriss") { }

    struct boss_harbinger_skyrissAI : public ScriptedAI
    {
        boss_harbinger_skyrissAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        SummonList summons;
        EventMap events;

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
            me->SetImmuneToAll(false);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            me->SetInCombatWithZone();

            events.ScheduleEvent(EVENT_SUMMON_IMAGE1, 1000);
            events.ScheduleEvent(EVENT_SUMMON_IMAGE2, 1000);
            events.ScheduleEvent(EVENT_SPELL_MIND_REND, 10000);
            events.ScheduleEvent(EVENT_SPELL_FEAR, 15000);
            events.ScheduleEvent(EVENT_SPELL_DOMINATION, 30000);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_MANA_BURN, 25000);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            summons.DespawnAll();
        }

        void JustSummoned(Creature* summon) override
        {
            summon->SetHealth(summon->CountPctFromMaxHealth(summon->GetEntry() == NPC_HARBINGER_SKYRISS_66 ? 66 : 33));
            summons.Summon(summon);
            summon->SetInCombatWithZone();
            me->UpdatePosition(*summon, true);
            me->SendMovementFlagUpdate();
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_KILL);
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
                case EVENT_SUMMON_IMAGE1:
                    if (HealthBelowPct(67))
                    {
                        Talk(SAY_IMAGE);
                        me->CastSpell(me, SPELL_66_ILLUSION, false);
                        break;
                    }
                    events.ScheduleEvent(EVENT_SUMMON_IMAGE1, 1000);
                    break;
                case EVENT_SUMMON_IMAGE2:
                    if (HealthBelowPct(34))
                    {
                        Talk(SAY_IMAGE);
                        me->CastSpell(me, SPELL_33_ILLUSION, false);
                        break;
                    }
                    events.ScheduleEvent(EVENT_SUMMON_IMAGE2, 1000);
                    break;
                case EVENT_SPELL_MIND_REND:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f))
                        me->CastSpell(target, SPELL_MIND_REND, false);
                    events.ScheduleEvent(EVENT_SPELL_MIND_REND, 10000);
                    break;
                case EVENT_SPELL_FEAR:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 20.0f))
                    {
                        Talk(SAY_FEAR);
                        me->CastSpell(target, SPELL_FEAR, false);
                    }
                    events.ScheduleEvent(EVENT_SPELL_FEAR, 25000);
                    break;
                case EVENT_SPELL_DOMINATION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 30.0f))
                    {
                        Talk(SAY_MIND);
                        me->CastSpell(target, SPELL_DOMINATION, false);
                    }
                    events.ScheduleEvent(EVENT_SPELL_DOMINATION, 30000);
                    break;
                case EVENT_SPELL_MANA_BURN:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, POWER_MANA, 40.0f, false)))
                        me->CastSpell(target, SPELL_MANA_BURN, false);
                    events.ScheduleEvent(EVENT_SPELL_MANA_BURN, 30000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetArcatrazAI<boss_harbinger_skyrissAI>(creature);
    }
};

void AddSC_boss_harbinger_skyriss()
{
    new boss_harbinger_skyriss();
}
