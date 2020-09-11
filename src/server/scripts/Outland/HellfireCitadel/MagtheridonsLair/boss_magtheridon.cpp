/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "magtheridons_lair.h"
#include "SpellInfo.h"

enum Yells
{
    SAY_TAUNT                       = 0,
    SAY_FREE                        = 1,
    SAY_AGGRO                       = 2,
    SAY_SLAY                        = 3,
    SAY_BANISH                      = 4,
    SAY_PHASE3                      = 5,
    SAY_DEATH                       = 6,
};

enum Emotes
{
    SAY_EMOTE_BEGIN                 = 7,
    SAY_EMOTE_NEARLY                = 8,
    SAY_EMOTE_FREE                  = 9,
    SAY_EMOTE_NOVA                  = 10
};

enum Spells
{
    SPELL_SHADOW_CAGE           = 30205,
    SPELL_BLAST_NOVA            = 30616,
    SPELL_CLEAVE                = 30619,
    SPELL_BLAZE                 = 30541,
    SPELL_BLAZE_SUMMON          = 30542,
    SPELL_BERSERK               = 27680,
    SPELL_SHADOW_GRASP_VISUAL   = 30166,
    SPELL_MIND_EXHAUSTION       = 44032,
    SPELL_QUAKE                 = 30657,
    SPELL_COLLAPSE_DAMAGE       = 36449,
    SPELL_CAMERA_SHAKE          = 36455,
    SPELL_DEBRIS_VISUAL         = 30632,
    SPELL_DEBRIS_DAMAGE         = 30631
};

enum Events
{
    EVENT_EMOTE1                = 1,
    EVENT_EMOTE2                = 2,
    EVENT_EMOTE3                = 3,
    EVENT_ENTER_COMBAT          = 4,
    EVENT_RECENTLY_SPOKEN       = 5,

    EVENT_CLEAVE                = 10,
    EVENT_BLAST_NOVA            = 11,
    EVENT_BLAZE                 = 12,
    EVENT_ENRAGE                = 13,
    EVENT_QUAKE                 = 14,
    EVENT_CHECK_HEALTH          = 15,
    EVENT_COLLAPSE_CEIL         = 16,
    EVENT_COLLAPSE_DAMAGE       = 17,
    EVENT_DEBRIS                = 18,

    EVENT_RANDOM_TAUNT          = 30,
    EVENT_CHECK_GRASP           = 31,
    EVENT_CANCEL_GRASP_CHECK    = 32
};

class DealDebrisDamage : public BasicEvent
{
public:
    DealDebrisDamage(Creature& creature, uint64 targetGUID) : _owner(creature), _targetGUID(targetGUID) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/)
    {
        if (Unit* target = ObjectAccessor::GetUnit(_owner, _targetGUID))
            target->CastSpell(target, SPELL_DEBRIS_DAMAGE, true, nullptr, nullptr, _owner.GetGUID());
        return true;
    }

private:
    Creature& _owner;
    uint64 _targetGUID;
};

class boss_magtheridon : public CreatureScript
{
    public:

        boss_magtheridon() : CreatureScript("boss_magtheridon") { }

        struct boss_magtheridonAI : public BossAI
        {
            boss_magtheridonAI(Creature* creature) : BossAI(creature, TYPE_MAGTHERIDON) { }

            EventMap events2;
 

            void Reset()
            {
                events2.Reset();
                events2.ScheduleEvent(EVENT_RANDOM_TAUNT, 90000);
                _Reset();
                me->CastSpell(me, SPELL_SHADOW_CAGE, true);
                me->SetReactState(REACT_PASSIVE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_IMMUNE_TO_PC);
            }

            void KilledUnit(Unit*  /*victim*/)
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

            void MoveInLineOfSight(Unit* /*who*/) { }

            void EnterCombat(Unit* /*who*/)
            {
                events2.Reset();
                _EnterCombat();
                events.ScheduleEvent(EVENT_EMOTE1, 0);
                events.ScheduleEvent(EVENT_EMOTE2, 60000);
                events.ScheduleEvent(EVENT_EMOTE3, 120000);
                events.ScheduleEvent(EVENT_ENTER_COMBAT, 123000);

           }

            void UpdateAI(uint32 diff)
            {
                events2.Update(diff);
                switch (events2.ExecuteEvent())
                {
                    case EVENT_RANDOM_TAUNT:
                        Talk(SAY_TAUNT);
                        events2.ScheduleEvent(EVENT_RANDOM_TAUNT, 90000);
                        break;
                    case EVENT_CHECK_GRASP:
                        if (me->GetAuraCount(SPELL_SHADOW_GRASP_VISUAL) == 5)
                        {
                            Talk(SAY_BANISH);
                            me->InterruptNonMeleeSpells(true);
                            break;
                        }
                        events2.ScheduleEvent(EVENT_CHECK_GRASP, 0);
                        break;
                }


                if (!UpdateVictim() || !CheckInRoom())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_EMOTE1:
                        Talk(SAY_EMOTE_BEGIN);
                        break;
                    case EVENT_EMOTE2:
                        Talk(SAY_EMOTE_NEARLY);
                        break;
                    case EVENT_EMOTE3:
                        Talk(SAY_EMOTE_FREE);
                        Talk(SAY_FREE);
                        break;
                    case EVENT_ENTER_COMBAT:
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_IMMUNE_TO_PC);
                        me->SetReactState(REACT_AGGRESSIVE);
                        events.ScheduleEvent(EVENT_CLEAVE, 9000);
                        events.ScheduleEvent(EVENT_BLAST_NOVA, 60000);
                        events.ScheduleEvent(EVENT_BLAZE, 10000);
                        events.ScheduleEvent(EVENT_QUAKE, 40000);
                        events.ScheduleEvent(EVENT_CHECK_HEALTH, 500);
                        events.ScheduleEvent(EVENT_ENRAGE, 22*MINUTE*IN_MILLISECONDS);

                        instance->SetData(DATA_ACTIVATE_CUBES, 1);
                        me->RemoveAurasDueToSpell(SPELL_SHADOW_CAGE);
                        break;
                    case EVENT_CLEAVE:
                        me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                        events.ScheduleEvent(EVENT_CLEAVE, 10000);
                        break;
                    case EVENT_BLAST_NOVA:
                        me->CastSpell(me, SPELL_BLAST_NOVA, false);
                        events.ScheduleEvent(EVENT_BLAST_NOVA, 60000);
                        events.ScheduleEvent(EVENT_CANCEL_GRASP_CHECK, 12000);
                        events2.ScheduleEvent(EVENT_CHECK_GRASP, 0);
                        break;
                    case EVENT_BLAZE:
                        me->CastCustomSpell(SPELL_BLAZE, SPELLVALUE_MAX_TARGETS, 1);
                        events.ScheduleEvent(EVENT_BLAZE, 30000);
                        break;
                    case EVENT_ENRAGE:
                        me->CastSpell(me, SPELL_BERSERK, true);
                        break;
                    case EVENT_CANCEL_GRASP_CHECK:
                        events2.Reset();
                        break;
                    case EVENT_QUAKE:
                        me->CastSpell(me, SPELL_QUAKE, false);
                        events.ScheduleEvent(EVENT_QUAKE, 50000);
                        break;
                    case EVENT_CHECK_HEALTH:
                        if (me->HealthBelowPct(30))
                        {
                            Talk(SAY_PHASE3);
                            events.SetPhase(1);
                            events.DelayEvents(18000);
                            events.ScheduleEvent(EVENT_COLLAPSE_CEIL, 8000);
                            events.ScheduleEvent(EVENT_COLLAPSE_DAMAGE, 15000);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH, 500);
                        break;
                    case EVENT_COLLAPSE_CEIL:
                        me->CastSpell(me, SPELL_CAMERA_SHAKE, true);
                        instance->SetData(DATA_COLLAPSE, GO_STATE_ACTIVE);
                        break;
                    case EVENT_COLLAPSE_DAMAGE:
                        me->CastSpell(me, SPELL_COLLAPSE_DAMAGE, true);
                        me->resetAttackTimer();
                        events.SetPhase(0);
                        events.ScheduleEvent(EVENT_DEBRIS, 20000);
                        break;
                    case EVENT_DEBRIS:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                        {
                            target->CastSpell(target, SPELL_DEBRIS_VISUAL, true, nullptr, nullptr, me->GetGUID());
                            me->m_Events.AddEvent(new DealDebrisDamage(*me, target->GetGUID()), me->m_Events.CalculateTime(5000));
                        }
                        events.ScheduleEvent(EVENT_DEBRIS, 20000);
                        break;
                }

                if (!events.IsInPhase(1))
                    DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_magtheridonAI>(creature);
        }
};

class spell_magtheridon_blaze : public SpellScriptLoader
{
    public:
        spell_magtheridon_blaze() : SpellScriptLoader("spell_magtheridon_blaze") { }

        class spell_magtheridon_blaze_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_magtheridon_blaze_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, SPELL_BLAZE_SUMMON, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_magtheridon_blaze_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_magtheridon_blaze_SpellScript();
        }
};

class spell_magtheridon_shadow_grasp : public SpellScriptLoader
{
public:
    spell_magtheridon_shadow_grasp() : SpellScriptLoader("spell_magtheridon_shadow_grasp") { }

    class spell_magtheridon_shadow_grasp_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_magtheridon_shadow_grasp_AuraScript)
        
        void HandleDummyApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetUnitOwner()->CastSpell((Unit*)NULL, SPELL_SHADOW_GRASP_VISUAL, false);
        }
        
        void HandleDummyRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetUnitOwner()->InterruptNonMeleeSpells(true);
        }

        void HandlePeriodicRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_MIND_EXHAUSTION, true);
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_magtheridon_shadow_grasp_AuraScript::HandleDummyApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_magtheridon_shadow_grasp_AuraScript::HandleDummyRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_magtheridon_shadow_grasp_AuraScript::HandlePeriodicRemove, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_magtheridon_shadow_grasp_AuraScript();
    }
};

void AddSC_boss_magtheridon()
{
    new boss_magtheridon();
    new spell_magtheridon_blaze();
    new spell_magtheridon_shadow_grasp();
}

