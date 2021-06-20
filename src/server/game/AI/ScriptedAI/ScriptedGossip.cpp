/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptedGossip.h"
#include "Player.h"
#include "Creature.h"

void ClearGossipMenuFor(Player* player)
{
    player->PlayerTalkClass->ClearMenus();
}

// Using provided text, not from DB
void AddGossipItemFor(Player* player, uint32 icon, std::string const& text, uint32 sender, uint32 action)
{
    player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, icon, text, sender, action, "", 0);
}

// Using provided texts, not from DB
void AddGossipItemFor(Player* player, uint32 icon, std::string const& text, uint32 sender, uint32 action, std::string const& popupText, uint32 popupMoney, bool coded)
{
    player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, icon, text, sender, action, popupText, popupMoney, coded);
}

// Uses gossip item info from DB
void AddGossipItemFor(Player* player, uint32 gossipMenuID, uint32 gossipMenuItemID, uint32 sender, uint32 action)
{
    player->PlayerTalkClass->GetGossipMenu().AddMenuItem(gossipMenuID, gossipMenuItemID, sender, action);
}

void SendGossipMenuFor(Player* player, uint32 npcTextID, uint64 const& guid)
{
    player->PlayerTalkClass->SendGossipMenu(npcTextID, guid);
}

void SendGossipMenuFor(Player* player, uint32 npcTextID, Creature const* creature)
{
    if (creature)
        SendGossipMenuFor(player, npcTextID, creature->GetGUID());
}

void CloseGossipMenuFor(Player* player)
{
    player->PlayerTalkClass->SendCloseGossip();
}
