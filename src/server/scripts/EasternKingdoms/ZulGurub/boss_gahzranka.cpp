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
SDName: Boss_Gahz'ranka
SD%Complete: 85
SDComment: Massive Geyser with knockback not working. Spell buggy.
SDCategory: Zul'Gurub
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_FROSTBREATH               = 16099,
    SPELL_MASSIVEGEYSER             = 22421, // Not working. (summon)
    SPELL_SLAM                      = 24326,
    SPELL_THRASH                    = 3391
};

enum Events
{
    EVENT_FROSTBREATH               = 1,
    EVENT_MASSIVEGEYSER             = 2,
    EVENT_SLAM                      = 3,
    EVENT_THRASH                    = 4
};

class boss_gahzranka : public CreatureScript
{
public:
    boss_gahzranka() : CreatureScript("boss_gahzranka") { }

    struct boss_gahzrankaAI : public BossAI
    {
        boss_gahzrankaAI(Creature* creature) : BossAI(creature, DATA_GAHZRANKA) { }

        void Reset() override
        {
            _Reset();
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_FROSTBREATH, 10000);
            events.ScheduleEvent(EVENT_MASSIVEGEYSER, 15000);
            events.ScheduleEvent(EVENT_SLAM, 17000);
            events.ScheduleEvent(EVENT_THRASH, urand(10000, 20000));
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
                    case EVENT_FROSTBREATH:
                        DoCastVictim(SPELL_FROSTBREATH);
                        events.ScheduleEvent(EVENT_FROSTBREATH, urand(10000, 22000));
                        break;
                    case EVENT_MASSIVEGEYSER:
                        DoCastVictim(SPELL_MASSIVEGEYSER);
                        events.ScheduleEvent(EVENT_MASSIVEGEYSER, urand(12000, 22000));
                        break;
                    case EVENT_SLAM:
                        DoCastVictim(SPELL_SLAM, true);
                        events.ScheduleEvent(EVENT_SLAM, urand(12000, 20000));
                        break;
                    case EVENT_THRASH:
                        DoCastSelf(SPELL_THRASH);
                        events.ScheduleEvent(EVENT_THRASH, urand(10000, 20000));
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
        return GetZulGurubAI<boss_gahzrankaAI>(creature);
    }
};

void AddSC_boss_gahzranka()
{
    new boss_gahzranka();
}
