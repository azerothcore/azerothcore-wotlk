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

enum Spells
{
    SPELL_SHADOWBOLT         = 15472,
    SPELL_CURSE_TONGUES      = 15470,
    SPELL_CURSE_WEAKNESS     = 12493,
    SPELL_DEMON_ARMOR        = 13787,
    SPELL_ENVELOPING_WEB     = 15471
};

constexpr Milliseconds TIMER_SHADOWBOLT = 7s;
constexpr Milliseconds TIMER_CURSE_TONGUES = 24s;
constexpr Milliseconds TIMER_CURSE_WEAKNESS = 12s;
constexpr Milliseconds TIMER_DEMON_ARMOR = 3s; //virtually only cast once
constexpr Milliseconds TIMER_ENVELOPING_WEB = 16s;

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
            events.ScheduleEvent(SPELL_SHADOWBOLT, TIMER_SHADOWBOLT / 5);
            events.ScheduleEvent(SPELL_CURSE_TONGUES, TIMER_CURSE_TONGUES / 5);
            events.ScheduleEvent(SPELL_CURSE_WEAKNESS, TIMER_CURSE_WEAKNESS / 5);
            events.ScheduleEvent(SPELL_DEMON_ARMOR, TIMER_DEMON_ARMOR / 5);
            events.ScheduleEvent(SPELL_ENVELOPING_WEB, TIMER_ENVELOPING_WEB / 5);
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
                    events.ScheduleEvent(SPELL_SHADOWBOLT, TIMER_SHADOWBOLT - 2s, TIMER_SHADOWBOLT + 2s);
                    break;
                case SPELL_CURSE_TONGUES:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                    {
                        DoCast(target, SPELL_CURSE_TONGUES);
                    }
                    events.ScheduleEvent(SPELL_CURSE_TONGUES, TIMER_CURSE_TONGUES - 2s, TIMER_CURSE_TONGUES + 2s);
                    break;
                case SPELL_CURSE_WEAKNESS:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                    {
                        DoCast(target, SPELL_CURSE_WEAKNESS);
                    }
                    events.ScheduleEvent(SPELL_CURSE_WEAKNESS, TIMER_CURSE_WEAKNESS - 2s, TIMER_CURSE_WEAKNESS + 2s);
                    break;
                case SPELL_DEMON_ARMOR:
                    DoCast(me, SPELL_DEMON_ARMOR);
                    events.ScheduleEvent(SPELL_DEMON_ARMOR, TIMER_DEMON_ARMOR);
                    break;
                case SPELL_ENVELOPING_WEB:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                        DoCast(target, SPELL_ENVELOPING_WEB);
                    events.ScheduleEvent(SPELL_ENVELOPING_WEB, TIMER_ENVELOPING_WEB - 2s, TIMER_ENVELOPING_WEB + 2s);
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
