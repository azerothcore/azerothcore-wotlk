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

#include "TC9GrpcHandler.h"
#include "Bag.h"
#include "BattlegroundMgr.h"
#include "Item.h"
#include "ObjectAccessor.h"
#include "Player.h"

GetPlayerItemsByGuidsResponse ToCloud9GrpcHandler::GetPlayerItemsByGuids(uint64 playerGuid, uint64* items, int itemsLen)
{
    Player *player = ObjectAccessor::FindPlayer(ObjectGuid(playerGuid));
    if (!player)
    {
        GetPlayerItemsByGuidsResponse resp;
        resp.errorCode = PlayerItemErrorCodePlayerNotFound;
        return resp;
    }

    int itemsFound = 0;
    std::unique_ptr<Item* []> foundItems(new Item * [itemsLen]);
    for (int i = 0; i < itemsLen; i++)
    {
        foundItems[i] = player->GetItemByGuid(ObjectGuid(items[i]));
        if (foundItems[i])
            itemsFound++;
    }

    // Don't forget to delete on "that" side.
    PlayerItem* itemsResult = static_cast<PlayerItem *>(malloc(sizeof(PlayerItem) * itemsFound));
    int itemsResultsItr = 0;
    for (int i = 0; i < itemsLen; i++)
    {
        if (!foundItems[i])
            continue;

        Item* pItem = foundItems[i];

        PlayerItem item;
        item.guid = pItem->GetGUID().GetRawValue();
        item.entry = pItem->GetEntry();
        item.owner = playerGuid;
        item.bagSlot = pItem->GetBagSlot();
        item.slot = pItem->GetSlot();
        item.isTradable = pItem->CanBeTraded(true);
        item.count = pItem->GetCount();
        item.flags = pItem->GetUInt32Value(ITEM_FIELD_FLAGS);
        item.durability = pItem->GetUInt32Value(ITEM_FIELD_DURABILITY);
        item.randomPropertyID = pItem->GetItemRandomPropertyId();

        // Don't forget to delete on "that" side.
        char *text = (char*)malloc(sizeof(char) * (pItem->GetText().length() + 1));
        strcpy(text, pItem->GetText().c_str());
        item.text = text;

        itemsResult[itemsResultsItr] = item;

        itemsResultsItr++;
    }

    GetPlayerItemsByGuidsResponse resp;
    resp.errorCode = PlayerItemErrorCodeNoError;
    resp.items = itemsResult;
    resp.itemsSize = itemsFound;
    return resp;
}

RemoveItemsWithGuidsFromPlayerResponse ToCloud9GrpcHandler::RemoveItemsWithGuidsFromPlayer(uint64 playerGuid, uint64* items, int itemsLen, uint64 assignToPlayerGuid)
{
    Player *player = ObjectAccessor::FindPlayer(ObjectGuid(playerGuid));
    if (!player)
    {
        RemoveItemsWithGuidsFromPlayerResponse resp;
        resp.errorCode = PlayerItemErrorCodePlayerNotFound;
        return resp;
    }

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    int itemsFound = 0;
    std::unique_ptr<uint64[]> deletedItems(new uint64 [itemsLen]);
    for (int i = 0; i < itemsLen; i++)
    {
        Item *item = player->GetItemByGuid(ObjectGuid(items[i]));
        if (!item)
        {
            deletedItems[i] = 0;
            continue;
        }

        itemsFound++;
        deletedItems[i] = item->GetGUID().GetRawValue();

        item->SetNotRefundable(player);
        player->MoveItemFromInventory(item->GetBagSlot(), item->GetSlot(), true);

        item->DeleteFromInventoryDB(trans);
        item->SetOwnerGUID(ObjectGuid(assignToPlayerGuid));
        item->SetState(ITEM_CHANGED);
        item->SaveToDB(trans);

        delete item;
    }

    if (itemsFound > 0)
    {
        player->SaveInventoryAndGoldToDB(trans);
        CharacterDatabase.CommitTransaction(trans);
    }

    // Don't forget to delete on "that" side.
    uint64_t* itemsResult = (uint64_t*)malloc(sizeof(uint64_t) * itemsFound);
    int itemsResultsItr = 0;
    for (int i = 0; i < itemsLen; i++)
    {
        if (deletedItems[i] == 0)
            continue;

        itemsResult[itemsResultsItr] = deletedItems[i];
        itemsResultsItr++;
    }

    RemoveItemsWithGuidsFromPlayerResponse resp;
    resp.errorCode = PlayerItemErrorCodeNoError;
    resp.updatedItems = itemsResult;
    resp.updatedItemsSize = itemsResultsItr;
    return resp;

}

PlayerItemErrorCode ToCloud9GrpcHandler::AddExistingItemToPlayer(AddExistingItemToPlayerRequest* request)
{
    Player *player = ObjectAccessor::FindPlayer(ObjectGuid(request->playerGuid));
    if (!player)
        return PlayerItemErrorCodePlayerNotFound;

    ItemTemplate const* proto = sObjectMgr->GetItemTemplate(request->itemEntry);
    if (!proto)
        return PlayerItemErrorUnknownTemplate;

    Item* item = NewItemOrBag(proto);
    if (!item->Create(ObjectGuid(request->itemGuid).GetCounter(), request->itemEntry, player))
    {
        delete item;
        return PlayerItemErrorFailedToCreateItem;
    }

    item->SetUInt32Value(ITEM_FIELD_FLAGS, request->itemFlags);
    item->SetUInt32Value(ITEM_FIELD_DURABILITY, request->itemDurability);
    item->SetItemRandomProperties(request->itemRandomPropertyID);
    item->SetCount(request->itemCount);

    // TODO: Add text.

    ItemPosCountVec dest;
    uint8 msg = player->CanStoreItem(NULL_BAG, NULL_SLOT, dest, item, false);
    if (msg != EQUIP_ERR_OK)
    {
        delete item;
        return PlayerItemErrorNoInventorySpace;
    }

    player->MoveItemToInventory(dest, item, true);

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    player->SaveInventoryAndGoldToDB(trans);
    CharacterDatabase.CommitTransaction(trans);

    return PlayerItemErrorCodeNoError;
}

GetMoneyForPlayerResponse ToCloud9GrpcHandler::GetMoneyForPlayer(uint64 playerGuid)
{
    Player *player = ObjectAccessor::FindPlayer(ObjectGuid(playerGuid));
    if (!player)
    {
        GetMoneyForPlayerResponse resp;
        resp.errorCode = PlayerMoneyErrorCodePlayerNotFound;
        return resp;
    }

    GetMoneyForPlayerResponse resp;
    resp.errorCode = PlayerMoneyErrorCodeNoError;
    resp.money = player->GetMoney();
    return resp;
}

ModifyMoneyForPlayerResponse ToCloud9GrpcHandler::ModifyMoneyForPlayer(uint64 playerGuid, int32 value)
{
    Player *player = ObjectAccessor::FindPlayer(ObjectGuid(playerGuid));
    if (!player)
    {
        ModifyMoneyForPlayerResponse resp;
        resp.errorCode = PlayerMoneyErrorCodePlayerNotFound;
        return resp;
    }

    if (!player->ModifyMoney(value, true))
    {
        ModifyMoneyForPlayerResponse resp;
        resp.errorCode = PlayerMoneyErrorCodeToMuchMoney;
        resp.newMoneyValue = player->GetMoney();
        return resp;
    }

    ModifyMoneyForPlayerResponse resp;
    resp.errorCode = PlayerMoneyErrorCodeNoError;
    resp.newMoneyValue = player->GetMoney();
    return resp;
}

CanPlayerInteractWithGOAndTypeResponse ToCloud9GrpcHandler::CanPlayerInteractWithGOAndType(uint64 playerGuid, uint64 go, uint8 goType)
{
    Player *player = ObjectAccessor::FindPlayer(ObjectGuid(playerGuid));
    if (!player)
    {
        CanPlayerInteractWithGOAndTypeResponse resp;
        resp.errorCode = PlayerInteractionErrorCodeCodePlayerNotFound;
        return resp;
    }

    CanPlayerInteractWithGOAndTypeResponse resp;
    resp.errorCode = PlayerInteractionErrorCodeNoError;
    resp.canInteract = player->GetGameObjectIfCanInteractWith(ObjectGuid(go), (GameobjectTypes)goType) != nullptr;
    return resp;
}

CanPlayerInteractWithNPCAndFlagsResponse ToCloud9GrpcHandler::CanPlayerInteractWithNPCAndFlags(uint64 playerGuid, uint64 npc, uint32 unitFlags)
{
    Player *player = ObjectAccessor::FindPlayer(ObjectGuid(playerGuid));
    if (!player)
    {
        CanPlayerInteractWithNPCAndFlagsResponse resp;
        resp.errorCode = PlayerInteractionErrorCodeCodePlayerNotFound;
        return resp;
    }

    CanPlayerInteractWithNPCAndFlagsResponse resp;
    resp.errorCode = PlayerInteractionErrorCodeNoError;
    resp.canInteract = player->GetNPCIfCanInteractWith(ObjectGuid(npc), (NPCFlags)unitFlags) != nullptr;
    return resp;
}

BattlegroundStartResponse ToCloud9GrpcHandler::StartBattleground(BattlegroundStartRequest* req)
{
    PvPDifficultyEntry const* pvpEntry = GetBattlegroundBracketByLevel(req->mapID, req->bracketLvl);
    if (!pvpEntry)
    {
        BattlegroundStartResponse resp;
        resp.errorCode = BattlegroundErrorFailedToCreateBG;
        return resp;
    }

    BattlegroundTypeId bgTypeId = BattlegroundTypeId(req->battlegroundTypeID);

    Battleground* bg = sBattlegroundMgr->CreateNewBattleground(bgTypeId, pvpEntry, req->arenaType, req->isRated);
    if (!bg)
    {
        BattlegroundStartResponse resp;
        resp.errorCode = BattlegroundErrorFailedToCreateBG;
        return resp;
    }

    bg->StartBattleground();

    bg->IncreaseInvitedCount(TEAM_HORDE);
    bg->IncreaseInvitedCount(TEAM_ALLIANCE);

    BattlegroundStartResponse resp;
    resp.errorCode = BattlegroundErrorCodeNoError;
    resp.instanceID = bg->GetInstanceID();
    resp.instanceClientID = bg->GetClientInstanceID();
    return resp;
}

BattlegroundErrorCode ToCloud9GrpcHandler::AddPlayersToBattleground(BattlegroundAddPlayersRequest* request)
{
    BattlegroundTypeId bgTypeId = BattlegroundTypeId(request->battlegroundTypeID);

    Battleground* bg = sBattlegroundMgr->GetBattleground(request->instanceID, BATTLEGROUND_TYPE_NONE);
    if (!bg)
        return BattlegroundErrorBattlegroundNotFound;

    for (int i = 0; i < request->alliancePlayersToAddSize; i++)
    {
        Player *player = ObjectAccessor::FindPlayer(ObjectGuid(request->alliancePlayersToAdd[i]));
        if (player)
        {
            player->SetEntryPoint();
            player->SetBattlegroundId(bg->GetInstanceID(), bg->GetBgTypeID(), 1, true, bgTypeId == BATTLEGROUND_RB, player->GetTeamId(true));
            sBattlegroundMgr->SendToBattleground(player, bg->GetInstanceID(), bgTypeId);
        }
    }

    for (int i = 0; i < request->hordePlayersToAddSize; i++)
    {
        Player *player = ObjectAccessor::FindPlayer(ObjectGuid(request->hordePlayersToAdd[i]));
        if (player)
        {
            player->SetEntryPoint();
            player->SetBattlegroundId(bg->GetInstanceID(), bg->GetBgTypeID(), 1, true, bgTypeId == BATTLEGROUND_RB, player->GetTeamId(true));
            sBattlegroundMgr->SendToBattleground(player, bg->GetInstanceID(), bgTypeId);
        }
    }

    return BattlegroundErrorCodeNoError;
}

BattlegroundJoinCheckErrorCode ToCloud9GrpcHandler::CanPlayerJoinBattlegroundQueue(uint64 playerGuid)
{
    Player *player = ObjectAccessor::FindPlayer(ObjectGuid(playerGuid));
    if (!player)
        return BattlegroundJoinCheckErrorCodePlayerNotFound;

    // has deserter debuff
    if (!player->CanJoinToBattleground())
        return BattlegroundJoinCheckErrorCodeResponseIsFalse;

    // don't let Death Knights join BG queues when they are not allowed to be teleported yet
    if (player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_TELEPORT) && player->GetMapId() == 609 && !player->IsGameMaster() && !player->HasSpell(50977))
        return BattlegroundJoinCheckErrorCodeResponseIsFalse;

    return BattlegroundJoinCheckErrorCodeOK;
}

BattlegroundJoinCheckErrorCode ToCloud9GrpcHandler::CanPlayerTeleportToBattleground(uint64 playerGuid)
{
    Player *player = ObjectAccessor::FindPlayer(ObjectGuid(playerGuid));
    if (!player)
        return BattlegroundJoinCheckErrorCodePlayerNotFound;

    if (player->GetCharmGUID() || player->IsInCombat())
        return BattlegroundJoinCheckErrorCodeResponseIsFalse;

    return BattlegroundJoinCheckErrorCodeOK;
}
