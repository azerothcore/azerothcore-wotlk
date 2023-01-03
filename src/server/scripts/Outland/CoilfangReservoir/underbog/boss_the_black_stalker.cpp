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
#include "the_underbog.h"

enum eBlackStalker
{
    SPELL_LEVITATE                  = 31704,
    SPELL_SUSPENSION                = 31719,
    SPELL_LEVITATION_PULSE          = 31701,
    SPELL_MAGNETIC_PULL             = 31705,
    SPELL_CHAIN_LIGHTNING           = 31717,
    SPELL_STATIC_CHARGE             = 31715,
    SPELL_SUMMON_SPORE_STRIDER      = 38755,

    EVENT_LEVITATE                  = 1,
    EVENT_SPELL_CHAIN               = 2,
    EVENT_SPELL_STATIC              = 3,
    EVENT_SPELL_SPORES              = 4,
    EVENT_CHECK                     = 5,
    EVENT_LEVITATE_TARGET_1         = 6,
    EVENT_LEVITATE_TARGET_2         = 7,

    ENTRY_SPORE_STRIDER             = 22299
};

struct boss_the_black_stalker : public BossAI
{
    boss_the_black_stalker(Creature* creature) : BossAI(creature, DATA_BLACK_STALKER)
    {
    }

    void Reset() override
    {
        lTarget.Clear();
        BossAI::Reset();
    }

    void EnterCombat(Unit* who) override
    {
        events.ScheduleEvent(EVENT_LEVITATE, 12000);
        events.ScheduleEvent(EVENT_SPELL_CHAIN, 6000);
        events.ScheduleEvent(EVENT_SPELL_STATIC, 10000);
        events.ScheduleEvent(EVENT_CHECK, 5000);
        if (IsHeroic())
            events.ScheduleEvent(EVENT_SPELL_SPORES, urand(10000, 15000));

        BossAI::EnterCombat(who);
    }

    void JustSummoned(Creature* summon) override
    {
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1))
            summon->AI()->AttackStart(target);
        else if (me->GetVictim())
            summon->AI()->AttackStart(me->GetVictim());

        BossAI::JustSummoned(summon);
    }

    void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
    {
        summons.Despawn(summon);
        for (uint8 i = 0; i < 3; ++i)
            me->CastSpell(me, SPELL_SUMMON_SPORE_STRIDER, false);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        switch (events.ExecuteEvent())
        {
            case EVENT_CHECK:
                float x, y, z, o;
                me->GetHomePosition(x, y, z, o);
                if (!me->IsWithinDist3d(x, y, z, 60))
                {
                    EnterEvadeMode();
                    return;
                }
                events.RepeatEvent(5000);
                break;
            case EVENT_SPELL_SPORES:
                me->CastSpell(me, SPELL_SUMMON_SPORE_STRIDER, false);
                events.RepeatEvent(urand(10000, 15000));
                break;
            case EVENT_SPELL_CHAIN:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    me->CastSpell(target, SPELL_CHAIN_LIGHTNING, false);
                events.DelayEvents(3000);
                events.RepeatEvent(9000);
                break;
            case EVENT_SPELL_STATIC:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30, true))
                    me->CastSpell(target, SPELL_STATIC_CHARGE, false);
                events.RepeatEvent(10000);
                break;
            case EVENT_LEVITATE:
                events.RepeatEvent(15000);
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1))
                {
                    me->CastSpell(target, SPELL_LEVITATE, false);
                    lTarget = target->GetGUID();
                    events.DelayEvents(5000);
                    events.ScheduleEvent(EVENT_LEVITATE_TARGET_1, 2000);
                }
                break;
            case EVENT_LEVITATE_TARGET_1:
                if (Unit* target = ObjectAccessor::GetUnit(*me, lTarget))
                {
                    if (!target->HasAura(SPELL_LEVITATE))
                        lTarget.Clear();
                    else
                    {
                        target->CastSpell(target, SPELL_MAGNETIC_PULL, true);
                        events.ScheduleEvent(EVENT_LEVITATE_TARGET_2, 1500);
                    }
                }
                break;
            case EVENT_LEVITATE_TARGET_2:
                if (Unit* target = ObjectAccessor::GetUnit(*me, lTarget))
                {
                    if (!target->HasAura(SPELL_LEVITATE))
                        lTarget.Clear();
                    else
                    {
                        target->AddAura(SPELL_SUSPENSION, target);
                        lTarget.Clear();
                    }
                }
                break;
            }

        DoMeleeAttackIfReady();
    }

private:
    ObjectGuid lTarget;
};

class spell_gen_allergies : public AuraScript
{
    PrepareAuraScript(spell_gen_allergies);

    void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32& amplitude)
    {
        isPeriodic = true;
        amplitude = urand(10 * IN_MILLISECONDS, 200 * IN_MILLISECONDS);
    }

    void Update(AuraEffect*  /*effect*/)
    {
        SetDuration(0);
    }

    void Register() override
    {
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_gen_allergies::CalcPeriodic, EFFECT_0, SPELL_AURA_DUMMY);
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_gen_allergies::Update, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

void AddSC_boss_the_black_stalker()
{
    RegisterUnderbogCreatureAI(boss_the_black_stalker);
    RegisterSpellScript(spell_gen_allergies);
}
