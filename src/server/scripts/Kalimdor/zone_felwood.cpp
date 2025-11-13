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
#include "ScriptedGossip.h"

/*######
## npcs_riverbreeze_and_silversky
######*/

enum RiverbreezeAndSilversky
{
    SPELL_CENARION_BEACON       = 15120,
    ITEM_CENARION_BEACON        = 11511,
    ACTION_CREATE_CENARION_BEACON = GOSSIP_ACTION_INFO_DEF + 1,

    NPC_ARATHANDRIS_SILVERSKY   = 9528,
    NPC_MAYBESS_RIVERBREEZE     = 9529,

    QUEST_CLEASING_FELWOOD_A    = 4101,
    QUEST_CLEASING_FELWOOD_H    = 4102,

    // Texts
    GOSSIP_MENU_SILVERSKY = 2208,
    GOSSIP_MENU_RIVERBREEZE = 21400,
    GOSSIP_OPTION_BEACON = 0,

    TEXT_SILVERSKY_1 = 2848,
    TEXT_SILVERSKY_2 = 2845,
    TEXT_SILVERSKY_3 = 2844,
    TEXT_RIVERBREEZE_1 = 2849,
    TEXT_RIVERBREEZE_2 = 2843,
    TEXT_RIVERBREEZE_3 = 2842,
};

class npcs_riverbreeze_and_silversky : public CreatureScript
{
public:
    npcs_riverbreeze_and_silversky() : CreatureScript("npcs_riverbreeze_and_silversky") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            CloseGossipMenuFor(player);
            creature->CastSpell(player, SPELL_CENARION_BEACON, false);
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        uint32 const creatureId = creature->GetEntry();

        if (creatureId == NPC_ARATHANDRIS_SILVERSKY)
        {
            if (player->GetQuestRewardStatus(QUEST_CLEASING_FELWOOD_A))
            {
                if (!player->HasItemCount(ITEM_CENARION_BEACON, 1, true))
                   AddGossipItemFor(player, GOSSIP_MENU_SILVERSKY, GOSSIP_OPTION_BEACON, GOSSIP_SENDER_MAIN, ACTION_CREATE_CENARION_BEACON);

                SendGossipMenuFor(player, TEXT_SILVERSKY_1, creature->GetGUID());
            }
            else if (player->GetTeamId() == TEAM_HORDE)
                SendGossipMenuFor(player, TEXT_SILVERSKY_2, creature->GetGUID());
            else
                SendGossipMenuFor(player, TEXT_SILVERSKY_3, creature->GetGUID());
        }

        if (creatureId == NPC_MAYBESS_RIVERBREEZE)
        {
            if (player->GetQuestRewardStatus(QUEST_CLEASING_FELWOOD_H))
            {
                if (!player->HasItemCount(ITEM_CENARION_BEACON, 1, true))
                    AddGossipItemFor(player, GOSSIP_MENU_RIVERBREEZE, GOSSIP_OPTION_BEACON, GOSSIP_SENDER_MAIN, ACTION_CREATE_CENARION_BEACON);

                SendGossipMenuFor(player, TEXT_RIVERBREEZE_1, creature->GetGUID());
            }
            else if (player->GetTeamId() == TEAM_ALLIANCE)
                SendGossipMenuFor(player, TEXT_RIVERBREEZE_2, creature->GetGUID());
            else
                SendGossipMenuFor(player, TEXT_RIVERBREEZE_3, creature->GetGUID());
        }

        return true;
    }
};

/*######
## at_ancient_leaf
######*/

enum AncientMisc
{
    QUEST_ANCIENT_LEAF      = 7632,
    NPC_VARTRUS             = 14524,
    NPC_STOMA               = 14525,
    NPC_HASTAT              = 14526,
    CREATURE_GROUP_ANCIENTS = 1
};

class at_ancient_leaf : public AreaTriggerScript
{
public:
    at_ancient_leaf() : AreaTriggerScript("at_ancient_leaf") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (player->IsGameMaster() || !player->IsAlive())
            return false;

        // Handle Call Ancients event start - The area trigger summons 3 ancients
        if ((player->GetQuestStatus(QUEST_ANCIENT_LEAF) == QUEST_STATUS_COMPLETE) || (player->GetQuestStatus(QUEST_ANCIENT_LEAF) == QUEST_STATUS_REWARDED))
        {
            // If ancients are already spawned, skip the rest
            if (GetClosestCreatureWithEntry(player, NPC_VARTRUS, 50.0f) || GetClosestCreatureWithEntry(player, NPC_STOMA, 50.0f) || GetClosestCreatureWithEntry(player, NPC_HASTAT, 50.0f))
                return true;

            player->GetMap()->SummonCreatureGroup(CREATURE_GROUP_ANCIENTS);
        }
        return false;
    }
};

void AddSC_felwood()
{
    new npcs_riverbreeze_and_silversky();
    new at_ancient_leaf();
}
