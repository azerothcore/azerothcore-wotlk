/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "gruuls_lair.h"

enum Yells
{
    SAY_AGGRO                   = 0,
    SAY_SLAM                    = 1,
    SAY_SHATTER                 = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4,

    EMOTE_GROW                  = 5
};

enum Spells
{
    SPELL_GROWTH                = 36300,
    SPELL_CAVE_IN               = 36240,
    SPELL_GROUND_SLAM           = 33525,
    SPELL_REVERBERATION         = 36297,
    SPELL_HURTFUL_STRIKE        = 33813,
    SPELL_SHATTER               = 33654,

    SPELL_SHATTER_EFFECT        = 33671,
    SPELL_STONED                = 33652,
};

enum Events
{
    EVENT_GROWTH                = 1,
    EVENT_CAVE_IN               = 2,
    EVENT_GROUND_SLAM           = 3,
    EVENT_HURTFUL_STRIKE        = 4,
    EVENT_REVERBERATION         = 5,
    EVENT_SHATTER               = 6,
    EVENT_RECENTLY_SPOKEN       = 7
};

class boss_gruul : public CreatureScript
{
    public:
        boss_gruul() : CreatureScript("boss_gruul") { }

        struct boss_gruulAI : public BossAI
        {
            boss_gruulAI(Creature* creature) : BossAI(creature, DATA_GRUUL) { }

            void Reset()
            {
                _Reset();
                _caveInTimer = 29000;
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
                Talk(SAY_AGGRO);

                events.ScheduleEvent(EVENT_GROWTH, 30000);
                events.ScheduleEvent(EVENT_CAVE_IN, _caveInTimer);
                events.ScheduleEvent(EVENT_REVERBERATION, 20000);
                events.ScheduleEvent(EVENT_HURTFUL_STRIKE, 10000);
                events.ScheduleEvent(EVENT_GROUND_SLAM, 35000);
            }

            void KilledUnit(Unit*  /*who*/)
            {
                if (events.GetNextEventTime(EVENT_RECENTLY_SPOKEN) == 0)
                {
                    events.ScheduleEvent(EVENT_RECENTLY_SPOKEN, 5000);
                    Talk(SAY_SLAY);
                }
            }

            void JustDied(Unit* /*killer*/)
            {
                _JustDied();
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
                    case EVENT_GROWTH:
                        Talk(EMOTE_GROW);
                        DoCast(me, SPELL_GROWTH);
                        events.ScheduleEvent(EVENT_GROWTH, 30000);
                        break;
                    case EVENT_CAVE_IN:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            me->CastSpell(target, SPELL_CAVE_IN, false);
                        if (_caveInTimer >= 4000)
                            _caveInTimer -= 1500;
                        events.ScheduleEvent(EVENT_CAVE_IN, _caveInTimer);
                        break;
                    case EVENT_REVERBERATION:
                        me->CastSpell(me, SPELL_REVERBERATION, false);
                        events.ScheduleEvent(EVENT_REVERBERATION, 22000);
                        break;
                    case EVENT_HURTFUL_STRIKE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 1, 5.0f))
                            me->CastSpell(target, SPELL_HURTFUL_STRIKE, false);
                        events.ScheduleEvent(EVENT_HURTFUL_STRIKE, 15000);
                        break;
                    case EVENT_GROUND_SLAM:
                        Talk(SAY_SLAM);
                        me->CastSpell(me, SPELL_GROUND_SLAM, false);
                        events.DelayEvents(8001);
                        events.ScheduleEvent(EVENT_GROUND_SLAM, 60000);
                        events.ScheduleEvent(EVENT_SHATTER, 8000);
                        break;
                    case EVENT_SHATTER:
                        Talk(SAY_SHATTER);
                        me->CastSpell(me, SPELL_SHATTER, false);
                        break;
                }

                DoMeleeAttackIfReady();
            }

            private:
                uint32 _caveInTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_gruulAI>(creature);
        }
};

class spell_gruul_ground_slam : public SpellScriptLoader
{
    public:
        spell_gruul_ground_slam() : SpellScriptLoader("spell_gruul_ground_slam") { }

        class spell_gruul_ground_slam_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_gruul_ground_slam_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    target->KnockbackFrom(GetCaster()->GetPositionX(), GetCaster()->GetPositionY(), 15.0f, 15.0f);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_gruul_ground_slam_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_gruul_ground_slam_SpellScript();
        }
};

class spell_gruul_ground_slam_trigger : public SpellScriptLoader
{
    public:
        spell_gruul_ground_slam_trigger() : SpellScriptLoader("spell_gruul_ground_slam_trigger") { }

        class spell_gruul_ground_slam_trigger_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_gruul_ground_slam_trigger_AuraScript);

            void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (GetUnitOwner()->GetAuraCount(GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell) == 5)
                    GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_STONED, true);
            }

            void Register()
            {
                 AfterEffectRemove += AuraEffectRemoveFn(spell_gruul_ground_slam_trigger_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_gruul_ground_slam_trigger_AuraScript();
        }
};

class spell_gruul_shatter : public SpellScriptLoader
{
    public:
        spell_gruul_shatter() : SpellScriptLoader("spell_gruul_shatter") { }

        class spell_gruul_shatter_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_gruul_shatter_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                {
                    target->RemoveAurasDueToSpell(SPELL_STONED);
                    target->CastSpell((Unit*)NULL, SPELL_SHATTER_EFFECT, true);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_gruul_shatter_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_gruul_shatter_SpellScript();
        }
};

class spell_gruul_shatter_effect : public SpellScriptLoader
{
    public:
        spell_gruul_shatter_effect() : SpellScriptLoader("spell_gruul_shatter_effect") { }

        class spell_gruul_shatter_effect_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_gruul_shatter_effect_SpellScript);

            void CalculateDamage()
            {
                if (!GetHitUnit())
                    return;

                float radius = GetSpellInfo()->Effects[EFFECT_0].CalcRadius(GetCaster());
                if (!radius)
                    return;

                float distance = GetCaster()->GetDistance2d(GetHitUnit());
                if (distance > 1.0f)
                    SetHitDamage(int32(GetHitDamage() * ((radius - distance) / radius)));
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_gruul_shatter_effect_SpellScript::CalculateDamage);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_gruul_shatter_effect_SpellScript();
        }
};

void AddSC_boss_gruul()
{
    new boss_gruul();
    new spell_gruul_ground_slam();
    new spell_gruul_ground_slam_trigger();
    new spell_gruul_shatter();
    new spell_gruul_shatter_effect();
}
