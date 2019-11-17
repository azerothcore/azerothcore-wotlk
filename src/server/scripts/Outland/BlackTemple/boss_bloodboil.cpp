/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "black_temple.h"

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_SPECIAL                     = 2,
    SAY_ENRAGE                      = 3,
    SAY_DEATH                       = 4
};

enum Spells
{
    SPELL_ACIDIC_WOUND              = 40484,
    SPELL_FEL_ACID_BREATH1          = 40508,
    SPELL_FEL_ACID_BREATH2          = 40595,
    SPELL_ARCING_SMASH1             = 40457,
    SPELL_ARCING_SMASH2             = 40599,
    SPELL_EJECT1                    = 40486,
    SPELL_EJECT2                    = 40597,
    SPELL_BEWILDERING_STRIKE        = 40491,
    SPELL_BLOODBOIL                 = 42005,
    SPELL_ACID_GEYSER               = 40630,
    SPELL_BERSERK                   = 45078,
    SPELL_CHARGE                    = 40602,

    SPELL_FEL_GEYSER_SUMMON         = 40569,
    SPELL_FEL_GEYSER_STUN           = 40591,
    SPELL_FEL_GEYSER_DAMAGE         = 40593,

    SPELL_FEL_RAGE_SELF             = 40594,
    SPELL_FEL_RAGE_TARGET           = 40604,
    SPELL_FEL_RAGE_2                = 40616,
    SPELL_FEL_RAGE_3                = 41625,
    SPELL_FEL_RAGE_SIZE             = 46787,
    SPELL_TAUNT_GURTOGG             = 40603,
    SPELL_INSIGNIFICANCE            = 40618
};

enum Misc
{
    EVENT_SPELL_BLOOD_BOIL          = 1,
    EVENT_SPELL_BEWILDERING_STRIKE  = 2,
    EVENT_SPELL_FEL_ACID_BREATH     = 3,
    EVENT_SPELL_EJECT               = 4,
    EVENT_SPELL_ARCING_SMASH        = 5,
    EVENT_SPELL_CHARGE              = 6,
    EVENT_SPELL_BERSERK             = 7,
    EVENT_SPELL_FEL_GEYSER          = 8,
    EVENT_KILL_TALK                 = 9,

    GROUP_DELAY                     = 1
};

class boss_gurtogg_bloodboil : public CreatureScript
{
    public:
        boss_gurtogg_bloodboil() : CreatureScript("boss_gurtogg_bloodboil") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_gurtogg_bloodboilAI>(creature);
        }

        struct boss_gurtogg_bloodboilAI : public BossAI
        {
            boss_gurtogg_bloodboilAI(Creature* creature) : BossAI(creature, DATA_GURTOGG_BLOODBOIL)
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

                me->CastSpell(me, SPELL_ACIDIC_WOUND, true);
                events.ScheduleEvent(EVENT_SPELL_BLOOD_BOIL, 10000);
                events.ScheduleEvent(EVENT_SPELL_BEWILDERING_STRIKE, 28000, GROUP_DELAY);
                events.ScheduleEvent(EVENT_SPELL_FEL_ACID_BREATH, 38000);
                events.ScheduleEvent(EVENT_SPELL_EJECT, 14000);
                events.ScheduleEvent(EVENT_SPELL_ARCING_SMASH, 5000);
                events.ScheduleEvent(EVENT_SPELL_FEL_GEYSER, 60000);
                events.ScheduleEvent(EVENT_SPELL_BERSERK, 600000);
            }

            void KilledUnit(Unit*  /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                summon->CastSpell(summon, SPELL_FEL_GEYSER_DAMAGE, false);
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
                    case EVENT_SPELL_BERSERK:
                        Talk(SAY_ENRAGE);
                        me->CastSpell(me, SPELL_BERSERK, true);
                        break;
                    case EVENT_SPELL_BLOOD_BOIL:
                        me->CastCustomSpell(SPELL_BLOODBOIL, SPELLVALUE_MAX_TARGETS, 5, me, false);
                        events.ScheduleEvent(EVENT_SPELL_BLOOD_BOIL, 10000);
                        break;
                    case EVENT_SPELL_BEWILDERING_STRIKE:
                        me->CastSpell(me->GetVictim(), SPELL_BEWILDERING_STRIKE, false);
                        events.ScheduleEvent(EVENT_SPELL_BEWILDERING_STRIKE, 30000, GROUP_DELAY);
                        break;
                    case EVENT_SPELL_FEL_ACID_BREATH:
                        me->CastSpell(me->GetVictim(), me->HasAura(SPELL_FEL_RAGE_SELF) ? SPELL_FEL_ACID_BREATH2 : SPELL_FEL_ACID_BREATH1, false);
                        events.ScheduleEvent(EVENT_SPELL_FEL_ACID_BREATH, 30000);
                        break;
                    case EVENT_SPELL_EJECT:
                        me->CastSpell(me->GetVictim(), me->HasAura(SPELL_FEL_RAGE_SELF) ? SPELL_EJECT2 : SPELL_EJECT1, false);
                        events.ScheduleEvent(EVENT_SPELL_EJECT, 20000);
                        break;
                    case EVENT_SPELL_ARCING_SMASH:
                        me->CastSpell(me->GetVictim(), me->HasAura(SPELL_FEL_RAGE_SELF) ? SPELL_ARCING_SMASH2 : SPELL_ARCING_SMASH1, false);
                        events.ScheduleEvent(EVENT_SPELL_ARCING_SMASH, 15000);
                        break;
                    case EVENT_SPELL_FEL_GEYSER:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 40.0f, true))
                        {
                            me->RemoveAurasByType(SPELL_AURA_MOD_TAUNT);
                            me->CastSpell(me, SPELL_FEL_RAGE_SELF, true);
                            me->CastSpell(target, SPELL_FEL_RAGE_TARGET, true);
                            me->CastSpell(target, SPELL_FEL_RAGE_2, true);
                            me->CastSpell(target, SPELL_FEL_RAGE_3, true);
                            me->CastSpell(target, SPELL_FEL_RAGE_SIZE, true);
                            target->CastSpell(me, SPELL_TAUNT_GURTOGG, true);

                            me->CastSpell(target, SPELL_FEL_GEYSER_SUMMON, true);
                            me->CastSpell(me, SPELL_FEL_GEYSER_STUN, true);
                            me->CastSpell(me, SPELL_INSIGNIFICANCE, true);
                            events.ScheduleEvent(EVENT_SPELL_CHARGE, 2000);
                            events.DelayEvents(30000, GROUP_DELAY);
                        }
                        events.ScheduleEvent(EVENT_SPELL_FEL_GEYSER, 90000);
                        break;
                    case EVENT_SPELL_CHARGE:
                        me->CastSpell(me->GetVictim(), SPELL_CHARGE, true);
                        break;
                }

                DoMeleeAttackIfReady();
                EnterEvadeIfOutOfCombatArea();
            }
    
            bool CheckEvadeIfOutOfCombatArea() const
            {
                return me->GetHomePosition().GetExactDist2d(me) > 105.0f;
            }
        };

};

class spell_gurtogg_bloodboil : public SpellScriptLoader
{
    public:
        spell_gurtogg_bloodboil() : SpellScriptLoader("spell_gurtogg_bloodboil") { }

        class spell_gurtogg_bloodboil_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_gurtogg_bloodboil_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                if (targets.empty())
                    return;

                targets.sort(acore::ObjectDistanceOrderPred(GetCaster(), false));
                if (targets.size() > GetSpellValue()->MaxAffectedTargets)
                {
                    std::list<WorldObject*>::iterator itr = targets.begin();
                    std::advance(itr, GetSpellValue()->MaxAffectedTargets);
                    targets.erase(itr, targets.end());
                }
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_gurtogg_bloodboil_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_gurtogg_bloodboil_SpellScript();
        }
};

class spell_gurtogg_eject : public SpellScriptLoader
{
    public:
        spell_gurtogg_eject() : SpellScriptLoader("spell_gurtogg_eject") { }

        class spell_gurtogg_eject_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_gurtogg_eject_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    GetCaster()->getThreatManager().modifyThreatPercent(target, -20);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_gurtogg_eject_SpellScript::HandleScriptEffect, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_gurtogg_eject_SpellScript();
        }
};

void AddSC_boss_gurtogg_bloodboil()
{
    new boss_gurtogg_bloodboil();
    new spell_gurtogg_bloodboil();
    new spell_gurtogg_eject();
}
