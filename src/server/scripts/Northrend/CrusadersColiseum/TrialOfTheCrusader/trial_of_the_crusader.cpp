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
                        AddGossipItemFor(player, 10599, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                        SendGossipMenuFor(player, 14664, creature->GetGUID());
                    }
                    else
                    {
                        AddGossipItemFor(player, 10599, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                        SendGossipMenuFor(player, 14664, creature->GetGUID());
                    }
                }
                break;
            case INSTANCE_PROGRESS_BEASTS_DEAD:
                {
                    AddGossipItemFor(player, 10609, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                    SendGossipMenuFor(player, 14678, creature->GetGUID());
                }
                break;
            case INSTANCE_PROGRESS_JARAXXUS_DEAD:
                {
                    if (player->GetTeamId() == TEAM_ALLIANCE)
                    {
                        AddGossipItemFor(player, 10678, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                        SendGossipMenuFor(player, 14813, creature->GetGUID());
                    }
                    else
                    {
                        AddGossipItemFor(player, 10678, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                        SendGossipMenuFor(player, 14813, creature->GetGUID());
                    }
                }
                break;
            case INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD:
                {
                    if (player->GetTeamId() == TEAM_ALLIANCE)
                    {
                        AddGossipItemFor(player, 10679, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                        SendGossipMenuFor(player, 14819, creature->GetGUID());
                    }
                    else
                    {
                        AddGossipItemFor(player, 10679, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                        SendGossipMenuFor(player, 14819, creature->GetGUID());
                    }
                }
                break;
            case INSTANCE_PROGRESS_VALKYR_DEAD:
                {
                    AddGossipItemFor(player, 10692, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                    SendGossipMenuFor(player, 14828, creature->GetGUID());
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
                AddGossipItemFor(player, 10600, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1337);
                SendGossipMenuFor(player, 14665, creature->GetGUID());
            }
            else
            {
                AddGossipItemFor(player, 10600, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1337);
                SendGossipMenuFor(player, 14665, creature->GetGUID());
            }
        }

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 2)
        {
            if (player->GetTeamId() == TEAM_ALLIANCE)
            {
                AddGossipItemFor(player, 10610, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1337);
                SendGossipMenuFor(player, 14680, creature->GetGUID());
            }
            else
            {
                AddGossipItemFor(player, 10610, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1337);
                SendGossipMenuFor(player, 14682, creature->GetGUID());
            }
        }

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 3)
        {
            if (player->GetTeamId() == TEAM_ALLIANCE)
            {
                AddGossipItemFor(player, 10687, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1337);
                SendGossipMenuFor(player, 14814, creature->GetGUID());
            }
            else
            {
                AddGossipItemFor(player, 10687, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1337);
                SendGossipMenuFor(player, 14814, creature->GetGUID());
            }
        }

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 4)
        {
            if (player->GetTeamId() == TEAM_ALLIANCE)
            {
                AddGossipItemFor(player, 10688, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1337);
                SendGossipMenuFor(player, 14821, creature->GetGUID());
            }
            else
            {
                AddGossipItemFor(player, 10688, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1337);
                SendGossipMenuFor(player, 14821, creature->GetGUID());
            }
        }

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 5)
        {
            AddGossipItemFor(player, 10693, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1337);
            SendGossipMenuFor(player, 14829, creature->GetGUID());
        }

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1337)
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
