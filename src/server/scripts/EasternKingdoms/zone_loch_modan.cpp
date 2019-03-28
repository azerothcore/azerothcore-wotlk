/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Loch_Modan
SD%Complete: 100
SDComment: Quest support: 3181
SDCategory: Loch Modan
EndScriptData */

/* ContentData
npc_mountaineer_pebblebitty
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Player.h"

/*######
## npc_mountaineer_pebblebitty
######*/

#define GOSSIP_MP "Open the gate please, i need to get to Searing Gorge"

#define GOSSIP_MP1 "But i need to get there, now open the gate!"
#define GOSSIP_MP2 "Ok, so what is this other way?"
#define GOSSIP_MP3 "Doesn't matter, i'm invulnerable."
#define GOSSIP_MP4 "Yes..."
#define GOSSIP_MP5 "Ok, i'll try to remember that."
#define GOSSIP_MP6 "A key? Ok!"

class npc_mountaineer_pebblebitty : public CreatureScript
{
public:
    npc_mountaineer_pebblebitty() : CreatureScript("npc_mountaineer_pebblebitty") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_MP1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, 1833, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_MP2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                SendGossipMenuFor(player, 1834, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_MP3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                SendGossipMenuFor(player, 1835, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+4:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_MP4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                SendGossipMenuFor(player, 1836, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+5:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_MP5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, 1837, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+6:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_MP6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
                SendGossipMenuFor(player, 1838, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+7:
                CloseGossipMenuFor(player);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (!player->GetQuestRewardStatus(3181) == 1)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_MP, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
};

void AddSC_loch_modan()
{
    new npc_mountaineer_pebblebitty();
}
