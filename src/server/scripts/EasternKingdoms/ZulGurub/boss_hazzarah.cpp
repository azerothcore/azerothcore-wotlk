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

/* ScriptData
SDName: Boss_Hazzarah
SD%Complete: 100
SDComment:
SDCategory: Zul'Gurub
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_SLEEP                             = 24664,
    SPELL_EARTH_SHOCK                       = 24685,
    SPELL_CHAIN_BURN                        = 24684,
    SPELL_SUMMON_NIGHTMARE_ILLUSION_LEFT    = 24681,
    SPELL_SUMMON_NIGHTMARE_ILLUSION_BACK    = 24728,
    SPELL_SUMMON_NIGHTMARE_ILLUSION_RIGHT   = 24729
};

enum Events
{
    EVENT_SLEEP                             = 1,
    EVENT_EARTH_SHOCK                       = 2,
    EVENT_CHAIN_BURN                        = 3,
    EVENT_ILLUSIONS                         = 4
};

class boss_hazzarah : public CreatureScript
{
public:
    boss_hazzarah() : CreatureScript("boss_hazzarah") { }

    struct boss_hazzarahAI : public BossAI
    {
        boss_hazzarahAI(Creature* creature) : BossAI(creature, DATA_EDGE_OF_MADNESS) { }

        void JustSummoned(Creature* summon) override
        {
            BossAI::JustSummoned(summon);
            DoZoneInCombat(summon);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_SLEEP, 12s, 15s);
            events.ScheduleEvent(EVENT_EARTH_SHOCK, 8s, 18s);
            events.ScheduleEvent(EVENT_CHAIN_BURN, 12s, 28s);
            events.ScheduleEvent(EVENT_ILLUSIONS, 16s, 24s);
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
                    case EVENT_SLEEP:
                        DoCastVictim(SPELL_SLEEP, true);
                        events.ScheduleEvent(EVENT_SLEEP, 24s, 32s);
                        break;
                    case EVENT_EARTH_SHOCK:
                        DoCastVictim(SPELL_EARTH_SHOCK);
                        events.ScheduleEvent(EVENT_EARTH_SHOCK, 8s, 18s);
                        break;
                    case EVENT_CHAIN_BURN:
                        DoCastVictim(SPELL_CHAIN_BURN);
                        events.ScheduleEvent(EVENT_CHAIN_BURN, 12s, 28s);
                        break;
                    case EVENT_ILLUSIONS:
                        DoCastSelf(SPELL_SUMMON_NIGHTMARE_ILLUSION_LEFT, true);
                        DoCastSelf(SPELL_SUMMON_NIGHTMARE_ILLUSION_BACK, true);
                        DoCastSelf(SPELL_SUMMON_NIGHTMARE_ILLUSION_RIGHT, true);
                        events.ScheduleEvent(EVENT_ILLUSIONS, 16s, 24s);
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
        return GetZulGurubAI<boss_hazzarahAI>(creature);
    }
};

void AddSC_boss_hazzarah()
{
    new boss_hazzarah();
}
