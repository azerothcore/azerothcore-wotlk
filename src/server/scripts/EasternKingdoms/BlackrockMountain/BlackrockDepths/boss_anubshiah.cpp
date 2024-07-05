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
#include "blackrock_depths.h"

enum Spells
{
    SPELL_SHADOWBOLT         = 15472,
    SPELL_CURSE_TONGUES      = 15470,
    SPELL_CURSE_WEAKNESS     = 12493,
    SPELL_DEMON_ARMOR        = 13787,
    SPELL_ENVELOPING_WEB     = 15471
};

enum Timers
{
    TIMER_SHADOWBOLT = 7000,
    TIMER_CURSE_TONGUES = 24000,
    TIMER_CURSE_WEAKNESS = 12000,
    TIMER_DEMON_ARMOR = 3000, // virtually only cast once
    TIMER_ENVELOPING_WEB = 16000
};

class boss_anubshiah : public CreatureScript
{
public:
    boss_anubshiah() : CreatureScript("boss_anubshiah") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_anubshiahAI>(creature);
    }

    struct boss_anubshiahAI : public BossAI
    {
        boss_anubshiahAI(Creature* creature) :  BossAI(creature, DATA_ANUBSHIAH) { }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(SPELL_SHADOWBOLT, 0.2 * (int)TIMER_SHADOWBOLT);
            events.ScheduleEvent(SPELL_CURSE_TONGUES, 0.2 * (int)TIMER_CURSE_TONGUES);
            events.ScheduleEvent(SPELL_CURSE_WEAKNESS, 0.2 * (int)TIMER_CURSE_WEAKNESS);
            events.ScheduleEvent(SPELL_DEMON_ARMOR, 0.2 * (int)TIMER_DEMON_ARMOR);
            events.ScheduleEvent(SPELL_ENVELOPING_WEB, 0.2 * (int)TIMER_ENVELOPING_WEB);
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
            {
                return;
            }
            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }
            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case SPELL_SHADOWBOLT:
                    DoCastVictim(SPELL_SHADOWBOLT);
                    events.ScheduleEvent(SPELL_SHADOWBOLT, urand(TIMER_SHADOWBOLT - 2000, TIMER_SHADOWBOLT + 2000));
                    break;
                case SPELL_CURSE_TONGUES:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                    {
                        DoCast(target, SPELL_CURSE_TONGUES);
                    }
                    events.ScheduleEvent(SPELL_CURSE_TONGUES, urand(TIMER_CURSE_TONGUES - 2000, TIMER_CURSE_TONGUES + 2000));
                    break;
                case SPELL_CURSE_WEAKNESS:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                    {
                        DoCast(target, SPELL_CURSE_WEAKNESS);
                    }
                    events.ScheduleEvent(SPELL_CURSE_WEAKNESS, urand(TIMER_CURSE_WEAKNESS - 2000, TIMER_CURSE_WEAKNESS + 2000));
                    break;
                case SPELL_DEMON_ARMOR:
                    DoCast(me, SPELL_DEMON_ARMOR);
                    events.ScheduleEvent(SPELL_DEMON_ARMOR, TIMER_DEMON_ARMOR);
                    break;
                case SPELL_ENVELOPING_WEB:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                        DoCast(target, SPELL_ENVELOPING_WEB);
                    events.ScheduleEvent(SPELL_ENVELOPING_WEB, urand(TIMER_ENVELOPING_WEB - 2000, TIMER_ENVELOPING_WEB + 2000));
                    break;
                default:
                    break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_anubshiah()
{
    new boss_anubshiah();
}
