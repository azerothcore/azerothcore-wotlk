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

#include "ScriptObject.h"
#include "ScriptedCreature.h"
#include "blackrock_spire.h"

enum Spells
{
    SPELL_REND                      = 16509,
    SPELL_STRIKE                    = 15580,
    SPELL_INTIMIDATING_ROAR         = 16508,
    SPELL_UROK_SPAWN                = 16473,
};

enum Says
{
    SAY_SUMMON                      = 0,
    SAY_AGGRO                       = 1,
};

enum Events
{
    EVENT_REND                      = 1,
    EVENT_STRIKE                    = 2,
    EVENT_INTIMIDATING_ROAR         = 3
};

class boss_urok_doomhowl : public CreatureScript
{
public:
    boss_urok_doomhowl() : CreatureScript("boss_urok_doomhowl") { }

    struct boss_urok_doomhowlAI : public BossAI
    {
        boss_urok_doomhowlAI(Creature* creature) : BossAI(creature, DATA_UROK_DOOMHOWL) {}

        void InitializeAI() override
        {
            me->CastSpell(me, SPELL_UROK_SPAWN, true);
            BossAI::InitializeAI();
            Talk(SAY_SUMMON);
            DoZoneInCombat(nullptr, 100.0f);

            if (GameObject* challenge = instance->instance->GetGameObject(instance->GetGuidData(GO_UROK_CHALLENGE)))
            {
                challenge->Delete();
            }

            if (GameObject* pile = instance->instance->GetGameObject(instance->GetGuidData(GO_UROK_PILE)))
            {
                pile->DespawnOrUnsummon(0ms, Seconds(MONTH));
            }
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(SPELL_REND, urand(17000, 20000));
            events.ScheduleEvent(SPELL_STRIKE, urand(10000, 12000));
            events.ScheduleEvent(SPELL_INTIMIDATING_ROAR, urand(25000, 30000));
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case SPELL_REND:
                        DoCastVictim(SPELL_REND);
                        events.ScheduleEvent(SPELL_REND, urand(8000, 10000));
                        break;
                    case SPELL_STRIKE:
                        DoCastVictim(SPELL_STRIKE);
                        events.ScheduleEvent(SPELL_STRIKE, urand(8000, 10000));
                        break;
                    case SPELL_INTIMIDATING_ROAR:
                        DoCastVictim(SPELL_INTIMIDATING_ROAR);
                        events.ScheduleEvent(SPELL_INTIMIDATING_ROAR, urand(40000, 45000));
                        break;
                    default:
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockSpireAI<boss_urok_doomhowlAI>(creature);
    }
};

void AddSC_boss_urok_doomhowl()
{
    new boss_urok_doomhowl();
}
