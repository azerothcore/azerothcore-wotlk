/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ahnkahet.h"


enum Yells
{
    TEXT_AGGRO          = 0,
    TEXT_SACRIFICE_1    = 1,
    TEXT_SACRIFICE_2    = 2,
    TEXT_SLAY           = 3,
    TEXT_DEATH          = 4,
    TEXT_PREACHING      = 5
};

enum Spells
{
    // VISUALS
    SPELL_PINK_SPHERE                       = 56075,
    SPELL_WHITE_SPHERE                      = 56102,
    SPELL_LIGHTNING_BOLTS                   = 56327,
    SPELL_ACTIVATE_INITIATE                 = 56868,
    SPELL_SACRIFICE_VISUAL                  = 56133,

    // FIGHT
    SPELL_GIFT_OF_THE_HERALD                = 56219,
    SPELL_CYCLONE_STRIKE                    = 56855, // Self
    SPELL_CYCLONE_STRIKE_H                  = 60030,
    SPELL_LIGHTNING_BOLT                    = 56891, // 40Y
    SPELL_LIGHTNING_BOLT_H                  = 60032, // 40Y
    SPELL_THUNDERSHOCK                      = 56926, // 30Y
    SPELL_THUNDERSHOCK_H                    = 60029  // 30Y
};

enum Events
{
    EVENT_JEDOGA_CYCLONE                    = 1,
    EVENT_JEDOGA_LIGHTNING_BOLT             = 2,
    EVENT_JEDOGA_THUNDERSHOCK               = 3,
    EVENT_JEDOGA_MOVE_UP                    = 4,
    EVENT_JEDOGA_MOVE_DOWN                  = 5,
};

enum Misc
{
    NPC_JEDOGA_CONTROLLER                   = 30181,
    NPC_INITIATE                            = 30114,

    SUMMON_GROUP_OUT_OF_COMBAT              = 0,
    SUMMON_GROUP_IN_COMBAT                  = 1,

    ACTION_INITIATE_DIED                    = 1,
    ACTION_ACTIVATE                         = 2,
    ACTION_HERALD                           = 3,
    ACTION_SACRIFICE_FAILED                 = 4,

    POINT_DOWN                              = 1,
    POINT_UP                                = 2,
    POINT_UP_START                          = 3,
    POINT_RITUAL                            = 4,
};

const Position JedogaPosition[2] =
{
    {372.330994f, -705.278015f, -2.459692f,  5.628908f},
    {372.330994f, -705.278015f, -16.179716f, 5.628908f}
};

class boss_jedoga_shadowseeker : public CreatureScript
{
public:
    boss_jedoga_shadowseeker() : CreatureScript("boss_jedoga_shadowseeker") { }

    struct boss_jedoga_shadowseekerAI : public ScriptedAI
    {
        boss_jedoga_shadowseekerAI(Creature* c) : ScriptedAI(c), pInstance(c->GetInstanceScript()), summons(me)
        {
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        uint8 initiates;
        uint32 introCheck;
        bool isFlying;
        bool startFly;

        void JustSummoned(Creature *cr) { summons.Summon(cr); }
        void MoveInLineOfSight(Unit *) { }

        void ActivateInitiate()
        {
            if (!summons.size())
                return;

            uint8 rnd = urand(0, summons.size()-1);
            uint8 loop = 0;
            for (std::list<uint64>::iterator i = summons.begin(); i != summons.end();)
            {
                Creature *summon = ObjectAccessor::GetCreature(*me, *i);
                if (summon && summon->GetEntry() == NPC_INITIATE && loop >= rnd)
                {
                    summon->AI()->DoAction(ACTION_ACTIVATE);
                    break;
                }

                ++i;
                ++loop;
            }

            return;
        }

        void ScheduleEvents()
        {
            events.RescheduleEvent(EVENT_JEDOGA_CYCLONE, 3000);
            events.RescheduleEvent(EVENT_JEDOGA_LIGHTNING_BOLT, 7000);
            events.RescheduleEvent(EVENT_JEDOGA_THUNDERSHOCK, 12000);
            events.RescheduleEvent(EVENT_JEDOGA_MOVE_UP, urand(20000, 25000));
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_INITIATE_DIED)
            {
                // all killed
                if (initiates++ > 13)
                {
                    summons.DespawnAll();
                    MoveDown();
                    initiates = 0;
                }
            }
            else if (param == ACTION_HERALD)
            {
                me->CastSpell(me, SPELL_GIFT_OF_THE_HERALD, true);
                events.DelayEvents(1001);
                events.ScheduleEvent(EVENT_JEDOGA_MOVE_DOWN, 1000);
                isFlying = false;
            }
            else if (param == ACTION_SACRIFICE_FAILED)
            {
                events.DelayEvents(1001);
                events.ScheduleEvent(EVENT_JEDOGA_MOVE_DOWN, 1000);
                isFlying = false;
                if (pInstance)
                    pInstance->SetData(DATA_JEDOGA_ACHIEVEMENT, false);
            }
        }

        void Reset()
        {
            if (pInstance)
            {
                pInstance->SetData(DATA_JEDOGA_SHADOWSEEKER_EVENT, NOT_STARTED);
                pInstance->SetData(DATA_JEDOGA_ACHIEVEMENT, true);
            }

            events.Reset();
            me->SummonCreatureGroup(SUMMON_GROUP_OUT_OF_COMBAT);
            initiates = 0;
            introCheck = 1; // leave 1
            isFlying = false;
            startFly = false;

            MoveUp(true);
            me->CastSpell(me, SPELL_PINK_SPHERE, true);
            me->CastSpell(me, SPELL_LIGHTNING_BOLTS, true);
        }

        void EnterCombat(Unit*  /*who*/)
        {
            if (pInstance)
                pInstance->SetData(DATA_JEDOGA_SHADOWSEEKER_EVENT, IN_PROGRESS);

            Talk(TEXT_AGGRO);
        }

        void KilledUnit(Unit* Victim)
        {
            if (!Victim || Victim->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(TEXT_SLAY);
        }

        void JustDied(Unit* /*Killer*/)
        {
            Talk(TEXT_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_JEDOGA_SHADOWSEEKER_EVENT, DONE);

            summons.DespawnAll();
        }

        void MoveDown()
        {
            me->GetMotionMaster()->MoveIdle();
            me->GetMotionMaster()->MovePoint(POINT_DOWN, JedogaPosition[1]);
            isFlying = false;
        }

        void MoveUp(bool start)
        {
            isFlying = true;
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
            me->AttackStop();
            me->GetMotionMaster()->Clear(true);
            me->SetFacingTo(5.66f);
            me->GetMotionMaster()->MovePoint((start ? POINT_UP_START : POINT_UP), JedogaPosition[0]);

            me->SetDisableGravity(true);
        }
        
        void MovementInform(uint32 Type, uint32 PointId)
        {
            if (Type != POINT_MOTION_TYPE) 
                return;

            if (PointId == POINT_DOWN)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                me->RemoveAurasDueToSpell(SPELL_PINK_SPHERE);
                me->RemoveAurasDueToSpell(SPELL_LIGHTNING_BOLTS);

                isFlying = false;
                me->SetInCombatWithZone();
                me->SetDisableGravity(false);
                if (!summons.HasEntry(NPC_INITIATE))
                    me->SummonCreatureGroup(SUMMON_GROUP_IN_COMBAT);

                if (UpdateVictim())
                {
                    me->StopMoving();
                    ScheduleEvents();
                    AttackStart(me->GetVictim());
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                }
            }
            else if (PointId == POINT_UP)
                ActivateInitiate();
            else if (PointId == POINT_RITUAL)
                startFly = true;
        }

        void UpdateAI(uint32 diff)
        {
            // Start text
            if (introCheck)
            {
                introCheck += diff;
                if (introCheck >= 2000)
                {
                    if (SelectTargetFromPlayerList(80.0f))
                    {
                        introCheck = 0;
                        Talk(TEXT_PREACHING);
                    }
                    else
                        introCheck = 1;
                }

                return;
            }

            if (startFly)
            {
                startFly = false;
                MoveUp(false);
            }

            if (isFlying && !SelectTargetFromPlayerList(80.0f))
            {
                EnterEvadeMode();
                return;
            }

            if (!isFlying)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.GetEvent())
                {
                    case EVENT_JEDOGA_CYCLONE:
                    {
                        me->CastSpell(me, IsHeroic() ? SPELL_CYCLONE_STRIKE_H : SPELL_CYCLONE_STRIKE, false);
                        events.RepeatEvent(urand(10000, 14000));
                        break;
                    }
                    case EVENT_JEDOGA_LIGHTNING_BOLT:
                    {
                        if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            me->CastSpell(pTarget, IsHeroic() ? SPELL_LIGHTNING_BOLT_H : SPELL_LIGHTNING_BOLT, false);

                        events.RepeatEvent(urand(11000, 15000));
                        break;
                    }
                    case EVENT_JEDOGA_THUNDERSHOCK:
                    {
                        if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            me->CastSpell(pTarget, IsHeroic() ? SPELL_THUNDERSHOCK_H : SPELL_THUNDERSHOCK, false);

                        events.RepeatEvent(urand(16000, 22000));
                        break;
                    }
                    case EVENT_JEDOGA_MOVE_UP:
                    {
                        events.PopEvent();
                        if (!summons.HasEntry(NPC_INITIATE))
                            break;

                        if (Creature *cr = me->SummonCreature(NPC_JEDOGA_CONTROLLER, 373.48f, -706.00f, -16.18f))
                        {
                            cr->CastSpell(cr, SPELL_SACRIFICE_VISUAL, true);
                            summons.Summon(cr);
                        }

                        Talk(TEXT_SACRIFICE_1);

                        isFlying = true;
                        me->GetMotionMaster()->Clear(true);
                        me->GetMotionMaster()->MovePoint(POINT_RITUAL, JedogaPosition[1]);
                        break;
                    }
                    case EVENT_JEDOGA_MOVE_DOWN:
                    {
                        Talk(TEXT_SACRIFICE_2);
                        summons.DespawnEntry(NPC_JEDOGA_CONTROLLER);
                        MoveDown();
                        events.PopEvent();
                        break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new boss_jedoga_shadowseekerAI(creature);
    }
};

class npc_jedoga_initiand : public CreatureScript
{
public:
    npc_jedoga_initiand() : CreatureScript("npc_jedoga_initiand") { }

    struct npc_jedoga_initiandAI : public ScriptedAI
    {
        npc_jedoga_initiandAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        int32 Timer;

        void AttackStart(Unit* who)
        {
            if (!Timer)
                ScriptedAI::AttackStart(who);
        }

        void MoveInLineOfSight(Unit *who) 
        {
            if (!Timer)
                ScriptedAI::MoveInLineOfSight(who);
        }

        void Reset()
        {
            Timer = 0;

            if (!pInstance)
                return;

            if (pInstance->GetData(DATA_JEDOGA_SHADOWSEEKER_EVENT) != IN_PROGRESS)
            {
                me->SetControlled(false, UNIT_STATE_STUNNED);
                me->RemoveAurasDueToSpell(SPELL_WHITE_SPHERE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
            }
            else
            {
                me->SetOrientation(me->GetAngle(372.6f, -705.12f));
                me->SendMovementFlagUpdate();
                me->CastSpell(me, SPELL_WHITE_SPHERE, false);
                me->SetControlled(true, UNIT_STATE_STUNNED);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE + UNIT_FLAG_NON_ATTACKABLE);
            }
        }

        void JustDied(Unit* Killer)
        {
            if (!pInstance || Killer == me)
                return;

            Creature* boss = me->GetMap()->GetCreature(pInstance->GetData64(DATA_JEDOGA_SHADOWSEEKER));
            if (boss)
            {
                if (Timer)
                    boss->AI()->DoAction(ACTION_SACRIFICE_FAILED);
                else
                    boss->AI()->DoAction(ACTION_INITIATE_DIED);
            }
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_ACTIVATE)
            {
                Timer = 1500;
                me->CastSpell(me, SPELL_ACTIVATE_INITIATE, true);
            }
        }

        void MovementInform(uint32 Type, uint32 PointId)
        {
            if (Type == POINT_MOTION_TYPE && PointId == POINT_RITUAL)
            {
                Unit::Kill(me, me);
                me->DespawnOrUnsummon(5000);
                Creature* boss = me->GetMap()->GetCreature(pInstance->GetData64(DATA_JEDOGA_SHADOWSEEKER));
                if (boss)
                    boss->AI()->DoAction(ACTION_HERALD);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (Timer)
            {
                Timer -= diff;
                if (Timer <= 0)
                {
                    me->CombatStop();
                    me->SetControlled(false, UNIT_STATE_STUNNED);
                    me->RemoveAurasDueToSpell(SPELL_WHITE_SPHERE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                    me->SetWalk(true);

                    float distance = me->GetDistance(JedogaPosition[1]);

                    if (distance < 9.0f)
                        me->SetSpeed(MOVE_WALK, 0.5f, true);
                    else if (distance < 15.0f)
                        me->SetSpeed(MOVE_WALK, 0.75f, true);
                    else if (distance < 20.0f)
                        me->SetSpeed(MOVE_WALK, 1.0f, true);

                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MovePoint(POINT_RITUAL, 373.48f, -706.00f, -16.18f);

                    Timer = 10000000;
                }

                return;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_jedoga_initiandAI(creature);
    }
};

void AddSC_boss_jedoga_shadowseeker()
{
    new boss_jedoga_shadowseeker();
    new npc_jedoga_initiand();
}
