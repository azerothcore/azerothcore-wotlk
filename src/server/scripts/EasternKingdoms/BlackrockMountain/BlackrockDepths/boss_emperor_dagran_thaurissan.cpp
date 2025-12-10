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
#include "blackrock_depths.h"

enum Yells
{
    YELL_SENATORS_ALIVE = 0,
    YELL_SENATORS_DEAD  = 1,
    SAY_SLAY            = 2
};

enum Spells
{
    SPELL_HANDOFTHAURISSAN      = 17492,
    SPELL_AVATAROFFLAME         = 15636
};

#define DATA_PERCENT_DEAD_SENATORS 0

class boss_emperor_dagran_thaurissan : public CreatureScript
{
public:
    boss_emperor_dagran_thaurissan() : CreatureScript("boss_emperor_dagran_thaurissan") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_draganthaurissanAI>(creature);
    }

    struct boss_draganthaurissanAI : public BossAI
    {
        uint32 hasYelled       = 0;
        uint32 SenatorYells[5] = {3, 4, 5, 6, 7}; // IDs in creature_text database

        boss_draganthaurissanAI(Creature* creature) : BossAI(creature, DATA_EMPEROR){}

        void JustEngagedWith(Unit* /*who*/) override
        {
            if (hasYelled != 5)
            {
                Talk(YELL_SENATORS_ALIVE);
            }
            else
            {
                Talk(YELL_SENATORS_DEAD);
            }

            me->CallForHelp(VISIBLE_RANGE);
            events.ScheduleEvent(SPELL_HANDOFTHAURISSAN, 4s, 7s);
            events.ScheduleEvent(SPELL_AVATAROFFLAME, 10s, 12s);
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            Talk(SAY_SLAY);
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == DATA_PERCENT_DEAD_SENATORS)
            {
                if (data >= 20 * (hasYelled + 1)) // map the 5 yells to %. Yell after 20,40,60,80,100%
                {
                    if (hasYelled < 5)
                    {
                        if (me->IsAlive())
                        {
                            Talk(SenatorYells[hasYelled]);
                        }
                    }
                    hasYelled++;
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Creature* Moira = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_MOIRA)))
            {
                Moira->AI()->EnterEvadeMode();
                Moira->AI()->Talk(0);
                Moira->SetFaction(FACTION_FRIENDLY);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case SPELL_HANDOFTHAURISSAN:
                    DoCast(SelectTarget(SelectTargetMethod::Random), SPELL_HANDOFTHAURISSAN);
                    //DoCastVictim(SPELL_HANDOFTHAURISSAN);
                    events.ScheduleEvent(SPELL_HANDOFTHAURISSAN, 4s, 7s);
                    break;
                case SPELL_AVATAROFFLAME:
                    DoCastSelf(SPELL_AVATAROFFLAME);
                    events.ScheduleEvent(SPELL_AVATAROFFLAME, 23s, 27s);
                    break;
                default:
                    break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_draganthaurissan()
{
    new boss_emperor_dagran_thaurissan();
}
