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

#include "SocialMgr.h"
#include "AccountMgr.h"
#include "DatabaseEnv.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "Util.h"
#include "WorldPacket.h"
#include "WorldSession.h"

PlayerSocial::PlayerSocial(): m_playerGUID() { }

uint32 PlayerSocial::GetNumberOfSocialsWithFlag(SocialFlag flag) const
{
    uint32 counter = 0;
    for (const auto& itr : m_playerSocialMap)
    {
        if ((itr.second.Flags & flag) != 0)
            ++counter;
    }
    return counter;
}

bool PlayerSocial::AddToSocialList(ObjectGuid friendGuid, SocialFlag flag)
{
    // check client limits
    if (GetNumberOfSocialsWithFlag(flag) >= (((flag & SOCIAL_FLAG_FRIEND) != 0) ? SOCIALMGR_FRIEND_LIMIT : SOCIALMGR_IGNORE_LIMIT))
        return false;

    auto itr = m_playerSocialMap.find(friendGuid);
    if (itr != m_playerSocialMap.end())
    {
        itr->second.Flags |= flag;

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_CHARACTER_SOCIAL_FLAGS);

        stmt->SetData(0, itr->second.Flags);
        stmt->SetData(1, GetPlayerGUID().GetCounter());
        stmt->SetData(2, friendGuid.GetCounter());

        CharacterDatabase.Execute(stmt);
    }
    else
    {
        m_playerSocialMap[friendGuid].Flags |= flag;

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_SOCIAL);

        stmt->SetData(0, GetPlayerGUID().GetCounter());
        stmt->SetData(1, friendGuid.GetCounter());
        stmt->SetData(2, flag);

        CharacterDatabase.Execute(stmt);
    }
    return true;
}

void PlayerSocial::RemoveFromSocialList(ObjectGuid friendGuid, SocialFlag flag)
{
    auto itr = m_playerSocialMap.find(friendGuid);
    if (itr == m_playerSocialMap.end())                     // not exist
        return;

    itr->second.Flags &= ~flag;

    if (itr->second.Flags == 0)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHARACTER_SOCIAL);

        stmt->SetData(0, GetPlayerGUID().GetCounter());
        stmt->SetData(1, friendGuid.GetCounter());

        CharacterDatabase.Execute(stmt);

        m_playerSocialMap.erase(itr);
    }
    else
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_REM_CHARACTER_SOCIAL_FLAGS);

        stmt->SetData(0, flag);
        stmt->SetData(1, GetPlayerGUID().GetCounter());
        stmt->SetData(2, friendGuid.GetCounter());

        CharacterDatabase.Execute(stmt);
    }
}

void PlayerSocial::SetFriendNote(ObjectGuid friendGuid, std::string note)
{
    auto itr = m_playerSocialMap.find(friendGuid);
    if (itr == m_playerSocialMap.end())                     // not exist
        return;

    utf8truncate(note, 48);                                  // DB and client size limitation

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_SOCIAL_NOTE);

    stmt->SetData(0, note);
    stmt->SetData(1, GetPlayerGUID().GetCounter());
    stmt->SetData(2, friendGuid.GetCounter());

    CharacterDatabase.Execute(stmt);

    m_playerSocialMap[friendGuid].Note = note;
}

void PlayerSocial::SendSocialList(Player* player, uint32 flags)
{
    if (!player)
        return;

    uint32 friendsCount = 0;
    uint32 ignoredCount = 0;
    uint32 totalCount = 0;

    WorldPacket data(SMSG_CONTACT_LIST, (4 + 4 + m_playerSocialMap.size() * 25)); // just can guess size
    data << uint32(flags);                                                        // 0x1 = Friendlist update. 0x2 = Ignorelist update. 0x4 = Mutelist update.
    std::size_t countPos = data.wpos();
    data << uint32(0);                                                           // contacts count placeholder

    for (auto& itr : m_playerSocialMap)
    {
        FriendInfo& friendInfo = itr.second;
        uint8 contactFlags = friendInfo.Flags;
        if (!(contactFlags & flags))
            continue;

        // Check client limit for friends list
        if (contactFlags & SOCIAL_FLAG_FRIEND)
            if (++friendsCount > SOCIALMGR_FRIEND_LIMIT)
                continue;

        // Check client limit for ignore list
        if (contactFlags & SOCIAL_FLAG_IGNORED)
            if (++ignoredCount > SOCIALMGR_IGNORE_LIMIT)
                continue;

        ++totalCount;

        sSocialMgr->GetFriendInfo(player, itr.first, friendInfo);

        data << itr.first;                                    // player guid
        data << uint32(contactFlags);                         // player flag (0x1 = Friend, 0x2 = Ignored, 0x4 = Muted)
        data << friendInfo.Note;                              // string note
        if (contactFlags & SOCIAL_FLAG_FRIEND)                // if IsFriend()
        {
            data << uint8(friendInfo.Status);                 // online/offline/etc?
            if (friendInfo.Status)                            // if online
            {
                data << uint32(friendInfo.Area);              // player area
                data << uint32(friendInfo.Level);             // player level
                data << uint32(friendInfo.Class);             // player class
            }
        }
    }

    data.put<uint32>(countPos, totalCount);
    player->GetSession()->SendPacket(&data);
    LOG_DEBUG("network", "WORLD: Sent SMSG_CONTACT_LIST");
}

bool PlayerSocial::_checkContact(ObjectGuid guid, SocialFlag flags) const
{
    const auto& itr = m_playerSocialMap.find(guid);
    if (itr != m_playerSocialMap.end())
        return (itr->second.Flags & flags) != 0;

    return false;
}

bool PlayerSocial::HasFriend(ObjectGuid friend_guid) const
{
    return _checkContact(friend_guid, SOCIAL_FLAG_FRIEND);
}

bool PlayerSocial::HasIgnore(ObjectGuid ignore_guid) const
{
    return _checkContact(ignore_guid, SOCIAL_FLAG_IGNORED);
}

SocialMgr::SocialMgr()
{
}

SocialMgr::~SocialMgr()
{
}

SocialMgr* SocialMgr::instance()
{
    static SocialMgr instance;
    return &instance;
}

void SocialMgr::GetFriendInfo(Player* player, ObjectGuid friendGUID, FriendInfo& friendInfo)
{
    if (!player)
        return;

    friendInfo.Status = FRIEND_STATUS_OFFLINE;
    friendInfo.Area = 0;
    friendInfo.Level = 0;
    friendInfo.Class = 0;

    Player* pFriend = ObjectAccessor::FindConnectedPlayer(friendGUID);
    if (!pFriend || pFriend->GetSession()->IsGMAccount())
        return;

    TeamId teamId = player->GetTeamId();
    AccountTypes security = player->GetSession()->GetSecurity();
    bool allowTwoSideWhoList = sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_WHO_LIST);
    AccountTypes gmLevelInWhoList = AccountTypes(sWorld->getIntConfig(CONFIG_GM_LEVEL_IN_WHO_LIST));

    auto const& itr = player->GetSocial()->m_playerSocialMap.find(friendGUID);
    if (itr != player->GetSocial()->m_playerSocialMap.end())
        friendInfo.Note = itr->second.Note;

    // PLAYER see his team only and PLAYER can't see MODERATOR, GAME MASTER, ADMINISTRATOR characters
    // MODERATOR, GAME MASTER, ADMINISTRATOR can see all
    if ((!AccountMgr::IsPlayerAccount(security) || ((pFriend->GetTeamId() == teamId || allowTwoSideWhoList) && pFriend->GetSession()->GetSecurity() <= gmLevelInWhoList)) && pFriend->IsVisibleGloballyFor(player))
    {
        friendInfo.Status = FRIEND_STATUS_ONLINE;
        if (pFriend->isAFK())
            friendInfo.Status = FRIEND_STATUS_AFK;
        if (pFriend->isDND())
            friendInfo.Status = FRIEND_STATUS_DND;
        friendInfo.Area = pFriend->GetZoneId();
        friendInfo.Level = pFriend->GetLevel();
        friendInfo.Class = pFriend->getClass();
    }
}

void SocialMgr::MakeFriendStatusPacket(FriendsResult result, ObjectGuid guid, WorldPacket* data)
{
    data->Initialize(SMSG_FRIEND_STATUS, 9);
    *data << uint8(result);
    *data << guid;
}

void SocialMgr::SendFriendStatus(Player* player, FriendsResult result, ObjectGuid friendGuid, bool broadcast)
{
    FriendInfo fi;
    GetFriendInfo(player, friendGuid, fi);

    WorldPacket data(SMSG_FRIEND_STATUS, 9);
    data << uint8(result);
    data << friendGuid;
    switch (result)
    {
        case FRIEND_ADDED_OFFLINE:
        case FRIEND_ADDED_ONLINE:
            data << fi.Note;
            break;
        default:
            break;
    }

    switch (result)
    {
        case FRIEND_ADDED_ONLINE:
        case FRIEND_ONLINE:
            data << uint8(fi.Status);
            data << uint32(fi.Area);
            data << uint32(fi.Level);
            data << uint32(fi.Class);
            break;
        default:
            break;
    }

    if (broadcast)
        BroadcastToFriendListers(player, &data);
    else
        player->GetSession()->SendPacket(&data);
}

void SocialMgr::BroadcastToFriendListers(Player* player, WorldPacket* packet)
{
    if (!player)
        return;

    TeamId teamId = player->GetTeamId();
    AccountTypes security = player->GetSession()->GetSecurity();
    bool allowTwoSideWhoList = sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_WHO_LIST);
    AccountTypes gmLevelInWhoList = AccountTypes(sWorld->getIntConfig(CONFIG_GM_LEVEL_IN_WHO_LIST));

    for (auto const& itr : m_socialMap)
    {
        auto const& itr2 = itr.second.m_playerSocialMap.find(player->GetGUID());
        if (itr2 != itr.second.m_playerSocialMap.end() && (itr2->second.Flags & SOCIAL_FLAG_FRIEND))
        {
            Player* pFriend = ObjectAccessor::FindPlayer(itr.first);

            // PLAYER see his team only and PLAYER can't see MODERATOR, GAME MASTER, ADMINISTRATOR characters
            // MODERATOR, GAME MASTER, ADMINISTRATOR can see all
            if (pFriend && (!AccountMgr::IsPlayerAccount(pFriend->GetSession()->GetSecurity()) || ((pFriend->GetTeamId() == teamId || allowTwoSideWhoList) && security <= gmLevelInWhoList)) && player->IsVisibleGloballyFor(pFriend))
                pFriend->GetSession()->SendPacket(packet);
        }
    }
}

PlayerSocial* SocialMgr::LoadFromDB(PreparedQueryResult result, ObjectGuid guid)
{
    PlayerSocial* social = &m_socialMap[guid];
    social->SetPlayerGUID(guid);

    if (!result)
        return social;

    do
    {
        Field* fields = result->Fetch();

        auto friendGuid = ObjectGuid::Create<HighGuid::Player>(fields[0].Get<uint32>());
        auto flags = fields[1].Get<uint8>();
        auto note = fields[2].Get<std::string>();

        social->m_playerSocialMap[friendGuid] = FriendInfo(flags, note);
    } while (result->NextRow());

    return social;
}
