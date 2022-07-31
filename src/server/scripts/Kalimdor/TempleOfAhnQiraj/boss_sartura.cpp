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
#include "SpellScript.h"
#include "ScriptedCreature.h"
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
    EVENT_SARTURA_WHIRLWIND_RANDOM  = 2,
    EVENT_SARTURA_WHIRLWIND_END     = 3,
    EVENT_SPELL_BERSERK             = 4,
    EVENT_SARTURA_AGGRO_RESET       = 5,
    EVENT_SARTURA_AGGRO_RESET_END   = 6,

    // Sartura's Royal Guard
    EVENT_GUARD_WHIRLWIND           = 7,
    EVENT_GUARD_WHIRLWIND_RANDOM    = 8,
    EVENT_GUARD_WHIRLWIND_END       = 9,
    EVENT_GUARD_KNOCKBACK           = 10,
    EVENT_GUARD_AGGRO_RESET         = 11,
    EVENT_GUARD_AGGRO_RESET_END     = 12
};

struct boss_sartura : public BossAI
{
    boss_sartura(Creature* creature) : BossAI(creature, DATA_SARTURA) {}

    void Reset() override
    {
        _Reset();
        whirlwind = false;
        enraged = false;
        berserked = false;
        aggroReset = false;
        MinionReset();
        _savedTargetGUID.Clear();
        _savedTargetThreat = 0.f;
    }

    void MinionReset()
    {
        std::list<Creature*> royalGuards;
        me->GetCreaturesWithEntryInRange(royalGuards, 200.0f, NPC_SARTURA_ROYAL_GUARD);
        for (Creature* minion : royalGuards)
        {
            minion->Respawn();
        }
    }

    void EnterCombat(Unit* who) override
    {
        BossAI::EnterCombat(who);
        Talk(SAY_AGGRO);
        events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND, 30000);
        events.ScheduleEvent(EVENT_SARTURA_AGGRO_RESET, urand(45000, 55000));
        events.ScheduleEvent(EVENT_SPELL_BERSERK, 10 * 60000);
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

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id != SPELL_SUNDERING_CLEAVE)
            return;

        me->RemoveAura(SPELL_SUNDERING_CLEAVE);
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
                    DoCastSelf(SPELL_WHIRLWIND, true);
                    whirlwind = true;
                    events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND_RANDOM, urand(3000, 7000));
                    events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND_END, 15000);
                    break;
                case EVENT_SARTURA_WHIRLWIND_RANDOM:
                    if (whirlwind == true)
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true))
                        {
                            me->AddThreat(target, 1.0f);
                            me->TauntApply(target);
                            AttackStart(target);
                        }
                        events.RepeatEvent(urand(3000, 7000));
                    }
                    break;
                case EVENT_SARTURA_WHIRLWIND_END:
                    events.CancelEvent(EVENT_SARTURA_WHIRLWIND_RANDOM);
                    whirlwind = false;
                    events.ScheduleEvent(EVENT_SARTURA_WHIRLWIND, urand(25000, 40000));
                    break;
                case EVENT_SARTURA_AGGRO_RESET:
                    if (aggroReset == false)
                    {
                        if (Unit* originalTarget = SelectTarget(SelectTargetMethod::Random, 0))
                        {
                            _savedTargetGUID = originalTarget->GetGUID();
                            _savedTargetThreat = me->GetThreatMgr().getThreat(originalTarget);
                            me->GetThreatMgr().modifyThreatPercent(originalTarget, -100);
                        }
                        aggroReset = true;
                        events.ScheduleEvent(EVENT_SARTURA_AGGRO_RESET_END, 5000);
                    }
                    else
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true))
                        {
                            me->AddThreat(target, 1.0f);
                            me->TauntApply(target);
                            AttackStart(target);
                        }
                    }
                    events.RepeatEvent(urand(1000, 2000));
                    break;
                case EVENT_SARTURA_AGGRO_RESET_END:
                    events.CancelEvent(EVENT_SARTURA_AGGRO_RESET);
                    if (Unit* originalTarget = ObjectAccessor::GetUnit(*me, _savedTargetGUID))
                    {
                        me->GetThreatMgr().addThreat(originalTarget, _savedTargetThreat);
                        _savedTargetGUID.Clear();
                    }
                    aggroReset = false;
                    events.RescheduleEvent(EVENT_SARTURA_AGGRO_RESET, urand(30000, 40000));
                    break;
                case EVENT_SPELL_BERSERK:
                    if (!berserked)
                    {
                        DoCastSelf(SPELL_BERSERK);
                        berserked = true;
                    }
                    break;
                default:
                    break;
            }
        }
        DoMeleeAttackIfReady();
    };
    private:
        bool whirlwind;
        bool enraged;
        bool berserked;
        bool aggroReset;
        ObjectGuid _savedTargetGUID;
        float _savedTargetThreat;
};

struct npc_sartura_royal_guard : public ScriptedAI
{
    npc_sartura_royal_guard(Creature* creature) : ScriptedAI(creature) {}

    void Reset()
    {
        events.Reset();
        whirlwind = false;
        aggroReset = false;
        _savedTargetGUID.Clear();
        _savedTargetThreat = 0.f;
    }

    void EnterCombat(Unit* /*who*/)
    {
        events.ScheduleEvent(EVENT_GUARD_WHIRLWIND, 30000);
        events.ScheduleEvent(EVENT_GUARD_AGGRO_RESET, urand(45000, 55000));
        events.ScheduleEvent(EVENT_GUARD_KNOCKBACK, 10000);
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id != SPELL_SUNDERING_CLEAVE)
            return;

        me->RemoveAura(SPELL_SUNDERING_CLEAVE);
    }

    void UpdateAI(uint32 diff)
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        while (uint32 eventid = events.ExecuteEvent())
        {
            switch (eventid)
            {
                case EVENT_GUARD_WHIRLWIND:
                    DoCastSelf(SPELL_GUARD_WHIRLWIND);
                    whirlwind = true;
                    events.ScheduleEvent(EVENT_GUARD_WHIRLWIND_RANDOM, urand(3000, 7000));
                    events.ScheduleEvent(EVENT_GUARD_WHIRLWIND_END, 15000);
                    break;
                case EVENT_GUARD_WHIRLWIND_RANDOM:
                    if (whirlwind == true)
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true))
                        {
                            me->AddThreat(target, 1.0f);
                            me->TauntApply(target);
                            AttackStart(target);
                        }
                        events.RepeatEvent(urand(3000, 7000));
                    }
                    break;
                case EVENT_GUARD_WHIRLWIND_END:
                    events.CancelEvent(EVENT_GUARD_WHIRLWIND_RANDOM);
                    whirlwind = false;
                    events.ScheduleEvent(EVENT_GUARD_WHIRLWIND, urand(25000, 40000));
                    break;
                case EVENT_GUARD_AGGRO_RESET:
                    if (aggroReset == true)
                    {
                        if (Unit* originalTarget = SelectTarget(SelectTargetMethod::Random, 0))
                        {
                            _savedTargetGUID = originalTarget->GetGUID();
                            _savedTargetThreat = me->GetThreatMgr().getThreat(originalTarget);
                            me->GetThreatMgr().modifyThreatPercent(originalTarget, -100);
                        }
                        aggroReset = true;
                        events.ScheduleEvent(EVENT_GUARD_AGGRO_RESET_END, 5000);
                    }
                    else
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100.0f, true))
                        {
                            me->AddThreat(target, 1.0f);
                            me->TauntApply(target);
                            AttackStart(target);
                        }
                    }
                    events.RepeatEvent(urand(1000, 2000));
                    break;
                case EVENT_GUARD_AGGRO_RESET_END:
                    events.CancelEvent(EVENT_GUARD_AGGRO_RESET);
                    if (Unit* originalTarget = ObjectAccessor::GetUnit(*me, _savedTargetGUID))
                    {
                        me->GetThreatMgr().addThreat(originalTarget, _savedTargetThreat);
                        _savedTargetGUID.Clear();
                    }
                    aggroReset = false;
                    events.RescheduleEvent(EVENT_GUARD_AGGRO_RESET, urand(30000, 40000));
                    break;
                case EVENT_GUARD_KNOCKBACK:
                    DoCastVictim(SPELL_GUARD_KNOCKBACK);
                    events.RepeatEvent(urand(10000, 20000));
                    break;
            }
        }
        DoMeleeAttackIfReady();
    }
    private:
        bool whirlwind;
        bool aggroReset;
        ObjectGuid _savedTargetGUID;
        float _savedTargetThreat;
};

void AddSC_boss_sartura()
{
    RegisterTempleOfAhnQirajCreatureAI(boss_sartura);
    RegisterTempleOfAhnQirajCreatureAI(npc_sartura_royal_guard);
}
