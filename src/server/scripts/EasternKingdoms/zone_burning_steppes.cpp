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

/*######
## NPC 9836: Maredis Firestar
######*/

enum MaredisFirestar
{
    ITEM_LIBRAM_OF_RUMINATION     = 11732,
    ITEM_LIBRAM_OF_CONSTITUTION   = 11733,
    ITEM_LIBRAM_OF_TENACITY       = 11734,
    ITEM_LIBRAM_OF_RESILIENCE     = 11736,
    ITEM_LIBRAM_OF_VORACITY       = 11737,
    GOSSIP_LIBRAM_OF_RUMINATION   = 2299,
    GOSSIP_LIBRAM_OF_CONSTITUTION = 2300,
    GOSSIP_LIBRAM_OF_TENACITY     = 2301,
    GOSSIP_LIBRAM_OF_RESILIENCE   = 2302,
    GOSSIP_LIBRAM_OF_VORACITY     = 2303
};

class npc_maredis_firestar : public CreatureScript
{
public:
    npc_maredis_firestar() : CreatureScript("npc_maredis_firestar") {}

    struct npc_maredis_firestarAI : public CreatureAI
    {
        npc_maredis_firestarAI(Creature* creature) : CreatureAI(creature) {}

        void sGossipHello(Player* player) override
        {
            // If player has 2 different librams on him he will only see top most one.
            // Count is default 1. In bank is default false.
            if (player->HasItemCount(ITEM_LIBRAM_OF_RUMINATION))
            {
                player->PrepareGossipMenu(me, GOSSIP_LIBRAM_OF_RUMINATION);
                player->SendPreparedGossip(me);
            }
            else if (player->HasItemCount(ITEM_LIBRAM_OF_CONSTITUTION))
            {
                player->PrepareGossipMenu(me, GOSSIP_LIBRAM_OF_CONSTITUTION);
                player->SendPreparedGossip(me);
            }
            else if (player->HasItemCount(ITEM_LIBRAM_OF_TENACITY))
            {
                player->PrepareGossipMenu(me, GOSSIP_LIBRAM_OF_TENACITY);
                player->SendPreparedGossip(me);
            }
            else if (player->HasItemCount(ITEM_LIBRAM_OF_RESILIENCE))
            {
                player->PrepareGossipMenu(me, GOSSIP_LIBRAM_OF_RESILIENCE);
                player->SendPreparedGossip(me);
            }
            else if (player->HasItemCount(ITEM_LIBRAM_OF_VORACITY))
            {
                player->PrepareGossipMenu(me, GOSSIP_LIBRAM_OF_VORACITY);
                player->SendPreparedGossip(me);
            }
        }

        void sGossipSelect(Player* player, uint32 /*sender*/, uint32 /*action*/) override
        {
            // All gossip menus only have one option. Conditions are handled in db.
            player->PrepareQuestMenu(me->GetGUID());
            player->SendPreparedQuest(me->GetGUID());
        }
    };
};

void AddSC_burning_steppes()
{
    new npc_maredis_firestar();
}
