/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_eye.h"

enum Yells
{
    SAY_AGGRO                           = 0,
    SAY_SUMMON1                         = 1,
    SAY_SUMMON2                         = 2,
    SAY_KILL                            = 3,
    SAY_DEATH                           = 4,
    SAY_VOIDA                           = 5,
    SAY_VOIDB                           = 6
};

enum Spells
{
    SPELL_SOLARIAN_TRANSFORM            = 39117,
    SPELL_ARCANE_MISSILES               = 33031,
    SPELL_WRATH_OF_THE_ASTROMANCER      = 42783,
    SPELL_BLINDING_LIGHT                = 33009,
    SPELL_PSYCHIC_SCREAM                = 34322,
    SPELL_VOID_BOLT                     = 39329
};

enum Misc
{
    DISPLAYID_INVISIBLE                 = 11686,
    NPC_ASTROMANCER_SOLARIAN_SPOTLIGHT  = 18928,
    NPC_SOLARIUM_AGENT                  = 18925,
    NPC_SOLARIUM_PRIEST                 = 18806,

    EVENT_CHECK_HEALTH                  = 1,
    EVENT_SPELL_ARCANE_MISSILES         = 2,
    EVENT_SPELL_WRATH_OF_ASTROMANCER    = 3,
    EVENT_SPELL_BLINDING_LIGHT          = 4,
    EVENT_SPAWN_PORTALS                 = 5,
    EVENT_SUMMON_ADDS                   = 6,
    EVENT_REAPPEAR                      = 7,
    EVENT_SPELL_PSYCHIC_SCREAM          = 8,
    EVENT_SPELL_VOID_BOLT               = 9
};


#define INNER_PORTAL_RADIUS         14.0f
#define OUTER_PORTAL_RADIUS         28.0f
#define CENTER_X                    432.909f
#define CENTER_Y                    -373.424f
#define CENTER_Z                    17.9608f
#define CENTER_O                    1.06421f
#define PORTAL_Z                    17.005f


class boss_high_astromancer_solarian : public CreatureScript
{
    public:

        boss_high_astromancer_solarian() : CreatureScript("boss_high_astromancer_solarian") { }

        struct boss_high_astromancer_solarianAI : public BossAI
        {
            boss_high_astromancer_solarianAI(Creature* creature) : BossAI(creature, DATA_ASTROMANCER)
            {
            }

            void Reset()
            {
                BossAI::Reset();
                me->SetModelVisible(true);
            }

            void AttackStart(Unit* who)
            {
                if (who && me->Attack(who, true))
                    me->GetMotionMaster()->MoveChase(who, (events.GetNextEventTime(EVENT_SPELL_VOID_BOLT) == 0 ? 30.0f : 0.0f));
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER && roll_chance_i(50))
                    Talk(SAY_KILL);
            }

            void JustDied(Unit* killer)
            {
                me->SetModelVisible(true);
                Talk(SAY_DEATH);
                BossAI::JustDied(killer);
            }

            void EnterCombat(Unit* who)
            {
                Talk(SAY_AGGRO);
                BossAI::EnterCombat(who);
                me->CallForHelp(105.0f);

                events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                events.ScheduleEvent(EVENT_SPELL_ARCANE_MISSILES, 3000);
                events.ScheduleEvent(EVENT_SPELL_WRATH_OF_ASTROMANCER, 1000);
                events.ScheduleEvent(EVENT_SPELL_BLINDING_LIGHT, 40000);
                events.ScheduleEvent(EVENT_SPAWN_PORTALS, 50000);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (!summon->IsTrigger())
                    summon->SetInCombatWithZone();
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
                        if (me->HealthBelowPct(21))
                        {
                            events.Reset();
                            events.ScheduleEvent(EVENT_SPELL_VOID_BOLT, 3000);
                            events.ScheduleEvent(EVENT_SPELL_PSYCHIC_SCREAM, 7000);
                            me->CastSpell(me, SPELL_SOLARIAN_TRANSFORM, true);
                            me->GetMotionMaster()->MoveChase(me->GetVictim());
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                        break;
                    case EVENT_SPELL_ARCANE_MISSILES:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f, true))
                            me->CastSpell(target, SPELL_ARCANE_MISSILES, false);
                        events.ScheduleEvent(EVENT_SPELL_ARCANE_MISSILES, 3000);
                        break;
                    case EVENT_SPELL_WRATH_OF_ASTROMANCER:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                            me->CastSpell(target, SPELL_WRATH_OF_THE_ASTROMANCER, false);
                        events.ScheduleEvent(EVENT_SPELL_WRATH_OF_ASTROMANCER, 22000);
                        break;
                    case EVENT_SPELL_BLINDING_LIGHT:
                        me->CastSpell(me, SPELL_BLINDING_LIGHT, false);
                        events.ScheduleEvent(EVENT_SPELL_BLINDING_LIGHT, 40000);
                        break;
                    case EVENT_SPAWN_PORTALS:
                        me->setAttackTimer(BASE_ATTACK, 21000);
                        me->SetModelVisible(false);
                        events.ScheduleEvent(EVENT_SPAWN_PORTALS, 50000);
                        events.DelayEvents(21000);
                        events.ScheduleEvent(EVENT_SUMMON_ADDS, 6000);
                        events.ScheduleEvent(EVENT_REAPPEAR, 20000);
                        for (uint8 i = 0; i < 3; ++i)
                        {
                            float o = rand_norm()*2*M_PI;
                            if (i == 0)
                                me->SummonCreature(NPC_ASTROMANCER_SOLARIAN_SPOTLIGHT, CENTER_X + cos(o)*INNER_PORTAL_RADIUS, CENTER_Y + sin(o)*INNER_PORTAL_RADIUS, CENTER_Z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 26000);
                            else
                                me->SummonCreature(NPC_ASTROMANCER_SOLARIAN_SPOTLIGHT, CENTER_X + cos(o)*OUTER_PORTAL_RADIUS, CENTER_Y + sin(o)*OUTER_PORTAL_RADIUS, PORTAL_Z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 26000);
                        }
                        break;
                    case EVENT_SUMMON_ADDS:
                        Talk(SAY_SUMMON1);
                        for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        {
                            if (Creature* light = ObjectAccessor::GetCreature(*me, *itr))
                                if (light->GetEntry() == NPC_ASTROMANCER_SOLARIAN_SPOTLIGHT)
                                {
                                    if (light->GetDistance2d(CENTER_X, CENTER_Y) < 20.0f)
                                    {
                                        me->SetPosition(*light);
                                        me->StopMovingOnCurrentPos();
                                    }
                                    for (uint8 j = 0; j < 4; ++j)
                                        me->SummonCreature(NPC_SOLARIUM_AGENT, light->GetPositionX()+frand(-3.0f, 3.0f), light->GetPositionY()+frand(-3.0f, 3.0f), light->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                                }
                        }
                        break;
                    case EVENT_REAPPEAR:
                        Talk(SAY_SUMMON2);
                        for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        {
                            if (Creature* light = ObjectAccessor::GetCreature(*me, *itr))
                            {
                                if (light->GetEntry() == NPC_ASTROMANCER_SOLARIAN_SPOTLIGHT)
                                {
                                    light->RemoveAllAuras();
                                    if (light->GetDistance2d(CENTER_X, CENTER_Y) < 20.0f)
                                        me->SetModelVisible(true);
                                    else
                                        me->SummonCreature(NPC_SOLARIUM_PRIEST, light->GetPositionX()+frand(-3.0f, 3.0f), light->GetPositionY()+frand(-3.0f, 3.0f), light->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                                }
                            }
                        }
                        // protection
                        if (me->GetDisplayId() != me->GetNativeDisplayId())
                        {
                            me->SetModelVisible(true);
                            me->SummonCreature(NPC_SOLARIUM_PRIEST, me->GetPositionX()+frand(-3.0f, 3.0f), me->GetPositionY()+frand(-3.0f, 3.0f), me->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                            me->SummonCreature(NPC_SOLARIUM_PRIEST, me->GetPositionX()+frand(-3.0f, 3.0f), me->GetPositionY()+frand(-3.0f, 3.0f), me->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                        }
                        break;
                    case EVENT_SPELL_VOID_BOLT:
                        me->CastSpell(me->GetVictim(), SPELL_VOID_BOLT, false);
                        events.ScheduleEvent(EVENT_SPELL_VOID_BOLT, 7000);
                        break;
                    case EVENT_SPELL_PSYCHIC_SCREAM:
                        me->CastSpell(me, SPELL_PSYCHIC_SCREAM, false);
                        events.ScheduleEvent(EVENT_SPELL_PSYCHIC_SCREAM, 12000);
                        break;

                }

                DoMeleeAttackIfReady();
                EnterEvadeIfOutOfCombatArea();
            }
                    
            bool CheckEvadeIfOutOfCombatArea() const
            {
                return me->GetDistance2d(432.59f, -371.93f) > 105.0f;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_high_astromancer_solarianAI>(creature);
        }
};

class spell_astromancer_wrath_of_the_astromancer : public SpellScriptLoader
{
    public:
        spell_astromancer_wrath_of_the_astromancer() : SpellScriptLoader("spell_astromancer_wrath_of_the_astromancer") { }

        class spell_astromancer_wrath_of_the_astromancer_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_astromancer_wrath_of_the_astromancer_AuraScript);

            void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
                    return;

                Unit* target = GetUnitOwner();
                target->CastSpell(target, GetSpellInfo()->Effects[EFFECT_1].CalcValue(), false);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_astromancer_wrath_of_the_astromancer_AuraScript::AfterRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_astromancer_wrath_of_the_astromancer_AuraScript();
        }
};

class spell_astromancer_solarian_transform : public SpellScriptLoader
{
    public:
        spell_astromancer_solarian_transform() : SpellScriptLoader("spell_astromancer_solarian_transform") { }

        class spell_astromancer_solarian_transform_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_astromancer_solarian_transform_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetUnitOwner()->HandleStatModifier(UnitMods(UNIT_MOD_ARMOR), TOTAL_PCT, 400.0f, true);
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetUnitOwner()->HandleStatModifier(UnitMods(UNIT_MOD_ARMOR), TOTAL_PCT, 400.0f, false);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_astromancer_solarian_transform_AuraScript::OnApply, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_astromancer_solarian_transform_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_astromancer_solarian_transform_AuraScript();
        }
};

void AddSC_boss_high_astromancer_solarian()
{
    new boss_high_astromancer_solarian();
    new spell_astromancer_wrath_of_the_astromancer();
    new spell_astromancer_solarian_transform();
}

