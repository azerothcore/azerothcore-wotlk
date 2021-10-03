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

        void InitializeAI() override
        {
            CreatureAI::InitializeAI();
            if (Unit* target = me->SelectNearestTarget(500))
            {
                me->AI()->AttackStart(target);
            }
        }

        void EnterCombat(Unit* /*who*/) override
        {
            events.ScheduleEvent(SPELL_HATCH_EGG, 1000);
        }

        void UpdateAI(uint32 diff) override
        {
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
                    if (GameObject* egg = me->FindNearestGameObjectOfType(GAMEOBJECT_TYPE_TRAP, 60))
                    {
                        me->GetMotionMaster()->MovePoint(0, egg->GetPosition());
                        if (me->GetDistance2d(egg) < 5)
                        {
                            me->StopMovingOnCurrentPos();
                            DoCast(SPELL_HATCH_EGG);
                            events.ScheduleEvent(SPELL_HATCH_EGG, urand(6000, 8000));
                        }
                    }
                    break;
                default:
                    break;
                }
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                me->StopMovingOnCurrentPos();
            }
            else
            {
                if (me->GetDistance2d(me->GetVictim()) > 10.0)
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
