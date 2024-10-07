#include "DBCStores.h"
#include "Define.h"
#include "GossipDef.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "NpcProfessionMgr.h"

class Professions_NPC : public CreatureScript
{
public:
    Professions_NPC() : CreatureScript("Professions_NPC") {}

    bool OnGossipHello(Player* player, Creature* creature)
    {
        sProfessionMgr->ReagentsMenu(player, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (sender)
        {
            case GOSSIP_SENDER_MAIN: {
                player->GetSession()->SendListInventory(creature->GetGUID(), action);
            } break;
        }
        return true;
    }
};

class Professions_ : public CreatureScript
{
public:
    Professions_() : CreatureScript("Professions_") {}

    bool OnGossipHello(Player* player, Creature* creature)
    {
        sProfessionMgr->MainMenu(player, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (sender)
        {
            case GOSSIP_SENDER_MAIN: {
                switch (action) {
                    case 0: sProfessionMgr->MainMenu(player, creature); break; /* начальное меню проф*/
                    case 1: sProfessionMgr->PrimaryMenu(player, creature); break; /* меню основных проф */
                    case 2: sProfessionMgr->SecondMenu(player, creature);  break; /* меню вторичных проф */
                    case 3: OnGossipHello(player, creature); break; /* начальное меню */
                }
            } break;
            case GOSSIP_SENDER_MAIN + 1: {
                if (!player->HasSkill(action))
                    sProfessionMgr->CompleteLearnProfession(player, action);
            } break;
        }
        return true;
    }
};

void AddSC_Professions_NPC()
{
    new Professions_NPC();
    new Professions_();
}
