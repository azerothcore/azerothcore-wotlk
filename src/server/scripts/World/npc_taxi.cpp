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

enum Npcs
{
    NPC_NETHER_DRAKE    = 20903,  // Netherstorm - Protectorate Nether Drake
    NPC_IRONWING        = 29154,  // Stormwind City - Thargold Ironwing
    NPC_DABIR           = 19409,  // Hellfire Peninsula - Wing Commander Dabir'ee
    NPC_BRACK           = 19401,  // Hellfire Peninsula - Wing Commander Brack
    NPC_IRENA           = 23413,  // Blade's Edge Mountains - Skyguard Handler Irena
    NPC_AYREN           = 25059,  // Isle of Quel'Danas - Ayren Cloudbreaker
    NPC_DRAGONHAWK      = 25236,  // Isle of Quel'Danas - Unrestrained Dragonhawk
    NPC_VERONIA         = 20162,  // Netherstorm - Veronia
    NPC_DEESAK          = 23415,  // Terokkar Forest - Skyguard Handler Deesak
    NPC_AFRASASTRASZ    = 27575,  // Dragonblight - Lord Afrasastrasz
    NPC_TARIOLSTRASZ    = 26443,  // Dragonblight - Tariolstrasz
    NPC_TORASTRASZA     = 26949,  // Dragonblight - Torastrasza
    NPC_CESSA           = 23704,  // Dustwallow Marsh - Cassa Crimsonwing
    NPC_KIELAR          = 17209,  // William Kielar <Spectral Gryphon Master> - Eastern Plaguelands Towers
};

enum Misc
{
    REP_SKYGUARD        = 1031,   // Sha'tari Skyguard Reputation

    // Netherstorm
    QUEST_NETHERY_WINGS = 10438,  // On Nethery Wings
    ITEM_DISRUPTOR      = 29778,  // Phase Disruptor (Needed for On Nethery Wings)
    QUEST_BEHIND_ENEMY  = 10652,  // Behind Enemy Lines

    // Hellfire Peninsula - Alliance
    QUEST_GATEWAYS_A    = 10146,  // Mission: The Murketh and Shaadraz Gateways
    QUEST_SHATTER_POINT = 10340,  // Shatter Point

    // Hellfire Peninsula - Horde
    QUEST_GATEWAYS_H    = 10129,  // Mission: The Murketh and Shaadraz Gateways
    QUEST_ABBYSAL       = 10162,  // Mission: The Abyssal Shelf
    QUEST_ABBYSAL_DAILY = 10347,  // Return to the Abyssal Shelf (Daily)
    QUEST_SPINEBREAKER  = 10242,  // Spinebreaker Post

    // Isle of Quel'Danas (Daily)
    QUEST_DEAD_SCAR     = 11532,  // Mission: Distraction at the Dead Scar
    QUEST_AIR_STRIKE    = 11533,  // The Air Strikes Must Continue
    QUEST_INTERCEPT     = 11542,  // Mission: Intercept the Reinforcements
    QUEST_KEEP_AT_BEY   = 11543,  // Keeping the Enemy at Bay

    // Dustwallow Marsh
    QUEST_SURVEY_ALCAZ  = 11142,  // Survey Alcaz Island
};

class npc_taxi : public CreatureScript
{
public:
    npc_taxi() : CreatureScript("npc_taxi") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        uint32 gossipmenuid = 0;
        gossipmenuid = creature->GetCreatureTemplate()->GossipMenuId;

        switch (creature->GetEntry())
        {
            case NPC_NETHER_DRAKE:
                if (player->GetQuestStatus(QUEST_NETHERY_WINGS) == QUEST_STATUS_INCOMPLETE && player->HasItemCount(ITEM_DISRUPTOR))
                    AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                break;
            case NPC_IRONWING:
                AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                break;
            case NPC_DABIR:
                if (player->GetQuestStatus(QUEST_GATEWAYS_A) == QUEST_STATUS_INCOMPLETE)
                    AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);

                if (!player->GetQuestRewardStatus(QUEST_SHATTER_POINT))
                    AddGossipItemFor(player, gossipmenuid, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                break;
            case NPC_BRACK:
                if (player->GetQuestStatus(QUEST_GATEWAYS_H) == QUEST_STATUS_INCOMPLETE)
                    AddGossipItemFor(player, gossipmenuid, 5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);

                if (player->GetQuestStatus(QUEST_ABBYSAL) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(QUEST_ABBYSAL_DAILY) == QUEST_STATUS_INCOMPLETE)
                    AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 9);

                if (player->GetQuestStatus(QUEST_SPINEBREAKER) == QUEST_STATUS_COMPLETE)
                    AddGossipItemFor(player, gossipmenuid, 4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
                break;
            case NPC_IRENA:
                if (player->GetReputationRank(REP_SKYGUARD) >= REP_HONORED)
                    AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
                break;
            case NPC_AYREN:
                if (player->GetQuestStatus(QUEST_DEAD_SCAR) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(QUEST_AIR_STRIKE) == QUEST_STATUS_INCOMPLETE)
                    AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);

                if (player->GetQuestStatus(QUEST_INTERCEPT) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(QUEST_KEEP_AT_BEY) == QUEST_STATUS_INCOMPLETE)
                    AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
                break;
            case NPC_DRAGONHAWK:
                if (player->GetQuestStatus(QUEST_INTERCEPT) == QUEST_STATUS_COMPLETE || player->GetQuestStatus(QUEST_KEEP_AT_BEY) == QUEST_STATUS_COMPLETE)
                    AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 14);
                break;
            case NPC_VERONIA:
                if (player->GetQuestStatus(QUEST_BEHIND_ENEMY) != QUEST_STATUS_REWARDED)
                    AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 15);
                break;
            case NPC_DEESAK:
                if (player->GetReputationRank(REP_SKYGUARD) >= REP_HONORED)
                    AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 16);
                break;
            case NPC_AFRASASTRASZ:
                // middle -> ground
                AddGossipItemFor(player, gossipmenuid, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 17);
                // middle -> top
                AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 18);
                break;
            case NPC_TARIOLSTRASZ:
                // ground -> top
                AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 19);
                // ground -> middle
                AddGossipItemFor(player, gossipmenuid, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 20);
                break;
            case NPC_TORASTRASZA:
                // top -> middle
                AddGossipItemFor(player, gossipmenuid, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 21);
                // top -> ground
                AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 22);
                break;
            case NPC_CESSA:
                if (player->GetQuestStatus(QUEST_SURVEY_ALCAZ) == QUEST_STATUS_INCOMPLETE)
                    AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 25);
                break;
            case NPC_KIELAR:
                AddGossipItemFor(player, gossipmenuid, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 26); // Northpass Tower.
                AddGossipItemFor(player, gossipmenuid, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 27); // Eastwall Tower.
                AddGossipItemFor(player, gossipmenuid, 2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 28); // Crown Guard Tower.
                break;
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature*  /*creature*/, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 35731, true);               //TaxiPath 628
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 53335, true);               //TaxiPath 1041 (Stormwind Harbor)
                break;
            case GOSSIP_ACTION_INFO_DEF + 4:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 33768, true);               //TaxiPath 585 (Gateways Murket and Shaadraz)
                break;
            case GOSSIP_ACTION_INFO_DEF + 5:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 35069, true);               //TaxiPath 612 (Taxi - Hellfire Peninsula - Expedition Point to Shatter Point)
                break;
            case GOSSIP_ACTION_INFO_DEF + 8:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 33659, true);               //TaxiPath 584 (Gateways Murket and Shaadraz)
                break;
            case GOSSIP_ACTION_INFO_DEF + 9:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 33825, true);               //TaxiPath 587 (Aerial Assault Flight (Horde))
                break;
            case GOSSIP_ACTION_INFO_DEF + 10:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 34578, true);               //TaxiPath 604 (Taxi - Reaver's Fall to Spinebreaker Ridge)
                break;
            case GOSSIP_ACTION_INFO_DEF + 11:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 41278, true);               //TaxiPath 706
                break;
            case GOSSIP_ACTION_INFO_DEF + 12:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 45071, true);               //TaxiPath 779
                break;
            case GOSSIP_ACTION_INFO_DEF + 13:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 45113, true);               //TaxiPath 784
                break;
            case GOSSIP_ACTION_INFO_DEF + 14:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 45353, true);               //TaxiPath 788
                break;
            case GOSSIP_ACTION_INFO_DEF + 15:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 34905, true);               //TaxiPath 606
                break;
            case GOSSIP_ACTION_INFO_DEF + 16:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 41279, true);               //TaxiPath 705 (Taxi - Skettis to Skyguard Outpost)
                break;
            case GOSSIP_ACTION_INFO_DEF + 17:
                CloseGossipMenuFor(player);
                player->ActivateTaxiPathTo(882);
                break;
            case GOSSIP_ACTION_INFO_DEF + 18:
                CloseGossipMenuFor(player);
                player->ActivateTaxiPathTo(881);
                break;
            case GOSSIP_ACTION_INFO_DEF + 19:
                CloseGossipMenuFor(player);
                player->ActivateTaxiPathTo(878);
                break;
            case GOSSIP_ACTION_INFO_DEF + 20:
                CloseGossipMenuFor(player);
                player->ActivateTaxiPathTo(883);
                break;
            case GOSSIP_ACTION_INFO_DEF + 21:
                CloseGossipMenuFor(player);
                player->ActivateTaxiPathTo(880);
                break;
            case GOSSIP_ACTION_INFO_DEF + 22:
                CloseGossipMenuFor(player);
                player->ActivateTaxiPathTo(879);
                break;
            case GOSSIP_ACTION_INFO_DEF + 25:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 42295, true);
                break;
            case GOSSIP_ACTION_INFO_DEF + 26:
                CloseGossipMenuFor(player);
                player->ActivateTaxiPathTo(494);
                break;
            case GOSSIP_ACTION_INFO_DEF + 27:
                CloseGossipMenuFor(player);
                player->ActivateTaxiPathTo(495);
                break;
            case GOSSIP_ACTION_INFO_DEF + 28:
                CloseGossipMenuFor(player);
                player->ActivateTaxiPathTo(496);
                break;
        }

        return true;
    }
};

void AddSC_npc_taxi()
{
    new npc_taxi;
}
