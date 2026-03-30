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
#include "SpellScript.h"
#include "temple_of_ahnqiraj.h"

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_DEATH                       = 2
};

enum Spells
{
    // Battleguard Sartura
    SPELL_WHIRLWIND                 = 26083, // MechanicImmunity->Stunned (15sec)
    SPELL_ENRAGE                    = 8269,
    SPELL_BERSERK                   = 27680,
    SPELL_SUNDERING_CLEAVE          = 25174,
    // Sartura's Royal Guard
    SPELL_GUARD_WHIRLWIND           = 26038,
    SPELL_GUARD_KNOCKBACK           = 26027
};

enum events
{
    // Battleguard Sartura
    EVENT_SARTURA_WHIRLWIND         = 1,
    EVENT_SARTURA_WHIRLWIND_RANDOM,
    EVENT_SARTURA_WHIRLWIND_END,
    EVENT_SPELL_BERSERK,
    EVENT_SARTURA_SUNDERING_CLEAVE,
    // Sartura's Royal Guard
    EVENT_GUARD_WHIRLWIND,
    EVENT_GUARD_WHIRLWIND_RANDOM,
    EVENT_GUARD_WHIRLWIND_END,
    EVENT_GUARD_KNOCKBACK,
};

struct boss_sartura : public BossAI
{
    boss_sartura(Creature* creature) : BossAI(creature, DATA_SARTURA) {}

    void InitializeAI() override
    {
        me->m_CombatDistance = 60.f;
        me->m_SightDistance = 60.f;
        Reset();
    }

    void Reset() override
    {
        _Reset();
        enraged = false;
        berserked = false;

        me->SetReactState(REACT_AGGRESSIVE);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND, 12s, 22s);
        events.ScheduleEvent(EVENT_SPELL_BERSERK, 10min);
        events.ScheduleEvent(EVENT_SARTURA_SUNDERING_CLEAVE, 2400ms, 3s);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_SLAY);
    }

    void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
    {
        if (!enraged && HealthBelowPct(20))
        {
            DoCastSelf(SPELL_ENRAGE);
            enraged = true;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_SARTURA_WHIRLWIND:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true, false))
                    {
                        me->GetThreatMgr().ResetAllThreat();
                        me->AddThreat(target, 1000.0f);
                    }
                    DoCastSelf(SPELL_WHIRLWIND);
                    events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND_RANDOM, 2s, 7s);
                    events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND_END, 15s);
                    break;
                case EVENT_SARTURA_WHIRLWIND_RANDOM:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                    {
                        me->GetThreatMgr().ResetAllThreat();
                        me->AddThreat(target, 1000.0f);
                    }
                    events.Repeat(2s, 7s);
                    break;
                case EVENT_SARTURA_WHIRLWIND_END:
                    me->GetThreatMgr().ResetAllThreat();
                    me->SetReactState(REACT_AGGRESSIVE);
                    events.CancelEvent(EVENT_SARTURA_WHIRLWIND_RANDOM);
                    events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND, 5s, 11s);
                    break;
                case EVENT_SPELL_BERSERK:
                    if (!berserked)
                    {
                        DoCastSelf(SPELL_BERSERK, true);
                        berserked = true;
                    }
                    break;
                case EVENT_SARTURA_SUNDERING_CLEAVE:
                    if (me->HasReactState(REACT_PASSIVE))
                    {
                        Milliseconds whirlwindTimer = events.GetTimeUntilEvent(EVENT_SARTURA_WHIRLWIND_END);
                        events.RescheduleEvent(EVENT_SARTURA_SUNDERING_CLEAVE, whirlwindTimer + 500ms);
                    }
                    else
                    {
                        DoCastVictim(SPELL_SUNDERING_CLEAVE, false);
                        events.RescheduleEvent(EVENT_SARTURA_SUNDERING_CLEAVE, 2400ms, 3s);
                    }
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    };

    private:
        bool enraged;
        bool berserked;
};

struct npc_sartura_royal_guard : public ScriptedAI
{
    npc_sartura_royal_guard(Creature* creature) : ScriptedAI(creature) {}

    void Reset() override
    {
        events.Reset();

        me->SetReactState(REACT_AGGRESSIVE);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        events.ScheduleEvent(EVENT_GUARD_WHIRLWIND, 6s, 10s);
        events.ScheduleEvent(EVENT_GUARD_KNOCKBACK, 12s, 16s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        while (uint32 eventid = events.ExecuteEvent())
        {
            switch (eventid)
            {
                case EVENT_GUARD_WHIRLWIND:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true, false))
                    {
                        me->GetThreatMgr().ResetAllThreat();
                        me->AddThreat(target, 1000.0f);
                    }
                    DoCastSelf(SPELL_GUARD_WHIRLWIND);
                    events.ScheduleEvent(EVENT_GUARD_WHIRLWIND_RANDOM, 2s, 7s);
                    events.ScheduleEvent(EVENT_GUARD_WHIRLWIND_END, 8s);
                    break;
                case EVENT_GUARD_WHIRLWIND_RANDOM:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                    {
                        me->GetThreatMgr().ResetAllThreat();
                        me->AddThreat(target, 1000.0f);
                    }
                    events.Repeat(2s, 7s);
                    break;
                case EVENT_GUARD_WHIRLWIND_END:
                    me->GetThreatMgr().ResetAllThreat();
                    me->SetReactState(REACT_AGGRESSIVE);
                    events.CancelEvent(EVENT_GUARD_WHIRLWIND_RANDOM);
                    events.ScheduleEvent(EVENT_GUARD_WHIRLWIND, 500ms, 9s);
                    break;
                case EVENT_GUARD_KNOCKBACK:
                    DoCastVictim(SPELL_GUARD_KNOCKBACK);
                    events.Repeat(21s, 37s);
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_sartura()
{
    RegisterTempleOfAhnQirajCreatureAI(boss_sartura);
    RegisterTempleOfAhnQirajCreatureAI(npc_sartura_royal_guard);
}
