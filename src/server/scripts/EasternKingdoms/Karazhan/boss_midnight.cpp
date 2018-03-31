/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "karazhan.h"

enum eSay
{
    SAY_ATTUMEN1_APPEAR             = 0,
    SAY_ATTUMEN1_MOUNT              = 2,

    SAY_ATTUMEN2_DEATH              = 0,

    SAY_ATTUMEN_KILL                = 1,
    SAY_ATTUMEN_DISARM              = 3,
    SAY_ATTUMEN_RANDOM              = 4,
    SAY_ATTUMEN_MIDNIGHT_KILL       = 5,

    SAY_MIDNIGHT_EMOTE              = 0
};

enum eSpells
{
    // Midnight
    SPELL_KNOCKDOWN                 = 29711,
    SPELL_SUMMON_ATTUMEN            = 29714,
    SPELL_SUMMON_ATTUMEN_MOUNTED    = 29799,

    // Attumen
    SPELL_SHADOW_CLEAVE             = 29832,
    SPELL_INTANGIBLE_PRESENCE       = 29833,
    SPELL_SPAWN_SMOKE1              = 29802,

    // Attumen 2
    SPELL_CHARGE_MIDNIGHT           = 29847,
    SPELL_SPAWN_SMOKE2              = 10389,

    // Generic
    SPELL_MOUNT_TARGET_ATTUMEN      = 29769,
    SPELL_MOUNT_TARGET_MIDNIGHT     = 29770
};

enum eEvents
{
    EVENT_CHECK_HEALTH_95           = 1,
    EVENT_CHECK_HEALTH_25           = 2,
    EVENT_SPELL_KNOCKDOWN           = 3,
    EVENT_SUMMON_ATTUMEN_MOUNTED    = 4,

    EVENT_SPELL_SHADOW_CLEAVE       = 10,
    EVENT_SPELL_INTANGIBLE_PRESENCE = 11,
    EVENT_RANDOM_YELL               = 12,

    EVENT_SPELL_CHARGE              = 20,

    EVENT_KILL_TALK                 = 30
};

enum eMisc
{
    POINT_MOVE_TO_MIDNIGHT          = 1,
    DATA_ATTUMEN_READY              = 1
};

class boss_midnight : public CreatureScript
{
    public:
        boss_midnight() : CreatureScript("boss_midnight") { }

        struct boss_midnightAI : public BossAI
        {
            boss_midnightAI(Creature* creature) : BossAI(creature, DATA_ATTUMEN) { }

            void Reset()
            {
                BossAI::Reset();
                me->SetVisible(true);
                _healthPct = 100.0f;
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                events.ScheduleEvent(EVENT_CHECK_HEALTH_95, 0);
                events.ScheduleEvent(EVENT_SPELL_KNOCKDOWN, 6000);
                DoZoneInCombat();
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (Creature* attumen = summons.GetCreatureWithEntry(NPC_ATTUMEN_THE_HUNTSMAN))
                    attumen->AI()->Talk(SAY_ATTUMEN_MIDNIGHT_KILL);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                summon->SetInCombatWithZone();

                if (summon->GetEntry() == NPC_ATTUMEN_THE_HUNTSMAN_MOUNTED)
                {
                    summon->SetHealth(summon->CountPctFromMaxHealth(_healthPct));
                    summon->CastSpell(summon, SPELL_SPAWN_SMOKE2, true);
                }
                else
                    summon->CastSpell(summon, SPELL_SPAWN_SMOKE1, true);
            }

            void SetData(uint32 type, uint32 /*data*/)
            {
                if (type == DATA_ATTUMEN_READY)
                    events.ScheduleEvent(EVENT_SUMMON_ATTUMEN_MOUNTED, 0);
            }

            void SummonedCreatureDies(Creature* summon, Unit* /*killer*/)
            {
                if (summon->GetEntry() == NPC_ATTUMEN_THE_HUNTSMAN_MOUNTED)
                {
                    summons.clear();
                    Unit::Kill(me, me);
                }
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
                    case EVENT_CHECK_HEALTH_95:
                        if (me->HealthBelowPct(96))
                        {
                            me->CastSpell(me, SPELL_SUMMON_ATTUMEN, true);
                            events.ScheduleEvent(EVENT_CHECK_HEALTH_25, 0);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH_95, 500);
                        break;
                    case EVENT_CHECK_HEALTH_25:
                        if (me->HealthBelowPct(25))
                        {
                            Talk(SAY_MIDNIGHT_EMOTE);
                            me->CastSpell(me, SPELL_MOUNT_TARGET_ATTUMEN, true);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH_25, 500);
                        break;
                    case EVENT_SPELL_KNOCKDOWN:
                        me->CastSpell(me->GetVictim(), SPELL_KNOCKDOWN, false);
                        events.ScheduleEvent(EVENT_SPELL_KNOCKDOWN, 20000);
                        break;
                    case EVENT_SUMMON_ATTUMEN_MOUNTED:
                        if (Creature* attumen = summons.GetCreatureWithEntry(NPC_ATTUMEN_THE_HUNTSMAN))
                        {
                            _healthPct = std::max<float>(me->GetHealthPct(), attumen->GetHealthPct());
                            attumen->DespawnOrUnsummon();
                        }

                        me->CastSpell(me, SPELL_SUMMON_ATTUMEN_MOUNTED, true);
                        me->SetVisible(false);
                        break;
                }

                if (me->IsVisible())
                    DoMeleeAttackIfReady();
                EnterEvadeIfOutOfCombatArea();
            }
                    
            bool CheckEvadeIfOutOfCombatArea() const
            {
                return me->GetHomePosition().GetExactDist2d(me) > 50.0f || me->GetPositionZ() > 60.0f;
            }

        private:
            float _healthPct;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_midnightAI>(creature);
        }
};

class boss_attumen : public CreatureScript
{
    public:
        boss_attumen() : CreatureScript("boss_attumen") { }

        struct boss_attumenAI : public ScriptedAI
        {
            boss_attumenAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void Reset()
            {
                _events.Reset();
            }

            void EnterCombat(Unit* /*who*/)
            {
                Talk(SAY_ATTUMEN1_APPEAR);
                _events.ScheduleEvent(EVENT_CHECK_HEALTH_25, 0);
                _events.ScheduleEvent(EVENT_SPELL_SHADOW_CLEAVE, 6000);
                _events.ScheduleEvent(EVENT_SPELL_INTANGIBLE_PRESENCE, 15000);
                _events.ScheduleEvent(EVENT_RANDOM_YELL, urand(25000, 45000));
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (_events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    _events.ScheduleEvent(EVENT_KILL_TALK, 5000);
                    Talk(SAY_ATTUMEN_KILL);
                }
            }

            void SpellHit(Unit*  /*caster*/, const SpellInfo* spellInfo)
            {
                if (spellInfo->Mechanic == MECHANIC_DISARM && _events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    _events.ScheduleEvent(EVENT_KILL_TALK, 5000);
                    Talk(SAY_ATTUMEN_DISARM);
                }
                else if (spellInfo->Id == SPELL_MOUNT_TARGET_ATTUMEN)
                {
                    me->CastSpell(me, SPELL_MOUNT_TARGET_MIDNIGHT, true);
                }
            }

            void SpellHitTarget(Unit* target, const SpellInfo* spellInfo)
            {
                if (spellInfo->Id == SPELL_MOUNT_TARGET_MIDNIGHT)
                {
                    Talk(SAY_ATTUMEN1_MOUNT);
                    _events.Reset();
                    me->GetMotionMaster()->MovePoint(POINT_MOVE_TO_MIDNIGHT, target->GetPositionX() + 2.0f*cos(target->GetAngle(me)), target->GetPositionY() + 2.0f*sin(target->GetAngle(me)), target->GetPositionZ()+0.2f, true, true, MOTION_SLOT_CONTROLLED);
                }
            }

            void MovementInform(uint32 type, uint32 point)
            {
                if (type == POINT_MOTION_TYPE && point == POINT_MOVE_TO_MIDNIGHT)
                {
                    if (TempSummon* summon = me->ToTempSummon())
                        if (Unit* midnight = summon->GetSummoner())
                            midnight->GetAI()->SetData(DATA_ATTUMEN_READY, 0);
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                _events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (_events.ExecuteEvent())
                {
                    case EVENT_SPELL_SHADOW_CLEAVE:
                        me->CastSpell(me->GetVictim(), SPELL_SHADOW_CLEAVE, false);
                        _events.ScheduleEvent(EVENT_SPELL_SHADOW_CLEAVE, urand(9000, 14000));
                        break;
                    case EVENT_SPELL_INTANGIBLE_PRESENCE:
                        me->CastSpell(me->GetVictim(), SPELL_INTANGIBLE_PRESENCE, false);
                        _events.ScheduleEvent(EVENT_SPELL_INTANGIBLE_PRESENCE, 30000);
                        break;
                    case EVENT_RANDOM_YELL:
                        Talk(SAY_ATTUMEN_RANDOM);
                        _events.ScheduleEvent(EVENT_RANDOM_YELL, urand(30000, 70000));
                        break;
                    case EVENT_CHECK_HEALTH_25:
                        if (me->HealthBelowPct(25))
                        {
                            me->CastSpell(me, SPELL_MOUNT_TARGET_MIDNIGHT, true);
                            break;
                        }
                        _events.ScheduleEvent(EVENT_CHECK_HEALTH_25, 500);
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_attumenAI>(creature);
        }
};

class boss_attumen_midnight : public CreatureScript
{
    public:
        boss_attumen_midnight() : CreatureScript("boss_attumen_midnight") { }

        struct boss_attumen_midnightAI : public ScriptedAI
        {
            boss_attumen_midnightAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void Reset()
            {
                _events.Reset();
            }

            void EnterCombat(Unit* /*who*/)
            {
                _events.ScheduleEvent(EVENT_SPELL_SHADOW_CLEAVE, 6000);
                _events.ScheduleEvent(EVENT_SPELL_INTANGIBLE_PRESENCE, 15000);
                _events.ScheduleEvent(EVENT_RANDOM_YELL, urand(25000, 45000));
                _events.ScheduleEvent(EVENT_SPELL_CHARGE, 20000);
                _events.ScheduleEvent(EVENT_SPELL_KNOCKDOWN, 11000);
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (_events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    _events.ScheduleEvent(EVENT_KILL_TALK, 5000);
                    Talk(SAY_ATTUMEN_KILL);
                }
            }

            void JustDied(Unit* /*killer*/)
            {
                Talk(SAY_ATTUMEN2_DEATH);
            }

            void SpellHit(Unit*  /*caster*/, const SpellInfo* spellInfo)
            {
                if (spellInfo->Mechanic == MECHANIC_DISARM && _events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    _events.ScheduleEvent(EVENT_KILL_TALK, 5000);
                    Talk(SAY_ATTUMEN_DISARM);
                }
            }

            void MovementInform(uint32 type, uint32 point)
            {
                if (type == POINT_MOTION_TYPE && point == POINT_MOVE_TO_MIDNIGHT)
                {
                    if (TempSummon* summon = me->ToTempSummon())
                        if (Unit* midnight = summon->GetSummoner())
                            midnight->GetAI()->SetData(DATA_ATTUMEN_READY, 0);
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                _events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (_events.ExecuteEvent())
                {
                    case EVENT_SPELL_SHADOW_CLEAVE:
                        me->CastSpell(me->GetVictim(), SPELL_SHADOW_CLEAVE, false);
                        _events.ScheduleEvent(EVENT_SPELL_SHADOW_CLEAVE, urand(9000, 14000));
                        break;
                    case EVENT_SPELL_INTANGIBLE_PRESENCE:
                        me->CastSpell(me->GetVictim(), SPELL_INTANGIBLE_PRESENCE, false);
                        _events.ScheduleEvent(EVENT_SPELL_INTANGIBLE_PRESENCE, 30000);
                        break;
                    case EVENT_RANDOM_YELL:
                        Talk(SAY_ATTUMEN_RANDOM);
                        _events.ScheduleEvent(EVENT_RANDOM_YELL, urand(30000, 70000));
                        break;
                    case EVENT_SPELL_CHARGE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_FARTHEST, 0, 24.0f, true)) 
                            me->CastSpell(target, SPELL_CHARGE_MIDNIGHT, false);
                        _events.ScheduleEvent(EVENT_SPELL_CHARGE, 20000);
                        break;
                    case EVENT_SPELL_KNOCKDOWN:
                        me->CastSpell(me->GetVictim(), SPELL_KNOCKDOWN, false);
                        _events.ScheduleEvent(EVENT_SPELL_KNOCKDOWN, 20000);
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_attumen_midnightAI>(creature);
        }
};

class spell_midnight_fixate : public SpellScriptLoader
{
    public:
        spell_midnight_fixate() : SpellScriptLoader("spell_midnight_fixate") { }

        class spell_midnight_fixate_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_midnight_fixate_AuraScript);

            void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if (Unit* caster = GetCaster())
                    caster->TauntApply(target);
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if (Unit* caster = GetCaster())
                    caster->TauntFadeOut(target);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_midnight_fixate_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_midnight_fixate_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }

        };

        AuraScript* GetAuraScript() const
        {
            return new spell_midnight_fixate_AuraScript();
        }
};

void AddSC_boss_attumen()
{
    new boss_midnight();
    new boss_attumen();
    new boss_attumen_midnight();
    new spell_midnight_fixate();
}
