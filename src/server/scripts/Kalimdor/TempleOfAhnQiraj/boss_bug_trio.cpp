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
#include "temple_of_ahnqiraj.h"
#include "TaskScheduler.h"

enum Spells
{
    // Kri
    SPELL_CLEAVE         = 26350,
    SPELL_TOXIC_VOLLEY   = 25812,
    SPELL_POISON_CLOUD   = 38718, // Only Spell with right dmg.

    // Vem
    SPELL_CHARGE         = 26561,
    SPELL_KNOCKBACK      = 18670,
    SPELL_KNOCKDOWN      = 19128,
    SPELL_VENGEANCE      = 25790,

    // Yauj
    SPELL_HEAL           = 25807,
    SPELL_FEAR           = 19408,
    SPELL_RAVAGE         = 24213,
    SPELL_DISPEL         = 25808
};

struct boss_bug_trio : public ScriptedAI
{
public:
    boss_bug_trio(Creature* creature) : ScriptedAI(creature) { _instance = me->GetInstanceScript(); }

    void EnterCombatWithTrio(Unit* who)
    {
        if (Creature* vem = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_VEM)))
            if (vem->GetGUID() != me->GetGUID())
                vem->GetAI()->AttackStart(who);
        if (Creature* kri = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_KRI)))
            if (kri->GetGUID() != me->GetGUID())
                kri->GetAI()->AttackStart(who);
        if (Creature* yauj = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_YAUJ)))
            if (yauj->GetGUID() != me->GetGUID())
                yauj->GetAI()->AttackStart(who);
    }

    InstanceScript* _instance;
};

struct boss_kri : public boss_bug_trio
{
    boss_kri(Creature* creature) : boss_bug_trio(creature)
    {
    }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void EnterCombat(Unit* who) override
    {
        EnterCombatWithTrio(who);

        _scheduler.Schedule(4s, 8s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CLEAVE);
            context.Repeat(5s, 12s);
        })
        .Schedule(6s, 12s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_TOXIC_VOLLEY);
            context.Repeat(10s, 15s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (_instance->GetData(DATA_BUG_TRIO_DEATH) < 2) // Unlootable until the trio is dead.
        {
            me->RemoveDynamicFlag(UNIT_DYNFLAG_LOOTABLE);
        }

        _instance->SetData(DATA_BUG_TRIO_DEATH, 1);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff, [this]
        {
            DoMeleeAttackIfReady();
        });
    }

private:
    TaskScheduler _scheduler;
};

struct boss_vem : public boss_bug_trio
{
    boss_vem(Creature* creature) : boss_bug_trio(creature)
    {
    }

    void Reset() override
    {
        _scheduler.CancelAll();

        _enraged = false;
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoCastAOE(SPELL_VENGEANCE, true);
        _instance->SetData(DATA_VEM_DEATH, 0);
        if (_instance->GetData(DATA_BUG_TRIO_DEATH) < 2) // Unlootable until the trio is dead.
        {
            me->RemoveDynamicFlag(UNIT_DYNFLAG_LOOTABLE);
        }
        _instance->SetData(DATA_BUG_TRIO_DEATH, 1);
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
            if (_instance->GetData(DATA_BUG_TRIO_DEATH) == 2 && !_enraged) // Vem is the only one left.
            {
                DoCastSelf(SPELL_VENGEANCE, true);
                _enraged = true;
            }
            context.Repeat(1s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff, [this]
        {
            DoMeleeAttackIfReady();
        });
    }

private:
    TaskScheduler _scheduler;
    bool _enraged;
};

struct boss_yauj : public boss_bug_trio
{
    boss_yauj(Creature* creature) : boss_bug_trio(creature)
    {
    }

    void Reset() override
    {
        _scheduler.CancelAll();
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (_instance->GetData(DATA_BUG_TRIO_DEATH) < 2) // Unlootable until the trio is dead.
            me->RemoveDynamicFlag(UNIT_DYNFLAG_LOOTABLE);
        _instance->SetData(DATA_BUG_TRIO_DEATH, 1);

        for (uint8 i = 0; i < 10; ++i)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
            {
                if (Creature* Summoned = me->SummonCreature(15621, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 90000))
                    Summoned->AI()->AttackStart(target);
            }
        }
    }

    void EnterCombat(Unit* who) override
    {
        EnterCombatWithTrio(who);

        _scheduler.Schedule(10s, 20s, [this](TaskContext context)
        {
            if (me->GetHealthPct() <= 93.f)
            {
                DoCastSelf(SPELL_HEAL);
            }
            else if (Unit* friendly = DoSelectLowestHpFriendly(100.f))
            {
                DoCast(friendly, SPELL_HEAL);
            }
            context.Repeat(12s);
        })
        .Schedule(10s, 20s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_FEAR);
            DoResetThreat();
            context.Repeat(20s);
        })
        .Schedule(12s, 20s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_RAVAGE);
            context.Repeat(12s, 20s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff, [this]
        {
            DoMeleeAttackIfReady();
        });
    }

private:
    TaskScheduler _scheduler;
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
                cCaster->getThreatMgr().modifyThreatPercent(target, -80);
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
