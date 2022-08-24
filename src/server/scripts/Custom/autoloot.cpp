#include "ScriptMgr.h"
#include "Player.h"
#include "Creature.h"
#include "LootMgr.h"
#include "Config.h"
#include "Group.h"
#include "WorldSession.h"


class AutoLoot : public PlayerScript
{
public:
	AutoLoot() : PlayerScript("AutoLoot") {}

	void OnCreatureKill(Player* player, Creature* creature) {
		//get any loot the creature has
		Loot* loot(&creature->loot);

		//check if player is in group
		//i'm still looking into how to make this work
		if (Group* grp = player->GetGroup())
        {
			// @todo: implement group auto loot
		}
		else if ((player->GetMapId() == 230 || player->GetMapId() == 37 || player->GetMapId() == 580 || player->GetAreaId() == 3539 || player->GetZoneId() == 3525 || player->GetAreaId() == 3759 || player->GetMapId() == 624 || player->GetMapId() == 533 || player->GetMapId() == 585 || player->GetMapId() == 615 || player->GetAreaId() == 35 || player->GetZoneId() == 2817 || player->GetAreaId() == 279 || player->GetMapId() == 550) && sConfigMgr->GetOption<bool>("AOE.Enable", true))
        {
			if (player->isAllowedToLoot(creature))
            {
				if (!loot->isLooted() && !loot->empty())
                {
					//loot gold
					uint32 gold = loot->gold;
					if (gold > 0) {
						player->ModifyMoney(gold);
					}

					//iterate over all available items
					uint8 maxSlot = loot->GetMaxSlotInLootFor(player);
					for (int i = 0; i < maxSlot; ++i) {
						//the method name here is a bit misleading, it just returns the item at a specific slot of the loot list
						LootItem* item = loot->LootItemInSlot(i, player);
						//so you have to add the item manually
						player->AddItem(item->itemid, item->count);
					}

					//because we don't remove the items as they are looted, clear the loot list
					loot->clear();
				}
			}
		}
	}
    void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea)
    {
        if ((newZone == 268 || newZone == 4075 || newArea == 3539 || newZone == 3525 || newArea == 3759 || newZone == 4603 || newArea == 35 || newArea == 279 || newArea == 3456) && sConfigMgr->GetOption<bool>("AOE.Enable", true))
        {
           ChatHandler(player->GetSession()).PSendSysMessage("В данной локации работает [Автолут]. Проверьте свободное место в своих сумках.");
        }
    }
};

void AddSC_AutoLoot()
{
	new AutoLoot();
};
