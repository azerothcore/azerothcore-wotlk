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
#include "mechanar.h"

enum Says
{
    SAY_AGGRO                      = 0,
    SAY_SUMMON                     = 1,
    SAY_DRAGONS_BREATH             = 2,
    SAY_SLAY                       = 3,
    SAY_DEATH                      = 4
};

enum Spells
{
    SPELL_SUMMON_RAGIN_FLAMES      = 35275,
    SPELL_FROST_ATTACK             = 35263,
    SPELL_ARCANE_BLAST             = 35314,
    SPELL_DRAGONS_BREATH           = 35250,
};

struct boss_nethermancer_sepethrea : public BossAI
{
    boss_nethermancer_sepethrea(Creature* creature) : BossAI(creature, DATA_NETHERMANCER_SEPRETHREA)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void JustEngagedWith(Unit*  /*who*/) override
    {
        _JustEngagedWith();

        scheduler.Schedule(6s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_FROST_ATTACK);
            context.Repeat(8s);
        }).Schedule(14s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_ARCANE_BLAST);
            context.Repeat(12s);
        }).Schedule(18s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_DRAGONS_BREATH);
            context.Repeat(16s);
            if (roll_chance_i(50))
            {
                Talk(SAY_DRAGONS_BREATH);
            }
        });

        Talk(SAY_AGGRO);
        DoCastSelf(SPELL_SUMMON_RAGIN_FLAMES, true);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (Unit* victim = me->GetVictim())
        {
            summon->AI()->AttackStart(victim);
            summon->AddThreat(victim, 1000.0f);
            summon->SetInCombatWithZone();
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }
};

enum raginFlames
{
    SPELL_INFERNO                   = 35268,
    SPELL_FIRE_TAIL                 = 35278,
    SPELL_INFERNO_DAMAGE            = 35283,

    EVENT_SPELL_FIRE_TAIL           = 1,
    EVENT_SPELL_INFERNO             = 2
};

struct npc_ragin_flames : public ScriptedAI
{
    npc_ragin_flames(Creature* creature) : ScriptedAI(creature) { }

    EventMap events;

    void Reset() override
    {
        me->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_ALL, true);
    }

    void JustEngagedWith(Unit*) override
    {
        events.ScheduleEvent(EVENT_SPELL_FIRE_TAIL, 500);
        events.ScheduleEvent(EVENT_SPELL_INFERNO, urand(10000, 20000));
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        switch (events.ExecuteEvent())
        {
        case EVENT_SPELL_INFERNO:
            if (me->IsWithinCombatRange(me->GetVictim(), 5.0f))
            {
                me->CastSpell(me, SPELL_INFERNO, true);
                events.ScheduleEvent(EVENT_SPELL_INFERNO, 20000);
            }
            else
                events.ScheduleEvent(EVENT_SPELL_INFERNO, 1000);
            break;
        case EVENT_SPELL_FIRE_TAIL:
            me->CastSpell(me, SPELL_FIRE_TAIL, true);
            events.ScheduleEvent(EVENT_SPELL_FIRE_TAIL, 500);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

class spell_ragin_flames_inferno : public AuraScript
{
    PrepareAuraScript(spell_ragin_flames_inferno);

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        GetUnitOwner()->CastCustomSpell(SPELL_INFERNO_DAMAGE, SPELLVALUE_BASE_POINT0, aurEff->GetAmount(), GetUnitOwner(), TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_ragin_flames_inferno::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

void AddSC_boss_nethermancer_sepethrea()
{
    RegisterMechanarCreatureAI(boss_nethermancer_sepethrea);
    RegisterMechanarCreatureAI(npc_ragin_flames);
    RegisterSpellScript(spell_ragin_flames_inferno);
}
