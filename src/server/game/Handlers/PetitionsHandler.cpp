/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "Language.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "PetitionMgr.h"
#include "ScriptMgr.h"
#include "SocialMgr.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandlePetitionBuyOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Received opcode CMSG_PETITION_BUY");
#endif

    ObjectGuid guidNPC;
    uint32 clientIndex;                                     // 1 for guild and arenaslot+1 for arenas in client
    std::string name;

    recvData >> guidNPC;                                   // NPC GUID
    recvData.read_skip<uint32>();                          // 0
    recvData.read_skip<uint64>();                          // 0
    recvData >> name;                                      // name
    recvData.read_skip<std::string>();                     // some string
    recvData.read_skip<uint32>();                          // 0
    recvData.read_skip<uint32>();                          // 0
    recvData.read_skip<uint32>();                          // 0
    recvData.read_skip<uint32>();                          // 0
    recvData.read_skip<uint32>();                          // 0
    recvData.read_skip<uint32>();                          // 0
    recvData.read_skip<uint32>();                          // 0
    recvData.read_skip<uint16>();                          // 0
    recvData.read_skip<uint32>();                          // 0
    recvData.read_skip<uint32>();                          // 0
    recvData.read_skip<uint32>();                          // 0

    for (int i = 0; i < 10; ++i)
        recvData.read_skip<std::string>();

    recvData >> clientIndex;                               // index
    recvData.read_skip<uint32>();                          // 0

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Petitioner (%s) tried sell petition: name %s", guidNPC.ToString().c_str(), name.c_str());
#endif

    // prevent cheating
    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(guidNPC, UNIT_NPC_FLAG_PETITIONER);
    if (!creature)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("network", "WORLD: HandlePetitionBuyOpcode - Unit (%s) not found or you can't interact with him.", guidNPC.ToString().c_str());
#endif
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    uint32 charterid = 0;
    uint32 cost = 0;
    uint32 type = 0;
    if (creature->IsTabardDesigner())
    {
        // if tabard designer, then trying to buy a guild charter.
        // do not let if already in guild.
        if (_player->GetGuildId())
            return;

        charterid = GUILD_CHARTER;
        cost = sWorld->getIntConfig(CONFIG_CHARTER_COST_GUILD);
        type = GUILD_CHARTER_TYPE;
    }
    else
    {
        // TODO: find correct opcode
        if (_player->getLevel() < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
        {
            SendNotification(LANG_ARENA_ONE_TOOLOW, sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL));
            return;
        }

        switch (clientIndex)                                 // arenaSlot+1 as received from client (1 from 3 case)
        {
            case 1:
                charterid = ARENA_TEAM_CHARTER_2v2;
                cost = sWorld->getIntConfig(CONFIG_CHARTER_COST_ARENA_2v2);
                type = ARENA_TEAM_CHARTER_2v2_TYPE;
                break;
            case 2:
                charterid = ARENA_TEAM_CHARTER_3v3;
                cost = sWorld->getIntConfig(CONFIG_CHARTER_COST_ARENA_3v3);
                type = ARENA_TEAM_CHARTER_3v3_TYPE;
                break;
            case 3:
                charterid = ARENA_TEAM_CHARTER_5v5;
                cost = sWorld->getIntConfig(CONFIG_CHARTER_COST_ARENA_5v5);
                type = ARENA_TEAM_CHARTER_5v5_TYPE;
                break;
            default:
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                LOG_DEBUG("network", "unknown selection at buy arena petition: %u", clientIndex);
#endif
                return;
        }

        if (_player->GetArenaTeamId(clientIndex - 1))        // arenaSlot+1 as received from client
        {
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, name, "", ERR_ALREADY_IN_ARENA_TEAM);
            return;
        }
    }

    sScriptMgr->PetitionBuy(_player, creature, charterid, cost, type);

    if (type == GUILD_CHARTER_TYPE)
    {
        if (sGuildMgr->GetGuildByName(name))
        {
            Guild::SendCommandResult(this, GUILD_COMMAND_CREATE, ERR_GUILD_NAME_EXISTS_S, name);
            return;
        }

        if (sObjectMgr->IsReservedName(name) || !ObjectMgr::IsValidCharterName(name))
        {
            Guild::SendCommandResult(this, GUILD_COMMAND_CREATE, ERR_GUILD_NAME_INVALID, name);
            return;
        }
    }
    else
    {
        if (sArenaTeamMgr->GetArenaTeamByName(name))
        {
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, name, "", ERR_ARENA_TEAM_NAME_EXISTS_S);
            return;
        }
        if (sObjectMgr->IsReservedName(name) || !ObjectMgr::IsValidCharterName(name))
        {
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, name, "", ERR_ARENA_TEAM_NAME_INVALID);
            return;
        }
    }

    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(charterid);
    if (!pProto)
    {
        _player->SendBuyError(BUY_ERR_CANT_FIND_ITEM, nullptr, charterid, 0);
        return;
    }

    if (!_player->HasEnoughMoney(cost))
    {
        //player hasn't got enough money
        _player->SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, creature, charterid, 0);
        return;
    }

    ItemPosCountVec dest;
    InventoryResult msg = _player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, charterid, pProto->BuyCount);
    if (msg != EQUIP_ERR_OK)
    {
        _player->SendEquipError(msg, nullptr, nullptr, charterid);
        return;
    }

    _player->ModifyMoney(-(int32)cost);
    Item* charter = _player->StoreNewItem(dest, charterid, true);
    if (!charter)
        return;

    charter->SetUInt32Value(ITEM_FIELD_ENCHANTMENT_1_1, charter->GetGUID().GetCounter());
    // ITEM_FIELD_ENCHANTMENT_1_1 is guild/arenateam id
    // ITEM_FIELD_ENCHANTMENT_1_1+1 is current signatures count (showed on item)
    charter->SetState(ITEM_CHANGED, _player);
    _player->SendNewItem(charter, 1, true, false);

    // a petition is invalid, if both the owner and the type matches
    // we checked above, if this player is in an arenateam, so this must be
    // datacorruption
    Petition const* petition = sPetitionMgr->GetPetitionByOwnerWithType(_player->GetGUID(), type);

    CharacterDatabase.EscapeString(name);
    SQLTransaction trans = CharacterDatabase.BeginTransaction();

    if (petition)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("network", "Invalid petition: %s", petition->petitionGuid.ToString().c_str());
#endif

        trans->PAppend("DELETE FROM petition WHERE petitionguid = %u", petition->petitionGuid);
        trans->PAppend("DELETE FROM petition_sign WHERE petitionguid = %u", petition->petitionGuid);
        // xinef: clear petition store
        sPetitionMgr->RemovePetition(petition->petitionGuid);
    }

    // xinef: petition pointer is invalid from now on

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PETITION);
    stmt->setUInt32(0, _player->GetGUID().GetCounter());
    stmt->setUInt32(1, charter->GetGUID().GetCounter());
    stmt->setString(2, name);
    stmt->setUInt8(3, uint8(type));
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);

    // xinef: fill petition store
    sPetitionMgr->AddPetition(charter->GetGUID(), _player->GetGUID(), name, uint8(type));
}

void WorldSession::HandlePetitionShowSignOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Received opcode CMSG_PETITION_SHOW_SIGNATURES");
#endif

    ObjectGuid petitionguid;
    recvData >> petitionguid;                              // petition guid

    // solve (possible) some strange compile problems with explicit use petition low guid at some GCC versions (wrong code optimization in compiler?)
    Petition const* petition = sPetitionMgr->GetPetition(petitionguid);
    if (!petition)
        return;

    uint32 type = petition->petitionType;

    // if guild petition and has guild => error, return;
    if (type == GUILD_CHARTER_TYPE && _player->GetGuildId())
        return;

    Signatures const* signatures = sPetitionMgr->GetSignature(petitionguid);
    uint8 signs = signatures ? signatures->signatureMap.size() : 0;

    LOG_DEBUG("network", "CMSG_PETITION_SHOW_SIGNATURES petition %s", petitionguid.ToString().c_str());

    WorldPacket data(SMSG_PETITION_SHOW_SIGNATURES, (8 + 8 + 4 + 1 + signs * 12));
    data << petitionguid;                                   // petition guid
    data << _player->GetGUID();                             // owner guid
    data << uint32(petitionguid.GetCounter());              // guild guid
    data << uint8(signs);                                   // sign's count

    if (signs)
        for (SignatureMap::const_iterator itr = signatures->signatureMap.begin(); itr != signatures->signatureMap.end(); ++itr)
        {
            data << itr->first;                                 // Player GUID
            data << uint32(0);                                  // there 0 ...
        }

    SendPacket(&data);
}

void WorldSession::HandlePetitionQueryOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Received opcode CMSG_PETITION_QUERY");   // ok
#endif

    ObjectGuid::LowType guildguid;
    ObjectGuid petitionguid;
    recvData >> guildguid;                                 // in Trinity always same as petition low guid
    recvData >> petitionguid;                              // petition guid
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "CMSG_PETITION_QUERY Petition (%s) Guild GUID %u", petitionguid.ToString().c_str(), guildguid);
#endif

    SendPetitionQueryOpcode(petitionguid);
}

void WorldSession::SendPetitionQueryOpcode(ObjectGuid petitionguid)
{
    Petition const* petition = sPetitionMgr->GetPetition(petitionguid);
    if (!petition)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("network", "CMSG_PETITION_QUERY failed for petition (%s)", petitionguid.ToString().c_str());
#endif
        return;
    }

    uint8 type = petition->petitionType;
    WorldPacket data(SMSG_PETITION_QUERY_RESPONSE, (4 + 8 + petition->petitionName.size() + 1 + 1 + 4 * 12 + 2 + 10));
    data << uint32(petitionguid.GetCounter());              // guild/team guid (in Trinity always same as petition low guid
    data << petition->ownerGuid;                            // charter owner guid
    data << petition->petitionName;                         // name (guild/arena team)
    data << uint8(0);                                       // some string
    if (type == GUILD_CHARTER_TYPE)
    {
        uint32 needed = sWorld->getIntConfig(CONFIG_MIN_PETITION_SIGNS);
        data << uint32(needed);
        data << uint32(needed);
        data << uint32(0);                                  // bypass client - side limitation, a different value is needed here for each petition
    }
    else
    {
        data << uint32(type - 1);
        data << uint32(type - 1);
        data << uint32(type);                               // bypass client - side limitation, a different value is needed here for each petition
    }
    data << uint32(0);                                      // 5
    data << uint32(0);                                      // 6
    data << uint32(0);                                      // 7
    data << uint32(0);                                      // 8
    data << uint16(0);                                      // 9 2 bytes field
    data << uint32(0);                                      // 10
    data << uint32(0);                                      // 11
    data << uint32(0);                                      // 13 count of next strings?

    for (int i = 0; i < 10; ++i)
        data << uint8(0);                                   // some string

    data << uint32(0);                                      // 14

    data << uint32(type != GUILD_CHARTER_TYPE);             // 15 0 - guild, 1 - arena team

    SendPacket(&data);
}

void WorldSession::HandlePetitionRenameOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Received opcode MSG_PETITION_RENAME");   // ok
#endif

    ObjectGuid petitionGuid;
    std::string newName;

    recvData >> petitionGuid;                              // guid
    recvData >> newName;                                   // new name

    Item* item = _player->GetItemByGuid(petitionGuid);
    if (!item)
        return;

    Petition const* petition = sPetitionMgr->GetPetition(petitionGuid);
    if (!petition)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("network", "CMSG_PETITION_QUERY failed for petition (%s)", petitionGuid.ToString().c_str());
#endif
        return;
    }

    if (petition->petitionType == GUILD_CHARTER_TYPE)
    {
        if (sGuildMgr->GetGuildByName(newName))
        {
            Guild::SendCommandResult(this, GUILD_COMMAND_CREATE, ERR_GUILD_NAME_EXISTS_S, newName);
            return;
        }
        if (sObjectMgr->IsReservedName(newName) || !ObjectMgr::IsValidCharterName(newName))
        {
            Guild::SendCommandResult(this, GUILD_COMMAND_CREATE, ERR_GUILD_NAME_INVALID, newName);
            return;
        }
    }
    else
    {
        if (sArenaTeamMgr->GetArenaTeamByName(newName))
        {
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, newName, "", ERR_ARENA_TEAM_NAME_EXISTS_S);
            return;
        }
        if (sObjectMgr->IsReservedName(newName) || !ObjectMgr::IsValidCharterName(newName))
        {
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, newName, "", ERR_ARENA_TEAM_NAME_INVALID);
            return;
        }
    }

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_PETITION_NAME);

    stmt->setString(0, newName);
    stmt->setUInt32(1, petitionGuid.GetCounter());

    CharacterDatabase.Execute(stmt);

    // xinef: update petition container
    const_cast<Petition*>(petition)->petitionName = newName;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Petition (%s) renamed to %s", petitionGuid.ToString().c_str(), newName.c_str());
#endif
    WorldPacket data(MSG_PETITION_RENAME, (8 + newName.size() + 1));
    data << petitionGuid;
    data << newName;
    SendPacket(&data);
}

void WorldSession::HandlePetitionSignOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Received opcode CMSG_PETITION_SIGN");    // ok
#endif

    ObjectGuid petitionGuid;
    uint8 unk;
    recvData >> petitionGuid;                              // petition guid
    recvData >> unk;

    Petition const* petition = sPetitionMgr->GetPetition(petitionGuid);
    if (!petition)
    {
        LOG_ERROR("server", "Petition %s is not found for player %s (Name: %s)", petitionGuid.ToString().c_str(), GetPlayer()->GetGUID().ToString().c_str(), GetPlayer()->GetName().c_str());
        return;
    }

    uint8 type = petition->petitionType;

    ObjectGuid playerGuid = _player->GetGUID();
    if (petition->ownerGuid == playerGuid)
        return;

    Signatures const* signatures = sPetitionMgr->GetSignature(petitionGuid);
    if (!signatures)
        return;

    // not let enemies sign guild charter
    if (!sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GUILD) && GetPlayer()->GetTeamId() != sObjectMgr->GetPlayerTeamIdByGUID(petition->ownerGuid.GetCounter()))
    {
        if (type != GUILD_CHARTER_TYPE)
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_INVITE_SS, "", "", ERR_ARENA_TEAM_NOT_ALLIED);
        else
            Guild::SendCommandResult(this, GUILD_COMMAND_CREATE, ERR_GUILD_NOT_ALLIED);
        return;
    }

    if (type != GUILD_CHARTER_TYPE)
    {
        if (_player->getLevel() < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
        {
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, "", _player->GetName().c_str(), ERR_ARENA_TEAM_TARGET_TOO_LOW_S);
            return;
        }

        uint8 slot = ArenaTeam::GetSlotByType(type);
        if (slot >= MAX_ARENA_SLOT)
            return;

        if (_player->GetArenaTeamId(slot))
        {
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_INVITE_SS, "", _player->GetName().c_str(), ERR_ALREADY_IN_ARENA_TEAM_S);
            return;
        }

        if (_player->GetArenaTeamIdInvited())
        {
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_INVITE_SS, "", _player->GetName().c_str(), ERR_ALREADY_INVITED_TO_ARENA_TEAM_S);
            return;
        }
    }
    else
    {
        if (_player->GetGuildId())
        {
            Guild::SendCommandResult(this, GUILD_COMMAND_INVITE, ERR_ALREADY_IN_GUILD_S, _player->GetName());
            return;
        }
        if (_player->GetGuildIdInvited())
        {
            Guild::SendCommandResult(this, GUILD_COMMAND_INVITE, ERR_ALREADY_INVITED_TO_GUILD_S, _player->GetName());
            return;
        }
    }

    uint32 signs = signatures->signatureMap.size();
    if (++signs > type)                                        // client signs maximum
        return;

    // Client doesn't allow to sign petition two times by one character, but not check sign by another character from same account
    // not allow sign another player from already sign player account

    bool found = false;
    for (SignatureMap::const_iterator itr = signatures->signatureMap.begin(); itr != signatures->signatureMap.end(); ++itr)
        if (itr->second == GetAccountId())
        {
            found = true;
            break;
        }

    if (found)
    {
        WorldPacket data(SMSG_PETITION_SIGN_RESULTS, (8 + 8 + 4));
        data << petitionGuid;
        data << playerGuid;
        data << (uint32)PETITION_SIGN_ALREADY_SIGNED;

        // close at signer side
        SendPacket(&data);

        // update for owner if online
        if (Player* owner = ObjectAccessor::FindConnectedPlayer(petition->ownerGuid))
            owner->GetSession()->SendPacket(&data);
        return;
    }

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PETITION_SIGNATURE);

    stmt->setUInt32(0, petition->ownerGuid.GetCounter());
    stmt->setUInt32(1, petitionGuid.GetCounter());
    stmt->setUInt32(2, playerGuid.GetCounter());
    stmt->setUInt32(3, GetAccountId());

    CharacterDatabase.Execute(stmt);

    // xinef: fill petition store
    sPetitionMgr->AddSignature(petitionGuid, GetAccountId(), playerGuid);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "PETITION SIGN: %s by player: %s (%s, Account: %u)", petitionGuid.ToString().c_str(), _player->GetName().c_str(), playerGuid.ToString().c_str(), GetAccountId());
#endif

    WorldPacket data(SMSG_PETITION_SIGN_RESULTS, (8 + 8 + 4));
    data << petitionGuid;
    data << playerGuid;
    data << uint32(PETITION_SIGN_OK);

    // close at signer side
    SendPacket(&data);

    // update signs count on charter, required testing...
    //Item* item = _player->GetItemByGuid(petitionguid));
    //if (item)
    //    item->SetUInt32Value(ITEM_FIELD_ENCHANTMENT_1_1+1, signs);

    // update for owner if online
    if (Player* owner = ObjectAccessor::FindConnectedPlayer(petition->ownerGuid))
        owner->GetSession()->SendPacket(&data);
}

void WorldSession::HandlePetitionDeclineOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Received opcode MSG_PETITION_DECLINE");  // ok
#endif

    ObjectGuid petitionguid;
    ObjectGuid ownerguid;
    recvData >> petitionguid;                              // petition guid
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Petition %s declined by %s", petitionguid.ToString().c_str(), _player->GetGUID().ToString().c_str());
#endif

    Petition const* petition = sPetitionMgr->GetPetition(petitionguid);
    if (!petition)
        return;

    if (Player* owner = ObjectAccessor::FindConnectedPlayer(ownerguid))                 // petition owner online
    {
        WorldPacket data(MSG_PETITION_DECLINE, 8);
        data << _player->GetGUID();
        owner->GetSession()->SendPacket(&data);
    }
}

void WorldSession::HandleOfferPetitionOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Received opcode CMSG_OFFER_PETITION");   // ok
#endif

    ObjectGuid petitionguid, plguid;
    uint32 junk;
    Player* player;
    recvData >> junk;                                      // this is not petition type!
    recvData >> petitionguid;                              // petition guid
    recvData >> plguid;                                    // player guid

    player = ObjectAccessor::FindConnectedPlayer(plguid);
    if (!player)
        return;

    Petition const* petition = sPetitionMgr->GetPetition(petitionguid);
    if (!petition)
        return;

    if (GetPlayer()->GetTeamId() != player->GetTeamId())
    {
        if (petition->petitionType != GUILD_CHARTER_TYPE)
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_INVITE_SS, "", "", ERR_ARENA_TEAM_NOT_ALLIED);
        else
            Guild::SendCommandResult(this, GUILD_COMMAND_CREATE, ERR_GUILD_NOT_ALLIED);
        return;
    }

    if (petition->petitionType != GUILD_CHARTER_TYPE)
    {
        if (player->getLevel() < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
        {
            // player is too low level to join an arena team
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, player->GetName().c_str(), "", ERR_ARENA_TEAM_TARGET_TOO_LOW_S);
            return;
        }

        uint8 slot = ArenaTeam::GetSlotByType(petition->petitionType);
        if (slot >= MAX_ARENA_SLOT)
            return;

        if (player->GetArenaTeamId(slot))
        {
            // player is already in an arena team
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, player->GetName().c_str(), "", ERR_ALREADY_IN_ARENA_TEAM_S);
            return;
        }

        if (player->GetArenaTeamIdInvited())
        {
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_INVITE_SS, "", _player->GetName().c_str(), ERR_ALREADY_INVITED_TO_ARENA_TEAM_S);
            return;
        }
    }
    else
    {
        if (player->GetGuildId())
        {
            Guild::SendCommandResult(this, GUILD_COMMAND_INVITE, ERR_ALREADY_IN_GUILD_S, _player->GetName());
            return;
        }

        if (player->GetGuildIdInvited())
        {
            Guild::SendCommandResult(this, GUILD_COMMAND_INVITE, ERR_ALREADY_INVITED_TO_GUILD_S, _player->GetName());
            return;
        }
    }

    Signatures const* signatures = sPetitionMgr->GetSignature(petitionguid);
    uint8 signs = signatures ? signatures->signatureMap.size() : 0;

    WorldPacket data(SMSG_PETITION_SHOW_SIGNATURES, (8 + 8 + 4 + signs + signs * 12));
    data << petitionguid;                                   // petition guid
    data << _player->GetGUID();                             // owner guid
    data << uint32(petitionguid.GetCounter());              // guild guid
    data << uint8(signs);                                   // sign's count

    if (signs)
        for (SignatureMap::const_iterator itr = signatures->signatureMap.begin(); itr != signatures->signatureMap.end(); ++itr)
        {
            data << itr->first;                                 // Player GUID
            data << uint32(0);                                  // there 0 ...
        }

    player->GetSession()->SendPacket(&data);
}

void WorldSession::HandleTurnInPetitionOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Received opcode CMSG_TURN_IN_PETITION");
#endif

    // Get petition guid from packet
    WorldPacket data;
    ObjectGuid petitionGuid;

    recvData >> petitionGuid;

    // Check if player really has the required petition charter
    Item* item = _player->GetItemByGuid(petitionGuid);
    if (!item)
        return;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Petition %s turned in by %s", petitionGuid.ToString().c_str(), _player->GetGUID().ToString().c_str());
#endif

    Petition const* petition = sPetitionMgr->GetPetition(petitionGuid);
    if (!petition)
    {
        LOG_ERROR("server", "Player %s (%s) tried to turn in petition (%s) that is not present in the database",
            _player->GetName().c_str(), _player->GetGUID().ToString().c_str(), petitionGuid.ToString().c_str());
        return;
    }

    ObjectGuid ownerGuid = petition->ownerGuid;
    uint8 type = petition->petitionType;
    std::string name = petition->petitionName;

    // Only the petition owner can turn in the petition
    if (_player->GetGUID() != ownerGuid)
        return;

    // Petition type (guild/arena) specific checks
    if (type == GUILD_CHARTER_TYPE)
    {
        // Check if player is already in a guild
        if (_player->GetGuildId())
        {
            data.Initialize(SMSG_TURN_IN_PETITION_RESULTS, 4);
            data << (uint32)PETITION_TURN_ALREADY_IN_GUILD;
            SendPacket(&data);
            return;
        }

        // Check if guild name is already taken
        if (sGuildMgr->GetGuildByName(name))
        {
            Guild::SendCommandResult(this, GUILD_COMMAND_CREATE, ERR_GUILD_NAME_EXISTS_S, name);
            return;
        }
    }
    else
    {
        // Check for valid arena bracket (2v2, 3v3, 5v5)
        uint8 slot = ArenaTeam::GetSlotByType(type);
        if (slot >= MAX_ARENA_SLOT)
            return;

        // Check if player is already in an arena team
        if (_player->GetArenaTeamId(slot))
        {
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, name, "", ERR_ALREADY_IN_ARENA_TEAM);
            return;
        }

        // Check if arena team name is already taken
        if (sArenaTeamMgr->GetArenaTeamByName(name))
        {
            SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, name, "", ERR_ARENA_TEAM_NAME_EXISTS_S);
            return;
        }
    }

    // Get petition signatures from db
    Signatures const* signatures = sPetitionMgr->GetSignature(petitionGuid);
    uint8 signs = signatures ? signatures->signatureMap.size() : 0;
    SignatureMap signatureCopy;
    if (signs)
        signatureCopy = signatures->signatureMap;

    uint32 requiredSignatures;
    if (type == GUILD_CHARTER_TYPE)
        requiredSignatures = sWorld->getIntConfig(CONFIG_MIN_PETITION_SIGNS);
    else
        requiredSignatures = type - 1;

    // Notify player if signatures are missing
    if (signs < requiredSignatures)
    {
        data.Initialize(SMSG_TURN_IN_PETITION_RESULTS, 4);
        data << (uint32)PETITION_TURN_NEED_MORE_SIGNATURES;
        SendPacket(&data);
        return;
    }

    // Proceed with guild/arena team creation

    // Delete charter item
    _player->DestroyItem(item->GetBagSlot(), item->GetSlot(), true);

    if (type == GUILD_CHARTER_TYPE)
    {
        // Create guild
        Guild* guild = new Guild;

        if (!guild->Create(_player, name))
        {
            delete guild;
            return;
        }

        // Register guild and add guild master
        sGuildMgr->AddGuild(guild);

        Guild::SendCommandResult(this, GUILD_COMMAND_CREATE, ERR_GUILD_COMMAND_SUCCESS, name);

        // Add members from signatures
        if (signs)
            for (SignatureMap::const_iterator itr = signatureCopy.begin(); itr != signatureCopy.end(); ++itr)
                guild->AddMember(itr->first);
    }
    else
    {
        // Receive the rest of the packet in arena team creation case
        uint32 background, icon, iconcolor, border, bordercolor;
        recvData >> background >> icon >> iconcolor >> border >> bordercolor;

        // Create arena team
        ArenaTeam* arenaTeam = new ArenaTeam();

        if (!arenaTeam->Create(_player->GetGUID(), type, name, background, icon, iconcolor, border, bordercolor))
        {
            delete arenaTeam;
            return;
        }

        // Register arena team
        sArenaTeamMgr->AddArenaTeam(arenaTeam);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("network", "PetitonsHandler: Arena team (guid: %u) added to ObjectMgr", arenaTeam->GetId());
#endif

        // Add members
        if (signs)
            for (SignatureMap::const_iterator itr = signatureCopy.begin(); itr != signatureCopy.end(); ++itr)
            {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                LOG_DEBUG("network", "PetitionsHandler: Adding arena team (guid: %u) member %s", arenaTeam->GetId(), itr->first.ToString().c_str());
#endif
                arenaTeam->AddMember(itr->first);
            }
    }

    SQLTransaction trans = CharacterDatabase.BeginTransaction();

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PETITION_BY_GUID);
    stmt->setUInt32(0, petitionGuid.GetCounter());
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_PETITION_SIGNATURE_BY_GUID);
    stmt->setUInt32(0, petitionGuid.GetCounter());
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);

    // xinef: clear petition store (petition and signatures)
    sPetitionMgr->RemovePetition(petitionGuid);

    // created
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "TURN IN PETITION %s", petitionGuid.ToString().c_str());
#endif

    data.Initialize(SMSG_TURN_IN_PETITION_RESULTS, 4);
    data << (uint32)PETITION_TURN_OK;
    SendPacket(&data);
}

void WorldSession::HandlePetitionShowListOpcode(WorldPacket& recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Received CMSG_PETITION_SHOWLIST");
#endif

    ObjectGuid guid;
    recvData >> guid;

    SendPetitionShowList(guid);
}

void WorldSession::SendPetitionShowList(ObjectGuid guid)
{
    Creature* creature = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_PETITIONER);
    if (!creature)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        LOG_DEBUG("network", "WORLD: HandlePetitionShowListOpcode - Unit (%s) not found or you can't interact with him.", guid.ToString().c_str());
#endif
        return;
    }

    WorldPacket data(SMSG_PETITION_SHOWLIST, 8 + 1 + 4 * 6);
    data << guid;                                           // npc guid

    // For guild default
    uint32 CharterEntry = GUILD_CHARTER;
    uint32 CharterDispayID = CHARTER_DISPLAY_ID;
    uint32 CharterCost = sWorld->getIntConfig(CONFIG_CHARTER_COST_GUILD);

    if (creature->IsTabardDesigner())
    {
        sScriptMgr->PetitionShowList(_player, creature, CharterEntry, CharterDispayID, CharterCost);

        data << uint8(1);                                   // count
        data << uint32(1);                                  // index
        data << CharterEntry;                               // charter entry
        data << CharterDispayID;                            // charter display id
        data << CharterCost;                                // charter cost
        data << uint32(0);                                  // unknown
        data << uint32(sWorld->getIntConfig(CONFIG_MIN_PETITION_SIGNS)); // required signs
    }
    else
    {
        // For 2v2 default
        CharterEntry = ARENA_TEAM_CHARTER_2v2;
        CharterDispayID = CHARTER_DISPLAY_ID;
        CharterCost = sWorld->getIntConfig(CONFIG_CHARTER_COST_ARENA_2v2);

        // 2v2
        data << uint8(3);                                   // count
        sScriptMgr->PetitionShowList(_player, creature, CharterEntry, CharterDispayID, CharterCost);
        data << uint32(1);                                  // index
        data << CharterEntry;                               // charter entry
        data << CharterDispayID;                            // charter display id
        data << CharterCost;                                // charter cost
        data << uint32(2);                                  // unknown
        data << uint32(2);                                  // required signs?

        // For 3v3 default
        CharterEntry = ARENA_TEAM_CHARTER_3v3;
        CharterDispayID = CHARTER_DISPLAY_ID;
        CharterCost = sWorld->getIntConfig(CONFIG_CHARTER_COST_ARENA_3v3);

        // 3v3
        sScriptMgr->PetitionShowList(_player, creature, CharterEntry, CharterDispayID, CharterCost);
        data << uint32(2);                                  // index
        data << CharterEntry;                               // charter entry
        data << CharterDispayID;                            // charter display id
        data << CharterCost;                                // charter cost
        data << uint32(3);                                  // unknown
        data << uint32(3);                                  // required signs?

        // For 3v3 default
        CharterEntry = ARENA_TEAM_CHARTER_5v5;
        CharterDispayID = CHARTER_DISPLAY_ID;
        CharterCost = sWorld->getIntConfig(CONFIG_CHARTER_COST_ARENA_5v5);

        // 5v5
        sScriptMgr->PetitionShowList(_player, creature, CharterEntry, CharterDispayID, CharterCost);
        data << uint32(3);                                  // index
        data << CharterEntry;                               // charter entry
        data << CharterDispayID;                            // charter display id
        data << CharterCost;                                // charter cost
        data << uint32(5);                                  // unknown
        data << uint32(5);                                  // required signs?
    }

    SendPacket(&data);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    LOG_DEBUG("network", "Sent SMSG_PETITION_SHOWLIST");
#endif
}
