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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "culling_of_stratholme.h"

enum Spells
{
    SPELL_CONSTRICTING_CHAINS_N                 = 52696,
    SPELL_CONSTRICTING_CHAINS_H                 = 58823,
    SPELL_DISEASE_EXPULSION_N                   = 52666,
    SPELL_DISEASE_EXPULSION_H                   = 58824,
    SPELL_FRENZY                                = 58841,
};

enum Events
{
    EVENT_SPELL_CONSTRICTING_CHAINS             = 1,
    EVENT_SPELL_DISEASE_EXPULSION               = 2,
    EVENT_SPELL_FRENZY                          = 3,
};

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SLAY                                    = 1,
    SAY_SPAWN                                   = 2,
    SAY_DEATH                                   = 3
};

class boss_meathook : public CreatureScript
{
public:
    boss_meathook() : CreatureScript("boss_meathook") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetCullingOfStratholmeAI<boss_meathookAI>(creature);
    }

    struct boss_meathookAI : public ScriptedAI
    {
        boss_meathookAI(Creature* c) : ScriptedAI(c)
        {
            Talk(SAY_SPAWN);
        }

        EventMap events;
        void Reset() override { events.Reset(); }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            events.RescheduleEvent(EVENT_SPELL_CONSTRICTING_CHAINS, 15000);
            events.RescheduleEvent(EVENT_SPELL_DISEASE_EXPULSION, 4000);
            events.RescheduleEvent(EVENT_SPELL_FRENZY, 20000);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
        }

        void KilledUnit(Unit*  /*victim*/) override
        {
            if (!urand(0, 1))
                return;

            Talk(SAY_SLAY);
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
                case EVENT_SPELL_DISEASE_EXPULSION:
                    me->CastSpell(me, DUNGEON_MODE(SPELL_DISEASE_EXPULSION_N, SPELL_DISEASE_EXPULSION_H), false);
                    events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_FRENZY:
                    me->CastSpell(me, SPELL_FRENZY, false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_CONSTRICTING_CHAINS:
                    if (Unit* pTarget = SelectTarget(SelectTargetMethod::MinThreat, 0, 50.0f, true))
                        me->CastSpell(pTarget, DUNGEON_MODE(SPELL_CONSTRICTING_CHAINS_N, SPELL_CONSTRICTING_CHAINS_H), false);
                    events.RepeatEvent(14000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_meathook()
{
    new boss_meathook();
}
