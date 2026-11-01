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
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "trial_of_the_champion.h"

enum GossipIds
{
    NPC_TEXT_NOT_MOUNTED_H = 15043,  // Horde text
    NPC_TEXT_NOT_MOUNTED_A = 14757,  // Alliance text

    NPC_TEXT_CHALLENGE_1   = 14688,
    NPC_TEXT_CHALLENGE_2   = 14737,
    NPC_TEXT_CHALLENGE_3   = 14738,

    GOSSIP_MENU_STAGE      = 10614,

    GOSSIP_START_EVENT_1A  = 0,
    GOSSIP_START_EVENT_1B  = 3, // Skip roleplay
    GOSSIP_START_EVENT_2   = 1,
    GOSSIP_START_EVENT_3   = 2,

};

struct npc_announcer_toc5 : public CreatureAI
{
    npc_announcer_toc5(Creature* creature) : CreatureAI(creature), _instance(creature->GetInstanceScript()) { }

    void Reset() override
    {
        if (!_instance)
            return;

        if (_instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_ALLIANCE)
            me->UpdateEntry(NPC_ARELAS);

        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); // removed during the black knight scene
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damagetype*/,
        SpellSchoolMask /*damageSchoolMask*/) override
    {
        if (damage >= me->GetHealth()) // for the bk scene so strangulate doesn't kill him
            damage = me->GetHealth() - 1;
    }

    void MovementInform(uint32 type, uint32 /*id*/) override
    {
        if (type != EFFECT_MOTION_TYPE)
            return;

        if (!_instance)
            return;

        if (_instance->GetData(DATA_INSTANCE_PROGRESS) < INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED)
            return;

        me->KillSelf(); // for the bk scene, die after knockback
    }

    void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
    {
        if (!me->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
            return;

        if (!_instance)
            return;

        if (gossipListId <= GOSSIP_START_EVENT_1B)
        {
            _instance->SetData(DATA_ANNOUNCER_GOSSIP_SELECT, gossipListId == GOSSIP_START_EVENT_1B ? 1 : 0);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        }

        CloseGossipMenuFor(player);
    }

    void UpdateAI(uint32 /*diff*/) override { }

private:
    InstanceScript* _instance;
};

void AddSC_trial_of_the_champion()
{
    RegisterTrialOfTheChampionCreatureAI(npc_announcer_toc5);
}
