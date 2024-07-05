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
#include "SpellScriptLoader.h"
#include "black_temple.h"

enum Says
{
    SAY_TAUNT                       = 0,
    SAY_AGGRO                       = 1,
    SAY_SPELL                       = 2,
    SAY_SLAY                        = 3,
    SAY_ENRAGE                      = 4,
    SAY_DEATH                       = 5,
    SAY_EMOTE_FRENZY                = 6
};

enum Spells
{
    SPELL_PRISMATIC_AURA_SHADOW     = 40880,
    SPELL_PRISMATIC_AURA_FIRE       = 40882,
    SPELL_PRISMATIC_AURA_NATURE     = 40883,
    SPELL_PRISMATIC_AURA_ARCANE     = 40891,
    SPELL_PRISMATIC_AURA_FROST      = 40896,
    SPELL_PRISMATIC_AURA_HOLY       = 40897,
    SPELL_SABER_LASH_AURA           = 40816,
    SPELL_SABER_LASH                = 40810,
    SPELL_SILENCING_SHRIEK          = 40823,
    SPELL_RANDOM_PERIODIC           = 40867,
    SPELL_SINFUL_PERIODIC           = 40862,
    SPELL_SINISTER_PERIODIC         = 40863,
    SPELL_VILE_PERIODIC             = 40865,
    SPELL_WICKED_PERIODIC           = 40866,
    SPELL_FATAL_ATTRACTION          = 40869,
    SPELL_FATAL_ATTRACTION_AURA     = 41001,
    SPELL_FATAL_ATTRACTION_DAMAGE   = 40871,
    SPELL_ENRAGE                    = 45078,
    SPELL_FRENZY                    = 40683,
    SPELL_SABER_LASH_IMMUNITY       = 43690
};

enum Misc
{
    EVENT_KILL_TALK                 = 1,
    EVENT_CHECK_HEALTH              = 2,
    EVENT_RANDOM_TALK               = 3,
    EVENT_SPELL_ENRAGE              = 4,
    EVENT_SPELL_PRISMATIC_AURA      = 5,
    EVENT_SPELL_SILENCING_SHRIEK    = 6,
    EVENT_SPELL_FATAL_ATTRACTION    = 7,
    EVENT_SPELL_SABER_LASH          = 8
};

class boss_mother_shahraz : public CreatureScript
{
public:
    boss_mother_shahraz() : CreatureScript("boss_mother_shahraz") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackTempleAI<boss_shahrazAI>(creature);
    }

    struct boss_shahrazAI : public BossAI
    {
        boss_shahrazAI(Creature* creature) : BossAI(creature, DATA_MOTHER_SHAHRAZ)
        {
        }

        void Reset() override
        {
            BossAI::Reset();
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            Talk(SAY_AGGRO);

            me->CastSpell(me, SPELL_SABER_LASH_AURA, true);
            me->CastSpell(me, SPELL_RANDOM_PERIODIC, true);
            events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
            events.ScheduleEvent(EVENT_RANDOM_TALK, 60000);
            events.ScheduleEvent(EVENT_SPELL_PRISMATIC_AURA, 0);
            events.ScheduleEvent(EVENT_SPELL_ENRAGE, 600000);
            events.ScheduleEvent(EVENT_SPELL_SILENCING_SHRIEK, 30000);
            events.ScheduleEvent(EVENT_SPELL_FATAL_ATTRACTION, 50000);
            events.ScheduleEvent(EVENT_SPELL_SABER_LASH, 4000);
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(SAY_SLAY);
                events.ScheduleEvent(EVENT_KILL_TALK, 6000);
            }
        }

        void JustDied(Unit* killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
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
                case EVENT_CHECK_HEALTH:
                    if (HealthBelowPct(10))
                    {
                        me->CastSpell(me, SPELL_FRENZY, true);
                        Talk(SAY_EMOTE_FRENZY);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                    break;
                case EVENT_SPELL_ENRAGE:
                    me->CastSpell(me, SPELL_ENRAGE, true);
                    Talk(SAY_ENRAGE);
                    break;
                case EVENT_RANDOM_TALK:
                    Talk(SAY_TAUNT);
                    events.ScheduleEvent(EVENT_RANDOM_TALK, urand(60000, 120000));
                    break;
                case EVENT_SPELL_SABER_LASH:
                    me->CastSpell(me->GetVictim(), SPELL_SABER_LASH, false);
                    events.ScheduleEvent(EVENT_SPELL_SABER_LASH, 30000);
                    break;
                case EVENT_SPELL_PRISMATIC_AURA:
                    me->CastSpell(me, RAND(SPELL_PRISMATIC_AURA_SHADOW, SPELL_PRISMATIC_AURA_FIRE, SPELL_PRISMATIC_AURA_NATURE, SPELL_PRISMATIC_AURA_ARCANE, SPELL_PRISMATIC_AURA_FROST, SPELL_PRISMATIC_AURA_HOLY), false);
                    events.ScheduleEvent(EVENT_SPELL_PRISMATIC_AURA, 15000);
                    break;
                case EVENT_SPELL_SILENCING_SHRIEK:
                    me->CastSpell(me, SPELL_SILENCING_SHRIEK, false);
                    events.ScheduleEvent(EVENT_SPELL_SILENCING_SHRIEK, 30000);
                    break;
                case EVENT_SPELL_FATAL_ATTRACTION:
                    Talk(SAY_SPELL);
                    me->CastCustomSpell(SPELL_FATAL_ATTRACTION, SPELLVALUE_MAX_TARGETS, 3, me, false);
                    events.ScheduleEvent(EVENT_SPELL_FATAL_ATTRACTION, 60000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_mother_shahraz_random_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_mother_shahraz_random_periodic_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SINFUL_PERIODIC, SPELL_SINISTER_PERIODIC, SPELL_VILE_PERIODIC, SPELL_WICKED_PERIODIC });
    }

    void Update(AuraEffect const* effect)
    {
        PreventDefaultAction();
        if (effect->GetTickNumber() % 5 == 1)
            GetUnitOwner()->CastSpell(GetUnitOwner(), RAND(SPELL_SINFUL_PERIODIC, SPELL_SINISTER_PERIODIC, SPELL_VILE_PERIODIC, SPELL_WICKED_PERIODIC), true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mother_shahraz_random_periodic_aura::Update, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_mother_shahraz_beam_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_mother_shahraz_beam_periodic_aura);

    void Update(AuraEffect const* effect)
    {
        PreventDefaultAction();
        if (Unit* target = GetUnitOwner()->GetAI()->SelectTarget(SelectTargetMethod::Random, 0))
            GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[effect->GetEffIndex()].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mother_shahraz_beam_periodic_aura::Update, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_mother_shahraz_saber_lash_aura : public AuraScript
{
    PrepareAuraScript(spell_mother_shahraz_saber_lash_aura);

    bool CheckProc(ProcEventInfo&  /*eventInfo*/)
    {
        return false;
    }

    void Update(AuraEffect const* effect)
    {
        PreventDefaultAction();
        if (Unit* target = GetUnitOwner()->GetVictim())
            GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[effect->GetEffIndex()].TriggerSpell, true);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_mother_shahraz_saber_lash_aura::CheckProc);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mother_shahraz_saber_lash_aura::Update, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_mother_shahraz_fatal_attraction : public SpellScript
{
    PrepareSpellScript(spell_mother_shahraz_fatal_attraction);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FATAL_ATTRACTION_AURA });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_SABER_LASH_IMMUNITY));
        if (targets.size() <= 1)
            FinishCast(SPELL_FAILED_DONT_REPORT);
    }

    void SetDest(SpellDestination& dest)
    {
        std::list<TargetInfo> const* targetsInfo = GetSpell()->GetUniqueTargetInfo();
        for (std::list<TargetInfo>::const_iterator ihit = targetsInfo->begin(); ihit != targetsInfo->end(); ++ihit)
            if (Unit* target = ObjectAccessor::GetUnit(*GetCaster(), ihit->targetGUID))
            {
                dest.Relocate(*target);
                if (roll_chance_i(50))
                    break;
            }
    }

    void HandleTeleportUnits(SpellEffIndex  /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_FATAL_ATTRACTION_AURA, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mother_shahraz_fatal_attraction::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_mother_shahraz_fatal_attraction::SetDest, EFFECT_1, TARGET_DEST_CASTER_RANDOM);
        OnEffectHitTarget += SpellEffectFn(spell_mother_shahraz_fatal_attraction::HandleTeleportUnits, EFFECT_1, SPELL_EFFECT_TELEPORT_UNITS);
    }
};

class spell_mother_shahraz_fatal_attraction_dummy : public SpellScript
{
    PrepareSpellScript(spell_mother_shahraz_fatal_attraction_dummy);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FATAL_ATTRACTION_DAMAGE });
    }

    void HandleDummy(SpellEffIndex  /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            target->CastSpell(target, SPELL_FATAL_ATTRACTION_DAMAGE, true);
            if (AuraEffect* aurEff = target->GetAuraEffect(SPELL_FATAL_ATTRACTION_AURA, EFFECT_1))
                aurEff->SetAmount(aurEff->GetTickNumber());
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_mother_shahraz_fatal_attraction_dummy::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_mother_shahraz_fatal_attraction_aura : public AuraScript
{
    PrepareAuraScript(spell_mother_shahraz_fatal_attraction_aura);

    void Update(AuraEffect const* effect)
    {
        if (effect->GetTickNumber() > uint32(effect->GetAmount() + 1))
        {
            PreventDefaultAction();
            SetDuration(0);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mother_shahraz_fatal_attraction_aura::Update, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

void AddSC_boss_mother_shahraz()
{
    new boss_mother_shahraz();
    RegisterSpellScript(spell_mother_shahraz_random_periodic_aura);
    RegisterSpellScript(spell_mother_shahraz_beam_periodic_aura);
    RegisterSpellScript(spell_mother_shahraz_saber_lash_aura);
    RegisterSpellScript(spell_mother_shahraz_fatal_attraction);
    RegisterSpellScript(spell_mother_shahraz_fatal_attraction_dummy);
    RegisterSpellScript(spell_mother_shahraz_fatal_attraction_aura);
}

