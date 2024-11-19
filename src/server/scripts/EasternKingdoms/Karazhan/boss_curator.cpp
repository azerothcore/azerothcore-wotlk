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
#include "karazhan.h"

enum Text
{
    SAY_AGGRO                       = 0,
    SAY_SUMMON                      = 1,
    SAY_EVOCATE                     = 2,
    SAY_ENRAGE                      = 3,
    SAY_KILL                        = 4,
    SAY_DEATH                       = 5
};

enum Spells
{
    SPELL_HATEFUL_BOLT              = 30383,
    SPELL_EVOCATION                 = 30254,
    SPELL_ARCANE_INFUSION           = 30403,
    SPELL_ASTRAL_DECONSTRUCTION     = 30407,

    SPELL_SUMMON_ASTRAL_FLARE1      = 30236,
    SPELL_SUMMON_ASTRAL_FLARE2      = 30239,
    SPELL_SUMMON_ASTRAL_FLARE3      = 30240,
    SPELL_SUMMON_ASTRAL_FLARE4      = 30241
};

struct boss_curator : public BossAI
{
    boss_curator(Creature* creature) : BossAI(creature, DATA_CURATOR)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_ARCANE, true);
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_PERIODIC_MANA_LEECH, true);
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_POWER_BURN, true);
        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_POWER_BURN, true);
        ScheduleHealthCheckEvent(15, [&] {
            me->InterruptNonMeleeSpells(true);
            DoCastSelf(SPELL_ARCANE_INFUSION, true);
            Talk(SAY_ENRAGE);
        });
        me->SetPower(POWER_MANA, me->GetMaxPower(POWER_MANA));
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_KILL);
        }
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        DoZoneInCombat();
        scheduler.Schedule(10min, [this](TaskContext /*context*/)
        {
            Talk(SAY_ENRAGE);
            me->InterruptNonMeleeSpells(true);
            DoCastSelf(SPELL_ASTRAL_DECONSTRUCTION, true);
        }).Schedule(10s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, 1, 45.0f, true, false))
            {
                DoCast(target, SPELL_HATEFUL_BOLT);
            }
            else
            {
                DoCastVictim(SPELL_HATEFUL_BOLT);
            }
            context.Repeat(7s, 15s);
        }).Schedule(6s, [this](TaskContext context)
        {
            if (me->HealthAbovePct(15))
            {
                if (roll_chance_i(50))
                {
                    Talk(SAY_SUMMON);
                }
                DoCastSelf(RAND(SPELL_SUMMON_ASTRAL_FLARE1, SPELL_SUMMON_ASTRAL_FLARE2, SPELL_SUMMON_ASTRAL_FLARE3, SPELL_SUMMON_ASTRAL_FLARE4));
                int32 mana = CalculatePct(me->GetMaxPower(POWER_MANA), 10);
                me->ModifyPower(POWER_MANA, -mana);
                if (me->GetPowerPct(POWER_MANA) < 10.0f)
                {
                    Talk(SAY_EVOCATE);
                    DoCastSelf(SPELL_EVOCATION);
                    scheduler.DelayAll(20s);
                    context.Repeat(20s);
                }
                else
                {
                    context.Repeat(10s);
                }
            }
        });
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (Unit* target = summon->SelectNearbyTarget(nullptr, 40.0f))
        {
            summon->AI()->AttackStart(target);
            summon->AddThreat(target, 1000.0f);
        }
        summon->SetInCombatWithZone();
    }
};

void AddSC_boss_curator()
{
    RegisterKarazhanCreatureAI(boss_curator);
}
