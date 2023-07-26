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

#include "MoveSplineInit.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SmartScriptMgr.h"
#include "old_hillsbrad.h"

enum Text
{
    SAY_ENTER                = 0,
    SAY_AGGRO                = 1,
    SAY_SLAY                 = 2,
    SAY_MORTAL               = 3,
    SAY_SHOUT                = 4,
    SAY_DEATH                = 5
};

enum Spells
{
    SPELL_WHIRLWIND          = 31909,
    SPELL_EXPLODING_SHOT     = 33792,
    SPELL_HAMSTRING          = 9080,
    SPELL_MORTAL_STRIKE      = 31911,
    SPELL_FRIGHTENING_SHOUT  = 33789
};

struct boss_lieutenant_drake : public BossAI
{
    boss_lieutenant_drake(Creature* creature) : BossAI(creature, DATA_LIEUTENANT_DRAKE)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void InitializeAI() override
    {
        runSecondPath = false;
        pathId = me->GetEntry() * 10;
        me->GetMotionMaster()->MovePath(pathId, false);
    }

    void Reset() override
    {
        _Reset();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);
        scheduler.Schedule(4s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_WHIRLWIND);
            context.Repeat(25s);
        }).Schedule(14s, [this](TaskContext context)
        {
            if (roll_chance_i(40))
            {
                Talk(SAY_SHOUT);
            }
            DoCastSelf(SPELL_FRIGHTENING_SHOUT);
            context.Repeat(25s);
        }).Schedule(9s, [this](TaskContext context)
        {
            if (roll_chance_i(40))
            {
                Talk(SAY_MORTAL);
            }
            DoCastVictim(SPELL_MORTAL_STRIKE);
            context.Repeat(10s);
        }).Schedule(18s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_HAMSTRING);
            context.Repeat(25s);
        }).Schedule(1s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 40.0f))
            {
                DoCast(target, SPELL_EXPLODING_SHOT);
            }
            context.Repeat(25s);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->GetTypeId() == TYPEID_PLAYER)
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
        if (InstanceScript* instance = me->GetInstanceScript())
        {
            instance->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_DRAKE_KILLED);
        }
    }

    void MovementInform(uint32 type, uint32 point) override
    {
        if (type != WAYPOINT_MOTION_TYPE)
        {
            return;
        }

        if (pathId == me->GetEntry() * 10)
        {
            switch (point)
            {
                case 7:
                    Talk(SAY_ENTER);
                    break;
                case 10:
                    pathId = (me->GetEntry() * 10) + 1;
                    runSecondPath = true;
                    break;
                default:
                    break;
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (runSecondPath)
        {
            runSecondPath = false;
            me->GetMotionMaster()->MovePath(pathId, true);
        }

        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }

private:
    uint32 pathId;
    bool runSecondPath;
};

void AddSC_boss_lieutenant_drake()
{
    RegisterOldHillsbradCreatureAI(boss_lieutenant_drake);
}
