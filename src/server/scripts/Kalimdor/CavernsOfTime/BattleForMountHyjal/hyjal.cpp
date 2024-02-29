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
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "hyjal.h"

enum Spells
{
    // Jaina
    SPELL_MASS_TELEPORT     = 16807,
    SPELL_BRILLIANCE_AURA   = 31260,
    SPELL_BLIZZARD          = 31266,
    SPELL_PYROBLAST         = 31263,
    SPELL_SUMMON_ELEMENTALS = 31264,

    // Thrall spells
    SPELL_CHAIN_LIGHTNING   = 31330,
    SPELL_FERAL_SPIRIT      = 31331,

    // Tyrande spells
    SPELL_STARFALL          = 20687,
    SPELL_TRUESHOT_AURA     = 31519
};

enum Talk
{
    SAY_ATTACKED = 0,
    SAY_BEGIN    = 1,
    SAY_INCOMING = 2,
    SAY_RALLY    = 3,
    SAY_FAILURE  = 4,
    SAY_SUCCESS  = 5,
    SAY_DEATH    = 6
};

class npc_lady_jaina_proudmoore : public CreatureScript
{
public:
    npc_lady_jaina_proudmoore() : CreatureScript("npc_lady_jaina_proudmoore") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new hyjalJainaAI(creature);
    }
    struct hyjalJainaAI : public ScriptedAI
    {
        hyjalJainaAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            scheduler.CancelAll();
            if (InstanceScript* hyjal = me->GetInstanceScript())
                if (!hyjal->GetData(DATA_WAVE_STATUS))
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_ATTACKED);

            scheduler.Schedule(15s, 35s, [this](TaskContext context)
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        DoCast(target, SPELL_BLIZZARD);
                    context.Repeat();
                }).Schedule(2s, 9s, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_PYROBLAST);
                        context.Repeat();
                    }).Schedule(15s, 45s, [this](TaskContext context)
                        {
                            DoCastSelf(SPELL_SUMMON_ELEMENTALS);
                            context.Repeat();
                        });
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (InstanceScript* hyjal = me->GetInstanceScript())
                hyjal->SetData(DATA_RESET_ALLIANCE, 0);
        }

        void PathEndReached(uint32 /*pathId*/) override
        {
            DoCastSelf(SPELL_MASS_TELEPORT);
            if (InstanceScript* hyjal = me->GetInstanceScript())
                hyjal->SetData(DATA_ALLIANCE_RETREAT, 0);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            scheduler.Update(diff);
        }
    };

    bool OnGossipSelect(Player* /*player*/ , Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

        if (InstanceScript* hyjal = creature->GetInstanceScript())
        {
            if (hyjal->GetBossState(DATA_WINTERCHILL) != DONE || hyjal->GetBossState(DATA_ANETHERON) != DONE)
            {
                hyjal->SetData(DATA_RESET_WAVES, 0);
                hyjal->SetData(DATA_SPAWN_WAVES, 0);
            }
            else
            {
                creature->Say(SAY_SUCCESS);
                creature->GetMotionMaster()->MovePath(JAINA_RETREAT_PATH, false);
            }
        }
        return true;
    }

};


void AddSC_hyjal()
{
    new npc_lady_jaina_proudmoore();
}
