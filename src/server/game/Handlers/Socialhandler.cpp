/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "AccountMgr.h"
#include "Language.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "SocialMgr.h"
#include "World.h"
#include "WorldSession.h"

void WorldSession::HandleContactListOpcode(WorldPacket& recv_data)
{
    uint32 flags;
    recv_data >> flags;

    LOG_DEBUG("network", "WORLD: Received CMSG_CONTACT_LIST - Unk: %d", flags);

    _player->GetSocial()->SendSocialList(_player, flags);
}

void WorldSession::HandleAddFriendOpcode(WorldPacket& recv_data)
{
    LOG_DEBUG("network", "WORLD: Received CMSG_ADD_FRIEND");

    std::string friendName = GetAcoreString(LANG_FRIEND_IGNORE_UNKNOWN);
    std::string friendNote;

    recv_data >> friendName;
    recv_data >> friendNote;

    if (!normalizePlayerName(friendName))
        return;

    LOG_DEBUG("network", "WORLD: %s asked to add friend : '%s'", GetPlayer()->GetName().c_str(), friendName.c_str());

    // xinef: Get Data From global storage
    ObjectGuid friendGuid = sWorld->GetGlobalPlayerGUID(friendName);
    if (!friendGuid)
        return;

    GlobalPlayerData const* playerData = sWorld->GetGlobalPlayerData(friendGuid.GetCounter());
    if (!playerData)
        return;

    uint32 friendAccountId = playerData->accountId;
    TeamId teamId = Player::TeamIdForRace(playerData->race);
    FriendsResult friendResult = FRIEND_NOT_FOUND;

    if (!AccountMgr::IsPlayerAccount(GetSecurity()) || sWorld->getBoolConfig(CONFIG_ALLOW_GM_FRIEND)|| AccountMgr::IsPlayerAccount(AccountMgr::GetSecurity(friendAccountId, realmID)))
    {
        if (friendGuid)
        {
            if (friendGuid == GetPlayer()->GetGUID())
                friendResult = FRIEND_SELF;
            else if (GetPlayer()->GetTeamId() != teamId && !sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_ADD_FRIEND)  && AccountMgr::IsPlayerAccount(GetSecurity()))
                friendResult = FRIEND_ENEMY;
            else if (GetPlayer()->GetSocial()->HasFriend(friendGuid))
                friendResult = FRIEND_ALREADY;
            else
            {
                Player* pFriend = ObjectAccessor::FindConnectedPlayer(friendGuid);
                if (pFriend && pFriend->IsVisibleGloballyFor(GetPlayer()) && !AccountMgr::IsGMAccount(pFriend->GetSession()->GetSecurity()))
                    friendResult = FRIEND_ADDED_ONLINE;
                else
                    friendResult = FRIEND_ADDED_OFFLINE;
                if (GetPlayer()->GetSocial()->AddToSocialList(friendGuid, SOCIAL_FLAG_FRIEND))
                    GetPlayer()->GetSocial()->SetFriendNote(friendGuid, friendNote);
                else
                friendResult = FRIEND_LIST_FULL;
            }
            GetPlayer()->GetSocial()->SetFriendNote(friendGuid, friendNote);
        }
    }

    sSocialMgr->SendFriendStatus(GetPlayer(), friendResult, friendGuid, false);

    LOG_DEBUG("network", "WORLD: Sent (SMSG_FRIEND_STATUS)");
}

void WorldSession::HandleDelFriendOpcode(WorldPacket& recv_data)
{
    ObjectGuid FriendGUID;
    recv_data >> FriendGUID;

    _player->GetSocial()->RemoveFromSocialList(FriendGUID, SOCIAL_FLAG_FRIEND);

    sSocialMgr->SendFriendStatus(GetPlayer(), FRIEND_REMOVED, FriendGUID, false);

    LOG_DEBUG("network", "WORLD: Sent motd (SMSG_FRIEND_STATUS)");
}

void WorldSession::HandleAddIgnoreOpcode(WorldPacket& recv_data)
{
    std::string ignoreName = GetAcoreString(LANG_FRIEND_IGNORE_UNKNOWN);

    recv_data >> ignoreName;

    if (!normalizePlayerName(ignoreName))
        return;

    LOG_DEBUG("network", "WORLD: %s asked to Ignore: '%s'", GetPlayer()->GetName().c_str(), ignoreName.c_str());

    ObjectGuid ignoreGuid = sWorld->GetGlobalPlayerGUID(ignoreName);
    if (!ignoreGuid)
        return;

    FriendsResult ignoreResult;

    if (ignoreGuid == GetPlayer()->GetGUID())              //not add yourself
        ignoreResult = FRIEND_IGNORE_SELF;
    else if (GetPlayer()->GetSocial()->HasIgnore(ignoreGuid))
        ignoreResult = FRIEND_IGNORE_ALREADY;
    else
    {
        ignoreResult = FRIEND_IGNORE_ADDED;

        // ignore list full
        if (!GetPlayer()->GetSocial()->AddToSocialList(ignoreGuid, SOCIAL_FLAG_IGNORED))
            ignoreResult = FRIEND_IGNORE_FULL;
    }

    sSocialMgr->SendFriendStatus(GetPlayer(), ignoreResult, ignoreGuid, false);

    LOG_DEBUG("network", "WORLD: Sent (SMSG_FRIEND_STATUS)");
}

void WorldSession::HandleDelIgnoreOpcode(WorldPacket& recv_data)
{
    ObjectGuid IgnoreGUID;
    recv_data >> IgnoreGUID;

    _player->GetSocial()->RemoveFromSocialList(IgnoreGUID, SOCIAL_FLAG_IGNORED);
    sSocialMgr->SendFriendStatus(GetPlayer(), FRIEND_IGNORE_REMOVED, IgnoreGUID, false);
}

void WorldSession::HandleSetContactNotesOpcode(WorldPacket& recv_data)
{
    ObjectGuid guid;
    std::string note;
    recv_data >> guid >> note;
    _player->GetSocial()->SetFriendNote(guid, note);
}
