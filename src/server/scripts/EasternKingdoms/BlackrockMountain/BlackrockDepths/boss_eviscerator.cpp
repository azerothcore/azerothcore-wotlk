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
    SPELL_SHADOWBOLT_VOLLEY = 15245,
    SPELL_REND              = 14331,
    SPELL_SHIELD            = 7121
};

constexpr Milliseconds TIMER_SHADOWBOLT_VOLLEY = 7s;
constexpr Milliseconds TIMER_REND = 20s;
constexpr Milliseconds TIMER_SHIELD = 12s;

class boss_eviscerator : public CreatureScript
{
public:
    boss_eviscerator() : CreatureScript("boss_eviscerator") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_evisceratorAI>(creature);
    }

    struct boss_evisceratorAI : public BossAI
    {
        boss_evisceratorAI(Creature* creature) : BossAI(creature, DATA_EVISCERATOR) {}

        bool SpellShieldReady = false;

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(SPELL_SHADOWBOLT_VOLLEY, TIMER_SHADOWBOLT_VOLLEY / 5);
            events.ScheduleEvent(SPELL_REND, TIMER_REND / 5);
            events.ScheduleEvent(SPELL_SHIELD, TIMER_SHIELD / 5);
        }

        void DamageTaken(Unit* /* doneBy */, uint32& /* damage */, DamageEffectType /* damagetype */, SpellSchoolMask damageSchoolMask) override
        {
            if ((damageSchoolMask & SPELL_SCHOOL_MASK_MAGIC) && SpellShieldReady)
            {
                DoCast(SPELL_SHIELD);
                SpellShieldReady = false;
                events.ScheduleEvent(SPELL_SHIELD, TIMER_SHIELD);
            }
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
                case SPELL_SHADOWBOLT_VOLLEY:
                    DoCastVictim(SPELL_SHADOWBOLT_VOLLEY);
                    events.ScheduleEvent(SPELL_SHADOWBOLT_VOLLEY, TIMER_SHADOWBOLT_VOLLEY - 2s, TIMER_SHADOWBOLT_VOLLEY + 2s);
                    break;
                case SPELL_REND:
                    DoCastVictim(SPELL_REND);
                    events.ScheduleEvent(SPELL_REND, TIMER_REND - 2s, TIMER_REND + 2s);
                    break;
                case SPELL_SHIELD:
                    SpellShieldReady = true;
                    break;
                default:
                    break;
                }
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_eviscerator()
{
    new boss_eviscerator();
}
