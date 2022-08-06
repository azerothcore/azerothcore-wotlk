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

#include "Player.h"
#include "ScriptObject.h"
#include "ScriptedCreature.h"
#include "mana_tombs.h"

enum Texts
{
    SAY_AGGRO           = 0,
    SAY_KILL            = 1,
    SAY_DEATH           = 2,
    EMOTE_DARK_SHELL    = 3
};

enum Spells
{
    SPELL_VOID_BLAST = 32325,
    SPELL_DARK_SHELL = 32358
};

enum Events
{
    EVENT_VOID_BLAST = 1,
    EVENT_DARK_SHELL
};

class boss_pandemonius : public CreatureScript
{
public:
    boss_pandemonius() : CreatureScript("boss_pandemonius") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetManaTombsAI<boss_pandemoniusAI>(creature);
    }

    struct boss_pandemoniusAI : public ScriptedAI
    {
        boss_pandemoniusAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

        void Reset() override
        {
            events.Reset();
            VoidBlastCounter = 0;
        }

        void EnterCombat(Unit*) override
        {
            me->SetInCombatWithZone();

            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_DARK_SHELL, 20000);
            events.ScheduleEvent(EVENT_VOID_BLAST, urand(8000, 23000));
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_KILL);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
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
                case EVENT_VOID_BLAST:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                    {
                        DoCast(target, SPELL_VOID_BLAST);
                        ++VoidBlastCounter;
                    }

                    if (VoidBlastCounter == 5)
                    {
                        VoidBlastCounter = 0;
                        events.RescheduleEvent(EVENT_VOID_BLAST, urand(15000, 25000));
                    }
                    else
                    {
                        events.RescheduleEvent(EVENT_VOID_BLAST, 500);
                        events.DelayEvents(EVENT_DARK_SHELL, 500);
                    }
                    break;
                case EVENT_DARK_SHELL:
                    if (me->IsNonMeleeSpellCast(false))
                    {
                        me->InterruptNonMeleeSpells(true);
                    }

                    Talk(EMOTE_DARK_SHELL);
                    DoCast(me, SPELL_DARK_SHELL);
                    events.RescheduleEvent(EVENT_DARK_SHELL, 20000);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        uint32 VoidBlastCounter;
    };
};

void AddSC_boss_pandemonius()
{
    new boss_pandemonius();
}
