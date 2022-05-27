/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_black_morass.h"

enum Enums
{
    SAY_ENTER                   = 0,
    SAY_AGGRO                   = 1,
    SAY_BANISH                  = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4,

    SPELL_HASTEN                = 31458,
    SPELL_MORTAL_WOUND          = 31464,
    SPELL_WING_BUFFET           = 31475,
    SPELL_REFLECT               = 38592,
    SPELL_BANISH_DRAGON_HELPER  = 31550
};

enum Events
{
    EVENT_HASTEN                = 1,
    EVENT_MORTAL_WOUND          = 2,
    EVENT_WING_BUFFET           = 3,
    EVENT_SPELL_REFLECTION      = 4
};

class boss_temporus : public CreatureScript
{
public:
    boss_temporus() : CreatureScript("boss_temporus") { }

    struct boss_temporusAI : public ScriptedAI
    {
        boss_temporusAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

        void OwnTalk(uint32 id)
        {
            if (me->GetEntry() == NPC_TEMPORUS)
                Talk(id);
        }

        void Reset() override
        {
            events.Reset();
        }

        void InitializeAI() override
        {
            OwnTalk(SAY_ENTER);
            ScriptedAI::InitializeAI();
        }

        void EnterCombat(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_HASTEN, 12000);
            events.ScheduleEvent(EVENT_MORTAL_WOUND, 5000);
            events.ScheduleEvent(EVENT_WING_BUFFET, 20000);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_REFLECTION, 28000);

            OwnTalk(SAY_AGGRO);
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
                instance->SetData(TYPE_TEMPORUS, DONE);
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

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_HASTEN:
                    me->CastSpell(me, SPELL_HASTEN, false);
                    events.ScheduleEvent(EVENT_HASTEN, 20000);
                    break;
                case EVENT_MORTAL_WOUND:
                    me->CastSpell(me->GetVictim(), SPELL_MORTAL_WOUND, false);
                    events.ScheduleEvent(EVENT_MORTAL_WOUND, 10000);
                    break;
                case EVENT_WING_BUFFET:
                    me->CastSpell(me, SPELL_WING_BUFFET, false);
                    events.ScheduleEvent(EVENT_WING_BUFFET, 20000);
                    break;
                case EVENT_SPELL_REFLECTION:
                    me->CastSpell(me, SPELL_REFLECT, false);
                    events.ScheduleEvent(EVENT_SPELL_REFLECTION, 30000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetTheBlackMorassAI<boss_temporusAI>(creature);
    }
};

void AddSC_boss_temporus()
{
    new boss_temporus();
}
