/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "scholomance.h"
#include "MoveSplineInit.h"
#include "GameObjectAI.h"
#include "Player.h"

enum Spells
{
    SPELL_SWOOP                       = 18144,
    SPELL_WING_FLAP                   = 12882,
    SPELL_PIERCE_ARMOR                = 6016,
    SPELL_DISARM                      = 8379,
    SPELL_KIRTONOS_TRANSFORM          = 16467,
    SPELL_SHADOW_BOLT_VOLLEY          = 17228,
    SPELL_CURSE_OF_TONGUES            = 12889,
    SPELL_DOMINATE_MIND               = 14515
};

enum Events
{
    INTRO_1                           = 1,
    INTRO_2                           = 2,
    INTRO_3                           = 3,
    INTRO_4                           = 4,
    INTRO_5                           = 5,
    INTRO_6                           = 6,
    EVENT_SWOOP                       = 7,
    EVENT_WING_FLAP                   = 8,
    EVENT_PIERCE_ARMOR                = 9,
    EVENT_DISARM                      = 10,
    EVENT_SHADOW_BOLT_VOLLEY          = 11,
    EVENT_CURSE_OF_TONGUES            = 12,
    EVENT_DOMINATE_MIND               = 13,
    EVENT_KIRTONOS_TRANSFORM          = 14
};

enum Misc
{
    WEAPON_KIRTONOS_STAFF             = 11365,
    POINT_KIRTONOS_LAND               = 13,
    KIRTONOS_PATH                     = 105061,
    
    EMOTE_SUMMONED                    = 0
};

Position const PosMove[2] =
{
    { 299.4884f, 92.76137f, 105.6335f, 0.0f },
    { 314.8673f, 90.30210f, 101.6459f, 0.0f }
};

class boss_kirtonos_the_herald : public CreatureScript
{
    public: boss_kirtonos_the_herald() : CreatureScript("boss_kirtonos_the_herald") { }

        struct boss_kirtonos_the_heraldAI : public ScriptedAI
        {
            boss_kirtonos_the_heraldAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = me->GetInstanceScript();
            }

            EventMap events;
            EventMap events2;
            InstanceScript* instance;

            void EnterCombat(Unit* /*who*/)
            {
                events.Reset();
                events.ScheduleEvent(EVENT_SHADOW_BOLT_VOLLEY, 2000);
                events.ScheduleEvent(EVENT_CURSE_OF_TONGUES, 6000);
                events.ScheduleEvent(EVENT_DOMINATE_MIND, 20000);
                events.ScheduleEvent(EVENT_KIRTONOS_TRANSFORM, 5000);
            }

            void JustDied(Unit* /*killer*/)
            {
                if (GameObject* gate = me->GetMap()->GetGameObject(instance->GetData64(GO_GATE_KIRTONOS)))
                    gate->SetGoState(GO_STATE_ACTIVE);

                instance->SetData(DATA_KIRTONOS_THE_HERALD, DONE);
            }

            void EnterEvadeMode()
            {
                if (GameObject* gate = me->GetMap()->GetGameObject(instance->GetData64(GO_GATE_KIRTONOS)))
                    gate->SetGoState(GO_STATE_ACTIVE);

                instance->SetData(DATA_KIRTONOS_THE_HERALD, NOT_STARTED);
                me->DespawnOrUnsummon(1);
            }

            void IsSummonedBy(Unit* /*summoner*/)
            {
                events2.Reset();
                events2.ScheduleEvent(INTRO_1, 500);
                me->SetDisableGravity(true);
                me->SetReactState(REACT_PASSIVE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                Talk(EMOTE_SUMMONED);
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type == WAYPOINT_MOTION_TYPE && id == POINT_KIRTONOS_LAND)
                {
                    events2.ScheduleEvent(INTRO_2, 1500);
                    events2.ScheduleEvent(INTRO_3, 2500);
                    events2.ScheduleEvent(INTRO_4, 5500);
                    events2.ScheduleEvent(INTRO_5, 6500);
                    events2.ScheduleEvent(INTRO_6, 11500);
                }
            }

            void UpdateAI(uint32 diff)
            {
                events2.Update(diff);
                switch (events2.ExecuteEvent())
                {
                    case INTRO_1:
                        me->GetMotionMaster()->MovePath(KIRTONOS_PATH, false);
                        break;
                    case INTRO_2:
                        me->GetMotionMaster()->MovePoint(0, PosMove[0]);
                        break;
                    case INTRO_3:
                        if (GameObject* gate = me->GetMap()->GetGameObject(instance->GetData64(GO_GATE_KIRTONOS)))
                            gate->SetGoState(GO_STATE_READY);
                        me->SetFacingTo(0.01745329f);
                        break;
                    case INTRO_4:
                        me->SetWalk(true);
                        me->SetDisableGravity(false);
                        me->CastSpell(me, SPELL_KIRTONOS_TRANSFORM, true);
                        me->SetCanFly(false);
                        break;
                    case INTRO_5:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                        me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(WEAPON_KIRTONOS_STAFF));
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                        me->SetReactState(REACT_AGGRESSIVE);
                        break;
                    case INTRO_6:
                        me->GetMotionMaster()->MovePoint(0, PosMove[1]);
                        break;
                }

                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_SWOOP:
                        me->CastSpell(me->GetVictim(), SPELL_SWOOP, false);
                        events.ScheduleEvent(EVENT_SWOOP, 15000);
                        break;
                    case EVENT_WING_FLAP:
                        me->CastSpell(me, SPELL_WING_FLAP, false);
                        events.ScheduleEvent(EVENT_WING_FLAP, 13000);
                        break;
                    case EVENT_PIERCE_ARMOR:
                        me->CastSpell(me->GetVictim(), SPELL_PIERCE_ARMOR, false);
                        events.ScheduleEvent(EVENT_PIERCE_ARMOR, 12000);
                        break;
                    case EVENT_DISARM:
                        me->CastSpell(me->GetVictim(), SPELL_DISARM, false);
                        events.ScheduleEvent(EVENT_DISARM, 11000);
                        break;
                    case EVENT_SHADOW_BOLT_VOLLEY:
                        me->CastSpell(me, SPELL_SHADOW_BOLT_VOLLEY, false);
                        events.ScheduleEvent(EVENT_SHADOW_BOLT_VOLLEY, 10000);
                        break;
                    case EVENT_CURSE_OF_TONGUES:
                        me->CastSpell(me, SPELL_CURSE_OF_TONGUES, false);
                        events.ScheduleEvent(EVENT_CURSE_OF_TONGUES, 20000);
                        break;
                    case EVENT_DOMINATE_MIND:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 20.0f, true))
                            me->CastSpell(target, SPELL_DOMINATE_MIND, false);
                        events.ScheduleEvent(EVENT_DOMINATE_MIND, urand(44000, 48000));
                        break;
                    case EVENT_KIRTONOS_TRANSFORM:
                        if (me->HealthBelowPct(50))
                        {
                            events.Reset();
                            events.ScheduleEvent(EVENT_SWOOP, 4000);
                            events.ScheduleEvent(EVENT_WING_FLAP, 7000);
                            events.ScheduleEvent(EVENT_PIERCE_ARMOR, 11000);
                            events.ScheduleEvent(EVENT_DISARM, 15000);
                            me->RemoveAura(SPELL_KIRTONOS_TRANSFORM);
                            me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(0));
                            break;
                        }
                        
                        events.ScheduleEvent(EVENT_KIRTONOS_TRANSFORM, 2000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_kirtonos_the_heraldAI>(creature);
        }
};

void AddSC_boss_kirtonos_the_herald()
{
    new boss_kirtonos_the_herald();
}
