/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
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

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_eckAI>(creature);
        }

        struct boss_eckAI : public BossAI
        {
            boss_eckAI(Creature* creature) : BossAI(creature, DATA_ECK_THE_FEROCIOUS)
            {
            }

            void InitializeAI()
            {
                BossAI::InitializeAI();
                me->GetMotionMaster()->MovePoint(POINT_START, 1638.55f, 919.76f, 104.95f, false);
                me->SetHomePosition(1642.712f, 934.646f, 107.205f, 0.767f);
                me->SetReactState(REACT_PASSIVE);
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type == POINT_MOTION_TYPE && id == POINT_START)
                {
                    me->CastSpell(me, SPELL_ECK_SPRING_INIT, true);
                    me->SetReactState(REACT_AGGRESSIVE);
                }
            }

            void Reset()
            {
                BossAI::Reset();
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                events.ScheduleEvent(EVENT_ECK_BERSERK, urand(60000, 90000));
                events.ScheduleEvent(EVENT_ECK_BITE, 5000);
                events.ScheduleEvent(EVENT_ECK_SPIT, 10000);
                events.ScheduleEvent(EVENT_ECK_SPRING, 8000);
            }

            void JustDied(Unit* killer)
            {
                BossAI::JustDied(killer);
            }

            void UpdateAI(uint32 diff)
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
                        events.ScheduleEvent(EVENT_ECK_HEALTH, 1000);
                        break;
                    case EVENT_ECK_BERSERK:
                        me->CastSpell(me, SPELL_ECK_BERSERK, false);
                        events.CancelEvent(EVENT_ECK_HEALTH);
                        break;
                    case EVENT_ECK_BITE:
                        me->CastSpell(me->GetVictim(), SPELL_ECK_BITE, false);
                        events.ScheduleEvent(EVENT_ECK_BITE, urand(8000, 12000));
                        break;
                    case EVENT_ECK_SPIT:
                        me->CastSpell(me->GetVictim(), SPELL_ECK_SPIT, false);
                        events.ScheduleEvent(EVENT_ECK_SPIT, 10000);
                        break;
                    case EVENT_ECK_SPRING:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 30.0f, true))
                        {
                            me->getThreatManager().resetAllAggro();
                            me->AddThreat(target, 500.0f);
                            me->CastSpell(target, SPELL_ECK_SPRING, false);
                        }

                        events.ScheduleEvent(EVENT_ECK_SPRING, urand(5000, 10000));
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
