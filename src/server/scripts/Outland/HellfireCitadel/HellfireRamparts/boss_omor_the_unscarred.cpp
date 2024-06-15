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
#include "ScriptedCreature.h"
#include "hellfire_ramparts.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_SUMMON                  = 1,
    SAY_CURSE                   = 2,
    SAY_KILL                    = 3,
    SAY_DIE                     = 4,
    SAY_WIPE                    = 5
};

enum Spells
{
    SPELL_SHADOW_BOLT           = 30686,
    SPELL_SUMMON_FIENDISH_HOUND = 30707,
    SPELL_TREACHEROUS_AURA      = 30695,
    SPELL_DEMONIC_SHIELD        = 31901
};

struct boss_omor_the_unscarred : public BossAI
{
    boss_omor_the_unscarred(Creature* creature) : BossAI(creature, DATA_OMOR_THE_UNSCARRED)
    {
        me->SetCombatMovement(false);
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        Talk(SAY_WIPE);
        _Reset();
        _targetGUID.Clear();
        ScheduleHealthCheckEvent(21, [&]{
            DoCastSelf(SPELL_DEMONIC_SHIELD);
            scheduler.Schedule(15s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_DEMONIC_SHIELD);
                context.Repeat(15s);
            });
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        _JustEngagedWith();
        scheduler.Schedule(6s, [this](TaskContext context)
        {
            if (roll_chance_i(33))
            {
                Talk(SAY_CURSE);
            }
            DoCastRandomTarget(SPELL_TREACHEROUS_AURA);
            context.Repeat(12s, 18s);
        }).Schedule(10s, [this](TaskContext /*context*/)
        {
            DoCastSelf(SPELL_SUMMON_FIENDISH_HOUND);
        }).Schedule(25s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SUMMON_FIENDISH_HOUND);
            context.Repeat(15s);
        });
    }

    void KilledUnit(Unit*) override
    {
        if(!_hasSpoken)
        {
            _hasSpoken = true;
            Talk(SAY_KILL);
        }
        scheduler.Schedule(6s, [this](TaskContext /*context*/)
        {
            _hasSpoken = false;
        });
    }

    void JustSummoned(Creature* summon) override
    {
        Talk(SAY_SUMMON);
        summons.Summon(summon);
        summon->SetInCombatWithZone();
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DIE);
        _JustDied();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        if (!me->GetVictim() || !me->isAttackReady())
            return;

        if (me->IsWithinMeleeRange(me->GetVictim()))
        {
            me->GetMotionMaster()->MoveChase(me->GetVictim());
            DoMeleeAttackIfReady();
        }
        else
        {
            me->GetMotionMaster()->Clear();
            DoCastVictim(SPELL_SHADOW_BOLT);
            me->resetAttackTimer();
        }
    }

private:
    ObjectGuid _targetGUID;
    bool _hasSpoken;
};

void AddSC_boss_omor_the_unscarred()
{
    RegisterHellfireRampartsCreatureAI(boss_omor_the_unscarred);
}
