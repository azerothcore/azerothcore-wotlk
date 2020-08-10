/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Npc_Taxi
SD%Complete: 0%
SDComment: To be used for taxi NPCs that are located globally.
SDCategory: NPCs
EndScriptData
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Player.h"
#include "WorldSession.h"

#define GOSSIP_SUSURRUS         "I am ready."
#define GOSSIP_NETHER_DRAKE     "I'm ready to fly! Take me up, dragon!"
#define GOSSIP_IRONWING         "I'd like to take a flight around Stormwind Harbor."
#define GOSSIP_DABIREE1         "Fly me to Murketh and Shaadraz Gateways"
#define GOSSIP_DABIREE2         "Fly me to Shatter Point"
#define GOSSIP_BRACK1           "Fly me to Murketh and Shaadraz Gateways"
#define GOSSIP_BRACK2           "Fly me to The Abyssal Shelf"
#define GOSSIP_BRACK3           "Fly me to Spinebreaker Post"
#define GOSSIP_IRENA            "Fly me to Skettis please"
#define GOSSIP_CLOUDBREAKER1    "Speaking of action, I've been ordered to undertake an air strike."
#define GOSSIP_CLOUDBREAKER2    "I need to intercept the Dawnblade reinforcements."
#define GOSSIP_DRAGONHAWK       "<Ride the dragonhawk to Sun's Reach>"
#define GOSSIP_VERONIA          "Fly me to Manaforge Coruu please"
#define GOSSIP_DEESAK           "Fly me to Ogri'la please"
#define GOSSIP_AFRASASTRASZ1    "I would like to take a flight to the ground, Lord Of Afrasastrasz."
#define GOSSIP_AFRASASTRASZ2    "My Lord, I must go to the upper floor of the temple."
#define GOSSIP_TARIOLSTRASZ1    "My Lord, I must go to the upper floor of the temple."
#define GOSSIP_TARIOLSTRASZ2    "Can you spare a drake to travel to Lord Of Afrasastrasz, in the middle of the temple?"
#define GOSSIP_TORASTRASZA1     "I would like to see Lord Of Afrasastrasz, in the middle of the temple."
#define GOSSIP_TORASTRASZA2     "Yes, Please. I would like to return to the ground floor of the temple."
#define GOSSIP_CRIMSONWING      "<Ride the gryphons to Survey Alcaz Island>"
#define GOSSIP_WILLIAMKEILAR1   "Take me to Northpass Tower."
#define GOSSIP_WILLIAMKEILAR2   "Take me to Eastwall Tower."
#define GOSSIP_WILLIAMKEILAR3   "Take me to Crown Guard Tower."

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
        case 17435: // Azuremyst Isle - Susurrus
            if (player->HasItemCount(23843, 1, true))
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_SUSURRUS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
            break;
        case 20903: // Netherstorm - Protectorate Nether Drake
            if (player->GetQuestStatus(10438) == QUEST_STATUS_INCOMPLETE && player->HasItemCount(29778))
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_NETHER_DRAKE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            break;
        case 29154: // Stormwind City - Thargold Ironwing
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_IRONWING, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
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
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_CLOUDBREAKER1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);

            if (player->GetQuestStatus(11542) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(11543) == QUEST_STATUS_INCOMPLETE)
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_CLOUDBREAKER2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
            break;
        case 25236: // Isle of Quel'Danas - Unrestrained Dragonhawk
            if (player->GetQuestStatus(11542) == QUEST_STATUS_COMPLETE || player->GetQuestStatus(11543) == QUEST_STATUS_COMPLETE)
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_DRAGONHAWK, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 14);
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
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_TORASTRASZA2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 22);
            break;
        case 23704: // Dustwallow Marsh - Cassa Crimsonwing
            if (player->GetQuestStatus(11142) == QUEST_STATUS_INCOMPLETE)
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_CRIMSONWING, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+25);
            break;
        case 17209:
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_WILLIAMKEILAR1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 26);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_WILLIAMKEILAR2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 27);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_WILLIAMKEILAR3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 28);
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
        case GOSSIP_ACTION_INFO_DEF:
            //spellId is correct, however it gives flight a somewhat funny effect //TaxiPath 506.
            CloseGossipMenuFor(player);
            player->CastSpell(player, 32474, true);
            break;
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
