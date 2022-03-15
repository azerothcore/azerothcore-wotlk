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

/* ScriptData
SDName: Npc_Taxi
SD%Complete: 0%
SDComment: To be used for taxi NPCs that are located globally.
SDCategory: NPCs
EndScriptData
*/

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

constexpr std::pair<uint32, uint32> gossip_nether_drake     = { 8229, 0 };      // I'm ready to fly! Take me up, dragon!
constexpr std::pair<uint32, uint32> gossip_ironwing         = { 9776, 0 };      // I'd like to take a flight around Stormwind Harbor.
constexpr std::pair<uint32, uint32> gossip_cloudbreaker1    = { 9062, 0 };      // Speaking of action, I've been ordered to undertake an air strike.
constexpr std::pair<uint32, uint32> gossip_cloudbreaker2    = { 9062, 1 };      // I need to intercept the Dawnblade reinforcements.
constexpr std::pair<uint32, uint32> gossip_dragonhawk       = { 9143, 0 };      // <Ride the dragonhawk to Sun's Reach.>
constexpr std::pair<uint32, uint32> gossip_torastraza2      = { 9457, 0 };      // Yes, please, I would like to return to the ground level of the temple.
constexpr std::pair<uint32, uint32> gossip_to_northpass     = { 7379, 0 };      // Take me to Northpass Tower.
constexpr std::pair<uint32, uint32> gossip_to_eastwall      = { 7379, 1 };      // Take me to Eastwall Tower.
constexpr std::pair<uint32, uint32> gossip_to_crown_guard   = { 7379, 2 };      // Take me to Crown Guard Tower.

#define GOSSIP_DABIREE1         "Fly me to Murketh and Shaadraz Gateways"
#define GOSSIP_DABIREE2         "Fly me to Shatter Point"
#define GOSSIP_BRACK1           "Fly me to Murketh and Shaadraz Gateways"
#define GOSSIP_BRACK2           "Fly me to The Abyssal Shelf"
#define GOSSIP_BRACK3           "Fly me to Spinebreaker Post"
#define GOSSIP_IRENA            "Fly me to Skettis please"
#define GOSSIP_VERONIA          "Fly me to Manaforge Coruu please"
#define GOSSIP_DEESAK           "Fly me to Ogri'la please"
#define GOSSIP_AFRASASTRASZ1    "I would like to take a flight to the ground, Lord Of Afrasastrasz."
#define GOSSIP_AFRASASTRASZ2    "My Lord, I must go to the upper floor of the temple."
#define GOSSIP_TARIOLSTRASZ1    "My Lord, I must go to the upper floor of the temple."
#define GOSSIP_TARIOLSTRASZ2    "Can you spare a drake to travel to Lord Of Afrasastrasz, in the middle of the temple?"
#define GOSSIP_TORASTRASZA1     "I would like to see Lord Of Afrasastrasz, in the middle of the temple."
#define GOSSIP_CRIMSONWING      "<Ride the gryphons to Survey Alcaz Island>"

class npc_taxi : public CreatureScript
{
public:
    npc_taxi() : CreatureScript("npc_taxi") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        switch (creature->GetEntry())
        {
            case 20903: // Netherstorm - Protectorate Nether Drake
                if (player->GetQuestStatus(10438) == QUEST_STATUS_INCOMPLETE && player->HasItemCount(29778))
                    AddGossipItemFor(player, gossip_nether_drake, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                break;
            case 29154: // Stormwind City - Thargold Ironwing
                AddGossipItemFor(player, gossip_ironwing, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                break;
            case 19409: // Hellfire Peninsula - Wing Commander Dabir'ee
                //Mission: The Murketh and Shaadraz Gateways
                if (player->GetQuestStatus(10146) == QUEST_STATUS_INCOMPLETE)
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_DABIREE1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);

                //Shatter Point
                if (!player->GetQuestRewardStatus(10340))
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_DABIREE2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                break;
            case 19401: // Hellfire Peninsula - Wing Commander Brack
                //Mission: The Murketh and Shaadraz Gateways
                if (player->GetQuestStatus(10129) == QUEST_STATUS_INCOMPLETE)
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_BRACK1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);

                //Mission: The Abyssal Shelf || Return to the Abyssal Shelf
                if (player->GetQuestStatus(10162) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(10347) == QUEST_STATUS_INCOMPLETE)
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_BRACK2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 9);

                //Spinebreaker Post
                if (player->GetQuestStatus(10242) == QUEST_STATUS_COMPLETE)
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_BRACK3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
                break;
            case 23413: // Blade's Edge Mountains - Skyguard Handler Irena
                if (player->GetReputationRank(1031) >= REP_HONORED)
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_IRENA, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
                break;
            case 25059: // Isle of Quel'Danas - Ayren Cloudbreaker
                if (player->GetQuestStatus(11532) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(11533) == QUEST_STATUS_INCOMPLETE)
                    AddGossipItemFor(player, gossip_cloudbreaker1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);

                if (player->GetQuestStatus(11542) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(11543) == QUEST_STATUS_INCOMPLETE)
                    AddGossipItemFor(player, gossip_cloudbreaker2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
                break;
            case 25236: // Isle of Quel'Danas - Unrestrained Dragonhawk
                if (player->GetQuestStatus(11542) == QUEST_STATUS_COMPLETE || player->GetQuestStatus(11543) == QUEST_STATUS_COMPLETE)
                    AddGossipItemFor(player, gossip_dragonhawk, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 14);
                break;
            case 20162: // Netherstorm - Veronia
                //Behind Enemy Lines
                if (player->GetQuestStatus(10652) != QUEST_STATUS_REWARDED)
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_VERONIA, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 15);
                break;
            case 23415: // Terokkar Forest - Skyguard Handler Deesak
                if (player->GetReputationRank(1031) >= REP_HONORED)
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_DEESAK, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 16);
                break;
            case 27575: // Dragonblight - Lord Afrasastrasz
                // middle -> ground
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_AFRASASTRASZ1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 17);
                // middle -> top
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_AFRASASTRASZ2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 18);
                break;
            case 26443: // Dragonblight - Tariolstrasz //need to check if quests are required before gossip available (12123, 12124)
                // ground -> top
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_TARIOLSTRASZ1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 19);
                // ground -> middle
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_TARIOLSTRASZ2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 20);
                break;
            case 26949: // Dragonblight - Torastrasza
                // top -> middle
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_TORASTRASZA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 21);
                // top -> ground
                AddGossipItemFor(player, gossip_torastraza2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 22);
                break;
            case 23704: // Dustwallow Marsh - Cassa Crimsonwing
                if (player->GetQuestStatus(11142) == QUEST_STATUS_INCOMPLETE)
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_CRIMSONWING, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 25);
                break;
            case 17209:
                AddGossipItemFor(player, gossip_to_northpass, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 26);
                AddGossipItemFor(player, gossip_to_eastwall, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 27);
                AddGossipItemFor(player, gossip_to_crown_guard, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 28);
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
                player->ActivateTaxiPathTo(627);                  //TaxiPath 627 (possibly 627+628(152->153->154->155))
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
            case GOSSIP_ACTION_INFO_DEF + 23:
                CloseGossipMenuFor(player);
                player->CastSpell(player, 43074, true);               //TaxiPath 736
                break;
            case GOSSIP_ACTION_INFO_DEF + 24:
                CloseGossipMenuFor(player);
                //player->ActivateTaxiPathTo(738);
                player->CastSpell(player, 43136, false);
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
