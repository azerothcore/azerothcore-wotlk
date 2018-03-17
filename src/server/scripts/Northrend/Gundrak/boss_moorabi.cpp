/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "gundrak.h"

enum eSpells
{
    SPELL_SUMMON_PHANTOM                    = 55205,
    SPELL_SUMMON_PHANTOM_TRANSFORM          = 55097,
    SPELL_DETERMINED_STAB                   = 55104,
    SPELL_DETERMINED_GORE                   = 55102,
    SPELL_GROUND_TREMOR                     = 55142,
    SPELL_QUAKE                             = 55101,
    SPELL_NUMBING_SHOUT                     = 55106,
    SPELL_NUMBING_ROAR                      = 55100,
    SPELL_MOJO_FRENZY                       = 55163,
    SPELL_TRANSFORMATION                    = 55098
};

enum eSays
{
    SAY_AGGRO                               = 0,
    SAY_SLAY                                = 1,
    SAY_DEATH                               = 2,
    SAY_TRANSFORM                           = 3,
    SAY_QUAKE                               = 4,
    EMOTE_TRANSFORM                         = 5,
    EMOTE_TRANSFORMED                       = 6,
    EMOTE_ALTAR                             = 7
};

enum Events
{
    EVENT_GROUND_TREMOR                     = 1,
    EVENT_NUMBLING_SHOUT                    = 2,
    EVENT_DETERMINED_STAB                   = 3,
    EVENT_TRANSFORMATION                    = 4,
    EVENT_KILL_TALK                         = 5,

    EVENT_PHANTOM                           = 10
};

class boss_moorabi : public CreatureScript
{
    public:
        boss_moorabi() : CreatureScript("boss_moorabi") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_moorabiAI>(creature);
        }

        struct boss_moorabiAI : public BossAI
        {
            boss_moorabiAI(Creature* creature) : BossAI(creature, DATA_MOORABI)
            {
            }

            EventMap events2;

            void Reset()
            {
                BossAI::Reset();
                events2.Reset();
                events2.ScheduleEvent(EVENT_PHANTOM, 21000);
            }

            void EnterCombat(Unit* who)
            {
                Talk(SAY_AGGRO);
                BossAI::EnterCombat(who);
                me->CastSpell(me, SPELL_MOJO_FRENZY, true);

                events.ScheduleEvent(EVENT_GROUND_TREMOR, 18000);
                events.ScheduleEvent(EVENT_NUMBLING_SHOUT, 10000);
                events.ScheduleEvent(EVENT_DETERMINED_STAB, 20000);
                events.ScheduleEvent(EVENT_TRANSFORMATION, 12000);
            }

            void SpellHitTarget(Unit*  /*caster*/, const SpellInfo* spellInfo)
            {
                if (spellInfo->Id == SPELL_TRANSFORMATION)
                {
                    me->RemoveAurasDueToSpell(SPELL_MOJO_FRENZY);
                    events.CancelEvent(EVENT_TRANSFORMATION);
                    Talk(EMOTE_TRANSFORMED);
                }
            }

            void JustDied(Unit* killer)
            {
                Talk(SAY_DEATH);
                Talk(EMOTE_ALTAR);
                BossAI::JustDied(killer);
            }

            void KilledUnit(Unit*)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!me->IsInCombat())
                {
                    events2.Update(diff);
                    if (events2.ExecuteEvent() == EVENT_PHANTOM)
                    {
                        me->CastSpell(me, SPELL_SUMMON_PHANTOM, true);
                        events2.ScheduleEvent(EVENT_PHANTOM, urand(20000, 25000));
                    }
                }

                if (!UpdateVictim())
                return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_GROUND_TREMOR:
                        if (roll_chance_i(50))
                            Talk(SAY_QUAKE);
                        me->CastSpell(me, me->GetDisplayId() != me->GetNativeDisplayId() ? SPELL_QUAKE : SPELL_GROUND_TREMOR, false);
                        events.ScheduleEvent(EVENT_GROUND_TREMOR, 10000);
                        break;
                    case EVENT_NUMBLING_SHOUT:
                        me->CastSpell(me, me->GetDisplayId() != me->GetNativeDisplayId() ? SPELL_NUMBING_ROAR : SPELL_NUMBING_SHOUT, false);
                        events.ScheduleEvent(EVENT_NUMBLING_SHOUT, 10000);
                        break;
                    case EVENT_DETERMINED_STAB:
                        me->CastSpell(me->GetVictim(), me->GetDisplayId() != me->GetNativeDisplayId() ? SPELL_DETERMINED_GORE : SPELL_DETERMINED_STAB, false);
                        events.ScheduleEvent(EVENT_DETERMINED_STAB, 8000);
                        break;
                    case EVENT_TRANSFORMATION:
                        Talk(EMOTE_TRANSFORM);
                        Talk(SAY_TRANSFORM);
                        me->CastSpell(me, SPELL_TRANSFORMATION, false);
                        me->CastSpell(me,SPELL_SUMMON_PHANTOM_TRANSFORM, true);
                        events.ScheduleEvent(EVENT_TRANSFORMATION, 10000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

class spell_moorabi_mojo_frenzy : public SpellScriptLoader
{
    public:
        spell_moorabi_mojo_frenzy() : SpellScriptLoader("spell_moorabi_mojo_frenzy") { }

        class spell_moorabi_mojo_frenzy_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_moorabi_mojo_frenzy_AuraScript);

            void HandlePeriodic(AuraEffect const*  /*aurEff*/)
            {
                PreventDefaultAction();
                
                if (GetUnitOwner()->GetMap()->IsHeroic())
                    GetUnitOwner()->SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f * (GetUnitOwner()->GetHealthPct()*GetUnitOwner()->GetHealthPct()/10000.0f));
                else
                    GetUnitOwner()->SetFloatValue(UNIT_MOD_CAST_SPEED, 1.0f * (GetUnitOwner()->GetHealthPct()/100.0f));
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_moorabi_mojo_frenzy_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_moorabi_mojo_frenzy_AuraScript();
        }
};

class achievement_less_rabi : public AchievementCriteriaScript
{
    public:
        achievement_less_rabi() : AchievementCriteriaScript("achievement_less_rabi")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target)
        {
            return target && target->GetDisplayId() == target->GetNativeDisplayId();
        }
};

void AddSC_boss_moorabi()
{
    new boss_moorabi();
    new spell_moorabi_mojo_frenzy();
    new achievement_less_rabi();
}
