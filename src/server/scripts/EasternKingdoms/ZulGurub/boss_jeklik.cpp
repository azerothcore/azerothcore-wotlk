/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "GameObjectAI.h"
#include "MoveSplineInit.h"
#include "ScriptedCreature.h"
#include "SmartAI.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "zulgurub.h"

enum Says
{
    // Jeklik
    SAY_AGGRO                           = 0,
    SAY_CALL_RIDERS                     = 1,
    SAY_DEATH                           = 2,
    EMOTE_SUMMON_BATS                   = 3,
    EMOTE_GREAT_HEAL                    = 4,

    // Bat Rider
    EMOTE_BATRIDER_LOW_HEALTH            = 0
};

enum Spells
{
    // Intro
    SPELL_GREEN_CHANNELING              = 13540,
    SPELL_BAT_FORM                      = 23966,

    // Phase one
    SPELL_PIERCE_ARMOR                  = 12097,
    SPELL_BLOOD_LEECH                   = 22644,
    SPELL_CHARGE                        = 22911,
    SPELL_SONIC_BURST                   = 23918,
    SPELL_SWOOP                         = 23919,

    // Phase two
    SPELL_CURSE_OF_BLOOD                = 16098,
    SPELL_PSYCHIC_SCREAM                = 22884,
    SPELL_SHADOW_WORD_PAIN              = 23952,
    SPELL_MIND_FLAY                     = 23953,
    SPELL_GREATER_HEAL                  = 23954,

    // Bat Rider (Boss)
    SPELL_BATRIDER_THROW_LIQUID_FIRE    = 23970,
    SPELL_BATRIDER_SUMMON_LIQUID_FIRE   = 23971,

    // Bat Rider (Trash)
    SPELL_BATRIDER_DEMO_SHOUT           = 23511,
    SPELL_BATRIDER_BATTLE_COMMAND       = 5115,
    SPELL_BATRIDER_INFECTED_BITE        = 16128,
    SPELL_BATRIDER_PASSIVE_THRASH       = 8876,
    SPELL_BATRIDER_UNSTABLE_CONCOCTION  = 24024
};

enum BatIds
{
    NPC_BLOODSEEKER_BAT                 = 11368,
    NPC_BATRIDER                        = 14750
};

enum Phase
{
    PHASE_ONE                           = 1,
    PHASE_TWO                           = 2
};

Position const SpawnBat[6] =
{
    { -12291.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12289.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12293.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12291.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12289.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12293.6220f, -1380.2640f, 144.8304f, 5.483f }
};

Position const SpawnBatRider = { -12301.689, -1371.2921, 145.09244 };
Position const JeklikCaveHomePosition = { -12291.9f, -1380.08f, 144.902f, 2.28638f };

enum PathID
{
    PATH_JEKLIK_INTRO                   = 145170,
    PATH_BATRIDER_LOOP                  = 147500
};

enum BatRiderMode
{
    BATRIDER_MODE_TRASH                 = 1,
    BATRIDER_MODE_BOSS
};

// High Priestess Jeklik (14517)
struct boss_jeklik : public BossAI
{
    // Bat Riders (14750) counter
    uint8 batRidersCount = 0;

    boss_jeklik(Creature* creature) : BossAI(creature, DATA_JEKLIK) { }

    void Reset() override
    {
        BossAI::Reset();

        me->SetHomePosition(JeklikCaveHomePosition);

        me->SetDisableGravity(false);
        me->SetReactState(REACT_PASSIVE);
        BossAI::me->SetCombatMovement(false);
        batRidersCount = 0;

        DoCastSelf(SPELL_GREEN_CHANNELING, true);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        Talk(SAY_AGGRO);
        DoZoneInCombat();

        me->RemoveAurasDueToSpell(SPELL_GREEN_CHANNELING);
        me->SetDisableGravity(true);
        DoCastSelf(SPELL_BAT_FORM, true);

        me->GetMotionMaster()->MovePath(PATH_JEKLIK_INTRO, false);
    }

    void PathEndReached(uint32 pathId) override
    {
        BossAI::PathEndReached(pathId);

        me->SetDisableGravity(false);
        me->SetCombatMovement(true);
        me->SetReactState(REACT_AGGRESSIVE);

        //
        // Phase 1
        //
        scheduler.Schedule(10s, 20s, PHASE_ONE, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, -8.0f, false, false))
            {
                DoCast(target, SPELL_CHARGE);
                AttackStart(target);
            }
            context.Repeat(15s, 30s);
        }).Schedule(5s, 15s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastVictim(SPELL_PIERCE_ARMOR);
            context.Repeat(20s, 30s);
        }).Schedule(5s, 15s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastVictim(SPELL_BLOOD_LEECH);
            context.Repeat(10s, 20s);
        }).Schedule(5s, 15s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SONIC_BURST);
            context.Repeat(20s, 30s);
        }).Schedule(20s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SWOOP);
            context.Repeat(20s, 30s);
        }).Schedule(30s, PHASE_ONE, [this](TaskContext context)
        {
            Talk(EMOTE_SUMMON_BATS);
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
            {
                for (uint8 i = 0; i < 6; ++i)
                {
                    if (Creature* bat = me->SummonCreature(NPC_BLOODSEEKER_BAT, SpawnBat[i], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                    {
                        bat->AI()->AttackStart(target);
                    }
                }
            }
            context.Repeat(30s);
        });

        //
        // Phase 2 (@ 50% health)
        //
        ScheduleHealthCheckEvent(50, [&]
        {
            me->RemoveAurasDueToSpell(SPELL_BAT_FORM);
            DoResetThreatList();

            scheduler.CancelGroup(PHASE_ONE);

            scheduler.Schedule(5s, 15s, PHASE_TWO, [this](TaskContext context)
            {
                DoCastSelf(SPELL_CURSE_OF_BLOOD);
                context.Repeat(25s, 30s);
            }).Schedule(25s, 35s, PHASE_TWO, [this](TaskContext context)
            {
                DoCastVictim(SPELL_PSYCHIC_SCREAM);
                context.Repeat(35s, 45s);
            }).Schedule(10s, 15s, PHASE_TWO, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_SHADOW_WORD_PAIN, 0, true);
                context.Repeat(12s, 18s);
            }).Schedule(10s, 30s, PHASE_TWO, [this](TaskContext context)
            {
                DoCastVictim(SPELL_MIND_FLAY);
                context.Repeat(20s, 40s);
            }).Schedule(25s, PHASE_TWO, [this](TaskContext context)
            {
                Talk(EMOTE_GREAT_HEAL);
                me->InterruptNonMeleeSpells(false);
                DoCastSelf(SPELL_GREATER_HEAL);
                context.Repeat(25s);
            }).Schedule(10s, PHASE_TWO, [this](TaskContext context)
            {
                if (me->GetThreatMgr().GetThreatListSize())
                {
                    // summon up to 2 bat riders
                    if (batRidersCount < 2)
                    {
                        Talk(SAY_CALL_RIDERS);
                        // only if the bat rider was successfully created
                        if (me->SummonCreature(NPC_BATRIDER, SpawnBatRider, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT))
                        {
                            batRidersCount++;
                        }
                        if (batRidersCount == 1)
                        {
                            context.Repeat(10s, 15s);
                        }
                    }
                }
            });
        });
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (why != EvadeReason::EVADE_REASON_NO_PATH)
        {
            me->DespawnOnEvade(5s);
        }

        BossAI::EnterEvadeMode(why);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }
};

// Gurubashi Bat Rider (14750) - trash and boss summon are same creature ID
struct npc_batrider : public CreatureAI
{
    BatRiderMode _mode;     // the version of this creature (trash or boss)
    TaskScheduler _scheduler;

    npc_batrider(Creature* creature) : CreatureAI(creature)
    {
        // if this is a summon of Jeklik, it is in boss mode
        if
        (
            me->GetEntry() == NPC_BATRIDER &&
            me->IsSummon() &&
            me->ToTempSummon() &&
            me->ToTempSummon()->GetSummoner() &&
            me->ToTempSummon()->GetSummoner()->GetEntry() == NPC_PRIESTESS_JEKLIK
        )
        {
            _mode = BATRIDER_MODE_BOSS;

            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);
            me->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);

            me->SetReactState(REACT_PASSIVE);

            me->SetSpeed(MOVE_WALK, 5.0f, true);

            me->SetCanFly(true);
            me->GetMotionMaster()->MoveSplinePath(PATH_BATRIDER_LOOP);
        }
        else
        {
            _mode = BATRIDER_MODE_TRASH;

            me->SetReactState(REACT_DEFENSIVE);

            // don't interrupt casting
            _scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
        }
    }

    void Reset() override
    {
        CreatureAI::Reset();

        _scheduler.CancelAll();

        if (_mode == BATRIDER_MODE_BOSS)
        {
            me->GetMotionMaster()->Clear();
        }
        else if (_mode == BATRIDER_MODE_TRASH)
        {
            me->CastSpell(me, SPELL_BATRIDER_PASSIVE_THRASH);
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        CreatureAI::JustEngagedWith(who);

        if (_mode == BATRIDER_MODE_BOSS)
        {
            _scheduler.Schedule(2s, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_BATRIDER_THROW_LIQUID_FIRE);
                context.Repeat(8s);
            });
        }
        else if (_mode == BATRIDER_MODE_TRASH)
        {
            _scheduler.Schedule(1s, [this](TaskContext /*context*/)
            {
                DoCastSelf(SPELL_BATRIDER_DEMO_SHOUT);
            }).Schedule(8s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_BATRIDER_BATTLE_COMMAND);
                context.Repeat(25s);
            }).Schedule(6500ms, [this](TaskContext context)
            {
                DoCastVictim(SPELL_BATRIDER_INFECTED_BITE);
                context.Repeat(8s);
            });
        }
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (_mode == BATRIDER_MODE_TRASH)
        {
            if (me->HealthBelowPctDamaged(30, damage))
            {
                _scheduler.CancelAll();
                DoCastSelf(SPELL_BATRIDER_UNSTABLE_CONCOCTION);
            }
        }
    }

    void UpdateAI(uint32 /*diff*/) override
    {
        if (_mode == BATRIDER_MODE_BOSS)
        {
            if (!me->isMoving())
            {
                me->SetCanFly(true);
                me->GetMotionMaster()->MoveSplinePath(PATH_BATRIDER_LOOP);
            }
        }
        else if (_mode == BATRIDER_MODE_TRASH)
        {
            if (!UpdateVictim())
            {
                return;
            }

            DoMeleeAttackIfReady();
        }

        _scheduler.Update();
    }
};

class spell_batrider_bomb : public SpellScript
{
    PrepareSpellScript(spell_batrider_bomb);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BATRIDER_SUMMON_LIQUID_FIRE });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Unit* target = GetHitUnit())
        {
            target->CastSpell(target, SPELL_BATRIDER_SUMMON_LIQUID_FIRE, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_batrider_bomb::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_jeklik()
{
    RegisterCreatureAI(boss_jeklik);
    RegisterCreatureAI(npc_batrider);
    RegisterSpellScript(spell_batrider_bomb);
}

