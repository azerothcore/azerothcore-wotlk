#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "Player.h"

/*
class azth_smart_stone : public ItemScript
{
    public:

        gossip_custom_item()
            : ItemScript("azth_smart_stone")
        {
        }

        bool OnUse(Player* player, Item* item, SpellCastTargets const& targets)
        {
            
            player->ADD_GOSSIP_ITEM( 2, "Example 1", GOSSIP_SENDER_MAIN, 1);

            player->ADD_GOSSIP_ITEM( 2, "|TInterface/ICONS/INV_Misc_Coin_03:30|t Example 2", GOSSIP_SENDER_MAIN, 2);
            
            
            // acquista app
            
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, item->GetGUID());

            return true;
        }
        
        void OnGossipSelect(Player* player, Item* item, uint32 sender, uint32 action) override
        {
            player->PlayerTalkClass->ClearMenus();

            switch (action)
            {
                case 1:
                    player->SetDisplayId(999);
                    break;
                case 2:
                    player->DeMorph();
                    break;
                case 3:
                    break;
            }
            player->CLOSE_GOSSIP_MENU();
        }
};

void AddSC_azth_smart_stone() // Add to scriptloader normally
{
    new azth_smart_stone();
}

*/