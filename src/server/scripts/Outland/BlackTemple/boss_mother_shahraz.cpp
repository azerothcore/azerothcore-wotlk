/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
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

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_shahrazAI>(creature);
        }

        struct boss_shahrazAI : public BossAI
        {
            boss_shahrazAI(Creature* creature) : BossAI(creature, DATA_MOTHER_SHAHRAZ)
            {
            }

            void Reset()
            {
                BossAI::Reset();
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
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

            void KilledUnit(Unit* /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustDied(Unit* killer)
            {
                BossAI::JustDied(killer);
                Talk(SAY_DEATH);
            }

            void UpdateAI(uint32 diff)
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

class spell_mother_shahraz_random_periodic : public SpellScriptLoader
{
    public:
        spell_mother_shahraz_random_periodic() : SpellScriptLoader("spell_mother_shahraz_random_periodic") { }

        class spell_mother_shahraz_random_periodic_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mother_shahraz_random_periodic_AuraScript);

            void Update(AuraEffect const* effect)
            {                
                PreventDefaultAction();
                if (effect->GetTickNumber()%5 == 1)
                    GetUnitOwner()->CastSpell(GetUnitOwner(), RAND(SPELL_SINFUL_PERIODIC, SPELL_SINISTER_PERIODIC, SPELL_VILE_PERIODIC, SPELL_WICKED_PERIODIC), true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_mother_shahraz_random_periodic_AuraScript::Update, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mother_shahraz_random_periodic_AuraScript();
        }
};

class spell_mother_shahraz_beam_periodic : public SpellScriptLoader
{
    public:
        spell_mother_shahraz_beam_periodic() : SpellScriptLoader("spell_mother_shahraz_beam_periodic") { }

        class spell_mother_shahraz_beam_periodic_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mother_shahraz_beam_periodic_AuraScript);

            void Update(AuraEffect const* effect)
            {                
                PreventDefaultAction();
                if (Unit* target = GetUnitOwner()->GetAI()->SelectTarget(SELECT_TARGET_RANDOM, 0))
                    GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[effect->GetEffIndex()].TriggerSpell, true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_mother_shahraz_beam_periodic_AuraScript::Update, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mother_shahraz_beam_periodic_AuraScript();
        }
};

class spell_mother_shahraz_saber_lash : public SpellScriptLoader
{
    public:
        spell_mother_shahraz_saber_lash() : SpellScriptLoader("spell_mother_shahraz_saber_lash") { }

        class spell_mother_shahraz_saber_lash_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mother_shahraz_saber_lash_AuraScript);

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

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_mother_shahraz_saber_lash_AuraScript::CheckProc);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_mother_shahraz_saber_lash_AuraScript::Update, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mother_shahraz_saber_lash_AuraScript();
        }
};

class spell_mother_shahraz_fatal_attraction : public SpellScriptLoader
{
    public:
        spell_mother_shahraz_fatal_attraction() : SpellScriptLoader("spell_mother_shahraz_fatal_attraction") { }

        class spell_mother_shahraz_fatal_attraction_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_mother_shahraz_fatal_attraction_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(acore::UnitAuraCheck(true, SPELL_SABER_LASH_IMMUNITY));
                if (targets.size() <= 1)
                    FinishCast(SPELL_FAILED_DONT_REPORT);
            }

            void SetDest(SpellDestination& dest)
            {
                std::list<Spell::TargetInfo> const* targetsInfo = GetSpell()->GetUniqueTargetInfo();
                for (std::list<Spell::TargetInfo>::const_iterator ihit = targetsInfo->begin(); ihit != targetsInfo->end(); ++ihit)
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

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mother_shahraz_fatal_attraction_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
                OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_mother_shahraz_fatal_attraction_SpellScript::SetDest, EFFECT_1, TARGET_DEST_CASTER_RANDOM);
                OnEffectHitTarget += SpellEffectFn(spell_mother_shahraz_fatal_attraction_SpellScript::HandleTeleportUnits, EFFECT_1, SPELL_EFFECT_TELEPORT_UNITS);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_mother_shahraz_fatal_attraction_SpellScript();
        }
};

class spell_mother_shahraz_fatal_attraction_dummy : public SpellScriptLoader
{
    public:
        spell_mother_shahraz_fatal_attraction_dummy() : SpellScriptLoader("spell_mother_shahraz_fatal_attraction_dummy") { }

        class spell_mother_shahraz_fatal_attraction_dummy_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_mother_shahraz_fatal_attraction_dummy_SpellScript);

            void HandleDummy(SpellEffIndex  /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                {
                    target->CastSpell(target, SPELL_FATAL_ATTRACTION_DAMAGE, true);
                    if (AuraEffect* aurEff = target->GetAuraEffect(SPELL_FATAL_ATTRACTION_AURA, EFFECT_1))
                        aurEff->SetAmount(aurEff->GetTickNumber());
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_mother_shahraz_fatal_attraction_dummy_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_mother_shahraz_fatal_attraction_dummy_SpellScript();
        }
};

class spell_mother_shahraz_fatal_attraction_aura : public SpellScriptLoader
{
    public:
        spell_mother_shahraz_fatal_attraction_aura() : SpellScriptLoader("spell_mother_shahraz_fatal_attraction_aura") { }

        class spell_mother_shahraz_fatal_attraction_aura_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_mother_shahraz_fatal_attraction_aura_AuraScript);

            void Update(AuraEffect const* effect)
            {                
                if (effect->GetTickNumber() > uint32(effect->GetAmount()+1))
                {
                    PreventDefaultAction();
                    SetDuration(0);
                }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_mother_shahraz_fatal_attraction_aura_AuraScript::Update, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_mother_shahraz_fatal_attraction_aura_AuraScript();
        }
};

void AddSC_boss_mother_shahraz()
{
    new boss_mother_shahraz();
    new spell_mother_shahraz_random_periodic();
    new spell_mother_shahraz_beam_periodic();
    new spell_mother_shahraz_saber_lash();
    new spell_mother_shahraz_fatal_attraction();
    new spell_mother_shahraz_fatal_attraction_dummy();
    new spell_mother_shahraz_fatal_attraction_aura();
}
