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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_depths.h"

enum Spells
{
    SPELL_SHADOWBOLT_VOLLEY = 15245,
    SPELL_REND              = 14331,
    SPELL_SHIELD            = 7121
};

enum Timers
{
    TIMER_SHADOWBOLT_VOLLEY = 7000,
    TIMER_REND              = 20000,
    TIMER_SHIELD            = 12000
};

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

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(SPELL_SHADOWBOLT_VOLLEY, 0.2 * (int)TIMER_SHADOWBOLT_VOLLEY);
            events.ScheduleEvent(SPELL_REND, 0.2 * (int) TIMER_REND);
            events.ScheduleEvent(SPELL_SHIELD, 0.2 * (int) TIMER_SHIELD);
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
                    events.ScheduleEvent(SPELL_SHADOWBOLT_VOLLEY, urand(TIMER_SHADOWBOLT_VOLLEY - 2000, TIMER_SHADOWBOLT_VOLLEY + 2000));
                    break;
                case SPELL_REND:
                    DoCastVictim(SPELL_REND);
                    events.ScheduleEvent(SPELL_REND, urand(TIMER_REND - 2000, TIMER_REND + 2000));
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
