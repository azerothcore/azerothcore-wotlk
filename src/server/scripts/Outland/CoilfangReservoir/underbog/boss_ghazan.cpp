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

#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "the_underbog.h"

enum eBlackStalker
{
    SPELL_ACID_BREATH               = 34268,
    SPELL_ACID_SPIT                 = 34290,
    SPELL_TAIL_SWEEP                = 34267,
    SPELL_ENRAGE                    = 15716,

    ACTION_MOVE_TO_PLATFORM         = 1
};

struct boss_ghazan : public BossAI
{
    boss_ghazan(Creature* creature) : BossAI(creature, DATA_GHAZAN)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void InitializeAI() override
    {
        _movedToPlatform = false;
        _reachedPlatform = false;
        Reset();
    }

    void Reset() override
    {
        _Reset();
        if (!_reachedPlatform)
        {
            _movedToPlatform = false;
        }

        ScheduleHealthCheckEvent(20, [&] {
            DoCastSelf(SPELL_ENRAGE);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.Schedule(3s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_ACID_BREATH);
            context.Repeat(7s, 9s);
        }).Schedule(1s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_ACID_SPIT);
            context.Repeat(7s, 9s);
        }).Schedule(DUNGEON_MODE<Milliseconds>(5900ms, 10s), [this](TaskContext context)
        {
            DoCastVictim(SPELL_TAIL_SWEEP);
            context.Repeat(7s, 9s);
        });

        _JustEngagedWith();
    }

    void DoAction(int32 type) override
    {
        if (type == ACTION_MOVE_TO_PLATFORM && !_movedToPlatform)
        {
            _movedToPlatform = true;
            me->GetMotionMaster()->MovePath((me->GetSpawnId() * 10) + 1, false);
        }
    }

    void MovementInform(uint32 type, uint32 pointId) override
    {
        if (!_movedToPlatform || type != WAYPOINT_MOTION_TYPE || pointId != 19)
        {
            return;
        }

        _reachedPlatform = true;
        me->SetHomePosition(me->GetPosition());

        me->m_Events.AddEventAtOffset([this]()
        {
            me->StopMoving();
            me->GetMotionMaster()->MoveRandom(12.f);
        }, 1ms);
    }

    void JustReachedHome() override
    {
        if (_reachedPlatform)
        {
            me->GetMotionMaster()->MoveRandom(12.f);
        }

        _JustReachedHome();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }

    private:
        bool _movedToPlatform;
        bool _reachedPlatform;
};

class at_underbog_ghazan : public OnlyOnceAreaTriggerScript
{
public:
    at_underbog_ghazan() : OnlyOnceAreaTriggerScript("at_underbog_ghazan") {}

    bool _OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (Creature* ghazan = instance->GetCreature(DATA_GHAZAN))
            {
                ghazan->AI()->DoAction(ACTION_MOVE_TO_PLATFORM);
                return true;
            }
        }

        return false;
    }
};

void AddSC_boss_ghazan()
{
    RegisterUnderbogCreatureAI(boss_ghazan);
    new at_underbog_ghazan();
}
