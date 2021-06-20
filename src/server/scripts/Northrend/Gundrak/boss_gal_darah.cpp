/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "gundrak.h"

enum Spells
{
    SPELL_START_VISUAL                  = 54988,
    SPELL_ENRAGE                        = 55285,
    SPELL_IMPALING_CHARGE               = 54956,
    SPELL_IMPALING_CHARGE_VEHICLE       = 54958,
    SPELL_STOMP                         = 55292,
    SPELL_PUNCTURE                      = 55276,
    SPELL_STAMPEDE                      = 55218,
    SPELL_STAMPEDE_DMG                  = 55220,
    SPELL_WHIRLING_SLASH                = 55250,
    SPELL_TRANSFORM_TO_RHINO            = 55297,
    SPELL_TRANSFORM_TO_TROLL            = 55299
};

enum Yells
{
    SAY_AGGRO                           = 0,
    SAY_SLAY                            = 1,
    SAY_DEATH                           = 2,
    SAY_SUMMON_RHINO                    = 3,
    SAY_TRANSFORM_1                     = 4,
    SAY_TRANSFORM_2                     = 5
};

enum Events
{
    EVENT_STAMPEDE                      = 1,
    EVENT_WHIRLING_SLASH                = 2,
    EVENT_PUNCTURE                      = 3,
    EVENT_ENRAGE                        = 4,
    EVENT_IMPALING_CHARGE               = 5,
    EVENT_UNSUMMON_RHINO                = 6,
    EVENT_STOMP                         = 7,
    EVENT_KILL_TALK                     = 8
};

class boss_gal_darah : public CreatureScript
{
    public:
        boss_gal_darah() : CreatureScript("boss_gal_darah") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_gal_darahAI>(creature);
        }

        struct boss_gal_darahAI : public BossAI
        {
            boss_gal_darahAI(Creature* creature) : BossAI(creature, DATA_GAL_DARAH)
            {
            }

            uint8 phaseCounter;
            std::set<uint64> impaledList;

            void Reset()
            {
                BossAI::Reset();
                impaledList.clear();
                phaseCounter = 0;
            }

            void InitializeAI()
            {
                BossAI::InitializeAI();
                me->CastSpell(me, SPELL_START_VISUAL, false);
            }

            void JustReachedHome()
            {
                BossAI::JustReachedHome();
                me->CastSpell(me, SPELL_START_VISUAL, false);
            }

            void ScheduleEvents(bool troll)
            {
                events.Reset();
                if (troll)
                {
                    events.RescheduleEvent(EVENT_STAMPEDE, 10000);
                    events.RescheduleEvent(EVENT_WHIRLING_SLASH, 21000);
                }
                else
                {
                    events.RescheduleEvent(EVENT_PUNCTURE, 10000);
                    events.RescheduleEvent(EVENT_ENRAGE, 15000);
                    events.RescheduleEvent(EVENT_IMPALING_CHARGE, 21000);
                    events.RescheduleEvent(EVENT_STOMP, 5000);
                }
            }

            void EnterCombat(Unit* who)
            {
                Talk(SAY_AGGRO);
                BossAI::EnterCombat(who);

                ScheduleEvents(true);
                me->RemoveAurasDueToSpell(SPELL_START_VISUAL);
                me->InterruptNonMeleeSpells(true);
            }

            void JustSummoned(Creature* summon)
            {
                uint32 despawnTime = 0;
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 60.0f, true))
                {
                    summon->CastSpell(target, SPELL_STAMPEDE_DMG, true);
                    despawnTime = (summon->GetDistance(target)/40.0f*1000)+500;
                }

                summon->DespawnOrUnsummon(despawnTime);
            }

            uint32 GetData(uint32  /*type*/) const
            {
                return impaledList.size();
            }

            void JustDied(Unit* killer)
            {
                Talk(SAY_DEATH);
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
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING|UNIT_STATE_CHARGING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_STAMPEDE:
                        Talk(SAY_SUMMON_RHINO);
                        me->CastSpell(me->GetVictim(), SPELL_STAMPEDE, false);
                        events.ScheduleEvent(EVENT_STAMPEDE, 15000);
                        break;
                    case EVENT_WHIRLING_SLASH:
                        if (++phaseCounter >= 3)
                        {
                            ScheduleEvents(false);
                            me->CastSpell(me, SPELL_TRANSFORM_TO_RHINO, false);
                            Talk(SAY_TRANSFORM_1);
                            phaseCounter = 0;
                            return;
                        }
                        events.ScheduleEvent(EVENT_WHIRLING_SLASH, 21000);
                        me->CastSpell(me, SPELL_WHIRLING_SLASH, false);
                        break;
                    case EVENT_PUNCTURE:
                        me->CastSpell(me->GetVictim(), SPELL_PUNCTURE, false);
                        events.ScheduleEvent(EVENT_PUNCTURE, 8000);
                        break;
                    case EVENT_ENRAGE:
                        me->CastSpell(me, SPELL_ENRAGE, false);
                        events.ScheduleEvent(EVENT_ENRAGE, 20000);
                        break;
                    case EVENT_STOMP:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f, true))
                            me->CastSpell(target, SPELL_STOMP, false);
                        events.ScheduleEvent(EVENT_STOMP, 20000);
                        break;
                    case EVENT_IMPALING_CHARGE:
                        if (++phaseCounter >= 3)
                        {
                            ScheduleEvents(true);
                            me->CastSpell(me, SPELL_TRANSFORM_TO_TROLL, false);
                            Talk(SAY_TRANSFORM_2);
                            phaseCounter = 0;
                            return;
                        }
                        events.ScheduleEvent(EVENT_IMPALING_CHARGE, 21000);
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 100.0f, true))
                        {
                            me->CastSpell(target, SPELL_IMPALING_CHARGE, false);
                            impaledList.insert(target->GetGUID());
                        }
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

class spell_galdarah_impaling_charge : public SpellScriptLoader
{
    public:
        spell_galdarah_impaling_charge() : SpellScriptLoader("spell_galdarah_impaling_charge") { }

        class spell_galdarah_impaling_charge_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_galdarah_impaling_charge_SpellScript);

            void HandleApplyAura(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    target->CastSpell(GetCaster(), SPELL_IMPALING_CHARGE_VEHICLE, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_galdarah_impaling_charge_SpellScript::HandleApplyAura, EFFECT_1, SPELL_EFFECT_APPLY_AURA);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_galdarah_impaling_charge_SpellScript();
        }
};

class spell_galdarah_transform : public SpellScriptLoader
{
    public:
        spell_galdarah_transform() : SpellScriptLoader("spell_galdarah_transform") { }

        class spell_galdarah_transform_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_galdarah_transform_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    target->RemoveAurasDueToSpell(SPELL_TRANSFORM_TO_RHINO);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_galdarah_transform_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_galdarah_transform_SpellScript();
        }
};

class achievement_share_the_love : public AchievementCriteriaScript
{
    public:
        achievement_share_the_love() : AchievementCriteriaScript("achievement_share_the_love")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target)
        {
            if (!target)
                return false;

            return target->GetAI()->GetData(target->GetEntry()) >= 5;
        }
};

void AddSC_boss_gal_darah()
{
    new boss_gal_darah();
    new spell_galdarah_impaling_charge();
    new spell_galdarah_transform();
    new achievement_share_the_love();
}
