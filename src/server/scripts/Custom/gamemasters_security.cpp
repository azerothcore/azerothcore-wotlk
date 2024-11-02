#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "ScriptedGossip.h"
#include "ScriptedCreature.h"
#include "Player.h"
#include "Unit.h"
#include "World.h"
#include "WorldSession.h"
class gamemasters_security : public PlayerScript
{
public:
    gamemasters_security() : PlayerScript("gamemasters_security") {}
    void OnLogin(Player* player) override
    {
        // Prevent GMs at all ranks to play as a normal player
        if (player->GetSession()->GetSecurity() == 1 || player->GetSession()->GetSecurity() == 2 || player->GetSession()->GetSecurity() == 3)
        {
            for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; slot++)
                player->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);
            for (uint8 slot = INVENTORY_SLOT_BAG_START; slot < INVENTORY_SLOT_BAG_END; slot++)
                player->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);
            for (uint8 slot = INVENTORY_SLOT_ITEM_START; slot < INVENTORY_SLOT_ITEM_END; slot++)
                player->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);
            for (uint8 slot = BANK_SLOT_ITEM_START; slot < BANK_SLOT_ITEM_END; slot++)
                player->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);
            for (uint8 slot = BANK_SLOT_BAG_START; slot < BANK_SLOT_BAG_END; slot++)
                player->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);
            for (uint8 slot = BUYBACK_SLOT_START; slot < BUYBACK_SLOT_END; slot++)
                player->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);
            player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 2586, true);
            player->EquipNewItem(EQUIPMENT_SLOT_FEET, 11508, true);
            player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 12064, true);
        }
    }
};
    void AddSC_Security_Scripts()
    {
        new gamemasters_security;
    }