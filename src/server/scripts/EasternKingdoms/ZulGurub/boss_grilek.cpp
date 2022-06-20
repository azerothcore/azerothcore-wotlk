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
SDName: Boss_Grilek
SD%Complete: 100
SDComment:
SDCategory: Zul'Gurub
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_AVATAR                    = 24646, // Enrage Spell
    SPELL_GROUND_TREMOR             = 6524,
    SPELL_ENTANGLING_ROOTS          = 24648
};

enum Events
{
    EVENT_AVATAR                    = 1,
    EVENT_GROUND_TREMOR             = 2,
    EVENT_START_PURSUIT             = 3,
    EVENT_ENTANGLING_ROOTS          = 4
};

class boss_grilek : public CreatureScript // grilek
{
public:
    boss_grilek() : CreatureScript("boss_grilek") { }

    struct boss_grilekAI : public BossAI
    {
        boss_grilekAI(Creature* creature) : BossAI(creature, DATA_EDGE_OF_MADNESS)
        {
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_AVATAR, 20s, 30s);
            events.ScheduleEvent(EVENT_GROUND_TREMOR, 15s, 25s);
            events.ScheduleEvent(EVENT_ENTANGLING_ROOTS, 5s, 15s);
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
                    case EVENT_AVATAR:
                        DoCast(me, SPELL_AVATAR);
                        ResetThreatList();
                        me->SetReactState(REACT_PASSIVE);
                        events.ScheduleEvent(EVENT_START_PURSUIT, 2s);
                        events.ScheduleEvent(EVENT_AVATAR, 45s, 50s);
                        break;
                    case EVENT_GROUND_TREMOR:
                        DoCastVictim(SPELL_GROUND_TREMOR, true);
                        events.ScheduleEvent(EVENT_GROUND_TREMOR, 12s, 16s);
                        break;
                    case EVENT_START_PURSUIT:
                        me->SetReactState(REACT_AGGRESSIVE);
                        break;
                    case EVENT_ENTANGLING_ROOTS:
                        DoCastVictim(SPELL_ENTANGLING_ROOTS);
                        events.ScheduleEvent(EVENT_ENTANGLING_ROOTS, 10s, 20s);
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
        return GetZulGurubAI<boss_grilekAI>(creature);
    }
};

void AddSC_boss_grilek()
{
    new boss_grilek();
}
