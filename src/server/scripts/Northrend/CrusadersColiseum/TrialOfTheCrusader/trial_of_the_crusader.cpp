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

#include "trial_of_the_crusader.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

enum MenuTexts
{
    MSG_TESTED                      = 724001,
    MSG_NEXT_STAGE                  = 724002,
    MSG_CRUSADERS                   = 724003,
    MSG_ANUBARAK                    = 724005,
};

class npc_announcer_toc10 : public CreatureScript
{
public:
    npc_announcer_toc10() : CreatureScript("npc_announcer_toc10") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (!creature->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
            return true;

        InstanceScript* pInstance = creature->GetInstanceScript();
        if (!pInstance)
            return true;

        uint32 gossipTextId = 0;
        switch (pInstance->GetData(TYPE_INSTANCE_PROGRESS))
        {
            case INSTANCE_PROGRESS_INITIAL:
                gossipTextId = MSG_TESTED;
                break;
            case INSTANCE_PROGRESS_INTRO_DONE:
            case INSTANCE_PROGRESS_BEASTS_DEAD:
            case INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD:
            case INSTANCE_PROGRESS_VALKYR_DEAD:
                gossipTextId = MSG_NEXT_STAGE;
                break;
            case INSTANCE_PROGRESS_JARAXXUS_DEAD:
                gossipTextId = MSG_CRUSADERS;
                break;
            case INSTANCE_PROGRESS_DONE:
                creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                return true;
            default:
                return true;
        }

        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "We are ready!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1337);
        SendGossipMenuFor(player, gossipTextId, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 uiAction) override
    {
        if (!creature->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
            return true;

        InstanceScript* pInstance = creature->GetInstanceScript();
        if (!pInstance)
            return true;

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1337)
        {
            pInstance->SetData(TYPE_ANNOUNCER_GOSSIP_SELECT, 0);
            creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        }

        CloseGossipMenuFor(player);
        return true;
    }
};

void AddSC_trial_of_the_crusader()
{
    new npc_announcer_toc10();
}
