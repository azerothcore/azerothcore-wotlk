/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "drak_tharon_keep.h"
#include "SpellAuras.h"

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

            void Reset()
            {
                BossAI::Reset();
                events2.Reset();
                events2.ScheduleEvent(EVENT_SPAWN_INVADERS, 30000);
            }

            void EnterCombat(Unit* who)
            {
                events.ScheduleEvent(EVENT_SPELL_INFECTED_WOUND, urand(6000,10000));
                events.ScheduleEvent(EVENT_SPELL_CRUSH, urand(3000,5000));
                events.ScheduleEvent(EVENT_SPELL_CONSUME, 15000);
                events.ScheduleEvent(EVENT_SPELL_CORPSE_EXPLODE, 35000);
                events.ScheduleEvent(EVENT_SPAWN_INVADERS, 20000, 30000);
                
                me->setActive(true);
                instance->SetBossState(DATA_TROLLGORE, IN_PROGRESS);
                if (who->GetTypeId() == TYPEID_PLAYER)
                {
                    Talk(SAY_AGGRO);
                    me->SetInCombatWithZone();
                }
            }

            void JustDied(Unit* killer)
            {
                Talk(SAY_DEATH);
                BossAI::JustDied(killer);
            }

            void KilledUnit(Unit*  /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_KILL);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
            }

            void UpdateAI(uint32 diff)
            {
                events2.Update(diff);
                switch (events2.ExecuteEvent())
                {
                    case EVENT_SPAWN_INVADERS:
                        me->CastSpell(me, SPELL_SUMMON_INVADER_A, true);
                        me->CastSpell(me, SPELL_SUMMON_INVADER_B, true);
                        me->CastSpell(me, SPELL_SUMMON_INVADER_C, true);
                        events2.ScheduleEvent(EVENT_SPAWN_INVADERS, 30000);
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
                        events.ScheduleEvent(EVENT_SPELL_INFECTED_WOUND, urand(25000,35000));
                        break;
                    case EVENT_SPELL_CRUSH:
                        me->CastSpell(me->GetVictim(), SPELL_CRUSH, false);
                        events.ScheduleEvent(EVENT_SPELL_CRUSH, urand(10000,15000));
                        break;
                    case EVENT_SPELL_CONSUME:
                        Talk(SAY_CONSUME);
                        me->CastSpell(me, SPELL_CONSUME, false);
                        events.ScheduleEvent(EVENT_SPELL_CONSUME, 15000);
                        break;
                    case EVENT_SPELL_CORPSE_EXPLODE:
                        Talk(SAY_EXPLODE);
                        me->CastSpell(me, SPELL_CORPSE_EXPLODE, false);
                        events.ScheduleEvent(EVENT_SPELL_CORPSE_EXPLODE, urand(15000,19000));
                        break;
                }

                DoMeleeAttackIfReady();
                EnterEvadeIfOutOfCombatArea();
            }
                    
            bool CheckEvadeIfOutOfCombatArea() const
            {
                return me->GetHomePosition().GetExactDist2d(me) > 60.0f;
            }

        private:
            EventMap events2;
        };

        CreatureAI *GetAI(Creature *creature) const
        {
            return GetInstanceAI<boss_trollgoreAI>(creature);
        }
};

class spell_trollgore_consume : public SpellScriptLoader
{
    public:
        spell_trollgore_consume() : SpellScriptLoader("spell_trollgore_consume") { }

        class spell_trollgore_consume_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_trollgore_consume_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    target->CastSpell(GetCaster(), SPELL_CONSUME_AURA, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_trollgore_consume_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_trollgore_consume_SpellScript();
        }
};

class spell_trollgore_corpse_explode : public SpellScriptLoader
{
    public:
        spell_trollgore_corpse_explode() : SpellScriptLoader("spell_trollgore_corpse_explode") { }

        class spell_trollgore_corpse_explode_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_trollgore_corpse_explode_AuraScript);

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

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_trollgore_corpse_explode_AuraScript::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
                AfterEffectRemove += AuraEffectRemoveFn(spell_trollgore_corpse_explode_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_trollgore_corpse_explode_AuraScript();
        }
};

class spell_trollgore_invader_taunt : public SpellScriptLoader
{
    public:
        spell_trollgore_invader_taunt() : SpellScriptLoader("spell_trollgore_invader_taunt") { }

        class spell_trollgore_invader_taunt_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_trollgore_invader_taunt_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    target->CastSpell(GetCaster(), uint32(GetEffectValue()), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_trollgore_invader_taunt_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_trollgore_invader_taunt_SpellScript();
        }
};

class achievement_consumption_junction : public AchievementCriteriaScript
{
    public:
        achievement_consumption_junction() : AchievementCriteriaScript("achievement_consumption_junction")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target)
        {
            if (!target)
                return false;

            return target->GetAuraCount(sSpellMgr->GetSpellIdForDifficulty(SPELL_CONSUME_AURA, target)) < 10;
        }
};

void AddSC_boss_trollgore()
{
    new boss_trollgore();
    new spell_trollgore_consume();
    new spell_trollgore_corpse_explode();
    new spell_trollgore_invader_taunt();
    new achievement_consumption_junction();
}
