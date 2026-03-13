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
#include "SpellInfo.h"
#include "gundrak.h"

enum Spells
{
    SPELL_ECK_BERSERK                   = 55816,
    SPELL_ECK_BITE                      = 55813,
    SPELL_ECK_SPIT                      = 55814,
    SPELL_ECK_SPRING                    = 55815,
    SPELL_ECK_SPRING_INIT               = 55837
};

enum Misc
{
    POINT_START                         = 0,
    EVENT_ECK_BERSERK                   = 1,
    EVENT_ECK_CRAZED_EMOTE              = 2,
    EMOTE_CRAZED                        = 1
};

Position const EckHomePosition = { 1642.712f, 934.646f, 107.205f, 0.767f };
Position const EckCombatStartPosition = { 1638.55f, 919.76f, 104.95f, 0.00f };

struct boss_eck : public BossAI
{
    boss_eck(Creature* creature) : BossAI(creature, DATA_ECK_THE_FEROCIOUS)
    {
        scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
    }

    void InitializeAI() override
    {
        BossAI::InitializeAI();
        me->GetMotionMaster()->MovePoint(POINT_START, EckCombatStartPosition, FORCED_MOVEMENT_NONE, 0.f, false);
        me->SetHomePosition(EckHomePosition);
        me->SetReactState(REACT_PASSIVE);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == POINT_START)
        {
            me->CastSpell(me, SPELL_ECK_SPRING_INIT, true);
            me->SetReactState(REACT_AGGRESSIVE);
        }
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_ECK_SPRING)
        {
            me->GetThreatMgr().ResetAllThreat();
            me->AddThreat(target, 1.0f);
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        ScheduleUniqueTimedEvent(77s, [&] {
            Talk(EMOTE_CRAZED);
        }, EVENT_ECK_CRAZED_EMOTE);
        ScheduleTimedEvent(5s, [&] {
            DoCastVictim(SPELL_ECK_BITE);
        }, 8s, 12s);
        ScheduleTimedEvent(10s, 37s, [&] {
            DoCastVictim(SPELL_ECK_SPIT);
        }, 8s, 12s);
        ScheduleTimedEvent(10s, 24s, [&] {
            DoCastRandomTarget(SPELL_ECK_SPRING, 0, 30.0f, true);
        }, 10s, 24s);
        ScheduleEnrageTimer(SPELL_ECK_BERSERK, 90s);
    }
};

void AddSC_boss_eck()
{
    RegisterGundrakCreatureAI(boss_eck);
}
