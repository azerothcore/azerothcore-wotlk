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
#include "oculus.h"

enum Spells
{
    SPELL_MAGIC_PULL                    = 51336,
    SPELL_THUNDERING_STOMP              = 50774,

    SPELL_UNSTABLE_SPHERE_PASSIVE       = 50756,
    SPELL_UNSTABLE_SPHERE_PULSE         = 50757,
    SPELL_UNSTABLE_SPHERE_TIMER         = 50758,
    SPELL_TELEPORT_VISUAL               = 52096,
};

enum DrakosNPCs
{
    NPC_UNSTABLE_SPHERE     = 28166,
};

enum Events
{
    EVENT_MAGIC_PULL                    = 1,
    EVENT_THUNDERING_STOMP              = 2,
    EVENT_SUMMON                        = 3,
    EVENT_SUMMON_x4                     = 4,
};

enum Yells
{
    SAY_AGGRO                                     = 0,
    SAY_KILL                                      = 1,
    SAY_DEATH                                     = 2,
    SAY_PULL                                      = 3,
    SAY_STOMP                                     = 4
};

class boss_drakos : public CreatureScript
{
public:
    boss_drakos() : CreatureScript("boss_drakos") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetOculusAI<boss_drakosAI>(pCreature);
    }

    struct boss_drakosAI : public ScriptedAI
    {
        boss_drakosAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset() override
        {
            if (pInstance)
                pInstance->SetData(DATA_DRAKOS, NOT_STARTED);

            events.Reset();
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            Talk(SAY_AGGRO);

            if (pInstance)
                pInstance->SetData(DATA_DRAKOS, IN_PROGRESS);

            me->SetInCombatWithZone();

            events.RescheduleEvent(EVENT_MAGIC_PULL, 10s, 15s);
            events.RescheduleEvent(EVENT_THUNDERING_STOMP, 3s, 6s);
            events.RescheduleEvent(EVENT_SUMMON, 2s);
        }

        void JustDied(Unit*  /*killer*/) override
        {
            Talk(SAY_DEATH);

            if (pInstance)
            {
                pInstance->SetData(DATA_DRAKOS, DONE);
                for( uint8 i = 0; i < 3; ++i )
                    if (ObjectGuid guid = pInstance->GetGuidData(DATA_DCD_1 + i))
                        if (GameObject* pGo = ObjectAccessor::GetGameObject(*me, guid))
                            if (pGo->GetGoState() != GO_STATE_ACTIVE )
                            {
                                pGo->SetLootState(GO_READY);
                                pGo->UseDoorOrButton(0, false);
                            }
            }
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            Talk(SAY_KILL);
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}
        void JustSummoned(Creature*  /*summon*/) override {}

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            DoMeleeAttackIfReady();

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_MAGIC_PULL:
                    {
                        Talk(SAY_PULL);
                        //me->TextEmote(TEXT_MAGIC_PULL, nullptr, true);

                        me->CastSpell(me, SPELL_MAGIC_PULL, false);
                        events.Repeat(15s, 25s);
                        events.ScheduleEvent(EVENT_SUMMON_x4, 1500ms);
                    }
                    break;
                case EVENT_THUNDERING_STOMP:
                    {
                        Talk(SAY_STOMP);

                        me->CastSpell(me, SPELL_THUNDERING_STOMP, false);
                        events.Repeat(10s, 20s);
                    }
                    break;
                case EVENT_SUMMON:
                    {
                        for( uint8 i = 0; i < 2; ++i )
                        {
                            float angle = rand_norm() * 2 * M_PI;
                            me->SummonCreature(NPC_UNSTABLE_SPHERE, me->GetPositionX() + 5.0f * cos(angle), me->GetPositionY() + 5.0f * std::sin(angle), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 18000);
                        }
                        events.Repeat(2s);
                    }
                    break;
                case EVENT_SUMMON_x4:
                    for( uint8 i = 0; i < 4; ++i )
                    {
                        float angle = rand_norm() * 2 * M_PI;
                        me->SummonCreature(NPC_UNSTABLE_SPHERE, me->GetPositionX() + 5.0f * cos(angle), me->GetPositionY() + 5.0f * std::sin(angle), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 18000);
                    }

                    break;
            }
        }
    };
};

class npc_oculus_unstable_sphere : public CreatureScript
{
public:
    npc_oculus_unstable_sphere() : CreatureScript("npc_oculus_unstable_sphere") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetOculusAI<npc_oculus_unstable_sphereAI>(pCreature);
    }

    struct npc_oculus_unstable_sphereAI : public ScriptedAI
    {
        npc_oculus_unstable_sphereAI(Creature* c) : ScriptedAI(c) {}

        uint32 timer;
        bool located, gonext;

        void PickNewLocation()
        {
            float dist = rand_norm() * 40.0f;
            float angle = rand_norm() * 2 * M_PI;
            me->GetMotionMaster()->MovePoint(1, 961.29f + dist * cos(angle), 1049.0f + dist * std::sin(angle), 360.0f);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE || id != 1)
                return;

            if (!located)
                gonext = true;
        }

        void Reset() override
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetSpeed(MOVE_RUN, 1.4f, true);
            me->CastSpell(me, SPELL_UNSTABLE_SPHERE_PASSIVE, true);
            me->CastSpell(me, SPELL_UNSTABLE_SPHERE_TIMER, true);
            timer = 0;
            located = false;
            gonext = false;

            PickNewLocation();
        }

        void AttackStart(Unit*  /*who*/) override {}
        void MoveInLineOfSight(Unit*  /*who*/) override {}

        void UpdateAI(uint32 diff) override
        {
            if (timer == 0)
                me->CastSpell(me, SPELL_TELEPORT_VISUAL, true);

            timer += diff;

            if (timer > 10000)
            {
                if (!located)
                    me->GetMotionMaster()->MoveIdle();
                located = true;
                me->CastSpell(me, SPELL_UNSTABLE_SPHERE_PULSE, true);
                timer -= 2000;
            }

            if (!located && gonext)
            {
                PickNewLocation();
                gonext = false;
            }
        }
    };
};

void AddSC_boss_drakos()
{
    new boss_drakos();
    new npc_oculus_unstable_sphere();
}
