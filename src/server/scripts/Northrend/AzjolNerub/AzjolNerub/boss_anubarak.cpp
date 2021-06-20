/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "azjol_nerub.h"

enum Spells
{
    SPELL_CARRION_BEETLES               = 53520,
    SPELL_SUMMON_CARRION_BEETLES        = 53521,
    SPELL_LEECHING_SWARM                = 53467,
    SPELL_POUND                         = 53472,
    SPELL_POUND_DAMAGE                  = 53509,
    SPELL_IMPALE_PERIODIC               = 53456,
    SPELL_EMERGE                        = 53500,
    SPELL_SUBMERGE                      = 53421,
    SPELL_SELF_ROOT                     = 42716,

    SPELL_SUMMON_DARTER                 = 53599,
    SPELL_SUMMON_ASSASSIN               = 53610,
    SPELL_SUMMON_GUARDIAN               = 53614,
    SPELL_SUMMON_VENOMANCER             = 53615,
};

enum Yells
{
    SAY_AGGRO                           = 0,
    SAY_SLAY                            = 1,
    SAY_DEATH                           = 2,
    SAY_LOCUST                          = 3,
    SAY_SUBMERGE                        = 4,
    SAY_INTRO                           = 5
};

enum Misc
{
    ACHIEV_TIMED_START_EVENT            = 20381,

    EVENT_CHECK_HEALTH_25               = 1,
    EVENT_CHECK_HEALTH_50               = 2,
    EVENT_CHECK_HEALTH_75               = 3,
    EVENT_CARRION_BEETELS               = 4,
    EVENT_LEECHING_SWARM                = 5,
    EVENT_IMPALE                        = 6,
    EVENT_POUND                         = 7,
    EVENT_CLOSE_DOORS                   = 8,
    EVENT_EMERGE                        = 9,
    EVENT_SUMMON_VENOMANCER             = 10,
    EVENT_SUMMON_DARTER                 = 11,
    EVENT_SUMMON_GUARDIAN               = 12,
    EVENT_SUMMON_ASSASSINS              = 13,
    EVENT_ENABLE_ROTATE                 = 14,
    EVENT_KILL_TALK                     = 15
};

class boss_anub_arak : public CreatureScript
{
    public:
        boss_anub_arak() : CreatureScript("boss_anub_arak") { }

        struct boss_anub_arakAI : public BossAI
        {
            boss_anub_arakAI(Creature* creature) : BossAI(creature, DATA_ANUBARAK_EVENT)
            {
                me->m_SightDistance = 120.0f;
                intro = false;
            }

            bool intro;

            void EnterEvadeMode()
            {
                me->DisableRotate(false);
                BossAI::EnterEvadeMode();
            }

            void MoveInLineOfSight(Unit* who)
            {
                if (!intro && who->GetTypeId() == TYPEID_PLAYER)
                {
                    intro = true;
                    Talk(SAY_INTRO);
                }
                BossAI::MoveInLineOfSight(who);
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
                    Talk(SAY_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (!summon->IsTrigger())
                    summon->SetInCombatWithZone();
            }

            void Reset()
            {
                BossAI::Reset();
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
            }

            void EnterCombat(Unit* )
            {
                Talk(SAY_AGGRO);
                instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);

                events.ScheduleEvent(EVENT_CARRION_BEETELS, 6500);
                events.ScheduleEvent(EVENT_LEECHING_SWARM, 20000);
                events.ScheduleEvent(EVENT_POUND, 15000);
                events.ScheduleEvent(EVENT_CHECK_HEALTH_75, 1000);
                events.ScheduleEvent(EVENT_CHECK_HEALTH_50, 1000);
                events.ScheduleEvent(EVENT_CHECK_HEALTH_25, 1000);
                events.ScheduleEvent(EVENT_CLOSE_DOORS, 5000);
            }

            void SummonHelpers(float x, float y, float z, uint32 spellId)
            {
                const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(spellId);
                me->SummonCreature(spellInfo->Effects[EFFECT_0].MiscValue, x, y, z);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (uint32 eventId = events.ExecuteEvent())
                {
                    case EVENT_CLOSE_DOORS:
                        _EnterCombat();
                        break;
                    case EVENT_CARRION_BEETELS:
                        me->CastSpell(me, SPELL_CARRION_BEETLES, false);
                        events.ScheduleEvent(EVENT_CARRION_BEETELS, 25000);
                        break;
                    case EVENT_LEECHING_SWARM:
                        Talk(SAY_LOCUST);
                        me->CastSpell(me, SPELL_LEECHING_SWARM, false);
                        events.ScheduleEvent(EVENT_LEECHING_SWARM, 20000);
                        break;
                    case EVENT_POUND:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 10.0f))
                        {                   
                            me->CastSpell(me, SPELL_SELF_ROOT, true);
                            me->DisableRotate(true);
                            me->SendMovementFlagUpdate();
                            events.ScheduleEvent(EVENT_ENABLE_ROTATE, 3300);
                            me->CastSpell(target, SPELL_POUND, false);
                        }
                        events.ScheduleEvent(EVENT_POUND, 18000);
                        break;
                    case EVENT_ENABLE_ROTATE:
                        me->RemoveAurasDueToSpell(SPELL_SELF_ROOT);
                        me->DisableRotate(false);
                        break;
                    case EVENT_CHECK_HEALTH_25:
                    case EVENT_CHECK_HEALTH_50:
                    case EVENT_CHECK_HEALTH_75:
                        if (me->HealthBelowPct(eventId*25))
                        {
                            Talk(SAY_SUBMERGE);
                            me->CastSpell(me, SPELL_IMPALE_PERIODIC, true);
                            me->CastSpell(me, SPELL_SUBMERGE, false);
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);

                            events.DelayEvents(46000, 0);
                            events.ScheduleEvent(EVENT_EMERGE, 45000);
                            events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 2000);
                            events.ScheduleEvent(EVENT_SUMMON_GUARDIAN, 4000);
                            events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 15000);
                            events.ScheduleEvent(EVENT_SUMMON_VENOMANCER, 20000);
                            events.ScheduleEvent(EVENT_SUMMON_DARTER, 30000);
                            events.ScheduleEvent(EVENT_SUMMON_ASSASSINS, 35000);
                            break;
                        }
                        events.ScheduleEvent(eventId, 500);
                        break;
                    case EVENT_EMERGE:
                        me->CastSpell(me, SPELL_EMERGE, true);
                        me->RemoveAura(SPELL_SUBMERGE);
                        me->RemoveAura(SPELL_IMPALE_PERIODIC);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                        break;
                    case EVENT_SUMMON_ASSASSINS:
                        SummonHelpers(509.32f, 247.42f, 239.48f, SPELL_SUMMON_ASSASSIN);
                        SummonHelpers(589.51f, 240.19f, 236.0f, SPELL_SUMMON_ASSASSIN);
                        break;
                    case EVENT_SUMMON_DARTER:
                        SummonHelpers(509.32f, 247.42f, 239.48f, SPELL_SUMMON_DARTER);
                        SummonHelpers(589.51f, 240.19f, 236.0f, SPELL_SUMMON_DARTER);
                        break;
                    case EVENT_SUMMON_GUARDIAN:
                        SummonHelpers(550.34f, 316.00f, 234.30f, SPELL_SUMMON_GUARDIAN);
                        break;
                    case EVENT_SUMMON_VENOMANCER:
                        SummonHelpers(550.34f, 316.00f, 234.30f, SPELL_SUMMON_VENOMANCER);
                        break;
                }

                if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                    DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_anub_arakAI(creature);
        }
};

class spell_azjol_nerub_carrion_beetels : public SpellScriptLoader
{
    public:
        spell_azjol_nerub_carrion_beetels() : SpellScriptLoader("spell_azjol_nerub_carrion_beetels") { }

        class spell_azjol_nerub_carrion_beetelsAuraScript : public AuraScript
        {
            PrepareAuraScript(spell_azjol_nerub_carrion_beetelsAuraScript)

            void HandleEffectPeriodic(AuraEffect const*  /*aurEff*/)
            {
                // Xinef: 2 each second
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_CARRION_BEETLES, true);
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SUMMON_CARRION_BEETLES, true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_azjol_nerub_carrion_beetelsAuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript *GetAuraScript() const
        {
            return new spell_azjol_nerub_carrion_beetelsAuraScript();
        }
};

class spell_azjol_nerub_pound : public SpellScriptLoader
{
    public:
        spell_azjol_nerub_pound() : SpellScriptLoader("spell_azjol_nerub_pound") { }

        class spell_azjol_nerub_pound_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_azjol_nerub_pound_SpellScript);

            void HandleApplyAura(SpellEffIndex  /*effIndex*/)
            {
                if (Unit* unitTarget = GetHitUnit())
                    GetCaster()->CastSpell(unitTarget, SPELL_POUND_DAMAGE, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_azjol_nerub_pound_SpellScript::HandleApplyAura, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_azjol_nerub_pound_SpellScript();
        }
};

class spell_azjol_nerub_impale_summon : public SpellScriptLoader
{
    public:
        spell_azjol_nerub_impale_summon() : SpellScriptLoader("spell_azjol_nerub_impale_summon") { }

        class spell_azjol_nerub_impale_summon_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_azjol_nerub_impale_summon_SpellScript);

            void SetDest(SpellDestination& dest)
            {
                // Adjust effect summon position
                float floorZ = GetCaster()->GetMap()->GetHeight(GetCaster()->GetPositionX(), GetCaster()->GetPositionY(), GetCaster()->GetPositionZ(), true);
                if (floorZ > INVALID_HEIGHT)
                    dest._position.m_positionZ = floorZ;
            }

            void Register()
            {
                OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_azjol_nerub_impale_summon_SpellScript::SetDest, EFFECT_0, TARGET_DEST_CASTER);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_azjol_nerub_impale_summon_SpellScript();
        }
};

void AddSC_boss_anub_arak()
{
    new boss_anub_arak();
    new spell_azjol_nerub_carrion_beetels();
    new spell_azjol_nerub_pound();
    new spell_azjol_nerub_impale_summon();
}
