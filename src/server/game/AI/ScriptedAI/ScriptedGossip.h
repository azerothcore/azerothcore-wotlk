/* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 *
 *
 * This program is free software licensed under GPL version 2
 * Please see the included DOCS/LICENSE.TXT for more information */

#ifndef SC_GOSSIP_H
#define SC_GOSSIP_H

#include "GossipDef.h"
#include "QuestDef.h"

// Gossip Item Text
#define GOSSIP_TEXT_BROWSE_GOODS        "I'd like to browse your goods."
#define GOSSIP_TEXT_TRAIN               "Train me!"

enum eTradeskill
{
    // Skill defines
    TRADESKILL_ALCHEMY                  = 1,
    TRADESKILL_BLACKSMITHING            = 2,
    TRADESKILL_COOKING                  = 3,
    TRADESKILL_ENCHANTING               = 4,
    TRADESKILL_ENGINEERING              = 5,
    TRADESKILL_FIRSTAID                 = 6,
    TRADESKILL_HERBALISM                = 7,
    TRADESKILL_LEATHERWORKING           = 8,
    TRADESKILL_POISONS                  = 9,
    TRADESKILL_TAILORING                = 10,
    TRADESKILL_MINING                   = 11,
    TRADESKILL_FISHING                  = 12,
    TRADESKILL_SKINNING                 = 13,
    TRADESKILL_JEWLCRAFTING             = 14,
    TRADESKILL_INSCRIPTION              = 15,

    TRADESKILL_LEVEL_NONE               = 0,
    TRADESKILL_LEVEL_APPRENTICE         = 1,
    TRADESKILL_LEVEL_JOURNEYMAN         = 2,
    TRADESKILL_LEVEL_EXPERT             = 3,
    TRADESKILL_LEVEL_ARTISAN            = 4,
    TRADESKILL_LEVEL_MASTER             = 5,
    TRADESKILL_LEVEL_GRAND_MASTER       = 6,

    // Gossip defines
    GOSSIP_ACTION_TRADE                 = 1,
    GOSSIP_ACTION_TRAIN                 = 2,
    GOSSIP_ACTION_TAXI                  = 3,
    GOSSIP_ACTION_GUILD                 = 4,
    GOSSIP_ACTION_BATTLE                = 5,
    GOSSIP_ACTION_BANK                  = 6,
    GOSSIP_ACTION_INN                   = 7,
    GOSSIP_ACTION_HEAL                  = 8,
    GOSSIP_ACTION_TABARD                = 9,
    GOSSIP_ACTION_AUCTION               = 10,
    GOSSIP_ACTION_INN_INFO              = 11,
    GOSSIP_ACTION_UNLEARN               = 12,
    GOSSIP_ACTION_INFO_DEF              = 1000,

    GOSSIP_SENDER_MAIN                  = 1,
    GOSSIP_SENDER_INN_INFO              = 2,
    GOSSIP_SENDER_INFO                  = 3,
    GOSSIP_SENDER_SEC_PROFTRAIN         = 4,
    GOSSIP_SENDER_SEC_CLASSTRAIN        = 5,
    GOSSIP_SENDER_SEC_BATTLEINFO        = 6,
    GOSSIP_SENDER_SEC_BANK              = 7,
    GOSSIP_SENDER_SEC_INN               = 8,
    GOSSIP_SENDER_SEC_MAILBOX           = 9,
    GOSSIP_SENDER_SEC_STABLEMASTER      = 10
};

class Creature;

// Clear menu
void ClearGossipMenuFor(Player* player);

// Using provided text, not from DB
void AddGossipItemFor(Player* player, uint32 icon, std::string const& text, uint32 sender, uint32 action);

// Using provided texts, not from DB
void AddGossipItemFor(Player* player, uint32 icon, std::string const& text, uint32 sender, uint32 action, std::string const& popupText, uint32 popupMoney, bool coded);

// Uses gossip item info from DB
void AddGossipItemFor(Player* player, uint32 gossipMenuID, uint32 gossipMenuItemID, uint32 sender, uint32 action);

// Send menu text
void SendGossipMenuFor(Player* player, uint32 npcTextID, uint64 const& guid);
void SendGossipMenuFor(Player* player, uint32 npcTextID, Creature const* creature);

// Close menu
void CloseGossipMenuFor(Player* player);

/// Old macro. Need delete later
// This fuction add's a menu item,
// a - Icon Id
// b - Text
// c - Sender(this is to identify the current Menu with this item)
// d - Action (identifys this Menu Item)
// e - Text to be displayed in pop up box
// f - Money value in pop up box
#define ADD_GOSSIP_ITEM(a, b, c, d) PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, a, b, c, d, "", 0)
#define ADD_GOSSIP_ITEM_EXTENDED(a, b, c, d, e, f, g)   PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, a, b, c, d, e, f, g)

// This fuction Sends the current menu to show to client, a - NPCTEXTID(uint32), b - npc guid(uint64)
#define SEND_GOSSIP_MENU(a, b)  PlayerTalkClass->SendGossipMenu(a, b)

// Closes the Menu
#define CLOSE_GOSSIP_MENU() PlayerTalkClass->SendCloseGossip()

#endif
