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
#include "karazhan.h"

enum ServantQuartersSpells
{
    SPELL_SNEAK                 = 22766,
    SPELL_ACIDIC_FANG           = 29901,
    SPELL_HYAKISS_WEB           = 29896,

    SPELL_DIVE                  = 29903,
    SPELL_SONIC_BURST           = 29904,
    SPELL_WING_BUFFET           = 29905,
    SPELL_FEAR                  = 29321,

    SPELL_RAVAGE                = 29906
};

enum ServantQuertersMisc
{
    EVENT_SPELL_ACIDIC_FANG     = 1,
    EVENT_SPELL_HYAKISS_WEB     = 2,

    EVENT_SPELL_DIVE            = 10,
    EVENT_SPELL_SONIC_BURST     = 11,
    EVENT_SPELL_WING_BUFFET     = 12,
    EVENT_SPELL_FEAR            = 13,

    EVENT_SPELL_RAVAGE          = 20,

    EVENT_CHECK_VISIBILITY      = 30
};

class boss_servant_quarters : public CreatureScript
{
public:
    boss_servant_quarters() : CreatureScript("boss_servant_quarters") { }

    struct boss_servant_quartersAI : public BossAI
    {
        boss_servant_quartersAI(Creature* creature) : BossAI(creature, DATA_SERVANT_QUARTERS) { }

        void Reset() override
        {
            events.Reset();
            me->SetVisible(false);
            me->SetReactState(REACT_PASSIVE);
            me->SetFaction(FACTION_FRIENDLY);
            _events2.Reset();
            _events2.ScheduleEvent(EVENT_CHECK_VISIBILITY, 5000);
            if (me->GetEntry() == NPC_HYAKISS_THE_LURKER)
                me->CastSpell(me, SPELL_SNEAK, true);

            if (instance->GetData(DATA_SELECTED_RARE) != me->GetEntry())
                me->DespawnOrUnsummon(1);
        }

        void EnterCombat(Unit*  /*who*/) override
        {
            me->setActive(true);
            if (me->GetEntry() == NPC_HYAKISS_THE_LURKER)
            {
                events.ScheduleEvent(EVENT_SPELL_ACIDIC_FANG, 5000);
                events.ScheduleEvent(EVENT_SPELL_HYAKISS_WEB, 9000);
            }
            else if (me->GetEntry() == NPC_SHADIKITH_THE_GLIDER)
            {
                events.ScheduleEvent(EVENT_SPELL_SONIC_BURST, 4000);
                events.ScheduleEvent(EVENT_SPELL_WING_BUFFET, 7000);
                events.ScheduleEvent(EVENT_SPELL_DIVE, 10000);
            }
            else // if (me->GetEntry() == NPC_ROKAD_THE_RAVAGER)
            {
                events.ScheduleEvent(EVENT_SPELL_RAVAGE, 3000);
            }
        }

        void JustDied(Unit* /*who*/) override
        {
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            if (type == POINT_MOTION_TYPE && point == EVENT_CHARGE)
                events.ScheduleEvent(EVENT_SPELL_FEAR, 0);
        }

        void UpdateAI(uint32 diff) override
        {
            _events2.Update(diff);
            switch (_events2.ExecuteEvent())
            {
                case EVENT_CHECK_VISIBILITY:
                    if (instance->GetBossState(DATA_SERVANT_QUARTERS) == DONE)
                    {
                        me->SetVisible(true);
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->RestoreFaction();
                    }
                    else
                        _events2.ScheduleEvent(EVENT_CHECK_VISIBILITY, 5000);
                    break;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_ACIDIC_FANG:
                    me->CastSpell(me->GetVictim(), SPELL_ACIDIC_FANG, false);
                    events.ScheduleEvent(EVENT_SPELL_ACIDIC_FANG, urand(12000, 18000));
                    break;
                case EVENT_SPELL_HYAKISS_WEB:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f))
                        me->CastSpell(target, SPELL_HYAKISS_WEB, false);
                    events.ScheduleEvent(EVENT_SPELL_HYAKISS_WEB, 15000);
                    break;
                case EVENT_SPELL_SONIC_BURST:
                    me->CastSpell(me, SPELL_SONIC_BURST, false);
                    events.ScheduleEvent(EVENT_SPELL_SONIC_BURST, urand(12000, 18000));
                    break;
                case EVENT_SPELL_WING_BUFFET:
                    me->CastSpell(me, SPELL_WING_BUFFET, false);
                    events.ScheduleEvent(EVENT_SPELL_WING_BUFFET, urand(12000, 18000));
                    break;
                case EVENT_SPELL_DIVE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, FarthestTargetSelector(me, 40.0f, false, true)))
                        me->CastSpell(target, SPELL_DIVE, false);
                    events.ScheduleEvent(EVENT_SPELL_DIVE, 20000);
                    break;
                case EVENT_SPELL_FEAR:
                    me->CastSpell(me->GetVictim(), SPELL_FEAR, false);
                    break;
                case EVENT_SPELL_RAVAGE:
                    me->CastSpell(me->GetVictim(), SPELL_RAVAGE, false);
                    events.ScheduleEvent(EVENT_SPELL_RAVAGE, 10500);
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events2;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetKarazhanAI<boss_servant_quartersAI>(creature);
    }
};

void AddSC_boss_servant_quarters()
{
    new boss_servant_quarters();
}
