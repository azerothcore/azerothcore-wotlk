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
#include "the_black_morass.h"

enum Enums
{
    SAY_ENTER                   = 0,
    SAY_AGGRO                   = 1,
    SAY_BANISH                  = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4,

    SPELL_ARCANE_BLAST          = 31457,
    SPELL_ARCANE_DISCHARGE      = 31472,
    SPELL_TIME_LAPSE            = 31467,
    SPELL_ATTRACTION            = 38540,

    SPELL_BANISH_DRAGON_HELPER  = 31550,
};

enum Events
{
    EVENT_ARCANE_BLAST          = 1,
    EVENT_TIME_LAPSE            = 2,
    EVENT_ARCANE_DISCHARGE      = 3,
    EVENT_ATTRACTION            = 4
};

class boss_chrono_lord_deja : public CreatureScript
{
public:
    boss_chrono_lord_deja() : CreatureScript("boss_chrono_lord_deja") { }

    struct boss_chrono_lord_dejaAI : public ScriptedAI
    {
        boss_chrono_lord_dejaAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

        void Reset() override
        {
            events.Reset();
        }

        void OwnTalk(uint32 id)
        {
            if (me->GetEntry() == NPC_CHRONO_LORD_DEJA)
                Talk(id);
        }

        void InitializeAI() override
        {
            OwnTalk(SAY_ENTER);
            ScriptedAI::InitializeAI();
        }

        void EnterCombat(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_ARCANE_BLAST, 10000);
            events.ScheduleEvent(EVENT_TIME_LAPSE, 15000);
            events.ScheduleEvent(EVENT_ARCANE_DISCHARGE, 25000);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_ATTRACTION, 20000);

            OwnTalk(SAY_AGGRO);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_UNIT && who->GetEntry() == NPC_TIME_KEEPER)
            {
                if (me->IsWithinDistInMap(who, 20.0f))
                {
                    OwnTalk(SAY_BANISH);
                    me->CastSpell(me, SPELL_BANISH_DRAGON_HELPER, true);
                    return;
                }
            }

            ScriptedAI::MoveInLineOfSight(who);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                OwnTalk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/) override
        {
            OwnTalk(SAY_DEATH);
            if (InstanceScript* instance = me->GetInstanceScript())
                instance->SetData(TYPE_CHRONO_LORD_DEJA, DONE);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_ARCANE_BLAST:
                    me->CastSpell(me->GetVictim(), SPELL_ARCANE_BLAST, false);
                    events.ScheduleEvent(EVENT_ARCANE_BLAST, 20000);
                    break;
                case EVENT_TIME_LAPSE:
                    me->CastSpell(me, SPELL_TIME_LAPSE, false);
                    events.ScheduleEvent(EVENT_TIME_LAPSE, 20000);
                    break;
                case EVENT_ARCANE_DISCHARGE:
                    me->CastSpell(me, SPELL_ARCANE_DISCHARGE, false);
                    events.ScheduleEvent(EVENT_ARCANE_DISCHARGE, 25000);
                    break;
                case EVENT_ATTRACTION:
                    me->CastSpell(me, SPELL_ATTRACTION, false);
                    events.ScheduleEvent(EVENT_ATTRACTION, 30000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetTheBlackMorassAI<boss_chrono_lord_dejaAI>(creature);
    }
};

void AddSC_boss_chrono_lord_deja()
{
    new boss_chrono_lord_deja();
}
