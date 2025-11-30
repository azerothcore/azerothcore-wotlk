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
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "shattered_halls.h"

enum Spells
{
    SPELL_BLAST_WAVE            = 30600,
    SPELL_FEAR                  = 30584,
    SPELL_THUNDERCLAP           = 30633,
    SPELL_BEATDOWN              = 30618,
    SPELL_BURNING_MAUL          = 30598
};

enum Equip
{
    EQUIP_STANDARD              = 1,
    EQUIP_BURNING_MAUL          = 2
};

enum HeadYells
{
    SAY_ON_AGGRO                = 0,
    SAY_ON_AGGRO_2,
    SAY_ON_AGGRO_3,
    SAY_ON_BEATDOWN,
    SAY_ON_BEATDOWN_2,
    SAY_ON_BEATDOWN_3,
    SAY_ON_KILL,
    SAY_ON_KILL_2,
    SAY_ON_DEATH
};

enum Misc
{
    EMOTE_BURNING_MAUL          = 0,
    DATA_BURNING_MAUL_END       = 1
};

enum Phase
{
    GROUP_NON_BURNING_PHASE     = 0,
    GROUP_BURNING_PHASE         = 1,
    GROUP_FULL_PHASE            = 2
};

struct boss_warbringer_omrogg : public BossAI
{
    boss_warbringer_omrogg(Creature* creature) : BossAI(creature, DATA_OMROGG)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void HandleHeadTalk(HeadYells yell)
    {
        switch (yell)
        {
            case SAY_ON_AGGRO:
            {
                uint8 group = urand(SAY_ON_AGGRO, SAY_ON_AGGRO_3);
                if (Creature* leftHead = instance->GetCreature(DATA_OMROGG_LEFT_HEAD))
                {
                    leftHead->AI()->Talk(group);
                    _headTalk.Schedule(3600ms, [this, group](TaskContext /*context*/)
                        {
                            if (Creature* rightHead = instance->GetCreature(DATA_OMROGG_RIGHT_HEAD))
                            rightHead->AI()->Talk(group);
                        });
                }
                break;
            }
            case SAY_ON_BEATDOWN:
            {
                if (Creature* leftHead = instance->GetCreature(DATA_OMROGG_LEFT_HEAD))
                {
                    leftHead->AI()->Talk(SAY_ON_BEATDOWN);
                    _headTalk.Schedule(3600ms, [this](TaskContext context)
                        {
                            if (Creature* rightHead = instance->GetCreature(DATA_OMROGG_RIGHT_HEAD))
                                rightHead->AI()->Talk(SAY_ON_BEATDOWN);
                            context.Schedule(3600ms, [this](TaskContext context)
                            {
                                uint8 group = urand(SAY_ON_BEATDOWN_2, SAY_ON_BEATDOWN_3);
                                if (Creature* leftHead = instance->GetCreature(DATA_OMROGG_LEFT_HEAD))
                                    leftHead->AI()->Talk(group);
                                context.Schedule(3600ms, [this, group](TaskContext /*context*/)
                                {
                                    if (Creature* rightHead = instance->GetCreature(DATA_OMROGG_RIGHT_HEAD))
                                        rightHead->AI()->Talk(group);
                                });
                            });
                        });
                }
                break;
            }
            case SAY_ON_KILL:
            {
                uint8 group = urand(SAY_ON_KILL, SAY_ON_KILL_2);
                if (Creature* leftHead = instance->GetCreature(DATA_OMROGG_LEFT_HEAD))
                    leftHead->AI()->Talk(group);
                _headTalk.Schedule(3600ms, [this, group](TaskContext /*context*/)
                    {
                        if (Creature* rightHead = instance->GetCreature(DATA_OMROGG_RIGHT_HEAD))
                            rightHead->AI()->Talk(group);
                    });
                break;
            }
            case SAY_ON_DEATH:
            {
                if (Creature* leftHead = instance->GetCreature(DATA_OMROGG_LEFT_HEAD))
                    leftHead->AI()->Talk(SAY_ON_DEATH);
                _headTalk.Schedule(3600ms, [this](TaskContext /*context*/)
                    {
                        if (Creature* rightHead = instance->GetCreature(DATA_OMROGG_RIGHT_HEAD))
                            rightHead->AI()->Talk(SAY_ON_DEATH);
                    });
                break;
            }
            default:
                break;
        }
    }

    void SetData(uint32 data, uint32) override
    {
        if (data != DATA_BURNING_MAUL_END)
            return;

        scheduler.CancelGroup(GROUP_BURNING_PHASE);
        ScheduleNonBurningPhase();
        ScheduleBurningPhase();
    }

    void ScheduleNonBurningPhase()
    {
        scheduler.
            Schedule(12100ms, 17300ms, GROUP_NON_BURNING_PHASE, [this](TaskContext context)
                {
                    DoCastAOE(SPELL_THUNDERCLAP);
                    context.Repeat(17200ms, 24200ms);
                })
            .Schedule(20s, 30s, GROUP_NON_BURNING_PHASE, [this](TaskContext context)
                {
                    DoCastSelf(SPELL_BEATDOWN);
                    me->AttackStop();
                    me->SetReactState(REACT_PASSIVE);
                    context.Schedule(200ms, GROUP_NON_BURNING_PHASE, [this](TaskContext context)
                    {
                        DoResetThreatList();
                        if (Unit* newTarget = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, false, false))
                            me->AddThreat(newTarget, 2250.f);
                        HandleHeadTalk(SAY_ON_BEATDOWN);
                        context.Schedule(1200ms, GROUP_NON_BURNING_PHASE, [this](TaskContext /*context*/)
                        {
                            me->SetReactState(REACT_AGGRESSIVE);
                        });
                    });
                    context.Repeat();
                });
    }

    void ScheduleBurningPhase()
    {
        scheduler.
            Schedule(45s, 60s, GROUP_BURNING_PHASE, [this](TaskContext context)
            {
                me->AttackStop();
                me->SetReactState(REACT_PASSIVE);
                context.CancelGroup(GROUP_NON_BURNING_PHASE);
                context.Schedule(1200ms, [this](TaskContext context)
                    {
                        DoCastAOE(SPELL_FEAR);
                        DoCast(SPELL_BURNING_MAUL);
                        context.Schedule(200ms, [this](TaskContext context)
                            {
                                Talk(EMOTE_BURNING_MAUL);
                                context.Schedule(2200ms, [this](TaskContext context)
                                    {
                                        DoResetThreatList();
                                        if (Unit* newTarget = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, false, false))
                                            me->AddThreat(newTarget, 2250.f);
                                        me->SetReactState(REACT_AGGRESSIVE);
                                        context.Schedule(4850ms, 8500ms, GROUP_BURNING_PHASE, [this](TaskContext context)
                                            {
                                                DoCastAOE(SPELL_BLAST_WAVE);
                                                context.Repeat();
                                            });
                                    });
                            });
                    });

            });
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        _headTalk.CancelAll();
        HandleHeadTalk(SAY_ON_AGGRO);

        ScheduleNonBurningPhase();
        ScheduleBurningPhase();
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim && victim->IsPlayer())
            HandleHeadTalk(SAY_ON_KILL);
    }

    void JustDied(Unit* killer) override
    {
        HandleHeadTalk(SAY_ON_DEATH);
        BossAI::JustDied(killer);
    }

    void UpdateAI(uint32 diff) override
    {
        _headTalk.Update(diff);

        if (!UpdateVictim())
            return;

        scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
    }

    protected:
        TaskScheduler _headTalk;
};

class spell_burning_maul : public AuraScript
{
    PrepareAuraScript(spell_burning_maul);

    void HandleOnRemove(AuraEffect const* /* aurEff */, AuraEffectHandleModes /* mode */)
    {
        if (Unit* caster = GetCaster())
        {
            if (Creature* omrogg = caster->ToCreature())
            {
                omrogg->LoadEquipment(EQUIP_STANDARD);
                omrogg->AI()->SetData(DATA_BURNING_MAUL_END, 0);
            }
        }
    }

    void HandleOnApply(AuraEffect const* /* aurEff */, AuraEffectHandleModes /* mode */)
    {
        if (Unit* caster = GetCaster())
            if (Creature* omrogg = caster->ToCreature())
                omrogg->LoadEquipment(EQUIP_BURNING_MAUL);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_burning_maul::HandleOnRemove, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        OnEffectApply += AuraEffectApplyFn(spell_burning_maul::HandleOnApply, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_warbringer_omrogg()
{
    RegisterShatteredHallsCreatureAI(boss_warbringer_omrogg);
    RegisterSpellScript(spell_burning_maul);
}
