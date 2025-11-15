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
#include "violet_hold.h"

enum eSpells
{
    SPELL_CAUTERIZING_FLAMES                  = 59466,
    SPELL_FIREBOLT                            = 54235,
    SPELL_FLAME_BREATH                        = 54282,
    SPELL_LAVA_BURN                           = 54249
};

enum eEvents
{
    EVENT_SPELL_FIREBOLT = 1,
    EVENT_SPELL_FLAME_BREATH,
    EVENT_SPELL_LAVA_BURN,
    EVENT_SPELL_CAUTERIZING_FLAMES,
};

class boss_lavanthor : public CreatureScript
{
public:
    boss_lavanthor() : CreatureScript("boss_lavanthor") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetVioletHoldAI<boss_lavanthorAI>(pCreature);
    }

    struct boss_lavanthorAI : public ScriptedAI
    {
        boss_lavanthorAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_FIREBOLT, 1s);
            events.RescheduleEvent(EVENT_SPELL_FLAME_BREATH, 5s);
            events.RescheduleEvent(EVENT_SPELL_LAVA_BURN, 10s);
            if (IsHeroic())
                events.RescheduleEvent(EVENT_SPELL_CAUTERIZING_FLAMES, 3s);
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
                case 0:
                    break;
                case EVENT_SPELL_FIREBOLT:
                    me->CastSpell(me->GetVictim(), SPELL_FIREBOLT, false);
                    events.Repeat(5s, 13s);
                    break;
                case EVENT_SPELL_FLAME_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_FLAME_BREATH, false);
                    events.Repeat(10s, 15s);
                    break;
                case EVENT_SPELL_LAVA_BURN:
                    me->CastSpell(me->GetVictim(), SPELL_LAVA_BURN, false);
                    events.Repeat(14s, 20s);
                    break;
                case EVENT_SPELL_CAUTERIZING_FLAMES:
                    me->CastSpell((Unit*)nullptr, SPELL_FLAME_BREATH, false);
                    events.Repeat(10s, 16s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (pInstance)
                pInstance->SetData(DATA_BOSS_DIED, 0);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void EnterEvadeMode(EvadeReason why) override
        {
            ScriptedAI::EnterEvadeMode(why);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);

            if (pInstance)
                pInstance->SetData(DATA_FAILED, 1);
        }
    };
};

void AddSC_boss_lavanthor()
{
    new boss_lavanthor();
}
