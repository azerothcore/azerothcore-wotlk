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

#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "TaskScheduler.h"

enum Spells
{
    SPELL_SOUL_CORRUPTION           = 25805,
    SPELL_CREATURE_OF_NIGHTMARE     = 25806,
    SPELL_SWELL_OF_SOULS            = 21307,
};

enum Misc
{
    ITEM_FRAGMENT                   = 21149,
    NPC_TWILIGHT_CORRUPTER          = 15625
};

enum Say
{
    SAY_RESPAWN = 0,
    SAY_AGGRO,
    SAY_KILL
};

/*######
# boss_twilight_corrupter
######*/

struct boss_twilight_corrupter : public ScriptedAI
{
    boss_twilight_corrupter(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _scheduler.CancelAll();
        me->RemoveAurasDueToSpell(SPELL_SWELL_OF_SOULS);
    }

    void InitializeAI() override
    {
        // Xinef: check if copy is summoned
        std::list<Creature*> cList;
        me->GetCreatureListWithEntryInGrid(cList, me->GetEntry(), 50.0f);
        for (Creature* creature : cList)
        {
            if (creature->IsAlive() && me->GetGUID() != creature->GetGUID())
            {
                me->DespawnOrUnsummon(1ms);
                break;
            }
        }

        _introSpoken = false;
        ScriptedAI::InitializeAI();
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_introSpoken && who->IsPlayer())
        {
            _introSpoken = true;
            Talk(SAY_RESPAWN, who);
            me->SetFaction(FACTION_MONSTER);
        }
        ScriptedAI::MoveInLineOfSight(who);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        _scheduler
            .Schedule(12s, 18s, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_CREATURE_OF_NIGHTMARE, 0, 100.f, true, false, false);
                context.Repeat(35s, 45s);
            })
            .Schedule(9s, 16s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_SOUL_CORRUPTION);
                context.Repeat(5s, 9s);
            });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_KILL, victim);
            DoCastSelf(SPELL_SWELL_OF_SOULS);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
    }

private:
    bool _introSpoken;
    TaskScheduler _scheduler;
};

/*######
# at_twilight_grove
######*/

class at_twilight_grove : public AreaTriggerScript
{
public:
    at_twilight_grove() : AreaTriggerScript("at_twilight_grove") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (player->HasQuestForItem(ITEM_FRAGMENT) && !player->HasItemCount(ITEM_FRAGMENT))
            player->SummonCreature(NPC_TWILIGHT_CORRUPTER, -10328.16f, -489.57f, 49.95f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 240000);

        return false;
    };
};

void AddSC_duskwood()
{
    RegisterCreatureAI(boss_twilight_corrupter);
    new at_twilight_grove();
}
