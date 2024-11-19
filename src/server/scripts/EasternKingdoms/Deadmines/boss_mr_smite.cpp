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
#include "deadmines.h"

enum Spells
{
    SPELL_SMITE_STOMP       = 6432,
    SPELL_SMITE_SLAM        = 6435,

    EQUIP_SWORD             = 1,
    EQUIP_TWO_SWORDS        = 2,
    EQUIP_MACE              = 3,

    EVENT_CHECK_HEALTH1     = 1,
    EVENT_CHECK_HEALTH2     = 2,
    EVENT_SMITE_SLAM        = 3,
    EVENT_SWAP_WEAPON1      = 4,
    EVENT_SWAP_WEAPON2      = 5,
    EVENT_RESTORE_COMBAT    = 6,
    EVENT_KNEEL             = 7,

    SAY_SWAP1               = 2,
    SAY_SWAP2               = 3
};

class boss_mr_smite : public CreatureScript
{
public:
    boss_mr_smite() : CreatureScript("boss_mr_smite") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetDeadminesAI<boss_mr_smiteAI>(creature);
    }

    struct boss_mr_smiteAI : public ScriptedAI
    {
        boss_mr_smiteAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        EventMap events;
        bool health67;
        bool health34;

        void Reset() override
        {
            health67 = false;
            health34 = false;
            me->LoadEquipment(EQUIP_SWORD);
            me->SetCanDualWield(false);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->RemoveUnitFlag(UNIT_FLAG_PACIFIED);
            me->SetReactState(REACT_AGGRESSIVE);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_CHECK_HEALTH1, 500ms);
            events.ScheduleEvent(EVENT_CHECK_HEALTH2, 500ms);
            events.ScheduleEvent(EVENT_SMITE_SLAM, 3s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_CHECK_HEALTH1:
                    if (me->HealthBelowPct(67) && !health67)
                    {
                        me->CastSpell(me, SPELL_SMITE_STOMP, false);
                        events.DelayEvents(10000);
                        me->GetMotionMaster()->Clear();
                        me->GetMotionMaster()->MovePoint(EQUIP_TWO_SWORDS, 1.859f, -780.72f, 9.831f);
                        Talk(SAY_SWAP1);
                        me->SetUnitFlag(UNIT_FLAG_PACIFIED);
                        me->SetReactState(REACT_PASSIVE);
                        health67 = true;
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH1, 500ms);
                    break;
                case EVENT_CHECK_HEALTH2:
                    if (me->HealthBelowPct(34) && !health34)
                    {
                        me->CastSpell(me, SPELL_SMITE_STOMP, false);
                        events.DelayEvents(10000);
                        me->GetMotionMaster()->Clear();
                        me->GetMotionMaster()->MovePoint(EQUIP_MACE, 1.859f, -780.72f, 9.831f);
                        Talk(SAY_SWAP2);
                        me->SetUnitFlag(UNIT_FLAG_PACIFIED);
                        me->SetReactState(REACT_PASSIVE);
                        health34 = true;
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH2, 500ms);
                    break;
                case EVENT_SMITE_SLAM:
                    if (me->HealthBelowPct(33))
                    {
                        me->CastSpell(me->GetVictim(), SPELL_SMITE_SLAM, false);
                        events.ScheduleEvent(EVENT_SMITE_SLAM, 6s);
                        break;
                    }
                    events.ScheduleEvent(EVENT_SMITE_SLAM, 500ms);
                    break;
                case EVENT_SWAP_WEAPON1:
                    me->LoadEquipment(EQUIP_TWO_SWORDS);
                    me->SetCanDualWield(true);
                    break;
                case EVENT_SWAP_WEAPON2:
                    me->LoadEquipment(EQUIP_MACE);
                    me->SetCanDualWield(false);
                    break;
                case EVENT_RESTORE_COMBAT:
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->RemoveUnitFlag(UNIT_FLAG_PACIFIED);
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    if (me->GetVictim())
                    {
                        me->GetMotionMaster()->MoveChase(me->GetVictim());
                        me->SetTarget(me->GetVictim()->GetGUID());
                    }
                    break;
                case EVENT_KNEEL:
                    me->SendMeleeAttackStop(me->GetVictim());
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            me->SetTarget();
            me->SetFacingTo(5.558f);
            me->SetStandState(UNIT_STAND_STATE_KNEEL);
            events.ScheduleEvent(point == EQUIP_TWO_SWORDS ? EVENT_SWAP_WEAPON1 : EVENT_SWAP_WEAPON2, 1500ms);
            events.ScheduleEvent(EVENT_RESTORE_COMBAT, 3s);
            events.ScheduleEvent(EVENT_KNEEL, 0ms);
        }
    };
};

void AddSC_boss_mr_smite()
{
    new boss_mr_smite();
}
