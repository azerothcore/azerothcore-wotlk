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
#include "arcatraz.h"

enum Say
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_SHADOW_NOVA                 = 2,
    SAY_DEATH                       = 3
};

enum Spells
{
    SPELL_VOID_ZONE                 = 36119,
    SPELL_SHADOW_NOVA               = 36127,
    SPELL_SEED_OF_CORRUPTION        = 36123
};

enum Events
{
    EVENT_VOID_ZONE                 = 1,
    EVENT_SHADOW_NOVA               = 2,
    EVENT_SEED_OF_CORRUPTION        = 3
};

class boss_zereketh_the_unbound : public CreatureScript
{
public:
    boss_zereketh_the_unbound() : CreatureScript("boss_zereketh_the_unbound") { }

    struct boss_zereketh_the_unboundAI : public BossAI
    {
        boss_zereketh_the_unboundAI(Creature* creature) : BossAI(creature, DATA_ZEREKETH) { }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_DEATH);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_VOID_ZONE, 6000);
            events.ScheduleEvent(EVENT_SHADOW_NOVA, 10000);
            events.ScheduleEvent(EVENT_SEED_OF_CORRUPTION, 16000);
            Talk(SAY_AGGRO);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
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
                case EVENT_VOID_ZONE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 60.0f, true))
                        me->CastSpell(target, SPELL_VOID_ZONE, false);
                    events.ScheduleEvent(EVENT_VOID_ZONE, 15000);
                    break;
                case EVENT_SHADOW_NOVA:
                    me->CastSpell(me, SPELL_SHADOW_NOVA, false);
                    if (roll_chance_i(50))
                        Talk(SAY_SHADOW_NOVA);
                    events.ScheduleEvent(EVENT_SHADOW_NOVA, 12000);
                    break;
                case EVENT_SEED_OF_CORRUPTION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true))
                        me->CastSpell(target, SPELL_SEED_OF_CORRUPTION, false);
                    events.ScheduleEvent(EVENT_SEED_OF_CORRUPTION, 16000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetArcatrazAI<boss_zereketh_the_unboundAI>(creature);
    }
};

void AddSC_boss_zereketh_the_unbound()
{
    new boss_zereketh_the_unbound();
}
