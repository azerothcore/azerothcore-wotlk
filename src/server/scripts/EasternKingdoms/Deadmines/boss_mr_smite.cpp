/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum Spels
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

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_mr_smiteAI>(creature);
        }

        struct boss_mr_smiteAI : public ScriptedAI
        {
            boss_mr_smiteAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            EventMap events;
            bool health67;
            bool health34;

            void Reset()
            {
                health67 = false;
                health34 = false;
                me->LoadEquipment(EQUIP_SWORD);
                me->SetCanDualWield(false);
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
                me->SetReactState(REACT_AGGRESSIVE);
            }

            void EnterCombat(Unit* /*who*/)
            {
                events.ScheduleEvent(EVENT_CHECK_HEALTH1, 500);
                events.ScheduleEvent(EVENT_CHECK_HEALTH2, 500);
                events.ScheduleEvent(EVENT_SMITE_SLAM, 3000);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                switch (events.ExecuteEvent())
                {
                    case EVENT_SMITE_SLAM:
                        me->CastSpell(me->GetVictim(), SPELL_SMITE_SLAM, false);
                        events.ScheduleEvent(EVENT_SMITE_SLAM, 15000);
                        break;
                    case EVENT_CHECK_HEALTH1:
                        if (me->HealthBelowPct(67) && !health67)
                        {
                            me->CastSpell(me, SPELL_SMITE_STOMP, false);
                            events.DelayEvents(10000);
                            me->GetMotionMaster()->Clear();
                            me->GetMotionMaster()->MovePoint(EQUIP_TWO_SWORDS, 1.859f, -780.72f, 9.831f);
                            Talk(SAY_SWAP1);
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
                            me->SetReactState(REACT_PASSIVE);
                            health67 = true;
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH1, 500);
                        break;
                    case EVENT_CHECK_HEALTH2:
                        if (me->HealthBelowPct(34) && !health34)
                        {
                            me->CastSpell(me, SPELL_SMITE_STOMP, false);
                            events.DelayEvents(10000);
                            me->GetMotionMaster()->Clear();
                            me->GetMotionMaster()->MovePoint(EQUIP_MACE, 1.859f, -780.72f, 9.831f);
                            Talk(SAY_SWAP2);
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
                            me->SetReactState(REACT_PASSIVE);
                            health34 = true;
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH2, 500);
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
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
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

            void MovementInform(uint32 type, uint32 point)
            {
                if (type != POINT_MOTION_TYPE)
                    return;

                me->SetTarget(0);
                me->SetFacingTo(5.558f);
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
                events.ScheduleEvent(point == EQUIP_TWO_SWORDS ? EVENT_SWAP_WEAPON1 : EVENT_SWAP_WEAPON2, 1500);
                events.ScheduleEvent(EVENT_RESTORE_COMBAT, 3000);
                events.ScheduleEvent(EVENT_KNEEL, 0);
            }
        };
};

void AddSC_boss_mr_smite()
{
    new boss_mr_smite();
}
