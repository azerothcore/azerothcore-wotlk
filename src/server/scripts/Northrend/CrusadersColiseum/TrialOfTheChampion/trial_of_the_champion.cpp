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

#include "trial_of_the_champion.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

enum Texts
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

class npc_announcer_toc5 : public CreatureScript
{
public:
    npc_announcer_toc5() : CreatureScript("npc_announcer_toc5") {}

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (!creature->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
            return true;

        InstanceScript* pInstance = creature->GetInstanceScript();
        if (!pInstance)
            return true;

        uint32 gossipTextId = 0;
        switch (pInstance->GetData(DATA_INSTANCE_PROGRESS))
        {
            case INSTANCE_PROGRESS_INITIAL:
                if (!player->GetVehicle())
                {
                    if (pInstance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE)
                        gossipTextId = NPC_TEXT_NOT_MOUNTED_H;
                    else
                        gossipTextId = NPC_TEXT_NOT_MOUNTED_A;
                }
                else
                {
                    gossipTextId = NPC_TEXT_CHALLENGE_1;
                    AddGossipItemFor(player, GOSSIP_MENU_STAGE, GOSSIP_START_EVENT_1A, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    AddGossipItemFor(player, GOSSIP_MENU_STAGE, GOSSIP_START_EVENT_1B, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                }
                break;
            case INSTANCE_PROGRESS_CHAMPIONS_DEAD:
                gossipTextId = NPC_TEXT_CHALLENGE_2;
                AddGossipItemFor(player, GOSSIP_MENU_STAGE, GOSSIP_START_EVENT_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                break;
            case INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED:
                gossipTextId = NPC_TEXT_CHALLENGE_3;
                AddGossipItemFor(player, GOSSIP_MENU_STAGE, GOSSIP_START_EVENT_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                break;
            default:
                return true;
        }
        SendGossipMenuFor(player, gossipTextId, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction) override
    {
        if (!creature->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
            return true;

        InstanceScript* pInstance = creature->GetInstanceScript();
        if (!pInstance)
            return true;

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1 || uiAction == GOSSIP_ACTION_INFO_DEF + 2 || uiAction == GOSSIP_ACTION_INFO_DEF + 3 || uiAction == GOSSIP_ACTION_INFO_DEF + 4)
        {
            pInstance->SetData(DATA_ANNOUNCER_GOSSIP_SELECT, (uiAction == GOSSIP_ACTION_INFO_DEF + 2 ? 1 : 0));
            creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        }

        CloseGossipMenuFor(player);
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetTrialOfTheChampionAI<npc_announcer_toc5AI>(creature);
    }

    struct npc_announcer_toc5AI : public CreatureAI
    {
        npc_announcer_toc5AI(Creature* creature) : CreatureAI(creature) {}

        void Reset() override
        {
            InstanceScript* pInstance = me->GetInstanceScript();
            if (!pInstance)
                return;
            if (pInstance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_ALLIANCE )
                me->UpdateEntry(NPC_ARELAS);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); // removed during black knight scene
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth()) // for bk scene so strangulate doesn't kill him
                damage = me->GetHealth() - 1;
        }

        void MovementInform(uint32 type, uint32 /*id*/) override
        {
            if (type != EFFECT_MOTION_TYPE)
                return;
            InstanceScript* pInstance = me->GetInstanceScript();
            if (!pInstance)
                return;
            if (pInstance->GetData(DATA_INSTANCE_PROGRESS) < INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED)
                return;

            me->KillSelf(); // for bk scene, die after knockback
        }

        void UpdateAI(uint32 /*diff*/) override { }
    };
};

void AddSC_trial_of_the_champion()
{
    new npc_announcer_toc5();
}
