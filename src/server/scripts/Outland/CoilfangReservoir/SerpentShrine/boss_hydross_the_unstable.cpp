/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "serpent_shrine.h"

enum Talk
{
    SAY_AGGRO                   = 0,
    SAY_SWITCH_TO_CLEAN         = 1,
    SAY_CLEAN_SLAY              = 2,
    SAY_CLEAN_DEATH             = 3,
    SAY_SWITCH_TO_CORRUPT       = 4,
    SAY_CORRUPT_SLAY            = 5,
    SAY_CORRUPT_DEATH           = 6
};

enum Spells
{
    SPELL_CLEANSING_FIELD_AURA  = 37935,
    SPELL_CLEANSING_FIELD       = 37934,
    SPELL_BLUE_BEAM             = 38015,
    SPELL_ELEMENTAL_SPAWNIN     = 25035,

    SPELL_SUMMON_CORRUPTED1     = 38188,
    SPELL_SUMMON_CORRUPTED2     = 38189,
    SPELL_SUMMON_CORRUPTED3     = 38190,
    SPELL_SUMMON_CORRUPTED4     = 38191,
    SPELL_SUMMON_PURIFIED1      = 38198,
    SPELL_SUMMON_PURIFIED2      = 38199,
    SPELL_SUMMON_PURIFIED3      = 38200,
    SPELL_SUMMON_PURIFIED4      = 38201,

    SPELL_CORRUPTION            = 37961,
    SPELL_WATER_TOMB            = 38235,
    SPELL_VILE_SLUDGE           = 38246,
    SPELL_ENRAGE                = 27680,

    SPELL_MARK_OF_HYDROSS1      = 38215,
    SPELL_MARK_OF_HYDROSS2      = 38216,
    SPELL_MARK_OF_HYDROSS3      = 38217,
    SPELL_MARK_OF_HYDROSS4      = 38218,
    SPELL_MARK_OF_HYDROSS5      = 38231,
    SPELL_MARK_OF_HYDROSS6      = 40584,
    SPELL_MARK_OF_CORRUPTION1   = 38219,
    SPELL_MARK_OF_CORRUPTION2   = 38220,
    SPELL_MARK_OF_CORRUPTION3   = 38221,
    SPELL_MARK_OF_CORRUPTION4   = 38222,
    SPELL_MARK_OF_CORRUPTION5   = 38230,
    SPELL_MARK_OF_CORRUPTION6   = 40583,
};

enum Misc
{
    GROUP_ABILITIES                 = 1,
    NPC_PURE_SPAWN_OF_HYDROSS       = 22035,

    EVENT_SPELL_MARK_OF_CORRUPTION1 = 1,
    EVENT_SPELL_MARK_OF_CORRUPTION2 = 2,
    EVENT_SPELL_MARK_OF_CORRUPTION3 = 3,
    EVENT_SPELL_MARK_OF_CORRUPTION4 = 4,
    EVENT_SPELL_MARK_OF_CORRUPTION5 = 5,
    EVENT_SPELL_MARK_OF_CORRUPTION6 = 6,
    EVENT_SPELL_MARK_OF_HYDROSS1    = 7,
    EVENT_SPELL_MARK_OF_HYDROSS2    = 8,
    EVENT_SPELL_MARK_OF_HYDROSS3    = 9,
    EVENT_SPELL_MARK_OF_HYDROSS4    = 10,
    EVENT_SPELL_MARK_OF_HYDROSS5    = 11,
    EVENT_SPELL_MARK_OF_HYDROSS6    = 12,
    EVENT_SPELL_WATER_TOMB          = 13,
    EVENT_SPELL_VILE_SLUDGE         = 14,
    EVENT_SPELL_ENRAGE              = 15,
    EVENT_CHECK_AURA                = 16,
    EVENT_KILL_TALK                 = 17
};

class boss_hydross_the_unstable : public CreatureScript
{
    public:
        boss_hydross_the_unstable() : CreatureScript("boss_hydross_the_unstable") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_hydross_the_unstableAI>(creature);
        }

        struct boss_hydross_the_unstableAI : public BossAI
        {
            boss_hydross_the_unstableAI(Creature* creature) : BossAI(creature, DATA_HYDROSS_THE_UNSTABLE)
            {
            }

            void Reset()
            {
                BossAI::Reset();
            }

            void JustReachedHome()
            {
                BossAI::JustReachedHome();
                if (!me->HasAura(SPELL_BLUE_BEAM))
                    me->RemoveAurasDueToSpell(SPELL_CLEANSING_FIELD_AURA);
            }

            void SetForm(bool corrupt, bool initial)
            {
                events.CancelEventGroup(GROUP_ABILITIES);
                DoResetThreat();
                
                if (corrupt)
                {
                    me->SetMeleeDamageSchool(SPELL_SCHOOL_NATURE);
                    me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FROST, false);
                    me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);
                    me->CastSpell(me, SPELL_CORRUPTION, true);
                    events.ScheduleEvent(EVENT_SPELL_MARK_OF_CORRUPTION1, 0, GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SPELL_MARK_OF_CORRUPTION2, 15000, GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SPELL_MARK_OF_CORRUPTION3, 30000, GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SPELL_MARK_OF_CORRUPTION4, 45000, GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SPELL_MARK_OF_CORRUPTION5, 60000, GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SPELL_MARK_OF_CORRUPTION6, 75000, GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SPELL_VILE_SLUDGE, 7000, GROUP_ABILITIES);
                }
                else
                {
                    me->SetMeleeDamageSchool(SPELL_SCHOOL_FROST);
                    me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FROST, true);
                    me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, false);
                    me->RemoveAurasDueToSpell(SPELL_CORRUPTION);
                    events.ScheduleEvent(EVENT_SPELL_MARK_OF_HYDROSS1, 0, GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SPELL_MARK_OF_HYDROSS2, 15000, GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SPELL_MARK_OF_HYDROSS3, 30000, GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SPELL_MARK_OF_HYDROSS4, 45000, GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SPELL_MARK_OF_HYDROSS5, 60000, GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SPELL_MARK_OF_HYDROSS6, 75000, GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SPELL_WATER_TOMB, 7000, GROUP_ABILITIES);
                }

                if (initial)
                    return;

                if (corrupt)
                {
                    Talk(SAY_SWITCH_TO_CORRUPT);
                    for (uint32 i = SPELL_SUMMON_CORRUPTED1; i <= SPELL_SUMMON_CORRUPTED4; ++i)
                        me->CastSpell(me, i, true);
                }
                else
                {
                    Talk(SAY_SWITCH_TO_CLEAN);
                    for (uint32 i = SPELL_SUMMON_PURIFIED1; i <= SPELL_SUMMON_PURIFIED4; ++i)
                        me->CastSpell(me, i, true);
                }
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                Talk(SAY_AGGRO);

                events.ScheduleEvent(EVENT_SPELL_ENRAGE, 600000);
                events.ScheduleEvent(EVENT_CHECK_AURA, 1000);
                SetForm(false, true);
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(me->HasAura(SPELL_CORRUPTION) ? SAY_CORRUPT_SLAY : SAY_CLEAN_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                summon->CastSpell(summon, SPELL_ELEMENTAL_SPAWNIN, true);
                summon->SetInCombatWithZone();

                if (summon->GetEntry() == NPC_PURE_SPAWN_OF_HYDROSS)
                    summon->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FROST, true);
                else
                    summon->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);
            }

            void SummonedCreatureDespawn(Creature* summon)
            {
                summons.Despawn(summon);
            }

            void JustDied(Unit* killer)
            {
                Talk(me->HasAura(SPELL_CORRUPTION) ? SAY_CORRUPT_DEATH : SAY_CLEAN_DEATH);
                BossAI::JustDied(killer);
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
                    case EVENT_CHECK_AURA:
                        if (me->HasAura(SPELL_BLUE_BEAM) == me->HasAura(SPELL_CORRUPTION))
                            SetForm(!me->HasAura(SPELL_BLUE_BEAM), false);
                        events.ScheduleEvent(EVENT_CHECK_AURA, 1000);
                        break;
                    case EVENT_SPELL_ENRAGE:
                        me->CastSpell(me, SPELL_ENRAGE, true);
                        break;
                    case EVENT_SPELL_MARK_OF_HYDROSS1:
                        me->CastSpell(me, SPELL_MARK_OF_HYDROSS1, false);
                        break;
                    case EVENT_SPELL_MARK_OF_HYDROSS2:
                        me->CastSpell(me, SPELL_MARK_OF_HYDROSS2, false);
                        break;
                    case EVENT_SPELL_MARK_OF_HYDROSS3:
                        me->CastSpell(me, SPELL_MARK_OF_HYDROSS3, false);
                        break;
                    case EVENT_SPELL_MARK_OF_HYDROSS4:
                        me->CastSpell(me, SPELL_MARK_OF_HYDROSS4, false);
                        break;
                    case EVENT_SPELL_MARK_OF_HYDROSS5:
                        me->CastSpell(me, SPELL_MARK_OF_HYDROSS5, false);
                        break;
                    case EVENT_SPELL_MARK_OF_HYDROSS6:
                        me->CastSpell(me, SPELL_MARK_OF_HYDROSS6, false);
                        events.ScheduleEvent(EVENT_SPELL_MARK_OF_HYDROSS6, 15000, GROUP_ABILITIES);
                        break;
                    case EVENT_SPELL_MARK_OF_CORRUPTION1:
                        me->CastSpell(me, SPELL_MARK_OF_CORRUPTION1, false);
                        break;
                    case EVENT_SPELL_MARK_OF_CORRUPTION2:
                        me->CastSpell(me, SPELL_MARK_OF_CORRUPTION2, false);
                        break;
                    case EVENT_SPELL_MARK_OF_CORRUPTION3:
                        me->CastSpell(me, SPELL_MARK_OF_CORRUPTION3, false);
                        break;
                    case EVENT_SPELL_MARK_OF_CORRUPTION4:
                        me->CastSpell(me, SPELL_MARK_OF_CORRUPTION4, false);
                        break;
                    case EVENT_SPELL_MARK_OF_CORRUPTION5:
                        me->CastSpell(me, SPELL_MARK_OF_CORRUPTION5, false);
                        break;
                    case EVENT_SPELL_MARK_OF_CORRUPTION6:
                        me->CastSpell(me, SPELL_MARK_OF_CORRUPTION6, false);
                        events.ScheduleEvent(EVENT_SPELL_MARK_OF_CORRUPTION6, 15000, GROUP_ABILITIES);
                        break;
                    case EVENT_SPELL_WATER_TOMB:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 60.0f, true))
                            me->CastSpell(target, SPELL_WATER_TOMB, false);
                        events.ScheduleEvent(EVENT_SPELL_WATER_TOMB, 7000, GROUP_ABILITIES);
                        break;
                    case EVENT_SPELL_VILE_SLUDGE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 60.0f, true))
                            me->CastSpell(target, SPELL_VILE_SLUDGE, false);
                        events.ScheduleEvent(EVENT_SPELL_VILE_SLUDGE, 15000, GROUP_ABILITIES);
                        break;

                }

                DoMeleeAttackIfReady();
            }
        };
};

class spell_hydross_cleansing_field_aura : public SpellScriptLoader
{
    public:
        spell_hydross_cleansing_field_aura() : SpellScriptLoader("spell_hydross_cleansing_field_aura") { }

        class spell_hydross_cleansing_field_aura_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hydross_cleansing_field_aura_AuraScript)

            void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTarget()->GetEntry() == NPC_HYDROSS_THE_UNSTABLE)
                    if (Unit* caster = GetCaster())
                        caster->CastSpell(caster, SPELL_CLEANSING_FIELD, true);
            }

            void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTarget()->GetEntry() == NPC_HYDROSS_THE_UNSTABLE)
                    if (Unit* caster = GetCaster())
                        caster->CastSpell(caster, SPELL_CLEANSING_FIELD, true);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_hydross_cleansing_field_aura_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_hydross_cleansing_field_aura_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hydross_cleansing_field_aura_AuraScript();
        }
};

class spell_hydross_cleansing_field_command : public SpellScriptLoader
{
    public:
        spell_hydross_cleansing_field_command() : SpellScriptLoader("spell_hydross_cleansing_field_command") { }

        class spell_hydross_cleansing_field_command_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hydross_cleansing_field_command_AuraScript)

            void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTarget()->HasUnitState(UNIT_STATE_CASTING))
                    GetTarget()->InterruptNonMeleeSpells(false);
                else
                    GetTarget()->CastSpell(GetTarget(), SPELL_BLUE_BEAM, true);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectApplyFn(spell_hydross_cleansing_field_command_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hydross_cleansing_field_command_AuraScript();
        }
};

class spell_hydross_mark_of_hydross : public SpellScriptLoader
{
    public:
        spell_hydross_mark_of_hydross() : SpellScriptLoader("spell_hydross_mark_of_hydross") { }

        class spell_hydross_mark_of_hydross_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hydross_mark_of_hydross_AuraScript)

            void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetTarget()->RemoveAurasByType(SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, GetCasterGUID(), GetAura());
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_hydross_mark_of_hydross_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hydross_mark_of_hydross_AuraScript();
        }
};

void AddSC_boss_hydross_the_unstable()
{
    new boss_hydross_the_unstable();
    new spell_hydross_cleansing_field_aura();
    new spell_hydross_cleansing_field_command();
    new spell_hydross_mark_of_hydross();
}
