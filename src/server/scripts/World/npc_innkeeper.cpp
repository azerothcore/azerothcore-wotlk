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
#include "GameEventMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

constexpr auto SPELL_TRICK = 24714;
constexpr auto SPELL_TREAT = 24715;
constexpr auto SPELL_TRICKED_OR_TREATED = 24755;
constexpr auto HALLOWEEN_EVENTID = 12;
constexpr auto GOSSIP_MENU = 9733;
constexpr auto GOSSIP_MENU_EVENT = 342;

class npc_innkeeper : public CreatureScript
{
public:
    npc_innkeeper() : CreatureScript("npc_innkeeper") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (IsEventActive(HALLOWEEN_EVENTID) && !player->HasAura(SPELL_TRICKED_OR_TREATED))
        {
            AddGossipItemFor(player, GOSSIP_MENU_EVENT, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + HALLOWEEN_EVENTID);
        }

        if (creature->IsQuestGiver())
        {
            player->PrepareQuestMenu(creature->GetGUID());
        }

        if (creature->IsVendor())
        {
            AddGossipItemFor(player, GOSSIP_MENU, 2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);
        }

        if (creature->IsInnkeeper())
        {
            AddGossipItemFor(player, GOSSIP_MENU, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INN);
        }

        player->TalkedToCreature(creature->GetEntry(), creature->GetGUID());
        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_INFO_DEF + HALLOWEEN_EVENTID && IsEventActive(HALLOWEEN_EVENTID) && !player->HasAura(SPELL_TRICKED_OR_TREATED))
        {
            player->CastSpell(player, SPELL_TRICKED_OR_TREATED, true);
            creature->CastSpell(player, roll_chance_i(50) ? SPELL_TRICK : SPELL_TREAT, true);

            CloseGossipMenuFor(player);
            return true;
        }

        CloseGossipMenuFor(player);

        switch (action)
        {
            case GOSSIP_ACTION_TRADE:
                player->GetSession()->SendListInventory(creature->GetGUID());
                break;
            case GOSSIP_ACTION_INN:
                player->SetBindPoint(creature->GetGUID());
                break;
        }
        return true;
    }
};

void AddSC_npc_innkeeper()
{
    new npc_innkeeper;
}
