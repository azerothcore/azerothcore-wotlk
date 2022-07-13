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

#include "trial_of_the_crusader.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

enum BarrettRamseyGossip
{
    CHALLENGE_BEASTS = 10599,
    CHALLENGE_BEASTS_CONFIRM = 10600,
    CHALLENGE_JARAXXUS = 10609,
    CHALLENGE_JARAXXUS_CONFIRM = 10610,
    CHALLENGE_FACTION_CHAMPIONS = 10678,
    CHALLENGE_FACTION_CHAMPIONS_CONFIRM = 10687,
    CHALLENGE_VALKYR = 10679,
    CHALLENGE_VALKYR_CONFIRM = 10688,
    CHALLENGE_ANUBARAK = 10692,
    CHALLENGE_ANUBARAK_CONFIRM = 10693
};

void getGossip(Player* player, Creature* creature, uint32 gossipMenuID, uint32 gossipMenuItemID, uint32 sender, uint32 action)
{
    AddGossipItemFor(player, gossipMenuID, gossipMenuItemID, sender, action);
    SendGossipMenuFor(player, player->GetGossipTextId(gossipMenuID, creature), creature->GetGUID());
}

class npc_announcer_toc10 : public CreatureScript
{
public:
    npc_announcer_toc10() : CreatureScript("npc_announcer_toc10") {}

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        ClearGossipMenuFor(player);

        if (!creature->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
        {
            return true;
        }

        InstanceScript* pInstance = creature->GetInstanceScript();
        if (!pInstance)
        {
            return true;
        }

        gossipMenuID = 0;

        switch (pInstance->GetData(TYPE_INSTANCE_PROGRESS))
        {

            case INSTANCE_PROGRESS_INITIAL:
            case INSTANCE_PROGRESS_INTRO_DONE:
                {
                    gossipMenuID = player->GetTeamId() == TEAM_ALLIANCE ? 0 : 1;
                    getGossip(player, creature, CHALLENGE_BEASTS, gossipMenuID, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                }
                break;
            case INSTANCE_PROGRESS_BEASTS_DEAD:
                {
                    getGossip(player, creature, CHALLENGE_JARAXXUS, gossipMenuID, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                }
                break;
            case INSTANCE_PROGRESS_JARAXXUS_DEAD:
                {
                    gossipMenuID = player->GetTeamId() == TEAM_ALLIANCE ? 0 : 1;
                    getGossip(player, creature, CHALLENGE_FACTION_CHAMPIONS, gossipMenuID, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                }
                break;
            case INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD:
                {
                    gossipMenuID = player->GetTeamId() == TEAM_ALLIANCE ? 0 : 1;
                    getGossip(player, creature, CHALLENGE_VALKYR, gossipMenuID, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                }
                break;
            case INSTANCE_PROGRESS_VALKYR_DEAD:
                {
                    getGossip(player, creature, CHALLENGE_ANUBARAK, gossipMenuID, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                }
                break;
            case INSTANCE_PROGRESS_DONE:
                return true;
                break;
            default:
                return true;
                break;
        }
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);

        if ( !creature->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
            return true;

        InstanceScript* pInstance = creature->GetInstanceScript();
        if ( !pInstance )
            return true;

        gossipMenuID = 0;

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                {
                    gossipMenuID = player->GetTeamId() == TEAM_ALLIANCE ? 0 : 1;
                    getGossip(player, creature, CHALLENGE_BEASTS_CONFIRM, gossipMenuID, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                {
                    gossipMenuID = player->GetTeamId() == TEAM_ALLIANCE ? 0 : 1;
                    getGossip(player, creature, CHALLENGE_JARAXXUS_CONFIRM, gossipMenuID, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                {
                    gossipMenuID = player->GetTeamId() == TEAM_ALLIANCE ? 0 : 1;
                    getGossip(player, creature, CHALLENGE_FACTION_CHAMPIONS_CONFIRM, gossipMenuID, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 4:
                {
                    gossipMenuID = player->GetTeamId() == TEAM_ALLIANCE ? 0 : 1;
                    getGossip(player, creature, CHALLENGE_VALKYR_CONFIRM, gossipMenuID, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 5:
                {
                    getGossip(player, creature, CHALLENGE_ANUBARAK_CONFIRM, gossipMenuID, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 6:
                {
                    CloseGossipMenuFor(player);
                    pInstance->SetData(TYPE_ANNOUNCER_GOSSIP_SELECT, 0);
                    creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                }
                break;
            default:
                break;
        }
        return true;
    }
private:
    uint32 gossipMenuID;
};

void AddSC_trial_of_the_crusader()
{
    new npc_announcer_toc10();
}
