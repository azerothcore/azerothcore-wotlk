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

#define GOSSIP_NETHER_DRAKE     "我准备起飞了！带我飞翔吧，龙！"
#define GOSSIP_IRONWING         "我想飞去暴风城港口。"
#define GOSSIP_DABIREE1         "送我去穆尔凯斯和沙德拉兹之门"
#define GOSSIP_DABIREE2         "送我去破碎岗哨"
#define GOSSIP_BRACK1           "送我去穆尔凯斯和沙德拉兹之门"
#define GOSSIP_BRACK2           "送我去地狱岩床"
#define GOSSIP_BRACK3           "送我去断背岗哨"
#define GOSSIP_IRENA            "送我去斯克提斯"
#define GOSSIP_CLOUDBREAKER1    "说到行动，我已下令发动空袭。"
#define GOSSIP_CLOUDBREAKER2    "我需要拦截黎明之刃的援军。"
#define GOSSIP_DRAGONHAWK       "<乘坐龙鹰去太阳之岛。>"
#define GOSSIP_VERONIA          "请送我去法力熔炉：库鲁恩"
#define GOSSIP_DEESAK           "请送我去奥格瑞拉"
#define GOSSIP_AFRASASTRASZ1    "我想返回神殿底层，阿弗拉沙斯塔兹。"
#define GOSSIP_AFRASASTRASZ2    "指挥官，我想去龙眠神殿顶层。"
#define GOSSIP_TARIOLSTRASZ1    "指挥官，我想去龙眠神殿顶层。"
#define GOSSIP_TARIOLSTRASZ2    "能让我搭乘幼龙前往龙眠神殿中层，与阿弗拉沙斯塔兹会面吗？"
#define GOSSIP_TORASTRASZA1     "我想去龙眠神殿中层，与阿弗拉沙斯塔兹指挥官谈一谈。"
#define GOSSIP_TORASTRASZA2     "嗯，我想返回神殿底层。"
#define GOSSIP_CRIMSONWING      "<骑狮鹫去调查奥卡兹岛>"
#define GOSSIP_WILLIAMKEILAR1   "送我去北地哨塔。"
#define GOSSIP_WILLIAMKEILAR2   "送我去东墙哨塔。"
#define GOSSIP_WILLIAMKEILAR3   "送我去皇冠哨塔。"

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
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_CRIMSONWING, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 25);
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
