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

struct boss_servant_quarters : public BossAI
{
    boss_servant_quarters(Creature* creature) : BossAI(creature, DATA_SERVANT_QUARTERS) { }

    void Reset() override
    {
        events.Reset();
        me->SetVisible(false);
        me->SetReactState(REACT_PASSIVE);
        me->SetFaction(FACTION_FRIENDLY);
        _events2.Reset();
        _events2.ScheduleEvent(EVENT_CHECK_VISIBILITY, 5s);

        if (me->GetEntry() == NPC_HYAKISS_THE_LURKER)
        {
            DoCastSelf(SPELL_SNEAK, true);
        }

        if (instance->GetData(DATA_SELECTED_RARE) != me->GetEntry())
            me->DespawnOrUnsummon(1);
    }

    void JustEngagedWith(Unit*  /*who*/) override
    {
        me->setActive(true);
        if (me->GetEntry() == NPC_HYAKISS_THE_LURKER)
        {
            events.ScheduleEvent(EVENT_SPELL_ACIDIC_FANG, 5s);
            events.ScheduleEvent(EVENT_SPELL_HYAKISS_WEB, 9s);
        }
        else if (me->GetEntry() == NPC_SHADIKITH_THE_GLIDER)
        {
            events.ScheduleEvent(EVENT_SPELL_SONIC_BURST, 4s);
            events.ScheduleEvent(EVENT_SPELL_WING_BUFFET, 7s);
            events.ScheduleEvent(EVENT_SPELL_DIVE, 10s);
        }
        else // if (me->GetEntry() == NPC_ROKAD_THE_RAVAGER)
        {
            events.ScheduleEvent(EVENT_SPELL_RAVAGE, 3s);
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
                    _events2.ScheduleEvent(EVENT_CHECK_VISIBILITY, 5s);
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
                events.Repeat(12s, 18s);
                break;
            case EVENT_SPELL_HYAKISS_WEB:
                DoCastRandomTarget(SPELL_HYAKISS_WEB, 0, 30.0f);
                events.Repeat(15s);
                break;
            case EVENT_SPELL_SONIC_BURST:
                DoCastSelf(SPELL_SONIC_BURST);
                events.Repeat(12s, 18s);
                break;
            case EVENT_SPELL_WING_BUFFET:
                DoCastSelf(SPELL_WING_BUFFET);
                events.Repeat(12s, 18s);
                break;
            case EVENT_SPELL_DIVE:
                if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, FarthestTargetSelector(me, 40.0f, false, true)))
                    me->CastSpell(target, SPELL_DIVE, false);
                events.Repeat(20s);
                break;
            case EVENT_SPELL_FEAR:
                DoCastVictim(SPELL_FEAR);
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

void AddSC_boss_servant_quarters()
{
    RegisterKarazhanCreatureAI(boss_servant_quarters);
}
