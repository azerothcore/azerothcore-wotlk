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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_spire.h"

enum Spells
{
    SPELL_WAR_STOMP = 16727,
    SPELL_HATCH_EGG = 15746
};

enum Timer
{
    TIMER_WAR_STOMP = 20000
};

enum Says
{
    SAY_SUMMON = 0,
};

class npc_rookery_hatcher : public CreatureScript
{
public:
    npc_rookery_hatcher() : CreatureScript("npc_rookery_hatcher") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockSpireAI<npc_rookery_hatcherAI>(creature);
    }

    struct npc_rookery_hatcherAI : public CreatureAI
    {
        npc_rookery_hatcherAI(Creature* creature) : CreatureAI(creature) {}

        EventMap events;
        std::list<GameObject*> nearbyEggs;
        GameObject*            targetEgg;

        void InitializeAI() override
        {
            CreatureAI::InitializeAI();
            if (Unit* target = me->SelectNearestTarget(500))
            {
                me->AI()->AttackStart(target);
            }
            nearbyEggs.clear();
            targetEgg = nullptr;
        }

        void EnterCombat(Unit* /*who*/) override
        {
            events.ScheduleEvent(SPELL_HATCH_EGG, 100);
        }

        void UpdateAI(uint32 diff) override
        {
            std::list<GameObject*> nearbyEggs;
            float                  tempDist = 20;
            float                  minDist  = 25;
            
        //    GameObject*            nearestEgg = nullptr;

            if (!UpdateVictim())
            {
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
            events.Update(diff);
            me->CallForHelp(10); // else the whelp doesn't come... This is tedious, maybe use spell db and override the hatch?

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case SPELL_HATCH_EGG:
                    if (!targetEgg) // no target, try to find one
                    {
                        LOG_FATAL("Entities:unit", "Looking for an egg");
                        me->GetGameObjectListWithEntryInGrid(nearbyEggs, DB_ENTRY_ROOKERY_EGG, 20);
                        LOG_FATAL("Entities:unit", "found %d eggs", nearbyEggs.size());
                        for (const auto& egg : nearbyEggs)
                        {
                            if (egg->GetGoState() == GO_STATE_READY)
                            {
                                LOG_FATAL("Entities:unit", "found an egg ready");
                                tempDist = me->GetDistance2d(egg);
                                if (tempDist < minDist)
                                {
                                    LOG_FATAL("Entities:unit", "It's in range");
                                    minDist   = tempDist;
                                    targetEgg = egg;
                                }
                            }
                            else
                                LOG_FATAL("Entities:unit", "found an unready egg");
                        }
                    }
                     
                   // if (nearestEgg)
                    //if (GameObject* egg = me->FindNearestGameObjectOfType(GAMEOBJECT_TYPE_TRAP, 60))
                    if (targetEgg) //have a target, go to it and cast it
                    {
                        me->GetMotionMaster()->MovePoint(0, targetEgg->GetPosition());
                        if (me->GetDistance2d(targetEgg) < 5)
                        {
                            me->StopMovingOnCurrentPos();
                            DoCast(SPELL_HATCH_EGG);
                    //        targetEgg->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
                            targetEgg = nullptr;
                            events.ScheduleEvent(SPELL_HATCH_EGG, urand(6000, 8000));
                        }
                    }
                    break;
                default:
                    break;
                }
            }

            // cast takes 1.5second, during which we don't have a target
            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                me->StopMovingOnCurrentPos();
            }
            else if (!targetEgg)
            {
                me->AI()->AttackStart(me->GetVictim());
                if (me->GetDistance2d(me->GetVictim()) > 1.0)
                    me->GetMotionMaster()->MovePoint(0, me->GetVictim()->GetPosition()); // a bit hacky, but needed to start moving once we've summoned an egg
            }
            DoMeleeAttackIfReady();
        }
    };
};

class boss_solakar_flamewreath : public CreatureScript
{
public:
    boss_solakar_flamewreath() : CreatureScript("boss_solakar_flamewreath") { }

    struct boss_solakar_flamewreathAI : public BossAI
    {
        boss_solakar_flamewreathAI(Creature* creature) : BossAI(creature, DATA_SOLAKAR_FLAMEWREATH) {}

        uint32 resetTimer;

        void Reset() override
        {
            _Reset();
            resetTimer = 10000;
        }

        void InitializeAI() override
        {
            BossAI::InitializeAI();
            Talk(SAY_SUMMON);
            if (Unit* target = me->SelectNearestTarget(500))
            {
                me->AI()->AttackStart(target);
            }
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(SPELL_WAR_STOMP, urand(17000, 20000));
            resetTimer = 0;
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            instance->SetData(DATA_SOLAKAR_FLAMEWREATH, DONE);
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
            case SPELL_WAR_STOMP:
                DoCastVictim(SPELL_WAR_STOMP);
                events.ScheduleEvent(SPELL_WAR_STOMP, urand(17000, 20000));
                break;

            default:
                break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                resetTimer -= diff;
                if (resetTimer < diff)
                {
                    instance->SetData(DATA_SOLAKAR_FLAMEWREATH, FAIL);
                }
                return;
            }
            resetTimer = 10000;
            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                ExecuteEvent(eventId);
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockSpireAI<boss_solakar_flamewreathAI>(creature);
    }
};

void AddSC_boss_solakar_flamewreath()
{
    new boss_solakar_flamewreath();
    new npc_rookery_hatcher();
}
