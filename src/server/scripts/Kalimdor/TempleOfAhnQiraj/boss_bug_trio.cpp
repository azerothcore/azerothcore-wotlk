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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "temple_of_ahnqiraj.h"
#include "TaskScheduler.h"

enum Spells
{
    SPELL_BLOODY_DEATH   = 25770,
    SPELL_FULL_HEAL      = 17683,

    // Kri
    SPELL_CLEAVE         = 26350,
    SPELL_THRASH         = 3391,
    SPELL_TOXIC_VOLLEY   = 25812,
    SPELL_POISON_CLOUD   = 26590,

    // Vem
    SPELL_CHARGE         = 26561,
    SPELL_KNOCKBACK      = 18670,
    SPELL_KNOCKDOWN      = 19128,
    SPELL_VENGEANCE      = 25790,

    // Yauj
    SPELL_HEAL           = 25807,
    SPELL_FEAR           = 26580,
    SPELL_RAVAGE         = 3242,
    SPELL_DISPEL         = 25808,

    NPC_YAUJ_BROOD       = 15621
};

enum Misc
{
    ACTION_CONSUME       = 0,

    EMOTE_DEVOURED       = 0,

    POINT_CONSUME        = 0,

    VEM_WAYPOINT_PATH    = 876030
};

const Position resetPoint = { -8582.0f, 2047.0f, -1.62f }; // Taken from CMangos

struct boss_bug_trio : public BossAI
{
public:
    boss_bug_trio(Creature* creature) : BossAI(creature, DATA_BUG_TRIO) { Reset(); }

    bool CheckInRoom() override
    {
        if (me->GetExactDist2d(resetPoint) <= 10.f)
        {
            EnterEvadeMode(EVADE_REASON_BOUNDARY);
            return false;
        }

        return true;
    }

    void EnterCombatWithTrio(Unit* who)
    {
        if (Creature* vem = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_VEM)))
            if (vem->GetGUID() != me->GetGUID())
                vem->GetAI()->AttackStart(who);
        if (Creature* kri = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_KRI)))
            if (kri->GetGUID() != me->GetGUID())
                kri->GetAI()->AttackStart(who);
        if (Creature* yauj = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_YAUJ)))
            if (yauj->GetGUID() != me->GetGUID())
                yauj->GetAI()->AttackStart(who);
    }

    void EvadeAllBosses(EvadeReason why)
    {
        if (Creature* vem = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_VEM)))
        {
            if (vem->GetGUID() != me->GetGUID())
            {
                if (vem->IsAlive() && !vem->IsInEvadeMode())
                    vem->AI()->EnterEvadeMode(why);
                else
                    vem->Respawn();
            }
        }

        if (Creature* kri = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_KRI)))
        {
            if (kri->GetGUID() != me->GetGUID())
            {
                if (kri->IsAlive() && !kri->IsInEvadeMode())
                    kri->AI()->EnterEvadeMode(why);
                else
                    kri->Respawn();
            }
        }

        if (Creature* yauj = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_YAUJ)))
        {
            if (yauj->GetGUID() != me->GetGUID())
            {
                if (yauj->IsAlive() && !yauj->IsInEvadeMode())
                    yauj->AI()->EnterEvadeMode(why);
                else
                    yauj->Respawn();
            }
        }
    }

    void DoAction(int32 action) override
    {
        if (action != ACTION_CONSUME || dying)
        {
            return;
        }

        isEating = true;
        me->SetSpeed(MOVE_RUN, 45.f/7.f); // From sniffs
        me->SetReactState(REACT_PASSIVE);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE || id != POINT_CONSUME)
            return;

        me->GetMotionMaster()->MoveIdle();
        me->SetSpeed(MOVE_RUN, 15.f/7.f); // From sniffs
        DoCastSelf(SPELL_FULL_HEAL, true);
        DoResetThreat();
        isEating = false;

        _scheduler.Schedule(4s, [this](TaskContext /*context*/)
        {
            me->SetReactState(REACT_AGGRESSIVE);
            if (Unit* target = me->GetVictim())
            {
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveChase(target);
                AttackStart(target);
            }
        });
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        BossAI::EnterEvadeMode(why);
        EvadeAllBosses(why);
    }

    void Reset() override
    {
        BossAI::Reset();
        _scheduler.CancelAll();
        dying = false;
        isEating = false;
        instance->SetData(DATA_BUG_TRIO_DEATH, 0);
        me->SetSpeed(MOVE_RUN, 15.f / 7.f); // From sniffs
        me->SetStandState(UNIT_STAND_STATE_STAND);
        me->SetControlled(false, UNIT_STATE_ROOT);

        if (me->GetEntry() == NPC_VEM)
        {
            me->GetMotionMaster()->MovePath(VEM_WAYPOINT_PATH, true);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim() || isEating || !CheckInRoom())
            return;

        _scheduler.Update(diff, [this]
        {
            DoMeleeAttackIfReady();
        });
    }

    void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (me->HealthBelowPctDamaged(1, damage) && instance->GetData(DATA_BUG_TRIO_DEATH) < 2 && who->GetGUID() != me->GetGUID() && !dying)
        {
            damage = 0;
            if (isEating)
                return;

            _scheduler.CancelAll();
            me->SetStandState(UNIT_STAND_STATE_DEAD);
            me->SetReactState(REACT_PASSIVE);
            me->SetControlled(true, UNIT_STATE_ROOT);
            dying = true;

            DoFinalSpell();

            // Move the other bugs to this bug position
            if (Creature* vem = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_VEM)))
            {
                if (vem->GetGUID() != me->GetGUID())
                {
                    vem->AI()->DoAction(ACTION_CONSUME);
                    vem->GetMotionMaster()->MovePoint(POINT_CONSUME, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                }
            }
            if (Creature* kri = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_KRI)))
            {
                if (kri->GetGUID() != me->GetGUID())
                {
                    kri->AI()->DoAction(ACTION_CONSUME);
                    kri->GetMotionMaster()->MovePoint(POINT_CONSUME, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                }
            }
            if (Creature* yauj = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_YAUJ)))
            {
                if (yauj->GetGUID() != me->GetGUID())
                {
                    yauj->AI()->DoAction(ACTION_CONSUME);
                    yauj->GetMotionMaster()->MovePoint(POINT_CONSUME, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                }
            }

            _scheduler.Schedule(4s, [this](TaskContext /*context*/)
            {
                if (!me->IsInEvadeMode() && instance->GetData(DATA_BUG_TRIO_DEATH) < 2)
                {
                    DoCastSelf(SPELL_BLOODY_DEATH, true);
                    Talk(EMOTE_DEVOURED);
                    me->DespawnOrUnsummon(1000);
                }
            });
        }
    }

    void DoFinalSpell()
    {
        switch (me->GetEntry())
        {
            case NPC_KRI:
                DoCastSelf(SPELL_POISON_CLOUD, true);
                break;
            case NPC_VEM:
                DoCastSelf(SPELL_VENGEANCE, true);
                break;
            case NPC_YAUJ:
                for (uint8 i = 0; i < 10; ++i)
                {
                    Position randomPos;
                    me->GetRandomContactPoint(me, randomPos.m_positionX, randomPos.m_positionY, randomPos.m_positionZ);
                    if (Creature* summon = me->SummonCreature(NPC_YAUJ_BROOD, randomPos))
                        DoZoneInCombat(summon);
                }
                break;
            default:
                break;
        }
    }

    void JustDied(Unit* killer) override
    {
        if (killer->GetGUID() == me->GetGUID())
        {
            instance->SetData(DATA_BUG_TRIO_DEATH, 1);
            me->RemoveDynamicFlag(UNIT_DYNFLAG_LOOTABLE);
            return;
        }

        BossAI::JustDied(killer);
    }

    TaskScheduler _scheduler;
    bool dying;
    bool isEating;
};

struct boss_kri : public boss_bug_trio
{
    boss_kri(Creature* creature) : boss_bug_trio(creature)
    {
    }

    void EnterCombat(Unit* who) override
    {
        EnterCombatWithTrio(who);

        _scheduler.Schedule(4s, 8s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CLEAVE);
            context.Repeat(5s, 12s);
        })
        .Schedule(6s, 30s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_TOXIC_VOLLEY);
            context.Repeat(10s, 25s);
        })
        .Schedule(6s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_THRASH);
            context.Repeat(2s, 6s);
        });
    }
};

struct boss_vem : public boss_bug_trio
{
    boss_vem(Creature* creature) : boss_bug_trio(creature)
    {
    }

    void EnterCombat(Unit* who) override
    {
        EnterCombatWithTrio(who);

        _scheduler.Schedule(15s, 27s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, [this](Unit* target) -> bool
                {
                    if (target->GetTypeId() != TYPEID_PLAYER)
                        return false;
                    if (me->IsWithinMeleeRange(target) || target == me->GetVictim())
                        return false;
                    if (!me->IsWithinLOS(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ()))
                        return false;

                    return true;
                }))
            {
                DoCast(target, SPELL_CHARGE);
            }
            context.Repeat(8s, 16s);
        })
        .Schedule(10s, 20s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_KNOCKBACK);
            context.Repeat(10s, 20s);
        })
        .Schedule(5s, 8s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_KNOCKDOWN);
            context.Repeat(15s, 20s);
        })
        .Schedule(1s, [this](TaskContext context)
        {
            if (instance->GetData(DATA_BUG_TRIO_DEATH) == 2 && !me->HasAura(SPELL_VENGEANCE)) // Vem is the only one left.
            {
                DoCastSelf(SPELL_VENGEANCE, true);
            }
            context.Repeat(1s);
        });
    }
};

struct boss_yauj : public boss_bug_trio
{
    boss_yauj(Creature* creature) : boss_bug_trio(creature)
    {
    }

    void EnterCombat(Unit* who) override
    {
        EnterCombatWithTrio(who);

        _scheduler.Schedule(20s, 30s, [this](TaskContext context)
        {
            if (me->GetHealthPct() <= 93.f)
            {
                DoCastSelf(SPELL_HEAL);
            }
            else if (Unit* friendly = DoSelectLowestHpFriendly(100.f))
            {
                DoCast(friendly, SPELL_HEAL);
            }
            context.Repeat(10s, 30s);
        })
        .Schedule(12s, 24s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_FEAR);
            DoResetThreat();
            context.Repeat(20s);
        })
        .Schedule(12s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_RAVAGE);
            context.Repeat(10s, 15s);
        })
        .Schedule(10s, 30s, [this](TaskContext context)
        {
            std::list<Creature*> targets = DoFindFriendlyCC(50.f);
            if (!targets.empty())
            {
                if (Creature* target = *(targets.begin()))
                    me->CastSpell(target, SPELL_DISPEL);
            }
            context.Repeat(10s, 15s);
        });
    }
};

class spell_vem_knockback : public SpellScript
{
    PrepareSpellScript(spell_vem_knockback);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
        {
            if (Creature* cCaster = GetCaster()->ToCreature())
            {
                cCaster->GetThreatMgr().modifyThreatPercent(target, -80);
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_vem_knockback::HandleScriptEffect, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_vem_vengeance : public SpellScript
{
    PrepareSpellScript(spell_vem_vengeance);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if([&](WorldObject const* target) -> bool
            {
                return target->GetEntry() != NPC_YAUJ && target->GetEntry() != NPC_VEM && target->GetEntry() != NPC_KRI;
            });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_vem_vengeance::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENTRY);
    }
};

void AddSC_bug_trio()
{
    RegisterCreatureAI(boss_kri);
    RegisterCreatureAI(boss_vem);
    RegisterCreatureAI(boss_yauj);
    RegisterSpellScript(spell_vem_knockback);
    RegisterSpellScript(spell_vem_vengeance);
}
