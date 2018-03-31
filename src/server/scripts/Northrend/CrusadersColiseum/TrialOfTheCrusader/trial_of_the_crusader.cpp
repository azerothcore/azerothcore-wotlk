/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "trial_of_the_crusader.h"
#include "Player.h"

enum MenuTexts
{
    MSG_TESTED                      = 724001,
    MSG_NEXT_STAGE                  = 724002,
    MSG_CRUSADERS                   = 724003,
    MSG_ANUBARAK                    = 724005,
};

class npc_announcer_toc10 : public CreatureScript
{
public:
    npc_announcer_toc10() : CreatureScript("npc_announcer_toc10") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if( !pCreature->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP) )
            return true;

        InstanceScript* pInstance = pCreature->GetInstanceScript();
        if( !pInstance )
            return true;

        uint32 gossipTextId = 0;
        switch( pInstance->GetData(TYPE_INSTANCE_PROGRESS) )
        {
            case INSTANCE_PROGRESS_INITIAL:
                gossipTextId = MSG_TESTED;
                break;
            case INSTANCE_PROGRESS_INTRO_DONE:
            case INSTANCE_PROGRESS_BEASTS_DEAD:
            case INSTANCE_PROGRESS_FACTION_CHAMPIONS_DEAD:
            case INSTANCE_PROGRESS_VALKYR_DEAD:
                gossipTextId = MSG_NEXT_STAGE;
                break;
            case INSTANCE_PROGRESS_JARAXXUS_DEAD:
                gossipTextId = MSG_CRUSADERS;
                break;
            case INSTANCE_PROGRESS_DONE:
                pCreature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                return true;
            default:
                return true;
        }

        pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "We are ready!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1337);
        pPlayer->SEND_GOSSIP_MENU(gossipTextId, pCreature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*sender*/, uint32 uiAction)
    {
        if( !pCreature->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP) )
            return true;

        InstanceScript* pInstance = pCreature->GetInstanceScript();
        if( !pInstance )
            return true;

        if( uiAction == GOSSIP_ACTION_INFO_DEF+1337 )
        {
            pInstance->SetData(TYPE_ANNOUNCER_GOSSIP_SELECT, 0);
            pCreature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }

        pPlayer->CLOSE_GOSSIP_MENU();
        return true;
    }
};

void AddSC_trial_of_the_crusader()
{
    new npc_announcer_toc10();
}
