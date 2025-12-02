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

constexpr float RANGE_SPELL_HATCH_EGG = 3.0f; // needed because the eggs seem to hatch if the mobs goes too close
constexpr float RANGE_WHELP_CALL_HELP = 15.0f; // range for the hatchers to call nearby whelps after having summoned them.

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
        Position               targetPosition;

        void InitializeAI() override
        {
            CreatureAI::InitializeAI();
            DoZoneInCombat(nullptr, 100.0f);
            nearbyEggs.clear();
            targetEgg = nullptr;
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            events.ScheduleEvent(SPELL_HATCH_EGG, 1s);
        }

        void UpdateAI(uint32 diff) override
        {
            std::list<GameObject*> nearbyEggs;
            float                  tempDist = 20;
            float                  minDist  = 25;
            std::list<Creature*>   nearbyWhelps;

            if (!UpdateVictim())
            {
                return;
            }

            GetCreatureListWithEntryInGrid(nearbyWhelps, me, NPC_ROOKERY_WHELP, RANGE_WHELP_CALL_HELP);
            for (auto const& whelp : nearbyWhelps)
            {
                if (!whelp->IsInCombat())
                {
                    whelp->SetInCombatWith(me->GetVictim());
                    whelp->AI()->AttackStart(me->GetVictim());
                }
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case SPELL_HATCH_EGG:
                        if (!targetEgg) // no target, try to find one
                        {
                            minDist = 50;
                            tempDist = 50;
                            me->GetGameObjectListWithEntryInGrid(nearbyEggs, GO_ROOKERY_EGG, 40);
                            for (auto const& egg : nearbyEggs)
                            {
                                if (egg->isSpawned() && egg->getLootState() == GO_READY)
                                {
                                    tempDist = me->GetDistance2d(egg);
                                    if (tempDist < minDist)
                                    {
                                        minDist   = tempDist;
                                        targetEgg = egg;
                                    }
                                }
                            }
                        }

                        if (targetEgg) //have a target, go to it and cast it
                        {
                            me->GetMotionMaster()->MovePoint(0, targetEgg->GetPosition());
                        }
                        break;
                    default:
                        break;
                }
            }

            // cast takes 1.5second, during which we don't have a target
            if (targetEgg && targetEgg->getLootState() == GO_READY && me->GetDistance2d(targetEgg) < RANGE_SPELL_HATCH_EGG)
            {
                me->StopMovingOnCurrentPos();
                me->SetFacingToObject(targetEgg);
                targetPosition = me->GetPosition();
                DoCast(SPELL_HATCH_EGG);
                targetEgg = nullptr;
                events.ScheduleEvent(SPELL_HATCH_EGG, 6s, 8s);
            }
            else if (!me->HasUnitState(UNIT_STATE_CASTING)  && !targetEgg)
            {
                if (Unit* victim = me->GetVictim())
                {
                    AttackStart(victim);
                }

                if (me->GetDistance2d(me->GetVictim()) > me->GetMeleeReach())
                {
                    me->GetMotionMaster()->MovePoint(0, me->GetVictim()->GetPosition()); // a bit hacky, but needed to start moving once we've summoned an egg
                }
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
            DoZoneInCombat(nullptr, 100.0f);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(SPELL_WAR_STOMP, 17s, 20s);
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
                    events.ScheduleEvent(SPELL_WAR_STOMP, 17s, 20s);
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
            {
                return;
            }
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
