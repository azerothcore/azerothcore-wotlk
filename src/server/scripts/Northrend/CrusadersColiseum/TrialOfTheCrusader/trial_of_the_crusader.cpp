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

class npc_announcer_toc10 : public CreatureScript
{
public:
    npc_announcer_toc10() : CreatureScript("npc_announcer_toc10") { }

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

        switch (pInstance->GetData(TYPE_INSTANCE_PROGRESS))
        {
            case INSTANCE_PROGRESS_INITIAL:
            case INSTANCE_PROGRESS_INTRO_DONE:
                {
                    if (player->GetTeamId() == TEAM_ALLIANCE)
                    {
                        AddGossipItemFor(player, CHALLENGE_BEASTS, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                        SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_BEASTS, creature), creature->GetGUID());
                    }
                    else
                    {
                        AddGossipItemFor(player, CHALLENGE_BEASTS, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                        SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_BEASTS, creature), creature->GetGUID());
                    }
                }
                break;
            case INSTANCE_PROGRESS_BEASTS_DEAD:
                {
                    AddGossipItemFor(player, CHALLENGE_JARAXXUS, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                    SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_JARAXXUS, creature), creature->GetGUID());
                }
                break;
            case INSTANCE_PROGRESS_JARAXXUS_DEAD:
                {
                    if (player->GetTeamId() == TEAM_ALLIANCE)
                    {
                        AddGossipItemFor(player, CHALLENGE_FACTION_CHAMPIONS, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                        SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_FACTION_CHAMPIONS, creature), creature->GetGUID());
                    }
                    else
                    {
                        AddGossipItemFor(player, CHALLENGE_FACTION_CHAMPIONS, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                        SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_FACTION_CHAMPIONS, creature), creature->GetGUID());
                    }
                }
                break;
            case INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD:
                {
                    if (player->GetTeamId() == TEAM_ALLIANCE)
                    {
                        AddGossipItemFor(player, CHALLENGE_VALKYR, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                        SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_VALKYR, creature), creature->GetGUID());
                    }
                    else
                    {
                        AddGossipItemFor(player, CHALLENGE_VALKYR, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                        SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_VALKYR, creature), creature->GetGUID());
                    }
                }
                break;
            case INSTANCE_PROGRESS_VALKYR_DEAD:
                {
                    AddGossipItemFor(player, CHALLENGE_ANUBARAK, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                    SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_ANUBARAK, creature), creature->GetGUID());
                }
                break;
            case INSTANCE_PROGRESS_DONE:
                creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                return true;
                break;
            default:
                return true;
                break;
        }
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 uiAction) override
    {
        ClearGossipMenuFor(player);

        if ( !creature->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
            return true;

        InstanceScript* pInstance = creature->GetInstanceScript();
        if ( !pInstance )
            return true;

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            if (player->GetTeamId() == TEAM_ALLIANCE)
            {
                AddGossipItemFor(player, CHALLENGE_BEASTS_CONFIRM, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_BEASTS_CONFIRM, creature), creature->GetGUID());
            }
            else
            {
                AddGossipItemFor(player, CHALLENGE_BEASTS_CONFIRM, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_BEASTS_CONFIRM, creature), creature->GetGUID());
            }
        }

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 2)
        {
            if (player->GetTeamId() == TEAM_ALLIANCE)
            {
                AddGossipItemFor(player, CHALLENGE_JARAXXUS_CONFIRM, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_JARAXXUS_CONFIRM, creature), creature->GetGUID());
            }
            else
            {
                AddGossipItemFor(player, CHALLENGE_JARAXXUS_CONFIRM, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_JARAXXUS_CONFIRM, creature), creature->GetGUID());
            }
        }

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 3)
        {
            if (player->GetTeamId() == TEAM_ALLIANCE)
            {
                AddGossipItemFor(player, CHALLENGE_FACTION_CHAMPIONS_CONFIRM, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_FACTION_CHAMPIONS_CONFIRM, creature), creature->GetGUID());
            }
            else
            {
                AddGossipItemFor(player, CHALLENGE_FACTION_CHAMPIONS_CONFIRM, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_FACTION_CHAMPIONS_CONFIRM, creature), creature->GetGUID());
            }
        }

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 4)
        {
            if (player->GetTeamId() == TEAM_ALLIANCE)
            {
                AddGossipItemFor(player, CHALLENGE_VALKYR_CONFIRM, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_VALKYR_CONFIRM, creature), creature->GetGUID());
            }
            else
            {
                AddGossipItemFor(player, CHALLENGE_VALKYR_CONFIRM, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_VALKYR_CONFIRM, creature), creature->GetGUID());
            }
        }

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 5)
        {
            AddGossipItemFor(player, CHALLENGE_ANUBARAK_CONFIRM, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
            SendGossipMenuFor(player, player->GetGossipTextId(CHALLENGE_ANUBARAK_CONFIRM, creature), creature->GetGUID());
        }

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 6)
        {
            CloseGossipMenuFor(player);
            pInstance->SetData(TYPE_ANNOUNCER_GOSSIP_SELECT, 0);
            creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        }

        return true;
    }
};

void AddSC_trial_of_the_crusader()
{
    new npc_announcer_toc10();
}
