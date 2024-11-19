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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "shadow_labyrinth.h"

enum Text
{
    SAY_INTRO               = 0,
    SAY_AGGRO               = 1,
    SAY_SLAY                = 2,
    SAY_HELP                = 3,
    SAY_DEATH               = 4
};

enum Spells
{
    SPELL_INCITE_CHAOS      = 33676,
    SPELL_INCITE_CHAOS_B    = 33684, // debuff applied to each player
    SPELL_CHARGE            = 33709,
    SPELL_WAR_STOMP         = 33707,
    SPELL_LAUGHTER          = 33722
};

enum Npc
{
    NPC_INCITE_TRIGGER      = 19300
};

struct boss_blackheart_the_inciter : public BossAI
{
    boss_blackheart_the_inciter(Creature* creature) : BossAI(creature, DATA_BLACKHEARTTHEINCITEREVENT)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

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
        _JustEngagedWith();
        me->CallForHelp(100.0f);
        scheduler.Schedule(24s, [this](TaskContext context)
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
            scheduler.DelayAll(15s);
            context.Repeat(50s, 70s);
            scheduler.Schedule(15s, [this](TaskContext /*context*/)
            {
                me->SetImmuneToPC(false);
                InciteChaos = false;
            });
        }).Schedule(15s, [this](TaskContext /*context*/)
        {
            me->SetImmuneToPC(false);
            InciteChaos = false;
        }).Schedule(30s, 50s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_CHARGE);
            context.Repeat(30s, 50s);
        }).Schedule(16950ms, 26350ms, [this](TaskContext context)
        {
            DoCastAOE(SPELL_WAR_STOMP);
            context.Repeat(16950ms, 26350ms);
        });
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
            return;

        scheduler.Update(diff);
        if (InciteChaos)
            return;

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_blackheart_the_inciter()
{
    RegisterShadowLabyrinthCreatureAI(boss_blackheart_the_inciter);
}
