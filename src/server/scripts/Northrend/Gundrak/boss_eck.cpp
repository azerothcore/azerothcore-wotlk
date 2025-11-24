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
    EVENT_ECK_BITE                      = 2,
    EVENT_ECK_SPIT                      = 3,
    EVENT_ECK_SPRING                    = 4,
    EVENT_ECK_HEALTH                    = 5
};

class boss_eck : public CreatureScript
{
public:
    boss_eck() : CreatureScript("boss_eck") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetGundrakAI<boss_eckAI>(creature);
    }

    struct boss_eckAI : public BossAI
    {
        boss_eckAI(Creature* creature) : BossAI(creature, DATA_ECK_THE_FEROCIOUS)
        {
        }

        void InitializeAI() override
        {
            BossAI::InitializeAI();
            me->GetMotionMaster()->MovePoint(POINT_START, 1638.55f, 919.76f, 104.95f, FORCED_MOVEMENT_NONE, 0.f, 0.f, false);
            me->SetHomePosition(1642.712f, 934.646f, 107.205f, 0.767f);
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

        void Reset() override
        {
            BossAI::Reset();
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            events.ScheduleEvent(EVENT_ECK_BERSERK, 60s, 90s);
            events.ScheduleEvent(EVENT_ECK_BITE, 5s);
            events.ScheduleEvent(EVENT_ECK_SPIT, 10s, 37s);
            events.ScheduleEvent(EVENT_ECK_SPRING, 10s, 24s);
        }

        void JustDied(Unit* killer) override
        {
            BossAI::JustDied(killer);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_ECK_HEALTH:
                    if (me->HealthBelowPct(21))
                    {
                        events.CancelEvent(EVENT_ECK_BERSERK);
                        me->CastSpell(me, SPELL_ECK_BERSERK, false);
                        break;
                    }
                    events.ScheduleEvent(EVENT_ECK_HEALTH, 1s);
                    break;
                case EVENT_ECK_BERSERK:
                    me->CastSpell(me, SPELL_ECK_BERSERK, false);
                    events.CancelEvent(EVENT_ECK_HEALTH);
                    break;
                case EVENT_ECK_BITE:
                    me->CastSpell(me->GetVictim(), SPELL_ECK_BITE, false);
                    events.ScheduleEvent(EVENT_ECK_BITE, 8s, 12s);
                    break;
                case EVENT_ECK_SPIT:
                    me->CastSpell(me->GetVictim(), SPELL_ECK_SPIT, false);
                    events.ScheduleEvent(EVENT_ECK_SPIT, 11s, 24s);
                    break;
                case EVENT_ECK_SPRING:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true, false))
                    {
                        me->CastSpell(target, SPELL_ECK_SPRING, false);
                    }
                    events.ScheduleEvent(EVENT_ECK_SPRING, 10s, 24s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_eck()
{
    new boss_eck();
}
