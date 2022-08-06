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
#include "old_hillsbrad.h"

enum EpochHunter
{
    SAY_AGGRO                   = 3,
    SAY_SLAY                    = 4,
    SAY_BREATH                  = 5,
    SAY_DEATH                   = 6,

    SPELL_SAND_BREATH           = 31914,
    SPELL_IMPENDING_DEATH       = 31916,
    SPELL_MAGIC_DISRUPTION_AURA = 33834,
    SPELL_WING_BUFFET           = 31475,

    EVENT_SPELL_SAND_BREATH     = 1,
    EVENT_SPELL_IMPENDING_DEATH = 2,
    EVENT_SPELL_DISRUPTION      = 3,
    EVENT_SPELL_WING_BUFFET     = 4
};

class boss_epoch_hunter : public CreatureScript
{
public:
    boss_epoch_hunter() : CreatureScript("boss_epoch_hunter") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetOldHillsbradAI<boss_epoch_hunterAI>(creature);
    }

    struct boss_epoch_hunterAI : public ScriptedAI
    {
        boss_epoch_hunterAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

        void Reset() override
        {
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_SPELL_SAND_BREATH, 8000);
            events.ScheduleEvent(EVENT_SPELL_IMPENDING_DEATH, 2000);
            events.ScheduleEvent(EVENT_SPELL_DISRUPTION, 20000);
            events.ScheduleEvent(EVENT_SPELL_WING_BUFFET, 14000);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void JustDied(Unit* killer) override
        {
            if (killer && killer == me)
                return;
            Talk(SAY_DEATH);
            me->GetInstanceScript()->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_EPOCH_KILLED);
            if (Creature* taretha = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(DATA_TARETHA_GUID)))
                taretha->AI()->DoAction(me->GetEntry());
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_SAND_BREATH:
                    if (roll_chance_i(50))
                        Talk(SAY_BREATH);
                    me->CastSpell(me->GetVictim(), SPELL_SAND_BREATH, false);
                    events.ScheduleEvent(EVENT_SPELL_SAND_BREATH, 20000);
                    break;
                case EVENT_SPELL_IMPENDING_DEATH:
                    me->CastSpell(me->GetVictim(), SPELL_IMPENDING_DEATH, false);
                    events.ScheduleEvent(EVENT_SPELL_IMPENDING_DEATH, 30000);
                    break;
                case EVENT_SPELL_WING_BUFFET:
                    me->CastSpell(me, SPELL_WING_BUFFET, false);
                    events.ScheduleEvent(EVENT_SPELL_WING_BUFFET, 30000);
                    break;
                case EVENT_SPELL_DISRUPTION:
                    me->CastSpell(me, SPELL_MAGIC_DISRUPTION_AURA, false);
                    events.ScheduleEvent(EVENT_SPELL_DISRUPTION, 30000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_epoch_hunter()
{
    new boss_epoch_hunter();
}
