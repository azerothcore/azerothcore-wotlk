/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "the_eye.h"

enum Yells
{
    SAY_AGGRO                           = 0,
    SAY_SUMMON                          = 1,
    SAY_KILL                            = 2,
    SAY_DEATH                           = 3,
    SAY_VOID                            = 4
};

enum Spells
{
    SPELL_SOLARIAN_TRANSFORM            = 39117,
    SPELL_ARCANE_MISSILES               = 33031,
    SPELL_WRATH_OF_THE_ASTROMANCER      = 42783,
    SPELL_BLINDING_LIGHT                = 33009,
    SPELL_PSYCHIC_SCREAM                = 34322,
    SPELL_VOID_BOLT                     = 39329,
    SPELL_TRUE_BEAM                     = 33365,
    SPELL_TELEPORT_START_POSITION       = 33244,
};

enum Misc
{
    DISPLAYID_INVISIBLE                 = 11686,
    NPC_ASTROMANCER_SOLARIAN_SPOTLIGHT  = 18928,
    NPC_SOLARIUM_AGENT                  = 18925,
    NPC_SOLARIUM_PRIEST                 = 18806
};

#define INNER_PORTAL_RADIUS         14.0f
#define OUTER_PORTAL_RADIUS         28.0f
#define CENTER_X                    432.909f
#define CENTER_Y                    -373.424f
#define CENTER_Z                    17.9608f
#define CENTER_O                    1.06421f
#define PORTAL_Z                    17.005f
#define START_POSITION_X            432.74f
#define START_POSITION_Y            -373.645f
#define START_POSITION_Z            18.0138f

struct boss_high_astromancer_solarian : public BossAI
{
    boss_high_astromancer_solarian(Creature* creature) : BossAI(creature, DATA_ASTROMANCER)
    {
        callForHelpRange = 105.0f;
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        me->SetModelVisible(true);
        me->SetReactState(REACT_AGGRESSIVE);

        ScheduleHealthCheckEvent(20, [&]{
            Talk(SAY_VOID);
            me->InterruptNonMeleeSpells(false);
            scheduler.CancelAll();
            me->SetModelVisible(true);
            me->ResumeChasingVictim();
            scheduler.Schedule(3s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_VOID_BOLT);
                context.Repeat(7s);
            }).Schedule(7s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_PSYCHIC_SCREAM);
                context.Repeat(12s);
            });
            DoCastSelf(SPELL_SOLARIAN_TRANSFORM, true);
        });
    }

    void AttackStart(Unit* who) override
    {
        if (who && me->Attack(who, true))
        {
            me->GetMotionMaster()->MoveChase(who, 0.0f);
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer() && roll_chance_i(50))
        {
            Talk(SAY_KILL);
        }
    }

    void JustDied(Unit* killer) override
    {
        me->SetModelVisible(true);
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }

    void JustEngagedWith(Unit* who) override
    {
        Talk(SAY_AGGRO);
        BossAI::JustEngagedWith(who);
        me->GetMotionMaster()->Clear();

        scheduler.Schedule(3650ms, [this](TaskContext context)
        {
            me->GetMotionMaster()->Clear();
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, false, true, -SPELL_WRATH_OF_THE_ASTROMANCER))
            {
                DoCast(target, SPELL_ARCANE_MISSILES);
            }
            else
            {
                //no targets in required range
                me->GetMotionMaster()->MoveChase(me->GetVictim(), 30.0f);
                me->CastStop();
            }
            context.Repeat(800ms, 7300ms);
        }).Schedule(21800ms, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_WRATH_OF_THE_ASTROMANCER, 0, 100.0f);
            context.Repeat(21800ms, 23350ms);
        }).Schedule(33900ms, [this](TaskContext context)
        {
            DoCastSelf(SPELL_BLINDING_LIGHT);
            context.Repeat(33900ms, 48100ms);
        }).Schedule(52100ms, [this](TaskContext context)
        {
            me->SetReactState(REACT_PASSIVE);
            scheduler.DelayAll(22s);
            // blink to room center in this line using SPELL_TELEPORT_START_POSITION and START_POSITION_X, START_POSITION_Y, START_POSITION_Z
            scheduler.Schedule(1s, [this](TaskContext)
            {
                for (uint8 i = 0; i < 3; ++i)
                {
                    float o = rand_norm() * 2 * M_PI;
                    if (i == 0)
                    {
                        me->SummonCreature(NPC_ASTROMANCER_SOLARIAN_SPOTLIGHT, CENTER_X + cos(o)*INNER_PORTAL_RADIUS, CENTER_Y + std::sin(o)*INNER_PORTAL_RADIUS, CENTER_Z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 25000);
                    }
                    else
                    {
                        me->SummonCreature(NPC_ASTROMANCER_SOLARIAN_SPOTLIGHT, CENTER_X + cos(o)*OUTER_PORTAL_RADIUS, CENTER_Y + std::sin(o)*OUTER_PORTAL_RADIUS, PORTAL_Z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 25000);
                    }
                }
            }).Schedule(2s, [this](TaskContext)
            {
                Talk(SAY_SUMMON);
            }).Schedule(3s, [this](TaskContext)
            {
                me->RemoveAllAuras();
                me->SetModelVisible(false);
            }).Schedule(7s, [this](TaskContext)
            {
                summons.DoForAllSummons([&](WorldObject* summon)
                {
                    if (Creature* light = summon->ToCreature())
                    {
                        if (light->GetEntry() == NPC_ASTROMANCER_SOLARIAN_SPOTLIGHT)
                        {
                            if (light->GetDistance2d(CENTER_X, CENTER_Y) < 20.0f)
                            {
                                DoCast(light, SPELL_TRUE_BEAM);
                                me->SetPosition(*light);
                                me->StopMovingOnCurrentPos();
                            }
                            for (uint8 j = 0; j < 4; ++j)
                            {
                                me->SummonCreature(NPC_SOLARIUM_AGENT, light->GetPositionX() + frand(-3.0f, 3.0f), light->GetPositionY() + frand(-3.0f, 3.0f), light->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                            }
                        }
                    }
                });
            }).Schedule(23s, [this](TaskContext)
            {
                me->SetReactState(REACT_AGGRESSIVE);
                summons.DoForAllSummons([&](WorldObject* summon)
                {
                    if (Creature* light = summon->ToCreature())
                    {
                        if (light->GetEntry() == NPC_ASTROMANCER_SOLARIAN_SPOTLIGHT)
                        {
                            light->RemoveAllAuras();
                            if (light->GetDistance2d(CENTER_X, CENTER_Y) < 20.0f)
                            {
                                me->RemoveAllAuras();
                                me->SetModelVisible(true);
                            }
                            else
                            {
                                me->SummonCreature(NPC_SOLARIUM_PRIEST, light->GetPositionX() + frand(-3.0f, 3.0f), light->GetPositionY() + frand(-3.0f, 3.0f), light->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                            }
                        }
                    }
                });
            });
            context.Repeat(87500ms, 91200ms);
        });
    }

     void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (me->GetReactState() == REACT_AGGRESSIVE)
        {
            DoMeleeAttackIfReady();
        }
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (!summon->IsTrigger())
        {
            summon->SetInCombatWithZone();
        }
    }
};

class spell_astromancer_wrath_of_the_astromancer : public AuraScript
{
    PrepareAuraScript(spell_astromancer_wrath_of_the_astromancer);

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
            return;

        Unit* target = GetUnitOwner();
        target->CastSpell(target, GetSpellInfo()->Effects[EFFECT_1].CalcValue(), false, nullptr, nullptr, GetCaster () ? GetCaster()->GetGUID() : ObjectGuid::Empty);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_astromancer_wrath_of_the_astromancer::AfterRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_astromancer_solarian_transform : public AuraScript
{
    PrepareAuraScript(spell_astromancer_solarian_transform);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->ApplyStatPctModifier(UNIT_MOD_ARMOR, TOTAL_PCT, 400.0f);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->ApplyStatPctModifier(UnitMods(UNIT_MOD_ARMOR), TOTAL_PCT, -80.0f);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_astromancer_solarian_transform::OnApply, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_astromancer_solarian_transform::OnRemove, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_high_astromancer_solarian()
{
    RegisterTheEyeAI(boss_high_astromancer_solarian);
    RegisterSpellScript(spell_astromancer_wrath_of_the_astromancer);
    RegisterSpellScript(spell_astromancer_solarian_transform);
}
