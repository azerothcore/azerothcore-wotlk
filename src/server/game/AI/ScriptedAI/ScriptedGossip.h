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

#ifndef SC_GOSSIP_H
#define SC_GOSSIP_H

#include "GossipDef.h"
#include "QuestDef.h"

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
void AddGossipItemFor(Player* player, uint32 gossipMenuID, uint32 gossipMenuItemID, uint32 sender, uint32 action, uint32 boxMoney = 0);
void AddGossipItemFor(Player* player, std::pair<uint32, uint32> gossip, uint32 sender, uint32 action, uint32 boxMoney = 0);

// Send menu text
void SendGossipMenuFor(Player* player, uint32 npcTextID, ObjectGuid const guid);
void SendGossipMenuFor(Player* player, uint32 npcTextID, Creature const* creature);

// Close menu
void CloseGossipMenuFor(Player* player);

constexpr std::pair<uint32, uint32> gossip_browse_your_goods        = { 9733, 2 };    // I'd like to browse your goods.
constexpr std::pair<uint32, uint32> gossip_train_me                 = { 0, 3 };       // Train me!
constexpr std::pair<uint32, uint32> gossip_Lokhtos_0                = { 4781, 0 };    // Show me what I have access to, Lokhtos.
constexpr std::pair<uint32, uint32> gossip_Lokhtos_1                = { 4781, 1 };    // Get Thorium Brotherhood Contract
constexpr std::pair<uint32, uint32> gossip_Continue                 = { 1828, 1 };    // Continue...
constexpr std::pair<uint32, uint32> gossip_Gloomrel_0               = { 1828, 0 };    // I have paid your price, Gloom'rel.  Now, teach me your secrets!
constexpr std::pair<uint32, uint32> gossip_Gloomrel_1               = { 1828, 1 };    // Gloom'rel, tell me your secrets!
constexpr std::pair<uint32, uint32> gossip_Doomrel_0                = { 1947, 0 };    // Your bondage is at an end, Doom'rel.  I challenge you!
constexpr std::pair<uint32, uint32> gossip_tell_me_more             = { 4093, 0 };    // Tell me more.
constexpr std::pair<uint32, uint32> gossip_what_else                = { 4109, 0 };    // What else do you have to say?
constexpr std::pair<uint32, uint32> gossip_where_is_master          = { 4108, 0 };    // You challenged us and we have come. Where is this master you speak of?
constexpr std::pair<uint32, uint32> gossip_challenge_dk             = { 9765, 0 };    // I challenge you, death knight!
constexpr std::pair<uint32, uint32> gossip_i_am_ready_highlord      = { 9795, 0 };    // I am ready, Highlord. Let the siege of Light's Hope begin!
constexpr std::pair<uint32, uint32> gossip_what_do_you_mean         = { 2903, 0 };    // What do you mean?
constexpr std::pair<uint32, uint32> gossip_how_do_you_know_all      = { 8280, 0 };    // How do you know all of this?
constexpr std::pair<uint32, uint32> gossip_guldan_is_my_answer      = { 4764, 1 };    // Gul'dan is my answer.
constexpr std::pair<uint32, uint32> gossip_kelthuzad_is_my_answer   = { 4764, 0 };    // Kel'Thuzad is my answer.
constexpr std::pair<uint32, uint32> gossip_nerzhul_is_my_answer     = { 4764, 3 };    // Ner'zhul is my answer.
constexpr std::pair<uint32, uint32> gossip_we_are_ready_lets_go     = { 10860, 0 };   // We're ready! Let's go!
constexpr std::pair<uint32, uint32> gossip_jaina_intro              = { 10943, 0 };   // What would you have of me, my lady?
constexpr std::pair<uint32, uint32> gossip_jsylvanas_intro          = { 10971, 0 };   // What would you have of me, Banshee Queen?
constexpr std::pair<uint32, uint32> gossip_can_you_remove_sword     = { 10950, 0 };   // Can you remove the sword?
constexpr std::pair<uint32, uint32> gossip_dark_lady_i_hear_arthas  = { 10950, 1 };   // Dark Lady, I think I hear Arthas coming. Whatever you're going to do, do it quickly.
constexpr std::pair<uint32, uint32> gossip_my_lady_i_hear_arthas    = { 11031, 1 };   // My lady, I think I hear Arthas coming. Whatever you're going to do, do it quickly.
constexpr std::pair<uint32, uint32> gossip_we_ready_lk_must_fall    = { 10953, 0 };   // We are ready to go, High Overlord. The Lich King must fall!
constexpr std::pair<uint32, uint32> gossip_what_should_we_do        = { 9573, 0 };    // What should we do next? //9574-0

constexpr std::pair<uint32, uint32> gossip_exchange_amber_emerald   = { 9573, 2 };    // I want to exchange my Amber Essence for Emerald Essence.
constexpr std::pair<uint32, uint32> gossip_exchange_emerald_amber   = { 9574, 2 };    // I want to exchange my Emerald Essence for Amber Essence.
constexpr std::pair<uint32, uint32> gossip_exchange_ruby_emerald    = { 9574, 3 };    // I want to exchange my Ruby Essence for Emerald Essence.
constexpr std::pair<uint32, uint32> gossip_exchange_amber_ruby      = { 9575, 1 };    // I want to exchange my Amber Essence for Ruby Essence.
constexpr std::pair<uint32, uint32> gossip_exchange_emerald_ruby    = { 9575, 2 };    // I want to exchange my Emerald Essence for Ruby Essence.

constexpr std::pair<uint32, uint32> gossip_want_fly_green_flight    = { 9573, 1 };    // I want to fly on the wings of the green flight.
constexpr std::pair<uint32, uint32> gossip_want_fly_bronze_flight   = { 9574, 1 };    // I want to fly on the wings of the bronze flight.
constexpr std::pair<uint32, uint32> gossip_want_fly_red_flight      = { 9575, 0 };    // I want to fly on the wings of the red flight.

constexpr std::pair<uint32, uint32> gossip_what_abil_emerald_have   = { 9573, 4 };    // What abilities do emerald drakes have?
constexpr std::pair<uint32, uint32> gossip_what_abil_amber_have     = { 9574, 4 };    // What abilities do amber drakes have?
constexpr std::pair<uint32, uint32> gossip_what_abil_ruby_have      = { 9575, 3 };    // What abilities do ruby drakes have?

constexpr std::pair<uint32, uint32> gossip_where_do_we_go           = { 9708, 0 };    // So where do we go from here?

#endif
