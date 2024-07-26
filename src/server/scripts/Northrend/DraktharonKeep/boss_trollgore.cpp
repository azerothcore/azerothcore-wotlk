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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScriptLoader.h"
#include "drak_tharon_keep.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

enum Yells
{
    SAY_AGGRO                           = 0,
    SAY_KILL                            = 1,
    SAY_CONSUME                         = 2,
    SAY_EXPLODE                         = 3,
    SAY_DEATH                           = 4
};

enum Spells
{
    SPELL_SUMMON_INVADER_A              = 49456,
    SPELL_SUMMON_INVADER_B              = 49457,
    SPELL_SUMMON_INVADER_C              = 49458,

    SPELL_INFECTED_WOUND                = 49637,
    SPELL_CRUSH                         = 49639,
    SPELL_CONSUME                       = 49380,
    SPELL_CORPSE_EXPLODE                = 49555,

    SPELL_CORPSE_EXPLODE_DAMAGE         = 49618,
    SPELL_CONSUME_AURA                  = 49381,
};

enum Events
{
    EVENT_SPELL_INFECTED_WOUND          = 1,
    EVENT_SPELL_CRUSH                   = 2,
    EVENT_SPELL_CONSUME                 = 3,
    EVENT_SPELL_CORPSE_EXPLODE          = 4,
    EVENT_SPAWN_INVADERS                = 5,
    EVENT_KILL_TALK                     = 6
};

class boss_trollgore : public CreatureScript
{
public:
    boss_trollgore() : CreatureScript("boss_trollgore") { }

    struct boss_trollgoreAI : public BossAI
    {
        boss_trollgoreAI(Creature* creature) : BossAI(creature, DATA_TROLLGORE)
        {
        }

        void Reset() override
        {
            BossAI::Reset();
            events2.Reset();
            events2.ScheduleEvent(EVENT_SPAWN_INVADERS, 30s);
        }

        void JustEngagedWith(Unit* who) override
        {
            events.ScheduleEvent(EVENT_SPELL_INFECTED_WOUND, 6s, 10s);
            events.ScheduleEvent(EVENT_SPELL_CRUSH, 3s, 5s);
            events.ScheduleEvent(EVENT_SPELL_CONSUME, 15s);
            events.ScheduleEvent(EVENT_SPELL_CORPSE_EXPLODE, 35s);
            events.ScheduleEvent(EVENT_SPAWN_INVADERS, 20s, 30s);

            me->setActive(true);
            instance->SetBossState(DATA_TROLLGORE, IN_PROGRESS);
            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                Talk(SAY_AGGRO);
                me->SetInCombatWithZone();
            }
        }

        void JustDied(Unit* killer) override
        {
            Talk(SAY_DEATH);
            BossAI::JustDied(killer);
        }

        void KilledUnit(Unit*  /*victim*/) override
        {
            if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(SAY_KILL);
                events.ScheduleEvent(EVENT_KILL_TALK, 6s);
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
        }

        void UpdateAI(uint32 diff) override
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case EVENT_SPAWN_INVADERS:
                    me->CastSpell(me, SPELL_SUMMON_INVADER_A, true);
                    me->CastSpell(me, SPELL_SUMMON_INVADER_B, true);
                    me->CastSpell(me, SPELL_SUMMON_INVADER_C, true);
                    events2.ScheduleEvent(EVENT_SPAWN_INVADERS, 30s);
                    break;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.ExecuteEvent())
            {
                case EVENT_SPELL_INFECTED_WOUND:
                    me->CastSpell(me->GetVictim(), SPELL_INFECTED_WOUND, false);
                    events.ScheduleEvent(EVENT_SPELL_INFECTED_WOUND, 25s, 35s);
                    break;
                case EVENT_SPELL_CRUSH:
                    me->CastSpell(me->GetVictim(), SPELL_CRUSH, false);
                    events.ScheduleEvent(EVENT_SPELL_CRUSH, 10s, 15s);
                    break;
                case EVENT_SPELL_CONSUME:
                    Talk(SAY_CONSUME);
                    me->CastSpell(me, SPELL_CONSUME, false);
                    events.ScheduleEvent(EVENT_SPELL_CONSUME, 15s);
                    break;
                case EVENT_SPELL_CORPSE_EXPLODE:
                    Talk(SAY_EXPLODE);
                    me->CastSpell(me, SPELL_CORPSE_EXPLODE, false);
                    events.ScheduleEvent(EVENT_SPELL_CORPSE_EXPLODE, 15s, 19s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        bool CheckEvadeIfOutOfCombatArea() const override
        {
            return me->GetHomePosition().GetExactDist2d(me) > 60.0f;
        }

    private:
        EventMap events2;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetDraktharonKeepAI<boss_trollgoreAI>(creature);
    }
};

class spell_trollgore_consume : public SpellScript
{
    PrepareSpellScript(spell_trollgore_consume);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CONSUME_AURA });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(GetCaster(), SPELL_CONSUME_AURA, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_trollgore_consume::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_trollgore_corpse_explode_aura : public AuraScript
{
    PrepareAuraScript(spell_trollgore_corpse_explode_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CORPSE_EXPLODE_DAMAGE });
    }

    void PeriodicTick(AuraEffect const* aurEff)
    {
        if (aurEff->GetTickNumber() == 2)
            if (Unit* caster = GetCaster())
                caster->CastSpell(GetTarget(), SPELL_CORPSE_EXPLODE_DAMAGE, true);
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Creature* target = GetTarget()->ToCreature())
            target->DespawnOrUnsummon(1);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_trollgore_corpse_explode_aura::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        AfterEffectRemove += AuraEffectRemoveFn(spell_trollgore_corpse_explode_aura::HandleRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_trollgore_invader_taunt : public SpellScript
{
    PrepareSpellScript(spell_trollgore_invader_taunt);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(GetCaster(), uint32(GetEffectValue()), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_trollgore_invader_taunt::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class achievement_consumption_junction : public AchievementCriteriaScript
{
public:
    achievement_consumption_junction() : AchievementCriteriaScript("achievement_consumption_junction")
    {
    }

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return target->GetAuraCount(sSpellMgr->GetSpellIdForDifficulty(SPELL_CONSUME_AURA, target)) < 10;
    }
};

void AddSC_boss_trollgore()
{
    new boss_trollgore();
    RegisterSpellScript(spell_trollgore_consume);
    RegisterSpellScript(spell_trollgore_corpse_explode_aura);
    RegisterSpellScript(spell_trollgore_invader_taunt);
    new achievement_consumption_junction();
}
