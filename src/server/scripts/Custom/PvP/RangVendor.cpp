#include "ScriptMgr.h"
#include "Chat.h"
#include "Player.h"
#include "../ServerMenu/ServerMenuMgr.h"

using namespace std;

#define GetText(a, b, c)    a->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? b : c

#define RankVendorID 44199

class npc_pvp_rang_10 : public CreatureScript
{
public:
    npc_pvp_rang_10() : CreatureScript("npc_pvp_rang_10") { }

    bool OnGossipHello(Player* player, Creature * creature)
    {
        if (!player || !creature)
            return true;

        player->PlayerTalkClass->ClearMenus();
        std::string name = player->GetName();
        std::ostringstream femb;

        if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        {
            femb << "Уважаемый|cff065961 " << name << "|r\n";
            femb << "Для просмотра данных продавцов вам нужно повышать ранги.\n\n";
            femb << "В данном мобе доступны 10 продавцов от первого(1) ранга до десятого(10).\n";
        }
        else
        {
            femb << "Respected|cff065961 " << name << "|r\n";
            femb << "To view these vendors you need to increase the ranks.\n\n";
            femb << "In this mob 10 sellers are available from the first(1) rank to the tenth(10).\n";
        }

        for(int i = 1; i<=10; i++)
            if(player->GetAuraCount(71201) >= static_cast<uint32>(i))
                AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "|TInterface\\icons\\Ability_warrior_rampage:20:20:0:0|t > Rank " + to_string(i), GOSSIP_SENDER_MAIN, RankVendorID + i);

        if (player->GetAuraCount(71201) == 0)
        {
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, GetText(player,"Вам нужно поднять ранги для просмотра содержимого","You need to up Rank for open vendor."), GOSSIP_SENDER_MAIN, 0);
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, GetText(player, "До свидания","Goodbye"), GOSSIP_SENDER_MAIN, 0);
        }

        player->PlayerTalkClass->SendGossipMenu(femb.str().c_str(), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        if (!action || !player || !creature)
            return true;

        uint32 rankplayer = action - RankVendorID;
        player->PlayerTalkClass->ClearMenus();

        if(player->GetAuraCount(71201) >= rankplayer)
            player->GetSession()->SendListInventory(creature->GetGUID(), action);

        return true;
    }
};

class npc_pvp_rang_20 : public CreatureScript
{
public:
        npc_pvp_rang_20() : CreatureScript("npc_pvp_rang_20") { }

    bool OnGossipHello(Player* player, Creature * creature)
    {
        if (!player || !creature)
            return true;

        player->PlayerTalkClass->ClearMenus();
        std::string name = player->GetName();
        std::ostringstream femb;

        if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        {
            femb << "Уважаемый|cff065961 " << name << "|r\n";
            femb << "Для просмотра данных продавцов вам нужно повышать ранги.\n\n";
            femb << "В данном мобе доступны 10 продавцов от одиннадцатого(11) ранга до двадцатого(20).\n";
        }
        else
        {
            femb << "Respected|cff065961 " << name << "|r\n";
            femb << "To view these vendors you need to increase the ranks.\n\n";
            femb << "In this mob 10 sellers are available from the eleventh(11) rank to the twentieth(20).\n";
        }

        for(int i = 11; i<=20; i++)
            if(player->GetAuraCount(71201) >= static_cast<uint32>(i))
                AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "|TInterface\\icons\\Ability_warrior_rampage:20:20:0:0|t > Rank " + to_string(i), GOSSIP_SENDER_MAIN, RankVendorID + i);

        if (player->GetAuraCount(71201) < 11)
        {
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, GetText(player,"Вам нужно поднять ранги для просмотра содержимого","You need to up Rank for open vendor."), GOSSIP_SENDER_MAIN, 0);
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, GetText(player, "До свидания","Goodbye"), GOSSIP_SENDER_MAIN, 0);
        }

        player->PlayerTalkClass->SendGossipMenu(femb.str().c_str(), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        if (!action || !player || !creature)
            return true;

        uint32 rankplayer = action - RankVendorID;
        player->PlayerTalkClass->ClearMenus();

        if(player->GetAuraCount(71201) >= rankplayer)
            player->GetSession()->SendListInventory(creature->GetGUID(), action);

        return true;
    }
};

class npc_pvp_rang_30 : public CreatureScript
{
public:
        npc_pvp_rang_30() : CreatureScript("npc_pvp_rang_30") { }

    bool OnGossipHello(Player* player, Creature * creature)
    {
        if (!player || !creature)
            return true;

        player->PlayerTalkClass->ClearMenus();
        std::string name = player->GetName();
        std::ostringstream femb;

        if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        {
            femb << "Уважаемый|cff065961 " << name << "|r\n";
            femb << "Для просмотра данных продавцов вам нужно повышать ранги.\n\n";
            femb << "В данном мобе доступны 10 продавцов от двадцать первого(21) ранга до тридцатого(30).\n";
        }
        else
        {
            femb << "Respected|cff065961 " << name << "|r\n";
            femb << "To view these vendors you need to increase the ranks.\n\n";
            femb << "In this mob 10 sellers are available from the twenty-first(21) rank to the thirtieth(30).\n";
        }

        for(int i = 21; i<=30; i++)
            if(player->GetAuraCount(71201) >= static_cast<uint32>(i))
                AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "|TInterface\\icons\\Ability_warrior_rampage:20:20:0:0|t > Rank " + to_string(i), GOSSIP_SENDER_MAIN, RankVendorID + i);

        if (player->GetAuraCount(71201) < 21)
        {
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, GetText(player,"Вам нужно поднять ранги для просмотра содержимого","You need to up Rank for open vendor."), GOSSIP_SENDER_MAIN, 0);
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, GetText(player, "До свидания","Goodbye"), GOSSIP_SENDER_MAIN, 0);
        }

        player->PlayerTalkClass->SendGossipMenu(femb.str().c_str(), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        if (!action || !player || !creature)
            return true;

        uint32 rankplayer = action - RankVendorID;
        player->PlayerTalkClass->ClearMenus();

        if(player->GetAuraCount(71201) >= rankplayer)
            player->GetSession()->SendListInventory(creature->GetGUID(), action);

        return true;
    }
};

class npc_pvp_rang_40 : public CreatureScript
{
public:
        npc_pvp_rang_40() : CreatureScript("npc_pvp_rang_40") { }

    bool OnGossipHello(Player* player, Creature * creature)
    {
        if (!player || !creature)
            return true;

        player->PlayerTalkClass->ClearMenus();
        std::string name = player->GetName();
        std::ostringstream femb;

        if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        {
            femb << "Уважаемый|cff065961 " << name << "|r\n";
            femb << "Для просмотра данных продавцов вам нужно повышать ранги.\n\n";
            femb << "В данном мобе доступны 10 продавцов от тридцать первого(31) ранга до сорокового(40).\n";
        }
        else
        {
            femb << "Respected|cff065961 " << name << "|r\n";
            femb << "To view these vendors you need to increase the ranks.\n\n";
            femb << "In this mob 10 sellers are available from the thirty-first(31) rank to the fortieth(40).\n";
        }

        for(int i = 31; i<=40; i++)
            if(player->GetAuraCount(71201) >= static_cast<uint32>(i))
                AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "|TInterface\\icons\\Ability_warrior_rampage:20:20:0:0|t > Rank " + to_string(i), GOSSIP_SENDER_MAIN, RankVendorID + i);

        if (player->GetAuraCount(71201) < 31)
        {
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, GetText(player,"Вам нужно поднять ранги для просмотра содержимого","You need to up Rank for open vendor."), GOSSIP_SENDER_MAIN, 0);
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, GetText(player, "До свидания","Goodbye"), GOSSIP_SENDER_MAIN, 0);
        }

        player->PlayerTalkClass->SendGossipMenu(femb.str().c_str(), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        if (!action || !player || !creature)
            return true;

        uint32 rankplayer = action - RankVendorID;
        player->PlayerTalkClass->ClearMenus();

        if(player->GetAuraCount(71201) >= rankplayer)
            player->GetSession()->SendListInventory(creature->GetGUID(), action);

        return true;
    }
};

class npc_pvp_rang_50 : public CreatureScript
{
public:
    npc_pvp_rang_50() : CreatureScript("npc_pvp_rang_50") { }

    bool OnGossipHello(Player* player, Creature * creature)
    {
        if (!player || !creature)
            return true;

        player->PlayerTalkClass->ClearMenus();
        std::string name = player->GetName();
        std::ostringstream femb;

        if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        {
            femb << "Уважаемый|cff065961 " << name << "|r\n";
            femb << "Для просмотра данных продавцов вам нужно повышать ранги.\n\n";
            femb << "В данном мобе доступны 10 продавцов от сорок первого(41) ранга до пятидесятого(50).\n";
        }
        else
        {
            femb << "Respected|cff065961 " << name << "|r\n";
            femb << "To view these vendors you need to increase the ranks.\n\n";
            femb << "In this mob 10 sellers are available from the forty-one(41) rank to the fiftieth(50).\n";
        }

        for(int i = 41; i<=50; i++)
            if(player->GetAuraCount(71201) >= static_cast<uint32>(i))
                AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "|TInterface\\icons\\Ability_warrior_rampage:20:20:0:0|t > Rank " + to_string(i), GOSSIP_SENDER_MAIN, RankVendorID + i);

        if (player->GetAuraCount(71201) < 41)
        {
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, GetText(player,"Вам нужно поднять ранги для просмотра содержимого","You need to up Rank for open vendor."), GOSSIP_SENDER_MAIN, 0);
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, GetText(player, "До свидания","Goodbye"), GOSSIP_SENDER_MAIN, 0);
        }

        player->PlayerTalkClass->SendGossipMenu(femb.str().c_str(), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        if (!action || !player || !creature)
            return true;

        uint32 rankplayer = action - RankVendorID;
        player->PlayerTalkClass->ClearMenus();

        if(player->GetAuraCount(71201) >= rankplayer)
            player->GetSession()->SendListInventory(creature->GetGUID(), action);
        return true;
    }
};

class npc_pvp_rang_info : public CreatureScript
{
public:
    npc_pvp_rang_info() : CreatureScript("npc_pvp_rang_info") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (!player || !creature)
            return true;

        sServerMenuMgr->RankInfo(player);
        return true;
    }
};

void AddSC_NPC_RANK_VENDOR()
{
    new npc_pvp_rang_10();
    new npc_pvp_rang_20();
    new npc_pvp_rang_30();
    new npc_pvp_rang_40();
    new npc_pvp_rang_50();
    new npc_pvp_rang_info();
}