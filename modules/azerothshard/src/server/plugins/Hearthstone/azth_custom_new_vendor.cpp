#include "Common.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Opcodes.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"

void AzthSendListInventory(uint64 vendorGuid, WorldSession * session, uint32 extendedCostStartValue)
{
	;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Sent SMSG_LIST_INVENTORY");

	Creature* vendor = session->GetPlayer()->GetNPCIfCanInteractWith(vendorGuid, UNIT_NPC_FLAG_VENDOR);
	if (!vendor)
	{
		;//sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: SendListInventory - Unit (GUID: %u) not found or you can not interact with him.", uint32(GUID_LOPART(vendorGuid)));
		session->GetPlayer()->SendSellError(SELL_ERR_CANT_FIND_VENDOR, NULL, 0, 0);
		return;
	}

	// remove fake death
	if (session->GetPlayer()->HasUnitState(UNIT_STATE_DIED))
		session->GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

	// Stop the npc if moving
	if (vendor->HasUnitState(UNIT_STATE_MOVING))
		vendor->StopMoving();

	VendorItemData const* items = vendor->GetVendorItems();
	if (!items)
	{
		WorldPacket data(SMSG_LIST_INVENTORY, 8 + 1 + 1);
		data << uint64(vendorGuid);
		data << uint8(0);                                   // count == 0, next will be error code
		data << uint8(0);                                   // "Vendor has no inventory"
		session->SendPacket(&data);
		return;
	}

	uint8 itemCount = items->GetItemCount();
	uint8 count = 0;

	WorldPacket data(SMSG_LIST_INVENTORY, 8 + 1 + itemCount * 8 * 4);
	data << uint64(vendorGuid);

	size_t countPos = data.wpos();
	data << uint8(count);

	float discountMod = session->GetPlayer()->GetReputationPriceDiscount(vendor);

	for (uint8 slot = 0; slot < itemCount; ++slot)
	{
		if (VendorItem const* item = items->GetItem(slot))
		{
			if (ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(item->item))
			{
				if (!(itemTemplate->AllowableClass & session->GetPlayer()->getClassMask()) && itemTemplate->Bonding == BIND_WHEN_PICKED_UP && !session->GetPlayer()->IsGameMaster())
					continue;
				// Only display items in vendor lists for the team the
				// player is on. If GM on, display all items.
				if (!session->GetPlayer()->IsGameMaster() && ((itemTemplate->Flags2 & ITEM_FLAGS_EXTRA_HORDE_ONLY && session->GetPlayer()->GetTeamId() == TEAM_ALLIANCE) || (itemTemplate->Flags2 == ITEM_FLAGS_EXTRA_ALLIANCE_ONLY && session->GetPlayer()->GetTeamId() == TEAM_HORDE)))
					continue;

				// Items sold out are not displayed in list
				uint32 leftInStock = !item->maxcount ? 0xFFFFFFFF : vendor->GetVendorItemCurrentCount(item);
				if (!session->GetPlayer()->IsGameMaster() && !leftInStock)
					continue;

				ConditionList conditions = sConditionMgr->GetConditionsForNpcVendorEvent(vendor->GetEntry(), item->item);
				if (!sConditionMgr->IsObjectMeetToConditions(session->GetPlayer(), vendor, conditions))
				{
					sLog->outError("SendListInventory: conditions not met for creature entry %u item %u", vendor->GetEntry(), item->item);
					continue;
				}

				// reputation discount
				uint32 ExtendedToGold = item->ExtendedCost > extendedCostStartValue ? (item->ExtendedCost - extendedCostStartValue)*10000 : 0;
				int32 price = item->IsGoldRequired(itemTemplate) ? uint32(floor(itemTemplate->BuyPrice * discountMod)) : ExtendedToGold;

				data << uint32(slot + 1);       // client expects counting to start at 1
				data << uint32(item->item);
				data << uint32(itemTemplate->DisplayInfoID);
				data << int32(leftInStock);
				data << uint32(price);
				data << uint32(itemTemplate->MaxDurability);
				data << uint32(itemTemplate->BuyCount);
				data << uint32(item->ExtendedCost);

				if (++count >= MAX_VENDOR_ITEMS)
					break;
			}
		}
	}

	if (count == 0)
	{
		data << uint8(0);
		session->SendPacket(&data);
		return;
	}

	data.put<uint8>(countPos, count);
	session->SendPacket(&data);
}