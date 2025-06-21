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

#include "VoiceChatChannel.h"
#include "BattlegroundMgr.h"
#include "ChannelMgr.h"
#include "GroupMgr.h"
#include "Player.h"
#include "VoiceChatMgr.h"

VoiceChatChannel::VoiceChatChannel(VoiceChatChannelTypes type, uint32 id, uint32 groupId, std::string name, TeamId team)
{
    _channelId = id;
    _type = type;
    _channelName = name;
    _groupId = groupId;
    _team = team;
    _isDeleting = false;
    _isMassAdding = false;

    for (uint8 i = 1; i < MAX_VOICECHAT_CHANNEL_MEMBERS; ++i)
        _membersGuids[i] = ObjectGuid();

    GenerateSessionId();
    GenerateEncryptionKey();
}

VoiceChatChannel::~VoiceChatChannel()
{
    _isDeleting = true;
    for (auto const& m_member : _members)
        RemoveVoiceChatMember(m_member.second.Guid);
}

void VoiceChatChannel::GenerateSessionId()
{
    // don't know what it should be so use time(nullptr) and increment to make it always different
    _sessionId = sVoiceChatMgr.GetNewSessionId();
}

void VoiceChatChannel::GenerateEncryptionKey()
{
    // todo figure out encryption key
    for (auto i = 0; i < 16; i++)
        _encryptionKey[i] = 0x00;
}

uint8 VoiceChatChannel::GenerateUserId(ObjectGuid guid)
{
    /*for (uint8 i = 1; i < MAX_VOICECHAT_CHANNEL_MEMBERS; ++i)
        {
            if (m_members.find(i) == m_members.end())
                return i;
        }
    return 0;*/

    // reusing user ID of a character that left voice chat makes other clients
    // show that character name when new character is speaking.
    // sending voice roster update doesn't seem to override it
    // sending SMSG_VOICE_SESSION_LEAVE with player guid works but makes everyone leave current voice channel
    // until fix is found just use new id for new characters

    // check if already has id
    uint8 freeId = 0;
    for (uint8 i = 1; i < MAX_VOICECHAT_CHANNEL_MEMBERS; ++i)
    {
        if (_membersGuids[i] == guid)
            return i;

        if (!_membersGuids[i])
        {
            _membersGuids[i] = guid;
            freeId = i;
            break;
        }
    }

    return freeId;
}

// let client know this voice channel is available
void VoiceChatChannel::SendAvailableVoiceChatChannel(WorldSession* session)
{
    Player* plr = session->GetPlayer();
    if (!plr)
        return;

    LOG_DEBUG("network", "Sending SMSG_AVAILABLE_VOICE_CHANNEL for player {}", plr->GetGUID().ToString());

    WorldPacket data(SMSG_AVAILABLE_VOICE_CHANNEL);
    data << _sessionId;
    data << uint8(_type);
    if (_type == VOICECHAT_CHANNEL_CUSTOM)
        data << _channelName;
    else
        data << uint8(0);
    data << plr->GetGUID();
    session->SendPacket(&data);
}

// send voice members list to all members
void VoiceChatChannel::SendVoiceRosterUpdate(bool empty, bool toAll, ObjectGuid toPlayer)
{
    // don't send while deleting channel and members
    if (_isDeleting)
        return;

    // don't send while massively adding members after channel create
    if (_isMassAdding)
        return;

    WorldPacket data(SMSG_VOICE_SESSION_ROSTER_UPDATE, 31 + (_members.size() * 11));
    data << uint64(_sessionId);
    data << uint16(_channelId);
    data << uint8(_type);
    if (_type == VOICECHAT_CHANNEL_CUSTOM)
        data << _channelName;
    else
        data << uint8(0);
    data.append(_encryptionKey, 16);
    data << uint32(htonl(sVoiceChatMgr.GetVoiceServerVoiceAddress()));
    data << uint16(sVoiceChatMgr.GetVoiceServerVoicePort());

    size_t countPos = data.wpos();
    uint8 count = empty ? 1 : _members.size();
    data << uint8(count);

    // send each member a list of that member plus others
    size_t pos = data.wpos();
    for (auto const& member : _members)
    {
        // clean up if disconnected
        Player* player = ObjectAccessor::FindPlayer(member.second.Guid);
        if (!player || !ObjectAccessor::FindConnectedPlayer(member.second.Guid))
        {
            _isDeleting = true;

            RemoveVoiceChatMember(member.second.Guid);
            if (!empty && count)
                count--;

            _isDeleting = false;
            continue;
        }

        data << member.second.Guid;
        data << member.second.UserId;
        data << member.second.Flags;

        for (auto const& j : _members)
        {
            if (j.first == member.first)
                continue;

            // clean up if disconnected
            Player* otherPlayer = ObjectAccessor::FindPlayer(j.second.Guid);
            if (!otherPlayer || !ObjectAccessor::FindConnectedPlayer(j.second.Guid))
            {
                _isDeleting = true;

                RemoveVoiceChatMember(j.second.Guid);
                if (!empty && count)
                    count--;

                _isDeleting = false;
                continue;
            }

            data << j.second.Guid;
            data << j.second.UserId;
            data << j.second.Priority;
            data << j.second.Flags;
        }

        if (!empty)
            data.put<uint8>(countPos, count);

        // do not send to not active users by default, don't know if it's okay
        if ((!toPlayer && member.second.IsVoiced()) || toAll || player->GetGUID() == toPlayer)
            player->GetSession()->SendPacket(&data);

        data.wpos(pos);
    }
}

// disable voice channel in client interface
void VoiceChatChannel::SendLeaveVoiceChatSession(WorldSession* session) const
{
    Player* plr = session->GetPlayer();
    if (!plr)
        return;

    LOG_DEBUG("network", "Sending SMSG_VOICE_SESSION_LEAVE for player {}", plr->GetGUID().ToString());

    WorldPacket data(SMSG_VOICE_SESSION_LEAVE, 16);
    data << plr->GetGUID();
    data << _sessionId;
    session->SendPacket(&data);
}

void VoiceChatChannel::SendLeaveVoiceChatSession(ObjectGuid guid)
{
    for (auto& memb : _members)
    {
        if (Player* plr = ObjectAccessor::FindPlayer(memb.second.Guid))
        {
            if (WorldSession* session = plr->GetSession())
            {
                WorldPacket data(SMSG_VOICE_SESSION_LEAVE, 16);
                data << guid;
                data << _sessionId;
                session->SendPacket(&data);
            }
        }
    }
}

void VoiceChatChannel::ConvertToRaid()
{
    if (GetType() == VOICECHAT_CHANNEL_RAID || GetType() != VOICECHAT_CHANNEL_GROUP)
        return;

    SetType(VOICECHAT_CHANNEL_RAID);
    SendVoiceRosterUpdate(false, true);
}

VoiceChatMember* VoiceChatChannel::GetVoiceChatMember(ObjectGuid guid)
{
    for (auto& memb : _members)
    {
        if (memb.second.Guid == guid)
            return &memb.second;
    }
    return nullptr;
}

bool VoiceChatChannel::IsOn(ObjectGuid guid)
{
    for (VoiceChatMembers::const_iterator i = _members.begin(); i != _members.end(); ++i)
    {
        if (i->second.Guid == guid)
            return true;
    }
    return false;
}

void VoiceChatChannel::AddVoiceChatMember(ObjectGuid guid)
{
    if (IsOn(guid))
        return;

    if (_isDeleting)
        return;

    Player* plr = ObjectAccessor::FindPlayer(guid);
    if (!plr)
    {
        LOG_ERROR("voice-chat", "Could not add voice member, player not found!");
        return;
    }

    WorldSession* sess = plr->GetSession();
    if (!sess)
    {
        LOG_ERROR("voice-chat", "Could not add voice member, session not found!");
        return;
    }

    if (!sess->IsVoiceChatEnabled())
    {
        LOG_ERROR("voice-chat", "Could not add voice member, voice chat disabled for session!");
        return;
    }

    uint8 userId = GenerateUserId(guid);
    if (!userId)
    {
        LOG_INFO("voice-chat", "Could not add voice member, no free slots!");
        WorldPacket data(SMSG_VOICESESSION_FULL);
        sess->SendPacket(&data);
        return;
    }

    VoiceChatMember member = VoiceChatMember(guid, userId);
    member.SetEnabled(true);
    member.SetVoiced(false);
    member.SetMuted(!sess->IsMicEnabled());

    if (plr->GetGroup()->IsLeader(plr->GetGUID()))
        member.SetHighPriority();

    _members[userId] = member;

    // activate slot on voice server
    sVoiceChatMgr.EnableChannelSlot(_channelId, userId);
    // notify voice server that mic is disabled
    if (member.IsMuted())
        sVoiceChatMgr.MuteChannelSlot(_channelId, userId);

    if (!_isMassAdding)
        SendVoiceRosterUpdate();

    SendAvailableVoiceChatChannel(sess);
}

void VoiceChatChannel::RemoveVoiceChatMember(ObjectGuid guid)
{
    if (!IsOn(guid))
        return;

    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        LOG_ERROR("voice-chat", "Could not remove voice member, member not found!");
        return;
    }

    Player* plr = ObjectAccessor::FindPlayer(guid);
    if (plr)
    {
        if (WorldSession* session = plr->GetSession())
        {
            uint32 channelId = GetChannelId();
            sVoiceChatMgr.GetEventEmitter() += [channelId, session](VoiceChatMgr* /*mgr*/)
                {
                    if (session->GetCurrentVoiceChannelId() == channelId)
                        session->SetCurrentVoiceChannelId(0);
                };

            if (session->GetCurrentVoiceChannelId() == channelId)
                session->SetCurrentVoiceChannelId(0);

            SendLeaveVoiceChatSession(session);
        }
    }

    SendLeaveVoiceChatSession(guid);

    sVoiceChatMgr.DisableChannelSlot(_channelId, member->UserId);

    LOG_INFO("voice-chat", "User #{} removed from channel #{}", member->UserId, _channelId);

    _members.erase(member->UserId);

    if (!_members.empty())
        SendVoiceRosterUpdate();
}

void VoiceChatChannel::AddMembersAfterCreate()
{
    if (!sVoiceChatMgr.CanUseVoiceChat())
        return;

    // add all possible members to this channel
    LOG_DEBUG("voice-chat", "Adding voice chat enabled members after create, channel #{}, type #{}", _channelId, _type);

    // disable sending voice roster update while adding
    _isMassAdding = true;

    switch (GetType())
    {
        case VOICECHAT_CHANNEL_GROUP:
        case VOICECHAT_CHANNEL_RAID:
        {
            if (Group* group = sGroupMgr->GetGroupByGUID(GetGroupId()))
            {
                for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                {
                    if (Player* groupMember = itr->GetSource())
                    {
                        if (WorldSession* session = groupMember->GetSession())
                        {
                            if (session->IsVoiceChatEnabled())
                                AddVoiceChatMember(groupMember->GetGUID());
                        }
                    }
                }
            }
            break;
        }
        case VOICECHAT_CHANNEL_BG:
        {
            if (Battleground* bg = sBattlegroundMgr->GetBattleground(GetGroupId(), BATTLEGROUND_TYPE_NONE))
            {
                for (auto const& itr : bg->GetPlayers())
                {
                    if (Player* bgMember = ObjectAccessor::FindPlayer(itr.first))
                    {
                        if (bgMember->GetTeamId() != GetTeam())
                            continue;

                        if (WorldSession* session = bgMember->GetSession())
                        {
                            if (session->IsVoiceChatEnabled())
                                AddVoiceChatMember(itr.first);
                        }
                    }
                }
            }
            break;
        }
        case VOICECHAT_CHANNEL_CUSTOM:
        {
            if (ChannelMgr* cMgr = ChannelMgr::forTeam(GetTeam()))
            {
                Channel* chan = cMgr->GetChannel(GetChannelName(), nullptr, false);
                if (chan)
                    chan->AddVoiceChatMembersAfterCreate();
            }
        }
        case VOICECHAT_CHANNEL_NONE:
          break;
        }

    // enable sending voice roster update
    _isMassAdding = false;
}

void VoiceChatChannel::VoiceMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        LOG_ERROR("voice-chat", "Error in voicing member, member not found!");
        return;
    }

    if (member->IsVoiced())
        return;

    member->SetVoiced(true);

    SendVoiceRosterUpdate();

    sVoiceChatMgr.VoiceChannelSlot(_channelId, member->UserId);

    LOG_INFO("voice-chat", "User #{} voiced in channel #{}", member->UserId, _channelId);
}

void VoiceChatChannel::DevoiceMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        LOG_ERROR("voice-chat", "Error in devoicing member, member not found!");
        return;
    }

    if (!member->IsVoiced())
        return;

    member->SetVoiced(false);

    // send roster to player
    SendVoiceRosterUpdate(false, false, guid);
    // send proper roster to other players
    SendVoiceRosterUpdate();

    sVoiceChatMgr.DevoiceChannelSlot(_channelId, member->UserId);

    LOG_INFO("voice-chat", "User #{} devoiced in channel #{}", member->UserId, _channelId);
}

void VoiceChatChannel::MuteMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        LOG_ERROR("voice-chat", "Error in muting voice member, member not found!");
        return;
    }

    if (member->IsMuted())
        return;

    member->SetMuted(true);

    SendVoiceRosterUpdate();

    sVoiceChatMgr.MuteChannelSlot(_channelId, member->UserId);

    LOG_INFO("voice-chat", "User #{} muted in channel #{}", member->UserId, _channelId);
}

void VoiceChatChannel::UnmuteMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        LOG_ERROR("voice-chat", "Error in unmuting voice member, member not found!");
        return;
    }

    if (!member->IsMuted())
        return;

    member->SetMuted(false);

    SendVoiceRosterUpdate();

    // only allow leader to unmute force muted members
    if (!member->IsForceMuted())
        sVoiceChatMgr.UnmuteChannelSlot(_channelId, member->UserId);

    LOG_INFO("voice-chat", "User #{} unmuted in channel #{}", member->UserId, _channelId);
}

void VoiceChatChannel::ForceMuteMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        LOG_ERROR("voice-chat", "Error in force muting voice member, member not found!");
        return;
    }

    if (member->IsForceMuted())
        return;

    member->SetForceMuted(true);

    SendVoiceRosterUpdate();

    sVoiceChatMgr.MuteChannelSlot(_channelId, member->UserId);

    LOG_INFO("voice-chat", "User #{} force muted in channel #{}", member->UserId, _channelId);
}

void VoiceChatChannel::ForceUnmuteMember(ObjectGuid guid)
{
    VoiceChatMember* member = GetVoiceChatMember(guid);
    if (!member)
    {
        LOG_ERROR("voice-chat", "error in force unmuting voice member, member not found!");
        return;
    }

    if (!member->IsForceMuted())
        return;

    bool micEnabled = !member->IsMuted();
    if (Player* plr = ObjectAccessor::FindPlayer(guid))
        micEnabled = plr->GetSession()->IsMicEnabled();

    member->SetForceMuted(false);

    SendVoiceRosterUpdate();

    // do not let speak if mic disabled by client
    if (micEnabled)
        sVoiceChatMgr.UnmuteChannelSlot(_channelId, member->UserId);

    LOG_INFO("voice-chat", "User #{} force unmuted in channel #{}", member->UserId, _channelId);
}
