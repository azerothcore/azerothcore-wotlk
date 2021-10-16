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
SDName: Boss_Lucifron
SD%Complete: 100
SDComment:
SDCategory: Molten Core
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Spells
{
    SPELL_IMPENDING_DOOM    = 19702,
    SPELL_LUCIFRON_CURSE    = 19703,
    SPELL_SHADOW_SHOCK      = 20603,
};

enum Events
{
    EVENT_IMPENDING_DOOM    = 1,
    EVENT_LUCIFRON_CURSE    = 2,
    EVENT_SHADOW_SHOCK      = 3,
};

class boss_lucifron : public CreatureScript
{
public:
    boss_lucifron() : CreatureScript("boss_lucifron") { }

    struct boss_lucifronAI : public BossAI
    {
        boss_lucifronAI(Creature* creature) : BossAI(creature, BOSS_LUCIFRON)
        {
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_IMPENDING_DOOM, urand(6000, 11000));
            events.ScheduleEvent(EVENT_LUCIFRON_CURSE, urand(11000, 14000));
            events.ScheduleEvent(EVENT_SHADOW_SHOCK, 5000);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_IMPENDING_DOOM:
                    {
                        DoCastVictim(SPELL_IMPENDING_DOOM);
                        events.RepeatEvent(20000);
                        break;
                    }
                    case EVENT_LUCIFRON_CURSE:
                    {
                        DoCastVictim(SPELL_LUCIFRON_CURSE);
                        events.RepeatEvent(20000);
                        break;
                    }
                    case EVENT_SHADOW_SHOCK:
                    {
                        DoCastVictim(SPELL_SHADOW_SHOCK);
                        events.RepeatEvent(5000);
                        break;
                    }
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_lucifronAI>(creature);
    }
};

void AddSC_boss_lucifron()
{
    new boss_lucifron();
}
