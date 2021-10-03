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
    SPELL_WAR_STOMP              = 16727
};

enum Timer
{
    TIMER_WAR_STOMP = 20000
};

enum Says
{
    SAY_SUMMON = 0,
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
}
