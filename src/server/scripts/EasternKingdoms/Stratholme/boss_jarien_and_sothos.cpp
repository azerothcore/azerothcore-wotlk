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
#include "stratholme.h"
#include "TaskScheduler.h"

enum Texts
{
    // Sothos
    SAY_SOTHOS_ON_SUMMON_0     = 0,
    SAY_SOTHOS_ON_SUMMON_1     = 1,
    EMOTE_SOTHOS_VENGEANCE     = 2,

    // Jarien
    SAY_JARIEN_ON_SUMMON_0     = 0,
    SAY_JARIEN_ON_SUMMON_1     = 1,
    SAY_JARIEN_ON_SUMMON_2     = 2,
    EMOTE_JARIEN_VENGEANCE     = 3
};

enum Spells
{
    // Jarien
    SPELL_MORTAL_STRIKE     = 16856,
    SPELL_SHADOW_SHOCK      = 22575,
    SPELL_CRIPPLE           = 20812,
    SPELL_CLEAVE            = 15284,

    // Sothos
    SPELL_SHIELD_CHARGE     = 15749,
    SPELL_SHIELD_SLAM       = 15655,
    SPELL_SHIELD_BLOCK      = 12169,
    SPELL_SHADOW_BOLT       = 27646,
    SPELL_FEAR              = 27641,

    // Both
    SPELL_VENGEANCE         = 27650
};

enum Phases
{
    PHASE_TALK = 0,
    PHASE_FIGHT
};

enum Actions
{
    ACTION_PARTNER_DEAD = 0
};

struct boss_jarien : public BossAI
{
    boss_jarien(Creature* creature) : BossAI(creature, DATA_JARIEN)
    {
        _scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });

        _talked = false;
        _phase = PHASE_TALK;
    }

    void Reset() override
    {
        _scheduler.CancelAll();
        _phase = _talked ? PHASE_FIGHT : PHASE_TALK;
        _Reset();
    }

    void IsSummonedBy(Unit* /*summoner*/) override
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        Talk(SAY_JARIEN_ON_SUMMON_0);

        _scheduler.Schedule(6s, [this](TaskContext /*context*/)
            {
                Talk(SAY_JARIEN_ON_SUMMON_1);
            })
        .Schedule(12s, [this](TaskContext /*context*/)
            {
                Talk(SAY_JARIEN_ON_SUMMON_2);
                _talked = true;
                _phase = PHASE_FIGHT;
                me->SetReactState(REACT_AGGRESSIVE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            });
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        if (Creature * sothos = me->FindNearestCreature(NPC_SOTHOS, 200.f))
        {
            sothos->AI()->DoAction(ACTION_PARTNER_DEAD);
        }
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_PARTNER_DEAD)
        {
            me->SetFullHealth();
            DoCastSelf(SPELL_VENGEANCE);
            Talk(EMOTE_JARIEN_VENGEANCE);
        }
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _EnterCombat();
        _scheduler.Schedule(5s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_SHADOW_SHOCK);
                context.Repeat(10s, 12s);
            })
        .Schedule(3s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_CLEAVE);
                context.Repeat(10s);
            })
        .Schedule(11s, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_CRIPPLE);
                context.Repeat(30s);
            })
        .Schedule(10s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_MORTAL_STRIKE);
                context.Repeat(15s);
            });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim() && _phase != PHASE_TALK)
        {
            return;
        }

        _scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
    }

    protected:
        TaskScheduler _scheduler;
        uint8 _phase;
        bool _talked;
};

struct boss_sothos : public BossAI
{
    boss_sothos(Creature* creature) : BossAI(creature, DATA_SOTHOS)
    {
        _scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });

        _talked = false;
        _phase = PHASE_TALK;
    }

    void Reset() override
    {
        _scheduler.CancelAll();
        _phase = _talked ? PHASE_FIGHT : PHASE_TALK;
        _Reset();
    }

    void IsSummonedBy(Unit* /*summoner*/) override
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

        _scheduler.Schedule(12s, [this](TaskContext /*context*/)
            {
                _talked = true;
                _phase = PHASE_FIGHT;
                me->SetReactState(REACT_AGGRESSIVE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            })
        .Schedule(3s, [this](TaskContext /*context*/)
            {
                Talk(SAY_SOTHOS_ON_SUMMON_0);
            })
        .Schedule(9s, [this](TaskContext /*context*/)
            {
                Talk(SAY_SOTHOS_ON_SUMMON_1);
            });
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        if (Creature* jarien = me->FindNearestCreature(NPC_JARIEN, 200.f))
        {
            jarien->AI()->DoAction(ACTION_PARTNER_DEAD);
        }
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_PARTNER_DEAD)
        {
            me->SetFullHealth();
            DoCastSelf(SPELL_VENGEANCE);
            Talk(EMOTE_SOTHOS_VENGEANCE);
        }
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _EnterCombat();
        _scheduler.Schedule(10s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_FEAR);
                context.Repeat(18s, 20s);
            })
        .Schedule(9s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_SHADOW_BOLT);
                context.Repeat(10s, 11s);
            })
        .Schedule(15s, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_SHIELD_CHARGE);
                context.Repeat();
            })
        .Schedule(3s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_SHIELD_BLOCK);
                context.Repeat(10s, 12s);
            })
        .Schedule(4s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_SHIELD_SLAM);
                context.Repeat(14s);
            });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim() && _phase != PHASE_TALK)
        {
            return;
        }

        _scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
    }

    protected:
        TaskScheduler _scheduler;
        uint8 _phase;
        bool _talked;
};

void AddSC_boss_jarien_and_sothos()
{
    RegisterStratholmeCreatureAI(boss_jarien);
    RegisterStratholmeCreatureAI(boss_sothos);
}
