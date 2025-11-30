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
#include "TaskScheduler.h"
#include "gruuls_lair.h"
#include "SpellMgr.h"

enum HighKingMaulgar
{
    SAY_AGGRO                   = 0,
    SAY_ENRAGE                  = 1,
    SAY_OGRE_DEATH              = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4,

    // High King Maulgar
    SPELL_ARCING_SMASH          = 39144,
    SPELL_MIGHTY_BLOW           = 33230,
    SPELL_WHIRLWIND             = 33238,
    SPELL_BERSERKER_C           = 26561,
    SPELL_ROAR                  = 16508,
    SPELL_FLURRY                = 33232,

    // Olm the Summoner
    SPELL_DARK_DECAY            = 33129,
    SPELL_DEATH_COIL            = 33130,
    SPELL_SUMMON_WFH            = 33131,

    // Kiggler the Craed
    SPELL_GREATER_POLYMORPH     = 33173,
    SPELL_LIGHTNING_BOLT        = 36152,
    SPELL_ARCANE_SHOCK          = 33175,
    SPELL_ARCANE_EXPLOSION      = 33237,

    // Blindeye the Seer
    SPELL_GREATER_PW_SHIELD     = 33147,
    SPELL_HEAL                  = 33144,
    SPELL_PRAYER_OH             = 33152,

    // Krosh Firehand
    SPELL_GREATER_FIREBALL      = 33051,
    SPELL_SPELLSHIELD           = 33054,
    SPELL_BLAST_WAVE            = 33061,

    ACTION_ADD_DEATH            = 1
};

struct boss_high_king_maulgar : public BossAI
{
    boss_high_king_maulgar(Creature* creature) : BossAI(creature, DATA_MAULGAR)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        _recentlySpoken = false;
        me->SetLootMode(0);
        ScheduleHealthCheckEvent(50, [&]{
            Talk(SAY_ENRAGE);
            DoCastSelf(SPELL_FLURRY);

            scheduler.Schedule(0ms, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_BERSERKER_C);
                context.Repeat(35s);
            }).Schedule(0ms, [this](TaskContext context)
            {
                DoCastVictim(SPELL_ROAR);
                context.Repeat(20600ms, 29100ms);
            });
        });
    }

    void KilledUnit(Unit*  /*victim*/) override
    {
        if (!_recentlySpoken)
        {
            Talk(SAY_SLAY);
            _recentlySpoken = true;
        }

        scheduler.Schedule(5s, [this](TaskContext)
        {
            _recentlySpoken = false;
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        if (instance->GetData(DATA_ADDS_KILLED) == MAX_ADD_NUMBER)
            _JustDied();
    }

    void DoAction(int32 actionId) override
    {
        if (me->IsAlive())
        {
            Talk(SAY_OGRE_DEATH);
            if (actionId == MAX_ADD_NUMBER)
            {
                me->AddLootMode(1);
            }
        }
        else if (actionId == MAX_ADD_NUMBER)
        {
            me->AddLootMode(1);
            me->loot.clear();
            me->loot.FillLoot(me->GetCreatureTemplate()->lootid, LootTemplates_Creature, me->GetLootRecipient(), false, false, me->GetLootMode(), me);
            me->SetDynamicFlag(UNIT_DYNFLAG_LOOTABLE);
            _JustDied();
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        scheduler.Schedule(9500ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_ARCING_SMASH);
            context.Repeat(9500ms, 12s);
        }).Schedule(15700ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_MIGHTY_BLOW);
            context.Repeat(16200ms, 19s);
        }).Schedule(67s, [this](TaskContext context)
        {
            scheduler.DelayAll(15s);
            DoCastSelf(SPELL_WHIRLWIND);
            context.Repeat(45s, 60s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }
private:
    bool _recentlySpoken;
};

struct boss_olm_the_summoner : public ScriptedAI
{
    boss_olm_the_summoner(Creature* creature) : ScriptedAI(creature), summons(me)
    {
        instance = creature->GetInstanceScript();
        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    SummonList summons;
    InstanceScript* instance;

    void Reset() override
    {
        _scheduler.CancelAll();
        summons.DespawnAll();
        instance->SetBossState(DATA_MAULGAR, NOT_STARTED);
    }

    void AttackStart(Unit* who) override
    {
        if (!who)
            return;

        if (me->Attack(who, true))
            me->GetMotionMaster()->MoveChase(who, 25.0f);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->SetInCombatWithZone();
        instance->SetBossState(DATA_MAULGAR, IN_PROGRESS);

        _scheduler.Schedule(1200ms, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SUMMON_WFH);
            context.Repeat(48500ms);
        }).Schedule(6050ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_DARK_DECAY);
            context.Repeat(6050ms);
        }).Schedule(6500ms, [this](TaskContext context)
        {
            if (me->HealthBelowPct(90))
            {
                DoCastRandomTarget(SPELL_DEATH_COIL);
            }
            context.Repeat(6s, 13500ms);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        instance->SetData(DATA_ADDS_KILLED, 1);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }
private:
    TaskScheduler _scheduler;
};

struct boss_kiggler_the_crazed : public ScriptedAI
{
    boss_kiggler_the_crazed(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    InstanceScript* instance;

    void Reset() override
    {
        _scheduler.CancelAll();
        instance->SetBossState(DATA_MAULGAR, NOT_STARTED);
    }

    void AttackStart(Unit* who) override
    {
        if (!who)
            return;

        if (me->Attack(who, true))
            me->GetMotionMaster()->MoveChase(who, 25.0f);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->SetInCombatWithZone();
        instance->SetBossState(DATA_MAULGAR, IN_PROGRESS);

        _scheduler.Schedule(1200ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_LIGHTNING_BOLT);
            context.Repeat(2400ms);
        }).Schedule(29s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_ARCANE_SHOCK);
            context.Repeat(7200ms, 20600ms);
        }).Schedule(23s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_GREATER_POLYMORPH);
            context.Repeat(10900ms);
        }).Schedule(30s, [this](TaskContext context)
        {
            if (me->SelectNearestPlayer(30.0f))
            {
                    DoCastAOE(SPELL_ARCANE_EXPLOSION);
            }
            context.Repeat(30s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        instance->SetData(DATA_ADDS_KILLED, 1);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }
private:
    TaskScheduler _scheduler;
};

struct boss_blindeye_the_seer : public ScriptedAI
{
    boss_blindeye_the_seer(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    InstanceScript* instance;

    void Reset() override
    {
        _scheduler.CancelAll();
        instance->SetBossState(DATA_MAULGAR, NOT_STARTED);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->SetInCombatWithZone();
        instance->SetBossState(DATA_MAULGAR, IN_PROGRESS);

        _scheduler.Schedule(7200ms, [this](TaskContext context)
        {
            if (Unit* target = DoSelectLowestHpFriendly(60.0f, 50000))
            {
                DoCast(target, SPELL_HEAL);
            }
            context.Repeat(7200ms);
        }).Schedule(37500s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_GREATER_PW_SHIELD);
            _scheduler.Schedule(1200ms, [this](TaskContext)
            {
                DoCastSelf(SPELL_PRAYER_OH);
            });
            context.Repeat(54500ms, 63s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        instance->SetData(DATA_ADDS_KILLED, 1);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }
private:
    TaskScheduler _scheduler;
};

struct boss_krosh_firehand : public ScriptedAI
{
    boss_krosh_firehand(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    InstanceScript* instance;

    void Reset() override
    {
        _scheduler.CancelAll();
        instance->SetBossState(DATA_MAULGAR, NOT_STARTED);
    }

    void AttackStart(Unit* who) override
    {
        if (!who)
            return;

        if (me->Attack(who, true))
            me->GetMotionMaster()->MoveChase(who, 25.0f);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->SetInCombatWithZone();
        instance->SetBossState(DATA_MAULGAR, IN_PROGRESS);

        _scheduler.Schedule(1200ms, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SPELLSHIELD);
            context.Repeat(30300ms);
        }).Schedule(3600ms, [this](TaskContext context)
        {
            DoCastVictim(SPELL_GREATER_FIREBALL);
            context.Repeat(3600ms);
        }).Schedule(7200ms, [this](TaskContext context)
        {
            if (me->SelectNearestPlayer(15.0f))
            {
                    DoCastAOE(SPELL_BLAST_WAVE);
            }
            context.Repeat(7200ms);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        instance->SetData(DATA_ADDS_KILLED, 1);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }
private:
    TaskScheduler _scheduler;
};

void AddSC_boss_high_king_maulgar()
{
    RegisterGruulsLairAI(boss_high_king_maulgar);
    RegisterGruulsLairAI(boss_kiggler_the_crazed);
    RegisterGruulsLairAI(boss_blindeye_the_seer);
    RegisterGruulsLairAI(boss_olm_the_summoner);
    RegisterGruulsLairAI(boss_krosh_firehand);
}
