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
#include "blackrock_spire.h"

enum Spells
{
    SPELL_FRENZY                    = 8269,
    SPELL_SUMMON_SPECTRAL_ASSASSIN  = 27249,
    SPELL_SHADOW_BOLT_VOLLEY        = 27382,
    SPELL_SHADOW_WRATH              = 27286
};

enum Says
{
    TALK_SUMMON                     = 0,
    TALK_AGGRO                      = 1,
    TALK_40_HP                      = 2,
    TALK_15_HP                      = 3
};

enum Events
{
    EVENT_SUMMON_SPECTRAL_ASSASSIN  = 1,
    EVENT_SHADOW_BOLT_VOLLEY        = 2,
    EVENT_SHADOW_WRATH              = 3,
    EVENT_FIGHT                     = 4
};

enum EventPhase
{
    EVENT_PHASE_TALK                = 1,
    EVENT_PHASE_FIGHT               = 2
};

class boss_lord_valthalak : public CreatureScript
{
public:
    boss_lord_valthalak() : CreatureScript("boss_lord_valthalak") { }

    struct boss_lord_valthalakAI : public BossAI
    {
        boss_lord_valthalakAI(Creature* creature) : BossAI(creature, DATA_LORD_VALTHALAK) { }

        void Reset() override
        {
            BossAI::Reset();

            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);

            frenzy40 = false;
            frenzy15 = false;
        }

        void IsSummonedBy(WorldObject* /*summoner*/) override
        {
            StartTalking(TALK_SUMMON, 8s);
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);

            Talk(TALK_AGGRO);

            events.SetPhase(EVENT_PHASE_FIGHT);
            events.ScheduleEvent(EVENT_SUMMON_SPECTRAL_ASSASSIN, 6s, 8s, 0, EVENT_PHASE_FIGHT);
            events.ScheduleEvent(EVENT_SHADOW_WRATH, 9s, 18s, 0, EVENT_PHASE_FIGHT);
        }

        void JustDied(Unit* killer) override
        {
            BossAI::JustDied(killer);

            instance->SetData(DATA_LORD_VALTHALAK, DONE);
        }

        void StartTalking(uint32 talkGroupId, Milliseconds timer)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->AttackStop();

            Talk(talkGroupId);

            events.SetPhase(EVENT_PHASE_TALK);
            events.ScheduleEvent(EVENT_FIGHT, timer, 0, EVENT_PHASE_TALK);
        }

        void StartFighting()
        {
            events.SetPhase(EVENT_PHASE_FIGHT);

            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);

            DoZoneInCombat();
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellSchoolMask /*school*/) override
        {
            if (!frenzy40 && me->HealthBelowPctDamaged(40, damage))
            {
                frenzy40 = true;
                DoCast(me, SPELL_FRENZY);

                events.CancelEvent(EVENT_SUMMON_SPECTRAL_ASSASSIN);

                StartTalking(TALK_40_HP, 5s);
            }

            if (!frenzy15 && me->HealthBelowPctDamaged(15, damage))
            {
                frenzy15 = true;

                events.ScheduleEvent(EVENT_SHADOW_BOLT_VOLLEY, 12s, 19s, 0, EVENT_PHASE_FIGHT);

                StartTalking(TALK_15_HP, 5s);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() && !events.IsInPhase(EVENT_PHASE_TALK))
            {
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_FIGHT:
                        StartFighting();
                        break;
                    case EVENT_SUMMON_SPECTRAL_ASSASSIN:
                        DoCast(me, SPELL_SUMMON_SPECTRAL_ASSASSIN);
                        events.ScheduleEvent(EVENT_SUMMON_SPECTRAL_ASSASSIN, 30s, 35s, 0, EVENT_PHASE_FIGHT);
                        break;
                    case EVENT_SHADOW_BOLT_VOLLEY:
                        DoCastVictim(SPELL_SHADOW_BOLT_VOLLEY);
                        events.ScheduleEvent(EVENT_SHADOW_BOLT_VOLLEY, 4s, 6s, 0, EVENT_PHASE_FIGHT);
                        break;
                    case EVENT_SHADOW_WRATH:
                        DoCastVictim(SPELL_SHADOW_WRATH);
                        events.ScheduleEvent(EVENT_SHADOW_WRATH, 19s, 24s, 0, EVENT_PHASE_FIGHT);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    private:
        bool frenzy40;
        bool frenzy15;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockSpireAI<boss_lord_valthalakAI>(creature);
    }
};

void AddSC_boss_lord_valthalak()
{
    new boss_lord_valthalak();
}
