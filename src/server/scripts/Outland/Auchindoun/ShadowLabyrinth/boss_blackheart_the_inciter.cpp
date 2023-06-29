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
#include "shadow_labyrinth.h"

enum BlackheartTheInciter
{
    SPELL_INCITE_CHAOS      = 33676,
    SPELL_INCITE_CHAOS_B    = 33684,    //debuff applied to each member of party
    SPELL_CHARGE            = 33709,
    SPELL_WAR_STOMP         = 33707,
    SPELL_LAUGHTER          = 33722,

    SAY_INTRO               = 0,
    SAY_AGGRO               = 1,
    SAY_SLAY                = 2,
    SAY_HELP                = 3,
    SAY_DEATH               = 4,

    EVENT_SPELL_INCITE      = 1,
    EVENT_INCITE_WAIT       = 2,
    EVENT_SPELL_CHARGE      = 3,
    EVENT_SPELL_KNOCKBACK   = 4,
    EVENT_SPELL_WAR_STOMP   = 5,

    NPC_INCITE_TRIGGER   = 19300
};

struct boss_blackheart_the_inciter : public BossAI
{
    boss_blackheart_the_inciter(Creature* creature) : BossAI(creature, DATA_BLACKHEARTTHEINCITEREVENT) { }

    bool InciteChaos;

    void Reset() override
    {
        _Reset();
        me->SetImmuneToPC(false);
        InciteChaos = false;
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer() && urand(0, 1))
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        _JustDied();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        me->CallForHelp(100.0f);
        events.ScheduleEvent(EVENT_SPELL_INCITE, 24000);
        events.ScheduleEvent(EVENT_INCITE_WAIT, 15000);
        events.ScheduleEvent(EVENT_SPELL_CHARGE, urand(30000, 50000));
        events.ScheduleEvent(EVENT_SPELL_WAR_STOMP, urand(16950, 26350));
        _JustEngagedWith();
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (InciteChaos && SelectTargetFromPlayerList(100.0f))
            return;

        CreatureAI::EnterEvadeMode(why);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim() && !InciteChaos)
        {
            return;
        }

        events.Update(diff);
        switch (events.ExecuteEvent())
        {
        case EVENT_INCITE_WAIT:
            me->SetImmuneToPC(false);
            InciteChaos = false;
            break;
        case EVENT_SPELL_INCITE:
        {
            DoCastAOE(SPELL_INCITE_CHAOS);
            DoCastSelf(SPELL_LAUGHTER, true);

            uint32 inciteTriggerID = NPC_INCITE_TRIGGER;
            std::list<HostileReference*> t_list = me->GetThreatMgr().GetThreatList();
            for (std::list<HostileReference*>::const_iterator itr = t_list.begin(); itr != t_list.end(); ++itr)
            {
                Unit* target = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid());

                if (target && target->IsPlayer())
                {
                    if (Creature* inciteTrigger = me->SummonCreature(inciteTriggerID++, *target, TEMPSUMMON_TIMED_DESPAWN, 15 * IN_MILLISECONDS))
                    {
                        inciteTrigger->CastSpell(target, SPELL_INCITE_CHAOS_B, true);
                    }
                }
            }

            DoResetThreatList();
            me->SetImmuneToPC(true);
            InciteChaos = true;
            events.DelayEvents(15000);
            events.RepeatEvent(urand(50000, 70000));
            events.ScheduleEvent(EVENT_INCITE_WAIT, 15000);
            break;
        }
        case EVENT_SPELL_CHARGE:
            DoCastRandomTarget(SPELL_CHARGE);
            events.RepeatEvent(urand(30000, 50000));
            break;
        case EVENT_SPELL_WAR_STOMP:
            DoCastAOE(SPELL_WAR_STOMP);
            events.RepeatEvent(urand(16950, 26350));
            break;
        }

        if (InciteChaos)
            return;

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_blackheart_the_inciter()
{
    RegisterShadowLabyrinthCreatureAI(boss_blackheart_the_inciter);
}
